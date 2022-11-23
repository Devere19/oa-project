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
  //开始时间
  startTime: string
  //结束时间
  endTime: string
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
  revenuePhotoList: any,
  revenueBy: string,
  pigeonhole: string,
  squeezeSeason: string,
  createBy: string,
  saleContractTime: string,
}

//列表查询参数类型
export type ExportListParm = {
  //合同编号
  saleContractNo: string,
  //销售方公司名
  saleCompanyName: string,
  //货物名称
  goodsName: string,
  //榨季
  squeezeSeason: string
  //开始时间
  startTime: string
  //结束时间
  endTime: string
  //是否归档 0归档  1未归档
  isPigeonhole: string
}