package cn.edu.guet.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 
 * @TableName purchase_payment_contract
 */
@TableName(value ="purchase_payment_contract")
@Data
public class PurchasePaymentContract implements Serializable {
    /**
     * 采购付款单ID
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 销售单合同编号
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
        PurchasePaymentContract other = (PurchasePaymentContract) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getPurchaseContractNo() == null ? other.getPurchaseContractNo() == null : this.getPurchaseContractNo().equals(other.getPurchaseContractNo()))
            && (this.getPaymentCount() == null ? other.getPaymentCount() == null : this.getPaymentCount().equals(other.getPaymentCount()))
            && (this.getPaymentTime() == null ? other.getPaymentTime() == null : this.getPaymentTime().equals(other.getPaymentTime()))
            && (this.getPaymentPhoto() == null ? other.getPaymentPhoto() == null : this.getPaymentPhoto().equals(other.getPaymentPhoto()))
            && (this.getPaymentPhotoArray() == null ? other.getPaymentPhotoArray() == null : this.getPaymentPhotoArray().equals(other.getPaymentPhotoArray()))
            && (this.getFinanceStaff() == null ? other.getFinanceStaff() == null : this.getFinanceStaff().equals(other.getFinanceStaff()))
            && (this.getFinanceState() == null ? other.getFinanceState() == null : this.getFinanceState().equals(other.getFinanceState()))
            && (this.getPurchasePaymentDirector() == null ? other.getPurchasePaymentDirector() == null : this.getPurchasePaymentDirector().equals(other.getPurchasePaymentDirector()))
            && (this.getCashier() == null ? other.getCashier() == null : this.getCashier().equals(other.getCashier()))
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
        result = prime * result + ((getPaymentCount() == null) ? 0 : getPaymentCount().hashCode());
        result = prime * result + ((getPaymentTime() == null) ? 0 : getPaymentTime().hashCode());
        result = prime * result + ((getPaymentPhoto() == null) ? 0 : getPaymentPhoto().hashCode());
        result = prime * result + ((getPaymentPhotoArray() == null) ? 0 : getPaymentPhotoArray().hashCode());
        result = prime * result + ((getFinanceStaff() == null) ? 0 : getFinanceStaff().hashCode());
        result = prime * result + ((getFinanceState() == null) ? 0 : getFinanceState().hashCode());
        result = prime * result + ((getPurchasePaymentDirector() == null) ? 0 : getPurchasePaymentDirector().hashCode());
        result = prime * result + ((getCashier() == null) ? 0 : getCashier().hashCode());
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
        sb.append(", paymentCount=").append(paymentCount);
        sb.append(", paymentTime=").append(paymentTime);
        sb.append(", paymentPhoto=").append(paymentPhoto);
        sb.append(", paymentPhotoArray=").append(paymentPhotoArray);
        sb.append(", financeStaff=").append(financeStaff);
        sb.append(", financeState=").append(financeState);
        sb.append(", purchasePaymentDirector=").append(purchasePaymentDirector);
        sb.append(", cashier=").append(cashier);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}