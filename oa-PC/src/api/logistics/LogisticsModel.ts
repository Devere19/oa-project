//列表查询参数类型
export type ListParm = {
  //物流单合同编号
  logisticsContractNo: string,
  //销售单合同编号
  saleContractNo: string,
  //榨季
  squeezeSeason: string

  currentPage: number,
  pageSize: number,
  total: number
}

//物流详情
export type LogisticsDetailList = {
  id: string,
  logisticsContractNo: string,
  purchaseContractNo: string,
  goodsFactory: string,
  outboundTime: string,
  licensePlateNumber: string,
  goodsWeight: string,
  goodsUnit: string,
  unloadingLocation: string,
  unitPrice: string,
  createBy: string
}


//新增物流单数据类型
export type AddLogisticsModel = {
  id: string,
  logisticsContractNo: string,
  saleContractNo: string,
  totalWeight: string,
  goodsUnit: string,
  freight: string,
  contractPhoto: string,
  contractPhotoList: any,
  logisticContractTime: string,
  squeezeSeason: string,
  createBy: string,
  logisticsDetailList: LogisticsDetailList[]
}