package cn.edu.guet.service.Impl;


import cn.edu.guet.bean.logisticsContract.ListParm;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.other.OtherWarehouse;
import cn.edu.guet.bean.own.OwnInOut;
import cn.edu.guet.bean.own.OwnWarehouse;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.SaleContractService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.web.PortResolverImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
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
        //查看归档为1的数据
        query.lambda().eq(LogisticsContract::getPigeonhole, 1);
        query.orderByDesc("create_time");

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
        //查看归档为1的数据
        query.lambda().eq(LogisticsContract::getPigeonhole, 0);
        query.orderByDesc("create_time");

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
    @Transactional
    public void add(LogisticsContract logisticsContract) {
        //新增物流单   然后新增物流详情单
        //图片字段处理
        List<String> contractPhotoList = logisticsContract.getContractPhotoList();
        logisticsContract.setContractPhoto(ImageUtils.getDBString(contractPhotoList));
        logisticsContract.setPigeonhole("1");
        logisticsContractMapper.insert(logisticsContract);
        List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
        //新增对应的物流详情但
        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            logisticsDetail.setLogisticsContractNo(logisticsContract.getLogisticsContractNo());
            logisticsDetailMapper.insert(logisticsDetail);
        }

        //运往自家仓库
        //拿到货物名称
        //采购单号
        String purchaseContractNo = logisticsDetailList.get(0).getPurchaseContractNo();
        QueryWrapper<PurchaseContract> purchaseContractQueryWrapper = new QueryWrapper<>();
        purchaseContractQueryWrapper.lambda().eq(PurchaseContract::getPurchaseContractNo,purchaseContractNo);
        PurchaseContract purchaseContract = purchaseContractMapper.selectOne(purchaseContractQueryWrapper);
        //货物名称
        String goodsName = purchaseContract.getGoodsName();
        //销售单合同是000   运往自家仓库的物流操作
        if (logisticsContract.getSaleContractNo().equals("000")){
            System.out.println("00000");
            //从其他厂取货，存到自家仓库  需要维护的是外商仓库的库存  外商仓库的出库记录  自家仓库的库存  自家仓库的入库记录
            //修改自家仓库库存
            //先判断是否有该货物，如果有的话跟新，没有的话插入
            QueryWrapper<OwnWarehouse> query = new QueryWrapper<>();
            query.lambda().eq(OwnWarehouse::getGoodsName,goodsName);
            OwnWarehouse ownWarehouse = ownWarehouseMapper.selectOne(query);
            if (ownWarehouse!=null){
                System.out.println("自家库存不为空");
                //更新库存
                BigDecimal totalWeight = logisticsContract.getTotalWeight();
                BigDecimal goodsCount = ownWarehouse.getGoodsCount();
                //判断物流合同的单位是吨还是斤
                if (logisticsContract.getGoodsUnit().equals("吨")){
                    System.out.println("选择是的吨");
                    ownWarehouse.setGoodsCount(goodsCount.add(totalWeight.multiply(BigDecimal.valueOf(2000))));
                }else{
                    System.out.println("选择的是斤");
                    ownWarehouse.setGoodsCount(goodsCount.add(totalWeight));
                }
                ownWarehouseMapper.updateById(ownWarehouse);
            }else{
                System.out.println("自家仓库没有该物品");
                //插入新的数据
                OwnWarehouse addOwnWarehouse = new OwnWarehouse();
                addOwnWarehouse.setGoodsName(goodsName);
                addOwnWarehouse.setFactoryName("自家仓库");
                if (logisticsContract.getGoodsUnit().equals("吨")){
                    System.out.println("新增的，并且选择是的吨");
                    addOwnWarehouse.setGoodsCount(logisticsContract.getTotalWeight().multiply(BigDecimal.valueOf(2000)));
                }else{
                    System.out.println("新增的，并且选择是的斤");
                    addOwnWarehouse.setGoodsCount(logisticsContract.getTotalWeight());
                }
                addOwnWarehouse.setGoodsUnit("斤");
                ownWarehouseMapper.insert(addOwnWarehouse);
            }
            //新增自家仓库入库记录
            OwnInOut ownInOut = new OwnInOut();
            ownInOut.setInOutType(1);
            ownInOut.setInOutContractNo(purchaseContractNo);
            ownInOut.setInOutGoodsName(goodsName);
            ownInOut.setInOutGoodsCount(logisticsContract.getTotalWeight());
            ownInOut.setInOutGoodsUnit(logisticsContract.getGoodsUnit());
            ownInOutMapper.insert(ownInOut);

            //外商库存库存修改和出库记录
            for (LogisticsDetail logisticsDetail : logisticsDetailList) {
                //更新外商库存
                //根据厂名和货物名称拿到库存，然后更新库存量
                QueryWrapper<OtherWarehouse> otherWarehouseQueryWrapper = new QueryWrapper<>();
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getFactoryName,logisticsDetail.getGoodsFactory());
                otherWarehouseQueryWrapper.lambda().eq(OtherWarehouse::getGoodsName,goodsName);
                OtherWarehouse one = otherWarehouseMapper.selectOne(otherWarehouseQueryWrapper);
                BigDecimal goodsCount = one.getGoodsCount();
                //判断单位
                if (logisticsDetail.getGoodsUnit().equals("吨")){
                    System.out.println("物流详情货物单位选择是的吨");
                    one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight().multiply(BigDecimal.valueOf(2000))));
                }else{
                    System.out.println("流详情货物单位选择的是斤");
                    one.setGoodsCount(goodsCount.subtract(logisticsDetail.getGoodsWeight()));
                }
                otherWarehouseMapper.updateById(one);
                //出库记录
            }


        }else{
            //销售合同不是000  出售商品的操作

            //如果采购合同不是000
            //外商仓库库存表
            //外商仓库出库记录


            //吐过采购合同是000 取货厂名是自家仓库
            //自家仓库库存表
            //自家仓库出库记录
        }

    }

    @Override
    public Boolean checkLogisticsContractNo(String logisticsContractNo) {
        QueryWrapper<LogisticsContract> qw= new QueryWrapper<>();
        qw.eq("logistics_contract_no",logisticsContractNo).orderByDesc("create_time");
        List<LogisticsContract> logisticsContracts= logisticsContractMapper.selectList(qw);
        return !logisticsContracts.isEmpty();
    }
}




