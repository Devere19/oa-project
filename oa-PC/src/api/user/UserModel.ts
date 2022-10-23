//定义角色类型
export type RoleType = {
  value: string,
  label: string
}
export type SelectRole = {
  list: RoleType[]
}

//列表查询参数类型
export type ListParm = {
  phone: string,
  nickName: string,
  currentPage: number,
  pageSize: number,
  total: number
}

//用户数据类型
export type AddUserModel = {
  id: string,
  type: string,  //新增：0 编辑：1
  roleId: string,
  name: string,
  password: string,
  mobile: string,
  email: string,
  status: string,
  nickName: string
}