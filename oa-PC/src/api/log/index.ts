import http from "@/http";
import { ListParm } from '@/api/log/LogModel'

//查询所有的日志
export const getListApi = (listParm: ListParm) => {
  return http.get("/api/log/getList", listParm)
}

//删除7天前的所有日志
export const deleteApi = () => {
  return http.delete("/api/log/delete")
}