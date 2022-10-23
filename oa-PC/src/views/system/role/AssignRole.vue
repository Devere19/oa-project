<template>
  <SysDialog :height="dialog.height" :width="dialog.width" :visible="dialog.visible" :title="dialog.title"
    @onClose="onClose" @onConfirm="commit">
    <template #content>
      <el-tree :data="menulist.data" show-checkbox node-key="id" :default-checked-keys="ownData.data"
        :props="defaultProps" ref="assignTree" :highlight-current="true" check-strictly="false" />
    </template>
  </SysDialog>
</template>

<script setup lang="ts">
import SysDialog from '@/components/SysDialog.vue';
import useDialog from '@/hooks/useDialog';
import useAssign from "@/composables/role/useAssign";
import { ElMessage, ElTree } from 'element-plus';
import { nextTick, reactive, ref } from 'vue';
import { SaveAssignParm } from "@/api/role/RoleModel";
import { saveRoleMenuApi } from "@/api/role/index";
import { getOwnMenuApi } from "@/api/role";
//提交参数
const saveParm = reactive<SaveAssignParm>({
  id: "",
  list: [],
});

//拥有的权限
const ownData = reactive({
  data: []
})
//弹框属性
const { dialog, onClose, onShow, onConfirm } = useDialog()
//树的ref属性
const assignTree = ref<InstanceType<typeof ElTree>>();
//获取权限树
const { defaultProps, menulist } = useAssign();
//显示弹框
const show = async (id: string, name: string) => {
  ownData.data = []
  assignTree.value?.setCheckedKeys([])
  //获取权限
  let res = await getOwnMenuApi(id)
  if (res && res.code == 200) {
    ownData.data = res.data
  }
  saveParm.id = id
  //设置弹框属性
  dialog.width = 450;
  dialog.height = 450;
  dialog.title = "分配权限";
  onShow();
};
defineExpose({
  show,
});

//提交保存
const commit = async () => {
  //获取选择的菜单数据id
  let checkIds = assignTree.value?.getCheckedKeys() as string[];
  let hlfIds = assignTree.value?.getHalfCheckedKeys() as string[];
  //menu数组
  let list = checkIds?.concat(hlfIds);
  if (list.length == 0) {
    ElMessage.warning("请勾选权限信息!");
    return;
  }
  console.log("提交的权限", list)
  saveParm.list = list
  //提交保存
  let res = await saveRoleMenuApi(saveParm);
  if (res && res.code == 200) {
    ElMessage.success(res.msg);
    onClose();
  }
};
</script>

<style scoped>
</style>