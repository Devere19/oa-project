package cn.edu.guet.service;

import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContractView;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【shipping_contract】的数据库操作Service
* @createDate 2022-11-07 12:02:08
*/
public interface ShippingContractService extends IService<ShippingContract> {
    Page<ShippingContract> getshippingContractData(int currentPage, int pageSize);
    Page<ShippingContract> searchShippingContract(int currentPage, int pageSize,String searchWord);
    int addNewShippingContract(ShippingContract shippingContract);
    int deleteOneShippingContract(int id);
    Boolean checkContainerNo(String containerNo);
}
