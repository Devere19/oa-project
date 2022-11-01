import http from "@/http";

//分页获取采购单
export const getPurchaseContractDataApi = (currentPage: number, pageSize: number) => {
    console.log(currentPage, pageSize);
    return http.get("purchaseContract/getPurchaseContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询采购单
export const searchPurchaseContractApi = (currentPage: number, pageSize: number, searchWord: string) => {
    console.log(currentPage, pageSize);
    return http.get("purchaseContract/searchPurchaseContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord
    })
}