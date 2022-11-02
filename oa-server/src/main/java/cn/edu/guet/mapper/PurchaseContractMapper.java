package cn.edu.guet.mapper;

import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author 陶祎祎
* @description 针对表【purchase_contract】的数据库操作Mapper
* @createDate 2022-10-31 18:18:23
* @Entity cn.edu.guet.bean.purchaseContract.PurchaseContract
*/
@Mapper
public interface PurchaseContractMapper extends BaseMapper<PurchaseContract> {

}




