package cn.edu.guet.bean.purchaseContract;

import lombok.Data;

import java.sql.Date;

/**
 * @author 陶祎祎
 */
@Data
public class PurchaseExportModel {
    private String searchWord;

    private boolean showPigeonhole;

    private Date startDate;

    private Date endDate;
}
