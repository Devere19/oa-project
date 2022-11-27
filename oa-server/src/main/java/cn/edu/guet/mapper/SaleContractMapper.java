package cn.edu.guet.mapper;

import cn.edu.guet.bean.sale.SaleContract;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/1 11:33
 * @Version 1.0
 */
@Mapper
public interface SaleContractMapper extends BaseMapper<SaleContract> {
    List<SaleContract> getTotalDayIncomeData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SaleContract> getTotalMonthIncomeData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SaleContract> getTotalSeasonIncomeData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SaleContract> getTotalYearIncomeData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    //    其中某公司
    List<SaleContract> getCompanyDayIncomeData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SaleContract> getCompanyMonthIncomeData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SaleContract> getCompanySeasonIncomeData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<SaleContract> getCompanyYearIncomeData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
}
