
import { AddRoleModel } from "@/api/role/RoleModel"
import { EditType } from "@/type/BaseEnum"
import { ref } from "vue"
import { deleteApi } from "@/api/role"
import { ElMessage } from "element-plus"
import { FuncList } from "@/type/baseType"
import useInstance from "@/hooks/useInstance"


export default function useRole(getList: FuncList) {

  const { global } = useInstance()

  //分配权限弹框ref属性
  const assignRoleRef = ref<{ show: (id: string, name: string) => void }>()
  
  //分配权限按钮
  const assignBtn = (row: AddRoleModel) => {
    assignRoleRef.value?.show(row.id, row.name)
  }

  //新增弹框的ref属性
  const addRef = ref<{ show: (type: string, raw?: AddRoleModel) => void }>()

  //新增：
  const addBtn = () => {
    addRef.value?.show(EditType.ADD)
  }

  //编辑
  const editBtn = (row: AddRoleModel) => {
    addRef.value?.show(EditType.EDIT, row)
  }

  //删除：
  const deleteBtn = async (row: AddRoleModel) => {
    const confirm = await global.$myconfirm('确定删除该数据吗？')
    if (confirm) {
      let res = await deleteApi(row.id)
      if (res && res.code == 200) {
        //信息提示
        ElMessage.success(res.msg)
        //刷新列表
        getList()
      }
    }
  }
  return {
    addBtn, editBtn, deleteBtn, addRef, assignBtn, assignRoleRef
  }
}