<template>
    <div ref="chartRef" />
</template>
  
<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, defineProps } from "vue";
import echarts from "@/utils/echartsUtil";
// import { LineChart } from "echarts/charts";
// echarts.use([LineChart]);

//接收父组件传递数据
const props = defineProps({
    option: Object,
})

const chartRef = ref<HTMLElement>();
const chartObject = ref();

onMounted(() => {
    // 获取图表对象
    chartObject.value = echarts.init(chartRef.value!)
    chartObject.value.setOption(props.option);
});

onBeforeUnmount(() => {
    chartObject.value.dispose()
})

</script>
  
<style lang="scss" scope>

</style>