<template>
  <div class="purchaseContract" v-loading="loading">
    <div class="headerGroup">
      <el-button class="showPigeonholeButton" type="info"
        @click="changePigeonholeData(showPigeonhole == false ? true : false)">
        {{ showPigeonhole == false ? "显示归档数据" : "显示原始数据" }}
      </el-button>
      <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
        新增
      </el-button>
      <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的采购单信息">
        <template #append>
          <el-button :icon="Search" @click="searchTableData" />
        </template>
      </el-input>
      <el-button v-show="firstSelection?.[0] != null" class="moreDeleteButton" type="danger"
        @click="openMoreDeleteDialog">批量删除
      </el-button>
      <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
      </el-button>
    </div>
    <el-table ref="firstTableRef" class="purchaseContractTable" :data="firstTableData" style="width: 98%" border="true"
      highlight-current-row @selection-change="handleSelectionChange">
      <!-- 暂时隐藏批量删除功能 -->
      <!-- <el-table-column type="selection" align="center" width="50%" /> -->
      <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
      <el-table-column label="采购合同编号" align="center" width="120">
        <template #default="scope">{{ scope.row.purchaseContractNo }}</template>
      </el-table-column>
      <el-table-column property="customerEnterpriseName" align="center" label="供货方公司名" />
      <el-table-column property="ownCompanyName" align="center" label="己方公司名" width="140" />
      <el-table-column property="squeezeSeason" align="center" label="榨季" />
      <el-table-column property="inboundTime" :formatter="conversionDate" align="center" label="入库时间" width="105" />
      <el-table-column property="goodsName" align="center" label="采购货物名称" />
      <el-table-column property="goodsCount" align="center" label="采购货物数量" />
      <el-table-column property="goodsUnit" align="center" label="采购货物单位" />
      <el-table-column property="goodsUnitPrice" align="center" label="采购货物单价" />
      <el-table-column property="paymentAmount" align="center" label="采购总价" />
      <el-table-column align="center" label="合同照片" width="130">
        <template #default="scope">
          <el-image style="width: 100px; height: 100px"
            :src="scope.row.contractPhoto == '' ? null : scope.row.contractPhoto"
            :preview-src-list="scope.row.contractPhotoArray" fit="cover" preview-teleported="true" />
        </template>
      </el-table-column>
      <el-table-column property="createTime" :formatter="conversionDateTime" sortable align="center" label="创建时间"
        width="105" />
      <el-table-column property="createBy" align="center" label="创建者" />
      <el-table-column property="name" align="center" label="操作" width="290" fixed="right">
        <template #default="scope">
          <el-button :icon="MoreFilled" size="default" type="primary" @click="openMordDetailDialog(scope.row)">详情
          </el-button>
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
        :total="total" @size-change="showPigeonhole == false ? getTTableData : getFTableData"
        @current-change="showPigeonhole == false ? getTTableData : getFTableData" />
    </div>
    <el-dialog v-model="addDialogFlag" title="新增采购单" width="50%" draggable center :before-close="closeAddDialog">
      <ul ref="addDialogTop" style="overflow: auto;height:600px">
        <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="180px"
          :model="NewPurchaseContractData" style="max-width: 65%">
          <!-- <el-form label-position="right" label-width="180px" :model="NewPurchaseContractData"
        style="max-width: 65%;height:600px"> -->
          <el-form-item label="采购合同编号" prop="purchaseContractNo">
            <el-input v-model="NewPurchaseContractData.purchaseContractNo" size="large" />
          </el-form-item>
          <el-form-item label="供货方公司名" prop="customerEnterpriseName">
            <el-select v-model="NewPurchaseContractData.customerEnterpriseName" placeholder="下拉选择" size="large">
              <el-option v-for="item in customerData.list" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
          <el-form-item label="己方公司名" prop="ownCompanyName">
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
              style="width: 100%;" value-format="YYYY-MM-DD" size="large"></el-date-picker>
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
          <div v-for="(item, index) in NewPurchaseContractData.inboundData" label-position="right" label-width="200px">
            <el-form-item>
              <el-tag size="large" hit>{{ "入库单" + (index + 1) }}</el-tag>
            </el-form-item>
            <el-form-item :prop="'inboundData.' + index + '.factoryName'" label="厂名" :rules="[
            { required: true, trigger: ['change'] }]">
              <el-input v-model="item.factoryName" size="large" />
            </el-form-item>
            <el-form-item :prop="'inboundData.' + index + '.inboundGoodsCount'" label="入库数量" :rules="[
            { required: true, trigger: ['change'] }]">
              <el-input v-model="item.inboundGoodsCount" size="large" />
              <el-button v-show="index != 0" @click.prevent="removeInboundItem(item)">删除</el-button>
            </el-form-item>
          </div>
          <el-form-item label="">
            <el-button type="warning" icon="Plus" @click="addInboundItem">添加入库单</el-button>
          </el-form-item>
          <el-form-item label="采购货物单价" prop="goodsUnitPrice">
            <el-input v-model="NewPurchaseContractData.goodsUnitPrice" size="large" />
          </el-form-item>
          <el-form-item label="采购总价" prop="paymentAmount">
            <el-input v-model="NewPurchaseContractData.paymentAmount" size="large" />
          </el-form-item>
          <el-form-item label="合同照片">
            <el-upload v-model:file-list="PhotoData" action="http://localhost:9000/addContractPhoto"
              list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
              :on-success="handlePhotoSuccess">
              <el-icon>
                <Plus />
              </el-icon>
            </el-upload>
          </el-form-item>
        </el-form>
      </ul>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="sendNewPurchaseContract(firstFormRef)">
            确定
          </el-button>
          <el-button @click="closeAddDialog">取消</el-button>
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
      <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" preview-teleported="true" />
    </el-dialog>
    <el-dialog v-model="moreDetailDialogFlag" title="采购单详情" width="75%" draggable center
      :before-close="closeMoreDetailDialog">
      <div>
        <el-row justify="center">
          <el-col :span="6" class="moreDetailTitle">
            采购合同编号：
          </el-col>
          <el-col :span="6" class="moreDetailContent">
            {{ PurchaseContractDetail.purchaseContractNo }}
          </el-col>
        </el-row>
        <el-row justify="center">
          <el-col :span="4" class="moreDetailTitle">
            供货方公司名：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.customerEnterpriseName }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            己方公司名&nbsp;&nbsp;&nbsp;：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.ownCompanyName }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            采购货物名称：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.goodsName }}
          </el-col>
        </el-row>
        <el-row justify="center">
          <el-col :span="4" class="moreDetailTitle">
            采购货物数量：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.goodsCount }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            采购货物单位：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.goodsUnit }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            采购货物单价：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.goodsUnitPrice }}
          </el-col>
        </el-row>
        <el-row justify="center">
          <el-col :span="4" class="moreDetailTitle">
            采购总价：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.paymentAmount }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            榨季：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.squeezeSeason }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            入库时间：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.inboundTime }}
          </el-col>
        </el-row>
      </div>
      <div>
        <el-row justify="center">
          <el-col :span="10">
            <el-table ref="secondTableRef" class="contractDetailTable" :data="secondTableData" style="width: 99%"
              border="true" highlight-current-row>
              <el-table-column property="factoryName" align="center" label="厂名" />
              <el-table-column property="inOutGoodsCount" align="center" label="入库数量" />
              <el-table-column property="currentGoodsCount" align="center" label="当前库存量" />
              <el-table-column property="goodsUnit" align="center" label="重量单位" />
              <el-table-column property="outboundDetailInfos" align="center" label="出库详情" fixed="right">
                <template #default="scope">
                  <el-button :icon="MoreFilled" size="default" type="primary" @click="moreOutboundDetail(scope.row)">
                    详情
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-col>
          <el-col :span="14">
            <el-table ref="thirdTableRef" class="contractDetailTable" :data="thirdTableData" style="width: 99%"
              border="true" highlight-current-row>
              <el-table-column property="saleContractNo" align="center" label="销售合同编号" />
              <el-table-column property="totalWeight" align="center" label="出库总量" />
              <el-table-column property="logisticsContractNo" align="center" label="运输合同编号" />
              <el-table-column property="licensePlateNumber" align="center" label="车牌" />
              <el-table-column property="goodsWeight" align="center" label="车载货量" />
              <el-table-column property="goodsUnit" align="center" label="重量单位" />
              <el-table-column property="outboundTime" align="center" label="出库日期" />
            </el-table>
          </el-col>
        </el-row>
      </div>
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules } from 'element-plus'
import { Delete, Search, MoreFilled, Hide, View } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime } from "@/utils/timeFormat"
// import type from 'element-plus'
import { deletePhotoApi } from '@/api/handlePhoto'
import { getSelectApi } from "@/api/sale/index"
import { SelectCustomer } from "@/api/customer/CustomerModel"
import { purchaseContractModel, inboundDataModel } from '@/api/purchaseContract/PurchaseContractModel';
import {
  getTPurchaseContractDataApi, getFPurchaseContractDataApi, searchPurchaseContractApi,
  deleteOnePurchaseContractApi, deleteMorePurchaseContractApi, setPurchaseContractPigeonholeApi,
  addNewPurchaseContractApi, getPurchaseDetail
} from '@/api/purchaseContract'


const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const background = ref(true)
const firstTableData = ref<purchaseContractModel[]>([])
const secondTableData = ref<purchaseContractModel[]>([])
const thirdTableData = ref<purchaseContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const oneDeleteDialogFlag = ref(false)
const moreDeleteDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const choosePurchaseContractNo = ref(0)
const showPigeonhole = ref(false)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const PhotoData = ref<UploadUserFile[]>([])
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()

const firstTableRef = ref<InstanceType<typeof ElTable>>()
const secondTableRef = ref<InstanceType<typeof ElTable>>()
const thirdTableRef = ref<InstanceType<typeof ElTable>>()
const firstSelection = ref<purchaseContractModel[]>([])

// 新增
const NewPurchaseContractData = reactive({
  id: '',
  purchaseContractNo: '',
  supplierNo: '',
  customerEnterpriseName: '',
  ownCompanyName: '',
  squeezeSeason: '',
  inboundTime: '',
  goodsName: '',
  goodsCount: '',
  goodsUnit: '',
  inboundData: reactive<inboundDataModel[]>([
    {
      factoryName: '',
      inboundGoodsCount: ''
    }
  ]),
  goodsUnitPrice: '',
  paymentAmount: '',
  contractPhotoArray: reactive<string[]>([]),
  createTime: '',
  createBy: ''
})

// 详情
const PurchaseContractDetail = reactive({
  purchaseContractNo: '',
  customerEnterpriseName: '',
  ownCompanyName: '',
  squeezeSeason: '',
  inboundTime: '',
  goodsName: '',
  goodsCount: '',
  goodsUnit: '',
  goodsUnitPrice: '',
  paymentAmount: '',
})

//表单校验规则1
const firstRules = reactive<FormRules>({
  purchaseContractNo: [
    { required: true, trigger: ['change'] }
  ],
  customerEnterpriseName: [
    { required: true, trigger: ['change'] }
  ],
  ownCompanyName: [
    { required: true, trigger: ['change'] }
  ],
  squeezeSeason: [
    { required: true, trigger: ['change'] }
  ],
  inboundTime: [
    { required: true, trigger: ['change'] }
  ],
  goodsName: [
    { required: true, trigger: ['change'] }
  ],
  goodsCount: [
    { required: true, trigger: ['change'] }
  ],
  goodsUnit: [
    { required: true, trigger: ['change'] }
  ],
  goodsUnitPrice: [
    { required: true, trigger: ['change'] }
  ],
  paymentAmount: [
    { required: true, trigger: ['change'] }
  ],
})

//表单校验规则2
const secondRules = reactive<FormRules>({
  factoryName: [
    { required: true, trigger: ['blur'] }
  ],
  inboundGoodsCount: [
    { required: true, trigger: ['blur'] }
  ],
})



//定义客户列表数据  label存公司名称  value存客户表id
const customerData = reactive<SelectCustomer>({
  list: []
})

onMounted(() => {
  getTTableData();
  getSelectApi().then(res => {
    customerData.list = res.data;
  })
})

// 获取显示数据
const getTTableData = () => {
  changeLoading();
  getTPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    firstTableData.value = res.data.records;
    changeLoading();
  });
}

// 获取隐藏数据
const getFTableData = () => {
  changeLoading();
  getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    firstTableData.value = res.data.records;
    changeLoading();
  });
}

// 切换归档或非归档数据
const changePigeonholeData = (flag: boolean) => {
  showPigeonhole.value = flag;
  if (flag == true) {
    getFTableData();
  } else {
    getTTableData();
  }
}


// 搜索数据
const searchTableData = () => {
  changeLoading();
  searchPurchaseContractApi(currentPage.value, pageSize.value, searchData.value, showPigeonhole.value).then(res => {
    total.value = res.data.total;//总记录
    firstTableData.value = res.data.records;
    returnAll.value = true;
    changeLoading();
  })
}

// 搜索后，回到全部数据
const returnAllData = () => {
  if (showPigeonhole.value == false) {
    getTTableData();
  } else {
    getFTableData();
  }
  returnAll.value = false
}

// 处理多选变化
const handleSelectionChange = (val: purchaseContractModel[]) => {
  firstSelection.value = val;
}

// 打开新增采购单窗口
const openAddDialog = () => {
  addDialogFlag.value = true
}

// 发送新增采购单请求
const sendNewPurchaseContract = async (formEl1: FormInstance | undefined) => {
  if (!formEl1) return
  await formEl1.validate((valid, fields) => {
    if (valid) {
      changeLoading();
      console.log(NewPurchaseContractData);
      addNewPurchaseContractApi(NewPurchaseContractData).then(res => {
        if (res.data == 1) {
          if (showPigeonhole.value == false) {
            getTTableData();
          } else {
            getFTableData();
          }
          addDialogFlag.value = false
          ElMessage({
            message: '新增采购单成功！',
            type: 'success',
          })
          PhotoData.value = [];
          NewPurchaseContractData.contractPhotoArray = [];
          changeLoading();
        }
        else {
          ElMessage({
            message: '删除采购单失败！',
            type: 'error',
          })
          changeLoading();
        }
      })
    } else {
      ElMessage({
        message: '表单验证未通过，请检测！',
        type: 'error',
      })
    }
  })
}

// 打开采购单详情窗口
const openMordDetailDialog = async (row: any) => {
  moreDetailDialogFlag.value = true
  const daterc = row.inboundTime
  if (daterc != null) {
    var date = new Date(daterc);
    var year = date.getFullYear();
    /* 在日期格式中，月份是从0开始，11结束，因此要加0
     * 使用三元表达式在小于10的前面加0，以达到格式统一  如 09:11:05
     * */
    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
    // 拼接
    PurchaseContractDetail.inboundTime = year + "-" + month + "-" + day;
  }
  PurchaseContractDetail.purchaseContractNo = row.purchaseContractNo
  PurchaseContractDetail.customerEnterpriseName = row.customerEnterpriseName
  PurchaseContractDetail.ownCompanyName = row.ownCompanyName
  PurchaseContractDetail.squeezeSeason = row.squeezeSeason
  PurchaseContractDetail.goodsName = row.goodsName
  PurchaseContractDetail.goodsCount = row.goodsCount
  PurchaseContractDetail.goodsUnit = row.goodsUnit
  PurchaseContractDetail.goodsUnitPrice = row.goodsUnitPrice
  PurchaseContractDetail.paymentAmount = row.paymentAmount
  await getPurchaseDetail(row.purchaseContractNo, row.goodsName).then(res => {
    secondTableData.value = res.data;
  })
}

const moreOutboundDetail = (row: any) => {
  thirdTableData.value = row.outboundDetailInfos;
}

const closeMoreDetailDialog = () => {
  moreDetailDialogFlag.value = false;
  secondTableData.value = [];
  thirdTableData.value = [];
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: purchaseContractModel) => {
  choosePurchaseContractNo.value = row.id;
  oneDeleteDialogFlag.value = true
}

// 发送单个删除请求
const oneDeletePurchaseContract = () => {
  changeLoading();
  deleteOnePurchaseContractApi(choosePurchaseContractNo.value).then(res => {
    changeLoading();
    if (res.data == 1) {
      if (showPigeonhole.value == false) {
        getTTableData();
      } else {
        getFTableData();
      }
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

// 打开多选删除提示窗口
const openMoreDeleteDialog = () => {
  moreDeleteDialogFlag.value = true
}

// 发送多选删除请求
const moreDeletePurchaseContract = () => {
  let purchaseContractIds = new Array();
  firstSelection.value.map((item) => {
    purchaseContractIds.push(item.id)
  });
  deleteMorePurchaseContractApi({ ids: JSON.stringify(purchaseContractIds) }).then(res => {
    if (res.data != 0) {
      getTTableData()
      moreDeleteDialogFlag.value = false
      returnAll.value = true
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

// 修改数据的是否归档状态
const changePigeonhole = (row: any) => {
  changeLoading();
  setPurchaseContractPigeonholeApi(row.id, row.pigeonhole).then(res => {
    changeLoading();
    if (res.data == 1) {
      if (showPigeonhole.value == false) {
        getTTableData()
      } else {
        getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
          total.value = res.data.total;//总记录
          firstTableData.value = res.data.records;
        });
      }
      returnAll.value = false;
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

// 添加新入厂单
const addInboundItem = () => {
  NewPurchaseContractData.inboundData.push({
    factoryName: '',
    inboundGoodsCount: '',
  })
}

// 删除入厂单
const removeInboundItem = (item: inboundDataModel) => {
  const index = NewPurchaseContractData.inboundData.indexOf(item)
  if (index !== -1) {
    NewPurchaseContractData.inboundData.splice(index, 1)
  }
}

// 照片移除后发送请求后台删除照片
const handleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
  console.log(uploadFile, uploadFiles);
  NewPurchaseContractData.contractPhotoArray.splice(NewPurchaseContractData.contractPhotoArray.indexOf(uploadFile.response.data), 1);
  console.log("移出照片数据组");
  deletePhotoApi(uploadFile.response.data);
}

// 处理照片预览
const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
  dialogImageUrl.value = uploadFile.url!
  previewImageFlag.value = true

}

// 上传照片成功后加入数组
const handlePhotoSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
  if (response.code == 200) {
    NewPurchaseContractData.contractPhotoArray.push(response.data);
    console.log(NewPurchaseContractData.contractPhotoArray);
    console.log("加入照片数据组");
  }
}

// 转变loading状态
const changeLoading = () => {
  loading.value = !loading.value;
}

// 关闭新增窗口
const closeAddDialog = () => {
  addDialogFlag.value = false;
  ReturnTop();
  firstFormRef.value?.resetFields();
  NewPurchaseContractData.inboundData = [
    {
      factoryName: '',
      inboundGoodsCount: ''
    }
  ];
  PhotoData.value = [];
  if (NewPurchaseContractData.contractPhotoArray.length != 0) {
    NewPurchaseContractData.contractPhotoArray.map((item) => {
      deletePhotoApi(item);
    });
    NewPurchaseContractData.contractPhotoArray = [];
  }
}

// 新增窗口滑动回最顶端
const ReturnTop = () => {
  addDialogTop.value.scrollTop = 0;
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

.moreDetailTitle {
  text-align: right;
  font-size: 15px;
  margin-bottom: 5px;
  font-weight: bolder;
}

.moreDetailContent {
  font-size: 15px;
}
</style>