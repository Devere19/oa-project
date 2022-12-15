package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.*;
import cn.edu.guet.bean.exportModel.*;
import cn.edu.guet.bean.sale.SaleContract;
import cn.edu.guet.mapper.*;
import cn.edu.guet.service.IncomeSpendInfoService;
import cn.edu.guet.util.ImageUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;

/**
* @author 陶祎祎
* @description 针对表【total_income_spend_info】的数据库操作Service实现
* @createDate 2022-11-17 10:57:58
*/
@Service
public class IncomeSpendInfoServiceImpl extends ServiceImpl<TotalIncomeSpendInfoMapper, TotalIncomeSpendView>
    implements IncomeSpendInfoService {

    @Autowired
    private TotalIncomeSpendInfoMapper totalIncomeSpendInfoMapper;

    @Autowired
    private PartIncomeSpendInfoMapper partIncomeSpendInfoMapper;

    @Autowired
    private SpendDetailInfoMapper spendDetailInfoMapper;

    @Autowired
    private SaleContractMapper saleContractMapper;

    @Autowired
    private OfficeStateInfoMapper officeStateInfoMapper;

    @Autowired
    private PurchasePaymentContractInfoMapper purchasePaymentContractInfoMapper;

    @Autowired
    private ProcessPaymentContractInfoMapper processPaymentContractInfoMapper;

    @Autowired
    private LogisticsPaymentContractInfoMapper logisticsPaymentContractInfoMapper;

    @Autowired
    private ShippingContractMapper shippingContractMapper;

    @Autowired
    private OfficeExpenseMapper officeExpenseMapper;

    @Override
    public List getChartIncomeSpendData(String dataType, String dataCompany, int timeType, String startDate, String endDate) {
        if("0".equals(dataType)){
//            整体业务
            if("0".equals(dataCompany)){
                if(timeType==0){
//                    获取总体日
                    return totalIncomeSpendInfoMapper.getTotalDayIncomeSpendData(startDate,endDate);
                }else if(timeType==1){
//                    获取总体月
                    return totalIncomeSpendInfoMapper.getTotalMonthIncomeSpendData(startDate,endDate);
                }else if(timeType==2){
//                    获取总体季
                    return totalIncomeSpendInfoMapper.getTotalSeasonIncomeSpendData(startDate,endDate);
                }else if(timeType==3){
//                    获取总体年
                    return totalIncomeSpendInfoMapper.getTotalYearIncomeSpendData(startDate,endDate);
                }
            }else if("1".equals(dataCompany)){
//                广西永湘贸易有限责任公司
                if(timeType==0){
//                    获取日
                    return partIncomeSpendInfoMapper.getFirstDayIncomeSpendData(startDate, endDate);
                }else if(timeType==1){
//                    获取月
                    return partIncomeSpendInfoMapper.getFirstMonthIncomeSpendData(startDate, endDate);
                }else if(timeType==2){
//                    获取季
                    return partIncomeSpendInfoMapper.getFirstSeasonIncomeSpendData(startDate, endDate);
                }else if(timeType==3){
//                    获取年
                    return partIncomeSpendInfoMapper.getFirstYearIncomeSpendData(startDate, endDate);
                }
            }else if("2".equals(dataCompany)){
//                广西永湘物流有限公司
                if(timeType==0){
//                    获取日
                    return partIncomeSpendInfoMapper.getSecondDayIncomeSpendData(startDate, endDate);
                }else if(timeType==1){
//                    获取月
                    return partIncomeSpendInfoMapper.getSecondMonthIncomeSpendData(startDate, endDate);
                }else if(timeType==2){
//                    获取季
                    return partIncomeSpendInfoMapper.getSecondSeasonIncomeSpendData(startDate, endDate);
                }else if(timeType==3){
//                    获取年
                    return partIncomeSpendInfoMapper.getSecondYearIncomeSpendData(startDate, endDate);
                }
            }else if("3".equals(dataCompany)){
//                广西丰沣顺国际物流有限公司
                if(timeType==0){
//                    获取日
                    return partIncomeSpendInfoMapper.getThirdDayIncomeSpendData(startDate, endDate);
                }else if(timeType==1){
//                    获取月
                    return partIncomeSpendInfoMapper.getThirdMonthIncomeSpendData(startDate, endDate);
                }else if(timeType==2){
//                    获取季
                    return partIncomeSpendInfoMapper.getThirdSeasonIncomeSpendData(startDate, endDate);
                }else if(timeType==3){
//                    获取年
                    return partIncomeSpendInfoMapper.getThirdYearIncomeSpendData(startDate, endDate);
                }
            }else if("4".equals(dataCompany)){
//                广西众润贸易有限责任公司
                if(timeType==0){
//                    获取日
                    return partIncomeSpendInfoMapper.getFourthDayIncomeSpendData(startDate, endDate);
                }else if(timeType==1){
//                    获取月
                    return partIncomeSpendInfoMapper.getFourthMonthIncomeSpendData(startDate, endDate);
                }else if(timeType==2){
//                    获取季
                    return partIncomeSpendInfoMapper.getFourthSeasonIncomeSpendData(startDate, endDate);
                }else if(timeType==3){
//                    获取年
                    return partIncomeSpendInfoMapper.getFourthYearIncomeSpendData(startDate, endDate);
                }
            }
//            办公经费
        }else if("1".equals(dataType)){
            if("0".equals(dataCompany)){
                if(timeType==0){
                    return totalIncomeSpendInfoMapper.getTotalDayOfficeExpenseData(startDate, endDate);
                }else if(timeType==1){
                    return totalIncomeSpendInfoMapper.getTotalMonthOfficeExpenseData(startDate, endDate);
                }else if(timeType==2){
                    return totalIncomeSpendInfoMapper.getTotalSeasonOfficeExpenseData(startDate, endDate);
                }else if(timeType==3){
                    return totalIncomeSpendInfoMapper.getTotalYearOfficeExpenseData(startDate, endDate);
                }
            }
        }
        return null;
    }

    @Override
    public List getNumberIncomeSpendData(String dataType, String dataCompany) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateNow = sdf.format(new Date());
        System.out.println("当前时间为："+dateNow);

        String currentYear=dateNow.substring(0,4);
        String currentMonth=dateNow.substring(0,7);
        String currentSeason=null;
        String currentDay=dateNow.substring(0,10);

        int month=Integer.parseInt(dateNow.substring(5,7));
        if(month<4){
            currentSeason=currentYear+ "-1";
        }else if(month<7){
            currentSeason=currentYear+ "-2";
        }else if(month<10){
            currentSeason=currentYear+ "-3";
        }else if(month<13){
            currentSeason=currentYear+ "-4";
        }

        if("0".equals(dataType)){
            if("0".equals(dataCompany)){
                List numberTotal=new ArrayList<>();
                numberTotal.add(totalIncomeSpendInfoMapper.getTotalDayIncomeSpendData(currentDay,currentDay));
                numberTotal.add(totalIncomeSpendInfoMapper.getTotalMonthIncomeSpendData(currentMonth,currentMonth));
                numberTotal.add(totalIncomeSpendInfoMapper.getTotalSeasonIncomeSpendData(currentSeason,currentSeason));
                numberTotal.add(totalIncomeSpendInfoMapper.getTotalYearIncomeSpendData(currentYear,currentYear));
                return numberTotal;
            }else if("1".equals(dataCompany)){
                List numberYx=new ArrayList<>();
                numberYx.add(partIncomeSpendInfoMapper.getFirstDayIncomeSpendData(currentDay, currentDay));
                numberYx.add(partIncomeSpendInfoMapper.getFirstMonthIncomeSpendData(currentMonth, currentMonth));
                numberYx.add(partIncomeSpendInfoMapper.getFirstSeasonIncomeSpendData(currentSeason, currentSeason));
                numberYx.add(partIncomeSpendInfoMapper.getFirstYearIncomeSpendData(currentYear, currentYear));
                return numberYx;
            }else if("2".equals(dataCompany)){
                List numberJt=new ArrayList<>();
                numberJt.add(partIncomeSpendInfoMapper.getSecondDayIncomeSpendData(currentDay, currentDay));
                numberJt.add(partIncomeSpendInfoMapper.getSecondMonthIncomeSpendData(currentMonth, currentMonth));
                numberJt.add(partIncomeSpendInfoMapper.getSecondSeasonIncomeSpendData(currentSeason, currentSeason));
                numberJt.add(partIncomeSpendInfoMapper.getSecondYearIncomeSpendData(currentYear, currentYear));
                return numberJt;
            }else if("3".equals(dataCompany)){
                List numberFfs=new ArrayList<>();
                numberFfs.add(partIncomeSpendInfoMapper.getThirdDayIncomeSpendData(currentDay, currentDay));
                numberFfs.add(partIncomeSpendInfoMapper.getThirdMonthIncomeSpendData(currentMonth, currentMonth));
                numberFfs.add(partIncomeSpendInfoMapper.getThirdSeasonIncomeSpendData(currentSeason, currentSeason));
                numberFfs.add(partIncomeSpendInfoMapper.getThirdYearIncomeSpendData(currentYear, currentYear));
                return numberFfs;
            }else if("4".equals(dataCompany)){
                List numberFfs=new ArrayList<>();
                numberFfs.add(partIncomeSpendInfoMapper.getFourthDayIncomeSpendData(currentDay, currentDay));
                numberFfs.add(partIncomeSpendInfoMapper.getFourthMonthIncomeSpendData(currentMonth, currentMonth));
                numberFfs.add(partIncomeSpendInfoMapper.getFourthSeasonIncomeSpendData(currentSeason, currentSeason));
                numberFfs.add(partIncomeSpendInfoMapper.getFourthYearIncomeSpendData(currentYear, currentYear));
                return numberFfs;
            }
        }else if("1".equals(dataType)){
            List numberTotal=new ArrayList<>();
            numberTotal.add(totalIncomeSpendInfoMapper.getTotalDayOfficeExpenseData(currentDay,currentDay));
            numberTotal.add(totalIncomeSpendInfoMapper.getTotalMonthOfficeExpenseData(currentMonth, currentMonth));
            numberTotal.add(totalIncomeSpendInfoMapper.getTotalSeasonOfficeExpenseData(currentSeason, currentSeason));
            numberTotal.add(totalIncomeSpendInfoMapper.getTotalYearOfficeExpenseData(currentYear, currentYear));
            return numberTotal;
        }
        return null;
    }

    @Override
    public IncomeSpendDetail getDetailIncomeSpendData(String dataType, String dataCompany, int timeType, String startDate, String endDate) {
        IncomeSpendDetail incomeSpendDetail=new IncomeSpendDetail();
        String[] companyList={"总体","广西永湘贸易有限责任公司","广西永湘物流有限公司","广西丰沣顺国际物流有限公司","广西众润贸易有限责任公司"};
        if("0".equals(dataType)){
//            整体业务
            if("0".equals(dataCompany)){
                if(timeType==0){
//                    获取总体日细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getTotalDayIncomeData(startDate,endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getTotalDaySpendData(startDate,endDate)));
                }else if(timeType==1){
//                    获取总体月细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getTotalMonthIncomeData(startDate,endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getTotalMonthSpendData(startDate,endDate)));
                }else if(timeType==2){
//                    获取总体季细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getTotalSeasonIncomeData(startDate,endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getTotalSeasonSpendData(startDate,endDate)));
                }else if(timeType==3){
//                    获取总体年细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getTotalYearIncomeData(startDate,endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getTotalYearSpendData(startDate,endDate)));
                }
            }else if("1".equals(dataCompany)||"2".equals(dataCompany)||"3".equals(dataCompany)||"4".equals(dataCompany)){
                if(timeType==0){
//                    获取子公司日细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getCompanyDayIncomeData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getCompanyDaySpendData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                }else if(timeType==1){
//                    获取子公司月细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getCompanyMonthIncomeData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getCompanyMonthSpendData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                }else if(timeType==2){
//                    获取子公司季细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getCompanySeasonIncomeData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getCompanySeasonSpendData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                }else if(timeType==3){
//                    获取子公司年细则
                    incomeSpendDetail.setIncomeDetail(handleIncomeImages(saleContractMapper.getCompanyYearIncomeData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                    incomeSpendDetail.setSpendDetail(handleSpendImages(spendDetailInfoMapper.getCompanyYearSpendData(companyList[Integer.parseInt(dataCompany)],startDate, endDate)));
                }
            }
//            办公经费
        }else if("1".equals(dataType)){
            if("0".equals(dataCompany)){
                if(timeType==0){
                    incomeSpendDetail.setSpendDetail(handleOffcieImages(spendDetailInfoMapper.getDayOfficeExpenseData(startDate, endDate)));
                }else if(timeType==1){
                    incomeSpendDetail.setSpendDetail(handleOffcieImages(spendDetailInfoMapper.getMonthOfficeExpenseData(startDate, endDate)));
                }else if(timeType==2){
                    incomeSpendDetail.setSpendDetail(handleOffcieImages(spendDetailInfoMapper.getSeasonOfficeExpenseData(startDate, endDate)));
                }else if(timeType==3){
                    incomeSpendDetail.setSpendDetail(handleOffcieImages(spendDetailInfoMapper.getYearOfficeExpenseData(startDate, endDate)));
                }
            }
        }
        return incomeSpendDetail;
    }

    public List<SaleContract> handleIncomeImages(List<SaleContract> incomeList){
        for (SaleContract record : incomeList) {
            //处理图片，形成一个图片数组
            String paymentPhoto = record.getRevenuePhoto();
//            付款照片
            if (StringUtils.isNotEmpty(paymentPhoto) && paymentPhoto.contains(",")) {
                //分割图片字符串，形成一个数组
                List<String> list = ImageUtils.imageSplit(paymentPhoto);
                record.setRevenuePhotoList(list);
                //取第一个图片的url
                record.setRevenuePhoto(ImageUtils.getFirstImageUrl(paymentPhoto));
            } else {
                record.setRevenuePhotoList(Arrays.asList(paymentPhoto));
            }
        }
        return incomeList;
    }

    public List<SpendDetailView> handleSpendImages(List<SpendDetailView> spendList){
        for (SpendDetailView record : spendList) {
            //处理图片，形成一个图片数组
            String paymentPhoto = record.getPaymentPhoto();
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
        return spendList;
    }

    public List<OfficeExpense> handleOffcieImages(List<OfficeExpense> officeList){
        for (OfficeExpense record : officeList) {

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
            } else {
                record.setPaymentPhotoArray(Arrays.asList(paymentPhoto));
            }
        }
        return officeList;
    }

    @Override
    public List<ExportSaleModel> getSaleData(String dataCompany, Integer timeType, String chooseDate) {
        String[] companyList={"总体","广西永湘贸易有限责任公司","广西永湘物流有限公司","广西丰沣顺国际物流有限公司","广西众润贸易有限责任公司"};
        if("0".equals(dataCompany)){
            if(timeType==0){
                return saleContractMapper.getSaleExportDayData(chooseDate,chooseDate);
            }else if(timeType==1){
                return saleContractMapper.getSaleExportMonthData(chooseDate,chooseDate);
            }else if(timeType==2){
                return saleContractMapper.getSaleExportSeasonData(chooseDate,chooseDate);
            }else if(timeType==3){
                return saleContractMapper.getSaleExportYearData(chooseDate,chooseDate);
            }
        }else{
            if(timeType==0){
                return saleContractMapper.getSaleExportCompanyDayData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==1){
                return saleContractMapper.getSaleExportCompanyMonthData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==2){
                return saleContractMapper.getSaleExportCompanySeasonData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==3){
                return saleContractMapper.getSaleExportCompanyYearData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }
        }
        return null;
    }

    @Override
    public List<ExportPurchasePaymentModel> getPurchasePaymentData(String dataCompany, Integer timeType, String chooseDate) {
        String[] companyList={"总体","广西永湘贸易有限责任公司","广西永湘物流有限公司","广西丰沣顺国际物流有限公司","广西众润贸易有限责任公司"};
        if("0".equals(dataCompany)){
            if(timeType==0){
                return purchasePaymentContractInfoMapper.getPurchaseExportDayData(chooseDate,chooseDate);
            }else if(timeType==1){
                return purchasePaymentContractInfoMapper.getPurchaseExportMonthData(chooseDate,chooseDate);
            }else if(timeType==2){
                return purchasePaymentContractInfoMapper.getPurchaseExportSeasonData(chooseDate,chooseDate);
            }else if(timeType==3){
                return purchasePaymentContractInfoMapper.getPurchaseExportYearData(chooseDate,chooseDate);
            }
        }else{
            if(timeType==0){
                return purchasePaymentContractInfoMapper.getPurchaseExportCompanyDayData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==1){
                return purchasePaymentContractInfoMapper.getPurchaseExportCompanyMonthData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==2){
                return purchasePaymentContractInfoMapper.getPurchaseExportCompanySeasonData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==3){
                return purchasePaymentContractInfoMapper.getPurchaseExportCompanyYearData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }
        }
        return null;
    }

    @Override
    public List<ExportProcessPaymentModel> getProcessPaymentData(String dataCompany, Integer timeType, String chooseDate) {
        String[] companyList={"总体","广西永湘贸易有限责任公司","广西永湘物流有限公司","广西丰沣顺国际物流有限公司","广西众润贸易有限责任公司"};
        if("0".equals(dataCompany)){
            if(timeType==0){
                return processPaymentContractInfoMapper.getProcessExportDayData(chooseDate,chooseDate);
            }else if(timeType==1){
                return processPaymentContractInfoMapper.getProcessExportMonthData(chooseDate,chooseDate);
            }else if(timeType==2){
                return processPaymentContractInfoMapper.getProcessExportSeasonData(chooseDate,chooseDate);
            }else if(timeType==3){
                return processPaymentContractInfoMapper.getProcessExportYearData(chooseDate,chooseDate);
            }
        }else{
            if(timeType==0){
                return processPaymentContractInfoMapper.getProcessExportCompanyDayData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==1){
                return processPaymentContractInfoMapper.getProcessExportCompanyMonthData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==2){
                return processPaymentContractInfoMapper.getProcessExportCompanySeasonData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==3){
                return processPaymentContractInfoMapper.getProcessExportCompanyYearData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }
        }
        return null;
    }

    @Override
    public List<ExportLogisticsPaymentModel> getLogisticsPaymentData(String dataCompany, Integer timeType, String chooseDate) {
        String[] companyList={"总体","广西永湘贸易有限责任公司","广西永湘物流有限公司","广西丰沣顺国际物流有限公司","广西众润贸易有限责任公司"};
        if("0".equals(dataCompany)){
            if(timeType==0){
                return logisticsPaymentContractInfoMapper.getLogisticsExportDayData(chooseDate,chooseDate);
            }else if(timeType==1){
                return logisticsPaymentContractInfoMapper.getLogisticsExportMonthData(chooseDate,chooseDate);
            }else if(timeType==2){
                return logisticsPaymentContractInfoMapper.getLogisticsExportSeasonData(chooseDate,chooseDate);
            }else if(timeType==3){
                return logisticsPaymentContractInfoMapper.getLogisticsExportYearData(chooseDate,chooseDate);
            }
        }else{
            if(timeType==0){
                return logisticsPaymentContractInfoMapper.getLogisticsExportCompanyDayData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==1){
                return logisticsPaymentContractInfoMapper.getLogisticsExportCompanyMonthData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==2){
                return logisticsPaymentContractInfoMapper.getLogisticsExportCompanySeasonData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==3){
                return logisticsPaymentContractInfoMapper.getLogisticsExportCompanyYearData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }
        }
        return null;
    }

    @Override
    public List<ExportShippingModel> getShippingData(String dataCompany, Integer timeType, String chooseDate) {
        String[] companyList={"总体","广西永湘贸易有限责任公司","广西永湘物流有限公司","广西丰沣顺国际物流有限公司","广西众润贸易有限责任公司"};
        if("0".equals(dataCompany)){
            if(timeType==0){
                return shippingContractMapper.getShippingExportDayData(chooseDate,chooseDate);
            }else if(timeType==1){
                return shippingContractMapper.getShippingExportMonthData(chooseDate,chooseDate);
            }else if(timeType==2){
                return shippingContractMapper.getShippingExportSeasonData(chooseDate,chooseDate);
            }else if(timeType==3){
                return shippingContractMapper.getShippingExportYearData(chooseDate,chooseDate);
            }
        }else{
            if(timeType==0){
                return shippingContractMapper.getShippingExportCompanyDayData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==1){
                return shippingContractMapper.getShippingExportCompanyMonthData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==2){
                return shippingContractMapper.getShippingExportCompanySeasonData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }else if(timeType==3){
                return shippingContractMapper.getShippingExportCompanyYearData(companyList[Integer.parseInt(dataCompany)],chooseDate,chooseDate);
            }
        }
        return null;
    }

    @Override
    public List<ExportOfficeExpenseModel> getOfficeExpenseData(Integer timeType, String chooseDate) {
        if(timeType==0){
            return officeExpenseMapper.getOfficeExpenseExportDayData(chooseDate,chooseDate);
        }else if(timeType==1){
            return officeExpenseMapper.getOfficeExpenseExportMonthData(chooseDate,chooseDate);
        }else if(timeType==2){
            return officeExpenseMapper.getOfficeExpenseExportSeasonData(chooseDate,chooseDate);
        }else if(timeType==3){
            return officeExpenseMapper.getOfficeExpenseExportYearData(chooseDate,chooseDate);
        }
        return null;
    }

}




