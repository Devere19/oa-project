package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.ImportModel.ImportPurchasePaymentContractModel;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.PurchaseContractService;
import cn.edu.guet.service.PurchasePaymentContractService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/**
 * @author 陶祎祎
 * @description 针对表【purchase_payment_contract】的数据库操作Service实现
 * @createDate 2022-11-10 20:41:25
 */
@Service
public class PurchasePaymentContractServiceImpl extends ServiceImpl<PurchasePaymentContractMapper, PurchasePaymentContract>
        implements PurchasePaymentContractService {

    @Autowired
    private PurchasePaymentContractInfoMapper purchasePaymentContractInfoMapper;

    @Autowired
    private PurchasePaymentContractMapper purchasePaymentContractMapper;

    @Autowired
    private PurchasePaymentStateInfoMapper purchasePaymentStateInfoMapper;

    @Autowired
    private PurchaseDirectorStateMapper purchaseDirectorStateMapper;

    @Autowired
    private DirectorMapper directorMapper;

    @Autowired
    private PurchaseContractMapper purchaseContractMapper;
    
    @Autowired
    private PurchaseContractService purchaseContractService;

    @Autowired
    private CashierPurchasePaymentMapper cashierPurchasePaymentMapper;

    @Override
    public Page<PurchasePaymentContractView> getPurchasePaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchasePaymentContractView> qw = new QueryWrapper<>();
        qw.orderByDesc("create_time","id");
        Page<PurchasePaymentContractView> page = new Page<>(currentPage, pageSize);
        page = purchasePaymentContractInfoMapper.selectPage(page, qw);
        for (PurchasePaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id", record.getId()).orderByDesc("nick_name");
            record.setPurchasePaymentDirector(purchasePaymentStateInfoMapper.selectList(stateQw));

            //处理图片，形成一个图片数组
            String paymentPhoto = record.getPaymentPhoto();
//            付款照片
            if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(paymentPhoto);
                record.setPaymentPhotoArray(list);
                //取第一个图片的url
                record.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<PurchasePaymentContractView> searchPurchasePaymentContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<PurchasePaymentContractView> qw = new QueryWrapper<>();
        qw.like("purchase_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                .like("goods_name", searchWord).or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord).orderByDesc("create_time","id");
        Page<PurchasePaymentContractView> page = new Page<>(currentPage, pageSize);
        page = purchasePaymentContractInfoMapper.selectPage(page, qw);
        for (PurchasePaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id", record.getId()).orderByDesc("nick_name");
            record.setPurchasePaymentDirector(purchasePaymentStateInfoMapper.selectList(stateQw));

            //处理图片，形成一个图片数组
            String paymentPhoto = record.getPaymentPhoto();
//            付款照片
            if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(paymentPhoto);
                record.setPaymentPhotoArray(list);
                //取第一个图片的url
                record.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int addNewPurchasePaymentContract(PurchasePaymentContract purchasePaymentContract) {
        purchasePaymentContract.setCreateBy(SecurityUtils.getUsername());
        purchasePaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        int result = purchasePaymentContractMapper.insert(purchasePaymentContract);

        if (result == 1) {
//        查询出董事会的ID
            QueryWrapper<Director> directorQw = new QueryWrapper<>();
            directorQw.orderByAsc("nick_name").last("limit 3");
            List<Director> directors = directorMapper.selectList(directorQw);

//        循环添加采购付款单的董事审核记录
            for (Director director : directors) {
                PurchaseDirectorState purchaseDirectorState = new PurchaseDirectorState();
                purchaseDirectorState.setPurchasePaymentContractId(purchasePaymentContract.getId());
                purchaseDirectorState.setUserId(Math.toIntExact(director.getId()));
                purchaseDirectorState.setCreateBy(SecurityUtils.getUsername());
                purchaseDirectorState.setLastUpdateBy(SecurityUtils.getUsername());
                purchaseDirectorStateMapper.insert(purchaseDirectorState);
            }

            //            获取采购单,修改存在采购付款单标记
            QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
            qw.eq("purchase_contract_no", purchasePaymentContract.getPurchaseContractNo());
            PurchaseContract purchaseContract=purchaseContractMapper.selectOne(qw);
            purchaseContract.setRelationPaymentExistState(1);
            purchaseContractMapper.updateById(purchaseContract);
        }
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updatePurchasePaymentContract(PurchasePaymentContract purchasePaymentContract) {
        PurchasePaymentContract oldPurchasePaymentContract=purchasePaymentContractMapper.selectById(purchasePaymentContract.getId());
        oldPurchasePaymentContract.setPurchaseContractNo(purchasePaymentContract.getPurchaseContractNo());
        oldPurchasePaymentContract.setPaymentCount(purchasePaymentContract.getPaymentCount());
        oldPurchasePaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        return purchasePaymentContractMapper.updateById(oldPurchasePaymentContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOnePurchasePaymentContract(int id) {
        String purchaseContractNo=purchasePaymentContractMapper.selectById(id).getPurchaseContractNo();

        int result=purchasePaymentContractMapper.deleteById(id);

        if(result==1){
            //        删除相关审核记录
            QueryWrapper<PurchaseDirectorState> directorStateQw = new QueryWrapper<>();
            directorStateQw.eq("purchase_payment_contract_id", id);
            purchaseDirectorStateMapper.delete(directorStateQw);

//            查询是否存在其他采购付款单
            QueryWrapper<PurchasePaymentContract> PPCQw = new QueryWrapper<>();
            PPCQw.eq("purchase_contract_no",purchaseContractNo);
            List<PurchasePaymentContract> purchasePaymentContractList=purchasePaymentContractMapper.selectList(PPCQw);

//            若不存在则修改采购单字段
            if(purchasePaymentContractList.isEmpty()==true){
                //            获取采购单
                QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
                qw.eq("purchase_contract_no", purchaseContractNo);
                PurchaseContract purchaseContract=purchaseContractMapper.selectOne(qw);
                purchaseContract.setRelationPaymentExistState(0);
                purchaseContractMapper.updateById(purchaseContract);
            }
        }

        return result;
    }

    @Override
    public PurchasePaymentContractView getOnePurchasePaymentContract(int id) {
        PurchasePaymentContractView purchasePaymentContractView=purchasePaymentContractInfoMapper.selectById(id);

        QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("purchase_payment_contract_id", id).orderByDesc("nick_name");
        purchasePaymentContractView.setPurchasePaymentDirector(purchasePaymentStateInfoMapper.selectList(stateQw));

        return purchasePaymentContractView;
    }

    @Override
    public int handleImportPurchasePaymentContractModel(ImportPurchasePaymentContractModel importPurchasePaymentContractModel) {
        PurchasePaymentContract purchasePaymentContract = new PurchasePaymentContract();
//        采购合同号
        if (importPurchasePaymentContractModel.getPurchaseContractNo() == null) {
            return 0;
        } else {
//            检验是否存在
            if (purchaseContractService.checkPurchaseContractNo(importPurchasePaymentContractModel.getPurchaseContractNo())) {
                purchasePaymentContract.setPurchaseContractNo(importPurchasePaymentContractModel.getPurchaseContractNo());
            } else {
                return 0;
            }
        }

        if (importPurchasePaymentContractModel.getPaymentCount() != null) {
            purchasePaymentContract.setPaymentCount(importPurchasePaymentContractModel.getPaymentCount());
        }
        
        return addNewPurchasePaymentContract(purchasePaymentContract);
    }

    @Override
    public Page<CashierPurchasePayment> getCashierPurchasePayment(int currentPage, int pageSize) {
        QueryWrapper<CashierPurchasePayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").orderByDesc("create_time","id");
        Page<CashierPurchasePayment> page = new Page<>(currentPage, pageSize);
        page = cashierPurchasePaymentMapper.selectPage(page, qw);
        Iterator<CashierPurchasePayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierPurchasePayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);

            if (purchasePaymentStateViews.size() < 3) {
                iterator.remove();
                page.setTotal(page.getTotal() - 1);
            } else {
                record.setPurchasePaymentDirector(purchasePaymentStateViews);

                //处理图片，形成一个图片数组
                String paymentPhoto = record.getPaymentPhoto();
//            付款照片
                if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                    //分割图片字符串，形成一个数组
                    List<String> list = ImageUtils.imageSplit(paymentPhoto);
                    record.setPaymentPhotoArray(list);
                    //取第一个图片的url
                    record.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
                } else {
                    record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
                }
            }
        }
        return page;
    }

    @Override
    public Page<CashierPurchasePayment> searchCashierPurchasePayment(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<CashierPurchasePayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").and(q -> q.like("purchase_contract_no", searchWord)
                .or().like("customer_enterprise_name", searchWord).or()
                .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                .like("goods_name", searchWord).or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord)).orderByDesc("create_time","id");
        Page<CashierPurchasePayment> page = new Page<>(currentPage, pageSize);
        page = cashierPurchasePaymentMapper.selectPage(page, qw);
        Iterator<CashierPurchasePayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierPurchasePayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);

            if (purchasePaymentStateViews.size() < 3) {
                iterator.remove();
                page.setTotal(page.getTotal() - 1);
            } else {
                record.setPurchasePaymentDirector(purchasePaymentStateViews);

                //处理图片，形成一个图片数组
                String paymentPhoto = record.getPaymentPhoto();
//            付款照片
                if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                    //分割图片字符串，形成一个数组
                    List<String> list = ImageUtils.imageSplit(paymentPhoto);
                    record.setPaymentPhotoArray(list);
                    //取第一个图片的url
                    record.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
                } else {
                    record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
                }
            }
        }
        return page;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int uploadCashierPurchasePayment(PurchasePaymentContract purchasePaymentContract) {
        PurchasePaymentContract oldPurchasePaymentContract = purchasePaymentContractMapper.selectById(purchasePaymentContract.getId());
        String paymentPhotos = ImageUtils.getDBString(purchasePaymentContract.getPaymentPhotoArray());
        if (paymentPhotos != "") {
            oldPurchasePaymentContract.setPaymentPhoto(paymentPhotos);
        }
        oldPurchasePaymentContract.setCashier(SecurityUtils.getUsername());
        oldPurchasePaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        oldPurchasePaymentContract.setPaymentTime(purchasePaymentContract.getPaymentTime());

        int result=purchasePaymentContractMapper.updateById(oldPurchasePaymentContract);

        if(result==1){
            QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
            qw.eq("purchase_contract_no",oldPurchasePaymentContract.getPurchaseContractNo());
            PurchaseContract purchaseContract=purchaseContractMapper.selectOne(qw);
            purchaseContract.setUnpaidAmount(purchaseContract.getPaymentAmount().subtract(oldPurchasePaymentContract.getPaymentCount()));

            purchaseContractMapper.updateById(purchaseContract);
        }

        return result;
    }


    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeFinanceState(int id, String financeStaff) {
        UpdateWrapper<PurchasePaymentContract> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("id", id).set("finance_state", 1).set("finance_staff", financeStaff);

        int result=purchasePaymentContractMapper.update(null, updateWrapper);

        if(result==1){
            QueryWrapper<PurchaseContract> qw = new QueryWrapper<>();
            qw.eq("purchase_contract_no", purchasePaymentContractMapper.selectById(id).getPurchaseContractNo());
            PurchaseContract purchaseContract=purchaseContractMapper.selectOne(qw);
            purchaseContract.setRelationPaymentAuditState(1);
            purchaseContractMapper.updateById(purchaseContract);
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeDirectorState(int purchasePaymentContractId, int userId) {
        UpdateWrapper<PurchaseDirectorState> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("purchase_payment_contract_id", purchasePaymentContractId).eq("user_id", userId).set("state", 1);
        return purchaseDirectorStateMapper.update(null, updateWrapper);

    }

//    APP方法

    /**
     * * 获取董事采购单数据
     *
     * @param currentPage
     * @param pageSize
     * @param userId
     * @param type
     * @return
     */
    @Override
    public Page<CashierPurchasePayment> getDirectorPPC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<CashierPurchasePayment> qw = new QueryWrapper<>();
//        该处的-是为了模糊匹配时匹配到完整的director_id
//        避免出现查userId=1，却查出userId=11这样的情况
        if(type==0){
            qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->
                    q.like("director_id",userId+"-").notLike("concat_director_state",userId+"-1")).orderByDesc("create_time","id");
        }else if(type==1){
            qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->
                    q.like("director_id",userId+"-").like("concat_director_state",userId+"-1").ne("director_state","1,1,1")).orderByDesc("create_time","id");
        }else if(type==2){
            qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->
                    q.like("director_id",userId+"-").like("concat_director_state",userId+"-1").eq("director_state","1,1,1")).orderByDesc("create_time","id");
        }
        Page<CashierPurchasePayment> page = new Page<>(currentPage, pageSize);
        page = cashierPurchasePaymentMapper.selectPage(page, qw);
        Iterator<CashierPurchasePayment> iterator = page.getRecords().iterator();

        while (iterator.hasNext()) {
            CashierPurchasePayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);
            record.setPurchasePaymentDirector(purchasePaymentStateViews);

            //处理图片，形成一个图片数组
            String paymentPhoto = record.getPaymentPhoto();
//            付款照片
            if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(paymentPhoto);
                record.setPaymentPhotoArray(list);
                //取第一个图片的url
                record.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

    @Override
    public PurchasePaymentContractView getOneDirectorPPC(int id) {
        PurchasePaymentContractView purchasePaymentContractView = purchasePaymentContractInfoMapper.selectById(id);
        QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("purchase_payment_contract_id", id).orderByDesc("nick_name");
        purchasePaymentContractView.setPurchasePaymentDirector(purchasePaymentStateInfoMapper.selectList(stateQw));
        //处理图片，形成一个图片数组
        String paymentPhoto = purchasePaymentContractView.getPaymentPhoto();
//            付款照片
        if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
            //分割图片字符串，形成一个数组
            List<String> list = ImageUtils.imageSplit(paymentPhoto);
            purchasePaymentContractView.setPaymentPhotoArray(list);
            //取第一个图片的url
            purchasePaymentContractView.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
        } else {
            purchasePaymentContractView.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
        }
        return purchasePaymentContractView;
    }

    @Override
    public Page<CashierPurchasePayment> searchDirectorPPC(int currentPage, int pageSize, String searchWord, int userId) {
        QueryWrapper<CashierPurchasePayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q -> q.like("director_id",userId+"-").and(w->w.like("purchase_contract_no", searchWord)
                .or().like("customer_enterprise_name", searchWord).or()
                .like("own_company_name", searchWord).or().like("squeeze_season", searchWord).or()
                .like("goods_name", searchWord).or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord))).orderByDesc("create_time","id");
        Page<CashierPurchasePayment> page = new Page<>(currentPage, pageSize);
        page = cashierPurchasePaymentMapper.selectPage(page, qw);
        Iterator<CashierPurchasePayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierPurchasePayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);
            record.setPurchasePaymentDirector(purchasePaymentStateViews);

            //处理图片，形成一个图片数组
            String paymentPhoto = record.getPaymentPhoto();
//            付款照片
            if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(paymentPhoto);
                record.setPaymentPhotoArray(list);
                //取第一个图片的url
                record.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

}




