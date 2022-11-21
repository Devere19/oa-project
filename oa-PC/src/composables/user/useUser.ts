import { AddUserModel } from "@/api/user/UserModel"
import { EditType } from "@/type/BaseEnum"
import { Edit } from "@element-plus/icons-vue"
import { ref } from "vue"
import { deleteApi } from "@/api/user"
import { FuncList } from "@/type/baseType"
import useInstance from "@/hooks/useInstance"
import { ElMessage } from "element-plus"

export default function useUser(getList: FuncList) {

  const { global } = useInstance()

  //新增组件的ref属性
  const addRef = ref<{ show: (type: string, row?: AddUserModel) => void }>()


  //新增
  const addBtn = () => {
    //父组件调用子组件的show方法
    addRef.value?.show(EditType.ADD)
  }
  //编辑
  const editBtn = (row: AddUserModel) => {
    //父组件调用子组件的show方法
    addRef.value?.show("1", row)
  }
  //删除
  const deleteBtn = async (row: AddUserModel) => {
    const confirm = await global.$myconfirm('确定删除该数据吗？')
    if (confirm) {
      let res = await deleteApi(row.id)
      if (res && res.code == 200) {
        ElMessage.success(res.msg)
        //刷新表格
        getList()
      } else {
        ElMessage.error(res.msg)
      }
    }
  }

  return {
    addBtn,
    editBtn,
    deleteBtn,
    addRef
  }
}