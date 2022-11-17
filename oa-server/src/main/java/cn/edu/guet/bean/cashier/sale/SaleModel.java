package cn.edu.guet.bean.cashier.sale;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/17 19:48
 * @Version 1.0
 */
@Data
public class SaleModel {
    private int id;
    private Date revenueTime;
    private BigDecimal revenueAmount;
    private String revenuePhoto;
    private List<String> revenuePhotoList;
    private String revenueBy;
}
