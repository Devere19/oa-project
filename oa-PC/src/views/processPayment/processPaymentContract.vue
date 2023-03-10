<template>
    <div class="processPaymentContract" v-loading="loading">
        <div class="headerGroup">
            <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
                新增
            </el-button>
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的加工付款单信息"
                @keyup.enter="searchTableData">
                <template #append>
                    <el-button :icon="Search" @click="searchTableData" />
                </template>
            </el-input>
            <el-upload class="moreDeleteButton" name="file"
                action="http://localhost:9000/processPaymentContract/processPaymentImportExcel" :on-error="uploadFalse"
                :on-success="uploadSuccess" :on-progress="() => changeLoadingTrue()" :limit="1" ref="upload"
                accept=".xlsx,.xls" :show-file-list="false">
                <el-button :icon="Upload" type="primary">批量导入</el-button>
            </el-upload>
            <el-button type="primary" class="moreDeleteButton" @click="changeOperateStatus">
                {{ operateStatus ? "隐藏操作" : "显示操作" }}</el-button>
            <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
            </el-button>
        </div>
        <el-table ref="firstTableRef" class="processContractTable" :data="firstTableData" style="width: 98%" :border="true"
            highlight-current-row>
            <!-- 暂时隐藏index -->
            <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
            <el-table-column label="加工合同编号" align="center" width="120">
                <template #default="scope">{{ scope.row.processContractNo }}</template>
            </el-table-column>
            <el-table-column property="customerEnterpriseName" align="center" label="加工方公司名" width="140" />
            <el-table-column property="ownCompanyName" align="center" label="己方公司名" width="140" />
            <el-table-column property="goodsName" align="center" label="加工货物" width="100" />
            <el-table-column property="paymentMonth" align="center" label="付款月份" width="100" />
            <el-table-column property="paymentMonthPriceT" align="center" label="加工单价(元/吨)" width="130" />
            <el-table-column property="goodsCount" align="center" label="加工总量(吨)" width="110" />
            <el-table-column property="paymentCount" align="center" label="总费用金额" width="100" />
            <el-table-column label="财务审核状态" align="center">
                <template #default="scope">{{ scope.row.financeState == null ? "未处理" : "已通过✔" }}</template>
            </el-table-column>
            <el-table-column align="center" label="董事1审核状态">
                <template #default="scope">
                    {{ scope.row.processPaymentDirector[0].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事2审核状态">
                <template #default="scope">
                    {{ scope.row.processPaymentDirector[1].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事3审核状态">
                <template #default="scope">
                    {{ scope.row.processPaymentDirector[2].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column property="paymentTime" :formatter="conversionDate" align="center" label="付款时间" />
            <el-table-column align="center" label="付款流水截图" width="130">
                <template #default="scope">
                    <el-image style="width: 100px; height: 100px"
                        :src="scope.row.paymentPhoto == '' ? null : scope.row.paymentPhoto"
                        :preview-src-list="scope.row.paymentPhotoArray" fit="cover" :preview-teleported="true" />
                </template>
            </el-table-column>
            <el-table-column property="createTime" :formatter="conversionDateTime" sortable align="center" label="创建时间"
                width="105" />
            <el-table-column property="createBy" align="center" label="创建者" />
            <el-table-column align="center" label="操作" width="390" fixed="right" v-if="operateStatus">
                <template #default="scope">
                    <el-button :icon="Select" size="default" type="success" @click="changeState(scope.row)"
                        :disabled="stateAvailable(scope.row)!">
                        通过
                    </el-button>
                    <el-button :icon="MoreFilled" size="default" type="primary" @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
                    <!-- <el-button :icon="Edit" size="default" type="info" @click="openUpdateDialog(scope.row)"
                        :disabled="scope.row.cashier != null ? true : (scope.row.financeStaff != null ? true : directorState(scope.row.processPaymentDirector))">修改
                    </el-button> -->
                    <el-button :icon="Edit" size="default" type="info" @click="openUpdateDialog(scope.row)"
                        :disabled="scope.row.financeStaff != null">修改
                    </el-button>
                    <el-button :disabled="scope.row.financeStaff != null" :icon="Delete" size="default" type="danger"
                        @click="openOneDeleteDialog(scope.$index, scope.row)">
                        删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="paginationGroup">
            <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
                :page-sizes="[5, 10, 20, 50, 100]" :background="background" layout="total, sizes, prev, pager, next, jumper"
                :total="total" @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
                @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()" />
        </div>
        <el-dialog v-model="addDialogFlag" title="新增加工付款单" width="40%" draggable center :before-close="closeAddDialog">
            <ul ref="addDialogTop" style="overflow: auto;height:290px;padding: 0;">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="140px"
                    :model="NewProcessPaymentContractData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <!-- 验证加工合同号是否存在 -->
                            <el-form-item label="加工合同编号" prop="processContractNo">
                                <el-input v-model="NewProcessPaymentContractData.processContractNo" size="large"
                                    :suffix-icon="contractExistFlag ? 'Select' : 'CloseBold'"
                                    @input="checkProcessContractNo" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="付款月份" prop="paymentMonth">
                                <el-date-picker type="month" v-model="NewProcessPaymentContractData.paymentMonth"
                                    :disabled-date="disabledDate" style="width: 100%;" value-format="YYYY-MM" size="large">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="加工单价(元/吨)" prop="paymentMonthPriceT">
                                <el-input v-model="NewProcessPaymentContractData.paymentMonthPriceT" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="加工总量(吨)" prop="goodsCount">
                                <el-input v-model="NewProcessPaymentContractData.goodsCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="总费用金额" prop="paymentCount">
                                <el-input v-model="NewProcessPaymentContractData.paymentCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendNewProcessPaymentContract(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="updateDialogFlag" title="修改加工付款单" width="40%" draggable center
            :before-close="closeUpdateDialog">
            <ul ref="updateDialogTop" style="overflow: auto;height:290px;padding: 0;">
                <el-form ref="secondFormRef" :rules="firstRules" label-position="right" label-width="140px"
                    :model="UpdateProcessPaymentContractData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <!-- 验证加工合同号是否存在 -->
                            <el-form-item label="加工合同编号" prop="processContractNo">
                                <el-input v-model="UpdateProcessPaymentContractData.processContractNo" size="large"
                                    :suffix-icon="contractExistFlag ? 'Select' : 'CloseBold'"
                                    @input="checkProcessContractNo" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="付款月份" prop="paymentMonth">
                                <el-date-picker type="month" v-model="UpdateProcessPaymentContractData.paymentMonth"
                                    :disabled-date="disabledDate" style="width: 100%;" value-format="YYYY-MM" size="large">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="加工单价(元/吨)" prop="paymentMonthPriceT">
                                <el-input v-model="UpdateProcessPaymentContractData.paymentMonthPriceT" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="加工总量(吨)" prop="goodsCount">
                                <el-input v-model="UpdateProcessPaymentContractData.goodsCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="总费用金额" prop="paymentCount">
                                <el-input v-model="UpdateProcessPaymentContractData.paymentCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="updateProcessPaymentContract(secondFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeUpdateDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" :preview-teleported="true" />
        </el-dialog>
        <el-dialog v-model="moreDetailDialogFlag" title="加工付款单详情" width="55%" draggable center
            :before-close="closeMoreDetailDialog">
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        加工合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processContractNo }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        加工货物：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.goodsName }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        付款月份：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.paymentMonth }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle" style="color: rgb(42, 183, 243);">
                        总费用金额：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent" style="color: rgb(42, 183, 243);">
                        {{ processPaymentContractDetail.paymentCount }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        加工方公司名：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.customerEnterpriseName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        己方公司名：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.ownCompanyName }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        加工单价(元/吨)：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.paymentMonthPriceT }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        加工总量(吨)：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.goodsCount }}
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
                        {{
                            processPaymentContractDetail.financeStaff == null ? "暂无" :
                            processPaymentContractDetail.financeStaff
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        财务审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.financeState == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事1名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processPaymentDirector[0].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事1审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processPaymentDirector[0].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事2名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processPaymentDirector[1].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事2审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processPaymentDirector[1].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事3名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processPaymentDirector[2].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事3审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.processPaymentDirector[2].state == null ? "未处理" : "已通过✔" }}
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
                        {{
                            processPaymentContractDetail.cashier == null ? "暂无" :
                            processPaymentContractDetail.cashier
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        付款时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{
                            processPaymentContractDetail.paymentTime == null ? "未知" :
                            processPaymentContractDetail.paymentTime
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
                        {{ processPaymentContractDetail.createBy }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        创建时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.createTime }}
                    </el-col>
                </el-row>
            </div>
        </el-dialog>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, computed, onMounted, nextTick } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules, ElMessageBox } from 'element-plus'
import { Delete, Search, MoreFilled, Select, CloseBold, Edit, Upload } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { processPaymentContractModel, processPaymentDirectorModel } from '@/api/processPaymentContract/ProcessPaymentContractModel'
import { getProcessPaymentContractDataApi, searchProcessPaymentContractApi, checkProcessContractNoApi, addNewProcessPaymentContractApi, updateProcessPaymentContractApi, deleteOneProcessPaymentContractApi, changeFinanceState, changeDirectorState } from '@/api/processPaymentContract'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<processPaymentContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const updateDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const chooseProcessPaymentContractNo = ref(0)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const secondFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()
const updateDialogTop = ref<any>()
const contractExistFlag = ref(false)

const loginUserName = ref("")
const loginUserRole = ref("")
const loginUserId = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()

// 新增加工付款单
const NewProcessPaymentContractData = reactive({
    id: '',
    processContractNo: '',
    paymentMonth: '',
    paymentMonthPriceT: '',
    goodsCount: '',
    paymentCount: 0,
})

// 修改加工付款单
const UpdateProcessPaymentContractData = reactive({
    id: '',
    processContractNo: '',
    paymentMonth: '',
    paymentMonthPriceT: '',
    goodsCount: '',
    paymentCount: 0,
})

// 详情
const processPaymentContractDetail = reactive({
    id: '',
    processContractNo: '',
    paymentMonth: '',
    paymentMonthPriceT: '',
    goodsName: '',
    goodsCount: '',
    paymentCount: '',
    customerEnterpriseName: '',
    ownCompanyName: '',
    financeStaff: '',
    financeState: '',
    processPaymentDirector: reactive<processPaymentDirectorModel[]>([]),
    cashier: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    createTime: '',
    createBy: '',
})


//表单校验规则
const firstRules = reactive<FormRules>({
    processContractNo: [
        { required: true, trigger: ['change'] }
    ],
    paymentMonth: [
        { required: true, trigger: ['change'] }
    ],
    paymentMonthPriceT: [
        { required: true, trigger: ['change'] }
    ],
    goodsCount: [
        { required: true, trigger: ['change'] }
    ],
    paymentCount: [
        { required: true, trigger: ['change'] }
    ],
})

NewProcessPaymentContractData.paymentCount = computed(() => {
    const temp = Number(NewProcessPaymentContractData.paymentMonthPriceT) * Number(NewProcessPaymentContractData.goodsCount)
    return temp
});

UpdateProcessPaymentContractData.paymentCount = computed(() => {
    const temp = Number(UpdateProcessPaymentContractData.paymentMonthPriceT) * Number(UpdateProcessPaymentContractData.goodsCount)
    return temp
});

const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
}

onMounted(() => {
    getTableData();
    loginUserName.value = userNickNameStore.user.nickName;
    loginUserRole.value = userNickNameStore.user.roleNames
    loginUserId.value = userNickNameStore.user.id
})

const stateAvailable = (row: any) => {
    if (row.financeState == null) {
        for (let i = 0; i < loginUserRole.value.length; i++) {
            if (loginUserRole.value[i] == '财务') {
                return false;
            }
        }
    } else {
        for (let i = 0; i < loginUserRole.value.length; i++) {
            if (loginUserRole.value[i] == '董事会') {
                return JudgmentRepeated(row);
            }
        }
    }
    return true;
}

//审批通过，根据身份修改加工付款单响应审核状态
const changeState = (row: any) => {
    if (row.financeState == null) {
        for (let i = 0; i < loginUserRole.value.length; i++) {
            if (loginUserRole.value[i] == '财务') {
                ElMessageBox.confirm(
                    '您确定要通过吗?',
                    {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        title: '系统提示'
                    }
                ).then(() => {
                    changeFinanceState(row.id, loginUserName.value).then(res => {
                        ElMessage({
                            message: "已通过",
                            type: 'success',
                            duration: 3000
                        })
                        getTableData();
                    });
                })
            }
        }
    } else {
        for (let i = 0; i < loginUserRole.value.length; i++) {
            if (loginUserRole.value[i] == '董事会') {
                ElMessageBox.confirm(
                    '您确定要通过吗?',
                    {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        title: '系统提示'
                    }
                ).then(() => {
                    changeDirectorState(row.id, loginUserId.value).then(res => {
                        ElMessage({
                            message: "已通过",
                            type: 'success',
                            duration: 3000
                        })
                        getTableData();
                    })
                })
            }
        }
    }
}

//判断董事会审批是否重复
const JudgmentRepeated = (row: any) => {
    console.log(userNickNameStore.user.roleNames)
    for (var i = 0; i < row.processPaymentDirector.length; i++) {
        if (row.processPaymentDirector[i].userId == userNickNameStore.user.id) {
            if (row.processPaymentDirector[i].state == null) {
                return false;
            } else {
                return true;
            }
        }
    }
    return true;
}

// 获取董事会是否已审批
// const directorState = (director: any) => {
//     for (let i = 0; i < director.length; i++) {
//         if (director[i].state == 1) {
//             return true;
//         }
//     }
//     return false;
// }

// 获取加工付款单数据
const getTableData = () => {
    changeLoadingTrue();
    getProcessPaymentContractDataApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        changeLoadingFalse();
    });
}


// 搜索加工付款单数据
const searchTableData = () => {
    if (searchData.value == null || searchData.value == '') {
        ElMessage({
            message: '请输入关键词再进行搜索！',
            type: 'warning',
            duration: 4000
        })
    } else {
        changeLoadingTrue();
        searchProcessPaymentContractApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开新增加工付款单窗口
const openAddDialog = () => {
    addDialogFlag.value = true
}

// 验证加工合同是否存在
const checkProcessContractNo = (e: any) => {
    checkProcessContractNoApi(e).then(res => {
        contractExistFlag.value = res.data
        if (res.data == false) {
            ElMessage({
                message: '所填加工合同编号不存在，请检查！',
                type: 'error',
                grouping: true,
                duration: 1000
            })
        } else {
            ElMessage({
                message: '验证合法！',
                type: 'success',
            })
        }
    })
}

// 发送新增加工付款单请求
const sendNewProcessPaymentContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (contractExistFlag.value == true) {
                changeLoadingTrue();
                console.log(NewProcessPaymentContractData);
                addNewProcessPaymentContractApi(NewProcessPaymentContractData).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '新增加工付款单成功！',
                            type: 'success',
                        })
                        getTableData();
                        closeAddDialog();
                    }
                    else {
                        ElMessage({
                            message: '新增加工付款单失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                })
            } else {
                ElMessage({
                    message: '不存在相应加工合同，请检查！',
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

// 发送修改加工付款单请求
const updateProcessPaymentContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (contractExistFlag.value == true) {
                changeLoadingTrue();
                console.log(UpdateProcessPaymentContractData);
                updateProcessPaymentContractApi(UpdateProcessPaymentContractData).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '修改加工付款单成功！',
                            type: 'success',
                        })
                        getTableData();
                        closeUpdateDialog();
                    }
                    else {
                        ElMessage({
                            message: '修改加工付款单失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                })
            } else {
                ElMessage({
                    message: '不存在相应加工合同，请检查！',
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


// 打开加工付款单详情窗口
const openMordDetailDialog = async (row: any) => {
    console.log(row.processPaymentDirector);
    processPaymentContractDetail.processContractNo = row.processContractNo
    processPaymentContractDetail.paymentMonth = row.paymentMonth
    processPaymentContractDetail.paymentMonthPriceT = row.paymentMonthPriceT
    processPaymentContractDetail.goodsName = row.goodsName
    processPaymentContractDetail.goodsCount = row.goodsCount
    processPaymentContractDetail.paymentCount = row.paymentCount
    processPaymentContractDetail.customerEnterpriseName = row.customerEnterpriseName
    processPaymentContractDetail.ownCompanyName = row.ownCompanyName
    processPaymentContractDetail.financeStaff = row.financeStaff
    processPaymentContractDetail.financeState = row.financeState
    processPaymentContractDetail.processPaymentDirector = row.processPaymentDirector
    processPaymentContractDetail.cashier = row.cashier
    processPaymentContractDetail.paymentTime = dateConversion(row.paymentTime)
    processPaymentContractDetail.paymentPhotoArray = row.paymentPhotoArray
    processPaymentContractDetail.createTime = timeConversion(row.createTime)
    processPaymentContractDetail.createBy = row.createBy
    moreDetailDialogFlag.value = true
}

const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开加工付款单修改窗口
const openUpdateDialog = async (row: any) => {
    updateDialogFlag.value = true;
    contractExistFlag.value = true;
    // 赋值必须要在窗口显示后，否则会被认定为初始值
    nextTick(() => {
        UpdateProcessPaymentContractData.id = row.id
        UpdateProcessPaymentContractData.processContractNo = row.processContractNo
        UpdateProcessPaymentContractData.paymentMonth = row.paymentMonth
        UpdateProcessPaymentContractData.paymentMonthPriceT = row.paymentMonthPriceT
        UpdateProcessPaymentContractData.goodsCount = row.goodsCount
        UpdateProcessPaymentContractData.paymentCount = row.paymentCount
    })
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: processPaymentContractModel) => {
    ElMessageBox.confirm(
        '您确定要删除该笔加工付款单吗?',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            title: '系统提示'
        }
    ).then(() => {
        chooseProcessPaymentContractNo.value = row.id;
        oneDeleteProcessPayment()
    });
}

// 发送单个删除请求
const oneDeleteProcessPayment = () => {
    changeLoadingTrue();
    deleteOneProcessPaymentContractApi(chooseProcessPaymentContractNo.value).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
            ElMessage({
                message: '删除加工付款单成功！',
                type: 'success',
            })
            getTableData();
        }
        else {
            ElMessage({
                message: '删除加工付款单失败！',
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
    AddReturnTop();
    firstFormRef.value?.resetFields();
    contractExistFlag.value = false;
}

// 新增窗口滑动回最顶端
const AddReturnTop = () => {
    addDialogTop.value.scrollTop = 0;
}

// 关闭修改窗口
const closeUpdateDialog = () => {
    updateDialogFlag.value = false;
    UpdateReturnTop();
    secondFormRef.value?.resetFields();
    contractExistFlag.value = false;
}

// 修改窗口滑动回最顶端
const UpdateReturnTop = () => {
    updateDialogTop.value.scrollTop = 0;
}

const uploadFalse = () => {
    ElMessage({
        message: '上传文件失败！',
        type: 'error',
        duration: 4000
    })
}

const uploadSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
    changeLoadingFalse();
    if (response.code == 200) {
        ElMessage({
            message: '批量插入加工付款单成功！',
            type: 'success',
        })
        getTableData();
    } else {
        let msg = '';
        response.data.map((item: any) => msg = msg + item + '<p>');
        ElMessage({
            dangerouslyUseHTMLString: true,
            message: msg,
            type: 'error',
            duration: 0,
            showClose: true,
        })
    }
}

const operateStatus = ref<boolean>(true)
//改变operateStatus
const changeOperateStatus = () => {
    operateStatus.value = !operateStatus.value
}
</script>

<style scoped>
.processPaymentContract {
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

.processContractTable {
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