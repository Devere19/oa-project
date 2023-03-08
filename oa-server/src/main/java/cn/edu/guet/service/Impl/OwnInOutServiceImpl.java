package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.own.OwnInOut;
import cn.edu.guet.mapper.OwnInOutMapper;
import cn.edu.guet.service.OwnInOutService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: 钟丁豪
 * @Date: 2022/11/21/14:32
 * @Description:
 */
@Service
public class OwnInOutServiceImpl extends ServiceImpl<OwnInOutMapper, OwnInOut> implements OwnInOutService {

    @Autowired
    private OwnInOutMapper ownInOutMapper;

    @Override
    public List<OwnInOut> getOwnInOutData(String inOutGoodsName) {
        QueryWrapper<OwnInOut> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("in_out_goods_name", inOutGoodsName);
        List<OwnInOut> own = ownInOutMapper.selectList(queryWrapper);
        return own;
    }
}
