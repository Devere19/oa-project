package cn.edu.guet.service.Impl;


import cn.edu.guet.bean.LogisticsPaymentContract;
import cn.edu.guet.bean.ProcessContract;
import cn.edu.guet.bean.logisticsContract.*;
import cn.edu.guet.bean.other.OtherInOut;
import cn.edu.guet.bean.other.OtherWarehouse;
import cn.edu.guet.bean.own.OwnInOut;
import cn.edu.guet.bean.own.OwnWarehouse;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.SaleContractService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.web.PortResolverImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author 郭乐源
 * @description 针对表【logistics_contract】的数据库操作Service实现
 * @createDate 2022-11-04 17:10:25
 */
@Service
public class LogisticsContractServiceImpl extends ServiceImpl<LogisticsContractMapper, LogisticsContract> implements LogisticsContractService {

    @Resource
    private LogisticsContractMapper logisticsContractMapper;
    @Resource
    private LogisticsDetailMapper logisticsDetailMapper;
    @Resource
    private SaleContractMapper saleContractMapper;
    @Resource
    private OwnWarehouseMapper ownWarehouseMapper;
    @Resource
    private PurchaseContractMapper purchaseContractMapper;
    @Resource
    private OwnInOutMapper ownInOutMapper;
    @Resource
    private OtherWarehouseMapper otherWarehouseMapper;
    @Resource
    private OtherInOutMapper otherInOutMapper;
    @Resource
    private LogisticsPaymentContractMapper logisticsPaymentContractMapper;
    @Resource
    private ProcessContractMapper processContractMapper;

    @Override
    public IPage<LogisticsContract> getList(ListParm listParm) {
        Page<LogisticsContract> page = new Page<>(listParm.getCurrentPage(), listParm.getPageSize());
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        //构造查询条件
        //物流单合同编号
        if (StringUtils.isNotEmpty(listParm.getLogisticsContractNo())) {
            query.lambda().like(LogisticsContract::getLogisticsContractNo, listParm.getLogisticsContractNo());
        }

        //销售单合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(LogisticsContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(LogisticsContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(LogisticsContract::getLogisticsContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(LogisticsContract::getLogisticsContractTime, format);
        }
        //查看归档为1的数据
        query.lambda().eq(LogisticsContract::getPigeonhole, 1);
        query.orderByDesc("id");

        Page<LogisticsContract> logisticsContractPage = logisticsContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (LogisticsContract record : logisticsContractPage.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            record.setContractPhotoList(Arrays.asList(contractPhoto));
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoList(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }
        }
        return logisticsContractPage;

    }

    @Override
    public IPage<LogisticsContract> searchPigeonholeZero(ListParm listParm) {
        Page<LogisticsContract> page = new Page<>(listParm.getCurrentPage(), listParm.getPageSize());
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        //构造查询条件
        //物流单合同编号
        if (StringUtils.isNotEmpty(listParm.getLogisticsContractNo())) {
            query.lambda().like(LogisticsContract::getLogisticsContractNo, listParm.getLogisticsContractNo());
        }

        //销售单合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(LogisticsContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(LogisticsContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(LogisticsContract::getLogisticsContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(LogisticsContract::getLogisticsContractTime, format);
        }
        //查看归档为1的数据
        query.lambda().eq(LogisticsContract::getPigeonhole, 0);
        query.orderByDesc("id");

        Page<LogisticsContract> logisticsContractPage = logisticsContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (LogisticsContract record : logisticsContractPage.getRecords()) {

            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            record.setContractPhotoList(Arrays.asList(contractPhoto));
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoList(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }
        }
        return logisticsContractPage;
    }

    @Override
    public void changePigeonhole(Integer id) {
        LogisticsContract logisticsContract = logisticsContractMapper.selectById(id);
        String pigeonhole = logisticsContract.getPigeonhole();
        //判断归档  如果是0 改为1  如果是1  改为0
        if (pigeonhole.equals("0")) {
            logisticsContract.setPigeonhole("1");
            logisticsContractMapper.updateById(logisticsContract);
        } else if (pigeonhole.equals("1")) {
            logisticsContract.setPigeonhole("0");
            logisticsContractMapper.updateById(logisticsContract);
        }
    }

    @Override
    public List<LogisticsDetail> getDetailLogistics(String logisticsContractNo) {
        //根据物流合同找到所有的物流详情表
        QueryWrapper<LogisticsDetail> query = new QueryWrapper<>();
        query.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        List<LogisticsDetail> logisticsDetails = logisticsDetailMapper.selectList(query);
        return logisticsDetails;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(LogisticsContract logisticsContract) {
        //新增物流单   然后新增物流详情单
        //图片字段处理
        List<String> contractPhotoList = logisticsContract.getContractPhotoList();
        logisticsContract.setContractPhoto(ImageUtils.getDBString(contractPhotoList));
        logisticsContract.setPigeonhole("1");
        logisticsContract.setCreateBy(SecurityUtils.getUsername());
        logisticsContract.setLastUpdateBy(SecurityUtils.getUsername());
        logisticsContractMapper.insert(logisticsContract);
        List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
        //新增对应的物流详情单
        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            logisticsDetail.setLogisticsContractNo(logisticsContract.getLogisticsContractNo());
            logisticsDetail.setCreateBy(SecurityUtils.getUsername());
            logisticsDetail.setLastUpdateBy(SecurityUtils.getUsername());
            logisticsDetailMapper.insert(logisticsDetail);
        }

        //运往自家仓库
        //拿到货物名称
        //采购单号
        String purchaseContractNo = logisticsDetailList.get(0).getPurchaseContractNo();
        QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
        purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, purchaseContractNo);
        PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
        //货物名称
        String goodsName = purchaseContract.getGoodsName();

        //销售单合同是000   运往自家仓库的物流操作
        if (logisticsContract.getSaleContractNo().equals("000")) {
            System.out.println("00000");
            //从其他厂取货，存到自家仓库  需要维护的是外商仓库的库存  外商仓库的出库记录  自家仓库的库存  自家仓库的入库记录
            //修改自家仓库库存
            //先判断是否有该货物，如果有的话跟新，没有的话插入
            QueryWrapper<OwnWarehouse> query = new QueryWrapper<>();
            query.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
            OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(query);
            if (ownWarehouse != null) {
                System.out.println("自家库存不为空");
                //更新库存
                BigDecimal totalWeight = logisticsContract.getTotalWeight();
                BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                //判断物流合同的单位是吨还是斤
                if (logisticsContract.getGoodsUnit().equals("吨")) {
                    System.out.println("选择是的吨");
                    ownWarehouse.setGoodsCount(goodsCount.add(totalWeight.multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("选择的是斤");
                    ownWarehouse.setGoodsCount(goodsCount.add(totalWeight));
                }
                ownWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                ownWarehouseMapper.updateById(ownWarehouse);
            } else {
                System.out.println("自家仓库没有该物品");
                //插入新的数据
                OwnWarehouse addOwnWarehouse = new OwnWarehouse();
                addOwnWarehouse.setGoodsName(goodsName);
                addOwnWarehouse.setFactoryName("自家仓库");
                if (logisticsContract.getGoodsUnit().equals("吨")) {
                    System.out.println("新增的，并且选择是的吨");
                    addOwnWarehouse.setGoodsCount(logisticsContract.getTotalWeight().multiply(BigDecimal.valueOf(2000)));
                } else {
                    System.out.println("新增的，并且选择是的斤");
                    addOwnWarehouse.setGoodsCount(logisticsContract.getTotalWeight());
                }
                addOwnWarehouse.setGoodsUnit("斤");
                addOwnWarehouse.setCreateBy(SecurityUtils.getUsername());
                addOwnWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                ownWarehouseMapper.insert(addOwnWarehouse);
            }
            //新增自家仓库入库记录
            OwnInOut ownInOut = new OwnInOut();
            ownInOut.setInOutType(1);
            ownInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
            ownInOut.setInOutGoodsName(goodsName);
            ownInOut.setInOutGoodsCount(logisticsContract.getTotalWeight());
            ownInOut.setInOutGoodsUnit(logisticsContract.getGoodsUnit());
            ownInOut.setCreateBy(SecurityUtils.getUsername());
            ownInOut.setLastUpdateBy(SecurityUtils.getUsername());
            ownInOutMapper.insert(ownInOut);
            //外商库存库存修改和出库记录
            for (LogisticsDetail logisticsDetail : logisticsDetailList) {
                //更新外商库存
                //根据厂名和货物名称拿到库存，然后更新库存量
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                OtherWarehouse one = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal goodsCount = one.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                }
                one.setLastUpdateBy(SecurityUtils.getUsername());
                otherWarehouseMapper.updateById(one);
                //出库记录
                Integer id = one.getId();
                OtherInOut otherInOut = new OtherInOut();
                otherInOut.setOtherWarehouseId(id);
                otherInOut.setInOutType(0);
                otherInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                otherInOut.setInOutGoodsName(goodsName);
                otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                otherInOut.setCreateBy(SecurityUtils.getUsername());
                otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                otherInOutMapper.insert(otherInOut);
            }
        } else {
            //销售合同不是000  出售商品的操作
            for (LogisticsDetail logisticsDetail : logisticsDetailList) {
                //采购合同是000 取货厂名是自家仓库
                if (logisticsDetail.getPurchaseContractNo().equals("000")) {
                    //减少自家仓库库存表
                    QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
                    ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
                    OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
                    BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                    //判断单位
                    if (logisticsDetail.getGoodsUnit().equals("吨")) {
                        System.out.println("物流详情货物单位选择是的吨");
                        ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                    } else {
                        System.out.println("流详情货物单位选择的是斤");
                        ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                    }
                    ownWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                    ownWarehouseMapper.updateById(ownWarehouse);
                    //自家仓库出库记录
                    OwnInOut ownInOut = new OwnInOut();
                    ownInOut.setInOutType(0);
                    ownInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                    ownInOut.setInOutGoodsName(goodsName);
                    ownInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                    ownInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                    ownInOut.setCreateBy(SecurityUtils.getUsername());
                    ownInOut.setLastUpdateBy(SecurityUtils.getUsername());
                    ownInOutMapper.insert(ownInOut);
                } else {
                    //如果采购合同不是000
                    //外商仓库库存表
                    QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                    OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                    BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                    //判断单位
                    if (logisticsDetail.getGoodsUnit().equals("吨")) {
                        System.out.println("物流详情货物单位选择是的吨");
                        otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                    } else {
                        System.out.println("流详情货物单位选择的是斤");
                        otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                    }
                    otherWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                    otherWarehouseMapper.updateById(otherWarehouse);
                    //外商仓库出库记录
                    Integer id = otherWarehouse.getId();
                    OtherInOut otherInOut = new OtherInOut();
                    otherInOut.setOtherWarehouseId(id);
                    otherInOut.setInOutType(0);
                    otherInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                    otherInOut.setInOutGoodsName(goodsName);
                    otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                    otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                    otherInOut.setCreateBy(SecurityUtils.getUsername());
                    otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                    otherInOutMapper.insert(otherInOut);
                }
            }
        }
    }

    @Override
    public Boolean checkLogisticsContractNo(String logisticsContractNo) {
        QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
        qw.eq("logistics_contract_no", logisticsContractNo).orderByDesc("create_time");
        List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(qw);
        return !logisticsContracts.isEmpty();
    }

    @Override
    public int shippingCheckLogisticsContractNo(String logisticsContractNo) {
        QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
        qw.eq("logistics_contract_no", logisticsContractNo).orderByDesc("create_time");
        List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(qw);
        if (logisticsContracts.isEmpty()) {
            return 1;
        } else {
            if (logisticsContracts.get(0).getUpperType() == 0) {
                return 2;
            }
        }
        return 0;
    }

    /**
     * @param id 物流单id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int delete(Integer id) {
        //判断是否已经有物流付款单

        //先拿到该物流单和物流单合同号
        LogisticsContract logisticsContract = logisticsContractMapper.selectById(id);
        String logisticsContractNo = logisticsContract.getLogisticsContractNo();
        //查询是否有该物流合同的物流付款单
        QueryWrapper<LogisticsPaymentContract> logisticsPaymentContractQueryWrapper = new QueryWrapper<>();
        logisticsPaymentContractQueryWrapper.lambda().eq(LogisticsPaymentContract::getLogisticsContractNo, logisticsContractNo);
        List<LogisticsPaymentContract> logisticsPaymentContracts = logisticsPaymentContractMapper.selectList(logisticsPaymentContractQueryWrapper);
        System.out.println("物流付款单的大小" + logisticsPaymentContracts.size());
        if (logisticsPaymentContracts.size() != 0) {
            return 0;
        }

        //货物名称
        //根据物流单号拿到物流详情集合  根据采购单号拿到货物名称
        QueryWrapper<LogisticsDetail> detailQueryWrapper = new QueryWrapper<>();
        detailQueryWrapper.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        List<LogisticsDetail> logisticsDetails = logisticsDetailMapper.selectList(detailQueryWrapper);

        String purchaseContractNo = logisticsDetails.get(0).getPurchaseContractNo();
        QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
        purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, purchaseContractNo);
        PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
        String goodsName = purchaseContract.getGoodsName();

        //如果销售合同是000    减掉对应的自家仓库库存  同时删掉自家仓库入库记录
        if (logisticsContract.getSaleContractNo().equals("000")) {
            //减去对应的自家仓库库存
            //根据货物名称拿到拿到这个自家仓库
            QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
            ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
            OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
            //判断物流单单位，如果是吨，减去数量*2000  如果是斤 ，直接减去对应的数量
            BigDecimal goodsCount = ownWarehouse.getGoodsCount();
            //判断单位
            if (logisticsContract.getGoodsUnit().equals("吨")) {
                System.out.println("物流详情货物单位选择是的吨");
                ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsContract.getTotalWeight().multiply(BigDecimal.valueOf(2000))));
            } else {
                System.out.println("流详情货物单位选择的是斤");
                ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsContract.getTotalWeight()));
            }
            ownWarehouseMapper.updateById(ownWarehouse);
            // 同时删掉自家仓库入库记录
            QueryWrapper<OwnInOut> ownInOutQueryWrapper = new QueryWrapper<>();
            ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
            ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutGoodsName, goodsName);
            ownInOutMapper.delete(ownInOutQueryWrapper);
            //修改外商仓库库存和删除外商仓库出库记录
            // List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
            for (LogisticsDetail logisticsDetail : logisticsDetails) {
                //修改外商库存
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal otherWarehouseGoodsCount = otherWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    otherWarehouse.setGoodsCount(otherWarehouseGoodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    otherWarehouse.setGoodsCount(otherWarehouseGoodsCount.add(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouseMapper.updateById(otherWarehouse);
                //删除外商出库记录
                QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                otherInOutMapper.delete(otherInOutQueryWrapper);
            }
        } else {
            //销售合同不是000  出售商品的操作
            // List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
            for (LogisticsDetail logisticsDetail : logisticsDetails) {
                //从自家仓库出货
                if (logisticsDetail.getPurchaseContractNo().equals("000")) {
                    // 修改库存
                    QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
                    ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
                    OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
                    //判断物流单单位
                    BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                    //判断单位
                    if (logisticsDetail.getGoodsUnit().equals("吨")) {
                        System.out.println("物流详情货物单位选择是的吨");
                        ownWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                    } else {
                        System.out.println("流详情货物单位选择的是斤");
                        ownWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                    }
                    ownWarehouseMapper.updateById(ownWarehouse);
                    //删除出库记录
                    QueryWrapper<OwnInOut> ownInOutQueryWrapper = new QueryWrapper<>();
                    ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                    ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutGoodsName, goodsName);
                    ownInOutMapper.delete(ownInOutQueryWrapper);
                } else {
                    //从外商仓库出货
                    //修改库存
                    QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                    OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                    BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                    //判断单位
                    if (logisticsDetail.getGoodsUnit().equals("吨")) {
                        System.out.println("物流详情货物单位选择是的吨");
                        otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                    } else {
                        System.out.println("流详情货物单位选择的是斤");
                        otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                    }
                    otherWarehouseMapper.updateById(otherWarehouse);
                    //删除外商出库记录
                    QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                    otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                    otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                    otherInOutMapper.delete(otherInOutQueryWrapper);
                }
            }
        }
        //删除物流单
        logisticsContractMapper.deleteById(id);
        //删除物流详情单
        QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        logisticsDetailMapper.delete(queryWrapper);
        return 1;
    }

    @Override
    public List<ExportOutLogisticsContract> getExportList(ExportListParm listParm) {
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        //构造查询条件
        //物流单合同编号
        if (StringUtils.isNotEmpty(listParm.getLogisticsContractNo())) {
            query.lambda().like(LogisticsContract::getLogisticsContractNo, listParm.getLogisticsContractNo());
        }

        //销售单合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(LogisticsContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(LogisticsContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(LogisticsContract::getLogisticsContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(LogisticsContract::getLogisticsContractTime, format);
        }
        //查看归档为1的数据
        if (listParm.getIsPigeonhole().equals("1")) {
            query.lambda().eq(LogisticsContract::getPigeonhole, 1);
        } else {
            query.lambda().eq(LogisticsContract::getPigeonhole, 0);
        }
        //查看归档为1的数据

        query.orderByDesc("id");
        List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(query);
        ArrayList<ExportOutLogisticsContract> list = new ArrayList<>();
        for (LogisticsContract logisticsContract : logisticsContracts) {
            ExportOutLogisticsContract exportOutLogisticsContract = new ExportOutLogisticsContract();
            exportOutLogisticsContract.setLogisticsContractNo(logisticsContract.getLogisticsContractNo());
            exportOutLogisticsContract.setSaleContractNo(logisticsContract.getSaleContractNo());
            exportOutLogisticsContract.setTotalWeight(logisticsContract.getTotalWeight());
            exportOutLogisticsContract.setGoodsUnit(logisticsContract.getGoodsUnit());
            exportOutLogisticsContract.setFreight(logisticsContract.getFreight());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(logisticsContract.getLogisticsContractTime());
            exportOutLogisticsContract.setLogisticsContractTime(format);
            exportOutLogisticsContract.setSqueezeSeason(logisticsContract.getSqueezeSeason());
            exportOutLogisticsContract.setCreateBy(logisticsContract.getCreateBy());
            list.add(exportOutLogisticsContract);
        }
        return list;
    }

    @Override
    public void isHaveAnyLogistics(String saleContractNo) {
        QueryWrapper<LogisticsContract> logisticsContractQueryWrapper = new QueryWrapper<>();
        logisticsContractQueryWrapper.lambda().eq(LogisticsContract::getSaleContractNo, saleContractNo);
        List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(logisticsContractQueryWrapper);
        if (logisticsContracts.size() == 0) {
            //修改销售单的isHaveLogistics为0
            QueryWrapper<SaleContract> query = new QueryWrapper<>();
            query.lambda().eq(SaleContract::getSaleContractNo, saleContractNo);
            SaleContract saleContract = saleContractMapper.selectOne(query);
            saleContract.setIsHaveLogistics(0);
            saleContractMapper.updateById(saleContract);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addProcessLogisticsContract(LogisticsContract logisticsContract) {
        //维护加工单的relation_logistics_exist_state
        // QueryWrapper<ProcessContract> processContractQueryWrapper1 = new QueryWrapper<>();
        // processContractQueryWrapper1.lambda().eq(ProcessContract::getProcessContractNo,logisticsContract.getSaleContractNo());
        // ProcessContract processContract1 = processContractMapper.selectOne(processContractQueryWrapper1);
        // processContract1.setRelationLogisticsExistState(1);
        // processContractMapper.updateById(processContract1);
        //加工单的物流单
        //生成物流单
        List<String> contractPhotoList = logisticsContract.getContractPhotoList();
        logisticsContract.setContractPhoto(ImageUtils.getDBString(contractPhotoList));
        logisticsContract.setPigeonhole("1");
        logisticsContract.setCreateBy(SecurityUtils.getUsername());
        logisticsContract.setLastUpdateBy(SecurityUtils.getUsername());
        logisticsContractMapper.insert(logisticsContract);
        List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
        //新增对应的物流详情单
        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            logisticsDetail.setLogisticsContractNo(logisticsContract.getLogisticsContractNo());
            logisticsDetail.setCreateBy(SecurityUtils.getUsername());
            logisticsDetail.setLastUpdateBy(SecurityUtils.getUsername());
            logisticsDetailMapper.insert(logisticsDetail);
        }
        //维护加工单的relation_logistics_exist_state
        QueryWrapper<ProcessContract> processContractQueryWrapper = new QueryWrapper<>();
        processContractQueryWrapper.lambda().eq(ProcessContract::getProcessContractNo, logisticsContract.getSaleContractNo());
        ProcessContract processContract = processContractMapper.selectOne(processContractQueryWrapper);
        processContract.setRelationLogisticsExistState(1);
        processContractMapper.updateById(processContract);
        //货物名称
        String goodsName = processContract.getGoodsName();

        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            if (logisticsDetail.getPurchaseContractNo().equals("000")) {
                //减少自家仓库库存表
                QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
                ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
                OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
                BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                }
                ownWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                ownWarehouseMapper.updateById(ownWarehouse);
                //自家仓库出库记录
                OwnInOut ownInOut = new OwnInOut();
                ownInOut.setInOutType(0);
                ownInOut.setInOutContractNo(logisticsDetail.getLogisticsContractNo());
                ownInOut.setInOutGoodsName(goodsName);
                ownInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                ownInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                ownInOut.setCreateBy(SecurityUtils.getUsername());
                ownInOut.setLastUpdateBy(SecurityUtils.getUsername());
                ownInOutMapper.insert(ownInOut);
            } else {
                //维护采购单的relation_logistics_exist_state
                //采购单是否有
                QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
                purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
                purchaseContract.setRelationLogisticsExistState(1);
                purchaseContractMapper.updateById(purchaseContract);

                //外商仓库库存表
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);

                BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                otherWarehouseMapper.updateById(otherWarehouse);
                //外商仓库出库记录
                Integer id = otherWarehouse.getId();
                OtherInOut otherInOut = new OtherInOut();
                otherInOut.setOtherWarehouseId(id);
                otherInOut.setInOutType(0);
                otherInOut.setInOutContractNo(logisticsDetail.getLogisticsContractNo());
                otherInOut.setInOutGoodsName(goodsName);
                otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                otherInOut.setCreateBy(SecurityUtils.getUsername());
                otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                otherInOutMapper.insert(otherInOut);
                //通过采购单合同号  查看采购单是否有了物流单，维护采购单的relation_logistics_exist_state字段
                // purchaseContract.setRelationLogisticsExistState(1);
                // purchaseContractMapper.updateById(purchaseContract);
            }
            //根据货物名称和加工厂名  新增加工厂名的库存和入库记录  根据厂名和货物名称判断是新增还是修改
            String goodsFactory = logisticsDetail.getUnloadingLocation();
            QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
            otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
            otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, goodsFactory);
            OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
            if (otherWarehouse == null) {
                //新增库存
                OtherWarehouse addOtherWareHouse = new OtherWarehouse();
                addOtherWareHouse.setFactoryName(goodsFactory);
                addOtherWareHouse.setGoodsName(goodsName);
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("新增的，并且选择是的吨");
                    addOtherWareHouse.setGoodsCount(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000)));
                } else {
                    System.out.println("新增的，并且选择是的斤");
                    addOtherWareHouse.setGoodsCount(logisticsDetail.getGoodsWeight());
                }
                addOtherWareHouse.setCreateBy(SecurityUtils.getUsername());
                addOtherWareHouse.setLastUpdateBy(SecurityUtils.getUsername());
                otherWarehouseMapper.insert(addOtherWareHouse);
            } else {
                //更新库存
                BigDecimal totalWeight = logisticsDetail.getGoodsWeight();
                BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                //判断物流合同的单位是吨还是斤
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("选择是的吨");
                    otherWarehouse.setGoodsCount(goodsCount.add(totalWeight.multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("选择的是斤");
                    otherWarehouse.setGoodsCount(goodsCount.add(totalWeight));
                }
                otherWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                otherWarehouseMapper.updateById(otherWarehouse);
            }
            //新增入库记录
            OtherWarehouse otherWarehouseRef = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
            Integer id = otherWarehouseRef.getId();
            OtherInOut otherInOut = new OtherInOut();
            otherInOut.setOtherWarehouseId(id);
            otherInOut.setInOutType(1);
            otherInOut.setInOutContractNo(logisticsDetail.getLogisticsContractNo());
            otherInOut.setInOutGoodsName(goodsName);
            otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
            otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
            otherInOut.setCreateBy(SecurityUtils.getUsername());
            otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
            otherInOutMapper.insert(otherInOut);
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addLogisticsContract(LogisticsContract logisticsContract) {
        //销售单的物流单
        //生成物流单
        List<String> contractPhotoList = logisticsContract.getContractPhotoList();
        logisticsContract.setContractPhoto(ImageUtils.getDBString(contractPhotoList));
        logisticsContract.setPigeonhole("1");
        logisticsContract.setCreateBy(SecurityUtils.getUsername());
        logisticsContract.setLastUpdateBy(SecurityUtils.getUsername());
        logisticsContractMapper.insert(logisticsContract);
        List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
        //新增对应的物流详情单
        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            logisticsDetail.setLogisticsContractNo(logisticsContract.getLogisticsContractNo());
            logisticsDetail.setCreateBy(SecurityUtils.getUsername());
            logisticsDetail.setLastUpdateBy(SecurityUtils.getUsername());
            logisticsDetailMapper.insert(logisticsDetail);
        }
        String goodsName = "";
        if (!logisticsContract.getSaleContractNo().equals("000")) {
            QueryWrapper<SaleContract> saleContractQueryWrapper = new QueryWrapper<>();
            saleContractQueryWrapper.lambda().eq(SaleContract::getSaleContractNo, logisticsContract.getSaleContractNo());
            SaleContract saleContract = saleContractMapper.selectOne(saleContractQueryWrapper);
            goodsName = saleContract.getGoodsName();
        } else {
            String purchaseContractNo = logisticsDetailList.get(0).getPurchaseContractNo();
            QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
            purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, purchaseContractNo);
            PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
            //货物名称
            goodsName = purchaseContract.getGoodsName();
        }

        //运往自家仓库的销售单
        if (logisticsContract.getSaleContractNo().equals("000")) {
            System.out.println("运往自家仓库的物流单");
            QueryWrapper<OwnWarehouse> query = new QueryWrapper<>();
            query.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
            OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(query);
            if (ownWarehouse != null) {
                System.out.println("自家库存不为空");
                //更新库存
                BigDecimal totalWeight = logisticsContract.getTotalWeight();
                BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                //判断物流合同的单位是吨还是斤
                if (logisticsContract.getGoodsUnit().equals("吨")) {
                    System.out.println("选择是的吨");
                    ownWarehouse.setGoodsCount(goodsCount.add(totalWeight.multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("选择的是斤");
                    ownWarehouse.setGoodsCount(goodsCount.add(totalWeight));
                }
                ownWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                ownWarehouseMapper.updateById(ownWarehouse);
            } else {
                System.out.println("自家仓库没有该物品");
                //插入新的数据
                OwnWarehouse addOwnWarehouse = new OwnWarehouse();
                addOwnWarehouse.setGoodsName(goodsName);
                addOwnWarehouse.setFactoryName("自家仓库");
                if (logisticsContract.getGoodsUnit().equals("吨")) {
                    System.out.println("新增的，并且选择是的吨");
                    addOwnWarehouse.setGoodsCount(logisticsContract.getTotalWeight().multiply(BigDecimal.valueOf(2000)));
                } else {
                    System.out.println("新增的，并且选择是的斤");
                    addOwnWarehouse.setGoodsCount(logisticsContract.getTotalWeight());
                }
                addOwnWarehouse.setGoodsUnit("斤");
                addOwnWarehouse.setCreateBy(SecurityUtils.getUsername());
                addOwnWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                ownWarehouseMapper.insert(addOwnWarehouse);
            }
            //新增自家仓库入库记录
            OwnInOut ownInOut = new OwnInOut();
            ownInOut.setInOutType(1);
            ownInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
            ownInOut.setInOutGoodsName(goodsName);
            ownInOut.setInOutGoodsCount(logisticsContract.getTotalWeight());
            ownInOut.setInOutGoodsUnit(logisticsContract.getGoodsUnit());
            ownInOut.setCreateBy(SecurityUtils.getUsername());
            ownInOut.setLastUpdateBy(SecurityUtils.getUsername());
            ownInOutMapper.insert(ownInOut);
            //外商库存库存修改和出库记录
            for (LogisticsDetail logisticsDetail : logisticsDetailList) {
                //通过采购单合同号  查看采购单是否有了物流单，维护采购单的relation_logistics_exist_state字段
                String detailPurchaseContractNo = logisticsDetail.getPurchaseContractNo();
                QueryWrapper<PurchaseContract> queryWrapper = new QueryWrapper<>();
                queryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, detailPurchaseContractNo);
                PurchaseContract purchaseContract1 = purchaseContractMapper.selectOne(queryWrapper);
                purchaseContract1.setRelationLogisticsExistState(1);
                purchaseContractMapper.updateById(purchaseContract1);

                //更新外商库存
                //根据厂名和货物名称拿到库存，然后更新库存量
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                OtherWarehouse one = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal goodsCount = one.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                }
                one.setLastUpdateBy(SecurityUtils.getUsername());
                otherWarehouseMapper.updateById(one);
                //出库记录
                Integer id = one.getId();
                OtherInOut otherInOut = new OtherInOut();
                otherInOut.setOtherWarehouseId(id);
                otherInOut.setInOutType(0);
                otherInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                otherInOut.setInOutGoodsName(goodsName);
                otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                otherInOut.setCreateBy(SecurityUtils.getUsername());
                otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                otherInOutMapper.insert(otherInOut);
            }
        } else {
            //维护销售单 isHaveLogistics
            QueryWrapper<SaleContract> saleContractQueryWrapper = new QueryWrapper<>();
            saleContractQueryWrapper.lambda().eq(SaleContract::getSaleContractNo, logisticsContract.getSaleContractNo());
            SaleContract saleContract = saleContractMapper.selectOne(saleContractQueryWrapper);
            saleContract.setIsHaveLogistics(1);
            saleContractMapper.updateById(saleContract);
            System.out.println("正常销售情况");
            for (LogisticsDetail logisticsDetail : logisticsContract.getLogisticsDetailList()) {
                if (logisticsDetail.getUpperType() == 0) {
                    System.out.println("销售单从加工单那里出货");
                    //减少加工单对应厂的库存
                    String factoryName = logisticsDetail.getGoodsFactory();
                    QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, factoryName);
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                    OtherWarehouse one = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                    BigDecimal goodsCount = one.getGoodsCount();
                    //判断单位
                    if (logisticsDetail.getGoodsUnit().equals("吨")) {
                        System.out.println("物流详情货物单位选择是的吨");
                        one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                    } else {
                        System.out.println("流详情货物单位选择的是斤");
                        one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                    }
                    one.setLastUpdateBy(SecurityUtils.getUsername());
                    otherWarehouseMapper.updateById(one);
                    //出库记录
                    Integer id = one.getId();
                    OtherInOut otherInOut = new OtherInOut();
                    otherInOut.setOtherWarehouseId(id);
                    otherInOut.setInOutType(0);
                    otherInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                    otherInOut.setInOutGoodsName(goodsName);
                    otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                    otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                    otherInOut.setCreateBy(SecurityUtils.getUsername());
                    otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                    otherInOutMapper.insert(otherInOut);
                } else {
                    if (logisticsDetail.getPurchaseContractNo().equals("000")) {
                        System.out.println("从自家仓库出货的正常销售情况");
                        //减少自家仓库库存表
                        QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
                        ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
                        OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
                        BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                        //判断单位
                        if (logisticsDetail.getGoodsUnit().equals("吨")) {
                            System.out.println("物流详情货物单位选择是的吨");
                            ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                        } else {
                            System.out.println("流详情货物单位选择的是斤");
                            ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                        }
                        ownWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                        ownWarehouseMapper.updateById(ownWarehouse);
                        //自家仓库出库记录
                        OwnInOut ownInOut = new OwnInOut();
                        ownInOut.setInOutType(0);
                        ownInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                        ownInOut.setInOutGoodsName(goodsName);
                        ownInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                        ownInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                        ownInOut.setCreateBy(SecurityUtils.getUsername());
                        ownInOut.setLastUpdateBy(SecurityUtils.getUsername());
                        ownInOutMapper.insert(ownInOut);
                    } else {
                        //通过采购单合同号  查看采购单是否有了物流单，维护采购单的relation_logistics_exist_state字段
                        String detailPurchaseContractNo = logisticsDetail.getPurchaseContractNo();
                        QueryWrapper<PurchaseContract> queryWrapper = new QueryWrapper<>();
                        queryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, detailPurchaseContractNo);
                        PurchaseContract purchaseContract1 = purchaseContractMapper.selectOne(queryWrapper);
                        purchaseContract1.setRelationLogisticsExistState(1);
                        purchaseContractMapper.updateById(purchaseContract1);

                        System.out.println("从外商仓库出后的正常销售情况");
                        //外商仓库库存表
                        QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                        otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                        otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                        OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                        BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                        //判断单位
                        if (logisticsDetail.getGoodsUnit().equals("吨")) {
                            System.out.println("物流详情货物单位选择是的吨");
                            otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                        } else {
                            System.out.println("流详情货物单位选择的是斤");
                            otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                        }
                        otherWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                        otherWarehouseMapper.updateById(otherWarehouse);
                        //外商仓库出库记录
                        Integer id = otherWarehouse.getId();
                        OtherInOut otherInOut = new OtherInOut();
                        otherInOut.setOtherWarehouseId(id);
                        otherInOut.setInOutType(0);
                        otherInOut.setInOutContractNo(logisticsContract.getLogisticsContractNo());
                        otherInOut.setInOutGoodsName(goodsName);
                        otherInOut.setInOutGoodsCount(logisticsDetail.getGoodsWeight());
                        otherInOut.setInOutGoodsUnit(logisticsDetail.getGoodsUnit());
                        otherInOut.setCreateBy(SecurityUtils.getUsername());
                        otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                        otherInOutMapper.insert(otherInOut);
                    }
                }
            }
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Integer id) {
        //先拿到该物流单和物流单合同号
        LogisticsContract logisticsContract = logisticsContractMapper.selectById(id);
        boolean result = false;
        if (logisticsContract.getUpperType() == 0) {
            //删除加工单
            result = deleteProcessContract(id);
        } else {
            //删除销售单
            result = deleteSaleContract(id);
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateLogistics(LogisticsContract logisticsContract) {
        //删除
        boolean deleteResult = deleteById(logisticsContract.getId());
        //新增
        Integer upperType = logisticsContract.getUpperType();
        boolean addResult = false;
        if (upperType == 0) {
            addResult = addProcessLogisticsContract(logisticsContract);
        } else {
            addResult = addLogisticsContract(logisticsContract);
        }
        if (deleteResult&&addResult){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 删除加工单
     *
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteProcessContract(Integer id) {
        //先拿到该物流单和物流单合同号
        LogisticsContract logisticsContract = logisticsContractMapper.selectById(id);
        String logisticsContractNo = logisticsContract.getLogisticsContractNo();

        //根据物流单号拿到物流详情集合
        QueryWrapper<LogisticsDetail> detailQueryWrapper = new QueryWrapper<>();
        detailQueryWrapper.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        List<LogisticsDetail> logisticsDetails = logisticsDetailMapper.selectList(detailQueryWrapper);

        System.out.println("删除加工单");
        //货物名称
        QueryWrapper<ProcessContract> processContractQueryWrapper = new QueryWrapper<>();
        processContractQueryWrapper.lambda().eq(ProcessContract::getProcessContractNo, logisticsContract.getSaleContractNo());
        ProcessContract processContract = processContractMapper.selectOne(processContractQueryWrapper);
        String goodsName = processContract.getGoodsName();

        for (LogisticsDetail logisticsDetail : logisticsDetails) {
            if (logisticsDetail.getPurchaseContractNo().equals("000")) {
                System.out.println("删除自家仓库到加工厂");
                // 修改自家仓库库存
                QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
                ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
                OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
                //判断物流单单位
                BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    ownWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    ownWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                }
                ownWarehouseMapper.updateById(ownWarehouse);
                //删除出库记录
                QueryWrapper<OwnInOut> ownInOutQueryWrapper = new QueryWrapper<>();
                ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutGoodsName, goodsName);
                ownInOutMapper.delete(ownInOutQueryWrapper);

                //加工单库存减少，同时删除加工单库存的入库记录
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getUnloadingLocation());
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal goodsCount1 = otherWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    otherWarehouse.setGoodsCount(goodsCount1.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    otherWarehouse.setGoodsCount(goodsCount1.subtract(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouseMapper.updateById(otherWarehouse);
                //删除加工单入库记录
                QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                otherInOutMapper.delete(otherInOutQueryWrapper);

                //删除物流详情单
                logisticsDetailMapper.deleteById(logisticsDetail.getId());

            } else {
                System.out.println("删除外商仓库到加工厂");
                //修改外商仓库库存
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouseMapper.updateById(otherWarehouse);
                //删除外商出库记录
                QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                otherInOutMapper.delete(otherInOutQueryWrapper);

                //加工单库存减少，同时删除加工单库存的入库记录
                QueryWrapper<OtherWarehouse> processOtherWarehouseQueryWrapper = new QueryWrapper<>();
                processOtherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                processOtherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getUnloadingLocation());
                OtherWarehouse processOtherWarehouse = otherWarehouseMapper.selectOne(processOtherWarehouseQueryWrapper);
                BigDecimal goodsCount1 = processOtherWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    processOtherWarehouse.setGoodsCount(goodsCount1.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    processOtherWarehouse.setGoodsCount(goodsCount1.subtract(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouseMapper.updateById(processOtherWarehouse);
                //删除加工单入库记录
                QueryWrapper<OtherInOut> processOtherInOutQueryWrapper = new QueryWrapper<>();
                processOtherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                processOtherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                otherInOutMapper.delete(processOtherInOutQueryWrapper);

                //删除物流详情单
                logisticsDetailMapper.deleteById(logisticsDetail.getId());

                //维护采购单relation_logistics_exist_state
                QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
                queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
                if (CollectionUtils.isEmpty(logisticsDetailList)) {
                    QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
                    purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                    PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
                    purchaseContract.setRelationLogisticsExistState(0);
                    purchaseContractMapper.updateById(purchaseContract);
                }
            }
            // //加工单库存减少，同时删除加工单库存的入库记录
            // QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
            // otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName,goodsName);
            // otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName,logisticsDetail.getUnloadingLocation());
            // OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
            // BigDecimal goodsCount = otherWarehouse.getGoodsCount();
            // //判断单位
            // if (logisticsDetail.getGoodsUnit().equals("吨")) {
            //     System.out.println("物流详情货物单位选择是的吨");
            //     otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
            // } else {
            //     System.out.println("流详情货物单位选择的是斤");
            //     otherWarehouse.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
            // }
            // otherWarehouseMapper.updateById(otherWarehouse);
            // //删除加工单入库记录
            // QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
            // otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
            // otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
            // otherInOutMapper.delete(otherInOutQueryWrapper);
        }
        //删除物流单
        logisticsContractMapper.deleteById(id);
        //维护加工单relation_logistics_exist_state字段
        QueryWrapper<LogisticsContract> logisticsContractQueryWrapper = new QueryWrapper<>();
        logisticsContractQueryWrapper.lambda().eq(LogisticsContract::getSaleContractNo, logisticsContract.getSaleContractNo());
        List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(logisticsContractQueryWrapper);
        if (CollectionUtils.isEmpty(logisticsContracts)) {
            //没有该加工单的物流单了 修改relation_logistics_exist_state
            QueryWrapper<ProcessContract> processContractQueryWrapper1 = new QueryWrapper<>();
            processContractQueryWrapper1.lambda().eq(ProcessContract::getProcessContractNo, logisticsContract.getSaleContractNo());
            ProcessContract processContract1 = processContractMapper.selectOne(processContractQueryWrapper1);
            processContract1.setRelationLogisticsExistState(0);
            processContractMapper.updateById(processContract1);
        }
        //删除物流详情单
        // for (LogisticsDetail logisticsDetail : logisticsDetails) {
        //     logisticsDetailMapper.deleteById(logisticsDetail.getId());
        //     //维护采购单 relation_logistics_exist_state
        //     QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
        //     queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
        //     List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
        //     if (CollectionUtils.isEmpty(logisticsDetailList)){
        //         QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
        //         purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
        //         PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
        //         purchaseContract.setRelationLogisticsExistState(0);
        //         purchaseContractMapper.updateById(purchaseContract);
        //     }
        // }
        return true;
    }

    /**
     * 删除销售单
     *
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteSaleContract(Integer id) {
        //先拿到该物流单和物流单合同号
        LogisticsContract logisticsContract = logisticsContractMapper.selectById(id);
        String logisticsContractNo = logisticsContract.getLogisticsContractNo();

        //根据物流单号拿到物流详情集合
        QueryWrapper<LogisticsDetail> detailQueryWrapper = new QueryWrapper<>();
        detailQueryWrapper.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        List<LogisticsDetail> logisticsDetails = logisticsDetailMapper.selectList(detailQueryWrapper);

        System.out.println("删除销售单");
        //货物名称
        String goodsName = "";
        if (!logisticsContract.getSaleContractNo().equals("000")) {
            QueryWrapper<SaleContract> saleContractQueryWrapper = new QueryWrapper<>();
            saleContractQueryWrapper.lambda().eq(SaleContract::getSaleContractNo, logisticsContract.getSaleContractNo());
            SaleContract saleContract = saleContractMapper.selectOne(saleContractQueryWrapper);
            goodsName = saleContract.getGoodsName();
        } else {
            String purchaseContractNo = logisticsDetails.get(0).getPurchaseContractNo();
            QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
            purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, purchaseContractNo);
            PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
            //货物名称
            goodsName = purchaseContract.getGoodsName();
        }

        if (logisticsContract.getSaleContractNo().equals("000")) {
            System.out.println("删除的运往自家仓库的");
            QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
            ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
            OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
            //判断物流单单位，如果是吨，减去数量*2000  如果是斤 ，直接减去对应的数量
            BigDecimal goodsCount = ownWarehouse.getGoodsCount();
            //判断单位
            if (logisticsContract.getGoodsUnit().equals("吨")) {
                System.out.println("物流详情货物单位选择是的吨");
                ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsContract.getTotalWeight().multiply(BigDecimal.valueOf(2000))));
            } else {
                System.out.println("流详情货物单位选择的是斤");
                ownWarehouse.setGoodsCount(goodsCount.subtract(logisticsContract.getTotalWeight()));
            }
            ownWarehouseMapper.updateById(ownWarehouse);
            // 同时删掉自家仓库入库记录
            QueryWrapper<OwnInOut> ownInOutQueryWrapper = new QueryWrapper<>();
            ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
            ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutGoodsName, goodsName);
            ownInOutMapper.delete(ownInOutQueryWrapper);
            //删除物流单
            logisticsContractMapper.deleteById(id);

            for (LogisticsDetail logisticsDetail : logisticsDetails) {
                //修改外商库存
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal otherWarehouseGoodsCount = otherWarehouse.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")) {
                    System.out.println("物流详情货物单位选择是的吨");
                    otherWarehouse.setGoodsCount(otherWarehouseGoodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                } else {
                    System.out.println("流详情货物单位选择的是斤");
                    otherWarehouse.setGoodsCount(otherWarehouseGoodsCount.add(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouseMapper.updateById(otherWarehouse);
                //删除外商出库记录
                QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                otherInOutMapper.delete(otherInOutQueryWrapper);
                //删除物流详情单
                logisticsDetailMapper.deleteById(logisticsDetail.getId());
                //维护采购单 relation_logistics_exist_state
                QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
                queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
                if (CollectionUtils.isEmpty(logisticsDetailList)) {
                    QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
                    purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                    PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
                    purchaseContract.setRelationLogisticsExistState(0);
                    purchaseContractMapper.updateById(purchaseContract);
                }
                //根据采购合同号 判断是否还有该采购合同的物流详情单，来维护采购单的relation_logistics_exist_state字段
                // QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
                // queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
                // List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
                // if (CollectionUtils.isEmpty(logisticsDetailList)){
                //     QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
                //     purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
                //     PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
                //     purchaseContract.setRelationLogisticsExistState(0);
                //     purchaseContractMapper.updateById(purchaseContract);
                // }
            }
        } else {
            //删除物流单
            logisticsContractMapper.deleteById(id);
            //维护销售单的isHaveLogistics
            QueryWrapper<LogisticsContract> logisticsContractQueryWrapper = new QueryWrapper<>();
            logisticsContractQueryWrapper.lambda().eq(LogisticsContract::getSaleContractNo, logisticsContract.getSaleContractNo());
            List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(logisticsContractQueryWrapper);
            if (CollectionUtils.isEmpty(logisticsContracts)) {
                QueryWrapper<SaleContract> saleContractQueryWrapper = new QueryWrapper<>();
                saleContractQueryWrapper.lambda().eq(SaleContract::getSaleContractNo, logisticsContract.getSaleContractNo());
                SaleContract saleContract = saleContractMapper.selectOne(saleContractQueryWrapper);
                saleContract.setIsHaveLogistics(0);
                saleContractMapper.updateById(saleContract);
            }
            for (LogisticsDetail logisticsDetail : logisticsDetails) {
                if (logisticsDetail.getUpperType() == 1) {
                    if (logisticsDetail.getPurchaseContractNo().equals("000")) {
                        System.out.println("自家仓库出货的正常销售");
                        // 修改库存
                        QueryWrapper<OwnWarehouse> ownWarehouseQueryWrapper = new QueryWrapper<>();
                        ownWarehouseQueryWrapper.lambda().eq(OwnWarehouse::getGoodsName, goodsName);
                        OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(ownWarehouseQueryWrapper);
                        //判断物流单单位
                        BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                        //判断单位
                        if (logisticsDetail.getGoodsUnit().equals("吨")) {
                            System.out.println("物流详情货物单位选择是的吨");
                            ownWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                        } else {
                            System.out.println("流详情货物单位选择的是斤");
                            ownWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                        }
                        ownWarehouseMapper.updateById(ownWarehouse);
                        //删除出库记录
                        QueryWrapper<OwnInOut> ownInOutQueryWrapper = new QueryWrapper<>();
                        ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                        ownInOutQueryWrapper.lambda().eq(OwnInOut::getInOutGoodsName, goodsName);
                        ownInOutMapper.delete(ownInOutQueryWrapper);
                    } else {
                        System.out.println("外商仓库出货的正常销售");
                        //修改库存
                        QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                        otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, logisticsDetail.getGoodsFactory());
                        otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                        OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                        BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                        //判断单位
                        if (logisticsDetail.getGoodsUnit().equals("吨")) {
                            System.out.println("物流详情货物单位选择是的吨");
                            otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                        } else {
                            System.out.println("流详情货物单位选择的是斤");
                            otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                        }
                        otherWarehouseMapper.updateById(otherWarehouse);
                        //删除外商出库记录
                        QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                        otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                        otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                        otherInOutMapper.delete(otherInOutQueryWrapper);
                        //删除物流详情单
                        logisticsDetailMapper.deleteById(logisticsDetail.getId());
                        //维护采购单 relation_logistics_exist_state
                        QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
                        queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                        List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
                        if (CollectionUtils.isEmpty(logisticsDetailList)) {
                            QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
                            purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo, logisticsDetail.getPurchaseContractNo());
                            PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
                            purchaseContract.setRelationLogisticsExistState(0);
                            purchaseContractMapper.updateById(purchaseContract);
                        }
                        //根据采购合同号 判断是否还有该采购合同的物流详情单，来维护采购单的relation_logistics_exist_state字段
                        // QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
                        // queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
                        // List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
                        // if (CollectionUtils.isEmpty(logisticsDetailList)){
                        //     QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
                        //     purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
                        //     PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
                        //     purchaseContract.setRelationLogisticsExistState(0);
                        //     purchaseContractMapper.updateById(purchaseContract);
                        // }
                    }
                } else {
                    System.out.println("加工厂出货的正常销售");
                    String goodsFactory = logisticsDetail.getGoodsFactory();
                    QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName, goodsName);
                    otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName, goodsFactory);
                    OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                    BigDecimal goodsCount = otherWarehouse.getGoodsCount();
                    //判断单位
                    if (logisticsDetail.getGoodsUnit().equals("吨")) {
                        System.out.println("物流详情货物单位选择是的吨");
                        otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                    } else {
                        System.out.println("流详情货物单位选择的是斤");
                        otherWarehouse.setGoodsCount(goodsCount.add(logisticsDetail.getGoodsWeight()));
                    }
                    otherWarehouseMapper.updateById(otherWarehouse);
                    //删除外商出库记录
                    QueryWrapper<OtherInOut> otherInOutQueryWrapper = new QueryWrapper<>();
                    otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutContractNo, logisticsContract.getLogisticsContractNo());
                    otherInOutQueryWrapper.lambda().eq(OtherInOut::getInOutGoodsName, goodsName);
                    otherInOutMapper.delete(otherInOutQueryWrapper);
                    //删除物流详情单
                    logisticsDetailMapper.deleteById(logisticsDetail.getId());
                    //判断是否还有该加工合同号的物流详情单，维护加工单的relation_logistics_exist_state字段
                    // QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
                    // queryWrapper.lambda().eq(LogisticsDetail::getPurchaseContractNo,logisticsDetail.getPurchaseContractNo());
                    // List<LogisticsDetail> logisticsDetailList = logisticsDetailMapper.selectList(queryWrapper);
                    // if (CollectionUtils.isEmpty(logisticsDetailList)){
                    //     QueryWrapper<ProcessContract> processContractQueryWrapper = new QueryWrapper<>();
                    //     processContractQueryWrapper.lambda().eq(ProcessContract::getProcessContractNo,logisticsDetail.getPurchaseContractNo());
                    //     ProcessContract processContract = processContractMapper.selectOne(processContractQueryWrapper);
                    //     processContract.setRelationLogisticsExistState(0);
                    //     processContractMapper.updateById(processContract);
                    // }
                }
            }
        }
        //维护销售单的is_have_logistics字段
        // QueryWrapper<LogisticsContract> logisticsContractQueryWrapper = new QueryWrapper<>();
        // logisticsContractQueryWrapper.lambda().eq(LogisticsContract::getSaleContractNo,logisticsContract.getSaleContractNo());
        // List<LogisticsContract> logisticsContracts = logisticsContractMapper.selectList(logisticsContractQueryWrapper);
        // if (CollectionUtils.isEmpty(logisticsContracts)){
        //     QueryWrapper<SaleContract> saleContractQueryWrapper = new QueryWrapper<>();
        //     saleContractQueryWrapper.lambda().eq(SaleContract::getSaleContractNo,logisticsContract.getSaleContractNo());
        //     SaleContract saleContract = saleContractMapper.selectOne(saleContractQueryWrapper);
        //     saleContract.setIsHaveLogistics(0);
        //     saleContractMapper.updateById(saleContract);
        // }
        //删除物流单
        // logisticsContractMapper.deleteById(id);
        //删除物流详情单
        // QueryWrapper<LogisticsDetail> queryWrapper = new QueryWrapper<>();
        // queryWrapper.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        // logisticsDetailMapper.delete(queryWrapper);
        return true;
    }

}




