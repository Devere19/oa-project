import http from "@/http";
import { moreDeleteModel, purchaseContractModel } from "./PurchaseContractModel";

//分页获取未归档采购单
export const getTPurchaseContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("purchaseContract/getTPurchaseContractData", {
        current: currentPage,
        page: pageSize,
    })
}

//分页获取已归档采购单
export const getFPurchaseContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("purchaseContract/getFPurchaseContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询采购单
export const searchPurchaseContractApi = (currentPage: number, pageSize: number, searchWord: string, showPigeonhole: boolean) => {
    return http.get("purchaseContract/searchPurchaseContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
        showPigeonhole: showPigeonhole,
    })
}

// 删除单笔采购单
export const deleteOnePurchaseContractApi = (id: number) => {
    return http.delete(`purchaseContract/deleteOnePurchaseContract/${id}`)
}

// 删除多笔采购单
export const deleteMorePurchaseContractApi = (pram: moreDeleteModel) => {
    return http.post("purchaseContract/deleteMorePurchaseContract", pram)
}

//修改采购单归档状态
export const setPurchaseContractPigeonholeApi = (id: number, pigeonhole: number) => {
    return http.get("purchaseContract/setPurchaseContractPigeonhole", {
        id: id,
        pigeonhole: pigeonhole
    })
}

//新增采购单
export const addNewPurchaseContractApi = (purchaseContract: purchaseContractModel) => {
    return http.post("purchaseContract/addNewPurchaseContract",
        purchaseContract)
}

// 获取采购单详情
export const getPurchaseDetail = (purchaseContractNo: string, goodsName: string) => {
    console.log(goodsName);
    return http.get("purchaseContract/getPurchaseDetail",
        {
            purchaseContractNo: purchaseContractNo,
            goodsName: goodsName
        })
}