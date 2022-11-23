<template>
    <div class="logisticsPaymentContract" v-loading="loading">
        <div class="headerGroup">
            <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
                新增
            </el-button>
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的物流付款单信息"
                @keyup.enter="searchTableData">
                <template #append>
                    <el-button :icon="Search" @click="searchTableData" />
                </template>
            </el-input>
            <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
            </el-button>
        </div>
        <el-table ref="firstTableRef" class="purchaseContractTable" :data="firstTableData" style="width: 98%"
            border="true" highlight-current-row>
            <!-- 暂时隐藏index -->
            <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
            <el-table-column label="物流合同编号" align="center" width="120">
                <template #default="scope">{{ scope.row.logisticsContractNo }}</template>
            </el-table-column>
            <el-table-column property="saleContractNo" align="center" label="销售合同编号" />
            <el-table-column property="freight" align="center" label="运费总价" />
            <el-table-column property="paymentCount" align="center" label="本次付款金额" />
            <el-table-column property="squeezeSeason" align="center" label="榨季" />
            <el-table-column property="logisticsContractTime" :formatter="conversionDate" align="center"
                label="物流合同签订时间" width="105" />
            <el-table-column property="goodsName" align="center" label="运输货物名称" />
            <el-table-column property="totalWeight" align="center" label="运输货物总量" />
            <el-table-column property="goodsUnit" align="center" label="运输货物单位" />
            <el-table-column label="财务审核状态" align="center">
                <template #default="scope">{{ scope.row.financeState == null ? "未处理" : "已通过✔" }}</template>
            </el-table-column>
            <el-table-column align="center" label="董事1审核状态">
                <template #default="scope">
                    {{ scope.row.logisticsPaymentDirector[0].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事2审核状态">
                <template #default="scope">
                    {{ scope.row.logisticsPaymentDirector[1].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事3审核状态">
                <template #default="scope">
                    {{ scope.row.logisticsPaymentDirector[2].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column property="paymentTime" :formatter="conversionDate" align="center" label="付款时间" />
            <el-table-column align="center" label="付款流水截图" width="130">
                <template #default="scope">
                    <el-image style="width: 100px; height: 100px"
                        :src="scope.row.paymentPhoto == '' ? null : scope.row.paymentPhoto"
                        :preview-src-list="scope.row.paymentPhotoArray" fit="cover" preview-teleported="true" />
                </template>
            </el-table-column>
            <el-table-column property="createTime" :formatter="conversionDateTime" sortable align="center" label="创建时间"
                width="105" />
            <el-table-column property="createBy" align="center" label="创建者" />
            <el-table-column align="center" label="操作" width="200" fixed="right">
                <template #default="scope">
                  <el-button :icon="Select" size="default" type="success" @click="changeState(scope.row)"
                             :disabled="loginUserRole =='财务' ? (scope.row.financeState == null ? false : true) : (loginUserRole == '董事会' ? JudgmentRepeated(scope.row) : false)">通过
                  </el-button>
                    <el-button :icon="MoreFilled" size="default" type="primary"
                        @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
                    <el-button :disabled="scope.row.paymentTime != null" :icon="Delete" size="default" type="danger"
                        @click="openOneDeleteDialog(scope.$index, scope.row)">
                        删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="paginationGroup">
            <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
                :page-sizes="[5, 10, 20, 50, 100]" :background="background"
                layout="total, sizes, prev, pager, next, jumper" :total="total"
                @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
                @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()" />
        </div>
        <el-dialog v-model="addDialogFlag" title="新增物流付款单" width="40%" draggable center :before-close="closeAddDialog">
            <ul ref="addDialogTop" style="overflow: auto;height:120px;padding: 0;">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="120px"
                    :model="NewLogisticsPaymentContractData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <!-- 验证物流合同号是否存在 -->
                            <el-form-item label="物流合同编号" prop="logisticsContractNo">
                                <el-input v-model="NewLogisticsPaymentContractData.logisticsContractNo" size="large"
                                    :suffix-icon="contractExistFlag ? 'Select' : 'CloseBold'"
                                    @change="checkLogisticsContractNo" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="本次付款金额" prop="paymentCount">
                                <el-input v-model="NewLogisticsPaymentContractData.paymentCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendNewLogisticsPaymentContract(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="oneDeleteDialogFlag" title="提示" width="30%" draggable center>
            <span>
                您确定要删除该笔物流付款单吗
            </span>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="oneDeleteLogisticsContract">
                        确定
                    </el-button>
                    <el-button @click="oneDeleteDialogFlag = false">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" preview-teleported="true" />
        </el-dialog>
        <el-dialog v-model="moreDetailDialogFlag" title="物流付款单详情" width="55%" draggable center
            :before-close="closeMoreDetailDialog">
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        物流合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsContractNo }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        销售合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.saleContractNo }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        运输货物名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.goodsName }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        运费总价：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.freight }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle" style="color: rgb(42, 183, 243);">
                        本次付款金额：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent" style="color: rgb(42, 183, 243);">
                        {{ logisticsPaymentContractDetail.paymentCount }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        运输货物总量：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.totalWeight }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        运输货物单位：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.goodsUnit }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        榨季：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.squeezeSeason }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        物流合同签订时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsContractTime }}
                    </el-col>
                </el-row>
            </div>
            <el-divider />
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        财务名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.financeStaff == null ? "暂无" :
                                logisticsPaymentContractDetail.financeStaff
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        财务审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.financeState == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事1名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsPaymentDirector[0].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事1审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsPaymentDirector[0].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事2名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsPaymentDirector[1].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事2审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsPaymentDirector[1].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事3名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsPaymentDirector[2].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事3审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.logisticsPaymentDirector[2].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
            </div>
            <el-divider />
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        出纳名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.cashier == null ? "暂无" :
                                logisticsPaymentContractDetail.financeStaff
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        付款时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.paymentTime == null ? "未知" :
                                logisticsPaymentContractDetail.paymentTime
                        }}
                    </el-col>
                </el-row>
            </div>
            <el-divider />
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        创建者：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.createBy }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        创建时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ logisticsPaymentContractDetail.createTime }}
                    </el-col>
                </el-row>
            </div>
        </el-dialog>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, FormInstance, FormRules } from 'element-plus'
import { Delete, Search, MoreFilled, Select, CloseBold } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { logisticsPaymentContractModel, logisticsPaymentDirectorModel } from '@/api/logisticsPaymentContract/LogisticsPaymentContractModel'
import { getLogisticsPaymentContractDataApi, searchLogisticsPaymentContractApi, checkLogisticsContractNoApi, addNewLogisticsPaymentContractApi, deleteOneLogisticsPaymentContractApi,changeDirectorState, changeFinanceState } from '@/api/logisticsPaymentContract'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<logisticsPaymentContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const oneDeleteDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const chooseLogisticsPaymentContractNo = ref(0)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()
const contractExistFlag = ref(false)

const loginUserName = ref("")
const loginUserRole = ref("")
const loginUserId = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()

// 新增物流付款单
const NewLogisticsPaymentContractData = reactive({
    id: '',
    logisticsContractNo: '',
    paymentCount: '',
    createBy: ''
})

// 详情
const logisticsPaymentContractDetail = reactive({
    id: '',
    logisticsContractNo: '',
    saleContractNo: '',
    freight: '',
    paymentCount: '',
    squeezeSeason: '',
    logisticsContractTime: '',
    goodsName: '',
    totalWeight: '',
    goodsUnit: '',
    financeStaff: '',
    financeState: '',
    logisticsPaymentDirector: reactive<logisticsPaymentDirectorModel[]>([]),
    cashier: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    createTime: '',
    createBy: '',
})


//表单校验规则
const firstRules = reactive<FormRules>({
    logisticsContractNo: [
        { required: true, trigger: ['change'] }
    ],
    paymentCount: [
        { required: true, trigger: ['change'] }
    ],
})

onMounted(() => {
    getTableData();
    loginUserName.value = userNickNameStore.user.nickName;
    loginUserRole.value = userNickNameStore.user.roleNames
    loginUserId.value = userNickNameStore.user.id
})

//审批通过，根据身份修改采购付款单响应审核状态
const changeState = (row:any) => {
  if (loginUserRole.value == '财务'){
    changeFinanceState(row.logisticsContractNo).then(res => {
      ElMessage({
        message: "已通过",
        type: 'success',
        duration: 3000
      })
      getTableData();
    });
  }else if (loginUserRole.value == '董事会'){
    changeDirectorState(row.id,loginUserId.value).then(res => {
      ElMessage({
        message: "已通过",
        type: 'success',
        duration: 3000
      })
      getTableData();
    })
  }
}

//判断董事会审批是否重复
const JudgmentRepeated = (row:any) => {
  console.log(userNickNameStore.user.roleNames)
  for (var i = 0;i<row.logisticsPaymentDirector.length;i++){
    if (row.logisticsPaymentDirector[i].userId == userNickNameStore.user.id){
      if (row.logisticsPaymentDirector[i].state == null){
        return false;
      }else{
        return true;
      }
    }
  }
  return true;
}

// 获取物流付款单数据
const getTableData = () => {
    changeLoadingTrue();
    getLogisticsPaymentContractDataApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        console.log(res.data.records);
        changeLoadingFalse();
    });
}


// 搜索物流付款单数据
const searchTableData = () => {
    if (searchData.value == null || searchData.value == '') {
        ElMessage({
            message: '请输入关键词再进行搜索！',
            type: 'warning',
            duration: 4000
        })
    } else {
        changeLoadingTrue();
        searchLogisticsPaymentContractApi(currentPage.value, pageSize.value, searchData.value).then(res => {
            total.value = res.data.total;//总记录
            firstTableData.value = res.data.records;
            returnAll.value = true;
            changeLoadingFalse();
        })
    }
}

// 搜索后，回到全部数据
const returnAllData = () => {
    getTableData();
    searchData.value = ""
    returnAll.value = false
}

// 打开新增物流付款单窗口
const openAddDialog = () => {
    addDialogFlag.value = true
}

// 验证物流合同是否存在
const checkLogisticsContractNo = (e: any) => {
    checkLogisticsContractNoApi(e).then(res => {
        contractExistFlag.value = res.data
        if (res.data == false) {
            ElMessage({
                message: '所填物流合同编号不存在，请检查！',
                type: 'error',
            })
        }
    })
}

// 发送新增物流付款单请求
const sendNewLogisticsPaymentContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (contractExistFlag.value == true) {
                changeLoadingTrue();
                NewLogisticsPaymentContractData.createBy = loginUserName.value;
                console.log(NewLogisticsPaymentContractData);
                addNewLogisticsPaymentContractApi(NewLogisticsPaymentContractData).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '新增物流付款单成功！',
                            type: 'success',
                        })
                        getTableData();
                        addDialogFlag.value = false;
                        contractExistFlag.value = false;
                        ReturnTop();
                        firstFormRef.value?.resetFields();
                    }
                    else {
                        ElMessage({
                            message: '新增物流付款单失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                })
            } else {
                ElMessage({
                    message: '不存在相应物流合同，请检查！',
                    type: 'error',
                    duration: 4000
                })
            }
        } else {
            ElMessage({
                message: '表单验证未通过，请检查！',
                type: 'error',
                duration: 4000
            })
        }
    })
}

// 打开物流付款单详情窗口
const openMordDetailDialog = async (row: any) => {
    logisticsPaymentContractDetail.logisticsContractNo = row.logisticsContractNo
    logisticsPaymentContractDetail.saleContractNo = row.saleContractNo
    logisticsPaymentContractDetail.freight = row.freight
    logisticsPaymentContractDetail.paymentCount = row.paymentCount
    logisticsPaymentContractDetail.squeezeSeason = row.squeezeSeason
    logisticsPaymentContractDetail.logisticsContractTime = dateConversion(row.logisticsContractTime)
    logisticsPaymentContractDetail.goodsName = row.goodsName
    logisticsPaymentContractDetail.totalWeight = row.totalWeight
    logisticsPaymentContractDetail.goodsUnit = row.goodsUnit
    logisticsPaymentContractDetail.financeStaff = row.financeStaff
    logisticsPaymentContractDetail.financeState = row.financeState
    logisticsPaymentContractDetail.logisticsPaymentDirector = row.logisticsPaymentDirector
    logisticsPaymentContractDetail.cashier = row.cashier
    logisticsPaymentContractDetail.paymentTime = dateConversion(row.paymentTime)
    logisticsPaymentContractDetail.paymentPhotoArray = row.paymentPhotoArray
    logisticsPaymentContractDetail.createTime = timeConversion(row.createTime)
    logisticsPaymentContractDetail.createBy = row.createBy
    moreDetailDialogFlag.value = true
}

const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: logisticsPaymentContractModel) => {
    chooseLogisticsPaymentContractNo.value = row.id;
    oneDeleteDialogFlag.value = true
}

// 发送单个删除请求
const oneDeleteLogisticsContract = () => {
    changeLoadingTrue();
    deleteOneLogisticsPaymentContractApi(chooseLogisticsPaymentContractNo.value).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
            ElMessage({
                message: '删除物流付款单成功！',
                type: 'success',
            })
            getTableData();
            oneDeleteDialogFlag.value = false
        }
        else {
            ElMessage({
                message: '删除物流付款单失败！',
                type: 'error',
                duration: 4000
            })
        }
    })
}

// 转变loading状态
const changeLoadingTrue = () => {
    loading.value = true;
}

// 转变loading状态
const changeLoadingFalse = () => {
    loading.value = false;
}

// 关闭新增窗口
const closeAddDialog = () => {
    addDialogFlag.value = false;
    ReturnTop();
    firstFormRef.value?.resetFields();
    contractExistFlag.value = false;
}

// 新增窗口滑动回最顶端
const ReturnTop = () => {
    addDialogTop.value.scrollTop = 0;
}

</script>

<style scoped>
.logisticsPaymentContract {
    width: 100%
}

.headerGroup {
    justify-content: center;
    display: flex;
    flex-direction: row;
    width: 100%;
}

.showPigeonholeButton {
    align-self: center;
    display: flex;
    float: left;
    margin-left: 1%;
}

.searchInput {
    margin: 1% 15%;
    align-self: center;
    width: 70%
}

.moreDeleteButton {
    align-self: center;
    display: flex;
    float: right;
    margin-right: 1%;
}

.purchaseContractTable {
    margin: auto;
}

.paginationGroup {
    margin-top: 1%;
    justify-content: center;
    display: flex;
    flex-direction: row;
}

.moreDetailTitle {
    text-align: right;
    font-size: 15px;
    margin-bottom: 5px;
    font-weight: bolder;
}

.moreDetailContent {
    font-size: 15px;
}
</style>