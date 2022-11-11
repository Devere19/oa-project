import exp from "constants"

export type shippingContractModel = {
    id: any,
    shippingContractNo: string,
    logtisticsContractNo: string,
    principal: string,
    packingTime: string,
    packingLocation: string,
    unpackingFactory: string,
    containerNo: string,
    sealNo: string,
    tallyClerk: string,
    tallyClerkPrice: any,
    departureFleet: string,
    departurePrice: any,
    carrierCompanyName: string,
    carrierCompanyPrice: any,
    destinationPortFleet: string,
    destinationPortPrice: any,
    expenses: any,
    contractPhotoArray: any,
    financeStaff: string,
    financeState: any,
    shippingDirector: any,
    cashier: string,
    paymentCount: any,
    paymentTime: any,
    paymentPhotoArray: any,
    createTime: string,
    createBy: string,
}

export type shippingDirectorModel = {
    id: any,
    shippingContractNo: string,
    userId: any,
    nickName: string,
    state: any
}
