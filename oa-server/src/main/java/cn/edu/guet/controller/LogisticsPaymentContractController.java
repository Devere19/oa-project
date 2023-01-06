package cn.edu.guet.controller;

import cn.edu.guet.bean.ImportModel.ImportLogisticsPaymentContractModel;
import cn.edu.guet.bean.ImportModel.ImportProcessPaymentContractModel;
import cn.edu.guet.bean.LogisticsPaymentContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.LogisticsPaymentContractService;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/logisticsPaymentContract")
public class LogisticsPaymentContractController {

    @Autowired
    private LogisticsPaymentContractService logisticsPaymentContractService;

    @Autowired
    private LogisticsContractService logisticsContractService;

    //    获取采购付款单数据
    @RequestMapping("/getLogisticsPaymentContractData")
    public HttpResult getLogisticsPaymentContractData(int current, int page){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.getLogisticsPaymentContractData(current,page));
    }

    @RequestMapping("/searchLogisticsPaymentContract")
    public HttpResult searchLogisticsPaymentContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.searchLogisticsPaymentContract(current,page,searchWord));
    }

    @RequestMapping("/logisticsPaymentImportExcel")
    public HttpResult logisticsPaymentImportExcel(@RequestBody MultipartFile file) throws IOException {
        EasyExcel.read(file.getInputStream(), ImportLogisticsPaymentContractModel.class, new PageReadListener<ImportLogisticsPaymentContractModel>(dataList -> {
            System.out.println(dataList.size());
            for (ImportLogisticsPaymentContractModel importLogisticsPaymentContractModel : dataList) {
                if(importLogisticsPaymentContractModel.getLogisticsContractNo()==null){
                    break;
                }
                System.out.println(logisticsPaymentContractService.handleImportLogisticsPaymentContractModel(importLogisticsPaymentContractModel));
            }
        })).sheet().doRead();
        return ResultUtils.success("批量插入物流付款单成功");
    }

    @DeleteMapping("/deleteOneLogisticsPaymentContract/{id}")
    public HttpResult deleteOneLogisticsPaymentContract(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",logisticsPaymentContractService.deleteOneLogisticsPaymentContract(id));
    }

    @RequestMapping("/addNewLogisticsPaymentContract")
    public HttpResult addNewLogisticsPaymentContract(@RequestBody LogisticsPaymentContract logisticsPaymentContract){
        return ResultUtils.success("新增成功",logisticsPaymentContractService.addNewLogisticsPaymentContract(logisticsPaymentContract));
    }

    @RequestMapping("/updateLogisticsPaymentContract")
    public HttpResult updateLogisticsPaymentContract(@RequestBody LogisticsPaymentContract logisticsPaymentContract){
        return ResultUtils.success("修改成功",logisticsPaymentContractService.updateLogisticsPaymentContract(logisticsPaymentContract));
    }

    @RequestMapping("/checkLogisticsContractNo")
    public HttpResult checkLogisticsContractNo(String logisticsContractNo){
        return ResultUtils.success("获取成功",logisticsContractService.checkLogisticsContractNo(logisticsContractNo));
    }

    //    APP接口

    /**
     * * APP获取董事会物流付款单
     * @param current
     * @param page
     * @param userId
     * @param type
     * @return
     */
    @RequestMapping("/getDirectorLPC")
    public HttpResult getDirectorLPC(int current, int page, int userId ,int type){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.getDirectorLPC(current,page,userId,type));
    }

    @RequestMapping("/getOneDirectorLPC")
    public HttpResult getOneDirectorLPC(int id){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.getOneDirectorLPC(id));
    }

    @RequestMapping("/searchDirectorLPC")
    public HttpResult searchDirectorLPC(int current, int page,String searchWord,int userId){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.searchDirectorLPC(current,page,searchWord,userId));
    }

    //审批
    @RequestMapping("/changeFinanceState")
    public  HttpResult changeFinanceState(int id, String financeStaff){
        return ResultUtils.success("已通过",logisticsPaymentContractService.changeFinanceState(id,financeStaff));
    }

    @RequestMapping("/changeDirectorState")
    public  HttpResult changeDirectorState(int logisticsPaymentContractId, int userId) {
        return ResultUtils.success("已通过", logisticsPaymentContractService.changeDirectorState(logisticsPaymentContractId, userId));
    }
}
