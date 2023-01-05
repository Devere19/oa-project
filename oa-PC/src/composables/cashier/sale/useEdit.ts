
import { FuncList } from "@/type/baseType"
import { ref } from "vue"


export default function useDetail(getList:FuncList) {


  //新增组件的ref属性
  const editRef = ref<{ show: (id:string) => void }>()




  //详情按钮
  const editBtn = (id:string) => {
    editRef.value?.show(id)
  }
  //刷新
  const refresh=()=>{
    getList()
  }

  const isEdit=(contractPhoto:string)=>{
    if(contractPhoto==null||contractPhoto==''){
      return false
    }else{
      return true
    }
  }


  return {
    editRef,
    editBtn,
    refresh,
    isEdit

  }
}