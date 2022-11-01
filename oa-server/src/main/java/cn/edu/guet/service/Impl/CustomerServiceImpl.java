package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.mapper.CustomerMapper;
import cn.edu.guet.service.CustomerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:24
 * @Version 1.0
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {
}
