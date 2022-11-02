import http from "../../http";
import { ListParm } from "./SaleModel";


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
export const deleteByIdApi=(id:number)=>{
  return http.delete(`/api/saleContract/deleteById/${id}`)

}