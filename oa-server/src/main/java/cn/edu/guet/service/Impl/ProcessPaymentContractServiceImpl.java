package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.ImportModel.ImportProcessPaymentContractModel;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.ProcessContractService;
import cn.edu.guet.service.ProcessPaymentContractService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
import cn.edu.guet.util.UnitUtils;
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
 * @description 针对表【process_payment_contract_info】的数据库操作Service实现
 * @createDate 2022-12-11 20:43:57
 */
@Service
public class ProcessPaymentContractServiceImpl extends ServiceImpl<ProcessPaymentContractMapper, ProcessPaymentContract>
        implements ProcessPaymentContractService {

    @Autowired
    private ProcessPaymentContractInfoMapper processPaymentContractInfoMapper;

    @Autowired
    private ProcessPaymentStateInfoMapper processPaymentStateInfoMapper;

    @Autowired
    private ProcessPaymentContractMapper processPaymentContractMapper;
    
    @Autowired
    private DirectorMapper directorMapper;
    
    @Autowired
    private ProcessDirectorStateMapper processDirectorStateMapper;
    
    @Autowired
    private ProcessContractMapper processContractMapper;
    
    @Autowired
    private ProcessContractService processContractService;

    @Autowired
    private CashierProcessPaymentMapper cashierProcessPaymentMapper;

    @Override
    public Page<ProcessPaymentContractView> getProcessPaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<ProcessPaymentContractView> qw = new QueryWrapper<>();
        qw.orderByDesc("create_time","id");
        Page<ProcessPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = processPaymentContractInfoMapper.selectPage(page, qw);
        for (ProcessPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("process_payment_contract_id", record.getId()).orderByDesc("nick_name");
            record.setProcessPaymentDirector(processPaymentStateInfoMapper.selectList(stateQw));

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
    public Page<ProcessPaymentContractView> searchProcessPaymentContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<ProcessPaymentContractView> qw = new QueryWrapper<>();
        qw.like("process_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                .like("own_company_name", searchWord).or().like("finance_staff", searchWord)
                .or().like("cashier", searchWord).or().like("create_by", searchWord).orderByDesc("create_time","id");
        Page<ProcessPaymentContractView> page = new Page<>(currentPage, pageSize);
        page = processPaymentContractInfoMapper.selectPage(page, qw);
        for (ProcessPaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("process_payment_contract_id", record.getId()).orderByDesc("nick_name");
            record.setProcessPaymentDirector(processPaymentStateInfoMapper.selectList(stateQw));

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
    public int addNewProcessPaymentContract(ProcessPaymentContract processPaymentContract) {
        processPaymentContract.setCreateBy(SecurityUtils.getUsername());
        processPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        //        单位默认为吨
        processPaymentContract.setGoodsUnit("吨");
        processPaymentContract.setPaymentMonthPriceG(UnitUtils.GtoT(processPaymentContract.getPaymentMonthPriceT()));
        
        int result = processPaymentContractMapper.insert(processPaymentContract);

        if (result == 1) {
//        查询出董事会的ID
            QueryWrapper<Director> directorQw = new QueryWrapper<>();
            directorQw.orderByAsc("nick_name").last("limit 3");
            List<Director> directors = directorMapper.selectList(directorQw);

//        循环添加加工付款单的董事审核记录
            for (Director director : directors) {
                ProcessDirectorState processDirectorState = new ProcessDirectorState();
                processDirectorState.setProcessPaymentContractId(processPaymentContract.getId());
                processDirectorState.setUserId(Math.toIntExact(director.getId()));
                processDirectorState.setCreateBy(SecurityUtils.getUsername());
                processDirectorState.setLastUpdateBy(SecurityUtils.getUsername());
                processDirectorStateMapper.insert(processDirectorState);
            }

            //            获取加工单,修改存在加工付款单标记
            QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
            qw.eq("process_contract_no", processPaymentContract.getProcessContractNo());
            ProcessContract processContract=processContractMapper.selectOne(qw);
            processContract.setRelationPaymentExistState(1);
            processContractMapper.updateById(processContract);
        }
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateProcessPaymentContract(ProcessPaymentContract processPaymentContract) {
        ProcessPaymentContract oldProcessPaymentContract=processPaymentContractMapper.selectById(processPaymentContract.getId());
        oldProcessPaymentContract.setProcessContractNo(processPaymentContract.getProcessContractNo());
        oldProcessPaymentContract.setPaymentMonth(processPaymentContract.getPaymentMonth());
        oldProcessPaymentContract.setPaymentMonthPriceT(processPaymentContract.getPaymentMonthPriceT());
//        单位默认为吨
        oldProcessPaymentContract.setGoodsUnit("吨");
//        计算一个斤的（g）单价
        oldProcessPaymentContract.setPaymentMonthPriceG(UnitUtils.GtoT(processPaymentContract.getPaymentMonthPriceT()));
        oldProcessPaymentContract.setGoodsCount(processPaymentContract.getGoodsCount());
        oldProcessPaymentContract.setPaymentCount(processPaymentContract.getPaymentCount());
        oldProcessPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        return processPaymentContractMapper.updateById(oldProcessPaymentContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneProcessPaymentContract(int id) {
        String processContractNo=processPaymentContractMapper.selectById(id).getProcessContractNo();

        int result=processPaymentContractMapper.deleteById(id);

        if(result==1){
            //        删除相关审核记录
            QueryWrapper<ProcessDirectorState> directorStateQw = new QueryWrapper<>();
            directorStateQw.eq("process_payment_contract_id", id);
            processDirectorStateMapper.delete(directorStateQw);

//            查询是否存在其他加工付款单
            QueryWrapper<ProcessPaymentContract> PPCQw = new QueryWrapper<>();
            PPCQw.eq("process_contract_no",processContractNo);
            List<ProcessPaymentContract> processPaymentContractList=processPaymentContractMapper.selectList(PPCQw);

//            若不存在则修改加工单字段
            if(processPaymentContractList.isEmpty()==true){
                //            获取加工单
                QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
                qw.eq("process_contract_no", processContractNo);
                ProcessContract processContract=processContractMapper.selectOne(qw);
                processContract.setRelationPaymentExistState(0);
                processContractMapper.updateById(processContract);
            }
        }

        return result;
    }

    @Override
    public ProcessPaymentContractView getOneProcessPaymentContract(int id) {
        ProcessPaymentContractView processPaymentContractView=processPaymentContractInfoMapper.selectById(id);

        QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("process_payment_contract_id", id).orderByDesc("nick_name");
        processPaymentContractView.setProcessPaymentDirector(processPaymentStateInfoMapper.selectList(stateQw));

        return processPaymentContractView;
    }

    @Override
    public int handleImportProcessPaymentContractModel(ImportProcessPaymentContractModel importProcessPaymentContractModel) {
        ProcessPaymentContract processPaymentContract = new ProcessPaymentContract();
//        加工合同号
        if (importProcessPaymentContractModel.getProcessContractNo() == null) {
            return 0;
        } else {
//            检验是否存在
            if (processContractService.checkProcessContractNo(importProcessPaymentContractModel.getProcessContractNo())) {
                processPaymentContract.setProcessContractNo(importProcessPaymentContractModel.getProcessContractNo());
            } else {
                return 0;
            }
        }

        if (importProcessPaymentContractModel.getPaymentMonth() != null) {
            processPaymentContract.setPaymentMonth(importProcessPaymentContractModel.getPaymentMonth());
        }
        if (importProcessPaymentContractModel.getPaymentMonthPriceT() != null) {
            processPaymentContract.setPaymentMonthPriceT(importProcessPaymentContractModel.getPaymentMonthPriceT());
        }
        if (importProcessPaymentContractModel.getGoodsCount() != null) {
            processPaymentContract.setGoodsCount(importProcessPaymentContractModel.getGoodsCount());
        }
        if (importProcessPaymentContractModel.getPaymentCount() != null) {
            processPaymentContract.setPaymentCount(importProcessPaymentContractModel.getPaymentCount());
        }

        return addNewProcessPaymentContract(processPaymentContract);
    }

    @Override
    public Page<CashierProcessPayment> getCashierProcessPayment(int currentPage, int pageSize) {
        QueryWrapper<CashierProcessPayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").orderByDesc("create_time","id");
        Page<CashierProcessPayment> page = new Page<>(currentPage, pageSize);
        page = cashierProcessPaymentMapper.selectPage(page, qw);
        Iterator<CashierProcessPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierProcessPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("process_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<ProcessPaymentStateView> processPaymentStateViews = processPaymentStateInfoMapper.selectList(stateQw);

            if (processPaymentStateViews.size() < 3) {
                iterator.remove();
                page.setTotal(page.getTotal() - 1);
            } else {
                record.setProcessPaymentDirector(processPaymentStateViews);

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
    public Page<CashierProcessPayment> searchCashierProcessPayment(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<CashierProcessPayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").and(q -> q.like("process_contract_no", searchWord)
                .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord)).orderByDesc("create_time","id");
        Page<CashierProcessPayment> page = new Page<>(currentPage, pageSize);
        page = cashierProcessPaymentMapper.selectPage(page, qw);
        Iterator<CashierProcessPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierProcessPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("process_payment_contract_id", record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<ProcessPaymentStateView> processPaymentStateViews = processPaymentStateInfoMapper.selectList(stateQw);

            if (processPaymentStateViews.size() < 3) {
                iterator.remove();
                page.setTotal(page.getTotal() - 1);
            } else {
                record.setProcessPaymentDirector(processPaymentStateViews);

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
    public int uploadCashierProcessPayment(ProcessPaymentContract processPaymentContract) {
        ProcessPaymentContract oldProcessPaymentContract = processPaymentContractMapper.selectById(processPaymentContract.getId());
        String paymentPhotos = ImageUtils.getDBString(processPaymentContract.getPaymentPhotoArray());
        if (paymentPhotos != "") {
            oldProcessPaymentContract.setPaymentPhoto(paymentPhotos);
        }
        oldProcessPaymentContract.setCashier(SecurityUtils.getUsername());
        oldProcessPaymentContract.setLastUpdateBy(SecurityUtils.getUsername());
        oldProcessPaymentContract.setPaymentTime(processPaymentContract.getPaymentTime());
        
        return processPaymentContractMapper.updateById(oldProcessPaymentContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeFinanceState(int id, String financeStaff) {
        UpdateWrapper<ProcessPaymentContract> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("id", id).set("finance_state", 1).set("finance_staff", financeStaff);

        int result=processPaymentContractMapper.update(null, updateWrapper);

        if(result==1){
            QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
            qw.eq("process_contract_no", processPaymentContractMapper.selectById(id).getProcessContractNo());
            ProcessContract processContract=processContractMapper.selectOne(qw);
            processContract.setRelationPaymentAuditState(1);
            processContractMapper.updateById(processContract);
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeDirectorState(int processPaymentContractId, int userId) {
        UpdateWrapper<ProcessDirectorState> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("process_payment_contract_id", processPaymentContractId).eq("user_id", userId).set("state", 1);
        return processDirectorStateMapper.update(null, updateWrapper);
    }

    @Override
    public Page<CashierProcessPayment> getDirectorPPC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<CashierProcessPayment> qw = new QueryWrapper<>();
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
        Page<CashierProcessPayment> page = new Page<>(currentPage, pageSize);
        page = cashierProcessPaymentMapper.selectPage(page, qw);
        Iterator<CashierProcessPayment> iterator = page.getRecords().iterator();

        while (iterator.hasNext()) {
            CashierProcessPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("process_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<ProcessPaymentStateView> processPaymentStateViews = processPaymentStateInfoMapper.selectList(stateQw);
            record.setProcessPaymentDirector(processPaymentStateViews);

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
    public ProcessPaymentContractView getOneDirectorPPC(int id) {
        ProcessPaymentContractView processPaymentContractView = processPaymentContractInfoMapper.selectById(id);
        QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("process_payment_contract_id", id).orderByDesc("nick_name");
        processPaymentContractView.setProcessPaymentDirector(processPaymentStateInfoMapper.selectList(stateQw));
        //处理图片，形成一个图片数组
        String paymentPhoto = processPaymentContractView.getPaymentPhoto();
//            付款照片
        if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
            //分割图片字符串，形成一个数组
            List<String> list = ImageUtils.imageSplit(paymentPhoto);
            processPaymentContractView.setPaymentPhotoArray(list);
            //取第一个图片的url
            processPaymentContractView.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
        } else {
            processPaymentContractView.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
        }
        return processPaymentContractView;
    }

    @Override
    public Page<CashierProcessPayment> searchDirectorPPC(int currentPage, int pageSize, String searchWord, int userId) {
        QueryWrapper<CashierProcessPayment> qw = new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(w->w.like("director_id",userId+"-").and(q -> q.like("process_contract_no", searchWord)
                .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                .or().like("finance_staff", searchWord).or().like("cashier", searchWord)
                .or().like("create_by", searchWord))).orderByDesc("create_time","id");
        Page<CashierProcessPayment> page = new Page<>(currentPage, pageSize);
        page = cashierProcessPaymentMapper.selectPage(page, qw);
        Iterator<CashierProcessPayment> iterator = page.getRecords().iterator();
        while (iterator.hasNext()) {
            CashierProcessPayment record = iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ProcessPaymentStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("process_payment_contract_id", record.getId()).orderByDesc("nick_name");
            List<ProcessPaymentStateView> processPaymentStateViews = processPaymentStateInfoMapper.selectList(stateQw);
            record.setProcessPaymentDirector(processPaymentStateViews);

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




