package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.ImportModel.ImportPurchaseContractModel;
import cn.edu.guet.bean.PurchaseDirectorState;
import cn.edu.guet.bean.PurchasePaymentContract;
import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.other.OtherInOut;
import cn.edu.guet.bean.other.OtherWarehouse;

import cn.edu.guet.bean.own.OwnInOut;
import cn.edu.guet.bean.own.OwnWarehouse;
import cn.edu.guet.bean.purchaseContract.*;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.CustomerService;
import cn.edu.guet.service.PurchaseContractService;
import cn.edu.guet.service.PurchasePaymentContractService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
import cn.edu.guet.util.UnitUtils;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author 陶祎祎
 * @description 针对表【purchase_contract】的数据库操作Service实现
 * @createDate 2022-10-31 18:18:23
 */
@Service
public class PurchaseContractServiceImpl extends ServiceImpl<PurchaseContractMapper, PurchaseContract>
        implements PurchaseContractService {

    @Autowired
    private PurchaseContractMapper purchaseContractMapper;

    @Autowired
    private OtherWarehouseMapper otherWarehouseMapper;

    @Autowired
    private OtherInOutMapper otherInOutMapper;

    @Autowired
    private OwnWarehouseMapper ownWarehouseMapper;

    @Autowired
    private OwnInOutMapper ownInOutMapper;

    @Autowired
    private InboundDetailInfoMapper inboundDetailInfoMapper;

    @Autowired
    private OutboundDetailInfoMapper outboundDetailInfoMapper;

    @Autowired
    private PurchasePaymentContractMapper purchasePaymentContractMapper;

    @Autowired
    private PurchaseDirectorStateMapper purchaseDirectorStateMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOnePurchaseContract(int id,int flag) {
        PurchaseContract purchaseContract = purchaseContractMapper.selectById(id);
//        删未审核完成的采购付款单
        QueryWrapper<PurchasePaymentContract> QwPPC = new QueryWrapper<>();
        QwPPC.eq("purchase_contract_no", purchaseContract.getPurchaseContractNo());
        List<PurchasePaymentContract> purchasePaymentContractList=purchasePaymentContractMapper.selectList(QwPPC);
        for(PurchasePaymentContract purchasePaymentContract:purchasePaymentContractList){
            //        删除相关审核记录
            QueryWrapper<PurchaseDirectorState> directorStateQw = new QueryWrapper<>();
            directorStateQw.eq("purchase_payment_contract_id", id);
            purchaseDirectorStateMapper.delete(directorStateQw);
        }
        purchasePaymentContractMapper.delete(QwPPC);

//        删库存和入库记录
        QueryWrapper<OtherInOut> QwOtherInOut = new QueryWrapper<>();
        QwOtherInOut.eq("in_out_contract_no", purchaseContract.getPurchaseContractNo());
        List<OtherInOut> otherInOuts = otherInOutMapper.selectList(QwOtherInOut);
//        QueryWrapper<OwnInOut> QwOwnInOut= new QueryWrapper<>();
//        QwOwnInOut.eq("in_out_contract_no",purchaseContract.getPurchaseContractNo());
//        List<OwnInOut> ownInOuts=ownInOutMapper.selectList(QwOwnInOut);
        if (otherInOuts.size() != 0) {
            for (int i = 0; i < otherInOuts.size(); i++) {
                QueryWrapper<OtherWarehouse> QwOtherWarehouse = new QueryWrapper<>();
                QwOtherWarehouse.eq("id", otherInOuts.get(i).getOtherWarehouseId()).eq("goods_name", otherInOuts.get(i).getInOutGoodsName());
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(QwOtherWarehouse);
                if ("吨".equals(purchaseContract.getGoodsUnit())) {
                    otherWarehouse.setGoodsCount(otherWarehouse.getGoodsCount().subtract(UnitUtils.TtoG(otherInOuts.get(i).getInOutGoodsCount())));
                } else {
                    otherWarehouse.setGoodsCount(otherWarehouse.getGoodsCount().subtract(otherInOuts.get(i).getInOutGoodsCount()));
                }
                otherWarehouseMapper.updateById(otherWarehouse);
                otherInOutMapper.deleteById(otherInOuts.get(i).getId());
            }
        }
//        if(ownInOuts.size()!=0){
//            for(int i=0;i<ownInOuts.size();i++){
//                QueryWrapper<OwnWarehouse> QwOwnWarehouse= new QueryWrapper<>();
//                QwOwnWarehouse.eq("goods_name",ownInOuts.get(i).getInOutGoodsName());
//                OwnWarehouse ownWarehouse=ownWarehouseMapper.selectOne(QwOwnWarehouse);
//                ownWarehouse.setGoodsCount(ownWarehouse.getGoodsCount().subtract(ownInOuts.get(i).getInOutGoodsCount()));
//                ownWarehouseMapper.updateById(ownWarehouse);
//                ownInOutMapper.deleteById(ownInOuts.get(i).getId());
//            }
//        }
        if(flag==0){
            ImageUtils.deleteImages(purchaseContractMapper.selectById(id).getContractPhoto());
        }
        return purchaseContractMapper.deleteById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteMorePurchaseContract(JSONArray ids) {
        LambdaQueryWrapper<PurchaseContract> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.in(PurchaseContract::getId, ids);
        return purchaseContractMapper.delete(lambdaQueryWrapper);
    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public int setPurchaseContractPigeonhole(int id, int pigeonhole) {
        PurchaseContract purchaseContract = purchaseContractMapper.selectById(id);
        if (pigeonhole == 1) {
            purchaseContract.setPigeonhole(0);
        } else {
            purchaseContract.setPigeonhole(1);
        }
        return purchaseContractMapper.updateById(purchaseContract);
    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public int addNewPurchaseContract(PurchaseContract purchaseContract,PurchaseContract oldPurchaseContract,int flag) {
        String contractPhotos = ImageUtils.getDBString(purchaseContract.getContractPhotoArray());
        if (contractPhotos != "") {
            purchaseContract.setContractPhoto(contractPhotos);
        }
        for (int i = 0; i < purchaseContract.getInboundData().size(); i++) {
//            当不是自家仓库时，即外商仓库
//            修改，不存在自家仓库的情况，只能从外商入
            if ("自家仓库".equals(purchaseContract.getInboundData().get(i).getFactoryName()) != true) {
//                查询是否存在对应外商仓库，且存储着对应物品
                QueryWrapper<OtherWarehouse> qw = new QueryWrapper<>();
                qw.eq("factory_name", purchaseContract.getInboundData().get(i).getFactoryName()).eq("goods_name", purchaseContract.getGoodsName());
                OtherWarehouse tempOtherWarehouse = otherWarehouseMapper.selectOne(qw);
                if (tempOtherWarehouse == null) {
//                    如果不存在对应库存信息，组建信息存储入数据库
                    OtherWarehouse otherWarehouse = new OtherWarehouse();
                    otherWarehouse.setFactoryName(purchaseContract.getInboundData().get(i).getFactoryName());
                    otherWarehouse.setGoodsName(purchaseContract.getGoodsName());
//                    判断单位是否是斤
                    if ("吨".equals(purchaseContract.getGoodsUnit())) {
                        otherWarehouse.setGoodsCount(UnitUtils.TtoG(purchaseContract.getInboundData().get(i).getInboundGoodsCount()));
                    } else {
                        otherWarehouse.setGoodsCount(purchaseContract.getInboundData().get(i).getInboundGoodsCount());
                    }
                    otherWarehouse.setCreateBy(SecurityUtils.getUsername());
                    otherWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                    int otherWarehouseId = addOtherWarehouse(otherWarehouse);
//                    获取到相应外商仓库的仓库ID，存储入库流水单
                    if (otherWarehouseId != 0) {
                        OtherInOut otherInOut = new OtherInOut();
                        otherInOut.setOtherWarehouseId(otherWarehouseId);
                        otherInOut.setInOutType(1);
                        otherInOut.setInOutContractNo(purchaseContract.getPurchaseContractNo());
                        otherInOut.setInOutGoodsName(purchaseContract.getGoodsName());
                        otherInOut.setInOutGoodsCount(purchaseContract.getInboundData().get(i).getInboundGoodsCount());
                        otherInOut.setInOutGoodsUnit(purchaseContract.getGoodsUnit());
                        if ("吨".equals(purchaseContract.getGoodsUnit())) {
                            otherInOut.setInOutGoodsUnitPrice(UnitUtils.GtoT(purchaseContract.getInboundData().get(i).getGoodsUnitPrice()));
                        } else {
                            otherInOut.setInOutGoodsUnitPrice(purchaseContract.getInboundData().get(i).getGoodsUnitPrice());
                        }
                        otherInOut.setInOutTime(purchaseContract.getInboundTime());
                        otherInOut.setCreateBy(SecurityUtils.getUsername());
                        otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                        otherInOutMapper.insert(otherInOut);
                    }
                } else {
//                    如果存在对应库存信息，则判断单位后，更新库存量，并存储入库流水单
                    if ("吨".equals(purchaseContract.getGoodsUnit())) {
                        tempOtherWarehouse.setGoodsCount(tempOtherWarehouse.getGoodsCount().add(UnitUtils.TtoG(purchaseContract.getInboundData().get(i).getInboundGoodsCount())));
                    } else {
                        tempOtherWarehouse.setGoodsCount(tempOtherWarehouse.getGoodsCount().add(purchaseContract.getInboundData().get(i).getInboundGoodsCount()));
                    }
                    tempOtherWarehouse.setLastUpdateBy(SecurityUtils.getUsername());
                    otherWarehouseMapper.updateById(tempOtherWarehouse);
                    OtherInOut otherInOut = new OtherInOut();
                    otherInOut.setOtherWarehouseId(tempOtherWarehouse.getId());
                    otherInOut.setInOutType(1);
                    otherInOut.setInOutContractNo(purchaseContract.getPurchaseContractNo());
                    otherInOut.setInOutGoodsName(purchaseContract.getGoodsName());
                    otherInOut.setInOutGoodsCount(purchaseContract.getInboundData().get(i).getInboundGoodsCount());
                    otherInOut.setInOutGoodsUnit(purchaseContract.getGoodsUnit());
                    if ("吨".equals(purchaseContract.getGoodsUnit())) {
                        otherInOut.setInOutGoodsUnitPrice(UnitUtils.GtoT(purchaseContract.getInboundData().get(i).getGoodsUnitPrice()));
                    } else {
                        otherInOut.setInOutGoodsUnitPrice(purchaseContract.getInboundData().get(i).getGoodsUnitPrice());
                    }
                    otherInOut.setInOutTime(purchaseContract.getInboundTime());
                    otherInOut.setCreateBy(SecurityUtils.getUsername());
                    otherInOut.setLastUpdateBy(SecurityUtils.getUsername());
                    otherInOutMapper.insert(otherInOut);
                }
            } else {
////                是自家仓库，则查询是否存在对应的库存信息
//                QueryWrapper<OwnWarehouse> qw= new QueryWrapper<>();
//                qw.eq("goods_name",purchaseContract.getGoodsName()).eq("goods_unit",purchaseContract.getGoodsUnit());
//                OwnWarehouse tempOwnWarehouse=ownWarehouseMapper.selectOne(qw);
//                if(tempOwnWarehouse==null){
////                    若不存在对应的库存信息，则组建库存信息，存入数据库
//                    OwnWarehouse ownWarehouse=new OwnWarehouse();
//                    ownWarehouse.setFactoryName("自家仓库");
//                    ownWarehouse.setGoodsName(purchaseContract.getGoodsName());
//                    ownWarehouse.setGoodsCount(purchaseContract.getInboundData().get(i).getInboundGoodsCount());
//                    ownWarehouse.setGoodsUnit(purchaseContract.getGoodsUnit());
//                    int ownWarehouseId=addOwnWarehouse(ownWarehouse);
//                    if(ownWarehouseId!=0){
////                        存储入库流水单
//                        OwnInOut ownInOut=new OwnInOut();
//                        ownInOut.setInOutType(1);
//                        ownInOut.setInOutContractNo(purchaseContract.getPurchaseContractNo());
//                        ownInOut.setInOutGoodsName(purchaseContract.getGoodsName());
//                        ownInOut.setInOutGoodsCount(purchaseContract.getInboundData().get(i).getInboundGoodsCount());
//                        ownInOut.setInOutGoodsUnit(purchaseContract.getGoodsUnit());
//                        ownInOutMapper.insert(ownInOut);
//                    }
//                }else {
////                    如果存在对应库存信息，则更新库存量，并存储入库流水单
//                    tempOwnWarehouse.setGoodsCount(tempOwnWarehouse.getGoodsCount().add(purchaseContract.getInboundData().get(i).getInboundGoodsCount()));
//                    ownWarehouseMapper.updateById(tempOwnWarehouse);
//                    OwnInOut ownInOut=new OwnInOut();
//                    ownInOut.setInOutType(1);
//                    ownInOut.setInOutContractNo(purchaseContract.getPurchaseContractNo());
//                    ownInOut.setInOutGoodsName(purchaseContract.getGoodsName());
//                    ownInOut.setInOutGoodsCount(purchaseContract.getInboundData().get(i).getInboundGoodsCount());
//                    ownInOut.setInOutGoodsUnit(purchaseContract.getGoodsUnit());
//                    ownInOutMapper.insert(ownInOut);
//                }
            }
        }
        if(flag==1){
            purchaseContract.setUnpaidAmount(oldPurchaseContract.getPaymentAmount());
            purchaseContract.setCreateTime(oldPurchaseContract.getCreateTime());
            purchaseContract.setCreateBy(oldPurchaseContract.getCreateBy());
        }else{
            purchaseContract.setUnpaidAmount(purchaseContract.getPaymentAmount());
            purchaseContract.setCreateBy(SecurityUtils.getUsername());
        }
        purchaseContract.setLastUpdateBy(SecurityUtils.getUsername());
        return purchaseContractMapper.insert(purchaseContract);
    }

    @Override
    public List<InboundBean> getPurchaseContractInboundData(String purchaseContractNo) {
        List<InboundBean> inboundData=new ArrayList<>();

        QueryWrapper<OtherInOut> QwOtherInOut = new QueryWrapper<>();
        QwOtherInOut.eq("in_out_contract_no", purchaseContractNo);
        List<OtherInOut> otherInOuts = otherInOutMapper.selectList(QwOtherInOut);
        if (otherInOuts.size() != 0) {
            for (int i = 0; i < otherInOuts.size(); i++) {
                QueryWrapper<OtherWarehouse> QwOtherWarehouse = new QueryWrapper<>();
                QwOtherWarehouse.eq("id", otherInOuts.get(i).getOtherWarehouseId()).eq("goods_name", otherInOuts.get(i).getInOutGoodsName());
                OtherWarehouse otherWarehouse = otherWarehouseMapper.selectOne(QwOtherWarehouse);

                InboundBean inboundBean=new InboundBean();
                inboundBean.setFactoryName(otherWarehouse.getFactoryName());
                inboundBean.setInboundGoodsCount(otherInOuts.get(i).getInOutGoodsCount());
                if ("吨".equals(otherInOuts.get(i).getInOutGoodsUnit())) {
                    inboundBean.setGoodsUnitPrice((UnitUtils.TtoG(otherInOuts.get(i).getInOutGoodsUnitPrice())));
                } else {
                    inboundBean.setGoodsUnitPrice(otherInOuts.get(i).getInOutGoodsUnitPrice());
                }

                inboundData.add(inboundBean);
            }
        }
        return inboundData;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updatePurchaseContract(PurchaseContract purchaseContract) {
        int result=0;

        QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
        qw.eq("purchase_contract_no", purchaseContract.getOldPurchaseContractNo());
        PurchaseContract oldPurchaseContract=purchaseContractMapper.selectOne(qw);

        if(purchaseContract.getOnlyUpdatePhoto()==1){
//            只修改了图片
            if (ImageUtils.getDBString(purchaseContract.getContractPhotoArray()) != "") {
                oldPurchaseContract.setContractPhoto(ImageUtils.getDBString(purchaseContract.getContractPhotoArray()));
            }else{
                oldPurchaseContract.setContractPhoto(null);
            }
            result=purchaseContractMapper.updateById(oldPurchaseContract);
        }else{
            //        0代表是删除，1代表是更新，所以此次选择1，则不删除原图片
            if(deleteOnePurchaseContract(purchaseContract.getId(),1)==1){
//                0代表是新增，1代表是更新，所以此次选择1，则需更改创建者和创建时间
                result=addNewPurchaseContract(purchaseContract,oldPurchaseContract,1);
            }
        }
        return result;
    }

    /**
     * * 添加外商库存信息，添加失败则返回0
     *
     * @param otherWarehouse
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public int addOtherWarehouse(OtherWarehouse otherWarehouse) {
        if (otherWarehouseMapper.insert(otherWarehouse) == 1) {
            return otherWarehouse.getId();
        } else {
            return 0;
        }
    }

    /**
     * * 添加自家仓库库存信息，添加失败则返回0
     *
     * @param ownWarehouse
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public int addOwnWarehouse(OwnWarehouse ownWarehouse) {
        if (ownWarehouseMapper.insert(ownWarehouse) == 1) {
            return ownWarehouse.getId();
        } else {
            return 0;
        }
    }


    /**
     * 查询采购单详情
     * * @param purchaseContractNo
     *
     * @return
     */
    @Override
    public List<InboundDetailInfo> getPurchaseDetail(String purchaseContractNo, String goodsName) {
        QueryWrapper<InboundDetailInfo> QwInboundDetail = new QueryWrapper<>();
        QwInboundDetail.eq("purchase_contract_no", purchaseContractNo).eq("in_out_goods_name", goodsName);
        List<InboundDetailInfo> inboundDetailInfos = inboundDetailInfoMapper.selectList(QwInboundDetail);
        for (InboundDetailInfo inboundDetailInfo : inboundDetailInfos) {
            QueryWrapper<OutboundDetailInfo> QwOutboundDetail = new QueryWrapper<>();
            QwOutboundDetail.eq("purchase_contract_no", inboundDetailInfo.getPurchaseContractNo()).eq("goods_factory", inboundDetailInfo.getFactoryName());
            List<OutboundDetailInfo> outboundDetailInfos = outboundDetailInfoMapper.selectList(QwOutboundDetail);
            inboundDetailInfo.setOutboundDetailInfos(outboundDetailInfos);
            BigDecimal currentGoodsCount = BigDecimal.valueOf(0);
            for (OutboundDetailInfo outboundDetailInfo : outboundDetailInfos) {
                currentGoodsCount = currentGoodsCount.add(outboundDetailInfo.getGoodsWeight());
            }
            inboundDetailInfo.setCurrentGoodsCount(inboundDetailInfo.getInOutGoodsCount().subtract(currentGoodsCount));
        }
        return inboundDetailInfos;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int handleImportPurchaseContractModel(ImportPurchaseContractModel importPurchaseContractModel) {
        PurchaseContract purchaseContract = new PurchaseContract();
//        采购合同号
        if (importPurchaseContractModel.getPurchaseContractNo() == null) {
            return 0;
        } else {
//            检验是否重复
            if (checkPurchaseContractNo(importPurchaseContractModel.getPurchaseContractNo())) {
                return 0;
            } else {
                purchaseContract.setPurchaseContractNo(importPurchaseContractModel.getPurchaseContractNo());
            }
        }
//        供货方公司名
        if (importPurchaseContractModel.getCustomerEnterpriseName() != null) {
            purchaseContract.setCustomerEnterpriseName(importPurchaseContractModel.getCustomerEnterpriseName());
        }
        if (importPurchaseContractModel.getOwnCompanyName() != null) {
            purchaseContract.setOwnCompanyName(importPurchaseContractModel.getOwnCompanyName());
        }
        if (importPurchaseContractModel.getSqueezeSeason() != null) {
            purchaseContract.setSqueezeSeason(importPurchaseContractModel.getSqueezeSeason());
        }
        if (importPurchaseContractModel.getInboundTime() != null) {
            purchaseContract.setInboundTime(importPurchaseContractModel.getInboundTime());
        }
        if (importPurchaseContractModel.getGoodsName() != null) {
            purchaseContract.setGoodsName(importPurchaseContractModel.getGoodsName());
        }
        if (importPurchaseContractModel.getGoodsCount() != null) {
            purchaseContract.setGoodsCount(importPurchaseContractModel.getGoodsCount());
        }
        if (importPurchaseContractModel.getGoodsUnit() != null) {
            purchaseContract.setGoodsUnit(importPurchaseContractModel.getGoodsUnit());
        }
        if (importPurchaseContractModel.getPaymentAmount() != null) {
            purchaseContract.setPaymentAmount(importPurchaseContractModel.getPaymentAmount());
        }

        purchaseContract.setUnpaidAmount(BigDecimal.valueOf(0));

        try {
            List<InboundBean> inboundBeans = new ArrayList<>();
            for (int i = 1; i <= 20; i++) {
                Method nameMethod = importPurchaseContractModel.getClass().getMethod("getFactoryName" + i);
                Method countMethod = importPurchaseContractModel.getClass().getMethod("getInboundGoodsCount" + i);
                if (nameMethod.invoke(importPurchaseContractModel) != null && countMethod.invoke(importPurchaseContractModel) != null) {
                    InboundBean inboundBean = new InboundBean();
                    inboundBean.setFactoryName(String.valueOf(nameMethod.invoke(importPurchaseContractModel)));
                    inboundBean.setInboundGoodsCount((BigDecimal) countMethod.invoke(importPurchaseContractModel));
                    inboundBeans.add(inboundBean);
                } else {
                    break;
                }
            }
            purchaseContract.setInboundData(inboundBeans);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

        return addNewPurchaseContract(purchaseContract,null,0);
    }


    @Override
    public Page<PurchaseContract> getTPurchaseContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
        qw.eq("pigeonhole", 1).orderByDesc("create_time");
        Page<PurchaseContract> page = new Page<>(currentPage, pageSize);
        page = purchaseContractMapper.selectPage(page, qw);
        for (PurchaseContract record : page.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            } else {
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<PurchaseContract> getFPurchaseContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
        qw.eq("pigeonhole", 0).orderByDesc("create_time");
        Page<PurchaseContract> page = new Page<>(currentPage, pageSize);
        page = purchaseContractMapper.selectPage(page, qw);
        for (PurchaseContract record : page.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            } else {
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<PurchaseContract> searchPurchaseContract(int currentPage, int pageSize, String searchWord, boolean showPigeonhole, Date startDate, Date endDate) {
        QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
        if (showPigeonhole == false) {
            if (startDate == null && endDate == null) {
                qw.eq("pigeonhole", 1).and(q -> {
                    q.like("purchase_contract_no", searchWord)
                            .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                            .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                            .or().like("create_by", searchWord);
                }).orderByDesc("create_time");
            } else {
                qw.eq("pigeonhole", 1).and(q -> {
                    q.like("purchase_contract_no", searchWord)
                            .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                            .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                            .or().like("create_by", searchWord);
                }).ge("inbound_time", startDate).le("inbound_time", endDate).orderByDesc("create_time");
            }
        } else {
            if (startDate == null && endDate == null) {
                qw.eq("pigeonhole", 0).and(q -> {
                    q.like("purchase_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                            .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                            .like("goods_name", searchWord).or().like("create_by", searchWord);
                }).orderByDesc("create_time");
            } else {
                qw.eq("pigeonhole", 0).and(q -> {
                            q.like("purchase_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                                    .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                                    .like("goods_name", searchWord).or().like("create_by", searchWord);
                        })
                        .ge("inbound_time", startDate).le("inbound_time", endDate).orderByDesc("create_time");
            }
        }
        Page<PurchaseContract> page = new Page<>(currentPage, pageSize);
        page = purchaseContractMapper.selectPage(page, qw);
        for (PurchaseContract record : page.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            } else {
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
        }
        return page;
    }

    @Override
    public List<ExportOutPurchaseContract> purchaseExportExcel(String searchWord, boolean showPigeonhole, Date startDate, Date endDate) {
        QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
        if (showPigeonhole == false) {
            if (startDate == null && endDate == null) {
                qw.eq("pigeonhole", 1).and(q -> {
                    q.like("purchase_contract_no", searchWord)
                            .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                            .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                            .or().like("create_by", searchWord);
                }).orderByDesc("create_time");
            } else {
                qw.eq("pigeonhole", 1).and(q -> {
                    q.like("purchase_contract_no", searchWord)
                            .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                            .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                            .or().like("create_by", searchWord);
                }).ge("inbound_time", startDate).le("inbound_time", endDate).orderByDesc("create_time");
            }
        } else {
            if (startDate == null && endDate == null) {
                qw.eq("pigeonhole", 0).and(q -> {
                    q.like("purchase_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                            .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                            .like("goods_name", searchWord).or().like("create_by", searchWord);
                }).orderByDesc("create_time");
            } else {
                qw.eq("pigeonhole", 0).and(q -> {
                            q.like("purchase_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                                    .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                                    .like("goods_name", searchWord).or().like("create_by", searchWord);
                        })
                        .ge("inbound_time", startDate).le("inbound_time", endDate).orderByDesc("create_time");
            }
        }
        List<PurchaseContract> purchaseContracts = purchaseContractMapper.selectList(qw);
        List<ExportOutPurchaseContract> exportOutPurchaseContracts = new ArrayList<>();
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (PurchaseContract purchaseContract : purchaseContracts) {
            ExportOutPurchaseContract exportOutPurchaseContract = new ExportOutPurchaseContract();
            exportOutPurchaseContract.setPurchaseContractNo(purchaseContract.getPurchaseContractNo());
            exportOutPurchaseContract.setCustomerEnterpriseName(purchaseContract.getCustomerEnterpriseName());
            exportOutPurchaseContract.setOwnCompanyName(purchaseContract.getOwnCompanyName());
            exportOutPurchaseContract.setSqueezeSeason(purchaseContract.getSqueezeSeason());
            exportOutPurchaseContract.setInboundTime(purchaseContract.getInboundTime());
            exportOutPurchaseContract.setGoodsName(purchaseContract.getGoodsName());
            exportOutPurchaseContract.setGoodsCount(purchaseContract.getGoodsCount());
            exportOutPurchaseContract.setGoodsUnit(purchaseContract.getGoodsUnit());
            exportOutPurchaseContract.setPaymentAmount(purchaseContract.getPaymentAmount());
            exportOutPurchaseContract.setUnpaidAmount(purchaseContract.getUnpaidAmount());
            exportOutPurchaseContract.setCreateTime(purchaseContract.getCreateTime());
            exportOutPurchaseContract.setCreateBy(purchaseContract.getCreateBy());
            exportOutPurchaseContract.setLastUpdateTime(purchaseContract.getLastUpdateTime());
            exportOutPurchaseContract.setLastUpdateBy(purchaseContract.getLastUpdateBy());
            exportOutPurchaseContracts.add(exportOutPurchaseContract);
        }
        return exportOutPurchaseContracts;
    }

    @Override
    public Boolean checkPurchaseContractNo(String purchaseContractNo) {
        QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
        qw.eq("purchase_contract_no", purchaseContractNo).orderByDesc("create_time");
        List<PurchaseContract> purchaseContracts = purchaseContractMapper.selectList(qw);
        return !purchaseContracts.isEmpty();
    }
}




