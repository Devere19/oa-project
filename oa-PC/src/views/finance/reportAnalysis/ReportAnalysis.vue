<template>
    <div class="reportAnalysis" v-loading="loading">
        <div>
            <el-form label-position="right" label-width="60px" class="formGroup">
                <el-row justify="center">
                    <el-col :span="12">
                        <el-form-item label="类型:">
                            <el-select v-model="dataType" placeholder="下拉选择" size="large" @change="changeType">
                                <el-option label="整体业务" value="0"></el-option>
                                <el-option label="办公经费" value="1"></el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="公司:">
                            <el-select v-model="dataCompany" placeholder="下拉选择" size="large" @change="changeCompany">
                                <el-option label="总体" value="0"></el-option>
                                <el-option label="广西永湘物流有限公司" value="1"></el-option>
                                <el-option label="广西南宁锦泰行工贸有限公司" value="2"></el-option>
                                <el-option label="广西丰沣顺国际物流有限公司" value="3"></el-option>
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
                    <div class="detailButton">
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
                    <div class="detailButton">
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
                    <div class="detailButton">
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
                    <div class="detailButton">
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
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import echarts from "@/utils/echartsUtil";
import { getChartIncomeSpendDataApi, getNumberIncomeSpendDataApi } from '@/api/ReportAnalysis'
// 引入柱状图图表，图表后缀都为 Chart
import { LineChart } from "echarts/charts";
echarts.use([LineChart]);

const dataType = ref();
const dataCompany = ref();

const choosedDay = ref<Date[]>([]);
const choosedMonth = ref<Date[]>([]);
const choosedStartSeason = ref<Date>();
const choosedEndSeason = ref<Date>();
const choosedSStartYear = ref<Date>();
const choosedSEndYear = ref<Date>();
const choosedYStartYear = ref<Date>();
const choosedYEndYear = ref<Date>();

const SYearFlag = ref(false);
const YYearFlag = ref(false);
const SSeasonFlag = ref(false);

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
        data: ['收入', '支出']
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
        data: ['收入', '支出']
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
        data: ['收入', '支出']
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
        data: ['收入', '支出']
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

const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
}

onMounted(() => {
    // 获取图表对象
    // firstChartObject.value = echarts.init(firstChartRef.value!, 'dark')
    firstChartObject = echarts.init(firstChartRef.value!)
    // 设置图表数据
    firstChartObject.setOption(firstOption);
});

// 响应类型的修改
const changeType = () => {
    console.log(dataType.value);
    if (dataCompany.value != undefined) {
        getNumberData()
    }
    if (dataCompany.value != undefined && activeTab.value == '0') {
        getDayData();
    } else if (dataCompany.value != undefined && activeTab.value == '1') {
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
    if (dataType.value != undefined && activeTab.value == '0') {
        getDayData();
    } else if (dataType.value != undefined && activeTab.value == '1') {
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
            if (dataCompany.value == "0") {
                firstOption.title.text = "总体日收入支出折线图";
            } else if (dataCompany.value == "1") {
                firstOption.title.text = "广西永湘物流有限公司日收入支出折线图";
            } else if (dataCompany.value == "2") {
                firstOption.title.text = "广西南宁锦泰行工贸有限公司日收入支出折线图";
            } else if (dataCompany.value == "3") {
                firstOption.title.text = "广西丰沣顺国际物流有限公司日收入支出折线图";
            }
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
            if (dataCompany.value == "0") {
                secondOption.title.text = "总体月收入支出折线图";
            } else if (dataCompany.value == "1") {
                secondOption.title.text = "广西永湘物流有限公司月收入支出折线图";
            } else if (dataCompany.value == "2") {
                secondOption.title.text = "广西南宁锦泰行工贸有限公司月收入支出折线图";
            } else if (dataCompany.value == "3") {
                secondOption.title.text = "广西丰沣顺国际物流有限公司月收入支出折线图";
            }
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
        if (res.code = 200) {
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
            if (dataCompany.value == "0") {
                thirdOption.title.text = "总体季收入支出折线图";
            } else if (dataCompany.value == "1") {
                thirdOption.title.text = "广西永湘物流有限公司季收入支出折线图";
            } else if (dataCompany.value == "2") {
                thirdOption.title.text = "广西南宁锦泰行工贸有限公司季收入支出折线图";
            } else if (dataCompany.value == "3") {
                thirdOption.title.text = "广西丰沣顺国际物流有限公司季收入支出折线图";
            }
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
        if (res.code = 200) {
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
            if (dataCompany.value == "0") {
                fourthOption.title.text = "总体年收入支出折线图";
            } else if (dataCompany.value == "1") {
                fourthOption.title.text = "广西永湘物流有限公司年收入支出折线图";
            } else if (dataCompany.value == "2") {
                fourthOption.title.text = "广西南宁锦泰行工贸有限公司年收入支出折线图";
            } else if (dataCompany.value == "3") {
                fourthOption.title.text = "广西丰沣顺国际物流有限公司年收入支出折线图";
            }
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
}

.content {
    font-size: 28px;
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
</style>