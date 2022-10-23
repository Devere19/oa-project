import { reactive } from "vue";
import { DialogModel } from "../type/baseType";

export default function useDialog() {
  //定义弹框属性
  const dialog = reactive<DialogModel>({
    visible: false,
    title: '标题',
    height: 250,
    width: 630
  })
  //展示
  const onShow = () => {
    dialog.visible = true
  }
  //关闭
  const onClose = () => {
    dialog.visible = false
  }

  const onConfirm = () => {
    dialog.visible = false
  }

  return {
    dialog,
    onShow,
    onClose,
    onConfirm
  }
}