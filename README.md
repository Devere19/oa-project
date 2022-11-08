# 永湘OA系统

## 后端管理界面

先把菜单栏那一块的数据写死

使用银玉世家的系统管理模块的代码和权限管理，前期先写死，把所有的功能菜单露出来，写完之后再用后端查出来的菜单代替写死的。
## 数据库表

#### 采购单（purchase_contract）

```sql
CREATE TABLE `purchase_contract` (
    `id` int NOT NULL AUTO_INCREMENT,
    `purchase_contract_no` varchar(255) NOT NULL COMMENT '采购合同编号',
    `supplier_no` int DEFAULT NULL COMMENT '供货商ID（客户表ID）',
    `own_company_name` varchar(255) DEFAULT NULL COMMENT '己方公司名',
    `squeeze_season` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '榨季',
    `inbound_time` date DEFAULT NULL COMMENT '入库时间（合同实际签订时间）',
    `goods_name` varchar(255) DEFAULT NULL COMMENT '采购货物名称',
    `goods_count` decimal(18,2) DEFAULT NULL COMMENT '采购货物数量',
    `goods_unit` varchar(255) DEFAULT NULL COMMENT '采购货物单位',
    `goods_unit_price` decimal(18,2) DEFAULT NULL COMMENT '采购货物单价',
    `payment_amount` decimal(18,2) DEFAULT NULL COMMENT '采购总金额',
    `contract_photo` text COMMENT '采购合同照片',
    `pigeonhole` int DEFAULT '1' COMMENT '归档 0表示隐藏  1表示显示',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
    `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
    `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
    PRIMARY KEY (`id`),
    UNIQUE KEY `purchase_unique` (`purchase_contract_no`) USING BTREE COMMENT '保证采购合同编号唯一'
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 采购付款单（purchase_payment_contract）

```sql
CREATE TABLE `purchase_payment_contract` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '采购付款单ID',
  `purchase_contract_no` varchar(255) DEFAULT NULL COMMENT '销售单合同编号',
  `payment_count` decimal(18,2) DEFAULT NULL COMMENT '本次付款金额',
  `payment_time` date DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text COMMENT '付款流水截图',
  `finance_staff` varchar(255) DEFAULT NULL COMMENT '财务名称',
  `finance_state` int DEFAULT NULL COMMENT '财务审核状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 采购付款单董事状态表（purchase_director_state）

```sql
CREATE TABLE `purchase_director_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_payment_contract_id` int DEFAULT NULL COMMENT '采购付款单ID',
  `userId` int DEFAULT NULL COMMENT '董事会用户ID',
  `state` int DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 销售单（sale_contract）

```sql
CREATE TABLE `sale_contract` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sale_contract_no` varchar(255) NOT NULL COMMENT '销售单合同编号',
  `sale_customer_id` int DEFAULT NULL COMMENT '客户表id',
  `own_company_name` varchar(255) DEFAULT NULL COMMENT '己方公司名',
  `goods_name` varchar(255) DEFAULT NULL COMMENT '销售货物名称',
  `goods_count` decimal(18,2) DEFAULT NULL COMMENT '销售货物数量',
  `goods_unit` varchar(255) DEFAULT NULL COMMENT '销售货物单位',
  `goods_unit_price` decimal(18,2) DEFAULT NULL COMMENT '销售货物单价',
  `goods_total_price` decimal(18,2) DEFAULT NULL COMMENT '销售合同总价钱',
  `sale_contract_time` datetime DEFAULT NULL COMMENT '销售合同时间',
  `payment_method` varchar(255) DEFAULT NULL COMMENT '结款方式',
  `transport_method` varchar(255) DEFAULT NULL COMMENT '运输方式',
  `contract_photo` text COMMENT '销售合同照片',
  `revenue_amount` decimal(18,2) DEFAULT NULL COMMENT '收款金额',
  `revenue_time` datetime DEFAULT NULL COMMENT '收款时间',
  `revenue_photo` varchar(255) DEFAULT NULL COMMENT '收款流水截图',
  `revenue_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '出纳操作人姓名',
  `pigeonhole` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT '归档  0表示隐藏  1表示显示',
  `squeeze_season` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '榨季  ',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_unique` (`sale_contract_no`) USING BTREE COMMENT '保证销售合同编号唯一'
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 物流单（logistics_contract）

```sql
CREATE TABLE `logistics_contract` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logistics_contract_no` varchar(255) NOT NULL COMMENT '物流单合同编号（运输合同编号）',
  `sale_contract_no` varchar(255) DEFAULT NULL COMMENT '销售单合同编号',
  `total_weight` decimal(10,2) DEFAULT NULL COMMENT '物流合同总重量',
  `goods_unit` varchar(255) DEFAULT NULL COMMENT '货物单位',
  `freight` decimal(18,2) DEFAULT NULL COMMENT '运费',
  `contract_photo` text COMMENT '物流合同照片',
  `logistic_contract_time` datetime DEFAULT NULL COMMENT '物流单合同签订时间',
  `squeeze_season` varchar(255) DEFAULT NULL COMMENT '榨季',
  `pigeonhole` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT '归档  1显示  0隐藏',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `logistics_unique` (`logistics_contract_no`) USING BTREE COMMENT '保证物流合同编号唯一'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 物流详情单（logistics_detail）

```sql
CREATE TABLE `logistics_detail` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键id  自增',
  `logistics_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '物流单合同编号（运输合同编号）',
  `purchase_contract_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '采购合同编号',
  `goods_factory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取货厂名',
  `outbound_time` datetime DEFAULT NULL COMMENT '出库日期',
  `license_plate_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '车牌号',
  `goods_weight` decimal(18,2) DEFAULT NULL COMMENT '载货量',
  `goods_unit` varchar(255) DEFAULT NULL COMMENT '货物单位',
  `unloading_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '卸货地点',
  `unit_price` decimal(10,2) DEFAULT NULL COMMENT '运输单价',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
```

#### 自家仓库库存表（own_warehouse）

```sql
CREATE TABLE `own_warehouse` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自家仓库ID',
  `factory_name` varchar(255) DEFAULT NULL COMMENT '厂名',
  `goods_name` varchar(255) DEFAULT NULL COMMENT '存储货物名称',
  `goods_count` decimal(18,2) DEFAULT NULL COMMENT '存储货物库存量',
  `goods_unit` varchar(255) DEFAULT NULL COMMENT '存储货物单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 外商仓库库存表（other_warehouse）

```sql
CREATE TABLE `other_warehouse` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '外商仓库ID',
  `factory_name` varchar(255) DEFAULT NULL COMMENT '厂名',
  `goods_name` varchar(255) DEFAULT NULL COMMENT '存储货物名称',
  `goods_count` decimal(18,2) DEFAULT NULL COMMENT '存储货物库存量',
  `goods_unit` varchar(255) DEFAULT NULL COMMENT '存储货物单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 自家仓库出入库表（own_in_out）

```sql
CREATE TABLE `own_in_out` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自家仓库出入库流水ID',
  `in_out_type` int DEFAULT NULL COMMENT '出入库类型（出库0，入库1）',
  `in_out_contract_no` varchar(255) DEFAULT NULL COMMENT '采购合同编号/销售合同编号',
  `in_out_goods_name` varchar(255) DEFAULT NULL COMMENT '出入库货物名称',
  `in_out_goods_count` decimal(18,2) DEFAULT NULL COMMENT '出入库货物数量',
  `in_out_goods_unit` varchar(255) DEFAULT NULL COMMENT '出入库货物单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 外商仓库出入库表（other_in_out）

```sql
CREATE TABLE `other_in_out` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '外商仓库出入库流水ID',
  `other_warehouse_id` int DEFAULT NULL COMMENT '外商仓库ID',
  `in_out_type` int DEFAULT NULL COMMENT '出入库类型（出库0，入库1）',
  `in_out_contract_no` varchar(255) DEFAULT NULL COMMENT '采购合同编号/销售合同编号',
  `in_out_goods_name` varchar(255) DEFAULT NULL COMMENT '出入库货物名称',
  `in_out_goods_count` decimal(18,2) DEFAULT NULL COMMENT '出入库货物数量',
  `in_out_goods_unit` varchar(255) DEFAULT NULL COMMENT '出入库货物单位',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 海运单（shipping_contract）

```sql
CREATE TABLE `shipping_contract` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipping_contract_no` varchar(255) NOT NULL COMMENT '海运单合同编号',
  `logtistics_contract_no` varchar(255) DEFAULT NULL COMMENT '物流单合同编号',
  `principal` varchar(255) DEFAULT NULL COMMENT '委托方',
  `packing_time` datetime DEFAULT NULL COMMENT '装箱日期',
  `packing_location` varchar(255) DEFAULT NULL COMMENT '装箱地点',
  `unpacking_factory` varchar(255) DEFAULT NULL COMMENT '卸箱工厂',
  `container_no` varchar(255) DEFAULT NULL COMMENT '集装箱号',
  `seal_no` varchar(255) DEFAULT NULL COMMENT '铅封号',
  `tally_clerk` varchar(255) DEFAULT NULL COMMENT '理货员',
  `tally_clerk_price` decimal(18,2) DEFAULT NULL COMMENT '理货费用',
  `departure_fleet` varchar(255) DEFAULT NULL COMMENT '起运承运车队',
  `departure_price` decimal(18,2) DEFAULT NULL COMMENT '起运承运车队费用',
  `carrier_company_name` varchar(255) DEFAULT NULL COMMENT '承运船公司',
  `carrier_company_price` decimal(18,2) DEFAULT NULL COMMENT '承运船公司费用',
  `destination_port_fleet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '目的港承运车队',
  `destination_port_price` decimal(18,2) DEFAULT NULL COMMENT '目的港承运车队费用',
  `expenses` decimal(18,2) DEFAULT NULL COMMENT '总费用',
  `contract_photo` text COMMENT '合同照片',
  `finance_staff` varchar(255) DEFAULT NULL COMMENT '财务名称',
  `finance_state` int DEFAULT NULL COMMENT '财务审核状态',
  `payment_count` decimal(18,2) DEFAULT NULL COMMENT '付款金额',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `payment_photo` text COMMENT '付款流水截图',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shipping_unique` (`shipping_contract_no`) USING BTREE COMMENT '保证海运合同编号唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 海运单董事状态表（shipping_director_state）

```sql
CREATE TABLE `shipping_director_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `shipping_contract_no` int DEFAULT NULL COMMENT '海运单合同编号',
  `userId` int DEFAULT NULL COMMENT '董事会用户ID',
  `state` int DEFAULT NULL COMMENT '董事会审核状态',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

#### 客户表（customer）

```sql
CREATE TABLE `customer` (
  `id` int NOT NULL COMMENT '客户表主键',
  `customer_enterprise_name` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `customer_name` varchar(255) DEFAULT NULL COMMENT '联系人',
  `customer_phone` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `customer_address` varchar(255) DEFAULT NULL COMMENT '邮寄地址',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者名称',
  `last_update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最新更新时间',
  `last_update_by` varchar(255) DEFAULT NULL COMMENT '最新更新者名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

## 菜单栏

+ 
