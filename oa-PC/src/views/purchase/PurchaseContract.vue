<template>
  <div class="purchaseContract">
    <div class="headerGroup">
      <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的订单信息">
        <template #append>
          <el-button :icon="Search" @click="searchTableData" />
        </template>
      </el-input>
      <el-button v-show="multipleSelection?.[0] != null" class="moreDeleteButton" type="danger"
        @click="openMoreDeleteDialog">批量删除
      </el-button>
      <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
      </el-button>
    </div>
    <el-table ref="multipleTableRef" class="purchaseContractTable" :data="tableData" style="width: 98%" border="true"
      highlight-current-row @selection-change="handleSelectionChange">
      <el-table-column type="selection" align="center" width="50%" />
      <el-table-column type="index" align="center" label="ID" width="50%" />
      <el-table-column label="采购合同编号" align="center">
        <template #default="scope">{{ scope.row.purchaseContractNo }}</template>
      </el-table-column>
      <el-table-column property="supplier" align="center" label="供货方公司名" />
      <el-table-column property="ownCompanyName" align="center" label="己方公司名" />
      <el-table-column property="squeezeSeason" align="center" label="榨季" />
      <el-table-column property="inboundTime" align="center" label="入库时间" />
      <el-table-column property="goodsName" align="center" label="采购货物名称" />
      <el-table-column property="goodsCount" align="center" label="采购货物数量" />
      <el-table-column property="goodsUnit" align="center" label="采购货物单位" />
      <el-table-column property="goodsUnitPrice" align="center" label="采购货物单价" />
      <el-table-column property="paymentAmount" align="center" label="采购总价" />
      <el-table-column property="contractPhoto" align="center" label="合同照片" />
      <el-table-column property="createTime" :formatter="CTTOdate" sortable align="center" label="创建时间" />
      <el-table-column property="createBy" align="center" label="创建者" />
      <!-- <el-table-column property="orderStatus" :formatter="tfChange" sortable align="center" label="订单状态"  />
      <el-table-column property="createTime" :formatter="CTTOdate" sortable align="center" label="创建时间"  />
      <el-table-column property="updateTime" :formatter="UTTOdate" sortable align="center" label="结束时间"  /> -->
      <el-table-column property="name" align="center" label="操作">
        <template #default="scope">
          <el-button size="default" type="text" @click="getSales(scope.row)">查看详情</el-button>
          <el-button size="default" type="text" @click="openOneDeleteDialog(scope.$index, scope.row)"
            style="color: red">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="paginationGroup">
      <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
        :page-sizes="[5, 10, 20, 50, 100]" :background="background" layout="total, sizes, prev, pager, next, jumper"
        :total="total" @size-change="getTableData" @current-change="getTableData" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'
import { Search } from '@element-plus/icons-vue'
import { ElTable } from 'element-plus'
import { ElMessage } from 'element-plus'
import { getPurchaseContractDataApi, searchPurchaseContractApi } from '@/api/purchaseContract'


const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const background = ref(true)
const tableData = ref<PurchaseContract[]>([])
const returnAll = ref(false)

const multipleTableRef = ref<InstanceType<typeof ElTable>>()
const multipleSelection = ref<PurchaseContract[]>([])

interface PurchaseContract {
  purchaseContractNo: string
  supplier: string
  ownCompanyName: string
  squeezeSeason: string
  inboundTime: Date
  goodsName: string
  goodsCount: number
  goodsUnit: string
  goodsUnitPrice: number
  paymentAmount: number
  contractPhoto: string
  createTime: Date
  createBy: string
}

onMounted(() => {
  getTableData();
})


const getTableData = () => {
  getPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    tableData.value = res.data.records;
  });
}

const CTTOdate = (row) => {
  let dateee = new Date(row.createTime).toJSON();
  return new Date(new Date(dateee)).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '')
}


const searchTableData = () => {
  searchPurchaseContractApi(currentPage.value, pageSize.value, searchData.value).then(res => {
    total.value = res.data.total;//总记录
    tableData.value = res.data.records;
    returnAll.value = true;
  })
}

const returnAllData = () => {
  getTableData();
  returnAll.value = false
}

const handleSelectionChange = (val: PurchaseContract[]) => {
  multipleSelection.value = val;
}
</script>

<style scoped>
.purchaseContract {
  width: 100%
}

.headerGroup {
  justify-content: center;
  display: flex;
  flex-direction: row;
}

.searchInput {
  margin: 1% 15%;
  align-self: center;
  width: 70%
}

.moreDeleteButton {
  align-self: center;
  display: flex;
  float: right;
  margin-right: 1%;
}

.purchaseContractTable {
  margin: auto;
}

.paginationGroup {
  margin-top: 1%;
  justify-content: center;
  display: flex;
  flex-direction: row;
}
</style>