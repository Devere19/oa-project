package cn.edu.guet.bean.sale;

/**
 * @Author Devere19
 * @Date 2022/11/1 21:43
 * @Version 1.0
 */

import lombok.Data;

/**
 * 销售单分页查询封装Bean
 */
@Data
public class ListParm {
    private String saleContractNo;
    private String saleCompanyName;
    private String goodsName;
    private String squeezeSeason;
    private int currentPage;
    private int pageSize;
}
