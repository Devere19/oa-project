
// 批量删除类型
export type moreDeleteModel = {
    ids: string,
}

export type purchaseContractModel = {
    id: any
    purchaseContractNo: string
    customerEnterpriseName: string
    ownCompanyName: string
    squeezeSeason: string
    inboundTime: string
    goodsName: string
    goodsCount: any
    goodsUnit: string
    paymentAmount: any
    contractPhotoArray: any
    createTime: string
    createBy: string
}

export type inboundDataModel = {
    factoryName: string
    inboundGoodsCount: string
    goodsUnitPrice: string
}

export type PurchaseExportModel = {
    searchWord: string
    showPigeonhole: boolean
    startDate: any
    endDate: any
}