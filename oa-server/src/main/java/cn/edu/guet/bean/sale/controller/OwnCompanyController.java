package cn.edu.guet.bean.sale.controller;

import cn.edu.guet.bean.OwnCompany;
import cn.edu.guet.bean.customer.SelectModel;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.OwnCompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 陶祎祎
 */
@RestController
@RequestMapping("/ownCompany")
public class OwnCompanyController {

    @Autowired
    private OwnCompanyService ownCompanyService;

    @GetMapping("/getOwnCompanySelect")
    public HttpResult getSelect(){
        List<SelectModel> selectModelList = new ArrayList<>();
        for (OwnCompany ownCompany : ownCompanyService.list()) {
            SelectModel selectModel = new SelectModel();
            selectModel.setLabel(ownCompany.getOwnCompanyName());
            selectModel.setValue(ownCompany.getOwnCompanyName());
            selectModelList.add(selectModel);
        }
        return ResultUtils.success("查询成功",selectModelList);
    }

    //    获取乙方公司数据
    @RequestMapping("/getOwnCompanyData")
    public HttpResult getOwnCompanyData(int current, int page){
        return ResultUtils.success("查询成功",ownCompanyService.getOwnCompanyData(current,page));
    }

    @RequestMapping("/searchOwnCompany")
    public HttpResult searchOwnCompany(int current,int page,String searchWord){
        return ResultUtils.success("查询成功",ownCompanyService.searchOwnCompany(current,page,searchWord));
    }

    @DeleteMapping("/deleteOneOwnCompany/{id}")
    public HttpResult deleteOneOwnCompany(@PathVariable("id") Integer id){
        System.out.println("所要删除的ID为"+id);
        return ResultUtils.success("删除成功",ownCompanyService.deleteOneOwnCompany(id));
    }

    @RequestMapping("/addNewOwnCompany")
    public HttpResult addNewCustomer(@RequestBody OwnCompany ownCompany){
        return ResultUtils.success("新增成功",ownCompanyService.addNewOwnCompany(ownCompany));
    }

    @RequestMapping("/updateOwnCompany")
    public HttpResult updateOwnCompany(@RequestBody OwnCompany ownCompany){
        return ResultUtils.success("更新成功",ownCompanyService.updateOwnCompany(ownCompany));
    }

    @RequestMapping("/checkOwnCompanyName")
    public HttpResult checkOwnCompanyName(String ownCompanyName){
        return ResultUtils.success("获取成功",ownCompanyService.checkOwnCompanyName(ownCompanyName));
    }
}
