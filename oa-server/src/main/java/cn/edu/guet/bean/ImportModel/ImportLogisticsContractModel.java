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
    @ExcelProperty(value = "物流单合同编号（“自提”请填写销售合同号）")
    private String logisticsContractNo;

    /**
     * 销售/加工单合同编号
     */
    @ExcelProperty(value = "销售/加工单合同编号（运往自家仓库请填写“000”）")
    private String saleContractNo;

    /**
     * 己方公司名
     */
    @ExcelProperty(value = "己方公司名称")
    private String ownCompanyName;

    /**
     * 销售单合同总重量
     */
    @ExcelProperty(value = "物流合同总重量")
    private BigDecimal totalWeight;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位（斤/吨）")
    private String goodsUnit;

    /**
     * 运费
     */
    @ExcelProperty(value = "运费")
    private BigDecimal freight;

    /**
     * 物流单合同签订时间
     */
    @ExcelProperty(value = "物流单合同签订时间（格式为xxxx-xx-xx）")
    private Date logisticsContractTime;

    /**
     * 榨季
     */
    @ExcelProperty(value = "榨季")
    private String squeezeSeason;


    /**
     * 物流单类型
     */
    @ExcelProperty(value = "物流单类型（0：加工单  1：销售单）")
    private Integer upperType;



    //物流详情单
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号")
    private String detailLogisticsContractNo;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型（0：加工单     1：采购单）")
    private String detailUpperType;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号（自家仓库出货请填写“000”）")
    private String detailPurchaseContractNo;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期（格式为xxxx-xx-xx）")
    private Date detailOutboundTime;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名（自家仓库出货填写自家仓库）")
    private String detailGoodsFactory;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号")
    private String detailLicensePlateNumber;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量")
    private BigDecimal detailGoodsWeight;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位")
    private String detailGoodsUnit;


    /**
     * 卸货量
     */
    @ExcelProperty(value = "卸货量")
    private BigDecimal detailUploadingWeight;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点")
    private String detailUnloadingLocation;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价")
    private BigDecimal detailUnitPrice;


    /**
     * 结算方式
     */
    @ExcelProperty(value = "结算方式（装货结算/卸货结算）")
    private String detailCalculationMethod;

}
