<template>
    <el-dialog :model-value="printDialogFlag" title="预览打印" width="60%" draggable center :before-close="onClose">
        <div id="printBox" style="font-size: 10px;">
            <el-row justify="center" class="borderGroup" style="font-size: 16px;">
                <div style="margin: 20px 0;">
                    用款申请书
                </div>
            </el-row>
            <el-row>
                <el-col :span="4" :class="['centerCommon', 'unTopGroup', 'weightGroup']">
                    申请部门
                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopLeftGroup']">
                    {{ formData.ownCompanyName }}
                </el-col>
                <el-col :span="4" :class="['centerCommon', 'unTopBotLeftGroup', 'weightGroup']">
                    用途
                </el-col>
                <el-col :span="8" class="unTopBotLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="4" :class="['centerCommon', 'unTopGroup', 'weightGroup']">
                    经办人
                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopLeftGroup']">
                    {{ formData.agent }}
                </el-col>
                <el-col :span="4" :class="['centerCommon', 'unTopLeftGroup', 'weightGroup']">
                </el-col>
                <el-col :span="8" class="unTopLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="4" :class="['centerCommon', 'unTopGroup', 'weightGroup']">
                    结算方式
                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopLeftGroup']">
                    转账&nbsp;&nbsp;•&nbsp;&nbsp;电汇&nbsp;&nbsp;•&nbsp;&nbsp;现金
                </el-col>
                <el-col :span="4" :class="['centerCommon', 'unTopLeftGroup', 'weightGroup']">
                    金额
                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopLeftGroup']">
                    {{ formData.amount }}
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="4" :class="['centerCommon', 'unTopBotGroup', 'weightGroup']">

                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopBotLeftGroup']">
                </el-col>
                <el-col :span="4" :class="['centerCommon', 'unTopLeftGroup', 'weightGroup']">
                    开户名
                </el-col>
                <el-col :span="8" class="unTopLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="4" :class="['centerCommon', 'unTopBotGroup', 'weightGroup']">
                    对方单位名称
                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopBotLeftGroup']">
                    {{ formData.customerEnterpriseName }}
                </el-col>
                <el-col :span="4" :class="['centerCommon', 'unTopLeftGroup', 'weightGroup']">
                    开户银行
                </el-col>
                <el-col :span="8" class="unTopLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="4" :class="['centerCommon', 'unTopGroup', 'weightGroup']">

                </el-col>
                <el-col :span="8" :class="['centerCommon', 'unTopLeftGroup']">
                </el-col>
                <el-col :span="4" :class="['centerCommon', 'unTopLeftGroup', 'weightGroup']">
                    账号
                </el-col>
                <el-col :span="8" class="unTopLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12" :class="['centerCommon', 'unTopBotGroup', 'weightGroup']">
                    线上审批情况:
                </el-col>
                <el-col :span="12" :class="['unTopBotLeftGroup', 'weightGroup']">
                    备注:
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12" :class="['centerCommon', 'unTopBotGroup']">
                    {{ formData.director[0] }}——已通过
                </el-col>
                <el-col :span="12" class="unTopBotLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12" :class="['centerCommon', 'unTopBotGroup']">
                    {{ formData.director[1] }}——已通过
                </el-col>
                <el-col :span="12" class="unTopBotLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12" :class="['centerCommon', 'unTopBotGroup']">
                    {{ formData.director[2] }}——已通过
                </el-col>
                <el-col :span="12" class="unTopBotLeftGroup">
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="12" :class="['centerCommon', 'unTopGroup']">
                    {{ formData.financeStaff }}——已通过
                </el-col>
                <el-col :span="12" class="unTopLeftGroup">
                </el-col>
            </el-row>
        </div>
        <template #footer>
            <span class="dialog-footer">
                <el-button v-print="printSet" type="primary">
                    打印
                </el-button>
                <el-button @click="onClose">取消</el-button>
            </span>
        </template>
    </el-dialog>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
//注册事件
const emit = defineEmits(['onClose'])

interface PrintFormData {
    ownCompanyName: string,
    agent: string,
    amount: string,
    customerEnterpriseName: string,
    director: [],
    financeStaff: string
}

const props = defineProps({
    formData: {
        type: Object,
        default: ref<PrintFormData>()
    },
    printDialogFlag: {
        type: Boolean,
        default: false
    }
})

const onClose = () => {
    emit('onClose')
}

const printSet = ref({
    id: 'printBox',//这里的id就是上面我们的打印区域id，实现指哪打哪
    popTitle: '永湘OA系统', // 打印配置页上方的标题
    extraHead: '', // 最上方的头部文字，附加在head标签上的额外标签，使用逗号分割
    preview: false, // 是否启动预览模式，默认是false
    previewTitle: '预览界面', // 打印预览的标题
    previewPrintBtnLabel: '开始打印', // 打印预览的标题下方的按钮文本，点击可进入打印
    zIndex: 20002, // 预览窗口的z-index，默认是20002，最好比默认值更高
    previewBeforeOpenCallback() { console.log('正在加载预览窗口！'); }, // 预览窗口打开之前的callback
    previewOpenCallback() { console.log('已经加载完预览窗口，预览打开了！') }, // 预览窗口打开时的callback
    beforeOpenCallback() { console.log('开始打印之前！') }, // 开始打印之前的callback
    openCallback() {
        console.log('执行打印了！');
        ElMessage({
            message: '打印中......',
            type: 'success',
        })
    }, // 调用打印时的callback
    closeCallback() {
        console.log('关闭了打印工具！');
    }, // 关闭打印的callback(无法区分确认or取消)
    clickMounted() { console.log('点击v-print绑定的按钮了！') },
})

</script>

<style lang="scss" scoped>
.centerCommon {
    display: flex;
    justify-content: center;
}

.borderGroup {
    border: solid 2px black;
}

.unTopGroup {
    border: solid 2px black;
    border-top: 0px;
    padding: 8px 0px;
}

.unTopLeftGroup {
    border: solid 2px black;
    border-top: 0px;
    border-left: 0px;
    padding: 8px 0px;
}

.unTopRightGroup {
    border: solid 2px black;
    border-top: 0px;
    border-right: 0px;
    padding: 8px 0px;
}

.unTopBotGroup {
    border: solid 2px black;
    border-top: 0px;
    border-bottom: 0px;
    padding: 8px 0px;
}

.unTopBotLeftGroup {
    border: solid 2px black;
    border-top: 0px;
    border-bottom: 0px;
    border-left: 0px;
    padding: 8px 0px;
}

.unTopBotRightGroup {
    border: solid 2px black;
    border-top: 0px;
    border-bottom: 0px;
    border-right: 0px;
    padding: 8px 0px;
}

.weightGroup {
    font-weight: 600
}
</style>