package cn.edu.guet.service;

import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【purchase_contract】的数据库操作Service
* @createDate 2022-10-31 18:18:23
*/
public interface PurchaseContractService extends IService<PurchaseContract> {
    int deleteOnePurchaseContract(int id);
    int deleteMorePurchaseContract(JSONArray ids);
    int setPurchaseContractPigeonhole(int id,int pigeonhole);
}
