import http from "@/http";

//获取商品数据
export const getGoodsNameDataApi = () => {
    return http.get("finance/getGoodsNameData")
}

//获取单价走势数据
export const getPriceTrendDataApi = (goodsName: string, startDate: Date, endDate: Date) => {
    return http.get("finance/getPriceTrendData", {
        goodsName: goodsName,
        startDate: startDate,
        endDate: endDate,
    })
}