package cn.edu.guet.controller;

import cn.edu.guet.bean.ImportModel.ImportPurchasePaymentContractModel;
import cn.edu.guet.bean.ImportModel.ImportShippingContractModel;
import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.PurchaseContractService;
import cn.edu.guet.service.PurchasePaymentContractService;
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
@RequestMapping("/purchasePaymentContract")
public class PurchasePaymentContractController {

    @Autowired
    private PurchasePaymentContractService purchasePaymentContractService;

    @Autowired
    private PurchaseContractService purchaseContractService;


    //    获取采购付款单数据
    @RequestMapping("/getPurchasePaymentContractData")
    public HttpResult getPurchasePaymentContractData(int current, int page){
        return ResultUtils.success("查询成功",purchasePaymentContractService.getPurchasePaymentContractData(current,page));
    }

    @RequestMapping("/searchPurchasePaymentContract")
    public HttpResult searchPurchasePaymentContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",purchasePaymentContractService.searchPurchasePaymentContract(current,page,searchWord));
    }

    @RequestMapping("/purchasePaymentImportExcel")
    public HttpResult purchasePaymentImportExcel(@RequestBody MultipartFile file) throws IOException {
        EasyExcel.read(file.getInputStream(), ImportPurchasePaymentContractModel.class, new PageReadListener<ImportPurchasePaymentContractModel>(dataList -> {
            System.out.println(dataList.size());
            for (ImportPurchasePaymentContractModel importPurchasePaymentContractModel : dataList) {
                if(importPurchasePaymentContractModel.getPurchaseContractNo()==null){
                    break;
                }
                System.out.println(purchasePaymentContractService.handleImportPurchasePaymentContractModel(importPurchasePaymentContractModel));
            }
        })).sheet().doRead();
        return ResultUtils.success("批量插入采购付款单成功");
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

    @RequestMapping("/updatePurchasePaymentContract")
    public HttpResult updatePurchasePaymentContract(@RequestBody PurchasePaymentContract purchasePaymentContract){
        return ResultUtils.success("修改成功",purchasePaymentContractService.updatePurchasePaymentContract(purchasePaymentContract));
    }

    @RequestMapping("/checkPurchaseContractNo")
    public HttpResult checkPurchaseContractNo(String purchaseContractNo){
        return ResultUtils.success("获取成功",purchaseContractService.checkPurchaseContractNo(purchaseContractNo));
    }


//    APP接口
    @RequestMapping("/getDirectorPPC")
    public HttpResult getDirectorPPC(int current, int page, int userId ,int type){
        return ResultUtils.success("查询成功",purchasePaymentContractService.getDirectorPPC(current,page,userId,type));

    }

    @RequestMapping("/getOneDirectorPPC")
    public HttpResult getOneDirectorPPC(int id){
        return ResultUtils.success("查询成功",purchasePaymentContractService.getOneDirectorPPC(id));
    }

    @RequestMapping("/searchDirectorPPC")
    public HttpResult searchDirectorPPC(int current, int page,String searchWord,int userId){
        return ResultUtils.success("查询成功",purchasePaymentContractService.searchDirectorPPC(current,page,searchWord,userId));
    }

//    审批
    @RequestMapping("/changeFinanceState")
    public  HttpResult changeFinanceState(int id,String financeStaff){
        return ResultUtils.success("已通过",purchasePaymentContractService.changeFinanceState(id,financeStaff));
    }

    @RequestMapping("/changeDirectorState")
    public  HttpResult changeDirectorState(int purchasePaymentContractId, int userId) {
        return ResultUtils.success("已通过", purchasePaymentContractService.changeDirectorState(purchasePaymentContractId, userId));
    }
}
