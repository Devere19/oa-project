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
public class ExportLogisticsPaymentModel {
    /**
     * 物流付款单ID
     */
    @Excel(name = "物流付款单ID")
    private Integer id;

    /**
     * 物流合同编号
     */
    @Excel(name = "物流合同编号")
    private String logisticsContractNo;

    /**
     * 本次付款金额
     */
    @Excel(name = "本次付款金额")
    private BigDecimal paymentCount;

    /**
     * 付款时间
     */
    @Excel(name = "付款时间",format = "yyyy-MM-dd",width = 11)
    private Date paymentTime;

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
