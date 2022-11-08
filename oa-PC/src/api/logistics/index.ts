import http from "../../http";
import { AddLogisticsModel, ListParm } from "./LogisticsModel";

//物流单列表(分页查询) 查询归档为1的数据
export const searchPigeonholeOneApi = (parm: ListParm) => {
  return http.get("/api/logistics/list", parm)
}


//物流单列表(分页查询) 查询归档为0的数据
export const searchPigeonholeZeroApi = (parm: ListParm) => {
  return http.get("/api/logistics/searchPigeonholeZero", parm)
}

//归档
export const changePigeonholeApi = (id: number) => {
  return http.put("/api/logistics/changePigeonhole", id)
}

//删除 通过id删除
export const deleteByIdApi = (id: number) => {
  return http.delete(`/api/logistics/deleteById/${id}`)

}

//根据物流合同编号查到所有的物流详情表
export const getDetailLogistics=(logisticsContractNo:string)=>{
  return http.get(`/api/logistics/getDetailLogistics/${logisticsContractNo}`)
}


//新增物流单和对应的详情单
export const addLogisticsApi = (parm: AddLogisticsModel) => {
  return http.post("/api/logistics/add", parm)
}