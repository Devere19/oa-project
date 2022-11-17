package cn.edu.guet.controller;

import cn.edu.guet.bean.logisticsContract.ListParm;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.LogisticsDetailService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/4 17:33
 * @Version 1.0
 */
@RestController
@RequestMapping("/api/logistics")
public class LogisticsContractController {

    @Resource
    private LogisticsDetailService logisticsDetailService;

    @Resource
    private LogisticsContractService logisticsContractService;

    /**
     * 获取归档位1的分页物流单数据
     *
     * @param listParm
     * @return
     */
    @GetMapping("/list")
    public HttpResult getList(ListParm listParm) {
        IPage<LogisticsContract> list = logisticsContractService.getList(listParm);
        return ResultUtils.success("查询成功", list);
    }

    /**
     * 获取归档位0的分页物流单数据
     *
     * @param listParm
     * @return
     */
    @GetMapping("/searchPigeonholeZero")
    public HttpResult searchPigeonholeZero(ListParm listParm) {
        IPage<LogisticsContract> list = logisticsContractService.searchPigeonholeZero(listParm);
        return ResultUtils.success("查询成功", list);
    }

    /**
     * 修改归档
     * @param id
     * @return
     */
    @PutMapping("/changePigeonhole")
    public HttpResult changePigeonhole(@RequestBody Integer id){
        logisticsContractService.changePigeonhole(id);
        return ResultUtils.success("修改成功");
    }

    /**
     * 删除物流单
     * @param id
     * @return
     */
    @DeleteMapping("/deleteById/{id}")
    public HttpResult deleteById(@PathVariable("id") Integer id){
        int result = logisticsContractService.delete(id);
        if (result==1) {
            return ResultUtils.success("删除成功");
        }else if (result==0){
            return ResultUtils.error("已经有该物流的付款信息，无法删除");
        }else {
            return ResultUtils.error("删除失败");
        }
    }

    /**
     * 根据物流单找到对应的物流详情
     * @param logisticsContractNo
     * @return
     */
    @GetMapping("/getDetailLogistics/{logisticsContractNo}")
    public HttpResult getDetailLogistics(@PathVariable("logisticsContractNo") String logisticsContractNo){
        List<LogisticsDetail> list=logisticsContractService.getDetailLogistics(logisticsContractNo);
        return ResultUtils.success("查询成功",list);
    }

    /**
     * 新增物流单和对应的物流详情
     *
     */
    @PostMapping("/add")
    public HttpResult add(@RequestBody LogisticsContract logisticsContract){
        logisticsContractService.add(logisticsContract);
        return ResultUtils.success("新增成功");
    }





}
