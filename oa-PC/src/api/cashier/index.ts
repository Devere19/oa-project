import http from "@/http";
import { purchasePaymentModel, logisticsPaymentModel, shippingPaymentModel } from "./CashierModel";

//分页获取采购付款单
export const getCashierPurchasePaymentApi = (currentPage: number, pageSize: number) => {
    return http.get("cashier/getCashierPurchasePayment", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询采购付款单
export const searchCashierPurchasePaymentApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("cashier/searchCashierPurchasePayment", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

//上传采购付款单的付款数据
export const uploadCashierPurchasePaymentApi = (purchasePaymentContract: purchasePaymentModel) => {
    return http.post("cashier/uploadCashierPurchasePayment",
        purchasePaymentContract)
}

//分页获取物流付款单
export const getCashierLogisticsPaymentApi = (currentPage: number, pageSize: number) => {
    return http.get("cashier/getCashierLogisticsPayment", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询物流付款单
export const searchCashierLogisticsPaymentApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("cashier/searchCashierLogisticsPayment", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

//上传物流付款单的付款数据
export const uploadCashierLogisticsPaymentApi = (logisticsPaymentContract: logisticsPaymentModel) => {
    return http.post("cashier/uploadCashierLogisticsPayment",
        logisticsPaymentContract)
}

//分页获取海运单
export const getCashierShippingApi = (currentPage: number, pageSize: number) => {
    return http.get("cashier/getCashierShipping", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询海运单
export const searchCashierShippingApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("cashier/searchCashierShipping", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}

//上传海运单的付款数据
export const uploadCashierShippingApi = (shippingContract: shippingPaymentModel) => {
    return http.post("cashier/uploadCashierShipping",
        shippingContract)
}