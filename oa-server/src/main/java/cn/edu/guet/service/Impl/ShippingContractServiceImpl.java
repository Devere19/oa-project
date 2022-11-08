package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.ShippingContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContract;
import cn.edu.guet.bean.purchaseContract.PurchaseContractView;
import cn.edu.guet.mapper.ShippingContractMapper;
import cn.edu.guet.service.ShippingContractService;
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
* @description 针对表【shipping_contract】的数据库操作Service实现
* @createDate 2022-11-07 12:02:08
*/
@Service
public class ShippingContractServiceImpl extends ServiceImpl<ShippingContractMapper, ShippingContract>
    implements ShippingContractService {

    @Autowired
    private ShippingContractMapper shippingContractMapper;

    @Override
    public Page<ShippingContract> getshippingContractData(int currentPage, int pageSize) {
        QueryWrapper<ShippingContract> qw= new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        for (ShippingContract record : page.getRecords()) {
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
        qw.like("shipping_contract_no",searchWord).or().like("logtistics_contract_no",searchWord).or().like("principal",searchWord)
                .or().like("packing_location",searchWord).or().like("unpacking_factory",searchWord).or().like("container_no",searchWord)
                .or().like("seal_no",searchWord).or().like("tally_clerk",searchWord).or().like("departure_fleet",searchWord)
                .or().like("carrier_company_name",searchWord).or().like("destination_port_fleet",searchWord).or().like("finance_staff",searchWord)
                .or().like("cashier",searchWord).or().like("create_by",searchWord).orderByDesc("create_time");
        Page<ShippingContract> page =new Page<>(currentPage,pageSize);
        page=shippingContractMapper.selectPage(page,qw);
        for (ShippingContract record : page.getRecords()) {
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
    public int addNewShippingContract(ShippingContract shippingContract) {
        shippingContract.setContractPhoto(ImageUtils.getDBString(shippingContract.getContractPhotoArray()));
        return shippingContractMapper.insert(shippingContract);
    }

    @Override
    public int deleteOneShippingContract(int id) {
        ImageUtils.deleteImages(shippingContractMapper.selectById(id).getContractPhoto());
        return shippingContractMapper.deleteById(id);
    }

    @Override
    public Boolean checkContainerNo(String containerNo) {
        List<ShippingContract> shippingContracts= shippingContractMapper.checkContainerNo(containerNo);
        return shippingContracts.size()!=0;
    }
}




