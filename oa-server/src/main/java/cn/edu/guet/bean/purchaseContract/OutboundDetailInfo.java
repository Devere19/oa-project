package cn.edu.guet.bean.purchaseContract;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;

/**
 * 
 * @author 陶祎祎
 * @TableName outbound_detail_info
 */
@TableName(value ="outbound_detail_info")
@Data
public class OutboundDetailInfo implements Serializable {
    /**
     * 采购合同编号
     */
    private String purchaseContractNo;

    /**
     * 销售单合同编号
     */
    private String saleContractNo;

    /**
     * 运输合同编号
     */
    private String logisticsContractNo;

    /**
     * 销售货物名称
     */
    private String goodsName;

    /**
     * 取货厂名
     */
    private String goodsFactory;

    /**
     * 车牌号
     */
    private String licensePlateNumber;

    /**
     * 载货量
     */
    private BigDecimal goodsWeight;

    /**
     * 货物单位
     */
    private String goodsUnit;

    /**
     * 出库日期
     */
    private Date outboundTime;

    /**
     * 出库总量
     */
    private BigDecimal totalWeight;

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
        OutboundDetailInfo other = (OutboundDetailInfo) that;
        return (this.getPurchaseContractNo() == null ? other.getPurchaseContractNo() == null : this.getPurchaseContractNo().equals(other.getPurchaseContractNo()))
            && (this.getSaleContractNo() == null ? other.getSaleContractNo() == null : this.getSaleContractNo().equals(other.getSaleContractNo()))
            && (this.getLogisticsContractNo() == null ? other.getLogisticsContractNo() == null : this.getLogisticsContractNo().equals(other.getLogisticsContractNo()))
            && (this.getGoodsName() == null ? other.getGoodsName() == null : this.getGoodsName().equals(other.getGoodsName()))
            && (this.getGoodsFactory() == null ? other.getGoodsFactory() == null : this.getGoodsFactory().equals(other.getGoodsFactory()))
            && (this.getLicensePlateNumber() == null ? other.getLicensePlateNumber() == null : this.getLicensePlateNumber().equals(other.getLicensePlateNumber()))
            && (this.getGoodsWeight() == null ? other.getGoodsWeight() == null : this.getGoodsWeight().equals(other.getGoodsWeight()))
            && (this.getGoodsUnit() == null ? other.getGoodsUnit() == null : this.getGoodsUnit().equals(other.getGoodsUnit()))
            && (this.getOutboundTime() == null ? other.getOutboundTime() == null : this.getOutboundTime().equals(other.getOutboundTime()))
            && (this.getTotalWeight() == null ? other.getTotalWeight() == null : this.getTotalWeight().equals(other.getTotalWeight()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getPurchaseContractNo() == null) ? 0 : getPurchaseContractNo().hashCode());
        result = prime * result + ((getSaleContractNo() == null) ? 0 : getSaleContractNo().hashCode());
        result = prime * result + ((getLogisticsContractNo() == null) ? 0 : getLogisticsContractNo().hashCode());
        result = prime * result + ((getGoodsName() == null) ? 0 : getGoodsName().hashCode());
        result = prime * result + ((getGoodsFactory() == null) ? 0 : getGoodsFactory().hashCode());
        result = prime * result + ((getLicensePlateNumber() == null) ? 0 : getLicensePlateNumber().hashCode());
        result = prime * result + ((getGoodsWeight() == null) ? 0 : getGoodsWeight().hashCode());
        result = prime * result + ((getGoodsUnit() == null) ? 0 : getGoodsUnit().hashCode());
        result = prime * result + ((getOutboundTime() == null) ? 0 : getOutboundTime().hashCode());
        result = prime * result + ((getTotalWeight() == null) ? 0 : getTotalWeight().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", purchaseContractNo=").append(purchaseContractNo);
        sb.append(", saleContractNo=").append(saleContractNo);
        sb.append(", logisticsContractNo=").append(logisticsContractNo);
        sb.append(", goodsName=").append(goodsName);
        sb.append(", goodsFactory=").append(goodsFactory);
        sb.append(", licensePlateNumber=").append(licensePlateNumber);
        sb.append(", goodsWeight=").append(goodsWeight);
        sb.append(", goodsUnit=").append(goodsUnit);
        sb.append(", outboundTime=").append(outboundTime);
        sb.append(", totalWeight=").append(totalWeight);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}