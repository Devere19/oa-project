
import { ref } from "vue"


export default function useDetail() {


  //新增组件的ref属性
  const detailRef = ref<{ show: (logisticsContractNo: string, saleContractNo: string) => void }>()



  //详情
  const detailBtn = (id: string,logisticsContractNo:string ,saleContractNo: string) => {
    detailRef.value?.show(id, logisticsContractNo,saleContractNo)
  }


  return {
    detailRef,
    detailBtn,

  }
}