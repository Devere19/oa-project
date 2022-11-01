package cn.edu.guet.controller;

import cn.edu.guet.service.SaleContractService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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



}
