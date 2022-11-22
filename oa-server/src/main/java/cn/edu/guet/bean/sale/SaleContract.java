package cn.edu.guet.bean.sale;

import cn.edu.guet.bean.customer.Customer;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
@TableName("sale_contract")
public class SaleContract {

    @TableId(value = "id",type = IdType.AUTO)
    private int id;
    //销售单合同编号
    private String saleContractNo;
    //客户表id
    private String saleCustomerId;
    //己方公司名
    private String ownCompanyName;
    //销售货物名称
    private String goodsName;
    //销售货物数量
    private BigDecimal goodsCount;
    //销售货物单位
    private String goodsUnit;
    //销售货物单价
    private BigDecimal goodsUnitPrice;
    //销售合同总价钱
    private BigDecimal goodsTotalPrice;
    //销售合同时间
    private Date saleContractTime;
    //结款方式
    private String paymentMethod;
    //运输方式
    private String transportMethod;
    //销售合同照片
    private String contractPhoto;
    //销售合同照片集合
    @TableField(exist = false)
    private List<String> contractPhotoList;
    //收款金额
    private BigDecimal revenueAmount;
    //收款时间
    private Date revenueTime;
    //收款流水截图
    private String revenuePhoto;
    //收款流水截图集合
    @TableField(exist = false)
    private List<String> revenuePhotoList;
    //出纳操作人姓名
    private String revenueBy;
    //归档  0表示隐藏  1表示显示
    private String pigeonhole;
    //榨季
    private String squeezeSeason;
    //创建时间
    private Date createTime;
    //创建者名称
    private String createBy;
    //最新更新时间
    private Date lastUpdateTime;
    //最新更新者名称
    private String lastUpdateBy;
    //客户，关联销售方公司
    @TableField(exist = false)
    private Customer customer;

}
