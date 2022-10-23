// 角色数据类型
export type AddRoleModel = {
  type: string,  //新增：0 编辑：1
  id: string,
  name: string,
  remark: string  //备注
}

////列表查询参数类型
export type ListParm = {
  roleName: string,
  currentPage: number,
  pageSize: number,
  total: number 
}

//权限参数
export type AssignParm = {
  roleId:string,
  userId:string
}
//角色权限
export type SaveAssignParm = {
  id:string,
  list:Array<string>
}