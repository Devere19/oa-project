package cn.edu.guet.mapper;

import cn.edu.guet.bean.customer.Customer;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * @Author Devere19
 * @Date 2022/11/1 13:23
 * @Version 1.0
 */
@Mapper
public interface CustomerMapper extends BaseMapper<Customer> {
}
