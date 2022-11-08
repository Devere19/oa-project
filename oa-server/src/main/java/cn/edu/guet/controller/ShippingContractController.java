package cn.edu.guet.controller;

import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.ShippingContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/shippingContract")
public class ShippingContractController {

    @Autowired
    private ShippingContractService shippingContractService;

    //    获取海运单数据
    @RequestMapping("/getshippingContractData")
    public HttpResult getshippingContractData(int current, int page){
        return ResultUtils.success("查询成功",shippingContractService.getshippingContractData(current,page));
    }

    @RequestMapping("/searchShippingContract")
    public HttpResult searchShippingContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",shippingContractService.searchShippingContract(current,page,searchWord));
    }

    @DeleteMapping("/deleteOneShippingContract/{id}")
    public HttpResult deleteOneShippingContract(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",shippingContractService.deleteOneShippingContract(id));
    }

    @RequestMapping("/addNewShippingContract")
    public HttpResult addNewShippingContract(@RequestBody ShippingContract shippingContract){
        return ResultUtils.success("新增成功",shippingContractService.addNewShippingContract(shippingContract));
    }

    @RequestMapping("/checkContainerNo")
    public HttpResult checkContainerNo(String containerNo){
        return ResultUtils.success("获取成功",shippingContractService.checkContainerNo(containerNo));
    }
}
