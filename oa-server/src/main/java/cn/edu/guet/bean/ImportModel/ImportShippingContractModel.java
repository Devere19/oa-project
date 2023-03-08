package cn.edu.guet.bean.ImportModel;

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
@AllArgsConstructor
@NoArgsConstructor
public class ImportShippingContractModel {

    /**
     * 海运合同编号
     */
    @ExcelProperty(value = "海运合同编号")
    private String shippingContractNo;

    /**
     * 物流合同编号
     */
    @ExcelProperty(value = "物流合同编号")
    private String logisticsContractNo;

    /**
     * 己方公司名
     */
    @ExcelProperty(value = "己方公司名")
    private String ownCompanyName;

    /**
     * 委托方
     */
    @ExcelProperty(value = "委托方")
    private String principal;

    /**
     * 装箱日期
     */
    @ExcelProperty(value = "装箱日期（格式为xxxx-xx-xx）")
    private Date packingTime;

    /**
     * 装箱地点
     */
    @ExcelProperty(value = "装箱地点")
    private String packingLocation;

    /**
     * 卸箱工厂
     */
    @ExcelProperty(value = "卸箱工厂")
    private String unpackingFactory;

    /**
     * 集装箱号1
     */
    @ExcelProperty(value = "集装箱号1")
    private String firstContainerNo;

    /**
     * 铅封号1
     */
    @ExcelProperty(value = "铅封号1")
    private String firstSealNo;

    /**
     * 集装箱号2
     */
    @ExcelProperty(value = "集装箱号2")
    private String secondContainerNo;

    /**
     * 铅封号2
     */
    @ExcelProperty(value = "铅封号2")
    private String secondSealNo;

    /**
     * 毛重
     */
    @ExcelProperty(value = "毛重")
    private BigDecimal rough;

    /**
     * 皮重
     */
    @ExcelProperty(value = "皮重")
    private BigDecimal tare;

    /**
     * 净重
     */
    @ExcelProperty(value = "净重")
    private BigDecimal suttle;

    /**
     * 理货员
     */
    @ExcelProperty(value = "理货员")
    private String tallyClerk;

    /**
     * 理货费用
     */
    @ExcelProperty(value = "理货费用")
    private BigDecimal tallyClerkPrice;

    /**
     * 理货费用备注
     */
    @ExcelProperty(value = "理货费用备注")
    private String tallyClerkRemark;

    /**
     * 车队管理名称
     */
    @ExcelProperty(value = "车队管理名称")
    private String fleetManageName;

    /**
     * 起运承运车队
     */
    @ExcelProperty(value = "起运承运车队")
    private String departureFleet;

    /**
     * 起运承运车队费用
     */
    @ExcelProperty(value = "起运承运车队费用(元)")
    private BigDecimal departurePrice;

    /**
     * 承运船公司
     */
    @ExcelProperty(value = "承运船公司")
    private String carrierCompanyName;

    /**
     * 承运船公司费用
     */
    @ExcelProperty(value = "承运船公司费用(元)")
    private BigDecimal carrierCompanyPrice;

    /**
     * 目的港承运车队
     */
    @ExcelProperty(value = "目的港承运车队")
    private String destinationPortFleet;

    /**
     * 目的港承运车队费用
     */
    @ExcelProperty(value = "目的港承运车队费用(元)")
    private BigDecimal destinationPortPrice;

    /**
     * 总费用
     */
    @ExcelProperty(value = "总费用(元)")
    private BigDecimal expenses;

}