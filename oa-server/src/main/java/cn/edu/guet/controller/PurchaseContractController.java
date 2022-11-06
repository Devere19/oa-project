package cn.edu.guet.controller;

import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.PurchaseContractService;
import cn.edu.guet.service.PurchaseContractViewService;
import cn.edu.guet.util.ImageUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/purchaseContract")
public class PurchaseContractController {

    @Autowired
    private PurchaseContractService purchaseContractService;

    @Autowired
    private PurchaseContractViewService purchaseContractViewService;

//    获取非归档数据（显示）
    @RequestMapping("/getTPurchaseContractData")
    public HttpResult getTPurchaseContractData(int current,int page){
        return ResultUtils.success("查询成功",purchaseContractViewService.getTPurchaseContractData(current,page));
    }

//    获取归档数据（隐藏）
    @RequestMapping("/getFPurchaseContractData")
    public HttpResult getFPurchaseContractData(int current,int page){
        return ResultUtils.success("查询成功",purchaseContractViewService.getFPurchaseContractData(current,page));
    }

    @RequestMapping("/searchPurchaseContract")
    public HttpResult searchPurchaseContract(int current,int page,String searchWord,boolean showPigeonhole){
        return ResultUtils.success("查询成功",purchaseContractViewService.searchPurchaseContract(current,page,searchWord,showPigeonhole));
    }

    @DeleteMapping("/deleteOnePurchaseContract/{id}")
    public HttpResult deleteOnePurchaseContract(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",purchaseContractService.deleteOnePurchaseContract(id));
    }

    @RequestMapping("/deleteMorePurchaseContract")
    public HttpResult deleteMorePurchaseContract(@RequestBody String pram){
        return ResultUtils.success("删除成功",purchaseContractService.deleteMorePurchaseContract(JSON.parseArray(pram.substring(8).split("\"")[0])));
    }

    @RequestMapping("/setPurchaseContractPigeonhole")
    public HttpResult setPurchaseContractPigeonhole(int id,int pigeonhole){
        return ResultUtils.success("修改成功",purchaseContractService.setPurchaseContractPigeonhole(id,pigeonhole));
    }

    @RequestMapping("/addNewPurchaseContract")
    public HttpResult addNewPurchaseContract(@RequestBody PurchaseContract purchaseContract){
        return ResultUtils.success("新增成功",purchaseContractService.addNewPurchaseContract(purchaseContract));
    }

//    获取详情数据
    @RequestMapping("/getPurchaseDetail")
    public HttpResult getPurchaseDetail(String purchaseContractNo,String goodsName){
        return ResultUtils.success("查询成功",purchaseContractService.getPurchaseDetail(purchaseContractNo,goodsName));
    }
}
