<template>
  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="commit">
    <template #content>
      <el-form :model="addModel" ref="addFormRef" :rules="rules" label-width="80px" size="default">
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="logisticsContractNo" label="物流单合同编号" label-width='150px' label-position="right">
              <el-input v-model="addModel.logisticsContractNo" placeholder="自提请填写销售合同号"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="upperType" label="物流单类型" label-width='150px' label-position="right">
              <el-radio-group v-model="addModel.upperType" class="ml-4">
                <el-radio label="0" size="default">加工单</el-radio>
                <el-radio label="1" size="default">销售单</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>

        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="saleContractNo" label="销售/加工单合同号" label-width='150px' label-position="right">
              <el-input v-model="addModel.saleContractNo" placeholder="运往自家仓库请填写'000'"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="logisticsContractTime" label="物流单合同签订时间" label-width='150px' label-position="right">
              <el-date-picker v-model="addModel.logisticsContractTime" type="date" format="YYYY-MM-DD"
                value-format="YYYY-MM-DD" placeholder="请选择合同时间" size="default" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="totalWeight" label="物流合同总重量" label-width='150px' label-position="right">
              <el-input v-model="addModel.totalWeight"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="goodsUnit" label="货物单位" label-width='150px' label-position="right">
              <el-select v-model="addModel.goodsUnit" placeholder="请选择货物单位" size="default">
                <el-option label="吨" value="吨"></el-option>
                <el-option label="斤" value="斤"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="freight" label="运费" label-width='150px' label-position="right">
              <el-input v-model="addModel.freight"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="squeezeSeason" label="榨季" label-width='150px' label-position="right">
              <el-input v-model="addModel.squeezeSeason" size="default"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-form-item prop="contractPhotoList" label="合同照片" label-width='150px' label-position="right">
            <el-upload v-model:file-list="PhotoData" action="http://120.77.28.123:9000/addContractPhoto"
              list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
              :on-success="handlePhotoSuccess">
              <el-icon>
                <Plus />
              </el-icon>
            </el-upload>
          </el-form-item>
        </el-row>
        <hr>
        <template v-for="(item, index) in addModel.logisticsDetailList" label-position="right" label-width="200px">
          <el-form-item>
            <el-tag size="large" hit>{{ "物流详情单" + (index + 1) }}</el-tag>
          </el-form-item>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.logisticsContractNo'" label="物流单合同编号"
                label-width='150px' label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="getLogisticsDetailList" disabled></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.upperType'" label="物流详情单类型" label-width='150px'
                label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-radio-group v-model="item.upperType" class="ml-4">
                  <el-radio label="1" size="default">采购单</el-radio>
                  <el-radio label="0" size="default">加工单</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>


          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.purchaseContractNo'" label="采购/加工合同编号"
                label-width='150px' label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="item.purchaseContractNo" placeholder="若从自家仓库出货请填写'000'"></el-input>
              </el-form-item>
            </el-col>


            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.outboundTime'" label="出库日期" label-width='150px'
                label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-date-picker v-model="item.outboundTime" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                  placeholder="请选择出库日期" size="default" />

              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.goodsFactory'" label="取货厂名" label-width='150px'
                label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="item.goodsFactory" placeholder="自家仓库出货请填写'自家仓库'">
                </el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.licensePlateNumber'" label="车牌号"
                label-width='150px' label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="item.licensePlateNumber"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.goodsWeight'" label="载货量" label-width='150px'
                label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="item.goodsWeight"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.goodsUnit'" label="货物单位" label-width='150px'
                label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-select v-model="item.goodsUnit" placeholder="请选择货物单位" size="default">
                  <el-option label="吨" value="吨"></el-option>
                  <el-option label="斤" value="斤"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.unitPrice'" label="运输单价" label-width='150px'
                label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="item.unitPrice"></el-input>
                <el-button v-show="index != 0" @click.prevent="removeInboundItem(item)" type="danger"
                  style="margin-top: 5px;">删除</el-button>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item :prop="'logisticsDetailList.' + index + '.unloadingLocation'" label="卸货地点"
                label-width='150px' label-position="right" :rules="[
  { required: true, trigger: ['change'] }]">
                <el-input v-model="item.unloadingLocation"></el-input>
              </el-form-item>
            </el-col>
            <!-- <el-col :span="12" :offset="0">
              <el-form-item label="" label-width='150px' label-position="right">
                <el-button type="warning" icon="Plus" @click="addLogisticsDetail">添加物流详情单</el-button>
              </el-form-item>
            </el-col> -->
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="" label-width='150px' label-position="right">
                <el-button type="warning" icon="Plus" @click="addLogisticsDetail">添加物流详情单</el-button>
              </el-form-item>
            </el-col>
          </el-row>

          <hr>
        </template>
      </el-form>

    </template>
  </SysDialog>
</template>

<script setup lang="ts">
import SysDialog from '@/components/SysDialog.vue';
import useDialog from '@/hooks/useDialog';
import { computed, reactive, ref } from 'vue';
import { AddLogisticsModel, LogisticsDetailList } from '@/api/logistics/LogisticsModel'
import { ElMessage, FormInstance, UploadProps, UploadUserFile } from 'element-plus';
import { deletePhotoApi } from '@/api/handlePhoto';
import { addLogisticsApi } from '@/api/logistics';
const { dialog, onShow, onClose, onConfirm } = useDialog()

const addFormRef = ref<FormInstance>()

const getLogisticsDetailList = computed(() => {
  return addModel.logisticsContractNo
})

//新增物流单数据类型
const addModel = reactive<AddLogisticsModel>({
  id: '',
  upperType: '',  //0:加工单   1：销售单
  logisticsContractNo: '',
  relationPaymentExistState: '',
  relationPaymentAuditState: '',
  relationShippingExistState: '',
  relationShippingAuditState: '',
  saleContractNo: '',
  totalWeight: '',
  goodsUnit: '',
  freight: '',
  contractPhoto: '',
  contractPhotoList: [],
  logisticsContractTime: '',
  squeezeSeason: '',
  createBy: '',
  logisticsDetailList: reactive<LogisticsDetailList[]>([
    {
      id: '',
      upperType: '',   //0：加工单  1：采购单
      logisticsContractNo: '',
      purchaseContractNo: '',
      goodsFactory: '',
      outboundTime: '',
      licensePlateNumber: '',
      goodsWeight: '',
      goodsUnit: '',
      unloadingLocation: '',
      unitPrice: '',
      createBy: ''
    }
  ])
})
const show = () => {
  dialog.title = "新增物流单"
  dialog.height = 650
  dialog.width = 800
  addModel.upperType = ''
  addFormRef.value?.resetFields()
  addModel.logisticsDetailList = reactive([
    {
      id: '',
      upperType: '',
      logisticsContractNo: '',
      purchaseContractNo: '',
      goodsFactory: '',
      outboundTime: '',
      licensePlateNumber: '',
      goodsWeight: '',
      goodsUnit: '',
      unloadingLocation: '',
      unitPrice: '',
      createBy: '',
    }
  ])
  PhotoData.value = [];
  if (addModel.contractPhotoList.length != 0) {
    addModel.contractPhotoList.map((item: string) => {
      deletePhotoApi(item);
    });
    addModel.contractPhotoList = [];
  }
  onShow()
}


//提交
const commit = async () => {
  addFormRef.value?.validate(async (avlid) => {
    if (avlid) {
      addModel.createBy = "李四"
      // console.log(addModel)
      let res = await addLogisticsApi(addModel)
      if (res && res.code == 200) {
        ElMessage.success(res.msg)
        //刷新表格
        emits('refresh')
        onClose()
      }
      //清空照片
      addModel.contractPhotoList = []
      PhotoData.value = []
    }
  })

}


//注册事件
const emits = defineEmits(['refresh'])


// 添加物流详情单
const addLogisticsDetail = () => {
  addModel.logisticsDetailList.push({
    id: '',
    upperType: '',
    logisticsContractNo: '',
    purchaseContractNo: '',
    goodsFactory: '',
    outboundTime: '',
    licensePlateNumber: '',
    goodsWeight: '',
    goodsUnit: '',
    unloadingLocation: '',
    unitPrice: '',
    createBy: ''
  })
}

//表单验证规则
const rules = reactive({
  logisticsContractNo: [
    {
      required: true,
      trigger: "change",
      message: "请输入物流单号",
    },
  ],
  upperType: [
    {
      required: true,
      trigger: "change",
      message: "请选择类型",
    },
  ],
  saleContractNo: [
    {
      required: true,
      trigger: "change",
      message: "请输入销售/加工单号",
    },
  ],
  logisticsContractTime: [
    {
      required: true,
      trigger: "change",
      message: "请输入物流单合同签订时间",
    },
  ],
  totalWeight: [
    {
      required: true,
      trigger: "change",
      message: "请输入物流合同总重量",
    },
  ],
  goodsUnit: [
    {
      required: true,
      trigger: "change",
      message: "请输入货物单位",
    },
  ],
  freight: [
    {
      required: true,
      trigger: "change",
      message: "请输入运费",
    },
  ],
  squeezeSeason: [
    {
      required: true,
      trigger: "change",
      message: "请输入榨季",
    },
  ],
})

// 删除物流详情单
const removeInboundItem = (item: LogisticsDetailList) => {
  const index = addModel.logisticsDetailList.indexOf(item)
  if (index !== -1) {
    addModel.logisticsDetailList.splice(index, 1)
  }
}

//图片上传-----------------------------------------------------------------------------------------------------
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)

const PhotoData = ref<UploadUserFile[]>([])
// 照片移除后发送请求后台删除照片
const handleRemove: UploadProps['onRemove'] = async (uploadFile: any, uploadFiles: any) => {
  console.log(uploadFile, uploadFiles);
  addModel.contractPhotoList.splice(addModel.contractPhotoList.indexOf(uploadFile.response.data), 1);
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
    addModel.contractPhotoList.push(response.data);
    console.log(addModel.contractPhotoList);
    // console.log("加入照片数据组");
  }
}

defineExpose({
  show
})
</script>

<style scoped>

</style>