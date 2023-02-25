<template>
  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="onConfirm">
    <template #content>
      <span class="title">运输单号:</span>{{ logisticsContractNumber }}<br />
      <span class="title">销售单号:</span>{{ saleContractNumber }}<br />

      <!-- 物流详情表格 -->
      <el-table :data="tableList.list" border stripe size="small" table-layout="auto" :fit="true" height="300px">
        <el-table-column prop="purchaseContractNo" label="采购/加工订单号"></el-table-column>
        <el-table-column prop="goodsFactory" label="取货厂名"></el-table-column>
        <el-table-column prop="unloadingLocation" label="卸货地点"></el-table-column>
        <el-table-column prop="unitPrice" label="运输单价"></el-table-column>
        <el-table-column prop="outboundTime" label="出库日期" :formatter="conversionDate"></el-table-column>
        <el-table-column prop="licensePlateNumber" label="车牌号"></el-table-column>
        <el-table-column prop="goodsWeight" label="载货量"></el-table-column>
        <el-table-column prop="uploadingWeight" label="些货量"></el-table-column>
        <el-table-column prop="goodsUnit" label="重量单位"></el-table-column>
        <el-table-column prop="calculationMethod" label="结算方式"></el-table-column>
      </el-table>
    </template>


  </SysDialog>
</template>

<script setup lang="ts">
import { getDetailLogistics } from '@/api/logistics';
import SysDialog from '@/components/SysDialog.vue'
import useDialog from '@/hooks/useDialog';
import { conversionDate } from '@/utils/timeFormat'
import { reactive, ref } from 'vue';
const { dialog, onShow, onClose, onConfirm } = useDialog()

const logisticsContractNumber = ref('')
const saleContractNumber = ref('')
const tableList = reactive({
  list: []
})


//展示
const show = async (id: string, logisticsContractNo: string, saleContractNo: string) => {
  logisticsContractNumber.value = logisticsContractNo
  saleContractNumber.value = saleContractNo
  //获取当前物流单的物流信息详情
  let res = await getDetailLogistics(id)
  if (res && res.code == 200) {
    tableList.list = res.data
  }
  dialog.title = '物流单详情'
  dialog.height = 400
  dialog.width = 800
  onShow()
}


//暴露出去给父组件调用
defineExpose({
  show
})



</script>

<style scoped>
.title {
  font-size: large;
  font-weight: bold;

}
</style>