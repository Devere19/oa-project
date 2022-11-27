package cn.edu.guet.bean;

import cn.edu.guet.bean.sale.SaleContract;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author 陶祎祎
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class IncomeSpendDetail {
    private List<SaleContract> incomeDetail;

    private List spendDetail;
}
