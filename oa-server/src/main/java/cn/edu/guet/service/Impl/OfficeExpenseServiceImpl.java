package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.ImportModel.ImportOfficeExpenseModel;
import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.OfficeExpenseService;
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
* @description 针对表【office_expense】的数据库操作Service实现
* @createDate 2022-11-19 13:16:22
*/
@Service
public class OfficeExpenseServiceImpl extends ServiceImpl<OfficeExpenseMapper, OfficeExpense>
    implements OfficeExpenseService {

    @Autowired
    private OfficeExpenseMapper officeExpenseMapper;

    @Autowired
    private OfficeStateInfoMapper officeStateInfoMapper;

    @Autowired
    private OfficeDirectorStateMapper officeDirectorStateMapper;

    @Autowired
    private DirectorMapper directorMapper;
    
    @Override
    public Page<OfficeExpense> getOfficeExpenseData(int currentPage, int pageSize) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<OfficeExpense> page =new Page<>(currentPage,pageSize);
        page=officeExpenseMapper.selectPage(page,qw);
        for (OfficeExpense record : page.getRecords()) {
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).orderByDesc("nick_name");
            record.setOfficeDirector(officeStateInfoMapper.selectList(stateQw));

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
    public Page<OfficeExpense> searchOfficeExpense(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.like("items_list",searchWord).or().like("finance_staff",searchWord)
                .or().like("cashier",searchWord).or().like("create_by",searchWord)
                .orderByDesc("create_time");
        Page<OfficeExpense> page =new Page<>(currentPage,pageSize);
        page=officeExpenseMapper.selectPage(page,qw);
        for (OfficeExpense record : page.getRecords()) {
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).orderByDesc("nick_name");
            record.setOfficeDirector(officeStateInfoMapper.selectList(stateQw));

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
    public int addNewOfficeExpense(OfficeExpense officeExpense) {
        officeExpense.setCreateBy(SecurityUtils.getUsername());
        officeExpense.setLastUpdateBy(SecurityUtils.getUsername());
        int result=officeExpenseMapper.insert(officeExpense);

        if(result==1) {
//        查询出董事会的ID
            QueryWrapper<Director> directorQw = new QueryWrapper<>();
            directorQw.orderByAsc("nick_name").last("limit 3");
            List<Director> directors = directorMapper.selectList(directorQw);

//        循环添加办公付款单的董事审核记录
            for (Director director : directors) {
                OfficeDirectorState officeDirectorState = new OfficeDirectorState();
                officeDirectorState.setOfficeExpenseId(officeExpense.getId());
                officeDirectorState.setUserId(Math.toIntExact(director.getId()));
                officeDirectorState.setCreateBy(SecurityUtils.getUsername());
                officeDirectorState.setLastUpdateBy(SecurityUtils.getUsername());
                officeDirectorStateMapper.insert(officeDirectorState);
            }
        }
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateOfficeExpense(OfficeExpense officeExpense) {
        OfficeExpense oldOfficeExpense=officeExpenseMapper.selectById(officeExpense.getId());
        oldOfficeExpense.setItemsList(officeExpense.getItemsList());
        oldOfficeExpense.setExpenses(officeExpense.getExpenses());
        oldOfficeExpense.setTime(officeExpense.getTime());
        oldOfficeExpense.setLastUpdateBy(SecurityUtils.getUsername());
        return officeExpenseMapper.updateById(oldOfficeExpense);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneOfficeExpense(int id) {
        OfficeExpense officeExpense=officeExpenseMapper.selectById(id);

//        删除相关审核记录
        QueryWrapper<OfficeDirectorState> directorStateQw= new QueryWrapper<>();
        directorStateQw.eq("office_expense_id",officeExpense.getId());
        officeDirectorStateMapper.delete(directorStateQw);

        return officeExpenseMapper.deleteById(id);
    }

    @Override
    public int handleImportOfficeExpenseModel(ImportOfficeExpenseModel importOfficeExpenseModel) {
        OfficeExpense officeExpense = new OfficeExpense();

        if (importOfficeExpenseModel.getItemsList() == null) {
            return 0;
        } else {
            officeExpense.setItemsList(importOfficeExpenseModel.getItemsList());
        }

        if (importOfficeExpenseModel.getExpenses() != null) {
            officeExpense.setExpenses(importOfficeExpenseModel.getExpenses());
        }
        if (importOfficeExpenseModel.getTime() != null) {
            officeExpense.setTime(importOfficeExpenseModel.getTime());
        }

        return addNewOfficeExpense(officeExpense);
    }

    @Override
    public Page<OfficeExpense> getCashierOfficeExpense(int currentPage, int pageSize) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<OfficeExpense> page =new Page<>(currentPage,pageSize);
        page=officeExpenseMapper.selectPage(page,qw);
        Iterator<OfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            OfficeExpense record=iterator.next();
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews=(officeStateInfoMapper.selectList(stateQw));

            if(officeStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
                record.setOfficeDirector(officeStateViews);

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
    public Page<OfficeExpense> searchCashierOfficeExpense(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->q.like("items_list",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord)).orderByDesc("create_time");
        Page<OfficeExpense> page =new Page<>(currentPage,pageSize);
        page=officeExpenseMapper.selectPage(page,qw);
        Iterator<OfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            OfficeExpense record=iterator.next();
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews=(officeStateInfoMapper.selectList(stateQw));

            if(officeStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
                record.setOfficeDirector(officeStateViews);

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
    public int uploadCashierOfficeExpense(OfficeExpense officeExpense) {
        OfficeExpense oldOfficeExpense= officeExpenseMapper.selectById(officeExpense.getId());
        String paymentPhotos=ImageUtils.getDBString(officeExpense.getPaymentPhotoArray());
        if(paymentPhotos!=""){
            oldOfficeExpense.setPaymentPhoto(paymentPhotos);
        }
        oldOfficeExpense.setCashier(SecurityUtils.getUsername());
        oldOfficeExpense.setLastUpdateBy(SecurityUtils.getUsername());
        oldOfficeExpense.setPaymentCount(oldOfficeExpense.getExpenses());
        oldOfficeExpense.setPaymentTime(officeExpense.getPaymentTime());
        return officeExpenseMapper.updateById(oldOfficeExpense);
    }

    /**
     * APP董事会获取对应办公经费单*
     * @param currentPage
     * @param pageSize
     * @param userId
     * @param type
     * @return
     */
    @Override
    public Page<OfficeExpense> getDirectorOE(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<OfficeExpense> page =new Page<>(currentPage,pageSize);
        page=officeExpenseMapper.selectPage(page,qw);
        Iterator<OfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            OfficeExpense record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews = officeStateInfoMapper.selectList(stateQw);

            boolean own=false;
            int flag=0;

            for(int j=0;j<officeStateViews.size();j++){
//                获取已经审核了的董事次数
                if(officeStateViews.get(j).getState()!=null){
                    flag++;
                }else{
//                    若有没审核的，且获取的是已完成的数据，则不符合，去除
                    if(type==2){
                        iterator.remove();
                        page.setTotal(page.getTotal()-1);
                        break;
                    }
                }
            }

            for(int i=0;i<officeStateViews.size();i++){
//                判断三个审批状态中是否有自己的审批状态（该处判断主要是用于董事会更迭，若不判断当前获取数据的董事会成员是否在审批的董事会成员中，则会乱套）
                if(officeStateViews.get(i).getUserId()==userId){
//                    如果是，则标记为true
                    own=true;
                    if(type==0){
//                    当存在自己，且获取的数据为未审批时，则判断是否为null，为null才是未审批
                        if(officeStateViews.get(i).getState()!=null){
//                            不为null，去除
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                            break;
                        }
                    }
//                    当存在自己，判断自己的状态是否为null，为null则是未审批
                    if(officeStateViews.get(i).getState()==null){
//                        当获取的是已审批的数据时，则去除
                        if(type==1){
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                            break;
                        }
                    }else{
//                        当不为null，则自己已经审批
                        if(type==1){
//                            若获取的是已审批但未完成的数据，判断是否三个董事都审批了
                            if(flag==3){
//                                是则去除
                                iterator.remove();
                                page.setTotal(page.getTotal()-1);
                            }
                        }
                    }
                }else{
//                    循环中userId不等于自己的Id，当循环到最后一次，且最后一次也没匹配上，则去除
                    if(i==officeStateViews.size()-1&&own==false){
                        iterator.remove();
                        page.setTotal(page.getTotal()-1);
                    }
                }
            }
            
            record.setOfficeDirector(officeStateViews);
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
    public OfficeExpense getOneDirectorOE(int id) {
        OfficeExpense officeExpense = officeExpenseMapper.selectById(id);
        QueryWrapper<OfficeStateView> stateQw = new QueryWrapper<>();
        stateQw.eq("office_expense_id", id).orderByDesc("nick_name");
        officeExpense.setOfficeDirector(officeStateInfoMapper.selectList(stateQw));
        //处理图片，形成一个图片数组
        String paymentPhoto = officeExpense.getPaymentPhoto();
//            付款照片
        if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
            //分割图片字符串，形成一个数组
            List<String> list = ImageUtils.imageSplit(paymentPhoto);
            officeExpense.setPaymentPhotoArray(list);
            //取第一个图片的url
            officeExpense.setPaymentPhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
        } else {
            officeExpense.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
        }
        return officeExpense;
    }

    @Override
    public Page<OfficeExpense> searchDirectorOE(int currentPage, int pageSize, String searchWord, int userId) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->q.like("items_list",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord)).orderByDesc("create_time");
        Page<OfficeExpense> page =new Page<>(currentPage,pageSize);
        page=officeExpenseMapper.selectPage(page,qw);
        Iterator<OfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            OfficeExpense record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews = officeStateInfoMapper.selectList(stateQw);

            for(int i=0;i<officeStateViews.size();i++){
//                判断是否有该登录的董事
                if(officeStateViews.get(i).getUserId()==userId){
                    break;
                }else{
//                    如果这次没有，而且第三次了还没有，说明该董事不是审核该笔采购单的，移除该条数据
                    if(i==officeStateViews.size()-1){
                        iterator.remove();
                        page.setTotal(page.getTotal()-1);
                    }
                }
            }

            record.setOfficeDirector(officeStateViews);
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
    public int changeFinanceState(int id, String financeStaff) {
        UpdateWrapper<OfficeExpense> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("id",id).set("finance_state", 1).set("finance_staff",financeStaff);
        return officeExpenseMapper.update(null, updateWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int changeDirectorState(int officeExpenseId, int userId) {
        UpdateWrapper<OfficeDirectorState> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("office_expense_id", officeExpenseId).eq("user_id", userId).set("state", 1);
        return officeDirectorStateMapper.update(null, updateWrapper);
    }
}




