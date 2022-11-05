//列表查询参数类型
export type ListParm = {
  //合同编号
  saleContractNo: string,
  //销售方公司名
  saleCompanyName: string,
  //货物名称
  goodsName: string,
  //榨季
  squeezeSeason: string
  currentPage: number,
  pageSize: number,
  total: number
}

//销售数据类型
export type AddSaleModel = {
  id: string,
  saleContractNo: string,
  saleCustomerId: string,
  ownCompanyName: string,
  goodsName: string,
  goodsCount: string,
  goodsUnit: string,
  goodsUnitPrice: string,
  goodsTotalPrice: string,
  paymentMethod: string,
  transportMethod: string,
  contractPhoto: string,
  contractPhotoList: any,
  revenueAmount: string,
  revenuePhoto: string,
  revenueBy: string,
  pigeonhole: string,
  squeezeSeason: string,
  createBy: string,
  saleContractTime: string,
}
