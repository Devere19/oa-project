package cn.edu.guet.bean.purchaseContract;


import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * 
 * @author 陶祎祎
 * @TableName purchase_contract
 */
@Data
public class PurchaseContract implements Serializable {
    /**
     * 
     */
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 采购合同编号
     */
    private String purchaseContractNo;

    /**
     * 旧采购单合同编号
     * 前端传输，更新采购单所用
     */
    @TableField(exist = false)
    private String oldPurchaseContractNo;

    /**
     * 供货商公司名称
     */
    private String customerEnterpriseName;

    /**
     * 己方公司名
     */
    private String ownCompanyName;

    /**
     * 榨季
     */
    private String squeezeSeason;

    /**
     * 入库时间（合同实际签订时间）
     */
    private Date inboundTime;

    /**
     * 采购货物名称
     */
    private String goodsName;

    /**
     * 采购货物数量
     */
    private BigDecimal goodsCount;

    /**
     * 采购货物单位
     */
    private String goodsUnit;

    /**
     * 前端传入库数据所用*
     */
    @TableField(exist = false)
    private List<InboundBean> inboundData;

    /**
     * 采购总金额
     */
    private BigDecimal paymentAmount;

    /**
     * 未结清金额
     */
    private BigDecimal unpaidAmount;

    /**
     * 采购合同照片
     */
    private String contractPhoto;

    /**
     * 前端数据传输*
     * 采购合同照片
     */
    @TableField(exist = false)
    private List<String> contractPhotoArray;

    /**
     * 更新采购单所用，标记是否只修改了图片
     * 1代表只改了图片 0则反之
     */
    @TableField(exist = false)
    private Integer onlyUpdatePhoto;

    /**
     * 归档 0表示隐藏，1表示显示
     */
    private Integer pigeonhole;

    /**
     * 是否存在相关付款单 0表示无 1表示有
     */
    private Integer relationPaymentExistState;

    /**
     * 相关付款单是否已审核 0表示未审核 1表示已审核
     */
    private Integer relationPaymentAuditState;

    /**
     * 是否已生成相关的物流单 0表示无 1表示有
     */
    private Integer relationLogisticsExistState;

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
        PurchaseContract other = (PurchaseContract) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getPurchaseContractNo() == null ? other.getPurchaseContractNo() == null : this.getPurchaseContractNo().equals(other.getPurchaseContractNo()))
            && (this.getOldPurchaseContractNo() == null ? other.getOldPurchaseContractNo() == null : this.getOldPurchaseContractNo().equals(other.getOldPurchaseContractNo()))
            && (this.getCustomerEnterpriseName() == null ? other.getCustomerEnterpriseName() == null : this.getCustomerEnterpriseName().equals(other.getCustomerEnterpriseName()))
            && (this.getOwnCompanyName() == null ? other.getOwnCompanyName() == null : this.getOwnCompanyName().equals(other.getOwnCompanyName()))
            && (this.getSqueezeSeason() == null ? other.getSqueezeSeason() == null : this.getSqueezeSeason().equals(other.getSqueezeSeason()))
            && (this.getInboundTime() == null ? other.getInboundTime() == null : this.getInboundTime().equals(other.getInboundTime()))
            && (this.getGoodsName() == null ? other.getGoodsName() == null : this.getGoodsName().equals(other.getGoodsName()))
            && (this.getGoodsCount() == null ? other.getGoodsCount() == null : this.getGoodsCount().equals(other.getGoodsCount()))
            && (this.getGoodsUnit() == null ? other.getGoodsUnit() == null : this.getGoodsUnit().equals(other.getGoodsUnit()))
            && (this.getInboundData() == null ? other.getInboundData() == null : this.getInboundData().equals(other.getInboundData()))
            && (this.getPaymentAmount() == null ? other.getPaymentAmount() == null : this.getPaymentAmount().equals(other.getPaymentAmount()))
            && (this.getUnpaidAmount() == null ? other.getUnpaidAmount() == null : this.getUnpaidAmount().equals(other.getUnpaidAmount()))
            && (this.getContractPhoto() == null ? other.getContractPhoto() == null : this.getContractPhoto().equals(other.getContractPhoto()))
            && (this.getContractPhotoArray() == null ? other.getContractPhotoArray() == null : this.getContractPhotoArray().equals(other.getContractPhotoArray()))
            && (this.getOnlyUpdatePhoto() == null ? other.getOnlyUpdatePhoto() == null : this.getOnlyUpdatePhoto().equals(other.getOnlyUpdatePhoto()))
            && (this.getPigeonhole() == null ? other.getPigeonhole() == null : this.getPigeonhole().equals(other.getPigeonhole()))
            && (this.getRelationPaymentExistState() == null ? other.getRelationPaymentExistState() == null : this.getRelationPaymentExistState().equals(other.getRelationPaymentExistState()))
            && (this.getRelationPaymentAuditState() == null ? other.getRelationPaymentAuditState() == null : this.getRelationPaymentAuditState().equals(other.getRelationPaymentAuditState()))
            && (this.getRelationLogisticsExistState() == null ? other.getRelationLogisticsExistState() == null : this.getRelationLogisticsExistState().equals(other.getRelationLogisticsExistState()))
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
        result = prime * result + ((getPurchaseContractNo() == null) ? 0 : getPurchaseContractNo().hashCode());
        result = prime * result + ((getOldPurchaseContractNo() == null) ? 0 : getOldPurchaseContractNo().hashCode());
        result = prime * result + ((getCustomerEnterpriseName() == null) ? 0 : getCustomerEnterpriseName().hashCode());
        result = prime * result + ((getOwnCompanyName() == null) ? 0 : getOwnCompanyName().hashCode());
        result = prime * result + ((getSqueezeSeason() == null) ? 0 : getSqueezeSeason().hashCode());
        result = prime * result + ((getInboundTime() == null) ? 0 : getInboundTime().hashCode());
        result = prime * result + ((getGoodsName() == null) ? 0 : getGoodsName().hashCode());
        result = prime * result + ((getGoodsCount() == null) ? 0 : getGoodsCount().hashCode());
        result = prime * result + ((getGoodsUnit() == null) ? 0 : getGoodsUnit().hashCode());
        result = prime * result + ((getInboundData() == null) ? 0 : getInboundData().hashCode());
        result = prime * result + ((getPaymentAmount() == null) ? 0 : getPaymentAmount().hashCode());
        result = prime * result + ((getUnpaidAmount() == null) ? 0 : getUnpaidAmount().hashCode());
        result = prime * result + ((getContractPhoto() == null) ? 0 : getContractPhoto().hashCode());
        result = prime * result + ((getContractPhotoArray() == null) ? 0 : getContractPhotoArray().hashCode());
        result = prime * result + ((getOnlyUpdatePhoto() == null) ? 0 : getOnlyUpdatePhoto().hashCode());
        result = prime * result + ((getPigeonhole() == null) ? 0 : getPigeonhole().hashCode());
        result = prime * result + ((getRelationPaymentExistState() == null) ? 0 : getRelationPaymentExistState().hashCode());
        result = prime * result + ((getRelationPaymentAuditState() == null) ? 0 : getRelationPaymentAuditState().hashCode());
        result = prime * result + ((getRelationLogisticsExistState() == null) ? 0 : getRelationLogisticsExistState().hashCode());
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
        sb.append(", purchaseContractNo=").append(purchaseContractNo);
        sb.append(", oldPurchaseContractNo=").append(oldPurchaseContractNo);
        sb.append(", customerEnterpriseName=").append(customerEnterpriseName);
        sb.append(", ownCompanyName=").append(ownCompanyName);
        sb.append(", squeezeSeason=").append(squeezeSeason);
        sb.append(", inboundTime=").append(inboundTime);
        sb.append(", goodsName=").append(goodsName);
        sb.append(", goodsCount=").append(goodsCount);
        sb.append(", goodsUnit=").append(goodsUnit);
        sb.append(", inboundData=").append(inboundData);
        sb.append(", paymentAmount=").append(paymentAmount);
        sb.append(", unpaidAmount=").append(unpaidAmount);
        sb.append(", contractPhoto=").append(contractPhoto);
        sb.append(", contractPhotoArray=").append(contractPhotoArray);
        sb.append(", onlyUpdatePhoto=").append(onlyUpdatePhoto);
        sb.append(", pigeonhole=").append(pigeonhole);
        sb.append(", relationPaymentExistState=").append(relationPaymentExistState);
        sb.append(", relationPaymentAuditState=").append(relationPaymentAuditState);
        sb.append(", relationLogisticsExistState=").append(relationLogisticsExistState);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}