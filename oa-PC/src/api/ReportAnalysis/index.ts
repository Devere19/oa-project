import http from "@/http";

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

//获取收入支出数据
export const getNumberIncomeSpendDataApi = (dataType: string, dataCompany: string) => {
    return http.get("finance/getNumberIncomeSpendData", {
        dataType: dataType,
        dataCompany: dataCompany,
    })
}