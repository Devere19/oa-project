<template>
  <el-main>
    <!-- 搜索栏目 -->
    <el-form :model="listParm" :inline="true" size="default">
      <el-form-item label="">
        <el-input v-model="listParm.logisticsContractNo" placeholder="请输入物流单合同编号"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="listParm.saleContractNo" placeholder="请输入销售单合同编号"></el-input>
      </el-form-item>
      <el-form-item label="">
        <el-input v-model="listParm.squeezeSeason" placeholder="请输入榨季"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="searchBtn" :icon="Search">搜索</el-button>
        <el-button @click="resetBtn" type="danger" plain :icon="Close">重置</el-button>
        <el-button type="primary" @click="addBtn" :icon="Plus">新增</el-button>
        <el-button type="primary" @click="searchPigeonholeZero" :icon="Plus">{{ isPigeonhole ? "显示归档数据" : "显示未归档数据" }}
        </el-button>
        <el-button type="success" @click="" :icon="Plus">导出</el-button>
      </el-form-item>
    </el-form>

    <!-- 表格 -->
    <el-table :data="tableList.list" border stripe size="small" :height="tableHeight" table-layout="auto" :fit="true">
      <el-table-column prop="logisticsContractNo" label="物流单合同编号"></el-table-column>
      <el-table-column prop="saleContractNo" label="销售单合同编号"></el-table-column>
      <el-table-column prop="totalWeight" label="物流合同总重量"></el-table-column>
      <el-table-column prop="goodsUnit" label="货物单位"></el-table-column>
      <el-table-column prop="freight" label="运费"></el-table-column>
      <el-table-column prop="contractPhoto" label="物流合同照片">
        <template #default="scope">
          <el-image style="width: 100px; height: 100px" :src="scope.row.contractPhoto"
            :preview-src-list="scope.row.contractPhotoList" :initial-index="4" fit="cover" preview-teleported="true" />
        </template>
      </el-table-column>
      <el-table-column prop="logisticContractTime" label="物流单合同签订时间" :formatter="conversionDate"></el-table-column>
      <el-table-column prop="squeezeSeason" label="榨季"></el-table-column>
      <el-table-column prop="createBy" label="创建者名称"></el-table-column>
      <el-table-column fixed="right" label="操作" align="center" width="280">
        <template #default="scope">
          <el-button type="primary" size="default"
            @click="detailBtn(scope.row.logisticsContractNo, scope.row.saleContractNo)">详情
          </el-button>
          <el-button type="success" size="default" @click="changePigeonhole(scope.row.id)">{{ isPigeonhole ? "归档" :
              "取消归档"
          }}
          </el-button>
          <!-- <el-button type="primary" size="default" @click="">修改
          </el-button> -->
          <el-button type="danger" size="default" @click="deleteBtn(scope.row.id)">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 物流详情 -->
    <DetailLogsitics ref="detailRef"></DetailLogsitics>

    <!-- 新增物流单 -->
    <AddLogis ref="addRef" @refresh="refresh"> </AddLogis>
  </el-main>
</template>

<script setup lang="ts">
import useTable from '@/composables/logistics/useTable'
import { Plus, Edit, Delete, Search, Close } from "@element-plus/icons-vue";
import { conversionDate } from '@/utils/timeFormat'
import useLogistics from '@/composables/logistics/useLogistics'
import useDetail from '@/composables/logistics/useDetail';
import DetailLogsitics from './DetailLogsitics.vue';
import AddLogis from './AddLogis.vue';
//表格相关属性
const { listParm, searchBtn, resetBtn, tableList, tableHeight, isPigeonhole, refresh, searchPigeonholeZero } = useTable()

//物流单相关属性
const { changePigeonhole, deleteBtn,addRef,addBtn } = useLogistics(refresh)

//详情相关属性
const { detailBtn, detailRef } = useDetail()

</script>

<style scoped>

</style>