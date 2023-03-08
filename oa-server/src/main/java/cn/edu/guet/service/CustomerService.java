package cn.edu.guet.service;


import cn.edu.guet.bean.customer.Customer;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:24
 * @Version 1.0
 */
public interface CustomerService extends IService<Customer> {
    Page<Customer> getCustomerData(int currentPage, int pageSize);
    Page<Customer> searchCustomer(int currentPage, int pageSize,String searchWord);
    int addNewCustomer(Customer customer);
    int updateCustomer(Customer customer);
    int deleteOneCustomer(int id);
    Integer checkCustomerCompanyName(String customerCompanyName);
}
