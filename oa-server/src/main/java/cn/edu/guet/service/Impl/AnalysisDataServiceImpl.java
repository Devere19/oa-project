package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.Goods;
import cn.edu.guet.bean.PriceTrend;
import cn.edu.guet.bean.PurchasePriceTrend;
import cn.edu.guet.mapper.AnalysisDataMapper;
import cn.edu.guet.service.AnalysisDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;

/**
 * @author 陶祎祎
 */
@Service
public class AnalysisDataServiceImpl implements AnalysisDataService {

    @Autowired
    private AnalysisDataMapper analysisDataMapper;

    @Override
    public List<Goods> getGoodsNameData() {
        return analysisDataMapper.getGoodsNameData();
    }

    @Override
    public PriceTrend getPriceTrendData(String goodsName, Date startDate, Date endDate) {
        PriceTrend priceTrend=new PriceTrend();
        priceTrend.setPurchasePriceTrends(analysisDataMapper.getPurchasePriceTrend(goodsName, startDate, endDate));
        priceTrend.setSalePriceTrends(analysisDataMapper.getSalePriceTrend(goodsName, startDate, endDate));
        return priceTrend;
    }
}
