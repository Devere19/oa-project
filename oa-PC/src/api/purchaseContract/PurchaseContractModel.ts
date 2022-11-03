
// 批量删除类型
export type moreDeleteModel = {
    ids: string,
}

export type purchaseContractModel = {
    id: any
    purchaseContractNo: string
    supplierNo: string
    customerEnterpriseName: string
    ownCompanyName: string
    squeezeSeason: string
    inboundTime: string
    goodsName: string
    goodsCount: any
    goodsUnit: string
    goodsUnitPrice: any
    paymentAmount: any
    contractPhotoArray: any
    createTime: string
    createBy: string
}

export type inboundDataModel = {
    factoryName: string
    inOutGoodsCount: string
}