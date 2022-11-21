import http from "@/http";

export const getOwnWarehouseDataApi = (currentPage: number, pageSize: number) => {
    return http.get("ownWarehouse/getFPurchaseContractData", {
        current: currentPage,
        page: pageSize,
    })
}

export const searchOwnWarehouseDataApi = (currentPage: number, pageSize: number, searchWord: string) => {
    return http.get("ownWarehouse/searchOwnWarehouse", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
    })
}