package cn.edu.guet.service.Impl;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.service.PurchaseContractService;
import cn.edu.guet.mapper.PurchaseContractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @author 陶祎祎
* @description 针对表【purchase_contract】的数据库操作Service实现
* @createDate 2022-10-31 18:18:23
*/
@Service
public class PurchaseContractServiceImpl extends ServiceImpl<PurchaseContractMapper, PurchaseContract>
    implements PurchaseContractService{

    @Autowired
    private PurchaseContractMapper purchaseContractMapper;

    @Override
    public int deleteOnePurchaseContract(int id) {
        return purchaseContractMapper.deleteById(id);
    }

    @Override
    public int deleteMorePurchaseContract(JSONArray ids) {
        LambdaQueryWrapper<PurchaseContract> lambdaQueryWrapper=new LambdaQueryWrapper<>();
        lambdaQueryWrapper.in(PurchaseContract::getId,ids);
        return purchaseContractMapper.delete(lambdaQueryWrapper);
    }

    @Override
    public int setPurchaseContractPigeonhole(int id, int pigeonhole) {
        PurchaseContract purchaseContract=purchaseContractMapper.selectById(id);
        if(pigeonhole==1){
            purchaseContract.setPigeonhole(0);
        }else{
            purchaseContract.setPigeonhole(1);
        }
        return purchaseContractMapper.updateById(purchaseContract);
    }
}




