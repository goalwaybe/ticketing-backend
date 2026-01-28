/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26-log)
 Source Host           : localhost:3306
 Source Schema         : newcmt

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26-log)
 File Encoding         : 65001

 Date: 27/01/2026 19:17:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ba_admin
-- ----------------------------
DROP TABLE IF EXISTS `ba_admin`;
CREATE TABLE `ba_admin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `login_failure` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录失败次数',
  `last_login_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐（废弃待删）',
  `motto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态:enable=启用,disable=禁用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_admin
-- ----------------------------
INSERT INTO `ba_admin` VALUES (1, 'admin', 'Admin', '/storage/default/20260127/PixPin_2026-01-e9a7c888a790b00f8ad721e3e0911e41265ede35.png', 'admin@buildadmin.com', '18888888888', 0, 1769512639, '127.0.0.1', '$2y$10$GlingsQzOMCrdeUIC0eRCeZ0XlJnN5AGPZfnOKU2Kd2VFS5AGCpNW', '', '', 'enable', 1769512639, 1769497215);

-- ----------------------------
-- Table structure for ba_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `ba_admin_group`;
CREATE TABLE `ba_admin_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分组',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '权限规则ID',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_admin_group
-- ----------------------------
INSERT INTO `ba_admin_group` VALUES (1, 0, '超级管理组', '*', 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_group` VALUES (2, 1, '一级管理员', '1,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,77,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,89', 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_group` VALUES (3, 2, '二级管理员', '21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43', 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_group` VALUES (4, 3, '三级管理员', '55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75', 1, 1769497215, 1769497215);

-- ----------------------------
-- Table structure for ba_admin_group_access
-- ----------------------------
DROP TABLE IF EXISTS `ba_admin_group_access`;
CREATE TABLE `ba_admin_group_access`  (
  `uid` int(11) UNSIGNED NOT NULL COMMENT '管理员ID',
  `group_id` int(11) UNSIGNED NOT NULL COMMENT '分组ID',
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理分组映射表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_admin_group_access
-- ----------------------------
INSERT INTO `ba_admin_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for ba_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `ba_admin_log`;
CREATE TABLE `ba_admin_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `url` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作Url',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求数据',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_admin_log
-- ----------------------------
INSERT INTO `ba_admin_log` VALUES (1, 1, 'admin', '/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"cf4ad7c9-d870-43fe-bbf7-0f7a041f4199\",\"captchaInfo\":\"47,161-250,107;350;200\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769497587);
INSERT INTO `ba_admin_log` VALUES (2, 1, 'admin', '/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"b2a37d3b-e9fe-499e-97ab-e0f359a4598d\",\"captchaInfo\":\"164,109-153,156;350;200\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769498014);
INSERT INTO `ba_admin_log` VALUES (3, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"ticket_user\",\"sql\":\"\",\"connection\":\"mysql\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769498452);
INSERT INTO `ba_admin_log` VALUES (4, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"ticket_user\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticket\\\\user\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticket\\\\User.php\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769498455);
INSERT INTO `ba_admin_log` VALUES (5, 1, 'admin', '/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"ticket_user\",\"comment\":\"\\u7528\\u6237\\u4e3b\\u8868\\uff08\\u767b\\u5f55\\u51ed\\u8bc1\\uff09\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"phone\",\"password_hash\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"columnFields\":[\"id\",\"phone\",\"password_hash\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticket_user\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\ticket\\\\User.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticket\\\\User.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\ticket\\\\User.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticket\\\\user\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"},\"fields\":[{\"name\":\"id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7528\\u6237ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"phone\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u624b\\u673a\\u53f7\\uff08\\u767b\\u5f55\\u8d26\\u53f7\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"password_hash\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5bc6\\u7801\\u54c8\\u5e0c\\u503c\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(500)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5934\\u50cf URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"gender\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6027\\u522b\\uff1a0=\\u672a\\u77e5, 1=\\u7537, 2=\\u5973\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5ba1\\u6838\\u72b6\\u6001\\uff1a0=\\u5f85\\u5ba1\\u6838, 1=\\u5df2\\u901a\\u8fc7, 2=\\u5df2\\u62d2\\u7edd\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"role\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u89d2\\u8272\\uff1a0=\\u666e\\u901a\\u7528\\u6237, 1=\\u5ba2\\u670d, 2=\\u8d22\\u52a1, 9=\\u7ba1\\u7406\\u5458\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u521b\\u5efa\\u65f6\\u95f4\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u66f4\\u65b0\\u65f6\\u95f4\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"deleted_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8f6f\\u5220\\u9664\\u65f6\\u95f4\\uff08NULL\\u8868\\u793a\\u672a\\u5220\\u9664\\uff09\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769498462);
INSERT INTO `ba_admin_log` VALUES (6, 1, 'admin', '/admin/crud.Crud/delete', 'CRUD代码生成-删除', '{\"id\":\"1\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769498752);
INSERT INTO `ba_admin_log` VALUES (7, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"ticket_user\",\"sql\":\"\",\"connection\":\"mysql\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769498800);
INSERT INTO `ba_admin_log` VALUES (8, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"ticket_user\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\TicketUser\\\\ticketUser\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\TicketUser\\\\TicketUser.php\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499505);
INSERT INTO `ba_admin_log` VALUES (9, 1, 'admin', '/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"ticket_user\",\"comment\":\"\\u7528\\u6237\\u4e3b\\u8868\\uff08\\u767b\\u5f55\\u51ed\\u8bc1\\uff09\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"phone\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"columnFields\":[\"id\",\"phone\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticketUser\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\TicketUser\\\\TicketUser.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\TicketUser\\\\TicketUser.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\TicketUser\\\\TicketUser.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\TicketUser\\\\ticketUser\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"},\"fields\":[{\"name\":\"id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"\\u7528\\u6237ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"phone\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u624b\\u673a\\u53f7\\uff08\\u767b\\u5f55\\u8d26\\u53f7\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"password_hash\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5bc6\\u7801\\u54c8\\u5e0c\\u503c\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(500)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5934\\u50cf URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"gender\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u6027\\u522b\\uff1a0=\\u672a\\u77e5, 1=\\u7537, 2=\\u5973\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5ba1\\u6838\\u72b6\\u6001\\uff1a0=\\u5f85\\u5ba1\\u6838, 1=\\u5df2\\u901a\\u8fc7, 2=\\u5df2\\u62d2\\u7edd\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"role\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u89d2\\u8272\\uff1a0=\\u666e\\u901a\\u7528\\u6237, 1=\\u5ba2\\u670d, 2=\\u8d22\\u52a1, 9=\\u7ba1\\u7406\\u5458\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u521b\\u5efa\\u65f6\\u95f4\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u66f4\\u65b0\\u65f6\\u95f4\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"deleted_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8f6f\\u5220\\u9664\\u65f6\\u95f4\\uff08NULL\\u8868\\u793a\\u672a\\u5220\\u9664\\uff09\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499507);
INSERT INTO `ba_admin_log` VALUES (10, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"97\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"name\":\"ticketuser\",\"path\":\"ticketuser\",\"icon\":\"fa fa-circle-o\",\"menu_type\":null,\"url\":\"\",\"component\":\"\",\"keepalive\":\"0\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769499506\",\"create_time\":\"1769499506\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499596);
INSERT INTO `ba_admin_log` VALUES (11, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"98\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"name\":\"ticketuser\\/ticketUser\",\"path\":\"ticketuser\\/ticketUser\",\"icon\":\"fa fa-circle-o\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/ticketUser\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769499506\",\"create_time\":\"1769499506\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499620);
INSERT INTO `ba_admin_log` VALUES (12, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"97\",\"pid\":\"0\",\"type\":\"menu_dir\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"name\":\"ticketuser\",\"path\":\"ticketuser\",\"icon\":\"el-icon-Avatar\",\"menu_type\":null,\"url\":\"\",\"component\":\"\",\"keepalive\":\"0\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769499596\",\"create_time\":\"1769499506\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499640);
INSERT INTO `ba_admin_log` VALUES (13, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"98\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"name\":\"ticketuser\\/ticketUser\",\"path\":\"ticketuser\\/ticketUser\",\"icon\":\"el-icon-Avatar\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/ticketUser\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769499620\",\"create_time\":\"1769499506\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499717);
INSERT INTO `ba_admin_log` VALUES (14, 1, 'admin', '/admin/ajax/upload?uuid=663e3bf1-316e-4037-9366-4f623607b301', '上传文件', '{\"uuid\":\"663e3bf1-316e-4037-9366-4f623607b301\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499784);
INSERT INTO `ba_admin_log` VALUES (15, 1, 'admin', '/admin/auth.Admin/edit', '管理员管理-编辑', '{\"group_arr\":[\"1\"],\"group_name_arr\":[\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u7ec4\"],\"id\":\"1\",\"username\":\"admin\",\"nickname\":\"Admin\",\"avatar\":\"\\/storage\\/default\\/20260127\\/PixPin_2026-01-e9a7c888a790b00f8ad721e3e0911e41265ede35.png\",\"email\":\"admin@buildadmin.com\",\"mobile\":\"18888888888\",\"last_login_time\":\"1769499776\",\"last_login_ip\":\"127.0.0.1\",\"password\":\"***\",\"motto\":\"\",\"status\":\"enable\",\"update_time\":\"1769499776\",\"create_time\":\"1769497215\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769499786);
INSERT INTO `ba_admin_log` VALUES (16, 1, 'admin', '/admin/Index/login', '登录', '{\"username\":\"admin\",\"password\":\"***\",\"keep\":\"\",\"captchaId\":\"b0243423-df3e-45a8-a428-980debaaf0e3\",\"captchaInfo\":\"96,117-113,75;350;200\"}', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', 1769499833);
INSERT INTO `ba_admin_log` VALUES (17, 1, 'admin', '/admin/ajax/upload?uuid=3856694b-f3ea-4361-bf43-fcf2c0bf5648', '上传文件', '{\"uuid\":\"3856694b-f3ea-4361-bf43-fcf2c0bf5648\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769500045);
INSERT INTO `ba_admin_log` VALUES (18, 1, 'admin', '/admin/ticketuser.TicketUser/edit', '用户管理-编辑', '{\"id\":\"9\",\"phone\":\"13800090001\",\"password_hash\":\"***\",\"avatar\":\"\\/storage\\/default\\/20260127\\/PixPin_2026-01-57011c001b25c2b780bbe923814e70f0865552f0.png\",\"gender\":\"1\",\"status\":\"1\",\"role\":\"9\",\"created_at\":\"2026-01-27 15:46:31\",\"updated_at\":\"2026-01-27 15:46:31\",\"deleted_at\":null}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769500046);
INSERT INTO `ba_admin_log` VALUES (19, 1, 'admin', '/admin/ajax/clearCache', '清理缓存', '{\"type\":\"all\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769502202);
INSERT INTO `ba_admin_log` VALUES (20, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=9', '用户管理-删除', '{\"ids\":[\"9\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769503428);
INSERT INTO `ba_admin_log` VALUES (21, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=8', '用户管理-删除', '{\"ids\":[\"8\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769504104);
INSERT INTO `ba_admin_log` VALUES (22, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=7', '用户管理-删除', '{\"ids\":[\"7\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769504655);
INSERT INTO `ba_admin_log` VALUES (23, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=6', '用户管理-删除', '{\"ids\":[\"6\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769504815);
INSERT INTO `ba_admin_log` VALUES (26, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=5', '用户管理-删除', '{\"ids\":[\"5\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769505596);
INSERT INTO `ba_admin_log` VALUES (27, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=5', '用户管理-删除', '{\"ids\":[\"5\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769505620);
INSERT INTO `ba_admin_log` VALUES (28, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=4&ids[]=3', '用户管理-删除', '{\"ids\":[\"4\",\"3\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769505691);
INSERT INTO `ba_admin_log` VALUES (29, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=4', '用户管理-删除', '{\"ids\":[\"4\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769506222);
INSERT INTO `ba_admin_log` VALUES (30, 1, 'admin', '/admin/ajax/clearCache', '清理缓存', '{\"type\":\"all\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769509323);
INSERT INTO `ba_admin_log` VALUES (31, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"user_profile\",\"sql\":\"\",\"connection\":\"mysql\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769509618);
INSERT INTO `ba_admin_log` VALUES (32, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"user_profile\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769510744);
INSERT INTO `ba_admin_log` VALUES (33, 1, 'admin', '/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"user_profile\",\"comment\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\\u8868\\uff08\\u542b\\u5b9e\\u540d\\u4e0e\\u6536\\u6b3e\\u4fe1\\u606f\\uff09\",\"quickSearchField\":[\"user_id\",\"bank_card_no\",\"id_card_no\"],\"defaultSortField\":\"\",\"formFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card_image_url\",\"wechat_qr_url\",\"alipay_qr_url\",\"created_at\",\"updated_at\"],\"columnFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card_image_url\",\"wechat_qr_url\",\"alipay_qr_url\",\"created_at\",\"updated_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticketuser\\\\userProfile\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\ticketuser\\\\UserProfile.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\ticketuser\\\\UserProfile.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"},\"fields\":[{\"name\":\"user_id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5173\\u8054\\u7528\\u6237ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"real_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8d1f\\u8d23\\u4eba\\u59d3\\u540d\\uff08\\u4e0d\\u53ef\\u4fee\\u6539\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"account_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5f00\\u6237\\u540d\\uff08\\u672c\\u4eba\\u59d3\\u540d\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"wechat_id\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5fae\\u4fe1\\u53f7\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"bank_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(30)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u94f6\\u884c\\u5361\\u53f7\\uff08\\u53ef\\u66f4\\u65b0\\uff0c\\u5efa\\u8bae\\u5e94\\u7528\\u5c42\\u52a0\\u5bc6\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8eab\\u4efd\\u8bc1\\u53f7\\uff08\\u5efa\\u8bae\\u5e94\\u7528\\u5c42\\u52a0\\u5bc6\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card_image_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8eab\\u4efd\\u8bc1\\u56fe\\u7247URL\\uff08\\u9700\\u5e26\\u6c34\\u5370\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"wechat_qr_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5fae\\u4fe1\\u6536\\u6b3e\\u7801\\u56fe\\u7247URL\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"alipay_qr_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u652f\\u4ed8\\u5b9d\\u6536\\u6b3e\\u7801\\u56fe\\u7247URL\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769510745);
INSERT INTO `ba_admin_log` VALUES (34, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"104\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\\u8868\",\"name\":\"ticketuser\\/userProfile\",\"path\":\"ticketuser\\/userProfile\",\"icon\":\"fa fa-circle-o\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/userProfile\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769510745\",\"create_time\":\"1769510745\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769510933);
INSERT INTO `ba_admin_log` VALUES (35, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"104\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\\u8868\",\"name\":\"ticketuser\\/userProfile\",\"path\":\"ticketuser\\/userProfile\",\"icon\":\"el-icon-CreditCard\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/userProfile\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769510933\",\"create_time\":\"1769510745\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769510977);
INSERT INTO `ba_admin_log` VALUES (36, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"104\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\",\"name\":\"ticketuser\\/userProfile\",\"path\":\"ticketuser\\/userProfile\",\"icon\":\"el-icon-CreditCard\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/userProfile\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769510977\",\"create_time\":\"1769510745\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769510997);
INSERT INTO `ba_admin_log` VALUES (37, 1, 'admin', '/admin/crud.Crud/delete', 'CRUD代码生成-删除', '{\"id\":\"3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511807);
INSERT INTO `ba_admin_log` VALUES (38, 1, 'admin', '/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{\"id\":\"3\",\"type\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511812);
INSERT INTO `ba_admin_log` VALUES (39, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"user_profile\",\"sql\":\"\",\"connection\":\"mysql\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511834);
INSERT INTO `ba_admin_log` VALUES (40, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{\"type\":\"db\",\"table\":\"user_profile\",\"sql\":\"\",\"connection\":\"mysql\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511846);
INSERT INTO `ba_admin_log` VALUES (41, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"user_profile\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511942);
INSERT INTO `ba_admin_log` VALUES (42, 1, 'admin', '/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{\"type\":\"db\",\"table\":{\"name\":\"user_profile\",\"comment\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\\u8868\\uff08\\u542b\\u5b9e\\u540d\\u4e0e\\u6536\\u6b3e\\u4fe1\\u606f\\uff09\",\"quickSearchField\":[\"real_name\",\"account_name\",\"id_card_no\"],\"defaultSortField\":\"real_name\",\"formFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card1_image\",\"id_card2_image\",\"wechat_qr_image\",\"alipay_qr_image\",\"created_at\",\"updated_at\"],\"columnFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card1_image\",\"id_card2_image\",\"wechat_qr_image\",\"alipay_qr_image\",\"created_at\",\"updated_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticketuser\\\\UserProfile\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\ticketuser\\\\UserProfile.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\ticketuser\\\\UserProfile.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"},\"fields\":[{\"name\":\"user_id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5173\\u8054\\u7528\\u6237ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"real_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8d1f\\u8d23\\u4eba\\u59d3\\u540d\\uff08\\u4e0d\\u53ef\\u4fee\\u6539\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"account_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5f00\\u6237\\u540d\\uff08\\u672c\\u4eba\\u59d3\\u540d\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"wechat_id\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5fae\\u4fe1\\u53f7\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"bank_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(30)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u94f6\\u884c\\u5361\\u53f7\\uff08\\u53ef\\u66f4\\u65b0\\uff0c\\u5efa\\u8bae\\u5e94\\u7528\\u5c42\\u52a0\\u5bc6\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8eab\\u4efd\\u8bc1\\u53f7\\uff08\\u5efa\\u8bae\\u5e94\\u7528\\u5c42\\u52a0\\u5bc6\\uff09\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card1_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8eab\\u4efd\\u8bc1\\u56fe\\u7247\\u6b63\\u9762URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"id_card2_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u8eab\\u4efd\\u8bc1\\u56fe\\u7247\\u53cd\\u9762URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"wechat_qr_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u5fae\\u4fe1\\u6536\\u6b3e\\u7801\\u56fe\\u7247URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"alipay_qr_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\\u652f\\u4ed8\\u5b9d\\u6536\\u6b3e\\u7801\\u56fe\\u7247URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511944);
INSERT INTO `ba_admin_log` VALUES (43, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{\"table\":\"user_profile\",\"connection\":\"mysql\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769511950);
INSERT INTO `ba_admin_log` VALUES (44, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"110\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\",\"name\":\"ticketuser\\/userProfile\",\"path\":\"ticketuser\\/userProfile\",\"icon\":\"fa fa-circle-o\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/userProfile\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769511944\",\"create_time\":\"1769511944\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769512051);
INSERT INTO `ba_admin_log` VALUES (45, 1, 'admin', '/admin/auth.Rule/edit', '菜单规则管理-编辑', '{\"id\":\"110\",\"pid\":\"97\",\"type\":\"menu\",\"title\":\"\\u7528\\u6237\\u8be6\\u7ec6\\u8d44\\u6599\",\"name\":\"ticketuser\\/userProfile\",\"path\":\"ticketuser\\/userProfile\",\"icon\":\"el-icon-Document\",\"menu_type\":\"tab\",\"url\":\"\",\"component\":\"\\/src\\/views\\/backend\\/ticketuser\\/userProfile\\/index.vue\",\"keepalive\":\"1\",\"extend\":\"none\",\"remark\":\"\",\"weigh\":\"0\",\"status\":\"1\",\"update_time\":\"1769512051\",\"create_time\":\"1769511944\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769512080);
INSERT INTO `ba_admin_log` VALUES (46, 1, 'admin', '/admin/ajax/upload?uuid=df3d2671-2f6b-4a7b-b31d-864bbbfaf3e3', '上传文件', '{\"uuid\":\"df3d2671-2f6b-4a7b-b31d-864bbbfaf3e3\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769512235);
INSERT INTO `ba_admin_log` VALUES (47, 1, 'admin', '/admin/ticketuser.TicketUser/del?ids[]=4', '用户管理-删除', '{\"ids\":[\"4\"]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 1769512278);

-- ----------------------------
-- Table structure for ba_admin_rule
-- ----------------------------
DROP TABLE IF EXISTS `ba_admin_rule`;
CREATE TABLE `ba_admin_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级菜单',
  `type` enum('menu_dir','menu','button') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:menu_dir=菜单目录,menu=菜单项,button=页面按钮',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `keepalive` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '缓存:0=关闭,1=开启',
  `extend` enum('none','add_rules_only','add_menu_only') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 116 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单和权限规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_admin_rule
-- ----------------------------
INSERT INTO `ba_admin_rule` VALUES (1, 0, 'menu', '控制台', 'dashboard', 'dashboard', 'fa fa-dashboard', 'tab', '', '/src/views/backend/dashboard.vue', 1, 'none', 'Remark lang', 999, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (2, 0, 'menu_dir', '权限管理', 'auth', 'auth', 'fa fa-group', NULL, '', '', 0, 'none', '', 100, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (3, 2, 'menu', '角色组管理', 'auth/group', 'auth/group', 'fa fa-group', 'tab', '', '/src/views/backend/auth/group/index.vue', 1, 'none', 'Remark lang', 99, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (4, 3, 'button', '查看', 'auth/group/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (5, 3, 'button', '添加', 'auth/group/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (6, 3, 'button', '编辑', 'auth/group/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (7, 3, 'button', '删除', 'auth/group/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (8, 2, 'menu', '管理员管理', 'auth/admin', 'auth/admin', 'el-icon-UserFilled', 'tab', '', '/src/views/backend/auth/admin/index.vue', 1, 'none', '', 98, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (9, 8, 'button', '查看', 'auth/admin/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (10, 8, 'button', '添加', 'auth/admin/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (11, 8, 'button', '编辑', 'auth/admin/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (12, 8, 'button', '删除', 'auth/admin/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (13, 2, 'menu', '菜单规则管理', 'auth/rule', 'auth/rule', 'el-icon-Grid', 'tab', '', '/src/views/backend/auth/rule/index.vue', 1, 'none', '', 97, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (14, 13, 'button', '查看', 'auth/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (15, 13, 'button', '添加', 'auth/rule/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (16, 13, 'button', '编辑', 'auth/rule/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (17, 13, 'button', '删除', 'auth/rule/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (18, 13, 'button', '快速排序', 'auth/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (19, 2, 'menu', '管理员日志管理', 'auth/adminLog', 'auth/adminLog', 'el-icon-List', 'tab', '', '/src/views/backend/auth/adminLog/index.vue', 1, 'none', '', 96, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (20, 19, 'button', '查看', 'auth/adminLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (21, 0, 'menu_dir', '会员管理', 'user', 'user', 'fa fa-drivers-license', NULL, '', '', 0, 'none', '', 95, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (22, 21, 'menu', '会员管理', 'user/user', 'user/user', 'fa fa-user', 'tab', '', '/src/views/backend/user/user/index.vue', 1, 'none', '', 94, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (23, 22, 'button', '查看', 'user/user/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (24, 22, 'button', '添加', 'user/user/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (25, 22, 'button', '编辑', 'user/user/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (26, 22, 'button', '删除', 'user/user/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (27, 21, 'menu', '会员分组管理', 'user/group', 'user/group', 'fa fa-group', 'tab', '', '/src/views/backend/user/group/index.vue', 1, 'none', '', 93, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (28, 27, 'button', '查看', 'user/group/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (29, 27, 'button', '添加', 'user/group/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (30, 27, 'button', '编辑', 'user/group/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (31, 27, 'button', '删除', 'user/group/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (32, 21, 'menu', '会员规则管理', 'user/rule', 'user/rule', 'fa fa-th-list', 'tab', '', '/src/views/backend/user/rule/index.vue', 1, 'none', '', 92, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (33, 32, 'button', '查看', 'user/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (34, 32, 'button', '添加', 'user/rule/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (35, 32, 'button', '编辑', 'user/rule/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (36, 32, 'button', '删除', 'user/rule/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (37, 32, 'button', '快速排序', 'user/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (38, 21, 'menu', '会员余额管理', 'user/moneyLog', 'user/moneyLog', 'el-icon-Money', 'tab', '', '/src/views/backend/user/moneyLog/index.vue', 1, 'none', '', 91, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (39, 38, 'button', '查看', 'user/moneyLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (40, 38, 'button', '添加', 'user/moneyLog/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (41, 21, 'menu', '会员积分管理', 'user/scoreLog', 'user/scoreLog', 'el-icon-Discount', 'tab', '', '/src/views/backend/user/scoreLog/index.vue', 1, 'none', '', 90, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (42, 41, 'button', '查看', 'user/scoreLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (43, 41, 'button', '添加', 'user/scoreLog/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (44, 0, 'menu_dir', '常规管理', 'routine', 'routine', 'fa fa-cogs', NULL, '', '', 0, 'none', '', 89, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (45, 44, 'menu', '系统配置', 'routine/config', 'routine/config', 'el-icon-Tools', 'tab', '', '/src/views/backend/routine/config/index.vue', 1, 'none', '', 88, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (46, 45, 'button', '查看', 'routine/config/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (47, 45, 'button', '编辑', 'routine/config/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (48, 44, 'menu', '附件管理', 'routine/attachment', 'routine/attachment', 'fa fa-folder', 'tab', '', '/src/views/backend/routine/attachment/index.vue', 1, 'none', 'Remark lang', 87, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (49, 48, 'button', '查看', 'routine/attachment/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (50, 48, 'button', '编辑', 'routine/attachment/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (51, 48, 'button', '删除', 'routine/attachment/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (52, 44, 'menu', '个人资料', 'routine/adminInfo', 'routine/adminInfo', 'fa fa-user', 'tab', '', '/src/views/backend/routine/adminInfo.vue', 1, 'none', '', 86, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (53, 52, 'button', '查看', 'routine/adminInfo/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (54, 52, 'button', '编辑', 'routine/adminInfo/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (55, 0, 'menu_dir', '数据安全管理', 'security', 'security', 'fa fa-shield', NULL, '', '', 0, 'none', '', 85, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (56, 55, 'menu', '数据回收站', 'security/dataRecycleLog', 'security/dataRecycleLog', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycleLog/index.vue', 1, 'none', '', 84, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (57, 56, 'button', '查看', 'security/dataRecycleLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (58, 56, 'button', '删除', 'security/dataRecycleLog/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (59, 56, 'button', '还原', 'security/dataRecycleLog/restore', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (60, 56, 'button', '查看详情', 'security/dataRecycleLog/info', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (61, 55, 'menu', '敏感数据修改记录', 'security/sensitiveDataLog', 'security/sensitiveDataLog', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveDataLog/index.vue', 1, 'none', '', 83, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (62, 61, 'button', '查看', 'security/sensitiveDataLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (63, 61, 'button', '删除', 'security/sensitiveDataLog/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (64, 61, 'button', '回滚', 'security/sensitiveDataLog/rollback', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (65, 61, 'button', '查看详情', 'security/sensitiveDataLog/info', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (66, 55, 'menu', '数据回收规则管理', 'security/dataRecycle', 'security/dataRecycle', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycle/index.vue', 1, 'none', 'Remark lang', 82, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (67, 66, 'button', '查看', 'security/dataRecycle/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (68, 66, 'button', '添加', 'security/dataRecycle/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (69, 66, 'button', '编辑', 'security/dataRecycle/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (70, 66, 'button', '删除', 'security/dataRecycle/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (71, 55, 'menu', '敏感字段规则管理', 'security/sensitiveData', 'security/sensitiveData', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveData/index.vue', 1, 'none', 'Remark lang', 81, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (72, 71, 'button', '查看', 'security/sensitiveData/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (73, 71, 'button', '添加', 'security/sensitiveData/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (74, 71, 'button', '编辑', 'security/sensitiveData/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (75, 71, 'button', '删除', 'security/sensitiveData/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (76, 0, 'menu', 'BuildAdmin', 'buildadmin', 'buildadmin', 'local-logo', 'link', 'https://doc.buildadmin.com', '', 0, 'none', '', 0, 0, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (77, 45, 'button', '添加', 'routine/config/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (78, 0, 'menu', '模块市场', 'moduleStore/moduleStore', 'moduleStore', 'el-icon-GoodsFilled', 'tab', '', '/src/views/backend/module/index.vue', 1, 'none', '', 86, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (79, 78, 'button', '查看', 'moduleStore/moduleStore/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (80, 78, 'button', '安装', 'moduleStore/moduleStore/install', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (81, 78, 'button', '调整状态', 'moduleStore/moduleStore/changeState', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (82, 78, 'button', '卸载', 'moduleStore/moduleStore/uninstall', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (83, 78, 'button', '更新', 'moduleStore/moduleStore/update', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (84, 0, 'menu', 'CRUD代码生成', 'crud/crud', 'crud/crud', 'fa fa-code', 'tab', '', '/src/views/backend/crud/index.vue', 1, 'none', '', 80, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (85, 84, 'button', '查看', 'crud/crud/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (86, 84, 'button', '生成', 'crud/crud/generate', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (87, 84, 'button', '删除', 'crud/crud/delete', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (88, 45, 'button', '删除', 'routine/config/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497215, 1769497215);
INSERT INTO `ba_admin_rule` VALUES (89, 1, 'button', '查看', 'dashboard/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769497216, 1769497216);
INSERT INTO `ba_admin_rule` VALUES (97, 0, 'menu_dir', '用户管理', 'ticketuser', 'ticketuser', 'el-icon-Avatar', NULL, '', '', 0, 'none', '', 0, 1, 1769499640, 1769499506);
INSERT INTO `ba_admin_rule` VALUES (98, 97, 'menu', '用户管理', 'ticketuser/ticketUser', 'ticketuser/ticketUser', 'el-icon-Avatar', 'tab', '', '/src/views/backend/ticketuser/ticketUser/index.vue', 1, 'none', '', 0, 1, 1769499717, 1769499506);
INSERT INTO `ba_admin_rule` VALUES (99, 98, 'button', '查看', 'ticketuser/ticketUser/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769499507, 1769499507);
INSERT INTO `ba_admin_rule` VALUES (100, 98, 'button', '添加', 'ticketuser/ticketUser/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769499507, 1769499507);
INSERT INTO `ba_admin_rule` VALUES (101, 98, 'button', '编辑', 'ticketuser/ticketUser/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769499507, 1769499507);
INSERT INTO `ba_admin_rule` VALUES (102, 98, 'button', '删除', 'ticketuser/ticketUser/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769499507, 1769499507);
INSERT INTO `ba_admin_rule` VALUES (103, 98, 'button', '快速排序', 'ticketuser/ticketUser/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769499507, 1769499507);
INSERT INTO `ba_admin_rule` VALUES (110, 97, 'menu', '用户详细资料', 'ticketuser/userProfile', 'ticketuser/userProfile', 'el-icon-Document', 'tab', '', '/src/views/backend/ticketuser/userProfile/index.vue', 1, 'none', '', 0, 1, 1769512080, 1769511944);
INSERT INTO `ba_admin_rule` VALUES (111, 110, 'button', '查看', 'ticketuser/userProfile/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769511944, 1769511944);
INSERT INTO `ba_admin_rule` VALUES (112, 110, 'button', '添加', 'ticketuser/userProfile/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769511944, 1769511944);
INSERT INTO `ba_admin_rule` VALUES (113, 110, 'button', '编辑', 'ticketuser/userProfile/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769511944, 1769511944);
INSERT INTO `ba_admin_rule` VALUES (114, 110, 'button', '删除', 'ticketuser/userProfile/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769511944, 1769511944);
INSERT INTO `ba_admin_rule` VALUES (115, 110, 'button', '快速排序', 'ticketuser/userProfile/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1769511944, 1769511944);

-- ----------------------------
-- Table structure for ba_area
-- ----------------------------
DROP TABLE IF EXISTS `ba_area`;
CREATE TABLE `ba_area`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简称',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) UNSIGNED NULL DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '首字母',
  `lng` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `lat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '省份地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_area
-- ----------------------------

-- ----------------------------
-- Table structure for ba_attachment
-- ----------------------------
DROP TABLE IF EXISTS `ba_attachment`;
CREATE TABLE `ba_attachment`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `topic` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '细目',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传管理员ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传用户ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '物理路径',
  `width` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '宽度',
  `height` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '高度',
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '原始名称',
  `size` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'mime类型',
  `quote` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传(引用)次数',
  `storage` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储方式',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sha1编码',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `last_upload_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '最后上传时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_attachment
-- ----------------------------
INSERT INTO `ba_attachment` VALUES (1, 'default', 1, 0, '/storage/default/20260127/PixPin_2026-01-e9a7c888a790b00f8ad721e3e0911e41265ede35.png', 334, 260, 'PixPin_2026-01-26_14-31-25.png', 203516, 'image/png', 2, 'local', 'e9a7c888a790b00f8ad721e3e0911e41265ede35', 1769499784, 1769512235);
INSERT INTO `ba_attachment` VALUES (2, 'default', 1, 0, '/storage/default/20260127/PixPin_2026-01-57011c001b25c2b780bbe923814e70f0865552f0.png', 352, 243, 'PixPin_2026-01-26_14-32-30.png', 202684, 'image/png', 1, 'local', '57011c001b25c2b780bbe923814e70f0865552f0', 1769500045, 1769500045);

-- ----------------------------
-- Table structure for ba_captcha
-- ----------------------------
DROP TABLE IF EXISTS `ba_captcha`;
CREATE TABLE `ba_captcha`  (
  `key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码Key',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码(加密后)',
  `captcha` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '验证码数据',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_captcha
-- ----------------------------

-- ----------------------------
-- Table structure for ba_config
-- ----------------------------
DROP TABLE IF EXISTS `ba_config`;
CREATE TABLE `ba_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量输入组件类型',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '变量值',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '字典数据',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  `allow_del` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '允许删除:0=否,1=是',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_config
-- ----------------------------
INSERT INTO `ba_config` VALUES (1, 'config_group', 'basics', 'Config group', '', 'array', '[{\"key\":\"basics\",\"value\":\"Basics\"},{\"key\":\"mail\",\"value\":\"Mail\"},{\"key\":\"config_quick_entrance\",\"value\":\"Config Quick entrance\"}]', NULL, 'required', '', 0, -1);
INSERT INTO `ba_config` VALUES (2, 'site_name', 'basics', 'Site Name', '', 'string', 'BuildAdmin', NULL, 'required', '', 0, 99);
INSERT INTO `ba_config` VALUES (3, 'record_number', 'basics', 'Record number', '域名备案号', 'string', '渝ICP备8888888号-1', NULL, '', '', 0, 0);
INSERT INTO `ba_config` VALUES (4, 'version', 'basics', 'Version number', '系统版本号', 'string', 'v1.0.0', NULL, 'required', '', 0, 0);
INSERT INTO `ba_config` VALUES (5, 'time_zone', 'basics', 'time zone', '', 'string', 'Asia/Shanghai', NULL, 'required', '', 0, 0);
INSERT INTO `ba_config` VALUES (6, 'no_access_ip', 'basics', 'No access ip', '禁止访问站点的ip列表,一行一个', 'textarea', NULL, NULL, '', '', 0, 0);
INSERT INTO `ba_config` VALUES (7, 'smtp_server', 'mail', 'smtp server', '', 'string', 'smtp.qq.com', NULL, '', '', 0, 9);
INSERT INTO `ba_config` VALUES (8, 'smtp_port', 'mail', 'smtp port', '', 'string', '465', NULL, '', '', 0, 8);
INSERT INTO `ba_config` VALUES (9, 'smtp_user', 'mail', 'smtp user', '', 'string', NULL, NULL, '', '', 0, 7);
INSERT INTO `ba_config` VALUES (10, 'smtp_pass', 'mail', 'smtp pass', '', 'string', NULL, NULL, '', '', 0, 6);
INSERT INTO `ba_config` VALUES (11, 'smtp_verification', 'mail', 'smtp verification', '', 'select', 'SSL', '{\"SSL\":\"SSL\",\"TLS\":\"TLS\"}', '', '', 0, 5);
INSERT INTO `ba_config` VALUES (12, 'smtp_sender_mail', 'mail', 'smtp sender mail', '', 'string', NULL, NULL, 'email', '', 0, 4);
INSERT INTO `ba_config` VALUES (13, 'config_quick_entrance', 'config_quick_entrance', 'Config Quick entrance', '', 'array', '[{\"key\":\"\\u6570\\u636e\\u56de\\u6536\\u89c4\\u5219\\u914d\\u7f6e\",\"value\":\"security\\/dataRecycle\"},{\"key\":\"\\u654f\\u611f\\u6570\\u636e\\u89c4\\u5219\\u914d\\u7f6e\",\"value\":\"security\\/sensitiveData\"}]', NULL, '', '', 0, 0);
INSERT INTO `ba_config` VALUES (14, 'backend_entrance', 'basics', 'Backend entrance', '', 'string', '/admin', NULL, 'required', '', 0, 1);

-- ----------------------------
-- Table structure for ba_crud_log
-- ----------------------------
DROP TABLE IF EXISTS `ba_crud_log`;
CREATE TABLE `ba_crud_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表名',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '注释',
  `table` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '数据表数据',
  `fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '字段数据',
  `sync` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '同步记录',
  `status` enum('delete','success','error','start') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'start' COMMENT '状态:delete=已删除,success=成功,error=失败,start=生成中',
  `connection` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `create_time` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'CRUD记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_crud_log
-- ----------------------------
INSERT INTO `ba_crud_log` VALUES (1, 'ticket_user', '用户主表（登录凭证）', '{\"name\":\"ticket_user\",\"comment\":\"用户主表（登录凭证）\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"phone\",\"password_hash\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"columnFields\":[\"id\",\"phone\",\"password_hash\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticket_user\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\ticket\\\\User.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticket\\\\User.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\ticket\\\\User.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticket\\\\user\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"用户ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"phone\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"手机号（登录账号）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"password_hash\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"密码哈希值\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(500)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"头像 URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"gender\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"性别：0=未知, 1=男, 2=女\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"审核状态：0=待审核, 1=已通过, 2=已拒绝\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"role\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"角色：0=普通用户, 1=客服, 2=财务, 9=管理员\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"deleted_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"软删除时间（NULL表示未删除）\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'delete', 'mysql', 1769498462);
INSERT INTO `ba_crud_log` VALUES (2, 'ticket_user', '用户主表（登录凭证）', '{\"name\":\"ticket_user\",\"comment\":\"用户主表（登录凭证）\",\"quickSearchField\":[\"id\"],\"defaultSortField\":\"id\",\"formFields\":[\"phone\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"columnFields\":[\"id\",\"phone\",\"avatar\",\"gender\",\"status\",\"role\",\"created_at\",\"updated_at\",\"deleted_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticketUser\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\TicketUser\\\\TicketUser.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\TicketUser\\\\TicketUser.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\TicketUser\\\\TicketUser.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\TicketUser\\\\ticketUser\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"}', '[{\"name\":\"id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"1\",\"comment\":\"用户ID\",\"designType\":\"pk\",\"table\":{\"width\":\"70\",\"operator\":\"RANGE\",\"sortable\":\"custom\"},\"form\":[]},{\"name\":\"phone\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"手机号（登录账号）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"password_hash\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"密码哈希值\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"avatar\",\"type\":\"varchar\",\"dataType\":\"varchar(500)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"头像 URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"gender\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"性别：0=未知, 1=男, 2=女\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"status\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"审核状态：0=待审核, 1=已通过, 2=已拒绝\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"role\",\"type\":\"tinyint\",\"dataType\":\"tinyint(4)\",\"default\":\"0\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"角色：0=普通用户, 1=客服, 2=财务, 9=管理员\",\"designType\":\"number\",\"table\":{\"render\":\"none\",\"operator\":\"RANGE\",\"sortable\":\"false\"},\"form\":{\"validator\":[\"number\"],\"validatorMsg\":\"\",\"step\":\"1\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"创建时间\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"更新时间\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"deleted_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"软删除时间（NULL表示未删除）\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1769499506);
INSERT INTO `ba_crud_log` VALUES (3, 'user_profile', '用户详细资料表（含实名与收款信息）', '{\"name\":\"user_profile\",\"comment\":\"用户详细资料表（含实名与收款信息）\",\"quickSearchField\":[\"user_id\",\"bank_card_no\",\"id_card_no\"],\"defaultSortField\":\"\",\"formFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card_image_url\",\"wechat_qr_url\",\"alipay_qr_url\",\"created_at\",\"updated_at\"],\"columnFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card_image_url\",\"wechat_qr_url\",\"alipay_qr_url\",\"created_at\",\"updated_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticketuser\\\\userProfile\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\ticketuser\\\\UserProfile.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\ticketuser\\\\UserProfile.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"}', '[{\"name\":\"user_id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"关联用户ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"real_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"负责人姓名（不可修改）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"account_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"开户名（本人姓名）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"wechat_id\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"微信号\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"bank_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(30)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"银行卡号（可更新，建议应用层加密）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"身份证号（建议应用层加密）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card_image_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"身份证图片URL（需带水印）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"wechat_qr_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"微信收款码图片URL\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"alipay_qr_url\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付宝收款码图片URL\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'delete', 'mysql', 1769510745);
INSERT INTO `ba_crud_log` VALUES (4, 'user_profile', '用户详细资料表（含实名与收款信息）', '{\"name\":\"user_profile\",\"comment\":\"用户详细资料表（含实名与收款信息）\",\"quickSearchField\":[\"real_name\",\"account_name\",\"id_card_no\"],\"defaultSortField\":\"real_name\",\"formFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card1_image\",\"id_card2_image\",\"wechat_qr_image\",\"alipay_qr_image\",\"created_at\",\"updated_at\"],\"columnFields\":[\"user_id\",\"real_name\",\"account_name\",\"wechat_id\",\"bank_card_no\",\"id_card_no\",\"id_card1_image\",\"id_card2_image\",\"wechat_qr_image\",\"alipay_qr_image\",\"created_at\",\"updated_at\"],\"defaultSortType\":\"desc\",\"generateRelativePath\":\"ticketuser\\\\UserProfile\",\"isCommonModel\":\"0\",\"modelFile\":\"app\\\\admin\\\\model\\\\ticketuser\\\\UserProfile.php\",\"controllerFile\":\"app\\\\admin\\\\controller\\\\ticketuser\\\\UserProfile.php\",\"validateFile\":\"app\\\\admin\\\\validate\\\\ticketuser\\\\UserProfile.php\",\"webViewsDir\":\"web\\\\src\\\\views\\\\backend\\\\ticketuser\\\\userProfile\",\"databaseConnection\":\"mysql\",\"designChange\":[],\"rebuild\":\"Yes\"}', '[{\"name\":\"user_id\",\"type\":\"bigint\",\"dataType\":\"bigint(20)\",\"default\":\"\",\"defaultType\":\"NONE\",\"null\":\"\",\"primaryKey\":\"1\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"关联用户ID\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"real_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"负责人姓名（不可修改）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"account_name\",\"type\":\"varchar\",\"dataType\":\"varchar(50)\",\"default\":\"\",\"defaultType\":\"EMPTY STRING\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"开户名（本人姓名）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"wechat_id\",\"type\":\"varchar\",\"dataType\":\"varchar(100)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"微信号\",\"designType\":\"remoteSelect\",\"table\":{\"operator\":\"LIKE\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"select-multi\":\"\",\"remote-pk\":\"id\",\"remote-field\":\"name\",\"remote-table\":\"\",\"remote-controller\":\"\",\"remote-model\":\"\",\"relation-fields\":\"\",\"remote-url\":\"\",\"remote-primary-table-alias\":\"\",\"remote-source-config-type\":\"\"}},{\"name\":\"bank_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(30)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"银行卡号（可更新，建议应用层加密）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card_no\",\"type\":\"varchar\",\"dataType\":\"varchar(20)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"身份证号（建议应用层加密）\",\"designType\":\"string\",\"table\":{\"render\":\"none\",\"operator\":\"LIKE\",\"sortable\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\"}},{\"name\":\"id_card1_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"身份证图片正面URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"id_card2_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"身份证图片反面URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"wechat_qr_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"微信收款码图片URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"alipay_qr_image\",\"type\":\"varchar\",\"dataType\":\"varchar(255)\",\"default\":\"\",\"defaultType\":\"NULL\",\"null\":\"1\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"支付宝收款码图片URL\",\"designType\":\"image\",\"table\":{\"render\":\"image\",\"operator\":\"false\"},\"form\":{\"validator\":[],\"validatorMsg\":\"\",\"image-multi\":\"\"}},{\"name\":\"created_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}},{\"name\":\"updated_at\",\"type\":\"datetime\",\"dataType\":\"datetime\",\"default\":\"CURRENT_TIMESTAMP\",\"defaultType\":\"INPUT\",\"null\":\"\",\"primaryKey\":\"\",\"unsigned\":\"\",\"autoIncrement\":\"\",\"comment\":\"\",\"designType\":\"datetime\",\"table\":{\"operator\":\"eq\",\"sortable\":\"custom\",\"width\":\"160\"},\"form\":{\"validator\":[\"date\"],\"validatorMsg\":\"\"}}]', 0, 'success', 'mysql', 1769511944);

-- ----------------------------
-- Table structure for ba_migrations
-- ----------------------------
DROP TABLE IF EXISTS `ba_migrations`;
CREATE TABLE `ba_migrations`  (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ba_migrations
-- ----------------------------
INSERT INTO `ba_migrations` VALUES (20230620180908, 'Install', '2026-01-27 15:00:15', '2026-01-27 15:00:15', 0);
INSERT INTO `ba_migrations` VALUES (20230620180916, 'InstallData', '2026-01-27 15:00:15', '2026-01-27 15:00:15', 0);
INSERT INTO `ba_migrations` VALUES (20230622221507, 'Version200', '2026-01-27 15:00:15', '2026-01-27 15:00:16', 0);
INSERT INTO `ba_migrations` VALUES (20230719211338, 'Version201', '2026-01-27 15:00:16', '2026-01-27 15:00:16', 0);
INSERT INTO `ba_migrations` VALUES (20230905060702, 'Version202', '2026-01-27 15:00:16', '2026-01-27 15:00:16', 0);
INSERT INTO `ba_migrations` VALUES (20231112093414, 'Version205', '2026-01-27 15:00:16', '2026-01-27 15:00:16', 0);
INSERT INTO `ba_migrations` VALUES (20231229043002, 'Version206', '2026-01-27 15:00:16', '2026-01-27 15:00:16', 0);
INSERT INTO `ba_migrations` VALUES (20250412134127, 'Version222', '2026-01-27 15:00:16', '2026-01-27 15:00:16', 0);

-- ----------------------------
-- Table structure for ba_security_data_recycle
-- ----------------------------
DROP TABLE IF EXISTS `ba_security_data_recycle`;
CREATE TABLE `ba_security_data_recycle`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '回收规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_security_data_recycle
-- ----------------------------
INSERT INTO `ba_security_data_recycle` VALUES (1, '管理员', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_data_recycle` VALUES (2, '管理员日志', 'auth/AdminLog.php', 'auth/adminlog', 'admin_log', '', 'id', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_data_recycle` VALUES (3, '菜单规则', 'auth/Menu.php', 'auth/menu', 'menu_rule', '', 'id', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_data_recycle` VALUES (4, '系统配置项', 'routine/Config.php', 'routine/config', 'config', '', 'id', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_data_recycle` VALUES (5, '会员', 'user/User.php', 'user/user', 'user', '', 'id', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_data_recycle` VALUES (6, '数据回收规则', 'security/DataRecycle.php', 'security/datarecycle', 'security_data_recycle', '', 'id', 1, 1769497215, 1769497215);

-- ----------------------------
-- Table structure for ba_security_data_recycle_log
-- ----------------------------
DROP TABLE IF EXISTS `ba_security_data_recycle_log`;
CREATE TABLE `ba_security_data_recycle_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作管理员',
  `recycle_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回收规则ID',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '回收的数据',
  `data_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `is_restore` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否已还原:0=否,1=是',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '数据回收记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_security_data_recycle_log
-- ----------------------------

-- ----------------------------
-- Table structure for ba_security_sensitive_data
-- ----------------------------
DROP TABLE IF EXISTS `ba_security_sensitive_data`;
CREATE TABLE `ba_security_sensitive_data`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_fields` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '敏感数据字段',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '敏感数据规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_security_sensitive_data
-- ----------------------------
INSERT INTO `ba_security_sensitive_data` VALUES (1, '管理员数据', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', '{\"username\":\"用户名\",\"mobile\":\"手机\",\"password\":\"密码\",\"status\":\"状态\"}', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_sensitive_data` VALUES (2, '会员数据', 'user/User.php', 'user/user', 'user', '', 'id', '{\"username\":\"用户名\",\"mobile\":\"手机号\",\"password\":\"密码\",\"status\":\"状态\",\"email\":\"邮箱地址\"}', 1, 1769497215, 1769497215);
INSERT INTO `ba_security_sensitive_data` VALUES (3, '管理员权限', 'auth/Group.php', 'auth/group', 'admin_group', '', 'id', '{\"rules\":\"权限规则ID\"}', 1, 1769497215, 1769497215);

-- ----------------------------
-- Table structure for ba_security_sensitive_data_log
-- ----------------------------
DROP TABLE IF EXISTS `ba_security_sensitive_data_log`;
CREATE TABLE `ba_security_sensitive_data_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作管理员',
  `sensitive_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '敏感数据规则ID',
  `data_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_field` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改字段',
  `data_comment` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改项',
  `id_value` int(11) NOT NULL DEFAULT 0 COMMENT '被修改项主键值',
  `before` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '修改前',
  `after` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '修改后',
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `is_rollback` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否已回滚:0=否,1=是',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '敏感数据修改记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_security_sensitive_data_log
-- ----------------------------

-- ----------------------------
-- Table structure for ba_test_build
-- ----------------------------
DROP TABLE IF EXISTS `ba_test_build`;
CREATE TABLE `ba_test_build`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `keyword_rows` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容',
  `views` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `likes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '有帮助数',
  `dislikes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '无帮助数',
  `note_textarea` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `update_time` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '知识库表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_test_build
-- ----------------------------

-- ----------------------------
-- Table structure for ba_ticket_user
-- ----------------------------
DROP TABLE IF EXISTS `ba_ticket_user`;
CREATE TABLE `ba_ticket_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号（登录账号）',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码哈希值',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像 URL',
  `gender` tinyint(4) NULL DEFAULT 0 COMMENT '性别：0=未知, 1=男, 2=女',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '审核状态：0=待审核, 1=已通过, 2=已拒绝',
  `role` tinyint(4) NOT NULL DEFAULT 0 COMMENT '角色：0=普通用户, 1=客服, 2=财务, 9=管理员',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '软删除时间（NULL表示未删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户主表（登录凭证）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_ticket_user
-- ----------------------------
INSERT INTO `ba_ticket_user` VALUES (1, '13800000001', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://api.adorable.io/avatars/200/13800000001.png', 1, 'w551ccc81@test.com', 1, 0, '2026-01-27 15:46:31', '2026-01-27 15:46:31', NULL);
INSERT INTO `ba_ticket_user` VALUES (2, '13800000002', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://api.adorable.io/avatars/200/13800000002.png', 2, 't98b73ae2@demo.org', 1, 0, '2026-01-27 15:46:31', '2026-01-27 15:46:31', NULL);
INSERT INTO `ba_ticket_user` VALUES (3, '13800000003', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://api.adorable.io/avatars/200/13800000003.png', 0, 'kf8a443c4@test.com', 0, 0, '2026-01-27 15:46:31', '2026-01-27 15:46:31', NULL);
INSERT INTO `ba_ticket_user` VALUES (4, '13800000004', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'https://api.adorable.io/avatars/200/13800000004.png', 1, 'jb017e1cd@local.dev', 2, 0, '2026-01-27 15:46:31', '2026-01-27 15:46:31', NULL);

-- ----------------------------
-- Table structure for ba_token
-- ----------------------------
DROP TABLE IF EXISTS `ba_token`;
CREATE TABLE `ba_token`  (
  `token` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Token',
  `type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类型',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户Token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_token
-- ----------------------------
INSERT INTO `ba_token` VALUES ('25ea407112e24d94506c08c974ed79a05e147999', 'admin', 1, 1769497587, 1769756787);
INSERT INTO `ba_token` VALUES ('b175cd8efd890e9e75072a42e18c493c7b5e1e93', 'admin', 1, 1769499833, 1769759033);

-- ----------------------------
-- Table structure for ba_user
-- ----------------------------
DROP TABLE IF EXISTS `ba_user`;
CREATE TABLE `ba_user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分组ID',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别:0=未知,1=男,2=女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `money` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '余额',
  `score` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分',
  `last_login_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `login_failure` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录失败次数',
  `join_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加入IP',
  `join_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '加入时间',
  `motto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐（废弃待删）',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态:enable=启用,disable=禁用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_user
-- ----------------------------
INSERT INTO `ba_user` VALUES (1, 1, 'user', 'User', '18888888888@qq.com', '18888888888', '', 2, '2026-01-27', 0, 0, NULL, '', 0, '', NULL, '', '$2y$10$V6ogGuIezeqBJyTV1zY3S.ZRfalOOXHYz/o.39fj2dxBVW8VpLbTm', '', 'enable', 1769497215, 1769497215);

-- ----------------------------
-- Table structure for ba_user_group
-- ----------------------------
DROP TABLE IF EXISTS `ba_user_group`;
CREATE TABLE `ba_user_group`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '权限节点',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_user_group
-- ----------------------------
INSERT INTO `ba_user_group` VALUES (1, '默认分组', '*', 1, 1769497215, 1769497215);

-- ----------------------------
-- Table structure for ba_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `ba_user_money_log`;
CREATE TABLE `ba_user_money_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `money` int(11) NOT NULL DEFAULT 0 COMMENT '变更余额',
  `before` int(11) NOT NULL DEFAULT 0 COMMENT '变更前余额',
  `after` int(11) NOT NULL DEFAULT 0 COMMENT '变更后余额',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员余额变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_user_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for ba_user_profile
-- ----------------------------
DROP TABLE IF EXISTS `ba_user_profile`;
CREATE TABLE `ba_user_profile`  (
  `user_id` bigint(20) NOT NULL COMMENT '关联用户ID',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '负责人姓名（不可修改）',
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '开户名（本人姓名）',
  `wechat_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信号',
  `bank_card_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '银行卡号（可更新，建议应用层加密）',
  `id_card_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证号（建议应用层加密）',
  `id_card1_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证图片正面URL',
  `id_card2_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证图片反面URL',
  `wechat_qr_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信收款码图片URL',
  `alipay_qr_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付宝收款码图片URL',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户详细资料表（含实名与收款信息）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_user_profile
-- ----------------------------
INSERT INTO `ba_user_profile` VALUES (1, '张伟', '张伟', 'zhangwei_8001', '6222080402001001', '110108198801011234', 'https://example.com/idcard/1_front.jpg?watermark=user1', 'https://example.com/idcard/1_back.jpg?watermark=user1', 'https://example.com/qrcode/wechat_1.png', 'https://example.com/qrcode/alipay_1.png', '2026-01-27 15:50:00', '2026-01-27 15:50:00');
INSERT INTO `ba_user_profile` VALUES (2, '李娜', '李娜', 'lina_8002', '6222080402001002', '110108199005122345', 'https://example.com/idcard/2_front.jpg?watermark=user2', 'https://example.com/idcard/2_back.jpg?watermark=user2', 'https://example.com/qrcode/wechat_2.png', 'https://example.com/qrcode/alipay_2.png', '2026-01-27 15:50:00', '2026-01-27 15:50:00');
INSERT INTO `ba_user_profile` VALUES (3, '王客服', '王客服', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-01-27 16:00:00', '2026-01-27 16:00:00');
INSERT INTO `ba_user_profile` VALUES (4, '赵敏', '赵敏', 'zhaomin_8005', '6222080402001005', '110108199211233456', 'https://example.com/idcard/5_front.jpg?watermark=user5', 'https://example.com/idcard/5_back.jpg?watermark=user5', 'https://example.com/qrcode/wechat_5.png', 'https://example.com/qrcode/alipay_5.png', '2026-01-27 15:50:00', '2026-01-27 15:50:00');

-- ----------------------------
-- Table structure for ba_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `ba_user_rule`;
CREATE TABLE `ba_user_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级菜单',
  `type` enum('route','menu_dir','menu','nav_user_menu','nav','button') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:route=路由,menu_dir=菜单目录,menu=菜单项,nav_user_menu=顶栏会员菜单下拉项,nav=顶栏菜单项,button=页面按钮',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tab' COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `no_login_valid` tinyint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '未登录有效:0=否,1=是',
  `extend` enum('none','add_rules_only','add_menu_only') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int(11) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员菜单权限规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_user_rule
-- ----------------------------
INSERT INTO `ba_user_rule` VALUES (1, 0, 'menu_dir', '我的账户', 'account', 'account', 'fa fa-user-circle', 'tab', '', '', 0, 'none', '', 98, 1, 1769497215, 1769497215);
INSERT INTO `ba_user_rule` VALUES (2, 1, 'menu', '账户概览', 'account/overview', 'account/overview', 'fa fa-home', 'tab', '', '/src/views/frontend/user/account/overview.vue', 0, 'none', '', 99, 1, 1769497215, 1769497215);
INSERT INTO `ba_user_rule` VALUES (3, 1, 'menu', '个人资料', 'account/profile', 'account/profile', 'fa fa-user-circle-o', 'tab', '', '/src/views/frontend/user/account/profile.vue', 0, 'none', '', 98, 1, 1769497215, 1769497215);
INSERT INTO `ba_user_rule` VALUES (4, 1, 'menu', '修改密码', 'account/changePassword', 'account/changePassword', 'fa fa-shield', 'tab', '', '/src/views/frontend/user/account/changePassword.vue', 0, 'none', '', 97, 1, 1769497215, 1769497215);
INSERT INTO `ba_user_rule` VALUES (5, 1, 'menu', '积分记录', 'account/integral', 'account/integral', 'fa fa-tag', 'tab', '', '/src/views/frontend/user/account/integral.vue', 0, 'none', '', 96, 1, 1769497215, 1769497215);
INSERT INTO `ba_user_rule` VALUES (6, 1, 'menu', '余额记录', 'account/balance', 'account/balance', 'fa fa-money', 'tab', '', '/src/views/frontend/user/account/balance.vue', 0, 'none', '', 95, 1, 1769497215, 1769497215);

-- ----------------------------
-- Table structure for ba_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `ba_user_score_log`;
CREATE TABLE `ba_user_score_log`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `score` int(11) NOT NULL DEFAULT 0 COMMENT '变更积分',
  `before` int(11) NOT NULL DEFAULT 0 COMMENT '变更前积分',
  `after` int(11) NOT NULL DEFAULT 0 COMMENT '变更后积分',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint(16) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '会员积分变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ba_user_score_log
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
