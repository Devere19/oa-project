package cn.edu.guet.service;

import cn.edu.guet.bean.CashierOfficeExpense;
import cn.edu.guet.bean.ImportModel.ImportOfficeExpenseModel;
import cn.edu.guet.bean.OfficeExpense;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 陶祎祎
* @description 针对表【office_expense】的数据库操作Service
* @createDate 2022-11-19 13:16:22
*/
public interface OfficeExpenseService extends IService<OfficeExpense> {
    Page<OfficeExpense> getOfficeExpenseData(int currentPage, int pageSize);
    Page<OfficeExpense> searchOfficeExpense(int currentPage, int pageSize,String searchWord);
    int addNewOfficeExpense(OfficeExpense officeExpense);
    int updateOfficeExpense(OfficeExpense officeExpense);
    int deleteOneOfficeExpense(int id);
    int handleImportOfficeExpenseModel(ImportOfficeExpenseModel importOfficeExpenseModel);

    //    出纳
    Page<CashierOfficeExpense> getCashierOfficeExpense(int currentPage, int pageSize);
    Page<CashierOfficeExpense> searchCashierOfficeExpense(int currentPage, int pageSize,String searchWord);
    int uploadCashierOfficeExpense(OfficeExpense officeExpense);

    //    APP
    Page<OfficeExpense> getDirectorOE(int currentPage, int pageSize, int userId , int type);
    OfficeExpense getOneDirectorOE(int id);
    Page<OfficeExpense> searchDirectorOE(int currentPage, int pageSize, String searchWord, int userId);

    //审批
    int changeFinanceState(int id,String financeStaff);
    int changeDirectorState(int officeExpenseId,int userId);
}
