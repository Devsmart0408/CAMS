/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 100138
 Source Host           : localhost:3306
 Source Schema         : db_cams

 Target Server Type    : MySQL
 Target Server Version : 100138
 File Encoding         : 65001

 Date: 18/07/2020 12:15:30
*/ 

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cases
-- ----------------------------
DROP TABLE IF EXISTS `cases`;
CREATE TABLE `cases`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `opening_balance` decimal(65, 5) NULL DEFAULT NULL,
  `current_balance` decimal(65, 5) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cases
-- ----------------------------
INSERT INTO `cases` VALUES (15, 'USD', 100000.00000, 71402.22425, '2020-07-03 19:34:20', '2020-07-13 23:30:07');

-- ----------------------------
-- Table structure for companies
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `companies_deleted_at_index`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of companies
-- ----------------------------

-- ----------------------------
-- Table structure for currencies
-- ----------------------------
DROP TABLE IF EXISTS `currencies`;
CREATE TABLE `currencies`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `buy_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sell_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `buy_rate_from` decimal(65, 5) NULL DEFAULT NULL,
  `buy_rate_to` decimal(65, 5) NULL DEFAULT NULL,
  `sell_rate_from` decimal(65, 5) NULL DEFAULT NULL,
  `sell_rate_to` decimal(65, 5) NULL DEFAULT NULL,
  `current_balance` decimal(65, 5) NULL DEFAULT NULL,
  `opening_balance` decimal(65, 5) NULL DEFAULT NULL,
  `opening_avg_rate` decimal(65, 5) NULL DEFAULT NULL,
  `last_avg_rate` decimal(65, 5) NULL DEFAULT NULL,
  `calc_type` enum('Multiplication','Division','Special') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bs_amount_dec_limit` int(11) NULL DEFAULT NULL,
  `avg_rate_dec_limit` int(11) NULL DEFAULT NULL,
  `balance_dec_limit` int(11) NULL DEFAULT NULL,
  `last_avg_rate_dec_limit` int(11) NULL DEFAULT NULL,
  `flag_img` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of currencies
-- ----------------------------
INSERT INTO `currencies` VALUES (16, 'USD', 'USD', '11', '111', 0.00000, 0.00000, 0.00000, 0.00000, 172970900.00000, 150000000.00000, 1500.00000, 1522.72090, 'Special', 0, 2, 0, 2, '1917720422.png', '2020-07-03 19:36:38', '2020-07-13 23:30:10');
INSERT INTO `currencies` VALUES (17, 'Saudi Arabia', 'SAR', '966', '9666', 0.00000, 0.00000, 0.00000, 0.00000, 80250.00000, 100000.00000, 3.75500, 3.76780, 'Division', 0, 4, 0, 4, '190695646.png', '2020-07-03 19:38:19', '2020-07-13 23:30:10');
INSERT INTO `currencies` VALUES (18, 'Euro', 'Eur', '33', '333', 0.00000, 0.00000, 0.00000, 0.00000, 110255.00000, 100000.00000, 1.10550, 1.10410, 'Multiplication', 0, 4, 0, 4, '277339455.png', '2020-07-03 19:41:35', '2020-07-13 23:30:11');
INSERT INTO `currencies` VALUES (20, 'Sterling Pounds', 'STR', '44', '444', 0.00000, 0.00000, 0.00000, 0.00000, 60550.00000, 50000.00000, 1.25110, 1.24760, 'Multiplication', 0, 4, 0, 4, '53551172.png', '2020-07-04 23:22:28', '2020-07-13 23:30:12');

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `company_id` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employees_deleted_at_index`(`deleted_at`) USING BTREE,
  INDEX `266_5ae5bce3adfe2`(`company_id`) USING BTREE,
  CONSTRAINT `266_5ae5bce3adfe2` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employees
-- ----------------------------

-- ----------------------------
-- Table structure for income
-- ----------------------------
DROP TABLE IF EXISTS `income`;
CREATE TABLE `income`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(65, 5) NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `create_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of income
-- ----------------------------
INSERT INTO `income` VALUES (6, '1004', 1, 1, 150.00000, 'Hello', '2020-07-10');
INSERT INTO `income` VALUES (8, '1006', 1, 4, 30.00000, 'Hello', '2020-07-10');
INSERT INTO `income` VALUES (14, '1007', 4, 1, 150.00000, 'Hello', '2020-07-14');

-- ----------------------------
-- Table structure for income_change
-- ----------------------------
DROP TABLE IF EXISTS `income_change`;
CREATE TABLE `income_change`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `invoice_date` date NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(11, 5) NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `modify_date` datetime(0) NULL DEFAULT NULL,
  `operation_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modify_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of income_change
-- ----------------------------
INSERT INTO `income_change` VALUES (31, '1007', '2020-07-14', 4, 1, 150.00000, 'Hello', '2020-07-13 00:00:00', 'Create', 4);

-- ----------------------------
-- Table structure for login_activities
-- ----------------------------
DROP TABLE IF EXISTS `login_activities`;
CREATE TABLE `login_activities`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `user_agent` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of login_activities
-- ----------------------------

-- ----------------------------
-- Table structure for login_history
-- ----------------------------
DROP TABLE IF EXISTS `login_history`;
CREATE TABLE `login_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `user_ip` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of login_history
-- ----------------------------
INSERT INTO `login_history` VALUES (1, 1, '127.0.0.1', '2020-07-10 23:48:34');
INSERT INTO `login_history` VALUES (2, 1, '127.0.0.1', '2020-07-10 23:48:44');
INSERT INTO `login_history` VALUES (3, 0, '127.0.0.1', '2020-07-10 23:56:52');
INSERT INTO `login_history` VALUES (4, 1, '127.0.0.1', '2020-07-11 00:09:37');
INSERT INTO `login_history` VALUES (5, 4, '127.0.0.1', '2020-07-11 00:18:14');
INSERT INTO `login_history` VALUES (6, 4, '127.0.0.1', '2020-07-11 21:36:16');
INSERT INTO `login_history` VALUES (7, 1, '127.0.0.1', '2020-07-12 02:47:22');
INSERT INTO `login_history` VALUES (8, 1, '127.0.0.1', '2020-07-12 17:27:20');
INSERT INTO `login_history` VALUES (9, 4, '127.0.0.1', '2020-07-12 17:30:47');
INSERT INTO `login_history` VALUES (10, 4, '127.0.0.1', '2020-07-12 17:35:16');
INSERT INTO `login_history` VALUES (11, 4, '127.0.0.1', '2020-07-12 17:38:37');
INSERT INTO `login_history` VALUES (12, 1, '127.0.0.1', '2020-07-12 17:38:47');
INSERT INTO `login_history` VALUES (13, 1, '127.0.0.1', '2020-07-13 08:52:51');
INSERT INTO `login_history` VALUES (14, 1, '127.0.0.1', '2020-07-13 10:59:10');
INSERT INTO `login_history` VALUES (15, 1, '127.0.0.1', '2020-07-13 17:14:52');
INSERT INTO `login_history` VALUES (16, 4, '127.0.0.1', '2020-07-13 19:35:44');
INSERT INTO `login_history` VALUES (17, 1, '127.0.0.1', '2020-07-13 19:36:00');
INSERT INTO `login_history` VALUES (18, 4, '127.0.0.1', '2020-07-13 19:36:20');
INSERT INTO `login_history` VALUES (19, 1, '127.0.0.1', '2020-07-13 19:40:29');
INSERT INTO `login_history` VALUES (20, 4, '127.0.0.1', '2020-07-13 19:40:51');
INSERT INTO `login_history` VALUES (21, 4, '127.0.0.1', '2020-07-13 19:41:12');
INSERT INTO `login_history` VALUES (22, 1, '127.0.0.1', '2020-07-13 19:41:24');

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2016_06_01_000001_create_oauth_auth_codes_table', 1);
INSERT INTO `migrations` VALUES (2, '2016_06_01_000002_create_oauth_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (3, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1);
INSERT INTO `migrations` VALUES (4, '2016_06_01_000004_create_oauth_clients_table', 1);
INSERT INTO `migrations` VALUES (5, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1);
INSERT INTO `migrations` VALUES (6, '2020_06_13_045432_create_cases_table', 1);
INSERT INTO `migrations` VALUES (7, '2020_06_13_045432_create_companies_table', 1);
INSERT INTO `migrations` VALUES (8, '2020_06_13_045432_create_currencies_table', 1);
INSERT INTO `migrations` VALUES (9, '2020_06_13_045432_create_employees_table', 1);
INSERT INTO `migrations` VALUES (10, '2020_06_13_045432_create_income_change_table', 1);
INSERT INTO `migrations` VALUES (11, '2020_06_13_045432_create_income_table', 1);
INSERT INTO `migrations` VALUES (12, '2020_06_13_045432_create_login_history_table', 1);
INSERT INTO `migrations` VALUES (13, '2020_06_13_045432_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (14, '2020_06_13_045432_create_payment_change_table', 1);
INSERT INTO `migrations` VALUES (15, '2020_06_13_045432_create_payment_table', 1);
INSERT INTO `migrations` VALUES (16, '2020_06_13_045432_create_product_table', 1);
INSERT INTO `migrations` VALUES (17, '2020_06_13_045432_create_roles_table', 1);
INSERT INTO `migrations` VALUES (18, '2020_06_13_045432_create_transactions_table', 1);
INSERT INTO `migrations` VALUES (19, '2020_06_13_045432_create_users_table', 1);
INSERT INTO `migrations` VALUES (20, '2020_06_13_045433_add_foreign_keys_to_employees_table', 1);

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `expires_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_personal_access_clients_client_id_index`(`client_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(0) NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(65, 5) NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `create_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES (1, '100000', 1, 3, 800.00000, 'Payment', '2020-07-10');

-- ----------------------------
-- Table structure for payment_change
-- ----------------------------
DROP TABLE IF EXISTS `payment_change`;
CREATE TABLE `payment_change`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `invoice_date` date NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(11, 5) NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `modify_date` datetime(0) NULL DEFAULT NULL,
  `operation_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `modify_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of payment_change
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '0: deactive, 1: active',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'Smartwatches', 1);
INSERT INTO `product` VALUES (2, 'Dress', 1);
INSERT INTO `product` VALUES (3, 'Pant', 1);
INSERT INTO `product` VALUES (4, 'Sunglass', 1);
INSERT INTO `product` VALUES (5, 'Belt', 1);
INSERT INTO `product` VALUES (6, 'Underwear', 0);
INSERT INTO `product` VALUES (7, 'Printer', 1);
INSERT INTO `product` VALUES (9, 'Book', 1);
INSERT INTO `product` VALUES (10, 'Photo', 1);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Administrator (can create other users)', '2020-06-13 20:09:54', '2020-06-13 20:09:54');
INSERT INTO `roles` VALUES (2, 'Simple user', '2020-06-13 20:09:54', '2020-06-13 20:09:54');

-- ----------------------------
-- Table structure for transaction_history
-- ----------------------------
DROP TABLE IF EXISTS `transaction_history`;
CREATE TABLE `transaction_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `customer_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(65, 5) NULL DEFAULT NULL,
  `rate` decimal(65, 5) NULL DEFAULT NULL,
  `total` decimal(65, 5) NULL DEFAULT NULL,
  `paid_by_client` decimal(65, 5) NULL DEFAULT NULL,
  `return_to_client` decimal(65, 5) NULL DEFAULT NULL,
  `description` decimal(65, 5) NULL DEFAULT NULL,
  `profit` decimal(65, 2) NULL DEFAULT NULL,
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '0: sell\r\n1: buy\r\n',
  `last_avg_rate` decimal(65, 5) NULL DEFAULT NULL,
  `current_balance` decimal(65, 5) NULL DEFAULT NULL,
  `modified_user` int(11) NULL DEFAULT NULL,
  `modified_date` datetime(0) NULL DEFAULT NULL,
  `operation_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transaction_history
-- ----------------------------
INSERT INTO `transaction_history` VALUES (117, NULL, 'Sterling Pounds', '1', 20, 14000.00000, 1.26550, 17717.00000, NULL, NULL, NULL, 250.60, 1, 1.24760, 46550.00000, 1, '2020-07-13 00:00:00', 'Edit', '2020-07-13 23:30:09', '2020-07-13 23:30:09');

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `customer_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `currency_id` int(11) NULL DEFAULT NULL,
  `amount` decimal(65, 5) NULL DEFAULT NULL,
  `rate` decimal(65, 5) NULL DEFAULT NULL,
  `total` decimal(65, 5) NULL DEFAULT NULL,
  `paid_by_client` decimal(65, 5) NULL DEFAULT NULL,
  `return_to_client` decimal(65, 5) NULL DEFAULT NULL,
  `description` decimal(65, 5) NULL DEFAULT NULL,
  `profit` decimal(65, 2) NULL DEFAULT NULL,
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '0: sell\r\n1: buy\r\n',
  `last_avg_rate` decimal(65, 5) NULL DEFAULT NULL,
  `current_balance` decimal(65, 5) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transactions
-- ----------------------------
INSERT INTO `transactions` VALUES (82, NULL, 'Sterling Pounds', '1', 20, 1200.00000, 1.24500, 1494.00000, 0.00000, 0.00000, NULL, 0.00, 0, 1.25100, 51200.00000, '2020-07-04 23:23:01', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (83, NULL, 'Saudi Arabia', '1', 17, 1500.00000, 3.78000, 396.82540, 0.00000, 0.00000, NULL, 0.00, 0, 3.75540, 101500.00000, '2020-07-04 23:24:14', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (84, NULL, 'Euro', '1', 18, 1255.00000, 1.10950, 1392.42250, 0.00000, 0.00000, NULL, 0.00, 0, 1.10550, 101255.00000, '2020-07-04 23:24:54', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (85, NULL, 'USD', '1', 16, 1500.00000, 1480.00000, 2220000.00000, 0.00000, 0.00000, NULL, 20.00, 0, 1500.00000, 147780000.00000, '2020-07-05 00:02:29', '2020-07-06 10:50:25');
INSERT INTO `transactions` VALUES (86, NULL, 'Sterling Pounds', '1', 20, 600.00000, 1.26250, 757.50000, NULL, NULL, NULL, 6.93, 1, 1.25100, 50600.00000, '2020-07-05 00:02:50', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (87, NULL, 'Saudi Arabia', '1', 17, 1250.00000, 3.75000, 333.33333, NULL, NULL, NULL, 0.48, 1, 3.75540, 100250.00000, '2020-07-05 00:03:35', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (88, NULL, 'Euro', '1', 18, 1600.00000, 1.11580, 1785.28000, NULL, NULL, NULL, 16.40, 1, 1.10550, 99655.00000, '2020-07-05 00:03:53', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (89, NULL, 'USD', '1', 16, 4250.00000, 1525.00000, 6481250.00000, NULL, NULL, NULL, 0.00, 1, 1501.03390, 154261250.00000, '2020-07-05 00:04:16', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (90, NULL, 'Sterling Pounds', '1', 20, 600.00000, 1.24500, 747.00000, 0.00000, 0.00000, NULL, 0.00, 0, 1.25090, 51200.00000, '2020-07-05 00:04:38', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (91, NULL, 'Saudi Arabia', '1', 17, 7500.00000, 3.78000, 1984.12698, 0.00000, 0.00000, NULL, 0.00, 0, 3.75710, 107750.00000, '2020-07-05 00:04:57', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (92, NULL, 'Euro', '1', 18, 1850.00000, 1.12850, 2087.72500, NULL, NULL, NULL, 42.46, 1, 1.10550, 97805.00000, '2020-07-05 00:05:20', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (93, NULL, 'Saudi Arabia', '1', 17, 7500.00000, 3.75250, 1998.66755, NULL, NULL, NULL, 2.43, 1, 3.75710, 100250.00000, '2020-07-05 00:05:37', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (94, NULL, 'Sterling Pounds', '1', 20, 1900.00000, 1.26290, 2399.51000, NULL, NULL, NULL, 22.82, 1, 1.25090, 49300.00000, '2020-07-05 00:05:55', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (95, NULL, 'Sterling Pounds', '1', 20, 250.00000, 1.24450, 311.12500, 0.00000, 0.00000, NULL, 0.00, 0, 1.25090, 49550.00000, '2020-07-05 19:58:57', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (96, NULL, 'USD', '1', 16, 1500.00000, 1530.00000, 2295000.00000, NULL, NULL, NULL, 0.00, 1, 1501.45060, 156556250.00000, '2020-07-05 19:59:36', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (97, NULL, 'USD', '1', 16, 1254.00000, 1575.00000, 1975050.00000, NULL, NULL, NULL, 0.00, 1, 1502.32460, 158531300.00000, '2020-07-05 19:59:57', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (98, NULL, 'USD', '1', 16, 600.00000, 1495.00000, 897000.00000, 0.00000, 0.00000, NULL, 2.93, 0, 1502.32460, 157634300.00000, '2020-07-05 20:01:32', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (99, NULL, 'USD', '1', 16, 1580.00000, 1480.00000, 2338400.00000, 0.00000, 0.00000, NULL, 23.48, 0, 1502.32460, 155295900.00000, '2020-07-05 20:02:05', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (100, NULL, 'Euro', '1', 18, 1900.00000, 1.10000, 2090.00000, 0.00000, 0.00000, NULL, 0.00, 0, 1.10540, 99705.00000, '2020-07-05 20:02:33', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (101, NULL, 'Euro', '1', 18, 1200.00000, 1.12500, 1350.00000, NULL, NULL, NULL, 23.47, 1, 1.10540, 98505.00000, '2020-07-05 20:02:57', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (102, NULL, 'Euro', '1', 18, 1750.00000, 1.10470, 1933.22500, 0.00000, 0.00000, NULL, 0.00, 0, 1.10540, 100255.00000, '2020-07-05 20:03:21', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (103, NULL, 'Euro', '1', 18, 2500.00000, 1.10350, 2758.75000, 0.00000, 0.00000, NULL, 0.00, 0, 1.10540, 102755.00000, '2020-07-05 20:17:06', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (104, NULL, 'Euro', '1', 18, 7500.00000, 1.11960, 8397.00000, NULL, NULL, NULL, 106.62, 1, 1.10540, 95255.00000, '2020-07-05 20:17:35', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (105, NULL, 'Euro', '1', 18, 40000.00000, 1.10100, 44040.00000, 0.00000, 0.00000, NULL, 0.00, 0, 1.10410, 135255.00000, '2020-07-05 20:18:02', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (107, NULL, 'Saudi Arabia', '1', 17, 40000.00000, 3.79500, 10540.18445, 0.00000, 0.00000, NULL, 0.00, 0, 3.76780, 140250.00000, '2020-07-05 20:19:13', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (108, NULL, 'Saudi Arabia', '1', 17, 60000.00000, 3.75550, 15976.56770, NULL, NULL, NULL, 52.20, 1, 3.76780, 80250.00000, '2020-07-05 20:19:43', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (109, NULL, 'Sterling Pounds', '1', 20, 25000.00000, 1.24120, 31030.00000, 0.00000, 0.00000, NULL, 0.00, 0, 1.24760, 74550.00000, '2020-07-05 20:20:11', '2020-07-13 23:30:11');
INSERT INTO `transactions` VALUES (110, NULL, 'Sterling Pounds', '1', 20, 14000.00000, 1.26550, 17717.00000, NULL, NULL, NULL, 250.36, 1, 1.24760, 60550.00000, '2020-07-05 20:20:48', '2020-07-13 23:30:12');
INSERT INTO `transactions` VALUES (111, NULL, 'USD', '1', 16, 15000.00000, 1480.00000, 22200000.00000, 0.00000, 0.00000, NULL, 222.90, 0, 1502.32460, 133095900.00000, '2020-07-05 20:22:54', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (112, NULL, 'USD', '1', 16, 25000.00000, 1595.00000, 39875000.00000, NULL, NULL, NULL, 0.00, 1, 1522.72090, 172970900.00000, '2020-07-05 20:23:48', '2020-07-13 23:30:10');
INSERT INTO `transactions` VALUES (113, NULL, 'Euro', '1', 18, 25000.00000, 1.12500, 28125.00000, NULL, NULL, NULL, 522.82, 1, 1.10410, 110255.00000, '2020-07-06 10:51:22', '2020-07-13 23:30:11');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `company_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `customer_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mobile` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `fax` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `birthday` date NULL DEFAULT NULL,
  `eco_ben` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role_id` tinyint(1) NULL DEFAULT NULL COMMENT '1: super admin, 2: staff, 3: customer, 4: client',
  `status` tinyint(1) NULL DEFAULT 1,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_number` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `expire_date` datetime(0) NULL DEFAULT NULL,
  `place_birthday` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `place_issue` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `national` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `id_img` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `company_img` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mix_img` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ofac` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `permission` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `balance` decimal(65, 5) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Admin', NULL, NULL, NULL, 'admin@admin.com', NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$Rw3AZN/Zqen4x4GaIcy8tupBMsSdzyT4BePdXAHxvD9VNUpS6G0Pe', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -700.00000, '2020-06-13 20:09:54', '2020-07-13 08:55:53', 'YyvU5fsELu9qB1Dch5giaoN3MrgWafOMxQcezfKaAaufE2wcwcOWdlO2hpNY');
INSERT INTO `users` VALUES (3, NULL, 'Walk In', 'Walk In', NULL, 'marko737@hotmail.com', '1', '000000', '000000', NULL, '2020-06-27', NULL, '$2y$10$GFt9ltoC5DNUGBrAvPK1Jug15/kdDFjeYWokcb7huLVEFbPA9lIWO', 3, 1, NULL, NULL, NULL, '', NULL, NULL, '2020-06-27 00:00:00', NULL, NULL, NULL, '1305440072.jpg', '1950859524.jpg', '1896768544.jpg', NULL, NULL, NULL, '2020-06-27 19:28:48', '2020-06-27 19:28:48', NULL);
INSERT INTO `users` VALUES (4, 'jeffbezos', NULL, NULL, NULL, 'jeff@admin.com', NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$XMW3sLQ07Eb6xcaPov7YJ.Jk6TwwXU9EIX5/q8X271.Ed95ZRxjmy', 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1900.00000, '2020-07-07 05:03:50', '2020-07-13 19:36:12', 'h1SmnYutX4pUVOh7fz8Uwqqofo5229dRNcJ5wMwMfrEtrhK4aYmyztWrtQVU');

SET FOREIGN_KEY_CHECKS = 1;
