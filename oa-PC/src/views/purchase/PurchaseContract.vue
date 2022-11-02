<template>
  <div class="purchaseContract">
    <div class="headerGroup">
      <el-button class="showPigeonholeButton" type="info"
        @click="getPigeonholeData(showPigeonhole == false ? true : false)">
        {{ showPigeonhole == false ? "显示归档数据" : "显示非归档数据" }}
      </el-button>
      <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
        新增
      </el-button>
      <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的采购单信息">
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
      <el-table-column property="customerEnterpriseName" align="center" label="供货方公司名" />
      <el-table-column property="ownCompanyName" align="center" label="己方公司名" />
      <el-table-column property="squeezeSeason" align="center" label="榨季" />
      <el-table-column property="inboundTime" align="center" label="入库时间" />
      <el-table-column property="goodsName" align="center" label="采购货物名称" />
      <el-table-column property="goodsCount" align="center" label="采购货物数量" />
      <el-table-column property="goodsUnit" align="center" label="采购货物单位" />
      <el-table-column property="goodsUnitPrice" align="center" label="采购货物单价" />
      <el-table-column property="paymentAmount" align="center" label="采购总价" />
      <el-table-column property="contractPhoto" align="center" label="合同照片" />
      <el-table-column property="createTime" :formatter="CTTOdate" sortable align="center" label="创建时间" width="165" />
      <el-table-column property="createBy" align="center" label="创建者" />
      <!-- <el-table-column property="orderStatus" :formatter="tfChange" sortable align="center" label="订单状态"  />
      <el-table-column property="createTime" :formatter="CTTOdate" sortable align="center" label="创建时间"  />
      <el-table-column property="updateTime" :formatter="UTTOdate" sortable align="center" label="结束时间"  /> -->
      <el-table-column property="name" align="center" label="操作" width="300">
        <template #default="scope">
          <el-button :icon="MoreFilled" size="default" type="primary" @click="getSales(scope.row)">详情</el-button>
          <el-button :icon="scope.row.pigeonhole == 1 ? Hide : View" size="default"
            :type="scope.row.pigeonhole == 1 ? 'info' : 'success'" @click="changePigeonhole(scope.row)">{{
                scope.row.pigeonhole ==
                  1 ?
                  "归档" : "还原"
            }}</el-button>
          <el-button :icon="Delete" size="default" type="danger" @click="openOneDeleteDialog(scope.$index, scope.row)">
            删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="paginationGroup">
      <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
        :page-sizes="[5, 10, 20, 50, 100]" :background="background" layout="total, sizes, prev, pager, next, jumper"
        :total="total" @size-change="getTableData" @current-change="getTableData" />
    </div>
    <el-dialog v-model="addDialogFlag" title="新增采购单" width="50%" draggable center>
      <ul class="infinite-list" ref="top" style="overflow: auto;height:650px">
        <el-form label-position="right" label-width="180px" :model="NewPurchaseContractData" style="max-width: 65%">
          <!-- <el-form label-position="right" label-width="180px" :model="NewPurchaseContractData"
        style="max-width: 65%;height:600px"> -->
          <el-form-item label="采购合同编号" prop="purchaseContractNo">
            <el-input v-model="NewPurchaseContractData.purchaseContractNo" size="large" />
          </el-form-item>
          <el-form-item label="供货方公司名" prop="customerEnterpriseName">
            <el-select v-model="NewPurchaseContractData.customerEnterpriseName" placeholder="下拉选择" size="large">
              <el-option label="桂林骏泰" value="1"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="己方公司名" prop="customerEnterpriseName">
            <el-select v-model="NewPurchaseContractData.ownCompanyName" placeholder="下拉选择" size="large">
              <el-option label="广西永湘物流有限公司" value="广西永湘物流有限公司"></el-option>
              <el-option label="广西南宁锦泰行工贸有限公司" value="广西南宁锦泰行工贸有限公司"></el-option>
              <el-option label="广西丰沣顺国际物流有限公司" value="广西丰沣顺国际物流有限公司"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="榨季" prop="squeezeSeason">
            <el-input v-model="NewPurchaseContractData.squeezeSeason" size="large" />
          </el-form-item>
          <el-form-item label="入库时间" prop="inboundTime">
            <el-date-picker type="date" placeholder="即合同实际签订日期" v-model="NewPurchaseContractData.inboundTime"
              style="width: 100%;" value-format="yyyy.MM.dd" size="large"></el-date-picker>
          </el-form-item>
          <el-form-item label="采购货物名称" prop="goodsName">
            <el-input v-model="NewPurchaseContractData.goodsName" size="large" />
          </el-form-item>
          <el-form-item label="采购货物数量" prop="goodsCount">
            <el-input v-model="NewPurchaseContractData.goodsCount" size="large" />
          </el-form-item>
          <el-form-item label="采购货物单位" prop="goodsUnit">
            <el-select v-model="NewPurchaseContractData.goodsUnit" placeholder="下拉选择重量单位" size="large">
              <el-option label="吨" value="吨"></el-option>
              <el-option label="斤" value="斤"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="采购货物单价" prop="goodsUnitPrice">
            <el-input v-model="NewPurchaseContractData.goodsUnitPrice" size="large" />
          </el-form-item>
          <el-form-item label="采购总价" prop="paymentAmount">
            <el-input v-model="NewPurchaseContractData.paymentAmount" size="large" />
          </el-form-item>
          <el-form-item label="合同照片" prop="contractPhoto">
            <el-upload v-model:file-list="NewPurchaseContractData.contractPhoto"
              action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15" list-type="picture-card"
              :auto-upload="false" :on-preview="handlePictureCardPreview" :on-remove="handleRemove">
              <el-icon>
                <Plus />
              </el-icon>
            </el-upload>
          </el-form-item>
        </el-form>
      </ul>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="addNewPurchaseContract">
            确定
          </el-button>
          <el-button @click="addDialogFlag = false">取消</el-button>
        </span>
      </template>
    </el-dialog>
    <el-dialog v-model="oneDeleteDialogFlag" title="提示" width="30%" draggable center>
      <span>
        您确定要删除该笔采购单吗
      </span>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="oneDeletePurchaseContract">
            确定
          </el-button>
          <el-button @click="oneDeleteDialogFlag = false">取消</el-button>
        </span>
      </template>
    </el-dialog>
    <el-dialog v-model="moreDeleteDialogFlag" title="提示" width="30%" draggable center>
      <span>
        您确定要删除所选中的采购单吗
      </span>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="moreDeletePurchaseContract">
            确定
          </el-button>
          <el-button @click="moreDeleteDialogFlag = false">取消</el-button>
        </span>
      </template>
    </el-dialog>
    <el-dialog v-model="previewImageFlag">
      <img w-full :src="dialogImageUrl" alt="Preview Image" />
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile } from 'element-plus'
import { Delete, Search, MoreFilled, Hide, View } from "@element-plus/icons-vue";
// import type from 'element-plus'
import { getTPurchaseContractDataApi, getFPurchaseContractDataApi, searchPurchaseContractApi, deleteOnePurchaseContractApi, deleteMorePurchaseContractApi, setPurchaseContractPigeonholeApi } from '@/api/purchaseContract'


const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const background = ref(true)
const tableData = ref<PurchaseContract[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const oneDeleteDialogFlag = ref(false)
const moreDeleteDialogFlag = ref(false)
const choosePurchaseContractNo = ref(0)
const showPigeonhole = ref(false)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)

const multipleTableRef = ref<InstanceType<typeof ElTable>>()
const multipleSelection = ref<PurchaseContract[]>([])

const NewPurchaseContractData = reactive({
  purchaseContractNo: '',
  // supplier_no: 0,
  customerEnterpriseName: '',
  ownCompanyName: '',
  squeezeSeason: '',
  inboundTime: '',
  goodsName: '',
  goodsCount: '',
  goodsUnit: '',
  goodsUnitPrice: '',
  paymentAmount: '',
  contractPhoto: ''
})

interface PurchaseContract {
  id: number
  purchaseContractNo: string
  customerEnterpriseName: string
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
  getTPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    tableData.value = res.data.records;
  });
}

const getPigeonholeData = (flag: boolean) => {
  showPigeonhole.value = flag;
  if (flag == true) {
    getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
      total.value = res.data.total;//总记录
      tableData.value = res.data.records;
    });
  } else {
    getTableData();
  }
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

const openAddDialog = () => {
  addDialogFlag.value = true
}

const addNewPurchaseContract = () => {
  console.log("新增采购单");
}

const openOneDeleteDialog = (index: number, row: PurchaseContract) => {
  choosePurchaseContractNo.value = row.id;
  oneDeleteDialogFlag.value = true
}

const oneDeletePurchaseContract = () => {
  deleteOnePurchaseContractApi(choosePurchaseContractNo.value).then(res => {
    if (res.data == 1) {
      getTableData()
      oneDeleteDialogFlag.value = false
      ElMessage({
        message: '删除采购单成功！',
        type: 'success',
      })
    }
    else {
      ElMessage({
        message: '删除采购单失败！',
        type: 'error',
      })
    }
  })
}

const openMoreDeleteDialog = () => {
  moreDeleteDialogFlag.value = true
}

const moreDeletePurchaseContract = () => {
  let purchaseContractIds = new Array();
  multipleSelection.value.map((item) => {
    purchaseContractIds.push(item.id)
  });
  deleteMorePurchaseContractApi({ ids: JSON.stringify(purchaseContractIds) }).then(res => {
    if (res.data != 0) {
      getTableData()
      moreDeleteDialogFlag.value = false
      ElMessage({
        message: '批量删除采购单成功！',
        type: 'success',
      })
    }
    else {
      ElMessage({
        message: '批量删除采购单失败！',
        type: 'error',
      })
    }
  })
}

const changePigeonhole = (row) => {
  setPurchaseContractPigeonholeApi(row.id, row.pigeonhole).then(res => {
    if (res.data == 1) {
      if (showPigeonhole.value == false) {
        getTableData()
      } else {
        getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
          total.value = res.data.total;//总记录
          tableData.value = res.data.records;
        });
      }
      ElMessage({
        message: '修改状态成功！',
        type: 'success',
      })
    }
    else {
      ElMessage({
        message: '修改状态失败！',
        type: 'error',
      })
    }
  })
}

const handleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
  console.log(uploadFile, uploadFiles)
}

const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
  dialogImageUrl.value = uploadFile.url!
  previewImageFlag.value = true
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
  width: 100%;
}

.showPigeonholeButton {
  align-self: center;
  display: flex;
  float: left;
  margin-left: 1%;
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