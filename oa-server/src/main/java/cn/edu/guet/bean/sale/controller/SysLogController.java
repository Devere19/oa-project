package cn.edu.guet.bean.sale.controller;

import cn.edu.guet.bean.log.ListParm;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.SysLogService;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @Author Devere19
 * @Date 2022/11/23 20:14
 * @Version 1.0
 */
@RestController
@RequestMapping("/api/log")
public class SysLogController {

    @Resource
    private SysLogService sysLogService;

    @GetMapping("getList")
    public HttpResult getList(ListParm listParm){
        return ResultUtils.success("查询成功",sysLogService.getList(listParm));
    }

    @DeleteMapping("delete")
    public HttpResult delete(){
        sysLogService.delete();
        return ResultUtils.success("删除成功");
    }
}
