package cn.edu.guet.mapper;

import cn.edu.guet.bean.ProcessPaymentContractView;
import cn.edu.guet.bean.exportModel.ExportProcessPaymentModel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【process_payment_contract_info】的数据库操作Mapper
* @createDate 2022-12-11 20:43:57
* @Entity generator.bean.ProcessPaymentContractView
*/
@Mapper
public interface ProcessPaymentContractInfoMapper extends BaseMapper<ProcessPaymentContractView> {
    //    导出所用
    List<ExportProcessPaymentModel> getProcessExportDayData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportProcessPaymentModel> getProcessExportMonthData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportProcessPaymentModel> getProcessExportSeasonData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportProcessPaymentModel> getProcessExportYearData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<ExportProcessPaymentModel> getProcessExportCompanyDayData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportProcessPaymentModel> getProcessExportCompanyMonthData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportProcessPaymentModel> getProcessExportCompanySeasonData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportProcessPaymentModel> getProcessExportCompanyYearData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
}




