import http from "../../http";
import { AddSaleModel, ListParm ,ExportListParm} from "./SaleModel";


//销售单列表(分页查询) 查询归档为1的数据
export const searchPigeonholeOneApi = (listParm: ListParm) => {
  return http.post("/api/saleContract/list", listParm)
}

//归档
export const changePigeonholeApi = (id: number) => {
  return http.put("/api/saleContract/changePigeonhole", id)
}

//销售单列表(分页查询) 查询归档为0的数据
export const searchPigeonholeZeroApi = (listParm: ListParm) => {
  return http.post("/api/saleContract/searchPigeonholeZero", listParm)
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

//修改销售单
export const editSaleContractApi=(parm:AddSaleModel)=>{
  return http.put("/api/saleContract/edit",parm)
}

//根据销售单拿到所有的物流信息的已出货量
export const getRemainingOutboundVolumeApi = (id: string) => {
  return http.get(`/api/saleContract/getRemainingOutboundVolume/${id}`)
}


//根据销售合同编号查到所有的物流详情表
export const getDetailSaleContract = (id: string) => {
  return http.get(`/api/saleContract/getDetailSaleContract/${id}`)
}

//导出excel传递参数
export const exportApi = (listParm: ExportListParm) => {
  return http.post("/api/saleContract/exportListParm", listParm)
}
