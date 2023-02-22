<template>
  <SysDialog :title="dialog.title" :height="dialog.height" :width="dialog.width" :visible="dialog.visible"
    @onClose="onClose" @onConfirm="commit">
    <template #content>
      <el-form :model="addModel" ref="addFormRef" :rules="rules" label-width="80px" size="default">
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="nickName" label="姓名">
              <el-input v-model="addModel.nickName"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="name" label="用户名">
              <el-input v-model="addModel.name" :suffix-icon="userNameSameFlag ? 'CloseBold' : 'Select'"
                @input="checkUserName"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="age" label="年龄">
              <el-input v-model="addModel.age"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="mobile" label="电话">
              <el-input v-model="addModel.mobile"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="identity" label="身份证">
              <el-input v-model="addModel.identity"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="homeAddress" label="家庭住址">
              <el-input v-model="addModel.homeAddress"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="onboardingTime" label="入职时间">
              <el-date-picker v-model="addModel.onboardingTime" type="date" placeholder="入职时间" size="default" />
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="departureTime" label="离职时间">
              <el-date-picker v-model="addModel.departureTime" type="date" placeholder="离职时间" size="default" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="roleId" label="角色">
              <!-- <el-select v-model="addModel.roleId" class="m-2" placeholder="请选择角色" size="default">
                <el-option v-for="item in roleData.list" :key="item.value" :label="item.label" :value="item.value" />
              </el-select> -->
              <el-select v-model="addModel.roleId" multiple placeholder="请选择角色" size="default">
                <el-option v-for="item in roleData.list" :key="item.value" :label="item.label" :value="item.value" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12" :offset="0">
            <el-form-item prop="status" label="状态">
              <el-radio-group v-model="addModel.status">
                <el-radio label="在职">在职</el-radio>
                <el-radio label="离职">离职</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12" :offset="0">
            <el-form-item prop="password" label="密码">
              <el-input v-model="addModel.password"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>

    </template>
  </SysDialog>
</template>

<script setup lang="ts">
import { AddUserModel } from '@/api/user/UserModel';
import SysDialog from '@/components/SysDialog.vue';
import useDialog from '@/hooks/useDialog';
import { nextTick, reactive, ref } from 'vue';
import useSelectRole from '@/composables/user/useSelectRole';
import { ElMessage, FormInstance } from 'element-plus';
import { addApi, editApi, getUserByName } from '@/api/user';
import { EditType, Title } from '@/type/BaseEnum';
import useInstance from '@/hooks/useInstance';
const { global } = useInstance()
//表单ref属性
const addFormRef = ref<FormInstance>()
//获取角色
const { roleData, listRole, roleId, getRole } = useSelectRole()

//弹框属性
const { dialog, onClose, onConfirm, onShow } = useDialog()



//显示弹框
const show = async (type: string, row?: AddUserModel) => {
  roleId.value = [];
  addModel.roleId = [];
  addModel.mobile = "";
  addModel.name = "";
  dialog.height = 350
  addModel.type = type
  addModel.password = ''
  addModel.salt = ''
  //获取角色数据
  await listRole()
  await getRole(row!?.id)
  console.log(roleData.list)
  type == EditType.ADD ? dialog.title = Title.ADD : dialog.title = Title.EDIT
  //设置数据
  if (type == EditType.EDIT) {
    //回显数据
    nextTick(() => {
      global.$objCopy(row, addModel)
      addModel.roleId = roleId.value
      tempUserName.value = addModel.name
    })
    addModel.type = type
  }
  onShow()
  //清空数据
  addFormRef.value?.resetFields()
}

//暴露出去给父组件调用
defineExpose({
  show
})
//表单绑定的对象
const addModel = reactive<AddUserModel>({
  id: "",
  type: "",
  roleId: [],
  name: "",
  nickName: '',
  age: '',
  mobile: '',
  identity: '',
  homeAddress: '',
  onboardingTime: '',
  departureTime: '',
  password: '',
  status: '',  //在职/离职
  salt: ''
})


//表单验证规则
const rules = reactive({
  nickName: [
    {
      required: true,
      trigger: "change",
      message: "请输入姓名",
    },
  ],
  mobile: [
    {
      required: true,
      trigger: "change",
      message: "请输入电话",
    },
  ],
  status: [
    {
      required: true,
      trigger: "change",
      message: "请输选择状态",
    },
  ],
  name: [
    {
      required: true,
      trigger: "change",
      message: "请输入账户",
    },
  ],
  password: [
    {
      required: true,
      trigger: "change",
      message: "请输入密码",
    },
  ],
  roleId: [
    {
      required: true,
      trigger: "change",
      message: "请选择角色",
    },
  ],
  age: [
    {
      required: true,
      trigger: "change",
      message: "请输入年龄",
    },
  ],
  identity: [
    {
      required: true,
      trigger: "change",
      message: "请输入身份证",
    },
  ],
  homeAddress: [
    {
      required: true,
      trigger: "change",
      message: "请输入家庭地址",
    },
  ],
})

//注册事件
const emits = defineEmits(['refresh'])

// 用户名重复flag
const userNameSameFlag = ref();
// 临时用户名（用于编辑情况）
const tempUserName = ref();

// 验证用户名是否重复
const checkUserName = async (e: any) => {
  if (e == "" || e == null) {
    return;
  }
  getUserByName(e).then(res => {
    userNameSameFlag.value = res.data;
    if (userNameSameFlag.value == true) {
      ElMessage({
        message: '该用户名已重复，请修改！',
        type: 'error',
        grouping: true,
        duration: 4000
      })
    } else if (userNameSameFlag.value == false) {
      ElMessage({
        message: '用户名验证合法！',
        type: 'success',
        grouping: true,
      })
    }
  });
}

//表单提交
const commit = () => {
  addFormRef.value?.validate(async (avlid) => {
    if (avlid) {
      let res = null;
      if (addModel.type == EditType.ADD) {
        console.log('新增')
        if (userNameSameFlag.value == false) {
          res = await addApi(addModel)
        } else {
          ElMessage({
            message: '该用户名已重复，请修改!',
            type: 'error',
            duration: 4000
          })
        }
      } else {
        console.log('编辑')
        if (userNameSameFlag.value == false || tempUserName.value == addModel.name) {
          res = await editApi(addModel);
        } else {
          ElMessage({
            message: '该用户名已重复，请修改!',
            type: 'error',
            duration: 4000
          })
        }
      }
      if (res && res.code == 200) {
        ElMessage.success(res.msg)
        //刷新表格
        emits('refresh')
        onClose()
      }
    }
  })
}
</script>

<style scoped></style>