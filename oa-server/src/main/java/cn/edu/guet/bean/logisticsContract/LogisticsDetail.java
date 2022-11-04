package cn.edu.guet.bean.logisticsContract;

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
 * @TableName logistics_detail
 */
@TableName(value ="logistics_detail")
@Data
public class LogisticsDetail implements Serializable {
    /**
     * 主键id  自增
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 物流单合同编号（运输合同编号）
     */
    private String saleContractNo;

    /**
     * 采购合同编号
     */
    private String purchaseContractNo;

    /**
     * 取货厂名
     */
    private String goodsFactory;

    /**
     * 出库日期
     */
    private Date outboundTime;

    /**
     * 车牌号
     */
    private String licensePlateNumber;

    /**
     * 载货量
     */
    private BigDecimal goodsWeight;

    /**
     * 卸货地点
     */
    private String unloadingLocation;

    /**
     * 运输单价
     */
    private BigDecimal unitPrice;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建者名称
     */
    private String createBy;

    /**
     * 最新更新时间
     */
    private Date lastUpdateTime;

    /**
     * 最新更新者名称
     */
    private String lastUpdateBy;

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
        LogisticsDetail other = (LogisticsDetail) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getSaleContractNo() == null ? other.getSaleContractNo() == null : this.getSaleContractNo().equals(other.getSaleContractNo()))
            && (this.getPurchaseContractNo() == null ? other.getPurchaseContractNo() == null : this.getPurchaseContractNo().equals(other.getPurchaseContractNo()))
            && (this.getGoodsFactory() == null ? other.getGoodsFactory() == null : this.getGoodsFactory().equals(other.getGoodsFactory()))
            && (this.getOutboundTime() == null ? other.getOutboundTime() == null : this.getOutboundTime().equals(other.getOutboundTime()))
            && (this.getLicensePlateNumber() == null ? other.getLicensePlateNumber() == null : this.getLicensePlateNumber().equals(other.getLicensePlateNumber()))
            && (this.getGoodsWeight() == null ? other.getGoodsWeight() == null : this.getGoodsWeight().equals(other.getGoodsWeight()))
            && (this.getUnloadingLocation() == null ? other.getUnloadingLocation() == null : this.getUnloadingLocation().equals(other.getUnloadingLocation()))
            && (this.getUnitPrice() == null ? other.getUnitPrice() == null : this.getUnitPrice().equals(other.getUnitPrice()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getCreateBy() == null ? other.getCreateBy() == null : this.getCreateBy().equals(other.getCreateBy()))
            && (this.getLastUpdateTime() == null ? other.getLastUpdateTime() == null : this.getLastUpdateTime().equals(other.getLastUpdateTime()))
            && (this.getLastUpdateBy() == null ? other.getLastUpdateBy() == null : this.getLastUpdateBy().equals(other.getLastUpdateBy()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getSaleContractNo() == null) ? 0 : getSaleContractNo().hashCode());
        result = prime * result + ((getPurchaseContractNo() == null) ? 0 : getPurchaseContractNo().hashCode());
        result = prime * result + ((getGoodsFactory() == null) ? 0 : getGoodsFactory().hashCode());
        result = prime * result + ((getOutboundTime() == null) ? 0 : getOutboundTime().hashCode());
        result = prime * result + ((getLicensePlateNumber() == null) ? 0 : getLicensePlateNumber().hashCode());
        result = prime * result + ((getGoodsWeight() == null) ? 0 : getGoodsWeight().hashCode());
        result = prime * result + ((getUnloadingLocation() == null) ? 0 : getUnloadingLocation().hashCode());
        result = prime * result + ((getUnitPrice() == null) ? 0 : getUnitPrice().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getCreateBy() == null) ? 0 : getCreateBy().hashCode());
        result = prime * result + ((getLastUpdateTime() == null) ? 0 : getLastUpdateTime().hashCode());
        result = prime * result + ((getLastUpdateBy() == null) ? 0 : getLastUpdateBy().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", saleContractNo=").append(saleContractNo);
        sb.append(", purchaseContractNo=").append(purchaseContractNo);
        sb.append(", goodsFactory=").append(goodsFactory);
        sb.append(", outboundTime=").append(outboundTime);
        sb.append(", licensePlateNumber=").append(licensePlateNumber);
        sb.append(", goodsWeight=").append(goodsWeight);
        sb.append(", unloadingLocation=").append(unloadingLocation);
        sb.append(", unitPrice=").append(unitPrice);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}