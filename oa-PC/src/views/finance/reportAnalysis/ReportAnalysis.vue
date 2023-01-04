<template>
    <div class="reportAnalysis" v-loading="loading">
        <div>
            <el-form label-position="right" label-width="60px" class="formGroup">
                <el-row justify="center">
                    <el-col :span="12">
                        <el-form-item label="类型:">
                            <el-select v-model="dataType" placeholder="下拉选择" size="large" @change="changeType">
                                <el-option label="整体业务" value="0"></el-option>
                                <el-option v-show="dataCompany == '0' || dataCompany == undefined" label="办公经费"
                                    value="1"></el-option>
                                <!-- <el-option v-show="dataCompany != '1' && dataCompany != '2' && dataCompany != '3'"
                                    label="办公经费" value="1"></el-option> -->
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="公司:">
                            <el-select v-model="dataCompany" placeholder="下拉选择" size="large" @change="changeCompany">
                                <el-option v-for="item in ownCompanyData"
                                    v-show="item.label != '总体' ? (dataType != '1' ? true : false) : true"
                                    :key="item.value" :label="item.label" :value="item.value" />
                                <!-- <el-option label="总体" value="0"></el-option>
                                <el-option v-show="dataType != '1'" label="广西永湘物流有限公司" value="1"></el-option>
                                <el-option v-show="dataType != '1'" label="广西南宁锦泰行工贸有限公司" value="2"></el-option>
                                <el-option v-show="dataType != '1'" label="广西丰沣顺国际物流有限公司" value="3"></el-option> -->
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>
        <div class="dataGroup">
            <div class="dataItem">
                <div class="dataContent" style="background-color: #35A9CE;">
                    <div class="contentGroup">
                        <span class="subTitle">
                            收入：
                        </span>
                        <span class="content">
                            {{ numberData[0].income }}
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            {{ numberData[0].spend }}
                        </span>
                    </div>
                    <div class="detailButton"
                        @click="(dataType != undefined && dataCompany != undefined) ? openDetailDialog(1) : ''">
                        查看细则
                    </div>
                </div>
                <div class="dataTitle">
                    日报
                </div>
            </div>
            <div class="dataItem">
                <div class="dataContent" style="background-color: #FFDF24;">
                    <div class="contentGroup">
                        <span class="subTitle">
                            收入：
                        </span>
                        <span class="content">
                            {{ numberData[1].income }}
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            {{ numberData[1].spend }}
                        </span>
                    </div>
                    <div class="detailButton"
                        @click="(dataType != undefined && dataCompany != undefined) ? openDetailDialog(2) : ''">
                        查看细则
                    </div>
                </div>
                <div class="dataTitle">
                    月报
                </div>
            </div>
            <div class="dataItem">
                <div class="dataContent" style="background-color: #D0E07D;">
                    <div class="contentGroup">
                        <span class="subTitle">
                            收入：
                        </span>
                        <span class="content">
                            {{ numberData[2].income }}
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            {{ numberData[2].spend }}
                        </span>
                    </div>
                    <div class="detailButton"
                        @click="(dataType != undefined && dataCompany != undefined) ? openDetailDialog(3) : ''">
                        查看细则
                    </div>
                </div>
                <div class="dataTitle">
                    季报
                </div>
            </div>
            <div class="dataItem">
                <div class="dataContent" style="background-color: #EF5AA1;">
                    <div class="contentGroup">
                        <span class="subTitle">
                            收入：
                        </span>
                        <span class="content">
                            {{ numberData[3].income }}
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            {{ numberData[3].spend }}
                        </span>
                    </div>
                    <div class="detailButton"
                        @click="(dataType != undefined && dataCompany != undefined) ? openDetailDialog(4) : ''">
                        查看细则
                    </div>
                </div>
                <div class="dataTitle">
                    年报
                </div>
            </div>
        </div>
        <div>
            <el-tabs type="border-card" @tab-click="handleTabChange">
                <el-tab-pane label="日" v-show=true name="0">
                    <div class="chartGroup">
                        <div ref="firstChartRef" class="chartItem"></div>
                        <el-date-picker v-model="choosedDay" value-format="YYYY-MM-DD" type="daterange"
                            :disabled-date="disabledDate" unlink-panels range-separator="To" start-placeholder="开始日期"
                            end-placeholder="结束日期" size="large" @change="changeDay" />
                    </div>
                </el-tab-pane>
                <el-tab-pane label="月" name="1">
                    <div class="chartGroup">
                        <div ref="secondChartRef" class="chartItem"></div>
                        <el-date-picker v-model="choosedMonth" value-format="YYYY-MM" type="monthrange"
                            :disabled-date="disabledDate" unlink-panels range-separator="To" start-placeholder="开始月份"
                            end-placeholder="结束月份" size="large" @change="changeMonth" />
                    </div>
                </el-tab-pane>
                <el-tab-pane label="季" name="2">
                    <div class="chartGroup">
                        <div ref="thirdChartRef" class="chartItem"></div>
                        <div class="rowCenterGroup">
                            <el-date-picker v-model="choosedSStartYear" value-format="YYYY" type="year"
                                :disabled-date="disabledDate" placeholder="开始年份" size="large" @change="changeSSYear" />
                            <el-select v-model="choosedStartSeason" placeholder="开始季度" size="large"
                                @change="changeSseason">
                                <el-option label="第一季度" value="1"></el-option>
                                <el-option label="第二季度" value="2"></el-option>
                                <el-option label="第三季度" value="3"></el-option>
                                <el-option label="第四季度" value="4"></el-option>
                            </el-select>
                            <span>&nbsp;&nbsp;To&nbsp;&nbsp;</span>
                            <el-date-picker v-model="choosedSEndYear" value-format="YYYY" type="year"
                                :disabled-date="disabledDate" placeholder="结束年份" size="large" @change="changeSEYear" />
                            <el-select v-model="choosedEndSeason" placeholder="结束季度" size="large"
                                @change="changeEseason">
                                <el-option label="第一季度" value="1"></el-option>
                                <el-option label="第二季度" value="2"></el-option>
                                <el-option label="第三季度" value="3"></el-option>
                                <el-option label="第四季度" value="4"></el-option>
                            </el-select>
                        </div>
                    </div>
                </el-tab-pane>
                <el-tab-pane label="年" name="3">
                    <div class="chartGroup">
                        <div ref="fourthChartRef" class="chartItem"></div>
                        <div class="rowCenterGroup">
                            <el-date-picker v-model="choosedYStartYear" value-format="YYYY" type="year"
                                :disabled-date="disabledDate" placeholder="开始年份" size="large" @change="changeYSYear" />
                            <span>&nbsp;&nbsp;To&nbsp;&nbsp;</span>
                            <el-date-picker v-model="choosedYEndYear" value-format="YYYY" type="year"
                                :disabled-date="disabledDate" placeholder="结束年份" size="large" @change="changeYEYear" />
                        </div>
                    </div>
                </el-tab-pane>
            </el-tabs>
        </div>
    </div>

    <el-dialog v-model="detialDialogFlag" width="70%" top="5vh" draggable center :before-close="closeDetailDialog">
        <ul style="overflow: auto;height:750px;padding: 0;">
            <div class="detailContent">
                <div class="headerGroup">
                    <div v-show="dayPickerFlag" class="pickerGroup">
                        <el-date-picker v-model="detailDay" type="date" value-format="YYYY-MM-DD"
                            :disabled-date="disabledDate" placeholder="选择日期" size="large" @change="changeDetailDay" />
                    </div>
                    <div v-show="monthPickerFlag" class="pickerGroup">
                        <el-date-picker v-model="detailMonth" type="month" value-format="YYYY-MM"
                            :disabled-date="disabledDate" placeholder="选择月份" size="large" @change="changeDetailMonth" />
                    </div>
                    <div v-show="seasonPickerFlag" class="pickerGroup">
                        <div class="rowCenterGroup">
                            <el-date-picker v-model="detailSYear" type="year" value-format="YYYY"
                                :disabled-date="disabledDate" placeholder="选择年份" size="large"
                                @change="changeDetailSYear" />
                            <el-select v-model="detailSSeason" placeholder="选择季度" size="large"
                                @change="changeDetailSSeason">
                                <el-option label="第一季度" value="1"></el-option>
                                <el-option label="第二季度" value="2"></el-option>
                                <el-option label="第三季度" value="3"></el-option>
                                <el-option label="第四季度" value="4"></el-option>
                            </el-select>
                        </div>
                    </div>
                    <div v-show="yearPickerFlag" class="pickerGroup">
                        <el-date-picker v-model="detailYear" type="year" value-format="YYYY"
                            :disabled-date="disabledDate" placeholder="选择年份" size="large" @change="changeDetailYear" />
                    </div>
                    <el-button class="exportButton" :icon="Download" type="success" @click="exportExcel">导出
                    </el-button>
                </div>
                <el-row v-show="dataType == '0'" class="detailRow">
                    <el-col>
                        <span class="detailSubTitle">
                            收入如下：
                        </span>
                    </el-col>
                </el-row>
                <el-table v-show="dataType == '0'" ref="incomeTableRef" :data="incomeTableData" border stripe
                    size="default" height="250px" style="width: 90%" highlight-current-row>
                    <el-table-column type="index" align="center" label="ID" width="90%" />
                    <el-table-column prop="saleContractNo" align="center" label="销售单合同编号"></el-table-column>
                    <el-table-column align="center" label="销售方公司名">
                        <template #default="scope">
                            <span>{{ scope.row.customerEnterpriseName }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="ownCompanyName" label="己方公司名" align="center"></el-table-column>
                    <el-table-column prop="revenueAmount" label="收款金额" align="center"></el-table-column>
                    <el-table-column prop="revenueTime" label="收款时间" :formatter="conversionDate" align="center">
                    </el-table-column>
                    <el-table-column prop="revenuePhoto" label="收款流水单截图" width="130" align="center">
                        <template #default="scope">
                            <el-image style="width: 80px; height: 80px"
                                :src="scope.row.revenuePhoto == '' ? null : scope.row.revenuePhoto"
                                :preview-src-list="scope.row.revenuePhotoList" fit="cover" :preview-teleported="true" />
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" align="center" width="120">
                        <template #default="scope">
                            <el-button type="primary" :icon="MoreFilled" size="default"
                                @click="openSaleDetail(scope.row)">详情
                            </el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-row class="detailRow">
                    <el-col>
                        <span class="detailSubTitle">
                            支出如下：
                        </span>
                    </el-col>
                </el-row>
                <el-table v-show="dataType == '0'" ref="spendTableRef" :data="spendTableData" border stripe
                    size="default" height="350px" style="width: 90%" highlight-current-row>
                    <el-table-column type="index" align="center" label="ID" width="90%" />
                    <el-table-column prop="type" label="支出类型" align="center" />
                    <el-table-column prop="ownCompanyName" label="己方公司名" width="140" align="center" />
                    <el-table-column prop="relationContractNo" label="采购/物流/海运合同编号" width="180" align="center" />
                    <el-table-column prop="paymentCount" label="付款金额" align="center" />
                    <el-table-column prop="paymentTime" label="付款时间" :formatter="conversionDate" align="center" />
                    <el-table-column align="center" label="付款流水截图" width="130">
                        <template #default="scope">
                            <el-image style="width: 80px; height: 80px"
                                :src="scope.row.paymentPhoto == '' ? null : scope.row.paymentPhoto"
                                :preview-src-list="scope.row.paymentPhotoArray" fit="cover"
                                :preview-teleported="true" />
                        </template>
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" align="center" width="120">
                        <template #default="scope">
                            <el-button type="primary" :icon="MoreFilled" size="default"
                                @click="scope.row.type == '采购付款单' ? openPurchaseDetail(scope.row) : scope.row.type == '加工付款单' ? openProcessDetail(scope.row) : scope.row.type == '物流付款单' ? openLogisticsDetail(scope.row) : openShippingDetail(scope.row)">
                                详情
                            </el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-table v-show="dataType == '1'" ref="officeTableRef" :data="officeTableData" height="650px"
                    style="width: 90%" border stripe size="default" highlight-current-row>
                    <el-table-column type="index" align="center" label="ID" width="90%" />
                    <el-table-column property="itemsList" align="center" label="支出项目清单" />
                    <el-table-column property="expenses" align="center" label="支出金额总计" />
                    <el-table-column property="time" :formatter="conversionDate" align="center" label="日期" />
                    <el-table-column prop="paymentCount" align="center" label="付款金额" />
                    <el-table-column property="paymentTime" :formatter="conversionDate" align="center" label="付款时间" />
                    <el-table-column align="center" label="付款流水截图" width="130">
                        <template #default="scope">
                            <el-image style="width: 100px; height: 100px"
                                :src="scope.row.paymentPhoto == '' ? null : scope.row.paymentPhoto"
                                :preview-src-list="scope.row.paymentPhotoArray" fit="cover"
                                :preview-teleported="true" />
                        </template>
                    </el-table-column>
                    <el-table-column align="center" label="操作" width="130" fixed="right">
                        <template #default="scope">
                            <el-button :icon="MoreFilled" size="default" type="primary"
                                @click="openOfficeDetail(scope.row)">详情
                            </el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
        </ul>
    </el-dialog>
    <el-dialog v-model="saleDialogFlag" title="销售单详情" width="55%" draggable center :before-close="closeSaleDetail">
        <div>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    销售合同编号：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.saleContractNo }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    销售货物名称：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.goodsName }}
                </el-col>
            </el-row>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    销售货物数量：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.goodsCount }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    销售货物单位：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.goodsUnit }}
                </el-col>
            </el-row>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    销售货物单价：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.goodsUnitPrice }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle" style="color: rgb(42, 183, 243);">
                    销售货物总价：
                </el-col>
                <el-col :span="6" class="moreDetailContent" style="color: rgb(42, 183, 243);">
                    {{ saleContractDetail.goodsTotalPrice }}
                </el-col>
            </el-row>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    供货方公司名：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.customerEnterpriseName }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    己方公司名：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.ownCompanyName }}
                </el-col>
            </el-row>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    榨季：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.squeezeSeason }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    合同时间：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.saleContractTime }}
                </el-col>
            </el-row>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    结款方式：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.paymentMethod }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    运输方式：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.transportMethod }}
                </el-col>
            </el-row>
        </div>
        <el-divider />
        <div>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    收款金额：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.revenueAmount == null ? "0" : saleContractDetail.revenueAmount }}
                </el-col>
            </el-row>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    出纳名称：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.revenueBy == null ? "暂无" :
        saleContractDetail.revenueBy
}}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    收款时间：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.revenueTime == null ? "未知" :
        saleContractDetail.revenueTime
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
                    {{ saleContractDetail.createBy }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    创建时间：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ saleContractDetail.createTime }}
                </el-col>
            </el-row>
        </div>
    </el-dialog>
    <el-dialog v-model="purchaseDialogFlag" title="采购付款单详情" width="55%" draggable center
        :before-close="closePurchaseDetail">
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
    <el-dialog v-model="processDialogFlag" title="加工付款单详情" width="55%" draggable center
        :before-close="closeProcessDetail">
        <div>
            <el-row justify="center">
                <el-col :span="6" class="moreDetailTitle">
                    加工合同编号：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ processPaymentContractDetail.processContractNo }}
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
    </el-dialog>
    <el-dialog v-model="logisticsDialogFlag" title="物流付款单详情" width="55%" draggable center
        :before-close="closeLogisticsDetail">
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
                    加工/销售合同编号：
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
        logisticsPaymentContractDetail.cashier
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
    <el-dialog v-model="shippingDialogFlag" title="海运单详情" width="50%" draggable center
        :before-close="closeShippingDetail">
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
                    集装箱号：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ ShippingContractDetail.containerNo }}
                </el-col>
                <el-col :span="6" class="moreDetailTitle">
                    铅封号：
                </el-col>
                <el-col :span="6" class="moreDetailContent">
                    {{ ShippingContractDetail.sealNo }}
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
    </el-dialog>
    <el-dialog v-model="officeDialogFlag" title="办公经费单详情" width="55%" draggable center
        :before-close="closeOfficeDetail">
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
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElTable, ElMessage } from 'element-plus'
import { MoreFilled, Download } from "@element-plus/icons-vue";
import { conversionDate, dateConversion, timeConversion } from "@/utils/timeFormat"
import { purchasePaymentDirectorModel } from '@/api/purchasePaymentContract/PurchasePaymentContractModel'
import { logisticsPaymentDirectorModel } from '@/api/logisticsPaymentContract/LogisticsPaymentContractModel'
import { shippingDirectorModel } from '@/api/shippingContract/ShippingContractModel'
import { officeExpenseDirectorModel } from '@/api/officeExpense/officeExpenseModel'
import { IncomeSpendExportModel } from '@/api/reportAnalysis/ReportAnalysisModel';
import {
    getChartIncomeSpendDataApi, getNumberIncomeSpendDataApi, getDetailIncomeSpendDataApi,
    getOnePurchasePaymentContractApi, getOneProcessPaymentContractApi, getOneLogisticsPaymentContractApi, getOneShippingContractApi,
    sendExportParmApi
} from '@/api/reportAnalysis'
import echarts from "@/utils/echartsUtil";
// 引入柱状图图表，图表后缀都为 Chart
import { LineChart } from "echarts/charts";
echarts.use([LineChart]);

const dataType = ref();
const dataCompany = ref();

const nowDate = ref()

// 图表选择日期
const choosedDay = ref<Date[]>([]);
const choosedMonth = ref<Date[]>([]);
const choosedStartSeason = ref<Date>();
const choosedEndSeason = ref<Date>();
const choosedSStartYear = ref<Date>();
const choosedSEndYear = ref<Date>();
const choosedYStartYear = ref<Date>();
const choosedYEndYear = ref<Date>();

const incomeTableRef = ref<InstanceType<typeof ElTable>>()
const spendTableRef = ref<InstanceType<typeof ElTable>>()
const officeTableRef = ref<InstanceType<typeof ElTable>>()
const incomeTableData = ref([])
const spendTableData = ref([])
const officeTableData = ref([])
// 查看细则时间选择器
const dayPickerFlag = ref(false)
const monthPickerFlag = ref(false)
const seasonPickerFlag = ref(false)
const yearPickerFlag = ref(false)
// 细则选择日期
const detailDay = ref<Date>();
const detailMonth = ref<Date>();
const detailSYear = ref<Date>();
const detailSSeason = ref();
const detailYear = ref<Date>();
// 详情窗口
const saleDialogFlag = ref(false)
const purchaseDialogFlag = ref(false)
const processDialogFlag = ref(false)
const logisticsDialogFlag = ref(false)
const shippingDialogFlag = ref(false)
const officeDialogFlag = ref(false)

const SYearFlag = ref(false);
const YYearFlag = ref(false);
const SSeasonFlag = ref(false);
const detialDialogFlag = ref(false)

const activeTab = ref('0')
const loading = ref(false)

const firstChartRef = ref<HTMLElement>();
let firstChartObject: echarts.ECharts | null = null;
const secondChartRef = ref<HTMLElement>();
let secondChartObject: echarts.ECharts | null = null;
const thirdChartRef = ref<HTMLElement>();
let thirdChartObject: echarts.ECharts | null = null;
const fourthChartRef = ref<HTMLElement>();
let fourthChartObject: echarts.ECharts | null = null;

const ownCompanyData = reactive([
    {
        label: '总体',
        value: '0'
    }, {
        label: '广西永湘贸易有限责任公司',
        value: '1'
    }, {
        label: '广西永湘物流有限公司',
        value: '2'
    }, {
        label: '广西丰沣顺国际物流有限公司',
        value: '3'
    }, {
        label: '广西众润贸易有限责任公司',
        value: '4'
    }])

const numberData = reactive<{
    income: string,
    spend: string
}[]>([
    {
        income: '0',
        spend: '0'
    },
    {
        income: '0',
        spend: '0'
    },
    {
        income: '0',
        spend: '0'
    },
    {
        income: '0',
        spend: '0'
    }
])

const firstOption = {
    title: {
        text: '日收入支出折线图'
    },
    tooltip: {//设置提示
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            label: {
                backgroundColor: '#6a7985'
            }
        }
    },
    legend: {
        data: ['收入', '支出'],
        selected: {
            '收入': true,
            '支出': true
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true,
    },
    toolbox: {
        feature: {
            saveAsImage: {
                title: '保存为图片'
            }
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name: '收入',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        },
        {
            name: '支出',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        }
    ],
};

const secondOption = {
    title: {
        text: '月收入支出折线图'
    },
    tooltip: {//设置提示
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            label: {
                backgroundColor: '#6a7985'
            }
        }
    },
    legend: {
        data: ['收入', '支出'],
        selected: {
            '收入': true,
            '支出': true
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true,
    },
    toolbox: {
        feature: {
            saveAsImage: {
                title: '保存为图片'
            }
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name: '收入',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        },
        {
            name: '支出',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        }
    ],
};

const thirdOption = {
    title: {
        text: '季收入支出折线图'
    },
    tooltip: {//设置提示
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            label: {
                backgroundColor: '#6a7985'
            }
        }
    },
    legend: {
        data: ['收入', '支出'],
        selected: {
            '收入': true,
            '支出': true
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true,
    },
    toolbox: {
        feature: {
            saveAsImage: {
                title: '保存为图片'
            }
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name: '收入',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        },
        {
            name: '支出',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        }
    ],
};

const fourthOption = {
    title: {
        text: '年收入支出折线图'
    },
    tooltip: {//设置提示
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            label: {
                backgroundColor: '#6a7985'
            }
        }
    },
    legend: {
        data: ['收入', '支出'],
        selected: {
            '收入': true,
            '支出': true
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true,
    },
    toolbox: {
        feature: {
            saveAsImage: {
                title: '保存为图片'
            }
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name: '收入',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        },
        {
            name: '支出',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        }
    ],
};

const saleContractDetail = reactive({
    saleContractNo: '',
    customerEnterpriseName: '',
    ownCompanyName: '',
    goodsName: '',
    goodsCount: '',
    goodsUnit: '',
    goodsUnitPrice: '',
    goodsTotalPrice: '',
    paymentMethod: '',
    transportMethod: '',
    revenueAmount: '',
    revenueBy: '',
    squeezeSeason: '',
    createBy: '',
    createTime: '',
    revenueTime: '',
    saleContractTime: '',
})

// 采购付款单详情
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

// 加工付款单详情
const processPaymentContractDetail = reactive({
    id: '',
    processContractNo: '',
    paymentMonth: '',
    paymentMonthPriceT: '',
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

// 物流付款单详情
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

// 海运单详情
const ShippingContractDetail = reactive({
    id: '',
    shippingContractNo: '',
    logisticsContractNo: '',
    ownCompanyName: '',
    principal: '',
    packingTime: '',
    packingLocation: '',
    unpackingFactory: '',
    containerNo: '',
    sealNo: '',
    tallyClerk: '',
    tallyClerkPrice: '',
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

// 办公经费单详情
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

const exportListParm = reactive<IncomeSpendExportModel>({
    dataType: '',
    dataCompany: '',
    timeType: 0,
    chooseDate: '',
})

const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
}

onMounted(() => {
    // 获取图表对象
    // firstChartObject.value = echarts.init(firstChartRef.value!, 'dark')
    firstChartObject = echarts.init(firstChartRef.value!)
    // 设置图表数据
    firstChartObject.setOption(firstOption);

    nowDate.value = new Date(+new Date() + 8 * 3600 * 1000).toISOString().slice(0, 10);
    setDefaultDate();
});

// 响应类型的修改
const changeType = () => {
    console.log(dataType.value);
    // 修改显示线条
    if (dataType.value == '1') {
        firstOption.legend.selected.收入 = false;
        secondOption.legend.selected.收入 = false;
        thirdOption.legend.selected.收入 = false;
        fourthOption.legend.selected.收入 = false;
    } else {
        firstOption.legend.selected.收入 = true;
        secondOption.legend.selected.收入 = true;
        thirdOption.legend.selected.收入 = true;
        fourthOption.legend.selected.收入 = true;
    }
    // 获取数值数据
    if (dataCompany.value != undefined) {
        getNumberData()
    }
    // 获取图表数据
    if (dataCompany.value != undefined && activeTab.value == '0' && choosedDay.value.length != 0) {
        getDayData();
    } else if (dataCompany.value != undefined && activeTab.value == '1' && choosedMonth.value.length != 0) {
        getMonthData();
    } else if (dataCompany.value != undefined && SYearFlag.value == false && SSeasonFlag.value == false
        && choosedSStartYear.value != undefined && choosedSEndYear.value != undefined
        && choosedStartSeason.value != undefined && choosedEndSeason.value != undefined
        && activeTab.value == '2') {
        getSeasonData();
    } else if (dataCompany.value != undefined && YYearFlag.value == false
        && choosedYStartYear.value != undefined && choosedYEndYear.value != undefined
        && activeTab.value == '3') {
        getYearData();
    }
}

// 响应公司的修改
const changeCompany = () => {
    console.log(dataCompany.value);
    if (dataType.value != undefined) {
        getNumberData()
    }
    if (dataType.value != undefined && activeTab.value == '0' && choosedDay.value.length != 0) {
        console.log(choosedDay.value);
        getDayData();
    } else if (dataType.value != undefined && activeTab.value == '1' && choosedMonth.value.length != 0) {
        getMonthData();
    } else if (dataType.value != undefined && SYearFlag.value == false && SSeasonFlag.value == false
        && choosedSStartYear.value != undefined && choosedSEndYear.value != undefined
        && choosedStartSeason.value != undefined && choosedEndSeason.value != undefined
        && activeTab.value == '2') {
        getSeasonData();
    } else if (dataType.value != undefined && YYearFlag.value == false
        && choosedYStartYear.value != undefined && choosedYEndYear.value != undefined
        && activeTab.value == '3') {
        getYearData();
    }
}

// 获取当前时间数据
const getNumberData = () => {
    changeLoadingTrue();
    getNumberIncomeSpendDataApi(dataType.value, dataCompany.value).then((res) => {
        changeLoadingFalse();
        if (res.code == 200) {
            console.log(res.data);
            res.data.map((item: any, index: any) => {
                if (item[0] == null) {
                    numberData[index].income = '0';
                    numberData[index].spend = '0';
                } else {
                    if (item[0].income == null) {
                        numberData[index].income = '0';
                    } else {
                        numberData[index].income = item[0].income;
                    }
                    if (item[0].spend == null) {
                        numberData[index].spend = '0';
                    } else {
                        numberData[index].spend = item[0].spend;
                    }
                }
            })
        }
    })
}

// 响应标签1日期的修改
const changeDay = () => {
    console.log(choosedDay.value);
    if (dataType.value != undefined && dataCompany.value != undefined) {
        getDayData();
    }
}

// 发送标签1图表数据的请求
const getDayData = () => {
    changeLoadingTrue();
    console.log("发送标签页1的请求");
    getChartIncomeSpendDataApi(dataType.value, dataCompany.value, 0, choosedDay.value[0], choosedDay.value[1]).then((res) => {
        changeLoadingFalse();
        if (res.code == 200) {
            firstOption.xAxis.data = [''];
            firstOption.series[0].data = [''];
            firstOption.series[1].data = [''];
            res.data.map((item: any, index: number) => {
                if (index == 0) {
                    firstOption.xAxis.data.pop();
                    firstOption.series[0].data.pop();
                    firstOption.series[1].data.pop();
                }
                firstOption.xAxis.data.push(item.legend);
                if (item.income != null) {
                    firstOption.series[0].data.push(item.income);
                } else {
                    firstOption.series[0].data.push("0");
                }
                if (item.spend != null) {
                    firstOption.series[1].data.push(item.spend);
                } else {
                    firstOption.series[1].data.push("0");
                }
            })
            // 设置图表标题
            firstOption.title.text = ownCompanyData[Number(dataCompany.value)].label + "日收入支出折线图";
            firstChartObject!.setOption(firstOption);
        }
    })
}

// 响应标签2月份的修改
const changeMonth = () => {
    console.log(choosedMonth.value);
    if (dataType.value != undefined && dataCompany.value != undefined) {
        getMonthData();
    }
}

// 发送标签2图表数据的请求
const getMonthData = () => {
    changeLoadingTrue();
    console.log("发送标签页2的请求");
    getChartIncomeSpendDataApi(dataType.value, dataCompany.value, 1, choosedMonth.value[0], choosedMonth.value[1]).then((res) => {
        changeLoadingFalse();
        if (res.code == 200) {
            secondOption.xAxis.data = [''];
            secondOption.series[0].data = [''];
            secondOption.series[1].data = [''];
            res.data.map((item: any, index: number) => {
                if (index == 0) {
                    secondOption.xAxis.data.pop();
                    secondOption.series[0].data.pop();
                    secondOption.series[1].data.pop();
                }
                secondOption.xAxis.data.push(item.legend);
                if (item.income != null) {
                    secondOption.series[0].data.push(item.income);
                } else {
                    secondOption.series[0].data.push("0");
                }
                if (item.spend != null) {
                    secondOption.series[1].data.push(item.spend);
                } else {
                    secondOption.series[1].data.push("0");
                }
            })
            // 设置图表标题
            secondOption.title.text = ownCompanyData[Number(dataCompany.value)].label + "月收入支出折线图";
            secondChartObject!.setOption(secondOption);
        }
    })
}

// 响应标签3开始年份的修改
const changeSSYear = () => {
    console.log(choosedSStartYear.value);
    if (choosedSEndYear.value != undefined) {
        if (choosedSStartYear.value! > choosedSEndYear.value) {
            SYearFlag.value = true
            showYearTips()
        } else {
            SYearFlag.value = false
            if (SSeasonFlag.value == false && dataType.value != undefined && dataCompany.value != undefined && choosedStartSeason.value != undefined && choosedEndSeason.value != undefined) {
                getSeasonData();
            }
        }
    }
}

// 响应标签4结束年份的修改
const changeSEYear = () => {
    console.log(choosedSEndYear.value);
    if (choosedSStartYear.value != undefined) {
        if (choosedSStartYear.value! > choosedSEndYear.value!) {
            SYearFlag.value = true
            showYearTips()
        } else {
            SYearFlag.value = false
            if (SSeasonFlag.value == false && dataType.value != undefined && dataCompany.value != undefined && choosedStartSeason.value != undefined && choosedEndSeason.value != undefined) {
                getSeasonData();
            }
        }
    }
}

const showYearTips = () => {
    ElMessage({
        message: '所选结束年份小于开始年份！',
        type: 'warning',
        duration: 4000
    })
}


// 响应标签3开始季度的修改
const changeSseason = () => {
    console.log(choosedStartSeason.value);
    if (choosedEndSeason.value != undefined) {
        if (choosedStartSeason.value! > choosedEndSeason.value) {
            SSeasonFlag.value = true
            showSeasonTips()
        } else {
            SSeasonFlag.value = false
        }
    }
}

// 响应标签3结束季度的修改
const changeEseason = () => {
    console.log(choosedEndSeason.value);
    if (choosedStartSeason.value != undefined) {
        if (choosedStartSeason.value > choosedEndSeason.value!) {
            SSeasonFlag.value = true
            showSeasonTips()
        } else {
            SSeasonFlag.value = false
            if (SYearFlag.value == false && dataType.value != undefined && dataCompany.value != undefined && choosedSStartYear.value != undefined && choosedSEndYear.value != undefined) {
                getSeasonData();
            }
        }
    }
}

const showSeasonTips = () => {
    ElMessage({
        message: '所选结束季度小于开始季度！',
        type: 'warning',
        duration: 4000
    })
}

// 发送标签3图表数据的请求
const getSeasonData = () => {
    changeLoadingTrue();
    console.log("发送标签页3的请求");
    console.log(dataType.value, dataCompany.value, choosedSStartYear.value, choosedSEndYear.value, choosedStartSeason.value, choosedEndSeason.value);
    let firstDate = String(choosedSStartYear.value);
    let secondDate = String(choosedSEndYear.value);
    let startSeason = Number(choosedStartSeason.value);
    let endSeason = Number(choosedEndSeason.value);
    if (startSeason == 1) {
        firstDate = firstDate + '-1';
    } else if (startSeason == 2) {
        firstDate = firstDate + '-2';
    } else if (startSeason == 3) {
        firstDate = firstDate + '-3';
    } else if (startSeason == 4) {
        firstDate = firstDate + '-4';
    }
    if (endSeason == 1) {
        secondDate = secondDate + '-1';
    } else if (endSeason == 2) {
        secondDate = secondDate + '-2';
    } else if (endSeason == 3) {
        secondDate = secondDate + '-3';
    } else if (endSeason == 4) {
        secondDate = secondDate + '-4';
    }
    console.log(firstDate, secondDate);
    getChartIncomeSpendDataApi(dataType.value, dataCompany.value, 2, firstDate, secondDate).then((res) => {
        changeLoadingFalse();
        if (res.code == 200) {
            thirdOption.xAxis.data = [''];
            thirdOption.series[0].data = [''];
            thirdOption.series[1].data = [''];
            res.data.map((item: any, index: number) => {
                if (index == 0) {
                    thirdOption.xAxis.data.pop();
                    thirdOption.series[0].data.pop();
                    thirdOption.series[1].data.pop();
                }
                thirdOption.xAxis.data.push(item.legend);
                if (item.income != null) {
                    thirdOption.series[0].data.push(item.income);
                } else {
                    thirdOption.series[0].data.push("0");
                }
                if (item.spend != null) {
                    thirdOption.series[1].data.push(item.spend);
                } else {
                    thirdOption.series[1].data.push("0");
                }
            })
            // 设置图表标题
            thirdOption.title.text = ownCompanyData[Number(dataCompany.value)].label + "季收入支出折线图";
            thirdChartObject!.setOption(thirdOption);
        }
    })
}

// 响应标签4开始年份的修改
const changeYSYear = () => {
    console.log(choosedYStartYear.value);
    if (choosedYEndYear.value != undefined) {
        if (choosedYStartYear.value! > choosedYEndYear.value) {
            SYearFlag.value = true
            showYearTips()
        } else {
            SYearFlag.value = false
            if (dataType.value != undefined && dataCompany.value != undefined) {
                getYearData();
            }
        }
    }
}

// 响应标签4结束年份的修改
const changeYEYear = () => {
    console.log(choosedYEndYear.value);
    if (choosedYStartYear.value != undefined) {
        if (choosedYStartYear.value > choosedYEndYear.value!) {
            SYearFlag.value = true
            showYearTips()
        } else {
            SYearFlag.value = false
            if (dataType.value != undefined && dataCompany.value != undefined) {
                getYearData();
            }
        }
    }
}

// 发送标签4图表数据的请求
const getYearData = () => {
    changeLoadingTrue();
    console.log("发送标签页4的请求");
    getChartIncomeSpendDataApi(dataType.value, dataCompany.value, 3, choosedYStartYear.value, choosedYEndYear.value).then((res) => {
        changeLoadingFalse();
        if (res.code == 200) {
            fourthOption.xAxis.data = [''];
            fourthOption.series[0].data = [''];
            fourthOption.series[1].data = [''];
            res.data.map((item: any, index: number) => {
                if (index == 0) {
                    fourthOption.xAxis.data.pop();
                    fourthOption.series[0].data.pop();
                    fourthOption.series[1].data.pop();
                }
                fourthOption.xAxis.data.push(item.legend);
                if (item.income != null) {
                    fourthOption.series[0].data.push(item.income);
                } else {
                    fourthOption.series[0].data.push("0");
                }
                if (item.spend != null) {
                    fourthOption.series[1].data.push(item.spend);
                } else {
                    fourthOption.series[1].data.push("0");
                }
            })
            // 设置图表标题
            fourthOption.title.text = ownCompanyData[Number(dataCompany.value)].label + "年收入支出折线图";
            fourthChartObject!.setOption(fourthOption);
        }
    })
}


const handleTabChange = async (e: any) => {
    activeTab.value = e.props.name;
    if (activeTab.value == '0') {
        setTimeout(() => {
            firstChartObject!.resize();
        })
    } else if (activeTab.value == '1') {
        setTimeout(() => {
            if (secondChartObject == null) {
                secondChartObject = echarts.init(secondChartRef.value!);
                secondChartObject.setOption(secondOption);
            } else {
                secondChartObject.resize();
            }
        })
    } else if (activeTab.value == '2') {
        setTimeout(() => {
            if (thirdChartObject == null) {
                thirdChartObject = echarts.init(thirdChartRef.value!);
                thirdChartObject.setOption(thirdOption);
            } else {
                thirdChartObject.resize();
            }
        })
    } else if (activeTab.value == '3') {
        setTimeout(() => {
            if (fourthChartObject == null) {
                fourthChartObject = echarts.init(fourthChartRef.value!);
                fourthChartObject.setOption(fourthOption);
            } else {
                fourthChartObject.resize();
            }
        })
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

window.addEventListener("resize", function () {
    if (firstChartObject != null) {
        firstChartObject.resize();
    }
    if (secondChartObject != null) {
        secondChartObject.resize();
    }
    if (thirdChartObject != null) {
        thirdChartObject.resize();
    }
    if (fourthChartObject != null) {
        fourthChartObject.resize();
    }
});

// 打开查看细则窗口
const openDetailDialog = (flag: number) => {
    if (flag == 1) {
        dayPickerFlag.value = true;
        getDetailData(0, detailDay.value);
    } else if (flag == 2) {
        monthPickerFlag.value = true;
        getDetailData(1, detailMonth.value);
    } else if (flag == 3) {
        seasonPickerFlag.value = true;
        getDetailData(2, detailSYear.value + '-' + detailSSeason.value);
    } else if (flag == 4) {
        yearPickerFlag.value = true;
        getDetailData(3, detailYear.value);
    }
    detialDialogFlag.value = true
}

// 关闭查看细则窗口
const closeDetailDialog = () => {
    detialDialogFlag.value = false;
    setDefaultDate();
    dayPickerFlag.value = false;
    monthPickerFlag.value = false;
    seasonPickerFlag.value = false;
    yearPickerFlag.value = false;
}

const setDefaultDate = () => {
    detailDay.value = nowDate.value;
    detailMonth.value = nowDate.value.slice(0, 7);
    detailSYear.value = nowDate.value.slice(0, 4);
    detailSSeason.value = getSeason(Number(nowDate.value.slice(5, 7)));
    detailYear.value = nowDate.value.slice(0, 4);
}

const getSeason = (time: number) => {
    if (time < 4) {
        return '1'
    } else if (time < 7) {
        return '2'
    } else if (time < 10) {
        return '3'
    } else if (time < 13) {
        return '4'
    }
}

const getDetailData = (timeType: any, startDate: any) => {
    changeLoadingTrue();
    exportListParm.dataType = dataType.value;
    exportListParm.dataCompany = dataCompany.value;
    exportListParm.timeType = timeType;
    exportListParm.chooseDate = startDate;
    getDetailIncomeSpendDataApi(dataType.value, dataCompany.value, timeType, startDate, startDate).then(res => {
        changeLoadingFalse();
        if (res.code == 200) {
            if (dataType.value == 0) {
                incomeTableData.value = res.data.incomeDetail;
                spendTableData.value = res.data.spendDetail;
            } else if (dataType.value == 1) {
                officeTableData.value = res.data.spendDetail;
            }
        }
        // else {
        //     ElMessage({
        //         message: '系统出错！',
        //         type: 'warning',
        //         duration: 4000
        //     })
        // }
    })
}

// 响应细则日的改变
const changeDetailDay = () => {
    getDetailData(0, detailDay.value);
}

// 响应细则月的改变
const changeDetailMonth = () => {
    getDetailData(1, detailMonth.value);
}

// 响应细则季（年）的改变
const changeDetailSYear = () => {
    if (detailSSeason.value != undefined) {
        let firstDate = String(detailSYear.value);
        let startSeason = Number(detailSSeason.value);
        if (startSeason == 1) {
            firstDate = firstDate + '-1';
        } else if (startSeason == 2) {
            firstDate = firstDate + '-2';
        } else if (startSeason == 3) {
            firstDate = firstDate + '-3';
        } else if (startSeason == 4) {
            firstDate = firstDate + '-4';
        }
        getDetailData(2, firstDate)
    }
}

// 响应细则季（季）的改变
const changeDetailSSeason = () => {
    if (detailSYear.value != undefined) {
        let firstDate = String(detailSYear.value);
        let startSeason = Number(detailSSeason.value);
        if (startSeason == 1) {
            firstDate = firstDate + '-1';
        } else if (startSeason == 2) {
            firstDate = firstDate + '-2';
        } else if (startSeason == 3) {
            firstDate = firstDate + '-3';
        } else if (startSeason == 4) {
            firstDate = firstDate + '-4';
        }
        getDetailData(2, firstDate)
    }
}

// 响应细则年的改变
const changeDetailYear = () => {
    getDetailData(3, detailYear.value);
}

// 打开销售单窗口
const openSaleDetail = (row: any) => {
    saleContractDetail.saleContractNo = row.saleContractNo;
    saleContractDetail.customerEnterpriseName = row.customerEnterpriseName;
    saleContractDetail.ownCompanyName = row.ownCompanyName;
    saleContractDetail.goodsName = row.goodsName;
    saleContractDetail.goodsCount = row.goodsCount;
    saleContractDetail.goodsUnit = row.goodsUnit;
    saleContractDetail.goodsUnitPrice = row.goodsUnitPrice;
    saleContractDetail.goodsTotalPrice = row.goodsTotalPrice;
    saleContractDetail.paymentMethod = row.paymentMethod;
    saleContractDetail.transportMethod = row.transportMethod;
    saleContractDetail.revenueAmount = row.revenueAmount;
    saleContractDetail.revenueBy = row.revenueBy;
    saleContractDetail.squeezeSeason = row.squeezeSeason;
    saleContractDetail.createBy = row.createBy;
    saleContractDetail.createTime = timeConversion(row.createTime);
    saleContractDetail.revenueTime = dateConversion(row.revenueTime);
    saleContractDetail.saleContractTime = dateConversion(row.saleContractTime);
    saleDialogFlag.value = true;
}

// 关闭销售单窗口
const closeSaleDetail = () => {
    saleDialogFlag.value = false
}

// 打开采购付款单窗口
const openPurchaseDetail = (row: any) => {
    changeLoadingTrue();
    getOnePurchasePaymentContractApi(row.id).then(res => {
        changeLoadingFalse();
        if (res.code == 200) {
            purchasePaymentContractDetail.purchaseContractNo = res.data.purchaseContractNo
            purchasePaymentContractDetail.paymentAmount = res.data.paymentAmount
            purchasePaymentContractDetail.paymentCount = res.data.paymentCount
            purchasePaymentContractDetail.customerEnterpriseName = res.data.customerEnterpriseName
            purchasePaymentContractDetail.ownCompanyName = res.data.ownCompanyName
            purchasePaymentContractDetail.squeezeSeason = res.data.squeezeSeason
            purchasePaymentContractDetail.inboundTime = dateConversion(res.data.inboundTime)
            purchasePaymentContractDetail.goodsName = res.data.goodsName
            purchasePaymentContractDetail.goodsCount = res.data.goodsCount
            purchasePaymentContractDetail.goodsUnit = res.data.goodsUnit
            purchasePaymentContractDetail.financeStaff = res.data.financeStaff
            purchasePaymentContractDetail.financeState = res.data.financeState
            purchasePaymentContractDetail.purchasePaymentDirector = res.data.purchasePaymentDirector
            purchasePaymentContractDetail.cashier = res.data.cashier
            purchasePaymentContractDetail.paymentTime = dateConversion(res.data.paymentTime)
            purchasePaymentContractDetail.paymentPhotoArray = res.data.paymentPhotoArray
            purchasePaymentContractDetail.createTime = timeConversion(res.data.createTime)
            purchasePaymentContractDetail.createBy = res.data.createBy
            purchaseDialogFlag.value = true
        }
    })
}

// 关闭采购付款单窗口
const closePurchaseDetail = () => {
    purchaseDialogFlag.value = false
}

// 打开加工付款单窗口
const openProcessDetail = (row: any) => {
    changeLoadingTrue();
    getOneProcessPaymentContractApi(row.id).then(res => {
        changeLoadingFalse();
        if (res.code == 200) {
            processPaymentContractDetail.processContractNo = res.data.processContractNo
            processPaymentContractDetail.paymentMonth = res.data.paymentMonth
            processPaymentContractDetail.paymentMonthPriceT = res.data.paymentMonthPriceT
            processPaymentContractDetail.goodsCount = res.data.goodsCount
            processPaymentContractDetail.paymentCount = res.data.paymentCount
            processPaymentContractDetail.customerEnterpriseName = res.data.customerEnterpriseName
            processPaymentContractDetail.ownCompanyName = res.data.ownCompanyName
            processPaymentContractDetail.financeStaff = res.data.financeStaff
            processPaymentContractDetail.financeState = res.data.financeState
            processPaymentContractDetail.processPaymentDirector = res.data.processPaymentDirector
            processPaymentContractDetail.cashier = res.data.cashier
            processPaymentContractDetail.paymentTime = dateConversion(res.data.paymentTime)
            processPaymentContractDetail.paymentPhotoArray = res.data.paymentPhotoArray
            processPaymentContractDetail.createTime = timeConversion(res.data.createTime)
            processPaymentContractDetail.createBy = res.data.createBy
            processDialogFlag.value = true
        }
    })
}

// 关闭加工付款单窗口
const closeProcessDetail = () => {
    processDialogFlag.value = false
}

// 打开物流单窗口
const openLogisticsDetail = (row: any) => {
    changeLoadingTrue();
    getOneLogisticsPaymentContractApi(row.id).then(res => {
        changeLoadingFalse();
        if (res.code == 200) {
            logisticsPaymentContractDetail.logisticsContractNo = res.data.logisticsContractNo
            logisticsPaymentContractDetail.saleContractNo = res.data.saleContractNo
            logisticsPaymentContractDetail.freight = res.data.freight
            logisticsPaymentContractDetail.paymentCount = res.data.paymentCount
            logisticsPaymentContractDetail.squeezeSeason = res.data.squeezeSeason
            logisticsPaymentContractDetail.logisticsContractTime = dateConversion(res.data.logisticsContractTime)
            logisticsPaymentContractDetail.goodsName = res.data.goodsName
            logisticsPaymentContractDetail.totalWeight = res.data.totalWeight
            logisticsPaymentContractDetail.goodsUnit = res.data.goodsUnit
            logisticsPaymentContractDetail.financeStaff = res.data.financeStaff
            logisticsPaymentContractDetail.financeState = res.data.financeState
            logisticsPaymentContractDetail.logisticsPaymentDirector = res.data.logisticsPaymentDirector
            logisticsPaymentContractDetail.cashier = res.data.cashier
            logisticsPaymentContractDetail.paymentTime = dateConversion(res.data.paymentTime)
            logisticsPaymentContractDetail.paymentPhotoArray = res.data.paymentPhotoArray
            logisticsPaymentContractDetail.createTime = timeConversion(res.data.createTime)
            logisticsPaymentContractDetail.createBy = res.data.createBy
            logisticsDialogFlag.value = true
        }
    })
}

// 关闭物流单窗口
const closeLogisticsDetail = () => {
    logisticsDialogFlag.value = false
}

// 打开海运单窗口
const openShippingDetail = (row: any) => {
    changeLoadingTrue();
    getOneShippingContractApi(row.id).then(res => {
        changeLoadingFalse();
        if (res.code == 200) {
            ShippingContractDetail.shippingContractNo = res.data.shippingContractNo
            ShippingContractDetail.logisticsContractNo = res.data.logisticsContractNo
            ShippingContractDetail.ownCompanyName = res.data.ownCompanyName
            ShippingContractDetail.principal = res.data.principal
            ShippingContractDetail.packingTime = dateConversion(res.data.packingTime)
            ShippingContractDetail.packingLocation = res.data.packingLocation
            ShippingContractDetail.unpackingFactory = res.data.unpackingFactory
            ShippingContractDetail.containerNo = res.data.containerNo
            ShippingContractDetail.sealNo = res.data.sealNo
            ShippingContractDetail.tallyClerk = res.data.tallyClerk
            ShippingContractDetail.tallyClerkPrice = res.data.tallyClerkPrice
            ShippingContractDetail.departureFleet = res.data.departureFleet
            ShippingContractDetail.departurePrice = res.data.departurePrice
            ShippingContractDetail.carrierCompanyName = res.data.carrierCompanyName
            ShippingContractDetail.carrierCompanyPrice = res.data.carrierCompanyPrice
            ShippingContractDetail.destinationPortFleet = res.data.destinationPortFleet
            ShippingContractDetail.destinationPortPrice = res.data.destinationPortPrice
            ShippingContractDetail.expenses = res.data.expenses
            ShippingContractDetail.contractPhotoArray = res.data.contractPhotoArray
            ShippingContractDetail.financeStaff = res.data.financeStaff
            ShippingContractDetail.financeState = res.data.financeState
            ShippingContractDetail.shippingDirector = res.data.shippingDirector
            ShippingContractDetail.cashier = res.data.cashier
            ShippingContractDetail.paymentCount = res.data.paymentCount
            ShippingContractDetail.paymentTime = dateConversion(res.data.paymentTime)
            ShippingContractDetail.paymentPhotoArray = res.data.paymentPhotoArray
            ShippingContractDetail.createTime = timeConversion(res.data.createTime)
            ShippingContractDetail.createBy = res.data.createBy
            shippingDialogFlag.value = true
        }
    })
}

// 关闭海运单窗口
const closeShippingDetail = () => {
    shippingDialogFlag.value = false
}

// 打开办公经费单窗口
const openOfficeDetail = (row: any) => {
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
    officeDialogFlag.value = true
}

// 关闭办公经费单窗口
const closeOfficeDetail = () => {
    officeDialogFlag.value = false
}

//导出表格
const exportExcel = () => {
    sendExportParmApi(exportListParm).then(res => {
        if (res.code == 200) {
            console.log("传递成功");
            console.log(res.data);
            const abtn = document.createElement("a");
            abtn.href = "http://120.77.28.123:9000/finance/incomeSpendExportExcel"
            abtn.click();
        }
    })
}

</script>

<style scoped>
.formGroup {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
}

.dataGroup {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-bottom: 30px;
}

.dataItem {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: auto;
    width: 300px;
    height: 230px;
}

.dataContent {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 300px;
    height: 200px;
}

.contentGroup {
    margin-top: 15px;
}

.subTitle {
    font-size: 28px;
    cursor: default;
}

.content {
    font-size: 28px;
    cursor: default;
}

.detailButton {
    margin-top: 15px;
    font-size: 26px;
    color: white;
    width: 200px;
    height: 40px;
    background-color: rgb(85, 85, 255);
    border-radius: 5%;
    text-align: center;
    cursor: pointer;
}

.dataTitle {
    font-size: 30px;
}

.chartGroup {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.chartItem {
    height: 45vh;
    width: 90%;
}

.rowCenterGroup {
    display: flex;
    flex-direction: row;
    align-items: center;
}

.detailContent {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.headerGroup {
    display: flex;
    flex-direction: row;
    justify-content: center;
    width: 100%;
}

.pickerGroup {
    margin-left: 40%;
    align-self: center;
    width: 100%;
}

.exportButton {
    align-self: center;
    display: flex;
    float: right;
    margin-right: 5%;
}

.detailRow {
    margin-top: 10px;
    margin-bottom: 10px
}

.detailSubTitle {
    /* color: #909399; */
    font-size: 20px;
    font-weight: bolder;
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