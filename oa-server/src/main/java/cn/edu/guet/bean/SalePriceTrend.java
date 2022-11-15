package cn.edu.guet.bean;

import lombok.Data;

import java.sql.Date;
import java.util.Objects;

/**
 * @author 陶祎祎
 */
@Data
public class SalePriceTrend {
    private Date saleContractTime;
    private String avgPrice;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        SalePriceTrend that = (SalePriceTrend) o;
        return Objects.equals(saleContractTime, that.saleContractTime) && Objects.equals(avgPrice, that.avgPrice);
    }

    @Override
    public int hashCode() {
        return Objects.hash(saleContractTime, avgPrice);
    }

    @Override
    public String toString() {
        return "SalePriceTrend{" +
                "saleContractTime=" + saleContractTime +
                ", avgPrice='" + avgPrice + '\'' +
                '}';
    }
}
