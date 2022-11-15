package cn.edu.guet.service;

import cn.edu.guet.bean.Goods;
import cn.edu.guet.bean.PriceTrend;
import cn.edu.guet.bean.PurchasePriceTrend;

import java.sql.Date;
import java.util.List;

/**
 * @author 陶祎祎
 */
public interface AnalysisDataService {
    List<Goods> getGoodsNameData();
    PriceTrend getPriceTrendData(String goodsName, Date startDate, Date endDate);
}
