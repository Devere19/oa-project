package cn.edu.guet.mapper;

import cn.edu.guet.bean.PurchasePaymentContractView;
import cn.edu.guet.bean.exportModel.ExportPurchasePaymentModel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【purchase_payment_contract_info】的数据库操作Mapper
* @createDate 2022-11-11 10:47:14
* @Entity generator.bean.PurchasePaymentContractInfo
*/
@Mapper
public interface PurchasePaymentContractInfoMapper extends BaseMapper<PurchasePaymentContractView> {
    //    导出所用
    List<ExportPurchasePaymentModel> getPurchaseExportDayData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportPurchasePaymentModel> getPurchaseExportMonthData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportPurchasePaymentModel> getPurchaseExportSeasonData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportPurchasePaymentModel> getPurchaseExportYearData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<ExportPurchasePaymentModel> getPurchaseExportCompanyDayData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportPurchasePaymentModel> getPurchaseExportCompanyMonthData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportPurchasePaymentModel> getPurchaseExportCompanySeasonData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportPurchasePaymentModel> getPurchaseExportCompanyYearData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
}




