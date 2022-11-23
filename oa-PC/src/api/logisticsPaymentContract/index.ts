import http from "@/http";
import { logisticsPaymentContractModel } from "./LogisticsPaymentContractModel";

//分页获取采购付款单
export const getLogisticsPaymentContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("logisticsPaymentContract/getLogisticsPaymentContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询采购付款单
export const searchLogisticsPaymentContractApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("logisticsPaymentContract/searchLogisticsPaymentContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单笔采购付款单
export const deleteOneLogisticsPaymentContractApi = (id: number) => {
    return http.delete(`logisticsPaymentContract/deleteOneLogisticsPaymentContract/${id}`)
}

//新增采购付款单
export const addNewLogisticsPaymentContractApi = (logisticsPaymentContract: logisticsPaymentContractModel) => {
    return http.post("logisticsPaymentContract/addNewLogisticsPaymentContract",
        logisticsPaymentContract)
}

//验证采购合同编号
export const checkLogisticsContractNoApi = (logisticsContractNo: string) => {
    return http.get("logisticsPaymentContract/checkLogisticsContractNo", {
        logisticsContractNo: logisticsContractNo,
    })
}

//财务审批通过
export const changeFinanceState = (id: number,financeStaff:string) => {
    return http.get("logisticsPaymentContract/changeFinanceState", {
        id: id,
        financeStaff:financeStaff
    })
}

//董事会审批通过
export const changeDirectorState = (logisticsPaymentContractId:number,userId:string) => {
    return http.get("logisticsPaymentContract/changeDirectorState", {
        logisticsPaymentContractId: logisticsPaymentContractId,
        userId:userId
    })
}