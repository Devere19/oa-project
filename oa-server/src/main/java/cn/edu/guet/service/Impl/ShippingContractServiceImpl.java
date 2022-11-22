package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.mapper.DirectorMapper;
import cn.edu.guet.mapper.ShippingContractMapper;
import cn.edu.guet.mapper.ShippingDirectorStateMapper;
import cn.edu.guet.mapper.ShippingStateInfoMapper;
import cn.edu.guet.service.ShippingContractService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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
* @description 针对表【shipping_contract】的数据库操作Service实现
* @createDate 2022-11-07 12:02:08
*/
@Service
public class ShippingContractServiceImpl extends ServiceImpl<ShippingContractMapper, ShippingContract>
    implements ShippingContractService {

    @Autowired
    private ShippingContractMapper shippingContractMapper;

    @Autowired
    private ShippingStateInfoMapper shippingStateInfoMapper;

    @Autowired
    private ShippingDirectorStateMapper shippingDirectorStateMapper;

    @Autowired
    private DirectorMapper directorMapper;


    @Override
    public Page<ShippingContract> getshippingContractData(int currentPage, int pageSize) {
        QueryWrapper<ShippingContract> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        for (ShippingContract record : page.getRecords()) {
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<ShippingStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("shipping_contract_no",record.getShippingContractNo()).orderByDesc("nick_name");
            record.setShippingDirector(shippingStateInfoMapper.selectList(stateQw));

            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            String paymentPhoto = record.getPaymentPhoto();
            //有多个照片,合同照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }else{
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
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
    public Page<ShippingContract> searchShippingContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<ShippingContract> qw= new QueryWrapper<>();
        qw.like("shipping_contract_no",searchWord).or().like("logistics_contract_no",searchWord).or().like("principal",searchWord)
                .or().like("packing_location",searchWord).or().like("unpacking_factory",searchWord).or().like("container_no",searchWord)
                .or().like("seal_no",searchWord).or().like("tally_clerk",searchWord).or().like("departure_fleet",searchWord)
                .or().like("carrier_company_name",searchWord).or().like("destination_port_fleet",searchWord).or().like("finance_staff",searchWord)
                .or().like("cashier",searchWord).or().like("create_by",searchWord).orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        for (ShippingContract record : page.getRecords()) {
            //            获取董事长审核信息，并加入数据库
            QueryWrapper<ShippingStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("shipping_contract_no",record.getShippingContractNo()).orderByAsc("nick_name");
            record.setShippingDirector(shippingStateInfoMapper.selectList(stateQw));

            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            String paymentPhoto = record.getPaymentPhoto();
            //有多个照片,合同照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }else{
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
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
    public int addNewShippingContract(ShippingContract shippingContract) {
        if(ImageUtils.getDBString(shippingContract.getContractPhotoArray())!=""){
            shippingContract.setContractPhoto(ImageUtils.getDBString(shippingContract.getContractPhotoArray()));
        }

        int result=shippingContractMapper.insert(shippingContract);

        if(result==1){
            //        查询出董事会的ID
            QueryWrapper<Director> directorQw= new QueryWrapper<>();
            directorQw.orderByAsc("nick_name").last("limit 3");
            List<Director> directors=directorMapper.selectList(directorQw);

//        循环添加海运董事审核记录
            for (Director director:directors){
                ShippingDirectorState shippingDirectorState=new ShippingDirectorState();
                shippingDirectorState.setShippingContractNo(shippingContract.getShippingContractNo());
                shippingDirectorState.setUserId(Math.toIntExact(director.getId()));
                shippingDirectorStateMapper.insert(shippingDirectorState);
            }
        }

        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteOneShippingContract(int id) {
        ShippingContract shippingContract=shippingContractMapper.selectById(id);
//        删除相关审核记录
        QueryWrapper<ShippingDirectorState> directorStateQw= new QueryWrapper<>();
        directorStateQw.eq("shipping_contract_no",shippingContract.getShippingContractNo());
        shippingDirectorStateMapper.delete(directorStateQw);
        ImageUtils.deleteImages(shippingContract.getContractPhoto());
        return shippingContractMapper.deleteById(id);
    }

    @Override
    public Boolean checkContainerNo(String containerNo) {
        List<ShippingContract> shippingContracts= shippingContractMapper.checkContainerNo(containerNo);
        return shippingContracts.size()!=0;
    }

    @Override
    public Page<ShippingContract> getCashierShipping(int currentPage, int pageSize) {
        QueryWrapper<ShippingContract> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        Iterator<ShippingContract> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            ShippingContract record=iterator.next();
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<ShippingStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("shipping_contract_no", record.getShippingContractNo()).isNotNull("state").orderByDesc("nick_name");
            List<ShippingStateView> shippingStateViews =shippingStateInfoMapper.selectList(stateQw);

            if(shippingStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
                record.setShippingDirector(shippingStateViews);

                //处理图片，形成一个图片数组
                String contractPhoto = record.getContractPhoto();
                String paymentPhoto = record.getPaymentPhoto();
                //有多个照片,合同照片
                if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                    //分割图片字符串，形成一个数组
                    List<String> list = ImageUtils.imageSplit(contractPhoto);
                    record.setContractPhotoArray(list);
                    //取第一个图片的url
                    record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
                } else {
                    record.setContractPhotoArray(Arrays.asList(contractPhoto));
                }
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
    public Page<ShippingContract> searchCashierShipping(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<ShippingContract> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").and(q->q.like("shipping_contract_no",searchWord)
                .or().like("logistics_contract_no",searchWord).or().like("principal",searchWord)
                .or().like("packing_location",searchWord).or().like("unpacking_factory",searchWord)
                .or().like("container_no",searchWord).or().like("seal_no",searchWord)
                .or().like("tally_clerk",searchWord).or().like("departure_fleet",searchWord)
                .or().like("carrier_company_name",searchWord).or().like("destination_port_fleet",searchWord)
                .or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord)).orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        Iterator<ShippingContract> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            ShippingContract record=iterator.next();
//            获取董事长审核信息，并添加进对象中
            QueryWrapper<ShippingStateView> stateQw = new QueryWrapper<>();
            stateQw.eq("shipping_contract_no", record.getShippingContractNo()).isNotNull("state").orderByDesc("nick_name");
            List<ShippingStateView> shippingStateViews =shippingStateInfoMapper.selectList(stateQw);

            if(shippingStateViews.size()<3){
                iterator.remove();
                page.setTotal(page.getTotal()-1);
            }else{
                record.setShippingDirector(shippingStateViews);

                //处理图片，形成一个图片数组
                String contractPhoto = record.getContractPhoto();
                String paymentPhoto = record.getPaymentPhoto();
                //有多个照片,合同照片
                if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                    //分割图片字符串，形成一个数组
                    List<String> list = ImageUtils.imageSplit(contractPhoto);
                    record.setContractPhotoArray(list);
                    //取第一个图片的url
                    record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
                } else {
                    record.setContractPhotoArray(Arrays.asList(contractPhoto));
                }
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
    public int uploadCashierShipping(ShippingContract shippingContract) {
        ShippingContract oldShippingContract= shippingContractMapper.selectById(shippingContract.getId());
        String paymentPhotos=ImageUtils.getDBString(shippingContract.getPaymentPhotoArray());
        if(paymentPhotos!=""){
            oldShippingContract.setPaymentPhoto(paymentPhotos);
        }
        oldShippingContract.setCashier(shippingContract.getCashier());
        oldShippingContract.setPaymentCount(oldShippingContract.getExpenses());
        oldShippingContract.setPaymentTime(shippingContract.getPaymentTime());
        return shippingContractMapper.updateById(oldShippingContract);
    }

    @Override
    public Page<ShippingContract> getDirectorSC(int currentPage, int pageSize, int userId, int type) {
        QueryWrapper<ShippingContract> qw= new QueryWrapper<>();
        qw.isNotNull("finance_staff").isNotNull("finance_state").orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        Iterator<ShippingContract> iterator=page.getRecords().iterator();
        while (iterator.hasNext()){
            ShippingContract record=iterator.next();
//            获取董事长审核信息，并加入对象中
            QueryWrapper<ShippingStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("shipping_contract_no",record.getShippingContractNo()).orderByDesc("nick_name");
            List<ShippingStateView> shippingStateViews = shippingStateInfoMapper.selectList(stateQw);

            int flag=0;
            for(int i=0;i<shippingStateViews.size();i++){
//                获取已经审核了的董事次数
                if(shippingStateViews.get(i).getState()!=null){
                    flag++;
                }
//                判断是否有该登录的董事
                if(shippingStateViews.get(i).getUserId()==userId){
//                    如果有，对该董事审批结果进行判断，此处判断是否为已审批
                    if(shippingStateViews.get(i).getState()!=null){
//                        若已审批，则判断是不是获取未审批的订单
                        if(type==0){
//                            则当获取的是未审批的订单时，移除数据
                            iterator.remove();
                            page.setTotal(page.getTotal()-1);
                        }else{
//                            循环为最后一次时
                            if(i==shippingStateViews.size()-1){
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
                    if(i==shippingStateViews.size()-1){
                        iterator.remove();
                        page.setTotal(page.getTotal()-1);
                    }
                }
            }
            record.setShippingDirector(shippingStateViews);
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




