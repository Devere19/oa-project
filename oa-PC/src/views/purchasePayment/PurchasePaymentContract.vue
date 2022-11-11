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
            border="true" highlight-current-row>
            <!-- 暂时隐藏index -->
            <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
            <el-table-column label="采购合同编号" align="center" width="120">
                <template #default="scope">{{ scope.row.purchaseContractNo }}</template>
            </el-table-column>
            <el-table-column property="paymentAmount" align="center" label="采购总价" />
            <el-table-column property="paymentCount" align="center" label="本次付款金额" />
            <el-table-column property="customerEnterpriseName" align="center" label="供货方公司名" />
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
                        :preview-src-list="scope.row.paymentPhotoArray" fit="cover" preview-teleported="true" />
                </template>
            </el-table-column>
            <el-table-column property="createTime" :formatter="conversionDateTime" sortable align="center" label="创建时间"
                width="105" />
            <el-table-column property="createBy" align="center" label="创建者" />
            <el-table-column align="center" label="操作" width="200" fixed="right">
                <template #default="scope">
                    <el-button :icon="MoreFilled" size="default" type="primary"
                        @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
                    <el-button :icon="Delete" size="default" type="danger"
                        @click="openOneDeleteDialog(scope.$index, scope.row)">
                        删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="paginationGroup">
            <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
                :page-sizes="[5, 10, 20, 50, 100]" :background="background"
                layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="getTableData"
                @current-change="getTableData" />
        </div>
        <el-dialog v-model="addDialogFlag" title="新增采购付款单" width="40%" draggable center :before-close="closeAddDialog">
            <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="120px"
                :model="NewPurchasePaymentContractData" style="max-width: 98%">
                <el-row justify="center">
                    <el-col :span="16">
                        <!-- 验证采购合同号是否存在 -->
                        <el-form-item label="采购合同编号" prop="purchaseContractNo">
                            <el-input v-model="NewPurchasePaymentContractData.purchaseContractNo" size="large"
                                :suffix-icon="contractExistFlag ? 'Select' : 'CloseBold'"
                                @change="checkPurchaseContractNo" />
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
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendNewPurchasePaymentContract(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="oneDeleteDialogFlag" title="提示" width="30%" draggable center>
            <span>
                您确定要删除该笔采购付款单吗
            </span>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="oneDeletePurchaseContract">
                        确定
                    </el-button>
                    <el-button @click="oneDeleteDialogFlag = false">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" preview-teleported="true" />
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
                </el-row>
                <el-row justify="center">
                    <el-col :span="4" class="moreDetailTitle">
                        采购货物名称：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.goodsName }}
                    </el-col>
                    <el-col :span="4" class="moreDetailTitle">
                        采购总价：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.paymentAmount }}
                    </el-col>
                    <el-col :span="4" class="moreDetailTitle" style="color: rgb(42, 183, 243);">
                        本次付款金额：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent" style="color: rgb(42, 183, 243);">
                        {{ purchasePaymentContractDetail.paymentCount }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="4" class="moreDetailTitle">
                        供货方公司名：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.customerEnterpriseName }}
                    </el-col>
                    <el-col :span="4" class="moreDetailTitle">
                        己方公司名：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.ownCompanyName }}
                    </el-col>
                    <el-col :span="4" class="moreDetailTitle">
                        入库时间：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.inboundTime }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="4" class="moreDetailTitle">
                        榨季：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.squeezeSeason }}
                    </el-col>
                    <el-col :span="4" class="moreDetailTitle">
                        采购货物数量：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.goodsCount }}
                    </el-col>
                    <el-col :span="4" class="moreDetailTitle">
                        采购货物单位：
                    </el-col>
                    <el-col :span="4" class="moreDetailContent">
                        {{ purchasePaymentContractDetail.goodsUnit }}
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
                                purchasePaymentContractDetail.financeStaff
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
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules } from 'element-plus'
import { Delete, Search, MoreFilled, Select, CloseBold } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { deletePhotoApi } from '@/api/handlePhoto'
import { purchasePaymentContractModel, purchasePaymentDirectorModel } from '@/api/purchasePaymentContract/purchasePaymentContractModel'
import { getPurchasePaymentContractDataApi, searchPurchasePaymentContractApi, checkPurchaseContractNoApi, addNewPurchasePaymentContractApi, deleteOnePurchasePaymentContractApi } from '@/api/purchasePaymentContract'


const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<purchasePaymentContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const oneDeleteDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const choosePurchasePaymentContractNo = ref(0)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const PhotoData = ref<UploadUserFile[]>([])
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()
const contractExistFlag = ref(false)

const firstTableRef = ref<InstanceType<typeof ElTable>>()

// 新增
const NewPurchasePaymentContractData = reactive({
    id: '',
    purchaseContractNo: '',
    paymentCount: '',
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
})

// 获取采购付款单数据
const getTableData = () => {
    changeLoading();
    getPurchasePaymentContractDataApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        changeLoading();
    });
}


// 搜索采购付款单数据
const searchTableData = () => {
    changeLoading();
    searchPurchasePaymentContractApi(currentPage.value, pageSize.value, searchData.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        returnAll.value = true;
        changeLoading();
    })
}

// 搜索后，回到全部数据
const returnAllData = () => {
    getTableData();
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
        console.log(res.data);
    })
}

// 发送新增采购付款单请求
const sendNewPurchasePaymentContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (contractExistFlag.value == true) {
                changeLoading();
                console.log(NewPurchasePaymentContractData);
                addNewPurchasePaymentContractApi(NewPurchasePaymentContractData).then(res => {
                    if (res.data == 1) {
                        changeLoading();
                        getTableData();
                        addDialogFlag.value = false;
                        ReturnTop();
                        firstFormRef.value?.resetFields();
                        ElMessage({
                            message: '新增采购付款单成功！',
                            type: 'success',
                        })
                    }
                    else {
                        ElMessage({
                            message: '新增采购付款单失败！',
                            type: 'error',
                            duration: 4000
                        })
                        changeLoading();
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

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: purchasePaymentContractModel) => {
    choosePurchasePaymentContractNo.value = row.id;
    oneDeleteDialogFlag.value = true
}

// 发送单个删除请求
const oneDeletePurchaseContract = () => {
    changeLoading();
    deleteOnePurchasePaymentContractApi(choosePurchasePaymentContractNo.value).then(res => {
        changeLoading();
        if (res.data == 1) {
            getTableData();
            oneDeleteDialogFlag.value = false
            ElMessage({
                message: '删除采购付款单成功！',
                type: 'success',
            })
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

// 照片移除后发送请求后台删除照片
// const handleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
//     console.log(uploadFile, uploadFiles);
//     NewPurchasePaymentContractData.contractPhotoArray.splice(NewPurchasePaymentContractData.contractPhotoArray.indexOf(uploadFile.response.data), 1);
//     console.log("移出照片数据组");
//     deletePhotoApi(uploadFile.response.data);
// }

// 处理照片预览
// const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
//     dialogImageUrl.value = uploadFile.url!
//     previewImageFlag.value = true

// }

// 上传照片成功后加入数组
// const handlePhotoSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
//     if (response.code == 200) {
//         NewPurchasePaymentContractData.contractPhotoArray.push(response.data);
//         console.log(NewPurchasePaymentContractData.contractPhotoArray);
//         console.log("加入照片数据组");
//     }
// }

// 转变loading状态
const changeLoading = () => {
    loading.value = !loading.value;
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