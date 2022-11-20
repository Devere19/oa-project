//定义客户类型
export type CustomerType = {
  value: string,
  label: string
}
export type SelectCustomer = {
  list: CustomerType[]
}

export type customerModel = {
  id: any
  customerEnterpriseName: string
  customerName: string
  customerPhone: string
  customerAddress: string
  createBy: string
  lastUpdateBy: string
}