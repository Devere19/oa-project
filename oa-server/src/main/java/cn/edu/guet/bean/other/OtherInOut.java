package cn.edu.guet.bean.other;

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
 * @TableName other_in_out
 */
@TableName(value ="other_in_out")
@Data
public class OtherInOut implements Serializable {
    /**
     * 外商仓库出入库流水ID
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 外商仓库ID
     */
    private Integer otherWarehouseId;

    /**
     * 出入库类型（出库0，入库1）
     */
    private Integer inOutType;

    /**
     * 采购合同编号/销售合同编号
     */
    private String inOutContractNo;

    /**
     * 出入库货物名称
     */
    private String inOutGoodsName;

    /**
     * 出入库货物数量
     */
    private BigDecimal inOutGoodsCount;

    /**
     * 出入库货物单位
     */
    private String inOutGoodsUnit;

    /**
     * 出入库单价（采购货物单价）
     */
    private BigDecimal inOutGoodsUnitPrice;

    /**
     * 出入库日期
     */
    private Date inOutTime;

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
        OtherInOut other = (OtherInOut) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getOtherWarehouseId() == null ? other.getOtherWarehouseId() == null : this.getOtherWarehouseId().equals(other.getOtherWarehouseId()))
            && (this.getInOutType() == null ? other.getInOutType() == null : this.getInOutType().equals(other.getInOutType()))
            && (this.getInOutContractNo() == null ? other.getInOutContractNo() == null : this.getInOutContractNo().equals(other.getInOutContractNo()))
            && (this.getInOutGoodsName() == null ? other.getInOutGoodsName() == null : this.getInOutGoodsName().equals(other.getInOutGoodsName()))
            && (this.getInOutGoodsCount() == null ? other.getInOutGoodsCount() == null : this.getInOutGoodsCount().equals(other.getInOutGoodsCount()))
            && (this.getInOutGoodsUnit() == null ? other.getInOutGoodsUnit() == null : this.getInOutGoodsUnit().equals(other.getInOutGoodsUnit()))
            && (this.getInOutTime() == null ? other.getInOutTime() == null : this.getInOutTime().equals(other.getInOutTime()))
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
        result = prime * result + ((getOtherWarehouseId() == null) ? 0 : getOtherWarehouseId().hashCode());
        result = prime * result + ((getInOutType() == null) ? 0 : getInOutType().hashCode());
        result = prime * result + ((getInOutContractNo() == null) ? 0 : getInOutContractNo().hashCode());
        result = prime * result + ((getInOutGoodsName() == null) ? 0 : getInOutGoodsName().hashCode());
        result = prime * result + ((getInOutGoodsCount() == null) ? 0 : getInOutGoodsCount().hashCode());
        result = prime * result + ((getInOutGoodsUnit() == null) ? 0 : getInOutGoodsUnit().hashCode());
        result = prime * result + ((getInOutTime() == null) ? 0 : getInOutTime().hashCode());
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
        sb.append(", otherWarehouseId=").append(otherWarehouseId);
        sb.append(", inOutType=").append(inOutType);
        sb.append(", inOutContractNo=").append(inOutContractNo);
        sb.append(", inOutGoodsName=").append(inOutGoodsName);
        sb.append(", inOutGoodsCount=").append(inOutGoodsCount);
        sb.append(", inOutGoodsUnit=").append(inOutGoodsUnit);
        sb.append(", inOutTime=").append(inOutTime);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", lastUpdateTime=").append(lastUpdateTime);
        sb.append(", lastUpdateBy=").append(lastUpdateBy);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}