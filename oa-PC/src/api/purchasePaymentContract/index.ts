import http from "@/http";
import { purchasePaymentContractModel } from "./PurchasePaymentContractModel";

//分页获取采购付款单
export const getPurchasePaymentContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("purchasePaymentContract/getPurchasePaymentContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询采购付款单
export const searchPurchasePaymentContractApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("purchasePaymentContract/searchPurchasePaymentContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

// 删除单笔采购付款单
export const deleteOnePurchasePaymentContractApi = (id: number) => {
    return http.delete(`purchasePaymentContract/deleteOnePurchasePaymentContract/${id}`)
}

//新增采购付款单
export const addNewPurchasePaymentContractApi = (purchasePaymentContract: purchasePaymentContractModel) => {
    return http.post("purchasePaymentContract/addNewPurchasePaymentContract",
        purchasePaymentContract)
}

//修改采购付款单
export const updatePurchasePaymentContractApi = (purchasePaymentContract: purchasePaymentContractModel) => {
    return http.post("purchasePaymentContract/updatePurchasePaymentContract",
        purchasePaymentContract)
}

//验证采购合同编号
export const checkPurchaseContractNoApi = (purchaseContractNo: string) => {
    return http.get("purchasePaymentContract/checkPurchaseContractNo", {
        purchaseContractNo: purchaseContractNo,
    })
}

//财务审批通过
export const changeFinanceState = (id: number, financeStaff: string) => {
    return http.get("purchasePaymentContract/changeFinanceState", {
        id: id,
        financeStaff: financeStaff
    })
}

//董事会审批通过
export const changeDirectorState = (purchasePaymentContractId: number, userId: string) => {
    return http.get("purchasePaymentContract/changeDirectorState", {
        purchasePaymentContractId: purchasePaymentContractId,
        userId: userId
    })
}