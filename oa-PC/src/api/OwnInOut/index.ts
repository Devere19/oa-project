import http from "@/http";

export const OwnInOutDataApi = (inOutGoodsName: string) => {
    return http.get("OwnInOut/getOwnInOutData", {
        inOutGoodsName: inOutGoodsName,
    })
}