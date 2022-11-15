<template>
    <div>
        <!-- <div>
            <el-form ref="firstFormRef" label-position="right" label-width="60px" :model="formChooseForm"
                class="formGroup">
                <el-form-item label="类型:">
                    <el-select v-model="formChooseForm.type" placeholder="下拉选择" size="large">
                        <el-option label="整体业务" value="整体业务"></el-option>
                        <el-option label="办公经费" value="办公经费"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="公司:">
                    <el-select v-model="formChooseForm.company" placeholder="下拉选择" size="large">
                        <el-option label="总体" value="总体"></el-option>
                        <el-option label="广西永湘物流有限公司" value="广西永湘物流有限公司"></el-option>
                        <el-option label="广西南宁锦泰行工贸有限公司" value="广西南宁锦泰行工贸有限公司"></el-option>
                        <el-option label="广西丰沣顺国际物流有限公司" value="广西丰沣顺国际物流有限公司"></el-option>
                    </el-select>
                </el-form-item>
            </el-form>
        </div> -->
        <div class="dataGroup">
            <div class="dataItem">
                <div class="dataContent" style="background-color: #35A9CE;">
                    <div class="contentGroup">
                        <span class="subTitle">
                            收入：
                        </span>
                        <span class="content">
                            10000
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            10000
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
                            10000
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            10000
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
                            10000
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            10000
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
                            10000
                        </span>
                    </div>
                    <div class="contentGroup">
                        <span class="subTitle">
                            支出：
                        </span>
                        <span class="content">
                            10000
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
        <div class="chartGroup">
            <div ref="firstChartRef" class="firstChart" style="width:60%"></div>
        </div>
        <div>

        </div>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted } from 'vue'
import { FormInstance } from 'element-plus'
import echarts from "@/utils/echartsUtil";
// 引入柱状图图表，图表后缀都为 Chart
import { LineChart } from "echarts/charts";
echarts.use([LineChart]);

const firstChartRef = ref<HTMLElement>();
const firstChartObject = ref();

const firstFormRef = ref<FormInstance>();
const formChooseForm = reactive({
    type: '',
    company: ''
})

const option = {
    title: {
        text: '2022年收入支出折线图'
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
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
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
            data: [120, 132, 101, 134, 90, 230, 210]
        },
        {
            name: '支出',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: [220, 182, 191, 234, 290, 330, 310]
        }
    ],
};

onMounted(() => {
    // 获取图表对象
    // firstChartObject.value = echarts.init(firstChartRef.value!, 'dark')
    firstChartObject.value = echarts.init(firstChartRef.value!)
    // 设置图表数据
    firstChartObject.value.setOption(option);
});



</script>

<style scoped>
.formGroup {
    display: flex;
    flex-direction: row;
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

.firstChart {
    height: 500px;
}
</style>