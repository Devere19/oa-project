
export type officeExpenseModel = {
    id: any,
    itemsList: string,
    expenses: any,
    time: string,
    createBy: string,
    lastUpdateBy: string
}

export type officeExpenseDirectorModel = {
    id: any,
    officeExpenseId: string,
    userId: any,
    nickName: string,
    state: any
}