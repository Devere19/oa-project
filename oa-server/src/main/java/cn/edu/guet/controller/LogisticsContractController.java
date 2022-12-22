package cn.edu.guet.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.edu.guet.bean.ImportModel.ImportPurchaseContractModel;
import cn.edu.guet.bean.logisticsContract.*;

import cn.edu.guet.bean.sale.ExportOutSaleContract;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.LogisticsDetailService;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
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
    @PostMapping("/list")
    public HttpResult getList(@RequestBody ListParm listParm) {
        IPage<LogisticsContract> list = logisticsContractService.getList(listParm);
        return ResultUtils.success("查询成功", list);
    }

    /**
     * 获取归档位0的分页物流单数据
     *
     * @param listParm
     * @return
     */
    @PostMapping("/searchPigeonholeZero")
    public HttpResult searchPigeonholeZero(@RequestBody ListParm listParm) {
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
        String fileName = "物流单.xlsx";
        ExportParams exportParams = new ExportParams();
        exportParams.setType(ExcelType.XSSF);
        Workbook workbook = ExcelExportUtil.exportExcel(exportParams, ExportOutLogisticsContract.class, logisticsContractService.getExportList(listParm));
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

    @RequestMapping("/logisContractImportExcel")
    public HttpResult purchaseImportExcel(@RequestBody MultipartFile file) throws IOException {

        return ResultUtils.success("批量插入采购单成功");
    }





}
