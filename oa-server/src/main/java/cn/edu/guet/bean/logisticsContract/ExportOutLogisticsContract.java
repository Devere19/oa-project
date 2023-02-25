package cn.edu.guet.bean.logisticsContract;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 物流单
 * @TableName logistics_contract
 */

@Data
public class ExportOutLogisticsContract implements Serializable {

    /**
     * 物流单合同编号（运输合同编号）
     */
    @Excel(name = "物流单合同编号（自提请填写销售合同号）")
    private String logisticsContractNo;

    /**
     * 销售/加工单合同编号
     */
    @Excel(name = "销售/加工单合同编号（运往自家仓库请填写 000）")
    private String saleContractNo;

    /**
     * 己方公司名
     */
    @Excel(name = "己方公司名称")
    private String ownCompanyName;

    /**
     * 销售单合同总重量
     */
    @Excel(name = "物流合同总重量")
    private BigDecimal totalWeight;

    /**
     * 货物单位
     */
    @Excel(name = "货物单位（斤/吨）")
    private String goodsUnit;

    /**
     * 运费
     */
    @Excel(name = "运费")
    private BigDecimal freight;

    /**
     * 物流单合同签订时间
     */
    @Excel(name = "物流单合同签订时间")
    private String logisticsContractTime;

    /**
     * 榨季
     */
    @Excel(name = "榨季")
    private String squeezeSeason;


    /**
     * 物流单类型
     */
    @Excel(name = "物流单类型（0：加工单  1：销售单）")
    private String upperType;



    //物流详情单
    /**
     * 物流单合同编号（运输合同编号）
     */
    @Excel(name = "物流单合同编号")
    private String detailLogisticsContractNo;

    /**
     * 物流详情单类型
     */
    @Excel(name = "物流详情单类型（0：加工单     1：采购单）")
    private String detailUpperType;


    /**
     * 采购/加工合同编号
     */
    @Excel(name = "采购/加工合同编号（若从自家仓库出货填写 000）")
    private String detailPurchaseContractNo;

    /**
     * 出库日期
     */
    @Excel(name = "出库日期")
    private String detailOutboundTime;


    /**
     * 取货厂名
     */
    @Excel(name = "取货厂名（自家仓库出货填写自家仓库）")
    private String detailGoodsFactory;


    /**
     * 车牌号
     */
    @Excel(name = "车牌号")
    private String detailLicensePlateNumber;

    /**
     * 载货量
     */
    @Excel(name = "载货量")
    private BigDecimal detailGoodsWeight;

    /**
     * 货物单位
     */
    @Excel(name = "货物单位")
    private String detailGoodsUnit;


    /**
     * 卸货量
     */
    @Excel(name = "卸货量")
    private BigDecimal detailUploadingWeight;


    /**
     * 卸货地点
     */
    @Excel(name = "卸货地点")
    private String detailUnloadingLocation;

    /**
     * 运输单价
     */
    @Excel(name = "运输单价")
    private BigDecimal detailUnitPrice;


    /**
     * 结算方式
     */
    @Excel(name = "结算方式（装货结算/卸货结算）")
    private String detailCalculationMethod;

    /**
     * 创建人
     */
    @Excel(name = "创建人姓名")
    private String createBy;




}