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

//验证采购合同编号
export const checkPurchaseContractNoApi = (purchaseContractNo: string) => {
    return http.get("purchasePaymentContract/checkPurchaseContractNo", {
        purchaseContractNo: purchaseContractNo,
    })
}

