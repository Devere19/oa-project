/**
 * 转换yyyy-mm-dd hh:mm:ss
 * @param row 
 * @param column 
 * @returns 
 */
// 日期带时分秒时间转换
export const conversionDateTime = (row: any, column: any) => {

    let dateee = new Date(row[column.property]).toJSON();
    if (dateee != null) {

        return new Date(new Date(dateee)).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '')
    }
}

/**
 * 转换yyyy-mm-dd
 * @param row 
 * @param column 
 * @returns 
 */
// 日期不带时分秒时间转换
export const conversionDate = (row: any, column: any) => {
    const daterc = row[column.property]
    if (daterc != null) {
        var date = new Date(daterc);
        var year = date.getFullYear();
        /* 在日期格式中，月份是从0开始，11结束，因此要加0
         * 使用三元表达式在小于10的前面加0，以达到格式统一  如 09:11:05
         * */
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        // 拼接wwwwwwwwwwww5
        return year + "-" + month + "-" + day;
    }
}