<template>
    <label for="username">用户名：</label><input type="text" id="username" v-model="loginForm.username" />
    <label for="password">密码：</label><input type="password" id="password" v-model="loginForm.password" />
    <button @click="login">登录</button>
</template>

<script setup lang="ts">
import { onMounted, reactive } from 'vue';
import { useRouter } from 'vue-router';
import { loginApi } from '@/api/login'
import { findNavTreeApi } from '@/api/menu'
import { navTreeStore } from '@/store/navTree';
import { storeToRefs } from 'pinia';
import { permsStore } from '@/store/perm'
import { getPermissions } from '@/api/user';
import { getNickNameApi } from '@/api/user';
import { userStore } from '@/store/nickName'
const userNickNameStore = userStore()
const permStore = permsStore()
const store = navTreeStore()
// const { navTree } = storeToRefs(store)
const router = useRouter()

const loginForm = reactive({
    username: 'admin',
    password: '123456',
})

const login = async () => {

    let res = await loginApi(loginForm)
    if (res && res.code == 200) {
        sessionStorage.setItem('token', res.data.token)
        // 跳转到页面之前要调用后台的菜单接口，获取当前用户的菜单
        // 再次发请求，但是发请求之前，要带上token
        let navTree = await findNavTreeApi(loginForm.username)
        console.log("用户菜单", navTree.data)
        store.setNaveTree(navTree.data)
        let perms = await getPermissions(loginForm.username)
        console.log("用户权限", perms.data)
        permStore.setPerms(perms.data)
        //获取登录人的信息 登陆成功通过username返回user信息
        let user = await getNickNameApi(loginForm.username)
        console.log("获取用户信息", user.data)
        userNickNameStore.setUser(user.data)
        router.push('/index');
    } else {
        router.push('/');
    }
}
onMounted(() => {

})
</script>

<style scoped>

</style>