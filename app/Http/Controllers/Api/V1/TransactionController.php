<?php

namespace App\Http\Controllers\Api\V1;

use App\Transaction;
use App\Currency;
use App\Http\Controllers\Controller;
use App\Http\Resources\Transaction as TransactionResource;
use Illuminate\Http\Request;
use DB;

class TransactionController extends Controller
{
    public function index()
    {
        $transactions = DB::table('transactions')
          ->join('currencies', 'transactions.currency_id', '=', 'currencies.id')
          ->join('users', 'transactions.customer_code', '=', 'users.customer_code')
          ->select(     'transactions.id as id', 
                        'users.first_name as customer_first_name', 
                        'users.last_name as customer_last_name', 
                        'currencies.calc_type as calc_type', 
                        'transactions.created_at as created_at', 
                        'currencies.name as name', 
                        'transactions.amount as amount', 
                        'transactions.rate as rate', 
                        'transactions.total as total', 
                        'transactions.profit as profit', 
                        'transactions.type as type', 
                        'transactions.current_balance as current_balance', 
                        'transactions.last_avg_rate as last_avg_rate', 
                        'transactions.paid_by_client as paid_by_client', 
                        'transactions.return_to_client as return_to_client' )
          ->get();

        return json_encode($transactions);
    }

    public function show($id)
    {
        $transaction_data = DB::table('transactions')
          ->join('currencies', 'transactions.currency_id', '=', 'currencies.id')
          ->join('users', 'transactions.customer_code', '=', 'users.customer_code')
          ->where('transactions.id', '=', $id)
          ->select(     'transactions.id as id', 
                        'transactions.customer_code as customer_code', 
                        'users.first_name as customer_first_name', 
                        'users.last_name as customer_last_name', 
                        'currencies.calc_type as calc_type', 
                        'currencies.code as currency_code', 
                        'currencies.buy_code as buy_code', 
                        'currencies.sell_code as sell_code', 
                        'currencies.name as name', 
                        'currencies.id as currency_id', 
                        'transactions.created_at as created_at', 
                        'transactions.amount as amount', 
                        'transactions.rate as rate', 
                        'transactions.total as total', 
                        'transactions.profit as profit', 
                        'transactions.type as type', 
                        'transactions.current_balance as current_balance', 
                        'transactions.last_avg_rate as last_avg_rate', 
                        'transactions.paid_by_client as paid_by_client', 
                        'transactions.return_to_client as return_to_client' )
          ->first();

        if ($transaction_data->type == 0)
            $currency_code = 'Buy-'.$transaction_data->buy_code.'-'.$transaction_data->name.'-'.$transaction_data->currency_id;
        else
            $currency_code = 'Sell-'.$transaction_data->sell_code.'-'.$transaction_data->name.'-'.$transaction_data->currency_id;
        
        $transaction_data->currency_code = $currency_code;
        $transaction_data->customer_id = $transaction_data->customer_code . '-' . $transaction_data->customer_first_name . ' ' . $transaction_data->customer_last_name;

        return json_encode($transaction_data);
    }

    public function store(Request $request)
    {
        $profit = 0;
        if ($request->type == 0) 
            $new_current_balance = $request->current_balance + $request->amount;
        else
            $new_current_balance = $request->current_balance - $request->amount;

        switch ($request->calc_type) {
            case 'Multiplication':
                if ($request->type == 0) 
                    $new_currency_avg_rate = ((($request->current_balance * $request->last_avg_rate) + ($request->amount * $request->rate)) / ($new_current_balance));
                else
                {
                    $new_currency_avg_rate = ((($request->current_balance * $request->last_avg_rate) - ($request->amount * $request->last_avg_rate)) / ($new_current_balance));
                    $profit = ($request->amount * $request->rate) - ($request->amount * $request->last_avg_rate);
                }
                break;
            case 'Division':                
                if ($request->type == 0) 
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) + ($request->amount / $request->rate)));
                else
                {
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) - ($request->amount / $request->last_avg_rate)));
                    $profit = ($request->amount / $request->rate) - ($request->amount / $request->last_avg_rate);
                }
                break;
            case 'Special':
                if ($request->type == 0) 
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) + ($request->amount / $request->rate)));
                else
                {
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) - ($request->amount / $request->last_avg_rate)));
                    $profit = ($request->amount / $request->rate) - ($request->amount / $request->last_avg_rate);
                }
                break;
            
            default:
                # code...
                break;
        }
        $transaction_data = array(            
            'name'              => $request->name,
            'customer_code'     => $request->customer_code,
            'currency_id'       => $request->currency_id,
            'amount'            => $request->amount,
            'rate'              => $request->rate,
            'total'             => $request->amount * $request->rate,
            'paid_by_client'    => $request->paid_by_client,
            'return_to_client'  => $request->return_to_client,
            'description'       => $request->description,
            'profit'            => $profit,
            'type'              => $request->type,
            'last_avg_rate'     => $new_currency_avg_rate,
            'current_balance'   => $new_current_balance
        );
        
        $transactions = Transaction::create($transaction_data);        

        $currency = Currency::findOrFail($request->currency_id);
        
        $currency_data = Array(
            'current_balance' => $new_current_balance,
            'last_avg_rate' => $new_currency_avg_rate
          );
        
        $currency->update($currency_data);

        return (new TransactionResource($transactions))
            ->response()
            ->setStatusCode(201);
    }

    public function update(Request $request, $id)
    {        
        $transaction = Transaction::findOrFail($id);

        $first_transaction = DB::table('transactions')->first();

        if($id == $first_transaction->id)
        {
            $currency_data = Currency::with([])->findOrFail($first_transaction->currency_id);
            $request->current_balance = $currency_data->opening_balance;
            $request->last_avg_rate = $currency_data->opening_avg_rate;
        }

        $profit = 0;
        if ($request->type == 0) 
            $new_current_balance = $request->current_balance + $request->amount;
        else
            $new_current_balance = $request->current_balance - $request->amount;

        switch ($request->calc_type) {
            case 'Multiplication':
                if ($request->type == 0) 
                    $new_currency_avg_rate = ((($request->current_balance * $request->last_avg_rate) + ($request->amount * $request->rate)) / ($new_current_balance));
                else
                {
                    $new_currency_avg_rate = ((($request->current_balance * $request->last_avg_rate) - ($request->amount * $request->last_avg_rate)) / ($new_current_balance));
                    $profit = ($request->amount * $request->rate) - ($request->amount * $request->last_avg_rate);
                }
                break;
            case 'Division':                
                if ($request->type == 0) 
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) + ($request->amount / $request->rate)));
                else
                {
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) - ($request->amount / $request->last_avg_rate)));
                    $profit = ($request->amount / $request->rate) - ($request->amount / $request->last_avg_rate);
                }
                break;
            case 'Special':
                if ($request->type == 0) 
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) + ($request->amount / $request->rate)));
                else
                {
                    $new_currency_avg_rate = (($new_current_balance) / (($request->current_balance / $request->last_avg_rate) - ($request->amount / $request->last_avg_rate)));
                    $profit = ($request->amount / $request->rate) - ($request->amount / $request->last_avg_rate);
                }
                break;
            
            default:
                # code...
                break;
        }

        $transaction_data = array(            
            'name'              => $request->name,
            'customer_code'     => $request->customer_code,
            'currency_id'       => $request->currency_id,
            'amount'            => $request->amount,
            'rate'              => $request->rate,
            'total'             => $request->amount * $request->rate,
            'paid_by_client'    => $request->paid_by_client,
            'return_to_client'  => $request->return_to_client,
            'description'       => $request->description,
            'profit'            => $profit,
            'type'              => $request->type,
            'last_avg_rate'     => $new_currency_avg_rate,
            'current_balance'   => $new_current_balance
        );

        $transaction->update($transaction_data);
        $transaction->touch();        

        $transactions = DB::table('transactions')
        ->join('currencies', 'transactions.currency_id', '=', 'currencies.id')
        ->select(     'transactions.id as id', 
                        'currencies.calc_type as calc_type', 
                        'transactions.created_at as created_at', 
                        'transactions.currency_id as currency_id', 
                        'currencies.name as name', 
                        'transactions.amount as amount', 
                        'transactions.rate as rate', 
                        'transactions.total as total', 
                        'transactions.profit as profit', 
                        'transactions.type as type', 
                        'transactions.current_balance as current_balance', 
                        'transactions.last_avg_rate as last_avg_rate', 
                        'transactions.paid_by_client as paid_by_client', 
                        'transactions.return_to_client as return_to_client' )
        ->get();
        
        for ($i = 1; $i < count($transactions); $i++ ) {
            $transaction = Transaction::findOrFail($transactions[$i]->id);
                $profit = 0;
                if ($transactions[$i]->type == 0) 
                    $transactions[$i]->current_balance = $transactions[$i-1]->current_balance + $transactions[$i]->amount;
                else
                    $transactions[$i]->current_balance = $transactions[$i-1]->current_balance - $transactions[$i]->amount;

                switch ($transactions[$i]->calc_type) {
                    case 'Multiplication':
                        if ($transactions[$i]->type == 0) 
                            $transactions[$i]->last_avg_rate = ((($transactions[$i-1]->current_balance * $transactions[$i-1]->last_avg_rate) + ($transactions[$i]->amount * $transactions[$i]->rate)) / ($transactions[$i]->current_balance));
                        else
                        {
                            $transactions[$i]->last_avg_rate = ((($transactions[$i-1]->current_balance * $transactions[$i-1]->last_avg_rate) - ($transactions[$i]->amount * $transactions[$i-1]->last_avg_rate)) / ($transactions[$i]->current_balance));
                            $transactions[$i]->profit = ($transactions[$i]->amount * $transactions[$i]->rate) - ($transactions[$i]->amount * $transactions[$i-1]->last_avg_rate);
                        }
                        break;
                    case 'Division':                
                        if ($transactions[$i]->type == 0) 
                            $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) + ($transactions[$i]->amount / $transactions[$i]->rate)));
                        else
                        {
                            $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate)));
                            $transactions[$i]->profit = ($transactions[$i]->amount / $transactions[$i]->rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate);
                        }
                        break;
                    case 'Special':
                        if ($transactions[$i]->type == 0) 
                            $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) + ($transactions[$i]->amount / $transactions[$i]->rate)));
                        else
                        {
                            $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate)));
                            $transactions[$i]->profit = ($transactions[$i]->amount / $transactions[$i]->rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate);
                        }
                        break;
                    
                    default:
                        # code...
                        break;
                }

                $transaction_data = array(            
                    'profit'            => $transactions[$i]->profit,
                    'last_avg_rate'     => $transactions[$i]->last_avg_rate,
                    'current_balance'   => $transactions[$i]->current_balance
                );

                $transaction->update($transaction_data); 
                
                $currency = Currency::findOrFail($transactions[$i]->currency_id);
                
                $currency_data = Array(
                    'current_balance' => $transactions[$i]->current_balance,
                    'last_avg_rate' => $transactions[$i]->last_avg_rate
                );
                
                $currency->update($currency_data);       
        }
        
        return (new TransactionResource($transaction))
            ->response()
            ->setStatusCode(202);
    }

    public function destroy($id)
    {
        $transaction = Transaction::findOrFail($id);   

        $first_transaction = DB::table('transactions')->first();

        if($id != $first_transaction->id)
        {
            $transaction->delete();

            $transactions = DB::table('transactions')
            ->join('currencies', 'transactions.currency_id', '=', 'currencies.id')
            ->select(     'transactions.id as id', 
                            'currencies.calc_type as calc_type', 
                            'transactions.created_at as created_at', 
                            'transactions.currency_id as currency_id', 
                            'currencies.name as name', 
                            'transactions.amount as amount', 
                            'transactions.rate as rate', 
                            'transactions.total as total', 
                            'transactions.profit as profit', 
                            'transactions.type as type', 
                            'transactions.current_balance as current_balance', 
                            'transactions.last_avg_rate as last_avg_rate', 
                            'transactions.paid_by_client as paid_by_client', 
                            'transactions.return_to_client as return_to_client' )
            ->get();  
            
            for ($i = 1; $i < count($transactions); $i++ ) {
                $transaction = Transaction::findOrFail($transactions[$i]->id);
                    $profit = 0;
                    if ($transactions[$i]->type == 0) 
                        $transactions[$i]->current_balance = $transactions[$i-1]->current_balance + $transactions[$i]->amount;
                    else
                        $transactions[$i]->current_balance = $transactions[$i-1]->current_balance - $transactions[$i]->amount;

                    switch ($transactions[$i]->calc_type) {
                        case 'Multiplication':
                            if ($transactions[$i]->type == 0) 
                                $transactions[$i]->last_avg_rate = ((($transactions[$i-1]->current_balance * $transactions[$i-1]->last_avg_rate) + ($transactions[$i]->amount * $transactions[$i]->rate)) / ($transactions[$i]->current_balance));
                            else
                            {
                                $transactions[$i]->last_avg_rate = ((($transactions[$i-1]->current_balance * $transactions[$i-1]->last_avg_rate) - ($transactions[$i]->amount * $transactions[$i-1]->last_avg_rate)) / ($transactions[$i]->current_balance));
                                $transactions[$i]->profit = ($transactions[$i]->amount * $transactions[$i]->rate) - ($transactions[$i]->amount * $transactions[$i-1]->last_avg_rate);
                            }
                            break;
                        case 'Division':                
                            if ($transactions[$i]->type == 0) 
                                $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) + ($transactions[$i]->amount / $transactions[$i]->rate)));
                            else
                            {
                                $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate)));
                                $transactions[$i]->profit = ($transactions[$i]->amount / $transactions[$i]->rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate);
                            }
                            break;
                        case 'Special':
                            if ($transactions[$i]->type == 0) 
                                $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) + ($transactions[$i]->amount / $transactions[$i]->rate)));
                            else
                            {
                                $transactions[$i]->last_avg_rate = (($transactions[$i]->current_balance) / (($transactions[$i-1]->current_balance / $transactions[$i-1]->last_avg_rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate)));
                                $transactions[$i]->profit = ($transactions[$i]->amount / $transactions[$i]->rate) - ($transactions[$i]->amount / $transactions[$i-1]->last_avg_rate);
                            }
                            break;
                        
                        default:
                            # code...
                            break;
                    }

                    $transaction_data = array(            
                        'profit'            => $transactions[$i]->profit,
                        'last_avg_rate'     => $transactions[$i]->last_avg_rate,
                        'current_balance'   => $transactions[$i]->current_balance
                    );

                    $transaction->update($transaction_data); 
                    
                    $currency = Currency::findOrFail($transactions[$i]->currency_id);
                    
                    $currency_data = Array(
                        'current_balance' => $transactions[$i]->current_balance,
                        'last_avg_rate' => $transactions[$i]->last_avg_rate
                    );
                    
                    $currency->update($currency_data);       
            }

            return response(null, 204);
        }
        else            
            return response()->json(['hasCase'=>false,'errors'=>'First Transaction can not be removed!!!']);

    }
}