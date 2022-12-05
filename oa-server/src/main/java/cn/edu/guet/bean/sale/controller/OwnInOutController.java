package cn.edu.guet.bean.sale.controller;

import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.OwnInOutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: 钟丁豪
 * @Date: 2022/11/21/14:35
 * @Description:
 */
@RestController
@RequestMapping("/OwnInOut")
public class OwnInOutController {

    @Autowired
    private OwnInOutService ownInOutService;

    @RequestMapping("/getOwnInOutData")
    public HttpResult getOwnInOutData(String inOutGoodsName){
        System.out.println(ownInOutService.getOwnInOutData(inOutGoodsName));
        return ResultUtils.success("查询成功",ownInOutService.getOwnInOutData(inOutGoodsName));
    }
}
