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

//验证海运单集装箱号
export const checkContainerNoApi = (containerNo: string) => {
    return http.get("shippingContract/checkContainerNo", {
        containerNo: containerNo,
    })
}