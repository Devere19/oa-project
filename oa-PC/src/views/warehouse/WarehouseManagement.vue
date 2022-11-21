<template>
  <div class="main" v-loading="loading">
    <div class="headerGroup">
      <el-button class="showPigeonholeButton" type="primary" @click="returnAllData" v-show="returnAll">返回全部数据</el-button>
      <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的存储货物名称"
                @keyup.enter="searchTableData">
        <template #append>
          <el-button :icon="Search" @click="searchTableData" />
        </template>
      </el-input>
    </div>
    <el-table ref="firstTableRef" class="purchaseContractTable" :data="firstTableData" style="width: 98%"
              border="true" highlight-current-row>
      <!-- 暂时隐藏index -->
      <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
      <el-table-column property="id" align="center" label="ID" />
      <el-table-column property="factoryName" label="仓库名称" align="center" width="120"></el-table-column>
      <el-table-column property="goodsName" align="center" label="存储货物名称" />
      <el-table-column property="goodsCount" align="center" label="存储货物库存量" />
      <el-table-column property="goodsUnit" align="center" label="存储货物单位" />

      <el-table-column property="createTime" :formatter="conversionDate" sortable align="center" label="创建时间" width="105" />
      <el-table-column property="createBy" align="center" label="创建者" />
      <el-table-column align="center" label="操作" width="200" fixed="right">
        <template #default="scope">
          <el-button :icon="MoreFilled" size="default" type="primary"
                     @click="openMordDetailDialog(scope.row)">详情
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="paginationGroup">
      <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[5, 10, 20, 50, 100]"
          :hide-on-single-page="false"
          :background="background"
          layout="total, sizes, prev, pager, next, jumper"
          :total=total
          @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
          @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
      />
    </div>

    <el-dialog v-model="detialDialogFlag" title="货物流水详情" width="50%" draggable center :before-close="closeAddDialog">
      <ul ref="addDialogTop" style="overflow: auto;height:400px;padding: 0;">
        <span class="title" style="line-height: 50px;">出入库详情:</span><br />
        <el-table ref="firstTableRef" class="purchaseContractTable"  style="width: 98%" :data="tableList.list"
                  border="true" highlight-current-row>
          <!-- 暂时隐藏index -->
          <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
          <el-table-column property="id" align="center" label="ID" />
          <el-table-column property="inOutContractNo" label="采购/销售合同编号" align="center" width="120"></el-table-column>
          <el-table-column property="inOutGoodsName" align="center" label="货物名称" />
          <el-table-column property="inOutType" align="center" label="出入库类型">
            <template #default="scope">
              {{ scope.row.inOutType == 0 ? "出库" : "入库" }}
            </template>
          </el-table-column>
          <el-table-column property="inOutGoodsCount" align="center" label="货物出入库数量" />
          <el-table-column property="inOutGoodsUnit" align="center" label="货物单位" />
          <el-table-column property="createTime" :formatter="conversionDate" sortable align="center" label="创建时间" width="105" />
          <el-table-column property="createBy" align="center" label="创建者" />
        </el-table>
      </ul>
      <template #footer>
                <span class="dialog-footer">
                    <el-button @click="closeAddDialog">关闭</el-button>
                </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import {Search} from "@element-plus/icons-vue";
import {getOwnWarehouseDataApi, searchOwnWarehouseDataApi} from '@/api/OwnWarehouse'
import {OwnInOutDataApi} from '@/api/OwnInOut'
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
import {onMounted, reactive, ref} from "vue";
import {ElMessage, FormInstance} from "element-plus";

const detialDialogFlag = ref(false)
const firstTableData = ref([])
const loading = ref(false)
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const searchData = ref("")
const returnAll = ref(false)
const addDialogTop = ref<any>()
const firstFormRef = ref<FormInstance>()
const contractExistFlag = ref(false)

//出库详情表格数据
const tableList = reactive({
  list: []
})

const OwnWarehouse = reactive({
    id:'',
  factoryName:'',
  goodsName:'',
  goodsCount:'',
  goodUnit:'',
  createTime:'',
  createBy:'',
})

// 搜索存储货物名称数据
const searchTableData = () => {
  if (searchData.value == null || searchData.value == '') {
    ElMessage({
      message: '请输入关键词再进行搜索！',
      type: 'warning',
      duration: 4000
    })
  } else {
    changeLoadingTrue();
    searchOwnWarehouseDataApi(currentPage.value, pageSize.value, searchData.value).then(res => {
      total.value = res.data.total;//总记录
      firstTableData.value = res.data.records;
      returnAll.value = true;
      changeLoadingFalse();
    })
  }
}

onMounted(() => {
  getTableData();
})

const openMordDetailDialog = (row:any) => {
  changeLoadingTrue();
  OwnInOutDataApi(row.goodsName).then(res => {
    // total.value = res.data.total;//总记录
    tableList.list = res.data;
    console.log(res.data);
    changeLoadingFalse();
  });
  detialDialogFlag.value = true


}

const changeLoadingTrue = () => {
  loading.value = true;
}

// 转变loading状态
const changeLoadingFalse = () => {
  loading.value = false;
}

//关闭窗口
const closeAddDialog = () => {
  detialDialogFlag.value = false;
  ReturnTop();
  firstFormRef.value?.resetFields();
  contractExistFlag.value = false;
}

const returnAllData = () => {
  getTableData();
  searchData.value = ""
  returnAll.value = false
}

// 新增窗口滑动回最顶端
const ReturnTop = () => {
  addDialogTop.value.scrollTop = 0;
}

//全部数据
const getTableData = () => {
  changeLoadingTrue();
  getOwnWarehouseDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    firstTableData.value = res.data.records;
    console.log(res.data.records);
    changeLoadingFalse();
  });
}
</script>

<style scoped>
.main{
  width: 100%;
}

.headerGroup{
  justify-content: center;
  display: flex;
  flex-direction: row;
  width: 100%;
}

.searchInput {
  margin: 1% 15%;
  align-self: center;
  width: 50%
}

.paginationGroup {
  margin-top: 1%;
  justify-content: center;
  display: flex;
  flex-direction: row;
}
.showPigeonholeButton{
  margin: 1%;
  align-self: center;
}
</style>