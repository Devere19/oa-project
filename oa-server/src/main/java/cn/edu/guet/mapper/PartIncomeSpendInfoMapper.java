package cn.edu.guet.mapper;

import cn.edu.guet.bean.TotalIncomeSpendView;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
*/
@Mapper
public interface PartIncomeSpendInfoMapper extends BaseMapper<TotalIncomeSpendView> {
    List<TotalIncomeSpendView> getFirstDayIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getFirstMonthIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getFirstSeasonIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getFirstYearIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<TotalIncomeSpendView> getSecondDayIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getSecondMonthIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getSecondSeasonIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getSecondYearIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<TotalIncomeSpendView> getThirdDayIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getThirdMonthIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getThirdSeasonIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getThirdYearIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<TotalIncomeSpendView> getFourthDayIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getFourthMonthIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getFourthSeasonIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<TotalIncomeSpendView> getFourthYearIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
}




