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
      <!-- <el-date-picker v-model="choosedDay" value-format="YYYY-MM-DD" type="daterange" :disabled-date="disabledDate"
        unlink-panels range-separator="To" start-placeholder="开始日期" end-placeholder="结束日期" size="large"
        @change="changeDay" style="margin: auto 1%;" /> -->
      <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的采购单信息"
        @keyup.enter="searchTableData">
        <template #append>
          <el-button :icon="Search" @click="searchTableData" />
        </template>
      </el-input>
      <!-- <el-button v-show="firstSelection?.[0] != null" class="moreDeleteButton" type="danger"
        @click="openMoreDeleteDialog">批量删除
      </el-button> -->
      <el-button class="moreDeleteButton" :icon="Download" type="success" @click="exportExcel">导出
      </el-button>
      <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
      </el-button>
    </div>
    <el-row justify="center">
      <el-col span="24">
        <el-date-picker v-model="choosedDay" value-format="YYYY-MM-DD" type="daterange" :disabled-date="disabledDate"
          unlink-panels range-separator="To" start-placeholder="开始日期" end-placeholder="结束日期" size="large"
          @change="changeDay" style="margin: 1% 0% 2% 0%;" />
      </el-col>
    </el-row>
    <el-table ref="firstTableRef" class="purchaseContractTable" :data="firstTableData" style="width: 98%" border="true"
      highlight-current-row @selection-change="handleSelectionChange">
      <!-- 暂时隐藏批量删除功能 -->
      <!-- <el-table-column type="selection" align="center" width="50%" /> -->
      <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
      <el-table-column label="采购合同编号" align="center" width="120">
        <template #default="scope">{{ scope.row.purchaseContractNo }}</template>
      </el-table-column>
      <el-table-column property="customerEnterpriseName" align="center" label="供货方公司名" width="140" />
      <el-table-column property="ownCompanyName" align="center" label="己方公司名" width="140" />
      <el-table-column property="squeezeSeason" align="center" label="榨季" />
      <el-table-column property="inboundTime" :formatter="conversionDate" align="center" label="入库时间" width="105" />
      <el-table-column property="goodsName" align="center" label="采购货物名称" />
      <el-table-column property="goodsCount" align="center" label="采购货物数量" />
      <el-table-column property="goodsUnit" align="center" label="采购货物单位" />
      <el-table-column property="goodsUnitPrice" align="center" label="采购货物单价(斤)" />
      <el-table-column property="paymentAmount" align="center" label="采购总价" />
      <el-table-column property="unpaidAmount" align="center" label="未结清金额" />
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
      <el-table-column align="center" label="操作" width="400" fixed="right">
        <template #default="scope">
          <el-button :icon="MoreFilled" size="default" type="primary" @click="openMordDetailDialog(scope.row)">详情
          </el-button>
          <el-button :icon="Money" size="default" type="success" :disabled="scope.row.unpaidAmount <= 0"
            @click="openAddPaymentDialog(scope.row)">付款
          </el-button>
          <el-button :icon="scope.row.pigeonhole == 1 ? Hide : View" size="default"
            :type="scope.row.pigeonhole == 1 ? 'info' : 'success'" @click="changePigeonhole(scope.row)">{{
                scope.row.pigeonhole ==
                  1 ?
                  "归档" : "还原"
            }}</el-button>
          <el-button :icon="Delete" size="default" type="danger"
            :disabled="scope.row.paymentAmount != scope.row.unpaidAmount"
            @click="openOneDeleteDialog(scope.$index, scope.row)">
            删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="paginationGroup">
      <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
        :page-sizes="[5, 10, 20, 50, 100]" :background="background" layout="total, sizes, prev, pager, next, jumper"
        :total="total"
        @size-change="showPigeonhole == false ? (searchData == null || searchData == '' ? getTTableData() : searchTableData()) : (searchData == null || searchData == '' ? getFTableData() : searchTableData())"
        @current-change="showPigeonhole == false ? (searchData == null || searchData == '' ? getTTableData() : searchTableData()) : (searchData == null || searchData == '' ? getFTableData() : searchTableData())" />
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
              :disabled-date="disabledDate" style="width: 100%;" value-format="YYYY-MM-DD" size="large">
            </el-date-picker>
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
              <el-input v-model="item.factoryName" size="large" @change="changeOwnFlag" />
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
            <el-input v-model="NewPurchaseContractData.goodsUnitPrice" placeholder="仅需填写所选重量单位的采购单价" size="large" />
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
            采购货物单价(斤)：
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
            未结清金额：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.unpaidAmount }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            榨季：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.squeezeSeason }}
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="4" class="moreDetailTitle">
            入库时间：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.inboundTime }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            创建者：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.createBy }}
          </el-col>
          <el-col :span="4" class="moreDetailTitle">
            创建时间：
          </el-col>
          <el-col :span="4" class="moreDetailContent">
            {{ PurchaseContractDetail.createTime }}
          </el-col>
        </el-row>
      </div>
      <div>
        <el-row justify="center">
          <el-col :span="10">
            <el-table ref="secondTableRef" class="contractDetailTable" :data="secondTableData" style="width: 99%;"
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
            <el-table ref="thirdTableRef" class="contractDetailTable" :data="thirdTableData" style="width: 99%;"
              border="true" highlight-current-row>
              <el-table-column property="saleContractNo" align="center" width="120" label="销售合同编号" />
              <el-table-column property="totalWeight" align="center" label="出库总量" />
              <el-table-column property="logisticsContractNo" align="center" width="120" label="运输合同编号" />
              <el-table-column property="licensePlateNumber" align="center" label="车牌" />
              <el-table-column property="goodsWeight" align="center" label="车载货量" />
              <el-table-column property="goodsUnit" align="center" label="重量单位" />
              <el-table-column property="outboundTime" :formatter="conversionDate" align="center" label="出库日期" />
            </el-table>
          </el-col>
        </el-row>
      </div>
    </el-dialog>
    <el-dialog v-model="addPaymentDialogFlag" title="新增采购付款单" width="40%" draggable center
      :before-close="closeAddPaymentDialog">
      <ul ref="addPaymentDialogTop" style="overflow: auto;height:120px;padding: 0;">
        <el-form ref="secondFormRef" :rules="secondRules" label-position="right" label-width="120px"
          :model="NewPurchasePaymentContractData" style="max-width: 98%;">
          <el-row justify="center">
            <el-col :span="16">
              <el-form-item label="采购合同编号" prop="purchaseContractNo">
                <el-input v-model="NewPurchasePaymentContractData.purchaseContractNo" size="large" disabled />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row justify="center">
            <el-col :span="16">
              <el-form-item label="本次付款金额" prop="paymentCount">
                <el-input v-model="NewPurchasePaymentContractData.paymentCount" size="large" />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </ul>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="sendNewPurchasePaymentContract(secondFormRef)">
            确定
          </el-button>
          <el-button @click="closeAddPaymentDialog">取消</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElTable, ElMessage, ElMessageBox, UploadProps, UploadUserFile, FormInstance, FormRules } from 'element-plus'
import { Delete, Search, MoreFilled, Hide, View, Money, Download } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
import { deletePhotoApi } from '@/api/handlePhoto'
import { getSelectApi } from "@/api/sale/index"
import { SelectCustomer } from "@/api/customer/CustomerModel"
import { purchaseContractModel, inboundDataModel, PurchaseExportModel } from '@/api/purchaseContract/PurchaseContractModel';
import {
  getTPurchaseContractDataApi, getFPurchaseContractDataApi, searchPurchaseContractApi,
  deleteOnePurchaseContractApi, deleteMorePurchaseContractApi, setPurchaseContractPigeonholeApi,
  addNewPurchaseContractApi, getPurchaseDetailApi, sendExportParmApi
} from '@/api/purchaseContract'
import { addNewPurchasePaymentContractApi } from '@/api/purchasePaymentContract'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<purchaseContractModel[]>([])
const secondTableData = ref([])
const thirdTableData = ref([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const addPaymentDialogFlag = ref(false)
const moreDeleteDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const choosePurchaseContractNo = ref(0)
const showPigeonhole = ref(false)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const PhotoData = ref<UploadUserFile[]>([])
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const secondFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()
const addPaymentDialogTop = ref<any>()
const ownFlag = ref(false)
const choosedDay = ref<Date[]>([]);

const loginUserName = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()
const secondTableRef = ref<InstanceType<typeof ElTable>>()
const thirdTableRef = ref<InstanceType<typeof ElTable>>()
const firstSelection = ref<purchaseContractModel[]>([])

// 新增采购单
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
  unpaidAmount: '',
  createTime: '',
  createBy: ''
})

// 新增采购付款单
const NewPurchasePaymentContractData = reactive({
  id: '',
  purchaseContractNo: '',
  paymentCount: '',
  createBy: ''
})

const exportListParm = reactive<PurchaseExportModel>({
  searchWord: '',
  showPigeonhole: false,
  startDate: null,
  endDate: null
})

// NewPurchaseContractData.paymentAmount = computed(() => {
//   const temp = String(Number(NewPurchaseContractData.goodsCount) * Number(NewPurchaseContractData.goodsUnitPrice))
//   return temp
// });

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
  purchaseContractNo: [
    { required: true, trigger: ['change'] }
  ],
  paymentCount: [
    { required: true, trigger: ['change'] }
  ],
})

const disabledDate = (time: Date) => {
  return time.getTime() > Date.now()
}

//定义客户列表数据  label存公司名称  value存客户表id
const customerData = reactive<SelectCustomer>({
  list: []
})

onMounted(() => {
  getTTableData();

  console.log(choosedDay.value);
  console.log(choosedDay.value.length);

  loginUserName.value = userNickNameStore.user.nickName;
  getSelectApi().then(res => {
    customerData.list = res.data;
  })
})

// 获取显示数据
const getTTableData = () => {
  changeLoadingTrue();
  getTPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    firstTableData.value = res.data.records;
    changeLoadingFalse();
  });
}

// 获取隐藏数据
const getFTableData = () => {
  changeLoadingTrue();
  getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    firstTableData.value = res.data.records;
    changeLoadingFalse();
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

// 响应标签1日期的修改
const changeDay = () => {
  console.log(choosedDay.value);
}

// 搜索数据
const searchTableData = () => {
  if (searchData.value != '' || choosedDay.value.length != 0) {
    changeLoadingTrue();
    searchPurchaseContractApi(currentPage.value, pageSize.value, searchData.value, showPigeonhole.value, choosedDay.value != null ? choosedDay.value[0] : null, choosedDay.value != null ? choosedDay.value[1] : null).then(res => {
      total.value = res.data.total;//总记录
      firstTableData.value = res.data.records;
      returnAll.value = true;
      changeLoadingFalse();
    })
  } else {
    ElMessage({
      message: '请输入关键词或选择某个时间段再进行搜索！',
      type: 'warning',
      duration: 4000
    })
  }
}

// 搜索后，回到全部数据
const returnAllData = () => {
  if (showPigeonhole.value == false) {
    getTTableData();
  } else {
    getFTableData();
  }
  searchData.value = ""
  choosedDay.value = []
  returnAll.value = false
}

//导出表格
const exportExcel = () => {
  exportListParm.searchWord = searchData.value
  exportListParm.showPigeonhole = showPigeonhole.value
  exportListParm.startDate = choosedDay.value != null ? choosedDay.value[0] : null
  exportListParm.endDate = choosedDay.value != null ? choosedDay.value[1] : null
  sendExportParmApi(exportListParm).then(res => {
    if (res.code == 200) {
      const abtn = document.createElement("a");
      abtn.href = "http://localhost:9000/purchaseContract/purchaseExportExcel"
      abtn.click();
    }
  })
}

// 处理多选变化
const handleSelectionChange = (val: purchaseContractModel[]) => {
  firstSelection.value = val;
}

// 打开新增采购单窗口
const openAddDialog = () => {
  addDialogFlag.value = true
}

// 打开新增采购付款单窗口
const openAddPaymentDialog = (row: any) => {
  NewPurchasePaymentContractData.purchaseContractNo = row.purchaseContractNo
  addPaymentDialogFlag.value = true
}

// 发送新增采购单请求
const sendNewPurchaseContract = async (formEl1: FormInstance | undefined) => {
  if (!formEl1) return
  await formEl1.validate((valid, fields) => {
    if (valid) {
      let total = 0;
      NewPurchaseContractData.inboundData.map(item => {
        total = total + Number(item.inboundGoodsCount)
      })
      if (ownFlag.value != true) {
        if (total == Number(NewPurchaseContractData.goodsCount)) {
          changeLoadingTrue();
          NewPurchaseContractData.createBy = loginUserName.value;
          console.log(NewPurchaseContractData);
          addNewPurchaseContractApi(NewPurchaseContractData).then(res => {
            changeLoadingFalse();
            if (res.data == 1) {
              ElMessage({
                message: '新增采购单成功！',
                type: 'success',
              })
              if (showPigeonhole.value == false) {
                getTTableData();
              } else {
                getFTableData();
              }
              addDialogFlag.value = false;
              ReturnTop();
              firstFormRef.value?.resetFields();
              PhotoData.value = [];
              NewPurchaseContractData.contractPhotoArray = [];
              NewPurchaseContractData.inboundData = [{
                factoryName: '',
                inboundGoodsCount: ''
              }]
            }
            else {
              ElMessage({
                message: '新增采购单失败！',
                type: 'error',
                duration: 4000
              })
            }
          })
        } else {
          ElMessage({
            message: '入库货物总量与所填采购货物数量不符！',
            type: 'error',
            duration: 4000
          })
        }
      } else {
        ElMessage({
          message: '入库厂名不能为自家仓库！',
          type: 'error',
          duration: 4000
        })
      }
    } else {
      ElMessage({
        message: '表单验证未通过，请检查！',
        type: 'error',
        duration: 4000
      })
    }
  })
}


// 发送新增采购付款单请求
const sendNewPurchasePaymentContract = async (formEl1: FormInstance | undefined) => {
  if (!formEl1) return
  await formEl1.validate((valid, fields) => {
    if (valid) {
      changeLoadingTrue();
      NewPurchasePaymentContractData.createBy = loginUserName.value;
      console.log(NewPurchasePaymentContractData);
      addNewPurchasePaymentContractApi(NewPurchasePaymentContractData).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
          ElMessage({
            message: '新增采购付款单成功！',
            type: 'success',
          })
          if (showPigeonhole.value == false) {
            getTTableData();
          } else {
            getFTableData();
          }
          addPaymentDialogFlag.value = false;
          ReturnPaymentTop();
          secondFormRef.value?.resetFields();
        }
        else {
          ElMessage({
            message: '新增采购付款单失败！',
            type: 'error',
            duration: 4000
          })
        }
      })
    } else {
      ElMessage({
        message: '表单验证未通过，请检查！',
        type: 'error',
        duration: 4000
      })
    }
  })
}


// 关闭新增采购单窗口
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

// 关闭新增采购付款单窗口
const closeAddPaymentDialog = () => {
  addPaymentDialogFlag.value = false;
  ReturnPaymentTop();
  secondFormRef.value?.resetFields();
}

// 新增采购单窗口滑动回最顶端
const ReturnTop = () => {
  addDialogTop.value.scrollTop = 0;
}

// 新增采购付款窗口滑动回最顶端
const ReturnPaymentTop = () => {
  addPaymentDialogTop.value.scrollTop = 0;
}

// 打开采购单详情窗口
const openMordDetailDialog = async (row: any) => {
  moreDetailDialogFlag.value = true
  PurchaseContractDetail.purchaseContractNo = row.purchaseContractNo
  PurchaseContractDetail.customerEnterpriseName = row.customerEnterpriseName
  PurchaseContractDetail.ownCompanyName = row.ownCompanyName
  PurchaseContractDetail.squeezeSeason = row.squeezeSeason
  PurchaseContractDetail.inboundTime = dateConversion(row.inboundTime)
  PurchaseContractDetail.goodsName = row.goodsName
  PurchaseContractDetail.goodsCount = row.goodsCount
  PurchaseContractDetail.goodsUnit = row.goodsUnit
  PurchaseContractDetail.goodsUnitPrice = row.goodsUnitPrice
  PurchaseContractDetail.paymentAmount = row.paymentAmount
  PurchaseContractDetail.unpaidAmount = row.unpaidAmount
  PurchaseContractDetail.createTime = timeConversion(row.createTime)
  PurchaseContractDetail.createBy = row.createBy
  await getPurchaseDetailApi(row.purchaseContractNo, row.goodsName).then(res => {
    secondTableData.value = res.data;
  })
}

const moreOutboundDetail = (row: any) => {
  if (row.outboundDetailInfos[0] == null) {
    ElMessage({
      message: '该单暂无出库详情！',
      type: 'warning',
      duration: 4000
    })
  }
  thirdTableData.value = row.outboundDetailInfos;
}

const closeMoreDetailDialog = () => {
  moreDetailDialogFlag.value = false;
  secondTableData.value = [];
  thirdTableData.value = [];
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: purchaseContractModel) => {
  ElMessageBox.confirm(
    '您确定要删除该笔采购单吗?',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      title: '系统提示'
    }
  ).then(() => {
    choosePurchaseContractNo.value = row.id;
    oneDeletePurchaseContract()
  });
}

// 发送单个删除请求
const oneDeletePurchaseContract = () => {
  changeLoadingTrue();
  deleteOnePurchaseContractApi(choosePurchaseContractNo.value).then(res => {
    changeLoadingFalse();
    if (res.data == 1) {
      ElMessage({
        message: '删除采购单成功！',
        type: 'success',
      })
      if (showPigeonhole.value == false) {
        getTTableData();
      } else {
        getFTableData();
      }
    }
    else {
      ElMessage({
        message: '删除采购单失败！',
        type: 'error',
        duration: 4000
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
      ElMessage({
        message: '批量删除采购单成功！',
        type: 'success',
      })
      getTTableData()
      moreDeleteDialogFlag.value = false
      returnAll.value = true
    }
    else {
      ElMessage({
        message: '批量删除采购单失败！',
        type: 'error',
        duration: 4000
      })
    }
  })
}

// 修改数据的是否归档状态
const changePigeonhole = (row: any) => {
  changeLoadingTrue();
  setPurchaseContractPigeonholeApi(row.id, row.pigeonhole).then(res => {
    if (res.data == 1) {
      changeLoadingFalse();
      ElMessage({
        message: '修改状态成功！',
        type: 'success',
      })
      if (showPigeonhole.value == false) {
        getTTableData()
      } else {
        getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
          total.value = res.data.total;//总记录
          firstTableData.value = res.data.records;
        });
      }
      returnAll.value = false;
    }
    else {
      changeLoadingFalse();
      ElMessage({
        message: '修改状态失败！',
        type: 'error',
        duration: 4000
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
const changeLoadingTrue = () => {
  loading.value = true;
}

// 转变loading状态
const changeLoadingFalse = () => {
  loading.value = false;
}


const changeOwnFlag = () => {
  for (let i = 0; i < NewPurchaseContractData.inboundData.length; i++) {
    if (NewPurchaseContractData.inboundData[i].factoryName == "自家仓库") {
      ownFlag.value = true;
      break;
    } else {
      ownFlag.value = false;
    }
  }
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
  /* margin: 1% 15% 1% 0%;
  align-self: center;
  width: 68% */
  margin: 0% 15% 0% 1%;
  align-self: center;
  width: 70%
    /* margin: 1% 15%;
  align-self: center;
  width: 70% */
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

.contractDetailTable {
  height: 400px;
  margin-bottom: 20px;
}
</style>