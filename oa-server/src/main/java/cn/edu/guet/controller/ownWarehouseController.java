package cn.edu.guet.controller;

import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.OwnWarehouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: 钟丁豪
 * @Date: 2022/11/20/18:25
 * @Description:
 */
@RestController
@RequestMapping("/ownWarehouse")
public class ownWarehouseController {

    @Autowired
    private OwnWarehouseService ownWarehouseService;

    @RequestMapping("/getFPurchaseContractData")
    public HttpResult getFPurchaseContractData(int current,int page){
        return ResultUtils.success("查询成功",ownWarehouseService.getOwnWarehouseData(current,page));
    }

    @RequestMapping("/searchOwnWarehouse")
    public HttpResult searchOwnWarehouse(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",ownWarehouseService.searchOwnWarehouse(current,page,searchWord));
    }
}
