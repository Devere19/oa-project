package cn.edu.guet.service;

import cn.edu.guet.bean.own.OwnInOut;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 *
 * @Author: 钟丁豪
 * @Date: 2022/11/21/14:30
 * @Description:
 */
public interface OwnInOutService extends IService<OwnInOut> {
    List<OwnInOut> getOwnInOutData(String inOutGoodsName);//查询全部
}
