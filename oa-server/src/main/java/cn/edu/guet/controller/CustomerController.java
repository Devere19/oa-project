package cn.edu.guet.controller;

import cn.edu.guet.service.CustomerService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

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



}
