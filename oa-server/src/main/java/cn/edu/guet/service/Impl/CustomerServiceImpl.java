package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.purchaseContract.InboundDetailInfo;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContractView;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.CustomerMapper;
import cn.edu.guet.mapper.PurchaseContractMapper;
import cn.edu.guet.mapper.SaleContractMapper;
import cn.edu.guet.service.CustomerService;
import cn.edu.guet.util.SecurityUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:24
 * @Version 1.0
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private PurchaseContractMapper purchaseContractMapper;

    @Autowired
    private SaleContractMapper saleContractMapper;

    @Override
    public Page<Customer> getCustomerData(int currentPage, int pageSize) {
        QueryWrapper<Customer> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<Customer> page =new Page<>(currentPage,pageSize);
        page=customerMapper.selectPage(page,qw);
        return page;
    }

    @Override
    public Page<Customer> searchCustomer(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<Customer> qw= new QueryWrapper<>();
        qw.like("customer_enterprise_name",searchWord).or().like("customer_name",searchWord)
                .or().like("customer_phone",searchWord).or().like("customer_address",searchWord)
                .or().like("create_by",searchWord).orderByDesc("create_time");
        Page<Customer> page =new Page<>(currentPage,pageSize);
        page=customerMapper.selectPage(page,qw);
        return page;
    }

    @Override
    public int addNewCustomer(Customer customer) {
        customer.setCreateBy(SecurityUtils.getUsername());
        customer.setLastUpdateBy(SecurityUtils.getUsername());
        return customerMapper.insert(customer);
    }

    @Override
    public int updateCustomer(Customer customer) {
        Customer data =customerMapper.selectById(customer.getId());
        data.setCustomerEnterpriseName(customer.getCustomerEnterpriseName());
        data.setCustomerName(customer.getCustomerName());
        data.setCustomerPhone(customer.getCustomerPhone());
        data.setCustomerAddress(customer.getCustomerAddress());
        data.setLastUpdateBy(SecurityUtils.getUsername());
        return customerMapper.updateById(data);
    }

    @Override
    public int deleteOneCustomer(int id) {
        int result=-1;

        QueryWrapper<PurchaseContract> purchaseContractQueryWrapper= new QueryWrapper<>();
        purchaseContractQueryWrapper.eq("supplier_no",id);
        List<PurchaseContract> purchaseContractList=purchaseContractMapper.selectList(purchaseContractQueryWrapper);

        if(purchaseContractList.isEmpty()){
            QueryWrapper<SaleContract> saleContractQueryWrapper= new QueryWrapper<>();
            saleContractQueryWrapper.eq("sale_customer_id",id);
            List<SaleContract> saleContractList=saleContractMapper.selectList(saleContractQueryWrapper);

            if(saleContractList.isEmpty()){
                result=customerMapper.deleteById(id);
            }
        }

        return result;
    }

    @Override
    public Integer checkCustomerCompanyName(String customerCompanyName) {
        QueryWrapper<Customer> qw = new QueryWrapper<>();
        qw.eq("customer_enterprise_name", customerCompanyName);
        Customer customer = customerMapper.selectOne(qw);
        if(customer==null){
            return 0;
        }else{
            return customer.getId();
        }
    }
}
