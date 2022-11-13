package cn.edu.guet.bean;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @author 陶祎祎
 * @TableName logistics_payment_state_info
 */
@TableName(value ="logistics_payment_state_info")
@Data
public class LogisticsPaymentStateView implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * 物流付款单ID
     */
    private Integer logisticsPaymentContractId;

    /**
     * 董事会用户ID
     */
    private Integer userId;

    /**
     * 昵称
     */
    private String nickName;

    /**
     * 董事会审核状态
     */
    private Integer state;

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
        LogisticsPaymentStateView other = (LogisticsPaymentStateView) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getLogisticsPaymentContractId() == null ? other.getLogisticsPaymentContractId() == null : this.getLogisticsPaymentContractId().equals(other.getLogisticsPaymentContractId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getNickName() == null ? other.getNickName() == null : this.getNickName().equals(other.getNickName()))
            && (this.getState() == null ? other.getState() == null : this.getState().equals(other.getState()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getLogisticsPaymentContractId() == null) ? 0 : getLogisticsPaymentContractId().hashCode());
        result = prime * result + ((getUserId() == null) ? 0 : getUserId().hashCode());
        result = prime * result + ((getNickName() == null) ? 0 : getNickName().hashCode());
        result = prime * result + ((getState() == null) ? 0 : getState().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", logisticsPaymentContractId=").append(logisticsPaymentContractId);
        sb.append(", userId=").append(userId);
        sb.append(", nickName=").append(nickName);
        sb.append(", state=").append(state);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}