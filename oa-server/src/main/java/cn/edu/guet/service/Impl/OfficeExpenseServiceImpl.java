package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.OfficeExpenseService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    @Override
    public int addNewOfficeExpense(OfficeExpense officeExpense) {
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
                officeDirectorStateMapper.insert(officeDirectorState);
            }
        }
        return result;
    }

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

            if(officeStateViews.size()==0){
                iterator.remove();
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

            if(officeStateViews.size()==0){
                iterator.remove();
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
    public int uploadCashierOfficeExpense(OfficeExpense officeExpense) {
        OfficeExpense oldOfficeExpense= officeExpenseMapper.selectById(officeExpense.getId());
        String paymentPhotos=ImageUtils.getDBString(officeExpense.getPaymentPhotoArray());
        if(paymentPhotos!=""){
            oldOfficeExpense.setPaymentPhoto(paymentPhotos);
        }
        oldOfficeExpense.setCashier(officeExpense.getCashier());
        oldOfficeExpense.setPaymentCount(oldOfficeExpense.getExpenses());
        oldOfficeExpense.setPaymentTime(officeExpense.getPaymentTime());
        return officeExpenseMapper.updateById(oldOfficeExpense);
    }
}




