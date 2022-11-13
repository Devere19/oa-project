package cn.edu.guet.controller;

import cn.edu.guet.bean.LogisticsPaymentContract;
import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.LogisticsPaymentContractService;
import cn.edu.guet.service.PurchasePaymentContractService;
import cn.edu.guet.service.ShippingContractService;
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

    @Autowired
    private LogisticsPaymentContractService logisticsPaymentContractService;

    @Autowired
    private ShippingContractService shippingContractService;

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

//    出纳完善采购付款单数据
    @RequestMapping("/uploadCashierPurchasePayment")
    public HttpResult uploadCashierPurchasePayment(@RequestBody PurchasePaymentContract purchasePaymentContract){
        return ResultUtils.success("上传成功",purchasePaymentContractService.uploadCashierPurchasePayment(purchasePaymentContract));
    }

    //    获取出纳的物流付款单数据
    @RequestMapping("/getCashierLogisticsPayment")
    public HttpResult getCashierLogisticsPayment(int current, int page){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.getCashierLogisticsPayment(current,page));
    }

//    出纳查询物流付款单数据
    @RequestMapping("/searchCashierLogisticsPayment")
    public HttpResult searchCashierLogisticsPayment(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",logisticsPaymentContractService.searchCashierLogisticsPayment(current,page,searchWord));
    }

//    出纳完善物流付款单数据
    @RequestMapping("/uploadCashierLogisticsPayment")
    public HttpResult uploadCashierLogisticsPayment(@RequestBody LogisticsPaymentContract logisticsPaymentContract){
        return ResultUtils.success("上传成功",logisticsPaymentContractService.uploadCashierLogisticsPayment(logisticsPaymentContract));
    }

    //    获取出纳的海运单数据
    @RequestMapping("/getCashierShipping")
    public HttpResult getCashierShipping(int current, int page){
        return ResultUtils.success("查询成功",shippingContractService.getCashierShipping(current,page));
    }

//    出纳查询海运单数据
    @RequestMapping("/searchCashierShipping")
    public HttpResult searchCashierShipping(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",shippingContractService.searchCashierShipping(current,page,searchWord));
    }

//    出纳完善海运单数据
    @RequestMapping("/uploadCashierShipping")
    public HttpResult uploadCashierShipping(@RequestBody ShippingContract shippingContract){
        return ResultUtils.success("上传成功",shippingContractService.uploadCashierShipping(shippingContract));
    }

}
