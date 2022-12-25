import { changePigeonholeApi, deleteByIdApi } from "@/api/sale/index";
import useInstance from "@/hooks/useInstance";
import {AddSaleModel } from "@/api/sale/SaleModel";
import { FuncList } from "@/type/baseType";
import { ElMessage } from "element-plus";
import { EditType } from "@/type/BaseEnum"
import { ref } from "vue";

export default function useSale(refresh: FuncList) {

  const { global } = useInstance()

  //新增组件的ref属性
  const addRef = ref<{ show: () => void }>()

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

  //新增
  const addBtn = () => {
    addRef.value?.show()
  }



  return {
    changePigeonhole,
    deleteBtn,
    addBtn,
    addRef,
  }
}