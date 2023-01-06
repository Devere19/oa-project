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
public class ImportLogisticsPaymentContractModel {

    /**
     * 物流合同编号
     */
    @ExcelProperty(value = "物流合同编号")
    private String logisticsContractNo;

    /**
     * 本次付款金额
     */
    @ExcelProperty(value = "本次付款金额")
    private BigDecimal paymentCount;
}
