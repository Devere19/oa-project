package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.LogisticsPaymentContractService;
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
* @description 针对表【logistics_payment_contract】的数据库操作Service实现
* @createDate 2022-11-12 21:15:26
*/
@Service
public class LogisticsPaymentContractServiceImpl extends ServiceImpl<LogisticsPaymentContractMapper, LogisticsPaymentContract>
    implements LogisticsPaymentContractService {

    @Autowired
    private LogisticsPaymentContractInfoMapper logisticsPaymentContractInfoMapper;

    @Autowired
    private LogisticsPaymentContractMapper logisticsPaymentContractMapper;

    @Autowired
    private LogisticsPaymentStateInfoMapper logisticsPaymentStateInfoMapper;

    @Autowired
    private LogisticsDirectorStateMapper logisticsDirectorStateMapper;

    @Autowired
    private DirectorMapper directorMapper;

    @Override
    public Page<LogisticsPaymentContractView> getLogisticsPaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<LogisticsPaymentContractView> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<LogisticsPaymentContractView> page =new Page<>(currentPage,pageSize);
        page=logisticsPaymentContractInfoMapper.selectPage(page,qw);
        for (LogisticsPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).orderByDesc("nick_name");
            record.setLogisticsPaymentDirector(logisticsPaymentStateInfoMapper.selectList(stateQw));

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
    public Page<LogisticsPaymentContractView> searchLogisticsPaymentContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<LogisticsPaymentContractView> qw= new QueryWrapper<>();
        qw.like("logistics_contract_no",searchWord).or().like("sale_contract_no",searchWord)
                .or().like("squeeze_season",searchWord).or().like("goods_name",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord).orderByDesc("create_time");
        Page<LogisticsPaymentContractView> page =new Page<>(currentPage,pageSize);
        page=logisticsPaymentContractInfoMapper.selectPage(page,qw);
        for (LogisticsPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).orderByDesc("nick_name");
            record.setLogisticsPaymentDirector(logisticsPaymentStateInfoMapper.selectList(stateQw));

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
    public int addNewLogisticsPaymentContract(LogisticsPaymentContract logisticsPaymentContract) {
        logisticsPaymentContract.setCreateBy(SecurityUtils.getUsername());
        logisticsPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        int result=logisticsPaymentContractMapper.insert(logisticsPaymentContract);

        if(result==1){
            //        查询出董事会的ID
            QueryWrapper<Director> directorQw= new QueryWrapper<>();
            directorQw.orderByAsc("nick_name").last("limit 3");
            List<Director> directors=directorMapper.selectList(directorQw);

//        循环添加采购付款单的董事审核记录
            for (Director director:directors){
                LogisticsDirectorState logisticsDirectorState=new LogisticsDirectorState();
                logisticsDirectorState.setLogisticsPaymentContractId(logisticsPaymentContract.getId());
                logisticsDirectorState.setUserId(Math.toIntExact(director.getId()));
                logisticsDirectorState.setCreateBy(SecurityUtils.getUsername());
                logisticsDirectorState.setLastUpdateBy(SecurityUtils.getUsername());
                logisticsDirectorStateMapper.insert(logisticsDirectorState);
            }
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneLogisticsPaymentContract(int id) {
        LogisticsPaymentContract logisticsPaymentContract=logisticsPaymentContractMapper.selectById(id);
//        删除相关审核记录
        QueryWrapper<LogisticsDirectorState> directorStateQw= new QueryWrapper<>();
        directorStateQw.eq("logistics_payment_contract_id",logisticsPaymentContract.getId());
        logisticsDirectorStateMapper.delete(directorStateQw);

        return logisticsPaymentContractMapper.deleteById(id);
    }

    @Override
    public Page<LogisticsPaymentContractView> getCashierLogisticsPayment(int currentPage, int pageSize) {
        QueryWrapper<LogisticsPaymentContractView> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<LogisticsPaymentContractView> page =new Page<>(currentPage,pageSize);
        page=logisticsPaymentContractInfoMapper.selectPage(page,qw);
        Iterator<LogisticsPaymentContractView> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            LogisticsPaymentContractView record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            if(logisticsPaymentStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
                record.setLogisticsPaymentDirector(logisticsPaymentStateViews);

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
    public Page<LogisticsPaymentContractView> searchCashierLogisticsPayment(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<LogisticsPaymentContractView> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->q.like("sale_contract_no",searchWord)
                .or().like("squeeze_season",searchWord).or().like("goods_name",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord)).orderByDesc("create_time");
        Page<LogisticsPaymentContractView> page =new Page<>(currentPage,pageSize);
        page=logisticsPaymentContractInfoMapper.selectPage(page,qw);
        Iterator<LogisticsPaymentContractView> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            LogisticsPaymentContractView record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            if(logisticsPaymentStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
                record.setLogisticsPaymentDirector(logisticsPaymentStateViews);

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
    public int uploadCashierLogisticsPayment(LogisticsPaymentContract logisticsPaymentContract) {
        LogisticsPaymentContract oldLogisticsPaymentContract= logisticsPaymentContractMapper.selectById(logisticsPaymentContract.getId());
        String paymentPhotos=ImageUtils.getDBString(logisticsPaymentContract.getPaymentPhotoArray());
        if(paymentPhotos!=""){
            oldLogisticsPaymentContract.setPaymentPhoto(paymentPhotos);
        }
        oldLogisticsPaymentContract.setCashier(SecurityUtils.getUsername());
        oldLogisticsPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        oldLogisticsPaymentContract.setPaymentTime(logisticsPaymentContract.getPaymentTime());
        return logisticsPaymentContractMapper.updateById(oldLogisticsPaymentContract);
    }

    @Override
    public Page<LogisticsPaymentContractView> getDirectorLPC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<LogisticsPaymentContractView> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<LogisticsPaymentContractView> page =new Page<>(currentPage,pageSize);
        page=logisticsPaymentContractInfoMapper.selectPage(page,qw);
        Iterator<LogisticsPaymentContractView> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            LogisticsPaymentContractView record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            int flag=0;
            for(int i=0;i<logisticsPaymentStateViews.size();i++){
//                获取已经审核了的董事次数
                if(logisticsPaymentStateViews.get(i).getState()!=null){
                    flag++;
                }
//                判断是否有该登录的董事
                if(logisticsPaymentStateViews.get(i).getUserId()==userId){
//                    如果有，对该董事审批结果进行判断，此处判断是否为已审批
                    if(logisticsPaymentStateViews.get(i).getState()!=null){
//                        若已审批，则判断是不是获取未审批的订单
                        if(type==0){
//                            则当获取的是未审批的订单时，移除数据
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                        }else{
//                            循环为最后一次时
                            if(i==logisticsPaymentStateViews.size()-1){
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
                    if(i==logisticsPaymentStateViews.size()-1){
                        iterator.remove();
                        page.setTotal(page.getTotal()-1);
                    }
                }
            }
            record.setLogisticsPaymentDirector(logisticsPaymentStateViews);
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
    public int changeFinanceState(String logisticsContractNo, String financeStaff) {
        UpdateWrapper<LogisticsPaymentContract> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("logistics_contract_no",logisticsContractNo).set("finance_state", 1).set("finance_staff",financeStaff);
        return logisticsPaymentContractMapper.update(null, updateWrapper);
    }

    @Override
    public int changeDirectorState(int logisticsPaymentContractId, int userId) {
        UpdateWrapper<LogisticsDirectorState> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("logistics_payment_contract_id", logisticsPaymentContractId).eq("user_id", userId).set("state", 1);
        return logisticsDirectorStateMapper.update(null, updateWrapper);
    }
}




