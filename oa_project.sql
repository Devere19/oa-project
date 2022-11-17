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

 Date: 17/11/2022 20:52:05
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '桂林骏泰科技信息有限公司', NULL, NULL, NULL, '2022-11-16 17:19:08', NULL, '2022-11-16 17:19:08', NULL);
INSERT INTO `customer` VALUES (2, '国信蓝桥', NULL, NULL, NULL, '2022-11-16 17:19:38', NULL, '2022-11-16 17:19:38', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_contract
-- ----------------------------
INSERT INTO `logistics_contract` VALUES (13, 'WL00001', 'XS00001', 20.00, '吨', 1000.00, 'http://localhost:9000/static/images/7bf08d56b11b4d26b1fd09de4b903173.jpg', '2022-11-14 16:00:00', '1月', '1', '2022-11-16 17:35:50', '李四', '2022-11-16 17:35:50', NULL);
INSERT INTO `logistics_contract` VALUES (14, 'WL00002', 'XS00002', 10.00, '吨', 1000.00, '', '2022-11-16 16:00:00', '2月', '1', '2022-11-17 12:34:28', '李四', '2022-11-17 12:34:28', NULL);
INSERT INTO `logistics_contract` VALUES (15, 'WL00003', 'XS00003', 1.00, '吨', 500.00, 'http://localhost:9000/static/images/da803eb41d0d4754882b76ef39fdb6c6.jpg', '2022-11-16 16:00:00', '5月', '1', '2022-11-17 12:54:43', '李四', '2022-11-17 12:54:43', NULL);
INSERT INTO `logistics_contract` VALUES (21, 'WL0004', 'XS00003', 10.00, '吨', 1000.00, 'http://localhost:9000/static/images/ddd1d5c2909049a88ab231d33a370bd2.jpg', '2022-11-16 16:00:00', 'DASDAS', '1', '2022-11-17 16:44:39', '李四', '2022-11-17 16:44:39', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_detail
-- ----------------------------
INSERT INTO `logistics_detail` VALUES (5, 'WL00001', 'CG00002', 'A厂', '2022-11-15 16:00:00', '桂C1111', 10.00, '吨', '湾仔码头', 10.00, '2022-11-16 17:35:50', '', '2022-11-16 17:35:50', NULL);
INSERT INTO `logistics_detail` VALUES (6, 'WL00001', 'CG00002', 'C厂', '2022-11-15 16:00:00', '桂C2222', 10.00, '吨', '湾仔码头', 10.00, '2022-11-16 17:35:50', '', '2022-11-16 17:35:50', NULL);
INSERT INTO `logistics_detail` VALUES (7, 'WL00002', 'CG00002', 'A厂', '2022-11-09 16:00:00', '桂C3333', 10.00, '吨', '湾仔码头', 100.00, '2022-11-17 12:34:29', '', '2022-11-17 12:34:29', NULL);
INSERT INTO `logistics_detail` VALUES (8, 'WL00003', 'CG00003', 'A厂', '2022-11-16 16:00:00', '桂C00123', 1.00, '吨', '陵川县', 500.00, '2022-11-17 12:54:43', '', '2022-11-17 12:54:43', NULL);
INSERT INTO `logistics_detail` VALUES (12, 'WL0004', 'CG00004', 'D厂', '2022-11-16 16:00:00', '桂C45620', 10.00, '吨', '北京', 1000.00, '2022-11-17 16:44:39', '', '2022-11-17 16:44:39', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `other_warehouse` VALUES (38, 'A厂', '白菜', 260000.000000, '斤', '2022-11-16 17:22:59', NULL, '2022-11-16 17:22:59', NULL);
INSERT INTO `other_warehouse` VALUES (39, 'C厂', '白菜', 80000.000000, '斤', '2022-11-16 17:22:59', NULL, '2022-11-16 17:22:59', NULL);
INSERT INTO `other_warehouse` VALUES (40, 'D厂', '白糖', 60000.000000, '斤', '2022-11-17 11:52:49', NULL, '2022-11-17 11:52:49', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of own_in_out
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of own_warehouse
-- ----------------------------
INSERT INTO `own_warehouse` VALUES (12, '自家仓库', '白糖', 0.000000, '斤', '2022-11-17 16:15:41', NULL, '2022-11-17 16:15:41', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_director_state
-- ----------------------------
INSERT INTO `purchase_director_state` VALUES (1, 2, 5, NULL, '2022-11-16 19:40:04', NULL, '2022-11-16 19:40:04', NULL);
INSERT INTO `purchase_director_state` VALUES (2, 2, 4, NULL, '2022-11-16 19:40:04', NULL, '2022-11-16 19:40:04', NULL);
INSERT INTO `purchase_director_state` VALUES (3, 2, 3, NULL, '2022-11-16 19:40:05', NULL, '2022-11-16 19:40:05', NULL);
INSERT INTO `purchase_director_state` VALUES (4, 3, 5, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 19:41:42', NULL);
INSERT INTO `purchase_director_state` VALUES (5, 3, 4, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 19:41:42', NULL);
INSERT INTO `purchase_director_state` VALUES (6, 3, 3, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 19:41:42', NULL);
INSERT INTO `purchase_director_state` VALUES (7, 4, 5, NULL, '2022-11-17 12:15:26', NULL, '2022-11-17 12:15:26', NULL);
INSERT INTO `purchase_director_state` VALUES (8, 4, 4, NULL, '2022-11-17 12:15:26', NULL, '2022-11-17 12:15:26', NULL);
INSERT INTO `purchase_director_state` VALUES (9, 4, 3, NULL, '2022-11-17 12:15:26', NULL, '2022-11-17 12:15:26', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_payment_contract
-- ----------------------------
INSERT INTO `purchase_payment_contract` VALUES (2, 'CG00001', NULL, 100000.00, '2022-11-16', NULL, NULL, NULL, '2022-11-16 19:40:04', NULL, '2022-11-16 19:43:00', NULL);
INSERT INTO `purchase_payment_contract` VALUES (3, 'CG00002', NULL, 100000.00, '2022-11-15', NULL, NULL, NULL, '2022-11-16 19:41:42', NULL, '2022-11-16 20:05:12', NULL);
INSERT INTO `purchase_payment_contract` VALUES (4, 'CG00003', NULL, 50000.00, '2022-11-17', NULL, NULL, NULL, '2022-11-17 12:15:26', NULL, '2022-11-17 12:16:18', NULL);

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
INSERT INTO `sale_contract` VALUES (20, 'XS00002', 2, '广西永湘物流有限公司', '白菜', 30.00, '吨', 1000.00, 50000.00, '2022-11-11', '出厂净重结算', '海运：港到港', 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', 1000.00, '2022-11-08', 'http://localhost:9000/static/images/ebbbbfde0581465184cc530f89fb9ac2.jpg', '出纳人员姓名', '1', '2月', '2022-11-16 21:48:51', '张三', '2022-11-17 20:38:33', NULL);
INSERT INTO `sale_contract` VALUES (22, 'XS00003', 2, '广西永湘物流有限公司', '白糖', 100.00, '吨', 1.00, 1000.00, '2022-11-12', '出厂净重结算', '陆运', 'http://localhost:9000/static/images/d3267eda04344f999e7b7b97c5b7633a.jpg,http://localhost:9000/static/images/016f93c02de04b03b5bc071bbe85af2d.jpg', 18000.00, '2022-11-13', 'http://localhost:9000/static/images/355ebf06b5a44b669a775eeb2b226209.jpg', '出纳人员姓名', '1', '5月', '2022-11-17 12:41:57', '张三', '2022-11-17 20:26:35', NULL);

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
INSERT INTO `shipping_contract` VALUES (7, 'HY00001', 'WL00001', '顺丰', '2022-11-16 00:00:00', '湾仔码头', '珍珠港', 'JZX00001', 'QF00001', '张三', 100.00, '新南车队', 1000.00, '东方海外', 4000.00, '老北车队', 1000.00, 6100.00, 'http://localhost:9000/static/images/6a75499791544492904e307d4048cfa6.jpg', NULL, NULL, NULL, NULL, '2022-11-16', NULL, '2022-11-16 18:31:29', NULL, '2022-11-16 19:58:49', NULL);
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
INSERT INTO `shipping_director_state` VALUES (1, 'HY00001', 5, NULL, '2022-11-16 18:31:30', NULL, '2022-11-16 18:31:30', NULL);
INSERT INTO `shipping_director_state` VALUES (2, 'HY00001', 4, NULL, '2022-11-16 18:31:30', NULL, '2022-11-16 18:31:30', NULL);
INSERT INTO `shipping_director_state` VALUES (3, 'HY00001', 3, NULL, '2022-11-16 18:31:30', NULL, '2022-11-16 18:31:30', NULL);
INSERT INTO `shipping_director_state` VALUES (4, 'HY00002', 5, NULL, '2022-11-17 12:46:18', NULL, '2022-11-17 12:46:18', NULL);
INSERT INTO `shipping_director_state` VALUES (5, 'HY00002', 4, NULL, '2022-11-17 12:46:18', NULL, '2022-11-17 12:46:18', NULL);
INSERT INTO `shipping_director_state` VALUES (6, 'HY00002', 3, NULL, '2022-11-17 12:46:18', NULL, '2022-11-17 12:46:18', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, '顶级菜单', '/system', NULL, 0, 'Shop', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (2, '用户管理', 1, '系统管理', '/userList', NULL, 1, 'User', 1, NULL, NULL, NULL, '2022-08-03 03:32:03', 0);
INSERT INTO `sys_menu` VALUES (3, '查看', 2, '用户管理', NULL, 'sys:user:view', 2, NULL, 0, NULL, NULL, NULL, '2022-08-03 03:48:15', 0);
INSERT INTO `sys_menu` VALUES (4, '新增', 2, '用户管理', NULL, 'sys:user:add', 2, NULL, 1, NULL, NULL, NULL, '2022-08-03 03:33:09', 0);
INSERT INTO `sys_menu` VALUES (5, '修改', 2, '用户管理', NULL, 'sys:user:edit', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (6, '删除', 2, '用户管理', '', 'sys:user:delete', 2, '', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (7, '角色管理', 1, '系统管理', '/roleList', NULL, 1, 'Avatar', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (8, '查看', 7, '角色管理', NULL, 'sys:role:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (9, '新增', 7, '角色管理', NULL, 'sys:role:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (10, '修改', 7, '角色管理', NULL, 'sys:role:edit', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (11, '删除', 7, '角色管理', NULL, 'sys:role:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (12, '菜单管理', 1, '系统管理', '/menuList', NULL, 1, 'Menu', 53, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (13, '查看', 12, '菜单管理', NULL, 'sys:menu:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (14, '新增', 12, '菜单管理', NULL, 'sys:menu:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (15, '修改', 12, '菜单管理', NULL, 'sys:menu:edit', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (16, '删除', 12, '菜单管理', NULL, 'sys:menu:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (17, '订单管理', 0, '顶级菜单', '/shoppingCart', NULL, 1, 'ShoppingCart', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (18, '查看', 17, '订单管理', NULL, 'sys:shoppingCart:view', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (19, '新增', 17, '订单管理', NULL, 'sys:shoppingCart:add', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (20, '修改', 17, '订单管理', NULL, 'sys:shoppingCart:edit', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (21, '删除', 17, '订单管理', NULL, 'sys:shoppingCart:delete', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (22, '会员信息', 0, '顶级菜单', '/member', NULL, 1, 'Present', 6, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (23, '查看', 22, '会员信息', NULL, 'sys:member:view', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (24, '新增', 22, '会员信息', NULL, 'sys:member:add', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (25, '修改', 22, '会员信息', NULL, 'sys:member:edit', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (26, '删除', 22, '会员信息', NULL, 'sys:member:delete', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (27, '轮播图管理', 0, '顶级菜单', '/giftList', NULL, 1, 'GoodsFilled', 7, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (28, '查看', 27, '礼盒管理', NULL, 'sys:giftList:view', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (29, '新增', 27, '礼盒管理', NULL, 'sys:giftList:add', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (30, '修改', 27, '礼盒管理', NULL, 'sys:giftList:edit', 2, NULL, NULL, NULL, NULL, NULL, '2022-08-03 03:43:57', 0);
INSERT INTO `sys_menu` VALUES (31, '删除', 27, '礼盒管理', NULL, 'sys:giftList:delete', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (32, '商品管理', 0, '顶级菜单', '/goodsList', 'sys:goods', 1, 'Goods', 5, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (33, '查看', 32, '商品管理', '', 'sys:goods:view', 2, '', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (34, '新增', 32, '商品管理', '', 'sys:goods:add', 2, '', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (35, '修改', 32, '商品管理', '', 'sys:goods:edit', 2, '', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (36, '删除', 32, '商品管理', '', 'sys:goods:delete', 2, '', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (37, '销售分析', 0, '顶级菜单', '/trendCharts', 'sys:analysis', 1, 'TrendCharts', 8, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (38, '查看', 37, '销售分析', '', 'sys:analysis:view', 2, '', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (39, '新增', 37, '销售分析', '', 'sys:analysis:add', 2, '', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (40, '修改', 37, '销售分析', '', 'sys:analysis:edit', 2, '', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (41, '删除', 37, '销售分析', '', 'sys:analysis:delete', 2, '', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (71, '首页', 0, NULL, '/Index', NULL, 1, 'house', -1, NULL, NULL, NULL, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', '超级管理员', 'admin', '2019-01-19 11:11:11', 'admin', '2019-01-19 19:07:18', 0);
INSERT INTO `sys_role` VALUES (2, 'pm', '项目经理', 'admin', '2019-01-19 11:11:11', 'admin', '2019-01-19 11:39:28', 0);
INSERT INTO `sys_role` VALUES (3, 'dev', '开发人员', 'admin', '2019-01-19 11:11:11', 'admin', '2019-01-19 11:39:28', 0);
INSERT INTO `sys_role` VALUES (4, 'test', '测试人员', 'admin', '2019-01-19 11:11:11', 'admin', '2019-01-19 11:11:11', 0);
INSERT INTO `sys_role` VALUES (5, 'director', '董事会', 'admin', NULL, NULL, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 656 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (469, 2, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (470, 2, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (471, 2, 3, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (472, 2, 4, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (473, 2, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (474, 2, 6, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (480, 2, 7, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (481, 2, 8, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (482, 2, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (483, 2, 10, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (484, 2, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (485, 2, 12, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (486, 2, 13, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (487, 2, 14, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (488, 2, 15, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (489, 2, 16, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (490, 2, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (491, 2, 18, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (492, 2, 19, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (493, 2, 20, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (494, 2, 21, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (495, 2, 22, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (496, 2, 23, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (497, 2, 24, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (498, 2, 25, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (499, 2, 26, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (500, 2, 27, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (501, 2, 28, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (502, 2, 29, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (503, 2, 30, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (504, 2, 31, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (505, 2, 32, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (506, 2, 33, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (507, 2, 34, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (508, 2, 35, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (509, 2, 36, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (608, 4, 1, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (609, 4, 2, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (610, 4, 3, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (611, 4, 7, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (612, 4, 8, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (613, 4, 12, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (614, 4, 13, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (615, 4, 17, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (616, 4, 18, 'admin', '2019-01-22 14:46:44', NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (623, 2, 37, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (624, 2, 38, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (625, 2, 39, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (626, 2, 40, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (627, 2, 41, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (638, 4, 27, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (639, 4, 28, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (641, 4, 32, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (642, 4, 33, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (645, 2, 71, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (646, 4, 71, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (652, 3, 71, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (653, 3, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (654, 3, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (655, 3, 3, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '机构ID',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `last_update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `last_update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '超管', 'http://rfzhrumxc.hn-bkt.clouddn.com/QQ%E5%9B%BE%E7%89%8720220814131142.jpg', 'bd1718f058d8a02468134432b8656a86', 'YzcmCZNvbXocrsz9dm8e', 'liwei.bluesky@hotmail.com', '18076757556', 1, 1, 'admin', '2021-08-13 18:11:11', 'admin', '2021-08-13 18:11:11', 0);
INSERT INTO `sys_user` VALUES (2, 'liwei', '李伟', 'http://rfzhrumxc.hn-bkt.clouddn.com/QQ%E5%9B%BE%E7%89%8720220814131142.jpg', '727f76787b7a79cc5942ee7714579e3c', 'b3f2ded289524fe98b12', '7274561@qq.com', '13730550682', 1, 38, 'admin', '2021-08-13 19:43:00', 'admin', '2021-08-14 18:10:02', 0);
INSERT INTO `sys_user` VALUES (3, 'huangjiasen', '黄佳森', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (4, 'xiexiaodong', '谢晓东', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_user` VALUES (5, 'linguofeng', '林国丰', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (94, 2, 4, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (95, 3, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (96, 4, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (97, 5, 5, NULL, NULL, NULL, NULL);

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
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `inbound_detail_info` AS select `purchase_contract`.`purchase_contract_no` AS `purchase_contract_no`,`ware`.`factory_name` AS `factory_name`,`io`.`in_out_goods_name` AS `in_out_goods_name`,`io`.`in_out_goods_count` AS `in_out_goods_count`,`ware`.`goods_unit` AS `goods_unit` from ((`other_in_out` `io` join `purchase_contract`) join `other_warehouse` `ware`) where ((`io`.`in_out_contract_no` = `purchase_contract`.`purchase_contract_no`) and (`io`.`in_out_type` = 1) and (`ware`.`goods_name` = `io`.`in_out_goods_name`) and (`ware`.`goods_unit` = `io`.`in_out_goods_unit`) and (`io`.`other_warehouse_id` = `ware`.`id`)) union select `purchase_contract`.`purchase_contract_no` AS `purchase_contract_no`,`ware`.`factory_name` AS `factory_name`,`io`.`in_out_goods_name` AS `in_out_goods_name`,`io`.`in_out_goods_count` AS `in_out_goods_count`,`ware`.`goods_unit` AS `goods_unit` from ((`own_in_out` `io` join `purchase_contract`) join `own_warehouse` `ware`) where ((`io`.`in_out_contract_no` = `purchase_contract`.`purchase_contract_no`) and (`io`.`in_out_type` = 1) and (`ware`.`goods_name` = `io`.`in_out_goods_name`) and (`ware`.`goods_unit` = `io`.`in_out_goods_unit`));

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
-- View structure for outbound_detail_info
-- ----------------------------
DROP VIEW IF EXISTS `outbound_detail_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `outbound_detail_info` AS select `p`.`purchase_contract_no` AS `purchase_contract_no`,`s`.`sale_contract_no` AS `sale_contract_no`,`ld`.`logistics_contract_no` AS `logistics_contract_no`,`s`.`goods_name` AS `goods_name`,`ld`.`goods_factory` AS `goods_factory`,`ld`.`license_plate_number` AS `license_plate_number`,`ld`.`goods_weight` AS `goods_weight`,`ld`.`goods_unit` AS `goods_unit`,`ld`.`outbound_time` AS `outbound_time`,`temp`.`total_weight` AS `total_weight` from ((((`purchase_contract` `p` join `logistics_detail` `ld`) join `sale_contract` `s`) join `logistics_contract` `l`) join (select `ld`.`goods_factory` AS `goods_factory`,sum(`ld`.`goods_weight`) AS `total_weight` from (((`purchase_contract` `p` join `logistics_detail` `ld`) join `sale_contract` `s`) join `logistics_contract` `l`) where ((`p`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`s`.`sale_contract_no` = `l`.`sale_contract_no`) and (`l`.`logistics_contract_no` = `ld`.`logistics_contract_no`)) group by `ld`.`goods_factory`) `temp`) where ((`p`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`s`.`sale_contract_no` = `l`.`sale_contract_no`) and (`l`.`logistics_contract_no` = `ld`.`logistics_contract_no`) and (`temp`.`goods_factory` = `ld`.`goods_factory`));

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
