package cn.edu.guet.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.edu.guet.bean.SysUser;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.sale.ExportListParm;
import cn.edu.guet.bean.sale.ExportOutSaleContract;
import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.SaleContractService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.commons.lang.StringUtils;
import org.apache.coyote.Response;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.net.URLEncoder;
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

    @Resource
    private LogisticsContractService logisticsContractService;

    /**
     * 获取归档位1的分页销售单数据
     *
     * @param listParm
     * @return
     */
    @PostMapping("/list")
    public HttpResult getList(@RequestBody ListParm listParm) {
        System.out.println("拿到的listParm："+listParm);
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
    @PostMapping("/searchPigeonholeZero")
    public HttpResult searchPigeonholeZero(@RequestBody ListParm listParm) {
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
        //判断是否有物流，如果有不允许删除

        //根据id拿到销售单号
        QueryWrapper<SaleContract> saleContractQueryWrapper = new QueryWrapper<>();
        saleContractQueryWrapper.lambda().eq(SaleContract::getId, id);
        SaleContract one = saleContractService.getOne(saleContractQueryWrapper);
        String saleContractNo = one.getSaleContractNo();
        QueryWrapper<LogisticsContract> logisticsContractQueryWrapper = new QueryWrapper<>();
        logisticsContractQueryWrapper.lambda().eq(LogisticsContract::getSaleContractNo, saleContractNo);
        List<LogisticsContract> list = logisticsContractService.list(logisticsContractQueryWrapper);
        if (list.size()>0) {
            return ResultUtils.error("该销售单已经有物流信息，不允许删除");
        }
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
     *
     * @param saleContractNo
     * @return
     */
    @GetMapping("/getRemainingOutboundVolume/{saleContractNo}")
    public HttpResult getRemainingOutboundVolume(@PathVariable("saleContractNo") String saleContractNo) {
        BigDecimal result = saleContractService.getRemainingOutboundVolume(saleContractNo);
        return ResultUtils.success("查询成功", result);
    }


    /**
     * 根据销售合同编号查到所有的物流详情表
     *
     * @param saleContractNo
     * @return
     */
    @GetMapping("/getDetailSaleContract/{saleContractNo}")
    public HttpResult getDetailSaleContract(@PathVariable("saleContractNo") String saleContractNo) {
        //根据销售合同找到所有的物流单，再根据物流合同找到所有的物流详情表
        return ResultUtils.success("查询成功", saleContractService.getDetailSaleContract(saleContractNo));
    }

    @PostMapping("/exportListParm")
    public HttpResult ExportExcel(HttpServletRequest request,@RequestBody ExportListParm listParm) throws Exception {
        request.getServletContext().setAttribute("listParm",listParm);
        System.out.println("存进的全局属性："+listParm);
        return ResultUtils.success("传递参数成功");
    }
    /**
     * 导出为Excel表格
     * @param response
     * @throws Exception
     */
    @GetMapping("/exportExcel")
    public void ExportExcel(HttpServletResponse response, HttpServletRequest request) throws Exception {
        ExportListParm listParm = (ExportListParm) request.getServletContext().getAttribute("listParm");
        System.out.println("拿到的全局数据:"+listParm);
        // 导出
        String fileName = "销售单.xlsx";
        ExportParams exportParams = new ExportParams();
        exportParams.setType(ExcelType.XSSF);
        Workbook workbook = ExcelExportUtil.exportExcel(exportParams, ExportOutSaleContract.class, saleContractService.getExportList(listParm));
        downloadExcel(fileName, workbook, response);
    }

    public static void downloadExcel(String fileName, Workbook workbook, HttpServletResponse response) throws Exception {
        try {
            if (StringUtils.isEmpty(fileName)) {
                throw new RuntimeException("导出文件名不能为空");
            }
            String encodeFileName = URLEncoder.encode(fileName, "UTF-8");
            response.setHeader("content-Type", "application/vnd.ms-excel; charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + encodeFileName);
            response.setHeader("FileName", encodeFileName);
            response.setHeader("Access-Control-Expose-Headers", "FileName");
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            workbook.close();
        }
    }


}
