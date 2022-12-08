

export type shippingContractModel = {
    id: any,
    shippingContractNo: string,
    oldShippingContractNo: string,
    logisticsContractNo: string,
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
    onlyUpdatePhoto: any,
    createBy: string,
}

export type shippingDirectorModel = {
    id: any,
    shippingContractNo: string,
    userId: any,
    nickName: string,
    state: any
}
