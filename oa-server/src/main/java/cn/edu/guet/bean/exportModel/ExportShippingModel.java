package cn.edu.guet.bean.exportModel;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 陶祎祎
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExportShippingModel {
    /**
     * 海运单合同编号
     */
    @Excel(name = "海运单合同编号")
    private String shippingContractNo;

    /**
     * 物流单合同编号
     */
    @Excel(name = "物流单合同编号")
    private String logisticsContractNo;

    /**
     * 总费用
     */
    @Excel(name = "总费用")
    private BigDecimal expenses;

    /**
     * 付款金额
     */
    @Excel(name = "付款金额")
    private BigDecimal paymentCount;

    /**
     * 付款时间
     */
    @Excel(name = "付款时间",format = "yyyy-MM-dd",width = 11)
    private Date paymentTime;

    /**
     * 财务名称
     */
    @Excel(name = "财务名称")
    private String financeStaff;

    /**
     * 出纳名称
     */
    @Excel(name = "出纳名称")
    private String cashier;

    /**
     * 己方公司名
     */
    @Excel(name = "己方公司名")
    private String ownCompanyName;

    /**
     * 委托方
     */
    @Excel(name = "委托方")
    private String principal;

    /**
     * 装箱日期
     */
    @Excel(name = "装箱日期",format = "yyyy-MM-dd",width = 11)
    private Date packingTime;

    /**
     * 装箱地点
     */
    @Excel(name = "装箱地点")
    private String packingLocation;

    /**
     * 卸箱工厂
     */
    @Excel(name = "卸箱工厂")
    private String unpackingFactory;

    /**
     * 集装箱号1
     */
    @Excel(name = "集装箱号1")
    private String firstContainerNo;

    /**
     * 集装箱号2
     */
    @Excel(name = "集装箱号2")
    private String secondContainerNo;

    /**
     * 铅封号1
     */
    @Excel(name = "铅封号1")
    private String firstSealNo;

    /**
     * 铅封号2
     */
    @Excel(name = "铅封号2")
    private String secondSealNo;

    /**
     * 毛重
     */
    @Excel(name = "毛重")
    private BigDecimal rough;

    /**
     * 皮重
     */
    @Excel(name = "皮重")
    private BigDecimal tare;

    /**
     * 净重
     */
    @Excel(name = "净重")
    private BigDecimal suttle;

    /**
     * 理货员
     */
    @Excel(name = "理货员")
    private String tallyClerk;

    /**
     * 理货费用
     */
    @Excel(name = "理货费用")
    private BigDecimal tallyClerkPrice;

    /**
     * 理货费用备注
     */
    @Excel(name = "理货费用备注")
    private String tallyClerkRemark;

    /**
     * 车队管理名称
     */
    @Excel(name = "车队管理名称")
    private String fleetManageName;

    /**
     * 起运承运车队
     */
    @Excel(name = "起运承运车队")
    private String departureFleet;

    /**
     * 起运承运车队费用
     */
    @Excel(name = "起运承运车队费用")
    private BigDecimal departurePrice;

    /**
     * 承运船公司
     */
    @Excel(name = "承运船公司")
    private String carrierCompanyName;

    /**
     * 承运船公司费用
     */
    @Excel(name = "承运船公司费用")
    private BigDecimal carrierCompanyPrice;

    /**
     * 目的港承运车队
     */
    @Excel(name = "目的港承运车队")
    private String destinationPortFleet;

    /**
     * 目的港承运车队费用
     */
    @Excel(name = "目的港承运车队费用")
    private BigDecimal destinationPortPrice;

}
