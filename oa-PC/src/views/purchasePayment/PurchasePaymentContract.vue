<template>
    <div class="purchasePaymentContract" v-loading="loading">
        <div class="headerGroup">
            <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
                新增
            </el-button>
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的采购付款单信息"
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
            <el-table-column label="采购合同编号" align="center" width="120">
                <template #default="scope">{{ scope.row.purchaseContractNo }}</template>
            </el-table-column>
            <el-table-column property="paymentAmount" align="center" label="采购总价" />
            <el-table-column property="paymentCount" align="center" label="本次付款金额" />
            <el-table-column property="customerEnterpriseName" align="center" label="供货方公司名" width="140" />
            <el-table-column property="ownCompanyName" align="center" label="己方公司名" width="140" />
            <el-table-column property="squeezeSeason" align="center" label="榨季" />
            <el-table-column property="inboundTime" :formatter="conversionDate" align="center" label="入库时间"
                width="105" />
            <el-table-column property="goodsName" align="center" label="采购货物名称" />
            <el-table-column property="goodsCount" align="center" label="采购货物数量" />
            <el-table-column property="goodsUnit" align="center" label="采购货物单位" />
            <el-table-column label="财务审核状态" align="center">
                <template #default="scope">{{ scope.row.financeState == null ? "未处理" : "已通过✔" }}</template>
            </el-table-column>
            <el-table-column align="center" label="董事1审核状态">
                <template #default="scope">
                    {{ scope.row.purchasePaymentDirector[0].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事2审核状态">
                <template #default="scope">
                    {{ scope.row.purchasePaymentDirector[1].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事3审核状态">
                <template #default="scope">
                    {{ scope.row.purchasePaymentDirector[2].state == null ? "未处理" : "已通过✔" }}
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
                        :disabled="loginUserRole == '财务' ? (scope.row.financeState == null ? false : true) : (loginUserRole == '董事会' ? (scope.row.financeState == 1 ? JudgmentRepeated(scope.row) : true) : true)">
                        通过
                    </el-button>
                    <el-button :icon="MoreFilled" size="default" type="primary"
                        @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
                    <!-- <el-button :icon="Edit" size="default" type="info" @click="openUpdateDialog(scope.row)"
                        :disabled="scope.row.cashier != null ? true : (scope.row.financeStaff != null ? true : directorState(scope.row.purchasePaymentDirector))">修改
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
                :page-sizes="[5, 10, 20, 50, 100]" :background="background"
                layout="total, sizes, prev, pager, next, jumper" :total="total"
                @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
                @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()" />
        </div>
        <el-dialog v-model="addDialogFlag" title="新增采购付款单" width="40%" draggable center :before-close="closeAddDialog">
            <ul ref="addDialogTop" style="overflow: auto;height:120px;padding: 0;">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="120px"
                    :model="NewPurchasePaymentContractData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <!-- 验证采购合同号是否存在 -->
                            <el-form-item label="采购合同编号" prop="purchaseContractNo">
                                <el-input v-model="NewPurchasePaymentContractData.purchaseContractNo" size="large"
                                    :suffix-icon="contractExistFlag ? 'Select' : 'CloseBold'"
                                    @input="checkPurchaseContractNo" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="本次付款金额" prop="paymentCount">
                                <el-input v-model="NewPurchasePaymentContractData.paymentCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendNewPurchasePaymentContract(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="updateDialogFlag" title="修改采购付款单" width="40%" draggable center
            :before-close="closeUpdateDialog">
            <ul ref="updateDialogTop" style="overflow: auto;height:120px;padding: 0;">
                <el-form ref="secondFormRef" :rules="firstRules" label-position="right" label-width="120px"
                    :model="UpdatePurchasePaymentContractData" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <!-- 验证采购合同号是否存在 -->
                            <el-form-item label="采购合同编号" prop="purchaseContractNo">
                                <el-input v-model="UpdatePurchasePaymentContractData.purchaseContractNo" size="large"
                                    :suffix-icon="contractExistFlag ? 'Select' : 'CloseBold'"
                                    @input="checkPurchaseContractNo" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="本次付款金额" prop="paymentCount">
                                <el-input v-model="UpdatePurchasePaymentContractData.paymentCount" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="updatePurchasePaymentContract(secondFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeUpdateDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" :preview-teleported="true" />
        </el-dialog>
        <el-dialog v-model="moreDetailDialogFlag" title="采购付款单详情" width="55%" draggable center
            :before-close="closeMoreDetailDialog">
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        采购合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchaseContractNo }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        采购货物名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.goodsName }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        采购总价：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.paymentAmount }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle" style="color: rgb(42, 183, 243);">
                        本次付款金额：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent" style="color: rgb(42, 183, 243);">
                        {{ purchasePaymentContractDetail.paymentCount }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        采购货物数量：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.goodsCount }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        采购货物单位：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.goodsUnit }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        供货方公司名：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.customerEnterpriseName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        己方公司名：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.ownCompanyName }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        榨季：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.squeezeSeason }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        入库时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.inboundTime }}
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
                        {{ purchasePaymentContractDetail.financeStaff == null ? "暂无" :
                                purchasePaymentContractDetail.financeStaff
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        财务审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.financeState == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事1名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchasePaymentDirector[0].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事1审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchasePaymentDirector[0].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事2名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchasePaymentDirector[1].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事2审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchasePaymentDirector[1].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事3名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchasePaymentDirector[2].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事3审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.purchasePaymentDirector[2].state == null ? "未处理" : "已通过✔" }}
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
                        {{ purchasePaymentContractDetail.cashier == null ? "暂无" :
                                purchasePaymentContractDetail.cashier
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        付款时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.paymentTime == null ? "未知" :
                                purchasePaymentContractDetail.paymentTime
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
                        {{ purchasePaymentContractDetail.createBy }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        创建时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.createTime }}
                    </el-col>
                </el-row>
            </div>
        </el-dialog>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, nextTick } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules, ElMessageBox } from 'element-plus'
import { Delete, Search, MoreFilled, Select, CloseBold, Edit } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { purchasePaymentContractModel, purchasePaymentDirectorModel } from '@/api/purchasePaymentContract/PurchasePaymentContractModel'
import { getPurchasePaymentContractDataApi, searchPurchasePaymentContractApi, checkPurchaseContractNoApi, addNewPurchasePaymentContractApi, updatePurchasePaymentContractApi, deleteOnePurchasePaymentContractApi, changeFinanceState, changeDirectorState } from '@/api/purchasePaymentContract'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<purchasePaymentContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const updateDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const choosePurchasePaymentContractNo = ref(0)
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

// 新增采购付款单
const NewPurchasePaymentContractData = reactive({
    id: '',
    purchaseContractNo: '',
    paymentCount: '',
    createBy: ''
})

// 修改采购付款单
const UpdatePurchasePaymentContractData = reactive({
    id: '',
    purchaseContractNo: '',
    paymentCount: '',
    createBy: ''
})

// 详情
const purchasePaymentContractDetail = reactive({
    id: '',
    purchaseContractNo: '',
    paymentAmount: '',
    paymentCount: '',
    customerEnterpriseName: '',
    ownCompanyName: '',
    squeezeSeason: '',
    inboundTime: '',
    goodsName: '',
    goodsCount: '',
    goodsUnit: '',
    financeStaff: '',
    financeState: '',
    purchasePaymentDirector: reactive<purchasePaymentDirectorModel[]>([]),
    cashier: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    createTime: '',
    createBy: '',
})


//表单校验规则
const firstRules = reactive<FormRules>({
    purchaseContractNo: [
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
const changeState = (row: any) => {
    if (loginUserRole.value == '财务') {
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

    } else if (loginUserRole.value == '董事会') {
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

//判断董事会审批是否重复
const JudgmentRepeated = (row: any) => {
    console.log(userNickNameStore.user.roleNames)
    for (var i = 0; i < row.purchasePaymentDirector.length; i++) {
        if (row.purchasePaymentDirector[i].userId == userNickNameStore.user.id) {
            if (row.purchasePaymentDirector[i].state == null) {
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

// 获取采购付款单数据
const getTableData = () => {
    changeLoadingTrue();
    getPurchasePaymentContractDataApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        changeLoadingFalse();
    });
}


// 搜索采购付款单数据
const searchTableData = () => {
    if (searchData.value == null || searchData.value == '') {
        ElMessage({
            message: '请输入关键词再进行搜索！',
            type: 'warning',
            duration: 4000
        })
    } else {
        changeLoadingTrue();
        searchPurchasePaymentContractApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开新增采购付款单窗口
const openAddDialog = () => {
    addDialogFlag.value = true
}

// 验证采购合同是否存在
const checkPurchaseContractNo = (e: any) => {
    checkPurchaseContractNoApi(e).then(res => {
        contractExistFlag.value = res.data
        if (res.data == false) {
            ElMessage({
                message: '所填采购合同编号不存在，请检查！',
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

// 发送新增采购付款单请求
const sendNewPurchasePaymentContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (contractExistFlag.value == true) {
                changeLoadingTrue();
                NewPurchasePaymentContractData.createBy = loginUserName.value;
                console.log(NewPurchasePaymentContractData);
                addNewPurchasePaymentContractApi(NewPurchasePaymentContractData).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '新增采购付款单成功！',
                            type: 'success',
                        })
                        getTableData();
                        closeAddDialog();
                    }
                    else {
                        ElMessage({
                            message: '新增采购付款单失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                })
            } else {
                ElMessage({
                    message: '不存在相应采购合同，请检查！',
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

// 发送修改采购付款单请求
const updatePurchasePaymentContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (contractExistFlag.value == true) {
                changeLoadingTrue();
                console.log(UpdatePurchasePaymentContractData);
                updatePurchasePaymentContractApi(UpdatePurchasePaymentContractData).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '修改采购付款单成功！',
                            type: 'success',
                        })
                        getTableData();
                        closeUpdateDialog();
                    }
                    else {
                        ElMessage({
                            message: '修改采购付款单失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                })
            } else {
                ElMessage({
                    message: '不存在相应采购合同，请检查！',
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


// 打开采购付款单详情窗口
const openMordDetailDialog = async (row: any) => {
    console.log(row.purchasePaymentDirector);
    purchasePaymentContractDetail.purchaseContractNo = row.purchaseContractNo
    purchasePaymentContractDetail.paymentAmount = row.paymentAmount
    purchasePaymentContractDetail.paymentCount = row.paymentCount
    purchasePaymentContractDetail.customerEnterpriseName = row.customerEnterpriseName
    purchasePaymentContractDetail.ownCompanyName = row.ownCompanyName
    purchasePaymentContractDetail.squeezeSeason = row.squeezeSeason
    purchasePaymentContractDetail.inboundTime = dateConversion(row.inboundTime)
    purchasePaymentContractDetail.goodsName = row.goodsName
    purchasePaymentContractDetail.goodsCount = row.goodsCount
    purchasePaymentContractDetail.goodsUnit = row.goodsUnit
    purchasePaymentContractDetail.financeStaff = row.financeStaff
    purchasePaymentContractDetail.financeState = row.financeState
    purchasePaymentContractDetail.purchasePaymentDirector = row.purchasePaymentDirector
    purchasePaymentContractDetail.cashier = row.cashier
    purchasePaymentContractDetail.paymentTime = dateConversion(row.paymentTime)
    purchasePaymentContractDetail.paymentPhotoArray = row.paymentPhotoArray
    purchasePaymentContractDetail.createTime = timeConversion(row.createTime)
    purchasePaymentContractDetail.createBy = row.createBy
    moreDetailDialogFlag.value = true
}

const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开采购付款单修改窗口
const openUpdateDialog = async (row: any) => {
    updateDialogFlag.value = true;
    contractExistFlag.value = true;
    // 赋值必须要在窗口显示后，否则会被认定为初始值
    nextTick(() => {
        UpdatePurchasePaymentContractData.id = row.id
        UpdatePurchasePaymentContractData.purchaseContractNo = row.purchaseContractNo
        UpdatePurchasePaymentContractData.paymentCount = row.paymentCount
    })
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: purchasePaymentContractModel) => {
    ElMessageBox.confirm(
        '您确定要删除该笔采购付款单吗?',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            title: '系统提示'
        }
    ).then(() => {
        choosePurchasePaymentContractNo.value = row.id;
        oneDeletePurchasePayment()
    });
}

// 发送单个删除请求
const oneDeletePurchasePayment = () => {
    changeLoadingTrue();
    deleteOnePurchasePaymentContractApi(choosePurchasePaymentContractNo.value).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
            ElMessage({
                message: '删除采购付款单成功！',
                type: 'success',
            })
            getTableData();
        }
        else {
            ElMessage({
                message: '删除采购付款单失败！',
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

</script>

<style scoped>
.purchasePaymentContract {
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