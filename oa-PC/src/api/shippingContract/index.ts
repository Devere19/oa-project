import http from "@/http";
import { shippingContractModel } from "./ShippingContractModel";

//分页获取海运单
export const getShippingContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("shippingContract/getshippingContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询海运单
export const searchShippingContractApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("shippingContract/searchShippingContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单笔海运单
export const deleteOneShippingContractApi = (id: number) => {
    return http.delete(`shippingContract/deleteOneShippingContract/${id}`)
}

//新增海运单
export const addNewShippingContractApi = (shippingContract: shippingContractModel) => {
    return http.post("shippingContract/addNewShippingContract",
        shippingContract)
}

//新增海运单
export const updateShippingContractApi = (shippingContract: shippingContractModel) => {
    return http.post("shippingContract/updateShippingContract",
        shippingContract)
}

//验证海运单集装箱号
export const checkContainerNoApi = (containerNo: string) => {
    return http.get("shippingContract/checkContainerNo", {
        containerNo: containerNo,
    })
}

//财务审批通过
export const changeFinanceState = (shippingContractNo: string, financeStaff: string) => {
    return http.get("shippingContract/changeFinanceState", {
        shippingContractNo: shippingContractNo,
        financeStaff: financeStaff
    })
}

//董事会审批通过
export const changeDirectorState = (shippingContractNo: number, userId: string) => {
    return http.get("shippingContract/changeDirectorState", {
        shippingContractNo: shippingContractNo,
        userId: userId
    })
}