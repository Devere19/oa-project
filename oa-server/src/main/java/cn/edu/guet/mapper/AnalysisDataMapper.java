package cn.edu.guet.mapper;

import cn.edu.guet.bean.Goods;
import cn.edu.guet.bean.PurchasePriceTrend;
import cn.edu.guet.bean.SalePriceTrend;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;

/**
 * @author 陶祎祎
 */
@Mapper
public interface AnalysisDataMapper {
    List<Goods> getGoodsNameData();
    List<PurchasePriceTrend> getPurchasePriceTrend(@Param("goodsName")String goodsName, @Param("startDate")Date startDate, @Param("endDate")Date endDate);
    List<SalePriceTrend> getSalePriceTrend(@Param("goodsName")String goodsName, @Param("startDate")Date startDate, @Param("endDate")Date endDate);
}
