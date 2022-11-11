package cn.edu.guet.bean;


import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 
 * @TableName purchase_payment_contract_info
 */
@TableName(value ="purchase_payment_contract_info")
@Data
public class PurchasePaymentContractView implements Serializable {
    /**
     * 采购付款单ID
     */
    private Integer id;

    /**
     * 采购单合同编号
     */
    private String purchaseContractNo;

    /**
     * 本次付款金额
     */
    private BigDecimal paymentCount;

    /**
     * 财务名称
     */
    private String financeStaff;

    /**
     * 财务审核状态
     */
    private Integer financeState;

    /**
     * 董事审核数据*
     */
    @TableField(exist = false)
    private List<PurchasePaymentStateView> purchasePaymentDirector;

    /**
     * 出纳名称
     */
    private String cashier;

    /**
     * 付款时间
     */
    private Date paymentTime;

    /**
     * 付款流水截图
     */
    private String paymentPhoto;

    /**
     * 前端数据传输*
     * 付款流水截图
     */
    @TableField(exist = false)
    private List<String> paymentPhotoArray;

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

    /**
     * 公司名称
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
     * 采购总金额
     */
    private BigDecimal paymentAmount;

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
        PurchasePaymentContractView other = (PurchasePaymentContractView) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getPurchaseContractNo() == null ? other.getPurchaseContractNo() == null : this.getPurchaseContractNo().equals(other.getPurchaseContractNo()))
            && (this.getPaymentCount() == null ? other.getPaymentCount() == null : this.getPaymentCount().equals(other.getPaymentCount()))
            && (this.getFinanceStaff() == null ? other.getFinanceStaff() == null : this.getFinanceStaff().equals(other.getFinanceStaff()))
            && (this.getFinanceState() == null ? other.getFinanceState() == null : this.getFinanceState().equals(other.getFinanceState()))
            && (this.getPurchasePaymentDirector() == null ? other.getPurchasePaymentDirector() == null : this.getPurchasePaymentDirector().equals(other.getPurchasePaymentDirector()))
            && (this.getCashier() == null ? other.getCashier() == null : this.getCashier().equals(other.getCashier()))
            && (this.getPaymentTime() == null ? other.getPaymentTime() == null : this.getPaymentTime().equals(other.getPaymentTime()))
            && (this.getPaymentPhoto() == null ? other.getPaymentPhoto() == null : this.getPaymentPhoto().equals(other.getPaymentPhoto()))
            && (this.getPaymentPhotoArray() == null ? other.getPaymentPhotoArray() == null : this.getPaymentPhotoArray().equals(other.getPaymentPhotoArray()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getCreateBy() == null ? other.getCreateBy() == null : this.getCreateBy().equals(other.getCreateBy()))
            && (this.getLastUpdateTime() == null ? other.getLastUpdateTime() == null : this.getLastUpdateTime().equals(other.getLastUpdateTime()))
            && (this.getLastUpdateBy() == null ? other.getLastUpdateBy() == null : this.getLastUpdateBy().equals(other.getLastUpdateBy()))
            && (this.getCustomerEnterpriseName() == null ? other.getCustomerEnterpriseName() == null : this.getCustomerEnterpriseName().equals(other.getCustomerEnterpriseName()))
            && (this.getOwnCompanyName() == null ? other.getOwnCompanyName() == null : this.getOwnCompanyName().equals(other.getOwnCompanyName()))
            && (this.getSqueezeSeason() == null ? other.getSqueezeSeason() == null : this.getSqueezeSeason().equals(other.getSqueezeSeason()))
            && (this.getInboundTime() == null ? other.getInboundTime() == null : this.getInboundTime().equals(other.getInboundTime()))
            && (this.getGoodsName() == null ? other.getGoodsName() == null : this.getGoodsName().equals(other.getGoodsName()))
            && (this.getGoodsCount() == null ? other.getGoodsCount() == null : this.getGoodsCount().equals(other.getGoodsCount()))
            && (this.getGoodsUnit() == null ? other.getGoodsUnit() == null : this.getGoodsUnit().equals(other.getGoodsUnit()))
            && (this.getPaymentAmount() == null ? other.getPaymentAmount() == null : this.getPaymentAmount().equals(other.getPaymentAmount()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getPurchaseContractNo() == null) ? 0 : getPurchaseContractNo().hashCode());
        result = prime * result + ((getPaymentCount() == null) ? 0 : getPaymentCount().hashCode());
        result = prime * result + ((getFinanceStaff() == null) ? 0 : getFinanceStaff().hashCode());
        result = prime * result + ((getFinanceState() == null) ? 0 : getFinanceState().hashCode());
        result = prime * result + ((getPurchasePaymentDirector() == null) ? 0 : getPurchasePaymentDirector().hashCode());
        result = prime * result + ((getCashier() == null) ? 0 : getCashier().hashCode());
        result = prime * result + ((getPaymentTime() == null) ? 0 : getPaymentTime().hashCode());
        result = prime * result + ((getPaymentPhoto() == null) ? 0 : getPaymentPhoto().hashCode());
        result = prime * result + ((getPaymentPhotoArray() == null) ? 0 : getPaymentPhotoArray().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getCreateBy() == null) ? 0 : getCreateBy().hashCode());
        result = prime * result + ((getLastUpdateTime() == null) ? 0 : getLastUpdateTime().hashCode());
        result = prime * result + ((getLastUpdateBy() == null) ? 0 : getLastUpdateBy().hashCode());
        result = prime * result + ((getCustomerEnterpriseName() == null) ? 0 : getCustomerEnterpriseName().hashCode());
        result = prime * result + ((getOwnCompanyName() == null) ? 0 : getOwnCompanyName().hashCode());
        result = prime * result + ((getSqueezeSeason() == null) ? 0 : getSqueezeSeason().hashCode());
        result = prime * result + ((getInboundTime() == null) ? 0 : getInboundTime().hashCode());
        result = prime * result + ((getGoodsName() == null) ? 0 : getGoodsName().hashCode());
        result = prime * result + ((getGoodsCount() == null) ? 0 : getGoodsCount().hashCode());
        result = prime * result + ((getGoodsUnit() == null) ? 0 : getGoodsUnit().hashCode());
        result = prime * result + ((getPaymentAmount() == null) ? 0 : getPaymentAmount().hashCode());
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
        sb.append(", paymentCount=").append(paymentCount);
        sb.append(", financeStaff=").append(financeStaff);
        sb.append(", financeState=").append(financeState);
        sb.append(", purchasePaymentDirector=").append(purchasePaymentDirector);
        sb.append(", cashier=").append(cashier);
        sb.append(", paymentTime=").append(paymentTime);
        sb.append(", paymentPhoto=").append(paymentPhoto);
        sb.append(", paymentPhotoArray=").append(paymentPhotoArray);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", customerEnterpriseName=").append(customerEnterpriseName);
        sb.append(", ownCompanyName=").append(ownCompanyName);
        sb.append(", squeezeSeason=").append(squeezeSeason);
        sb.append(", inboundTime=").append(inboundTime);
        sb.append(", goodsName=").append(goodsName);
        sb.append(", goodsCount=").append(goodsCount);
        sb.append(", goodsUnit=").append(goodsUnit);
        sb.append(", paymentAmount=").append(paymentAmount);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}