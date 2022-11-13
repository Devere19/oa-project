
export type logisticsPaymentContractModel = {
    id: any,
    logisticsContractNo: string,
    paymentCount: string,
}

export type logisticsPaymentDirectorModel = {
    id: any,
    logisticsPaymentContractId: string,
    userId: any,
    nickName: string,
    state: any
}