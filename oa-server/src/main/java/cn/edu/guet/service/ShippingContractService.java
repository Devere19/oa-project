package cn.edu.guet.service;

import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.bean.PurchasePaymentContractView;
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

    //    出纳
    Page<ShippingContract> getCashierShipping(int currentPage, int pageSize);
    Page<ShippingContract> searchCashierShipping(int currentPage, int pageSize,String searchWord);
    int uploadCashierShipping(ShippingContract shippingContract);

    //    APP
    Page<ShippingContract> getDirectorSC(int currentPage, int pageSize, int userId ,int type);

    //审批
    int changeFinanceState(String shippingContractNo,String financeStaff);
    int changeDirectorState(String shippingContractNo,int userId);
}
