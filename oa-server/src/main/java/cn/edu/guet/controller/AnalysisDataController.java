package cn.edu.guet.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.edu.guet.bean.purchaseContract.ExportOutPurchaseContract;
import cn.edu.guet.bean.purchaseContract.PurchaseExportParams;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.*;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cn.edu.guet.util.ExcelUtils.downloadExcel;

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

//    @RequestMapping("/purchaseExportExcel")
//    public void purchaseExportExcel(HttpServletResponse response, HttpServletRequest request) throws Exception {
//        PurchaseExportParams purchaseExportParams = (PurchaseExportParams) request.getServletContext().getAttribute("purchaseExportModel");
//        System.out.println("拿到的全局数据:"+ purchaseExportParams);
//        // 导出
//        String fileName = "分页测试.xlsx";
//        List<Map<String, Object>> sheetsList = new ArrayList<>();
//
//        ExportParams purchaseParams1 = new ExportParams();
//        purchaseParams1.setSheetName("采购单信息");
//        purchaseParams1.setType(ExcelType.XSSF);
//        ExportParams purchaseParams2 = new ExportParams();
//        purchaseParams2.setSheetName("销售单信息");
//        purchaseParams2.setType(ExcelType.XSSF);
//        ExportParams purchaseParams3 = new ExportParams();
//        purchaseParams3.setSheetName("物流单信息");
//        purchaseParams3.setType(ExcelType.XSSF);
//
//        Map<String, Object> purchaseExportMap1 = new HashMap<>();
//        Map<String, Object> purchaseExportMap2 = new HashMap<>();
//        Map<String, Object> purchaseExportMap3 = new HashMap<>();
//        purchaseExportMap1.put("title", purchaseParams1);
//        purchaseExportMap1.put("entity", ExportOutPurchaseContract.class);
//        purchaseExportMap1.put("data", purchaseContractService.purchaseExportExcel(purchaseExportParams.getSearchWord(), purchaseExportParams.isShowPigeonhole(), purchaseExportParams.getStartDate(), purchaseExportParams.getEndDate()));
//        purchaseExportMap2.put("title", purchaseParams2);
//        purchaseExportMap2.put("entity", ExportOutPurchaseContract.class);
//        purchaseExportMap2.put("data", purchaseContractService.purchaseExportExcel(purchaseExportParams.getSearchWord(), purchaseExportParams.isShowPigeonhole(), purchaseExportParams.getStartDate(), purchaseExportParams.getEndDate()));
//        purchaseExportMap3.put("title", purchaseParams3);
//        purchaseExportMap3.put("entity", ExportOutPurchaseContract.class);
//        purchaseExportMap3.put("data", purchaseContractService.purchaseExportExcel(purchaseExportParams.getSearchWord(), purchaseExportParams.isShowPigeonhole(), purchaseExportParams.getStartDate(), purchaseExportParams.getEndDate()));
//
//        sheetsList.add(purchaseExportMap1);
//        sheetsList.add(purchaseExportMap2);
//        sheetsList.add(purchaseExportMap3);
//
//        Workbook workbook = ExcelExportUtil.exportExcel(sheetsList,ExcelType.XSSF);
//        downloadExcel(fileName, workbook, response);
//    }
}
