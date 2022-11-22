package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.OfficeExpense;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.OfficeExpenseService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
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

            int flag=0;
            for(int i=0;i<officeStateViews.size();i++){
//                获取已经审核了的董事次数
                if(officeStateViews.get(i).getState()!=null){
                    flag++;
                }
//                判断是否有该登录的董事
                if(officeStateViews.get(i).getUserId()==userId){
//                    如果有，对该董事审批结果进行判断，此处判断是否为已审批
                    if(officeStateViews.get(i).getState()!=null){
//                        若已审批，则判断是不是获取未审批的订单
                        if(type==0){
//                            则当获取的是未审批的订单时，移除数据
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                        }else{
//                            循环为最后一次时
                            if(i==officeStateViews.size()-1){
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
}




