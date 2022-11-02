<template>
  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="onConfirm">
    <template #content>
      <el-form :model="addModel" ref="addFormRef" label-width="80px" size="default">
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="saleContractNo" label="合同编号">
              <el-input v-model="addModel.saleContractNo"></el-input>
            </el-form-item>
          </el-col>
          <!-- <el-col :span="12" :offset="0">
            <el-form-item prop="roleId" label="角色">
              <el-select v-model="addModel.roleId" class="m-2" placeholder="请选择角色" size="default">
                <el-option v-for="item in roleData.list" :key="item.value" :label="item.label" :value="item.value" />
              </el-select>
            </el-form-item>
          </el-col> -->
          <el-col :span="12" :offset="0">
            <el-form-item prop="saleCustomerId" label="销售公司">
              <el-input v-model="addModel.saleCustomerId"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="ownCompanyName" label="己方公司">
              <el-input v-model="addModel.ownCompanyName"></el-input>
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
              <el-input v-model="addModel.goodsUnit"></el-input>
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
              <el-input v-model="addModel.paymentMethod"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="transportMethod" label="运输方式">
              <el-input v-model="addModel.transportMethod"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="squeezeSeason" label="榨季">
              <el-input v-model="addModel.squeezeSeason"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="squeezeSeason" label="榨季">
              <el-input v-model="addModel.squeezeSeason"></el-input>
            </el-form-item>
          </el-col>
        </el-row>



      </el-form>

    </template>
  </SysDialog>
</template>

<script setup lang="ts">
import SysDialog from "@/components/SysDialog.vue";
import useDialog from '@/hooks/useDialog';
import { AddSaleModel } from "@/api/sale/SaleModel"
import { reactive } from "vue";
//弹框属性
const { onClose, dialog, onConfirm, onShow } = useDialog()

//show方法 
const show = () => {
  dialog.title = "新增销售单"
  dialog.height = 640
  dialog.width = 800
  onShow()
}


//表单绑定的对象
const addModel = reactive<AddSaleModel>({
  id: '',
  saleContractNo: '',
  saleCustomerId: '',
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
  revenueBy: '',
  pigeonhole: '',
  squeezeSeason: '',
  createBy: '',
})


//暴露出去给父组件调用
defineExpose({
  show
})
</script>

<style scoped>

</style>