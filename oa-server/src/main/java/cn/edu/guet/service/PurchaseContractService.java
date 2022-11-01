package cn.edu.guet.service;

import cn.edu.guet.bean.PurchaseContract;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【purchase_contract】的数据库操作Service
* @createDate 2022-10-31 18:18:23
*/
public interface PurchaseContractService extends IService<PurchaseContract> {
    Page<PurchaseContract> getPurchaseContractData(int currentPage, int pageSize);
    Page<PurchaseContract> searchPurchaseContract(int currentPage, int pageSize,String searchWord);
}
