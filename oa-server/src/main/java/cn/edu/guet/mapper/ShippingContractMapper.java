package cn.edu.guet.mapper;

import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.bean.exportModel.ExportShippingModel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【shipping_contract】的数据库操作Mapper
* @createDate 2022-11-07 12:02:08
* @Entity cn.edu.guet.bean.ShippingContract
*/
@Mapper
public interface ShippingContractMapper extends BaseMapper<ShippingContract> {
    List<ShippingContract> checkContainerNo(String containerNo);

    //    导出所用
    List<ExportShippingModel> getShippingExportDayData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportShippingModel> getShippingExportMonthData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportShippingModel> getShippingExportSeasonData(@Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportShippingModel> getShippingExportYearData(@Param("startDate")String startDate, @Param("endDate")String endDate);

    List<ExportShippingModel> getShippingExportCompanyDayData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportShippingModel> getShippingExportCompanyMonthData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportShippingModel> getShippingExportCompanySeasonData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
    List<ExportShippingModel> getShippingExportCompanyYearData(@Param("company")String company, @Param("startDate")String startDate, @Param("endDate")String endDate);
}




