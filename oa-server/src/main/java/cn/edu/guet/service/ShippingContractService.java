package cn.edu.guet.service;

import cn.edu.guet.bean.CashierShipping;
import cn.edu.guet.bean.ImportModel.ImportShippingContractModel;
import cn.edu.guet.bean.ShippingContract;
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
    int addNewShippingContract(ShippingContract shippingContract,ShippingContract oldShippingContract,int flag);
    int updateShippingContract(ShippingContract shippingContract);
    int deleteOneShippingContract(int id,int flag);
    ShippingContract getOneShippingContract(int id);
    Boolean checkContainerNo(String containerNo);
    int handleImportShippingContractModel(ImportShippingContractModel importShippingContractModel);
    Boolean checkShippingContractNo(String shippingContractNo);

    //    出纳
    Page<CashierShipping> getCashierShipping(int currentPage, int pageSize);
    Page<CashierShipping> searchCashierShipping(int currentPage, int pageSize,String searchWord);
    int uploadCashierShipping(ShippingContract shippingContract);

    //    APP
    Page<CashierShipping> getDirectorSC(int currentPage, int pageSize, int userId ,int type);
    ShippingContract getOneDirectorSC(int id);
    Page<CashierShipping> searchDirectorSC(int currentPage, int pageSize ,String searchWord, int userId);

    //审批
    int changeFinanceState(String shippingContractNo,String financeStaff);
    int changeDirectorState(String shippingContractNo,int userId);
}
