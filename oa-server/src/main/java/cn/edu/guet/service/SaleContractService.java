package cn.edu.guet.service;

import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @Author Devere19
 * @Date 2022/11/1 11:34
 * @Version 1.0
 */
public interface SaleContractService extends IService<SaleContract> {
    /**
     * 分页查询销售单
     * @param listParm
     * @return
     */
    IPage<SaleContract> getList(ListParm listParm);

    /**
     * 修改归档数据  0表示隐藏  1表示显示  默认显示为1的数据
     * @param id
     */
    void changePigeonhole(Integer id);
}
