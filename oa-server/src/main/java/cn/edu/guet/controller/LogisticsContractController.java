package cn.edu.guet.controller;

import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.LogisticsDetailService;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @Author Devere19
 * @Date 2022/11/4 17:33
 * @Version 1.0
 */
@RestController
public class LogisticsContractController {

    @Resource
    private LogisticsDetailService logisticsDetailService;

    @Resource
    private LogisticsContractService logisticsContractService;


}
