package cn.edu.guet.bean.customer;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.Objects;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:16
 * @Version 1.0
 */

/**
 * 客户表
 * @author 陶祎祎
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
    private String createBy;
    //最近更新时间
    private Date lastUpdateTime;
    //最新更新着名称
    private String lastUpdateBy;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Customer customer = (Customer) o;
        return id == customer.id && Objects.equals(customerEnterpriseName, customer.customerEnterpriseName) && Objects.equals(customerName, customer.customerName) && Objects.equals(customerPhone, customer.customerPhone) && Objects.equals(customerAddress, customer.customerAddress) && Objects.equals(createTime, customer.createTime) && Objects.equals(createBy, customer.createBy) && Objects.equals(lastUpdateTime, customer.lastUpdateTime) && Objects.equals(lastUpdateBy, customer.lastUpdateBy);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, customerEnterpriseName, customerName, customerPhone, customerAddress, createTime, createBy, lastUpdateTime, lastUpdateBy);
    }

    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", customerEnterpriseName='" + customerEnterpriseName + '\'' +
                ", customerName='" + customerName + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", customerAddress='" + customerAddress + '\'' +
                ", createTime=" + createTime +
                ", createBy='" + createBy + '\'' +
                ", lastUpdateTime=" + lastUpdateTime +
                ", lastUpdateBy='" + lastUpdateBy + '\'' +
                '}';
    }
}
