package cn.edu.guet.service;

import cn.edu.guet.bean.own.OwnWarehouse;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;


/**
 * Created with IntelliJ IDEA.
 *
 * @Author: 钟丁豪
 * @Date: 2022/11/20/18:00
 * @Description:
 */
public interface OwnWarehouseService extends IService<OwnWarehouse> {
    Page<OwnWarehouse> getOwnWarehouseData(int currentPage, int pageSize);//查询全部
    Page<OwnWarehouse> searchOwnWarehouse(int currentPage, int pageSize, String searchWord);
}
