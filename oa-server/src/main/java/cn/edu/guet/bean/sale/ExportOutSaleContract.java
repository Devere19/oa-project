package cn.edu.guet.bean.sale;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.edu.guet.bean.customer.Customer;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/1 11:13
 * @Version 1.0
 */

/**
 * 销售单
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExportOutSaleContract {

    //销售单合同编号
    @Excel(name = "销售单合同编号")
    private String saleContractNo;
    //客户表id
    @Excel(name = "销售方公司名")
    private String customerFactory;
    //己方公司名
    @Excel(name = "己方公司名")
    private String ownCompanyName;
    //销售合同时间
    @Excel(name = "销售合同时间")
    private String saleContractTime;
    //销售货物名称
    @Excel(name = "销售货物名称")
    private String goodsName;
    //销售货物数量
    @Excel(name = "销售货物数量")
    private BigDecimal goodsCount;
    //销售货物单位
    @Excel(name = "销售货物单位")
    private String goodsUnit;
    //销售货物单价
    @Excel(name = "销售货物单价")
    private BigDecimal goodsUnitPrice;
    //销售合同总价钱
    @Excel(name = "销售合同总价钱")
    private BigDecimal goodsTotalPrice;
    //结款方式
    @Excel(name = "结款方式")
    private String paymentMethod;
    //运输方式
    @Excel(name = "运输方式")
    private String transportMethod;
    //收款金额
    @Excel(name = "收款金额")
    private BigDecimal revenueAmount;
    //收款时间
    @Excel(name = "收款时间")
    private Date revenueTime;
    //出纳操作人姓名
    @Excel(name = "出纳操作人姓名")
    private String revenueBy;
    //榨季
    @Excel(name = "榨季")
    private String squeezeSeason;
    //创建者名称
    @Excel(name = "创建者名称")
    private String createBy;


}
