import http from "@/http";
import { processContractModel } from "./ProcessContractModel";

//分页获取未归档加工单
export const getTProcessContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("processContract/getTProcessContractData", {
        current: currentPage,
        page: pageSize,
    })
}

//分页获取已归档加工单
export const getFProcessContractDataApi = (currentPage: number, pageSize: number) => {
    return http.get("processContract/getFProcessContractData", {
        current: currentPage,
        page: pageSize,
    })
}

// 分页查询加工单
export const searchProcessContractApi = (currentPage: number, pageSize: number, searchWord: string, showPigeonhole: boolean, startDate: any, endDate: any) => {
    return http.get("processContract/searchProcessContract", {
        current: currentPage,
        page: pageSize,
        searchWord: searchWord,
        showPigeonhole: showPigeonhole,
        startDate: startDate,
        endDate: endDate,
    })
}

// 删除单笔加工单
export const deleteOneProcessContractApi = (id: number) => {
    return http.delete(`processContract/deleteOneProcessContract/${id}`)
}

//修改加工单归档状态
export const setProcessContractPigeonholeApi = (id: number, pigeonhole: number) => {
    return http.get("processContract/setProcessContractPigeonhole", {
        id: id,
        pigeonhole: pigeonhole
    })
}

//新增加工单
export const addNewProcessContractApi = (processContract: processContractModel) => {
    return http.post("processContract/addNewProcessContract",
        processContract)
}

//修改加工单
export const updateProcessContractApi = (processContract: processContractModel) => {
    return http.post("processContract/updateProcessContract",
        processContract)
}

// 获取加工单详情
export const getProcessDetailApi = (processContractNo: string, goodsName: string) => {
    console.log(goodsName);
    return http.get("processContract/getProcessDetail",
        {
            processContractNo: processContractNo,
            goodsName: goodsName
        })
}