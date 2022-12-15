package cn.edu.guet.mapper;

import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.bean.exportModel.ExportOfficeExpenseModel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【office_expense】的数据库操作Mapper
* @createDate 2022-11-19 13:16:22
* @Entity generator.bean.OfficeExpense
*/
@Mapper
public interface OfficeExpenseMapper extends BaseMapper<OfficeExpense> {
    //    导出所用
    List<ExportOfficeExpenseModel> getOfficeExpenseExportDayData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportOfficeExpenseModel> getOfficeExpenseExportMonthData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportOfficeExpenseModel> getOfficeExpenseExportSeasonData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportOfficeExpenseModel> getOfficeExpenseExportYearData(@Param("startDate")String startDate, @Param("endDate")String endDate);
}




