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
 * @author 陶祎祎
 * @TableName logistics_payment_contract_info
 */
@TableName(value ="logistics_payment_contract_info")
@Data
public class LogisticsPaymentContractView implements Serializable {
    /**
     * 物流付款单ID
     */
    private Integer id;

    /**
     * 物流合同编号
     */
    private String logisticsContractNo;

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
    private List<LogisticsPaymentStateView> logisticsPaymentDirector;

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
     * 销售单合同编号
     */
    private String saleContractNo;

    /**
     * 己方公司名
     */
    private String ownCompanyName;

    /**
     * 运费
     */
    private BigDecimal freight;

    /**
     * 榨季
     */
    private String squeezeSeason;

    /**
     * 物流单合同签订时间
     */
    private Date logisticsContractTime;

    /**
     * 销售货物名称
     */
    private String goodsName;

    /**
     * 物流合同总重量
     */
    private BigDecimal totalWeight;

    /**
     * 货物单位
     */
    private String goodsUnit;

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
        LogisticsPaymentContractView other = (LogisticsPaymentContractView) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getLogisticsContractNo() == null ? other.getLogisticsContractNo() == null : this.getLogisticsContractNo().equals(other.getLogisticsContractNo()))
            && (this.getPaymentCount() == null ? other.getPaymentCount() == null : this.getPaymentCount().equals(other.getPaymentCount()))
            && (this.getFinanceStaff() == null ? other.getFinanceStaff() == null : this.getFinanceStaff().equals(other.getFinanceStaff()))
            && (this.getFinanceState() == null ? other.getFinanceState() == null : this.getFinanceState().equals(other.getFinanceState()))
            && (this.getLogisticsPaymentDirector() == null ? other.getLogisticsPaymentDirector() == null : this.getLogisticsPaymentDirector().equals(other.getLogisticsPaymentDirector()))
            && (this.getCashier() == null ? other.getCashier() == null : this.getCashier().equals(other.getCashier()))
            && (this.getPaymentTime() == null ? other.getPaymentTime() == null : this.getPaymentTime().equals(other.getPaymentTime()))
            && (this.getPaymentPhoto() == null ? other.getPaymentPhoto() == null : this.getPaymentPhoto().equals(other.getPaymentPhoto()))
            && (this.getPaymentPhotoArray() == null ? other.getPaymentPhotoArray() == null : this.getPaymentPhotoArray().equals(other.getPaymentPhotoArray()))
            && (this.getCreateTime() == null ? other.getCreateTime() == null : this.getCreateTime().equals(other.getCreateTime()))
            && (this.getCreateBy() == null ? other.getCreateBy() == null : this.getCreateBy().equals(other.getCreateBy()))
            && (this.getLastUpdateTime() == null ? other.getLastUpdateTime() == null : this.getLastUpdateTime().equals(other.getLastUpdateTime()))
            && (this.getLastUpdateBy() == null ? other.getLastUpdateBy() == null : this.getLastUpdateBy().equals(other.getLastUpdateBy()))
            && (this.getSaleContractNo() == null ? other.getSaleContractNo() == null : this.getSaleContractNo().equals(other.getSaleContractNo()))
            && (this.getFreight() == null ? other.getFreight() == null : this.getFreight().equals(other.getFreight()))
            && (this.getSqueezeSeason() == null ? other.getSqueezeSeason() == null : this.getSqueezeSeason().equals(other.getSqueezeSeason()))
            && (this.getLogisticsContractTime() == null ? other.getLogisticsContractTime() == null : this.getLogisticsContractTime().equals(other.getLogisticsContractTime()))
            && (this.getGoodsName() == null ? other.getGoodsName() == null : this.getGoodsName().equals(other.getGoodsName()))
            && (this.getTotalWeight() == null ? other.getTotalWeight() == null : this.getTotalWeight().equals(other.getTotalWeight()))
            && (this.getGoodsUnit() == null ? other.getGoodsUnit() == null : this.getGoodsUnit().equals(other.getGoodsUnit()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getLogisticsContractNo() == null) ? 0 : getLogisticsContractNo().hashCode());
        result = prime * result + ((getPaymentCount() == null) ? 0 : getPaymentCount().hashCode());
        result = prime * result + ((getFinanceStaff() == null) ? 0 : getFinanceStaff().hashCode());
        result = prime * result + ((getFinanceState() == null) ? 0 : getFinanceState().hashCode());
        result = prime * result + ((getLogisticsPaymentDirector() == null) ? 0 : getLogisticsPaymentDirector().hashCode());
        result = prime * result + ((getCashier() == null) ? 0 : getCashier().hashCode());
        result = prime * result + ((getPaymentTime() == null) ? 0 : getPaymentTime().hashCode());
        result = prime * result + ((getPaymentPhoto() == null) ? 0 : getPaymentPhoto().hashCode());
        result = prime * result + ((getPaymentPhotoArray() == null) ? 0 : getPaymentPhotoArray().hashCode());
        result = prime * result + ((getCreateTime() == null) ? 0 : getCreateTime().hashCode());
        result = prime * result + ((getCreateBy() == null) ? 0 : getCreateBy().hashCode());
        result = prime * result + ((getLastUpdateTime() == null) ? 0 : getLastUpdateTime().hashCode());
        result = prime * result + ((getLastUpdateBy() == null) ? 0 : getLastUpdateBy().hashCode());
        result = prime * result + ((getSaleContractNo() == null) ? 0 : getSaleContractNo().hashCode());
        result = prime * result + ((getFreight() == null) ? 0 : getFreight().hashCode());
        result = prime * result + ((getSqueezeSeason() == null) ? 0 : getSqueezeSeason().hashCode());
        result = prime * result + ((getLogisticsContractTime() == null) ? 0 : getLogisticsContractTime().hashCode());
        result = prime * result + ((getGoodsName() == null) ? 0 : getGoodsName().hashCode());
        result = prime * result + ((getTotalWeight() == null) ? 0 : getTotalWeight().hashCode());
        result = prime * result + ((getGoodsUnit() == null) ? 0 : getGoodsUnit().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", logisticsContractNo=").append(logisticsContractNo);
        sb.append(", paymentCount=").append(paymentCount);
        sb.append(", financeStaff=").append(financeStaff);
        sb.append(", financeState=").append(financeState);
        sb.append(", logisticsPaymentDirector=").append(logisticsPaymentDirector);
        sb.append(", cashier=").append(cashier);
        sb.append(", paymentTime=").append(paymentTime);
        sb.append(", paymentPhoto=").append(paymentPhoto);
        sb.append(", paymentPhotoArray=").append(paymentPhotoArray);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", saleContractNo=").append(saleContractNo);
        sb.append(", freight=").append(freight);
        sb.append(", squeezeSeason=").append(squeezeSeason);
        sb.append(", logisticsContractTime=").append(logisticsContractTime);
        sb.append(", goodsName=").append(goodsName);
        sb.append(", totalWeight=").append(totalWeight);
        sb.append(", goodsUnit=").append(goodsUnit);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}