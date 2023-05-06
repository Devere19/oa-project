<template>
    <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
        @onClose="close" @onConfirm="commit">
        <template #content>
            <el-form :model="addModel" ref="addFormRef" label-width="80px" size="default">
                <el-row>
                    <el-col :span="12" :offset="0">
                        <el-form-item prop="revenueTime" label="收款时间">
                            <el-date-picker v-model="addModel.revenueTime" type="date" placeholder="" size="default"
                                format="YYYY-MM-DD" value-format="YYYY-MM-DD" />
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="12" :offset="0">
                        <el-form-item prop="revenueAmount" label="收款金额">
                            <el-input v-model="addModel.revenueAmount"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-form-item prop="contractPhotoList" label="合同照片">
                        <el-upload v-model:file-list="PhotoData" :action=uploadPhotoUrl
                            list-type="picture-card" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
                            :on-success="handlePhotoSuccess">
                            <el-icon>
                                <Plus />
                            </el-icon>
                        </el-upload>
                    </el-form-item>
                </el-row>
            </el-form>
        </template>
    </SysDialog>
</template>

<script setup lang="ts">
import SysDialog from '@/components/SysDialog.vue';
import useDialog from '@/hooks/useDialog'
import { SaleModel } from '@/api/cashier/CashierModel'
import { reactive, ref } from 'vue';
import { ElMessage, FormInstance, UploadProps, UploadUserFile } from 'element-plus';
import { deletePhotoApi } from '@/api/handlePhoto';
import { editCashierSaleApi } from '@/api/cashier';
import { uploadPhotoUrl } from '@/http/config'

const addFormRef = ref<FormInstance>()

const { dialog, onShow, onClose, onConfirm } = useDialog()

const show = async (id: string) => {
    dialog.title = '收款信息填写'
    addModel.id = id
    onShow()
    addFormRef.value?.resetFields()
}

const addModel = reactive<SaleModel>({
    id: '',
    revenueTime: '',
    revenueAmount: '',
    revenuePhoto: '',
    revenuePhotoList: [],
    revenueBy: ''
})

defineExpose({
    show
})

//图片上传-----------------------------------------------------------------------------------------------------
const dialogImageUrl = ref('')
const previewImageFlag = ref(false)

const PhotoData = ref<UploadUserFile[]>([])
// 照片移除后发送请求后台删除照片
const handleRemove: UploadProps['onRemove'] = async (uploadFile: any, uploadFiles: any) => {
    console.log(uploadFile, uploadFiles);
    addModel.revenuePhotoList.splice(addModel.revenuePhotoList.indexOf(uploadFile.response.data), 1);
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
        addModel.revenuePhotoList.push(response.data);
        console.log(addModel.revenuePhotoList);
        // console.log("加入照片数据组");
    }
}

//关闭
const close = () => {
    onClose()
    PhotoData.value = [];
    if (addModel.revenuePhotoList.length != 0) {
        addModel.revenuePhotoList.map((item: string) => {
            deletePhotoApi(item);
        });
        addModel.revenuePhotoList = [];
    }
}
//注册事件
const emits = defineEmits(['refresh'])

//提交
const commit = async () => {
    addModel.revenueBy = '出纳人员姓名'
    let res = await editCashierSaleApi(addModel)
    if (res && res.code == 200) {
        ElMessage.success(res.msg)
        //刷新表格
        emits('refresh')
        onClose()
    }
    //清空照片
    addModel.revenuePhotoList = []
    PhotoData.value = []
}
</script>

<style scoped></style>