package cn.edu.guet.bean.purchaseContract;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 陶祎祎
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExportOutPurchaseContract {

    /**
     * 采购合同编号
     */
    @Excel(name = "采购合同编号")
    private String purchaseContractNo;

    /**
     * 公司名称
     */
    @Excel(name = "供货方公司名")
    private String customerEnterpriseName;

    /**
     * 己方公司名
     */
    @Excel(name = "己方公司名")
    private String ownCompanyName;

    /**
     * 榨季
     */
    @Excel(name = "榨季")
    private String squeezeSeason;

    /**
     * 入库时间（合同实际签订时间）
     */
    @Excel(name = "入库时间（合同实际签订时间）",format = "yyyy-MM-dd",width = 11)
    private Date inboundTime;

    /**
     * 采购货物名称
     */
    @Excel(name = "采购货物名称")
    private String goodsName;

    /**
     * 采购货物数量
     */
    @Excel(name = "采购货物数量")
    private BigDecimal goodsCount;

    /**
     * 采购货物单位
     */
    @Excel(name = "采购货物单位")
    private String goodsUnit;

    /**
     * 采购货物单价
     */
    @Excel(name = "采购货物单价")
    private BigDecimal goodsUnitPrice;

    /**
     * 采购总金额
     */
    @Excel(name = "采购总金额")
    private BigDecimal paymentAmount;

    /**
     * 未结清金额
     */
    @Excel(name = "未结清金额")
    private BigDecimal unpaidAmount;

    /**
     * 创建时间
     */
    @Excel(name = "创建时间",format = "yyyy-MM-dd HH:mm:ss",width = 12)
    private Date createTime;

    /**
     * 创建者名称
     */
    @Excel(name = "创建者名称")
    private String createBy;

    /**
     * 最新更新时间
     */
    @Excel(name = "最新更新时间",format = "yyyy-MM-dd HH:mm:ss",width = 12)
    private Date lastUpdateTime;

    /**
     * 最新更新者名称
     */
    @Excel(name = "最新更新者名称")
    private String lastUpdateBy;
}
