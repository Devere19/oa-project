package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.ImportModel.ImportLogisticsPaymentContractModel;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.LogisticsContractService;
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

    @Autowired
    private LogisticsContractMapper logisticsContractMapper;

    @Autowired
    private LogisticsContractService logisticsContractService;

    @Autowired
    private SaleContractMapper saleContractMapper;

    @Autowired
    private CashierLogisticsPaymentMapper cashierLogisticsPaymentMapper;

    @Override
    public Page<LogisticsPaymentContractView> getLogisticsPaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.orderByDesc("create_time", "id");
        Page<LogisticsPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = logisticsPaymentContractInfoMapper.selectPage(page, qw);
        for (LogisticsPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).orderByDesc("nick_name");
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
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<LogisticsPaymentContractView> searchLogisticsPaymentContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.like("logistics_contract_no", searchWord).or().like("sale_contract_no", searchWord)
                .or().like("logistics_contract_no", searchWord)
                .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord).orderByDesc("create_time", "id");
        Page<LogisticsPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = logisticsPaymentContractInfoMapper.selectPage(page, qw);
        for (LogisticsPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).orderByDesc("nick_name");
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
            } else {
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
        int result = logisticsPaymentContractMapper.insert(logisticsPaymentContract);

        if (result == 1) {
            //        查询出董事会的ID
            QueryWrapper<Director> directorQw = new QueryWrapper<>();
            directorQw.orderByAsc("nick_name").last("limit 3");
            List<Director> directors = directorMapper.selectList(directorQw);

//        循环添加采购付款单的董事审核记录
            for (Director director : directors) {
                LogisticsDirectorState logisticsDirectorState = new LogisticsDirectorState();
                logisticsDirectorState.setLogisticsPaymentContractId(logisticsPaymentContract.getId());
                logisticsDirectorState.setUserId(Math.toIntExact(director.getId()));
                logisticsDirectorState.setCreateBy(SecurityUtils.getUsername());
                logisticsDirectorState.setLastUpdateBy(SecurityUtils.getUsername());
                logisticsDirectorStateMapper.insert(logisticsDirectorState);
            }

            //            获取物流单,修改存在物流付款单标记
            QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
            qw.eq("logistics_contract_no", logisticsPaymentContract.getLogisticsContractNo());
            LogisticsContract logisticsContract = logisticsContractMapper.selectOne(qw);
            logisticsContract.setRelationPaymentExistState(1);
            logisticsContractMapper.updateById(logisticsContract);
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateLogisticsPaymentContract(LogisticsPaymentContract logisticsPaymentContract) {
        LogisticsPaymentContract oldLogisticsPaymentContract = logisticsPaymentContractMapper.selectById(logisticsPaymentContract.getId());
        oldLogisticsPaymentContract.setLogisticsContractNo(logisticsPaymentContract.getLogisticsContractNo());
        oldLogisticsPaymentContract.setPaymentCount(logisticsPaymentContract.getPaymentCount());
        oldLogisticsPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        return logisticsPaymentContractMapper.updateById(oldLogisticsPaymentContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneLogisticsPaymentContract(int id) {
        String logisticsContractNo = logisticsPaymentContractMapper.selectById(id).getLogisticsContractNo();

        int result = logisticsPaymentContractMapper.deleteById(id);

        if (result == 1) {
            //        删除相关审核记录
            QueryWrapper<LogisticsDirectorState> directorStateQw = new QueryWrapper<>();
            directorStateQw.eq("logistics_payment_contract_id", id);
            logisticsDirectorStateMapper.delete(directorStateQw);

//            查询是否存在其他物流付款单
            QueryWrapper<LogisticsPaymentContract> LPCQw = new QueryWrapper<>();
            LPCQw.eq("logistics_contract_no", logisticsContractNo);
            List<LogisticsPaymentContract> logisticsPaymentContractList = logisticsPaymentContractMapper.selectList(LPCQw);

//            若不存在则修改物流单字段
            if (logisticsPaymentContractList.isEmpty() == true) {
                //            获取物流单
                QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
                qw.eq("logistics_contract_no", logisticsContractNo);
                LogisticsContract logisticsContract = logisticsContractMapper.selectOne(qw);
                logisticsContract.setRelationPaymentExistState(0);
                logisticsContractMapper.updateById(logisticsContract);
            }
        }

        return result;
    }

    @Override
    public LogisticsPaymentContractView getOneLogisticsPaymentContract(int id) {
        LogisticsPaymentContractView logisticsPaymentContractView = logisticsPaymentContractInfoMapper.selectById(id);

        QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("logistics_payment_contract_id", id).orderByDesc("nick_name");
        logisticsPaymentContractView.setLogisticsPaymentDirector(logisticsPaymentStateInfoMapper.selectList(stateQw));

        return logisticsPaymentContractView;
    }

    @Override
    public int handleImportLogisticsPaymentContractModel(ImportLogisticsPaymentContractModel importLogisticsPaymentContractModel) {
        LogisticsPaymentContract logisticsPaymentContract = new LogisticsPaymentContract();
//        物流合同号
        if (importLogisticsPaymentContractModel.getLogisticsContractNo() == null) {
            return 0;
        } else {
//            检验是否存在
            if (logisticsContractService.checkLogisticsContractNo(importLogisticsPaymentContractModel.getLogisticsContractNo())) {
                logisticsPaymentContract.setLogisticsContractNo(importLogisticsPaymentContractModel.getLogisticsContractNo());
            } else {
                return 0;
            }
        }

        if (importLogisticsPaymentContractModel.getPaymentCount() != null) {
            logisticsPaymentContract.setPaymentCount(importLogisticsPaymentContractModel.getPaymentCount());
        }

        return addNewLogisticsPaymentContract(logisticsPaymentContract);
    }

    @Override
    public Page<CashierLogisticsPayment> getCashierLogisticsPayment(int currentPage, int pageSize) {
        QueryWrapper<CashierLogisticsPayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").orderByDesc("create_time", "id");
        Page<CashierLogisticsPayment> page = new Page<>(currentPage, pageSize);
        page = cashierLogisticsPaymentMapper.selectPage(page, qw);
        Iterator<CashierLogisticsPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierLogisticsPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

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
                } else {
                    record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
                }
        }
        return page;
    }

    @Override
    public Page<CashierLogisticsPayment> searchCashierLogisticsPayment(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<CashierLogisticsPayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").and(q -> q.like("sale_contract_no", searchWord)
                .or().like("logistics_contract_no", searchWord)
                .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord)).orderByDesc("create_time", "id");
        Page<CashierLogisticsPayment> page = new Page<>(currentPage, pageSize);
        page = cashierLogisticsPaymentMapper.selectPage(page, qw);
        Iterator<CashierLogisticsPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierLogisticsPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

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
                } else {
                    record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
                }
        }
        return page;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int uploadCashierLogisticsPayment(LogisticsPaymentContract logisticsPaymentContract) {
        LogisticsPaymentContract oldLogisticsPaymentContract = logisticsPaymentContractMapper.selectById(logisticsPaymentContract.getId());
        String paymentPhotos = ImageUtils.getDBString(logisticsPaymentContract.getPaymentPhotoArray());
        if (paymentPhotos != "") {
            oldLogisticsPaymentContract.setPaymentPhoto(paymentPhotos);
        }
        oldLogisticsPaymentContract.setCashier(SecurityUtils.getUsername());
        oldLogisticsPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        oldLogisticsPaymentContract.setPaymentTime(logisticsPaymentContract.getPaymentTime());
        return logisticsPaymentContractMapper.updateById(oldLogisticsPaymentContract);
    }

    @Override
    public String getLogisticsCustomer(String logisticsContractNo) {
        QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
        qw.eq("logistics_contract_no", logisticsContractNo);
        LogisticsContract logisticsContract = logisticsContractMapper.selectOne(qw);
        QueryWrapper<SaleContract> q = new QueryWrapper<>();
        q.eq("sale_contract_no", logisticsContract.getSaleContractNo());
        return saleContractMapper.selectOne(q).getCustomerEnterpriseName();
    }

    @Override
    public Page<CashierLogisticsPayment> getDirectorLPC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<CashierLogisticsPayment> qw = new QueryWrapper<>();
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
        Page<CashierLogisticsPayment> page = new Page<>(currentPage, pageSize);
        page = cashierLogisticsPaymentMapper.selectPage(page, qw);
        Iterator<CashierLogisticsPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierLogisticsPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);
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
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return page;
    }

    @Override
    public LogisticsPaymentContractView getOneDirectorLPC(int id) {
        LogisticsPaymentContractView logisticsPaymentContractView = logisticsPaymentContractInfoMapper.selectById(id);
        QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("logistics_payment_contract_id", id).orderByDesc("nick_name");
        logisticsPaymentContractView.setLogisticsPaymentDirector(logisticsPaymentStateInfoMapper.selectList(stateQw));
        //处理图片，形成一个图片数组
        String paymentPhoto = logisticsPaymentContractView.getPaymentPhoto();
//            付款照片
        if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
            //分割图片字符串，形成一个数组
            List<String> list = ImageUtils.imageSplit(paymentPhoto);
            logisticsPaymentContractView.setPaymentPhotoArray(list);
            //取第一个图片的url
            logisticsPaymentContractView.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
        } else {
            logisticsPaymentContractView.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
        }
        return logisticsPaymentContractView;
    }

    @Override
    public Page<CashierLogisticsPayment> searchDirectorLPC(int currentPage, int pageSize, String searchWord, int userId) {
        QueryWrapper<CashierLogisticsPayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(w->w.like("director_id",userId+"-").and(q -> q.like("sale_contract_no", searchWord)
                .or().like("logistics_contract_no", searchWord)
                .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord))).orderByDesc("create_time", "id");
        Page<CashierLogisticsPayment> page = new Page<>(currentPage, pageSize);
        page = cashierLogisticsPaymentMapper.selectPage(page, qw);
        Iterator<CashierLogisticsPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierLogisticsPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);
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
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }

        }
        return page;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeFinanceState(int id, String financeStaff) {
        UpdateWrapper<LogisticsPaymentContract> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("id", id).set("finance_state", 1).set("finance_staff", financeStaff);

        int result = logisticsPaymentContractMapper.update(null, updateWrapper);

        if (result == 1) {
            QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
            qw.eq("logistics_contract_no", logisticsPaymentContractMapper.selectById(id).getLogisticsContractNo());
            LogisticsContract logisticsContract = logisticsContractMapper.selectOne(qw);
            logisticsContract.setRelationPaymentAuditState(1);
            logisticsContractMapper.updateById(logisticsContract);
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeDirectorState(int logisticsPaymentContractId, int userId) {
        UpdateWrapper<LogisticsDirectorState> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("logistics_payment_contract_id", logisticsPaymentContractId).eq("user_id", userId).set("state", 1);
        return logisticsDirectorStateMapper.update(null, updateWrapper);
    }
}




