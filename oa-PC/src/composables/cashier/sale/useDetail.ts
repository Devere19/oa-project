import { AddSaleModel } from "@/api/sale/SaleModel"
import { ref } from "vue"


export default function useDetail() {


  //新增组件的ref属性
  const detailRef = ref<{ show: (addModel: AddSaleModel) => void }>()




  //详情按钮
  const detailBtn = (addModel: AddSaleModel) => {
    detailRef.value?.show(addModel)
  }


  return {
    detailRef,
    detailBtn,

  }
}