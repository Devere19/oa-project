import http from "../../http";
import { AddLogisticsModel, ExportListParm, ListParm } from "./LogisticsModel";

//物流单列表(分页查询) 查询归档为1的数据
export const searchPigeonholeOneApi = (listParm: ListParm) => {
  return http.post("/api/logistics/list", listParm)
}


//物流单列表(分页查询) 查询归档为0的数据
export const searchPigeonholeZeroApi = (listParm: ListParm) => {
  return http.post("/api/logistics/searchPigeonholeZero", listParm)
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
export const getDetailLogistics = (id: string) => {
  return http.get(`/api/logistics/getDetailLogistics/${id}`)
}


//新增物流单和对应的详情单
export const addLogisticsApi = (parm: AddLogisticsModel) => {
  return http.post("/api/logistics/add", parm)
}


//导出excel传递参数
export const exportApi = (listParm: ExportListParm) => {
  return http.post("/api/logistics/exportListParm", listParm)
}

//修改物流单
export const updateLogisticsApi=(parm:AddLogisticsModel)=>{
  return http.post("/api/logistics/edit", parm)

}