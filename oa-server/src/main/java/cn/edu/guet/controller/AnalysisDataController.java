package cn.edu.guet.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.edu.guet.bean.IncomeSpendExportParams;
import cn.edu.guet.bean.exportModel.*;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.*;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
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
    private ProcessPaymentContractService processPaymentContractService;

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

    @RequestMapping("/getOneProcessPaymentContract")
    public HttpResult getOneProcessPaymentContract(int id){
        return ResultUtils.success("查询成功",processPaymentContractService.getOneProcessPaymentContract(id));
    }

    @RequestMapping("/getOneLogisticsPaymentContract")
    public HttpResult getOneLogisticsPaymentContract(int id){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.getOneLogisticsPaymentContract(id));
    }

    @RequestMapping("/getOneShippingContract")
    public HttpResult getOneShippingContract(int id){
        return ResultUtils.success("查询成功",shippingContractService.getOneShippingContract(id));
    }

    @RequestMapping("/sendExportParm")
    public HttpResult sendExportParm(HttpServletRequest request, @RequestBody IncomeSpendExportParams incomeSpendExportParams){
        request.getServletContext().setAttribute("incomeSpendExportParams", incomeSpendExportParams);
        System.out.println("存进的全局属性："+ incomeSpendExportParams);
        return ResultUtils.success("传递参数成功");
    }

    @RequestMapping("/incomeSpendExportExcel")
    public void purchaseExportExcel(HttpServletResponse response, HttpServletRequest request) throws Exception {
        IncomeSpendExportParams incomeSpendExportParams = (IncomeSpendExportParams) request.getServletContext().getAttribute("incomeSpendExportParams");
        System.out.println("拿到的全局数据:"+ incomeSpendExportParams);

        String fileName =null;

        if("0".equals(incomeSpendExportParams.getDataType())){
            // StringUtils.isEmpty(logisticsContract.getCreateBy())?SecurityUtils.getUsername(): logisticsContract.getCreateBy()
            if("0".equals(incomeSpendExportParams.getDataCompany())){
                fileName = "整体业务-总体-"+incomeSpendExportParams.getChooseDate()+"收入支出细则.xlsx";
            }else if("1".equals(incomeSpendExportParams.getDataCompany())){
                fileName = "整体业务-广西永湘贸易有限责任公司-"+incomeSpendExportParams.getChooseDate()+"收入支出细则.xlsx";
            }else if("2".equals(incomeSpendExportParams.getDataCompany())){
                fileName = "整体业务-广西永湘物流有限公司-"+incomeSpendExportParams.getChooseDate()+"收入支出细则.xlsx";
            }else if("3".equals(incomeSpendExportParams.getDataCompany())){
                fileName = "整体业务-广西丰沣顺国际物流有限公司-"+incomeSpendExportParams.getChooseDate()+"收入支出细则.xlsx";
            }else if("4".equals(incomeSpendExportParams.getDataCompany())){
                fileName = "整体业务-广西众润贸易有限责任公司-"+incomeSpendExportParams.getChooseDate()+"收入支出细则.xlsx";
            }

            List<Map<String, Object>> sheetsList = new ArrayList<>();

            List<ExportSaleModel> exportSaleModelList=incomeSpendInfoService.getSaleData(incomeSpendExportParams.getDataCompany(),incomeSpendExportParams.getTimeType(),incomeSpendExportParams.getChooseDate());
            List<ExportPurchasePaymentModel> exportPurchasePaymentModelList=incomeSpendInfoService.getPurchasePaymentData(incomeSpendExportParams.getDataCompany(),incomeSpendExportParams.getTimeType(),incomeSpendExportParams.getChooseDate());
            List<ExportProcessPaymentModel> exportProcessPaymentModelList=incomeSpendInfoService.getProcessPaymentData(incomeSpendExportParams.getDataCompany(),incomeSpendExportParams.getTimeType(),incomeSpendExportParams.getChooseDate());
            List<ExportLogisticsPaymentModel> exportLogisticsPaymentModelList=incomeSpendInfoService.getLogisticsPaymentData(incomeSpendExportParams.getDataCompany(),incomeSpendExportParams.getTimeType(),incomeSpendExportParams.getChooseDate());
            List<ExportShippingModel> exportShippingModelList=incomeSpendInfoService.getShippingData(incomeSpendExportParams.getDataCompany(),incomeSpendExportParams.getTimeType(),incomeSpendExportParams.getChooseDate());

            ExportParams saleParams = new ExportParams();
            saleParams.setSheetName("销售单信息");
            saleParams.setType(ExcelType.XSSF);
            ExportParams purchasePaymentParams = new ExportParams();
            purchasePaymentParams.setSheetName("采购付款单信息");
            purchasePaymentParams.setType(ExcelType.XSSF);
            ExportParams processPaymentParams = new ExportParams();
            processPaymentParams.setSheetName("加工付款单信息");
            processPaymentParams.setType(ExcelType.XSSF);
            ExportParams logisticsPaymentParams = new ExportParams();
            logisticsPaymentParams.setSheetName("物流付款单信息");
            logisticsPaymentParams.setType(ExcelType.XSSF);
            ExportParams shippingParams = new ExportParams();
            shippingParams.setSheetName("海运单信息");
            shippingParams.setType(ExcelType.XSSF);

            Map<String, Object> saleExportMap = new HashMap<>();
            Map<String, Object> purchasePaymentExportMap = new HashMap<>();
            Map<String, Object> processPaymentExportMap = new HashMap<>();
            Map<String, Object> logisticsPaymentExportMap = new HashMap<>();
            Map<String, Object> shippingExportMap = new HashMap<>();

            saleExportMap.put("title", saleParams);
            saleExportMap.put("entity", ExportSaleModel.class);
            saleExportMap.put("data", exportSaleModelList);
            purchasePaymentExportMap.put("title", purchasePaymentParams);
            purchasePaymentExportMap.put("entity", ExportPurchasePaymentModel.class);
            purchasePaymentExportMap.put("data", exportPurchasePaymentModelList);
            processPaymentExportMap.put("title", processPaymentParams);
            processPaymentExportMap.put("entity", ExportProcessPaymentModel.class);
            processPaymentExportMap.put("data", exportProcessPaymentModelList);
            logisticsPaymentExportMap.put("title", logisticsPaymentParams);
            logisticsPaymentExportMap.put("entity", ExportLogisticsPaymentModel.class);
            logisticsPaymentExportMap.put("data", exportLogisticsPaymentModelList);
            shippingExportMap.put("title", shippingParams);
            shippingExportMap.put("entity", ExportShippingModel.class);
            shippingExportMap.put("data", exportShippingModelList);

            sheetsList.add(saleExportMap);
            sheetsList.add(purchasePaymentExportMap);
            sheetsList.add(processPaymentExportMap);
            sheetsList.add(logisticsPaymentExportMap);
            sheetsList.add(shippingExportMap);

            Workbook workbook = ExcelExportUtil.exportExcel(sheetsList,ExcelType.XSSF);
            downloadExcel(fileName, workbook, response);

        }else if("1".equals(incomeSpendExportParams.getDataType())){
            fileName = "办公经费-总体-"+incomeSpendExportParams.getChooseDate()+"支出细则.xlsx";
            ExportParams officeExpenseParams = new ExportParams();
            officeExpenseParams.setType(ExcelType.XSSF);
            Workbook workbook = ExcelExportUtil.exportExcel(officeExpenseParams, ExportOfficeExpenseModel.class, incomeSpendInfoService.getOfficeExpenseData(incomeSpendExportParams.getTimeType(),incomeSpendExportParams.getChooseDate()));
            downloadExcel(fileName, workbook, response);
        }

        // 导出
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
    }
}
