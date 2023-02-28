<template>
  <h1>{{ user.userMessage.nickName }}</h1>
  <el-tooltip class="box-item" effect="dark" placement="bottom">
    <template #content>
      <a href="/" @click="removeSession" class="tuichu">退出登录</a>
    </template>
    <el-avatar size="large" shape="circle" :src="avatar" fit="fill">
    </el-avatar>
  </el-tooltip>
  <h2>{{ user.userMessage.roleNames }}</h2>
  <el-link style="margin-left: 30%;" href="http://120.77.28.123:9000/static/models/models.zip">点击下载导入模板</el-link>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue';
import { userStore } from '@/store/nickName'

const user = reactive({
  userMessage: {}
})
const removeSession = () => {
  sessionStorage.removeItem('token')
}

const userNickName = userStore()
user.userMessage = userNickName.getUser
const avatar = ref('http://cdn.glypro19.com/oaassets/QQ%E5%9B%BE%E7%89%8720221022063943.png')
// user.userMessage={
//   nickName:'开发者',
//   avatar:'http://cdn.glypro19.com/oaassets/QQ%E5%9B%BE%E7%89%8720221022063943.png'
// }
</script>

<style scoped>
h1 {
  margin-left: 15%;
  margin-right: 20px;
}

h2 {
  margin-left: 20px;
}

.tuichu {
  text-decoration: none;
  color: white;
  line-height: 100%;
  /* height: 100%;
  width: 100%; */
}

.el-link {
  margin-right: 8px;
  color: black;
  font-size: 20px;
}

.el-link .el-icon--right.el-icon {
  vertical-align: text-bottom;
}
</style>