package cn.edu.guet.bean;

import lombok.Data;

import java.sql.Date;
import java.util.Objects;

/**
 * @author 陶祎祎
 */
@Data
public class PurchasePriceTrend {
    private Date inboundTime;

    private String avgPrice;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        PurchasePriceTrend that = (PurchasePriceTrend) o;
        return Objects.equals(inboundTime, that.inboundTime) && Objects.equals(avgPrice, that.avgPrice);
    }

    @Override
    public int hashCode() {
        return Objects.hash(inboundTime, avgPrice);
    }

    @Override
    public String toString() {
        return "PurchasePriceTrend{" +
                "inboundTime=" + inboundTime +
                ", avgPrice='" + avgPrice + '\'' +
                '}';
    }
}
