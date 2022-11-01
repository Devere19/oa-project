package cn.edu.guet.bean.customer;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:16
 * @Version 1.0
 */

/**
 * 客户表
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("customer")
public class Customer {
    //客户表主键
    @TableId(type = IdType.AUTO)
    private int id;
    //公司名称
    private String customerEnterpriseName;
    //联系人
    private String customerName;
    //联系方式
    private String customerPhone;
    //邮寄地址
    private String customerAddress;
    //创建时间
    private Date createTime;
    //创建者名称
    private String createby;
    //最近更新时间
    private Date lastUpdateTime;
    //最新更新着名称
    private String lastUpdateBy;
}
