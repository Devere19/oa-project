package cn.edu.guet.service;


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
    int addNewLogisticsPaymentContract(LogisticsPaymentContract purchasePaymentContract);
    int deleteOneLogisticsPaymentContract(int id);

}
