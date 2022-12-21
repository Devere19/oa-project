import http from "@/http";
import { ownCompanyModel } from "./OwnCompanyModel";

//获取己方公司表列表
export const getOwnCompanySelectApi = () => {
    return http.get("ownCompany/getOwnCompanySelect")
}

//分页获取己方公司数据
export const getOwnCompanyDataApi = (currentPage: number, pageSize: number) => {
    return http.get("ownCompany/getOwnCompanyData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询己方公司数据
export const searchOwnCompanyApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("ownCompany/searchOwnCompany", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单个己方公司数据
export const deleteOneOwnCompanyApi = (id: number) => {
    return http.delete(`ownCompany/deleteOneOwnCompany/${id}`)
}

//新增己方公司数据
export const addNewOwnCompanyApi = (ownCompany: ownCompanyModel) => {
    return http.post("ownCompany/addNewOwnCompany",
        ownCompany)
}

//修改己方公司数据
export const updateOwnCompanyApi = (ownCompany: ownCompanyModel) => {
    return http.post("ownCompany/updateOwnCompany",
        ownCompany)
}
