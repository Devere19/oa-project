package cn.edu.guet.controller;

import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.PurchaseContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/purchaseContract")
public class PurchaseContractController {

    @Autowired
    private PurchaseContractService purchaseContractService;

    @RequestMapping("/getPurchaseContractData")
        public HttpResult getPurchaseContractData(int current,int page){
        return ResultUtils.success("查询成功",purchaseContractService.getPurchaseContractData(current,page));
    }

    @RequestMapping("/searchPurchaseContract")
        public HttpResult searchPurchaseContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",purchaseContractService.searchPurchaseContract(current,page,searchWord));
    }
}
