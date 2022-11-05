package cn.edu.guet.controller;

import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.customer.SelectCustomer;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.CustomerService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
        List<SelectCustomer> selectCustomerList = new ArrayList<>();
        for (Customer customer : customerService.list()) {
            SelectCustomer selectCustomer = new SelectCustomer();
            selectCustomer.setLabel(customer.getCustomerEnterpriseName());
            selectCustomer.setValue(String.valueOf(customer.getId()));
            selectCustomerList.add(selectCustomer);
        }
        return ResultUtils.success("查询成功",selectCustomerList);
    }

}
