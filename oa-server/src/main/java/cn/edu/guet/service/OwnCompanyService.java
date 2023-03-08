package cn.edu.guet.service;

import cn.edu.guet.bean.OwnCompany;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【own_company】的数据库操作Service
* @createDate 2022-12-05 13:35:05
*/
public interface OwnCompanyService extends IService<OwnCompany> {
    Page<OwnCompany> getOwnCompanyData(int currentPage, int pageSize);
    Page<OwnCompany> searchOwnCompany(int currentPage, int pageSize,String searchWord);
    int addNewOwnCompany(OwnCompany ownCompany);
    int updateOwnCompany(OwnCompany ownCompany);
    int deleteOneOwnCompany(int id);
    Integer checkOwnCompanyName(String ownCompanyName);
}
