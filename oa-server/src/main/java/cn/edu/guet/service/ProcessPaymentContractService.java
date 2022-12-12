package cn.edu.guet.service;

import cn.edu.guet.bean.ProcessPaymentContract;
import cn.edu.guet.bean.ProcessPaymentContract;
import cn.edu.guet.bean.ProcessPaymentContractView;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【process_payment_contract】的数据库操作Service
* @createDate 2022-12-11 20:43:57
*/
public interface ProcessPaymentContractService extends IService<ProcessPaymentContract> {
    Page<ProcessPaymentContractView> getProcessPaymentContractData(int currentPage, int pageSize);
    Page<ProcessPaymentContractView> searchProcessPaymentContract(int currentPage, int pageSize,String searchWord);
    int addNewProcessPaymentContract(ProcessPaymentContract processPaymentContract);
    int updateProcessPaymentContract(ProcessPaymentContract processPaymentContract);
    int deleteOneProcessPaymentContract(int id);
    ProcessPaymentContractView getOneProcessPaymentContract(int id);

    //    出纳
    Page<ProcessPaymentContractView> getCashierProcessPayment(int currentPage, int pageSize);
    Page<ProcessPaymentContractView> searchCashierProcessPayment(int currentPage, int pageSize,String searchWord);
    int uploadCashierProcessPayment(ProcessPaymentContract processPaymentContract);

    //审批
    int changeFinanceState(int id,String financeStaff);
    int changeDirectorState(int processPaymentContractId,int userId);


    //    APP
    Page<ProcessPaymentContractView> getDirectorPPC(int currentPage, int pageSize, int userId ,int type);
    ProcessPaymentContractView getOneDirectorPPC(int id);
    Page<ProcessPaymentContractView> searchDirectorPPC(int currentPage, int pageSize ,String searchWord, int userId);
}
