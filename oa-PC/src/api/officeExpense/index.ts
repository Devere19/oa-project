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