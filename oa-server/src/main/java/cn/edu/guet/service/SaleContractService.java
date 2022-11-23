package cn.edu.guet.service;

import cn.edu.guet.bean.cashier.sale.SaleModel;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/1 11:34
 * @Version 1.0
 */
public interface SaleContractService extends IService<SaleContract> {
    /**
     * 分页查询销售单 归档为1
     * @param listParm
     * @return
     */
    IPage<SaleContract> getList(ListParm listParm);

    /**
     * 修改归档数据  0表示隐藏  1表示显示  默认显示为1的数据
     * @param id
     */
    void changePigeonhole(Integer id);

    /**
     * 分页查询销售单 归档为0
     * @param listParm
     * @return
     */
    IPage<SaleContract> searchPigeonholeZero(ListParm listParm);

    /**
     * 新增
     * @param saleContract
     */
    boolean add(SaleContract saleContract);

    /**
     * 根据销售单拿到所有的物流信息的已出货量
     * @param saleContractNo
     * @return
     */
    BigDecimal getRemainingOutboundVolume(String saleContractNo);

    /**
     * 根据销售合同编号查到所有的物流详情表
     * @param saleContractNo
     * @return
     */
    List<LogisticsDetail> getDetailSaleContract(String saleContractNo);

    IPage<SaleContract> getCashierSaleContract(ListParm listParm);

    int editCashierSale(SaleModel saleModel);
}
