package cn.edu.guet.service;

import cn.edu.guet.bean.logisticsContract.ListParm;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;

import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

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
}
