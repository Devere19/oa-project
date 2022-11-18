package cn.edu.guet.bean;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import lombok.Data;

/**
 * 
 * @author 陶祎祎
 * @TableName ffs_income_spend_info
 */
@TableName(value ="ffs_income_spend_info")
@Data
public class FfsIncomeSpendView implements Serializable {
    /**
     * 
     */
    private String legend;

    /**
     * 
     */
    private BigDecimal income;

    /**
     * 
     */
    private BigDecimal spend;

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
        FfsIncomeSpendView other = (FfsIncomeSpendView) that;
        return (this.getLegend() == null ? other.getLegend() == null : this.getLegend().equals(other.getLegend()))
            && (this.getIncome() == null ? other.getIncome() == null : this.getIncome().equals(other.getIncome()))
            && (this.getSpend() == null ? other.getSpend() == null : this.getSpend().equals(other.getSpend()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getLegend() == null) ? 0 : getLegend().hashCode());
        result = prime * result + ((getIncome() == null) ? 0 : getIncome().hashCode());
        result = prime * result + ((getSpend() == null) ? 0 : getSpend().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", legend=").append(legend);
        sb.append(", income=").append(income);
        sb.append(", spend=").append(spend);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}