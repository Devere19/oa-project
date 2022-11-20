package cn.edu.guet.mapper;


import cn.edu.guet.bean.TotalIncomeSpendView;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【total_income_spend_info】的数据库操作Mapper
* @createDate 2022-11-17 10:57:58
* @Entity generator.bean.TotalIncomeSpendView
*/
@Mapper
public interface TotalIncomeSpendInfoMapper extends BaseMapper<TotalIncomeSpendView> {
    List<TotalIncomeSpendView> getTotalDayIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getTotalMonthIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getTotalSeasonIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getTotalYearIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
//    办公经费
    List<TotalIncomeSpendView> getTotalDayOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getTotalMonthOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getTotalSeasonOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getTotalYearOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
}




