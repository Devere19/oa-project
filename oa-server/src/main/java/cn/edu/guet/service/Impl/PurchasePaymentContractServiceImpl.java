package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.mapper.*;
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

    @Override
    public Page<PurchasePaymentContractView> getPurchasePaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        for (PurchasePaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).orderByDesc("nick_name");
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
            }else{
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<PurchasePaymentContractView> searchPurchasePaymentContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.like("purchase_contract_no",searchWord).or().like("customer_enterprise_name",searchWord).or()
                .like("own_company_name",searchWord).or().like("squeeze_season",searchWord).or()
                .like("goods_name",searchWord).or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord).orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        for (PurchasePaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).orderByDesc("nick_name");
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
            }else{
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
        int result=purchasePaymentContractMapper.insert(purchasePaymentContract);

        if(result==1) {
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
        }
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOnePurchasePaymentContract(int id) {
        PurchasePaymentContract purchasePaymentContract=purchasePaymentContractMapper.selectById(id);
//        删除相关审核记录
        QueryWrapper<PurchaseDirectorState> directorStateQw= new QueryWrapper<>();
        directorStateQw.eq("purchase_payment_contract_id",purchasePaymentContract.getId());
        purchaseDirectorStateMapper.delete(directorStateQw);

        return purchasePaymentContractMapper.deleteById(id);
    }

    @Override
    public Page<PurchasePaymentContractView> getCashierPurchasePayment(int currentPage, int pageSize) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        Iterator<PurchasePaymentContractView> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            PurchasePaymentContractView record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);

            if(purchasePaymentStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
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
                }else{
                    record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
                }
            }
        }
        return page;
    }

    @Override
    public Page<PurchasePaymentContractView> searchCashierPurchasePayment(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->q.like("purchase_contract_no",searchWord)
                .or().like("customer_enterprise_name",searchWord).or()
                .like("own_company_name",searchWord).or().like("squeeze_season",searchWord).or()
                .like("goods_name",searchWord).or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord)).orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        Iterator<PurchasePaymentContractView> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            PurchasePaymentContractView record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);

            if(purchasePaymentStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
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
                }else{
                    record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
                }
            }
        }
        return page;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int uploadCashierPurchasePayment(PurchasePaymentContract purchasePaymentContract) {
        PurchasePaymentContract oldPurchasePaymentContract= purchasePaymentContractMapper.selectById(purchasePaymentContract.getId());
        String paymentPhotos=ImageUtils.getDBString(purchasePaymentContract.getPaymentPhotoArray());
        if(paymentPhotos!=""){
            oldPurchasePaymentContract.setPaymentPhoto(paymentPhotos);
        }
        oldPurchasePaymentContract.setCashier(SecurityUtils.getUsername());
        oldPurchasePaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        oldPurchasePaymentContract.setPaymentTime(purchasePaymentContract.getPaymentTime());
        return purchasePaymentContractMapper.updateById(oldPurchasePaymentContract);
    }


    @Override
    public int changeFinanceState(String purchaseContractNo) {
        UpdateWrapper<PurchasePaymentContract> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("purchase_contract_no",purchaseContractNo).set("finance_state", 1);
        return purchasePaymentContractMapper.update(null, updateWrapper);
    }

    @Override
    public int changeDirectorState(int purchasePaymentContractId, int userId) {
        UpdateWrapper<PurchaseDirectorState> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("purchase_payment_contract_id",purchasePaymentContractId).eq("user_id",userId).set("state", 1);
        return purchaseDirectorStateMapper.update(null, updateWrapper);

//    APP方法
    /**
     * * 获取董事采购单数据
     * @param currentPage
     * @param pageSize
     * @param userId
     * @param type
     * @return
     */
    @Override
    public Page<PurchasePaymentContractView> getDirectorPPC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        Iterator<PurchasePaymentContractView> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            PurchasePaymentContractView record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).orderByDesc("nick_name");
            List<PurchasePaymentStateView> purchasePaymentStateViews = purchasePaymentStateInfoMapper.selectList(stateQw);

            int flag=0;
            for(int i=0;i<purchasePaymentStateViews.size();i++){
//                获取已经审核了的董事次数
                if(purchasePaymentStateViews.get(i).getState()!=null){
                    flag++;
                }
//                判断是否有该登录的董事
                if(purchasePaymentStateViews.get(i).getUserId()==userId){
//                    如果有，对该董事审批结果进行判断，此处判断是否为已审批
                    if(purchasePaymentStateViews.get(i).getState()!=null){
//                        若已审批，则判断是不是获取未审批的订单
                        if(type==0){
//                            则当获取的是未审批的订单时，移除数据
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                        }else{
//                            循环为最后一次时
                            if(i==purchasePaymentStateViews.size()-1){
//                                判断不为空的值是不是3，是3则代表已完成
                                if(flag==3){
                                    if(type==1){
//                                        所以获取已审批时则移除数据
                                        iterator.remove();
                                        page.setTotal(page.getTotal()-1);
                                    }
                                }else{
//                                    当不是3时，则代表本人已审批，但其他董事未审批完
                                    if(type==2){
//                                        所以获取已完成时移除数据
                                        iterator.remove();
                                        page.setTotal(page.getTotal()-1);
                                    }
                                }
                            }
                        }
                    }else{
//                        如果为未审批，则判断是要已审批的和已完成的不，是则去除
                        if(type==1||type==2){
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                        }
                    }
                    break;
                }else{
//                    如果这次没有，而且第三次了还没有，说明该董事不是审核该笔采购单的，移除该条数据
                    if(i==purchasePaymentStateViews.size()-1){
                        iterator.remove();
                        page.setTotal(page.getTotal()-1);
                    }
                }
            }
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
            }else{
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;

    }

}




