package cn.edu.guet.bean.exportModel;

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
public class ExportSaleModel {

    @Excel(name = "销售单合同编号")
    private String saleContractNo;

    @Excel(name = "销售方公司名")
    private String customerEnterpriseName;

    @Excel(name = "己方公司名")
    private String ownCompanyName;

    @Excel(name = "销售合同总价钱")
    private BigDecimal goodsTotalPrice;

    @Excel(name = "收款金额")
    private BigDecimal revenueAmount;

    @Excel(name = "付款时间",format = "yyyy-MM-dd",width = 11)
    private Date revenueTime;

    @Excel(name = "出纳姓名")
    private String revenueBy;

    @Excel(name = "榨季")
    private String squeezeSeason;

    @Excel(name = "销售合同时间")
    private String saleContractTime;

    @Excel(name = "销售货物名称")
    private String goodsName;

    @Excel(name = "销售货物数量")
    private BigDecimal goodsCount;

    @Excel(name = "销售货物单位")
    private String goodsUnit;

    @Excel(name = "销售货物单价")
    private BigDecimal goodsUnitPrice;

    @Excel(name = "结款方式")
    private String paymentMethod;

    @Excel(name = "运输方式")
    private String transportMethod;

}
