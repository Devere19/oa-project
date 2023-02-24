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
 * @TableName cashier_shipping
 */
@TableName(value ="cashier_shipping")
@Data
public class CashierShipping implements Serializable {
    /**
     * 
     */
    private Integer id;

    /**
     * 海运单合同编号
     */
    private String shippingContractNo;

    /**
     * 物流单合同编号
     */
    private String logisticsContractNo;

    /**
     * 己方公司名称
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
     * 目的港承运车队费用
     */
    private BigDecimal destinationPortPrice;

    /**
     * 总费用
     */
    private BigDecimal expenses;

    /**
     * 合同照片
     */
    private String contractPhoto;

    /**
     * 财务名称
     */
    private String financeStaff;

    /**
     * 财务审核状态
     */
    private Integer financeState;

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
     * 
     */
    private String directorState;

    /**
     * 前端数据传输*
     * 海运合同照片
     */
    @TableField(exist = false)
    private List<String> contractPhotoArray;

    /**
     * 前端数据传输*
     * 付款流水截图
     */
    @TableField(exist = false)
    private List<String> paymentPhotoArray;

    /**
     * 董事审核数据*
     */
    @TableField(exist = false)
    private List<ShippingStateView> shippingDirector;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}