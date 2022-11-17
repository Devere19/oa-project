import { ListParm } from "@/api/role/RoleModel";
import { nextTick, onMounted, reactive, ref } from "vue";
import { getListApi } from "@/api/role";
export default function useTable() {

  //定义表格高度
  const tableHeight = ref(0)


  //定义表格数据
  const tableList = reactive({
    list: []
  })
  //列表参数
  const ListParm = reactive<ListParm>({
    roleName: '',
    pageSize: 10,
    currentPage: 1,
    total: 0
  })

  //列表
  const getList = async () => {
    let res = await getListApi(ListParm)a
    if (res && res.code == 200) {
      // console.log(res)
      //设置表格数据
      tableList.list = res.data.records
      //设置分页的总条数
      ListParm.total = res.data.total
    }
  }

  //刷新列表
  const refresh=()=>{
    getList()
  }

  //搜索
  const searchBtn = () => {
    getList()
  }

  //重置
  const resetBtn = () => {
    ListParm.roleName=''
    getList()
  }

  //页容量改变时出发
  const sizeChange = (val: number) => {
    ListParm.pageSize = val
    getList()
  }

  //页数改变时出发
  const currentChange = (val: number) => {
    ListParm.currentPage = val
    getList()
  }

  onMounted(() => {
    getList()
    nextTick(() => {
      tableHeight.value = window.innerHeight - 230
    })
  })
  return {
    ListParm,
    getList,
    searchBtn,
    resetBtn,
    tableList,
    sizeChange,
    currentChange,
    tableHeight,
    refresh
  }
}