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
 * @TableName spend_detail_info
 */
@TableName(value ="spend_detail_info")
@Data
public class SpendDetailView implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * 
     */
    private String type;

    /**
     * 
     */
    private String ownCompanyName;

    /**
     * 
     */
    private String relationContractNo;

    /**
     * 
     */
    private BigDecimal paymentCount;

    /**
     * 
     */
    private Date paymentTime;

    /**
     * 
     */
    private String paymentPhoto;

    /**
     * 前端数据传输*
     * 付款流水截图
     */
    @TableField(exist = false)
    private List<String> paymentPhotoArray;

    /**
     *
     */
    private String timeFlag;

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
        SpendDetailView other = (SpendDetailView) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getType() == null ? other.getType() == null : this.getType().equals(other.getType()))
            && (this.getOwnCompanyName() == null ? other.getOwnCompanyName() == null : this.getOwnCompanyName().equals(other.getOwnCompanyName()))
            && (this.getRelationContractNo() == null ? other.getRelationContractNo() == null : this.getRelationContractNo().equals(other.getRelationContractNo()))
            && (this.getPaymentCount() == null ? other.getPaymentCount() == null : this.getPaymentCount().equals(other.getPaymentCount()))
            && (this.getPaymentTime() == null ? other.getPaymentTime() == null : this.getPaymentTime().equals(other.getPaymentTime()))
            && (this.getPaymentPhoto() == null ? other.getPaymentPhoto() == null : this.getPaymentPhoto().equals(other.getPaymentPhoto()))
            && (this.getPaymentPhotoArray() == null ? other.getPaymentPhotoArray() == null : this.getPaymentPhotoArray().equals(other.getPaymentPhotoArray()))
            && (this.getTimeFlag() == null ? other.getTimeFlag() == null : this.getTimeFlag().equals(other.getTimeFlag()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getType() == null) ? 0 : getType().hashCode());
        result = prime * result + ((getOwnCompanyName() == null) ? 0 : getOwnCompanyName().hashCode());
        result = prime * result + ((getRelationContractNo() == null) ? 0 : getRelationContractNo().hashCode());
        result = prime * result + ((getPaymentCount() == null) ? 0 : getPaymentCount().hashCode());
        result = prime * result + ((getPaymentTime() == null) ? 0 : getPaymentTime().hashCode());
        result = prime * result + ((getPaymentPhoto() == null) ? 0 : getPaymentPhoto().hashCode());
        result = prime * result + ((getPaymentPhotoArray() == null) ? 0 : getPaymentPhotoArray().hashCode());
        result = prime * result + ((getTimeFlag() == null) ? 0 : getTimeFlag().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", type=").append(type);
        sb.append(", ownCompanyName=").append(ownCompanyName);
        sb.append(", relationContractNo=").append(relationContractNo);
        sb.append(", paymentCount=").append(paymentCount);
        sb.append(", paymentTime=").append(paymentTime);
        sb.append(", paymentPhoto=").append(paymentPhoto);
        sb.append(", paymentPhotoArray=").append(paymentPhotoArray);
        sb.append(", timeFlag=").append(timeFlag);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}