<template>
    <div class="officeExpense" v-loading="loading">
        <div class="headerGroup">
            <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
                新增
            </el-button>
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的办公经费单信息"
                @keyup.enter="searchTableData">
                <template #append>
                    <el-button :icon="Search" @click="searchTableData" />
                </template>
            </el-input>
            <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
            </el-button>
        </div>
        <el-table ref="firstTableRef" class="purchaseContractTable" :data="firstTableData" style="width: 98%"
            :border="true" highlight-current-row>
            <!-- 暂时隐藏index -->
            <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
            <el-table-column property="itemsList" align="center" label="支出项目清单" />
            <el-table-column property="expenses" align="center" label="支出金额总计" />
            <el-table-column property="time" :formatter="conversionDate" align="center" label="日期" width="105" />
            <el-table-column label="财务审核状态" align="center">
                <template #default="scope">{{ scope.row.financeState == null ? "未处理" : "已通过✔" }}</template>
            </el-table-column>
            <el-table-column align="center" label="董事1审核状态">
                <template #default="scope">
                    {{ scope.row.officeDirector[0].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事2审核状态">
                <template #default="scope">
                    {{ scope.row.officeDirector[1].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事3审核状态">
                <template #default="scope">
                    {{ scope.row.officeDirector[2].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="付款金额">
                <template #default="scope">
                    {{ scope.row.paymentCount == null ? "0" : scope.row.paymentCount }}
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
            <el-table-column align="center" label="操作" width="390" fixed="right">
                <template #default="scope">
                    <el-button :icon="Select" size="default" type="success" @click="changeState(scope.row)"
                        :disabled="stateAvailable(scope.row)!">
                        通过
                    </el-button>
                    <el-button :icon="MoreFilled" size="default" type="primary"
                        @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
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
                :page-sizes="[5, 10, 20, 50, 100]" :background="background"
                layout="total, sizes, prev, pager, next, jumper" :total="total"
                @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
                @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()" />
        </div>
        <el-dialog v-model="addDialogFlag" title="新增办公经费单" width="40%" draggable center :before-close="closeAddDialog">
            <ul ref="addDialogTop" style="overflow: auto;height:170px;padding: 0;">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="120px"
                    :model="NewOfficeExpenseData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="日期" prop="time">
                                <el-date-picker type="date" placeholder="下拉选择" v-model="NewOfficeExpenseData.time"
                                    :disabled-date="disabledDate" style="width: 100%;" value-format="YYYY-MM-DD"
                                    size="large">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="支出项目清单" prop="itemsList">
                                <el-input v-model="NewOfficeExpenseData.itemsList" type="textarea" autosize
                                    size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="支出金额总计" prop="expenses">
                                <el-input v-model="NewOfficeExpenseData.expenses" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendNewOfficeExpense(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="updateDialogFlag" title="修改办公经费单" width="40%" draggable center
            :before-close="closeUpdateDialog">
            <ul ref="updateDialogTop" style="overflow: auto;height:170px;padding: 0;">
                <el-form ref="secondFormRef" :rules="firstRules" label-position="right" label-width="120px"
                    :model="UpdateOfficeExpenseData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="日期" prop="time">
                                <el-date-picker type="date" placeholder="下拉选择" v-model="UpdateOfficeExpenseData.time"
                                    :disabled-date="disabledDate" style="width: 100%;" value-format="YYYY-MM-DD"
                                    size="large">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="支出项目清单" prop="itemsList">
                                <el-input v-model="UpdateOfficeExpenseData.itemsList" type="textarea" autosize
                                    size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="支出金额总计" prop="expenses">
                                <el-input v-model="UpdateOfficeExpenseData.expenses" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="updateOfficeExpense(secondFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeUpdateDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" :preview-teleported="true" />
        </el-dialog>
        <el-dialog v-model="moreDetailDialogFlag" title="办公经费单详情" width="55%" draggable center
            :before-close="closeMoreDetailDialog">
            <div>
                <el-row justify="center">
                    <el-col style="textAlign:center" class="moreDetailTitle">
                        支出项目清单：
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col style="textAlign:center" class="moreDetailContent">
                        {{ officeExpenseDetail.itemsList }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        支出金额总计：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.expenses }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        日期：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.time }}
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
                        {{ officeExpenseDetail.financeStaff == null ? "暂无" :
        officeExpenseDetail.financeStaff
}}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        财务审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.financeState == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事1名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.officeDirector[0].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事1审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.officeDirector[0].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事2名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.officeDirector[1].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事2审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.officeDirector[1].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事3名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.officeDirector[2].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事3审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.officeDirector[2].state == null ? "未处理" : "已通过✔" }}
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
                        {{ officeExpenseDetail.cashier == null ? "暂无" :
        officeExpenseDetail.financeStaff
}}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        付款时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.paymentTime == null ? "未知" :
        officeExpenseDetail.paymentTime
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
                        {{ officeExpenseDetail.createBy }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        创建时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ officeExpenseDetail.createTime }}
                    </el-col>
                </el-row>
            </div>
        </el-dialog>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, nextTick } from 'vue'
import { ElTable, ElMessage, FormInstance, FormRules, ElMessageBox } from 'element-plus'
import { Delete, Search, MoreFilled, Select, Edit } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { officeExpenseModel, officeExpenseDirectorModel } from '@/api/officeExpense/officeExpenseModel'
import { getOfficeExpenseDataApi, searchOfficeExpenseApi, addNewOfficeExpenseApi, updateOfficeExpenseApi, deleteOneOfficeExpenseApi, changeDirectorState, changeFinanceState } from '@/api/officeExpense'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<officeExpenseModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const updateDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const chooseOfficeExpenseNo = ref(0)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const secondFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()
const updateDialogTop = ref<any>()

const loginUserName = ref("")
const loginUserRole = ref("")
const loginUserId = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()

// 新增办公经费单
const NewOfficeExpenseData = reactive({
    id: '',
    itemsList: '',
    expenses: '',
    time: '',
    createBy: '',
    lastUpdateBy: '',
})

// 修改办公经费
const UpdateOfficeExpenseData = reactive({
    id: '',
    itemsList: '',
    expenses: '',
    time: '',
    createBy: '',
    lastUpdateBy: '',
})

// 详情
const officeExpenseDetail = reactive({
    id: '',
    itemsList: '',
    expenses: '',
    time: '',
    financeStaff: '',
    financeState: '',
    officeDirector: reactive<officeExpenseDirectorModel[]>([]),
    cashier: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    createTime: '',
    createBy: '',
})


//表单校验规则
const firstRules = reactive<FormRules>({
    itemsList: [
        { required: true, trigger: ['change'] }
    ],
    expenses: [
        { required: true, trigger: ['change'] }
    ],
    time: [
        { required: true, trigger: ['change'] }
    ],
})

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

//审批通过，根据身份修改采购付款单响应审核状态
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
    for (let i = 0; i < row.officeDirector.length; i++) {
        if (row.officeDirector[i].userId == userNickNameStore.user.id) {
            if (row.officeDirector[i].state == null) {
                return false;
            } else {
                return true;
            }
        }
    }
    return true;
}

// 获取办公经费单数据
const getTableData = () => {
    changeLoadingTrue();
    getOfficeExpenseDataApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        console.log(res.data.records);
        changeLoadingFalse();
    });
}


// 搜索办公经费单数据
const searchTableData = () => {
    if (searchData.value == null || searchData.value == '') {
        ElMessage({
            message: '请输入关键词再进行搜索！',
            type: 'warning',
            duration: 4000
        })
    } else {
        changeLoadingTrue();
        searchOfficeExpenseApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开新增办公经费单窗口
const openAddDialog = () => {
    addDialogFlag.value = true
}


// 发送新增办公经费单请求
const sendNewOfficeExpense = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            changeLoadingTrue();
            NewOfficeExpenseData.createBy = loginUserName.value;
            console.log(NewOfficeExpenseData);
            addNewOfficeExpenseApi(NewOfficeExpenseData).then(res => {
                changeLoadingFalse();
                if (res.data == 1) {
                    ElMessage({
                        message: '新增办公经费单成功！',
                        type: 'success',
                    })
                    getTableData();
                    closeAddDialog();
                }
                else {
                    ElMessage({
                        message: '新增办公经费单失败！',
                        type: 'error',
                        duration: 4000
                    })
                }
            })
        } else {
            ElMessage({
                message: '表单验证未通过，请检查！',
                type: 'error',
                duration: 4000
            })
        }
    })
}

// 打开办公经费单详情窗口
const openMordDetailDialog = async (row: any) => {
    officeExpenseDetail.id = row.id
    officeExpenseDetail.itemsList = row.itemsList
    officeExpenseDetail.expenses = row.expenses
    officeExpenseDetail.time = dateConversion(row.time)
    officeExpenseDetail.financeState = row.financeState
    officeExpenseDetail.officeDirector = row.officeDirector
    officeExpenseDetail.cashier = row.cashier
    officeExpenseDetail.paymentTime = dateConversion(row.paymentTime)
    officeExpenseDetail.paymentPhotoArray = row.paymentPhotoArray
    officeExpenseDetail.createTime = timeConversion(row.createTime)
    officeExpenseDetail.createBy = row.createBy
    moreDetailDialogFlag.value = true
}

const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开办公经费单修改窗口
const openUpdateDialog = async (row: any) => {
    updateDialogFlag.value = true;
    // 赋值必须要在窗口显示后，否则会被认定为初始值
    nextTick(() => {
        UpdateOfficeExpenseData.id = row.id
        UpdateOfficeExpenseData.itemsList = row.itemsList
        UpdateOfficeExpenseData.expenses = row.expenses
        UpdateOfficeExpenseData.time = dateConversion(row.time)
    })
}

// 发送修改办公经费单请求
const updateOfficeExpense = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            changeLoadingTrue();
            UpdateOfficeExpenseData.lastUpdateBy = loginUserName.value;
            console.log(UpdateOfficeExpenseData);
            updateOfficeExpenseApi(UpdateOfficeExpenseData).then(res => {
                changeLoadingFalse();
                if (res.data == 1) {
                    ElMessage({
                        message: '修改办公经费单成功！',
                        type: 'success',
                    })
                    getTableData();
                    closeUpdateDialog();
                }
                else {
                    ElMessage({
                        message: '修改办公经费单失败！',
                        type: 'error',
                        duration: 4000
                    })
                }
            })
        } else {
            ElMessage({
                message: '表单验证未通过，请检查！',
                type: 'error',
                duration: 4000
            })
        }
    })
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: officeExpenseModel) => {
    ElMessageBox.confirm(
        '您确定要删除该笔办公经费单吗?',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            title: '系统提示'
        }
    ).then(() => {
        chooseOfficeExpenseNo.value = row.id;
        oneDeleteOfficeExpense()
    });
}

// 发送单个删除请求
const oneDeleteOfficeExpense = () => {
    changeLoadingTrue();
    deleteOneOfficeExpenseApi(chooseOfficeExpenseNo.value).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
            ElMessage({
                message: '删除办公经费单成功！',
                type: 'success',
            })
            getTableData();
        }
        else {
            ElMessage({
                message: '删除办公经费单失败！',
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
}

// 关闭修改窗口
const closeUpdateDialog = () => {
    updateDialogFlag.value = false;
    UpdateReturnTop();
    secondFormRef.value?.resetFields();
}

// 新增窗口滑动回最顶端
const AddReturnTop = () => {
    addDialogTop.value.scrollTop = 0;
}

// 修改窗口滑动回最顶端
const UpdateReturnTop = () => {
    updateDialogTop.value.scrollTop = 0;
}

</script>

<style scoped>
.officeExpense {
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