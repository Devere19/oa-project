package cn.edu.guet.bean.ImportModel;

import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/29 20:55
 * @Version 1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImportLogisticsContractModel {


    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "运输合同编号")
    private String logisticsContractNo;

    /**
     * 销售单合同编号
     */
    @ExcelProperty(value = "销售单合同编号")
    private String saleContractNo;
    /**
     * 销售单合同总重量
     */
    @ExcelProperty(value = "销售单合同总重量")
    private BigDecimal totalWeight;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位")
    private String goodsUnit;

    /**
     * 运费
     */
    @ExcelProperty(value = "运费")
    private BigDecimal freight;

    /**
     * 物流单合同签订时间
     */
    @ExcelProperty(value = "物流单合同签订时间")
    private Date logisticsContractTime;

    /**
     * 榨季
     */
    @ExcelProperty(value = "榨季")
    private String squeezeSeason;


    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    private Date createTime;


    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）1")
    private String logisticsContractNo1;

    /**
     * 采购合同编号
     */
    @ExcelProperty(value = "采购合同编号1")
    private String purchaseContractNo1;

    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名1")
    private String goodsFactory1;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期1")
    private Date outboundTime1;

    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号1")
    private String licensePlateNumber1;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量1")
    private BigDecimal goodsWeight1;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位1")
    private String goodsUnit1;

    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点1")
    private String unloadingLocation1;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价1")
    private BigDecimal unitPrice1;

    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号2（运输合同编号）2")
    private String logisticsContractNo2;

    /**
     * 采购合同编号
     */
    @ExcelProperty(value = "采购合同编号2")
    private String purchaseContractNo2;

    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名2")
    private String goodsFactory2;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期2")
    private Date outboundTime2;

    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号2")
    private String licensePlateNumber2;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量2")
    private BigDecimal goodsWeight2;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位2")
    private String goodsUnit2;

    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点2")
    private String unloadingLocation2;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价2")
    private BigDecimal unitPrice2;

    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）3")
    private String logisticsContractNo3;

    /**
     * 采购合同编号
     */
    @ExcelProperty(value = "采购合同编号3")
    private String purchaseContractNo3;

    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名3")
    private String goodsFactory3;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期3")
    private Date outboundTime3;

    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号3")
    private String licensePlateNumber3;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量3")
    private BigDecimal goodsWeight3;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位3")
    private String goodsUnit3;

    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点3")
    private String unloadingLocation3;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价3")
    private BigDecimal unitPrice3;

    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）4")
    private String logisticsContractNo4;

    /**
     * 采购合同编号
     */
    @ExcelProperty(value = "采购合同编号4")
    private String purchaseContractNo4;

    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名4")
    private String goodsFactory4;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期4")
    private Date outboundTime4;

    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号4")
    private String licensePlateNumber4;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量4")
    private BigDecimal goodsWeight4;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位4")
    private String goodsUnit4;

    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点4")
    private String unloadingLocation4;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价4")
    private BigDecimal unitPrice4;

    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）5")
    private String logisticsContractNo5;

    /**
     * 采购合同编号
     */
    @ExcelProperty(value = "采购合同编号5")
    private String purchaseContractNo5;

    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名5")
    private String goodsFactory5;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期5")
    private Date outboundTime5;

    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号5")
    private String licensePlateNumber5;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量5")
    private BigDecimal goodsWeight5;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位5")
    private String goodsUnit5;

    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点5")
    private String unloadingLocation5;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价5")
    private BigDecimal unitPrice5;


}
