<template>
    <el-main>
        <!-- 搜索栏 -->
        <el-form :model="ListParm" :inline="true" size="default">
            <el-form-item label="">
                <el-input v-model="ListParm.roleName" placeholder="请输入角色的名称"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button @click="searchBtn" :icon="Search" :disabled="isSearch">搜索</el-button>
                <el-button @click="resetBtn" :icon="Close" type="danger" plain :disabled="isSearch">重置</el-button>
                <el-button type="primary" @click="addBtn" :icon="Plus" :disabled="isAdd">新增</el-button>
            </el-form-item>
        </el-form>
        <!-- 表格 -->
        <el-table :height="tableHeight" :data="tableList.list" border stripe>
            <el-table-column prop="name" label="角色名称"></el-table-column>
            <el-table-column prop="remark" label="角色描述"></el-table-column>
            <el-table-column label="操作" width="320" align="center">
                <template #default="scope">
                    <el-button type="primary" :icon="Edit" size="default" @click="editBtn(scope.row)"
                        :disabled="isEdit">编辑</el-button>
                    <el-button type="success" :icon="Edit" size="default" @click="assignBtn(scope.row)"
                        :disabled="isEdit">修改权限</el-button>
                    <el-button type="danger" :icon="Delete" size="default" @click="deleteBtn(scope.row)"
                        :disabled="isDelete">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <!-- 分页 -->
        <el-pagination @size-change="sizeChange" @current-change="currentChange"
            :current-page.sync="ListParm.currentPage" :page-sizes="[10, 20, 40, 80, 100]" :page-size="ListParm.pageSize"
            layout="total, sizes, prev, pager, next, jumper" :total="ListParm.total" background>
            :pager-count="7">
        </el-pagination>

        <!-- 新增编辑弹框 -->
        <RoleAdd ref="addRef" @refresh="refresh"></RoleAdd>
        <!-- 分配权限 -->
        <AssignRole ref="assignRoleRef"></AssignRole>
    </el-main>

</template>

<script setup lang="ts">
import RoleAdd from "./RoleAdd.vue";
import { Plus, Edit, Delete, Search, Close } from "@element-plus/icons-vue";
import useTable from "@/composables/role/useTable";
import useRole from "@/composables/role/useRole";
import isHavePerms from '@/utils/isHavePerms';
import { onMounted } from "vue";
import AssignRole from "./AssignRole.vue";
//获取权限
const { isAdd, isDelete, isEdit, isSearch } = isHavePerms('sys:role:view', 'sys:role:edit', 'sys:role:delete', 'sys:role:add')


//表格相关的业务
const { ListParm, getList, searchBtn, resetBtn, tableList, sizeChange, currentChange, tableHeight, refresh } = useTable()


//增删改查的业务
const { addBtn, deleteBtn, editBtn, addRef, assignBtn ,assignRoleRef} = useRole(getList)
</script>

<style scoped>
</style>