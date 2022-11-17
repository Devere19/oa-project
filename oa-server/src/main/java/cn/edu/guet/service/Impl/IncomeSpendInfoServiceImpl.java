package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.TotalIncomeSpendView;
import cn.edu.guet.mapper.FfsIncomeSpendInfoMapper;
import cn.edu.guet.mapper.JtIncomeSpendInfoMapper;
import cn.edu.guet.mapper.TotalIncomeSpendInfoMapper;
import cn.edu.guet.mapper.YxIncomeSpendInfoMapper;
import cn.edu.guet.service.IncomeSpendInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
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
    private YxIncomeSpendInfoMapper yxIncomeSpendInfoMapper;

    @Autowired
    private JtIncomeSpendInfoMapper jtIncomeSpendInfoMapper;

    @Autowired
    private FfsIncomeSpendInfoMapper ffsIncomeSpendInfoMapper;

    @Override
    public List getIncomeSpendData(String dataType, String dataCompany, Date startDate, Date endDate) {
        if("0".equals(dataType)){
            if("0".equals(dataCompany)){
                System.out.println(totalIncomeSpendInfoMapper.getTotalIncomeSpendData(startDate,endDate));
                return totalIncomeSpendInfoMapper.getTotalIncomeSpendData(startDate,endDate);
            }else if("1".equals(dataCompany)){
                System.out.println(yxIncomeSpendInfoMapper.getYxIncomeSpendData(startDate, endDate));
                return yxIncomeSpendInfoMapper.getYxIncomeSpendData(startDate, endDate);
            }else if("2".equals(dataCompany)){
                return jtIncomeSpendInfoMapper.getJtIncomeSpendData(startDate, endDate);
            }else if("3".equals(dataCompany)){
                return ffsIncomeSpendInfoMapper.getFfsIncomeSpendData(startDate, endDate);
            }
        }
        return null;
    }
}




