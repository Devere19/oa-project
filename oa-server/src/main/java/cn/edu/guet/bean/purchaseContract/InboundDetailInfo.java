package cn.edu.guet.bean.purchaseContract;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

/**
 * 
 * @author 陶祎祎
 * @TableName inbound_detail_info
 */
@TableName(value ="inbound_detail_info")
@Data
public class InboundDetailInfo implements Serializable {
    /**
     * 采购合同编号
     */
    private String purchaseContractNo;

    /**
     * 入库厂名
     */
    private String factoryName;

    /**
     * 当前库存量
     */
    @TableField(exist = false)
    private BigDecimal currentGoodsCount;

    /**
     * 入库货物名称
     */
    private String inOutGoodsName;

    /**
     * 入库货物数量
     */
    private BigDecimal inOutGoodsCount;

    /**
     * 入库货物单位
     */
    private String goodsUnit;

    /**
     * 入库货物单价
     */
    private BigDecimal goodsUnitPrice;

    /**
     * 详情对象
     */
    @TableField(exist = false)
    private List<OutboundDetailInfo> outboundDetailInfos;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        InboundDetailInfo other = (InboundDetailInfo) that;
        return (this.getPurchaseContractNo() == null ? other.getPurchaseContractNo() == null : this.getPurchaseContractNo().equals(other.getPurchaseContractNo()))
            && (this.getFactoryName() == null ? other.getFactoryName() == null : this.getFactoryName().equals(other.getFactoryName()))
            && (this.getCurrentGoodsCount() == null ? other.getCurrentGoodsCount() == null : this.getCurrentGoodsCount().equals(other.getCurrentGoodsCount()))
            && (this.getInOutGoodsName() == null ? other.getInOutGoodsName() == null : this.getInOutGoodsName().equals(other.getInOutGoodsName()))
            && (this.getInOutGoodsCount() == null ? other.getInOutGoodsCount() == null : this.getInOutGoodsCount().equals(other.getInOutGoodsCount()))
            && (this.getGoodsUnit() == null ? other.getGoodsUnit() == null : this.getGoodsUnit().equals(other.getGoodsUnit()))
            && (this.getGoodsUnitPrice() == null ? other.getGoodsUnitPrice() == null : this.getGoodsUnitPrice().equals(other.getGoodsUnitPrice()))
            && (this.getOutboundDetailInfos() == null ? other.getOutboundDetailInfos() == null : this.getOutboundDetailInfos().equals(other.getOutboundDetailInfos()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getPurchaseContractNo() == null) ? 0 : getPurchaseContractNo().hashCode());
        result = prime * result + ((getFactoryName() == null) ? 0 : getFactoryName().hashCode());
        result = prime * result + ((getCurrentGoodsCount() == null) ? 0 : getCurrentGoodsCount().hashCode());
        result = prime * result + ((getInOutGoodsName() == null) ? 0 : getInOutGoodsName().hashCode());
        result = prime * result + ((getInOutGoodsCount() == null) ? 0 : getInOutGoodsCount().hashCode());
        result = prime * result + ((getGoodsUnit() == null) ? 0 : getGoodsUnit().hashCode());
        result = prime * result + ((getGoodsUnitPrice() == null) ? 0 : getGoodsUnitPrice().hashCode());
        result = prime * result + ((getOutboundDetailInfos() == null) ? 0 : getOutboundDetailInfos().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", purchaseContractNo=").append(purchaseContractNo);
        sb.append(", factoryName=").append(factoryName);
        sb.append(", currentGoodsCount=").append(currentGoodsCount);
        sb.append(", inOutGoodsName=").append(inOutGoodsName);
        sb.append(", inOutGoodsCount=").append(inOutGoodsCount);
        sb.append(", goodsUnit=").append(goodsUnit);
        sb.append(", goodsUnitPrice=").append(goodsUnitPrice);
        sb.append(", outboundDetailInfos=").append(outboundDetailInfos);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}