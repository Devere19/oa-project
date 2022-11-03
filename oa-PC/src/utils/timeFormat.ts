/**
 * 转换yyyy-mm-dd hh:mm:ss
 * @param row 
 * @returns 
 */

export default function timeFormat(row: any) {
    let dateee = new Date(row.createTime).toJSON();
    let CTTOdate = new Date(new Date(dateee)).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '')
    return {
        CTTOdate
    }
}