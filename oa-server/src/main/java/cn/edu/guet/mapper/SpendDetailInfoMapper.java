package cn.edu.guet.mapper;

import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.bean.SpendDetailView;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【spend_detail_info】的数据库操作Mapper
* @createDate 2022-11-26 12:24:21
* @Entity generator.bean.SpendDetailView
*/
@Mapper
public interface SpendDetailInfoMapper extends BaseMapper<SpendDetailView> {
//    总体
    List<SpendDetailView> getTotalDaySpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SpendDetailView> getTotalMonthSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SpendDetailView> getTotalSeasonSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SpendDetailView> getTotalYearSpendData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    //    其中某公司
    List<SpendDetailView> getCompanyDaySpendData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SpendDetailView> getCompanyMonthSpendData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SpendDetailView> getCompanySeasonSpendData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SpendDetailView> getCompanyYearSpendData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);

    //    总体
    List<OfficeExpense> getDayOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<OfficeExpense> getMonthOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<OfficeExpense> getSeasonOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<OfficeExpense> getYearOfficeExpenseData(@Param("startDate")String startDate, @Param("endDate")String endDate);
}




