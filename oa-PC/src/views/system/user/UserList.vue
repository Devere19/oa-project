<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="listParm" :inline="true" size="default">
      <el-form-item>
        <el-input v-model="listParm.phone" placeholder="请输入电话"></el-input>
      </el-form-item>
      <el-form-item>
        <el-input v-model="listParm.nickName" placeholder="请输入姓名"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="searchBtn" :icon="Search" :disabled="isSearch">搜索</el-button>
        <el-button @click="resetBtn" type="danger" plain :icon="Close" :disabled="isSearch">重置</el-button>
        <el-button type="primary" @click="addBtn" :icon="Plus" :disabled="isAdd" >新增</el-button>
      </el-form-item>
    </el-form>

    <!-- 表格 -->
    <el-table :data="tableList.list" border stripe :height="tableHeight">
      <el-table-column prop="nickName" label="姓名"></el-table-column>
      <el-table-column prop="name" label="账号"></el-table-column>
      <el-table-column prop="mobile" label="电话"></el-table-column>
      <el-table-column prop="identity" label="身份证"></el-table-column>
      <el-table-column prop="homeAddress" label="家庭住址"></el-table-column>
      <el-table-column prop="onboardingTime" label="入职时间" :formatter="conversionDateNull"></el-table-column>
      <el-table-column prop="departureTime" label="离职时间" :formatter="conversionDateNull"></el-table-column>
      <el-table-column prop="status" label="状态">
        <template #default="scope">
          <el-tag v-if="scope.row.status == '在职'" type="success" size="default">在职</el-tag>
          <el-tag v-if="scope.row.status == '离职'" type="danger" size="default">离职</el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" width="220">
        <template #default="scope">
          <el-button type="primary" :icon="Edit" size="default" @click="editBtn(scope.row)" :disabled="isEdit">编辑
          </el-button>
          <el-button type="danger" :icon="Delete" size="default" @click="deleteBtn(scope.row)" :disabled="isDelete">删除
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

    <!-- 新增编辑弹框-->
    <AddUser ref="addRef" @refresh="refresh"></AddUser>
  </el-main>

</template>

<script setup lang="ts">
import useTable from '@/composables/user/useTable';
import useUser from '@/composables/user/useUser';
import AddUser from './AddUser.vue';
import { Plus, Edit, Delete, Search, Close } from "@element-plus/icons-vue";
import isHavePerms from '@/utils/isHavePerms';
import { onMounted } from 'vue';
import { ref } from 'vue';
import { conversionDateNull } from '@/utils/timeFormat'
//获取权限
const { isAdd, isDelete, isEdit, isSearch } = isHavePerms('sys:user:view', 'sys:user:edit', 'sys:user:delete', 'sys:user:add')


//表格
const { listParm, getList, refresh, searchBtn, resetBtn, tableList, sizeChange, currentChange, tableHeight } = useTable()



//新增、编辑
const { addBtn, editBtn, deleteBtn, addRef } = useUser(getList)
</script>

<style scoped>

</style>