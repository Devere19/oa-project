import { ElMessage, ElMessageBox } from 'element-plus'

export default function myconFirm(text: string) {
  return new Promise((resovle, reject) => {
    ElMessageBox.confirm(
      text,
      '系统提示',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
    ).then(() => {
      //返回确定
      resovle(true)
    }).catch(() => {
      reject(false)
    })
  }).catch(() => {
    return false
  })
}