
// 批量删除类型
export type moreDeleteModel = {
    ids: string,
}

export type purchaseContractModel = {
    id: any
    purchaseContractNo: string
    oldPurchaseContractNo: string
    customerEnterpriseName: string
    ownCompanyName: string
    squeezeSeason: string
    inboundTime: string
    inboundFactoryS: any
    goodsName: string
    goodsCount: any
    goodsUnit: string
    paymentAmount: any
    contractPhotoArray: any
    onlyUpdatePhoto: any
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