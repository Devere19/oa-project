package cn.edu.guet.controller;

import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Date;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/finance")
public class AnalysisDataController {

    @Autowired
    private AnalysisDataService analysisDataService;

    @Autowired
    private IncomeSpendInfoService incomeSpendInfoService;

    @Autowired
    private PurchasePaymentContractService purchasePaymentContractService;

    @Autowired
    private LogisticsPaymentContractService logisticsPaymentContractService;

    @Autowired
    private ShippingContractService shippingContractService;

    @RequestMapping("/getGoodsNameData")
    public HttpResult getGoodsNameData(){
        return ResultUtils.success("获取成功",analysisDataService.getGoodsNameData());
    }

    @RequestMapping("/getPriceTrendData")
    public HttpResult getPriceTrendData(String goodsName, Date startDate, Date endDate){
       return ResultUtils.success("获取成功",analysisDataService.getPriceTrendData(goodsName,startDate,endDate));
    }

    @RequestMapping("/getChartIncomeSpendData")
    public HttpResult getChartIncomeSpendData(String dataType, String dataCompany, int timeType, String startDate, String endDate){
       return ResultUtils.success("获取成功",incomeSpendInfoService.getChartIncomeSpendData(dataType,dataCompany,timeType,startDate,endDate));
    }

    @RequestMapping("/getNumberIncomeSpendData")
    public HttpResult getNumberIncomeSpendData(String dataType, String dataCompany){
        return ResultUtils.success("获取成功",incomeSpendInfoService.getNumberIncomeSpendData(dataType,dataCompany));
    }

    @RequestMapping("/getDetailIncomeSpendData")
    public HttpResult getDetailIncomeSpendData(String dataType, String dataCompany, int timeType, String startDate, String endDate){
        return ResultUtils.success("获取成功",incomeSpendInfoService.getDetailIncomeSpendData(dataType,dataCompany,timeType,startDate,endDate));
    }

    @RequestMapping("/getOnePurchasePaymentContract")
    public HttpResult getOnePurchasePaymentContract(int id){
        return ResultUtils.success("查询成功",purchasePaymentContractService.getOnePurchasePaymentContract(id));
    }

    @RequestMapping("/getOneLogisticsPaymentContract")
    public HttpResult getOneLogisticsPaymentContract(int id){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.getOneLogisticsPaymentContract(id));
    }

    @RequestMapping("/getOneShippingContract")
    public HttpResult getOneShippingContract(int id){
        return ResultUtils.success("查询成功",shippingContractService.getOneShippingContract(id));
    }

}
