package cn.edu.guet.bean;

import lombok.Data;

/**
 * @author 陶祎祎
 */
@Data
public class IncomeSpendExportParams {
    private String dataType;

    private String dataCompany;

    private Integer timeType;

    private String chooseDate;

    @Override
    public String toString() {
        return "IncomeSpendExportParams{" +
                "dataType='" + dataType + '\'' +
                ", dataCompany='" + dataCompany + '\'' +
                ", timeType=" + timeType +
                ", chooseDate='" + chooseDate + '\'' +
                '}';
    }
}
