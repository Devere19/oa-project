
// 批量删除类型
export type moreDeleteModel = {
    ids: string,
}

export type purchaseContractModel = {
    id: number
    purchaseContractNo: string
    supplierNo: string
    customerEnterpriseName: string
    ownCompanyName: string
    squeezeSeason: string
    inboundTime: string
    goodsName: string
    goodsCount: number
    goodsUnit: string
    goodsUnitPrice: number
    paymentAmount: number
    contractPhoto: string
    createTime: Date
    createBy: string
}

export type inboundDataModel = {
    factoryName: string
    inOutGoodsCount: string
}