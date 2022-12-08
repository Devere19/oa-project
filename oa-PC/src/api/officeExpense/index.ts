import http from "@/http";
import { officeExpenseModel } from "./OfficeExpenseModel";

//分页获取办公经费单
export const getOfficeExpenseDataApi = (currentPage: number, pageSize: number) => {
    return http.get("officeExpense/getOfficeExpenseData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询办公经费单
export const searchOfficeExpenseApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("officeExpense/searchOfficeExpense", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单笔办公经费单
export const deleteOneOfficeExpenseApi = (id: number) => {
    return http.delete(`officeExpense/deleteOneOfficeExpense/${id}`)
}

//新增办公经费单
export const addNewOfficeExpenseApi = (officeExpense: officeExpenseModel) => {
    return http.post("officeExpense/addNewOfficeExpense",
        officeExpense)
}

//修改办公经费单
export const updateOfficeExpenseApi = (officeExpense: officeExpenseModel) => {
    return http.post("officeExpense/updateOfficeExpense",
        officeExpense)
}

//财务审批通过
export const changeFinanceState = (id: number, financeStaff: string) => {
    return http.get("officeExpense/changeFinanceState", {
        id: id,
        financeStaff: financeStaff
    })
}

//董事会审批通过
export const changeDirectorState = (officeExpenseId: number, userId: string) => {
    return http.get("officeExpense/changeDirectorState", {
        officeExpenseId: officeExpenseId,
        userId: userId
    })
}