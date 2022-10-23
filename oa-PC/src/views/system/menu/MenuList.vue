<template>
  <el-main stylt="padding-top:10px">
    <!-- 新增 -->
    <div style="display: flex;">
      <el-button style="margin-bottom: 10px" type="primary" :icon="Plus" size="default" @click="addBtn"
        :disabled="isAdd">新增</el-button>
    </div>
    <!-- 表格数据 -->
    <el-table :data="tableList.list" row-key="id" :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
      border stripe default-expand-all :height="tableHeight">
      <el-table-column prop="name" label="菜单名称"></el-table-column>
      <el-table-column prop="type" label="类型">
        <template #default="scope">
          <el-tag v-if="scope.row.type == '0'" size="default">目录</el-tag>
          <el-tag v-if="scope.row.type == '1'" type="success" size="default">菜单</el-tag>
          <el-tag v-if="scope.row.type == '2'" type="danger" size="default">按钮</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="icon" label="图标">
        <template #default="scope">
          <el-icon>
            <!-- 通过动态自建的方式显示图标 -->
            <component :is="scope.row.icon"></component>
          </el-icon>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="路由名称"></el-table-column>
      <el-table-column prop="url" label="路由地址"></el-table-column>
      <el-table-column prop="perms" label="权限字段"></el-table-column>
      <el-table-column label="操作" width="200" align="center">
        <template #default="scope">
          <el-button type="success" :icon="Edit" size="default" @click="editBtn(scope.row)" :disabled="isEdit">编辑
          </el-button>
          <el-button type="danger" :icon="Delete" size="default" @click="deleteBtn(scope.row)" :disabled="isDelete">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 新增、编辑 -->
    <AddMenu ref="addRef" @refresh="refresh"></AddMenu>
  </el-main>

</template>

<script setup lang="ts">
import { Plus, Edit, Delete, Search, Close } from "@element-plus/icons-vue";
import useMenu from "@/composables/menu/useMenu";
// import AddMenu from "./AddMenu.vue";
import AddMenu from "./AddMenu.vue";
import useMenuTable from "@/composables/menu/useMenuTable";
import isHavePerms from '@/utils/isHavePerms';
import { onMounted } from "vue";
//获取权限
const { isAdd, isDelete, isEdit, isSearch } = isHavePerms('sys:menu:view', 'sys:menu:edit', 'sys:menu:delete', 'sys:menu:add')


//表格数据
const { getList, tableList, tableHeight, refresh } = useMenuTable()
//新增、编辑
const { addBtn, deleteBtn, editBtn, addRef } = useMenu(getList)


</script>

<style scoped>
</style>