//列表查询参数类型
export type ListParm = {
  //物流单合同编号
  logisticsContractNo: string,
  //销售单合同编号
  saleContractNo: string,
  //榨季
  squeezeSeason: string
  startTime: string
  endTime: string
  currentPage: number,
  pageSize: number,
  total: number
}

//物流详情
export type LogisticsDetailList = {
  id: string,
  upperType:string,  //0：加工单  1：采购单
  logisticsContractNo: string,
  purchaseContractNo: string,
  goodsFactory: string,
  outboundTime: string,
  licensePlateNumber: string,
  goodsWeight: string,
  goodsUnit: string,
  unloadingLocation: string,
  unitPrice: string,
  createBy: string,
}


//新增物流单数据类型
export type AddLogisticsModel = {
  id: string,
  upperType:string,  //0:加工单   1：销售单
  logisticsContractNo: string,
  saleContractNo: string,
  totalWeight: string,
  goodsUnit: string,
  freight: string,
  contractPhoto: string,
  contractPhotoList: any,
  logisticsContractTime: string,
  squeezeSeason: string,
  createBy: string,
  relationPaymentExistState:string,
  relationPaymentAuditState:string,
  relationShippingExistState:string,
  relationShippingAuditState:string,
  logisticsDetailList: LogisticsDetailList[]
}


//列表查询参数类型
export type ExportListParm = {
  //物流单合同编号
  logisticsContractNo: string,
  //销售单合同编号
  saleContractNo: string,
  //榨季
  squeezeSeason: string
  startTime: string
  endTime: string
  //是否归档 0归档  1未归档
  isPigeonhole: string
}