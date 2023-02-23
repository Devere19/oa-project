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
 * @TableName cashier_office_expense
 */
@TableName(value ="cashier_office_expense")
@Data
public class CashierOfficeExpense implements Serializable {
    /**
     * 办公经费单ID
     */
    private Integer id;

    /**
     * 支出项目清单
     */
    private String itemsList;

    /**
     * 支出金额总计
     */
    private BigDecimal expenses;

    /**
     * 日期
     */
    private Date time;

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
     * 付款流水截图
     */
    @TableField(exist = false)
    private List<String> paymentPhotoArray;

    /**
     * 董事审核数据*
     */
    @TableField(exist = false)
    private List<OfficeStateView> officeDirector;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}