//定义菜单数据类型
export type MenuType = {
  editType: string,
  id: string | number,
  parentId: string | number,
  name: string,
  perms: string,
  url: string,
  type: string,
  icon: string,
  parentName: string,
  orderNum: string,
  open: boolean
}

//选中上级菜单数据类型
export type SelectNode = {
  parentId: string | number,
  parentName: string
}