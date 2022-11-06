package cn.edu.guet.controller;

import cn.edu.guet.bean.SysUser;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.SaleContractService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.coyote.Response;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

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
     *
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
     *
     * @param id
     * @return
     */
    @PutMapping("/changePigeonhole")
    public HttpResult changePigeonHole(@RequestBody Integer id) {
        System.out.println(id);
        saleContractService.changePigeonhole(id);
        return ResultUtils.success("修改成功");
    }

    /**
     * 获取归档位0的分页销售单数据
     *
     * @param listParm
     * @return
     */
    @GetMapping("/searchPigeonholeZero")
    public HttpResult searchPigeonholeZero(ListParm listParm) {
        IPage<SaleContract> list = saleContractService.searchPigeonholeZero(listParm);
        return ResultUtils.success("查询成功", list);
    }

    /**
     * 根据id 删除某个销售单
     *
     * @param id
     * @return
     */
    @DeleteMapping("/deleteById/{id}")
    public HttpResult deleteByIdApi(@PathVariable("id") Integer id) {
        if (saleContractService.removeById(id)) {
            return ResultUtils.success("删除成功");
        } else {
            return ResultUtils.error("删除失败");
        }
    }

    //新增销售单
    @PostMapping("add")
    public HttpResult add(@RequestBody SaleContract saleContract) {
        boolean result = saleContractService.add(saleContract);
        if (result) {
            return ResultUtils.success("新增成功");
        } else {
            return ResultUtils.error("新增失败");
        }
    }

    /**
     * 获取当前销售单下的已出库量
     * @param saleContractNo
     * @return
     */
    @GetMapping("/getRemainingOutboundVolume/{saleContractNo}")
    public HttpResult getRemainingOutboundVolume(@PathVariable("saleContractNo") String saleContractNo) {
        BigDecimal result = saleContractService.getRemainingOutboundVolume(saleContractNo);
        return ResultUtils.success("查询成功",result);
    }


    /**
     * 根据销售合同编号查到所有的物流详情表
     * @param saleContractNo
     * @return
     */
    @GetMapping("/getDetailSaleContract/{saleContractNo}")
    public HttpResult getDetailSaleContract(@PathVariable("saleContractNo") String saleContractNo) {
        //根据销售合同找到所有的物流单，再根据物流合同找到所有的物流详情表
        return ResultUtils.success("查询成功",saleContractService.getDetailSaleContract(saleContractNo));
    }


}
