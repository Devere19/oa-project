package cn.edu.guet.bean.ImportModel;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;


/**
 * @author 陶祎祎
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImportPurchaseContractModel {

    /**
     * 采购合同编号
     */
    @ExcelProperty(value = "采购合同编号")
    private String purchaseContractNo;

    /**
     * 供货方公司名称
     */
    @ExcelProperty(value = "供货方公司名称")
    private String customerEnterpriseName;

    /**
     * 己方公司名
     */
    @ExcelProperty(value = "己方公司名")
    private String ownCompanyName;

    /**
     * 榨季
     */
    @ExcelProperty(value = "榨季")
    private String squeezeSeason;

    /**
     * 入库时间（合同实际签订时间）
     */
    @ExcelProperty(value = "入库时间（格式为xxxx-xx-xx）")
    private Date inboundTime;

    /**
     * 采购货物名称
     */
    @ExcelProperty(value = "采购货物名称")
    private String goodsName;

    /**
     * 采购货物数量
     */
    @ExcelProperty(value = "采购货物数量")
    private BigDecimal goodsCount;

    /**
     * 采购货物单位
     */
    @ExcelProperty(value = "采购货物单位")
    private String goodsUnit;

    /**
     * 采购总金额
     */
    @ExcelProperty(value = "采购总金额")
    private BigDecimal paymentAmount;

//    /**
//     * 已付款金额
//     */
//    @ExcelProperty(value = "已付款金额")
//    private BigDecimal paymentCount;
//
//    /**
//     * 付款时间
//     */
//    @ExcelProperty(value = "付款时间")
//    private Date paymentTime;
//
//    /**
//     * 出纳名称
//     */
//    @ExcelProperty(value = "出纳名称")
//    private String cashier;
//
//    /**
//     * 财务名称
//     */
//    @ExcelProperty(value = "财务名称")
//    private String financeStaff;
//
//    /**
//     * 董事会1
//     */
//    @ExcelProperty(value = "董事会1")
//    private String director1;
//
//    /**
//     * 董事会2
//     */
//    @ExcelProperty(value = "董事会2")
//    private String director2;
//
//    /**
//     * 董事会3
//     */
//    @ExcelProperty(value = "董事会3")
//    private String director3;

    /**
     * 入库厂名1
     */
    @ExcelProperty(value = "入库厂名1")
    private String factoryName1;

    /**
     * 入库数量1
     */
    @ExcelProperty(value = "入库数量1")
    private BigDecimal inboundGoodsCount1;

    /**
     * 采购货物单价1
     */
    @ExcelProperty(value = "采购货物单价1")
    private BigDecimal inOutGoodsUnitPrice1;

    /**
     * 入库厂名2
     */
    @ExcelProperty(value = "入库厂名2")
    private String factoryName2;

    /**
     * 入库数量2
     */
    @ExcelProperty(value = "入库数量2")
    private BigDecimal inboundGoodsCount2;

    /**
     * 采购货物单价2
     */
    @ExcelProperty(value = "采购货物单价2")
    private BigDecimal inOutGoodsUnitPrice2;

    /**
     * 入库厂名3
     */
    @ExcelProperty(value = "入库厂名3")
    private String factoryName3;

    /**
     * 入库数量3
     */
    @ExcelProperty(value = "入库数量3")
    private BigDecimal inboundGoodsCount3;

    /**
     * 采购货物单价3
     */
    @ExcelProperty(value = "采购货物单价3")
    private BigDecimal inOutGoodsUnitPrice3;

    /**
     * 入库厂名4
     */
    @ExcelProperty(value = "入库厂名4")
    private String factoryName4;

    /**
     * 入库数量4
     */
    @ExcelProperty(value = "入库数量4")
    private BigDecimal inboundGoodsCount4;

    /**
     * 采购货物单价4
     */
    @ExcelProperty(value = "采购货物单价4")
    private BigDecimal inOutGoodsUnitPrice4;

    /**
     * 入库厂名5
     */
    @ExcelProperty(value = "入库厂名5")
    private String factoryName5;

    /**
     * 入库数量5
     */
    @ExcelProperty(value = "入库数量5")
    private BigDecimal inboundGoodsCount5;

    /**
     * 采购货物单价5
     */
    @ExcelProperty(value = "采购货物单价5")
    private BigDecimal inOutGoodsUnitPrice5;

    /**
     * 入库厂名6
     */
    @ExcelProperty(value = "入库厂名6")
    private String factoryName6;

    /**
     * 入库数量6
     */
    @ExcelProperty(value = "入库数量6")
    private BigDecimal inboundGoodsCount6;

    /**
     * 采购货物单价6
     */
    @ExcelProperty(value = "采购货物单价6")
    private BigDecimal inOutGoodsUnitPrice6;

    /**
     * 入库厂名7
     */
    @ExcelProperty(value = "入库厂名7")
    private String factoryName7;

    /**
     * 入库数量7
     */
    @ExcelProperty(value = "入库数量7")
    private BigDecimal inboundGoodsCount7;

    /**
     * 采购货物单价7
     */
    @ExcelProperty(value = "采购货物单价7")
    private BigDecimal inOutGoodsUnitPrice7;

    /**
     * 入库厂名8
     */
    @ExcelProperty(value = "入库厂名8")
    private String factoryName8;

    /**
     * 入库数量8
     */
    @ExcelProperty(value = "入库数量8")
    private BigDecimal inboundGoodsCount8;

    /**
     * 采购货物单价8
     */
    @ExcelProperty(value = "采购货物单价8")
    private BigDecimal inOutGoodsUnitPrice8;

    /**
     * 入库厂名9
     */
    @ExcelProperty(value = "入库厂名9")
    private String factoryName9;

    /**
     * 入库数量9
     */
    @ExcelProperty(value = "入库数量9")
    private BigDecimal inboundGoodsCount9;

    /**
     * 采购货物单价9
     */
    @ExcelProperty(value = "采购货物单价9")
    private BigDecimal inOutGoodsUnitPrice9;

    /**
     * 入库厂名10
     */
    @ExcelProperty(value = "入库厂名10")
    private String factoryName10;

    /**
     * 入库数量10
     */
    @ExcelProperty(value = "入库数量10")
    private BigDecimal inboundGoodsCount10;

    /**
     * 采购货物单价10
     */
    @ExcelProperty(value = "采购货物单价10")
    private BigDecimal inOutGoodsUnitPrice10;

    /**
     * 入库厂名11
     */
    @ExcelProperty(value = "入库厂名11")
    private String factoryName11;

    /**
     * 入库数量11
     */
    @ExcelProperty(value = "入库数量11")
    private BigDecimal inboundGoodsCount11;

    /**
     * 采购货物单价11
     */
    @ExcelProperty(value = "采购货物单价11")
    private BigDecimal inOutGoodsUnitPrice11;

    /**
     * 入库厂名12
     */
    @ExcelProperty(value = "入库厂名12")
    private String factoryName12;

    /**
     * 入库数量12
     */
    @ExcelProperty(value = "入库数量12")
    private BigDecimal inboundGoodsCount12;

    /**
     * 采购货物单价12
     */
    @ExcelProperty(value = "采购货物单价12")
    private BigDecimal inOutGoodsUnitPrice12;

    /**
     * 入库厂名13
     */
    @ExcelProperty(value = "入库厂名13")
    private String factoryName13;

    /**
     * 入库数量13
     */
    @ExcelProperty(value = "入库数量13")
    private BigDecimal inboundGoodsCount13;

    /**
     * 采购货物单价13
     */
    @ExcelProperty(value = "采购货物单价13")
    private BigDecimal inOutGoodsUnitPrice13;

    /**
     * 入库厂名14
     */
    @ExcelProperty(value = "入库厂名14")
    private String factoryName14;

    /**
     * 入库数量14
     */
    @ExcelProperty(value = "入库数量14")
    private BigDecimal inboundGoodsCount14;

    /**
     * 采购货物单价14
     */
    @ExcelProperty(value = "采购货物单价14")
    private BigDecimal inOutGoodsUnitPrice14;

    /**
     * 入库厂名15
     */
    @ExcelProperty(value = "入库厂名15")
    private String factoryName15;

    /**
     * 入库数量15
     */
    @ExcelProperty(value = "入库数量15")
    private BigDecimal inboundGoodsCount15;

    /**
     * 采购货物单价15
     */
    @ExcelProperty(value = "采购货物单价15")
    private BigDecimal inOutGoodsUnitPrice15;

    /**
     * 入库厂名16
     */
    @ExcelProperty(value = "入库厂名16")
    private String factoryName16;

    /**
     * 入库数量16
     */
    @ExcelProperty(value = "入库数量16")
    private BigDecimal inboundGoodsCount16;

    /**
     * 采购货物单价16
     */
    @ExcelProperty(value = "采购货物单价16")
    private BigDecimal inOutGoodsUnitPrice16;

    /**
     * 入库厂名17
     */
    @ExcelProperty(value = "入库厂名17")
    private String factoryName17;

    /**
     * 入库数量17
     */
    @ExcelProperty(value = "入库数量17")
    private BigDecimal inboundGoodsCount17;

    /**
     * 采购货物单价17
     */
    @ExcelProperty(value = "采购货物单价17")
    private BigDecimal inOutGoodsUnitPrice17;

    /**
     * 入库厂名18
     */
    @ExcelProperty(value = "入库厂名18")
    private String factoryName18;

    /**
     * 入库数量18
     */
    @ExcelProperty(value = "入库数量18")
    private BigDecimal inboundGoodsCount18;

    /**
     * 采购货物单价18
     */
    @ExcelProperty(value = "采购货物单价18")
    private BigDecimal inOutGoodsUnitPrice18;

    /**
     * 入库厂名19
     */
    @ExcelProperty(value = "入库厂名19")
    private String factoryName19;

    /**
     * 入库数量19
     */
    @ExcelProperty(value = "入库数量19")
    private BigDecimal inboundGoodsCount19;

    /**
     * 采购货物单价19
     */
    @ExcelProperty(value = "采购货物单价19")
    private BigDecimal inOutGoodsUnitPrice19;

    /**
     * 入库厂名20
     */
    @ExcelProperty(value = "入库厂名20")
    private String factoryName20;

    /**
     * 入库数量20
     */
    @ExcelProperty(value = "入库数量20")
    private BigDecimal inboundGoodsCount20;

    /**
     * 采购货物单价20
     */
    @ExcelProperty(value = "采购货物单价20")
    private BigDecimal inOutGoodsUnitPrice20;
}
