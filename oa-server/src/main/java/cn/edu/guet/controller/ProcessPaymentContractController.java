package cn.edu.guet.controller;

import cn.edu.guet.bean.ImportModel.ImportProcessPaymentContractModel;
import cn.edu.guet.bean.ImportModel.ImportPurchasePaymentContractModel;
import cn.edu.guet.bean.ProcessPaymentContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.ProcessContractService;
import cn.edu.guet.service.ProcessPaymentContractService;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/processPaymentContract")
public class ProcessPaymentContractController {
    @Autowired
    private ProcessPaymentContractService processPaymentContractService;

    @Autowired
    private ProcessContractService processContractService;

    //    获取加工付款单数据
    @RequestMapping("/getProcessPaymentContractData")
    public HttpResult getProcessPaymentContractData(int current, int page){
        return ResultUtils.success("查询成功",processPaymentContractService.getProcessPaymentContractData(current,page));
    }

    @RequestMapping("/searchProcessPaymentContract")
    public HttpResult searchProcessPaymentContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",processPaymentContractService.searchProcessPaymentContract(current,page,searchWord));
    }

    @Transactional(rollbackFor = Exception.class)
    @RequestMapping("/processPaymentImportExcel")
    public HttpResult processPaymentImportExcel(@RequestBody MultipartFile file) throws IOException {
        List<String> errorList=new ArrayList<>();
        EasyExcel.read(file.getInputStream(), ImportProcessPaymentContractModel.class, new PageReadListener<ImportProcessPaymentContractModel>(dataList -> {
            System.out.println(dataList.size());
            for (ImportProcessPaymentContractModel importProcessPaymentContractModel : dataList) {
                if(importProcessPaymentContractModel.getProcessContractNo()==null){
                    break;
                }
                int result=processPaymentContractService.handleImportProcessPaymentContractModel(importProcessPaymentContractModel);
                if(result==0){
                    String msg="加工合同号（"+importProcessPaymentContractModel.getProcessContractNo()+"）不存在";
                    if(!errorList.contains(msg)){
                        errorList.add(msg);
                    }
                }
            }
        })).sheet().doRead();
        if(!errorList.isEmpty()){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return ResultUtils.error("批量插入加工付款单失败",errorList);
        }
        return ResultUtils.success("批量插入加工付款单成功");
    }

    @DeleteMapping("/deleteOneProcessPaymentContract/{id}")
    public HttpResult deleteOneProcessPaymentContract(@PathVariable("id") Integer id){
        return ResultUtils.success("删除成功",processPaymentContractService.deleteOneProcessPaymentContract(id));
    }

    @RequestMapping("/addNewProcessPaymentContract")
    public HttpResult addNewProcessPaymentContract(@RequestBody ProcessPaymentContract processPaymentContract){
        return ResultUtils.success("新增成功",processPaymentContractService.addNewProcessPaymentContract(processPaymentContract));
    }

    @RequestMapping("/updateProcessPaymentContract")
    public HttpResult updateProcessPaymentContract(@RequestBody ProcessPaymentContract processPaymentContract){
        return ResultUtils.success("修改成功",processPaymentContractService.updateProcessPaymentContract(processPaymentContract));
    }

    @RequestMapping("/checkPurchaseContractNo")
    public HttpResult checkPurchaseContractNo(String purchaseContractNo){
        return ResultUtils.success("获取成功",processContractService.checkProcessContractNo(purchaseContractNo));
    }


    //    APP接口
    @RequestMapping("/getDirectorPPC")
    public HttpResult getDirectorPPC(int current, int page, int userId ,int type){
        return ResultUtils.success("查询成功",processPaymentContractService.getDirectorPPC(current,page,userId,type));

    }

    @RequestMapping("/getOneDirectorPPC")
    public HttpResult getOneDirectorPPC(int id){
        return ResultUtils.success("查询成功",processPaymentContractService.getOneDirectorPPC(id));
    }

    @RequestMapping("/searchDirectorPPC")
    public HttpResult searchDirectorPPC(int current, int page,String searchWord,int userId){
        return ResultUtils.success("查询成功",processPaymentContractService.searchDirectorPPC(current,page,searchWord,userId));
    }

    //    审批
    @RequestMapping("/changeFinanceState")
    public  HttpResult changeFinanceState(int id,String financeStaff){
        return ResultUtils.success("已通过",processPaymentContractService.changeFinanceState(id,financeStaff));
    }

    @RequestMapping("/changeDirectorState")
    public  HttpResult changeDirectorState(int processPaymentContractId, int userId) {
        return ResultUtils.success("已通过", processPaymentContractService.changeDirectorState(processPaymentContractId, userId));
    }
}
