import http from "@/http";
import { customerModel } from "./CustomerModel";

//分页获取客户数据
export const getCustomerDataApi = (currentPage: number, pageSize: number) => {
    return http.get("api/customer/getCustomerData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询客户数据
export const searchCustomerApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("api/customer/searchCustomer", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单个客户数据
export const deleteOneCustomerApi = (id: number) => {
    return http.delete(`api/customer/deleteOneCustomer/${id}`)
}

//新增客户数据
export const addNewCustomerApi = (customer: customerModel) => {
    return http.post("api/customer/addNewCustomer",
        customer)
}

//修改客户数据
export const updateCustomerApi = (customer: customerModel) => {
    return http.post("api/customer/updateCustomer",
        customer)
}
