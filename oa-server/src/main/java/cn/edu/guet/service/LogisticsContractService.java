package cn.edu.guet.service;

import cn.edu.guet.bean.ImportModel.ImportLogisticsContractModel;
import cn.edu.guet.bean.logisticsContract.*;

import cn.edu.guet.http.HttpResult;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Collection;
import java.util.List;

/**
* @author 郭乐源
* @description 针对表【logistics_contract】的数据库操作Service
* @createDate 2022-11-04 17:10:25
*/
public interface LogisticsContractService extends IService<LogisticsContract> {

    /**
     * 分页查询 查询归档维1的数据
     * @param listParm
     * @return
     */
    IPage<LogisticsContract> getList(ListParm listParm);

    /**
     * 分页查询 查询归档维0的数据
     * @param listParm
     * @return
     */
    IPage<LogisticsContract> searchPigeonholeZero(ListParm listParm);

    /**
     * 归档 修改归档
     * @param id
     */
    void changePigeonhole(Integer id);

    /**
     * 根据物流单得到所有的物流详情
     * @param logisticsContractNo
     * @return
     */
    List<LogisticsDetail> getDetailLogistics(String logisticsContractNo);

    /**
     * 新增物流单和物流详情但
     * @param logisticsContract
     */
    HttpResult add(LogisticsContract logisticsContract);

    /**
     * 检查物流合同单号是否存在*
     * @param logisticsContractNo
     * @return
     */
    Boolean checkLogisticsContractNo(String logisticsContractNo);

    /**
     * 检查物流合同单号是否存在*
     * @param logisticsContractNo
     * @return
     */
    int shippingCheckLogisticsContractNo(String logisticsContractNo);

    /**
     * 删除，同时删除对应的物流详情和对应的自家舱和和外商仓库的出入库记录和库存
     * @param id
     * @return  0 已经有付款单了  1 正常删除   -1 删除失败
     */
    int delete(Integer id);

    /**
     * 导出excel
     * @param listParm
     * @return
     */
    List<ExportOutLogisticsContract> getExportList(ExportListParm listParm);

    /**
     *  //判断是否还有和该物流单一样的销售合同的物流单，如果有的话，正常进行，如果没有，需要把销售单的isHaveLogistics修改为0
     * @param saleContractNo
     */
    void isHaveAnyLogistics(String saleContractNo);

    /**
     * 新增物流单是加工单类型
     * @param logisticsContract
     * @return
     */
    HttpResult addProcessLogisticsContract(LogisticsContract logisticsContract);

    /**
     * 新增物流单是销售单类型/运往自家仓库
     * @param logisticsContract
     * @return
     */
    HttpResult addLogisticsContract(LogisticsContract logisticsContract);

    /**
     * 删除物流单
     * @param id
     * @return
     */
    boolean deleteById(Integer id);

    /**
     * 更新物流单  先删除再新增
     * @param logisticsContract
     * @return
     */
    HttpResult updateLogistics(LogisticsContract logisticsContract);

    boolean handleImportLogisticsContractModel(ImportLogisticsContractModel importLogisticsContractModel) ;

}
