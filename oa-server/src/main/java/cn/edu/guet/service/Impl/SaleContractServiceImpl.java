package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.SysUser;
import cn.edu.guet.bean.cashier.sale.SaleModel;
import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.sale.ExportListParm;
import cn.edu.guet.bean.sale.ExportOutSaleContract;
import cn.edu.guet.bean.sale.ListParm;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.mapper.CustomerMapper;
import cn.edu.guet.mapper.SaleContractMapper;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.service.LogisticsDetailService;
import cn.edu.guet.service.SaleContractService;
import cn.edu.guet.util.ImageUtils;
import cn.edu.guet.util.SecurityUtils;
import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.web.PortResolverImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.logging.SimpleFormatter;

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
    @Resource
    private LogisticsContractService logisticsContractService;

    @Resource
    private LogisticsDetailService logisticsDetailService;

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
            // QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
            query.lambda().like(SaleContract::getCustomerEnterpriseName, listParm.getSaleCompanyName());
            // Customer customer = customerMapper.selectOne(queryWrapper);
            // query.lambda().like(SaleContract::getCustomerEnterpriseName, customer.getId());
        }
        //货物名称
        if (StringUtils.isNotEmpty(listParm.getGoodsName())) {
            query.lambda().like(SaleContract::getGoodsName, listParm.getGoodsName());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(SaleContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(SaleContract::getSaleContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(SaleContract::getSaleContractTime, format);
        }


        //查看归档为1的数据
        query.lambda().eq(SaleContract::getPigeonhole, 1);
        query.orderByDesc("id");

        Page<SaleContract> saleContractPage = saleContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (SaleContract record : saleContractPage.getRecords()) {
            // String saleCustomerId = record.getSaleCustomerId();
            // Customer customer = customerMapper.selectById(saleCustomerId);
            // record.setCustomer(customer);

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
            String revenuePhoto = record.getRevenuePhoto();
            record.setRevenuePhotoList(Arrays.asList(revenuePhoto));
            //有多个照片
            if (StringUtils.isNotEmpty(revenuePhoto) && revenuePhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(revenuePhoto);
                record.setRevenuePhotoList(list);
                //取第一个图片的url
                record.setRevenuePhoto(ImageUtils.getFirstImageUrl(revenuePhoto));
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
        if (pigeonhole.equals("0")) {
            saleContract.setPigeonhole("1");
            saleContractMapper.updateById(saleContract);
        } else if (pigeonhole.equals("1")) {
            saleContract.setPigeonhole("0");
            saleContractMapper.updateById(saleContract);
        }

    }

    @Override
    public IPage<SaleContract> searchPigeonholeZero(ListParm listParm) {
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
            // QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
            // queryWrapper.lambda().like(Customer::getCustomerEnterpriseName, listParm.getSaleCompanyName());
            // Customer customer = customerMapper.selectOne(queryWrapper);
            // query.lambda().like(SaleContract::getSaleCustomerId, customer.getId());
            query.lambda().like(SaleContract::getCustomerEnterpriseName, listParm.getSaleCompanyName());
        }
        //货物名称
        if (StringUtils.isNotEmpty(listParm.getGoodsName())) {
            query.lambda().like(SaleContract::getGoodsName, listParm.getGoodsName());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(SaleContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(SaleContract::getSaleContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(SaleContract::getSaleContractTime, format);
        }
        //查看归档为1的数据
        query.lambda().eq(SaleContract::getPigeonhole, 0);
        query.orderByDesc("id");

        Page<SaleContract> saleContractPage = saleContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (SaleContract record : saleContractPage.getRecords()) {
            // String saleCustomerId = record.getSaleCustomerId();
            // Customer customer = customerMapper.selectById(saleCustomerId);
            // record.setCustomer(customer);
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
            String revenuePhoto = record.getRevenuePhoto();
            record.setRevenuePhotoList(Arrays.asList(revenuePhoto));
            //有多个照片
            if (StringUtils.isNotEmpty(revenuePhoto) && revenuePhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(revenuePhoto);
                record.setRevenuePhotoList(list);
                //取第一个图片的url
                record.setRevenuePhoto(ImageUtils.getFirstImageUrl(revenuePhoto));
            }
        }
        return saleContractPage;
    }

    @Override
    public boolean add(SaleContract saleContract) {
        if (saleContract.equals(null)) {
            return false;
        }
        String contractPhotoStr = "";
        if (saleContract.getContractPhotoList().size() > 0) {
            for (String time : saleContract.getContractPhotoList()) {
                contractPhotoStr += time + ",";
            }
            //赋值contractPhoto
            saleContract.setContractPhoto(contractPhotoStr.substring(0, contractPhotoStr.length() - 1));
        } else {
            saleContract.setContractPhoto(contractPhotoStr);
        }
        saleContract.setPigeonhole("1");
        saleContract.setCreateBy(SecurityUtils.getUsername());
        saleContract.setLastUpdateBy(SecurityUtils.getUsername());
        int insert = this.baseMapper.insert(saleContract);
        if (insert > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean edit(SaleContract saleContract) {
        if (saleContract.equals(null)) {
            return false;
        }
        String contractPhotoStr = "";
        if (saleContract.getContractPhotoList().size() > 0) {
            for (String time : saleContract.getContractPhotoList()) {
                contractPhotoStr += time + ",";
            }
            //赋值contractPhoto
            saleContract.setContractPhoto(contractPhotoStr.substring(0, contractPhotoStr.length() - 1));
        } else {
            saleContract.setContractPhoto(contractPhotoStr);
        }
        saleContract.setPigeonhole("1");
        saleContract.setLastUpdateBy(SecurityUtils.getUsername());
        int i = this.baseMapper.updateById(saleContract);
        if (i > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public BigDecimal getRemainingOutboundVolume(String saleContractNo) {
        //拿到所有物流单中销售单号是saleContract的
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        query.lambda().eq(LogisticsContract::getSaleContractNo, saleContractNo);
        List<LogisticsContract> list = logisticsContractService.list(query);
        BigDecimal result = BigDecimal.valueOf(0);
        //拿到所有的物流单中的重量，得到总数， 如果没有的话返回0
        for (LogisticsContract logisticsContract : list) {
            result = result.add(logisticsContract.getTotalWeight());
        }
        return result;
    }

    @Override
    public List<LogisticsDetail> getDetailSaleContract(String saleContractNo) {
        //根据销售合同找到所有的物流单，再根据物流合同找到所有的物流详情表
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        query.lambda().eq(LogisticsContract::getSaleContractNo, saleContractNo);
        List<LogisticsContract> list = logisticsContractService.list(query);
        List<LogisticsDetail> logisticsDetailList = new ArrayList<>();
        for (LogisticsContract logisticsContract : list) {
            String logisticsContractNo = logisticsContract.getLogisticsContractNo();
            QueryWrapper<LogisticsDetail> detailQueryWrapper = new QueryWrapper<>();
            detailQueryWrapper.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
            List<LogisticsDetail> logisticsDetails = logisticsDetailService.list(detailQueryWrapper);
            for (LogisticsDetail logisticsDetail : logisticsDetails) {
                // if (logisticsDetail.getUpperType() == 1) {
                    logisticsDetailList.add(logisticsDetail);
                // }
            }
        }
        return logisticsDetailList;
    }

    @Override
    public IPage<SaleContract> getCashierSaleContract(ListParm listParm) {
        System.out.println(listParm);
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
            // QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
            // queryWrapper.lambda().like(Customer::getCustomerEnterpriseName, listParm.getSaleCompanyName());
            // Customer customer = customerMapper.selectOne(queryWrapper);
            // query.lambda().like(SaleContract::getSaleCustomerId, customer.getId());
            query.lambda().like(SaleContract::getCustomerEnterpriseName, listParm.getSaleCompanyName());
        }
        //货物名称
        if (StringUtils.isNotEmpty(listParm.getGoodsName())) {
            query.lambda().like(SaleContract::getGoodsName, listParm.getGoodsName());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(SaleContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(SaleContract::getSaleContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(SaleContract::getSaleContractTime, format);
        }
        // //查看归档为1的数据
        // query.lambda().eq(SaleContract::getPigeonhole, 0);
        query.orderByDesc("id");

        Page<SaleContract> saleContractPage = saleContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (SaleContract record : saleContractPage.getRecords()) {
            // String saleCustomerId = record.getSaleCustomerId();
            // Customer customer = customerMapper.selectById(saleCustomerId);
            // record.setCustomer(customer);
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
            String revenuePhoto = record.getRevenuePhoto();
            record.setRevenuePhotoList(Arrays.asList(revenuePhoto));
            //有多个照片
            if (StringUtils.isNotEmpty(revenuePhoto) && revenuePhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(revenuePhoto);
                record.setRevenuePhotoList(list);
                //取第一个图片的url
                record.setRevenuePhoto(ImageUtils.getFirstImageUrl(revenuePhoto));
            }
        }
        return saleContractPage;
    }

    @Override
    public int editCashierSale(SaleModel saleModel) {
        //根据id拿到销售单
        SaleContract saleContract = saleContractMapper.selectById(saleModel.getId());
        saleContract.setRevenueBy(SecurityUtils.getUsername());
        saleContract.setLastUpdateBy(SecurityUtils.getUsername());
        saleContract.setRevenueAmount(saleModel.getRevenueAmount());
        saleContract.setRevenueTime(saleModel.getRevenueTime());
        //图片处理
        List<String> revenuePhotoList = saleModel.getRevenuePhotoList();
        saleContract.setRevenuePhoto(ImageUtils.getDBString(revenuePhotoList));
        return saleContractMapper.updateById(saleContract);
    }

    @Override
    public List<ExportOutSaleContract> getExportList(ExportListParm listParm) {
        QueryWrapper<SaleContract> query = new QueryWrapper<>();
        //构造查询条件
        //合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(SaleContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //销售方公司id
        if (StringUtils.isNotEmpty(listParm.getSaleCompanyName())) {
            //通过公司名称拿到客户表对应的id
            // QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
            // queryWrapper.lambda().like(Customer::getCustomerEnterpriseName, listParm.getSaleCompanyName());
            // Customer customer = customerMapper.selectOne(queryWrapper);
            // query.lambda().like(SaleContract::getSaleCustomerId, customer.getId());
            query.lambda().like(SaleContract::getCustomerEnterpriseName, listParm.getSaleCompanyName());
        }
        //货物名称
        if (StringUtils.isNotEmpty(listParm.getGoodsName())) {
            query.lambda().like(SaleContract::getGoodsName, listParm.getGoodsName());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(SaleContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //起止时间
        if (listParm.getStartTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getStartTime());
            query.lambda().ge(SaleContract::getSaleContractTime, format);
        }
        if (listParm.getEndTime() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(listParm.getEndTime());
            query.lambda().le(SaleContract::getSaleContractTime, format);
        }
        //查看归档为1的数据
        if (listParm.getIsPigeonhole().equals("1")) {
            query.lambda().eq(SaleContract::getPigeonhole, 1);
        } else {
            query.lambda().eq(SaleContract::getPigeonhole, 0);
        }
        query.orderByDesc("id");
        List<SaleContract> saleContracts = saleContractMapper.selectList(query);
        List<ExportOutSaleContract> list = new ArrayList<>();
        for (SaleContract saleContract : saleContracts) {
            ExportOutSaleContract exportOutSaleContract = new ExportOutSaleContract();
            exportOutSaleContract.setSaleContractNo(saleContract.getSaleContractNo());
            // QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
            // queryWrapper.lambda().eq(Customer::getId, saleContract.getSaleCustomerId());
            // Customer customer = customerMapper.selectOne(queryWrapper);
            exportOutSaleContract.setCustomerFactory(saleContract.getCustomerEnterpriseName());
            exportOutSaleContract.setOwnCompanyName(saleContract.getOwnCompanyName());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String format = sdf.format(saleContract.getSaleContractTime());
            exportOutSaleContract.setSaleContractTime(format);
            exportOutSaleContract.setGoodsName(saleContract.getGoodsName());
            exportOutSaleContract.setGoodsCount(saleContract.getGoodsCount());
            exportOutSaleContract.setGoodsUnit(saleContract.getGoodsUnit());
            exportOutSaleContract.setGoodsUnitPrice(saleContract.getGoodsUnitPrice());
            exportOutSaleContract.setGoodsTotalPrice(saleContract.getGoodsTotalPrice());
            exportOutSaleContract.setPaymentMethod(saleContract.getPaymentMethod());
            exportOutSaleContract.setTransportMethod(saleContract.getTransportMethod());
            exportOutSaleContract.setRevenueAmount(saleContract.getRevenueAmount());
            exportOutSaleContract.setRevenueBy(saleContract.getRevenueBy());
            exportOutSaleContract.setSqueezeSeason(saleContract.getSqueezeSeason());
            exportOutSaleContract.setCreateBy(saleContract.getCreateBy());
            list.add(exportOutSaleContract);
        }
        return list;
    }

    @Override
    public boolean editIsHaveLogistics(String saleContractNo) {
        QueryWrapper<SaleContract> query = new QueryWrapper<>();
        query.lambda().eq(SaleContract::getSaleContractNo, saleContractNo);
        SaleContract saleContract = saleContractMapper.selectOne(query);
        if (saleContract == null) {
            //没有该销售合同号
            return false;
        } else {
            saleContract.setIsHaveLogistics(1);
            saleContractMapper.updateById(saleContract);
            return true;
        }
    }

}
