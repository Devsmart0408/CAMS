<template>
    <section class="content-wrapper" style="min-height: 960px;">
        <section class="content-header">
            <h1>Transaction</h1>
        </section>

        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header with-border">
                            <h3 class="box-title">List</h3>
                        </div>

                        <div class="box-body">
                            <div class="btn-group">
                                <router-link :to="{ name: xprops.route + '.create' }" class="btn btn-success btn-sm">
                                    <i class="fa fa-plus"></i> Add new
                                </router-link>
                                <button type="button" class="btn btn-default btn-sm" @click="fetchData">
                                    <i class="fa fa-refresh" :class="{'fa-spin': loading}"></i> Refresh
                                </button>                                
                                <button type="button" class="btn btn-danger btn-sm" @click="removeAllData">
                                    <i class="fa fa-times" :class="{'fa-spin': loading}"></i> Remove All Changes
                                </button>
                            </div>
                        </div>

                        <div class="box-body">
                            <div class="row" v-if="loading">
                                <div class="col-xs-4 col-xs-offset-4">
                                    <div class="alert text-center">
                                        <i class="fa fa-spin fa-refresh"></i> Loading
                                    </div>
                                </div>
                            </div>
                            <datatable
                                    v-if="!loading"
                                    :columns="columns"
                                    :data="data"
                                    :total="total"
                                    :query="query"
                                    :xprops="xprops"
                                    :support-backup="true"
                                    />
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
</template>


<script>
import { mapGetters, mapActions } from 'vuex'
import components from '../../dtmodules/'

export default {
    components,
    data() {
        return {
            columns: [
                { title: 'TransactionID', field: 'id', sortable: true },
                { title: 'TransactionType', field: 'type', tdComp: 'DatatableSingle', sortable: true },
                { title: 'Customer', field: 'customer_first_name', thComp: 'DatatableFilter', sortable: true },
                { title: 'Type', field: 'calc_type', sortable: true },
                { title: 'DateTime', field: 'created_at', sortable: true },
                { title: 'Currency', field: 'name', sortable: true },
                { title: 'Buy / Sell Amount', field: 'amount', sortable: true },
                { title: 'TTL For Buy / Sell', field: 'total', sortable: true },
                { title: 'B / S Rate', field: 'rate', sortable: true },
                { title: 'Profit', field: 'profit', sortable: true },
                { title: 'Current Balance', field: 'current_balance', sortable: true },
                { title: 'Last Average Rate', field: 'last_avg_rate', sortable: true },
                { title: 'Paid By Client', field: 'paid_by_client', sortable: true },
                { title: 'Return To Client', field: 'return_to_client', sortable: true },
                { title: 'Actions', tdComp: 'DatatableActions', visible: true, thClass: 'text-right', tdClass: 'text-right', colStyle: 'width: 130px;' }
            ],
            query: { sort: 'id', order: 'desc', customer_first_name: '' },
            xprops: {
                module: 'TransactionIndex',
                route: 'transaction'
            }
        }
    },
    created() {
        this.fetchData()
        const q = { limit: 10, offset: 0, sort: 'id', order: 'desc', ...this.query }
        Object.keys(q).forEach(key => { this.$set(this.query, key, q[key]) })
        window.addEventListener("keypress", this.saveKeyAction)
    },
    destroyed() {
        this.resetState()
    },
    computed: {
        ...mapGetters('TransactionIndex', ['data', 'data_all', 'total', 'loading', 'relationships']),
    },
    watch: {
        query: {
            handler(query) {
                this.setQuery(query)
                this.handleQueryChange()
            },
            deep: true
        },
        "$route": function() {
            this.resetState()
            window.addEventListener("keypress", this.saveKeyAction)
        }
    },
    methods: {
        ...mapActions('TransactionIndex', ['fetchData', 'setQuery', 'resetState', 'setAll', 'removeAllData']),
        handleQueryChange () {       
            let rows = Array()
            this.data_all.forEach(element => {
                if( element.customer_first_name.toLowerCase().search(this.query['customer_first_name'].toLowerCase()) >= 0 )
                {
                    rows.push(element)
                }
            });
            this.setAll(rows)
        },
        saveKeyAction(e) {
            if (e.keyCode == 26)
                this.$router.push({ name: 'transaction.create' })

        }
    }
}
</script>


<style scoped>

</style>
