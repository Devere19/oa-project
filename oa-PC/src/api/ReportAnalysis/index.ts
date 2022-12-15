import http from "@/http";
import { IncomeSpendExportModel } from "./ReportAnalysisModel";

//获取图表收入支出数据
export const getChartIncomeSpendDataApi = (dataType: string, dataCompany: string, timeType: number, startDate: any, endDate: any) => {
    return http.get("finance/getChartIncomeSpendData", {
        dataType: dataType,
        dataCompany: dataCompany,
        timeType: timeType,
        startDate: startDate,
        endDate: endDate,
    })
}

//获取数值收入支出数据
export const getNumberIncomeSpendDataApi = (dataType: string, dataCompany: string) => {
    return http.get("finance/getNumberIncomeSpendData", {
        dataType: dataType,
        dataCompany: dataCompany,
    })
}

//获取收入支出细则数据
export const getDetailIncomeSpendDataApi = (dataType: string, dataCompany: string, timeType: number, startDate: any, endDate: any) => {
    return http.get("finance/getDetailIncomeSpendData", {
        dataType: dataType,
        dataCompany: dataCompany,
        timeType: timeType,
        startDate: startDate,
        endDate: endDate,
    })
}

// 获取采购付款单详情
export const getOnePurchasePaymentContractApi = (id: number) => {
    return http.get("finance/getOnePurchasePaymentContract", {
        id: id
    })
}

// 获取加工付款单详情
export const getOneProcessPaymentContractApi = (id: number) => {
    return http.get("finance/getOneProcessPaymentContract", {
        id: id
    })
}

// 获取物流付款单详情
export const getOneLogisticsPaymentContractApi = (id: number) => {
    return http.get("finance/getOneLogisticsPaymentContract", {
        id: id
    })
}

// 获取海运单详情
export const getOneShippingContractApi = (id: number) => {
    return http.get("finance/getOneShippingContract", {
        id: id
    })
}

//导出excel传递参数
export const sendExportParmApi = (incomeSpendExportModel: IncomeSpendExportModel) => {
    return http.post("/finance/sendExportParm", incomeSpendExportModel)
}