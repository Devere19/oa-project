package cn.edu.guet.bean.sale.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Devere19
 * @Date 2022/10/23 10:41
 * @Version 1.0
 */
@RestController("/a")
public class TestController {

    @GetMapping("/a")
    public String a(){
        return "aaaa";
    }
}
