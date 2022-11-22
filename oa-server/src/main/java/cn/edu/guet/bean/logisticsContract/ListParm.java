package cn.edu.guet.bean.logisticsContract;

/**
 * @Author Devere19
 * @Date 2022/11/7 17:42
 * @Version 1.0
 */

import lombok.Data;

import java.util.Date;

/**
 * 物流单查询列表
 */
@Data
public class ListParm {
    //物流单合同编号（运输合同编号）
    private String logisticsContractNo;
    //销售单合同编号
    private String saleContractNo;
    //榨季
    private String squeezeSeason;
    private Date startTime;
    private Date endTime;
    private int currentPage;
    private int pageSize;
}
