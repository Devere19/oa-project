import http from "@/http";
import { processPaymentContractModel } from "./ProcessPaymentContractModel";

//分页获取加工付款单
export const getProcessPaymentContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("processPaymentContract/getProcessPaymentContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询加工付款单
export const searchProcessPaymentContractApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("processPaymentContract/searchProcessPaymentContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单笔加工付款单
export const deleteOneProcessPaymentContractApi = (id: number) => {
    return http.delete(`processPaymentContract/deleteOneProcessPaymentContract/${id}`)
}

//新增加工付款单
export const addNewProcessPaymentContractApi = (processPaymentContract: processPaymentContractModel) => {
    return http.post("processPaymentContract/addNewProcessPaymentContract",
        processPaymentContract)
}

//修改加工付款单
export const updateProcessPaymentContractApi = (processPaymentContract: processPaymentContractModel) => {
    return http.post("processPaymentContract/updateProcessPaymentContract",
        processPaymentContract)
}

//验证加工合同编号
export const checkProcessContractNoApi = (processContractNo: string) => {
    return http.get("processPaymentContract/checkProcessContractNo", {
        processContractNo: processContractNo,
    })
}

//财务审批通过
export const changeFinanceState = (id: number, financeStaff: string) => {
    return http.get("processPaymentContract/changeFinanceState", {
        id: id,
        financeStaff: financeStaff
    })
}

//董事会审批通过
export const changeDirectorState = (processPaymentContractId: number, userId: string) => {
    return http.get("processPaymentContract/changeDirectorState", {
        processPaymentContractId: processPaymentContractId,
        userId: userId
    })
}