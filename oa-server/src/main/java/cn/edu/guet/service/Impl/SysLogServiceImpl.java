package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.SysRole;
import cn.edu.guet.bean.log.ListParm;
import cn.edu.guet.bean.log.SysLog;
import cn.edu.guet.mapper.SysLogMapper;
import cn.edu.guet.service.SysLogService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @Author 郭乐源
 * @Date 2022/8/9 18:46
 * @Version 1.0
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {
    @Resource
    private SysLogMapper sysLogMapper;
    @Override
    public IPage getList(ListParm listParm) {
        //构造一个分页对象
        IPage<SysLog> page = new Page<>(listParm.getCurrentPage(), listParm.getPageSize());
        //构造查询条件
        QueryWrapper<SysLog> query = new QueryWrapper<>();
        query.orderByDesc("id");
        return sysLogMapper.selectPage(page,query);
    }
}
