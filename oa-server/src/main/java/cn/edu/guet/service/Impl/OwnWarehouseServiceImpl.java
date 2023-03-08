package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.own.OwnWarehouse;
import cn.edu.guet.mapper.OwnWarehouseMapper;
import cn.edu.guet.service.OwnWarehouseService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Map;
import java.util.function.Function;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: 钟丁豪
 * @Date: 2022/11/20/18:08
 * @Description:
 */
@Service
public class OwnWarehouseServiceImpl extends ServiceImpl<OwnWarehouseMapper,OwnWarehouse> implements OwnWarehouseService {

    @Autowired
    private OwnWarehouseMapper ownWarehouseMapper;

    @Override
    public Page<OwnWarehouse> getOwnWarehouseData(int currentPage, int pageSize) {
        QueryWrapper<OwnWarehouse> wrapper = new QueryWrapper<>();
        wrapper.ne("goods_count",0);
        Page<OwnWarehouse> page = new Page<>(currentPage,pageSize);
        page = ownWarehouseMapper.selectPage(page,wrapper);
        return page;
    }

    @Override
    public Page<OwnWarehouse> searchOwnWarehouse(int currentPage, int pageSize, String searchWord) {
        LambdaQueryWrapper<OwnWarehouse> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(OwnWarehouse::getGoodsName,searchWord);
        Page<OwnWarehouse> page = new Page<>(currentPage, pageSize);
        Page<OwnWarehouse> vague = ownWarehouseMapper.selectPage(page,wrapper);
        return vague;
    }
}
