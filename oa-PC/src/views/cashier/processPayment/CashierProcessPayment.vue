<template>
    <div class="processPaymentContract" v-loading="loading">
        <div class="headerGroup">
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的加工付款单信息"
                @keyup.enter="searchTableData">
                <template #append>
                    <el-button :icon="Search" @click="searchTableData" />
                </template>
            </el-input>
            <el-button class="moreDeleteButton" type="primary" @click="changeOperateStatus">
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
            <el-table-column property="paymentTime" :formatter="conversionDate" align="center" label="付款时间" width="105" />
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
            <el-table-column align="center" label="操作" width="290" fixed="right" v-if="operateStatus">
                <template #default="scope">
                    <el-button :icon="Printer" size="default" type="info" @click="openPrintDialog(scope.row)">制单
                    </el-button>
                    <el-button :icon="MoreFilled" size="default" type="primary" @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
                    <el-button :icon="Upload" size="default" type="success" :disabled="scope.row.cashier != null"
                        @click="openUploadDialog(scope.row)">
                        上传</el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="paginationGroup">
            <el-pagination v-model:currentPage="currentPage" v-model:page-size="pageSize" :hide-on-single-page="false"
                :page-sizes="[5, 10, 20, 50, 100]" :background="background" layout="total, sizes, prev, pager, next, jumper"
                :total="total" @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
                @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()" />
        </div>
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" :preview-teleported="true" />
        </el-dialog>
        <el-dialog v-model="moreDetailDialogFlag" title="加工付款单详情" width="50%" draggable center
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
                        {{ processPaymentContractDetail.financeStaff == null ? "暂无" :
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
                        {{ processPaymentContractDetail.cashier == null ? "暂无" :
                            processPaymentContractDetail.cashier
                        }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        付款时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ processPaymentContractDetail.paymentTime == null ? "未知" :
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
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" :disabled="processPaymentContractDetail.cashier != null"
                        @click="openUploadDialog">上传</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="uploadDialogFlag" title="上传窗口" width="40%" draggable center :before-close="closeUploadDialog">
            <ul ref="uploadDialogTop" style="overflow: auto;height:300px">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="150px"
                    :model="uploadPaymentData" style="max-width: 80%">
                    <el-form-item label="加工合同编号" prop="processContractNo">
                        <el-input v-model="uploadPaymentData.processContractNo" disabled size="large" />
                    </el-form-item>
                    <el-form-item label="付款时间" prop="paymentTime">
                        <el-date-picker type="date" v-model="uploadPaymentData.paymentTime" :disabledDate="disabledDate"
                            style="width: 100%;" value-format="YYYY-MM-DD" size="large"></el-date-picker>
                    </el-form-item>
                    <el-form-item label="付款流水截图">
                        <el-upload v-model:file-list="PhotoData" action="http://120.77.28.123:9000/addContractPhoto"
                            list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
                            :on-success="handlePhotoSuccess">
                            <el-icon>
                                <Plus />
                            </el-icon>
                        </el-upload>
                    </el-form-item>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendPaymentData(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeUploadDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>

        <PrintFormDialog :printDialogFlag="printDialogFlag" :formData="formData" @onClose="closePrintDialog">
        </PrintFormDialog>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules } from 'element-plus'
import { Upload, Search, MoreFilled, Printer } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
import { numberToChina } from "@/utils/chinaNumberUtil"
// import type from 'element-plus'
import { deletePhotoApi } from '@/api/handlePhoto'
import { processPaymentContractModel, processPaymentDirectorModel } from '@/api/processPaymentContract/processPaymentContractModel'
import { getCashierProcessPaymentApi, searchCashierProcessPaymentApi, uploadCashierProcessPaymentApi } from '@/api/cashier'
import { userStore } from '@/store/nickName'
import PrintFormDialog from '@/components/PrintFormDialog.vue'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<processPaymentContractModel[]>([])
const returnAll = ref(false)
const uploadDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const PhotoData = ref<UploadUserFile[]>([])
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const uploadDialogTop = ref<any>()

const loginUserName = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()

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

// 上传付款信息
const uploadPaymentData = reactive({
    id: '',
    processContractNo: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    cashier: '',
})

//表单校验规则
const firstRules = reactive<FormRules>({
    processContractNo: [
        { required: true, trigger: ['change'] }
    ],
    paymentTime: [
        { required: true, trigger: ['change'] }
    ],
})

const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
}

onMounted(() => {
    getTableData();
    loginUserName.value = userNickNameStore.user.nickName;
})

// 获取加工付款单数据
const getTableData = () => {
    changeLoadingTrue();
    getCashierProcessPaymentApi(currentPage.value, pageSize.value).then(res => {
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
        searchCashierProcessPaymentApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开加工付款单详情窗口
const openMordDetailDialog = async (row: any) => {
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
    uploadPaymentData.id = row.id
    uploadPaymentData.processContractNo = row.processContractNo
    moreDetailDialogFlag.value = true
}

// 关闭详情窗口
const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开上传窗口
const openUploadDialog = (row: any) => {
    console.log(row);
    console.log(row.processContractNo != undefined);
    if (row.processContractNo != undefined) {
        uploadPaymentData.id = row.id;
        uploadPaymentData.processContractNo = row.processContractNo;
    }
    uploadDialogFlag.value = true;
}

// 发送付款数据
const sendPaymentData = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            changeLoadingTrue();
            uploadPaymentData.cashier = loginUserName.value;
            console.log(uploadPaymentData);
            uploadCashierProcessPaymentApi(uploadPaymentData).then(res => {
                changeLoadingFalse();
                if (res.data == 1) {
                    ElMessage({
                        message: '上传数据成功！',
                        type: 'success',
                    })
                    getTableData();
                    uploadDialogFlag.value = false;
                    ReturnTop();
                    firstFormRef.value?.resetFields();
                    PhotoData.value = [];
                    uploadPaymentData.paymentPhotoArray = [];
                }
                else {
                    ElMessage({
                        message: '上传数据失败！',
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

// 关闭上传窗口
const closeUploadDialog = () => {
    uploadDialogFlag.value = false;
    ReturnTop();
    firstFormRef.value?.resetFields();
    PhotoData.value = [];
    if (uploadPaymentData.paymentPhotoArray.length != 0) {
        uploadPaymentData.paymentPhotoArray.map((item) => {
            deletePhotoApi(item);
        });
        uploadPaymentData.paymentPhotoArray = [];
    }
}

// 照片移除后发送请求后台删除照片
const handleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
    console.log(uploadFile, uploadFiles);
    uploadPaymentData.paymentPhotoArray.splice(uploadPaymentData.paymentPhotoArray.indexOf(uploadFile.response.data), 1);
    console.log("移出照片数据组");
    deletePhotoApi(uploadFile.response.data);
}

// 处理照片预览
const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
    dialogImageUrl.value = uploadFile.url!
    previewImageFlag.value = true

}

// 上传照片成功后加入数组
const handlePhotoSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
    if (response.code == 200) {
        uploadPaymentData.paymentPhotoArray.push(response.data);
        console.log(uploadPaymentData.paymentPhotoArray);
        console.log("加入照片数据组");
    }
}

// 转变loading状态
const changeLoadingTrue = () => {
    loading.value = true;
}

// 转变loading状态
const changeLoadingFalse = () => {
    loading.value = false;
}

// 新增窗口滑动回最顶端
const ReturnTop = () => {
    uploadDialogTop.value.scrollTop = 0;
}

// 按钮显示
const operateStatus = ref<boolean>(true)
//改变operateStatus
const changeOperateStatus = () => {
    operateStatus.value = !operateStatus.value
}

const printDialogFlag = ref(false)
const formData = reactive({
    ownCompanyName: "",
    agent: "",
    amount: "",
    customerEnterpriseName: "",
    director: <string[]>[],
    financeStaff: ""
})

const openPrintDialog = (row: any) => {
    printDialogFlag.value = true;
    formData.ownCompanyName = row.ownCompanyName;
    formData.agent = loginUserName.value;
    formData.amount = numberToChina(row.paymentCount);
    formData.customerEnterpriseName = row.customerEnterpriseName;
    row.processPaymentDirector.forEach((d: any) => {
        formData.director.push(d.nickName);
    });
    formData.financeStaff = row.financeStaff;
}

const closePrintDialog = () => {
    printDialogFlag.value = false;
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