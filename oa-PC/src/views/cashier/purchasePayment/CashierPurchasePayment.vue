<template>
    <div class="purchasePaymentContract" v-loading="loading">
        <div class="headerGroup">
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
                    <el-button :icon="Upload" size="default" type="success" :disabled="scope.row.cashier != null"
                        @click="openUploadDialog(scope.row)">
                        上传</el-button>
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
        <el-dialog v-model="previewImageFlag">
            <el-image w-full="false" :src="dialogImageUrl" alt="Preview Image" preview-teleported="true" />
        </el-dialog>
        <el-dialog v-model="moreDetailDialogFlag" title="采购付款单详情" width="50%" draggable center
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
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary"
                        :disabled="purchasePaymentContractDetail.cashier != null || purchasePaymentContractDetail.cashier != ''"
                        @click="openUploadDialog">上传</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="uploadDialogFlag" title="上传窗口" width="40%" draggable center
            :before-close="closeUploadDialog">
            <ul ref="uploadDialogTop" style="overflow: auto;height:300px">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="150px"
                    :model="uploadPaymentData" style="max-width: 80%">
                    <el-form-item label="采购合同编号" prop="purchaseContractNo">
                        <el-input v-model="uploadPaymentData.purchaseContractNo" disabled size="large" />
                    </el-form-item>
                    <el-form-item label="付款时间" prop="paymentTime">
                        <el-date-picker type="date" placeholder="即合同实际签订日期" v-model="uploadPaymentData.paymentTime"
                            style="width: 100%;" value-format="YYYY-MM-DD" size="large"></el-date-picker>
                    </el-form-item>
                    <el-form-item label="付款流水截图">
                        <el-upload v-model:file-list="PhotoData" action="http://localhost:9000/addContractPhoto"
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
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules } from 'element-plus'
import { Upload, Search, MoreFilled } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { deletePhotoApi } from '@/api/handlePhoto'
import { purchasePaymentContractModel, purchasePaymentDirectorModel } from '@/api/purchasePaymentContract/purchasePaymentContractModel'
import { getCashierPurchasePaymentApi, searchCashierPurchasePaymentApi, uploadCashierPurchasePaymentApi } from '@/api/cashier'


const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<purchasePaymentContractModel[]>([])
const returnAll = ref(false)
const uploadDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const choosePurchasePaymentContractNo = ref(0)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const PhotoData = ref<UploadUserFile[]>([])
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const uploadDialogTop = ref<any>()

const firstTableRef = ref<InstanceType<typeof ElTable>>()

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

// 上传付款信息
const uploadPaymentData = reactive({
    id: '',
    purchaseContractNo: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
})

//表单校验规则
const firstRules = reactive<FormRules>({
    purchaseContractNo: [
        { required: true, trigger: ['change'] }
    ],
    paymentTime: [
        { required: true, trigger: ['change'] }
    ],
})

onMounted(() => {
    getTableData();
})

// 获取采购付款单数据
const getTableData = () => {
    changeLoadingTrue();
    getCashierPurchasePaymentApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        console.log(res.data.records);
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
        searchCashierPurchasePaymentApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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
    uploadPaymentData.id = row.id
    uploadPaymentData.purchaseContractNo = row.purchaseContractNo
    moreDetailDialogFlag.value = true
}

// 关闭详情窗口
const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开上传窗口
const openUploadDialog = (row: any) => {
    console.log(row);
    console.log(row.purchaseContractNo != undefined);
    if (row.purchaseContractNo != undefined) {
        uploadPaymentData.id = row.id;
        uploadPaymentData.purchaseContractNo = row.purchaseContractNo;
    }
    uploadDialogFlag.value = true;
}

const sendPaymentData = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            console.log(uploadPaymentData);
            changeLoadingTrue();
            uploadCashierPurchasePaymentApi(uploadPaymentData).then(res => {
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