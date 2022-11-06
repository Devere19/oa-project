import http from "../../http";
import { AddSaleModel, ListParm } from "./SaleModel";


//销售单列表(分页查询) 查询归档为1的数据
export const searchPigeonholeOneApi = (parm: ListParm) => {
  return http.get("/api/saleContract/list", parm)
}

//归档
export const changePigeonholeApi = (id: number) => {
  return http.put("/api/saleContract/changePigeonhole", id)
}

//销售单列表(分页查询) 查询归档为0的数据
export const searchPigeonholeZeroApi = (parm: ListParm) => {
  return http.get("/api/saleContract/searchPigeonholeZero", parm)
}

//删除 通过id删除
export const deleteByIdApi = (id: number) => {
  return http.delete(`/api/saleContract/deleteById/${id}`)

}

//获取客户表列表
export const getSelectApi = () => {
  return http.get("/api/customer/getSelect")
}


//新增销售单
export const addSaleContractApi = (parm: AddSaleModel) => {
  return http.post("/api/saleContract/add", parm)
}

//根据销售单拿到所有的物流信息的已出货量
export const getRemainingOutboundVolumeApi = (saleContractNo: string) => {
  return http.get(`/api/saleContract/getRemainingOutboundVolume/${saleContractNo}`)
}


//根据销售合同编号查到所有的物流详情表
export const getDetailSaleContract=(saleContractNo:string)=>{
  return http.get(`/api/saleContract/getDetailSaleContract/${saleContractNo}`)
}
