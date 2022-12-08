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
        return ResultUtils.success("删除成功",shippingContractService.deleteOneShippingContract(id,0));
    }

    @RequestMapping("/addNewShippingContract")
    public HttpResult addNewShippingContract(@RequestBody ShippingContract shippingContract){
        return ResultUtils.success("新增成功",shippingContractService.addNewShippingContract(shippingContract,null,0));
    }

    @RequestMapping("/updateShippingContract")
    public HttpResult updateShippingContract(@RequestBody ShippingContract shippingContract){
        return ResultUtils.success("修改成功",shippingContractService.updateShippingContract(shippingContract));
    }

    @RequestMapping("/checkContainerNo")
    public HttpResult checkContainerNo(String containerNo){
        return ResultUtils.success("获取成功",shippingContractService.checkContainerNo(containerNo));
    }

    //    APP接口
    @RequestMapping("/getDirectorSC")
    public HttpResult getDirectorSC(int current, int page, int userId ,int type){
        return ResultUtils.success("查询成功",shippingContractService.getDirectorSC(current,page,userId,type));
    }

    @RequestMapping("/getOneDirectorSC")
    public HttpResult getOneDirectorSC(int id){
        return ResultUtils.success("查询成功",shippingContractService.getOneDirectorSC(id));
    }

    @RequestMapping("/searchDirectorSC")
    public HttpResult searchDirectorSC(int current, int page,String searchWord, int userId){
        return ResultUtils.success("查询成功",shippingContractService.searchDirectorSC(current,page,searchWord,userId));
    }

    //审批
    @RequestMapping("/changeFinanceState")
    public  HttpResult changeFinanceState(String shippingContractNo,String financeStaff){
        return ResultUtils.success("已通过",shippingContractService.changeFinanceState(shippingContractNo,financeStaff));
    }

    @RequestMapping("/changeDirectorState")
    public  HttpResult changeDirectorState(String shippingContractNo,int userId)  {
        return ResultUtils.success("已通过", shippingContractService.changeDirectorState(shippingContractNo, userId));
    }
}
