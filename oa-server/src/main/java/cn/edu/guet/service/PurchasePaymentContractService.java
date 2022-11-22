package cn.edu.guet.service;


import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.bean.PurchasePaymentContractView;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【purchase_payment_contract】的数据库操作Service
* @createDate 2022-11-10 20:41:25
*/
public interface PurchasePaymentContractService extends IService<PurchasePaymentContract> {
    Page<PurchasePaymentContractView> getPurchasePaymentContractData(int currentPage, int pageSize);
    Page<PurchasePaymentContractView> searchPurchasePaymentContract(int currentPage, int pageSize,String searchWord);
    int addNewPurchasePaymentContract(PurchasePaymentContract purchasePaymentContract);
    int deleteOnePurchasePaymentContract(int id);

//    出纳
    Page<PurchasePaymentContractView> getCashierPurchasePayment(int currentPage, int pageSize);
    Page<PurchasePaymentContractView> searchCashierPurchasePayment(int currentPage, int pageSize,String searchWord);
    int uploadCashierPurchasePayment(PurchasePaymentContract purchasePaymentContract);
    int changeFinanceState(String purchaseContractNo);
    int changeDirectorState(int purchasePaymentContractId,int userId);
}
