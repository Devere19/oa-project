<template>
  <el-main>
    <!-- 搜索栏目 -->
    <el-form :model="listParm" :inline="true" size="default">
      <el-form-item label="">
        <el-input v-model="listParm.saleContractNo" placeholder="请输入合同编号" style="width:150px"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="listParm.saleCompanyName" placeholder="请输入销售方公司名" style="width:150px"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="listParm.goodsName" placeholder="请输入货物名称" style="width:150px"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="listParm.squeezeSeason" placeholder="请输入榨季" style="width:150px"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-date-picker v-model="listParm.startTime" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
          placeholder="开始时间" style="width:120px" />
      </el-form-item>
      <el-form-item label="">
        <el-date-picker v-model="listParm.endTime" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
          placeholder="截止时间" style="width:120px" />
      </el-form-item>
      <el-form-item>
        <el-button @click="searchBtn" :icon="Search">搜索</el-button>
        <el-button @click="resetBtn" type="danger" plain :icon="Close">重置</el-button>
        <el-button type="primary" @click="addBtn" :icon="Plus">新增</el-button>
        <el-button type="primary" @click="searchPigeonholeZero" :icon="Plus">{{ isPigeonhole? "显示归档数据": "显示原始数据" }}
        </el-button>
        <el-button type="success" @click="exportOutBtn" :icon="Plus">导出</el-button>
        <el-button type="primary"  @click="changeOperateStatus"
        > {{operateStatus?"隐藏操作":"显示操作"}}</el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :data="tableList.list" border stripe size="small" :height="tableHeight" table-layout="auto" :fit="true">
      <el-table-column prop="saleContractNo" label="销售单合同编号"></el-table-column>
      <el-table-column prop="customerEnterpriseName" label="销售方公司名">
        <!-- <template #default="scope">
          <span>{{ scope.row.customer.customerEnterpriseName }}</span>
        </template> -->
      </el-table-column>
      <el-table-column prop="ownCompanyName" label="己方公司名"></el-table-column>
      <el-table-column prop="saleContractTime" label="合同签订时间" :formatter="conversionDateNull"></el-table-column>
      <el-table-column prop="goodsName" label="销售货物名称"></el-table-column>
      <el-table-column prop="goodsCount" label="销售货物总量"></el-table-column>
      <el-table-column prop="goodsUnit" label="销售货物单位"></el-table-column>
      <el-table-column prop="goodsUnitPrice" label="销售货物单价"></el-table-column>
      <el-table-column prop="goodsTotalPrice" label="销售合同总价钱"></el-table-column>
      <el-table-column prop="paymentMethod" label="结款方式"></el-table-column>
      <el-table-column prop="transportMethod" label="运输方式"></el-table-column>
      <el-table-column prop="contractPhoto" label="销售合同照片">
        <template #default="scope">
          <el-image style="width: 100px; height: 100px"
            :src="scope.row.contractPhoto == '' ? null : scope.row.contractPhoto"
            :preview-src-list="scope.row.contractPhotoList" fit="cover" :preview-teleported="true" />
        </template>
      </el-table-column>
      <el-table-column prop="revenueTime" label="收款时间" :formatter="conversionDateNull"></el-table-column>
      <el-table-column prop="revenueAmount" label="收款金额"></el-table-column>
      <el-table-column prop="revenuePhoto" label="收款流水单截图">
        <template #default="scope">
          <el-image style="width: 100px; height: 100px"
            :src="scope.row.revenuePhoto == '' ? null : scope.row.revenuePhoto"
            :preview-src-list="scope.row.revenuePhotoList" fit="cover" :preview-teleported="true" />
        </template>
      </el-table-column>
      <el-table-column prop="revenueBy" label="出纳操作人姓名"></el-table-column>
      <!-- <el-table-column prop="pigeonhole" label="归档"></el-table-column> -->
      <el-table-column prop="squeezeSeason" label="榨季"></el-table-column>
      <el-table-column prop="createBy" label="创建者名称"></el-table-column>
      <el-table-column fixed="right" label="操作" align="center" width="380" v-if="operateStatus">
        <template #default="scope">
          <el-button type="primary" :icon="MoreFilled" size="default" @click="detailBtn(scope.row)">详情
          </el-button>
          <el-button :type="scope.row.pigeonhole == 1 ? 'warning' : 'defalut'"
            :icon="scope.row.pigeonhole == 1 ? Hide : View" size="default" @click="changePigeonhole(scope.row.id)">{{
              isPigeonhole? "归档":
                "还原"
            }}
          </el-button>
          <el-button type="info" :icon="Edit" size="default" @click="openUpdateDialog(scope.row)"
            :disabled="getUpdateDisabled(scope.row)">
            <el-tooltip effect="dark" :content="scope.row.tips" placement="top-start"
              :disabled="!(scope.row.isHaveLogistics == 1 ? (scope.row.contractPhoto != null && scope.row.contractPhoto != '' ? true : false) : false)">
              修改
            </el-tooltip>
          </el-button>
          <el-button type="danger" :icon="Delete" size="default"
            :disabled="(scope.row.isHaveLogistics == 1 || scope.row.revenueTime != null)"
            @click="deleteBtn(scope.row.id)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination @size-change="sizeChange" @current-change="currentChange" :current-page.sync="listParm.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]" :page-size="listParm.pageSize"
      layout="total, sizes, prev, pager, next, jumper" :total="listParm.total" background>
      :pager-count="7">
    </el-pagination>

    <!-- 新增界面 -->
    <AddSaleContract ref="addRef" @refresh="refresh"> </AddSaleContract>

    <!-- 详情界面 -->
    <DetailSaleContract ref="detailRef"> </DetailSaleContract>

    <!-- 修改销售单弹窗 -->
    <el-dialog v-model="updateDialogFlag" :title="isEdit == false ? '补充合同照片' : '修改销售单'" width="50%" draggable center
      :before-close="closeUpdateDialog">
      <ul style="overflow: auto;height:600px">
        <el-form :model="addModel" ref="thridFormRef" :rules="rules" label-width="80px" size="default">
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="saleContractNo" label="合同编号">
                <el-input v-model="addModel.saleContractNo" :disabled="isEdit"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="customerEnterpriseName" label="销售公司">
                <el-select v-model="addModel.customerEnterpriseName" class="m-2" placeholder="请选择销售公司" size="default"
                  :disabled="isEdit">
                  <el-option v-for="item in customerData.list" :key="item.value" :label="item.label"
                    :value="item.value" />
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="ownCompanyName" label="己方公司">
                <el-select v-model="addModel.ownCompanyName" placeholder="请选择己方公司" size="default" :disabled="isEdit">
                  <el-option v-for="item in roleData.list" :key="item.value" :label="item.label" :value="item.value" />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="goodsName" label="货物名称">
                <el-input v-model="addModel.goodsName" :disabled="isEdit"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="goodsCount" label="货物数量">
                <el-input v-model="addModel.goodsCount" :disabled="isEdit"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="goodsUnit" label="货物单位">
                <el-select v-model="addModel.goodsUnit" placeholder="请选择货物单位" size="default" :disabled="isEdit">
                  <el-option label="吨" value="吨"></el-option>
                  <el-option label="斤" value="斤"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="goodsUnitPrice" label="货物单价">
                <el-input v-model="addModel.goodsUnitPrice" :disabled="isEdit"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="goodsTotalPrice" label="销售总价">
                <el-input v-model="addModel.goodsTotalPrice" :disabled="isEdit"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="paymentMethod" label="结款方式">
                <el-select v-model="addModel.paymentMethod" placeholder="请选择结款方式" size="default" :disabled="isEdit">
                  <el-option label="出厂净重结算" value="出厂净重结算"></el-option>
                  <el-option label="卸货净重结算" value="卸货净重结算"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="transportMethod" label="运输方式">
                <el-select v-model="addModel.transportMethod" placeholder="请选择运输方式" size="default" :disabled="isEdit">
                  <el-option label="自提" value="自提"></el-option>
                  <el-option label="陆运" value="陆运"></el-option>
                  <el-option label="海运：港到港" value="海运：港到港"></el-option>
                  <el-option label="海运：门到港" value="海运：门到港"></el-option>
                  <el-option label="海运：门到门" value="海运：门到门"></el-option>
                  <el-option label="海运：港到门" value="海运：港到门"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="squeezeSeason" label="榨季">
                <el-input v-model="addModel.squeezeSeason" :disabled="isEdit"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="saleContractTime" label="合同时间">
                <el-date-picker v-model="addModel.saleContractTime" type="date" format="YYYY-MM-DD"
                  value-format="YYYY-MM-DD" placeholder="请选择合同时间" size="default" :disabled="isEdit" />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-form-item prop="contractPhotoList" label="合同照片">
              <el-upload v-model:file-list="UpdatePhotoData" action="http://120.77.28.123:9000/addContractPhoto"
                list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="updateHandleRemove"
                :on-success="updateHandlePhotoSuccess">
                <el-icon>
                  <Plus />
                </el-icon>
              </el-upload>
            </el-form-item>
          </el-row>
        </el-form>
      </ul>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="updateSaleContract(thridFormRef)">
            确定
          </el-button>
          <el-button @click="closeUpdateDialog">取消</el-button>
        </span>
      </template>
    </el-dialog>
  </el-main>

</template>

<script setup lang="ts">
import { Plus, Edit, Delete, Search, Close, MoreFilled, Hide, View, Money } from "@element-plus/icons-vue";
import useTable from '@/composables/sale/useTable';
import useSale from "@/composables/sale/useSale";
import AddSaleContract from "@/views/sale/AddSaleContract.vue"
import DetailSaleContract from "./DetailSaleContract.vue";
import useDetail from '@/composables/sale/useDetail'
import { conversionDateNull } from '@/utils/timeFormat'
import { editSaleContractApi, exportApi, getSelectApi } from '@/api/sale/index'
import { ExportListParm } from '@/api/sale/SaleModel'
import { nextTick, onMounted, reactive, ref } from "vue";
import { AddSaleModel } from "@/api/sale/SaleModel";
import { add } from "lodash";
import { ElMessage, FormInstance, UploadProps, UploadUserFile } from "element-plus";
import useInstance from '@/hooks/useInstance';
import { SelectCustomer, SelectOwnCompany } from "@/api/customer/CustomerModel";
import { deletePhotoApi } from "@/api/handlePhoto";
import { getOwnCompanySelectApi } from "@/api/ownCompany";
const { global } = useInstance()
//表格属性
const { listParm, tableList, tableHeight, sizeChange, currentChange, searchBtn, resetBtn, refresh, getList, searchPigeonholeZero, isPigeonhole } = useTable()

//销售单新增、编辑、删除、导出
const { changePigeonhole, deleteBtn, addBtn, addRef } = useSale(refresh)

// 销售单详情相关操作
const { detailRef, detailBtn } = useDetail()

//导出表格
const exportOutBtn = async () => {
  exportListParm.saleContractNo = listParm.saleContractNo
  exportListParm.saleCompanyName = listParm.saleCompanyName
  exportListParm.goodsName = listParm.goodsName
  exportListParm.squeezeSeason = listParm.squeezeSeason
  exportListParm.startTime = listParm.startTime
  exportListParm.endTime = listParm.endTime
  exportListParm.isPigeonhole = isPigeonhole.value == true ? '1' : '0'
  let res = await exportApi(exportListParm)
  if (res && res.code == 200) {
    const abtn = document.createElement("a");
    abtn.href = "http://120.77.28.123:9000/api/saleContract/exportExcel"
    abtn.click();
  }
}
const exportListParm = reactive<ExportListParm>({
  saleContractNo: '',
  saleCompanyName: '',
  goodsName: '',
  squeezeSeason: '',
  startTime: '',
  endTime: '',
  isPigeonhole: '1'
})

const updateDialogFlag = ref(false)
const UpdatePhotoData = ref<UploadUserFile[]>([])
const updateFlag = ref(true)
const thridFormRef = ref<FormInstance>()
//定义客户列表数据  label和value都存公司名称
const customerData = reactive<SelectCustomer>({
  list: []
})
const preDeletePhoto = ref<string[]>([])
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const isEdit = ref<boolean>(false)


//定义己方公司列表
const roleData = reactive<SelectOwnCompany>({
  list: []
})


onMounted(() => {
  getSelectApi().then(res => {
    customerData.list = res.data;
  })
  getOwnCompanySelectApi().then(res => {
    roleData.list = res.data;
  })

})

// 修改销售单
const addModel = reactive<AddSaleModel>({
  id: '',
  saleContractNo: '',
  customerEnterpriseName: '',
  ownCompanyName: '',
  goodsName: '',
  goodsCount: '',
  goodsUnit: '',
  goodsUnitPrice: '',
  goodsTotalPrice: '',
  paymentMethod: '',
  transportMethod: '',
  contractPhoto: '',
  contractPhotoList: [],
  revenueAmount: '',
  revenuePhoto: '',
  revenuePhotoList: [],
  revenueBy: '',
  pigeonhole: '',
  squeezeSeason: '',
  createBy: '',
  saleContractTime: '',
  isHaveLogistics: ''
})

// 打开修改采购单窗口
const openUpdateDialog = (row: AddSaleModel) => {
  //判断是否只是可以编辑照片
  if (row.isHaveLogistics == '1') {
    console.log("只能编辑图片")
    isEdit.value = true
  } else {
    console.log("都可以编辑")
    isEdit.value = false
  }
  console.log("是否可以修改所有的" + isEdit.value)
  updateDialogFlag.value = true;
  for (let i = 0; i < row.contractPhotoList.length; i++) {
    // 当一张图片都没上传是长度为1，但内容为null，因此需要进行判断
    if (row.contractPhotoList[i] != null && row.contractPhotoList[i] != '') {
      UpdatePhotoData.value.push({
        name: i + '',
        url: row.contractPhotoList[i],
      });
    }
  }
  // 赋值必须要在窗口显示后，否则会被认定为初始值
  nextTick(() => {
    global.$objCopy(row, addModel)
    // 当一张图片都没上传是长度为1，但内容为null，不将null清除则会后续传输时会带上null，出现错误
    if (row.contractPhotoList[0] == null || row.contractPhotoList[0] == '') {
      addModel.contractPhotoList.splice(0, 1);
    }
    addModel.createBy = row.createBy
  })
}

// 关闭修改采购单窗口
const closeUpdateDialog = () => {
  updateDialogFlag.value = false;
  thridFormRef.value?.resetFields();
  UpdatePhotoData.value = [];
  preDeletePhoto.value = [];
  // if (UpdatePurchaseContractData.contractPhotoArray.length != 0) {
  //   UpdatePurchaseContractData.contractPhotoArray.map((item) => {
  //     deletePhotoApi(item);
  //   });
  //   UpdatePurchaseContractData.contractPhotoArray = [];
  // }
}
// 处理照片预览
const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
  dialogImageUrl.value = uploadFile.url!
  previewImageFlag.value = true
}
// 更新窗口照片移除后发送请求后台删除照片
const updateHandleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
  console.log(uploadFile, uploadFiles);
  if (addModel.contractPhotoList.indexOf(uploadFile.url!) == -1) {
    addModel.contractPhotoList.splice(addModel.contractPhotoList.indexOf(uploadFile.response.data), 1);
    console.log("移出照片数据组");
    deletePhotoApi(uploadFile.response.data);
    console.log("删除已上传照片");
  } else {
    preDeletePhoto.value.push(uploadFile.url!);
    console.log("加入预删除照片组");
  }
}


// 更新窗口上传照片成功后加入数组
const updateHandlePhotoSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
  if (response.code == 200) {
    addModel.contractPhotoList.push(response.data);
    console.log(addModel.contractPhotoList);
    console.log("加入照片数据组");
  }
}


const updateSaleContract = async (formEl1: FormInstance | undefined) => {
  thridFormRef.value?.validate(async (avlid) => {
    if (avlid) {
      for (let i = 0; i < preDeletePhoto.value.length; i++) {
        // 删除修改的照片
        deletePhotoApi(preDeletePhoto.value[i]);
        addModel.contractPhotoList.splice(addModel.contractPhotoList.indexOf(preDeletePhoto.value[i]), 1);
        console.log("删除修改照片" + i);
      }
      let res = await editSaleContractApi(addModel)
      if (res && res.code == 200) {
        ElMessage({
          message: '修改成功！',
          type: 'success',
        })
        updateDialogFlag.value = false;
        thridFormRef.value?.resetFields();
        UpdatePhotoData.value = [];
        preDeletePhoto.value = [];
        refresh()
      } else {
        ElMessage({
          message: '修改失败！',
          type: 'error',
        })
      }
    }
  })
}

const getUpdateDisabled = (row: any) => {
  if (row.isHaveLogistics == '1') {
    if (row.contractPhoto != null || row.contractPhoto != '') {
      row.tips = "存在相关的物流单,不允许修改!"
      return true;
    }
  }
  return false;
}

const getDeleteDisabled = (row: AddSaleModel) => {
  if (row.isHaveLogistics == '1') {
    console.log("已经存在了相关物流单，无法删除", row.saleContractNo, row.contractPhoto)
    return true;
  } else {
    return false
  }
}

//表单验证规则
const rules = reactive({
  saleContractNo: [
    {
      required: true,
      trigger: "change",
      message: "请输入合同编号",
    },
  ],
  customerEnterpriseName: [
    {
      required: true,
      trigger: "change",
      message: "请输入销售公司名",
    },
  ],
  ownCompanyName: [
    {
      required: true,
      trigger: "change",
      message: "请输入己方公司名",
    },
  ],
  goodsName: [
    {
      required: true,
      trigger: "change",
      message: "请输入货物名称",
    },
  ],
  goodsCount: [
    {
      required: true,
      trigger: "change",
      message: "请输入货物数量",
    },
  ],
  goodsUnit: [
    {
      required: true,
      trigger: "change",
      message: "请输入货物单位",
    },
  ],
  goodsUnitPrice: [
    {
      required: true,
      trigger: "change",
      message: "请输入货物单价",
    },
  ],
  goodsTotalPrice: [
    {
      required: true,
      trigger: "change",
      message: "请输入销售总价",
    },
  ],
  paymentMethod: [
    {
      required: true,
      trigger: "change",
      message: "请输入结款方式",
    },
  ],
  transportMethod: [
    {
      required: true,
      trigger: "change",
      message: "请输入运输方式",
    },
  ],
  squeezeSeason: [
    {
      required: true,
      trigger: "change",
      message: "请输入榨季",
    },
  ],
  saleContractTime: [
    {
      required: true,
      trigger: "change",
      message: "请输入合同时间",
    },
  ],

})

const operateStatus = ref<boolean>(true)
//改变operateStatus
const changeOperateStatus = () => {
  operateStatus.value = !operateStatus.value
}


</script>

<style scoped>

</style>