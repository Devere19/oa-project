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
 * @author 陶祎祎
 * @TableName cashier_purchase_payment
 */
@TableName(value ="cashier_purchase_payment")
@Data
public class CashierPurchasePayment implements Serializable {
    /**
     * 采购付款单ID
     */
    private Integer id;

    /**
     * 采购单合同编号
     */
    private String purchaseContractNo;

    /**
     * 本次付款金额
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
     * 供货商公司名
     */
    private String customerEnterpriseName;

    /**
     * 己方公司名
     */
    private String ownCompanyName;

    /**
     * 榨季
     */
    private String squeezeSeason;

    /**
     * 入库时间（合同实际签订时间）
     */
    private Date inboundTime;

    /**
     * 采购货物名称
     */
    private String goodsName;

    /**
     * 采购货物数量
     */
    private BigDecimal goodsCount;

    /**
     * 采购货物单位
     */
    private String goodsUnit;

    /**
     * 采购总金额
     */
    private BigDecimal paymentAmount;

    /**
     * 
     */
    private String directorState;

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
    private List<PurchasePaymentStateView> purchasePaymentDirector;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}