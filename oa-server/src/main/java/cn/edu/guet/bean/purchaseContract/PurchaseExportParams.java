package cn.edu.guet.bean.purchaseContract;

import lombok.Data;

import java.sql.Date;

/**
 * @author 陶祎祎
 */
@Data
public class PurchaseExportParams {
    private String searchWord;

    private boolean showPigeonhole;

    private Date startDate;

    private Date endDate;

    @Override
    public String toString() {
        return "PurchaseExportParams{" +
                "searchWord='" + searchWord + '\'' +
                ", showPigeonhole=" + showPigeonhole +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                '}';
    }
}
