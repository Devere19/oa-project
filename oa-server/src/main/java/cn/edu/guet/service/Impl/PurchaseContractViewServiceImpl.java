package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.purchaseContract.PurchaseContractView;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.PurchaseContractViewMapper;
import cn.edu.guet.service.PurchaseContractViewService;
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
* @description 针对表【purchase_contract_info】的数据库操作Service实现
* @createDate 2022-11-02 09:45:29
*/
@Service
public class PurchaseContractViewServiceImpl extends ServiceImpl<PurchaseContractViewMapper, PurchaseContractView>
    implements PurchaseContractViewService {

    @Autowired
    private PurchaseContractViewMapper purchaseContractViewMapper;

    @Override
    public Page<PurchaseContractView> getTPurchaseContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchaseContractView> qw= new QueryWrapper<>();
        qw.eq("pigeonhole",1).orderByDesc("create_time");
        Page<PurchaseContractView> page =new Page<>(currentPage,pageSize);
        page=purchaseContractViewMapper.selectPage(page,qw);
        for (PurchaseContractView record : page.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }else{
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<PurchaseContractView> getFPurchaseContractData(int currentPage, int pageSize) {
        QueryWrapper<PurchaseContractView> qw= new QueryWrapper<>();
        qw.eq("pigeonhole",0).orderByDesc("create_time");
        Page<PurchaseContractView> page =new Page<>(currentPage,pageSize);
        page=purchaseContractViewMapper.selectPage(page,qw);
        for (PurchaseContractView record : page.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }else{
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
        }
        return page;
    }

    @Override
    public Page<PurchaseContractView> searchPurchaseContract(int currentPage, int pageSize,String searchWord,boolean showPigeonhole) {
        QueryWrapper<PurchaseContractView> qw= new QueryWrapper<>();
        if(showPigeonhole==false){
            qw.eq("pigeonhole",1).and(q->{q.like("purchase_contract_no",searchWord).or().like("customer_enterprise_name",searchWord).or()
                    .like("own_company_name",searchWord).or().like("squeeze_season",searchWord).or()
                    .like("goods_name",searchWord).or().like("create_by",searchWord);}).orderByDesc("create_time");
        }else{
            qw.eq("pigeonhole",0).and(q->{q.like("purchase_contract_no",searchWord).or().like("customer_enterprise_name",searchWord).or()
                    .like("own_company_name",searchWord).or().like("squeeze_season",searchWord).or()
                    .like("goods_name",searchWord).or().like("create_by",searchWord);}).orderByDesc("create_time");
        }
        Page<PurchaseContractView> page =new Page<>(currentPage,pageSize);
        page=purchaseContractViewMapper.selectPage(page,qw);
        for (PurchaseContractView record : page.getRecords()) {
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoArray(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }else{
                record.setContractPhotoArray(Arrays.asList(contractPhoto));
            }
        }
        return page;
    }
}




