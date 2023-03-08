<template>
    <div class="shippingContract" v-loading="loading">
        <div class="headerGroup">
            <el-button class="showPigeonholeButton" type="primary" @click="openAddDialog">
                新增
            </el-button>
            <el-input v-model="searchData" size="large" class="searchInput" placeholder="请输入所要查询的海运单信息"
                @keyup.enter="searchTableData">
                <template #append>
                    <el-button :icon="Search" @click="searchTableData" />
                </template>
            </el-input>
            <el-upload class="moreDeleteButton" name="file"
                action="http://120.77.28.123:9000/shippingContract/shippingImportExcel" :on-error="uploadFalse"
                :on-success="uploadSuccess" :on-progress="() => changeLoadingTrue()" :limit="1" ref="upload"
                accept=".xlsx,.xls" :show-file-list="false">
                <el-button :icon="Upload" type="primary">批量导入</el-button>
            </el-upload>
            <el-button class="moreDeleteButton" type="primary" @click="changeOperateStatus">
                {{ operateStatus ? "隐藏操作" : "显示操作" }}</el-button>
            <el-button v-show="returnAll" class="moreDeleteButton" type="danger" @click="returnAllData">返回全部
            </el-button>
        </div>
        <el-table ref="firstTableRef" class="shipppingContractTable" :data="firstTableData" style="width: 98%"
            :border="true" highlight-current-row>
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
            <el-table-column align="center" label="合同照片" width="130">
                <template #default="scope">
                    <el-image style="width: 100px; height: 100px"
                        :src="scope.row.contractPhoto == '' ? null : scope.row.contractPhoto"
                        :preview-src-list="scope.row.contractPhotoArray" fit="cover" :preview-teleported="true" />
                </template>
            </el-table-column>
            <!-- <el-table-column align="center" label="财务名称">
                <template #default="scope">
                    {{ scope.row.financeStaff == null ? "暂无" : scope.row.financeStaff }}
                </template>
            </el-table-column> -->
            <el-table-column label="财务审核状态" align="center">
                <template #default="scope">{{ scope.row.financeState == null ? "未处理" : "已通过✔" }}</template>
            </el-table-column>
            <!-- <el-table-column align="center" label="董事1名称">
                <template #default="scope">
                    {{ scope.row.shippingDirector[0].nickName }}
                </template>
            </el-table-column> -->
            <el-table-column align="center" label="董事1审核状态">
                <template #default="scope">
                    {{ scope.row.shippingDirector[0].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <!-- <el-table-column align="center" label="董事2名称">
                <template #default="scope">
                    {{ scope.row.shippingDirector[1].nickName }}
                </template>
            </el-table-column> -->
            <el-table-column align="center" label="董事2审核状态">
                <template #default="scope">
                    {{ scope.row.shippingDirector[1].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <!-- <el-table-column align="center" label="董事3名称">
                <template #default="scope">
                    {{ scope.row.shippingDirector[2].nickName }}
                </template>
            </el-table-column> -->
            <el-table-column align="center" label="董事3审核状态">
                <template #default="scope">
                    {{ scope.row.shippingDirector[2].state == null ? "未处理" : "已通过✔" }}
                </template>
            </el-table-column>
            <!-- <el-table-column align="center" label="出纳名称">
                <template #default="scope">
                    {{ scope.row.cashier == null ? "暂无" : scope.row.cashier }}
                </template>
            </el-table-column> -->
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
            <el-table-column align="center" label="操作" width="390" fixed="right" v-if="operateStatus">
                <template #default="scope">
                    <el-button :icon="Select" size="default" type="success" @click="changeState(scope.row)"
                        :disabled="stateAvailable(scope.row)!">
                        通过
                    </el-button>
                    <el-button :icon="MoreFilled" size="default" type="primary" @click="openMordDetailDialog(scope.row)">详情
                    </el-button>
                    <el-button :icon="Edit" size="default" type="info" @click="openUpdateDialog(scope.row)"
                        :disabled="(scope.row.financeStaff != null ? (scope.row.contractPhoto == null ? false : true) : false)">修改
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
        <el-dialog v-model="addDialogFlag" title="新增海运单" width="50%" draggable center :before-close="closeAddDialog">
            <ul ref="addDialogTop" style="overflow: auto;height:600px">
                <el-form ref="firstFormRef" :rules="firstRules" label-position="right" label-width="180px"
                    :model="NewShippingContractData" style="max-width: 98%">
                    <!-- <el-form label-position="right" label-width="180px" :model="NewShippingContractData"
          style="max-width: 65%;height:600px"> -->
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="海运合同编号" prop="shippingContractNo">
                                <el-input v-model="NewShippingContractData.shippingContractNo" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="物流合同编号" prop="logisticsContractNo">
                                <el-input v-model="NewShippingContractData.logisticsContractNo" size="large"
                                    :suffix-icon="logisticsContractNoFlag ? 'Select' : 'CloseBold'"
                                    @input="checkLogisticsContractNo" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="委托方" prop="principal">
                                <el-input v-model="NewShippingContractData.principal" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="装箱日期" prop="packingTime">
                                <el-date-picker type="date" placeholder="请选择装箱日期"
                                    v-model="NewShippingContractData.packingTime" :disabledDate="disabledDate"
                                    style="width: 100%;" value-format="YYYY-MM-DD" size="large"></el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="装箱地点" prop="packingLocation">
                                <el-input v-model="NewShippingContractData.packingLocation" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="卸货工厂" prop="unpackingFactory">
                                <el-input v-model="NewShippingContractData.unpackingFactory" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <!--30天内只能出现一次  -->
                            <el-form-item label="集装箱号1" prop="firstContainerNo">
                                <el-input v-model="NewShippingContractData.firstContainerNo" size="large"
                                    :suffix-icon="firstContainerSameFlag ? 'CloseBold' : 'Select'"
                                    @input="checkFirstContainerNo" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="铅封号1" prop="firstSealNo">
                                <el-input v-model="NewShippingContractData.firstSealNo" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <!--30天内只能出现一次  -->
                            <el-form-item label="集装箱号2" prop="secondContainerNo">
                                <el-input v-model="NewShippingContractData.secondContainerNo" size="large"
                                    :suffix-icon="secondContainerSameFlag ? 'CloseBold' : 'Select'"
                                    @input="checkSecondContainerNo" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="铅封号2" prop="secondSealNo">
                                <el-input v-model="NewShippingContractData.secondSealNo" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="毛重" prop="rough">
                                <el-input v-model="NewShippingContractData.rough" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="皮重" prop="tare">
                                <el-input v-model="NewShippingContractData.tare" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="净重" prop="suttle">
                                <el-input v-model="NewShippingContractData.suttle" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="理货员" prop="tallyClerk">
                                <el-input v-model="NewShippingContractData.tallyClerk" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="理货费用" prop="tallyClerkPrice">
                                <el-input v-model="NewShippingContractData.tallyClerkPrice" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="理货费用备注" prop="tallyClerkRemark">
                                <el-input v-model="NewShippingContractData.tallyClerkRemark" autosize type="textarea" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="车队管理名称" prop="fleetManageName">
                                <el-input v-model="NewShippingContractData.fleetManageName" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="起运承运车队" prop="departureFleet">
                                <el-input v-model="NewShippingContractData.departureFleet" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="起运车队费用" prop="departurePrice">
                                <el-input v-model="NewShippingContractData.departurePrice" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="承运船公司" prop="carrierCompanyName">
                                <el-input v-model="NewShippingContractData.carrierCompanyName" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="承运船费用" prop="carrierCompanyPrice">
                                <el-input v-model="NewShippingContractData.carrierCompanyPrice" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="目的港承运车队" prop="destinationPortFleet">
                                <el-input v-model="NewShippingContractData.destinationPortFleet" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="目的港车队费用" prop="destinationPortPrice">
                                <el-input v-model="NewShippingContractData.destinationPortPrice" size="large" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="总费用" prop="expenses">
                                <el-input v-model="NewShippingContractData.expenses" size="large" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="己方公司名" prop="ownCompanyName">
                                <el-select v-model="NewShippingContractData.ownCompanyName" placeholder="下拉选择" size="large">
                                    <el-option v-for="item in ownCompanyData.list" :key="item.value" :label="item.label"
                                        :value="item.value" />
                                </el-select>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item label="合同照片">
                        <el-upload v-model:file-list="AddPhotoData" action="http://120.77.28.123:9000/addContractPhoto"
                            list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="addHandleRemove"
                            :on-success="addHandlePhotoSuccess">
                            <el-icon>
                                <Plus />
                            </el-icon>
                        </el-upload>
                    </el-form-item>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="sendNewShippingContract(firstFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeAddDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
        <el-dialog v-model="updateDialogFlag" :title="updateFlag == true ? '补充合同照片' : '修改海运单'" width="50%" draggable center
            :before-close="closeUpdateDialog">
            <ul ref="updateDialogTop" style="overflow: auto;height:600px">
                <el-form ref="secondFormRef" :rules="firstRules" label-position="right" label-width="180px"
                    :model="UpdateShippingContractData" style="max-width: 98%">
                    <!-- <el-form label-position="right" label-width="180px" :model="NewShippingContractData"
          style="max-width: 65%;height:600px"> -->
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="海运合同编号" prop="shippingContractNo">
                                <el-input v-model="UpdateShippingContractData.shippingContractNo" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="物流合同编号" prop="logisticsContractNo">
                                <el-input v-model="UpdateShippingContractData.logisticsContractNo" size="large"
                                    :suffix-icon="logisticsContractNoFlag ? 'Select' : 'CloseBold'"
                                    @input="checkLogisticsContractNo" :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="委托方" prop="principal">
                                <el-input v-model="UpdateShippingContractData.principal" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="装箱日期" prop="packingTime">
                                <el-date-picker type="date" placeholder="请选择装箱日期"
                                    v-model="UpdateShippingContractData.packingTime" :disabledDate="disabledDate"
                                    style="width: 100%;" value-format="YYYY-MM-DD" size="large"
                                    :disabled="updateFlag"></el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="装箱地点" prop="packingLocation">
                                <el-input v-model="UpdateShippingContractData.packingLocation" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="卸货工厂" prop="unpackingFactory">
                                <el-input v-model="UpdateShippingContractData.unpackingFactory" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <!--30天内只能出现一次  -->
                            <el-form-item label="集装箱号1" prop="firstContainerNo">
                                <el-input v-model="UpdateShippingContractData.firstContainerNo" size="large"
                                    :suffix-icon="firstContainerSameFlag ? 'CloseBold' : 'Select'" :disabled="updateFlag"
                                    @input="checkFirstContainerNo" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="铅封号1" prop="firstSealNo">
                                <el-input v-model="UpdateShippingContractData.firstSealNo" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <!--30天内只能出现一次  -->
                            <el-form-item label="集装箱号2" prop="secondContainerNo">
                                <el-input v-model="UpdateShippingContractData.secondContainerNo" size="large"
                                    :suffix-icon="secondContainerSameFlag ? 'CloseBold' : 'Select'" :disabled="updateFlag"
                                    @input="checkSecondContainerNo" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="铅封号2" prop="secondSealNo">
                                <el-input v-model="UpdateShippingContractData.secondSealNo" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="毛重" prop="rough">
                                <el-input v-model="UpdateShippingContractData.rough" size="large" :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="皮重" prop="tare">
                                <el-input v-model="UpdateShippingContractData.tare" size="large" :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="净重" prop="suttle">
                                <el-input v-model="UpdateShippingContractData.suttle" size="large" :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="理货员" prop="tallyClerk">
                                <el-input v-model="UpdateShippingContractData.tallyClerk" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="理货费用" prop="tallyClerkPrice">
                                <el-input v-model="UpdateShippingContractData.tallyClerkPrice" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="理货费用备注" prop="tallyClerkRemark">
                                <el-input v-model="UpdateShippingContractData.tallyClerkRemark" autosize type="textarea"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="车队管理名称" prop="fleetManageName">
                                <el-input v-model="UpdateShippingContractData.fleetManageName" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="起运承运车队" prop="departureFleet">
                                <el-input v-model="UpdateShippingContractData.departureFleet" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="起运车队费用" prop="departurePrice">
                                <el-input v-model="UpdateShippingContractData.departurePrice" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="承运船公司" prop="carrierCompanyName">
                                <el-input v-model="UpdateShippingContractData.carrierCompanyName" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="承运船费用" prop="carrierCompanyPrice">
                                <el-input v-model="UpdateShippingContractData.carrierCompanyPrice" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="目的港承运车队" prop="destinationPortFleet">
                                <el-input v-model="UpdateShippingContractData.destinationPortFleet" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="目的港车队费用" prop="destinationPortPrice">
                                <el-input v-model="UpdateShippingContractData.destinationPortPrice" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="12">
                            <el-form-item label="总费用" prop="expenses">
                                <el-input v-model="UpdateShippingContractData.expenses" size="large"
                                    :disabled="updateFlag" />
                            </el-form-item>
                        </el-col>
                        <el-col :span="12">
                            <el-form-item label="己方公司名" prop="ownCompanyName">
                                <el-select v-model="UpdateShippingContractData.ownCompanyName" placeholder="下拉选择"
                                    size="large" :disabled="updateFlag">
                                    <el-option v-for="item in ownCompanyData.list" :key="item.value" :label="item.label"
                                        :value="item.value" />
                                </el-select>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-form-item label="合同照片">
                        <el-upload v-model:file-list="UpdatePhotoData" action="http://120.77.28.123:9000/addContractPhoto"
                            list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="updateHandleRemove"
                            :on-success="updateHandlePhotoSuccess">
                            <el-icon>
                                <Plus />
                            </el-icon>
                        </el-upload>
                    </el-form-item>
                </el-form>
            </ul>
            <template #footer>
                <span class="dialog-footer">
                    <el-button type="primary" @click="updateShippingContract(secondFormRef)">
                        确定
                    </el-button>
                    <el-button @click="closeUpdateDialog">取消</el-button>
                </span>
            </template>
        </el-dialog>
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
                <!-- <el-row justify="center">
                    <el-col :span="6" class="moreDetailTitle">
                        物流合同编号：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.logisticsContractNo }}
                    </el-col>
                </el-row> -->
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
                    <el-col :span="6" class="moreDetailTitle">
                        己方公司名：
                    </el-col>
                    <el-col :span="6" class="moreDetailContent">
                        {{ ShippingContractDetail.ownCompanyName }}
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
                        {{ ShippingContractDetail.cashier == null ? "暂无" : ShippingContractDetail.financeStaff }}
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
        </el-dialog>
    </div>
</template>
  
<script lang="ts" setup>
import { ref, reactive, computed, onMounted, nextTick } from 'vue'
import { ElTable, ElMessage, UploadProps, UploadUserFile, FormInstance, FormRules, ElMessageBox } from 'element-plus'
import { Delete, Search, MoreFilled, Select, CloseBold, Edit, Upload } from "@element-plus/icons-vue";
import { conversionDate, conversionDateTime, dateConversion, timeConversion } from "@/utils/timeFormat"
// import type from 'element-plus'
import { deletePhotoApi } from '@/api/handlePhoto'
import { getOwnCompanySelectApi } from "@/api/ownCompany/index"
import { shippingContractModel, shippingDirectorModel } from '@/api/shippingContract/ShippingContractModel'
import { getShippingContractDataApi, searchShippingContractApi, shippingCheckLogisticsContractNoApi, checkContainerNoApi, addNewShippingContractApi, updateShippingContractApi, deleteOneShippingContractApi, changeDirectorState, changeFinanceState } from '@/api/shippingContract'
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()

const searchData = ref("")
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(5)
const background = ref(true)
const firstTableData = ref<shippingContractModel[]>([])
const returnAll = ref(false)
const addDialogFlag = ref(false)
const updateDialogFlag = ref(false)
const moreDetailDialogFlag = ref(false)
const updateFlag = ref(true)
const chooseShippingContractNo = ref(0)
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)
const AddPhotoData = ref<UploadUserFile[]>([])
const UpdatePhotoData = ref<UploadUserFile[]>([])
const preDeletePhoto = ref<string[]>([])
const loading = ref(false)
const firstFormRef = ref<FormInstance>()
const secondFormRef = ref<FormInstance>()
const addDialogTop = ref<any>()
const updateDialogTop = ref<any>()
const firstContainerSameFlag = ref(false)
const secondContainerSameFlag = ref(false)
const logisticsContractNoFlag = ref(false)
const logisticsNoResult = ref()

const tempFirstContainer = ref();
const tempSecondContainer = ref();

const loginUserName = ref("")
const loginUserRole = ref("")
const loginUserId = ref("")

const firstTableRef = ref<InstanceType<typeof ElTable>>()

// 新增
const NewShippingContractData = reactive({
    id: '',
    shippingContractNo: '',
    oldShippingContractNo: '',
    logisticsContractNo: '',
    ownCompanyName: '',
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
    expenses: 0,
    contractPhotoArray: reactive<string[]>([]),
    onlyUpdatePhoto: '',
    createBy: '',
})

// 修改
const UpdateShippingContractData = reactive({
    id: '',
    shippingContractNo: '',
    oldShippingContractNo: '',
    logisticsContractNo: '',
    ownCompanyName: '',
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
    expenses: 0,
    contractPhotoArray: reactive<string[]>([]),
    onlyUpdatePhoto: 0,
    createBy: '',
})

// 详情
const ShippingContractDetail = reactive({
    id: '',
    shippingContractNo: '',
    logisticsContractNo: '',
    ownCompanyName: '',
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

NewShippingContractData.expenses = computed(() => {
    const temp = Number(NewShippingContractData.tallyClerkPrice) + Number(NewShippingContractData.departurePrice)
        + Number(NewShippingContractData.carrierCompanyPrice) + Number(NewShippingContractData.destinationPortPrice)
    return temp
});

UpdateShippingContractData.expenses = computed(() => {
    const temp = Number(UpdateShippingContractData.tallyClerkPrice) + Number(UpdateShippingContractData.departurePrice)
        + Number(UpdateShippingContractData.carrierCompanyPrice) + Number(UpdateShippingContractData.destinationPortPrice)
    return temp
});


//表单校验规则
const firstRules = reactive<FormRules>({
    shippingContractNo: [
        { required: true, trigger: ['change'] }
    ],
    logisticsContractNo: [
        { required: true, trigger: ['change'] }
    ],
    ownCompanyName: [
        { required: true, trigger: ['change'] }
    ],
    principal: [
        { required: true, trigger: ['change'] }
    ],
    packingTime: [
        { required: true, trigger: ['change'] }
    ],
    packingLocation: [
        { required: true, trigger: ['change'] }
    ],
    unpackingFactory: [
        { required: true, trigger: ['change'] }
    ],
    firstContainerNo: [
        { required: true, trigger: ['change'] }
    ],
    firstSealNo: [
        { required: true, trigger: ['change'] }
    ],
    rough: [
        { required: true, trigger: ['change'] }
    ],
    tare: [
        { required: true, trigger: ['change'] }
    ],
    suttle: [
        { required: true, trigger: ['change'] }
    ],
    tallyClerk: [
        { required: true, trigger: ['change'] }
    ],
    tallyClerkPrice: [
        { required: true, trigger: ['change'] }
    ],
    departureFleet: [
        { required: true, trigger: ['change'] }
    ],
    departurePrice: [
        { required: true, trigger: ['change'] }
    ],
    carrierCompanyName: [
        { required: true, trigger: ['change'] }
    ],
    carrierCompanyPrice: [
        { required: true, trigger: ['change'] }
    ],
    destinationPortFleet: [
        { required: true, trigger: ['change'] }
    ],
    destinationPortPrice: [
        { required: true, trigger: ['change'] }
    ],
    expenses: [
        { required: true, trigger: ['change'] }
    ],
})

const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
}

//定义己方公司列表数据  label和value都存公司名称
const ownCompanyData = reactive<SelectOwnCompany>({
    list: []
})

onMounted(() => {
    getTableData();
    loginUserName.value = userNickNameStore.user.nickName;
    loginUserRole.value = userNickNameStore.user.roleNames;
    loginUserId.value = userNickNameStore.user.id;

    getOwnCompanySelectApi().then(res => {
        ownCompanyData.list = res.data;
    })
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
                    changeFinanceState(row.shippingContractNo, loginUserName.value).then(res => {
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
                    changeDirectorState(row.shippingContractNo, loginUserId.value).then(res => {
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
    for (var i = 0; i < row.shippingDirector.length; i++) {
        if (row.shippingDirector[i].userId == userNickNameStore.user.id) {
            if (row.shippingDirector[i].state == null) {
                return false;
            } else {
                return true;
            }
        }
    }
    return true;
}

// 获取海运单数据
const getTableData = () => {
    changeLoadingTrue();
    getShippingContractDataApi(currentPage.value, pageSize.value).then(res => {
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
        searchShippingContractApi(currentPage.value, pageSize.value, searchData.value).then(res => {
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

// 打开新增海运单窗口
const openAddDialog = () => {
    addDialogFlag.value = true
}

// 打开修改海运单窗口
const openUpdateDialog = (row: any) => {
    console.log(row.contractPhotoArray);
    if (row.contractPhoto == null) {
        if (row.financeStaff == null) {
            updateFlag.value = false;
        } else {
            updateFlag.value = true;
        }
    } else {
        updateFlag.value = false;
    }
    logisticsContractNoFlag.value = true;
    updateDialogFlag.value = true;
    for (let i = 0; i < row.contractPhotoArray.length; i++) {
        // 当一张图片都没上传是长度为1，但内容为null，因此需要进行判断
        if (row.contractPhotoArray[i] != null) {
            UpdatePhotoData.value.push({
                name: i + '',
                url: row.contractPhotoArray[i],
            });
        }
    }
    // 赋值必须要在窗口显示后，否则会被认定为初始值
    nextTick(() => {
        UpdateShippingContractData.id = row.id
        UpdateShippingContractData.shippingContractNo = row.shippingContractNo
        UpdateShippingContractData.oldShippingContractNo = row.shippingContractNo
        UpdateShippingContractData.logisticsContractNo = row.logisticsContractNo
        UpdateShippingContractData.ownCompanyName = row.ownCompanyName
        UpdateShippingContractData.principal = row.principal
        UpdateShippingContractData.packingTime = dateConversion(row.packingTime)
        UpdateShippingContractData.packingLocation = row.packingLocation
        UpdateShippingContractData.unpackingFactory = row.unpackingFactory
        UpdateShippingContractData.firstContainerNo = row.firstContainerNo
        tempFirstContainer.value = row.firstContainerNo
        UpdateShippingContractData.firstSealNo = row.firstSealNo
        UpdateShippingContractData.secondContainerNo = row.secondContainerNo
        tempSecondContainer.value = row.secondContainerNo
        UpdateShippingContractData.secondSealNo = row.secondSealNo
        UpdateShippingContractData.rough = row.rough
        UpdateShippingContractData.tare = row.tare
        UpdateShippingContractData.suttle = row.suttle
        UpdateShippingContractData.tallyClerk = row.tallyClerk
        UpdateShippingContractData.tallyClerkPrice = row.tallyClerkPrice
        UpdateShippingContractData.tallyClerkRemark = row.tallyClerkRemark
        UpdateShippingContractData.fleetManageName = row.fleetManageName
        UpdateShippingContractData.departureFleet = row.departureFleet
        UpdateShippingContractData.departurePrice = row.departurePrice
        UpdateShippingContractData.carrierCompanyName = row.carrierCompanyName
        UpdateShippingContractData.carrierCompanyPrice = row.carrierCompanyPrice
        UpdateShippingContractData.destinationPortFleet = row.destinationPortFleet
        UpdateShippingContractData.destinationPortPrice = row.destinationPortPrice
        UpdateShippingContractData.contractPhotoArray = row.contractPhotoArray
        // 当一张图片都没上传是长度为1，但内容为null，不将null清除则会后续传输时会带上null，出现错误
        if (row.contractPhotoArray[0] == null) {
            UpdateShippingContractData.contractPhotoArray.splice(0, 1);
        }
        console.log(UpdateShippingContractData.contractPhotoArray);
        UpdateShippingContractData.createBy = row.createBy
        UpdateShippingContractData.expenses = row.expenses
    })
}

// 验证物流合同是否存在
const checkLogisticsContractNo = (e: any) => {
    shippingCheckLogisticsContractNoApi(e).then(res => {
        logisticsNoResult.value = res.data;
        if (res.data == 0) {
            logisticsContractNoFlag.value = true;
            ElMessage({
                message: '验证合法！',
                type: 'success',
            })
        } else {
            logisticsContractNoFlag.value = false;
            if (res.data == 1) {
                ElMessage({
                    message: '所填物流合同编号不存在，请检查！',
                    type: 'error',
                    grouping: true,
                    duration: 1000
                })
            } else if (res.data == 2) {
                ElMessage({
                    message: '对应的物流合同属于加工单，不合法，请检查！',
                    type: 'error',
                    grouping: true,
                    duration: 1000
                })
            }
        }
    })
}

const checkFirstContainerNo = (e: any) => {
    if (e == "" || e == null) {
        firstContainerSameFlag.value = false;
    } else {
        checkContainerNoApi(e).then(res => {
            firstContainerSameFlag.value = res.data
            if (res.data == true) {
                ElMessage({
                    message: '集装箱号1在30天内已重复，请检查！',
                    type: 'error',
                    grouping: true,
                    duration: 4000
                })
            } else {
                ElMessage({
                    message: '验证合法！',
                    type: 'success',
                    grouping: true,
                })
            }
        })
    }
}

const checkSecondContainerNo = (e: any) => {
    if (e == "" || e == null) {
        secondContainerSameFlag.value = false;
    } else {
        checkContainerNoApi(e).then(res => {
            secondContainerSameFlag.value = res.data
            if (res.data == true) {
                ElMessage({
                    message: '集装箱号2在30天内已重复，请检查！',
                    type: 'error',
                    grouping: true,
                    duration: 4000
                })
            } else {
                ElMessage({
                    message: '验证合法！',
                    type: 'success',
                    grouping: true,
                })
            }
        })
    }
}

// 发送新增海运单请求
const sendNewShippingContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (logisticsContractNoFlag.value != false) {
                if (firstContainerSameFlag.value == false && secondContainerSameFlag.value == false && NewShippingContractData.firstContainerNo != NewShippingContractData.secondContainerNo) {
                    changeLoadingTrue();
                    NewShippingContractData.createBy = loginUserName.value;
                    console.log(NewShippingContractData);
                    addNewShippingContractApi(NewShippingContractData).then(res => {
                        if (res.data == 1) {
                            changeLoadingFalse();
                            ElMessage({
                                message: '新增海运单成功！',
                                type: 'success',
                            })
                            getTableData();
                            addDialogFlag.value = false;
                            firstContainerSameFlag.value = true;
                            secondContainerSameFlag.value = true;
                            logisticsContractNoFlag.value = false;
                            AddReturnTop();
                            firstFormRef.value?.resetFields();
                            AddPhotoData.value = [];
                            NewShippingContractData.contractPhotoArray = [];
                        }
                        else {
                            changeLoadingFalse();
                            ElMessage({
                                message: '新增海运单失败！',
                                type: 'error',
                                duration: 4000
                            })
                        }
                    })
                } else {
                    if (firstContainerSameFlag.value == true) {
                        ElMessage({
                            message: '集装箱号1在30天内已重复，请检查！',
                            type: 'error',
                            duration: 4000
                        })
                    } else if (secondContainerSameFlag.value == true) {
                        ElMessage({
                            message: '集装箱号2在30天内已重复，请检查！',
                            type: 'error',
                            duration: 4000
                        })
                    } else if (NewShippingContractData.firstContainerNo == NewShippingContractData.secondContainerNo) {
                        ElMessage({
                            message: '集装箱号1和集装箱号2重复，请检查！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                }
            } else {
                if (logisticsNoResult.value == 1) {
                    ElMessage({
                        message: '所填物流合同编号不存在，请检查！',
                        type: 'error',
                        duration: 4000

                    })
                } else if (logisticsNoResult.value == 2) {
                    ElMessage({
                        message: '对应的物流合同属于加工单，不合法，请检查！',
                        type: 'error',
                        duration: 4000
                    })
                }
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

// 发送修改海运单请求
const updateShippingContract = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate((valid, fields) => {
        if (valid) {
            if (logisticsContractNoFlag.value != false) {
                if ((firstContainerSameFlag.value == false || tempFirstContainer.value == UpdateShippingContractData.firstContainerNo || (tempFirstContainer.value == UpdateShippingContractData.secondContainerNo && tempSecondContainer.value == UpdateShippingContractData.firstContainerNo) || (tempSecondContainer.value == UpdateShippingContractData.firstContainerNo && tempSecondContainer.value != UpdateShippingContractData.secondContainerNo))
                    && (secondContainerSameFlag.value == false || tempSecondContainer.value == UpdateShippingContractData.secondContainerNo || (tempFirstContainer.value == UpdateShippingContractData.secondContainerNo && tempSecondContainer.value == UpdateShippingContractData.firstContainerNo) || (tempFirstContainer.value == UpdateShippingContractData.secondContainerNo && tempFirstContainer.value != UpdateShippingContractData.firstContainerNo))
                    && UpdateShippingContractData.firstContainerNo != UpdateShippingContractData.secondContainerNo) {
                    changeLoadingTrue();
                    UpdateShippingContractData.createBy = loginUserName.value;
                    console.log(UpdateShippingContractData);
                    for (let i = 0; i < preDeletePhoto.value.length; i++) {
                        // 删除修改的照片
                        deletePhotoApi(preDeletePhoto.value[i]);
                        UpdateShippingContractData.contractPhotoArray.splice(UpdateShippingContractData.contractPhotoArray.indexOf(preDeletePhoto.value[i]), 1);
                        console.log("删除修改照片" + i);
                    }
                    if (updateFlag.value == true) {
                        UpdateShippingContractData.onlyUpdatePhoto = 1;
                    } else {
                        UpdateShippingContractData.onlyUpdatePhoto = 0;
                    }
                    updateShippingContractApi(UpdateShippingContractData).then(res => {
                        if (res.data == 1) {
                            changeLoadingFalse();
                            ElMessage({
                                message: '修改海运单成功！',
                                type: 'success',
                            })
                            getTableData();
                            updateDialogFlag.value = false;
                            firstContainerSameFlag.value = true;
                            secondContainerSameFlag.value = true;
                            logisticsContractNoFlag.value = false;
                            UpdateReturnTop();
                            secondFormRef.value?.resetFields();
                            UpdatePhotoData.value = [];
                            preDeletePhoto.value = [];
                        }
                        else {
                            changeLoadingFalse();
                            ElMessage({
                                message: '修改海运单失败！',
                                type: 'error',
                                duration: 4000
                            })
                        }
                    })
                } else {
                    if (firstContainerSameFlag.value == true) {
                        ElMessage({
                            message: '集装箱号1在30天内已重复，请检查！',
                            type: 'error',
                            duration: 4000
                        })
                    } else if (secondContainerSameFlag.value == true) {
                        ElMessage({
                            message: '集装箱号2在30天内已重复，请检查！',
                            type: 'error',
                            duration: 4000
                        })
                    } else if (UpdateShippingContractData.firstContainerNo == UpdateShippingContractData.secondContainerNo) {
                        ElMessage({
                            message: '集装箱号1和集装箱号2重复，请检查！',
                            type: 'error',
                            duration: 4000
                        })
                    }
                }
            } else {
                if (logisticsNoResult.value == 1) {
                    ElMessage({
                        message: '所填物流合同编号不存在，请检查！',
                        type: 'error',
                        duration: 4000

                    })
                } else if (logisticsNoResult.value == 2) {
                    ElMessage({
                        message: '对应的物流合同属于加工单，不合法，请检查！',
                        type: 'error',
                        duration: 4000
                    })
                }
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

// 打开海运单详情窗口
const openMordDetailDialog = async (row: any) => {
    ShippingContractDetail.shippingContractNo = row.shippingContractNo
    ShippingContractDetail.logisticsContractNo = row.logisticsContractNo
    ShippingContractDetail.ownCompanyName = row.ownCompanyName
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
    moreDetailDialogFlag.value = true
}

const closeMoreDetailDialog = () => {
    moreDetailDialogFlag.value = false;
}

// 打开单个删除提示窗口
const openOneDeleteDialog = (index: number, row: shippingContractModel) => {
    ElMessageBox.confirm(
        '您确定要删除该笔海运单吗?',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            title: '系统提示'
        }
    ).then(() => {
        chooseShippingContractNo.value = row.id;
        oneDeletePurchaseContract()
    });
}

// 发送单个删除请求
const oneDeletePurchaseContract = () => {
    changeLoadingTrue();
    deleteOneShippingContractApi(chooseShippingContractNo.value).then(res => {
        changeLoadingFalse();
        if (res.data == 1) {
            ElMessage({
                message: '删除海运单成功！',
                type: 'success',
            })
            getTableData();
        }
        else {
            ElMessage({
                message: '删除海运单失败！',
                type: 'error',
                duration: 4000
            })
        }
    })
}


// 处理照片预览
const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
    dialogImageUrl.value = uploadFile.url!
    previewImageFlag.value = true

}

// 上传照片成功后加入数组
const addHandlePhotoSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
    if (response.code == 200) {
        NewShippingContractData.contractPhotoArray.push(response.data);
        console.log(NewShippingContractData.contractPhotoArray);
        console.log("加入照片数据组");
    }
}

// 更新窗口上传照片成功后加入数组
const updateHandlePhotoSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
    if (response.code == 200) {
        UpdateShippingContractData.contractPhotoArray.push(response.data);
        console.log(UpdateShippingContractData.contractPhotoArray);
        console.log("加入照片数据组");
    }
}

// 照片移除后发送请求后台删除照片
const addHandleRemove: UploadProps['onRemove'] = (uploadFile: any, uploadFiles: any) => {
    console.log(uploadFile, uploadFiles);
    NewShippingContractData.contractPhotoArray.splice(NewShippingContractData.contractPhotoArray.indexOf(uploadFile.response.data), 1);
    console.log("移出照片数据组");
    deletePhotoApi(uploadFile.response.data);
}

// 更新窗口照片移除后发送请求后台删除照片
const updateHandleRemove: UploadProps['onRemove'] = (uploadFile: any, uploadFiles: any) => {
    console.log(uploadFile, uploadFiles);
    if (UpdateShippingContractData.contractPhotoArray.indexOf(uploadFile.url!) == -1) {
        UpdateShippingContractData.contractPhotoArray.splice(UpdateShippingContractData.contractPhotoArray.indexOf(uploadFile.response.data), 1);
        console.log("移出照片数据组");
        deletePhotoApi(uploadFile.response.data);
        console.log("删除已上传照片");
    } else {
        preDeletePhoto.value.push(uploadFile.url!);
        console.log("加入预删除照片组");
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

// 关闭新增窗口
const closeAddDialog = () => {
    addDialogFlag.value = false;
    AddReturnTop();
    firstFormRef.value?.resetFields();
    firstContainerSameFlag.value = true;
    secondContainerSameFlag.value = true;
    logisticsContractNoFlag.value = false;
    AddPhotoData.value = [];
    if (NewShippingContractData.contractPhotoArray.length != 0) {
        NewShippingContractData.contractPhotoArray.map((item) => {
            deletePhotoApi(item);
        });
        NewShippingContractData.contractPhotoArray = [];
    }
}

// 关闭修改海运单窗口
const closeUpdateDialog = () => {
    updateDialogFlag.value = false;
    UpdateReturnTop();
    logisticsContractNoFlag.value = false;
    secondFormRef.value?.resetFields();
    UpdatePhotoData.value = [];
    preDeletePhoto.value = [];
    tempFirstContainer.value = null;
    tempSecondContainer.value = null;
}

// 新增窗口滑动回最顶端
const AddReturnTop = () => {
    addDialogTop.value.scrollTop = 0;
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
            message: '批量插入海运单成功！',
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

.shipppingContractTable {
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