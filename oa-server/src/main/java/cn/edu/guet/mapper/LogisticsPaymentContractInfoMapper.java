package cn.edu.guet.mapper;

import cn.edu.guet.bean.LogisticsPaymentContractView;
import cn.edu.guet.bean.exportModel.ExportLogisticsPaymentModel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【logistics_payment_contract_info】的数据库操作Mapper
* @createDate 2022-11-12 21:15:26
* @Entity generator.bean.LogisticsPaymentContractInfo
*/
@Mapper
public interface LogisticsPaymentContractInfoMapper extends BaseMapper<LogisticsPaymentContractView> {
    //    导出所用
    List<ExportLogisticsPaymentModel> getLogisticsExportDayData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportLogisticsPaymentModel> getLogisticsExportMonthData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportLogisticsPaymentModel> getLogisticsExportSeasonData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportLogisticsPaymentModel> getLogisticsExportYearData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<ExportLogisticsPaymentModel> getLogisticsExportCompanyDayData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportLogisticsPaymentModel> getLogisticsExportCompanyMonthData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportLogisticsPaymentModel> getLogisticsExportCompanySeasonData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportLogisticsPaymentModel> getLogisticsExportCompanyYearData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
}




