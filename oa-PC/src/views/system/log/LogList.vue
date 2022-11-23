<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="listParm" :inline="true" size="default">

    </el-form>
    <!-- 表格数据 -->
    <el-table :data="tableList.list" border stripe size="small" table-layout="auto" :height="tableHeight" :fit="true">
      <el-table-column prop="userName" label="操作人姓名"></el-table-column>
      <el-table-column prop="method" label="请求方法"></el-table-column>
      <el-table-column prop="params" label="请求参数"></el-table-column>
      <el-table-column prop="time" label="执行时间（毫秒）"></el-table-column>
      <el-table-column prop="ip" label="IP地址"></el-table-column>
      <el-table-column prop="createBy" label="创建人"></el-table-column>
      <el-table-column prop="createTime" label="创建时间" :formatter="conversionDateTimeNull"></el-table-column>
    </el-table>

    <!-- 分页 -->
    <el-pagination @size-change="sizeChange" @current-change="currentChange" :current-page.sync="listParm.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]" :page-size="listParm.pageSize"
      layout="total, sizes, prev, pager, next, jumper" :total="listParm.total" background>
      :pager-count="7">
    </el-pagination>
  </el-main>

</template>

<script setup lang="ts">
import { ListParm } from '@/api/log/LogModel';
import { getListApi } from '@/api/log/index'
import { onMounted, reactive, ref } from 'vue';
import { conversionDateTimeNull } from '@/utils/timeFormat'
import { table } from 'console';

const tableList = reactive({
  list: []
})
const listParm = reactive<ListParm>({
  currentPage: 1,
  pageSize: 10,
  total: 0
})
const tableHeight = ref(0)

const getList = async () => {
  let res = await getListApi(listParm)
  if (res && res.code == 200) {
    tableList.list = res.data.records
    console.log(tableList.list)
    listParm.total = res.data.total
  }
}
//分页查询 显示数量改变
const sizeChange = (size: number) => {
  listParm.pageSize = size
  getList()
}
//分页查询 当前页数该百年
const currentChange = (size: number) => {
  listParm.currentPage = size
  getList()
}



onMounted(() => {
  getList()
  tableHeight.value = window.innerHeight - 230
})
</script>

<style scoped>

</style>