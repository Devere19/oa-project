package cn.edu.guet.service;

import cn.edu.guet.bean.TotalIncomeSpendView;
import com.baomidou.mybatisplus.extension.service.IService;

import java.sql.Date;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【total_income_spend_info】的数据库操作Service
* @createDate 2022-11-17 10:57:58
*/
public interface IncomeSpendInfoService extends IService<TotalIncomeSpendView> {
    List getChartIncomeSpendData(String dataType, String dataCompany, int timeType, String startDate, String endDate);
    List getNumberIncomeSpendData(String dataType, String dataCompany);
}
