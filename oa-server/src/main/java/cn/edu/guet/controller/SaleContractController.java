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

    /**
     * 获取归档位1的分页销售单数据
     * @param listParm
     * @return
     */
    @GetMapping("/list")
    public HttpResult getList(ListParm listParm) {
        IPage<SaleContract> list = saleContractService.getList(listParm);
        return ResultUtils.success("查询成功", list);
    }

    /**
     * 修改销售单的归档数据
     * @param id
     * @return
     */
    @PutMapping("/changePigeonhole")
    public HttpResult changePigeonHole(@RequestBody Integer id){
        saleContractService.changePigeonhole(id);
        return ResultUtils.success("修改成功");
    }

    /**
     * 获取归档位0的分页销售单数据
     * @param listParm
     * @return
     */
    @GetMapping("/searchPigeonholeZero")
    public HttpResult searchPigeonholeZero(ListParm listParm) {
        IPage<SaleContract> list = saleContractService.searchPigeonholeZero(listParm);
        return ResultUtils.success("查询成功", list);
    }

    @DeleteMapping("/deleteById/{id}")
    public HttpResult deleteByIdApi(@PathVariable("id") Integer id){
        if (saleContractService.removeById(id)){
            return ResultUtils.success("删除成功");
        }else {
            return ResultUtils.error("删除失败");
        }
    }



}
