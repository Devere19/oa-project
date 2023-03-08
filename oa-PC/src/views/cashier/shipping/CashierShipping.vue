<template>
    <div class="shippingContract" v-loading="loading">
        <div class="headerGroup">
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的海运单信息"
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
        <el-table ref="firstTableRef" class="purchaseContractTable" :data="firstTableData" style="width: 98%" :border="true"
            highlight-current-row>
            <!-- 暂时隐藏index -->
            <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
            <el-table-column label="海运合同编号" align="center" width="120">
                <template #default="scope">{{ scope.row.shippingContractNo }}</template>
            </el-table-column>
            <el-table-column property="logisticsContractNo" align="center" label="物流合同编号" width="120" />
            <el-table-column property="ownCompanyName" align="center" label="己方公司名" width="140" />
            <el-table-column property="principal" align="center" label="委托方" />
            <el-table-column property="packingTime" :formatter="conversionDate" align="center" label="装箱日期" width="105" />
            <el-table-column property="packingLocation" align="center" label="装箱地点" width="100" />
            <el-table-column property="unpackingFactory" align="center" label="卸箱工厂" width="100" />
            <el-table-column property="firstContainerNo" align="center" label="集装箱号1" width="110" />
            <el-table-column property="firstSealNo" align="center" label="铅封号1" width="90" />
            <el-table-column property="secondContainerNo" align="center" label="集装箱号2" width="110" />
            <el-table-column property="secondSealNo" align="center" label="铅封号2" width="90" />
            <el-table-column property="rough" align="center" label="毛重" width="100" />
            <el-table-column property="tare" align="center" label="皮重" width="100" />
            <el-table-column property="suttle" align="center" label="净重" width="100" />
            <el-table-column property="tallyClerk" align="center" label="理货员" width="90" />
            <el-table-column property="tallyClerkPrice" align="center" label="理货费用" width="100" />
            <el-table-column property="tallyClerkRemark" align="center" label="理货费用备注" width="200" show-overflow-tooltip />
            <el-table-column property="fleetManageName" align="center" label="车队管理名称" />
            <el-table-column property="departureFleet" align="center" label="起运承运车队" />
            <el-table-column property="departurePrice" align="center" label="起运车队费用" />
            <el-table-column property="carrierCompanyName" align="center" label="承运船公司" />
            <el-table-column property="carrierCompanyPrice" align="center" label="承运船费用" />
            <el-table-column property="destinationPortFleet" align="center" label="目的港承运车队" />
            <el-table-column property="destinationPortPrice" align="center" label="目的港车队费用" />
            <el-table-column property="expenses" align="center" label="总费用" />
            <!-- <el-table-column align="center" label="合同照片" width="130">
                <template #default="scope">
                    <el-image style="width: 100px; height: 100px"
                        :src="scope.row.contractPhoto == '' ? null : scope.row.contractPhoto"
                        :preview-src-list="scope.row.contractPhotoArray" fit="cover" preview-teleported="true" />
                </template>
            </el-table-column> -->
            <el-table-column label="财务审核状态" align="center">
                <template #default="scope">{{ scope.row.financeState == null ? "未处理" : "已通过✔" }}</template>
            </el-table-column>
            <el-table-column align="center" label="董事1审核状态">
                <template #default="scope">
                    {{ scope.row.shippingDirector[0].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事2审核状态">
                <template #default="scope">
                    {{ scope.row.shippingDirector[1].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <el-table-column align="center" label="董事3审核状态">
                <template #default="scope">
                    {{ scope.row.shippingDirector[2].state == null ? "未处理" : "已通过✔" }}
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
        <el-dialog v-model="moreDetailDialogFlag" title="海运单详情" width="50%" draggable center
            :before-close="closeMoreDetailDialog">
            <!-- <el-divider content-position="center">基本信息</el-divider> -->
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        海运合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingContractNo }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        物流合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.logisticsContractNo }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        委托方：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.principal }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        装箱日期：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.packingTime }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        装箱地点：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.packingLocation }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        卸货工厂：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.unpackingFactory }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        集装箱号1：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.firstContainerNo }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        铅封号1：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.firstSealNo }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        集装箱号2：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.secondContainerNo }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        铅封号2：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.secondSealNo }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        毛重：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.rough }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        皮重：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.tare }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        净重：
                    </el-col>
                    <el-col :span="18" class="moreDetailContent">
                        {{ ShippingContractDetail.suttle }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        理货员：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.tallyClerk }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        理货费用：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.tallyClerkPrice }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        理货费用备注：
                    </el-col>
                    <el-col :span="18" class="moreDetailContent">
                        {{ ShippingContractDetail.tallyClerkRemark }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        车队管理名称：
                    </el-col>
                    <el-col :span="18" class="moreDetailContent">
                        {{ ShippingContractDetail.fleetManageName }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        起运承运车队：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.departureFleet }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        起运车队费用：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.departurePrice }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        承运船公司：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.carrierCompanyName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        承运船费用：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.carrierCompanyPrice }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        目的港承运车队：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.destinationPortFleet }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        目的港车队费用：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.destinationPortPrice }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        总费用：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.expenses }}
                    </el-col>
                </el-row>
            </div>
            <!-- <el-divider content-position="center">审核情况</el-divider> -->
            <el-divider />
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        财务名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.financeStaff == null ? "暂无" : ShippingContractDetail.financeStaff }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        财务审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.financeState == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事1名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingDirector[0].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事1审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingDirector[0].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事2名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingDirector[1].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事2审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingDirector[1].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        董事3名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingDirector[2].nickName }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        董事3审核状态：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.shippingDirector[2].state == null ? "未处理" : "已通过✔" }}
                    </el-col>
                </el-row>
            </div>
            <el-divider />
            <div>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        付款金额：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.paymentCount == null ? "0" : ShippingContractDetail.paymentCount }}
                    </el-col>
                </el-row>
                <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        出纳名称：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.cashier == null ? "暂无" : ShippingContractDetail.cashier }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        付款时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.paymentTime == null ? "未知" : ShippingContractDetail.paymentTime }}
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
                        {{ ShippingContractDetail.createBy }}
                    </el-col>
                    <el-col :span="6" class="moreDetailTitle">
                        创建时间：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.createTime }}
                    </el-col>
                </el-row>
            </div>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" :disabled="ShippingContractDetail.cashier != null"
                        @click="openUploadDialog">上传</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="uploadDialogFlag" title="上传窗口" width="40%" draggable center :before-close="closeUploadDialog">
            <ul ref="uploadDialogTop" style="overflow: auto;height:300px">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="150px"
                    :model="uploadPaymentData" style="max-width: 80%">
                    <el-form-item label="海运合同编号" prop="shippingContractNo">
                        <el-input v-model="uploadPaymentData.shippingContractNo" disabled size="large" />
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
import { shippingContractModel, shippingDirectorModel } from '@/api/shippingContract/ShippingContractModel'
import { getCashierShippingApi, searchCashierShippingApi, uploadCashierShippingApi, getLogisticsCustomerApi } from '@/api/cashier'
import { userStore } from '@/store/nickName'
import PrintFormDialog from '@/components/PrintFormDialog.vue'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<shippingContractModel[]>([])
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
const ShippingContractDetail = reactive({
    id: '',
    shippingContractNo: '',
    logisticsContractNo: '',
    principal: '',
    packingTime: '',
    packingLocation: '',
    unpackingFactory: '',
    firstContainerNo: '',
    firstSealNo: '',
    secondContainerNo: '',
    secondSealNo: '',
    rough: '',
    tare: '',
    suttle: '',
    tallyClerk: '',
    tallyClerkPrice: '',
    tallyClerkRemark: '',
    fleetManageName: '',
    departureFleet: '',
    departurePrice: '',
    carrierCompanyName: '',
    carrierCompanyPrice: '',
    destinationPortFleet: '',
    destinationPortPrice: '',
    expenses: '',
    contractPhotoArray: reactive<string[]>([]),
    financeStaff: '',
    financeState: '',
    shippingDirector: reactive<shippingDirectorModel[]>([]),
    cashier: '',
    paymentCount: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    createTime: '',
    createBy: '',
})

// 上传付款信息
const uploadPaymentData = reactive({
    id: '',
    shippingContractNo: '',
    paymentTime: '',
    paymentPhotoArray: reactive<string[]>([]),
    cashier: '',
})

//表单校验规则
const firstRules = reactive<FormRules>({
    shippingContractNo: [
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
    console.log("页面挂载");
})

// 获取海运单数据
const getTableData = () => {
    changeLoadingTrue();
    getCashierShippingApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        changeLoadingFalse();
    });
}


// 搜索海运单数据
const searchTableData = () => {
    if (searchData.value == null || searchData.value == '') {
        ElMessage({
            message: '请输入关键词再进行搜索！',
            type: 'warning',
            duration: 4000
        })
    } else {
        changeLoadingTrue();
        searchCashierShippingApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开海运单详情窗口
const openMordDetailDialog = async (row: any) => {
    ShippingContractDetail.shippingContractNo = row.shippingContractNo
    ShippingContractDetail.logisticsContractNo = row.logisticsContractNo
    ShippingContractDetail.principal = row.principal
    ShippingContractDetail.packingTime = dateConversion(row.packingTime)
    ShippingContractDetail.packingLocation = row.packingLocation
    ShippingContractDetail.unpackingFactory = row.unpackingFactory
    ShippingContractDetail.firstContainerNo = row.firstContainerNo
    ShippingContractDetail.firstSealNo = row.firstSealNo
    ShippingContractDetail.secondContainerNo = row.secondContainerNo
    ShippingContractDetail.secondSealNo = row.secondSealNo
    ShippingContractDetail.rough = row.rough
    ShippingContractDetail.tare = row.tare
    ShippingContractDetail.suttle = row.suttle
    ShippingContractDetail.tallyClerk = row.tallyClerk
    ShippingContractDetail.tallyClerkPrice = row.tallyClerkPrice
    ShippingContractDetail.tallyClerkRemark = row.tallyClerkRemark
    ShippingContractDetail.fleetManageName = row.fleetManageName
    ShippingContractDetail.departureFleet = row.departureFleet
    ShippingContractDetail.departurePrice = row.departurePrice
    ShippingContractDetail.carrierCompanyName = row.carrierCompanyName
    ShippingContractDetail.carrierCompanyPrice = row.carrierCompanyPrice
    ShippingContractDetail.destinationPortFleet = row.destinationPortFleet
    ShippingContractDetail.destinationPortPrice = row.destinationPortPrice
    ShippingContractDetail.expenses = row.expenses
    ShippingContractDetail.contractPhotoArray = row.contractPhotoArray
    ShippingContractDetail.financeStaff = row.financeStaff
    ShippingContractDetail.financeState = row.financeState
    ShippingContractDetail.shippingDirector = row.shippingDirector
    ShippingContractDetail.cashier = row.cashier
    ShippingContractDetail.paymentCount = row.paymentCount
    ShippingContractDetail.paymentTime = dateConversion(row.paymentTime)
    ShippingContractDetail.paymentPhotoArray = row.paymentPhotoArray
    ShippingContractDetail.createTime = timeConversion(row.createTime)
    ShippingContractDetail.createBy = row.createBy
    uploadPaymentData.id = row.id
    uploadPaymentData.shippingContractNo = row.shippingContractNo
    moreDetailDialogFlag.value = true
}

// 关闭详情窗口
const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开上传窗口
const openUploadDialog = (row: any) => {
    console.log(row);
    console.log(row.shippingContractNo != undefined);
    if (row.shippingContractNo != undefined) {
        uploadPaymentData.id = row.id;
        uploadPaymentData.shippingContractNo = row.shippingContractNo;
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
            uploadCashierShippingApi(uploadPaymentData).then(res => {
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
const handleRemove: UploadProps['onRemove'] = (uploadFile: any, uploadFiles: any) => {
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
    formData.amount = numberToChina(row.expenses);
    getLogisticsCustomerApi(row.logisticsContractNo).then(res => {
        formData.customerEnterpriseName = res.data
    })
    row.shippingDirector.forEach((d: any) => {
        formData.director.push(d.nickName);
    });
    formData.financeStaff = row.financeStaff;
}

const closePrintDialog = () => {
    printDialogFlag.value = false;
}

</script>
  
<style scoped>
.shippingContract {
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