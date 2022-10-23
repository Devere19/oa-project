import http from "../../http";
import { MenuType } from "./MenuModel";
//查询上级菜单
export const getParentApi = () => {
  return http.get("/api/menu/parent")
}

//查询所有菜单，包括按钮
export const getAllMenuApi = () => {
  return http.get("/api/menu/getAllMenu")
}

//新增
export const addApi = (parm: MenuType) => {
  return http.post("/api/menu", parm)
}

//列表
export const getListApi = () => {
  return http.get("/api/menu/list")
}

//编辑
export const editApi = (parm: MenuType) => {
  return http.put("/api/menu", parm)
}
//删除
export const deleteApi = (id: string | number) => {
  return http.delete(`/api/menu/${id}`)
}
//查询菜单树
export const findNavTreeApi = (userName: string) => {
  return http.get(`/api/menu/findNavTree/${userName}`);
}
