
export type purchasePaymentContractModel = {
    id: any,
    purchaseContractNo: string,
    paymentCount: string,
}

export type purchasePaymentDirectorModel = {
    id: any,
    purchasePaymentContractId: string,
    userId: any,
    nickName: string,
    state: any
}