package cn.edu.guet.controller;

import cn.edu.guet.bean.ProcessContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.ProcessContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.sql.Date;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/processContract")
public class ProcessContractController {
    @Autowired
    private ProcessContractService processContractService;

    //    获取非归档数据（显示）
    @RequestMapping("/getTProcessContractData")
    public HttpResult getTProcessContractData(int current, int page){
        return ResultUtils.success("查询成功",processContractService.getTProcessContractData(current,page));
    }

    //    获取归档数据（隐藏）
    @RequestMapping("/getFProcessContractData")
    public HttpResult getFProcessContractData(int current,int page){
        return ResultUtils.success("查询成功",processContractService.getFProcessContractData(current,page));
    }

    @RequestMapping("/searchProcessContract")
    public HttpResult searchProcessContract(int current, int page, String searchWord, boolean showPigeonhole, Date startDate, Date endDate){
        return ResultUtils.success("查询成功",processContractService.searchProcessContract(current,page,searchWord,showPigeonhole,startDate,endDate));
    }

    @DeleteMapping("/deleteOneProcessContract/{id}")
    public HttpResult deleteOneProcessContract(@PathVariable("id") Integer id){
        return ResultUtils.success("删除成功",processContractService.deleteOneProcessContract(id,0));
    }

    @RequestMapping("/setProcessContractPigeonhole")
    public HttpResult setProcessContractPigeonhole(int id,int pigeonhole){
        return ResultUtils.success("修改成功",processContractService.setProcessContractPigeonhole(id,pigeonhole));
    }

    @RequestMapping("/addNewProcessContract")
    public HttpResult addNewProcessContract(@RequestBody ProcessContract processContract){
        return ResultUtils.success("新增成功",processContractService.addNewProcessContract(processContract,null,0));
    }

    @RequestMapping("/updateProcessContract")
    public HttpResult updateProcessContract(@RequestBody ProcessContract processContract){
        return ResultUtils.success("新增成功",processContractService.updateProcessContract(processContract));
    }

    //    获取详情数据
    @RequestMapping("/getProcessDetail")
    public HttpResult getProcessDetail(String processContractNo,String goodsName){
        return ResultUtils.success("查询成功",processContractService.getProcessDetail(processContractNo,goodsName));
    }
}
