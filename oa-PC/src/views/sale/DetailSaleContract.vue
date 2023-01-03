<template>
  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="onConfirm">
    <template #content>
      <span class="title">销售编号:</span>{{ detailTableList.saleContractNo }}<br />
      <span class="title">货物名称:</span>{{ detailTableList.goodsName }}
      <span class="title">销售方公司名:</span>{{ detailTableList.customerEnterpriseName }}
      <span class="title">己方公司名:</span>{{ detailTableList.ownCompanyName }}
      <span class="title">销售总量:</span>{{ detailTableList.goodsCount }}{{ detailTableList.goodsUnit }}<br />
      <span class="title">剩余出库量:</span>{{ detailTableList.goodsCount - remainingOutboundVolume }}{{
    detailTableList.goodsUnit
}}<br />
      <span class="title" style="line-height: 50px;">出库详情:</span><br />

      <!-- 出库详情表格 -->
      <el-table :data="tableList.list" border stripe size="small" table-layout="auto" :fit="true" height="300px">
        <el-table-column prop="logisticsContractNo" label="运输合同"></el-table-column>
        <el-table-column prop="purchaseContractNo" label="采购订单号"></el-table-column>
        <el-table-column prop="goodsFactory" label="取货厂名"></el-table-column>
        <el-table-column prop="unloadingLocation" label="卸货地点"></el-table-column>
        <el-table-column prop="unitPrice" label="运输单价"></el-table-column>
        <el-table-column prop="outboundTime" label="出库日期" :formatter="CTTOdate"></el-table-column>
        <el-table-column prop="licensePlateNumber" label="车牌号"></el-table-column>
        <el-table-column prop="goodsWeight" label="载货量"></el-table-column>
        <el-table-column prop="goodsUnit" label="重量单位"></el-table-column>
      </el-table>
    </template>


  </SysDialog>

</template>

<script setup lang="ts">
import { AddSaleModel } from '@/api/sale/SaleModel';
import SysDialog from '@/components/SysDialog.vue';
import useDialog from '@/hooks/useDialog';
import { reactive, ref } from 'vue';
import useInstance from '@/hooks/useInstance';
import { getRemainingOutboundVolumeApi, getDetailSaleContract } from '@/api/sale';
const { global } = useInstance()

const { onShow, dialog, onConfirm, onClose } = useDialog()

//计算剩余出库量  totalWeight是已经运送的总重量
const remainingOutboundVolume = ref<number>(0)



const show = async (addModel: AddSaleModel) => {
  //获取剩余出库量
  // detaliTableList.list = addModel
  global.$objCopy(addModel, detailTableList)
  let res = await getRemainingOutboundVolumeApi(detailTableList.id)
  if (res && res.code == 200) {
    remainingOutboundVolume.value = res.data
  }
  //获取所有的运输合同
  let response = await getDetailSaleContract(detailTableList.id)
  if (response && response.code == 200) {
    tableList.list = response.data
  }
  dialog.title = '销售单详情'
  dialog.height = 400
  dialog.width = 800
  onShow()
}

//时间格式化
const CTTOdate = (row: { createTime: string | number | Date; }) => {
  let dateee = new Date(row.createTime).toJSON();
  return new Date(new Date(dateee)).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '')
  // return new Date(new Date(dateee)).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, '').substring(0, 10)
}


// //表单绑定的对象
// const detaliTableList = reactive({
//   list: []
// })
//表单绑定的对象
const detailTableList = reactive({
  id: '',
  saleContractNo: '',
  customerEnterpriseName: '',
  ownCompanyName: '',
  goodsName: '',
  goodsCount: 0,
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
  // customer: reactive(
  //   {
  //     id: '',
  //     customerAddress: '',
  //     customerName: '',
  //     customerPhone: '',
  //     createTime: '',
  //     customerEnterpriseName: ''
  //   }
  // )
})

//出库详情表格数据
const tableList = reactive({
  list: []
})





//暴露出去给父组件调用
defineExpose({
  show
})


</script>

<style scoped >
.title {
  font-size: large;
  font-weight: bold;

}
</style>