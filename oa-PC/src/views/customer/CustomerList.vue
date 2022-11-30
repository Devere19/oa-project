<template>
    <div class="customer" v-loading="loading">
        <div class="headerGroup">
            <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
                新增
            </el-button>
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的客户信息"
                @keyup.enter="searchTableData">
                <template #append>
                    <el-button :icon="Search" @click="searchTableData" />
                </template>
            </el-input>
            <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
            </el-button>
        </div>
        <el-table ref="firstTableRef" class="customerTable" :data="firstTableData" style="width: 98%" border="true"
            highlight-current-row>
            <!-- 暂时隐藏index -->
            <!-- <el-table-column type="index" align="center" label="ID" width="50%" /> -->
            <el-table-column property="customerEnterpriseName" align="center" label="公司名称" />
            <el-table-column property="customerName" align="center" label="联系人" />
            <el-table-column property="customerPhone" align="center" label="联系方式" />
            <el-table-column property="customerAddress" align="center" label="邮寄地址" width="140" />
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
                layout="total, sizes, prev, pager, next, jumper" :total="total"
                @size-change="searchData == null || searchData == '' ? getTableData() : searchTableData()"
                @current-change="searchData == null || searchData == '' ? getTableData() : searchTableData()" />
        </div>
        <el-dialog v-model="addDialogFlag" :title="addFlag ? '新增客户' : '修改信息'" width="40%" draggable center
            :before-close="closeAddDialog">
            <ul ref="addDialogTop" :style="'overflow: auto;padding: 0;height:' + addFlag ? '240px' : '300px'">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="120px"
                    :model="CustomerModel" style="max-width: 98%">
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="公司名称" prop="customerEnterpriseName">
                                <el-input v-model="CustomerModel.customerEnterpriseName" size="large"
                                    :disabled="!addFlag && !updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="联系人名称" prop="customerName">
                                <el-input v-model="CustomerModel.customerName" size="large"
                                    :disabled="!addFlag && !updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="联系方式" prop="customerPhone">
                                <el-input v-model="CustomerModel.customerPhone" size="large"
                                    :disabled="!addFlag && !updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row justify="center">
                        <el-col :span="16">
                            <el-form-item label="邮寄地址" prop="customerAddress">
                                <el-input v-model="CustomerModel.customerAddress" size="large"
                                    :disabled="!addFlag && !updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <div v-show="detailFlag">
                        <el-row justify="center">
                            <el-col :span="16">
                                <el-form-item label="创建者">
                                    {{ CustomerModel.createBy }}
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row justify="center">
                            <el-col :span="16">
                                <el-form-item label="创建时间">
                                    {{ CustomerCreateTime }}
                                </el-form-item>
                            </el-col>
                        </el-row>
                    </div>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <!-- 新增 -->
                    <el-button v-show="addFlag || updateFlag" type="primary" @click="handleCustomerData(firstFormRef)">
                        确定
                    </el-button>
                    <!-- 修改 -->
                    <el-button v-show="detailFlag && !updateFlag" type="primary" @click="updateFlag = true">
                        修改
                    </el-button>
                    <!-- 取消 -->
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="oneDeleteDialogFlag" title="提示" width="30%" draggable center>
            <span>
                您确定要删除该条客户信息吗
            </span>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="oneDeleteCustomer">
                        确定
                    </el-button>
                    <el-button @click="oneDeleteDialogFlag = false">取消</el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, nextTick } from 'vue'
import type { FormInstance, FormRules } from 'element-plus'
import { ElTable, ElMessage } from 'element-plus'
import { Delete, Search, MoreFilled } from "@element-plus/icons-vue";
import { conversionDateTime, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { customerModel } from '@/api/customer/CustomerModel'
import { getCustomerDataApi, searchCustomerApi, deleteOneCustomerApi, addNewCustomerApi, updateCustomerApi } from '@/api/customer'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<customerModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const oneDeleteDialogFlag = ref(false)
const chooseCustomerId = ref(0)
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()

const addFlag = ref(false)
const detailFlag = ref(false)
const updateFlag = ref(false)

const loginUserName = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()

// 客户
const CustomerModel = reactive({
    id: '',
    customerEnterpriseName: '',
    customerName: '',
    customerPhone: '',
    customerAddress: '',
    createBy: '',
    lastUpdateBy: ''
})

const CustomerCreateTime = ref()


//表单校验规则
const firstRules = reactive<FormRules>({
    customerEnterpriseName: [
        { required: true, trigger: ['change'] }
    ],
    customerName: [
        { required: true, trigger: ['change'] }
    ],
    customerPhone: [
        { required: true, trigger: ['change'] }
    ],
    customerAddress: [
        { required: true, trigger: ['change'] }
    ],
})

onMounted(() => {
    getTableData();
    loginUserName.value = userNickNameStore.user.nickName;
})

// 获取客户数据
const getTableData = () => {
    changeLoadingTrue();
    getCustomerDataApi(currentPage.value, pageSize.value).then(res => {
        total.value = res.data.total;//总记录
        firstTableData.value = res.data.records;
        console.log(res.data.records);
        changeLoadingFalse();
    });
}


// 搜索客户数据
const searchTableData = () => {
    if (searchData.value == null || searchData.value == '') {
        ElMessage({
            message: '请输入关键词再进行搜索！',
            type: 'warning',
            duration: 4000
        })
    } else {
        changeLoadingTrue();
        searchCustomerApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开新增客户的窗口
const openAddDialog = () => {
    addFlag.value = true
    detailFlag.value = false
    updateFlag.value = false
    addDialogFlag.value = true
}

// 打开客户详情窗口
const openMordDetailDialog = async (row: any) => {
    addFlag.value = false
    detailFlag.value = true
    updateFlag.value = false
    addDialogFlag.value = true
    // 赋值必须要在窗口显示后，否则会被认定为初始值
    nextTick(() => {
        CustomerModel.id = row.id
        CustomerModel.customerEnterpriseName = row.customerEnterpriseName
        CustomerModel.customerName = row.customerName
        CustomerModel.customerPhone = row.customerPhone
        CustomerModel.customerAddress = row.customerAddress
        CustomerModel.createBy = row.createBy
        CustomerCreateTime.value = timeConversion(row.createTime)
    })
}

// 发送新增客户请求
const handleCustomerData = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            changeLoadingTrue();
            if (!updateFlag.value) {
                CustomerModel.createBy = loginUserName.value;
                // 发送新增请求
                addNewCustomerApi(CustomerModel).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '新增客户成功！',
                            type: 'success',
                        })
                        getTableData();
                        addDialogFlag.value = false;
                        addFlag.value = false;
                        detailFlag.value = false;
                        updateFlag.value = false;
                        ReturnTop();
                        firstFormRef.value?.resetFields();
                    }
                    else {
                        ElMessage({
                            message: '新增客户失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                })
            } else {
                CustomerModel.lastUpdateBy = loginUserName.value;
                // 发送修改请求
                updateCustomerApi(CustomerModel).then(res => {
                    changeLoadingFalse();
                    if (res.data == 1) {
                        ElMessage({
                            message: '修改客户信息成功！',
                            type: 'success',
                        })
                        getTableData();
                        addDialogFlag.value = false;
                        addFlag.value = false;
                        detailFlag.value = false;
                        updateFlag.value = false;
                        ReturnTop();
                        firstFormRef.value?.resetFields();
                    }
                    else {
                        ElMessage({
                            message: '修改客户信息失败！',
                            type: 'error',
                            duration: 4000
                        })
                    }
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

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: customerModel) => {
    chooseCustomerId.value = row.id;
    oneDeleteDialogFlag.value = true
}

// 发送单个删除请求
const oneDeleteCustomer = () => {
    changeLoadingTrue();
    deleteOneCustomerApi(chooseCustomerId.value).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
            ElMessage({
                message: '删除客户信息成功！',
                type: 'success',
            })
            getTableData();
            oneDeleteDialogFlag.value = false
        }
        else if (res.data == 0) {
            ElMessage({
                message: '删除客户信息失败！',
                type: 'error',
                duration: 4000
            })
        } else if (res.data == -1) {
            ElMessage({
                message: '该客户已有相关采购单或销售单记录，无法删除！',
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

// 关闭新增修改窗口
const closeAddDialog = () => {
    firstFormRef.value?.resetFields()
    addDialogFlag.value = false;
    addFlag.value = false;
    detailFlag.value = false;
    updateFlag.value = false;
    ReturnTop();
}

// 新增窗口滑动回最顶端
const ReturnTop = () => {
    addDialogTop.value.scrollTop = 0;
}

</script>

<style scoped>
.customer {
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

.customerTable {
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
    width: 120px;
}
</style>