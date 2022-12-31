package cn.edu.guet.service;

import cn.edu.guet.bean.ProcessContract;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import java.sql.Date;

/**
* @author 陶祎祎
* @description 针对表【process_contract】的数据库操作Service
* @createDate 2022-12-11 20:43:57
*/
public interface ProcessContractService extends IService<ProcessContract> {
    int deleteOneProcessContract(int id,int flag);
    int setProcessContractPigeonhole(int id,int pigeonhole);
    int addNewProcessContract(ProcessContract processContract, ProcessContract oldProcessContract, int flag);
    int updateProcessContract(ProcessContract processContract);
    int getProcessDetail(String processContractNo, String goodsName);
    Page<ProcessContract> getTProcessContractData(int currentPage, int pageSize);
    Page<ProcessContract> getFProcessContractData(int currentPage, int pageSize);
    Page<ProcessContract> searchProcessContract(int currentPage, int pageSize, String searchWord, boolean showPigeonhole, Date startDate, Date endDate);
    Boolean checkProcessContractNo(String processContractNo);

    boolean editRelationLogisticsExistState(String processContractNo);
}
