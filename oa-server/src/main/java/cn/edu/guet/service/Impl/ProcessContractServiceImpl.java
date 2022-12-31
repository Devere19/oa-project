package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.ProcessContract;
import cn.edu.guet.bean.ProcessDirectorState;
import cn.edu.guet.bean.ProcessPaymentContract;
import cn.edu.guet.mapper.ProcessContractMapper;
import cn.edu.guet.mapper.ProcessDirectorStateMapper;
import cn.edu.guet.mapper.ProcessPaymentContractMapper;
import cn.edu.guet.service.ProcessContractService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.sql.Date;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【process_contract】的数据库操作Service实现
* @createDate 2022-12-11 20:43:57
*/
@Service
public class ProcessContractServiceImpl extends ServiceImpl<ProcessContractMapper, ProcessContract>
    implements ProcessContractService {

    @Autowired
    private ProcessContractMapper processContractMapper;

    @Autowired
    private ProcessPaymentContractMapper processPaymentContractMapper;

    @Autowired
    private ProcessDirectorStateMapper processDirectorStateMapper;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneProcessContract(int id, int flag) {
        ProcessContract processContract = processContractMapper.selectById(id);
//        删未审核完成的加工付款单
        QueryWrapper<ProcessPaymentContract> QwPPC = new QueryWrapper<>();
        QwPPC.eq("process_contract_no", processContract.getProcessContractNo());
        List<ProcessPaymentContract> processPaymentContractList=processPaymentContractMapper.selectList(QwPPC);
        for(ProcessPaymentContract processPaymentContract:processPaymentContractList){
            //        删除相关审核记录
            QueryWrapper<ProcessDirectorState> directorStateQw = new QueryWrapper<>();
            directorStateQw.eq("process_payment_contract_id", id);
            processDirectorStateMapper.delete(directorStateQw);
        }
        processPaymentContractMapper.delete(QwPPC);
        if(flag==0){
            ImageUtils.deleteImages(processContractMapper.selectById(id).getContractPhoto());
        }
        return processContractMapper.deleteById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int setProcessContractPigeonhole(int id, int pigeonhole) {
        ProcessContract processContract = processContractMapper.selectById(id);
        if (pigeonhole == 1) {
            processContract.setPigeonhole(0);
        } else {
            processContract.setPigeonhole(1);
        }
        return processContractMapper.updateById(processContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int addNewProcessContract(ProcessContract processContract, ProcessContract oldProcessContract, int flag) {
        String contractPhotos = ImageUtils.getDBString(processContract.getContractPhotoArray());
        if (contractPhotos != "") {
            processContract.setContractPhoto(contractPhotos);
        }
        if(flag==1){
            processContract.setCreateTime(oldProcessContract.getCreateTime());
            processContract.setCreateBy(oldProcessContract.getCreateBy());
        }else{
            processContract.setCreateBy(SecurityUtils.getUsername());
        }
        processContract.setLastUpdateBy(SecurityUtils.getUsername());
        return processContractMapper.insert(processContract);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateProcessContract(ProcessContract processContract) {
        int result=0;

        QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
        qw.eq("process_contract_no", processContract.getOldProcessContractNo());
        ProcessContract oldProcessContract=processContractMapper.selectOne(qw);

        if(processContract.getOnlyUpdatePhoto()==1){
//            只修改了图片
            if (ImageUtils.getDBString(processContract.getContractPhotoArray()) != "") {
                oldProcessContract.setContractPhoto(ImageUtils.getDBString(processContract.getContractPhotoArray()));
            }else{
                oldProcessContract.setContractPhoto(null);
            }
            result=processContractMapper.updateById(oldProcessContract);
        }else{
            //        0代表是删除，1代表是更新，所以此次选择1，则不删除原图片
            if(deleteOneProcessContract(processContract.getId(),1)==1){
//                0代表是新增，1代表是更新，所以此次选择1，则需更改创建者和创建时间
                result=addNewProcessContract(processContract,oldProcessContract,1);
            }
        }
        return result;
    }

    @Override
    public int getProcessDetail(String processContractNo, String goodsName) {
        return 0;
    }

    @Override
    public Page<ProcessContract> getTProcessContractData(int currentPage, int pageSize) {
        QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
        qw.eq("pigeonhole", 1).orderByDesc("create_time");
        Page<ProcessContract> page = new Page<>(currentPage, pageSize);
        page = processContractMapper.selectPage(page, qw);
        for (ProcessContract record : page.getRecords()) {
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
    public Page<ProcessContract> getFProcessContractData(int currentPage, int pageSize) {
        QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
        qw.eq("pigeonhole", 0).orderByDesc("create_time");
        Page<ProcessContract> page = new Page<>(currentPage, pageSize);
        page = processContractMapper.selectPage(page, qw);
        for (ProcessContract record : page.getRecords()) {
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
    public Page<ProcessContract> searchProcessContract(int currentPage, int pageSize, String searchWord, boolean showPigeonhole, Date startDate, Date endDate) {
        QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
        if (showPigeonhole == false) {
            if (startDate == null && endDate == null) {
                qw.eq("pigeonhole", 1).and(q -> {
                    q.like("process_contract_no", searchWord)
                            .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                            .or().like("alcohol_conversion_formula", searchWord).or().like("concentrated_solution_conversion_formula", searchWord)
                            .or().like("create_by", searchWord);
                }).orderByDesc("create_time");
            } else {
                qw.eq("pigeonhole", 1).and(q -> {
                    q.like("process_contract_no", searchWord)
                            .or().like("customer_enterprise_name", searchWord).or().like("own_company_name", searchWord)
                            .or().like("alcohol_conversion_formula", searchWord).or().like("concentrated_solution_conversion_formula", searchWord)
                            .or().like("create_by", searchWord);
                }).ge("sign_time", startDate).le("sign_time", endDate).orderByDesc("create_time");
            }
        } else {
            if (startDate == null && endDate == null) {
                qw.eq("pigeonhole", 0).and(q -> {
                    q.like("process_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                            .like("own_company_name", searchWord).or().like("alcohol_conversion_formula", searchWord).or()
                            .like("concentrated_solution_conversion_formula", searchWord).or().like("create_by", searchWord);
                }).orderByDesc("create_time");
            } else {
                qw.eq("pigeonhole", 0).and(q -> {
                            q.like("process_contract_no", searchWord).or().like("customer_enterprise_name", searchWord).or()
                                    .like("own_company_name", searchWord).or().like("alcohol_conversion_formula", searchWord).or()
                                    .like("concentrated_solution_conversion_formula", searchWord).or().like("create_by", searchWord);
                        })
                        .ge("sign_time", startDate).le("sign_time", endDate).orderByDesc("create_time");
            }
        }
        Page<ProcessContract> page = new Page<>(currentPage, pageSize);
        page = processContractMapper.selectPage(page, qw);
        for (ProcessContract record : page.getRecords()) {
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
    public Boolean checkProcessContractNo(String processContractNo) {
        QueryWrapper<ProcessContract> qw = new QueryWrapper<>();
        qw.eq("process_contract_no", processContractNo).orderByDesc("create_time");
        List<ProcessContract> processContracts = processContractMapper.selectList(qw);
        return !processContracts.isEmpty();
    }

    @Override
    public boolean editRelationLogisticsExistState(String processContractNo) {
        QueryWrapper<ProcessContract> query = new QueryWrapper<>();
        query.lambda().eq(ProcessContract::getProcessContractNo,processContractNo);
        ProcessContract processContract = processContractMapper.selectOne(query);
        if (null==processContract){
            //没有该加工合同号
            return false;
        }else {
            processContract.setRelationLogisticsExistState(1);
            processContractMapper.updateById(processContract);
            return true;
        }
    }
}




