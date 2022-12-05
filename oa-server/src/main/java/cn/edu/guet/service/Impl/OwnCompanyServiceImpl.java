package cn.edu.guet.service.Impl;

import cn.edu.guet.bean.OwnCompany;
import cn.edu.guet.bean.customer.Customer;
import cn.edu.guet.mapper.OwnCompanyMapper;
import cn.edu.guet.service.OwnCompanyService;
import cn.edu.guet.util.SecurityUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 陶祎祎
 * @description 针对表【own_company】的数据库操作Service实现
 * @createDate 2022-12-05 13:35:05
 */
@Service
public class OwnCompanyServiceImpl extends ServiceImpl<OwnCompanyMapper, OwnCompany>
        implements OwnCompanyService {

    @Autowired
    private OwnCompanyMapper ownCompanyMapper;

    @Override
    public Page<OwnCompany> getOwnCompanyData(int currentPage, int pageSize) {
        QueryWrapper<OwnCompany> qw = new QueryWrapper<>();
        qw.orderByDesc("create_time");
        Page<OwnCompany> page = new Page<>(currentPage, pageSize);
        page = ownCompanyMapper.selectPage(page, qw);
        return page;
    }

    @Override
    public Page<OwnCompany> searchOwnCompany(int currentPage, int pageSize, String searchWord) {
        QueryWrapper<OwnCompany> qw = new QueryWrapper<>();
        qw.like("own_company_name", searchWord)
                .or().like("create_by", searchWord).orderByDesc("create_time");
        Page<OwnCompany> page = new Page<>(currentPage, pageSize);
        page = ownCompanyMapper.selectPage(page, qw);
        return page;
    }

    @Override
    public int addNewOwnCompany(OwnCompany ownCompany) {
        ownCompany.setCreateBy(SecurityUtils.getUsername());
        ownCompany.setLastUpdateBy(SecurityUtils.getUsername());
        return ownCompanyMapper.insert(ownCompany);
    }

    @Override
    public int updateOwnCompany(OwnCompany ownCompany) {
        OwnCompany data = ownCompanyMapper.selectById(ownCompany.getId());
        data.setOwnCompanyName(ownCompany.getOwnCompanyName());
        data.setLastUpdateBy(SecurityUtils.getUsername());
        return ownCompanyMapper.updateById(data);
    }

    @Override
    public int deleteOneOwnCompany(int id) {
        return ownCompanyMapper.deleteById(id);
    }

    @Override
    public Integer checkOwnCompanyName(String ownCompanyName) {
        QueryWrapper<OwnCompany> qw = new QueryWrapper<>();
        qw.eq("own_company_name", ownCompanyName);
        OwnCompany ownCompany = ownCompanyMapper.selectOne(qw);
        if (ownCompany == null) {
            return 0;
        } else {
            return ownCompany.getId();
        }
    }
}




