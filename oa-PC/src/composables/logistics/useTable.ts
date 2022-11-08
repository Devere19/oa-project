import { searchPigeonholeOneApi, searchPigeonholeZeroApi } from "@/api/logistics"
import { ListParm } from "@/api/logistics/LogisticsModel"
import { nextTick, onMounted, reactive, ref } from "vue"

export default function useTable() {


  //表格数据
  const tableList = reactive({
    list: []
  })
  //默认归档为1的为true
  const isPigeonhole = ref<boolean>(true)

  //表格高度
  const tableHeight = ref(0)


  //查询参数
  const listParm = reactive<ListParm>({
    logisticsContractNo: '',
    saleContractNo: '',
    squeezeSeason: '',
    currentPage: 1,
    pageSize: 10,
    total: 0
  })

  //查询归档为1的列表
  const getList = async () => {
    let res = await searchPigeonholeOneApi(listParm)
    if (res && res.code == 200) {
      //设置表格的数据
      console.log('物流单归档为1的表格数据', res.data)
      tableList.list = res.data.records
      //设置分页总条数
      listParm.total = res.data.total
    }
  }

  //查询归档为0的列表
  const getListZero = async () => {
    let res = await searchPigeonholeZeroApi(listParm)
    if (res && res.code == 200) {
      //设置表格的数据
      console.log('物流单归档为0的表格数据', res.data)
      tableList.list = res.data.records
      //设置分页总条数
      listParm.total = res.data.total
    }
  }

  //查看归档为0的数据
  const searchPigeonholeZero = async () => {
    isPigeonhole.value = !isPigeonhole.value
    refresh()
  }

  //刷新列表
  const refresh = () => {
    // getList()
    if (isPigeonhole.value) {
      //查询归档为1的列表
      getList()
    } else {
      getListZero()
    }
  }

  //搜索
  const searchBtn = () => {
    refresh()
  }

  //重置
  const resetBtn = () => {
    listParm.logisticsContractNo = ''
    listParm.saleContractNo = ''
    listParm.squeezeSeason = ''
    refresh()
  }



  onMounted(() => {
    refresh()
    nextTick(() => {
      tableHeight.value = window.innerHeight - 230
    })
  })



  return {
    listParm, searchBtn, resetBtn, tableList, tableHeight, isPigeonhole, refresh, searchPigeonholeZero
  }
}