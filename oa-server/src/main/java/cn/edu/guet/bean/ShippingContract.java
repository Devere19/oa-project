package cn.edu.guet.bean;

import cn.afterturn.easypoi.excel.annotation.Excel;
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
 * @author 陶祎祎
 * @TableName shipping_contract
 */
@TableName(value ="shipping_contract")
@Data
public class ShippingContract implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 海运单合同编号
     */
    private String shippingContractNo;


    /**
     * 旧海运单合同编号
     * 前端传输，更新海运单所用
     */
    @TableField(exist = false)
    private String oldShippingContractNo;

    /**
     * 物流单合同编号
     */
    private String logisticsContractNo;

    /**
     * 己方公司名
     */
    private String ownCompanyName;

    /**
     * 委托方
     */
    private String principal;

    /**
     * 装箱日期
     */
    private Date packingTime;

    /**
     * 装箱地点
     */
    private String packingLocation;

    /**
     * 卸箱工厂
     */
    private String unpackingFactory;

    /**
     * 集装箱号1
     */
    private String firstContainerNo;

    /**
     * 集装箱号2
     */
    private String secondContainerNo;

    /**
     * 铅封号1
     */
    private String firstSealNo;

    /**
     * 铅封号2
     */
    private String secondSealNo;

    /**
     * 毛重
     */
    private BigDecimal rough;

    /**
     * 皮重
     */
    private BigDecimal tare;

    /**
     * 净重
     */
    private BigDecimal suttle;

    /**
     * 理货员
     */
    private String tallyClerk;

    /**
     * 理货费用
     */
    private BigDecimal tallyClerkPrice;

    /**
     * 理货费用备注
     */
    private String tallyClerkRemark;

    /**
     * 车队管理名称
     */
    private String fleetManageName;

    /**
     * 起运承运车队
     */
    private String departureFleet;

    /**
     * 起运承运车队费用
     */
    private BigDecimal departurePrice;

    /**
     * 承运船公司
     */
    private String carrierCompanyName;

    /**
     * 承运船公司费用
     */
    private BigDecimal carrierCompanyPrice;

    /**
     * 目的港承运车队
     */
    private String destinationPortFleet;

    /**
     * 总费用
     */
    private BigDecimal expenses;

    /**
     * 目的港承运车队费用
     */
    private BigDecimal destinationPortPrice;

    /**
     * 合同照片
     */
    private String contractPhoto;

    /**
     * 前端数据传输*
     * 海运合同照片
     */
    @TableField(exist = false)
    private List<String> contractPhotoArray;

    /**
     * 更新海运单所用，标记是否只修改了图片
     * 1代表只改了图片 0则反之
     */
    @TableField(exist = false)
    private Integer onlyUpdatePhoto;

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
    private List<ShippingStateView> shippingDirector;

    /**
     * 出纳名称
     */
    private String cashier;

    /**
     * 付款金额
     */
    private BigDecimal paymentCount;

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
        ShippingContract other = (ShippingContract) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getShippingContractNo() == null ? other.getShippingContractNo() == null : this.getShippingContractNo().equals(other.getShippingContractNo()))
            && (this.getOldShippingContractNo() == null ? other.getOldShippingContractNo() == null : this.getOldShippingContractNo().equals(other.getOldShippingContractNo()))
            && (this.getLogisticsContractNo() == null ? other.getLogisticsContractNo() == null : this.getLogisticsContractNo().equals(other.getLogisticsContractNo()))
            && (this.getOwnCompanyName() == null ? other.getOwnCompanyName() == null : this.getOwnCompanyName().equals(other.getOwnCompanyName()))
            && (this.getPrincipal() == null ? other.getPrincipal() == null : this.getPrincipal().equals(other.getPrincipal()))
            && (this.getPackingTime() == null ? other.getPackingTime() == null : this.getPackingTime().equals(other.getPackingTime()))
            && (this.getPackingLocation() == null ? other.getPackingLocation() == null : this.getPackingLocation().equals(other.getPackingLocation()))
            && (this.getUnpackingFactory() == null ? other.getUnpackingFactory() == null : this.getUnpackingFactory().equals(other.getUnpackingFactory()))
            && (this.getFirstContainerNo() == null ? other.getFirstContainerNo() == null : this.getFirstContainerNo().equals(other.getFirstContainerNo()))
            && (this.getSecondContainerNo() == null ? other.getSecondContainerNo() == null : this.getSecondContainerNo().equals(other.getSecondContainerNo()))
            && (this.getFirstSealNo() == null ? other.getFirstSealNo() == null : this.getFirstSealNo().equals(other.getFirstSealNo()))
            && (this.getSecondSealNo() == null ? other.getSecondSealNo() == null : this.getSecondSealNo().equals(other.getSecondSealNo()))
            && (this.getTallyClerk() == null ? other.getTallyClerk() == null : this.getTallyClerk().equals(other.getTallyClerk()))
            && (this.getTallyClerkPrice() == null ? other.getTallyClerkPrice() == null : this.getTallyClerkPrice().equals(other.getTallyClerkPrice()))
            && (this.getDepartureFleet() == null ? other.getDepartureFleet() == null : this.getDepartureFleet().equals(other.getDepartureFleet()))
            && (this.getDeparturePrice() == null ? other.getDeparturePrice() == null : this.getDeparturePrice().equals(other.getDeparturePrice()))
            && (this.getCarrierCompanyName() == null ? other.getCarrierCompanyName() == null : this.getCarrierCompanyName().equals(other.getCarrierCompanyName()))
            && (this.getCarrierCompanyPrice() == null ? other.getCarrierCompanyPrice() == null : this.getCarrierCompanyPrice().equals(other.getCarrierCompanyPrice()))
            && (this.getDestinationPortFleet() == null ? other.getDestinationPortFleet() == null : this.getDestinationPortFleet().equals(other.getDestinationPortFleet()))
            && (this.getExpenses() == null ? other.getExpenses() == null : this.getExpenses().equals(other.getExpenses()))
            && (this.getDestinationPortPrice() == null ? other.getDestinationPortPrice() == null : this.getDestinationPortPrice().equals(other.getDestinationPortPrice()))
            && (this.getContractPhoto() == null ? other.getContractPhoto() == null : this.getContractPhoto().equals(other.getContractPhoto()))
            && (this.getContractPhotoArray() == null ? other.getContractPhotoArray() == null : this.getContractPhotoArray().equals(other.getContractPhotoArray()))
            && (this.getFinanceStaff() == null ? other.getFinanceStaff() == null : this.getFinanceStaff().equals(other.getFinanceStaff()))
            && (this.getFinanceState() == null ? other.getFinanceState() == null : this.getFinanceState().equals(other.getFinanceState()))
            && (this.getShippingDirector() == null ? other.getShippingDirector() == null : this.getShippingDirector().equals(other.getShippingDirector()))
            && (this.getCashier() == null ? other.getCashier() == null : this.getCashier().equals(other.getCashier()))
            && (this.getPaymentCount() == null ? other.getPaymentCount() == null : this.getPaymentCount().equals(other.getPaymentCount()))
            && (this.getPaymentTime() == null ? other.getPaymentTime() == null : this.getPaymentTime().equals(other.getPaymentTime()))
            && (this.getPaymentPhoto() == null ? other.getPaymentPhoto() == null : this.getPaymentPhoto().equals(other.getPaymentPhoto()))
            && (this.getPaymentPhotoArray() == null ? other.getPaymentPhotoArray() == null : this.getPaymentPhotoArray().equals(other.getPaymentPhotoArray()))
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
        result = prime * result + ((getShippingContractNo() == null) ? 0 : getShippingContractNo().hashCode());
        result = prime * result + ((getOldShippingContractNo() == null) ? 0 : getOldShippingContractNo().hashCode());
        result = prime * result + ((getLogisticsContractNo() == null) ? 0 : getLogisticsContractNo().hashCode());
        result = prime * result + ((getOwnCompanyName() == null) ? 0 : getOwnCompanyName().hashCode());
        result = prime * result + ((getPrincipal() == null) ? 0 : getPrincipal().hashCode());
        result = prime * result + ((getPackingTime() == null) ? 0 : getPackingTime().hashCode());
        result = prime * result + ((getPackingLocation() == null) ? 0 : getPackingLocation().hashCode());
        result = prime * result + ((getUnpackingFactory() == null) ? 0 : getUnpackingFactory().hashCode());
        result = prime * result + ((getFirstContainerNo() == null) ? 0 : getFirstContainerNo().hashCode());
        result = prime * result + ((getSecondContainerNo() == null) ? 0 : getSecondContainerNo().hashCode());
        result = prime * result + ((getFirstSealNo() == null) ? 0 : getFirstSealNo().hashCode());
        result = prime * result + ((getSecondSealNo() == null) ? 0 : getSecondSealNo().hashCode());
        result = prime * result + ((getTallyClerk() == null) ? 0 : getTallyClerk().hashCode());
        result = prime * result + ((getTallyClerkPrice() == null) ? 0 : getTallyClerkPrice().hashCode());
        result = prime * result + ((getDepartureFleet() == null) ? 0 : getDepartureFleet().hashCode());
        result = prime * result + ((getDeparturePrice() == null) ? 0 : getDeparturePrice().hashCode());
        result = prime * result + ((getCarrierCompanyName() == null) ? 0 : getCarrierCompanyName().hashCode());
        result = prime * result + ((getCarrierCompanyPrice() == null) ? 0 : getCarrierCompanyPrice().hashCode());
        result = prime * result + ((getDestinationPortFleet() == null) ? 0 : getDestinationPortFleet().hashCode());
        result = prime * result + ((getExpenses() == null) ? 0 : getExpenses().hashCode());
        result = prime * result + ((getDestinationPortPrice() == null) ? 0 : getDestinationPortPrice().hashCode());
        result = prime * result + ((getContractPhoto() == null) ? 0 : getContractPhoto().hashCode());
        result = prime * result + ((getContractPhotoArray() == null) ? 0 : getContractPhotoArray().hashCode());
        result = prime * result + ((getFinanceStaff() == null) ? 0 : getFinanceStaff().hashCode());
        result = prime * result + ((getFinanceState() == null) ? 0 : getFinanceState().hashCode());
        result = prime * result + ((getShippingDirector() == null) ? 0 : getShippingDirector().hashCode());
        result = prime * result + ((getCashier() == null) ? 0 : getCashier().hashCode());
        result = prime * result + ((getPaymentCount() == null) ? 0 : getPaymentCount().hashCode());
        result = prime * result + ((getPaymentTime() == null) ? 0 : getPaymentTime().hashCode());
        result = prime * result + ((getPaymentPhoto() == null) ? 0 : getPaymentPhoto().hashCode());
        result = prime * result + ((getPaymentPhotoArray() == null) ? 0 : getPaymentPhotoArray().hashCode());
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
        sb.append(", shippingContractNo=").append(shippingContractNo);
        sb.append(", oldShippingContractNo=").append(oldShippingContractNo);
        sb.append(", logisticsContractNo=").append(logisticsContractNo);
        sb.append(", ownCompanyName=").append(ownCompanyName);
        sb.append(", principal=").append(principal);
        sb.append(", packingTime=").append(packingTime);
        sb.append(", packingLocation=").append(packingLocation);
        sb.append(", unpackingFactory=").append(unpackingFactory);
        sb.append(", firstContainerNo=").append(firstContainerNo);
        sb.append(", secondContainerNo=").append(secondContainerNo);
        sb.append(", firstSealNo=").append(firstSealNo);
        sb.append(", secondSealNo=").append(secondSealNo);
        sb.append(", tallyClerk=").append(tallyClerk);
        sb.append(", tallyClerkPrice=").append(tallyClerkPrice);
        sb.append(", departureFleet=").append(departureFleet);
        sb.append(", departurePrice=").append(departurePrice);
        sb.append(", carrierCompanyName=").append(carrierCompanyName);
        sb.append(", carrierCompanyPrice=").append(carrierCompanyPrice);
        sb.append(", destinationPortFleet=").append(destinationPortFleet);
        sb.append(", expenses=").append(expenses);
        sb.append(", destinationPortPrice=").append(destinationPortPrice);
        sb.append(", contractPhoto=").append(contractPhoto);
        sb.append(", contractPhotoArray=").append(contractPhotoArray);
        sb.append(", financeStaff=").append(financeStaff);
        sb.append(", financeState=").append(financeState);
        sb.append(", shippingDirector=").append(shippingDirector);
        sb.append(", cashier=").append(cashier);
        sb.append(", paymentCount=").append(paymentCount);
        sb.append(", paymentTime=").append(paymentTime);
        sb.append(", paymentPhoto=").append(paymentPhoto);
        sb.append(", paymentPhotoArray=").append(paymentPhotoArray);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}