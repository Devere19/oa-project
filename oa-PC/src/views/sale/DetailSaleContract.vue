<template>

  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="onConfirm">
    <template #content>
      销售单详情
    </template>

  </SysDialog>

</template>

<script setup lang="ts">
import SysDialog from '@/components/SysDialog.vue';
import useDialog from '@/hooks/useDialog';

const { onShow, dialog, onConfirm, onClose } = useDialog()

const show = () => {
  dialog.title = '销售单想起那个'
}


//暴露出去给父组件调用
defineExpose({
  show
})


</script>

<style scoped>

</style>