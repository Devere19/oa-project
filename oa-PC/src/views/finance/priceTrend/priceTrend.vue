<template>
    <div>
        <div class="priceTrend">
            <div class="chartGroup">
                <div ref="firstChartRef" class="chartDiv" style="width:48%;margin-right: 1.5%;" />
                <div ref="secondChartRef" class="chartDiv" style="width:48%;margin-left: 1.5%;" />
            </div>
            <div class="selectGroup">
                <span class="title">
                    选择商品
                </span>
                <el-select v-model="choosedGoods" placeholder="下拉选择商品" size="large" @change="changeGoods">
                    <el-option v-for="item in goodsList" :key="item.goodsName" :label="item.goodsName"
                        :value="item.goodsName" />
                </el-select>
            </div>
            <div class="pickerGroup">
                <span class="title">
                    选择日期
                </span>
                <el-date-picker v-model="choosedDate" value-format="YYYY-MM-DD" type="daterange"
                    :disabled-date="disabledDate" unlink-panels range-separator="To" start-placeholder="开始日期"
                    end-placeholder="结束日期" :shortcuts="shortcuts" size="large" @change="changeDate" />
            </div>
        </div>
    </div>
</template>

<script lang="ts" setup>
import { ref, reactive, onMounted, markRaw } from 'vue'
import { getPriceTrendDataApi, getGoodsNameDataApi } from '@/api/priceTrend'
// import echarts from "@/utils/echartsUtil";
import echarts from "@/utils/echartsUtil";
// 引入柱状图图表，图表后缀都为 Chart
import { LineChart, LineSeriesOption } from "echarts/charts";
echarts.use([LineChart]);

const firstChartRef = ref<HTMLElement>();
const secondChartRef = ref<HTMLElement>();
const firstChartObject = ref();
const secondChartObject = ref();

const choosedGoods = ref('')
const choosedDate = ref<Date[]>([])
const goodsList = reactive<goods[]>([])

type goods = {
    goodsName: string
}

const shortcuts = [
    {
        text: '最近一星期',
        value: () => {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
            return [start, end]
        },
    },
    {
        text: '最近一个月',
        value: () => {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
            return [start, end]
        },
    },
    {
        text: '最近三个月',
        value: () => {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
            return [start, end]
        },
    },
]

const purchaseOption = {
    title: {
        text: '采购单价走势图'
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
        data: ['采购单价']
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
            name: '采购单价',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        }
    ],
};

const saleOption = {
    title: {
        text: '销售单价走势图'
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
        data: ['销售单价']
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
            name: '销售单价',
            type: 'line',
            label: {
                show: true,
                position: 'top'
            },
            data: ['']
        }
    ],
};

onMounted(() => {
    // 获取图表对象
    // firstChartObject.value = echarts.init(firstChartRef.value!, 'dark')
    firstChartObject.value = markRaw(echarts.init(firstChartRef.value!))
    secondChartObject.value = markRaw(echarts.init(secondChartRef.value!))
    // 设置图表数据
    firstChartObject.value.setOption(purchaseOption);
    secondChartObject.value.setOption(saleOption);
    getGoodsNameDataApi().then((res) => {
        res.data.map((item: goods) => {
            goodsList.push(item);
        })
    })
});

const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
}

const changeGoods = (e: any) => {
    choosedGoods.value = e;
    if (choosedDate.value[0] != null && choosedDate.value[1] != null) {
        getPriceData();
    }
}

const changeDate = (e: any) => {
    choosedDate.value.push = e[0];
    choosedDate.value.push = e[1];
    if (choosedGoods.value != '' || choosedGoods.value != null) {
        getPriceData();
    }
}

const getPriceData = () => {
    getPriceTrendDataApi(choosedGoods.value, choosedDate.value[0], choosedDate.value[1]).then((res) => {
        res.data.purchasePriceTrends.map((item: any, index: number) => {
            if (index == 0) {
                purchaseOption.xAxis.data.pop();
                purchaseOption.series[0].data.pop();
            }
            purchaseOption.xAxis.data.push(item.inboundTime);
            purchaseOption.series[0].data.push(item.avgPrice);
        })
        res.data.salePriceTrends.map((item: any, index: number) => {
            if (index == 0) {
                saleOption.xAxis.data.pop();
                saleOption.series[1].data.pop();
            }
            saleOption.xAxis.data.push(item.saleContractTime);
            saleOption.series[1].data.push(item.avgPrice);
        })
        purchaseOption.title.text = choosedGoods.value + "采购单价走势图";
        saleOption.title.text = choosedGoods.value + "销售单价走势图";
        firstChartObject.value.setOption(purchaseOption);
        secondChartObject.value.setOption(saleOption);
    })
}

</script>

<style scoped>
.priceTrend {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
}

.selectGroup {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 10px;
}

.pickerGroup {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 10px;
}

.title {
    font-size: 28px;
    margin-bottom: 10px;
}

.chartGroup {
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 100%;
}

.chartDiv {
    height: 500px;
    margin-top: 50px;
}
</style>