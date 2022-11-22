/*
 Navicat Premium Data Transfer

 Source Server         : 8.141.150.151
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : 8.141.150.151:3306
 Source Schema         : oa_project

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 22/11/2022 17:17:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '客户表主键',
  `customer_enterprise_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司名称',
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `customer_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系方式',
  `customer_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮寄地址',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '桂林骏泰科技信息有限公司', '李哥', '15077777777', '广西桂林', '2022-11-16 17:19:08', '张三', '2022-11-20 16:57:33', NULL);
INSERT INTO `customer` VALUES (2, '国信蓝桥', '刘哥', '15065423589', '北京', '2022-11-16 17:19:38', '张三', '2022-11-20 16:57:34', '超管');

-- ----------------------------
-- Table structure for logistics_contract
-- ----------------------------
DROP TABLE IF EXISTS `logistics_contract`;
CREATE TABLE `logistics_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '物流单合同编号（运输合同编号）',
  `sale_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '销售单合同编号',
  `total_weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '物流合同总重量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货物单位',
  `freight` decimal(18, 2) NULL DEFAULT NULL COMMENT '运费',
  `contract_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '物流合同照片',
  `logistics_contract_time` datetime(0) NULL DEFAULT NULL COMMENT '物流单合同签订时间',
  `squeeze_season` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '榨季',
  `pigeonhole` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '归档  1显示  0隐藏',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_unique`(`logistics_contract_no`) USING BTREE COMMENT '保证物流合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_contract
-- ----------------------------
INSERT INTO `logistics_contract` VALUES (13, 'WL00001', 'XS00001', 20.00, '吨', 1000.00, 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', '2022-11-14 16:00:00', '1月', '1', '2022-11-16 17:35:50', '李四', '2022-11-18 13:45:18', NULL);
INSERT INTO `logistics_contract` VALUES (14, 'WL00002', 'XS00002', 10.00, '吨', 1000.00, 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', '2022-11-16 16:00:00', '2月', '1', '2022-11-17 12:34:28', '李四', '2022-11-18 13:45:20', NULL);
INSERT INTO `logistics_contract` VALUES (15, 'WL00003', 'XS00003', 1.00, '吨', 500.00, 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', '2022-11-16 16:00:00', '5月', '1', '2022-11-17 12:54:43', '李四', '2022-11-18 13:45:21', NULL);
INSERT INTO `logistics_contract` VALUES (21, 'WL0004', 'XS00003', 10.00, '吨', 1000.00, 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', '2022-11-16 16:00:00', 'DASDAS', '1', '2022-11-17 16:44:39', '李四', '2022-11-18 13:45:22', NULL);
INSERT INTO `logistics_contract` VALUES (22, 'WL00005', 'XS00002', 30.00, '吨', 10000.00, '', '2022-11-17 16:00:00', '5月', '1', '2022-11-18 22:57:19', '李四', '2022-11-18 22:57:19', NULL);

-- ----------------------------
-- Table structure for logistics_detail
-- ----------------------------
DROP TABLE IF EXISTS `logistics_detail`;
CREATE TABLE `logistics_detail`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id  自增',
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流单合同编号（运输合同编号）',
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '采购合同编号',
  `goods_factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取货厂名',
  `outbound_time` datetime(0) NULL DEFAULT NULL COMMENT '出库日期',
  `license_plate_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '车牌号',
  `goods_weight` decimal(18, 2) NULL DEFAULT NULL COMMENT '载货量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货物单位',
  `unloading_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卸货地点',
  `unit_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '运输单价',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_detail
-- ----------------------------
INSERT INTO `logistics_detail` VALUES (5, 'WL00001', 'CG00002', 'A厂', '2022-11-15 16:00:00', '桂C1111', 10.00, '吨', '湾仔码头', 10.00, '2022-11-16 17:35:50', '', '2022-11-16 17:35:50', NULL);
INSERT INTO `logistics_detail` VALUES (6, 'WL00001', 'CG00002', 'C厂', '2022-11-15 16:00:00', '桂C2222', 10.00, '吨', '湾仔码头', 10.00, '2022-11-16 17:35:50', '', '2022-11-16 17:35:50', NULL);
INSERT INTO `logistics_detail` VALUES (7, 'WL00002', 'CG00002', 'A厂', '2022-11-09 16:00:00', '桂C3333', 10.00, '吨', '湾仔码头', 100.00, '2022-11-17 12:34:29', '', '2022-11-17 12:34:29', NULL);
INSERT INTO `logistics_detail` VALUES (8, 'WL00003', 'CG00003', 'A厂', '2022-11-16 16:00:00', '桂C00123', 1.00, '吨', '陵川县', 500.00, '2022-11-17 12:54:43', '', '2022-11-17 12:54:43', NULL);
INSERT INTO `logistics_detail` VALUES (12, 'WL0004', 'CG00004', 'D厂', '2022-11-16 16:00:00', '桂C45620', 10.00, '吨', '北京', 1000.00, '2022-11-17 16:44:39', '', '2022-11-17 16:44:39', NULL);
INSERT INTO `logistics_detail` VALUES (13, 'WL00005', 'CG00002', 'A厂', '2022-11-17 16:00:00', '桂C5550', 10.00, '吨', '湾仔码头', 10.00, '2022-11-18 22:57:20', '', '2022-11-18 22:57:20', NULL);
INSERT INTO `logistics_detail` VALUES (14, 'WL00005', 'CG00002', 'A厂', '2022-11-17 16:00:00', '桂C6660', 10.00, '吨', '湾仔码头', 10.00, '2022-11-18 22:57:20', '', '2022-11-18 22:57:20', NULL);
INSERT INTO `logistics_detail` VALUES (15, 'WL00005', 'CG00002', 'C厂', '2022-11-17 16:00:00', '桂C8888', 10.00, '吨', '湾仔码头', 10.00, '2022-11-18 22:57:20', '', '2022-11-18 22:57:20', NULL);

-- ----------------------------
-- Table structure for logistics_director_state
-- ----------------------------
DROP TABLE IF EXISTS `logistics_director_state`;
CREATE TABLE `logistics_director_state`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `logistics_payment_contract_id` int(0) NULL DEFAULT NULL COMMENT '采购付款单ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '董事会用户ID',
  `state` int(0) NULL DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_director_state
-- ----------------------------
INSERT INTO `logistics_director_state` VALUES (1, 1, 5, NULL, '2022-11-16 19:55:40', NULL, '2022-11-16 19:55:40', NULL);
INSERT INTO `logistics_director_state` VALUES (2, 1, 4, NULL, '2022-11-16 19:55:40', NULL, '2022-11-16 19:55:40', NULL);
INSERT INTO `logistics_director_state` VALUES (3, 1, 3, NULL, '2022-11-16 19:55:40', NULL, '2022-11-16 19:55:40', NULL);
INSERT INTO `logistics_director_state` VALUES (4, 2, 5, NULL, '2022-11-17 12:37:21', NULL, '2022-11-17 12:37:21', NULL);
INSERT INTO `logistics_director_state` VALUES (5, 2, 4, NULL, '2022-11-17 12:37:22', NULL, '2022-11-17 12:37:22', NULL);
INSERT INTO `logistics_director_state` VALUES (6, 2, 3, NULL, '2022-11-17 12:37:22', NULL, '2022-11-17 12:37:22', NULL);
INSERT INTO `logistics_director_state` VALUES (7, 3, 5, NULL, '2022-11-17 14:03:33', NULL, '2022-11-17 14:03:33', NULL);
INSERT INTO `logistics_director_state` VALUES (8, 3, 4, NULL, '2022-11-17 14:03:33', NULL, '2022-11-17 14:03:33', NULL);
INSERT INTO `logistics_director_state` VALUES (9, 3, 3, NULL, '2022-11-17 14:03:33', NULL, '2022-11-17 14:03:33', NULL);

-- ----------------------------
-- Table structure for logistics_payment_contract
-- ----------------------------
DROP TABLE IF EXISTS `logistics_payment_contract`;
CREATE TABLE `logistics_payment_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '物流付款单ID',
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流单合同编号',
  `cashier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出纳名称',
  `payment_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '本次付款金额',
  `payment_time` date NULL DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '付款流水截图',
  `finance_staff` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '财务名称',
  `finance_state` int(0) NULL DEFAULT NULL COMMENT '财务审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_payment_contract
-- ----------------------------
INSERT INTO `logistics_payment_contract` VALUES (1, 'WL00001', NULL, 1000.00, '2022-11-16', NULL, NULL, NULL, '2022-11-16 19:55:40', NULL, '2022-11-16 19:57:54', NULL);
INSERT INTO `logistics_payment_contract` VALUES (2, 'WL00002', NULL, 500.00, '2022-11-17', NULL, NULL, NULL, '2022-11-17 12:37:21', NULL, '2022-11-17 12:38:30', NULL);
INSERT INTO `logistics_payment_contract` VALUES (3, 'WL00003', NULL, 500.00, NULL, NULL, NULL, NULL, '2022-11-17 14:03:33', NULL, '2022-11-17 14:03:33', NULL);

-- ----------------------------
-- Table structure for office_director_state
-- ----------------------------
DROP TABLE IF EXISTS `office_director_state`;
CREATE TABLE `office_director_state`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `office_expense_id` int(0) NULL DEFAULT NULL COMMENT '办公经费单ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '董事会用户ID',
  `state` int(0) NULL DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of office_director_state
-- ----------------------------
INSERT INTO `office_director_state` VALUES (16, 3, 5, 1, '2022-11-19 17:03:53', NULL, '2022-11-19 18:43:48', NULL);
INSERT INTO `office_director_state` VALUES (17, 3, 4, 1, '2022-11-19 17:03:53', NULL, '2022-11-19 18:43:49', NULL);
INSERT INTO `office_director_state` VALUES (18, 3, 3, 1, '2022-11-19 17:03:53', NULL, '2022-11-19 18:43:50', NULL);
INSERT INTO `office_director_state` VALUES (19, 4, 5, 1, '2022-11-19 17:04:07', NULL, '2022-11-19 18:43:52', NULL);
INSERT INTO `office_director_state` VALUES (20, 4, 4, 1, '2022-11-19 17:04:07', NULL, '2022-11-19 18:43:53', NULL);
INSERT INTO `office_director_state` VALUES (21, 4, 3, 1, '2022-11-19 17:04:07', NULL, '2022-11-19 18:43:55', NULL);

-- ----------------------------
-- Table structure for office_expense
-- ----------------------------
DROP TABLE IF EXISTS `office_expense`;
CREATE TABLE `office_expense`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '办公经费单ID',
  `items_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '支出项目清单',
  `expenses` decimal(18, 2) NULL DEFAULT NULL COMMENT '支出金额总计',
  `time` date NULL DEFAULT NULL COMMENT '日期',
  `finance_staff` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '财务名称',
  `finance_state` int(0) NULL DEFAULT NULL COMMENT '财务审核状态',
  `cashier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出纳名称',
  `payment_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '付款金额',
  `payment_time` date NULL DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '付款流水截图',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of office_expense
-- ----------------------------
INSERT INTO `office_expense` VALUES (3, '笔墨纸砚', 1000.00, '2022-11-19', '王五', 1, NULL, NULL, NULL, NULL, '2022-11-19 17:03:53', '', '2022-11-19 17:49:47', NULL);
INSERT INTO `office_expense` VALUES (4, '乒乓球', 50.00, '2022-11-15', '李四', 1, '', 50.00, '2022-11-19', 'http://localhost:9000/static/images/7a9bae30cae14a21b03744ad72f98c58.jpg', '2022-11-19 17:04:07', '', '2022-11-19 19:01:48', NULL);

-- ----------------------------
-- Table structure for other_in_out
-- ----------------------------
DROP TABLE IF EXISTS `other_in_out`;
CREATE TABLE `other_in_out`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '外商仓库出入库流水ID',
  `other_warehouse_id` int(0) NULL DEFAULT NULL COMMENT '外商仓库ID',
  `in_out_type` int(0) NULL DEFAULT NULL COMMENT '出入库类型（出库0，入库1）',
  `in_out_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '采购合同编号/物流单合同编号',
  `in_out_goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出入库货物名称',
  `in_out_goods_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '出入库货物数量',
  `in_out_goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出入库货物单位',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of other_in_out
-- ----------------------------
INSERT INTO `other_in_out` VALUES (50, 36, 1, 'CG00001', '白糖', 100.00, '吨', '2022-11-16 17:21:17', NULL, '2022-11-16 17:21:17', NULL);
INSERT INTO `other_in_out` VALUES (51, 37, 1, 'CG00001', '白糖', 100.00, '吨', '2022-11-16 17:21:18', NULL, '2022-11-16 17:21:18', NULL);
INSERT INTO `other_in_out` VALUES (52, 38, 1, 'CG00002', '白菜', 150.00, '吨', '2022-11-16 17:22:59', NULL, '2022-11-16 17:22:59', NULL);
INSERT INTO `other_in_out` VALUES (53, 39, 1, 'CG00002', '白菜', 50.00, '吨', '2022-11-16 17:22:59', NULL, '2022-11-16 17:22:59', NULL);
INSERT INTO `other_in_out` VALUES (54, 38, 0, 'XS00001', '白菜', 10.00, '吨', '2022-11-16 17:35:50', NULL, '2022-11-16 17:35:50', NULL);
INSERT INTO `other_in_out` VALUES (55, 39, 0, 'XS00001', '白菜', 10.00, '吨', '2022-11-16 17:35:51', NULL, '2022-11-16 17:35:51', NULL);
INSERT INTO `other_in_out` VALUES (56, 36, 1, 'CG00003', '白糖', 50.00, '吨', '2022-11-17 11:52:49', NULL, '2022-11-17 11:52:49', NULL);
INSERT INTO `other_in_out` VALUES (57, 40, 1, 'CG00003', '白糖', 50.00, '吨', '2022-11-17 11:52:49', NULL, '2022-11-17 11:52:49', NULL);
INSERT INTO `other_in_out` VALUES (58, 40, 1, 'CG00004', '白糖', 10.00, '吨', '2022-11-17 11:54:02', NULL, '2022-11-17 11:54:02', NULL);
INSERT INTO `other_in_out` VALUES (59, 38, 0, 'XS00002', '白菜', 10.00, '吨', '2022-11-17 12:34:29', NULL, '2022-11-17 12:34:29', NULL);
INSERT INTO `other_in_out` VALUES (60, 36, 0, 'XS00003', '白糖', 1.00, '吨', '2022-11-17 12:54:43', NULL, '2022-11-17 12:54:43', NULL);
INSERT INTO `other_in_out` VALUES (64, 40, 0, 'WL0004', '白糖', 10.00, '吨', '2022-11-17 16:44:39', NULL, '2022-11-17 16:44:39', NULL);
INSERT INTO `other_in_out` VALUES (65, 38, 0, 'WL00005', '白菜', 10.00, '吨', '2022-11-18 22:57:20', NULL, '2022-11-18 22:57:20', NULL);
INSERT INTO `other_in_out` VALUES (66, 38, 0, 'WL00005', '白菜', 10.00, '吨', '2022-11-18 22:57:21', NULL, '2022-11-18 22:57:21', NULL);
INSERT INTO `other_in_out` VALUES (67, 39, 0, 'WL00005', '白菜', 10.00, '吨', '2022-11-18 22:57:21', NULL, '2022-11-18 22:57:21', NULL);
INSERT INTO `other_in_out` VALUES (68, 41, 1, 'CG00005', '橘子', 50.00, '吨', '2022-11-22 14:51:35', NULL, '2022-11-22 14:51:35', NULL);
INSERT INTO `other_in_out` VALUES (69, 42, 1, 'CG00006', '西瓜', 10.00, '吨', '2022-11-22 14:58:18', NULL, '2022-11-22 14:58:18', NULL);
INSERT INTO `other_in_out` VALUES (70, 43, 1, 'CG00007', '榴莲', 50.00, '斤', '2022-11-22 15:37:20', 'xiexiaodong', '2022-11-22 15:37:20', 'xiexiaodong');

-- ----------------------------
-- Table structure for other_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `other_warehouse`;
CREATE TABLE `other_warehouse`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '外商仓库ID',
  `factory_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '厂名',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储货物名称',
  `goods_count` decimal(18, 6) NULL DEFAULT NULL COMMENT '存储货物库存量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '斤' COMMENT '存储货物单位  斤',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of other_warehouse
-- ----------------------------
INSERT INTO `other_warehouse` VALUES (36, 'A厂', '白糖', 298000.000000, '斤', '2022-11-16 17:21:17', NULL, '2022-11-16 17:21:17', NULL);
INSERT INTO `other_warehouse` VALUES (37, 'B厂', '白糖', 200000.000000, '斤', '2022-11-16 17:21:17', NULL, '2022-11-16 17:21:17', NULL);
INSERT INTO `other_warehouse` VALUES (38, 'A厂', '白菜', 220000.000000, '斤', '2022-11-16 17:22:59', NULL, '2022-11-16 17:22:59', NULL);
INSERT INTO `other_warehouse` VALUES (39, 'C厂', '白菜', 60000.000000, '斤', '2022-11-16 17:22:59', NULL, '2022-11-16 17:22:59', NULL);
INSERT INTO `other_warehouse` VALUES (40, 'D厂', '白糖', 60000.000000, '斤', '2022-11-17 11:52:49', NULL, '2022-11-17 11:52:49', NULL);
INSERT INTO `other_warehouse` VALUES (41, 'F厂', '橘子', 100000.000000, '斤', '2022-11-22 14:51:35', NULL, '2022-11-22 14:51:35', NULL);
INSERT INTO `other_warehouse` VALUES (42, 'G厂', '西瓜', 20000.000000, '斤', '2022-11-22 14:58:17', NULL, '2022-11-22 14:58:17', NULL);
INSERT INTO `other_warehouse` VALUES (43, 'H厂', '榴莲', 50.000000, '斤', '2022-11-22 15:37:20', 'xiexiaodong', '2022-11-22 15:37:20', 'xiexiaodong');

-- ----------------------------
-- Table structure for own_in_out
-- ----------------------------
DROP TABLE IF EXISTS `own_in_out`;
CREATE TABLE `own_in_out`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自家仓库出入库流水ID',
  `in_out_type` int(0) NULL DEFAULT NULL COMMENT '出入库类型（出库0，入库1）',
  `in_out_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '采购合同编号/物流单合同编号',
  `in_out_goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出入库货物名称',
  `in_out_goods_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '出入库货物数量',
  `in_out_goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出入库货物单位',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of own_in_out
-- ----------------------------
INSERT INTO `own_in_out` VALUES (17, 0, '222', '白糖', 10.00, '吨', '2022-11-21 18:41:09', NULL, '2022-11-22 14:14:58', NULL);
INSERT INTO `own_in_out` VALUES (18, 1, '11', '白菜', 10.00, '斤', '2022-11-21 22:20:27', NULL, '2022-11-21 22:20:27', NULL);
INSERT INTO `own_in_out` VALUES (19, 2, '333', '白糖', 50.00, '吨', '2022-11-22 14:14:55', NULL, '2022-11-22 14:14:55', NULL);

-- ----------------------------
-- Table structure for own_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `own_warehouse`;
CREATE TABLE `own_warehouse`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '自家仓库ID',
  `factory_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '自家仓库' COMMENT '厂名',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储货物名称',
  `goods_count` decimal(24, 6) NULL DEFAULT NULL COMMENT '存储货物库存量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '斤' COMMENT '存储货物单位   斤',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of own_warehouse
-- ----------------------------
INSERT INTO `own_warehouse` VALUES (12, '自家仓库', '白糖', 1.000000, '斤', '2022-11-17 16:15:41', NULL, '2022-11-20 22:12:01', NULL);
INSERT INTO `own_warehouse` VALUES (13, '自家仓库', '白菜', 2.000000, '斤', '2022-11-21 22:21:00', NULL, '2022-11-21 22:21:00', NULL);

-- ----------------------------
-- Table structure for purchase_contract
-- ----------------------------
DROP TABLE IF EXISTS `purchase_contract`;
CREATE TABLE `purchase_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '采购合同编号',
  `supplier_no` int(0) NULL DEFAULT NULL COMMENT '供货商ID（客户表ID）',
  `own_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '己方公司名',
  `squeeze_season` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '榨季',
  `inbound_time` date NULL DEFAULT NULL COMMENT '入库时间（合同实际签订时间）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '采购货物名称',
  `goods_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '采购货物数量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '采购货物单位',
  `goods_unit_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '采购货物单价',
  `payment_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '采购总金额',
  `unpaid_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '未结清金额',
  `contract_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '采购合同照片',
  `pigeonhole` int(0) NULL DEFAULT 1 COMMENT '归档 0表示隐藏  1表示显示',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `purchase_unique`(`purchase_contract_no`) USING BTREE COMMENT '保证采购合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_contract
-- ----------------------------
INSERT INTO `purchase_contract` VALUES (57, 'CG00001', 1, '广西南宁锦泰行工贸有限公司', '1月', '2022-11-16', '白糖', 200.00, '吨', 0.50, 200000.00, 200000.00, 'http://localhost:9000/static/images/fa3de4b8c1f94082ac0f86638bc8442c.jpg', 1, '2022-11-16 17:21:18', '', '2022-11-16 17:21:18', NULL);
INSERT INTO `purchase_contract` VALUES (58, 'CG00002', 2, '广西永湘物流有限公司', '2月', '2022-11-14', '白菜', 200.00, '吨', 0.50, 200000.00, 200000.00, 'http://localhost:9000/static/images/f936cd6ed61e423ca9f617ea9559bf1d.jpg,http://localhost:9000/static/images/ce7eaad52a8d47ea84ef6f7247bee078.jpg', 1, '2022-11-16 17:22:59', '', '2022-11-17 12:01:32', NULL);
INSERT INTO `purchase_contract` VALUES (59, 'CG00003', 1, '广西永湘物流有限公司', '3月', '2022-11-17', '白糖', 100.00, '吨', 0.60, 120000.00, 120000.00, 'http://localhost:9000/static/images/d531e32e280645cdaa7b060449fb3454.jpg', 1, '2022-11-17 11:52:49', '', '2022-11-17 11:52:49', NULL);
INSERT INTO `purchase_contract` VALUES (60, 'CG00004', 2, '广西丰沣顺国际物流有限公司', '4月', '2022-11-15', '白糖', 10.00, '吨', 0.55, 11000.00, 11000.00, 'http://localhost:9000/static/images/25761e697f7044c69b2ce0022d08084d.jpg', 1, '2022-11-17 11:54:02', '', '2022-11-17 12:01:36', NULL);
INSERT INTO `purchase_contract` VALUES (61, 'CG00005', 1, '广西丰沣顺国际物流有限公司', '5月', '2022-11-22', '橘子', 50.00, '吨', 0.01, 60000.00, 60000.00, 'http://localhost:9000/static/images/052d36adddbc4820b4c5ed198ae79001.jpg', 1, '2022-11-22 14:51:35', '超管', '2022-11-22 14:51:35', NULL);
INSERT INTO `purchase_contract` VALUES (62, 'CG00006', 1, '广西永湘物流有限公司', '1的撒', '2022-11-22', '西瓜', 10.00, '吨', 0.01, 6000.00, 6000.00, 'http://localhost:9000/static/images/b47b0d614d7343c4902e48d6a16ef549.jpg,http://localhost:9000/static/images/943e5f3aef75402e87d9e26486c8fb1a.jpg', 1, '2022-11-22 14:58:18', '超管', '2022-11-22 14:58:18', NULL);
INSERT INTO `purchase_contract` VALUES (63, 'CG00007', 1, '广西南宁锦泰行工贸有限公司', '6月', '2022-11-15', '榴莲', 50.00, '斤', 20.00, 9000.00, 9000.00, 'http://localhost:9000/static/images/c8a77cd62bb7406cad24874a745e6d01.jpg', 1, '2022-11-22 15:37:20', 'xiexiaodong', '2022-11-22 15:39:21', 'xiexiaodong');

-- ----------------------------
-- Table structure for purchase_director_state
-- ----------------------------
DROP TABLE IF EXISTS `purchase_director_state`;
CREATE TABLE `purchase_director_state`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `purchase_payment_contract_id` int(0) NULL DEFAULT NULL COMMENT '采购付款单ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '董事会用户ID',
  `state` int(0) NULL DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_director_state
-- ----------------------------
INSERT INTO `purchase_director_state` VALUES (1, 2, 5, NULL, '2022-11-16 19:40:04', NULL, '2022-11-16 19:40:04', NULL);
INSERT INTO `purchase_director_state` VALUES (2, 2, 4, NULL, '2022-11-16 19:40:04', NULL, '2022-11-16 19:40:04', NULL);
INSERT INTO `purchase_director_state` VALUES (3, 2, 3, NULL, '2022-11-16 19:40:05', NULL, '2022-11-16 19:40:05', NULL);
INSERT INTO `purchase_director_state` VALUES (4, 3, 5, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 19:41:42', NULL);
INSERT INTO `purchase_director_state` VALUES (5, 3, 4, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 19:41:42', NULL);
INSERT INTO `purchase_director_state` VALUES (6, 3, 3, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 19:41:42', NULL);
INSERT INTO `purchase_director_state` VALUES (7, 4, 5, NULL, '2022-11-17 12:15:26', NULL, '2022-11-19 17:52:49', NULL);
INSERT INTO `purchase_director_state` VALUES (8, 4, 4, NULL, '2022-11-17 12:15:26', NULL, '2022-11-19 17:52:59', NULL);
INSERT INTO `purchase_director_state` VALUES (9, 4, 3, NULL, '2022-11-17 12:15:26', NULL, '2022-11-19 17:52:59', NULL);
INSERT INTO `purchase_director_state` VALUES (10, 5, 5, NULL, '2022-11-21 12:21:28', NULL, '2022-11-21 12:21:28', NULL);
INSERT INTO `purchase_director_state` VALUES (11, 5, 4, NULL, '2022-11-21 12:21:28', NULL, '2022-11-21 12:21:28', NULL);
INSERT INTO `purchase_director_state` VALUES (12, 5, 3, NULL, '2022-11-21 12:21:28', NULL, '2022-11-21 12:21:28', NULL);

-- ----------------------------
-- Table structure for purchase_payment_contract
-- ----------------------------
DROP TABLE IF EXISTS `purchase_payment_contract`;
CREATE TABLE `purchase_payment_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '采购付款单ID',
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '销售单合同编号',
  `cashier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出纳名称',
  `payment_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '本次付款金额',
  `payment_time` date NULL DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '付款流水截图',
  `finance_staff` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '财务名称',
  `finance_state` int(0) NULL DEFAULT NULL COMMENT '财务审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_payment_contract
-- ----------------------------
INSERT INTO `purchase_payment_contract` VALUES (2, 'CG00001', NULL, 100000.00, NULL, NULL, NULL, NULL, '2022-11-16 19:40:04', NULL, '2022-11-20 18:21:53', NULL);
INSERT INTO `purchase_payment_contract` VALUES (3, 'CG00002', NULL, 100000.00, NULL, NULL, NULL, NULL, '2022-11-16 19:41:42', NULL, '2022-11-20 18:21:53', NULL);
INSERT INTO `purchase_payment_contract` VALUES (4, 'CG00003', NULL, 50000.00, NULL, NULL, '王五', 1, '2022-11-17 12:15:26', NULL, '2022-11-20 18:21:53', NULL);
INSERT INTO `purchase_payment_contract` VALUES (5, 'CG00003', NULL, 50000.00, NULL, NULL, NULL, NULL, '2022-11-21 12:21:28', '超管', '2022-11-21 12:21:28', NULL);

-- ----------------------------
-- Table structure for sale_contract
-- ----------------------------
DROP TABLE IF EXISTS `sale_contract`;
CREATE TABLE `sale_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `sale_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '销售单合同编号',
  `sale_customer_id` int(0) NULL DEFAULT NULL COMMENT '客户表id',
  `own_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '己方公司名',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '销售货物名称',
  `goods_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '销售货物数量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '销售货物单位',
  `goods_unit_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '销售货物单价',
  `goods_total_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '销售合同总价钱',
  `sale_contract_time` date NULL DEFAULT NULL COMMENT '销售合同时间',
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '结款方式',
  `transport_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运输方式',
  `contract_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '销售合同照片',
  `revenue_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '收款金额',
  `revenue_time` date NULL DEFAULT NULL COMMENT '收款时间',
  `revenue_photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收款流水截图',
  `revenue_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出纳操作人姓名',
  `pigeonhole` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '归档  0表示隐藏  1表示显示',
  `squeeze_season` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '榨季  ',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sale_unique`(`sale_contract_no`) USING BTREE COMMENT '保证销售合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sale_contract
-- ----------------------------
INSERT INTO `sale_contract` VALUES (19, 'XS00001', 1, '广西南宁锦泰行工贸有限公司', '白菜', 100.00, '吨', 1.00, 400000.00, '2022-11-13', '出厂净重结算', '陆运', 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', 400000.00, '2022-11-16', 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', '', '1', '1月', '2022-11-16 17:30:33', '张三', '2022-11-17 20:34:48', NULL);
INSERT INTO `sale_contract` VALUES (20, 'XS00002', 2, '广西永湘物流有限公司', '白菜', 30.00, '吨', 2.00, 50000.00, '2022-11-09', '出厂净重结算', '海运：港到港', 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', 1000.00, '2022-04-19', 'http://localhost:9000/static/images/ebbbbfde0581465184cc530f89fb9ac2.jpg', '出纳人员姓名', '1', '2月', '2022-11-16 21:48:51', '张三', '2022-11-18 15:45:29', NULL);
INSERT INTO `sale_contract` VALUES (22, 'XS00003', 2, '广西永湘物流有限公司', '白糖', 100.00, '吨', 1.00, 1000.00, '2022-11-08', '出厂净重结算', '陆运', 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', 18000.00, '2022-11-09', 'http://localhost:9000/static/images/355ebf06b5a44b669a775eeb2b226209.jpg', '出纳人员姓名', '1', '5月', '2022-11-17 12:41:57', '张三', '2022-11-17 20:26:35', NULL);

-- ----------------------------
-- Table structure for shipping_contract
-- ----------------------------
DROP TABLE IF EXISTS `shipping_contract`;
CREATE TABLE `shipping_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `shipping_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '海运单合同编号',
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流单合同编号',
  `principal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '委托方',
  `packing_time` datetime(0) NULL DEFAULT NULL COMMENT '装箱日期',
  `packing_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '装箱地点',
  `unpacking_factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卸箱工厂',
  `container_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '集装箱号',
  `seal_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '铅封号',
  `tally_clerk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '理货员',
  `tally_clerk_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '理货费用',
  `departure_fleet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '起运承运车队',
  `departure_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '起运承运车队费用',
  `carrier_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '承运船公司',
  `carrier_company_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '承运船公司费用',
  `destination_port_fleet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目的港承运车队',
  `destination_port_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '目的港承运车队费用',
  `expenses` decimal(18, 2) NULL DEFAULT NULL COMMENT '总费用',
  `contract_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '合同照片',
  `finance_staff` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '财务名称',
  `finance_state` int(0) NULL DEFAULT NULL COMMENT '财务审核状态',
  `cashier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出纳名称',
  `payment_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '付款金额',
  `payment_time` date NULL DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '付款流水截图',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `shipping_unique`(`shipping_contract_no`) USING BTREE COMMENT '保证海运合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping_contract
-- ----------------------------
INSERT INTO `shipping_contract` VALUES (7, 'HY00001', 'WL00001', '顺丰', '2022-11-16 00:00:00', '湾仔码头', '珍珠港', 'JZX00001', 'QF00001', '张三', 100.00, '新南车队', 1000.00, '东方海外', 4000.00, '老北车队', 1000.00, 6100.00, 'http://localhost:9000/static/images/6a75499791544492904e307d4048cfa6.jpg', '王五', 1, '', 6100.00, '2022-11-19', 'http://localhost:9000/static/images/23540aebb2494bb0b5276ff42992297e.jpg', '2022-11-16 18:31:29', NULL, '2022-11-19 18:42:47', NULL);
INSERT INTO `shipping_contract` VALUES (8, 'HY00002', 'WL00002', '韵达', '2022-11-17 00:00:00', '湾仔码头', '青螺湾', 'JZX00002', 'QF00002', '王五', 500.00, '新南车队', 1000.00, '东方海外', 5000.00, '老北车队', 1000.00, 7500.00, NULL, NULL, NULL, NULL, NULL, '2022-11-17', NULL, '2022-11-17 12:46:18', NULL, '2022-11-17 12:52:44', NULL);

-- ----------------------------
-- Table structure for shipping_director_state
-- ----------------------------
DROP TABLE IF EXISTS `shipping_director_state`;
CREATE TABLE `shipping_director_state`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `shipping_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '海运单合同编号',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '董事会用户ID',
  `state` int(0) NULL DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping_director_state
-- ----------------------------
INSERT INTO `shipping_director_state` VALUES (1, 'HY00001', 5, 1, '2022-11-16 18:31:30', NULL, '2022-11-20 17:40:31', NULL);
INSERT INTO `shipping_director_state` VALUES (2, 'HY00001', 4, 1, '2022-11-16 18:31:30', NULL, '2022-11-20 17:40:32', NULL);
INSERT INTO `shipping_director_state` VALUES (3, 'HY00001', 3, 1, '2022-11-16 18:31:30', NULL, '2022-11-20 17:41:59', NULL);
INSERT INTO `shipping_director_state` VALUES (4, 'HY00002', 5, 1, '2022-11-17 12:46:18', NULL, '2022-11-19 18:32:25', NULL);
INSERT INTO `shipping_director_state` VALUES (5, 'HY00002', 4, 1, '2022-11-17 12:46:18', NULL, '2022-11-19 18:32:26', NULL);
INSERT INTO `shipping_director_state` VALUES (6, 'HY00002', 3, 1, '2022-11-17 12:46:18', NULL, '2022-11-19 18:32:28', NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `time` bigint(0) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 777, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (2, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 134, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (3, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 86, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (4, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 187, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (5, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findTree()', '\"admin\"', 171, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (6, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 41, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (7, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 147, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (8, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (name = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":...', 53, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (9, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 52, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (10, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":\"i...', 46, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (11, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 194, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (12, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 127, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (13, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 178, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (14, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 85, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (15, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 166, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (16, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 204, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (17, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 94, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (18, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 168, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (19, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 141, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (20, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.list()', '{\"customSqlSegment\":\" ORDER BY order_num ASC\",\"emptyOfEntity\":true,\"emptyOfNormal\":true,\"emptyOfWhere\":true,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[],\"orderBy\":[{\"sqlSegment\":\"order_num ASC\"}...', 73, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (21, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 153, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (22, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 120, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (23, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 140, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (24, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 97, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (25, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.list()', '{\"customSqlSegment\":\" ORDER BY order_num ASC\",\"emptyOfEntity\":true,\"emptyOfNormal\":true,\"emptyOfWhere\":true,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[],\"orderBy\":[{\"sqlSegment\":\"order_num ASC\"}...', 108, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (26, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 98, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (27, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 164, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (28, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 87, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (29, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 140, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (30, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 127, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (31, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 181, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (32, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 144, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (33, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.updateById()', '{\"id\":1,\"lastUpdateTime\":1669096902127,\"name\":\"超级管理员\",\"remark\":\"超级管理员\"}', 131, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (34, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 88, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (35, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 148, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (36, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.list()', NULL, 93, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (37, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 106, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (38, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 116, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (39, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 170, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (40, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 77, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (41, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.updateById()', '{\"id\":5,\"lastUpdateTime\":1669096915375,\"name\":\"董事会\",\"remark\":\"董事会\"}', 145, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (42, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 138, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (43, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.updateById()', '{\"id\":6,\"lastUpdateTime\":1669096923633,\"name\":\"出纳\",\"remark\":\"出纳\"}', 157, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (44, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 181, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (45, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.updateById()', '{\"id\":7,\"lastUpdateTime\":1669096927663,\"name\":\"采购员\",\"remark\":\"采购员\"}', 175, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (46, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 182, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (47, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.updateById()', '{\"id\":8,\"lastUpdateTime\":1669096930903,\"name\":\"销售员\",\"remark\":\"销售员\"}', 157, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (48, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 130, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (49, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.updateById()', '{\"id\":9,\"lastUpdateTime\":1669096934277,\"name\":\"财务\",\"remark\":\"财务\"}', 154, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (50, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 169, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (51, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 141, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (52, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.list()', NULL, 121, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (53, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 125, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (54, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 81, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (55, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 146, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (56, NULL, NULL, 'cn.edu.guet.service.Impl.OwnWarehouseServiceImpl.getOwnWarehouseData()', '1', 152, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (57, NULL, NULL, 'cn.edu.guet.service.Impl.OwnInOutServiceImpl.getOwnInOutData()', '\"白糖\"', 104, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (58, NULL, NULL, 'cn.edu.guet.service.Impl.OwnInOutServiceImpl.getOwnInOutData()', '\"白糖\"', 44, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (59, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 92, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (60, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 141, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (61, NULL, NULL, 'cn.edu.guet.service.Impl.OwnWarehouseServiceImpl.getOwnWarehouseData()', '1', 176, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (62, NULL, NULL, 'cn.edu.guet.service.Impl.OwnInOutServiceImpl.getOwnInOutData()', '\"白糖\"', 112, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (63, NULL, NULL, 'cn.edu.guet.service.Impl.OwnInOutServiceImpl.getOwnInOutData()', '\"白糖\"', 57, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (64, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.getCustomerData()', '1', 148, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (65, NULL, NULL, 'cn.edu.guet.service.Impl.LogisticsPaymentContractServiceImpl.getLogisticsPaymentContractData()', '1', 271, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (66, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 151, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (67, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 259, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (68, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 106, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (69, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 153, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (70, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 96, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (71, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.list()', '{\"customSqlSegment\":\" ORDER BY order_num ASC\",\"emptyOfEntity\":true,\"emptyOfNormal\":true,\"emptyOfWhere\":true,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[],\"orderBy\":[{\"sqlSegment\":\"order_num ASC\"}...', 120, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (72, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 122, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (73, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 103, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (74, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 164, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (75, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00004\"', 153, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (76, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 88, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (77, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 143, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (78, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 121, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (79, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 169, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (80, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 145, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (81, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 194, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (82, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 1117, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (83, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 1277, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (84, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 98, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (85, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 157, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (86, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 68, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (87, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 193, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (88, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 164, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (89, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 206, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (90, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 709, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (91, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 794, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (92, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.addNewPurchaseContract()', '{\"contractPhoto\":\"http://localhost:9000/static/images/052d36adddbc4820b4c5ed198ae79001.jpg\",\"contractPhotoArray\":[\"http://localhost:9000/static/images/052d36adddbc4820b4c5ed198ae79001.jpg\"],\"createBy\"...', 430, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (93, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 141, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (94, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 561, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (95, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 739, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (96, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 178, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (97, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 120, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (98, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 85, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (99, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 181, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (100, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findTree()', '\"admin\"', 104, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (101, NULL, NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 49, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (102, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 205, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (103, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (name = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":...', 60, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (104, NULL, NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 64, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (105, NULL, NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":\"i...', 76, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (106, NULL, NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 105, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (107, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 155, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (108, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.addNewPurchaseContract()', '{\"contractPhoto\":\"http://localhost:9000/static/images/b47b0d614d7343c4902e48d6a16ef549.jpg,http://localhost:9000/static/images/943e5f3aef75402e87d9e26486c8fb1a.jpg\",\"contractPhotoArray\":[\"http://local...', 366, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (109, NULL, NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 117, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (110, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 778, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (111, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 144, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (112, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 70, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (113, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 161, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (114, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findTree()', '\"admin\"', 70, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (115, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 88, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (116, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 246, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (117, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (name = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":...', 79, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (118, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 50, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (119, 'admin', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":\"i...', 50, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (120, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"xiexiaodong\"', 183, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (121, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"xiexiaodong\"', 159, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (122, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"xiexiaodong\"', 48, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (123, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"xiexiaodong\"', 153, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (124, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findTree()', '\"xiexiaodong\"', 65, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (125, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"xiexiaodong\"', 97, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (126, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"xiexiaodong\"', 177, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (127, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (name = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":...', 57, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (128, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 39, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (129, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":\"i...', 86, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (130, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 110, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (131, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 209, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (132, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.addNewPurchaseContract()', '{\"contractPhoto\":\"http://localhost:9000/static/images/c8a77cd62bb7406cad24874a745e6d01.jpg\",\"contractPhotoArray\":[\"http://localhost:9000/static/images/c8a77cd62bb7406cad24874a745e6d01.jpg\"],\"createBy\"...', 320, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (133, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 112, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (134, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 747, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (135, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findByName()', '\"admin\"', 130, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (136, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 67, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (137, 'xiexiaodong', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 169, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (138, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findTree()', '\"admin\"', 57, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (139, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.findByUser()', '\"admin\"', 47, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (140, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.findPermissions()', '\"admin\"', 130, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (141, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (name = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":...', 65, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (142, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (user_id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegmen...', 69, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (143, 'admin', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getOne()', '{\"customSqlSegment\":\"WHERE (id = #{ew.paramNameValuePairs.MPGENVAL1})\",\"emptyOfEntity\":true,\"emptyOfNormal\":false,\"emptyOfWhere\":false,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[{\"sqlSegment\":\"i...', 58, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (144, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 193, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (145, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 92, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (146, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 164, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (147, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00007\"', 141, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (148, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00006\"', 120, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (149, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00004\"', 164, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (150, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getCashierPurchasePayment()', '1', 208, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (151, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 94, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (152, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 185, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (153, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 239, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (154, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getCashierPurchasePayment()', '1', 187, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (155, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 754, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (156, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 355, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (157, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getPurchasePaymentContractData()', '1', 329, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (158, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 337, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (159, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 131, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (160, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 298, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (161, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getPurchasePaymentContractData()', '1', 421, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (162, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getCashierPurchasePayment()', '1', 179, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (163, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 247, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (164, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 342, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (165, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 272, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (166, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 308, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (167, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsPaymentContractServiceImpl.getCashierLogisticsPayment()', '1', 139, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (168, 'admin', NULL, 'cn.edu.guet.service.Impl.OfficeExpenseServiceImpl.getCashierOfficeExpense()', '1', 307, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (169, 'admin', NULL, 'cn.edu.guet.service.Impl.OwnWarehouseServiceImpl.getOwnWarehouseData()', '1', 272, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (170, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 305, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (171, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 5712, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (172, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL0004\"', 6032, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (173, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00003\"', 7587, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (174, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00002\"', 8165, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (175, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL0004\"', 1278, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (176, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00002\"', 549, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (177, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00002\"', 498, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (178, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00002\"', 60, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (179, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00002\"', 63, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (180, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getDetailLogistics()', '\"WL00002\"', 118, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (181, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsContractServiceImpl.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 10350, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (182, 'admin', NULL, 'cn.edu.guet.service.Impl.ShippingContractServiceImpl.getshippingContractData()', '1', 10486, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (183, 'admin', NULL, 'cn.edu.guet.service.Impl.OfficeExpenseServiceImpl.getOfficeExpenseData()', '1', 261, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (184, 'admin', NULL, 'cn.edu.guet.service.Impl.AnalysisDataServiceImpl.getGoodsNameData()', NULL, 194, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (185, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getPurchasePaymentContractData()', '1', 310, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (186, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsPaymentContractServiceImpl.getLogisticsPaymentContractData()', '1', 6774, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (187, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getPurchasePaymentContractData()', '1', 516, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (188, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsPaymentContractServiceImpl.getLogisticsPaymentContractData()', '1', 326, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (189, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.getCustomerData()', '1', 119, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (190, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsPaymentContractServiceImpl.getLogisticsPaymentContractData()', '1', 277, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (191, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getPurchasePaymentContractData()', '1', 708, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (192, 'admin', NULL, 'cn.edu.guet.service.Impl.SaleContractServiceImpl.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 271, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (193, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchasePaymentContractServiceImpl.getPurchasePaymentContractData()', '1', 431, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (194, 'admin', NULL, 'cn.edu.guet.service.Impl.LogisticsPaymentContractServiceImpl.getLogisticsPaymentContractData()', '1', 427, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (195, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.getCustomerData()', '1', 5207, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (196, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 3224, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (197, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.getCustomerData()', '1', 11229, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (198, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.updateCustomer()', '{\"createBy\":\"张三\",\"customerAddress\":\"北京\",\"customerEnterpriseName\":\"国信蓝桥\",\"customerName\":\"刘哥\",\"customerPhone\":\"15065423589\",\"id\":2,\"lastUpdateBy\":\"超管\"}', 625, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (199, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.getCustomerData()', '1', 167, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (200, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.getCustomerData()', '1', 20293, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (201, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 985, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (202, 'admin', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 245, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (203, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 363, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (204, 'admin', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 121, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (205, 'admin', NULL, 'cn.edu.guet.service.Impl.SysUserServiceImpl.getList()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 147, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (206, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.getAllMenu()', NULL, 5537, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (207, 'admin', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 7516, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (208, 'admin', NULL, 'cn.edu.guet.service.Impl.SysMenuServiceImpl.list()', '{\"customSqlSegment\":\" ORDER BY order_num ASC\",\"emptyOfEntity\":true,\"emptyOfNormal\":true,\"emptyOfWhere\":true,\"expression\":{\"groupBy\":[],\"having\":[],\"normal\":[],\"orderBy\":[{\"sqlSegment\":\"order_num ASC\"}...', 6865, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (209, 'admin', NULL, 'cn.edu.guet.service.Impl.SysRoleServiceImpl.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 3005, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (210, 'admin', NULL, 'cn.edu.guet.service.Impl.CustomerServiceImpl.list()', NULL, 200, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (211, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractViewServiceImpl.getTPurchaseContractData()', '1', 297, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (212, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00007\"', 1002, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (213, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00004\"', 163, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (214, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00006\"', 155, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (215, 'admin', NULL, 'cn.edu.guet.service.Impl.PurchaseContractServiceImpl.getPurchaseDetail()', '\"CG00007\"', 123, '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `parent_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级菜单名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL,类型：1.普通页面（如用户管理， /sys/user） 2.嵌套完整外部页面，以http(s)开头的链接 3.嵌套服务器页面，使用iframe:前缀+目标URL(如SQL监控， iframe:/druid/login.html, iframe:前缀会替换成服务器地址)',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：sys:user:add,sys:user:edit)',
  `type` int(0) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(0) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, '顶级菜单', '/system', NULL, 0, 'Setting', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (2, '员工管理', 1, '系统管理', '/userList', NULL, 1, 'User', 1, NULL, NULL, NULL, '2022-11-20 15:20:04', 0);
INSERT INTO `sys_menu` VALUES (3, '查看', 2, '用户管理', NULL, 'sys:user:view', 2, NULL, 0, NULL, NULL, NULL, '2022-08-03 03:48:15', 0);
INSERT INTO `sys_menu` VALUES (4, '新增', 2, '用户管理', NULL, 'sys:user:add', 2, NULL, 1, NULL, NULL, NULL, '2022-08-03 03:33:09', 0);
INSERT INTO `sys_menu` VALUES (5, '修改', 2, '用户管理', NULL, 'sys:user:edit', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (6, '删除', 2, '用户管理', '', 'sys:user:delete', 2, '', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (7, '角色管理', 1, '系统管理', '/roleList', NULL, 1, 'Avatar', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (8, '查看', 7, '角色管理', NULL, 'sys:role:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (9, '新增', 7, '角色管理', NULL, 'sys:role:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (10, '修改', 7, '角色管理', NULL, 'sys:role:edit', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (11, '删除', 7, '角色管理', NULL, 'sys:role:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (12, '菜单管理', 1, '系统管理', '/menuList', NULL, 1, 'Menu', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (13, '查看', 12, '菜单管理', NULL, 'sys:menu:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (14, '新增', 12, '菜单管理', NULL, 'sys:menu:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (15, '修改', 12, '菜单管理', NULL, 'sys:menu:edit', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (16, '删除', 12, '菜单管理', NULL, 'sys:menu:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (17, '采购单', 0, '顶级菜单', '/purchaseContract', NULL, 1, 'ShoppingCart', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (73, '查看', 17, '采购单', NULL, 'sys:purchaseContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (75, '新增', 17, '采购单', NULL, 'sys:purchaseContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (76, '归档', 17, '采购单', NULL, 'sys:purchaseContract:hole', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (77, '删除', 17, '采购单', NULL, 'sys:purchaseContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (78, '付款', 17, '采购单', NULL, 'sys:purchaseContract:pay', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (79, '出纳', 0, '顶级菜单', '/cashier', NULL, 0, 'Money', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (80, '采购付款单', 79, '出纳', '/cashier/cashierPurchasePayment', NULL, 1, 'Money', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (81, '出纳销售单', 79, '出纳', '/cashier/cashierSale', NULL, 1, 'Money', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (82, '查看', 81, '出纳销售单', NULL, 'sys:cashierSale:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (83, '上传', 81, '出纳销售单', NULL, 'sys:cashierSale:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (84, '物流付款单', 79, '出纳', '/cashier/cashierLogisticsPayment', NULL, 1, 'Money', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (85, '出纳海运单', 79, '出纳', '/cashier/cashierShipping', NULL, 1, 'Money', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (86, '查看', 85, '出纳海运单', NULL, 'sys:cashierShipping:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (87, '上传', 85, '出纳海运单', NULL, 'sys:cashierShipping:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (88, '办公经费', 79, '出纳', '/cashier/cashierOfficeExpense', NULL, 1, 'Money', 5, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (89, '查看', 88, '办公经费', NULL, 'sys:cashierOfficeExpense:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (90, '上传', 88, '办公经费', NULL, 'sys:cashierOfficeExpense:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (91, '仓库管理', 0, '顶级菜单', '/warehouseManagement', NULL, 1, 'Discount', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (92, '销售单', 0, '顶级菜单', '/saleContract', NULL, 1, 'Document', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (93, '查看', 92, '销售单', NULL, 'sys:saleContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (94, '新增', 92, '销售单', NULL, 'sys:saleContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (95, '归档', 92, '销售单', NULL, 'sys:saleContract:hole', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (96, '删除', 92, '销售单', NULL, 'sys:saleContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (97, '出库信息', 0, '顶级菜单', '/outbound', NULL, 0, 'Shop', 5, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (98, '出库物流单', 97, '出库信息', '/outbound/outboundLogisticsList', NULL, 1, 'Bicycle', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (99, '查看', 98, '出库物流单', NULL, 'sys:outboundLogisticsList:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (100, '新增', 98, '出库物流单', NULL, 'sys:outboundLogisticsList:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (101, '归档', 98, '出库物流单', NULL, 'sys:outboundLogisticsList:hole', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (102, '删除', 98, '出库物流单', NULL, 'sys:outboundLogisticsList:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (103, '出库海运单', 97, '出库信息', '/outbound/outboundShippingList', NULL, 1, 'Ship', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (104, '查看', 103, '出库海运单', NULL, 'sys:outboundShippingList:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (105, '新增', 103, '出库海运单', NULL, 'sys:outboundShippingList:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (106, '归档', 103, '出库海运单', NULL, 'sys:outboundShippingList:hole', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (107, '删除', 103, '出库海运单', NULL, 'sys:outboundShippingList:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (108, '财务管理', 0, '顶级菜单', '/finance', NULL, 0, 'Coin', 6, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (109, '报表分析', 108, '财务管理', '/finance/reportAnalysis', NULL, 1, 'TrendCharts', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (110, '办公经费', 108, '财务管理', '/finance/officeExpense', NULL, 1, 'TrendCharts', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (111, '查看', 110, '办公经费', NULL, 'sys:officeExpense:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (112, '新增', 110, '办公经费', NULL, 'sys:officeExpense:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (113, '删除', 110, '办公经费', NULL, 'sys:officeExpense:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (114, '单价走势', 108, '财务管理', '/finance/priceTrend', NULL, 1, 'TrendCharts', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (115, '采购付款单', 0, '顶级菜单', '/purchasePaymentContract', NULL, 1, 'Document', 7, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (116, '查看', 115, '采购付款单', NULL, 'sys:purchasePaymentContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (117, '新增', 115, '采购付款单', NULL, 'sys:purchasePaymentContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (118, '删除', 115, '采购付款单', NULL, 'sys:purchasePaymentContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (119, '物流付款单', 0, '顶级菜单', '/logisticsPaymentContract', NULL, 1, 'Document', 8, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (120, '查看', 119, '物流付款单', NULL, 'sys:logisticsPaymentContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (121, '新增', 119, '物流付款单', NULL, 'sys:logisticsPaymentContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (122, '删除', 119, '物流付款单', NULL, 'sys:logisticsPaymentContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (123, '客户管理', 0, '顶级菜单', '/customerList', NULL, 1, 'User', 9, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (124, '查看', 123, '客户管理', NULL, 'sys:customerList:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (125, '新增', 123, '客户管理', NULL, 'sys:customerList:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (126, '删除', 123, '客户管理', NULL, 'sys:customerList:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (127, '首页', 0, '顶级菜单', '/dashboard', NULL, 1, 'house', -1, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员', 'admin', '2019-01-19 11:11:11', 'admin', '2022-11-22 06:01:42', 0);
INSERT INTO `sys_role` VALUES (5, '董事会', '董事会', 'admin', NULL, NULL, '2022-11-22 06:01:55', 0);
INSERT INTO `sys_role` VALUES (6, '出纳', '出纳', NULL, '2022-11-20 08:02:08', NULL, '2022-11-22 06:02:04', 0);
INSERT INTO `sys_role` VALUES (7, '采购员', '采购员', NULL, '2022-11-20 08:02:48', NULL, '2022-11-22 06:02:08', 0);
INSERT INTO `sys_role` VALUES (8, '销售员', '销售员', NULL, '2022-11-20 08:04:10', NULL, '2022-11-22 06:02:11', 0);
INSERT INTO `sys_role` VALUES (9, '财务', '财务', NULL, '2022-11-20 08:05:02', NULL, '2022-11-22 06:02:14', 0);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `role_id` bigint(0) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NULL DEFAULT NULL COMMENT '菜单ID',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 972 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (803, 1, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (804, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (805, 1, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (806, 1, 3, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (807, 1, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (808, 1, 4, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (809, 1, 6, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (810, 1, 7, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (811, 1, 8, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (812, 1, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (813, 1, 10, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (814, 1, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (815, 1, 12, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (816, 1, 13, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (817, 1, 14, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (818, 1, 15, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (819, 1, 16, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (820, 1, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (821, 1, 73, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (822, 1, 75, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (823, 1, 76, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (824, 1, 77, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (825, 1, 78, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (826, 1, 79, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (827, 1, 80, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (828, 1, 81, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (829, 1, 84, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (830, 1, 85, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (831, 1, 88, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (832, 1, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (833, 1, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (834, 1, 94, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (835, 1, 93, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (836, 1, 95, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (837, 1, 96, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (838, 1, 97, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (839, 1, 98, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (840, 1, 103, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (841, 1, 108, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (842, 1, 109, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (843, 1, 110, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (844, 1, 113, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (845, 1, 112, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (846, 1, 111, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (847, 1, 114, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (848, 1, 115, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (849, 1, 117, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (850, 1, 116, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (851, 1, 118, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (852, 1, 119, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (853, 1, 122, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (854, 1, 121, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (855, 1, 120, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (856, 1, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (857, 1, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (858, 1, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (859, 1, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (860, 5, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (861, 5, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (862, 5, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (863, 5, 3, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (864, 5, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (865, 5, 4, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (866, 5, 6, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (867, 5, 7, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (868, 5, 8, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (869, 5, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (870, 5, 10, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (871, 5, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (872, 5, 12, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (873, 5, 13, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (874, 5, 14, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (875, 5, 15, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (876, 5, 16, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (877, 5, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (878, 5, 73, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (879, 5, 76, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (880, 5, 78, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (881, 5, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (882, 5, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (883, 5, 93, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (884, 5, 95, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (885, 5, 97, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (886, 5, 98, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (887, 5, 99, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (888, 5, 101, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (889, 5, 103, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (890, 5, 106, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (891, 5, 104, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (892, 5, 108, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (893, 5, 109, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (894, 5, 110, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (895, 5, 113, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (896, 5, 112, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (897, 5, 111, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (898, 5, 114, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (899, 5, 115, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (900, 5, 117, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (901, 5, 116, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (902, 5, 118, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (903, 5, 119, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (904, 5, 122, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (905, 5, 121, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (906, 5, 120, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (907, 5, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (908, 5, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (909, 5, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (910, 5, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (911, 6, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (912, 6, 79, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (913, 6, 80, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (914, 6, 81, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (915, 6, 82, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (916, 6, 83, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (917, 6, 84, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (918, 6, 85, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (919, 6, 86, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (920, 6, 87, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (921, 6, 88, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (922, 6, 89, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (923, 6, 90, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (924, 6, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (925, 6, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (926, 6, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (927, 6, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (950, 7, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (951, 7, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (952, 7, 73, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (953, 7, 75, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (954, 7, 76, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (955, 7, 77, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (956, 7, 78, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (957, 7, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (958, 7, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (959, 7, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (960, 7, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (961, 8, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (962, 8, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (963, 8, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (964, 8, 94, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (965, 8, 93, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (966, 8, 95, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (967, 8, 96, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (968, 8, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (969, 8, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (970, 8, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (971, 8, 124, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `age` int(0) NULL DEFAULT NULL COMMENT '年龄',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `identity` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `home_address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `onboarding_time` date NULL DEFAULT NULL COMMENT '入职时间',
  `departure_time` date NULL DEFAULT NULL COMMENT '离职时间',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐',
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态   在职/离职',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '超管', 21, '18076757556', '452402200004090930', '广西桂林', '2022-11-17', NULL, '25a8f5416ef8a4c72d68e07170010030', '53caae756e414182914a', '在职', 'admin', '2021-08-13 18:11:11', 'admin', '2022-11-19 14:09:42');
INSERT INTO `sys_user` VALUES (3, 'huangjaisen', '黄佳森', 50, '15555555555', '000000000000000000', '广西南宁', '2022-11-19', NULL, '25a8f5416ef8a4c72d68e07170010030', '53caae756e414182914a', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (4, 'xiexiaodong', '谢晓东', 50, '00000000000', '000000000000000000', '广西南宁', '2022-11-12', NULL, '31735eaa63e572eca5be029eb0e57310', 'b22850c877074c2abd0d', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (5, 'linguofeng', '林国丰', 50, '11111111111', '333333333333333333', '广西南宁', '2022-11-09', NULL, 'b1c5b3d735dbe4cdb44cef856ba5c958', 'ec032ec23df44d2ebe87', '在职', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(0) NULL DEFAULT NULL COMMENT '角色ID',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (108, 3, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (109, 4, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (110, 5, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (111, 1, 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- View structure for director
-- ----------------------------
DROP VIEW IF EXISTS `director`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `director` AS select `su`.`id` AS `id`,`su`.`nick_name` AS `nick_name` from `sys_user` `su` where `su`.`id` in (select `sur`.`user_id` from (`sys_user_role` `sur` join `sys_role` `sr`) where ((`sr`.`remark` = '董事会') and (`sur`.`role_id` = `sr`.`id`)));

-- ----------------------------
-- View structure for ffs_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `ffs_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ffs_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西丰沣顺国际物流有限公司'))))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西丰沣顺国际物流有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西丰沣顺国际物流有限公司'))))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西丰沣顺国际物流有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西丰沣顺国际物流有限公司'))))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西丰沣顺国际物流有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for inbound_detail_info
-- ----------------------------
DROP VIEW IF EXISTS `inbound_detail_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `inbound_detail_info` AS select `purchase_contract`.`purchase_contract_no` AS `purchase_contract_no`,`ware`.`factory_name` AS `factory_name`,`io`.`in_out_goods_name` AS `in_out_goods_name`,`io`.`in_out_goods_count` AS `in_out_goods_count`,`io`.`in_out_goods_unit` AS `goods_unit` from ((`other_in_out` `io` join `purchase_contract`) join `other_warehouse` `ware`) where ((`io`.`in_out_contract_no` = `purchase_contract`.`purchase_contract_no`) and (`io`.`in_out_type` = 1) and (`ware`.`goods_name` = `io`.`in_out_goods_name`) and (`io`.`other_warehouse_id` = `ware`.`id`)) union select `purchase_contract`.`purchase_contract_no` AS `purchase_contract_no`,`ware`.`factory_name` AS `factory_name`,`io`.`in_out_goods_name` AS `in_out_goods_name`,`io`.`in_out_goods_count` AS `in_out_goods_count`,`io`.`in_out_goods_unit` AS `in_out_goods_unit` from ((`own_in_out` `io` join `purchase_contract`) join `own_warehouse` `ware`) where ((`io`.`in_out_contract_no` = `purchase_contract`.`purchase_contract_no`) and (`io`.`in_out_type` = 1) and (`ware`.`goods_name` = `io`.`in_out_goods_name`));

-- ----------------------------
-- View structure for jt_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `jt_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `jt_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西南宁锦泰行工贸有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西南宁锦泰行工贸有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西南宁锦泰行工贸有限公司'))))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西南宁锦泰行工贸有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西南宁锦泰行工贸有限公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西南宁锦泰行工贸有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西南宁锦泰行工贸有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西南宁锦泰行工贸有限公司'))))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西南宁锦泰行工贸有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西南宁锦泰行工贸有限公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西南宁锦泰行工贸有限公司'))))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西南宁锦泰行工贸有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for logistics_payment_contract_info
-- ----------------------------
DROP VIEW IF EXISTS `logistics_payment_contract_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `logistics_payment_contract_info` AS select `lpc`.`id` AS `id`,`lpc`.`logistics_contract_no` AS `logistics_contract_no`,`lpc`.`payment_count` AS `payment_count`,`lpc`.`payment_time` AS `payment_time`,`lpc`.`payment_photo` AS `payment_photo`,`lpc`.`finance_staff` AS `finance_staff`,`lpc`.`finance_state` AS `finance_state`,`lpc`.`cashier` AS `cashier`,`lpc`.`create_time` AS `create_time`,`lpc`.`create_by` AS `create_by`,`lpc`.`last_update_time` AS `last_update_time`,`lpc`.`last_update_by` AS `last_update_by`,`lc`.`sale_contract_no` AS `sale_contract_no`,`lc`.`freight` AS `freight`,`lc`.`squeeze_season` AS `squeeze_season`,`lc`.`logistics_contract_time` AS `logistics_contract_time`,`sc`.`goods_name` AS `goods_name`,`lc`.`total_weight` AS `total_weight`,`lc`.`goods_unit` AS `goods_unit` from ((`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) join `sale_contract` `sc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`sc`.`sale_contract_no` = `lc`.`sale_contract_no`));

-- ----------------------------
-- View structure for logistics_payment_state_info
-- ----------------------------
DROP VIEW IF EXISTS `logistics_payment_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `logistics_payment_state_info` AS select `lds`.`id` AS `id`,`lds`.`logistics_payment_contract_id` AS `logistics_payment_contract_id`,`lds`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`lds`.`state` AS `state` from (`director` `d` join `logistics_director_state` `lds`) where (`d`.`id` = `lds`.`user_id`);

-- ----------------------------
-- View structure for office_state_info
-- ----------------------------
DROP VIEW IF EXISTS `office_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `office_state_info` AS select `ods`.`id` AS `id`,`ods`.`office_expense_id` AS `office_expense_id`,`ods`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`ods`.`state` AS `state` from (`director` `d` join `office_director_state` `ods`) where (`d`.`id` = `ods`.`user_id`);

-- ----------------------------
-- View structure for outbound_detail_info
-- ----------------------------
DROP VIEW IF EXISTS `outbound_detail_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `outbound_detail_info` AS select `p`.`purchase_contract_no` AS `purchase_contract_no`,`s`.`sale_contract_no` AS `sale_contract_no`,`ld`.`logistics_contract_no` AS `logistics_contract_no`,`s`.`goods_name` AS `goods_name`,`ld`.`goods_factory` AS `goods_factory`,`ld`.`license_plate_number` AS `license_plate_number`,`ld`.`goods_weight` AS `goods_weight`,`ld`.`goods_unit` AS `goods_unit`,`ld`.`outbound_time` AS `outbound_time`,`temp`.`total_weight` AS `total_weight` from ((((`purchase_contract` `p` join `logistics_detail` `ld`) join `sale_contract` `s`) join `logistics_contract` `l`) join (select `t`.`purchase_contract_no` AS `purchase_contract_no`,`t`.`sale_contract_no` AS `sale_contract_no`,`t`.`logistics_contract_no` AS `logistics_contract_no`,`t`.`goods_factory` AS `goods_factory`,sum(`t`.`goods_weight`) AS `total_weight` from (select `p`.`purchase_contract_no` AS `purchase_contract_no`,`s`.`sale_contract_no` AS `sale_contract_no`,`ld`.`logistics_contract_no` AS `logistics_contract_no`,`s`.`goods_name` AS `goods_name`,`ld`.`goods_factory` AS `goods_factory`,`ld`.`license_plate_number` AS `license_plate_number`,`ld`.`goods_weight` AS `goods_weight`,`ld`.`goods_unit` AS `goods_unit`,`ld`.`outbound_time` AS `outbound_time` from (((`purchase_contract` `p` join `logistics_detail` `ld`) join `sale_contract` `s`) join `logistics_contract` `l`) where ((`p`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`s`.`sale_contract_no` = `l`.`sale_contract_no`) and (`l`.`logistics_contract_no` = `ld`.`logistics_contract_no`))) `t` group by `t`.`purchase_contract_no`,`t`.`sale_contract_no`,`t`.`logistics_contract_no`,`t`.`goods_factory`) `temp`) where ((`p`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`s`.`sale_contract_no` = `l`.`sale_contract_no`) and (`l`.`logistics_contract_no` = `ld`.`logistics_contract_no`) and (`temp`.`goods_factory` = `ld`.`goods_factory`) and (`temp`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`temp`.`sale_contract_no` = `l`.`sale_contract_no`) and (`temp`.`logistics_contract_no` = `l`.`logistics_contract_no`));

-- ----------------------------
-- View structure for purchase_contract_info
-- ----------------------------
DROP VIEW IF EXISTS `purchase_contract_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `purchase_contract_info` AS select `p`.`id` AS `id`,`p`.`purchase_contract_no` AS `purchase_contract_no`,`c`.`customer_enterprise_name` AS `customer_enterprise_name`,`p`.`own_company_name` AS `own_company_name`,`p`.`squeeze_season` AS `squeeze_season`,`p`.`inbound_time` AS `inbound_time`,`p`.`goods_name` AS `goods_name`,`p`.`goods_count` AS `goods_count`,`p`.`goods_unit` AS `goods_unit`,`p`.`goods_unit_price` AS `goods_unit_price`,`p`.`payment_amount` AS `payment_amount`,`p`.`unpaid_amount` AS `unpaid_amount`,`p`.`contract_photo` AS `contract_photo`,`p`.`pigeonhole` AS `pigeonhole`,`p`.`create_time` AS `create_time`,`p`.`create_by` AS `create_by`,`p`.`last_update_time` AS `last_update_time`,`p`.`last_update_by` AS `last_update_by` from (`purchase_contract` `p` join `customer` `c`) where (`p`.`supplier_no` = `c`.`id`);

-- ----------------------------
-- View structure for purchase_payment_contract_info
-- ----------------------------
DROP VIEW IF EXISTS `purchase_payment_contract_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `purchase_payment_contract_info` AS select `ppc`.`id` AS `id`,`ppc`.`purchase_contract_no` AS `purchase_contract_no`,`ppc`.`payment_count` AS `payment_count`,`ppc`.`payment_time` AS `payment_time`,`ppc`.`payment_photo` AS `payment_photo`,`ppc`.`finance_staff` AS `finance_staff`,`ppc`.`finance_state` AS `finance_state`,`ppc`.`cashier` AS `cashier`,`ppc`.`create_time` AS `create_time`,`ppc`.`create_by` AS `create_by`,`ppc`.`last_update_time` AS `last_update_time`,`ppc`.`last_update_by` AS `last_update_by`,`pci`.`customer_enterprise_name` AS `customer_enterprise_name`,`pci`.`own_company_name` AS `own_company_name`,`pci`.`squeeze_season` AS `squeeze_season`,`pci`.`inbound_time` AS `inbound_time`,`pci`.`goods_name` AS `goods_name`,`pci`.`goods_count` AS `goods_count`,`pci`.`goods_unit` AS `goods_unit`,`pci`.`payment_amount` AS `payment_amount` from (`purchase_payment_contract` `ppc` join `purchase_contract_info` `pci`) where (`ppc`.`purchase_contract_no` = `pci`.`purchase_contract_no`);

-- ----------------------------
-- View structure for purchase_payment_state_info
-- ----------------------------
DROP VIEW IF EXISTS `purchase_payment_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `purchase_payment_state_info` AS select `pds`.`id` AS `id`,`pds`.`purchase_payment_contract_id` AS `purchase_payment_contract_id`,`pds`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`pds`.`state` AS `state` from (`director` `d` join `purchase_director_state` `pds`) where (`d`.`id` = `pds`.`user_id`);

-- ----------------------------
-- View structure for shipping_state_info
-- ----------------------------
DROP VIEW IF EXISTS `shipping_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `shipping_state_info` AS select `pds`.`id` AS `id`,`pds`.`shipping_contract_no` AS `shipping_contract_no`,`pds`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`pds`.`state` AS `state` from (`director` `d` join `shipping_director_state` `pds`) where (`d`.`id` = `pds`.`user_id`);

-- ----------------------------
-- View structure for total_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `total_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `total_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where (`sc`.`revenue_time` is not null) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `purchase_payment_contract`.`payment_time` AS `payment_time` from `purchase_payment_contract` where (`purchase_payment_contract`.`payment_time` is not null) group by `purchase_payment_contract`.`payment_time` union select `logistics_payment_contract`.`payment_time` AS `payment_time` from `logistics_payment_contract` where (`logistics_payment_contract`.`payment_time` is not null) group by `logistics_payment_contract`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where (`sc`.`revenue_time` is not null) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where (`sc`.`revenue_time` is not null) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `purchase_payment_contract`.`payment_time` AS `payment_time` from `purchase_payment_contract` where (`purchase_payment_contract`.`payment_time` is not null) group by `purchase_payment_contract`.`payment_time` union select `logistics_payment_contract`.`payment_time` AS `payment_time` from `logistics_payment_contract` where (`logistics_payment_contract`.`payment_time` is not null) group by `logistics_payment_contract`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`purchase_payment_contract`.`payment_count`) AS `out_amount`,`purchase_payment_contract`.`payment_time` AS `payment_time` from `purchase_payment_contract` where (`purchase_payment_contract`.`payment_time` is not null) group by `purchase_payment_contract`.`payment_time` union select sum(`logistics_payment_contract`.`payment_count`) AS `out_amount`,`logistics_payment_contract`.`payment_time` AS `payment_time` from `logistics_payment_contract` where (`logistics_payment_contract`.`payment_time` is not null) group by `logistics_payment_contract`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for yx_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `yx_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `yx_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西永湘物流有限公司'))))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西永湘物流有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘物流有限公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西永湘物流有限公司'))))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西永湘物流有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西永湘物流有限公司'))))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from (`shipping_contract` `sc` join `logistics_contract` `lc`) where ((`sc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and `lc`.`sale_contract_no` in (select `sale_contract`.`sale_contract_no` from `sale_contract` where (`sale_contract`.`own_company_name` = '广西永湘物流有限公司'))))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

SET FOREIGN_KEY_CHECKS = 1;
