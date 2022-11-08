import { changePigeonholeApi, deleteByIdApi } from "@/api/logistics"
import { FuncList } from "@/type/baseType"
import { ElMessage } from "element-plus"
import useInstance from "@/hooks/useInstance"
import { ref } from "vue"



export default function useLogistics(refresh: FuncList) {

  //新增组件的ref属性
  const addRef = ref<{ show: () => void }>()


  const { global } = useInstance()

  //新增
  const addBtn = () => {
    addRef.value?.show()
  }

  //修改归档状态
  const changePigeonhole = async (id: number) => {
    let res = await changePigeonholeApi(id)
    if (res && res.code == 200) {
      ElMessage.success(res.msg)
      refresh()
    } else {
      ElMessage.error(res.msg)
    }
  }

  //删除
  const deleteBtn = async (id: number) => {
    const confirm = await global.$myconfirm('确定删除该数据吗？')
    if (confirm) {
      let res = await deleteByIdApi(id)
      if (res && res.code == 200) {
        ElMessage.success(res.msg)
        refresh()
      } else {
        ElMessage.error(res.msg)
      }
    }
  }




  return {
    changePigeonhole, deleteBtn, addRef, addBtn
  }

}