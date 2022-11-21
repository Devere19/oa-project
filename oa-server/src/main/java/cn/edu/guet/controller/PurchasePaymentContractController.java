package cn.edu.guet.controller;

import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.PurchaseContractViewService;
import cn.edu.guet.service.PurchasePaymentContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/purchasePaymentContract")
public class PurchasePaymentContractController {

    @Autowired
    private PurchasePaymentContractService purchasePaymentContractService;

    @Autowired
    private PurchaseContractViewService purchaseContractViewService;

    //    获取采购付款单数据
    @RequestMapping("/getPurchasePaymentContractData")
    public HttpResult getPurchasePaymentContractData(int current, int page){
        return ResultUtils.success("查询成功",purchasePaymentContractService.getPurchasePaymentContractData(current,page));
    }

    @RequestMapping("/searchPurchasePaymentContract")
    public HttpResult searchPurchasePaymentContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",purchasePaymentContractService.searchPurchasePaymentContract(current,page,searchWord));
    }

    @DeleteMapping("/deleteOnePurchasePaymentContract/{id}")
    public HttpResult deleteOnePurchasePaymentContract(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",purchasePaymentContractService.deleteOnePurchasePaymentContract(id));
    }

    @RequestMapping("/addNewPurchasePaymentContract")
    public HttpResult addNewPurchasePaymentContract(@RequestBody PurchasePaymentContract purchasePaymentContract){
        return ResultUtils.success("新增成功",purchasePaymentContractService.addNewPurchasePaymentContract(purchasePaymentContract));
    }

    @RequestMapping("/checkPurchaseContractNo")
    public HttpResult checkPurchaseContractNo(String purchaseContractNo){
        return ResultUtils.success("获取成功",purchaseContractViewService.checkPurchaseContractNo(purchaseContractNo));
    }
}