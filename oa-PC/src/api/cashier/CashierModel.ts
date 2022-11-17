

export type purchasePaymentModel = {
    id: any
    purchaseContractNo: string
    paymentTime: string
    paymentPhotoArray: any
}

export type logisticsPaymentModel = {
    id: any
    logisticsContractNo: string
    paymentTime: string
    paymentPhotoArray: any
}

export type shippingPaymentModel = {
    id: any
    shippingContractNo: string
    paymentTime: string
    paymentPhotoArray: any
}

export type SaleModel = {
    id: string
    revenueTime: string
    revenueAmount: string
    revenuePhoto: string
    revenuePhotoList: any,
    revenueBy:string
}