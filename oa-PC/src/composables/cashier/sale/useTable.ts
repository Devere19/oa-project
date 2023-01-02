import { getCashierSaleContractApi } from "@/api/cashier"
import { ListParm } from "@/api/sale/SaleModel"
import { nextTick, onMounted, reactive, ref } from "vue"

export default function useTable() {


  //表格高度
  const tableHeight = ref(0)

  //表格数据
  const tableList = reactive({
    list: []
  })



  //列表参数
  const listParm = reactive<ListParm>({
    saleContractNo: '',
    saleCompanyName: '',
    goodsName: '',
    squeezeSeason: '',
    startTime:'',
    endTime:'',
    currentPage: 1,
    pageSize: 10,
    total: 0
  })
  //分页查询 显示数量改变
  const sizeChange = (size: number) => {
    listParm.pageSize = size
    getList()
  }
  //分页查询 当前页数该百年
  const currentChange = (size: number) => {
    listParm.currentPage = size
    getList()
  }

  const getList = async () => {
    let res = await getCashierSaleContractApi(listParm)
    if (res && res.code == 200) {
      //设置表格的数据
      console.log('归纳的销售单数据', res.data)
      tableList.list = res.data.records
      //设置分页总条数
      listParm.total = res.data.total
    }
  }
  //搜索
  const searchBtn = () => {
    getList()
  }
  //重置
  const resetBtn = () => {
    listParm.goodsName = ''
    listParm.saleCompanyName = ''
    listParm.saleContractNo = ''
    listParm.squeezeSeason = ''
    listParm.startTime = ''
    listParm.endTime = ''
    getList()
  }


  onMounted(() => {
    getList()
    nextTick(() => {
      tableHeight.value = window.innerHeight - 230
    })
  })


  return {
    listParm, tableHeight, tableList, sizeChange, currentChange, searchBtn, resetBtn, getList

  }
}