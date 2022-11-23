package cn.edu.guet.controller;

import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.OfficeExpenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @DeleteMapping("/deleteOneOfficeExpense/{id}")
    public HttpResult deleteOneOfficeExpense(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",officeExpenseService.deleteOneOfficeExpense(id));
    }

    @RequestMapping("/addNewOfficeExpense")
    public HttpResult addNewOfficeExpense(@RequestBody OfficeExpense officeExpense){
        return ResultUtils.success("新增成功",officeExpenseService.addNewOfficeExpense(officeExpense));
    }

    //    APP接口
    @RequestMapping("/getDirectorOE")
    public HttpResult getDirectorOE(int current, int page, int userId ,int type){
        return ResultUtils.success("查询成功",officeExpenseService.getDirectorOE(current,page,userId,type));
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
