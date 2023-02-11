<template>
  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="commit">
    <template #content>
      <el-form :model="addModel" ref="addFormRef" :rules="rules" label-width="80px" size="default">
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="saleContractNo" label="合同编号">
              <el-input v-model="addModel.saleContractNo"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="customerEnterpriseName" label="销售公司">
              <el-select v-model="addModel.customerEnterpriseName" class="m-2" placeholder="请选择销售公司" size="default">
                <el-option v-for="item in customerData.list" :key="item.value" :label="item.label"
                  :value="item.value" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="ownCompanyName" label="己方公司">
              <el-select v-model="addModel.ownCompanyName" placeholder="请选择己方公司" size="default">
                <!-- <el-option label="广西永湘物流有限公司" value="广西永湘物流有限公司"></el-option>
                <el-option label="广西南宁锦泰行工贸有限公司" value="广西南宁锦泰行工贸有限公司"></el-option>
                <el-option label="广西丰沣顺国际物流有限公司" value="广西丰沣顺国际物流有限公司"></el-option> -->
                <el-option v-for="item in roleData.list" :key="item.value" :label="item.label" :value="item.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="goodsName" label="货物名称">
              <el-input v-model="addModel.goodsName"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="goodsCount" label="货物数量">
              <el-input v-model="addModel.goodsCount"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="goodsUnit" label="货物单位">
              <el-select v-model="addModel.goodsUnit" placeholder="请选择货物单位" size="default">
                <el-option label="吨" value="吨"></el-option>
                <el-option label="斤" value="斤"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="goodsUnitPrice" label="货物单价">
              <el-input v-model="addModel.goodsUnitPrice"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="goodsTotalPrice" label="销售总价">
              <el-input v-model="addModel.goodsTotalPrice"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="paymentMethod" label="结款方式">
              <el-select v-model="addModel.paymentMethod" placeholder="请选择结款方式" size="default">
                <el-option label="出厂净重结算" value="出厂净重结算"></el-option>
                <el-option label="卸货净重结算" value="卸货净重结算"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="transportMethod" label="运输方式">
              <el-select v-model="addModel.transportMethod" placeholder="请选择运输方式" size="default">
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
              <el-input v-model="addModel.squeezeSeason"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="saleContractTime" label="合同时间">
              <el-date-picker v-model="addModel.saleContractTime" type="date" format="YYYY-MM-DD"
                value-format="YYYY-MM-DD" placeholder="请选择合同时间" size="default" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-form-item prop="contractPhotoList" label="合同照片">
            <el-upload v-model:file-list="PhotoData" action="http://120.77.28.123:9000/addContractPhoto"
              list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
              :on-success="handlePhotoSuccess">
              <el-icon>
                <Plus />
              </el-icon>
            </el-upload>
          </el-form-item>
        </el-row>
      </el-form>

    </template>
  </SysDialog>
</template>

<script setup lang="ts">
import SysDialog from "@/components/SysDialog.vue";
import useDialog from '@/hooks/useDialog';
import { AddSaleModel } from "@/api/sale/SaleModel"
import { nextTick, onMounted, reactive, ref } from "vue";
import { SelectCustomer } from "@/api/cashier/customer/CustomerModel";
import { getSelectApi, addSaleContractApi, editSaleContractApi } from "@/api/sale/index";
import { ElMessage, FormInstance, UploadFile, UploadFiles, UploadInstance, UploadProps, UploadUserFile } from "element-plus";
import { add } from "lodash";
import { deletePhotoApi } from "@/api/handlePhoto";
import { EditType } from "@/type/BaseEnum";
import useInstance from '@/hooks/useInstance';
import OwnCompanyList from "../ownCompany/OwnCompanyList.vue";
import { SelectOwnCompany } from "@/api/cashier/customer/CustomerModel"
import { getOwnCompanySelectApi } from "@/api/ownCompany";
const { global } = useInstance()
//弹框属性
const { onClose, dialog, onConfirm, onShow } = useDialog()

const addFormRef = ref<FormInstance>()

//show方法 
const show = async () => {
  //清空照片

  addModel.contractPhotoList = []
  PhotoData.value = []
  dialog.height = 600
  dialog.width = 800
  dialog.title = '新增销售单'

  //清空照片
  let res = await getSelectApi()
  customerData.list = res.data
  onShow()
  addFormRef.value?.resetFields()
}
onMounted(() => {
  getOwnCompanySelectApi().then(res => {
    roleData.list = res.data;
  })
})

//定义客户列表数据  label存公司名称  vale存客户表id
const customerData = reactive<SelectCustomer>({
  list: []
})
//定义己方公司列表
const roleData = reactive<SelectOwnCompany>({
  list: []
})

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

//注册事件
const emits = defineEmits(['refresh'])

//提交新增数据
const commit = async () => {
  addFormRef.value?.validate(async (avlid) => {
    if (avlid) {
      // console.log("提交的数据:", addModel)
      let res = await addSaleContractApi(addModel)
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

//表单绑定的对象
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


//暴露出去给父组件调用
defineExpose({
  show
})

</script>

<style scoped>

</style>