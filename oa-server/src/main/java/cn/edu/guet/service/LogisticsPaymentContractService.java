package cn.edu.guet.service;

import cn.edu.guet.bean.ImportModel.ImportLogisticsPaymentContractModel;
import cn.edu.guet.bean.LogisticsPaymentContract;
import cn.edu.guet.bean.LogisticsPaymentContractView;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【logistics_payment_contract】的数据库操作Service
* @createDate 2022-11-12 21:15:26
*/
public interface LogisticsPaymentContractService extends IService<LogisticsPaymentContract> {
    Page<LogisticsPaymentContractView> getLogisticsPaymentContractData(int currentPage, int pageSize);
    Page<LogisticsPaymentContractView> searchLogisticsPaymentContract(int currentPage, int pageSize,String searchWord);
    int addNewLogisticsPaymentContract(LogisticsPaymentContract logisticsPaymentContract);
    int updateLogisticsPaymentContract(LogisticsPaymentContract logisticsPaymentContract);
    int deleteOneLogisticsPaymentContract(int id);
    LogisticsPaymentContractView getOneLogisticsPaymentContract(int id);
    int handleImportLogisticsPaymentContractModel(ImportLogisticsPaymentContractModel importLogisticsPaymentContractModel);

    //    出纳
    Page<LogisticsPaymentContractView> getCashierLogisticsPayment(int currentPage, int pageSize);
    Page<LogisticsPaymentContractView> searchCashierLogisticsPayment(int currentPage, int pageSize,String searchWord);
    int uploadCashierLogisticsPayment(LogisticsPaymentContract logisticsPaymentContract);

    //    APP
    Page<LogisticsPaymentContractView> getDirectorLPC(int currentPage, int pageSize, int userId , int type);
    LogisticsPaymentContractView getOneDirectorLPC(int id);
    Page<LogisticsPaymentContractView> searchDirectorLPC(int currentPage, int pageSize, String searchWord, int userId);

    //审批
    int changeFinanceState(int id,String financeStaff);
    int changeDirectorState(int logisticsPaymentContractId,int userId);
}
