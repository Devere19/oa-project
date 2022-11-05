<template>
  客户信息
</template>

<script>
import { Plus, Edit, Delete, Search, Close } from "@element-plus/icons-vue";
import useTable from '@/composables/sale/useTable';
import useSale from "@/composables/sale/useSale";
import AddSaleContract from "@/views/sale/AddSaleContract.vue"
//表格属性
const { listParm, tableList, tableHeight, sizeChange, currentChange, searchBtn, resetBtn, refresh, getList, searchPigeonholeZero, isPigeonhole } = useTable()
//销售单新增、编辑、删除
const { changePigeonhole, deleteBtn, addBtn ,addRef} = useSale(refresh)
</script>

<style scoped>

</style>