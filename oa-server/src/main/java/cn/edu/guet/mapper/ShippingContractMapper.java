package cn.edu.guet.mapper;

import cn.edu.guet.bean.ShippingContract;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【shipping_contract】的数据库操作Mapper
* @createDate 2022-11-07 12:02:08
* @Entity cn.edu.guet.bean.ShippingContract
*/
@Mapper
public interface ShippingContractMapper extends BaseMapper<ShippingContract> {
    List<ShippingContract> checkContainerNo(String containerNo);
}




