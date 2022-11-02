package cn.edu.guet.controller;

import cn.edu.guet.bean.SysUser;
import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.SaleContractService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @Author Devere19
 * @Date 2022/11/1 11:36
 * @Version 1.0
 */
@RestController
@RequestMapping("/api/saleContract")
public class SaleContractController {

    @Resource
    private SaleContractService saleContractService;

    @GetMapping("/list")
    public HttpResult getList(ListParm listParm) {
        IPage<SaleContract> list = saleContractService.getList(listParm);
        return ResultUtils.success("查询成功", list);
    }

    @PutMapping("/changePigeonhole")
    public HttpResult changePigeonHole(@RequestBody Integer id){
        saleContractService.changePigeonhole(id);
        return ResultUtils.success("修改成功");
    }


}
