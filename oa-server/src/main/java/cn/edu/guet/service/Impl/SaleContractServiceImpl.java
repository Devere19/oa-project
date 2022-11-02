package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.SysUser;
import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.CustomerMapper;
import cn.edu.guet.mapper.SaleContractMapper;
import cn.edu.guet.service.SaleContractService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/1 11:35
 * @Version 1.0
 */
@Service
public class SaleContractServiceImpl extends ServiceImpl<SaleContractMapper, SaleContract> implements SaleContractService {

    @Resource
    private SaleContractMapper saleContractMapper;

    @Resource
    private CustomerMapper customerMapper;

    @Override
    public IPage<SaleContract> getList(ListParm listParm) {
        Page<SaleContract> page = new Page<>(listParm.getCurrentPage(), listParm.getPageSize());
        QueryWrapper<SaleContract> query = new QueryWrapper<>();
        //构造查询条件
        //合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(SaleContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //销售方公司id
        if (StringUtils.isNotEmpty(listParm.getSaleCompanyName())) {
            //通过公司名称拿到客户表对应的id
            QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
            queryWrapper.lambda().like(Customer::getCustomerEnterpriseName, listParm.getSaleCompanyName());
            Customer customer = customerMapper.selectOne(queryWrapper);
            query.lambda().like(SaleContract::getSaleCustomerId, customer.getId());
        }
        //货物名称
        if (StringUtils.isNotEmpty(listParm.getGoodsName())) {
            query.lambda().like(SaleContract::getGoodsName, listParm.getGoodsName());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(SaleContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //查看归档为1的数据
        query.lambda().eq(SaleContract::getPigeonhole,1);

        Page<SaleContract> saleContractPage = saleContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (SaleContract record : saleContractPage.getRecords()) {
            String saleCustomerId = record.getSaleCustomerId();
            Customer customer = customerMapper.selectById(saleCustomerId);
            record.setCustomer(customer);
            //处理图片，形成一个图片数组
            String contractPhoto = record.getContractPhoto();
            record.setContractPhotoList(Arrays.asList(contractPhoto));
            //有多个照片
            if (StringUtils.isNotEmpty(contractPhoto) && contractPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(contractPhoto);
                record.setContractPhotoList(list);
                //取第一个图片的url
                record.setContractPhoto(ImageUtils.getFirstImageUrl(contractPhoto));
            }
        }
        return saleContractPage;
    }

    @Override
    public void changePigeonhole(Integer id) {
        //
        SaleContract saleContract = saleContractMapper.selectById(id);
        String pigeonhole = saleContract.getPigeonhole();
        //判断归档  如果是0 改为1  如果是1  改为0
        if (pigeonhole.equals("0")){
            saleContract.setPigeonhole("1");
            saleContractMapper.updateById(saleContract);
        }
        if (pigeonhole.equals("1")){
            saleContract.setPigeonhole("0");
            saleContractMapper.updateById(saleContract);
        }

    }
}
