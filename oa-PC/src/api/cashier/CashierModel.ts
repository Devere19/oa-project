

export type purchasePaymentModel = {
    id: any
    purchaseContractNo: string
    paymentTime: string
    paymentPhotoArray: any
    cashier: string
}

export type processPaymentModel = {
    id: any
    processContractNo: string
    paymentTime: string
    paymentPhotoArray: any
    cashier: string
}

export type logisticsPaymentModel = {
    id: any
    logisticsContractNo: string
    paymentTime: string
    paymentPhotoArray: any
    cashier: string
}

export type shippingPaymentModel = {
    id: any
    shippingContractNo: string
    paymentTime: string
    paymentPhotoArray: any
    cashier: string
}

export type SaleModel = {
    id: string
    revenueTime: string
    revenueAmount: string
    revenuePhoto: string
    revenuePhotoList: any,
    revenueBy: string
}

export type officeExpenseModel = {
    id: any
    paymentTime: string
    paymentPhotoArray: any
    cashier: string
}