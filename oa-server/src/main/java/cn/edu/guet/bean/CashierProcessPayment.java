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
 * @TableName cashier_process_payment
 */
@TableName(value ="cashier_process_payment")
@Data
public class CashierProcessPayment implements Serializable {
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
     * 加工付款单ID
     */
    private Integer id;

    /**
     * 加工单合同编号
     */
    private String processContractNo;

    /**
     * 付款月份
     */
    private String paymentMonth;

    /**
     * 付款月加工单价/斤
     */
    private BigDecimal paymentMonthPriceG;

    /**
     * 付款月加工单价/吨
     */
    private BigDecimal paymentMonthPriceT;

    /**
     * 付款月加工总量
     */
    private BigDecimal goodsCount;

    /**
     * 加工货物单位
     */
    private String goodsUnit;

    /**
     * 出纳名称
     */
    private String cashier;

    /**
     * 总费用金额
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
    private String directorId;

    /**
     * 
     */
    private String directorState;

    /**
     *
     */
    private String concatDirectorState;

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
    private List<ProcessPaymentStateView> processPaymentDirector;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}