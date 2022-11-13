package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.LogisticsPaymentContractService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
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
        for (LogisticsPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            if(logisticsPaymentStateViews.size()==0){
                page.getRecords().remove(record);
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
        for (LogisticsPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            if(logisticsPaymentStateViews.size()==0){
                page.getRecords().remove(record);
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
    public int uploadCashierLogisticsPayment(LogisticsPaymentContract logisticsPaymentContract) {
        LogisticsPaymentContract oldLogisticsPaymentContract= logisticsPaymentContractMapper.selectById(logisticsPaymentContract.getId());
        String paymentPhotos=ImageUtils.getDBString(logisticsPaymentContract.getPaymentPhotoArray());
        if(paymentPhotos!=""){
            oldLogisticsPaymentContract.setPaymentPhoto(paymentPhotos);
        }
        oldLogisticsPaymentContract.setPaymentTime(logisticsPaymentContract.getPaymentTime());
        return logisticsPaymentContractMapper.updateById(oldLogisticsPaymentContract);
    }
}




