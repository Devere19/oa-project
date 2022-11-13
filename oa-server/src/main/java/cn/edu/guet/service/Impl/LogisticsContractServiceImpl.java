package cn.edu.guet.service.Impl;


import cn.edu.guet.bean.logisticsContract.ListParm;
import cn.edu.guet.bean.logisticsContract.LogisticsContract;
import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.LogisticsContractMapper;
import cn.edu.guet.mapper.LogisticsDetailMapper;
import cn.edu.guet.service.LogisticsContractService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author 郭乐源
 * @description 针对表【logistics_contract】的数据库操作Service实现
 * @createDate 2022-11-04 17:10:25
 */
@Service
public class LogisticsContractServiceImpl extends ServiceImpl<LogisticsContractMapper, LogisticsContract> implements LogisticsContractService {

    @Resource
    private LogisticsContractMapper logisticsContractMapper;
    @Resource
    private LogisticsDetailMapper logisticsDetailMapper;

    @Override
    public IPage<LogisticsContract> getList(ListParm listParm) {
        Page<LogisticsContract> page = new Page<>(listParm.getCurrentPage(), listParm.getPageSize());
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        //构造查询条件
        //物流单合同编号
        if (StringUtils.isNotEmpty(listParm.getLogisticsContractNo())) {
            query.lambda().like(LogisticsContract::getLogisticsContractNo, listParm.getLogisticsContractNo());
        }

        //销售单合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(LogisticsContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(LogisticsContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //查看归档为1的数据
        query.lambda().eq(LogisticsContract::getPigeonhole, 1);
        query.orderByDesc("create_time");

        Page<LogisticsContract> logisticsContractPage = logisticsContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (LogisticsContract record : logisticsContractPage.getRecords()) {
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
        return logisticsContractPage;

    }

    @Override
    public IPage<LogisticsContract> searchPigeonholeZero(ListParm listParm) {
        Page<LogisticsContract> page = new Page<>(listParm.getCurrentPage(), listParm.getPageSize());
        QueryWrapper<LogisticsContract> query = new QueryWrapper<>();
        //构造查询条件
        //物流单合同编号
        if (StringUtils.isNotEmpty(listParm.getLogisticsContractNo())) {
            query.lambda().like(LogisticsContract::getLogisticsContractNo, listParm.getLogisticsContractNo());
        }

        //销售单合同编号
        if (StringUtils.isNotEmpty(listParm.getSaleContractNo())) {
            query.lambda().like(LogisticsContract::getSaleContractNo, listParm.getSaleContractNo());
        }
        //榨季
        if (StringUtils.isNotEmpty(listParm.getSqueezeSeason())) {
            query.lambda().like(LogisticsContract::getSqueezeSeason, listParm.getSqueezeSeason());
        }
        //查看归档为1的数据
        query.lambda().eq(LogisticsContract::getPigeonhole, 0);
        query.orderByDesc("create_time");

        Page<LogisticsContract> logisticsContractPage = logisticsContractMapper.selectPage(page, query);
        //给里面的每一个customer赋值  根据saleCustomerId获取customer
        for (LogisticsContract record : logisticsContractPage.getRecords()) {

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
        return logisticsContractPage;
    }

    @Override
    public void changePigeonhole(Integer id) {
        LogisticsContract logisticsContract = logisticsContractMapper.selectById(id);
        String pigeonhole = logisticsContract.getPigeonhole();
        //判断归档  如果是0 改为1  如果是1  改为0
        if (pigeonhole.equals("0")) {
            logisticsContract.setPigeonhole("1");
            logisticsContractMapper.updateById(logisticsContract);
        } else if (pigeonhole.equals("1")) {
            logisticsContract.setPigeonhole("0");
            logisticsContractMapper.updateById(logisticsContract);
        }
    }

    @Override
    public List<LogisticsDetail> getDetailLogistics(String logisticsContractNo) {
        //根据物流合同找到所有的物流详情表
        QueryWrapper<LogisticsDetail> query = new QueryWrapper<>();
        query.lambda().eq(LogisticsDetail::getLogisticsContractNo, logisticsContractNo);
        List<LogisticsDetail> logisticsDetails = logisticsDetailMapper.selectList(query);
        return logisticsDetails;
    }

    @Override
    @Transactional
    public void add(LogisticsContract logisticsContract) {
        //新增物流单   然后新增物流详情单
        //图片字段处理
        List<String> contractPhotoList = logisticsContract.getContractPhotoList();
        logisticsContract.setContractPhoto(ImageUtils.getDBString(contractPhotoList));
        logisticsContract.setPigeonhole("1");
        logisticsContractMapper.insert(logisticsContract);
        List<LogisticsDetail> logisticsDetailList = logisticsContract.getLogisticsDetailList();
        //新增对应的物流详情但
        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            logisticsDetail.setLogisticsContractNo(logisticsContract.getLogisticsContractNo());
            logisticsDetailMapper.insert(logisticsDetail);
        }
        //自家仓库的出库记录和库存    外家仓库的出库记录和库存  不需要维护自家仓库的入库和库存记录，也不需要维护外加仓库的出库记录和库存
        //自家仓库的出库记录和库存
        for (LogisticsDetail logisticsDetail : logisticsDetailList) {
            if (logisticsDetail.getPurchaseContractNo().equals("000")&&logisticsDetail.getGoodsFactory().equals("自家仓库")){

            }
        }

    }

    @Override
    public Boolean checkLogisticsContractNo(String logisticsContractNo) {
        QueryWrapper<LogisticsContract> qw= new QueryWrapper<>();
        qw.eq("logistics_contract_no",logisticsContractNo).orderByDesc("create_time");
        List<LogisticsContract> logisticsContracts= logisticsContractMapper.selectList(qw);
        return !logisticsContracts.isEmpty();
    }
}




