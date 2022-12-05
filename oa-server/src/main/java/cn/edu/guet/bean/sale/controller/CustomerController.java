package cn.edu.guet.bean.sale.controller;

import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.customer.SelectModel;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.CustomerService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:25
 * @Version 1.0
 */
@RestController
@RequestMapping("/api/customer")
public class CustomerController {
    @Resource
    private CustomerService customerService;

    @GetMapping("/getSelect")
    public HttpResult getSelect(){
        List<SelectModel> selectModelList = new ArrayList<>();
        for (Customer customer : customerService.list()) {
            SelectModel selectModel = new SelectModel();
            selectModel.setLabel(customer.getCustomerEnterpriseName());
            selectModel.setValue(customer.getCustomerEnterpriseName());
            selectModelList.add(selectModel);
        }
        return ResultUtils.success("查询成功",selectModelList);
    }

    //    获取客户数据
    @RequestMapping("/getCustomerData")
    public HttpResult getCustomerData(int current, int page){
        return ResultUtils.success("查询成功",customerService.getCustomerData(current,page));
    }

    @RequestMapping("/searchCustomer")
    public HttpResult searchCustomer(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",customerService.searchCustomer(current,page,searchWord));
    }

    @DeleteMapping("/deleteOneCustomer/{id}")
    public HttpResult deleteOneCustomer(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",customerService.deleteOneCustomer(id));
    }

    @RequestMapping("/addNewCustomer")
    public HttpResult addNewCustomer(@RequestBody Customer customer){
        return ResultUtils.success("新增成功",customerService.addNewCustomer(customer));
    }

    @RequestMapping("/updateCustomer")
    public HttpResult updateCustomer(@RequestBody Customer customer){
        return ResultUtils.success("更新成功",customerService.updateCustomer(customer));
    }

    @RequestMapping("/checkCustomerCompanyName")
    public HttpResult checkCustomerCompanyName(String customerCompanyName){
        return ResultUtils.success("获取成功",customerService.checkCustomerCompanyName(customerCompanyName));
    }
}
