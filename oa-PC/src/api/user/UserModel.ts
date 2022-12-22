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
  roleId: string[],
  name: string,
  nickName: string
  age:string,
  mobile:string,
  identity:string,
  homeAddress:string,
  onboardingTime:string,
  departureTime:string,
  password:string,
  status:string,  //在职/离职
  salt:string
}