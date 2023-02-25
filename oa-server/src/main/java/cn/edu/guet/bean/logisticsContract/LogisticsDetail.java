package cn.edu.guet.bean.logisticsContract;

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
 * @TableName logistics_detail
 */
@TableName(value ="logistics_detail")
@Data
public class LogisticsDetail implements Serializable {
    /**
     * 主键id  自增
     */
    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 物流单合同编号（运输合同编号）
     */
    private String logisticsContractNo;

    /**
     * 采购合同编号
     */
    private String purchaseContractNo;

    /**
     * 取货厂名
     */
    private String goodsFactory;

    /**
     * 出库日期
     */
    private Date outboundTime;

    /**
     * 车牌号
     */
    private String licensePlateNumber;

    /**
     * 载货量
     */
    private BigDecimal goodsWeight;

    /**
     * 货物单位
     */
    private String goodsUnit;

    /**
     * 卸货地点
     */
    private String unloadingLocation;

    /**
     * 运输单价
     */
    private BigDecimal unitPrice;

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
     * 类型  0：加工单   1：采购单
     */
    private Integer upperType;

    /**
     * 计算方式【装货结算、卸货结算】
     */
    private String calculationMethod;

    /**
     * 些货量
     */
    private BigDecimal uploadingWeight;


}