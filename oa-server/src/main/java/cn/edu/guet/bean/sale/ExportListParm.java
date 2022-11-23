package cn.edu.guet.bean.sale;

/**
 * @Author Devere19
 * @Date 2022/11/1 21:43
 * @Version 1.0
 */

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 导出查询bean
 */
@Data
public class ExportListParm implements Serializable {
    //销售单合同号
    private String saleContractNo;
    //销售方公司名称
    private String saleCompanyName;
    //货物名称
    private String goodsName;
    //榨季
    private String squeezeSeason;
    //起止时间
    private Date startTime;

    private Date endTime;

    private String isPigeonhole;
}
