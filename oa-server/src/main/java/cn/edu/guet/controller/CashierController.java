package cn.edu.guet.controller;

import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.PurchasePaymentContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("cashier")
public class CashierController {

    @Autowired
    private PurchasePaymentContractService purchasePaymentContractService;

    //    获取出纳的采购付款单数据
    @RequestMapping("/getCashierPurchasePayment")
    public HttpResult getCashierPurchasePayment(int current, int page){
        return ResultUtils.success("查询成功",purchasePaymentContractService.getCashierPurchasePayment(current,page));
    }

//    出纳查询采购付款单数据
    @RequestMapping("/searchCashierPurchasePayment")
    public HttpResult searchCashierPurchasePayment(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",purchasePaymentContractService.searchCashierPurchasePayment(current,page,searchWord));
    }

    @RequestMapping("/uploadCashierPurchasePayment")
    public HttpResult uploadCashierPurchasePayment(@RequestBody PurchasePaymentContract purchasePaymentContract){
        return ResultUtils.success("新增成功",purchasePaymentContractService.uploadCashierPurchasePayment(purchasePaymentContract));
    }
}
