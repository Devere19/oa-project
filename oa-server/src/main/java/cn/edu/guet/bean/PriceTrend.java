package cn.edu.guet.bean;

import lombok.Data;

import java.util.List;
import java.util.Objects;

/**
 * @author 陶祎祎
 */
@Data
public class PriceTrend {
    private List<PurchasePriceTrend> purchasePriceTrends;
    private List<SalePriceTrend> salePriceTrends;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        PriceTrend that = (PriceTrend) o;
        return Objects.equals(purchasePriceTrends, that.purchasePriceTrends) && Objects.equals(salePriceTrends, that.salePriceTrends);
    }

    @Override
    public int hashCode() {
        return Objects.hash(purchasePriceTrends, salePriceTrends);
    }

    @Override
    public String toString() {
        return "PriceTrend{" +
                "purchasePriceTrends=" + purchasePriceTrends +
                ", salePriceTrends=" + salePriceTrends +
                '}';
    }
}
