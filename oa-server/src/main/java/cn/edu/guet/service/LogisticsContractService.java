package cn.edu.guet.service;

import cn.edu.guet.bean.logisticsContract.*;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

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
    void add(LogisticsContract logisticsContract);

    Boolean checkLogisticsContractNo(String logisticsContractNo);

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

}
