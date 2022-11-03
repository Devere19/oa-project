<template>
  <div class="purchaseContract">
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
      <el-table-column property="name" align="center" label="操作" width="300">
        <template #default="scope">
          <el-button :icon="MoreFilled" size="default" type="primary" @click="">详情</el-button>
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
    <el-dialog v-model="addDialogFlag" title="新增采购单" width="50%" draggable center>
      <ul ref="top" style="overflow: auto;height:600px">
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
          <el-form v-for="(item, index) in InboundData" label-position="right" label-width="200px">
            <el-form-item>
              <el-tag size="large" hit>{{ "入库单" + (index + 1) }}</el-tag>
            </el-form-item>
            <el-form-item label="厂名">
              <el-input v-model="item.factoryName" size="large" />
            </el-form-item>
            <el-form-item label="入库数量">
              <el-input v-model="item.inOutGoodsCount" size="large" />
              <el-button v-show="index != 0" @click.prevent="removeInboundItem(item)">删除</el-button>
            </el-form-item>
          </el-form>
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
          <el-button type="primary" @click="sendNewPurchaseContract">
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
      <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" preview-teleported="true" />
    </el-dialog>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile } from 'element-plus'
import { Delete, Search, MoreFilled, Hide, View } from "@element-plus/icons-vue";
// import timeFormat from "@/utils/timeFormat"
// import type from 'element-plus'
import { deletePhotoApi } from '@/api/handlePhoto'
import { purchaseContractModel, inboundDataModel } from '@/api/purchaseContract/PurchaseContractModel';
import { getTPurchaseContractDataApi, getFPurchaseContractDataApi, searchPurchaseContractApi, deleteOnePurchaseContractApi, deleteMorePurchaseContractApi, setPurchaseContractPigeonholeApi, addNewPurchaseContractApi } from '@/api/purchaseContract'


const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)
const background = ref(true)
const tableData = ref<purchaseContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const oneDeleteDialogFlag = ref(false)
const moreDeleteDialogFlag = ref(false)
const choosePurchaseContractNo = ref(0)
const showPigeonhole = ref(false)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const PhotoData = ref<UploadUserFile[]>([])

const multipleTableRef = ref<InstanceType<typeof ElTable>>()
const multipleSelection = ref<purchaseContractModel[]>([])

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
  goodsUnitPrice: '',
  paymentAmount: '',
  contractPhotoArray: reactive<string[]>([]),
  createTime: '',
  createBy: ''
})

const InboundData = reactive<inboundDataModel[]>([
  {
    factoryName: '',
    inOutGoodsCount: ''
  }
])

onMounted(() => {
  getTTableData();
})

// 获取显示数据
const getTTableData = () => {
  getTPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    tableData.value = res.data.records;
  });
}

// 获取隐藏数据
const getFTableData = () => {
  getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
    total.value = res.data.total;//总记录
    tableData.value = res.data.records;
  });
}

// 切换归档或非归档数据
const changePigeonholeData = (flag: boolean) => {
  showPigeonhole.value = flag;
  if (flag == true) {
    getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
      total.value = res.data.total;//总记录
      tableData.value = res.data.records;
    });
  } else {
    getTTableData();
  }
}

// 时间转换
const CTTOdate = (row: any) => {
  let dateee = new Date(row.createTime).toJSON();
  return new Date(new Date(dateee)).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '')
}

// 搜索数据
const searchTableData = () => {
  searchPurchaseContractApi(currentPage.value, pageSize.value, searchData.value, showPigeonhole.value).then(res => {
    total.value = res.data.total;//总记录
    tableData.value = res.data.records;
    returnAll.value = true;
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
  multipleSelection.value = val;
}

// 打开新增窗口
const openAddDialog = () => {
  addDialogFlag.value = true
}

// 发送新增采购单请求
const sendNewPurchaseContract = () => {
  console.log(NewPurchaseContractData);
  addNewPurchaseContractApi(NewPurchaseContractData, InboundData).then(res => {
    console.log(res);
  })
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: purchaseContractModel) => {
  choosePurchaseContractNo.value = row.id;
  oneDeleteDialogFlag.value = true
}

// 发送单个删除请求
const oneDeletePurchaseContract = () => {
  deleteOnePurchaseContractApi(choosePurchaseContractNo.value).then(res => {
    if (res.data == 1) {
      getTTableData()
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
  multipleSelection.value.map((item) => {
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
  setPurchaseContractPigeonholeApi(row.id, row.pigeonhole).then(res => {
    if (res.data == 1) {
      if (showPigeonhole.value == false) {
        getTTableData()
      } else {
        getFPurchaseContractDataApi(currentPage.value, pageSize.value).then(res => {
          total.value = res.data.total;//总记录
          tableData.value = res.data.records;
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
  InboundData.push({
    factoryName: '',
    inOutGoodsCount: '',
  })
}

// 删除入厂单
const removeInboundItem = (item: inboundDataModel) => {
  const index = InboundData.indexOf(item)
  if (index !== -1) {
    InboundData.splice(index, 1)
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