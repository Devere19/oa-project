import http from "@/http";

//获取收入支出数据
export const getIncomeSpendDataApi = (dataType: string, dataCompany: string, startDate: any, endDate: any) => {
    return http.get("finance/getIncomeSpendData", {
        dataType: dataType,
        dataCompany: dataCompany,
        startDate: startDate,
        endDate: endDate,
    })
}