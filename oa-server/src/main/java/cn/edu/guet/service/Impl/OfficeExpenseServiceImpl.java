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

    @Autowired
    private CashierOfficeExpenseMapper cashierOfficeExpenseMapper;

    @Override
    public Page<OfficeExpense> getOfficeExpenseData(int currentPage, int pageSize) {
        QueryWrapper<OfficeExpense> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time","id");
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
                .orderByDesc("create_time","id");
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
    public Page<CashierOfficeExpense> getCashierOfficeExpense(int currentPage, int pageSize) {
        QueryWrapper<CashierOfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").orderByDesc("create_time","id");
        Page<CashierOfficeExpense> page =new Page<>(currentPage,pageSize);
        page=cashierOfficeExpenseMapper.selectPage(page,qw);
        Iterator<CashierOfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            CashierOfficeExpense record=iterator.next();
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews=(officeStateInfoMapper.selectList(stateQw));

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
    public Page<CashierOfficeExpense> searchCashierOfficeExpense(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<CashierOfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").eq("director_state","1,1,1").and(q->q.like("items_list",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord)).orderByDesc("create_time","id");
        Page<CashierOfficeExpense> page =new Page<>(currentPage,pageSize);
        page=cashierOfficeExpenseMapper.selectPage(page,qw);
        Iterator<CashierOfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            CashierOfficeExpense record=iterator.next();
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).isNotNull("state").orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews=(officeStateInfoMapper.selectList(stateQw));

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
    public Page<CashierOfficeExpense> getDirectorOE(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<CashierOfficeExpense> qw= new QueryWrapper<>();
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
        Page<CashierOfficeExpense> page =new Page<>(currentPage,pageSize);
        page=cashierOfficeExpenseMapper.selectPage(page,qw);
        Iterator<CashierOfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            CashierOfficeExpense record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews = officeStateInfoMapper.selectList(stateQw);
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
    public Page<CashierOfficeExpense> searchDirectorOE(int currentPage, int pageSize, String searchWord, int userId) {
        QueryWrapper<CashierOfficeExpense> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(w->w.like("director_id",userId+"-").and(q->q.like("items_list",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord))).orderByDesc("create_time","id");
        Page<CashierOfficeExpense> page =new Page<>(currentPage,pageSize);
        page=cashierOfficeExpenseMapper.selectPage(page,qw);
        Iterator<CashierOfficeExpense> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            CashierOfficeExpense record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<OfficeStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("office_expense_id",record.getId()).orderByDesc("nick_name");
            List<OfficeStateView> officeStateViews = officeStateInfoMapper.selectList(stateQw);
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




