package cn.edu.guet.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 
 * @TableName process_contract
 */
@TableName(value ="process_contract")
@Data
public class ProcessContract implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 加工合同编号
     */
    private String processContractNo;


    /**
     * 旧加工单合同编号
     * 前端传输，更新加工单所用
     */
    @TableField(exist = false)
    private String oldProcessContractNo;

    /**
     * 加工货物名称
     */
    private String goodsName;

    /**
     * 加工方公司名
     */
    private String customerEnterpriseName;

    /**
     * 己方公司名
     */
    private String ownCompanyName;

    /**
     * 酒精转换公式
     */
    private String alcoholConversionFormula;

    /**
     * 浓缩液转换公式
     */
    private String concentratedSolutionConversionFormula;

    /**
     * 合同签订时间
     */
    private Date signTime;

    /**
     * 合同照片
     */
    private String contractPhoto;

    /**
     * 前端数据传输*
     * 加工合同照片
     */
    @TableField(exist = false)
    private List<String> contractPhotoArray;

    /**
     * 更新加工单所用，标记是否只修改了图片
     * 1代表只改了图片 0则反之
     */
    @TableField(exist = false)
    private Integer onlyUpdatePhoto;

    /**
     * 归档 0表示隐藏  1表示显示
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
        ProcessContract other = (ProcessContract) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getProcessContractNo() == null ? other.getProcessContractNo() == null : this.getProcessContractNo().equals(other.getProcessContractNo()))
            && (this.getOldProcessContractNo() == null ? other.getOldProcessContractNo() == null : this.getOldProcessContractNo().equals(other.getOldProcessContractNo()))
            && (this.getGoodsName() == null ? other.getGoodsName() == null : this.getGoodsName().equals(other.getGoodsName()))
            && (this.getCustomerEnterpriseName() == null ? other.getCustomerEnterpriseName() == null : this.getCustomerEnterpriseName().equals(other.getCustomerEnterpriseName()))
            && (this.getOwnCompanyName() == null ? other.getOwnCompanyName() == null : this.getOwnCompanyName().equals(other.getOwnCompanyName()))
            && (this.getAlcoholConversionFormula() == null ? other.getAlcoholConversionFormula() == null : this.getAlcoholConversionFormula().equals(other.getAlcoholConversionFormula()))
            && (this.getConcentratedSolutionConversionFormula() == null ? other.getConcentratedSolutionConversionFormula() == null : this.getConcentratedSolutionConversionFormula().equals(other.getConcentratedSolutionConversionFormula()))
            && (this.getSignTime() == null ? other.getSignTime() == null : this.getSignTime().equals(other.getSignTime()))
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
        result = prime * result + ((getProcessContractNo() == null) ? 0 : getProcessContractNo().hashCode());
        result = prime * result + ((getOldProcessContractNo() == null) ? 0 : getOldProcessContractNo().hashCode());
        result = prime * result + ((getGoodsName() == null) ? 0 : getGoodsName().hashCode());
        result = prime * result + ((getCustomerEnterpriseName() == null) ? 0 : getCustomerEnterpriseName().hashCode());
        result = prime * result + ((getOwnCompanyName() == null) ? 0 : getOwnCompanyName().hashCode());
        result = prime * result + ((getAlcoholConversionFormula() == null) ? 0 : getAlcoholConversionFormula().hashCode());
        result = prime * result + ((getConcentratedSolutionConversionFormula() == null) ? 0 : getConcentratedSolutionConversionFormula().hashCode());
        result = prime * result + ((getSignTime() == null) ? 0 : getSignTime().hashCode());
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
        sb.append(", processContractNo=").append(processContractNo);
        sb.append(", oldProcessContractNo=").append(oldProcessContractNo);
        sb.append(", goodsName=").append(goodsName);
        sb.append(", customerEnterpriseName=").append(customerEnterpriseName);
        sb.append(", ownCompanyName=").append(ownCompanyName);
        sb.append(", alcoholConversionFormula=").append(alcoholConversionFormula);
        sb.append(", concentratedSolutionConversionFormula=").append(concentratedSolutionConversionFormula);
        sb.append(", signTime=").append(signTime);
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