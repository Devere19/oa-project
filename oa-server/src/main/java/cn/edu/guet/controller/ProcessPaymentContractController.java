package cn.edu.guet.controller;

import cn.edu.guet.bean.ProcessPaymentContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.ProcessContractService;
import cn.edu.guet.service.ProcessPaymentContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
