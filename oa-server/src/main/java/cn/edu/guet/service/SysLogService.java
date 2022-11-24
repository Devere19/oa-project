package cn.edu.guet.service;

import cn.edu.guet.bean.log.ListParm;
import cn.edu.guet.bean.log.SysLog;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @Author 郭乐源
 * @Date 2022/8/9 18:45
 * @Version 1.0
 */
public interface SysLogService extends IService<SysLog> {
    IPage getList(ListParm listParm);

    //删除7天前的日志
    void delete();
}
