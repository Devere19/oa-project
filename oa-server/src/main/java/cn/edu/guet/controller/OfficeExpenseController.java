package cn.edu.guet.controller;

import cn.edu.guet.bean.ImportModel.ImportLogisticsPaymentContractModel;
import cn.edu.guet.bean.ImportModel.ImportOfficeExpenseModel;
import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.OfficeExpenseService;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/officeExpense")
public class OfficeExpenseController {

    @Autowired
    private OfficeExpenseService officeExpenseService;

    //    获取办公经费单数据
    @RequestMapping("/getOfficeExpenseData")
    public HttpResult getOfficeExpenseData(int current, int page){
        return ResultUtils.success("查询成功",officeExpenseService.getOfficeExpenseData(current,page));
    }

    @RequestMapping("/searchOfficeExpense")
    public HttpResult searchOfficeExpense(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",officeExpenseService.searchOfficeExpense(current,page,searchWord));
    }

    @RequestMapping("/officeExpenseImportExcel")
    public HttpResult officeExpenseImportExcel(@RequestBody MultipartFile file) throws IOException {
        EasyExcel.read(file.getInputStream(), ImportOfficeExpenseModel.class, new PageReadListener<ImportOfficeExpenseModel>(dataList -> {
            System.out.println(dataList.size());
            for (ImportOfficeExpenseModel importOfficeExpenseModel : dataList) {
                if(importOfficeExpenseModel.getItemsList()==null){
                    break;
                }
                System.out.println(officeExpenseService.handleImportOfficeExpenseModel(importOfficeExpenseModel));
            }
        })).sheet().doRead();
        return ResultUtils.success("批量插入办公经费单成功");
    }

    @DeleteMapping("/deleteOneOfficeExpense/{id}")
    public HttpResult deleteOneOfficeExpense(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",officeExpenseService.deleteOneOfficeExpense(id));
    }

    @RequestMapping("/addNewOfficeExpense")
    public HttpResult addNewOfficeExpense(@RequestBody OfficeExpense officeExpense){
        return ResultUtils.success("新增成功",officeExpenseService.addNewOfficeExpense(officeExpense));
    }

    @RequestMapping("/updateOfficeExpense")
    public HttpResult updateOfficeExpense(@RequestBody OfficeExpense officeExpense){
        return ResultUtils.success("修改成功",officeExpenseService.updateOfficeExpense(officeExpense));
    }

    //    APP接口
    @RequestMapping("/getDirectorOE")
    public HttpResult getDirectorOE(int current, int page, int userId ,int type){
        return ResultUtils.success("查询成功",officeExpenseService.getDirectorOE(current,page,userId,type));
    }

    @RequestMapping("/getOneDirectorOE")
    public HttpResult getOneDirectorOE(int id){
        return ResultUtils.success("查询成功",officeExpenseService.getOneDirectorOE(id));
    }

    @RequestMapping("/searchDirectorOE")
    public HttpResult searchDirectorOE(int current, int page,String searchWord,int userId){
        return ResultUtils.success("查询成功",officeExpenseService.searchDirectorOE(current,page,searchWord,userId));
    }

    //审批
    @RequestMapping("/changeFinanceState")
    public  HttpResult changeFinanceState(int id,String financeStaff){
        return ResultUtils.success("已通过",officeExpenseService.changeFinanceState(id,financeStaff));
    }

    @RequestMapping("/changeDirectorState")
    public  HttpResult changeDirectorState(int officeExpenseId, int userId)  {
        return ResultUtils.success("已通过", officeExpenseService.changeDirectorState(officeExpenseId, userId));
    }
}
