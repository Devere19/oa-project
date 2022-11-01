package cn.edu.guet.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.edu.guet.bean.PurchaseContract;
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
    public Page<PurchaseContract> getPurchaseContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchaseContract> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<PurchaseContract> page =new Page<>(currentPage,pageSize);
        page=purchaseContractMapper.selectPage(page,qw);
        return page;
    }

    @Override
    public Page<PurchaseContract> searchPurchaseContract(int currentPage, int pageSize,String searchWord) {
        QueryWrapper<PurchaseContract> qw= new QueryWrapper<>();
        qw.like("purchase_contract_no",searchWord).or().like("supplier",searchWord).or()
                .like("own_company_name",searchWord).or().like("squeeze_season",searchWord).or()
                .like("goods_name",searchWord).or().like("create_by",searchWord).orderByDesc("create_time");
        Page<PurchaseContract> page =new Page<>(currentPage,pageSize);
        page=purchaseContractMapper.selectPage(page,qw);
        return page;
    }
}




