package cn.edu.guet.mapper;

import cn.edu.guet.bean.FfsIncomeSpendView;
import cn.edu.guet.bean.JtIncomeSpendView;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【ffs_income_spend_info】的数据库操作Mapper
* @createDate 2022-11-17 14:27:25
* @Entity generator.bean.FfsIncomeSpendView
*/
@Mapper
public interface FfsIncomeSpendInfoMapper extends BaseMapper<FfsIncomeSpendView> {
    List<FfsIncomeSpendView> getFfsDayIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<FfsIncomeSpendView> getFfsMonthIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<FfsIncomeSpendView> getFfsSeasonIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<FfsIncomeSpendView> getFfsYearIncomeSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
}



