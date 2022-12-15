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
public class ExportProcessPaymentModel {
    /**
     * 加工付款单ID
     */
    @Excel(name = "加工付款单ID")
    private Integer id;

    /**
     * 加工单合同编号
     */
    @Excel(name = "加工合同编号")
    private String processContractNo;

    /**
     * 总费用金额
     */
    @Excel(name = "总费用金额")
    private BigDecimal paymentCount;

    /**
     * 付款时间
     */
    @Excel(name = "付款时间",format = "yyyy-MM-dd",width = 11)
    private Date paymentTime;

    /**
     * 付款月份
     */
    @Excel(name = "付款月份")
    private String paymentMonth;

    /**
     * 付款月加工单价/吨
     */
    @Excel(name = "付款月加工单价(元/吨)")
    private BigDecimal paymentMonthPriceT;

    /**
     * 付款月加工总量
     */
    @Excel(name = "付款月加工总量")
    private BigDecimal goodsCount;

    /**
     * 财务名称
     */
    @Excel(name = "财务名称")
    private String financeStaff;

    /**
     * 出纳名称
     */
    @Excel(name = "出纳名称")
    private String cashier;
}
