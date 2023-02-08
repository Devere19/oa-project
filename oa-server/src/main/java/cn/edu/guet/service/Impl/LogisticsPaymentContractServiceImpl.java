package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.ImportModel.ImportLogisticsPaymentContractModel;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
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

    @Override
    public Page<LogisticsPaymentContractView> getLogisticsPaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.orderByDesc("create_time","id");
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
                .or().like("create_by", searchWord).orderByDesc("create_time","id");
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
            LogisticsContract logisticsContract=logisticsContractMapper.selectOne(qw);
            logisticsContract.setRelationPaymentExistState(1);
            logisticsContractMapper.updateById(logisticsContract);
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateLogisticsPaymentContract(LogisticsPaymentContract logisticsPaymentContract) {
        LogisticsPaymentContract oldLogisticsPaymentContract=logisticsPaymentContractMapper.selectById(logisticsPaymentContract.getId());
        oldLogisticsPaymentContract.setLogisticsContractNo(logisticsPaymentContract.getLogisticsContractNo());
        oldLogisticsPaymentContract.setPaymentCount(logisticsPaymentContract.getPaymentCount());
        oldLogisticsPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        return logisticsPaymentContractMapper.updateById(oldLogisticsPaymentContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneLogisticsPaymentContract(int id) {
        String logisticsContractNo=logisticsPaymentContractMapper.selectById(id).getLogisticsContractNo();

        int result=logisticsPaymentContractMapper.deleteById(id);

        if(result==1){
            //        删除相关审核记录
            QueryWrapper<LogisticsDirectorState> directorStateQw = new QueryWrapper<>();
            directorStateQw.eq("logistics_payment_contract_id", id);
            logisticsDirectorStateMapper.delete(directorStateQw);

//            查询是否存在其他物流付款单
            QueryWrapper<LogisticsPaymentContract> LPCQw = new QueryWrapper<>();
            LPCQw.eq("logistics_contract_no",logisticsContractNo);
            List<LogisticsPaymentContract> logisticsPaymentContractList=logisticsPaymentContractMapper.selectList(LPCQw);

//            若不存在则修改物流单字段
            if(logisticsPaymentContractList.isEmpty()==true){
                //            获取物流单
                QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
                qw.eq("logistics_contract_no", logisticsContractNo);
                LogisticsContract logisticsContract=logisticsContractMapper.selectOne(qw);
                logisticsContract.setRelationPaymentExistState(0);
                logisticsContractMapper.updateById(logisticsContract);
            }
        }

        return result;
    }

    @Override
    public LogisticsPaymentContractView getOneLogisticsPaymentContract(int id) {
        LogisticsPaymentContractView logisticsPaymentContractView=logisticsPaymentContractInfoMapper.selectById(id);

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
    public Page<LogisticsPaymentContractView> getCashierLogisticsPayment(int currentPage, int pageSize) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time","id");
        Page<LogisticsPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = logisticsPaymentContractInfoMapper.selectPage(page, qw);
        Iterator<LogisticsPaymentContractView> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            LogisticsPaymentContractView record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            if (logisticsPaymentStateViews.size() < 3) {
                iterator.remove();
                page.setTotal(page.getTotal() - 1);
            } else {
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
        }
        return page;
    }

    @Override
    public Page<LogisticsPaymentContractView> searchCashierLogisticsPayment(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q -> q.like("sale_contract_no", searchWord)
                .or().like("logistics_contract_no", searchWord)
                .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord)).orderByDesc("create_time","id");
        Page<LogisticsPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = logisticsPaymentContractInfoMapper.selectPage(page, qw);
        Iterator<LogisticsPaymentContractView> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            LogisticsPaymentContractView record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            if (logisticsPaymentStateViews.size() < 3) {
                iterator.remove();
                page.setTotal(page.getTotal() - 1);
            } else {
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
    public Page<LogisticsPaymentContractView> getDirectorLPC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time","id");
        Page<LogisticsPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = logisticsPaymentContractInfoMapper.selectPage(page, qw);
        Iterator<LogisticsPaymentContractView> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            LogisticsPaymentContractView record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            boolean own = false;
            int flag = 0;

            for (int j = 0; j < logisticsPaymentStateViews.size(); j++) {
//                获取已经审核了的董事次数
                if (logisticsPaymentStateViews.get(j).getState() != null) {
                    flag++;
                } else {
//                    若有没审核的，且获取的是已完成的数据，则不符合，去除
                    if (type == 2) {
                        iterator.remove();
                        page.setTotal(page.getTotal() - 1);
                        break;
                    }
                }
            }

            for (int i = 0; i < logisticsPaymentStateViews.size(); i++) {
//                判断三个审批状态中是否有自己的审批状态（该处判断主要是用于董事会更迭，若不判断当前获取数据的董事会成员是否在审批的董事会成员中，则会乱套）
                if (logisticsPaymentStateViews.get(i).getUserId() == userId) {
//                    如果是，则标记为true
                    own = true;
                    if (type == 0) {
//                    当存在自己，且获取的数据为未审批时，则判断是否为null，为null才是未审批
                        if (logisticsPaymentStateViews.get(i).getState() != null) {
//                            不为null，去除
                            iterator.remove();
                            page.setTotal(page.getTotal() - 1);
                            break;
                        }
                    }
//                    当存在自己，判断自己的状态是否为null，为null则是未审批
                    if (logisticsPaymentStateViews.get(i).getState() == null) {
//                        当获取的是已审批的数据时，则去除
                        if (type == 1) {
                            iterator.remove();
                            page.setTotal(page.getTotal() - 1);
                            break;
                        }
                    } else {
//                        当不为null，则自己已经审批
                        if (type == 1) {
//                            若获取的是已审批但未完成的数据，判断是否三个董事都审批了
                            if (flag == 3) {
//                                是则去除
                                iterator.remove();
                                page.setTotal(page.getTotal() - 1);
                            }
                        }
                    }
                } else {
//                    循环中userId不等于自己的Id，当循环到最后一次，且最后一次也没匹配上，则去除
                    if (i == logisticsPaymentStateViews.size() - 1 && own == false) {
                        iterator.remove();
                        page.setTotal(page.getTotal() - 1);
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
    public Page<LogisticsPaymentContractView> searchDirectorLPC(int currentPage, int pageSize, String searchWord, int userId) {
        QueryWrapper<LogisticsPaymentContractView> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q -> q.like("sale_contract_no", searchWord)
                .or().like("logistics_contract_no", searchWord)
                .or().like("squeeze_season", searchWord).or().like("goods_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord)).orderByDesc("create_time","id");
        Page<LogisticsPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = logisticsPaymentContractInfoMapper.selectPage(page, qw);
        Iterator<LogisticsPaymentContractView> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            LogisticsPaymentContractView record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<LogisticsPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("logistics_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<LogisticsPaymentStateView> logisticsPaymentStateViews = logisticsPaymentStateInfoMapper.selectList(stateQw);

            for (int i = 0; i < logisticsPaymentStateViews.size(); i++) {
//                判断是否有该登录的董事
                if (logisticsPaymentStateViews.get(i).getUserId() == userId) {
                    break;
                } else {
//                    如果这次没有，而且第三次了还没有，说明该董事不是审核该笔采购单的，移除该条数据
                    if (i == logisticsPaymentStateViews.size() - 1) {
                        iterator.remove();
                        page.setTotal(page.getTotal() - 1);
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

        int result=logisticsPaymentContractMapper.update(null, updateWrapper);

        if(result==1){
            QueryWrapper<LogisticsContract> qw = new QueryWrapper<>();
            qw.eq("logistics_contract_no", logisticsPaymentContractMapper.selectById(id).getLogisticsContractNo());
            LogisticsContract logisticsContract=logisticsContractMapper.selectOne(qw);
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




