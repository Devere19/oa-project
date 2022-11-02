import { nextTick, onMounted, reactive, ref } from "vue";
import { ListParm } from '@/api/sale/SaleModel'
import { searchPigeonholeOneApi, searchPigeonholeZeroApi } from "@/api/sale";

export default function useTable() {

  //查询参数
  const listParm = reactive<ListParm>({
    saleContractNo: '',
    saleCompanyName: '',
    goodsName: '',
    squeezeSeason: '',
    currentPage: 1,
    pageSize: 10,
    total: 0
  })

  //表格数据
  const tableList = reactive({
    list: []
  })
  //默认归档为1的为true
  const isPigeonhole = ref<boolean>(true)

  //表格高度
  const tableHeight = ref(0)

  //查询归档为1的列表
  const getList = async () => {
    let res = await searchPigeonholeOneApi(listParm)
    if (res && res.code == 200) {
      //设置表格的数据
      console.log('销售单归档为1的表格数据', res.data)
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
      console.log('销售单归档为0的表格数据', res.data)
      tableList.list = res.data.records
      //设置分页总条数
      listParm.total = res.data.total
    }
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

  //分页查询 显示数量改变
  const sizeChange = (size: number) => {
    listParm.pageSize = size
    // getList()
    if (isPigeonhole.value) {
      //查询归档为1的列表
      getList()
    } else {
      getListZero()
    }
  }
  //分页查询 当前页数该百年
  const currentChange = (size: number) => {
    listParm.currentPage = size
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
    // getList()
    if (isPigeonhole.value) {
      //查询归档为1的列表
      getList()
    } else {
      getListZero()
    }
  }
  //重置
  const resetBtn = () => {
    listParm.goodsName = ''
    listParm.saleCompanyName = ''
    listParm.saleContractNo = ''
    listParm.squeezeSeason = ''
    // getList()
    if (isPigeonhole.value) {
      //查询归档为1的列表
      getList()
    } else {
      getListZero()
    }
  }

  //查看归档为0的数据
  const searchPigeonholeZero = async () => {
    isPigeonhole.value = !isPigeonhole.value
    if (isPigeonhole.value) {
      //查询归档为1的列表
      getList()
    } else {
      getListZero()
    }
  }

  onMounted(() => {
    refresh()
    nextTick(() => {
      tableHeight.value = window.innerHeight - 230
    })
  })

  return {
    listParm,
    tableList,
    tableHeight,
    refresh,
    getList,
    sizeChange,
    currentChange,
    searchBtn,
    resetBtn,
    searchPigeonholeZero,
    isPigeonhole
  }
}