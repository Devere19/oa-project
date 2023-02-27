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
public class ImportOfficeExpenseModel {
    /**
     * 支出项目清单
     */
    @ExcelProperty(value = "支出项目清单")
    private String itemsList;

    /**
     * 支出金额总计
     */
    @ExcelProperty(value = "支出金额总计")
    private BigDecimal expenses;

    /**
     * 日期
     */
    @ExcelProperty(value = "日期（格式为xxxx-xx-xx）")
    private Date time;
}
