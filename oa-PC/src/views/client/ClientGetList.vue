<template>

    <!--  搜索栏-->
  <div>
    <div class="d1">
      <el-col span="24">
        <el-input clearable>
        </el-input>
      </el-col>
    </div>
    <div class="d2">
      <el-col span="10">
        <el-input placeholder="按照姓名查询"  style="margin-left:20px"></el-input>
      </el-col>
    </div>
    <el-button type="primary" size="default" style="margin-left:40px ">查询</el-button>
    <el-button type="primary" size="default" style="margin-left:40px ">新增</el-button>
  </div>
<!--表格设计-->
  <el-table :data="infoList" border :height="tableHeight">
    <el-table-column type="index" label="序号" align="center" width="150">
    </el-table-column>
    <el-table-column prop="customerEnterpriseName" label="客户企业名称" align="center" width="220">
    </el-table-column>
    <el-table-column prop="customerName" label="客户名" align="center" width="220">
    </el-table-column>
    <el-table-column prop="customerPhone" label="联系方式" align="center" width="220">
    </el-table-column>
    <el-table-column prop="customerAddress" label="客户住址" align="center" width="300">
    </el-table-column>
    <el-table-column prop="createTime" label="创建时间" align="center" width="220">
    </el-table-column>
    <el-table-column prop="createBy" label="创建人" align="center" width="220">
    </el-table-column>
    <el-table-column prop="LastUpdateTime" label="最后一次更改时间" align="center" width="220">
    </el-table-column>
    <el-table-column prop="LastUpdateBy" label="更改人" align="center" width="220">
    </el-table-column>
  </el-table>


</template>


<script lang="ts" setup>
import {
  Check,
  Delete,
  Edit,
  Message,
  Search,
  Star,
} from '@element-plus/icons-vue'
</script>

<style scoped>
.d1{
  position: relative;
  float: left;
}
.d2{
  position: relative;
  float: left;
}
.s1{
  position: relative;
  float: left;

}
</style>