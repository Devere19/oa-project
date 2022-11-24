package cn.edu.guet.service;

import cn.edu.guet.bean.purchaseContract.ExportOutPurchaseContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContractView;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.sql.Date;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【purchase_contract_info】的数据库操作Service
* @createDate 2022-11-02 09:45:29
*/
public interface PurchaseContractViewService extends IService<PurchaseContractView> {
    Page<PurchaseContractView> getTPurchaseContractData(int currentPage, int pageSize);
    Page<PurchaseContractView> getFPurchaseContractData(int currentPage, int pageSize);
    Page<PurchaseContractView> searchPurchaseContract(int currentPage, int pageSize, String searchWord, boolean showPigeonhole, Date startDate, Date endDate);
    List<ExportOutPurchaseContract> purchaseExportExcel(String searchWord, boolean showPigeonhole, Date startDate, Date endDate);
    Boolean checkPurchaseContractNo(String purchaseContractNo);
}
