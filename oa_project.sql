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

 Date: 06/01/2023 23:17:15
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
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (17, '广西丰沣顺国际物流有限公司', '韩娜', '18176884685', '广西南宁市青秀区凤凰岭路1号', '2022-12-02 11:46:16', 'admin', '2022-12-02 11:46:16', 'admin');
INSERT INTO `customer` VALUES (18, '上林南华糖业有限责任公司', '汤受表（汤科长）', '13978653242', '上林县白圩镇五里桥5号（厂址）', '2022-12-02 11:49:26', 'admin', '2022-12-02 11:49:26', 'admin');
INSERT INTO `customer` VALUES (19, '广西江莱投资有限公司', '黄识先', '13152693427', '南宁市青秀区金湖路57号文德大厦南楼11层11C', '2022-12-02 11:59:10', 'admin', '2022-12-02 11:59:10', 'admin');
INSERT INTO `customer` VALUES (20, '广西永湘贸易有限责任公司', '韩娜', '18176884685', '广西南宁市青秀区凤凰岭路1号', '2022-12-02 12:13:15', 'admin', '2022-12-02 12:13:15', 'admin');
INSERT INTO `customer` VALUES (21, '江苏途富新材料有限公司', '周峰', '13512741422', '广州市黄埔区黄埔东路5号2411房，收件人：廖小姐收13750105013', '2023-01-06 11:37:48', '韩娜', '2023-01-06 11:37:48', '韩娜');
INSERT INTO `customer` VALUES (22, '广西广业贵糖糖业集团有限公司', '陈冬艳', '15977593553', '贵港高新区粤桂产业园幸福路1号，收件人：陈冬艳，电话：0775-4201668', '2023-01-06 11:39:58', '韩娜', '2023-01-06 11:39:58', '韩娜');
INSERT INTO `customer` VALUES (23, '湛江君实糖业有限公司', '郑然仁', '13590009019', '广东省雷州市纪家镇行沟桥', '2023-01-06 11:42:11', '韩娜', '2023-01-06 11:42:11', '韩娜');
INSERT INTO `customer` VALUES (24, '忻城南华糖业有限责任公司', '汤受表', '13978653242', '上林忻城糖厂', '2023-01-06 11:43:59', '韩娜', '2023-01-06 11:43:59', '韩娜');
INSERT INTO `customer` VALUES (25, '中粮崇左糖业有限公司', '林铎', '18978815692', '广西崇左市濑湍镇中粮崇左糖业有限公司，收件人蒋宏艳18777104191', '2023-01-06 11:57:49', '韩娜', '2023-01-06 11:57:49', '韩娜');
INSERT INTO `customer` VALUES (26, '中粮屯河北海糖业有限公司', '黄敏', '18877103048', '合同收件地址：广西北海市南康镇富康路166号中粮屯河北海糖业有限公司，收件人卢振萍13877990393', '2023-01-06 12:01:47', '韩娜', '2023-01-06 12:01:47', '韩娜');
INSERT INTO `customer` VALUES (27, '龙州南华糖业有限责任公司', '汤受表', '13978653242', '霞秀糖厂', '2023-01-06 12:04:48', '韩娜', '2023-01-06 12:04:48', '韩娜');
INSERT INTO `customer` VALUES (29, '广西隆安南华糖业有限责任公司', '汤受表', '13978653242', '南圩糖厂', '2023-01-06 12:41:38', '韩娜', '2023-01-06 12:41:38', '韩娜');
INSERT INTO `customer` VALUES (30, '广东富桥糖业有限公司', '钟燕', '18924406750', ' 广东省湛江市霞山区 开发区安平路8号凯胜汇华轩糖业集团2楼（喷水池玻璃门蓝框）', '2023-01-06 14:34:06', '韩娜', '2023-01-06 14:34:06', '韩娜');

-- ----------------------------
-- Table structure for logistics_contract
-- ----------------------------
DROP TABLE IF EXISTS `logistics_contract`;
CREATE TABLE `logistics_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '物流单合同编号（运输合同编号）',
  `sale_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '销售单/加工单合同编号',
  `own_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '己方公司名称',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货物名称',
  `total_weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '物流合同总重量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货物单位',
  `freight` decimal(18, 2) NULL DEFAULT NULL COMMENT '运费',
  `contract_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '物流合同照片',
  `logistics_contract_time` date NULL DEFAULT NULL COMMENT '物流单合同签订时间',
  `squeeze_season` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '榨季',
  `pigeonhole` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '归档  1显示  0隐藏',
  `relation_payment_exist_state` int(0) NULL DEFAULT NULL COMMENT '是否存在相关付款单 0表示无 1表示有',
  `relation_payment_audit_state` int(0) NULL DEFAULT NULL COMMENT '相关付款单是否已审核 0表示未审核 1表示已审核',
  `relation_shipping_exist_state` int(0) NULL DEFAULT NULL COMMENT '是否存在相关海运单 0表示无 1表示有',
  `relation_shipping_audit_state` int(0) NULL DEFAULT NULL COMMENT '相关海运单是否已审核 0表示未审核 1表示已审核',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  `upper_type` int(0) NULL DEFAULT NULL COMMENT '上级类型 0代表加工单 1代表销售单',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `logistics_unique`(`logistics_contract_no`) USING BTREE COMMENT '保证物流合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_contract
-- ----------------------------
INSERT INTO `logistics_contract` VALUES (90, 'WL1', 'XS测试', '广西众润贸易有限责任公司', '测试', 50.00, '吨', 1000.00, 'http://120.77.28.123:9000/static/images/ef73f162912f4da08350ad137300326d.jpg', '2023-01-06', '测试', '1', 1, NULL, 1, 1, '2023-01-06 17:22:06', '黄佳森', '2023-01-06 17:22:06', '黄佳森', 1);
INSERT INTO `logistics_contract` VALUES (92, 'WL测试', 'XS测试', '广西永湘贸易有限责任公司', '测试', 10.00, '吨', 10.00, '', '2023-01-06', '10月', '1', NULL, NULL, NULL, NULL, '2023-01-06 22:16:17', NULL, '2023-01-06 22:16:17', NULL, 0);

-- ----------------------------
-- Table structure for logistics_detail
-- ----------------------------
DROP TABLE IF EXISTS `logistics_detail`;
CREATE TABLE `logistics_detail`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id  自增',
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流单合同编号（运输合同编号）',
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '采购合同编号',
  `goods_factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '取货厂名',
  `outbound_time` date NULL DEFAULT NULL COMMENT '出库日期',
  `license_plate_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '车牌号',
  `goods_weight` decimal(18, 2) NULL DEFAULT NULL COMMENT '载货量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '货物单位',
  `unloading_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '卸货地点',
  `unit_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '运输单价',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  `upper_type` int(0) NULL DEFAULT NULL COMMENT '类型  0：加工单   1采购单',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_detail
-- ----------------------------
INSERT INTO `logistics_detail` VALUES (105, 'WL1', 'CG测试', 'A厂', '2023-01-06', '桂C1111', 50.00, '吨', '天津港', 100.00, '2023-01-06 17:20:03', '黄佳森', '2023-01-06 17:20:03', '黄佳森', 1);
INSERT INTO `logistics_detail` VALUES (108, 'WL测试', 'CG测试', 'A厂', '2023-01-16', '桂C456123', 5.00, '吨', '海南港口', 10.00, '2023-01-06 22:16:17', NULL, '2023-01-06 22:16:17', NULL, 0);
INSERT INTO `logistics_detail` VALUES (109, 'WL测试', 'CG测试', 'A厂', '2023-01-06', '桂C888', 5.00, '吨', '河北港口', 12.00, '2023-01-06 22:16:17', NULL, '2023-01-06 22:16:17', NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_director_state
-- ----------------------------
INSERT INTO `logistics_director_state` VALUES (58, 20, 5, NULL, '2023-01-06 19:06:36', NULL, '2023-01-06 19:06:36', NULL);
INSERT INTO `logistics_director_state` VALUES (59, 20, 4, NULL, '2023-01-06 19:06:36', NULL, '2023-01-06 19:06:36', NULL);
INSERT INTO `logistics_director_state` VALUES (60, 20, 3, NULL, '2023-01-06 19:06:36', NULL, '2023-01-06 19:06:36', NULL);
INSERT INTO `logistics_director_state` VALUES (61, 21, 5, NULL, '2023-01-06 19:06:37', NULL, '2023-01-06 19:06:37', NULL);
INSERT INTO `logistics_director_state` VALUES (62, 21, 4, NULL, '2023-01-06 19:06:37', NULL, '2023-01-06 19:06:37', NULL);
INSERT INTO `logistics_director_state` VALUES (63, 21, 3, NULL, '2023-01-06 19:06:38', NULL, '2023-01-06 19:06:38', NULL);
INSERT INTO `logistics_director_state` VALUES (64, 22, 5, NULL, '2023-01-06 19:06:39', NULL, '2023-01-06 19:06:39', NULL);
INSERT INTO `logistics_director_state` VALUES (65, 22, 4, NULL, '2023-01-06 19:06:39', NULL, '2023-01-06 19:06:39', NULL);
INSERT INTO `logistics_director_state` VALUES (66, 22, 3, NULL, '2023-01-06 19:06:39', NULL, '2023-01-06 19:06:39', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_payment_contract
-- ----------------------------
INSERT INTO `logistics_payment_contract` VALUES (20, 'WL1', NULL, 100.00, NULL, NULL, NULL, NULL, '2023-01-06 19:06:36', NULL, '2023-01-06 19:06:36', NULL);
INSERT INTO `logistics_payment_contract` VALUES (21, 'WL1', NULL, 100.00, NULL, NULL, NULL, NULL, '2023-01-06 19:06:37', NULL, '2023-01-06 19:06:37', NULL);
INSERT INTO `logistics_payment_contract` VALUES (22, 'WL1', NULL, 100.00, NULL, NULL, NULL, NULL, '2023-01-06 19:06:38', NULL, '2023-01-06 19:06:38', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of office_director_state
-- ----------------------------
INSERT INTO `office_director_state` VALUES (40, 12, 5, NULL, '2023-01-06 19:08:26', NULL, '2023-01-06 19:08:26', NULL);
INSERT INTO `office_director_state` VALUES (41, 12, 4, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_director_state` VALUES (42, 12, 3, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_director_state` VALUES (43, 13, 5, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_director_state` VALUES (44, 13, 4, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_director_state` VALUES (45, 13, 3, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_director_state` VALUES (46, 14, 5, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:28', NULL);
INSERT INTO `office_director_state` VALUES (47, 14, 4, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:28', NULL);
INSERT INTO `office_director_state` VALUES (48, 14, 3, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:28', NULL);
INSERT INTO `office_director_state` VALUES (49, 15, 5, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:28', NULL);
INSERT INTO `office_director_state` VALUES (50, 15, 4, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:28', NULL);
INSERT INTO `office_director_state` VALUES (51, 15, 3, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:28', NULL);
INSERT INTO `office_director_state` VALUES (52, 16, 5, NULL, '2023-01-06 19:08:29', NULL, '2023-01-06 19:08:29', NULL);
INSERT INTO `office_director_state` VALUES (53, 16, 4, NULL, '2023-01-06 19:08:29', NULL, '2023-01-06 19:08:29', NULL);
INSERT INTO `office_director_state` VALUES (54, 16, 3, NULL, '2023-01-06 19:08:29', NULL, '2023-01-06 19:08:29', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of office_expense
-- ----------------------------
INSERT INTO `office_expense` VALUES (12, '笔墨纸砚', 50.00, '2023-01-06', NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 19:08:26', NULL, '2023-01-06 19:08:26', NULL);
INSERT INTO `office_expense` VALUES (13, '梅兰竹菊', 100.00, '2023-01-06', NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_expense` VALUES (14, '办公桌', 50.00, '2023-01-06', NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 19:08:27', NULL, '2023-01-06 19:08:27', NULL);
INSERT INTO `office_expense` VALUES (15, '打印机墨水、打印机纸张', 100.00, '2023-01-06', '黄佳森', 1, NULL, NULL, NULL, NULL, '2023-01-06 19:08:28', NULL, '2023-01-06 19:08:45', NULL);
INSERT INTO `office_expense` VALUES (16, '洗手液', 100.00, '2023-01-06', '黄佳森', 1, NULL, NULL, NULL, NULL, '2023-01-06 19:08:29', NULL, '2023-01-06 19:08:42', NULL);

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
  `in_out_goods_unit_price` decimal(18, 2) NULL DEFAULT NULL COMMENT '采购货物单价（即采购单入库时才需填写）',
  `in_out_time` date NULL DEFAULT NULL COMMENT '出入库日期',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 594 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of other_in_out
-- ----------------------------
INSERT INTO `other_in_out` VALUES (371, 81, 1, 'GTXS22/2320221110-002', '甘蔗糖蜜', 2000.00, '吨', 0.70, '2022-11-10', '2023-01-06 12:09:47', '韩娜', '2023-01-06 12:09:47', '韩娜');
INSERT INTO `other_in_out` VALUES (372, 82, 1, 'HT05032223000002', '甘蔗糖蜜', 3000.00, '吨', 0.70, '2022-11-28', '2023-01-06 12:11:46', '韩娜', '2023-01-06 12:11:46', '韩娜');
INSERT INTO `other_in_out` VALUES (479, 85, 1, 'HT04032223000003', '甘蔗糖蜜', 1000.00, '吨', 0.72, '2022-12-28', '2023-01-06 12:43:23', '韩娜', '2023-01-06 12:43:23', '韩娜');
INSERT INTO `other_in_out` VALUES (482, 82, 1, 'HT05032223000004', '甘蔗糖蜜', 5000.00, '吨', 0.71, '2022-12-20', '2023-01-06 12:58:36', '韩娜', '2023-01-06 12:58:36', '韩娜');
INSERT INTO `other_in_out` VALUES (483, 87, 1, '桔/2023029', '甘蔗糖蜜', 2000.00, '吨', 0.72, '2023-01-05', '2023-01-06 14:35:25', '韩娜', '2023-01-06 14:35:25', '韩娜');
INSERT INTO `other_in_out` VALUES (589, 88, 1, 'CG测试', '测试', 100.00, '吨', 0.50, '2023-01-06', '2023-01-06 17:17:22', '黄佳森', '2023-01-06 17:17:22', '黄佳森');
INSERT INTO `other_in_out` VALUES (591, 88, 0, 'WL1', '测试', 50.00, '吨', NULL, NULL, '2023-01-06 17:22:07', '黄佳森', '2023-01-06 17:22:07', '黄佳森');
INSERT INTO `other_in_out` VALUES (594, 88, 0, 'WL测试', '测试', 5.00, '吨', NULL, NULL, '2023-01-06 22:16:19', NULL, '2023-01-06 22:16:19', NULL);
INSERT INTO `other_in_out` VALUES (595, 88, 0, 'WL测试', '测试', 5.00, '吨', NULL, NULL, '2023-01-06 22:16:20', NULL, '2023-01-06 22:16:20', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of other_warehouse
-- ----------------------------
INSERT INTO `other_warehouse` VALUES (81, '贵糖糖厂', '甘蔗糖蜜', 4000000.000000, '斤', '2023-01-06 12:07:24', '韩娜', '2023-01-06 12:07:24', '韩娜');
INSERT INTO `other_warehouse` VALUES (82, '上林糖厂', '甘蔗糖蜜', 16000000.000000, '斤', '2023-01-06 12:11:46', '韩娜', '2023-01-06 12:11:46', '韩娜');
INSERT INTO `other_warehouse` VALUES (85, '南圩糖厂', '甘蔗糖蜜', 2000000.000000, '斤', '2023-01-06 12:43:23', '韩娜', '2023-01-06 12:43:23', '韩娜');
INSERT INTO `other_warehouse` VALUES (86, '1', '1', 0.000000, '斤', '2023-01-06 12:43:29', 'admin', '2023-01-06 12:43:29', 'admin');
INSERT INTO `other_warehouse` VALUES (87, '龙门糖厂', '甘蔗糖蜜', 4000000.000000, '斤', '2023-01-06 14:35:25', '韩娜', '2023-01-06 14:35:25', '韩娜');
INSERT INTO `other_warehouse` VALUES (88, 'A厂', '测试', 80000.000000, '斤', '2023-01-06 17:17:22', '黄佳森', '2023-01-06 22:14:35', '黄佳森');

-- ----------------------------
-- Table structure for own_company
-- ----------------------------
DROP TABLE IF EXISTS `own_company`;
CREATE TABLE `own_company`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `own_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '己方公司名称',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `company_unique`(`own_company_name`) USING BTREE COMMENT '保证己方公司名唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of own_company
-- ----------------------------
INSERT INTO `own_company` VALUES (8, '广西永湘贸易有限责任公司', '2023-01-02 13:04:16', 'admin', '2023-01-02 13:04:38', NULL);
INSERT INTO `own_company` VALUES (9, '广西永湘物流有限公司', '2023-01-02 13:04:20', 'admin', '2023-01-02 13:04:47', NULL);
INSERT INTO `own_company` VALUES (10, '广西丰沣顺国际物流有限公司', '2023-01-02 13:04:28', 'admin', '2023-01-02 13:04:47', NULL);
INSERT INTO `own_company` VALUES (11, '广西众润贸易有限责任公司', '2023-01-02 13:04:29', 'admin', '2023-01-02 13:04:48', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of own_warehouse
-- ----------------------------

-- ----------------------------
-- Table structure for process_contract
-- ----------------------------
DROP TABLE IF EXISTS `process_contract`;
CREATE TABLE `process_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `process_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '加工合同编号',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加工货物名称',
  `customer_enterprise_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加工方公司名',
  `own_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '己方公司名',
  `alcohol_conversion_formula` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '酒精转换公式',
  `concentrated_solution_conversion_formula` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浓缩液转换公式',
  `sign_time` date NULL DEFAULT NULL COMMENT '合同签订时间',
  `contract_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '合同照片',
  `pigeonhole` int(0) NULL DEFAULT 1 COMMENT '归档 0表示隐藏  1表示显示',
  `relation_payment_exist_state` int(0) NULL DEFAULT NULL COMMENT '是否存在相关付款单 0表示无 1表示有',
  `relation_payment_audit_state` int(0) NULL DEFAULT NULL COMMENT '相关付款单是否已审核 0表示未审核 1表示已审核',
  `relation_logistics_exist_state` int(0) NULL DEFAULT NULL COMMENT '是否已生成相关的物流单 0表示无 1表示有',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `process_unique`(`process_contract_no`) USING BTREE COMMENT '保证加工合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process_contract
-- ----------------------------
INSERT INTO `process_contract` VALUES (64, '1', '白糖', '测试公司', '己方公司', 'x+y=3', 'x+y=1', '2023-01-06', 'http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg', 1, 1, NULL, NULL, '2023-01-06 14:45:35', NULL, '2023-01-06 19:04:51', NULL);
INSERT INTO `process_contract` VALUES (65, '2', '白糖', '测试公司', '己方公司', 'x+y=4', 'x+y=2', '2023-01-07', 'http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg', 1, 1, NULL, NULL, '2023-01-06 14:45:35', NULL, '2023-01-06 19:04:53', NULL);
INSERT INTO `process_contract` VALUES (66, '3', '白糖', '测试公司', '己方公司', 'x+y=5', 'x+y=3', '2023-01-08', 'http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg', 1, 1, NULL, NULL, '2023-01-06 14:45:35', NULL, '2023-01-06 19:04:56', NULL);
INSERT INTO `process_contract` VALUES (67, '4', '白糖', '测试公司', '己方公司', 'x+y=6', 'x+y=4', '2023-01-09', 'http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg', 1, NULL, NULL, NULL, '2023-01-06 14:45:35', NULL, '2023-01-06 19:04:58', NULL);
INSERT INTO `process_contract` VALUES (68, '5', '白糖', '测试公司', '己方公司', 'x+y=7', 'x+y=5', '2023-01-10', 'http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg', 1, 1, NULL, NULL, '2023-01-06 14:45:35', NULL, '2023-01-06 19:05:01', NULL);
INSERT INTO `process_contract` VALUES (69, 'JG测试', '白糖', '上林南华糖业有限责任公司', '广西众润贸易有限责任公司', 'x+3y=1', 'x+9y=4', '2023-01-06', 'http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg', 1, 1, 1, NULL, '2023-01-06 18:52:38', '黄佳森', '2023-01-06 18:52:38', '黄佳森');

-- ----------------------------
-- Table structure for process_director_state
-- ----------------------------
DROP TABLE IF EXISTS `process_director_state`;
CREATE TABLE `process_director_state`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `process_payment_contract_id` int(0) NULL DEFAULT NULL COMMENT '加工付款单ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '董事会用户ID',
  `state` int(0) NULL DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process_director_state
-- ----------------------------
INSERT INTO `process_director_state` VALUES (61, 22, 5, NULL, '2023-01-06 19:05:35', NULL, '2023-01-06 19:05:35', NULL);
INSERT INTO `process_director_state` VALUES (62, 22, 4, NULL, '2023-01-06 19:05:35', NULL, '2023-01-06 19:05:35', NULL);
INSERT INTO `process_director_state` VALUES (63, 22, 3, NULL, '2023-01-06 19:05:35', NULL, '2023-01-06 19:05:35', NULL);
INSERT INTO `process_director_state` VALUES (64, 23, 5, NULL, '2023-01-06 19:05:36', NULL, '2023-01-06 19:05:36', NULL);
INSERT INTO `process_director_state` VALUES (65, 23, 4, NULL, '2023-01-06 19:05:36', NULL, '2023-01-06 19:05:36', NULL);
INSERT INTO `process_director_state` VALUES (66, 23, 3, NULL, '2023-01-06 19:05:37', NULL, '2023-01-06 19:05:37', NULL);
INSERT INTO `process_director_state` VALUES (67, 24, 5, NULL, '2023-01-06 19:05:37', NULL, '2023-01-06 19:05:37', NULL);
INSERT INTO `process_director_state` VALUES (68, 24, 4, NULL, '2023-01-06 19:05:37', NULL, '2023-01-06 19:05:37', NULL);
INSERT INTO `process_director_state` VALUES (69, 24, 3, NULL, '2023-01-06 19:05:37', NULL, '2023-01-06 19:05:37', NULL);
INSERT INTO `process_director_state` VALUES (70, 25, 5, NULL, '2023-01-06 19:05:38', NULL, '2023-01-06 19:05:38', NULL);
INSERT INTO `process_director_state` VALUES (71, 25, 4, NULL, '2023-01-06 19:05:38', NULL, '2023-01-06 19:05:38', NULL);
INSERT INTO `process_director_state` VALUES (72, 25, 3, NULL, '2023-01-06 19:05:38', NULL, '2023-01-06 19:05:38', NULL);
INSERT INTO `process_director_state` VALUES (73, 26, 5, NULL, '2023-01-06 19:17:47', NULL, '2023-01-06 19:17:47', NULL);
INSERT INTO `process_director_state` VALUES (74, 26, 4, NULL, '2023-01-06 19:17:47', NULL, '2023-01-06 19:17:47', NULL);
INSERT INTO `process_director_state` VALUES (75, 26, 3, NULL, '2023-01-06 19:17:47', NULL, '2023-01-06 19:17:47', NULL);
INSERT INTO `process_director_state` VALUES (76, 27, 5, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_director_state` VALUES (77, 27, 4, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_director_state` VALUES (78, 27, 3, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_director_state` VALUES (79, 28, 5, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_director_state` VALUES (80, 28, 4, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_director_state` VALUES (81, 28, 3, NULL, '2023-01-06 19:17:49', NULL, '2023-01-06 19:17:49', NULL);
INSERT INTO `process_director_state` VALUES (82, 29, 5, NULL, '2023-01-06 19:17:49', NULL, '2023-01-06 19:17:49', NULL);
INSERT INTO `process_director_state` VALUES (83, 29, 4, NULL, '2023-01-06 19:17:49', NULL, '2023-01-06 19:17:49', NULL);
INSERT INTO `process_director_state` VALUES (84, 29, 3, NULL, '2023-01-06 19:17:49', NULL, '2023-01-06 19:17:49', NULL);

-- ----------------------------
-- Table structure for process_payment_contract
-- ----------------------------
DROP TABLE IF EXISTS `process_payment_contract`;
CREATE TABLE `process_payment_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '加工付款单ID',
  `process_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '加工单合同编号',
  `payment_month` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '付款月份',
  `payment_month_price_g` decimal(18, 2) NULL DEFAULT NULL COMMENT '付款月加工单价/斤',
  `payment_month_price_t` decimal(18, 2) NULL DEFAULT NULL COMMENT '付款月加工单价/吨',
  `goods_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '付款月加工总量',
  `goods_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '加工货物单位',
  `cashier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '出纳名称',
  `payment_count` decimal(18, 2) NULL DEFAULT NULL COMMENT '总费用金额',
  `payment_time` date NULL DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '付款流水截图',
  `finance_staff` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '财务名称',
  `finance_state` int(0) NULL DEFAULT NULL COMMENT '财务审核状态',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process_payment_contract
-- ----------------------------
INSERT INTO `process_payment_contract` VALUES (22, 'JG测试', '2023-01', 0.50, 1000.00, 10.00, '吨', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:05:35', NULL, '2023-01-06 19:05:35', NULL);
INSERT INTO `process_payment_contract` VALUES (23, '1', '2022-12', 0.50, 1000.00, 10.00, '吨', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:05:36', NULL, '2023-01-06 19:05:36', NULL);
INSERT INTO `process_payment_contract` VALUES (24, '2', '2022-11', 0.50, 1000.00, 20.00, '吨', NULL, 20000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:05:37', NULL, '2023-01-06 19:05:37', NULL);
INSERT INTO `process_payment_contract` VALUES (25, 'JG测试', '2022-08', 0.50, 1000.00, 10.00, '吨', NULL, 10000.00, NULL, NULL, '黄佳森', 1, '2023-01-06 19:05:38', NULL, '2023-01-06 19:05:45', NULL);
INSERT INTO `process_payment_contract` VALUES (26, 'JG测试', '2023-01', 0.50, 1000.00, 10.00, '吨', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:17:47', NULL, '2023-01-06 19:17:47', NULL);
INSERT INTO `process_payment_contract` VALUES (27, '3', '2022-12', 0.50, 1000.00, 10.00, '吨', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_payment_contract` VALUES (28, '5', '2022-11', 0.50, 1000.00, 20.00, '吨', NULL, 20000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:17:48', NULL, '2023-01-06 19:17:48', NULL);
INSERT INTO `process_payment_contract` VALUES (29, 'JG测试', '2022-08', 0.50, 1000.00, 10.00, '吨', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:17:49', NULL, '2023-01-06 19:17:49', NULL);

-- ----------------------------
-- Table structure for purchase_contract
-- ----------------------------
DROP TABLE IF EXISTS `purchase_contract`;
CREATE TABLE `purchase_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '采购合同编号',
  `customer_enterprise_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '供货商公司名',
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
  `relation_payment_exist_state` int(0) NULL DEFAULT NULL COMMENT '是否存在相关付款单 0表示无 1表示有',
  `relation_payment_audit_state` int(0) NULL DEFAULT NULL COMMENT '相关付款单是否已审核 0表示未审核 1表示已审核',
  `relation_logistics_exist_state` int(0) NULL DEFAULT NULL COMMENT '是否已生成相关的物流单 0表示无 1表示有',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `purchase_unique`(`purchase_contract_no`) USING BTREE COMMENT '保证采购合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 295 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_contract
-- ----------------------------
INSERT INTO `purchase_contract` VALUES (197, 'GTXS22/2320221110-002', '广西广业贵糖糖业集团有限公司', '广西永湘贸易有限责任公司', '2022/2023', '2022-11-10', '甘蔗糖蜜', 2000.00, '吨', NULL, 2800000.00, 2800000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:07:24', '韩娜', '2023-01-06 12:09:47', '韩娜');
INSERT INTO `purchase_contract` VALUES (198, 'HT05032223000002', '上林南华糖业有限责任公司', '广西永湘贸易有限责任公司', '2022/2023', '2022-11-28', '甘蔗糖蜜', 3000.00, '吨', NULL, 4200000.00, 4200000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:11:46', '韩娜', '2023-01-06 12:11:46', '韩娜');
INSERT INTO `purchase_contract` VALUES (199, 'FFS-YX22/23-（桔）-001', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-11-25', '甘蔗糖蜜', 3000.00, '吨', NULL, 4206000.00, 4206000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:08', NULL, '2023-01-06 12:22:08', NULL);
INSERT INTO `purchase_contract` VALUES (200, 'JL-YX-2022113001', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-11-30', '甘蔗糖蜜', 2000.00, '吨', NULL, 2720000.00, 2720000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:09', NULL, '2023-01-06 12:22:09', NULL);
INSERT INTO `purchase_contract` VALUES (201, 'JL-YX-2022113002', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-11-30', '甘蔗糖蜜', 2000.00, '吨', NULL, 2720000.00, 2720000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:09', NULL, '2023-01-06 12:22:09', NULL);
INSERT INTO `purchase_contract` VALUES (202, '202212050001', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-05', '甘蔗糖蜜', 5000.00, '吨', NULL, 6100000.00, 6100000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:09', NULL, '2023-01-06 12:22:09', NULL);
INSERT INTO `purchase_contract` VALUES (203, 'GTXS22/2320221207-008', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-07', '甘蔗糖蜜', 2000.00, '吨', NULL, 2800000.00, 2800000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:09', NULL, '2023-01-06 12:22:09', NULL);
INSERT INTO `purchase_contract` VALUES (204, '202212080001', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-08', '甘蔗糖蜜', 5000.00, '吨', NULL, 6100000.00, 6100000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:10', NULL, '2023-01-06 12:22:10', NULL);
INSERT INTO `purchase_contract` VALUES (205, 'JL-YX-2022121301', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-13', '甘蔗糖蜜', 2000.00, '吨', NULL, 2720000.00, 2720000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:10', NULL, '2023-01-06 12:22:10', NULL);
INSERT INTO `purchase_contract` VALUES (206, 'HT18032223000002', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-20', '甘蔗糖蜜', 4000.00, '吨', NULL, 5640000.00, 5640000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:10', NULL, '2023-01-06 12:22:10', NULL);
INSERT INTO `purchase_contract` VALUES (208, 'HT16032223000004', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 1000.00, '吨', NULL, 1430000.00, 1430000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:11', NULL, '2023-01-06 12:22:11', NULL);
INSERT INTO `purchase_contract` VALUES (209, 'HT14032223000006', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 1000.00, '吨', NULL, 1430000.00, 1430000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:11', NULL, '2023-01-06 12:22:11', NULL);
INSERT INTO `purchase_contract` VALUES (210, 'HT15032223000004', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 1000.00, '吨', NULL, 1430000.00, 1430000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:11', NULL, '2023-01-06 12:22:11', NULL);
INSERT INTO `purchase_contract` VALUES (211, 'HT11032223000003', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 1000.00, '吨', NULL, 1430000.00, 1430000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:12', NULL, '2023-01-06 12:22:12', NULL);
INSERT INTO `purchase_contract` VALUES (212, 'HT10032223000003', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 1000.00, '吨', NULL, 1430000.00, 1430000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:12', NULL, '2023-01-06 12:22:12', NULL);
INSERT INTO `purchase_contract` VALUES (213, 'HT11032223000002', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 2000.00, '吨', NULL, 2860000.00, 2860000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:12', NULL, '2023-01-06 12:22:12', NULL);
INSERT INTO `purchase_contract` VALUES (214, 'HT12032223000011', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 2000.00, '吨', NULL, 2860000.00, 2860000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:12', NULL, '2023-01-06 12:22:12', NULL);
INSERT INTO `purchase_contract` VALUES (216, 'XTX-YX2022122801', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2023-12-28', '甘蔗糖蜜', 1500.00, '吨', NULL, 2077500.00, 2077500.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:13', NULL, '2023-01-06 12:22:13', NULL);
INSERT INTO `purchase_contract` VALUES (217, 'YX-JL-2022123001', NULL, '广西永湘贸易有限责任公司', '2022/2023', '2023-12-30', '白砂糖', 6000.00, '吨', NULL, 34320000.00, 34320000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:13', NULL, '2023-01-06 12:22:13', NULL);
INSERT INTO `purchase_contract` VALUES (254, 'HT04032223000003', '广西隆安南华糖业有限责任公司', '广西永湘贸易有限责任公司', '2022/2023', '2022-12-28', '甘蔗糖蜜', 1000.00, '吨', NULL, 1430000.00, 1430000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:13', NULL, '2023-01-06 12:43:23', '韩娜');
INSERT INTO `purchase_contract` VALUES (257, 'HT05032223000004', '上林南华糖业有限责任公司', '广西永湘贸易有限责任公司', '2022/2023', '2022-12-20', '甘蔗糖蜜', 5000.00, '吨', NULL, 7100000.00, 710000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 12:22:10', NULL, '2023-01-06 12:58:36', '韩娜');
INSERT INTO `purchase_contract` VALUES (258, '桔/2023029', '广东富桥糖业有限公司', '广西永湘贸易有限责任公司', '2022/2023', '2023-01-05', '甘蔗糖蜜', 2000.00, '吨', NULL, 2866000.00, 2866000.00, NULL, 1, NULL, NULL, NULL, '2023-01-06 14:35:26', '韩娜', '2023-01-06 14:35:26', '韩娜');
INSERT INTO `purchase_contract` VALUES (294, 'CG测试', '江苏途富新材料有限公司', '广西丰沣顺国际物流有限公司', '测试', '2023-01-06', '测试', 100.00, '吨', NULL, 100000.00, 100000.00, 'http://120.77.28.123:9000/static/images/0c5fe159944142949f7b872ff64acb28.jpg', 1, 1, NULL, 1, '2023-01-06 17:17:23', '黄佳森', '2023-01-06 17:17:23', '黄佳森');

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
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_director_state
-- ----------------------------
INSERT INTO `purchase_director_state` VALUES (64, 23, 5, NULL, '2023-01-06 19:02:00', NULL, '2023-01-06 19:02:00', NULL);
INSERT INTO `purchase_director_state` VALUES (65, 23, 4, NULL, '2023-01-06 19:02:00', NULL, '2023-01-06 19:02:00', NULL);
INSERT INTO `purchase_director_state` VALUES (66, 23, 3, NULL, '2023-01-06 19:02:00', NULL, '2023-01-06 19:02:00', NULL);
INSERT INTO `purchase_director_state` VALUES (67, 24, 5, NULL, '2023-01-06 19:02:01', NULL, '2023-01-06 19:02:01', NULL);
INSERT INTO `purchase_director_state` VALUES (68, 24, 4, NULL, '2023-01-06 19:02:01', NULL, '2023-01-06 19:02:01', NULL);
INSERT INTO `purchase_director_state` VALUES (69, 24, 3, NULL, '2023-01-06 19:02:01', NULL, '2023-01-06 19:02:01', NULL);
INSERT INTO `purchase_director_state` VALUES (70, 25, 5, NULL, '2023-01-06 19:02:02', NULL, '2023-01-06 19:02:02', NULL);
INSERT INTO `purchase_director_state` VALUES (71, 25, 4, NULL, '2023-01-06 19:02:02', NULL, '2023-01-06 19:02:02', NULL);
INSERT INTO `purchase_director_state` VALUES (72, 25, 3, NULL, '2023-01-06 19:02:02', NULL, '2023-01-06 19:02:02', NULL);

-- ----------------------------
-- Table structure for purchase_payment_contract
-- ----------------------------
DROP TABLE IF EXISTS `purchase_payment_contract`;
CREATE TABLE `purchase_payment_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '采购付款单ID',
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '采购单合同编号',
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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_payment_contract
-- ----------------------------
INSERT INTO `purchase_payment_contract` VALUES (23, 'CG测试', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:02:00', NULL, '2023-01-06 19:02:00', NULL);
INSERT INTO `purchase_payment_contract` VALUES (24, 'CG测试', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:02:01', NULL, '2023-01-06 19:02:01', NULL);
INSERT INTO `purchase_payment_contract` VALUES (25, 'CG测试', NULL, 10000.00, NULL, NULL, NULL, NULL, '2023-01-06 19:02:02', NULL, '2023-01-06 19:02:02', NULL);

-- ----------------------------
-- Table structure for sale_contract
-- ----------------------------
DROP TABLE IF EXISTS `sale_contract`;
CREATE TABLE `sale_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `sale_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '销售单合同编号',
  `sale_customer_id` int(0) NULL DEFAULT NULL COMMENT '客户表id',
  `customer_enterprise_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '销售方公司名',
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
  `is_have_logistics` int(0) NULL DEFAULT NULL COMMENT '是否存在物流单  1表示存在了',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sale_unique`(`sale_contract_no`) USING BTREE COMMENT '保证销售合同编号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sale_contract
-- ----------------------------
INSERT INTO `sale_contract` VALUES (60, 'XS测试', NULL, '忻城南华糖业有限责任公司', '广西丰沣顺国际物流有限公司', '测试', 50.00, '吨', 3000.00, 150000.00, '2023-01-06', '出厂净重结算', '海运：港到港', '', NULL, NULL, '', '', '1', '测试', '2023-01-06 17:18:48', '黄佳森', '2023-01-06 17:18:48', '黄佳森', 1);

-- ----------------------------
-- Table structure for shipping_contract
-- ----------------------------
DROP TABLE IF EXISTS `shipping_contract`;
CREATE TABLE `shipping_contract`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `shipping_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '海运单合同编号',
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流单合同编号',
  `own_company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '己方公司名称',
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
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping_contract
-- ----------------------------
INSERT INTO `shipping_contract` VALUES (43, '1', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-06 00:00:00', '天津港', '青岛港', 'JZX1', 'QF1', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:21', NULL, '2023-01-06 17:20:21', NULL);
INSERT INTO `shipping_contract` VALUES (44, '2', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-07 00:00:00', '天津港', '青岛港', 'JZX2', 'QF2', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 600.00, 4200.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:22', NULL, '2023-01-06 17:20:22', NULL);
INSERT INTO `shipping_contract` VALUES (45, '3', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-08 00:00:00', '天津港', '青岛港', 'JZX3', 'QF3', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:23', NULL, '2023-01-06 17:20:23', NULL);
INSERT INTO `shipping_contract` VALUES (46, '4', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-09 00:00:00', '天津港', '青岛港', 'JZX4', 'QF4', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:24', NULL, '2023-01-06 17:20:24', NULL);
INSERT INTO `shipping_contract` VALUES (47, '5', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-10 00:00:00', '天津港', '青岛港', 'JZX5', 'QF5', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:25', NULL, '2023-01-06 17:20:25', NULL);
INSERT INTO `shipping_contract` VALUES (48, '6', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-11 00:00:00', '天津港', '青岛港', 'JZX6', 'QF6', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:26', NULL, '2023-01-06 17:20:26', NULL);
INSERT INTO `shipping_contract` VALUES (49, '7', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-12 00:00:00', '天津港', '青岛港', 'JZX7', 'QF7', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:27', NULL, '2023-01-06 17:20:27', NULL);
INSERT INTO `shipping_contract` VALUES (50, '8', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-13 00:00:00', '天津港', '青岛港', 'JZX8', 'QF8', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:28', NULL, '2023-01-06 17:20:28', NULL);
INSERT INTO `shipping_contract` VALUES (51, '9', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-14 00:00:00', '天津港', '青岛港', 'JZX9', 'QF9', '王五', 100.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4100.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-01-06 17:20:29', NULL, '2023-01-06 17:20:29', NULL);
INSERT INTO `shipping_contract` VALUES (52, '10', 'WL1', '广西丰沣顺国际物流有限公司', '八方达', '2023-01-15 00:00:00', '天津港', '青岛港', 'JZX10', 'QF10', '王五', 200.00, '新南车队', 500.00, '东方海外航运', 3000.00, '老北车队', 500.00, 4200.00, NULL, '黄佳森', 1, NULL, NULL, NULL, NULL, '2023-01-06 17:20:30', NULL, '2023-01-06 17:20:30', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipping_director_state
-- ----------------------------
INSERT INTO `shipping_director_state` VALUES (88, '1', 5, NULL, '2023-01-06 17:20:22', NULL, '2023-01-06 17:20:22', NULL);
INSERT INTO `shipping_director_state` VALUES (89, '1', 4, NULL, '2023-01-06 17:20:22', NULL, '2023-01-06 17:20:22', NULL);
INSERT INTO `shipping_director_state` VALUES (90, '1', 3, NULL, '2023-01-06 17:20:22', NULL, '2023-01-06 17:20:22', NULL);
INSERT INTO `shipping_director_state` VALUES (91, '2', 5, NULL, '2023-01-06 17:20:23', NULL, '2023-01-06 17:20:23', NULL);
INSERT INTO `shipping_director_state` VALUES (92, '2', 4, NULL, '2023-01-06 17:20:23', NULL, '2023-01-06 17:20:23', NULL);
INSERT INTO `shipping_director_state` VALUES (93, '2', 3, NULL, '2023-01-06 17:20:23', NULL, '2023-01-06 17:20:23', NULL);
INSERT INTO `shipping_director_state` VALUES (94, '3', 5, NULL, '2023-01-06 17:20:23', NULL, '2023-01-06 17:20:23', NULL);
INSERT INTO `shipping_director_state` VALUES (95, '3', 4, NULL, '2023-01-06 17:20:24', NULL, '2023-01-06 17:20:24', NULL);
INSERT INTO `shipping_director_state` VALUES (96, '3', 3, NULL, '2023-01-06 17:20:24', NULL, '2023-01-06 17:20:24', NULL);
INSERT INTO `shipping_director_state` VALUES (97, '4', 5, NULL, '2023-01-06 17:20:24', NULL, '2023-01-06 17:20:24', NULL);
INSERT INTO `shipping_director_state` VALUES (98, '4', 4, NULL, '2023-01-06 17:20:25', NULL, '2023-01-06 17:20:25', NULL);
INSERT INTO `shipping_director_state` VALUES (99, '4', 3, NULL, '2023-01-06 17:20:25', NULL, '2023-01-06 17:20:25', NULL);
INSERT INTO `shipping_director_state` VALUES (100, '5', 5, NULL, '2023-01-06 17:20:25', NULL, '2023-01-06 17:20:25', NULL);
INSERT INTO `shipping_director_state` VALUES (101, '5', 4, NULL, '2023-01-06 17:20:26', NULL, '2023-01-06 17:20:26', NULL);
INSERT INTO `shipping_director_state` VALUES (102, '5', 3, NULL, '2023-01-06 17:20:26', NULL, '2023-01-06 17:20:26', NULL);
INSERT INTO `shipping_director_state` VALUES (103, '6', 5, NULL, '2023-01-06 17:20:26', NULL, '2023-01-06 17:20:26', NULL);
INSERT INTO `shipping_director_state` VALUES (104, '6', 4, NULL, '2023-01-06 17:20:26', NULL, '2023-01-06 17:20:26', NULL);
INSERT INTO `shipping_director_state` VALUES (105, '6', 3, NULL, '2023-01-06 17:20:27', NULL, '2023-01-06 17:20:27', NULL);
INSERT INTO `shipping_director_state` VALUES (106, '7', 5, NULL, '2023-01-06 17:20:27', NULL, '2023-01-06 17:20:27', NULL);
INSERT INTO `shipping_director_state` VALUES (107, '7', 4, NULL, '2023-01-06 17:20:27', NULL, '2023-01-06 17:20:27', NULL);
INSERT INTO `shipping_director_state` VALUES (108, '7', 3, NULL, '2023-01-06 17:20:27', NULL, '2023-01-06 17:20:27', NULL);
INSERT INTO `shipping_director_state` VALUES (109, '8', 5, NULL, '2023-01-06 17:20:28', NULL, '2023-01-06 17:20:28', NULL);
INSERT INTO `shipping_director_state` VALUES (110, '8', 4, NULL, '2023-01-06 17:20:28', NULL, '2023-01-06 17:20:28', NULL);
INSERT INTO `shipping_director_state` VALUES (111, '8', 3, NULL, '2023-01-06 17:20:28', NULL, '2023-01-06 17:20:28', NULL);
INSERT INTO `shipping_director_state` VALUES (112, '9', 5, NULL, '2023-01-06 17:20:29', NULL, '2023-01-06 17:20:29', NULL);
INSERT INTO `shipping_director_state` VALUES (113, '9', 4, NULL, '2023-01-06 17:20:29', NULL, '2023-01-06 17:20:29', NULL);
INSERT INTO `shipping_director_state` VALUES (114, '9', 3, NULL, '2023-01-06 17:20:30', NULL, '2023-01-06 17:20:30', NULL);
INSERT INTO `shipping_director_state` VALUES (115, '10', 5, NULL, '2023-01-06 17:20:30', NULL, '2023-01-06 17:20:30', NULL);
INSERT INTO `shipping_director_state` VALUES (116, '10', 4, NULL, '2023-01-06 17:20:30', NULL, '2023-01-06 17:20:30', NULL);
INSERT INTO `shipping_director_state` VALUES (117, '10', 3, 1, '2023-01-06 17:20:30', NULL, '2023-01-06 17:22:26', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 22716 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (21709, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 557, '117.140.240.127', '黄佳森', '2023-01-05 22:17:54', '黄佳森', '2023-01-05 22:17:54');
INSERT INTO `sys_log` VALUES (21710, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 41, '117.140.240.127', '黄佳森', '2023-01-05 22:17:54', '黄佳森', '2023-01-05 22:17:54');
INSERT INTO `sys_log` VALUES (21711, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 92, '117.140.240.127', '黄佳森', '2023-01-05 22:17:54', '黄佳森', '2023-01-05 22:17:54');
INSERT INTO `sys_log` VALUES (21712, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 240, '117.140.240.127', '黄佳森', '2023-01-05 22:17:55', '黄佳森', '2023-01-05 22:17:55');
INSERT INTO `sys_log` VALUES (21713, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 138, '117.140.240.127', '黄佳森', '2023-01-05 22:17:56', '黄佳森', '2023-01-05 22:17:56');
INSERT INTO `sys_log` VALUES (21714, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 119, '117.140.240.127', '黄佳森', '2023-01-05 22:17:57', '黄佳森', '2023-01-05 22:17:57');
INSERT INTO `sys_log` VALUES (21715, '黄佳森', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 80, '117.140.240.127', '黄佳森', '2023-01-05 22:17:58', '黄佳森', '2023-01-05 22:17:58');
INSERT INTO `sys_log` VALUES (21716, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 84, '117.140.240.127', '黄佳森', '2023-01-05 22:17:59', '黄佳森', '2023-01-05 22:17:59');
INSERT INTO `sys_log` VALUES (21717, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '117.140.240.127', '黄佳森', '2023-01-05 22:17:59', '黄佳森', '2023-01-05 22:17:59');
INSERT INTO `sys_log` VALUES (21718, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 92, '117.140.240.127', '黄佳森', '2023-01-05 22:17:59', '黄佳森', '2023-01-05 22:17:59');
INSERT INTO `sys_log` VALUES (21719, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 86, '117.140.240.127', '黄佳森', '2023-01-05 22:18:00', '黄佳森', '2023-01-05 22:18:00');
INSERT INTO `sys_log` VALUES (21720, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 98, '117.140.240.127', '黄佳森', '2023-01-05 22:18:00', '黄佳森', '2023-01-05 22:18:00');
INSERT INTO `sys_log` VALUES (21721, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 95, '117.140.240.127', '黄佳森', '2023-01-05 22:18:00', '黄佳森', '2023-01-05 22:18:00');
INSERT INTO `sys_log` VALUES (21722, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 90, '117.140.240.127', '黄佳森', '2023-01-05 22:18:01', '黄佳森', '2023-01-05 22:18:01');
INSERT INTO `sys_log` VALUES (21723, '黄佳森', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 80, '117.140.240.127', '黄佳森', '2023-01-05 22:18:01', '黄佳森', '2023-01-05 22:18:01');
INSERT INTO `sys_log` VALUES (21724, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 90, '117.140.240.127', '黄佳森', '2023-01-05 22:18:01', '黄佳森', '2023-01-05 22:18:01');
INSERT INTO `sys_log` VALUES (21725, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 47, '117.140.240.127', '黄佳森', '2023-01-05 22:18:01', '黄佳森', '2023-01-05 22:18:01');
INSERT INTO `sys_log` VALUES (21726, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '117.140.240.127', '黄佳森', '2023-01-05 22:18:03', '黄佳森', '2023-01-05 22:18:03');
INSERT INTO `sys_log` VALUES (21727, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 79, '117.140.240.127', '黄佳森', '2023-01-05 22:18:03', '黄佳森', '2023-01-05 22:18:03');
INSERT INTO `sys_log` VALUES (21728, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 46, '117.140.240.127', '黄佳森', '2023-01-05 22:18:03', '黄佳森', '2023-01-05 22:18:03');
INSERT INTO `sys_log` VALUES (21729, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '117.140.240.127', '黄佳森', '2023-01-05 22:18:04', '黄佳森', '2023-01-05 22:18:04');
INSERT INTO `sys_log` VALUES (21730, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 79, '117.140.240.127', '黄佳森', '2023-01-05 22:18:04', '黄佳森', '2023-01-05 22:18:04');
INSERT INTO `sys_log` VALUES (21731, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 79, '117.140.240.127', '黄佳森', '2023-01-05 22:18:06', '黄佳森', '2023-01-05 22:18:06');
INSERT INTO `sys_log` VALUES (21732, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 93, '117.140.240.127', '黄佳森', '2023-01-05 22:18:07', '黄佳森', '2023-01-05 22:18:07');
INSERT INTO `sys_log` VALUES (21733, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 80, '117.140.240.127', '黄佳森', '2023-01-05 22:18:08', '黄佳森', '2023-01-05 22:18:08');
INSERT INTO `sys_log` VALUES (21734, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 79, '117.140.240.127', '黄佳森', '2023-01-05 22:18:12', '黄佳森', '2023-01-05 22:18:12');
INSERT INTO `sys_log` VALUES (21735, '黄佳森', NULL, 'cn.edu.guet.controller.AnalysisDataController.getGoodsNameData()', NULL, 77, '117.140.240.127', '黄佳森', '2023-01-05 22:18:13', '黄佳森', '2023-01-05 22:18:13');
INSERT INTO `sys_log` VALUES (21736, '黄佳森', NULL, 'cn.edu.guet.controller.CashierController.getCashierPurchasePayment()', '1', 79, '117.140.240.127', '黄佳森', '2023-01-05 22:18:18', '黄佳森', '2023-01-05 22:18:18');
INSERT INTO `sys_log` VALUES (21737, '黄佳森', NULL, 'cn.edu.guet.controller.CashierController.getCashierProcessPayment()', '1', 93, '117.140.240.127', '黄佳森', '2023-01-05 22:18:19', '黄佳森', '2023-01-05 22:18:19');
INSERT INTO `sys_log` VALUES (21738, '黄佳森', NULL, 'cn.edu.guet.controller.CashierController.getCashierSaleContract()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 89, '117.140.240.127', '黄佳森', '2023-01-05 22:18:20', '黄佳森', '2023-01-05 22:18:20');
INSERT INTO `sys_log` VALUES (21739, '黄佳森', NULL, 'cn.edu.guet.controller.CashierController.getCashierLogisticsPayment()', '1', 93, '117.140.240.127', '黄佳森', '2023-01-05 22:18:21', '黄佳森', '2023-01-05 22:18:21');
INSERT INTO `sys_log` VALUES (21740, '黄佳森', NULL, 'cn.edu.guet.controller.CashierController.getCashierShipping()', '1', 92, '117.140.240.127', '黄佳森', '2023-01-05 22:18:22', '黄佳森', '2023-01-05 22:18:22');
INSERT INTO `sys_log` VALUES (21741, '黄佳森', NULL, 'cn.edu.guet.controller.CashierController.getCashierOfficeExpense()', '1', 79, '117.140.240.127', '黄佳森', '2023-01-05 22:18:23', '黄佳森', '2023-01-05 22:18:23');
INSERT INTO `sys_log` VALUES (21742, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 366, '116.10.252.177', 'admin', '2023-01-05 22:36:02', 'admin', '2023-01-05 22:36:02');
INSERT INTO `sys_log` VALUES (21743, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 47, '116.10.252.177', 'admin', '2023-01-05 22:36:02', 'admin', '2023-01-05 22:36:02');
INSERT INTO `sys_log` VALUES (21744, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 45, '116.10.252.177', 'admin', '2023-01-05 22:36:02', 'admin', '2023-01-05 22:36:02');
INSERT INTO `sys_log` VALUES (21745, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 138, '116.10.252.177', 'admin', '2023-01-05 22:36:03', 'admin', '2023-01-05 22:36:03');
INSERT INTO `sys_log` VALUES (21746, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.list()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 136, '116.10.252.177', 'admin', '2023-01-05 22:36:05', 'admin', '2023-01-05 22:36:05');
INSERT INTO `sys_log` VALUES (21747, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.delete()', '20', 437, '116.10.252.177', 'admin', '2023-01-05 22:36:18', 'admin', '2023-01-05 22:36:18');
INSERT INTO `sys_log` VALUES (21748, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.list()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 91, '116.10.252.177', 'admin', '2023-01-05 22:36:18', 'admin', '2023-01-05 22:36:18');
INSERT INTO `sys_log` VALUES (21749, 'admin', NULL, 'cn.edu.guet.controller.SysRoleController.getListSelect()', NULL, 91, '116.10.252.177', 'admin', '2023-01-05 22:36:21', 'admin', '2023-01-05 22:36:21');
INSERT INTO `sys_log` VALUES (21750, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getRole()', '21', 47, '116.10.252.177', 'admin', '2023-01-05 22:36:21', 'admin', '2023-01-05 22:36:21');
INSERT INTO `sys_log` VALUES (21751, 'admin', NULL, 'cn.edu.guet.controller.SysRoleController.getListSelect()', NULL, 90, '116.10.252.177', 'admin', '2023-01-05 22:36:25', 'admin', '2023-01-05 22:36:25');
INSERT INTO `sys_log` VALUES (21752, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getRole()', 'null', 46, '116.10.252.177', 'admin', '2023-01-05 22:36:26', 'admin', '2023-01-05 22:36:26');
INSERT INTO `sys_log` VALUES (21753, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 364, '116.10.252.177', 'admin', '2023-01-05 22:36:54', 'admin', '2023-01-05 22:36:54');
INSERT INTO `sys_log` VALUES (21754, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 46, '116.10.252.177', 'admin', '2023-01-05 22:36:54', 'admin', '2023-01-05 22:36:54');
INSERT INTO `sys_log` VALUES (21755, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 46, '116.10.252.177', 'admin', '2023-01-05 22:36:54', 'admin', '2023-01-05 22:36:54');
INSERT INTO `sys_log` VALUES (21756, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 138, '116.10.252.177', 'admin', '2023-01-05 22:36:54', 'admin', '2023-01-05 22:36:54');
INSERT INTO `sys_log` VALUES (21757, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.list()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 136, '116.10.252.177', 'admin', '2023-01-05 22:36:58', 'admin', '2023-01-05 22:36:58');
INSERT INTO `sys_log` VALUES (21758, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 94, '116.10.252.177', 'admin', '2023-01-05 22:37:16', 'admin', '2023-01-05 22:37:16');
INSERT INTO `sys_log` VALUES (21759, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 83, '116.10.252.177', 'admin', '2023-01-05 22:37:16', 'admin', '2023-01-05 22:37:16');
INSERT INTO `sys_log` VALUES (21760, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 96, '116.10.252.177', 'admin', '2023-01-05 22:37:16', 'admin', '2023-01-05 22:37:16');
INSERT INTO `sys_log` VALUES (21761, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 74, '116.10.252.177', 'admin', '2023-01-05 22:37:18', 'admin', '2023-01-05 22:37:18');
INSERT INTO `sys_log` VALUES (21762, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 89, '116.10.252.177', 'admin', '2023-01-05 22:37:18', 'admin', '2023-01-05 22:37:18');
INSERT INTO `sys_log` VALUES (21763, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 81, '116.10.252.177', 'admin', '2023-01-05 22:37:18', 'admin', '2023-01-05 22:37:18');
INSERT INTO `sys_log` VALUES (21764, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 37, '116.10.252.177', 'admin', '2023-01-05 22:37:18', 'admin', '2023-01-05 22:37:18');
INSERT INTO `sys_log` VALUES (21765, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 90, '116.10.252.177', 'admin', '2023-01-05 22:37:19', 'admin', '2023-01-05 22:37:19');
INSERT INTO `sys_log` VALUES (21766, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 93, '116.10.252.177', 'admin', '2023-01-05 22:37:19', 'admin', '2023-01-05 22:37:19');
INSERT INTO `sys_log` VALUES (21767, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 74, '116.10.252.177', 'admin', '2023-01-05 22:37:19', 'admin', '2023-01-05 22:37:19');
INSERT INTO `sys_log` VALUES (21768, 'admin', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 91, '116.10.252.177', 'admin', '2023-01-05 22:37:20', 'admin', '2023-01-05 22:37:20');
INSERT INTO `sys_log` VALUES (21769, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 112, '116.10.252.177', 'admin', '2023-01-05 22:37:21', 'admin', '2023-01-05 22:37:21');
INSERT INTO `sys_log` VALUES (21770, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 121, '116.10.252.177', 'admin', '2023-01-05 22:37:24', 'admin', '2023-01-05 22:37:24');
INSERT INTO `sys_log` VALUES (21771, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 112, '116.10.252.177', 'admin', '2023-01-05 22:37:26', 'admin', '2023-01-05 22:37:26');
INSERT INTO `sys_log` VALUES (21772, 'admin', NULL, 'cn.edu.guet.controller.SysLogController.getList()', '{\"currentPage\":1,\"pageSize\":10}', 112, '116.10.252.177', 'admin', '2023-01-05 22:37:35', 'admin', '2023-01-05 22:37:35');
INSERT INTO `sys_log` VALUES (21773, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.list()', NULL, 96, '116.10.252.177', 'admin', '2023-01-05 22:37:36', 'admin', '2023-01-05 22:37:36');
INSERT INTO `sys_log` VALUES (21774, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.getAllMenu()', NULL, 84, '116.10.252.177', 'admin', '2023-01-05 22:37:37', 'admin', '2023-01-05 22:37:37');
INSERT INTO `sys_log` VALUES (21775, 'admin', NULL, 'cn.edu.guet.controller.SysRoleController.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 136, '116.10.252.177', 'admin', '2023-01-05 22:37:37', 'admin', '2023-01-05 22:37:37');
INSERT INTO `sys_log` VALUES (21776, 'admin', NULL, 'cn.edu.guet.controller.SysRoleController.getList()', '{\"currentPage\":1,\"pageSize\":10,\"roleName\":\"\"}', 76, '116.10.252.177', 'admin', '2023-01-05 22:37:38', 'admin', '2023-01-05 22:37:38');
INSERT INTO `sys_log` VALUES (21777, 'admin', NULL, 'cn.edu.guet.controller.SysRoleController.getOwnMenu()', '\"13\"', 97, '116.10.252.177', 'admin', '2023-01-05 22:37:55', 'admin', '2023-01-05 22:37:55');
INSERT INTO `sys_log` VALUES (21778, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.list()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 121, '116.10.252.177', 'admin', '2023-01-05 22:37:58', 'admin', '2023-01-05 22:37:58');
INSERT INTO `sys_log` VALUES (21779, 'admin', NULL, 'cn.edu.guet.controller.SysRoleController.getListSelect()', NULL, 90, '116.10.252.177', 'admin', '2023-01-05 22:38:00', 'admin', '2023-01-05 22:38:00');
INSERT INTO `sys_log` VALUES (21780, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getRole()', '21', 46, '116.10.252.177', 'admin', '2023-01-05 22:38:00', 'admin', '2023-01-05 22:38:00');
INSERT INTO `sys_log` VALUES (21781, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 318, '1.119.169.88', 'admin', '2023-01-06 10:42:47', 'admin', '2023-01-06 10:42:47');
INSERT INTO `sys_log` VALUES (21782, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 41, '1.119.169.88', 'admin', '2023-01-06 10:42:48', 'admin', '2023-01-06 10:42:48');
INSERT INTO `sys_log` VALUES (21783, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 40, '1.119.169.88', 'admin', '2023-01-06 10:42:48', 'admin', '2023-01-06 10:42:48');
INSERT INTO `sys_log` VALUES (21784, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 120, '1.119.169.88', 'admin', '2023-01-06 10:42:48', 'admin', '2023-01-06 10:42:48');
INSERT INTO `sys_log` VALUES (21785, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.list()', '{\"currentPage\":1,\"nickName\":\"\",\"pageSize\":10,\"phone\":\"\"}', 123, '1.119.169.88', 'admin', '2023-01-06 10:42:54', 'admin', '2023-01-06 10:42:54');
INSERT INTO `sys_log` VALUES (21786, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 118, '1.119.169.88', 'admin', '2023-01-06 10:42:59', 'admin', '2023-01-06 10:42:59');
INSERT INTO `sys_log` VALUES (21787, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 118, '1.119.169.88', 'admin', '2023-01-06 10:43:00', 'admin', '2023-01-06 10:43:00');
INSERT INTO `sys_log` VALUES (21788, 'admin', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 78, '1.119.169.88', 'admin', '2023-01-06 10:43:01', 'admin', '2023-01-06 10:43:01');
INSERT INTO `sys_log` VALUES (21789, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 78, '1.119.169.88', 'admin', '2023-01-06 10:43:02', 'admin', '2023-01-06 10:43:02');
INSERT INTO `sys_log` VALUES (21790, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 93, '1.119.169.88', 'admin', '2023-01-06 10:43:02', 'admin', '2023-01-06 10:43:02');
INSERT INTO `sys_log` VALUES (21791, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 99, '1.119.169.88', 'admin', '2023-01-06 10:43:02', 'admin', '2023-01-06 10:43:02');
INSERT INTO `sys_log` VALUES (21792, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 77, '1.119.169.88', 'admin', '2023-01-06 10:43:03', 'admin', '2023-01-06 10:43:03');
INSERT INTO `sys_log` VALUES (21793, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 98, '1.119.169.88', 'admin', '2023-01-06 10:43:03', 'admin', '2023-01-06 10:43:03');
INSERT INTO `sys_log` VALUES (21794, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 106, '1.119.169.88', 'admin', '2023-01-06 10:43:03', 'admin', '2023-01-06 10:43:03');
INSERT INTO `sys_log` VALUES (21795, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 83, '1.119.169.88', 'admin', '2023-01-06 10:43:05', 'admin', '2023-01-06 10:43:05');
INSERT INTO `sys_log` VALUES (21796, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 93, '1.119.169.88', 'admin', '2023-01-06 10:43:05', 'admin', '2023-01-06 10:43:05');
INSERT INTO `sys_log` VALUES (21797, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 100, '1.119.169.88', 'admin', '2023-01-06 10:43:05', 'admin', '2023-01-06 10:43:05');
INSERT INTO `sys_log` VALUES (21798, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 39, '1.119.169.88', 'admin', '2023-01-06 10:43:05', 'admin', '2023-01-06 10:43:05');
INSERT INTO `sys_log` VALUES (21799, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 78, '1.119.169.88', 'admin', '2023-01-06 10:43:09', 'admin', '2023-01-06 10:43:09');
INSERT INTO `sys_log` VALUES (21800, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 101, '1.119.169.88', 'admin', '2023-01-06 10:43:09', 'admin', '2023-01-06 10:43:09');
INSERT INTO `sys_log` VALUES (21801, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 39, '1.119.169.88', 'admin', '2023-01-06 10:43:09', 'admin', '2023-01-06 10:43:09');
INSERT INTO `sys_log` VALUES (21802, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 92, '1.119.169.88', 'admin', '2023-01-06 10:43:10', 'admin', '2023-01-06 10:43:10');
INSERT INTO `sys_log` VALUES (21803, 'admin', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 100, '1.119.169.88', 'admin', '2023-01-06 10:43:10', 'admin', '2023-01-06 10:43:10');
INSERT INTO `sys_log` VALUES (21804, 'admin', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 95, '1.119.169.88', 'admin', '2023-01-06 10:43:12', 'admin', '2023-01-06 10:43:12');
INSERT INTO `sys_log` VALUES (21805, 'admin', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 101, '1.119.169.88', 'admin', '2023-01-06 10:43:14', 'admin', '2023-01-06 10:43:14');
INSERT INTO `sys_log` VALUES (21806, 'admin', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 95, '1.119.169.88', 'admin', '2023-01-06 10:43:15', 'admin', '2023-01-06 10:43:15');
INSERT INTO `sys_log` VALUES (21807, 'admin', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 79, '1.119.169.88', 'admin', '2023-01-06 10:43:21', 'admin', '2023-01-06 10:43:21');
INSERT INTO `sys_log` VALUES (21808, 'admin', NULL, 'cn.edu.guet.controller.AnalysisDataController.getGoodsNameData()', NULL, 77, '1.119.169.88', 'admin', '2023-01-06 10:43:22', 'admin', '2023-01-06 10:43:22');
INSERT INTO `sys_log` VALUES (21809, 'admin', NULL, 'cn.edu.guet.controller.CashierController.getCashierPurchasePayment()', '1', 79, '1.119.169.88', 'admin', '2023-01-06 10:43:24', 'admin', '2023-01-06 10:43:24');
INSERT INTO `sys_log` VALUES (21810, 'admin', NULL, 'cn.edu.guet.controller.CashierController.getCashierProcessPayment()', '1', 79, '1.119.169.88', 'admin', '2023-01-06 10:43:26', 'admin', '2023-01-06 10:43:26');
INSERT INTO `sys_log` VALUES (21811, 'admin', NULL, 'cn.edu.guet.controller.CashierController.getCashierOfficeExpense()', '1', 100, '1.119.169.88', 'admin', '2023-01-06 10:43:28', 'admin', '2023-01-06 10:43:28');
INSERT INTO `sys_log` VALUES (21812, '韩娜', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"韩娜\"}', 321, '116.252.95.228', '韩娜', '2023-01-06 11:35:00', '韩娜', '2023-01-06 11:35:00');
INSERT INTO `sys_log` VALUES (21813, '韩娜', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"韩娜\"', 44, '116.252.95.228', '韩娜', '2023-01-06 11:35:00', '韩娜', '2023-01-06 11:35:00');
INSERT INTO `sys_log` VALUES (21814, '韩娜', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"韩娜\"', 41, '116.252.95.228', '韩娜', '2023-01-06 11:35:01', '韩娜', '2023-01-06 11:35:01');
INSERT INTO `sys_log` VALUES (21815, '韩娜', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"韩娜\"', 122, '116.252.95.228', '韩娜', '2023-01-06 11:35:01', '韩娜', '2023-01-06 11:35:01');
INSERT INTO `sys_log` VALUES (21816, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 147, '116.252.95.228', '韩娜', '2023-01-06 11:35:10', '韩娜', '2023-01-06 11:35:10');
INSERT INTO `sys_log` VALUES (21817, '韩娜', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 80, '116.252.95.228', '韩娜', '2023-01-06 11:35:21', '韩娜', '2023-01-06 11:35:21');
INSERT INTO `sys_log` VALUES (21818, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 119, '116.252.95.228', '韩娜', '2023-01-06 11:35:24', '韩娜', '2023-01-06 11:35:24');
INSERT INTO `sys_log` VALUES (21819, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 70, '116.252.95.228', '韩娜', '2023-01-06 11:35:27', '韩娜', '2023-01-06 11:35:27');
INSERT INTO `sys_log` VALUES (21820, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 80, '116.252.95.228', '韩娜', '2023-01-06 11:35:27', '韩娜', '2023-01-06 11:35:27');
INSERT INTO `sys_log` VALUES (21821, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 95, '116.252.95.228', '韩娜', '2023-01-06 11:35:27', '韩娜', '2023-01-06 11:35:27');
INSERT INTO `sys_log` VALUES (21822, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 78, '116.252.95.228', '韩娜', '2023-01-06 11:35:29', '韩娜', '2023-01-06 11:35:29');
INSERT INTO `sys_log` VALUES (21823, '韩娜', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 74, '116.252.95.228', '韩娜', '2023-01-06 11:35:29', '韩娜', '2023-01-06 11:35:29');
INSERT INTO `sys_log` VALUES (21824, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 101, '116.252.95.228', '韩娜', '2023-01-06 11:35:29', '韩娜', '2023-01-06 11:35:29');
INSERT INTO `sys_log` VALUES (21825, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 40, '116.252.95.228', '韩娜', '2023-01-06 11:35:29', '韩娜', '2023-01-06 11:35:29');
INSERT INTO `sys_log` VALUES (21826, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 71, '116.252.95.228', '韩娜', '2023-01-06 11:35:31', '韩娜', '2023-01-06 11:35:31');
INSERT INTO `sys_log` VALUES (21827, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 79, '116.252.95.228', '韩娜', '2023-01-06 11:35:31', '韩娜', '2023-01-06 11:35:31');
INSERT INTO `sys_log` VALUES (21828, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 95, '116.252.95.228', '韩娜', '2023-01-06 11:35:31', '韩娜', '2023-01-06 11:35:31');
INSERT INTO `sys_log` VALUES (21829, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 144, '116.252.95.228', '韩娜', '2023-01-06 11:36:05', '韩娜', '2023-01-06 11:36:05');
INSERT INTO `sys_log` VALUES (21830, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"广州市黄埔区黄埔东路5号2411房，收件人：廖小姐收13750105013\",\"customerEnterpriseName\":\"江苏途富新材料有限公司\",\"customerName\":\"周峰\",\"customerPhone\":\"13512741422\",\"id\":21,\"lastUpdateBy\":\"韩娜\"}', 245, '116.252.95.228', '韩娜', '2023-01-06 11:37:49', '韩娜', '2023-01-06 11:37:49');
INSERT INTO `sys_log` VALUES (21831, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 107, '116.252.95.228', '韩娜', '2023-01-06 11:37:49', '韩娜', '2023-01-06 11:37:49');
INSERT INTO `sys_log` VALUES (21832, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"贵港高新区粤桂产业园幸福路1号，公司名称：广西广业贵糖糖业集团有限公司，收件人：陈冬艳，电话：0775-4201668\",\"customerEnterpriseName\":\"广西广业贵糖糖业集团有限公司\",\"customerName\":\"陈冬艳\",\"customerPhone\":\"15977593553\",\"id\":22,\"l...', 292, '116.252.95.228', '韩娜', '2023-01-06 11:39:59', '韩娜', '2023-01-06 11:39:59');
INSERT INTO `sys_log` VALUES (21833, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 119, '116.252.95.228', '韩娜', '2023-01-06 11:39:59', '韩娜', '2023-01-06 11:39:59');
INSERT INTO `sys_log` VALUES (21834, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.updateCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"贵港高新区粤桂产业园幸福路1号，收件人：陈冬艳，电话：0775-4201668\",\"customerEnterpriseName\":\"广西广业贵糖糖业集团有限公司\",\"customerName\":\"陈冬艳\",\"customerPhone\":\"15977593553\",\"id\":22,\"lastUpdateBy\":\"韩娜\"}', 284, '116.252.95.228', '韩娜', '2023-01-06 11:40:16', '韩娜', '2023-01-06 11:40:16');
INSERT INTO `sys_log` VALUES (21835, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 80, '116.252.95.228', '韩娜', '2023-01-06 11:40:16', '韩娜', '2023-01-06 11:40:16');
INSERT INTO `sys_log` VALUES (21836, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"广东省雷州市纪家镇行沟桥\",\"customerEnterpriseName\":\"湛江君实糖业有限公司\",\"customerName\":\"郑然仁\",\"customerPhone\":\"13590009019\",\"id\":23,\"lastUpdateBy\":\"韩娜\"}', 293, '116.252.95.228', '韩娜', '2023-01-06 11:42:12', '韩娜', '2023-01-06 11:42:12');
INSERT INTO `sys_log` VALUES (21837, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 97, '116.252.95.228', '韩娜', '2023-01-06 11:42:12', '韩娜', '2023-01-06 11:42:12');
INSERT INTO `sys_log` VALUES (21838, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"上林忻城糖厂\",\"customerEnterpriseName\":\"忻城南华糖业有限责任公司\",\"customerName\":\"汤受表\",\"customerPhone\":\"13978653242\",\"id\":24,\"lastUpdateBy\":\"韩娜\"}', 256, '116.252.95.228', '韩娜', '2023-01-06 11:44:00', '韩娜', '2023-01-06 11:44:00');
INSERT INTO `sys_log` VALUES (21839, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 90, '116.252.95.228', '韩娜', '2023-01-06 11:44:00', '韩娜', '2023-01-06 11:44:00');
INSERT INTO `sys_log` VALUES (21840, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"广西崇左市濑湍镇中粮崇左糖业有限公司，收件人蒋宏艳18777104191\",\"customerEnterpriseName\":\"中粮崇左糖业有限公司\",\"customerName\":\"林铎\",\"customerPhone\":\"18978815692\",\"id\":25,\"lastUpdateBy\":\"韩娜\"}', 282, '116.252.95.228', '韩娜', '2023-01-06 11:57:50', '韩娜', '2023-01-06 11:57:50');
INSERT INTO `sys_log` VALUES (21841, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 93, '116.252.95.228', '韩娜', '2023-01-06 11:57:50', '韩娜', '2023-01-06 11:57:50');
INSERT INTO `sys_log` VALUES (21842, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"合同收件地址：广西北海市南康镇富康路166号中粮屯河北海糖业有限公司，收件人卢振萍13877990393\",\"customerEnterpriseName\":\"中粮屯河北海糖业有限公司\",\"customerName\":\"黄敏\",\"customerPhone\":\"18877103048\",\"id\":26,\"lastUpdateB...', 279, '116.252.95.228', '韩娜', '2023-01-06 12:01:48', '韩娜', '2023-01-06 12:01:48');
INSERT INTO `sys_log` VALUES (21843, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 93, '116.252.95.228', '韩娜', '2023-01-06 12:01:48', '韩娜', '2023-01-06 12:01:48');
INSERT INTO `sys_log` VALUES (21844, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"霞秀糖厂\",\"customerEnterpriseName\":\"龙州南华糖业有限责任公司\",\"customerName\":\"汤受表\",\"customerPhone\":\"13978653242\",\"id\":27,\"lastUpdateBy\":\"韩娜\"}', 280, '116.252.95.228', '韩娜', '2023-01-06 12:04:49', '韩娜', '2023-01-06 12:04:49');
INSERT INTO `sys_log` VALUES (21845, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 93, '116.252.95.228', '韩娜', '2023-01-06 12:04:49', '韩娜', '2023-01-06 12:04:49');
INSERT INTO `sys_log` VALUES (21846, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 81, '116.252.95.228', '韩娜', '2023-01-06 12:04:53', '韩娜', '2023-01-06 12:04:53');
INSERT INTO `sys_log` VALUES (21847, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 80, '116.252.95.228', '韩娜', '2023-01-06 12:04:53', '韩娜', '2023-01-06 12:04:53');
INSERT INTO `sys_log` VALUES (21848, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 93, '116.252.95.228', '韩娜', '2023-01-06 12:04:53', '韩娜', '2023-01-06 12:04:53');
INSERT INTO `sys_log` VALUES (21849, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"韩娜\",\"customerEnterpriseName\":\"广西广业贵糖糖业集团有限公司\",\"goodsCount\":2000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":195,\"inboundData\":[{\"factoryName\":\"贵糖糖厂\",\"goodsUnitPrice\":1...', 510, '116.252.95.228', '韩娜', '2023-01-06 12:07:25', '韩娜', '2023-01-06 12:07:25');
INSERT INTO `sys_log` VALUES (21850, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 102, '116.252.95.228', '韩娜', '2023-01-06 12:07:25', '韩娜', '2023-01-06 12:07:25');
INSERT INTO `sys_log` VALUES (21851, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"GTXS22/2320221110-002\"', 124, '116.252.95.228', '韩娜', '2023-01-06 12:07:39', '韩娜', '2023-01-06 12:07:39');
INSERT INTO `sys_log` VALUES (21852, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"GTXS22/2320221110-002\"', 122, '116.252.95.228', '韩娜', '2023-01-06 12:07:59', '韩娜', '2023-01-06 12:07:59');
INSERT INTO `sys_log` VALUES (21853, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"GTXS22/2320221110-002\"', 138, '116.252.95.228', '韩娜', '2023-01-06 12:08:20', '韩娜', '2023-01-06 12:08:20');
INSERT INTO `sys_log` VALUES (21854, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.updatePurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"韩娜\",\"createTime\":1672978044000,\"customerEnterpriseName\":\"广西广业贵糖糖业集团有限公司\",\"goodsCount\":2000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":196,\"inboundData\":[{\"factoryName...', 1106, '116.252.95.228', '韩娜', '2023-01-06 12:08:41', '韩娜', '2023-01-06 12:08:41');
INSERT INTO `sys_log` VALUES (21855, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 94, '116.252.95.228', '韩娜', '2023-01-06 12:08:41', '韩娜', '2023-01-06 12:08:41');
INSERT INTO `sys_log` VALUES (21856, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"GTXS22/2320221110-002\"', 137, '116.252.95.228', '韩娜', '2023-01-06 12:09:40', '韩娜', '2023-01-06 12:09:40');
INSERT INTO `sys_log` VALUES (21857, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.updatePurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"韩娜\",\"createTime\":1672978044000,\"customerEnterpriseName\":\"广西广业贵糖糖业集团有限公司\",\"goodsCount\":2000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":197,\"inboundData\":[{\"factoryName...', 1100, '116.252.95.228', '韩娜', '2023-01-06 12:09:47', '韩娜', '2023-01-06 12:09:47');
INSERT INTO `sys_log` VALUES (21858, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 94, '116.252.95.228', '韩娜', '2023-01-06 12:09:47', '韩娜', '2023-01-06 12:09:47');
INSERT INTO `sys_log` VALUES (21859, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"韩娜\",\"customerEnterpriseName\":\"上林南华糖业有限责任公司\",\"goodsCount\":3000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":198,\"inboundData\":[{\"factoryName\":\"上林糖厂\",\"goodsUnitPrice\":140...', 445, '116.252.95.228', '韩娜', '2023-01-06 12:11:46', '韩娜', '2023-01-06 12:11:46');
INSERT INTO `sys_log` VALUES (21860, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 124, '116.252.95.228', '韩娜', '2023-01-06 12:11:47', '韩娜', '2023-01-06 12:11:47');
INSERT INTO `sys_log` VALUES (21861, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.sendExportParm()', NULL, 1, '116.252.95.228', '韩娜', '2023-01-06 12:11:57', '韩娜', '2023-01-06 12:11:57');
INSERT INTO `sys_log` VALUES (21862, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 1147, '116.252.95.228', NULL, '2023-01-06 12:11:59', NULL, '2023-01-06 12:11:59');
INSERT INTO `sys_log` VALUES (21863, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseImportExcel()', NULL, 6215, '116.252.95.228', NULL, '2023-01-06 12:22:14', NULL, '2023-01-06 12:22:14');
INSERT INTO `sys_log` VALUES (21864, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 92, '116.252.95.228', '韩娜', '2023-01-06 12:22:14', '韩娜', '2023-01-06 12:22:14');
INSERT INTO `sys_log` VALUES (21865, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 139, '116.252.95.228', '韩娜', '2023-01-06 12:22:19', '韩娜', '2023-01-06 12:22:19');
INSERT INTO `sys_log` VALUES (21866, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 136, '116.252.95.228', '韩娜', '2023-01-06 12:22:22', '韩娜', '2023-01-06 12:22:22');
INSERT INTO `sys_log` VALUES (21867, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 136, '116.252.95.228', '韩娜', '2023-01-06 12:22:25', '韩娜', '2023-01-06 12:22:25');
INSERT INTO `sys_log` VALUES (21868, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 135, '116.252.95.228', '韩娜', '2023-01-06 12:22:26', '韩娜', '2023-01-06 12:22:26');
INSERT INTO `sys_log` VALUES (21869, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 148, '116.252.95.228', '韩娜', '2023-01-06 12:22:32', '韩娜', '2023-01-06 12:22:32');
INSERT INTO `sys_log` VALUES (21870, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 136, '116.252.95.228', '韩娜', '2023-01-06 12:23:27', '韩娜', '2023-01-06 12:23:27');
INSERT INTO `sys_log` VALUES (21871, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 136, '116.252.95.228', '韩娜', '2023-01-06 12:23:31', '韩娜', '2023-01-06 12:23:31');
INSERT INTO `sys_log` VALUES (21872, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 135, '116.252.95.228', '韩娜', '2023-01-06 12:23:34', '韩娜', '2023-01-06 12:23:34');
INSERT INTO `sys_log` VALUES (21873, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 135, '116.252.95.228', '韩娜', '2023-01-06 12:23:59', '韩娜', '2023-01-06 12:23:59');
INSERT INTO `sys_log` VALUES (21874, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 136, '116.252.95.228', '韩娜', '2023-01-06 12:24:01', '韩娜', '2023-01-06 12:24:01');
INSERT INTO `sys_log` VALUES (21875, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 136, '116.252.95.228', '韩娜', '2023-01-06 12:24:05', '韩娜', '2023-01-06 12:24:05');
INSERT INTO `sys_log` VALUES (21876, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 136, '116.252.95.228', '韩娜', '2023-01-06 12:24:25', '韩娜', '2023-01-06 12:24:25');
INSERT INTO `sys_log` VALUES (21877, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseImportExcel()', NULL, 3864, '116.252.95.228', NULL, '2023-01-06 12:25:03', NULL, '2023-01-06 12:25:03');
INSERT INTO `sys_log` VALUES (21878, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 91, '116.252.95.228', '韩娜', '2023-01-06 12:25:03', '韩娜', '2023-01-06 12:25:03');
INSERT INTO `sys_log` VALUES (21879, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 634, '117.140.240.127', '黄佳森', '2023-01-06 12:28:49', '黄佳森', '2023-01-06 12:28:49');
INSERT INTO `sys_log` VALUES (21880, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 46, '117.140.240.127', '黄佳森', '2023-01-06 12:28:49', '黄佳森', '2023-01-06 12:28:49');
INSERT INTO `sys_log` VALUES (21881, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 46, '117.140.240.127', '黄佳森', '2023-01-06 12:28:49', '黄佳森', '2023-01-06 12:28:49');
INSERT INTO `sys_log` VALUES (21882, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 272, '117.140.240.127', '黄佳森', '2023-01-06 12:28:50', '黄佳森', '2023-01-06 12:28:50');
INSERT INTO `sys_log` VALUES (21883, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 90, '117.140.240.127', '黄佳森', '2023-01-06 12:28:58', '黄佳森', '2023-01-06 12:28:58');
INSERT INTO `sys_log` VALUES (21884, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 137, '117.140.240.127', '黄佳森', '2023-01-06 12:28:58', '黄佳森', '2023-01-06 12:28:58');
INSERT INTO `sys_log` VALUES (21885, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 101, '117.140.240.127', '黄佳森', '2023-01-06 12:28:58', '黄佳森', '2023-01-06 12:28:58');
INSERT INTO `sys_log` VALUES (21886, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseImportExcel()', NULL, 33340, '117.140.240.127', NULL, '2023-01-06 12:29:56', NULL, '2023-01-06 12:29:56');
INSERT INTO `sys_log` VALUES (21887, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 138, '117.140.240.127', '黄佳森', '2023-01-06 12:29:56', '黄佳森', '2023-01-06 12:29:56');
INSERT INTO `sys_log` VALUES (21888, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 103, '117.140.240.127', '黄佳森', '2023-01-06 12:30:57', '黄佳森', '2023-01-06 12:30:57');
INSERT INTO `sys_log` VALUES (21889, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 113, '117.140.240.127', '黄佳森', '2023-01-06 12:30:57', '黄佳森', '2023-01-06 12:30:57');
INSERT INTO `sys_log` VALUES (21890, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 172, '117.140.240.127', '黄佳森', '2023-01-06 12:30:57', '黄佳森', '2023-01-06 12:30:57');
INSERT INTO `sys_log` VALUES (21891, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT11032223000002\"', 109, '117.140.240.127', '黄佳森', '2023-01-06 12:31:01', '黄佳森', '2023-01-06 12:31:01');
INSERT INTO `sys_log` VALUES (21892, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 88, '117.140.240.127', '黄佳森', '2023-01-06 12:31:07', '黄佳森', '2023-01-06 12:31:07');
INSERT INTO `sys_log` VALUES (21893, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 90, '117.140.240.127', '黄佳森', '2023-01-06 12:31:07', '黄佳森', '2023-01-06 12:31:07');
INSERT INTO `sys_log` VALUES (21894, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:31:07', '黄佳森', '2023-01-06 12:31:07');
INSERT INTO `sys_log` VALUES (21895, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:31:15', '黄佳森', '2023-01-06 12:31:15');
INSERT INTO `sys_log` VALUES (21896, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 163, '117.140.240.127', '黄佳森', '2023-01-06 12:31:19', '黄佳森', '2023-01-06 12:31:19');
INSERT INTO `sys_log` VALUES (21897, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 136, '117.140.240.127', '黄佳森', '2023-01-06 12:31:24', '黄佳森', '2023-01-06 12:31:24');
INSERT INTO `sys_log` VALUES (21898, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 138, '117.140.240.127', '黄佳森', '2023-01-06 12:31:25', '黄佳森', '2023-01-06 12:31:25');
INSERT INTO `sys_log` VALUES (21899, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:31:26', '黄佳森', '2023-01-06 12:31:26');
INSERT INTO `sys_log` VALUES (21900, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 136, '117.140.240.127', '黄佳森', '2023-01-06 12:31:28', '黄佳森', '2023-01-06 12:31:28');
INSERT INTO `sys_log` VALUES (21901, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 137, '117.140.240.127', '黄佳森', '2023-01-06 12:31:31', '黄佳森', '2023-01-06 12:31:31');
INSERT INTO `sys_log` VALUES (21902, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 89, '117.140.240.127', '黄佳森', '2023-01-06 12:31:33', '黄佳森', '2023-01-06 12:31:33');
INSERT INTO `sys_log` VALUES (21903, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:31:36', '黄佳森', '2023-01-06 12:31:36');
INSERT INTO `sys_log` VALUES (21904, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:31:39', '黄佳森', '2023-01-06 12:31:39');
INSERT INTO `sys_log` VALUES (21905, '黄佳森', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 89, '117.140.240.127', '黄佳森', '2023-01-06 12:31:49', '黄佳森', '2023-01-06 12:31:49');
INSERT INTO `sys_log` VALUES (21906, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 88, '117.140.240.127', '黄佳森', '2023-01-06 12:31:50', '黄佳森', '2023-01-06 12:31:50');
INSERT INTO `sys_log` VALUES (21907, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 100, '117.140.240.127', '黄佳森', '2023-01-06 12:31:50', '黄佳森', '2023-01-06 12:31:50');
INSERT INTO `sys_log` VALUES (21908, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 138, '117.140.240.127', '黄佳森', '2023-01-06 12:31:50', '黄佳森', '2023-01-06 12:31:50');
INSERT INTO `sys_log` VALUES (21909, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"HT04032223000003\"', 102, '117.140.240.127', '黄佳森', '2023-01-06 12:32:03', '黄佳森', '2023-01-06 12:32:03');
INSERT INTO `sys_log` VALUES (21910, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:32:11', '黄佳森', '2023-01-06 12:32:11');
INSERT INTO `sys_log` VALUES (21911, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 137, '117.140.240.127', '黄佳森', '2023-01-06 12:34:31', '黄佳森', '2023-01-06 12:34:31');
INSERT INTO `sys_log` VALUES (21912, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:34:33', '黄佳森', '2023-01-06 12:34:33');
INSERT INTO `sys_log` VALUES (21913, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:34:33', '黄佳森', '2023-01-06 12:34:33');
INSERT INTO `sys_log` VALUES (21914, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 136, '117.140.240.127', '黄佳森', '2023-01-06 12:34:36', '黄佳森', '2023-01-06 12:34:36');
INSERT INTO `sys_log` VALUES (21915, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"黄佳森\",\"customerAddress\":\"123456\",\"customerEnterpriseName\":\"测试\",\"customerName\":\"1234567\",\"customerPhone\":\"12345678\",\"id\":28,\"lastUpdateBy\":\"黄佳森\"}', 273, '117.140.240.127', '黄佳森', '2023-01-06 12:34:48', '黄佳森', '2023-01-06 12:34:48');
INSERT INTO `sys_log` VALUES (21916, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 91, '117.140.240.127', '黄佳森', '2023-01-06 12:34:49', '黄佳森', '2023-01-06 12:34:49');
INSERT INTO `sys_log` VALUES (21917, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 89, '117.140.240.127', '黄佳森', '2023-01-06 12:34:51', '黄佳森', '2023-01-06 12:34:51');
INSERT INTO `sys_log` VALUES (21918, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 91, '117.140.240.127', '黄佳森', '2023-01-06 12:34:51', '黄佳森', '2023-01-06 12:34:51');
INSERT INTO `sys_log` VALUES (21919, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:34:51', '黄佳森', '2023-01-06 12:34:51');
INSERT INTO `sys_log` VALUES (21920, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 96, '117.140.240.127', '黄佳森', '2023-01-06 12:35:12', '黄佳森', '2023-01-06 12:35:12');
INSERT INTO `sys_log` VALUES (21921, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 107, '117.140.240.127', '黄佳森', '2023-01-06 12:35:12', '黄佳森', '2023-01-06 12:35:12');
INSERT INTO `sys_log` VALUES (21922, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 169, '117.140.240.127', '黄佳森', '2023-01-06 12:35:12', '黄佳森', '2023-01-06 12:35:12');
INSERT INTO `sys_log` VALUES (21923, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:35:16', '黄佳森', '2023-01-06 12:35:16');
INSERT INTO `sys_log` VALUES (21924, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '3', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:35:19', '黄佳森', '2023-01-06 12:35:19');
INSERT INTO `sys_log` VALUES (21925, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '2', 147, '117.140.240.127', '黄佳森', '2023-01-06 12:35:21', '黄佳森', '2023-01-06 12:35:21');
INSERT INTO `sys_log` VALUES (21926, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:35:22', '黄佳森', '2023-01-06 12:35:22');
INSERT INTO `sys_log` VALUES (21927, '黄佳森', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 90, '117.140.240.127', '黄佳森', '2023-01-06 12:35:26', '黄佳森', '2023-01-06 12:35:26');
INSERT INTO `sys_log` VALUES (21928, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 88, '117.140.240.127', '黄佳森', '2023-01-06 12:35:27', '黄佳森', '2023-01-06 12:35:27');
INSERT INTO `sys_log` VALUES (21929, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 100, '117.140.240.127', '黄佳森', '2023-01-06 12:35:27', '黄佳森', '2023-01-06 12:35:27');
INSERT INTO `sys_log` VALUES (21930, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 138, '117.140.240.127', '黄佳森', '2023-01-06 12:35:27', '黄佳森', '2023-01-06 12:35:27');
INSERT INTO `sys_log` VALUES (21931, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"黄佳森\",\"customerEnterpriseName\":\"测试\",\"goodsCount\":100,\"goodsName\":\"测试\",\"goodsUnit\":\"吨\",\"id\":253,\"inboundData\":[{\"factoryName\":\"A厂\",\"goodsUnitPrice\":1000,\"inboundGood...', 497, '117.140.240.127', '黄佳森', '2023-01-06 12:36:08', '黄佳森', '2023-01-06 12:36:08');
INSERT INTO `sys_log` VALUES (21932, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 153, '117.140.240.127', '黄佳森', '2023-01-06 12:36:08', '黄佳森', '2023-01-06 12:36:08');
INSERT INTO `sys_log` VALUES (21933, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 155, '117.140.240.127', '黄佳森', '2023-01-06 12:36:10', '黄佳森', '2023-01-06 12:36:10');
INSERT INTO `sys_log` VALUES (21934, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 137, '117.140.240.127', '黄佳森', '2023-01-06 12:36:11', '黄佳森', '2023-01-06 12:36:11');
INSERT INTO `sys_log` VALUES (21935, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.deleteOneCustomer()', '28', 274, '117.140.240.127', '黄佳森', '2023-01-06 12:36:15', '黄佳森', '2023-01-06 12:36:15');
INSERT INTO `sys_log` VALUES (21936, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 91, '117.140.240.127', '黄佳森', '2023-01-06 12:36:15', '黄佳森', '2023-01-06 12:36:15');
INSERT INTO `sys_log` VALUES (21937, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 93, '117.140.240.127', '黄佳森', '2023-01-06 12:36:17', '黄佳森', '2023-01-06 12:36:17');
INSERT INTO `sys_log` VALUES (21938, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 101, '117.140.240.127', '黄佳森', '2023-01-06 12:36:17', '黄佳森', '2023-01-06 12:36:17');
INSERT INTO `sys_log` VALUES (21939, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 143, '117.140.240.127', '黄佳森', '2023-01-06 12:36:17', '黄佳森', '2023-01-06 12:36:17');
INSERT INTO `sys_log` VALUES (21940, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.deleteOnePurchaseContract()', '253', 876, '117.140.240.127', '黄佳森', '2023-01-06 12:36:32', '黄佳森', '2023-01-06 12:36:32');
INSERT INTO `sys_log` VALUES (21941, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:36:32', '黄佳森', '2023-01-06 12:36:32');
INSERT INTO `sys_log` VALUES (21942, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 137, '117.140.240.127', '黄佳森', '2023-01-06 12:37:27', '黄佳森', '2023-01-06 12:37:27');
INSERT INTO `sys_log` VALUES (21943, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 154, '117.140.240.127', '黄佳森', '2023-01-06 12:37:28', '黄佳森', '2023-01-06 12:37:28');
INSERT INTO `sys_log` VALUES (21944, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 136, '117.140.240.127', '黄佳森', '2023-01-06 12:37:30', '黄佳森', '2023-01-06 12:37:30');
INSERT INTO `sys_log` VALUES (21945, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:37:33', '黄佳森', '2023-01-06 12:37:33');
INSERT INTO `sys_log` VALUES (21946, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:37:35', '黄佳森', '2023-01-06 12:37:35');
INSERT INTO `sys_log` VALUES (21947, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 138, '117.140.240.127', '黄佳森', '2023-01-06 12:37:42', '黄佳森', '2023-01-06 12:37:42');
INSERT INTO `sys_log` VALUES (21948, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:37:43', '黄佳森', '2023-01-06 12:37:43');
INSERT INTO `sys_log` VALUES (21949, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 144, '117.140.240.127', '黄佳森', '2023-01-06 12:37:44', '黄佳森', '2023-01-06 12:37:44');
INSERT INTO `sys_log` VALUES (21950, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 135, '117.140.240.127', '黄佳森', '2023-01-06 12:37:44', '黄佳森', '2023-01-06 12:37:44');
INSERT INTO `sys_log` VALUES (21951, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 136, '117.140.240.127', '黄佳森', '2023-01-06 12:37:52', '黄佳森', '2023-01-06 12:37:52');
INSERT INTO `sys_log` VALUES (21952, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 137, '117.140.240.127', '黄佳森', '2023-01-06 12:37:56', '黄佳森', '2023-01-06 12:37:56');
INSERT INTO `sys_log` VALUES (21953, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 135, '116.252.95.228', '韩娜', '2023-01-06 12:39:22', '韩娜', '2023-01-06 12:39:22');
INSERT INTO `sys_log` VALUES (21954, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 135, '116.252.95.228', '韩娜', '2023-01-06 12:39:24', '韩娜', '2023-01-06 12:39:24');
INSERT INTO `sys_log` VALUES (21955, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 153, '116.252.95.228', '韩娜', '2023-01-06 12:39:25', '韩娜', '2023-01-06 12:39:25');
INSERT INTO `sys_log` VALUES (21956, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 135, '116.252.95.228', '韩娜', '2023-01-06 12:39:36', '韩娜', '2023-01-06 12:39:36');
INSERT INTO `sys_log` VALUES (21957, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"HT04032223000003\"', 102, '116.252.95.228', '韩娜', '2023-01-06 12:39:52', '韩娜', '2023-01-06 12:39:52');
INSERT INTO `sys_log` VALUES (21958, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 136, '116.252.95.228', '韩娜', '2023-01-06 12:40:30', '韩娜', '2023-01-06 12:40:30');
INSERT INTO `sys_log` VALUES (21959, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"南圩糖厂\",\"customerEnterpriseName\":\"广西隆安南华糖业有限责任公司\",\"customerName\":\"汤受表\",\"customerPhone\":\"13978653242\",\"id\":29,\"lastUpdateBy\":\"韩娜\"}', 277, '116.252.95.228', '韩娜', '2023-01-06 12:41:39', '韩娜', '2023-01-06 12:41:39');
INSERT INTO `sys_log` VALUES (21960, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 153, '116.252.95.228', '韩娜', '2023-01-06 12:41:39', '韩娜', '2023-01-06 12:41:39');
INSERT INTO `sys_log` VALUES (21961, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 101, '116.252.95.228', '韩娜', '2023-01-06 12:41:53', '韩娜', '2023-01-06 12:41:53');
INSERT INTO `sys_log` VALUES (21962, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 137, '116.252.95.228', '韩娜', '2023-01-06 12:41:53', '韩娜', '2023-01-06 12:41:53');
INSERT INTO `sys_log` VALUES (21963, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 101, '116.252.95.228', '韩娜', '2023-01-06 12:41:53', '韩娜', '2023-01-06 12:41:53');
INSERT INTO `sys_log` VALUES (21964, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"HT04032223000003\"', 102, '116.252.95.228', '韩娜', '2023-01-06 12:41:56', '韩娜', '2023-01-06 12:41:56');
INSERT INTO `sys_log` VALUES (21965, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 421, '116.10.252.177', 'admin', '2023-01-06 12:42:48', 'admin', '2023-01-06 12:42:48');
INSERT INTO `sys_log` VALUES (21966, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 51, '116.10.252.177', 'admin', '2023-01-06 12:42:49', 'admin', '2023-01-06 12:42:49');
INSERT INTO `sys_log` VALUES (21967, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 51, '116.10.252.177', 'admin', '2023-01-06 12:42:49', 'admin', '2023-01-06 12:42:49');
INSERT INTO `sys_log` VALUES (21968, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 153, '116.10.252.177', 'admin', '2023-01-06 12:42:49', 'admin', '2023-01-06 12:42:49');
INSERT INTO `sys_log` VALUES (21969, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 84, '116.10.252.177', 'admin', '2023-01-06 12:42:52', 'admin', '2023-01-06 12:42:52');
INSERT INTO `sys_log` VALUES (21970, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 85, '116.10.252.177', 'admin', '2023-01-06 12:42:52', 'admin', '2023-01-06 12:42:52');
INSERT INTO `sys_log` VALUES (21971, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 153, '116.10.252.177', 'admin', '2023-01-06 12:42:52', 'admin', '2023-01-06 12:42:52');
INSERT INTO `sys_log` VALUES (21972, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 101, '116.10.252.177', 'admin', '2023-01-06 12:42:58', 'admin', '2023-01-06 12:42:58');
INSERT INTO `sys_log` VALUES (21973, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.updatePurchaseContract()', '{\"contractPhotoArray\":[],\"createTime\":1672978933000,\"customerEnterpriseName\":\"广西隆安南华糖业有限责任公司\",\"goodsCount\":1000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":254,\"inboundData\":[{\"factoryName\":\"南圩糖厂\",\"goodsU...', 794, '116.252.95.228', '韩娜', '2023-01-06 12:43:24', '韩娜', '2023-01-06 12:43:24');
INSERT INTO `sys_log` VALUES (21974, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 131, '116.252.95.228', '韩娜', '2023-01-06 12:43:24', '韩娜', '2023-01-06 12:43:24');
INSERT INTO `sys_log` VALUES (21975, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"admin\",\"customerEnterpriseName\":\"忻城南华糖业有限责任公司\",\"goodsCount\":1,\"goodsName\":\"1\",\"goodsUnit\":\"斤\",\"id\":255,\"inboundData\":[{\"factoryName\":\"1\",\"goodsUnitPrice\":1,\"inboun...', 560, '116.10.252.177', 'admin', '2023-01-06 12:43:30', 'admin', '2023-01-06 12:43:30');
INSERT INTO `sys_log` VALUES (21976, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 103, '116.10.252.177', 'admin', '2023-01-06 12:43:30', 'admin', '2023-01-06 12:43:30');
INSERT INTO `sys_log` VALUES (21977, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.deleteOnePurchaseContract()', '255', 862, '116.10.252.177', 'admin', '2023-01-06 12:43:35', 'admin', '2023-01-06 12:43:35');
INSERT INTO `sys_log` VALUES (21978, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 131, '116.10.252.177', 'admin', '2023-01-06 12:43:36', 'admin', '2023-01-06 12:43:36');
INSERT INTO `sys_log` VALUES (21979, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"admin\",\"customerEnterpriseName\":\"广西丰沣顺国际物流有限公司\",\"goodsCount\":1,\"goodsName\":\"1\",\"goodsUnit\":\"吨\",\"id\":256,\"inboundData\":[{\"factoryName\":\"1\",\"goodsUnitPrice\":1,\"inbou...', 480, '116.10.252.177', 'admin', '2023-01-06 12:44:01', 'admin', '2023-01-06 12:44:01');
INSERT INTO `sys_log` VALUES (21980, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 88, '116.10.252.177', 'admin', '2023-01-06 12:44:02', 'admin', '2023-01-06 12:44:02');
INSERT INTO `sys_log` VALUES (21981, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.deleteOnePurchaseContract()', '256', 781, '116.10.252.177', 'admin', '2023-01-06 12:44:05', 'admin', '2023-01-06 12:44:05');
INSERT INTO `sys_log` VALUES (21982, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 97, '116.10.252.177', 'admin', '2023-01-06 12:44:05', 'admin', '2023-01-06 12:44:05');
INSERT INTO `sys_log` VALUES (21983, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 139, '116.252.95.228', '韩娜', '2023-01-06 12:44:09', '韩娜', '2023-01-06 12:44:09');
INSERT INTO `sys_log` VALUES (21984, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '2', 136, '116.252.95.228', '韩娜', '2023-01-06 12:44:13', '韩娜', '2023-01-06 12:44:13');
INSERT INTO `sys_log` VALUES (21985, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '3', 135, '116.252.95.228', '韩娜', '2023-01-06 12:44:17', '韩娜', '2023-01-06 12:44:17');
INSERT INTO `sys_log` VALUES (21986, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 142, '116.252.95.228', '韩娜', '2023-01-06 12:44:24', '韩娜', '2023-01-06 12:44:24');
INSERT INTO `sys_log` VALUES (21987, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 77, '116.10.252.177', 'admin', '2023-01-06 12:44:42', 'admin', '2023-01-06 12:44:42');
INSERT INTO `sys_log` VALUES (21988, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 86, '116.10.252.177', 'admin', '2023-01-06 12:44:42', 'admin', '2023-01-06 12:44:42');
INSERT INTO `sys_log` VALUES (21989, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 109, '116.10.252.177', 'admin', '2023-01-06 12:44:42', 'admin', '2023-01-06 12:44:42');
INSERT INTO `sys_log` VALUES (21990, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 56, '116.10.252.177', 'admin', '2023-01-06 12:44:42', 'admin', '2023-01-06 12:44:42');
INSERT INTO `sys_log` VALUES (21991, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 82, '116.10.252.177', 'admin', '2023-01-06 12:44:43', 'admin', '2023-01-06 12:44:43');
INSERT INTO `sys_log` VALUES (21992, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 77, '116.10.252.177', 'admin', '2023-01-06 12:44:43', 'admin', '2023-01-06 12:44:43');
INSERT INTO `sys_log` VALUES (21993, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '116.10.252.177', 'admin', '2023-01-06 12:44:43', 'admin', '2023-01-06 12:44:43');
INSERT INTO `sys_log` VALUES (21994, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 76, '116.10.252.177', 'admin', '2023-01-06 12:44:45', 'admin', '2023-01-06 12:44:45');
INSERT INTO `sys_log` VALUES (21995, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '116.10.252.177', 'admin', '2023-01-06 12:44:45', 'admin', '2023-01-06 12:44:45');
INSERT INTO `sys_log` VALUES (21996, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 135, '116.10.252.177', 'admin', '2023-01-06 12:44:45', 'admin', '2023-01-06 12:44:45');
INSERT INTO `sys_log` VALUES (21997, '韩娜', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 92, '116.252.95.228', '韩娜', '2023-01-06 12:44:48', '韩娜', '2023-01-06 12:44:48');
INSERT INTO `sys_log` VALUES (21998, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 139, '116.252.95.228', '韩娜', '2023-01-06 12:44:52', '韩娜', '2023-01-06 12:44:52');
INSERT INTO `sys_log` VALUES (21999, '韩娜', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 92, '116.252.95.228', '韩娜', '2023-01-06 12:44:53', '韩娜', '2023-01-06 12:44:53');
INSERT INTO `sys_log` VALUES (22000, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 76, '116.252.95.228', '韩娜', '2023-01-06 12:44:57', '韩娜', '2023-01-06 12:44:57');
INSERT INTO `sys_log` VALUES (22001, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 125, '116.252.95.228', '韩娜', '2023-01-06 12:44:57', '韩娜', '2023-01-06 12:44:57');
INSERT INTO `sys_log` VALUES (22002, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '116.252.95.228', '韩娜', '2023-01-06 12:44:57', '韩娜', '2023-01-06 12:44:57');
INSERT INTO `sys_log` VALUES (22003, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 76, '116.252.95.228', '韩娜', '2023-01-06 12:45:00', '韩娜', '2023-01-06 12:45:00');
INSERT INTO `sys_log` VALUES (22004, '韩娜', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 82, '116.252.95.228', '韩娜', '2023-01-06 12:45:00', '韩娜', '2023-01-06 12:45:00');
INSERT INTO `sys_log` VALUES (22005, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '116.252.95.228', '韩娜', '2023-01-06 12:45:00', '韩娜', '2023-01-06 12:45:00');
INSERT INTO `sys_log` VALUES (22006, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 41, '116.252.95.228', '韩娜', '2023-01-06 12:45:00', '韩娜', '2023-01-06 12:45:00');
INSERT INTO `sys_log` VALUES (22007, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 91, '116.252.95.228', '韩娜', '2023-01-06 12:45:05', '韩娜', '2023-01-06 12:45:05');
INSERT INTO `sys_log` VALUES (22008, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 129, '116.10.252.177', 'admin', '2023-01-06 12:50:12', 'admin', '2023-01-06 12:50:12');
INSERT INTO `sys_log` VALUES (22009, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 118, '116.10.252.177', 'admin', '2023-01-06 12:50:29', 'admin', '2023-01-06 12:50:29');
INSERT INTO `sys_log` VALUES (22010, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 119, '116.10.252.177', 'admin', '2023-01-06 12:50:33', 'admin', '2023-01-06 12:50:33');
INSERT INTO `sys_log` VALUES (22011, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 99, '116.10.252.177', 'admin', '2023-01-06 12:50:33', 'admin', '2023-01-06 12:50:33');
INSERT INTO `sys_log` VALUES (22012, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 98, '116.10.252.177', 'admin', '2023-01-06 12:50:33', 'admin', '2023-01-06 12:50:33');
INSERT INTO `sys_log` VALUES (22013, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.sendExportParm()', NULL, 0, '116.10.252.177', 'admin', '2023-01-06 12:50:50', 'admin', '2023-01-06 12:50:50');
INSERT INTO `sys_log` VALUES (22014, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 273, '116.10.252.177', NULL, '2023-01-06 12:50:50', NULL, '2023-01-06 12:50:50');
INSERT INTO `sys_log` VALUES (22015, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 210, '116.10.252.177', NULL, '2023-01-06 12:50:51', NULL, '2023-01-06 12:50:51');
INSERT INTO `sys_log` VALUES (22016, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 248, '116.10.252.177', NULL, '2023-01-06 12:50:51', NULL, '2023-01-06 12:50:51');
INSERT INTO `sys_log` VALUES (22017, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 198, '116.10.252.177', NULL, '2023-01-06 12:50:52', NULL, '2023-01-06 12:50:52');
INSERT INTO `sys_log` VALUES (22018, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 173, '116.10.252.177', NULL, '2023-01-06 12:50:52', NULL, '2023-01-06 12:50:52');
INSERT INTO `sys_log` VALUES (22019, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseExportExcel()', NULL, 193, '180.163.29.206', NULL, '2023-01-06 12:51:50', NULL, '2023-01-06 12:51:50');
INSERT INTO `sys_log` VALUES (22020, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 118, '116.252.95.228', '韩娜', '2023-01-06 12:55:06', '韩娜', '2023-01-06 12:55:06');
INSERT INTO `sys_log` VALUES (22021, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 98, '116.252.95.228', '韩娜', '2023-01-06 12:55:06', '韩娜', '2023-01-06 12:55:06');
INSERT INTO `sys_log` VALUES (22022, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 98, '116.252.95.228', '韩娜', '2023-01-06 12:55:06', '韩娜', '2023-01-06 12:55:06');
INSERT INTO `sys_log` VALUES (22023, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 119, '116.252.95.228', '韩娜', '2023-01-06 12:55:17', '韩娜', '2023-01-06 12:55:17');
INSERT INTO `sys_log` VALUES (22024, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 119, '116.252.95.228', '韩娜', '2023-01-06 12:55:21', '韩娜', '2023-01-06 12:55:21');
INSERT INTO `sys_log` VALUES (22025, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 149, '116.252.95.228', '韩娜', '2023-01-06 12:55:25', '韩娜', '2023-01-06 12:55:25');
INSERT INTO `sys_log` VALUES (22026, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"HT05032223000004\"', 78, '116.252.95.228', '韩娜', '2023-01-06 12:57:31', '韩娜', '2023-01-06 12:57:31');
INSERT INTO `sys_log` VALUES (22027, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.updatePurchaseContract()', '{\"contractPhotoArray\":[],\"createTime\":1672978930000,\"customerEnterpriseName\":\"上林南华糖业有限责任公司\",\"goodsCount\":5000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":257,\"inboundData\":[{\"factoryName\":\"上林糖厂\",\"goodsUni...', 944, '116.252.95.228', '韩娜', '2023-01-06 12:58:37', '韩娜', '2023-01-06 12:58:37');
INSERT INTO `sys_log` VALUES (22028, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 100, '116.252.95.228', '韩娜', '2023-01-06 12:58:37', '韩娜', '2023-01-06 12:58:37');
INSERT INTO `sys_log` VALUES (22029, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '3', 82, '116.252.95.228', '韩娜', '2023-01-06 12:59:18', '韩娜', '2023-01-06 12:59:18');
INSERT INTO `sys_log` VALUES (22030, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '1', 53, '116.252.95.228', '韩娜', '2023-01-06 12:59:18', '韩娜', '2023-01-06 12:59:18');
INSERT INTO `sys_log` VALUES (22031, '韩娜', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 98, '116.252.95.228', '韩娜', '2023-01-06 12:59:42', '韩娜', '2023-01-06 12:59:42');
INSERT INTO `sys_log` VALUES (22032, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 77, '116.252.95.228', '韩娜', '2023-01-06 12:59:43', '韩娜', '2023-01-06 12:59:43');
INSERT INTO `sys_log` VALUES (22033, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 97, '116.252.95.228', '韩娜', '2023-01-06 12:59:43', '韩娜', '2023-01-06 12:59:43');
INSERT INTO `sys_log` VALUES (22034, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 149, '116.252.95.228', '韩娜', '2023-01-06 12:59:43', '韩娜', '2023-01-06 12:59:43');
INSERT INTO `sys_log` VALUES (22035, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '1', 99, '116.252.95.228', '韩娜', '2023-01-06 12:59:56', '韩娜', '2023-01-06 12:59:56');
INSERT INTO `sys_log` VALUES (22036, '韩娜', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 100, '116.252.95.228', '韩娜', '2023-01-06 13:00:06', '韩娜', '2023-01-06 13:00:06');
INSERT INTO `sys_log` VALUES (22037, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 97, '116.252.95.228', '韩娜', '2023-01-06 13:00:07', '韩娜', '2023-01-06 13:00:07');
INSERT INTO `sys_log` VALUES (22038, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 98, '116.252.95.228', '韩娜', '2023-01-06 13:00:07', '韩娜', '2023-01-06 13:00:07');
INSERT INTO `sys_log` VALUES (22039, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 119, '116.252.95.228', '韩娜', '2023-01-06 13:00:07', '韩娜', '2023-01-06 13:00:07');
INSERT INTO `sys_log` VALUES (22040, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 118, '116.252.95.228', '韩娜', '2023-01-06 13:00:17', '韩娜', '2023-01-06 13:00:17');
INSERT INTO `sys_log` VALUES (22041, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 148, '116.252.95.228', '韩娜', '2023-01-06 13:00:20', '韩娜', '2023-01-06 13:00:20');
INSERT INTO `sys_log` VALUES (22042, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT05032223000004\"', 148, '116.252.95.228', '韩娜', '2023-01-06 13:00:22', '韩娜', '2023-01-06 13:00:22');
INSERT INTO `sys_log` VALUES (22043, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 317, '1.119.169.88', 'admin', '2023-01-06 13:03:57', 'admin', '2023-01-06 13:03:57');
INSERT INTO `sys_log` VALUES (22044, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 40, '1.119.169.88', 'admin', '2023-01-06 13:03:57', 'admin', '2023-01-06 13:03:57');
INSERT INTO `sys_log` VALUES (22045, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 39, '1.119.169.88', 'admin', '2023-01-06 13:03:58', 'admin', '2023-01-06 13:03:58');
INSERT INTO `sys_log` VALUES (22046, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 199, '1.119.169.88', 'admin', '2023-01-06 13:03:58', 'admin', '2023-01-06 13:03:58');
INSERT INTO `sys_log` VALUES (22047, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 123, '1.119.169.88', 'admin', '2023-01-06 13:04:00', 'admin', '2023-01-06 13:04:00');
INSERT INTO `sys_log` VALUES (22048, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 97, '1.119.169.88', 'admin', '2023-01-06 13:04:00', 'admin', '2023-01-06 13:04:00');
INSERT INTO `sys_log` VALUES (22049, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 101, '1.119.169.88', 'admin', '2023-01-06 13:04:00', 'admin', '2023-01-06 13:04:00');
INSERT INTO `sys_log` VALUES (22050, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 149, '1.119.169.88', 'admin', '2023-01-06 13:04:05', 'admin', '2023-01-06 13:04:05');
INSERT INTO `sys_log` VALUES (22051, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 149, '1.119.169.88', 'admin', '2023-01-06 13:04:06', 'admin', '2023-01-06 13:04:06');
INSERT INTO `sys_log` VALUES (22052, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 119, '1.119.169.88', 'admin', '2023-01-06 13:04:07', 'admin', '2023-01-06 13:04:07');
INSERT INTO `sys_log` VALUES (22053, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 149, '1.119.169.88', 'admin', '2023-01-06 13:04:10', 'admin', '2023-01-06 13:04:10');
INSERT INTO `sys_log` VALUES (22054, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 148, '1.119.169.88', 'admin', '2023-01-06 13:04:16', 'admin', '2023-01-06 13:04:16');
INSERT INTO `sys_log` VALUES (22055, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 149, '1.119.169.88', 'admin', '2023-01-06 13:04:32', 'admin', '2023-01-06 13:04:32');
INSERT INTO `sys_log` VALUES (22056, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 394, '116.10.252.177', 'admin', '2023-01-06 13:04:41', 'admin', '2023-01-06 13:04:41');
INSERT INTO `sys_log` VALUES (22057, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 49, '116.10.252.177', 'admin', '2023-01-06 13:04:41', 'admin', '2023-01-06 13:04:41');
INSERT INTO `sys_log` VALUES (22058, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 99, '116.10.252.177', 'admin', '2023-01-06 13:04:41', 'admin', '2023-01-06 13:04:41');
INSERT INTO `sys_log` VALUES (22059, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 149, '116.10.252.177', 'admin', '2023-01-06 13:04:42', 'admin', '2023-01-06 13:04:42');
INSERT INTO `sys_log` VALUES (22060, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 118, '1.119.169.88', 'admin', '2023-01-06 13:04:42', 'admin', '2023-01-06 13:04:42');
INSERT INTO `sys_log` VALUES (22061, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 148, '1.119.169.88', 'admin', '2023-01-06 13:04:44', 'admin', '2023-01-06 13:04:44');
INSERT INTO `sys_log` VALUES (22062, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 78, '116.10.252.177', 'admin', '2023-01-06 13:04:45', 'admin', '2023-01-06 13:04:45');
INSERT INTO `sys_log` VALUES (22063, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 97, '116.10.252.177', 'admin', '2023-01-06 13:04:45', 'admin', '2023-01-06 13:04:45');
INSERT INTO `sys_log` VALUES (22064, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 149, '116.10.252.177', 'admin', '2023-01-06 13:04:45', 'admin', '2023-01-06 13:04:45');
INSERT INTO `sys_log` VALUES (22065, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 119, '116.10.252.177', 'admin', '2023-01-06 13:04:47', 'admin', '2023-01-06 13:04:47');
INSERT INTO `sys_log` VALUES (22066, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 78, '1.119.169.88', 'admin', '2023-01-06 13:04:56', 'admin', '2023-01-06 13:04:56');
INSERT INTO `sys_log` VALUES (22067, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 98, '1.119.169.88', 'admin', '2023-01-06 13:04:56', 'admin', '2023-01-06 13:04:56');
INSERT INTO `sys_log` VALUES (22068, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 98, '1.119.169.88', 'admin', '2023-01-06 13:04:56', 'admin', '2023-01-06 13:04:56');
INSERT INTO `sys_log` VALUES (22069, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 78, '1.119.169.88', 'admin', '2023-01-06 13:04:58', 'admin', '2023-01-06 13:04:58');
INSERT INTO `sys_log` VALUES (22070, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 99, '1.119.169.88', 'admin', '2023-01-06 13:04:58', 'admin', '2023-01-06 13:04:58');
INSERT INTO `sys_log` VALUES (22071, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 98, '1.119.169.88', 'admin', '2023-01-06 13:04:58', 'admin', '2023-01-06 13:04:58');
INSERT INTO `sys_log` VALUES (22072, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 50, '1.119.169.88', 'admin', '2023-01-06 13:04:58', 'admin', '2023-01-06 13:04:58');
INSERT INTO `sys_log` VALUES (22073, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 77, '1.119.169.88', 'admin', '2023-01-06 13:05:03', 'admin', '2023-01-06 13:05:03');
INSERT INTO `sys_log` VALUES (22074, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 97, '1.119.169.88', 'admin', '2023-01-06 13:05:03', 'admin', '2023-01-06 13:05:03');
INSERT INTO `sys_log` VALUES (22075, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 99, '1.119.169.88', 'admin', '2023-01-06 13:05:03', 'admin', '2023-01-06 13:05:03');
INSERT INTO `sys_log` VALUES (22076, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 77, '1.119.169.88', 'admin', '2023-01-06 13:05:08', 'admin', '2023-01-06 13:05:08');
INSERT INTO `sys_log` VALUES (22077, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 97, '1.119.169.88', 'admin', '2023-01-06 13:05:08', 'admin', '2023-01-06 13:05:08');
INSERT INTO `sys_log` VALUES (22078, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 98, '1.119.169.88', 'admin', '2023-01-06 13:05:08', 'admin', '2023-01-06 13:05:08');
INSERT INTO `sys_log` VALUES (22079, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 49, '1.119.169.88', 'admin', '2023-01-06 13:05:09', 'admin', '2023-01-06 13:05:09');
INSERT INTO `sys_log` VALUES (22080, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"YX-JL-2022123001\"', 98, '116.10.252.177', 'admin', '2023-01-06 13:05:48', 'admin', '2023-01-06 13:05:48');
INSERT INTO `sys_log` VALUES (22081, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 147, '116.10.252.177', 'admin', '2023-01-06 13:05:51', 'admin', '2023-01-06 13:05:51');
INSERT INTO `sys_log` VALUES (22082, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getFPurchaseContractData()', '1', 99, '116.10.252.177', 'admin', '2023-01-06 13:08:49', 'admin', '2023-01-06 13:08:49');
INSERT INTO `sys_log` VALUES (22083, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 149, '116.10.252.177', 'admin', '2023-01-06 13:08:50', 'admin', '2023-01-06 13:08:50');
INSERT INTO `sys_log` VALUES (22084, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 150, '116.10.252.177', 'admin', '2023-01-06 13:09:52', 'admin', '2023-01-06 13:09:52');
INSERT INTO `sys_log` VALUES (22085, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '1', 99, '116.10.252.177', 'admin', '2023-01-06 13:09:58', 'admin', '2023-01-06 13:09:58');
INSERT INTO `sys_log` VALUES (22086, 'admin', NULL, 'cn.edu.guet.controller.ownWarehouseController.getFPurchaseContractData()', '1', 99, '116.10.252.177', 'admin', '2023-01-06 13:10:54', 'admin', '2023-01-06 13:10:54');
INSERT INTO `sys_log` VALUES (22087, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 91, '116.10.252.177', 'admin', '2023-01-06 13:10:55', 'admin', '2023-01-06 13:10:55');
INSERT INTO `sys_log` VALUES (22088, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 109, '116.10.252.177', 'admin', '2023-01-06 13:10:55', 'admin', '2023-01-06 13:10:55');
INSERT INTO `sys_log` VALUES (22089, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 155, '116.10.252.177', 'admin', '2023-01-06 13:10:55', 'admin', '2023-01-06 13:10:55');
INSERT INTO `sys_log` VALUES (22090, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 149, '116.10.252.177', 'admin', '2023-01-06 13:10:56', 'admin', '2023-01-06 13:10:56');
INSERT INTO `sys_log` VALUES (22091, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 148, '116.10.252.177', 'admin', '2023-01-06 13:11:26', 'admin', '2023-01-06 13:11:26');
INSERT INTO `sys_log` VALUES (22092, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '1', 99, '116.10.252.177', 'admin', '2023-01-06 13:11:35', 'admin', '2023-01-06 13:11:35');
INSERT INTO `sys_log` VALUES (22093, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 80, '116.10.252.177', 'admin', '2023-01-06 13:12:21', 'admin', '2023-01-06 13:12:21');
INSERT INTO `sys_log` VALUES (22094, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 79, '116.10.252.177', 'admin', '2023-01-06 13:12:21', 'admin', '2023-01-06 13:12:21');
INSERT INTO `sys_log` VALUES (22095, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 100, '116.10.252.177', 'admin', '2023-01-06 13:12:21', 'admin', '2023-01-06 13:12:21');
INSERT INTO `sys_log` VALUES (22096, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 78, '116.10.252.177', 'admin', '2023-01-06 13:12:21', 'admin', '2023-01-06 13:12:21');
INSERT INTO `sys_log` VALUES (22097, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 100, '116.10.252.177', 'admin', '2023-01-06 13:12:21', 'admin', '2023-01-06 13:12:21');
INSERT INTO `sys_log` VALUES (22098, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 120, '116.10.252.177', 'admin', '2023-01-06 13:12:21', 'admin', '2023-01-06 13:12:21');
INSERT INTO `sys_log` VALUES (22099, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '1', 121, '116.10.252.177', 'admin', '2023-01-06 13:12:27', 'admin', '2023-01-06 13:12:27');
INSERT INTO `sys_log` VALUES (22100, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.searchPurchaseContract()', '1', 156, '116.10.252.177', 'admin', '2023-01-06 13:12:31', 'admin', '2023-01-06 13:12:31');
INSERT INTO `sys_log` VALUES (22101, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 326, '116.10.252.177', 'admin', '2023-01-06 13:16:36', 'admin', '2023-01-06 13:16:36');
INSERT INTO `sys_log` VALUES (22102, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 41, '116.10.252.177', 'admin', '2023-01-06 13:16:36', 'admin', '2023-01-06 13:16:36');
INSERT INTO `sys_log` VALUES (22103, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 40, '116.10.252.177', 'admin', '2023-01-06 13:16:36', 'admin', '2023-01-06 13:16:36');
INSERT INTO `sys_log` VALUES (22104, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 119, '116.10.252.177', 'admin', '2023-01-06 13:16:36', 'admin', '2023-01-06 13:16:36');
INSERT INTO `sys_log` VALUES (22105, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 84, '116.10.252.177', 'admin', '2023-01-06 13:16:38', 'admin', '2023-01-06 13:16:38');
INSERT INTO `sys_log` VALUES (22106, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 119, '116.10.252.177', 'admin', '2023-01-06 13:16:38', 'admin', '2023-01-06 13:16:38');
INSERT INTO `sys_log` VALUES (22107, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 89, '116.10.252.177', 'admin', '2023-01-06 13:16:38', 'admin', '2023-01-06 13:16:38');
INSERT INTO `sys_log` VALUES (22108, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"HT04032223000003\"', 118, '116.10.252.177', 'admin', '2023-01-06 13:17:54', 'admin', '2023-01-06 13:17:54');
INSERT INTO `sys_log` VALUES (22109, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.setPurchaseContractPigeonhole()', '216', 320, '116.10.252.177', 'admin', '2023-01-06 13:18:06', 'admin', '2023-01-06 13:18:06');
INSERT INTO `sys_log` VALUES (22110, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 118, '116.10.252.177', 'admin', '2023-01-06 13:18:07', 'admin', '2023-01-06 13:18:07');
INSERT INTO `sys_log` VALUES (22111, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getFPurchaseContractData()', '1', 119, '116.10.252.177', 'admin', '2023-01-06 13:18:10', 'admin', '2023-01-06 13:18:10');
INSERT INTO `sys_log` VALUES (22112, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.setPurchaseContractPigeonhole()', '216', 300, '116.10.252.177', 'admin', '2023-01-06 13:18:11', 'admin', '2023-01-06 13:18:11');
INSERT INTO `sys_log` VALUES (22113, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getFPurchaseContractData()', '1', 90, '116.10.252.177', 'admin', '2023-01-06 13:18:11', 'admin', '2023-01-06 13:18:11');
INSERT INTO `sys_log` VALUES (22114, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 119, '116.10.252.177', 'admin', '2023-01-06 13:18:13', 'admin', '2023-01-06 13:18:13');
INSERT INTO `sys_log` VALUES (22115, 'admin', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 78, '116.10.252.177', 'admin', '2023-01-06 13:18:33', 'admin', '2023-01-06 13:18:33');
INSERT INTO `sys_log` VALUES (22116, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 316, '1.119.169.88', 'admin', '2023-01-06 13:33:17', 'admin', '2023-01-06 13:33:17');
INSERT INTO `sys_log` VALUES (22117, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 39, '1.119.169.88', 'admin', '2023-01-06 13:33:17', 'admin', '2023-01-06 13:33:17');
INSERT INTO `sys_log` VALUES (22118, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 84, '1.119.169.88', 'admin', '2023-01-06 13:33:17', 'admin', '2023-01-06 13:33:17');
INSERT INTO `sys_log` VALUES (22119, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 119, '1.119.169.88', 'admin', '2023-01-06 13:33:17', 'admin', '2023-01-06 13:33:17');
INSERT INTO `sys_log` VALUES (22120, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 119, '1.119.169.88', 'admin', '2023-01-06 13:33:20', 'admin', '2023-01-06 13:33:20');
INSERT INTO `sys_log` VALUES (22121, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 84, '1.119.169.88', 'admin', '2023-01-06 13:33:20', 'admin', '2023-01-06 13:33:20');
INSERT INTO `sys_log` VALUES (22122, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 90, '1.119.169.88', 'admin', '2023-01-06 13:33:20', 'admin', '2023-01-06 13:33:20');
INSERT INTO `sys_log` VALUES (22123, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 118, '1.119.169.88', 'admin', '2023-01-06 13:33:24', 'admin', '2023-01-06 13:33:24');
INSERT INTO `sys_log` VALUES (22124, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 118, '1.119.169.88', 'admin', '2023-01-06 13:33:29', 'admin', '2023-01-06 13:33:29');
INSERT INTO `sys_log` VALUES (22125, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 118, '1.119.169.88', 'admin', '2023-01-06 13:33:32', 'admin', '2023-01-06 13:33:32');
INSERT INTO `sys_log` VALUES (22126, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 127, '1.119.169.88', 'admin', '2023-01-06 13:33:34', 'admin', '2023-01-06 13:33:34');
INSERT INTO `sys_log` VALUES (22127, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 78, '1.119.169.88', 'admin', '2023-01-06 13:33:52', 'admin', '2023-01-06 13:33:52');
INSERT INTO `sys_log` VALUES (22128, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 85, '1.119.169.88', 'admin', '2023-01-06 13:33:52', 'admin', '2023-01-06 13:33:52');
INSERT INTO `sys_log` VALUES (22129, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 89, '1.119.169.88', 'admin', '2023-01-06 13:33:52', 'admin', '2023-01-06 13:33:52');
INSERT INTO `sys_log` VALUES (22130, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 83, '1.119.169.88', 'admin', '2023-01-06 13:33:54', 'admin', '2023-01-06 13:33:54');
INSERT INTO `sys_log` VALUES (22131, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 89, '1.119.169.88', 'admin', '2023-01-06 13:33:54', 'admin', '2023-01-06 13:33:54');
INSERT INTO `sys_log` VALUES (22132, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 118, '1.119.169.88', 'admin', '2023-01-06 13:33:54', 'admin', '2023-01-06 13:33:54');
INSERT INTO `sys_log` VALUES (22133, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 407, '1.119.169.88', 'admin', '2023-01-06 13:58:53', 'admin', '2023-01-06 13:58:53');
INSERT INTO `sys_log` VALUES (22134, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 52, '1.119.169.88', 'admin', '2023-01-06 13:58:54', 'admin', '2023-01-06 13:58:54');
INSERT INTO `sys_log` VALUES (22135, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 51, '1.119.169.88', 'admin', '2023-01-06 13:58:54', 'admin', '2023-01-06 13:58:54');
INSERT INTO `sys_log` VALUES (22136, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 153, '1.119.169.88', 'admin', '2023-01-06 13:58:54', 'admin', '2023-01-06 13:58:54');
INSERT INTO `sys_log` VALUES (22137, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 90, '1.119.169.88', 'admin', '2023-01-06 13:58:56', 'admin', '2023-01-06 13:58:56');
INSERT INTO `sys_log` VALUES (22138, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 106, '1.119.169.88', 'admin', '2023-01-06 13:58:56', 'admin', '2023-01-06 13:58:56');
INSERT INTO `sys_log` VALUES (22139, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 163, '1.119.169.88', 'admin', '2023-01-06 13:58:56', 'admin', '2023-01-06 13:58:56');
INSERT INTO `sys_log` VALUES (22140, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 152, '1.119.169.88', 'admin', '2023-01-06 13:58:59', 'admin', '2023-01-06 13:58:59');
INSERT INTO `sys_log` VALUES (22141, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 153, '1.119.169.88', 'admin', '2023-01-06 13:59:01', 'admin', '2023-01-06 13:59:01');
INSERT INTO `sys_log` VALUES (22142, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 152, '1.119.169.88', 'admin', '2023-01-06 13:59:05', 'admin', '2023-01-06 13:59:05');
INSERT INTO `sys_log` VALUES (22143, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 152, '1.119.169.88', 'admin', '2023-01-06 13:59:07', 'admin', '2023-01-06 13:59:07');
INSERT INTO `sys_log` VALUES (22144, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 167, '1.119.169.88', 'admin', '2023-01-06 13:59:08', 'admin', '2023-01-06 13:59:08');
INSERT INTO `sys_log` VALUES (22145, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 137, '1.119.169.88', 'admin', '2023-01-06 13:59:14', 'admin', '2023-01-06 13:59:14');
INSERT INTO `sys_log` VALUES (22146, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 149, '1.119.169.88', 'admin', '2023-01-06 13:59:18', 'admin', '2023-01-06 13:59:18');
INSERT INTO `sys_log` VALUES (22147, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 152, '1.119.169.88', 'admin', '2023-01-06 13:59:20', 'admin', '2023-01-06 13:59:20');
INSERT INTO `sys_log` VALUES (22148, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 153, '1.119.169.88', 'admin', '2023-01-06 13:59:21', 'admin', '2023-01-06 13:59:21');
INSERT INTO `sys_log` VALUES (22149, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 152, '1.119.169.88', 'admin', '2023-01-06 13:59:25', 'admin', '2023-01-06 13:59:25');
INSERT INTO `sys_log` VALUES (22150, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 153, '1.119.169.88', 'admin', '2023-01-06 13:59:27', 'admin', '2023-01-06 13:59:27');
INSERT INTO `sys_log` VALUES (22151, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"YX-JL-2022123001\"', 99, '1.119.169.88', 'admin', '2023-01-06 13:59:35', 'admin', '2023-01-06 13:59:35');
INSERT INTO `sys_log` VALUES (22152, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"XTX-YX2022122801\"', 101, '1.119.169.88', 'admin', '2023-01-06 13:59:40', 'admin', '2023-01-06 13:59:40');
INSERT INTO `sys_log` VALUES (22153, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 152, '1.119.169.88', 'admin', '2023-01-06 13:59:45', 'admin', '2023-01-06 13:59:45');
INSERT INTO `sys_log` VALUES (22154, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT10032223000003\"', 100, '1.119.169.88', 'admin', '2023-01-06 14:00:01', 'admin', '2023-01-06 14:00:01');
INSERT INTO `sys_log` VALUES (22155, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '2', 149, '1.119.169.88', 'admin', '2023-01-06 14:00:04', 'admin', '2023-01-06 14:00:04');
INSERT INTO `sys_log` VALUES (22156, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT15032223000004\"', 100, '1.119.169.88', 'admin', '2023-01-06 14:00:06', 'admin', '2023-01-06 14:00:06');
INSERT INTO `sys_log` VALUES (22157, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '3', 152, '1.119.169.88', 'admin', '2023-01-06 14:00:09', 'admin', '2023-01-06 14:00:09');
INSERT INTO `sys_log` VALUES (22158, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT05032223000004\"', 153, '1.119.169.88', 'admin', '2023-01-06 14:00:11', 'admin', '2023-01-06 14:00:11');
INSERT INTO `sys_log` VALUES (22159, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '4', 153, '1.119.169.88', 'admin', '2023-01-06 14:00:15', 'admin', '2023-01-06 14:00:15');
INSERT INTO `sys_log` VALUES (22160, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT05032223000002\"', 153, '1.119.169.88', 'admin', '2023-01-06 14:00:17', 'admin', '2023-01-06 14:00:17');
INSERT INTO `sys_log` VALUES (22161, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '5', 152, '1.119.169.88', 'admin', '2023-01-06 14:00:34', 'admin', '2023-01-06 14:00:34');
INSERT INTO `sys_log` VALUES (22162, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"GTXS22/2320221110-002\"', 152, '1.119.169.88', 'admin', '2023-01-06 14:00:36', 'admin', '2023-01-06 14:00:36');
INSERT INTO `sys_log` VALUES (22163, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 101, '1.119.169.88', 'admin', '2023-01-06 14:00:47', 'admin', '2023-01-06 14:00:47');
INSERT INTO `sys_log` VALUES (22164, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 90, '1.119.169.88', 'admin', '2023-01-06 14:00:47', 'admin', '2023-01-06 14:00:47');
INSERT INTO `sys_log` VALUES (22165, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 99, '1.119.169.88', 'admin', '2023-01-06 14:00:47', 'admin', '2023-01-06 14:00:47');
INSERT INTO `sys_log` VALUES (22166, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 90, '1.119.169.88', 'admin', '2023-01-06 14:00:48', 'admin', '2023-01-06 14:00:48');
INSERT INTO `sys_log` VALUES (22167, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 101, '1.119.169.88', 'admin', '2023-01-06 14:00:48', 'admin', '2023-01-06 14:00:48');
INSERT INTO `sys_log` VALUES (22168, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 99, '1.119.169.88', 'admin', '2023-01-06 14:00:48', 'admin', '2023-01-06 14:00:48');
INSERT INTO `sys_log` VALUES (22169, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 49, '1.119.169.88', 'admin', '2023-01-06 14:00:49', 'admin', '2023-01-06 14:00:49');
INSERT INTO `sys_log` VALUES (22170, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 603, '117.140.240.127', '黄佳森', '2023-01-06 14:29:51', '黄佳森', '2023-01-06 14:29:51');
INSERT INTO `sys_log` VALUES (22171, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 44, '117.140.240.127', '黄佳森', '2023-01-06 14:29:51', '黄佳森', '2023-01-06 14:29:51');
INSERT INTO `sys_log` VALUES (22172, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 44, '117.140.240.127', '黄佳森', '2023-01-06 14:29:52', '黄佳森', '2023-01-06 14:29:52');
INSERT INTO `sys_log` VALUES (22173, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 255, '117.140.240.127', '黄佳森', '2023-01-06 14:29:52', '黄佳森', '2023-01-06 14:29:52');
INSERT INTO `sys_log` VALUES (22174, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 75, '117.140.240.127', '黄佳森', '2023-01-06 14:29:55', '黄佳森', '2023-01-06 14:29:55');
INSERT INTO `sys_log` VALUES (22175, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 80, '117.140.240.127', '黄佳森', '2023-01-06 14:29:55', '黄佳森', '2023-01-06 14:29:55');
INSERT INTO `sys_log` VALUES (22176, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 127, '117.140.240.127', '黄佳森', '2023-01-06 14:29:55', '黄佳森', '2023-01-06 14:29:55');
INSERT INTO `sys_log` VALUES (22177, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"HT04032223000003\"', 127, '117.140.240.127', '黄佳森', '2023-01-06 14:29:56', '黄佳森', '2023-01-06 14:29:56');
INSERT INTO `sys_log` VALUES (22178, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"YX-JL-2022123001\"', 75, '117.140.240.127', '黄佳森', '2023-01-06 14:30:05', '黄佳森', '2023-01-06 14:30:05');
INSERT INTO `sys_log` VALUES (22179, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"XTX-YX2022122801\"', 84, '117.140.240.127', '黄佳森', '2023-01-06 14:31:20', '黄佳森', '2023-01-06 14:31:20');
INSERT INTO `sys_log` VALUES (22180, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 126, '116.252.95.228', '韩娜', '2023-01-06 14:31:50', '韩娜', '2023-01-06 14:31:50');
INSERT INTO `sys_log` VALUES (22181, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.addNewCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\"1\",\"customerEnterpriseName\":\"广东富桥糖业有限公司\",\"customerName\":\"钟燕\",\"customerPhone\":\"4\",\"id\":30,\"lastUpdateBy\":\"韩娜\"}', 257, '116.252.95.228', '韩娜', '2023-01-06 14:34:06', '韩娜', '2023-01-06 14:34:06');
INSERT INTO `sys_log` VALUES (22182, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 85, '116.252.95.228', '韩娜', '2023-01-06 14:34:06', '韩娜', '2023-01-06 14:34:06');
INSERT INTO `sys_log` VALUES (22183, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 74, '116.252.95.228', '韩娜', '2023-01-06 14:34:15', '韩娜', '2023-01-06 14:34:15');
INSERT INTO `sys_log` VALUES (22184, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 80, '116.252.95.228', '韩娜', '2023-01-06 14:34:15', '韩娜', '2023-01-06 14:34:15');
INSERT INTO `sys_log` VALUES (22185, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 127, '116.252.95.228', '韩娜', '2023-01-06 14:34:15', '韩娜', '2023-01-06 14:34:15');
INSERT INTO `sys_log` VALUES (22186, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"韩娜\",\"customerEnterpriseName\":\"广东富桥糖业有限公司\",\"goodsCount\":2000,\"goodsName\":\"甘蔗糖蜜\",\"goodsUnit\":\"吨\",\"id\":258,\"inboundData\":[{\"factoryName\":\"龙门糖厂\",\"goodsUnitPrice\":1433,...', 469, '116.252.95.228', '韩娜', '2023-01-06 14:35:26', '韩娜', '2023-01-06 14:35:26');
INSERT INTO `sys_log` VALUES (22187, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 86, '116.252.95.228', '韩娜', '2023-01-06 14:35:26', '韩娜', '2023-01-06 14:35:26');
INSERT INTO `sys_log` VALUES (22188, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 75, '116.252.95.228', '韩娜', '2023-01-06 14:36:24', '韩娜', '2023-01-06 14:36:24');
INSERT INTO `sys_log` VALUES (22189, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 79, '116.252.95.228', '韩娜', '2023-01-06 14:36:24', '韩娜', '2023-01-06 14:36:24');
INSERT INTO `sys_log` VALUES (22190, '韩娜', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 85, '116.252.95.228', '韩娜', '2023-01-06 14:36:24', '韩娜', '2023-01-06 14:36:24');
INSERT INTO `sys_log` VALUES (22191, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 37, '116.252.95.228', '韩娜', '2023-01-06 14:36:24', '韩娜', '2023-01-06 14:36:24');
INSERT INTO `sys_log` VALUES (22192, '韩娜', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 79, '116.252.95.228', '韩娜', '2023-01-06 14:36:25', '韩娜', '2023-01-06 14:36:25');
INSERT INTO `sys_log` VALUES (22193, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 83, '116.252.95.228', '韩娜', '2023-01-06 14:36:25', '韩娜', '2023-01-06 14:36:25');
INSERT INTO `sys_log` VALUES (22194, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 114, '116.252.95.228', '韩娜', '2023-01-06 14:36:25', '韩娜', '2023-01-06 14:36:25');
INSERT INTO `sys_log` VALUES (22195, '韩娜', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"YX-JL-2022123001\"', 83, '116.252.95.228', '韩娜', '2023-01-06 14:36:37', '韩娜', '2023-01-06 14:36:37');
INSERT INTO `sys_log` VALUES (22196, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 127, '116.252.95.228', '韩娜', '2023-01-06 14:36:56', '韩娜', '2023-01-06 14:36:56');
INSERT INTO `sys_log` VALUES (22197, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.updateCustomer()', '{\"createBy\":\"韩娜\",\"customerAddress\":\" 广东省湛江市霞山区 开发区安平路8号凯胜汇华轩糖业集团2楼（喷水池玻璃门蓝框）\",\"customerEnterpriseName\":\"广东富桥糖业有限公司\",\"customerName\":\"钟燕\",\"customerPhone\":\"18924406750\",\"id\":30,\"lastUpdateBy\":\"韩娜\"}', 285, '116.252.95.228', '韩娜', '2023-01-06 14:37:19', '韩娜', '2023-01-06 14:37:19');
INSERT INTO `sys_log` VALUES (22198, '韩娜', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 126, '116.252.95.228', '韩娜', '2023-01-06 14:37:20', '韩娜', '2023-01-06 14:37:20');
INSERT INTO `sys_log` VALUES (22199, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 399, '1.119.169.88', 'admin', '2023-01-06 15:32:25', 'admin', '2023-01-06 15:32:25');
INSERT INTO `sys_log` VALUES (22200, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 51, '1.119.169.88', 'admin', '2023-01-06 15:32:26', 'admin', '2023-01-06 15:32:26');
INSERT INTO `sys_log` VALUES (22201, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 50, '1.119.169.88', 'admin', '2023-01-06 15:32:26', 'admin', '2023-01-06 15:32:26');
INSERT INTO `sys_log` VALUES (22202, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 150, '1.119.169.88', 'admin', '2023-01-06 15:32:26', 'admin', '2023-01-06 15:32:26');
INSERT INTO `sys_log` VALUES (22203, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 81, '1.119.169.88', 'admin', '2023-01-06 15:32:29', 'admin', '2023-01-06 15:32:29');
INSERT INTO `sys_log` VALUES (22204, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 105, '1.119.169.88', 'admin', '2023-01-06 15:32:29', 'admin', '2023-01-06 15:32:29');
INSERT INTO `sys_log` VALUES (22205, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 164, '1.119.169.88', 'admin', '2023-01-06 15:32:29', 'admin', '2023-01-06 15:32:29');
INSERT INTO `sys_log` VALUES (22206, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 573, '117.140.240.127', '黄佳森', '2023-01-06 16:04:30', '黄佳森', '2023-01-06 16:04:30');
INSERT INTO `sys_log` VALUES (22207, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 42, '117.140.240.127', '黄佳森', '2023-01-06 16:04:31', '黄佳森', '2023-01-06 16:04:31');
INSERT INTO `sys_log` VALUES (22208, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 41, '117.140.240.127', '黄佳森', '2023-01-06 16:04:31', '黄佳森', '2023-01-06 16:04:31');
INSERT INTO `sys_log` VALUES (22209, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 243, '117.140.240.127', '黄佳森', '2023-01-06 16:04:31', '黄佳森', '2023-01-06 16:04:31');
INSERT INTO `sys_log` VALUES (22210, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 82, '117.140.240.127', '黄佳森', '2023-01-06 16:04:36', '黄佳森', '2023-01-06 16:04:36');
INSERT INTO `sys_log` VALUES (22211, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 121, '117.140.240.127', '黄佳森', '2023-01-06 16:04:36', '黄佳森', '2023-01-06 16:04:36');
INSERT INTO `sys_log` VALUES (22212, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 92, '117.140.240.127', '黄佳森', '2023-01-06 16:04:36', '黄佳森', '2023-01-06 16:04:36');
INSERT INTO `sys_log` VALUES (22213, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.purchaseImportExcel()', NULL, 29880, '117.140.240.127', NULL, '2023-01-06 16:06:17', NULL, '2023-01-06 16:06:17');
INSERT INTO `sys_log` VALUES (22214, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 121, '117.140.240.127', '黄佳森', '2023-01-06 16:06:17', '黄佳森', '2023-01-06 16:06:17');
INSERT INTO `sys_log` VALUES (22215, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 80, '117.140.240.127', '黄佳森', '2023-01-06 16:08:55', '黄佳森', '2023-01-06 16:08:55');
INSERT INTO `sys_log` VALUES (22216, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 98, '117.140.240.127', '黄佳森', '2023-01-06 16:08:55', '黄佳森', '2023-01-06 16:08:55');
INSERT INTO `sys_log` VALUES (22217, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 140, '117.140.240.127', '黄佳森', '2023-01-06 16:08:55', '黄佳森', '2023-01-06 16:08:55');
INSERT INTO `sys_log` VALUES (22218, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 608, '117.140.240.127', '黄佳森', '2023-01-06 16:43:07', '黄佳森', '2023-01-06 16:43:07');
INSERT INTO `sys_log` VALUES (22219, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 44, '117.140.240.127', '黄佳森', '2023-01-06 16:43:08', '黄佳森', '2023-01-06 16:43:08');
INSERT INTO `sys_log` VALUES (22220, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 44, '117.140.240.127', '黄佳森', '2023-01-06 16:43:08', '黄佳森', '2023-01-06 16:43:08');
INSERT INTO `sys_log` VALUES (22221, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 267, '117.140.240.127', '黄佳森', '2023-01-06 16:43:08', '黄佳森', '2023-01-06 16:43:08');
INSERT INTO `sys_log` VALUES (22222, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 85, '117.140.240.127', '黄佳森', '2023-01-06 16:43:11', '黄佳森', '2023-01-06 16:43:11');
INSERT INTO `sys_log` VALUES (22223, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 93, '117.140.240.127', '黄佳森', '2023-01-06 16:43:11', '黄佳森', '2023-01-06 16:43:11');
INSERT INTO `sys_log` VALUES (22224, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 1990, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:51:00', '黄佳森', '2023-01-06 16:51:00');
INSERT INTO `sys_log` VALUES (22225, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 76, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:51:01', '黄佳森', '2023-01-06 16:51:01');
INSERT INTO `sys_log` VALUES (22226, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 72, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:51:01', '黄佳森', '2023-01-06 16:51:01');
INSERT INTO `sys_log` VALUES (22227, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 419, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:51:01', '黄佳森', '2023-01-06 16:51:01');
INSERT INTO `sys_log` VALUES (22228, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 2046, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:40', '黄佳森', '2023-01-06 16:57:40');
INSERT INTO `sys_log` VALUES (22229, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 80, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:41', '黄佳森', '2023-01-06 16:57:41');
INSERT INTO `sys_log` VALUES (22230, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 73, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:41', '黄佳森', '2023-01-06 16:57:41');
INSERT INTO `sys_log` VALUES (22231, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 420, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:42', '黄佳森', '2023-01-06 16:57:42');
INSERT INTO `sys_log` VALUES (22232, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 139, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:47', '黄佳森', '2023-01-06 16:57:47');
INSERT INTO `sys_log` VALUES (22233, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 163, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:47', '黄佳森', '2023-01-06 16:57:47');
INSERT INTO `sys_log` VALUES (22234, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 75, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:57:47', '黄佳森', '2023-01-06 16:57:47');
INSERT INTO `sys_log` VALUES (22235, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getOwnCompanyData()', '1', 209, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 16:58:00', '黄佳森', '2023-01-06 16:58:00');
INSERT INTO `sys_log` VALUES (22236, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 15155, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:04:21', '黄佳森', '2023-01-06 17:04:21');
INSERT INTO `sys_log` VALUES (22237, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15160, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:04:21', '黄佳森', '2023-01-06 17:04:21');
INSERT INTO `sys_log` VALUES (22238, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 62, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:04:21', '黄佳森', '2023-01-06 17:04:21');
INSERT INTO `sys_log` VALUES (22239, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 63, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:04:21', '黄佳森', '2023-01-06 17:04:21');
INSERT INTO `sys_log` VALUES (22240, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 10081, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:04:21', '黄佳森', '2023-01-06 17:04:21');
INSERT INTO `sys_log` VALUES (22241, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 10228, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:04:21', '黄佳森', '2023-01-06 17:04:21');
INSERT INTO `sys_log` VALUES (22242, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:23', '黄佳森', '2023-01-06 17:15:23');
INSERT INTO `sys_log` VALUES (22243, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 123, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:23', '黄佳森', '2023-01-06 17:15:23');
INSERT INTO `sys_log` VALUES (22244, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25130, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:23', '黄佳森', '2023-01-06 17:15:23');
INSERT INTO `sys_log` VALUES (22245, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 25128, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:23', '黄佳森', '2023-01-06 17:15:23');
INSERT INTO `sys_log` VALUES (22246, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:37', '黄佳森', '2023-01-06 17:15:37');
INSERT INTO `sys_log` VALUES (22247, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:37', '黄佳森', '2023-01-06 17:15:37');
INSERT INTO `sys_log` VALUES (22248, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 186, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:15:37', '黄佳森', '2023-01-06 17:15:37');
INSERT INTO `sys_log` VALUES (22249, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 187, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:16:06', '黄佳森', '2023-01-06 17:16:06');
INSERT INTO `sys_log` VALUES (22250, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getCustomerData()', '1', 185, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:16:10', '黄佳森', '2023-01-06 17:16:10');
INSERT INTO `sys_log` VALUES (22251, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 124, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:16:20', '黄佳森', '2023-01-06 17:16:20');
INSERT INTO `sys_log` VALUES (22252, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 124, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:16:20', '黄佳森', '2023-01-06 17:16:20');
INSERT INTO `sys_log` VALUES (22253, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 194, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:16:20', '黄佳森', '2023-01-06 17:16:20');
INSERT INTO `sys_log` VALUES (22254, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.addNewPurchaseContract()', '{\"contractPhotoArray\":[],\"createBy\":\"黄佳森\",\"customerEnterpriseName\":\"江苏途富新材料有限公司\",\"goodsCount\":100,\"goodsName\":\"测试\",\"goodsUnit\":\"吨\",\"id\":294,\"inboundData\":[{\"factoryName\":\"A厂\",\"goodsUnitPrice\":1000,\"in...', 700, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:23', '黄佳森', '2023-01-06 17:17:23');
INSERT INTO `sys_log` VALUES (22255, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 128, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:24', '黄佳森', '2023-01-06 17:17:24');
INSERT INTO `sys_log` VALUES (22256, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 123, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:28', '黄佳森', '2023-01-06 17:17:28');
INSERT INTO `sys_log` VALUES (22257, '黄佳森', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 132, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:28', '黄佳森', '2023-01-06 17:17:28');
INSERT INTO `sys_log` VALUES (22258, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 124, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:28', '黄佳森', '2023-01-06 17:17:28');
INSERT INTO `sys_log` VALUES (22259, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 62, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:28', '黄佳森', '2023-01-06 17:17:28');
INSERT INTO `sys_log` VALUES (22260, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:35', '黄佳森', '2023-01-06 17:17:35');
INSERT INTO `sys_log` VALUES (22261, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 123, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:35', '黄佳森', '2023-01-06 17:17:35');
INSERT INTO `sys_log` VALUES (22262, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 62, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:35', '黄佳森', '2023-01-06 17:17:35');
INSERT INTO `sys_log` VALUES (22263, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 126, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:42', '黄佳森', '2023-01-06 17:17:42');
INSERT INTO `sys_log` VALUES (22264, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 128, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:42', '黄佳森', '2023-01-06 17:17:42');
INSERT INTO `sys_log` VALUES (22265, '黄佳森', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 128, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:42', '黄佳森', '2023-01-06 17:17:42');
INSERT INTO `sys_log` VALUES (22266, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 63, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:42', '黄佳森', '2023-01-06 17:17:42');
INSERT INTO `sys_log` VALUES (22267, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:17:44', '黄佳森', '2023-01-06 17:17:44');
INSERT INTO `sys_log` VALUES (22268, '黄佳森', NULL, 'cn.edu.guet.controller.SaleContractController.add()', '{\"contractPhoto\":\"\",\"contractPhotoList\":[],\"createBy\":\"黄佳森\",\"customerEnterpriseName\":\"忻城南华糖业有限责任公司\",\"goodsCount\":50,\"goodsName\":\"测试\",\"goodsTotalPrice\":150000,\"goodsUnit\":\"吨\",\"goodsUnitPrice\":3000,\"id\"...', 199, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:49', '黄佳森', '2023-01-06 17:18:49');
INSERT INTO `sys_log` VALUES (22269, '黄佳森', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 184, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:49', '黄佳森', '2023-01-06 17:18:49');
INSERT INTO `sys_log` VALUES (22270, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 124, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:51', '黄佳森', '2023-01-06 17:18:51');
INSERT INTO `sys_log` VALUES (22271, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:51', '黄佳森', '2023-01-06 17:18:51');
INSERT INTO `sys_log` VALUES (22272, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 188, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:51', '黄佳森', '2023-01-06 17:18:51');
INSERT INTO `sys_log` VALUES (22273, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:55', '黄佳森', '2023-01-06 17:18:55');
INSERT INTO `sys_log` VALUES (22274, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:55', '黄佳森', '2023-01-06 17:18:55');
INSERT INTO `sys_log` VALUES (22275, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 120, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:18:55', '黄佳森', '2023-01-06 17:18:55');
INSERT INTO `sys_log` VALUES (22276, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.add()', '{\"contractPhoto\":\"\",\"contractPhotoList\":[],\"createBy\":\"黄佳森\",\"freight\":1000,\"goodsName\":\"测试\",\"goodsUnit\":\"吨\",\"id\":89,\"lastUpdateBy\":\"黄佳森\",\"logisticsContractNo\":\"WL1\",\"logisticsContractTime\":16729344000...', 1625, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:05', '黄佳森', '2023-01-06 17:20:05');
INSERT INTO `sys_log` VALUES (22277, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 187, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:05', '黄佳森', '2023-01-06 17:20:05');
INSERT INTO `sys_log` VALUES (22278, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:07', '黄佳森', '2023-01-06 17:20:07');
INSERT INTO `sys_log` VALUES (22279, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 124, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:07', '黄佳森', '2023-01-06 17:20:07');
INSERT INTO `sys_log` VALUES (22280, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 188, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:07', '黄佳森', '2023-01-06 17:20:07');
INSERT INTO `sys_log` VALUES (22281, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"CG测试\"', 187, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:09', '黄佳森', '2023-01-06 17:20:09');
INSERT INTO `sys_log` VALUES (22282, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 119, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:17', '黄佳森', '2023-01-06 17:20:17');
INSERT INTO `sys_log` VALUES (22283, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 183, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:17', '黄佳森', '2023-01-06 17:20:17');
INSERT INTO `sys_log` VALUES (22284, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 62, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:17', '黄佳森', '2023-01-06 17:20:17');
INSERT INTO `sys_log` VALUES (22285, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 120, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:19', '黄佳森', '2023-01-06 17:20:19');
INSERT INTO `sys_log` VALUES (22286, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:19', '黄佳森', '2023-01-06 17:20:19');
INSERT INTO `sys_log` VALUES (22287, NULL, NULL, 'cn.edu.guet.controller.ShippingContractController.shippingImportExcel()', NULL, 9855, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 17:20:31', NULL, '2023-01-06 17:20:31');
INSERT INTO `sys_log` VALUES (22288, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 499, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:32', '黄佳森', '2023-01-06 17:20:32');
INSERT INTO `sys_log` VALUES (22289, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 123, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:36', '黄佳森', '2023-01-06 17:20:36');
INSERT INTO `sys_log` VALUES (22290, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 184, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:36', '黄佳森', '2023-01-06 17:20:36');
INSERT INTO `sys_log` VALUES (22291, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 61, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:36', '黄佳森', '2023-01-06 17:20:36');
INSERT INTO `sys_log` VALUES (22292, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 129, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:58', '黄佳森', '2023-01-06 17:20:58');
INSERT INTO `sys_log` VALUES (22293, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 524, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:20:58', '黄佳森', '2023-01-06 17:20:58');
INSERT INTO `sys_log` VALUES (22294, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:00', '黄佳森', '2023-01-06 17:21:00');
INSERT INTO `sys_log` VALUES (22295, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 189, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:00', '黄佳森', '2023-01-06 17:21:00');
INSERT INTO `sys_log` VALUES (22296, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 63, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:00', '黄佳森', '2023-01-06 17:21:00');
INSERT INTO `sys_log` VALUES (22297, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:05', '黄佳森', '2023-01-06 17:21:05');
INSERT INTO `sys_log` VALUES (22298, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 493, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:05', '黄佳森', '2023-01-06 17:21:05');
INSERT INTO `sys_log` VALUES (22299, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 119, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:50', '黄佳森', '2023-01-06 17:21:50');
INSERT INTO `sys_log` VALUES (22300, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 181, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:50', '黄佳森', '2023-01-06 17:21:50');
INSERT INTO `sys_log` VALUES (22301, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 62, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:50', '黄佳森', '2023-01-06 17:21:50');
INSERT INTO `sys_log` VALUES (22302, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '89', 187, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:21:52', '黄佳森', '2023-01-06 17:21:52');
INSERT INTO `sys_log` VALUES (22303, NULL, NULL, 'cn.edu.guet.controller.PhotoController.addContractPhoto()', NULL, 0, '117.140.240.127', NULL, '2023-01-06 17:22:04', NULL, '2023-01-06 17:22:04');
INSERT INTO `sys_log` VALUES (22304, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.updateLogistics()', '{\"contractPhoto\":\"http://120.77.28.123:9000/static/images/ef73f162912f4da08350ad137300326d.jpg\",\"contractPhotoList\":[\"http://120.77.28.123:9000/static/images/ef73f162912f4da08350ad137300326d.jpg\"],\"cr...', 2767, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:08', '黄佳森', '2023-01-06 17:22:08');
INSERT INTO `sys_log` VALUES (22305, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 183, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:08', '黄佳森', '2023-01-06 17:22:08');
INSERT INTO `sys_log` VALUES (22306, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:13', '黄佳森', '2023-01-06 17:22:13');
INSERT INTO `sys_log` VALUES (22307, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 505, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:13', '黄佳森', '2023-01-06 17:22:13');
INSERT INTO `sys_log` VALUES (22308, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.changeFinanceState()', '\"10\"', 620, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:21', '黄佳森', '2023-01-06 17:22:21');
INSERT INTO `sys_log` VALUES (22309, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 492, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:21', '黄佳森', '2023-01-06 17:22:21');
INSERT INTO `sys_log` VALUES (22310, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.changeDirectorState()', '\"10\"', 375, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:27', '黄佳森', '2023-01-06 17:22:27');
INSERT INTO `sys_log` VALUES (22311, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 497, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:22:27', '黄佳森', '2023-01-06 17:22:27');
INSERT INTO `sys_log` VALUES (22312, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 129, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:24:22', '黄佳森', '2023-01-06 17:24:22');
INSERT INTO `sys_log` VALUES (22313, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 129, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:24:23', '黄佳森', '2023-01-06 17:24:23');
INSERT INTO `sys_log` VALUES (22314, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:24:25', '黄佳森', '2023-01-06 17:24:25');
INSERT INTO `sys_log` VALUES (22315, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 139, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:24:29', '黄佳森', '2023-01-06 17:24:29');
INSERT INTO `sys_log` VALUES (22316, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 5127, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:35:53', '黄佳森', '2023-01-06 17:35:53');
INSERT INTO `sys_log` VALUES (22317, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 25173, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:35:54', '黄佳森', '2023-01-06 17:35:54');
INSERT INTO `sys_log` VALUES (22318, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 10098, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:35:54', '黄佳森', '2023-01-06 17:35:54');
INSERT INTO `sys_log` VALUES (22319, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 63, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:35:55', '黄佳森', '2023-01-06 17:35:55');
INSERT INTO `sys_log` VALUES (22320, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 10140, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:35:56', '黄佳森', '2023-01-06 17:35:56');
INSERT INTO `sys_log` VALUES (22321, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15183, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:48:10', '黄佳森', '2023-01-06 17:48:10');
INSERT INTO `sys_log` VALUES (22322, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 15420, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:48:10', '黄佳森', '2023-01-06 17:48:10');
INSERT INTO `sys_log` VALUES (22323, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 15489, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:48:10', '黄佳森', '2023-01-06 17:48:10');
INSERT INTO `sys_log` VALUES (22324, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 5138, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:48:13', '黄佳森', '2023-01-06 17:48:13');
INSERT INTO `sys_log` VALUES (22325, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 20165, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:55:47', '黄佳森', '2023-01-06 17:55:47');
INSERT INTO `sys_log` VALUES (22326, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 133, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 17:59:39', '黄佳森', '2023-01-06 17:59:39');
INSERT INTO `sys_log` VALUES (22327, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 5209, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:27:48', '黄佳森', '2023-01-06 18:27:48');
INSERT INTO `sys_log` VALUES (22328, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 5727, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:27:51', '黄佳森', '2023-01-06 18:27:51');
INSERT INTO `sys_log` VALUES (22329, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16136, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:27:59', '黄佳森', '2023-01-06 18:27:59');
INSERT INTO `sys_log` VALUES (22330, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 17007, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:28:00', '黄佳森', '2023-01-06 18:28:00');
INSERT INTO `sys_log` VALUES (22331, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 359, '1.119.169.88', 'admin', '2023-01-06 18:38:14', 'admin', '2023-01-06 18:38:14');
INSERT INTO `sys_log` VALUES (22332, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 46, '1.119.169.88', 'admin', '2023-01-06 18:38:15', 'admin', '2023-01-06 18:38:15');
INSERT INTO `sys_log` VALUES (22333, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 45, '1.119.169.88', 'admin', '2023-01-06 18:38:15', 'admin', '2023-01-06 18:38:15');
INSERT INTO `sys_log` VALUES (22334, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 135, '1.119.169.88', 'admin', '2023-01-06 18:38:15', 'admin', '2023-01-06 18:38:15');
INSERT INTO `sys_log` VALUES (22335, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 308, '1.119.169.88', 'admin', '2023-01-06 18:39:26', 'admin', '2023-01-06 18:39:26');
INSERT INTO `sys_log` VALUES (22336, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 39, '1.119.169.88', 'admin', '2023-01-06 18:39:26', 'admin', '2023-01-06 18:39:26');
INSERT INTO `sys_log` VALUES (22337, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 39, '1.119.169.88', 'admin', '2023-01-06 18:39:26', 'admin', '2023-01-06 18:39:26');
INSERT INTO `sys_log` VALUES (22338, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 115, '1.119.169.88', 'admin', '2023-01-06 18:39:26', 'admin', '2023-01-06 18:39:26');
INSERT INTO `sys_log` VALUES (22339, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 89, '1.119.169.88', 'admin', '2023-01-06 18:39:29', 'admin', '2023-01-06 18:39:29');
INSERT INTO `sys_log` VALUES (22340, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 104, '1.119.169.88', 'admin', '2023-01-06 18:39:29', 'admin', '2023-01-06 18:39:29');
INSERT INTO `sys_log` VALUES (22341, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 170, '1.119.169.88', 'admin', '2023-01-06 18:39:29', 'admin', '2023-01-06 18:39:29');
INSERT INTO `sys_log` VALUES (22342, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 38, '1.119.169.88', 'admin', '2023-01-06 18:39:29', 'admin', '2023-01-06 18:39:29');
INSERT INTO `sys_log` VALUES (22343, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 75, '1.119.169.88', 'admin', '2023-01-06 18:39:33', 'admin', '2023-01-06 18:39:33');
INSERT INTO `sys_log` VALUES (22344, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 76, '1.119.169.88', 'admin', '2023-01-06 18:39:42', 'admin', '2023-01-06 18:39:42');
INSERT INTO `sys_log` VALUES (22345, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 130, '1.119.169.88', 'admin', '2023-01-06 18:39:42', 'admin', '2023-01-06 18:39:42');
INSERT INTO `sys_log` VALUES (22346, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 37, '1.119.169.88', 'admin', '2023-01-06 18:39:42', 'admin', '2023-01-06 18:39:42');
INSERT INTO `sys_log` VALUES (22347, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 93, '1.119.169.88', 'admin', '2023-01-06 18:40:21', 'admin', '2023-01-06 18:40:21');
INSERT INTO `sys_log` VALUES (22348, 'admin', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 352, '1.119.169.88', 'admin', '2023-01-06 18:40:22', 'admin', '2023-01-06 18:40:22');
INSERT INTO `sys_log` VALUES (22349, 'admin', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 95, '1.119.169.88', 'admin', '2023-01-06 18:40:31', 'admin', '2023-01-06 18:40:31');
INSERT INTO `sys_log` VALUES (22350, 'admin', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 94, '1.119.169.88', 'admin', '2023-01-06 18:40:34', 'admin', '2023-01-06 18:40:34');
INSERT INTO `sys_log` VALUES (22351, 'admin', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 94, '1.119.169.88', 'admin', '2023-01-06 18:40:38', 'admin', '2023-01-06 18:40:38');
INSERT INTO `sys_log` VALUES (22352, 'admin', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 94, '1.119.169.88', 'admin', '2023-01-06 18:41:06', 'admin', '2023-01-06 18:41:06');
INSERT INTO `sys_log` VALUES (22353, 'admin', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 94, '1.119.169.88', 'admin', '2023-01-06 18:41:08', 'admin', '2023-01-06 18:41:08');
INSERT INTO `sys_log` VALUES (22354, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 787, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:41:35', '黄佳森', '2023-01-06 18:41:35');
INSERT INTO `sys_log` VALUES (22355, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 860, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:41:35', '黄佳森', '2023-01-06 18:41:35');
INSERT INTO `sys_log` VALUES (22356, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 995, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:41:35', '黄佳森', '2023-01-06 18:41:35');
INSERT INTO `sys_log` VALUES (22357, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 73, '1.119.169.88', 'admin', '2023-01-06 18:42:45', 'admin', '2023-01-06 18:42:45');
INSERT INTO `sys_log` VALUES (22358, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 151, '1.119.169.88', 'admin', '2023-01-06 18:42:45', 'admin', '2023-01-06 18:42:45');
INSERT INTO `sys_log` VALUES (22359, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 37, '1.119.169.88', 'admin', '2023-01-06 18:42:45', 'admin', '2023-01-06 18:42:45');
INSERT INTO `sys_log` VALUES (22360, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 131, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:44:26', '黄佳森', '2023-01-06 18:44:26');
INSERT INTO `sys_log` VALUES (22361, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 216, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:44:26', '黄佳森', '2023-01-06 18:44:26');
INSERT INTO `sys_log` VALUES (22362, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 67, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:44:26', '黄佳森', '2023-01-06 18:44:26');
INSERT INTO `sys_log` VALUES (22363, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '90', 199, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:44:31', '黄佳森', '2023-01-06 18:44:31');
INSERT INTO `sys_log` VALUES (22364, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 138, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:46:06', '黄佳森', '2023-01-06 18:46:06');
INSERT INTO `sys_log` VALUES (22365, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 15176, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:50:58', '黄佳森', '2023-01-06 18:50:58');
INSERT INTO `sys_log` VALUES (22366, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15177, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:50:58', '黄佳森', '2023-01-06 18:50:58');
INSERT INTO `sys_log` VALUES (22367, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 20247, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:51:03', '黄佳森', '2023-01-06 18:51:03');
INSERT INTO `sys_log` VALUES (22368, NULL, NULL, 'cn.edu.guet.controller.PhotoController.addContractPhoto()', NULL, 0, '117.140.240.127', NULL, '2023-01-06 18:52:37', NULL, '2023-01-06 18:52:37');
INSERT INTO `sys_log` VALUES (22369, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.addNewProcessContract()', '{\"alcoholConversionFormula\":\"x+3y=1\",\"concentratedSolutionConversionFormula\":\"x+9y=4\",\"contractPhoto\":\"http://120.77.28.123:9000/static/images/89fc2970c3f64b04b39605ae86b7e89b.jpg\",\"contractPhotoArray...', 399, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:52:38', '黄佳森', '2023-01-06 18:52:38');
INSERT INTO `sys_log` VALUES (22370, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 133, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 18:52:39', '黄佳森', '2023-01-06 18:52:39');
INSERT INTO `sys_log` VALUES (22371, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 843, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:13', '黄佳森', '2023-01-06 19:01:13');
INSERT INTO `sys_log` VALUES (22372, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 1055, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:17', '黄佳森', '2023-01-06 19:01:17');
INSERT INTO `sys_log` VALUES (22373, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 73, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:18', '黄佳森', '2023-01-06 19:01:18');
INSERT INTO `sys_log` VALUES (22374, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 72, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:18', '黄佳森', '2023-01-06 19:01:18');
INSERT INTO `sys_log` VALUES (22375, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 410, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:19', '黄佳森', '2023-01-06 19:01:19');
INSERT INTO `sys_log` VALUES (22376, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 132, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:31', '黄佳森', '2023-01-06 19:01:31');
INSERT INTO `sys_log` VALUES (22377, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 132, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:31', '黄佳森', '2023-01-06 19:01:31');
INSERT INTO `sys_log` VALUES (22378, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 207, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:31', '黄佳森', '2023-01-06 19:01:31');
INSERT INTO `sys_log` VALUES (22379, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 136, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:01:44', '黄佳森', '2023-01-06 19:01:44');
INSERT INTO `sys_log` VALUES (22380, NULL, NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.purchasePaymentImportExcel()', NULL, 3346, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 19:02:03', NULL, '2023-01-06 19:02:03');
INSERT INTO `sys_log` VALUES (22381, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 336, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:04', '黄佳森', '2023-01-06 19:02:04');
INSERT INTO `sys_log` VALUES (22382, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 175, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:15', '黄佳森', '2023-01-06 19:02:15');
INSERT INTO `sys_log` VALUES (22383, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 176, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:15', '黄佳森', '2023-01-06 19:02:15');
INSERT INTO `sys_log` VALUES (22384, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 416, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:15', '黄佳森', '2023-01-06 19:02:15');
INSERT INTO `sys_log` VALUES (22385, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseContractInboundData()', '\"CG测试\"', 200, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:20', '黄佳森', '2023-01-06 19:02:20');
INSERT INTO `sys_log` VALUES (22386, NULL, NULL, 'cn.edu.guet.controller.PhotoController.addContractPhoto()', NULL, 0, '117.140.240.127', NULL, '2023-01-06 19:02:27', NULL, '2023-01-06 19:02:27');
INSERT INTO `sys_log` VALUES (22387, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.updatePurchaseContract()', '{\"contractPhotoArray\":[\"http://120.77.28.123:9000/static/images/0c5fe159944142949f7b872ff64acb28.jpg\"],\"createBy\":\"黄佳森\",\"customerEnterpriseName\":\"江苏途富新材料有限公司\",\"goodsCount\":100,\"goodsName\":\"测试\",\"goodsU...', 471, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:28', '黄佳森', '2023-01-06 19:02:28');
INSERT INTO `sys_log` VALUES (22388, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 135, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:02:29', '黄佳森', '2023-01-06 19:02:29');
INSERT INTO `sys_log` VALUES (22389, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 3948, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:01', '黄佳森', '2023-01-06 19:03:01');
INSERT INTO `sys_log` VALUES (22390, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 3948, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:01', '黄佳森', '2023-01-06 19:03:01');
INSERT INTO `sys_log` VALUES (22391, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 5707, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:02', '黄佳森', '2023-01-06 19:03:02');
INSERT INTO `sys_log` VALUES (22392, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 2922, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:13', '黄佳森', '2023-01-06 19:03:13');
INSERT INTO `sys_log` VALUES (22393, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 127, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:30', '黄佳森', '2023-01-06 19:03:30');
INSERT INTO `sys_log` VALUES (22394, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 136, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:30', '黄佳森', '2023-01-06 19:03:30');
INSERT INTO `sys_log` VALUES (22395, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 205, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:03:30', '黄佳森', '2023-01-06 19:03:30');
INSERT INTO `sys_log` VALUES (22396, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 123, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:06', '黄佳森', '2023-01-06 19:05:06');
INSERT INTO `sys_log` VALUES (22397, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 187, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:06', '黄佳森', '2023-01-06 19:05:06');
INSERT INTO `sys_log` VALUES (22398, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 192, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:06', '黄佳森', '2023-01-06 19:05:06');
INSERT INTO `sys_log` VALUES (22399, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 136, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:16', '黄佳森', '2023-01-06 19:05:16');
INSERT INTO `sys_log` VALUES (22400, NULL, NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.processPaymentImportExcel()', NULL, 4276, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 19:05:39', NULL, '2023-01-06 19:05:39');
INSERT INTO `sys_log` VALUES (22401, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 384, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:40', '黄佳森', '2023-01-06 19:05:40');
INSERT INTO `sys_log` VALUES (22402, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.changeFinanceState()', '25', 654, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:47', '黄佳森', '2023-01-06 19:05:47');
INSERT INTO `sys_log` VALUES (22403, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 399, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:47', '黄佳森', '2023-01-06 19:05:47');
INSERT INTO `sys_log` VALUES (22404, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 381, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:54', '黄佳森', '2023-01-06 19:05:54');
INSERT INTO `sys_log` VALUES (22405, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 147, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:58', '黄佳森', '2023-01-06 19:05:58');
INSERT INTO `sys_log` VALUES (22406, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 142, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:58', '黄佳森', '2023-01-06 19:05:58');
INSERT INTO `sys_log` VALUES (22407, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 218, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:05:59', '黄佳森', '2023-01-06 19:05:59');
INSERT INTO `sys_log` VALUES (22408, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 135, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:06:17', '黄佳森', '2023-01-06 19:06:17');
INSERT INTO `sys_log` VALUES (22409, NULL, NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.logisticsPaymentImportExcel()', NULL, 3806, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 19:06:40', NULL, '2023-01-06 19:06:40');
INSERT INTO `sys_log` VALUES (22410, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 395, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:06:40', '黄佳森', '2023-01-06 19:06:40');
INSERT INTO `sys_log` VALUES (22411, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 127, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:06:51', '黄佳森', '2023-01-06 19:06:51');
INSERT INTO `sys_log` VALUES (22412, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 188, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:06:51', '黄佳森', '2023-01-06 19:06:51');
INSERT INTO `sys_log` VALUES (22413, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:06:51', '黄佳森', '2023-01-06 19:06:51');
INSERT INTO `sys_log` VALUES (22414, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 128, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:07:01', '黄佳森', '2023-01-06 19:07:01');
INSERT INTO `sys_log` VALUES (22415, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 510, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:07:02', '黄佳森', '2023-01-06 19:07:02');
INSERT INTO `sys_log` VALUES (22416, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:07:06', '黄佳森', '2023-01-06 19:07:06');
INSERT INTO `sys_log` VALUES (22417, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 191, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:07:06', '黄佳森', '2023-01-06 19:07:06');
INSERT INTO `sys_log` VALUES (22418, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:07:06', '黄佳森', '2023-01-06 19:07:06');
INSERT INTO `sys_log` VALUES (22419, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 438, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:10', '黄佳森', '2023-01-06 19:08:10');
INSERT INTO `sys_log` VALUES (22420, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 458, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:15', '黄佳森', '2023-01-06 19:08:15');
INSERT INTO `sys_log` VALUES (22421, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 129, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:21', '黄佳森', '2023-01-06 19:08:21');
INSERT INTO `sys_log` VALUES (22422, NULL, NULL, 'cn.edu.guet.controller.OfficeExpenseController.officeExpenseImportExcel()', NULL, 3023, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 19:08:30', NULL, '2023-01-06 19:08:30');
INSERT INTO `sys_log` VALUES (22423, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 447, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:30', '黄佳森', '2023-01-06 19:08:30');
INSERT INTO `sys_log` VALUES (22424, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.changeFinanceState()', '16', 377, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:42', '黄佳森', '2023-01-06 19:08:42');
INSERT INTO `sys_log` VALUES (22425, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 520, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:43', '黄佳森', '2023-01-06 19:08:43');
INSERT INTO `sys_log` VALUES (22426, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.changeFinanceState()', '15', 371, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:45', '黄佳森', '2023-01-06 19:08:45');
INSERT INTO `sys_log` VALUES (22427, '黄佳森', NULL, 'cn.edu.guet.controller.OfficeExpenseController.getOfficeExpenseData()', '1', 504, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:46', '黄佳森', '2023-01-06 19:08:46');
INSERT INTO `sys_log` VALUES (22428, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 126, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:48', '黄佳森', '2023-01-06 19:08:48');
INSERT INTO `sys_log` VALUES (22429, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 189, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:48', '黄佳森', '2023-01-06 19:08:48');
INSERT INTO `sys_log` VALUES (22430, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:48', '黄佳森', '2023-01-06 19:08:48');
INSERT INTO `sys_log` VALUES (22431, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 125, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:49', '黄佳森', '2023-01-06 19:08:49');
INSERT INTO `sys_log` VALUES (22432, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 506, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:50', '黄佳森', '2023-01-06 19:08:50');
INSERT INTO `sys_log` VALUES (22433, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 377, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:53', '黄佳森', '2023-01-06 19:08:53');
INSERT INTO `sys_log` VALUES (22434, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:54', '黄佳森', '2023-01-06 19:08:54');
INSERT INTO `sys_log` VALUES (22435, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 127, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:54', '黄佳森', '2023-01-06 19:08:54');
INSERT INTO `sys_log` VALUES (22436, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 186, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:54', '黄佳森', '2023-01-06 19:08:54');
INSERT INTO `sys_log` VALUES (22437, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 442, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:56', '黄佳森', '2023-01-06 19:08:56');
INSERT INTO `sys_log` VALUES (22438, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 389, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:58', '黄佳森', '2023-01-06 19:08:58');
INSERT INTO `sys_log` VALUES (22439, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 375, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:08:59', '黄佳森', '2023-01-06 19:08:59');
INSERT INTO `sys_log` VALUES (22440, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 374, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:02', '黄佳森', '2023-01-06 19:09:02');
INSERT INTO `sys_log` VALUES (22441, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 455, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:04', '黄佳森', '2023-01-06 19:09:04');
INSERT INTO `sys_log` VALUES (22442, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 121, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:08', '黄佳森', '2023-01-06 19:09:08');
INSERT INTO `sys_log` VALUES (22443, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 184, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:08', '黄佳森', '2023-01-06 19:09:08');
INSERT INTO `sys_log` VALUES (22444, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 133, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:08', '黄佳森', '2023-01-06 19:09:08');
INSERT INTO `sys_log` VALUES (22445, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 122, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:12', '黄佳森', '2023-01-06 19:09:12');
INSERT INTO `sys_log` VALUES (22446, '黄佳森', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 582, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 19:09:13', '黄佳森', '2023-01-06 19:09:13');
INSERT INTO `sys_log` VALUES (22447, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"黄佳森\"}', 2585, '117.140.240.127', '黄佳森', '2023-01-06 19:16:26', '黄佳森', '2023-01-06 19:16:26');
INSERT INTO `sys_log` VALUES (22448, '黄佳森', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"黄佳森\"', 115, '117.140.240.127', '黄佳森', '2023-01-06 19:16:26', '黄佳森', '2023-01-06 19:16:26');
INSERT INTO `sys_log` VALUES (22449, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"黄佳森\"', 77, '117.140.240.127', '黄佳森', '2023-01-06 19:16:27', '黄佳森', '2023-01-06 19:16:27');
INSERT INTO `sys_log` VALUES (22450, '黄佳森', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"黄佳森\"', 315, '117.140.240.127', '黄佳森', '2023-01-06 19:16:27', '黄佳森', '2023-01-06 19:16:27');
INSERT INTO `sys_log` VALUES (22451, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 238, '117.140.240.127', '黄佳森', '2023-01-06 19:16:32', '黄佳森', '2023-01-06 19:16:32');
INSERT INTO `sys_log` VALUES (22452, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 151, '117.140.240.127', '黄佳森', '2023-01-06 19:16:32', '黄佳森', '2023-01-06 19:16:32');
INSERT INTO `sys_log` VALUES (22453, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 364, '117.140.240.127', '黄佳森', '2023-01-06 19:16:32', '黄佳森', '2023-01-06 19:16:32');
INSERT INTO `sys_log` VALUES (22454, '黄佳森', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 342, '117.140.240.127', '黄佳森', '2023-01-06 19:16:41', '黄佳森', '2023-01-06 19:16:41');
INSERT INTO `sys_log` VALUES (22455, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 396, '117.140.240.127', '黄佳森', '2023-01-06 19:16:45', '黄佳森', '2023-01-06 19:16:45');
INSERT INTO `sys_log` VALUES (22456, '黄佳森', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 322, '117.140.240.127', '黄佳森', '2023-01-06 19:16:50', '黄佳森', '2023-01-06 19:16:50');
INSERT INTO `sys_log` VALUES (22457, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 342, '117.140.240.127', '黄佳森', '2023-01-06 19:17:26', '黄佳森', '2023-01-06 19:17:26');
INSERT INTO `sys_log` VALUES (22458, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 83, '117.140.240.127', '黄佳森', '2023-01-06 19:17:30', '黄佳森', '2023-01-06 19:17:30');
INSERT INTO `sys_log` VALUES (22459, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 103, '117.140.240.127', '黄佳森', '2023-01-06 19:17:30', '黄佳森', '2023-01-06 19:17:30');
INSERT INTO `sys_log` VALUES (22460, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 189, '117.140.240.127', '黄佳森', '2023-01-06 19:17:31', '黄佳森', '2023-01-06 19:17:31');
INSERT INTO `sys_log` VALUES (22461, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '2', 115, '117.140.240.127', '黄佳森', '2023-01-06 19:17:34', '黄佳森', '2023-01-06 19:17:34');
INSERT INTO `sys_log` VALUES (22462, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 294, '117.140.240.127', '黄佳森', '2023-01-06 19:17:37', '黄佳森', '2023-01-06 19:17:37');
INSERT INTO `sys_log` VALUES (22463, NULL, NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.processPaymentImportExcel()', NULL, 3540, '117.140.240.127', NULL, '2023-01-06 19:17:49', NULL, '2023-01-06 19:17:49');
INSERT INTO `sys_log` VALUES (22464, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 332, '117.140.240.127', '黄佳森', '2023-01-06 19:17:50', '黄佳森', '2023-01-06 19:17:50');
INSERT INTO `sys_log` VALUES (22465, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 103, '117.140.240.127', '黄佳森', '2023-01-06 19:17:57', '黄佳森', '2023-01-06 19:17:57');
INSERT INTO `sys_log` VALUES (22466, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 84, '117.140.240.127', '黄佳森', '2023-01-06 19:17:57', '黄佳森', '2023-01-06 19:17:57');
INSERT INTO `sys_log` VALUES (22467, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 138, '117.140.240.127', '黄佳森', '2023-01-06 19:17:57', '黄佳森', '2023-01-06 19:17:57');
INSERT INTO `sys_log` VALUES (22468, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '2', 113, '117.140.240.127', '黄佳森', '2023-01-06 19:18:01', '黄佳森', '2023-01-06 19:18:01');
INSERT INTO `sys_log` VALUES (22469, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 148, '117.140.240.127', '黄佳森', '2023-01-06 19:18:04', '黄佳森', '2023-01-06 19:18:04');
INSERT INTO `sys_log` VALUES (22470, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 1083, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:14', 'admin', '2023-01-06 19:56:14');
INSERT INTO `sys_log` VALUES (22471, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 21, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:14', 'admin', '2023-01-06 19:56:14');
INSERT INTO `sys_log` VALUES (22472, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:14', 'admin', '2023-01-06 19:56:14');
INSERT INTO `sys_log` VALUES (22473, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 35, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:14', 'admin', '2023-01-06 19:56:14');
INSERT INTO `sys_log` VALUES (22474, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:17', 'admin', '2023-01-06 19:56:17');
INSERT INTO `sys_log` VALUES (22475, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 26, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:17', 'admin', '2023-01-06 19:56:17');
INSERT INTO `sys_log` VALUES (22476, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 67, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:17', 'admin', '2023-01-06 19:56:17');
INSERT INTO `sys_log` VALUES (22477, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 21, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:21', 'admin', '2023-01-06 19:56:21');
INSERT INTO `sys_log` VALUES (22478, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 23, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:21', 'admin', '2023-01-06 19:56:21');
INSERT INTO `sys_log` VALUES (22479, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 41, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:21', 'admin', '2023-01-06 19:56:21');
INSERT INTO `sys_log` VALUES (22480, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:27', 'admin', '2023-01-06 19:56:27');
INSERT INTO `sys_log` VALUES (22481, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:27', 'admin', '2023-01-06 19:56:27');
INSERT INTO `sys_log` VALUES (22482, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 52, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:27', 'admin', '2023-01-06 19:56:27');
INSERT INTO `sys_log` VALUES (22483, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 21, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:27', 'admin', '2023-01-06 19:56:27');
INSERT INTO `sys_log` VALUES (22484, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:36', 'admin', '2023-01-06 19:56:36');
INSERT INTO `sys_log` VALUES (22485, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:36', 'admin', '2023-01-06 19:56:36');
INSERT INTO `sys_log` VALUES (22486, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:36', 'admin', '2023-01-06 19:56:36');
INSERT INTO `sys_log` VALUES (22487, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:40', 'admin', '2023-01-06 19:56:40');
INSERT INTO `sys_log` VALUES (22488, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 35, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:40', 'admin', '2023-01-06 19:56:40');
INSERT INTO `sys_log` VALUES (22489, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:40', 'admin', '2023-01-06 19:56:40');
INSERT INTO `sys_log` VALUES (22490, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:45', 'admin', '2023-01-06 19:56:45');
INSERT INTO `sys_log` VALUES (22491, 'admin', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 124, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:56:45', 'admin', '2023-01-06 19:56:45');
INSERT INTO `sys_log` VALUES (22492, 'admin', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 248, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:01', 'admin', '2023-01-06 19:57:01');
INSERT INTO `sys_log` VALUES (22493, 'admin', NULL, 'cn.edu.guet.controller.ProcessPaymentContractController.getProcessPaymentContractData()', '1', 88, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:05', 'admin', '2023-01-06 19:57:05');
INSERT INTO `sys_log` VALUES (22494, 'admin', NULL, 'cn.edu.guet.controller.LogisticsPaymentContractController.getLogisticsPaymentContractData()', '1', 73, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:08', 'admin', '2023-01-06 19:57:08');
INSERT INTO `sys_log` VALUES (22495, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 23, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:14', 'admin', '2023-01-06 19:57:14');
INSERT INTO `sys_log` VALUES (22496, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 10, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:14', 'admin', '2023-01-06 19:57:14');
INSERT INTO `sys_log` VALUES (22497, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:15', 'admin', '2023-01-06 19:57:15');
INSERT INTO `sys_log` VALUES (22498, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 0, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:26', 'admin', '2023-01-06 19:57:26');
INSERT INTO `sys_log` VALUES (22499, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 36, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:29', 'admin', '2023-01-06 19:57:29');
INSERT INTO `sys_log` VALUES (22500, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 45, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:29', 'admin', '2023-01-06 19:57:29');
INSERT INTO `sys_log` VALUES (22501, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 14, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:29', 'admin', '2023-01-06 19:57:29');
INSERT INTO `sys_log` VALUES (22502, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 0, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:36', 'admin', '2023-01-06 19:57:36');
INSERT INTO `sys_log` VALUES (22503, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 20, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:47', 'admin', '2023-01-06 19:57:47');
INSERT INTO `sys_log` VALUES (22504, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 38, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:47', 'admin', '2023-01-06 19:57:47');
INSERT INTO `sys_log` VALUES (22505, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:47', 'admin', '2023-01-06 19:57:47');
INSERT INTO `sys_log` VALUES (22506, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 0, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:57:52', 'admin', '2023-01-06 19:57:52');
INSERT INTO `sys_log` VALUES (22507, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 22, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:58:01', 'admin', '2023-01-06 19:58:01');
INSERT INTO `sys_log` VALUES (22508, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 31, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:58:01', 'admin', '2023-01-06 19:58:01');
INSERT INTO `sys_log` VALUES (22509, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 7, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:58:01', 'admin', '2023-01-06 19:58:01');
INSERT INTO `sys_log` VALUES (22510, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 1, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:58:07', 'admin', '2023-01-06 19:58:07');
INSERT INTO `sys_log` VALUES (22511, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 140, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:59:57', 'admin', '2023-01-06 19:59:57');
INSERT INTO `sys_log` VALUES (22512, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 157, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:59:57', 'admin', '2023-01-06 19:59:57');
INSERT INTO `sys_log` VALUES (22513, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 64, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 19:59:57', 'admin', '2023-01-06 19:59:57');
INSERT INTO `sys_log` VALUES (22514, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:00:00', 'admin', '2023-01-06 20:00:00');
INSERT INTO `sys_log` VALUES (22515, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 27, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:00:00', 'admin', '2023-01-06 20:00:00');
INSERT INTO `sys_log` VALUES (22516, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 12, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:00:00', 'admin', '2023-01-06 20:00:00');
INSERT INTO `sys_log` VALUES (22517, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 0, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:00:01', 'admin', '2023-01-06 20:00:01');
INSERT INTO `sys_log` VALUES (22518, NULL, NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 685, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 20:00:02', NULL, '2023-01-06 20:00:02');
INSERT INTO `sys_log` VALUES (22519, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '90', 38, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:00:47', 'admin', '2023-01-06 20:00:47');
INSERT INTO `sys_log` VALUES (22520, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '90', 29, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:01:49', 'admin', '2023-01-06 20:01:49');
INSERT INTO `sys_log` VALUES (22521, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 295, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:04:34', 'admin', '2023-01-06 20:04:34');
INSERT INTO `sys_log` VALUES (22522, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 286, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:04:34', 'admin', '2023-01-06 20:04:34');
INSERT INTO `sys_log` VALUES (22523, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 10, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:04:34', 'admin', '2023-01-06 20:04:34');
INSERT INTO `sys_log` VALUES (22524, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 0, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:04:35', 'admin', '2023-01-06 20:04:35');
INSERT INTO `sys_log` VALUES (22525, NULL, NULL, 'cn.edu.guet.controller.LogisticsContractController.ExportExcel()', NULL, 532, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 20:04:36', NULL, '2023-01-06 20:04:36');
INSERT INTO `sys_log` VALUES (22526, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:31', 'admin', '2023-01-06 20:05:31');
INSERT INTO `sys_log` VALUES (22527, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 31, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:31', 'admin', '2023-01-06 20:05:31');
INSERT INTO `sys_log` VALUES (22528, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 30, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:31', 'admin', '2023-01-06 20:05:31');
INSERT INTO `sys_log` VALUES (22529, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 10, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:31', 'admin', '2023-01-06 20:05:31');
INSERT INTO `sys_log` VALUES (22530, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 23, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:34', 'admin', '2023-01-06 20:05:34');
INSERT INTO `sys_log` VALUES (22531, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 49, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:51', 'admin', '2023-01-06 20:05:51');
INSERT INTO `sys_log` VALUES (22532, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 62, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:51', 'admin', '2023-01-06 20:05:51');
INSERT INTO `sys_log` VALUES (22533, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:05:51', 'admin', '2023-01-06 20:05:51');
INSERT INTO `sys_log` VALUES (22534, 'admin', NULL, 'cn.edu.guet.controller.ShippingContractController.getshippingContractData()', '1', 97, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:06:13', 'admin', '2023-01-06 20:06:13');
INSERT INTO `sys_log` VALUES (22535, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:06:13', 'admin', '2023-01-06 20:06:13');
INSERT INTO `sys_log` VALUES (22536, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:06:17', 'admin', '2023-01-06 20:06:17');
INSERT INTO `sys_log` VALUES (22537, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 44, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:06:17', 'admin', '2023-01-06 20:06:17');
INSERT INTO `sys_log` VALUES (22538, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 21, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:06:17', 'admin', '2023-01-06 20:06:17');
INSERT INTO `sys_log` VALUES (22539, 'admin', NULL, 'cn.edu.guet.controller.PurchasePaymentContractController.getPurchasePaymentContractData()', '1', 327, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:06:48', 'admin', '2023-01-06 20:06:48');
INSERT INTO `sys_log` VALUES (22540, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 15, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:03', 'admin', '2023-01-06 20:08:03');
INSERT INTO `sys_log` VALUES (22541, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:03', 'admin', '2023-01-06 20:08:03');
INSERT INTO `sys_log` VALUES (22542, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 42, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:03', 'admin', '2023-01-06 20:08:03');
INSERT INTO `sys_log` VALUES (22543, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 22, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:04', 'admin', '2023-01-06 20:08:04');
INSERT INTO `sys_log` VALUES (22544, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:31', 'admin', '2023-01-06 20:08:31');
INSERT INTO `sys_log` VALUES (22545, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:31', 'admin', '2023-01-06 20:08:31');
INSERT INTO `sys_log` VALUES (22546, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 30, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:32', 'admin', '2023-01-06 20:08:32');
INSERT INTO `sys_log` VALUES (22547, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 9, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:32', 'admin', '2023-01-06 20:08:32');
INSERT INTO `sys_log` VALUES (22548, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 31, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:36', 'admin', '2023-01-06 20:08:36');
INSERT INTO `sys_log` VALUES (22549, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 40, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:36', 'admin', '2023-01-06 20:08:36');
INSERT INTO `sys_log` VALUES (22550, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:36', 'admin', '2023-01-06 20:08:36');
INSERT INTO `sys_log` VALUES (22551, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 28, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:56', 'admin', '2023-01-06 20:08:56');
INSERT INTO `sys_log` VALUES (22552, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 44, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:56', 'admin', '2023-01-06 20:08:56');
INSERT INTO `sys_log` VALUES (22553, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 10, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:08:56', 'admin', '2023-01-06 20:08:56');
INSERT INTO `sys_log` VALUES (22554, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:07', 'admin', '2023-01-06 20:09:07');
INSERT INTO `sys_log` VALUES (22555, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 40, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:07', 'admin', '2023-01-06 20:09:07');
INSERT INTO `sys_log` VALUES (22556, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 11, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:07', 'admin', '2023-01-06 20:09:07');
INSERT INTO `sys_log` VALUES (22557, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 34, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:16', 'admin', '2023-01-06 20:09:16');
INSERT INTO `sys_log` VALUES (22558, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 44, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:16', 'admin', '2023-01-06 20:09:16');
INSERT INTO `sys_log` VALUES (22559, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 22, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:16', 'admin', '2023-01-06 20:09:16');
INSERT INTO `sys_log` VALUES (22560, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:51', 'admin', '2023-01-06 20:09:51');
INSERT INTO `sys_log` VALUES (22561, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 27, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:51', 'admin', '2023-01-06 20:09:51');
INSERT INTO `sys_log` VALUES (22562, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 7, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:09:51', 'admin', '2023-01-06 20:09:51');
INSERT INTO `sys_log` VALUES (22563, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 24, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:12', 'admin', '2023-01-06 20:10:12');
INSERT INTO `sys_log` VALUES (22564, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 38, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:12', 'admin', '2023-01-06 20:10:12');
INSERT INTO `sys_log` VALUES (22565, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 23, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:13', 'admin', '2023-01-06 20:10:13');
INSERT INTO `sys_log` VALUES (22566, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 242, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:24', 'admin', '2023-01-06 20:10:24');
INSERT INTO `sys_log` VALUES (22567, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 36, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:24', 'admin', '2023-01-06 20:10:24');
INSERT INTO `sys_log` VALUES (22568, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:24', 'admin', '2023-01-06 20:10:24');
INSERT INTO `sys_log` VALUES (22569, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 51, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:52', 'admin', '2023-01-06 20:10:52');
INSERT INTO `sys_log` VALUES (22570, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 68, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:52', 'admin', '2023-01-06 20:10:52');
INSERT INTO `sys_log` VALUES (22571, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 11, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:10:52', 'admin', '2023-01-06 20:10:52');
INSERT INTO `sys_log` VALUES (22572, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:09', 'admin', '2023-01-06 20:11:09');
INSERT INTO `sys_log` VALUES (22573, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 35, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:09', 'admin', '2023-01-06 20:11:09');
INSERT INTO `sys_log` VALUES (22574, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 8, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:09', 'admin', '2023-01-06 20:11:09');
INSERT INTO `sys_log` VALUES (22575, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:15', 'admin', '2023-01-06 20:11:15');
INSERT INTO `sys_log` VALUES (22576, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 32, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:15', 'admin', '2023-01-06 20:11:15');
INSERT INTO `sys_log` VALUES (22577, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 15, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:15', 'admin', '2023-01-06 20:11:15');
INSERT INTO `sys_log` VALUES (22578, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 30, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:21', 'admin', '2023-01-06 20:11:21');
INSERT INTO `sys_log` VALUES (22579, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 37, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:21', 'admin', '2023-01-06 20:11:21');
INSERT INTO `sys_log` VALUES (22580, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 11, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:21', 'admin', '2023-01-06 20:11:21');
INSERT INTO `sys_log` VALUES (22581, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:26', 'admin', '2023-01-06 20:11:26');
INSERT INTO `sys_log` VALUES (22582, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 34, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:26', 'admin', '2023-01-06 20:11:26');
INSERT INTO `sys_log` VALUES (22583, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 20, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:26', 'admin', '2023-01-06 20:11:26');
INSERT INTO `sys_log` VALUES (22584, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 24, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:45', 'admin', '2023-01-06 20:11:45');
INSERT INTO `sys_log` VALUES (22585, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 8, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:45', 'admin', '2023-01-06 20:11:45');
INSERT INTO `sys_log` VALUES (22586, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 121, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:11:45', 'admin', '2023-01-06 20:11:45');
INSERT INTO `sys_log` VALUES (22587, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:19', 'admin', '2023-01-06 20:14:19');
INSERT INTO `sys_log` VALUES (22588, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 33, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:20', 'admin', '2023-01-06 20:14:20');
INSERT INTO `sys_log` VALUES (22589, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:20', 'admin', '2023-01-06 20:14:20');
INSERT INTO `sys_log` VALUES (22590, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 26, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:23', 'admin', '2023-01-06 20:14:23');
INSERT INTO `sys_log` VALUES (22591, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 36, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:23', 'admin', '2023-01-06 20:14:23');
INSERT INTO `sys_log` VALUES (22592, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:23', 'admin', '2023-01-06 20:14:23');
INSERT INTO `sys_log` VALUES (22593, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:27', 'admin', '2023-01-06 20:14:27');
INSERT INTO `sys_log` VALUES (22594, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 28, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:27', 'admin', '2023-01-06 20:14:27');
INSERT INTO `sys_log` VALUES (22595, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 8, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:14:27', 'admin', '2023-01-06 20:14:27');
INSERT INTO `sys_log` VALUES (22596, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 45, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:15:01', 'admin', '2023-01-06 20:15:01');
INSERT INTO `sys_log` VALUES (22597, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 91, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:15:01', 'admin', '2023-01-06 20:15:01');
INSERT INTO `sys_log` VALUES (22598, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 41, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:15:01', 'admin', '2023-01-06 20:15:01');
INSERT INTO `sys_log` VALUES (22599, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:15:38', 'admin', '2023-01-06 20:15:38');
INSERT INTO `sys_log` VALUES (22600, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 33, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:15:38', 'admin', '2023-01-06 20:15:38');
INSERT INTO `sys_log` VALUES (22601, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:15:38', 'admin', '2023-01-06 20:15:38');
INSERT INTO `sys_log` VALUES (22602, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:19:28', 'admin', '2023-01-06 20:19:28');
INSERT INTO `sys_log` VALUES (22603, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 36, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:19:28', 'admin', '2023-01-06 20:19:28');
INSERT INTO `sys_log` VALUES (22604, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 8, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:19:28', 'admin', '2023-01-06 20:19:28');
INSERT INTO `sys_log` VALUES (22605, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 287, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:18', 'admin', '2023-01-06 20:24:18');
INSERT INTO `sys_log` VALUES (22606, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 12, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:18', 'admin', '2023-01-06 20:24:18');
INSERT INTO `sys_log` VALUES (22607, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 288, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:18', 'admin', '2023-01-06 20:24:18');
INSERT INTO `sys_log` VALUES (22608, 'admin', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"admin\"}', 899, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:35', 'admin', '2023-01-06 20:24:35');
INSERT INTO `sys_log` VALUES (22609, 'admin', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"admin\"', 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:35', 'admin', '2023-01-06 20:24:35');
INSERT INTO `sys_log` VALUES (22610, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"admin\"', 24, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:35', 'admin', '2023-01-06 20:24:35');
INSERT INTO `sys_log` VALUES (22611, 'admin', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"admin\"', 127, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:35', 'admin', '2023-01-06 20:24:35');
INSERT INTO `sys_log` VALUES (22612, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 25, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:40', 'admin', '2023-01-06 20:24:40');
INSERT INTO `sys_log` VALUES (22613, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 10, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:40', 'admin', '2023-01-06 20:24:40');
INSERT INTO `sys_log` VALUES (22614, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 73, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:24:40', 'admin', '2023-01-06 20:24:40');
INSERT INTO `sys_log` VALUES (22615, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 336, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:28:45', 'admin', '2023-01-06 20:28:45');
INSERT INTO `sys_log` VALUES (22616, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 308, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:28:45', 'admin', '2023-01-06 20:28:45');
INSERT INTO `sys_log` VALUES (22617, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 13, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:28:45', 'admin', '2023-01-06 20:28:45');
INSERT INTO `sys_log` VALUES (22618, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 24, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:28', 'admin', '2023-01-06 20:29:28');
INSERT INTO `sys_log` VALUES (22619, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 35, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:28', 'admin', '2023-01-06 20:29:28');
INSERT INTO `sys_log` VALUES (22620, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 40, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:28', 'admin', '2023-01-06 20:29:28');
INSERT INTO `sys_log` VALUES (22621, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 26, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:30', 'admin', '2023-01-06 20:29:30');
INSERT INTO `sys_log` VALUES (22622, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 27, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:30', 'admin', '2023-01-06 20:29:30');
INSERT INTO `sys_log` VALUES (22623, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 38, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:30', 'admin', '2023-01-06 20:29:30');
INSERT INTO `sys_log` VALUES (22624, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.sendExportParm()', NULL, 0, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:32', 'admin', '2023-01-06 20:29:32');
INSERT INTO `sys_log` VALUES (22625, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 20, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:44', 'admin', '2023-01-06 20:29:44');
INSERT INTO `sys_log` VALUES (22626, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 27, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:44', 'admin', '2023-01-06 20:29:44');
INSERT INTO `sys_log` VALUES (22627, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 39, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:44', 'admin', '2023-01-06 20:29:44');
INSERT INTO `sys_log` VALUES (22628, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 28, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:47', 'admin', '2023-01-06 20:29:47');
INSERT INTO `sys_log` VALUES (22629, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 31, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:47', 'admin', '2023-01-06 20:29:47');
INSERT INTO `sys_log` VALUES (22630, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:29:47', 'admin', '2023-01-06 20:29:47');
INSERT INTO `sys_log` VALUES (22631, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 611, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:35:23', 'admin', '2023-01-06 20:35:23');
INSERT INTO `sys_log` VALUES (22632, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 564, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:35:23', 'admin', '2023-01-06 20:35:23');
INSERT INTO `sys_log` VALUES (22633, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 11, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:35:23', 'admin', '2023-01-06 20:35:23');
INSERT INTO `sys_log` VALUES (22634, NULL, NULL, 'cn.edu.guet.controller.LogisticsContractController.purchaseImportExcel()', NULL, 0, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 20:35:27', NULL, '2023-01-06 20:35:27');
INSERT INTO `sys_log` VALUES (22635, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 30, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:37:37', 'admin', '2023-01-06 20:37:37');
INSERT INTO `sys_log` VALUES (22636, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 29, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:37:37', 'admin', '2023-01-06 20:37:37');
INSERT INTO `sys_log` VALUES (22637, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 9, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 20:37:37', 'admin', '2023-01-06 20:37:37');
INSERT INTO `sys_log` VALUES (22638, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '90', 67, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:12:36', 'admin', '2023-01-06 21:12:36');
INSERT INTO `sys_log` VALUES (22639, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '90', 32, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:12:43', 'admin', '2023-01-06 21:12:43');
INSERT INTO `sys_log` VALUES (22640, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 47, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:12:54', 'admin', '2023-01-06 21:12:54');
INSERT INTO `sys_log` VALUES (22641, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 105, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:12:55', 'admin', '2023-01-06 21:12:55');
INSERT INTO `sys_log` VALUES (22642, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 102, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:12:55', 'admin', '2023-01-06 21:12:55');
INSERT INTO `sys_log` VALUES (22643, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"CG测试\"', 49, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:00', 'admin', '2023-01-06 21:13:00');
INSERT INTO `sys_log` VALUES (22644, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 20, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:13', 'admin', '2023-01-06 21:13:13');
INSERT INTO `sys_log` VALUES (22645, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 36, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:13', 'admin', '2023-01-06 21:13:13');
INSERT INTO `sys_log` VALUES (22646, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 11, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:13', 'admin', '2023-01-06 21:13:13');
INSERT INTO `sys_log` VALUES (22647, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 16, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:38', 'admin', '2023-01-06 21:13:38');
INSERT INTO `sys_log` VALUES (22648, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 23, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:38', 'admin', '2023-01-06 21:13:38');
INSERT INTO `sys_log` VALUES (22649, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 14, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:38', 'admin', '2023-01-06 21:13:38');
INSERT INTO `sys_log` VALUES (22650, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 67, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:38', 'admin', '2023-01-06 21:13:38');
INSERT INTO `sys_log` VALUES (22651, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getRemainingOutboundVolume()', '\"60\"', 35, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:41', 'admin', '2023-01-06 21:13:41');
INSERT INTO `sys_log` VALUES (22652, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getDetailSaleContract()', '\"60\"', 39, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:41', 'admin', '2023-01-06 21:13:41');
INSERT INTO `sys_log` VALUES (22653, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 19, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:46', 'admin', '2023-01-06 21:13:46');
INSERT INTO `sys_log` VALUES (22654, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 26, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:46', 'admin', '2023-01-06 21:13:46');
INSERT INTO `sys_log` VALUES (22655, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 18, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:13:47', 'admin', '2023-01-06 21:13:47');
INSERT INTO `sys_log` VALUES (22656, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 34, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:15:32', 'admin', '2023-01-06 21:15:32');
INSERT INTO `sys_log` VALUES (22657, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 246, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:15:32', 'admin', '2023-01-06 21:15:32');
INSERT INTO `sys_log` VALUES (22658, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 246, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:15:32', 'admin', '2023-01-06 21:15:32');
INSERT INTO `sys_log` VALUES (22659, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 21, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:15:32', 'admin', '2023-01-06 21:15:32');
INSERT INTO `sys_log` VALUES (22660, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getRemainingOutboundVolume()', '\"60\"', 34, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:15:33', 'admin', '2023-01-06 21:15:33');
INSERT INTO `sys_log` VALUES (22661, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getDetailSaleContract()', '\"60\"', 60, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:15:33', 'admin', '2023-01-06 21:15:33');
INSERT INTO `sys_log` VALUES (22662, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 297, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:16:38', 'admin', '2023-01-06 21:16:38');
INSERT INTO `sys_log` VALUES (22663, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 316, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:16:38', 'admin', '2023-01-06 21:16:38');
INSERT INTO `sys_log` VALUES (22664, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 10, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:16:38', 'admin', '2023-01-06 21:16:38');
INSERT INTO `sys_log` VALUES (22665, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 823, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:18:44', 'admin', '2023-01-06 21:18:44');
INSERT INTO `sys_log` VALUES (22666, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:18:44', 'admin', '2023-01-06 21:18:44');
INSERT INTO `sys_log` VALUES (22667, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 811, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 21:18:44', 'admin', '2023-01-06 21:18:44');
INSERT INTO `sys_log` VALUES (22668, NULL, NULL, 'cn.edu.guet.controller.LogisticsContractController.purchaseImportExcel()', NULL, 569, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 21:18:51', NULL, '2023-01-06 21:18:51');
INSERT INTO `sys_log` VALUES (22669, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 1191, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:09:42', 'admin', '2023-01-06 22:09:42');
INSERT INTO `sys_log` VALUES (22670, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 1052, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:09:42', 'admin', '2023-01-06 22:09:42');
INSERT INTO `sys_log` VALUES (22671, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 72, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:09:43', 'admin', '2023-01-06 22:09:43');
INSERT INTO `sys_log` VALUES (22672, NULL, NULL, 'cn.edu.guet.controller.LogisticsContractController.purchaseImportExcel()', NULL, 852, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:12:26', NULL, '2023-01-06 22:12:26');
INSERT INTO `sys_log` VALUES (22673, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 2612, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:20', 'admin', '2023-01-06 22:15:20');
INSERT INTO `sys_log` VALUES (22674, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 2679, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:21', 'admin', '2023-01-06 22:15:21');
INSERT INTO `sys_log` VALUES (22675, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 2509, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:21', 'admin', '2023-01-06 22:15:21');
INSERT INTO `sys_log` VALUES (22676, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 454, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:21', 'admin', '2023-01-06 22:15:21');
INSERT INTO `sys_log` VALUES (22677, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 198, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:22', 'admin', '2023-01-06 22:15:22');
INSERT INTO `sys_log` VALUES (22678, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 40, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:22', 'admin', '2023-01-06 22:15:22');
INSERT INTO `sys_log` VALUES (22679, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 878, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:23', 'admin', '2023-01-06 22:15:23');
INSERT INTO `sys_log` VALUES (22680, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 68, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:23', 'admin', '2023-01-06 22:15:23');
INSERT INTO `sys_log` VALUES (22681, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 69, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:24', 'admin', '2023-01-06 22:15:24');
INSERT INTO `sys_log` VALUES (22682, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 46, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:24', 'admin', '2023-01-06 22:15:24');
INSERT INTO `sys_log` VALUES (22683, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 928, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:24', 'admin', '2023-01-06 22:15:24');
INSERT INTO `sys_log` VALUES (22684, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 67, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:24', 'admin', '2023-01-06 22:15:24');
INSERT INTO `sys_log` VALUES (22685, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 108, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:26', 'admin', '2023-01-06 22:15:26');
INSERT INTO `sys_log` VALUES (22686, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 1477, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:27', 'admin', '2023-01-06 22:15:27');
INSERT INTO `sys_log` VALUES (22687, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 32, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:28', 'admin', '2023-01-06 22:15:28');
INSERT INTO `sys_log` VALUES (22688, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 89, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:37', 'admin', '2023-01-06 22:15:37');
INSERT INTO `sys_log` VALUES (22689, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 149, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:37', 'admin', '2023-01-06 22:15:37');
INSERT INTO `sys_log` VALUES (22690, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 100, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:37', 'admin', '2023-01-06 22:15:37');
INSERT INTO `sys_log` VALUES (22691, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 134, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:37', 'admin', '2023-01-06 22:15:37');
INSERT INTO `sys_log` VALUES (22692, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 86, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:38', 'admin', '2023-01-06 22:15:38');
INSERT INTO `sys_log` VALUES (22693, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 2853, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:40', 'admin', '2023-01-06 22:15:40');
INSERT INTO `sys_log` VALUES (22694, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 155, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:44', 'admin', '2023-01-06 22:15:44');
INSERT INTO `sys_log` VALUES (22695, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 562, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:44', 'admin', '2023-01-06 22:15:44');
INSERT INTO `sys_log` VALUES (22696, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 498, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:15:45', 'admin', '2023-01-06 22:15:45');
INSERT INTO `sys_log` VALUES (22697, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getDetailLogistics()', '90', 356, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:00', 'admin', '2023-01-06 22:16:00');
INSERT INTO `sys_log` VALUES (22698, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 256, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:04', 'admin', '2023-01-06 22:16:04');
INSERT INTO `sys_log` VALUES (22699, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 257, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:04', 'admin', '2023-01-06 22:16:04');
INSERT INTO `sys_log` VALUES (22700, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 481, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:04', 'admin', '2023-01-06 22:16:04');
INSERT INTO `sys_log` VALUES (22701, 'admin', NULL, 'cn.edu.guet.controller.PurchaseContractController.getPurchaseDetail()', '\"CG测试\"', 328, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:06', 'admin', '2023-01-06 22:16:06');
INSERT INTO `sys_log` VALUES (22702, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 174, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:11', 'admin', '2023-01-06 22:16:11');
INSERT INTO `sys_log` VALUES (22703, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 315, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:11', 'admin', '2023-01-06 22:16:11');
INSERT INTO `sys_log` VALUES (22704, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 814, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:12', 'admin', '2023-01-06 22:16:12');
INSERT INTO `sys_log` VALUES (22705, NULL, NULL, 'cn.edu.guet.controller.LogisticsContractController.purchaseImportExcel()', NULL, 6466, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:16:21', NULL, '2023-01-06 22:16:21');
INSERT INTO `sys_log` VALUES (22706, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 253, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:16:22', 'admin', '2023-01-06 22:16:22');
INSERT INTO `sys_log` VALUES (22707, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 423, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:21:15', 'admin', '2023-01-06 22:21:15');
INSERT INTO `sys_log` VALUES (22708, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 521, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:21:15', 'admin', '2023-01-06 22:21:15');
INSERT INTO `sys_log` VALUES (22709, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 1053, '0:0:0:0:0:0:0:1', 'admin', '2023-01-06 22:21:17', 'admin', '2023-01-06 22:21:17');
INSERT INTO `sys_log` VALUES (22710, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 110, '111.196.132.113', 'admin', '2023-01-06 22:22:46', 'admin', '2023-01-06 22:22:46');
INSERT INTO `sys_log` VALUES (22711, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 169, '111.196.132.113', 'admin', '2023-01-06 22:22:46', 'admin', '2023-01-06 22:22:46');
INSERT INTO `sys_log` VALUES (22712, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 71, '111.196.132.113', 'admin', '2023-01-06 22:22:47', 'admin', '2023-01-06 22:22:47');
INSERT INTO `sys_log` VALUES (22713, 'admin', NULL, 'cn.edu.guet.controller.LogisticsContractController.getList()', '{\"currentPage\":1,\"logisticsContractNo\":\"\",\"pageSize\":10,\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 134, '111.196.132.113', 'admin', '2023-01-06 22:22:47', 'admin', '2023-01-06 22:22:47');
INSERT INTO `sys_log` VALUES (22714, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 46, '111.196.132.113', 'admin', '2023-01-06 22:22:47', 'admin', '2023-01-06 22:22:47');
INSERT INTO `sys_log` VALUES (22715, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 51, '111.196.132.113', 'admin', '2023-01-06 22:22:47', 'admin', '2023-01-06 22:22:47');
INSERT INTO `sys_log` VALUES (22716, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 112, '111.196.132.113', 'admin', '2023-01-06 22:33:38', 'admin', '2023-01-06 22:33:38');
INSERT INTO `sys_log` VALUES (22717, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 100, '111.196.132.113', 'admin', '2023-01-06 22:33:39', 'admin', '2023-01-06 22:33:39');
INSERT INTO `sys_log` VALUES (22718, 'admin', NULL, 'cn.edu.guet.controller.SaleContractController.getList()', '{\"currentPage\":1,\"goodsName\":\"\",\"pageSize\":10,\"saleCompanyName\":\"\",\"saleContractNo\":\"\",\"squeezeSeason\":\"\"}', 363, '111.196.132.113', 'admin', '2023-01-06 22:33:39', 'admin', '2023-01-06 22:33:39');
INSERT INTO `sys_log` VALUES (22719, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 51, '111.196.132.113', 'admin', '2023-01-06 22:33:39', 'admin', '2023-01-06 22:33:39');
INSERT INTO `sys_log` VALUES (22720, 'admin', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 95, '111.196.132.113', 'admin', '2023-01-06 22:33:45', 'admin', '2023-01-06 22:33:45');
INSERT INTO `sys_log` VALUES (22721, 'admin', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 105, '111.196.132.113', 'admin', '2023-01-06 22:33:45', 'admin', '2023-01-06 22:33:45');
INSERT INTO `sys_log` VALUES (22722, 'admin', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 153, '111.196.132.113', 'admin', '2023-01-06 22:33:45', 'admin', '2023-01-06 22:33:45');
INSERT INTO `sys_log` VALUES (22723, 'huangjiasen', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"huangjiasen\"}', 655, '111.196.132.113', 'huangjiasen', '2023-01-06 22:33:58', 'huangjiasen', '2023-01-06 22:33:58');
INSERT INTO `sys_log` VALUES (22724, 'huangjiasen', NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"huangjiasen\"', 92, '111.196.132.113', 'huangjiasen', '2023-01-06 22:33:58', 'huangjiasen', '2023-01-06 22:33:58');
INSERT INTO `sys_log` VALUES (22725, 'huangjiasen', NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"huangjiasen\"', 92, '111.196.132.113', 'huangjiasen', '2023-01-06 22:33:58', 'huangjiasen', '2023-01-06 22:33:58');
INSERT INTO `sys_log` VALUES (22726, 'huangjiasen', NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"huangjiasen\"', 362, '111.196.132.113', 'huangjiasen', '2023-01-06 22:33:59', 'huangjiasen', '2023-01-06 22:33:59');
INSERT INTO `sys_log` VALUES (22727, 'huangjiasen', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 91, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:02', 'huangjiasen', '2023-01-06 22:34:02');
INSERT INTO `sys_log` VALUES (22728, 'huangjiasen', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 94, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:02', 'huangjiasen', '2023-01-06 22:34:02');
INSERT INTO `sys_log` VALUES (22729, 'huangjiasen', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 166, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:02', 'huangjiasen', '2023-01-06 22:34:02');
INSERT INTO `sys_log` VALUES (22730, 'huangjiasen', NULL, 'cn.edu.guet.controller.ProcessContractController.addNewProcessContract()', '{\"alcoholConversionFormula\":\"0000\",\"concentratedSolutionConversionFormula\":\"0000000000\",\"contractPhotoArray\":[],\"createBy\":\"huangjiasen\",\"customerEnterpriseName\":\"广西丰沣顺国际物流有限公司\",\"goodsName\":\"00000\",\"i...', 317, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:14', 'huangjiasen', '2023-01-06 22:34:14');
INSERT INTO `sys_log` VALUES (22731, 'huangjiasen', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 153, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:14', 'huangjiasen', '2023-01-06 22:34:14');
INSERT INTO `sys_log` VALUES (22732, 'huangjiasen', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 87, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:24', 'huangjiasen', '2023-01-06 22:34:24');
INSERT INTO `sys_log` VALUES (22733, 'huangjiasen', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 90, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:24', 'huangjiasen', '2023-01-06 22:34:24');
INSERT INTO `sys_log` VALUES (22734, 'huangjiasen', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 153, '111.196.132.113', 'huangjiasen', '2023-01-06 22:34:24', 'huangjiasen', '2023-01-06 22:34:24');
INSERT INTO `sys_log` VALUES (22735, 'huangjiasen', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 340, '0:0:0:0:0:0:0:1', 'huangjiasen', '2023-01-06 22:47:49', 'huangjiasen', '2023-01-06 22:47:49');
INSERT INTO `sys_log` VALUES (22736, 'huangjiasen', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 351, '0:0:0:0:0:0:0:1', 'huangjiasen', '2023-01-06 22:47:49', 'huangjiasen', '2023-01-06 22:47:49');
INSERT INTO `sys_log` VALUES (22737, 'huangjiasen', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 379, '0:0:0:0:0:0:0:1', 'huangjiasen', '2023-01-06 22:47:49', 'huangjiasen', '2023-01-06 22:47:49');
INSERT INTO `sys_log` VALUES (22738, 'huangjiasen', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 291, '0:0:0:0:0:0:0:1', 'huangjiasen', '2023-01-06 22:49:36', 'huangjiasen', '2023-01-06 22:49:36');
INSERT INTO `sys_log` VALUES (22739, 'huangjiasen', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 282, '0:0:0:0:0:0:0:1', 'huangjiasen', '2023-01-06 22:49:36', 'huangjiasen', '2023-01-06 22:49:36');
INSERT INTO `sys_log` VALUES (22740, 'huangjiasen', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 307, '0:0:0:0:0:0:0:1', 'huangjiasen', '2023-01-06 22:49:36', 'huangjiasen', '2023-01-06 22:49:36');
INSERT INTO `sys_log` VALUES (22741, NULL, NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 47, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:57:41', NULL, '2023-01-06 22:57:41');
INSERT INTO `sys_log` VALUES (22742, NULL, NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 39, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:57:41', NULL, '2023-01-06 22:57:41');
INSERT INTO `sys_log` VALUES (22743, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 94, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:57:41', NULL, '2023-01-06 22:57:41');
INSERT INTO `sys_log` VALUES (22744, NULL, NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 49, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:21', NULL, '2023-01-06 22:59:21');
INSERT INTO `sys_log` VALUES (22745, NULL, NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 42, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:21', NULL, '2023-01-06 22:59:21');
INSERT INTO `sys_log` VALUES (22746, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 101, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:21', NULL, '2023-01-06 22:59:21');
INSERT INTO `sys_log` VALUES (22747, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.deleteOneProcessContract()', '70', 140, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:26', NULL, '2023-01-06 22:59:26');
INSERT INTO `sys_log` VALUES (22748, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 25, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:26', NULL, '2023-01-06 22:59:26');
INSERT INTO `sys_log` VALUES (22749, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.addNewProcessContract()', '{\"alcoholConversionFormula\":\"11111\",\"concentratedSolutionConversionFormula\":\"111111111\",\"contractPhotoArray\":[],\"customerEnterpriseName\":\"广西丰沣顺国际物流有限公司\",\"goodsName\":\"1111\",\"id\":71,\"oldProcessContractN...', 101, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:36', NULL, '2023-01-06 22:59:36');
INSERT INTO `sys_log` VALUES (22750, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 32, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 22:59:36', NULL, '2023-01-06 22:59:36');
INSERT INTO `sys_log` VALUES (22751, NULL, NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 53, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:33', NULL, '2023-01-06 23:04:33');
INSERT INTO `sys_log` VALUES (22752, NULL, NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 52, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:33', NULL, '2023-01-06 23:04:33');
INSERT INTO `sys_log` VALUES (22753, NULL, NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 102, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:33', NULL, '2023-01-06 23:04:34');
INSERT INTO `sys_log` VALUES (22754, '黄佳森', NULL, 'cn.edu.guet.controller.LoginController.login()', '{\"password\":\"123456\",\"username\":\"huangjiasen\"}', 356, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:04:48', '黄佳森', '2023-01-06 23:04:48');
INSERT INTO `sys_log` VALUES (22755, NULL, NULL, 'cn.edu.guet.controller.SysMenuController.findNavTree()', '\"huangjiasen\"', 39, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:48', NULL, '2023-01-06 23:04:48');
INSERT INTO `sys_log` VALUES (22756, NULL, NULL, 'cn.edu.guet.controller.SysUserController.findPermissions()', '\"huangjiasen\"', 19, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:49', NULL, '2023-01-06 23:04:49');
INSERT INTO `sys_log` VALUES (22757, NULL, NULL, 'cn.edu.guet.controller.SysUserController.getNickName()', '\"huangjiasen\"', 68, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:49', NULL, '2023-01-06 23:04:49');
INSERT INTO `sys_log` VALUES (22758, NULL, NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 17, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:59', NULL, '2023-01-06 23:04:59');
INSERT INTO `sys_log` VALUES (22759, NULL, NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 51, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:59', NULL, '2023-01-06 23:04:59');
INSERT INTO `sys_log` VALUES (22760, NULL, NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 92, '0:0:0:0:0:0:0:1', NULL, '2023-01-06 23:04:59', NULL, '2023-01-06 23:04:59');
INSERT INTO `sys_log` VALUES (22761, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 277, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:30', '黄佳森', '2023-01-06 23:08:30');
INSERT INTO `sys_log` VALUES (22762, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 293, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:30', '黄佳森', '2023-01-06 23:08:30');
INSERT INTO `sys_log` VALUES (22763, '黄佳森', NULL, 'cn.edu.guet.controller.PurchaseContractController.getTPurchaseContractData()', '1', 313, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:30', '黄佳森', '2023-01-06 23:08:30');
INSERT INTO `sys_log` VALUES (22764, '黄佳森', NULL, 'cn.edu.guet.controller.OwnCompanyController.getSelect()', NULL, 24, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:48', '黄佳森', '2023-01-06 23:08:48');
INSERT INTO `sys_log` VALUES (22765, '黄佳森', NULL, 'cn.edu.guet.controller.CustomerController.getSelect()', NULL, 26, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:48', '黄佳森', '2023-01-06 23:08:48');
INSERT INTO `sys_log` VALUES (22766, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 72, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:48', '黄佳森', '2023-01-06 23:08:48');
INSERT INTO `sys_log` VALUES (22767, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.deleteOneProcessContract()', '71', 133, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:51', '黄佳森', '2023-01-06 23:08:51');
INSERT INTO `sys_log` VALUES (22768, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 25, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:08:51', '黄佳森', '2023-01-06 23:08:51');
INSERT INTO `sys_log` VALUES (22769, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.addNewProcessContract()', '{\"alcoholConversionFormula\":\"11111111111111\",\"concentratedSolutionConversionFormula\":\"111111111111\",\"contractPhotoArray\":[],\"createBy\":\"黄佳森\",\"customerEnterpriseName\":\"广西丰沣顺国际物流有限公司\",\"goodsName\":\"11111...', 55, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:09:00', '黄佳森', '2023-01-06 23:09:00');
INSERT INTO `sys_log` VALUES (22770, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 24, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:09:00', '黄佳森', '2023-01-06 23:09:00');
INSERT INTO `sys_log` VALUES (22771, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.deleteOneProcessContract()', '72', 193, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:09:05', '黄佳森', '2023-01-06 23:09:05');
INSERT INTO `sys_log` VALUES (22772, '黄佳森', NULL, 'cn.edu.guet.controller.ProcessContractController.getTProcessContractData()', '1', 38, '0:0:0:0:0:0:0:1', '黄佳森', '2023-01-06 23:09:05', '黄佳森', '2023-01-06 23:09:05');

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
) ENGINE = InnoDB AUTO_INCREMENT = 152 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

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
INSERT INTO `sys_menu` VALUES (17, '采购单', 0, '顶级菜单', '/purchaseContract', NULL, 1, 'ShoppingCart', 5, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (73, '查看', 17, '采购单', NULL, 'sys:purchaseContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (75, '新增', 17, '采购单', NULL, 'sys:purchaseContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (76, '归档', 17, '采购单', NULL, 'sys:purchaseContract:hole', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (77, '删除', 17, '采购单', NULL, 'sys:purchaseContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (78, '付款', 17, '采购单', NULL, 'sys:purchaseContract:pay', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (79, '出纳', 0, '顶级菜单', '/cashier', NULL, 0, 'Money', 13, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (80, '采购付款单', 79, '出纳', '/cashier/cashierPurchasePayment', NULL, 1, 'Money', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (81, '出纳销售单', 79, '出纳', '/cashier/cashierSale', NULL, 1, 'Money', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (82, '查看', 81, '出纳销售单', NULL, 'sys:cashierSale:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (83, '上传', 81, '出纳销售单', NULL, 'sys:cashierSale:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (84, '物流付款单', 79, '出纳', '/cashier/cashierLogisticsPayment', NULL, 1, 'Money', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (85, '出纳海运单', 79, '出纳', '/cashier/cashierShipping', NULL, 1, 'Money', 5, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (86, '查看', 85, '出纳海运单', NULL, 'sys:cashierShipping:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (87, '上传', 85, '出纳海运单', NULL, 'sys:cashierShipping:upload', 2, NULL, 0, NULL, NULL, NULL, '2022-12-12 13:22:15', 0);
INSERT INTO `sys_menu` VALUES (88, '办公经费', 79, '出纳', '/cashier/cashierOfficeExpense', NULL, 1, 'Money', 6, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (89, '查看', 88, '办公经费', NULL, 'sys:cashierOfficeExpense:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (90, '上传', 88, '办公经费', NULL, 'sys:cashierOfficeExpense:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (91, '仓库管理', 0, '顶级菜单', '/warehouseManagement', NULL, 1, 'Discount', 4, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (92, '销售单', 0, '顶级菜单', '/saleContract', NULL, 1, 'Document', 7, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (93, '查看', 92, '销售单', NULL, 'sys:saleContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (94, '新增', 92, '销售单', NULL, 'sys:saleContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (95, '归档', 92, '销售单', NULL, 'sys:saleContract:hole', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (96, '删除', 92, '销售单', NULL, 'sys:saleContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (97, '出库信息', 0, '顶级菜单', '/outbound', NULL, 0, 'Shop', 8, NULL, NULL, NULL, NULL, 0);
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
INSERT INTO `sys_menu` VALUES (108, '财务管理', 0, '顶级菜单', '/finance', NULL, 0, 'Coin', 12, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (109, '报表分析', 108, '财务管理', '/finance/reportAnalysis', NULL, 1, 'TrendCharts', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (110, '办公经费', 108, '财务管理', '/finance/officeExpense', NULL, 1, 'TrendCharts', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (111, '查看', 110, '办公经费', NULL, 'sys:officeExpense:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (112, '新增', 110, '办公经费', NULL, 'sys:officeExpense:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (113, '删除', 110, '办公经费', NULL, 'sys:officeExpense:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (114, '单价走势', 108, '财务管理', '/finance/priceTrend', NULL, 1, 'TrendCharts', 3, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (115, '采购付款单', 0, '顶级菜单', '/purchasePaymentContract', NULL, 1, 'Document', 9, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (116, '查看', 115, '采购付款单', NULL, 'sys:purchasePaymentContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (117, '新增', 115, '采购付款单', NULL, 'sys:purchasePaymentContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (118, '删除', 115, '采购付款单', NULL, 'sys:purchasePaymentContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (119, '物流付款单', 0, '顶级菜单', '/logisticsPaymentContract', NULL, 1, 'Document', 11, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (120, '查看', 119, '物流付款单', NULL, 'sys:logisticsPaymentContract:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (121, '新增', 119, '物流付款单', NULL, 'sys:logisticsPaymentContract:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (122, '删除', 119, '物流付款单', NULL, 'sys:logisticsPaymentContract:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (123, '客户管理', 0, '顶级菜单', '/customerList', NULL, 1, 'User', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (124, '查看', 123, '客户管理', NULL, 'sys:customerList:view', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (125, '新增', 123, '客户管理', NULL, 'sys:customerList:add', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (126, '删除', 123, '客户管理', NULL, 'sys:customerList:delete', 2, NULL, 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (127, '首页', 0, '顶级菜单', '/dashboard', NULL, 1, 'house', -1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (128, '日志管理', 1, '系统管理', '/logList', 'sys:log', 1, 'Monitor', 4, NULL, '2022-11-23 12:04:02', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (129, '查看', 128, '日志管理', '', 'sys:log:view', 2, '', 0, NULL, '2022-11-23 12:06:57', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (130, '公司管理', 0, '顶级菜单', '/ownCompanyList', NULL, 1, 'Management', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (132, '查看', 130, '公司管理', NULL, 'sys:ownCompanyList:view', 2, '', 0, NULL, '2022-12-05 18:42:04', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (133, '新增', 130, '公司管理', NULL, 'sys:ownCompanyList:add', 2, '', 0, NULL, '2022-12-05 18:44:19', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (134, '删除', 130, '公司管理', NULL, 'sys:ownCompanyList:delete', 2, '', 0, NULL, '2022-12-05 18:44:47', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (135, '加工单', 0, '顶级菜单', '/processContract', NULL, 1, 'Box', 6, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (136, '查看', 135, '加工单', '', 'sys:processContract:view', 2, '', 0, NULL, '2022-12-12 09:39:33', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (137, '新增', 135, '加工单', '', 'sys:processContract:add', 2, '', 0, NULL, '2022-12-12 09:40:11', NULL, '2022-12-12 09:40:27', 0);
INSERT INTO `sys_menu` VALUES (138, '归档', 135, '加工单', '', 'sys:processContract:hole', 2, '', 0, NULL, '2022-12-12 09:40:56', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (139, '删除', 135, '加工单', '', 'sys:processContract:delete', 2, '', 0, NULL, '2022-12-12 09:41:22', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (140, '付款', 135, '加工单', '', 'sys:processContract:pay', 2, '', 0, NULL, '2022-12-12 09:41:45', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (141, '加工付款单', 0, '顶级菜单', '/processPaymentContract', NULL, 1, 'Document', 10, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (142, '删除', 141, '加工付款单', '', 'sys:processPaymentContract:delete', 2, '', 0, NULL, '2022-12-12 11:55:51', NULL, '2022-12-12 11:56:14', 0);
INSERT INTO `sys_menu` VALUES (143, '新增', 141, '加工付款单', '', 'sys:purchasePaymentContract:add', 2, '', 0, NULL, '2022-12-12 11:56:58', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (144, '查看', 141, '加工付款单', '', 'sys:purchasePaymentContract:view', 2, '', 0, NULL, '2022-12-12 11:57:19', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (145, '加工付款单', 79, '出纳', '/cashier/cashierProcessPayment', '', 1, 'Money', 2, NULL, '2022-12-12 13:16:55', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (146, '查看', 145, '加工付款单', '', 'sys:cashierProcessPayment:view', 2, '', 0, NULL, '2022-12-12 13:20:50', NULL, '2022-12-12 13:23:47', 0);
INSERT INTO `sys_menu` VALUES (147, '上传', 145, '加工付款单', '', 'sys:cashierProcessPayment:upload', 2, '', 0, NULL, '2022-12-12 13:21:56', NULL, '2022-12-12 13:23:27', 0);
INSERT INTO `sys_menu` VALUES (148, '查看', 80, '采购付款单', '', 'sys:cashierPurchasePayment:view', 2, '', 0, NULL, '2022-12-12 13:22:53', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (149, '上传', 80, '采购付款单', '', 'sys:cashierPurchasePayment:upload', 2, '', 0, NULL, '2022-12-12 13:24:28', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (150, '查看', 84, '物流付款单', '', 'sys:cashierLogisticsPayment:view', 2, '', 0, NULL, '2022-12-12 13:25:29', NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (151, '上传', 84, '物流付款单', '', 'sys:cashierLogisticsPayment:upload', 2, '', 0, NULL, '2022-12-12 13:26:05', NULL, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '超级管理员', 'admin', '2019-01-19 11:11:11', 'admin', '2022-11-22 06:01:42', 0);
INSERT INTO `sys_role` VALUES (5, '董事会', '董事会', 'admin', NULL, NULL, '2022-11-22 06:01:55', 0);
INSERT INTO `sys_role` VALUES (6, '出纳', '出纳', NULL, '2022-11-20 08:02:08', NULL, '2022-11-22 06:02:04', 0);
INSERT INTO `sys_role` VALUES (7, '采购员', '采购员', NULL, '2022-11-20 08:02:48', NULL, '2022-11-22 06:02:08', 0);
INSERT INTO `sys_role` VALUES (8, '销售员', '销售员', NULL, '2022-11-20 08:04:10', NULL, '2022-11-22 06:02:11', 0);
INSERT INTO `sys_role` VALUES (9, '财务', '财务', NULL, '2022-11-20 08:05:02', NULL, '2022-11-22 06:02:14', 0);
INSERT INTO `sys_role` VALUES (11, '业务员', '操作采购单、销售单等', NULL, '2022-12-05 11:55:58', NULL, NULL, 0);
INSERT INTO `sys_role` VALUES (13, '物流操作', '', NULL, '2022-12-06 08:59:10', NULL, NULL, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1747 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
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
INSERT INTO `sys_role_menu` VALUES (1305, 11, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1306, 11, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1307, 11, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1308, 11, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1309, 11, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1433, 13, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1434, 13, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1435, 13, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1436, 13, 97, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1437, 13, 119, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1438, 13, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1568, 1, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1569, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1570, 1, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1571, 1, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1572, 1, 3, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1573, 1, 4, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1574, 1, 6, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1575, 1, 7, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1576, 1, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1577, 1, 10, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1578, 1, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1579, 1, 8, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1580, 1, 12, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1581, 1, 16, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1582, 1, 15, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1583, 1, 14, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1584, 1, 13, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1585, 1, 128, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1586, 1, 129, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1587, 1, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1588, 1, 78, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1589, 1, 77, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1590, 1, 76, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1591, 1, 75, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1592, 1, 73, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1593, 1, 135, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1594, 1, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1595, 1, 79, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1596, 1, 80, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1597, 1, 145, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1598, 1, 81, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1599, 1, 84, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1600, 1, 85, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1601, 1, 88, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1602, 1, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1603, 1, 93, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1604, 1, 94, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1605, 1, 95, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1606, 1, 96, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1607, 1, 97, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1608, 1, 98, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1609, 1, 103, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1610, 1, 108, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1611, 1, 109, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1612, 1, 110, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1613, 1, 112, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1614, 1, 113, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1615, 1, 111, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1616, 1, 114, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1617, 1, 115, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1618, 1, 118, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1619, 1, 117, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1620, 1, 116, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1621, 1, 141, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1622, 1, 119, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1623, 1, 122, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1624, 1, 121, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1625, 1, 120, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1626, 1, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1627, 1, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1628, 1, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1629, 1, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1630, 1, 130, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1631, 1, 134, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1632, 1, 133, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1633, 1, 132, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1634, 6, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1635, 6, 79, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1636, 6, 80, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1637, 6, 145, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1638, 6, 81, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1639, 6, 82, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1640, 6, 83, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1641, 6, 84, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1642, 6, 85, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1643, 6, 86, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1644, 6, 87, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1645, 6, 88, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1646, 6, 89, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1647, 6, 90, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1648, 6, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1649, 6, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1650, 6, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1651, 6, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1652, 9, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1653, 9, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1654, 9, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1655, 9, 3, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1656, 9, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1657, 9, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1658, 9, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1659, 9, 73, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1660, 9, 75, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1661, 9, 76, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1662, 9, 77, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1663, 9, 78, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1664, 9, 135, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1665, 9, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1666, 9, 96, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1667, 9, 95, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1668, 9, 94, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1669, 9, 93, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1670, 9, 97, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1671, 9, 98, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1672, 9, 103, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1673, 9, 115, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1674, 9, 141, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1675, 9, 119, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1676, 9, 108, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1677, 9, 109, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1678, 9, 110, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1679, 9, 114, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1680, 9, 80, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1681, 9, 81, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1682, 9, 84, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1683, 9, 85, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1684, 9, 88, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1685, 5, 127, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1686, 5, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1687, 5, 7, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1688, 5, 8, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1689, 5, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1690, 5, 10, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1691, 5, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1692, 5, 12, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1693, 5, 16, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1694, 5, 15, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1695, 5, 14, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1696, 5, 13, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1697, 5, 2, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1698, 5, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1699, 5, 3, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1700, 5, 4, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1701, 5, 6, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1702, 5, 128, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1703, 5, 129, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1704, 5, 130, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1705, 5, 134, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1706, 5, 133, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1707, 5, 132, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1708, 5, 123, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1709, 5, 125, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1710, 5, 124, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1711, 5, 126, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1712, 5, 91, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1713, 5, 17, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1714, 5, 73, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1715, 5, 76, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1716, 5, 78, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1717, 5, 135, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1718, 5, 139, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1719, 5, 138, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1720, 5, 136, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1721, 5, 92, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1722, 5, 95, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1723, 5, 93, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1724, 5, 97, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1725, 5, 98, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1726, 5, 101, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1727, 5, 99, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1728, 5, 103, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1729, 5, 106, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1730, 5, 104, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1731, 5, 115, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1732, 5, 118, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1733, 5, 116, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1734, 5, 141, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1735, 5, 144, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1736, 5, 142, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1737, 5, 119, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1738, 5, 122, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1739, 5, 120, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1740, 5, 108, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1741, 5, 109, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1742, 5, 110, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1743, 5, 112, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1744, 5, 113, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1745, 5, 111, NULL, NULL, NULL, NULL);
INSERT INTO `sys_role_menu` VALUES (1746, 5, 114, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '超管', 21, '18076757556', '452402200004090930', '广西桂林', '2022-11-17', NULL, '25a8f5416ef8a4c72d68e07170010030', '53caae756e414182914a', '在职', 'admin', '2021-08-13 18:11:11', 'admin', '2022-11-19 14:09:42');
INSERT INTO `sys_user` VALUES (3, 'huangjiasen', '黄佳森', 50, '15555555555', '000000000000000000', '广西南宁', '2022-11-19', NULL, '25a8f5416ef8a4c72d68e07170010030', '53caae756e414182914a', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (4, 'xiexiaodong', '谢晓东', 50, '00000000000', '000000000000000000', '广西南宁', '2022-11-12', NULL, '31735eaa63e572eca5be029eb0e57310', 'b22850c877074c2abd0d', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (5, 'linguofeng', '林国丰', 50, '11111111111', '333333333333333333', '广西南宁', '2022-11-09', NULL, 'b1c5b3d735dbe4cdb44cef856ba5c958', 'ec032ec23df44d2ebe87', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (19, 'hanna', '韩娜', 32, '15289675760', '450521198908194829', '广西南宁', '2017-09-01', NULL, 'b1c72a3c3ff998e96266473fc61dbbd9', 'aabefb3c1bfd44f9a25d', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (21, 'qinjianghui', '覃江慧', 34, '18100764437', '452702198808121861', '仙葫盘古路2-8号', NULL, NULL, 'd4ce3f076b1d5dd451041e5aaf5f4bf6', 'bb458927371c4915b3c0', '在职', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (23, 'chuna', '出纳', 1, '1', '1', '1', '2022-12-04', NULL, 'c2beb18b93e611f10e4a3bf77df4a637', '702c94c01d1e4d228ac4', '在职', NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (110, 5, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (111, 1, 1, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (122, 19, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (131, 21, 13, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (132, 21, 11, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (143, 3, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (144, 3, 6, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (145, 3, 7, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (146, 3, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (147, 4, 5, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (148, 4, 9, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user_role` VALUES (149, 23, 6, NULL, NULL, NULL, NULL);

-- ----------------------------
-- View structure for director
-- ----------------------------
DROP VIEW IF EXISTS `director`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `director` AS select `su`.`id` AS `id`,`su`.`nick_name` AS `nick_name` from `sys_user` `su` where `su`.`id` in (select `sur`.`user_id` from (`sys_user_role` `sur` join `sys_role` `sr`) where ((`sr`.`remark` = '董事会') and (`sur`.`role_id` = `sr`.`id`)));

-- ----------------------------
-- View structure for first_company_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `first_company_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `first_company_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘贸易有限责任公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西永湘贸易有限责任公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘贸易有限责任公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘贸易有限责任公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西永湘贸易有限责任公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `ppc`.`payment_time` union select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `process_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西永湘贸易有限责任公司')))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西永湘贸易有限责任公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for fourth_company_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `fourth_company_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `fourth_company_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西众润贸易有限责任公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西众润贸易有限责任公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西众润贸易有限责任公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西众润贸易有限责任公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西众润贸易有限责任公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `ppc`.`payment_time` union select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `process_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西众润贸易有限责任公司')))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西众润贸易有限责任公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for inbound_detail_info
-- ----------------------------
DROP VIEW IF EXISTS `inbound_detail_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `inbound_detail_info` AS select `purchase_contract`.`purchase_contract_no` AS `purchase_contract_no`,`ware`.`factory_name` AS `factory_name`,`io`.`in_out_goods_name` AS `in_out_goods_name`,`io`.`in_out_goods_count` AS `in_out_goods_count`,`io`.`in_out_goods_unit` AS `goods_unit`,`io`.`in_out_goods_unit_price` AS `goods_unit_price` from ((`other_in_out` `io` join `purchase_contract`) join `other_warehouse` `ware`) where ((`io`.`in_out_contract_no` = `purchase_contract`.`purchase_contract_no`) and (`io`.`in_out_type` = 1) and (`ware`.`goods_name` = `io`.`in_out_goods_name`) and (`io`.`other_warehouse_id` = `ware`.`id`));

-- ----------------------------
-- View structure for logistics_payment_contract_info
-- ----------------------------
DROP VIEW IF EXISTS `logistics_payment_contract_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `logistics_payment_contract_info` AS select `lpc`.`id` AS `id`,`lpc`.`logistics_contract_no` AS `logistics_contract_no`,`lpc`.`cashier` AS `cashier`,`lpc`.`payment_count` AS `payment_count`,`lpc`.`payment_time` AS `payment_time`,`lpc`.`payment_photo` AS `payment_photo`,`lpc`.`finance_staff` AS `finance_staff`,`lpc`.`finance_state` AS `finance_state`,`lpc`.`create_time` AS `create_time`,`lpc`.`create_by` AS `create_by`,`lpc`.`last_update_time` AS `last_update_time`,`lpc`.`last_update_by` AS `last_update_by`,`lc`.`sale_contract_no` AS `sale_contract_no`,`lc`.`own_company_name` AS `own_company_name`,`lc`.`freight` AS `freight`,`lc`.`squeeze_season` AS `squeeze_season`,`lc`.`logistics_contract_time` AS `logistics_contract_time`,`lc`.`goods_name` AS `goods_name`,`lc`.`total_weight` AS `total_weight`,`lc`.`goods_unit` AS `goods_unit` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where (`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`);

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
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `outbound_detail_info` AS select `p`.`purchase_contract_no` AS `purchase_contract_no`,`l`.`sale_contract_no` AS `sale_contract_no`,`ld`.`logistics_contract_no` AS `logistics_contract_no`,`l`.`goods_name` AS `goods_name`,`ld`.`goods_factory` AS `goods_factory`,`ld`.`license_plate_number` AS `license_plate_number`,`ld`.`goods_weight` AS `goods_weight`,`ld`.`goods_unit` AS `goods_unit`,`ld`.`outbound_time` AS `outbound_time`,`temp`.`total_weight` AS `total_weight` from (((`purchase_contract` `p` join `logistics_detail` `ld`) join `logistics_contract` `l`) join (select `t`.`purchase_contract_no` AS `purchase_contract_no`,`t`.`sale_contract_no` AS `sale_contract_no`,`t`.`logistics_contract_no` AS `logistics_contract_no`,`t`.`goods_factory` AS `goods_factory`,sum(`t`.`goods_weight`) AS `total_weight` from (select `p`.`purchase_contract_no` AS `purchase_contract_no`,`l`.`sale_contract_no` AS `sale_contract_no`,`ld`.`logistics_contract_no` AS `logistics_contract_no`,`l`.`goods_name` AS `goods_name`,`ld`.`goods_factory` AS `goods_factory`,`ld`.`license_plate_number` AS `license_plate_number`,`ld`.`goods_weight` AS `goods_weight`,`ld`.`goods_unit` AS `goods_unit`,`ld`.`outbound_time` AS `outbound_time` from ((`purchase_contract` `p` join `logistics_detail` `ld`) join `logistics_contract` `l`) where ((`p`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`l`.`logistics_contract_no` = `ld`.`logistics_contract_no`))) `t` group by `t`.`purchase_contract_no`,`t`.`sale_contract_no`,`t`.`logistics_contract_no`,`t`.`goods_factory`) `temp`) where ((`p`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`l`.`logistics_contract_no` = `ld`.`logistics_contract_no`) and (`temp`.`goods_factory` = `ld`.`goods_factory`) and (`temp`.`purchase_contract_no` = `ld`.`purchase_contract_no`) and (`temp`.`sale_contract_no` = `l`.`sale_contract_no`) and (`temp`.`logistics_contract_no` = `l`.`logistics_contract_no`));

-- ----------------------------
-- View structure for process_payment_contract_info
-- ----------------------------
DROP VIEW IF EXISTS `process_payment_contract_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `process_payment_contract_info` AS select `pc`.`goods_name` AS `goods_name`,`pc`.`customer_enterprise_name` AS `customer_enterprise_name`,`pc`.`own_company_name` AS `own_company_name`,`ppc`.`id` AS `id`,`ppc`.`process_contract_no` AS `process_contract_no`,`ppc`.`payment_month` AS `payment_month`,`ppc`.`payment_month_price_g` AS `payment_month_price_g`,`ppc`.`payment_month_price_t` AS `payment_month_price_t`,`ppc`.`goods_count` AS `goods_count`,`ppc`.`goods_unit` AS `goods_unit`,`ppc`.`cashier` AS `cashier`,`ppc`.`payment_count` AS `payment_count`,`ppc`.`payment_time` AS `payment_time`,`ppc`.`payment_photo` AS `payment_photo`,`ppc`.`finance_staff` AS `finance_staff`,`ppc`.`finance_state` AS `finance_state`,`ppc`.`create_time` AS `create_time`,`ppc`.`create_by` AS `create_by`,`ppc`.`last_update_time` AS `last_update_time`,`ppc`.`last_update_by` AS `last_update_by` from (`process_contract` `pc` join `process_payment_contract` `ppc`) where (`pc`.`process_contract_no` = `ppc`.`process_contract_no`);

-- ----------------------------
-- View structure for process_payment_state_info
-- ----------------------------
DROP VIEW IF EXISTS `process_payment_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `process_payment_state_info` AS select `pds`.`id` AS `id`,`pds`.`process_payment_contract_id` AS `process_payment_contract_id`,`pds`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`pds`.`state` AS `state` from (`director` `d` join `process_director_state` `pds`) where (`d`.`id` = `pds`.`user_id`);

-- ----------------------------
-- View structure for purchase_payment_contract_info
-- ----------------------------
DROP VIEW IF EXISTS `purchase_payment_contract_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `purchase_payment_contract_info` AS select `ppc`.`id` AS `id`,`ppc`.`purchase_contract_no` AS `purchase_contract_no`,`ppc`.`payment_count` AS `payment_count`,`ppc`.`payment_time` AS `payment_time`,`ppc`.`payment_photo` AS `payment_photo`,`ppc`.`finance_staff` AS `finance_staff`,`ppc`.`finance_state` AS `finance_state`,`ppc`.`cashier` AS `cashier`,`ppc`.`create_time` AS `create_time`,`ppc`.`create_by` AS `create_by`,`ppc`.`last_update_time` AS `last_update_time`,`ppc`.`last_update_by` AS `last_update_by`,`pc`.`customer_enterprise_name` AS `customer_enterprise_name`,`pc`.`own_company_name` AS `own_company_name`,`pc`.`squeeze_season` AS `squeeze_season`,`pc`.`inbound_time` AS `inbound_time`,`pc`.`goods_name` AS `goods_name`,`pc`.`goods_count` AS `goods_count`,`pc`.`goods_unit` AS `goods_unit`,`pc`.`payment_amount` AS `payment_amount` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where (`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`);

-- ----------------------------
-- View structure for purchase_payment_state_info
-- ----------------------------
DROP VIEW IF EXISTS `purchase_payment_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `purchase_payment_state_info` AS select `pds`.`id` AS `id`,`pds`.`purchase_payment_contract_id` AS `purchase_payment_contract_id`,`pds`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`pds`.`state` AS `state` from (`director` `d` join `purchase_director_state` `pds`) where (`d`.`id` = `pds`.`user_id`);

-- ----------------------------
-- View structure for second_company_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `second_company_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `second_company_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西永湘物流有限公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西永湘物流有限公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘物流有限公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西永湘物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西永湘物流有限公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西永湘物流有限公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `process_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西永湘物流有限公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西永湘物流有限公司')))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西永湘物流有限公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for shipping_state_info
-- ----------------------------
DROP VIEW IF EXISTS `shipping_state_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `shipping_state_info` AS select `pds`.`id` AS `id`,`pds`.`shipping_contract_no` AS `shipping_contract_no`,`pds`.`user_id` AS `user_id`,`d`.`nick_name` AS `nick_name`,`pds`.`state` AS `state` from (`director` `d` join `shipping_director_state` `pds`) where (`d`.`id` = `pds`.`user_id`);

-- ----------------------------
-- View structure for spend_detail_info
-- ----------------------------
DROP VIEW IF EXISTS `spend_detail_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `spend_detail_info` AS select `temp`.`id` AS `id`,`temp`.`type` AS `type`,`temp`.`own_company_name` AS `own_company_name`,`temp`.`relation_contract_no` AS `relation_contract_no`,`temp`.`payment_count` AS `payment_count`,`temp`.`payment_time` AS `payment_time`,`temp`.`payment_photo` AS `payment_photo` from (select `ppc`.`id` AS `id`,'采购付款单' AS `type`,`t`.`own_company_name` AS `own_company_name`,`ppc`.`purchase_contract_no` AS `relation_contract_no`,`ppc`.`payment_count` AS `payment_count`,`ppc`.`payment_time` AS `payment_time`,`ppc`.`payment_photo` AS `payment_photo` from (`purchase_payment_contract` `ppc` join (select `ppc`.`id` AS `id`,`pc`.`own_company_name` AS `own_company_name` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where (`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`)) `t`) where ((`ppc`.`payment_time` is not null) and (`ppc`.`id` = `t`.`id`)) union select `ppc`.`id` AS `id`,'加工付款单' AS `type`,`t`.`own_company_name` AS `own_company_name`,`ppc`.`process_contract_no` AS `relation_contract_no`,`ppc`.`payment_count` AS `payment_count`,`ppc`.`payment_time` AS `payment_time`,`ppc`.`payment_photo` AS `payment_photo` from (`process_payment_contract` `ppc` join (select `ppc`.`id` AS `id`,`pc`.`own_company_name` AS `own_company_name` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where (`ppc`.`process_contract_no` = `pc`.`process_contract_no`)) `t`) where ((`ppc`.`payment_time` is not null) and (`ppc`.`id` = `t`.`id`)) union select `lpc`.`id` AS `id`,'物流付款单' AS `type`,`t`.`own_company_name` AS `own_company_name`,`lpc`.`logistics_contract_no` AS `relation_contract_no`,`lpc`.`payment_count` AS `payment_count`,`lpc`.`payment_time` AS `payment_time`,`lpc`.`payment_photo` AS `payment_photo` from (`logistics_payment_contract` `lpc` join (select `lpc`.`id` AS `id`,`lc`.`own_company_name` AS `own_company_name` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where (`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`)) `t`) where ((`lpc`.`payment_time` is not null) and (`lpc`.`id` = `t`.`id`)) union select `sc`.`id` AS `id`,'海运单' AS `type`,`sc`.`own_company_name` AS `own_company_name`,`sc`.`shipping_contract_no` AS `relation_contract_no`,`sc`.`payment_count` AS `payment_count`,`sc`.`payment_time` AS `payment_time`,`sc`.`payment_photo` AS `payment_photo` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null)) `temp` order by `temp`.`payment_time`;

-- ----------------------------
-- View structure for third_company_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `third_company_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `third_company_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司')) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where ((`sc`.`revenue_time` is not null) and (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司')) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select `ppc`.`payment_time` AS `payment_time` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select `lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `lpc`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `purchase_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`purchase_payment_contract` `ppc` join `purchase_contract` `pc`) where ((`ppc`.`purchase_contract_no` = `pc`.`purchase_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select sum(`ppc`.`payment_count`) AS `out_amount`,`ppc`.`payment_time` AS `payment_time` from `process_payment_contract` `ppc` where ((`ppc`.`payment_time` is not null) and `ppc`.`id` in (select `ppc`.`id` from (`process_payment_contract` `ppc` join `process_contract` `pc`) where ((`ppc`.`process_contract_no` = `pc`.`process_contract_no`) and (`pc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `ppc`.`payment_time` union select sum(`lpc`.`payment_count`) AS `out_amount`,`lpc`.`payment_time` AS `payment_time` from `logistics_payment_contract` `lpc` where ((`lpc`.`payment_time` is not null) and `lpc`.`id` in (select `lpc`.`id` from (`logistics_payment_contract` `lpc` join `logistics_contract` `lc`) where ((`lpc`.`logistics_contract_no` = `lc`.`logistics_contract_no`) and (`lc`.`own_company_name` = '广西丰沣顺国际物流有限公司')))) group by `lpc`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where ((`sc`.`payment_time` is not null) and `sc`.`id` in (select `sc`.`id` from `shipping_contract` `sc` where (`sc`.`own_company_name` = '广西丰沣顺国际物流有限公司'))) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

-- ----------------------------
-- View structure for total_income_spend_info
-- ----------------------------
DROP VIEW IF EXISTS `total_income_spend_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `total_income_spend_info` AS select `f`.`date` AS `i_date`,`f`.`income` AS `income`,`s`.`spend` AS `spend` from ((select `temp`.`date` AS `date`,`temp`.`income` AS `income` from (select `d`.`date` AS `date`,`o`.`income` AS `income`,`o`.`revenue_time` AS `revenue_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where (`sc`.`revenue_time` is not null) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `purchase_payment_contract`.`payment_time` AS `payment_time` from `purchase_payment_contract` where (`purchase_payment_contract`.`payment_time` is not null) group by `purchase_payment_contract`.`payment_time` union select `process_payment_contract`.`payment_time` AS `payment_time` from `process_payment_contract` where (`process_payment_contract`.`payment_time` is not null) group by `process_payment_contract`.`payment_time` union select `logistics_payment_contract`.`payment_time` AS `payment_time` from `logistics_payment_contract` where (`logistics_payment_contract`.`payment_time` is not null) group by `logistics_payment_contract`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`sc`.`revenue_amount`) AS `income`,`sc`.`revenue_time` AS `revenue_time` from `sale_contract` `sc` where (`sc`.`revenue_time` is not null) group by `sc`.`revenue_time`) `o` on((`d`.`date` = `o`.`revenue_time`)))) `temp` order by `temp`.`date` desc) `f` join (select `temp`.`date` AS `date`,`temp`.`spend` AS `spend` from (select `d`.`date` AS `date`,`o`.`spend` AS `spend`,`o`.`payment_time` AS `payment_time` from ((select `sc`.`revenue_time` AS `date` from `sale_contract` `sc` where (`sc`.`revenue_time` is not null) group by `sc`.`revenue_time` union select `temp`.`payment_time` AS `payment_time` from (select `purchase_payment_contract`.`payment_time` AS `payment_time` from `purchase_payment_contract` where (`purchase_payment_contract`.`payment_time` is not null) group by `purchase_payment_contract`.`payment_time` union select `process_payment_contract`.`payment_time` AS `payment_time` from `process_payment_contract` where (`process_payment_contract`.`payment_time` is not null) group by `process_payment_contract`.`payment_time` union select `logistics_payment_contract`.`payment_time` AS `payment_time` from `logistics_payment_contract` where (`logistics_payment_contract`.`payment_time` is not null) group by `logistics_payment_contract`.`payment_time` union select `sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `d` left join (select sum(`temp`.`out_amount`) AS `spend`,`temp`.`payment_time` AS `payment_time` from (select sum(`purchase_payment_contract`.`payment_count`) AS `out_amount`,`purchase_payment_contract`.`payment_time` AS `payment_time` from `purchase_payment_contract` where (`purchase_payment_contract`.`payment_time` is not null) group by `purchase_payment_contract`.`payment_time` union select sum(`process_payment_contract`.`payment_count`) AS `out_amount`,`process_payment_contract`.`payment_time` AS `payment_time` from `process_payment_contract` where (`process_payment_contract`.`payment_time` is not null) group by `process_payment_contract`.`payment_time` union select sum(`logistics_payment_contract`.`payment_count`) AS `out_amount`,`logistics_payment_contract`.`payment_time` AS `payment_time` from `logistics_payment_contract` where (`logistics_payment_contract`.`payment_time` is not null) group by `logistics_payment_contract`.`payment_time` union select sum(`sc`.`expenses`) AS `out_amount`,`sc`.`payment_time` AS `payment_time` from `shipping_contract` `sc` where (`sc`.`payment_time` is not null) group by `sc`.`payment_time`) `temp` group by `temp`.`payment_time`) `o` on((`d`.`date` = `o`.`payment_time`)))) `temp` order by `temp`.`date` desc) `s`) where (`f`.`date` = `s`.`date`) order by `f`.`date` desc;

SET FOREIGN_KEY_CHECKS = 1;
