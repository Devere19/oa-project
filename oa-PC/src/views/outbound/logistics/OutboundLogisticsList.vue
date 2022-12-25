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
      <el-form-item label="">
        <el-date-picker v-model="listParm.startTime" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
          placeholder="开始时间" style="width:120px" />
      </el-form-item>
      <el-form-item label="">
        <el-date-picker v-model="listParm.endTime" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
          placeholder="截止时间" style="width:120px" />
      </el-form-item>
      <el-form-item>
        <el-button @click="searchBtn" :icon="Search">搜索</el-button>
        <el-button @click="resetBtn" type="danger" plain :icon="Close">重置</el-button>
        <el-button type="primary" @click="addBtn" :icon="Plus">新增</el-button>
        <el-button type="primary" @click="searchPigeonholeZero" :icon="Plus">{{ isPigeonhole ? "显示归档数据" : "显示未归档数据" }}
        </el-button>
        <!-- <el-upload class="moreDeleteButton" name="file"
          action="http://localhost:9000/api/logistics/logisContractImportExcel" :on-error="uploadFalse"
          :on-success="uploadSuccess" :limit="1" ref="upload" accept=".xlsx,.xls" :show-file-list="false">
          <el-button :icon="Upload" type="primary">批量导入</el-button>
        </el-upload> -->
        <el-button type="success" @click="exportOutBtn" :icon="Plus">导出</el-button>
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
      <el-table-column prop="logisticsContractTime" label="物流单合同签订时间" :formatter="conversionDate"></el-table-column>
      <el-table-column prop="squeezeSeason" label="榨季"></el-table-column>
      <el-table-column prop="createBy" label="创建者名称"></el-table-column>
      <el-table-column fixed="right" label="操作" align="center" width="320">
        <template #default="scope">
          <el-button type="primary" size="default" :icon="MoreFilled"
            @click="detailBtn(scope.row.logisticsContractNo, scope.row.saleContractNo)">详情
          </el-button>
          <el-button :type="scope.row.pigeonhole == 1 ? 'info' : 'success'"
            :icon="scope.row.pigeonhole == 1 ? Hide : View" size="default" @click="changePigeonhole(scope.row.id)">{{
                isPigeonhole ? "归档" :
                  "取消归档"
            }}
          </el-button>
          <!-- <el-button type="primary" size="default" @click="">修改
          </el-button> -->
          <el-button type="danger" :icon="Delete" size="default" @click="deleteBtn(scope.row.id)">删除
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

    <!-- 物流详情 -->
    <DetailLogsitics ref="detailRef"></DetailLogsitics>

    <!-- 新增物流单 -->
    <AddLogis ref="addRef" @refresh="refresh"> </AddLogis>
  </el-main>
</template>

<script setup lang="ts">
import useTable from '@/composables/logistics/useTable'
import { Plus, Edit, Delete, Search, Close, MoreFilled, Hide, View, Money, Upload } from "@element-plus/icons-vue";
import { conversionDate } from '@/utils/timeFormat'
import useLogistics from '@/composables/logistics/useLogistics'
import useDetail from '@/composables/logistics/useDetail';
import DetailLogsitics from './DetailLogsitics.vue';
import AddLogis from './AddLogis.vue';
import { exportApi } from '@/api/logistics';
import { ExportListParm } from '@/api/logistics/LogisticsModel';
import { reactive } from 'vue';
import { ElMessage, UploadProps } from 'element-plus';
//表格相关属性
const { listParm, searchBtn, resetBtn, tableList, tableHeight, isPigeonhole, refresh, searchPigeonholeZero, sizeChange, currentChange } = useTable()

//物流单相关属性
const { changePigeonhole, deleteBtn, addRef, addBtn } = useLogistics(refresh)

//详情相关属性
const { detailBtn, detailRef } = useDetail()


//导出表格
const exportOutBtn = async () => {
  exportListParm.saleContractNo = listParm.saleContractNo
  exportListParm.logisticsContractNo = listParm.logisticsContractNo
  exportListParm.squeezeSeason = listParm.squeezeSeason
  exportListParm.startTime = listParm.startTime
  exportListParm.endTime = listParm.endTime
  exportListParm.isPigeonhole = isPigeonhole.value == true ? '1' : '0'
  let res = await exportApi(exportListParm)
  if (res && res.code == 200) {
    const abtn = document.createElement("a");
    abtn.href = "http://120.77.28.123:9000/api/logistics/exportExcel"
    abtn.click();
  }
}

const exportListParm = reactive<ExportListParm>({
  logisticsContractNo: '',
  saleContractNo: '',
  squeezeSeason: '',
  startTime: '',
  endTime: '',
  isPigeonhole: '1'
})
const uploadSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
  if (response.code == 200) {
    ElMessage({
      message: '批量插入采购单成功！',
      type: 'success',
    })
  } else {
    ElMessage({
      message: '系统出错，批量插入采购单失败！',
      type: 'error',
      duration: 4000
    })
  }
}

const uploadFalse = () => {
  ElMessage({
    message: '上传文件失败！',
    type: 'error',
    duration: 4000
  })
}

</script>

<style scoped>

</style>