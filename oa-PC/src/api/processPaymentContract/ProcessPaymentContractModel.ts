
export type processPaymentContractModel = {
    id: any,
    processContractNo: string,
    paymentMonth: string,
    paymentMonthPriceT: any,
    goodsCount: any,
    paymentCount: any,
}

export type processPaymentDirectorModel = {
    id: any,
    processPaymentContractId: string,
    userId: any,
    nickName: string,
    state: any
}