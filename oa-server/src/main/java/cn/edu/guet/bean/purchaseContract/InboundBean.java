package cn.edu.guet.bean.purchaseContract;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Objects;

/**
 * @author 陶祎祎
 */
@Data
@Component
@NoArgsConstructor
@AllArgsConstructor
public class InboundBean{
    /**
     * 入库厂名*
     */
    private String factoryName;

    /**
     * 入库数量*
     */
    private BigDecimal inboundGoodsCount;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        InboundBean that = (InboundBean) o;
        return Objects.equals(factoryName, that.factoryName) && Objects.equals(inboundGoodsCount, that.inboundGoodsCount);
    }

    @Override
    public int hashCode() {
        return Objects.hash(factoryName, inboundGoodsCount);
    }

    @Override
    public String toString() {
        return "InboundBean{" +
                "factoryName='" + factoryName + '\'' +
                ", inboundGoodsCount=" + inboundGoodsCount +
                '}';
    }
}
