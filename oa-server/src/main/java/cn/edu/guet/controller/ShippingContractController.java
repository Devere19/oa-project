package cn.edu.guet.controller;

import cn.edu.guet.bean.ImportModel.ImportPurchaseContractModel;
import cn.edu.guet.bean.ImportModel.ImportShippingContractModel;
import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.ShippingContractService;
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
@RequestMapping("/shippingContract")
public class ShippingContractController {

    @Autowired
    private ShippingContractService shippingContractService;

    @Autowired
    private LogisticsContractService logisticsContractService;

    //    获取海运单数据
    @RequestMapping("/getshippingContractData")
    public HttpResult getshippingContractData(int current, int page){
        return ResultUtils.success("查询成功",shippingContractService.getshippingContractData(current,page));
    }

    @RequestMapping("/searchShippingContract")
    public HttpResult searchShippingContract(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",shippingContractService.searchShippingContract(current,page,searchWord));
    }

    @RequestMapping("/shippingImportExcel")
    public HttpResult shippingImportExcel(@RequestBody MultipartFile file) throws IOException {
        EasyExcel.read(file.getInputStream(), ImportShippingContractModel.class, new PageReadListener<ImportShippingContractModel>(dataList -> {
            System.out.println(dataList.size());
            for (ImportShippingContractModel importShippingContractModel : dataList) {
                if(importShippingContractModel.getShippingContractNo()==null){
                    break;
                }
                System.out.println(shippingContractService.handleImportShippingContractModel(importShippingContractModel));
            }
        })).sheet().doRead();
        return ResultUtils.success("批量插入海运单成功");
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

    @RequestMapping("/shippingCheckLogisticsContractNo")
    public HttpResult shippingCheckLogisticsContractNo(String logisticsContractNo){
        return ResultUtils.success("获取成功",logisticsContractService.shippingCheckLogisticsContractNo(logisticsContractNo));
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
