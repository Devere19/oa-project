<template>
    <div class="login-container flx-center">
        <div class="login-box">
            <div class="login-left">
                <div class="title">永湘OA系统</div>
                <div class="sub">桂林骏泰信息科技有限公司</div>
                <img src="../../assets/login.png" alt="" />
            </div>

            <div class="login-form">
                <div class="login-logo">
                    <img class="login-icon" src="../../assets/logo.png" alt="" />
                </div>
                <div class="login-logo">
                    <p class="logo-text">欢迎登录</p>
                </div>
                <el-form ref="loginFormRef" :model="loginForm" :rules="loginRules" size="large">
                    <el-form-item prop="username">
                        <el-input :prefix-icon="User" v-model="loginForm.username" placeholder="用户名">
                        </el-input>
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input :prefix-icon="Lock" type="password" show-password v-model="loginForm.password"
                            placeholder="密码">
                        </el-input>
                    </el-form-item>
                    <div class="flx-row">
                        <el-checkbox v-model="loginForm.checked" label="记住密码" size="large" />
                    </div>
                </el-form>

                <div class="login-btn">
                    <el-button :icon="UserFilled" round @click="login(loginFormRef)" size="large" type="primary"
                        :loading="loading">
                        登录
                    </el-button>
                    <el-button :icon="CircleClose" round @click="resetForm(loginFormRef)" size="large">重置</el-button>
                </div>
            </div>
        </div>
    </div>
</template>
  
<script setup lang="ts">
import { Base64 } from 'js-base64'
import { onMounted, reactive, ref } from 'vue'
import { ElMessage, FormInstance, FormRules } from 'element-plus'
import { useRouter } from 'vue-router';
import { loginApi } from '@/api/login'
import { findNavTreeApi } from '@/api/menu'
import { navTreeStore } from '@/store/navTree';
import { storeToRefs } from 'pinia';
import { permsStore } from '@/store/perm'
import { getPermissions } from '@/api/user';
import { getNickNameApi } from '@/api/user';
import { userStore } from '@/store/nickName';
import { UserFilled, Lock, User, CircleClose } from '@element-plus/icons-vue'
const userNickNameStore = userStore()
const permStore = permsStore()
const store = navTreeStore()
// const { navTree } = storeToRefs(store)
const router = useRouter()

const loginFormRef = ref<FormInstance>()
const loading = ref(false)
const loginForm = reactive({
    username: '',
    password: '',
    checked: true,
})

const loginRules = reactive<FormRules>({
    username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
    password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
})

const login = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate(async (valid, fields) => {
        if (valid) {
            loading.value = true
            let res = await loginApi(loginForm)
            if (res && res.code == 200) {
                if (loginForm.checked) {
                    let password = Base64.encode(loginForm.password) // base64加密
                    setCookie(loginForm.username, password, 7)
                } else {
                    setCookie('', '', -1)
                }
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
        } else {
            ElMessage({
                message: '请输入账号密码！',
                type: 'error',
                duration: 4000
            })
        }
    })
}

const resetForm = (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    formEl1.resetFields()
}

// const getGMTString=(date :Date)=>{

// }

const setCookie = (userId: string, password: string, days: any) => {
    let date = new Date() // 获取时间
    date.setTime(date.getTime() + 24 * 60 * 60 * 1000 * days) // 保存的天数
    // 字符串拼接cookie
    window.document.cookie =
        'userId' + '=' + userId + ';path=/;expires=' + date
    window.document.cookie =
        'password' + '=' + password + ';path=/;expires=' + date
}

// 读取cookie 将用户名和密码回显到input框中
const getCookie = () => {
    if (document.cookie.length > 0) {
        let arr = document.cookie.split('; ') //分割成一个个独立的“key=value”的形式
        for (let i = 0; i < arr.length; i++) {
            let arr2 = arr[i].split('=') // 再次切割，arr2[0]为key值，arr2[1]为对应的value
            if (arr2[0] === 'userId') {
                loginForm.username = arr2[1]
            } else if (arr2[0] === 'password') {
                loginForm.password = Base64.decode(arr2[1]) // base64解密
                loginForm.checked = true
            }
        }
    }
}

onMounted(() => {
    getCookie()
})
</script>
  
<style scoped lang="scss">
.login-container {
    width: 100vw;
    height: 100vh;
    // background-color: #6c88d5;
    background-image: url('../../assets/bg.png');
    background-size: 100% 100%;
    display: flex;
    align-items: center;
    justify-content: center;

    .login-box {
        width: 96%;
        height: 94%;
        background-color: hsla(0, 0%, 100%, 0.85);
        border-radius: 10px;
        padding: 0 8% 0 50px;
        box-sizing: border-box;
        display: flex;
        align-items: center;
        justify-content: space-around;

        .login-left {
            width: 800px;
            color: #6E736FFF;

            .title {
                font-size: 48px;
                font-weight: 400;
                letter-spacing: 0px;
                color: rgba(47, 57, 78, 1);
                text-align: left;
            }

            img {
                width: 735px;
                height: 465px;
            }
        }

        .login-form {
            width: 400px;
            height: 460px;
            padding: 10px 40px 35px 40px;
            border-radius: 10px;
            -webkit-box-shadow: 2px 3px 7px rgb(0 0 0 / 20%);
            box-shadow: 2px 3px 7px rgb(0 0 0 / 20%);

            .login-logo {
                display: flex;
                align-items: center;
                justify-content: center;
                // margin-bottom: 45px;

                .login-icon {
                    margin-top: 10px;
                    width: 150px;
                    // height: 52px;
                }

                .logo-text {
                    font-weight: bold;
                    font-size: 32px;
                    padding-left: 5px;
                    margin-top: 10px;
                    white-space: nowrap;
                    color: #2d51e6;
                }
            }

            .flx-row {
                display: flex;
                justify-content: center;
            }

            .login-btn {
                margin-top: 15px;
                padding-bottom: 20px;
                display: flex;
                justify-content: center;
                // justify-content: space-between;
                width: 100%;
                white-space: nowrap;

                .el-button {
                    width: 185px;
                }
            }
        }
    }
}
</style>
  