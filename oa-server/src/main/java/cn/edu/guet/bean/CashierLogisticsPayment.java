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
 * @TableName cashier_logistics_payment
 */
@TableName(value ="cashier_logistics_payment")
@Data
public class CashierLogisticsPayment implements Serializable {
    /**
     * 物流付款单ID
     */
    private Integer id;

    /**
     * 物流单合同编号
     */
    private String logisticsContractNo;

    /**
     * 出纳名称
     */
    private String cashier;

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
     * 销售单/加工单合同编号
     */
    private String saleContractNo;

    /**
     * 己方公司名称
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
     * 货物名称
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
    private List<LogisticsPaymentStateView> logisticsPaymentDirector;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}