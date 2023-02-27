package cn.edu.guet.bean.ImportModel;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * @author 陶祎祎
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImportProcessPaymentContractModel {
    /**
     * 加工合同编号
     */
    @ExcelProperty(value = "加工合同编号")
    private String processContractNo;

    /**
     * 付款月份
     */
    @ExcelProperty(value = "付款月份（格式为xxxx-xx）")
    private String paymentMonth;

    /**
     * 加工单价(元/吨)
     */
    @ExcelProperty(value = "加工单价(元/吨)")
    private BigDecimal paymentMonthPriceT;

    /**
     * 加工总量(吨)
     */
    @ExcelProperty(value = "加工总量(吨)")
    private BigDecimal goodsCount;

    /**
     * 总费用金额
     */
    @ExcelProperty(value = "总费用金额")
    private BigDecimal paymentCount;
}
