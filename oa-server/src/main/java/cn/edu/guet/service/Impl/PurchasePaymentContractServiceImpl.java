package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.PurchasePaymentContractService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【purchase_payment_contract】的数据库操作Service实现
* @createDate 2022-11-10 20:41:25
*/
@Service
public class PurchasePaymentContractServiceImpl extends ServiceImpl<PurchasePaymentContractMapper, PurchasePaymentContract>
    implements PurchasePaymentContractService {

    @Autowired
    private PurchasePaymentContractInfoMapper purchasePaymentContractInfoMapper;

    @Autowired
    private PurchasePaymentContractMapper purchasePaymentContractMapper;

    @Autowired
    private PurchasePaymentStateInfoMapper purchasePaymentStateInfoMapper;

    @Autowired
    private PurchaseDirectorStateMapper purchaseDirectorStateMapper;

    @Autowired
    private DirectorMapper directorMapper;

    @Override
    public Page<PurchasePaymentContractView> getPurchasePaymentContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        for (PurchasePaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入数据库
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).orderByDesc("nick_name");
            record.setPurchasePaymentDirector(purchasePaymentStateInfoMapper.selectList(stateQw));

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
    public Page<PurchasePaymentContractView> searchPurchasePaymentContract(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<PurchasePaymentContractView> qw= new QueryWrapper<>();
        qw.like("purchase_contract_no",searchWord).or().like("finance_staff",searchWord).or().like("cashier",searchWord)
                .or().like("create_by",searchWord).orderByDesc("create_time");
        Page<PurchasePaymentContractView> page =new Page<>(currentPage,pageSize);
        page=purchasePaymentContractInfoMapper.selectPage(page,qw);
        for (PurchasePaymentContractView record : page.getRecords()) {
//            获取董事长审核信息，并加入数据库
            QueryWrapper<PurchasePaymentStateView> stateQw= new QueryWrapper<>();
            stateQw.eq("purchase_payment_contract_id",record.getId()).orderByDesc("nick_name");
            record.setPurchasePaymentDirector(purchasePaymentStateInfoMapper.selectList(stateQw));

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
    public int addNewPurchasePaymentContract(PurchasePaymentContract purchasePaymentContract) {
        int result=purchasePaymentContractMapper.insert(purchasePaymentContract);

//        查询出董事会的ID
        QueryWrapper<Director> directorQw= new QueryWrapper<>();
        directorQw.orderByAsc("nick_name").last("limit 3");
        List<Director> directors=directorMapper.selectList(directorQw);

//        循环添加采购付款单的董事审核记录
        for (Director director:directors){
            PurchaseDirectorState purchaseDirectorState=new PurchaseDirectorState();
            purchaseDirectorState.setPurchasePaymentContractId(purchasePaymentContract.getId());
            purchaseDirectorState.setUserId(Math.toIntExact(director.getId()));
            purchaseDirectorStateMapper.insert(purchaseDirectorState);
        }
        return result;
    }

    @Override
    public int deleteOnePurchasePaymentContract(int id) {
        PurchasePaymentContract purchasePaymentContract=purchasePaymentContractMapper.selectById(id);
//        删除相关审核记录
        QueryWrapper<PurchaseDirectorState> directorStateQw= new QueryWrapper<>();
        directorStateQw.eq("purchase_payment_contract_id",purchasePaymentContract.getId());
        purchaseDirectorStateMapper.delete(directorStateQw);

        return purchasePaymentContractMapper.deleteById(id);
    }

}




