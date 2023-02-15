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
                    <el-row class="flx-row">
                        <el-col :span="20">
                            <el-checkbox style="flex: 1" v-model="loginForm.checked" label="记住密码" size="large" />
                        </el-col>
                        <el-col class="flx-col" :span="4" @click="forgetPassword">
                            忘记密码?
                        </el-col>
                    </el-row>
                    <!-- <el-checkbox style="flex: 1" v-model="loginForm.checked" label="记住密码" size="large" />
                      <span>忘记密码？</span> -->
                </el-form>

                <div class="login-btn">
                    <el-button :icon="UserFilled" round @click="login(loginFormRef)" size="large" type="primary"
                        :loading="loading">
                        登录
                    </el-button>
                    <el-button :icon="CircleClose" round @click="resetForm(loginFormRef)" size="large">重置</el-button>
                </div>
            </div>

            <el-dialog v-model="forgetPasswordVisiable" title="忘记密码" width="40%" :before-close="handleClose">
                <div class="forgetPassword_box">
                    <el-steps :active="active" align-center finish-status="success">
                        <el-step title="请输入用户名" />
                        <el-step title="请输入姓名和身份证号" />
                        <el-step title="请输入您要修改的密码" />
                    </el-steps>
                    <el-main>
                        <el-form :model="addModel" ref="form" label-width="120px" :inline="false">
                            <el-col :span="16" :offset="0" v-if="active == 0">
                                <el-form-item prop="name" label="用户名" :rules="[
                                { required: true, trigger: ['change'] }]">
                                    <el-input v-model="addModel.name"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="16" :offset="0" v-if="active == 1">
                                <el-form-item prop="nickName" label="姓名" :rules="[
                                { required: true, trigger: ['change'] }]">
                                    <el-input v-model="addModel.nickName"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="16" :offset="0" v-if="active == 1">
                                <el-form-item prop="identity" label="身份证" :rules="[
                                { required: true, trigger: ['change'] }]">
                                    <el-input v-model="addModel.identity"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="16" :offset="0" v-if="active == 2">
                                <el-form-item prop="password" label="输入密码" :rules="[
                                { required: true, trigger: ['change'] }]">
                                    <el-input v-model="addModel.password"></el-input>
                                </el-form-item>
                            </el-col>
                            <el-col :span="16" :offset="0" v-if="active == 2">
                                <el-form-item prop="mobile" label="再次确认密码" :rules="[
                                { required: true, trigger: ['change'] }]">
                                    <el-input v-model="addModel.mobile"></el-input>
                                </el-form-item>
                            </el-col>
                        </el-form>

                    </el-main>


                </div>
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="beforeClickBtn" :disabled="active == 0" v-if="active != 3">上一步</el-button>
                        <el-button type="primary" @click="nextClickBtn()">
                            {{ active== 2 ? "提交" : active == 3 ? "返回登录页" : "下一步" }}
                        </el-button>
                    </span>
                </template>
            </el-dialog>
        </div>
    </div>
</template>

<script setup lang="ts">
import { Base64 } from 'js-base64'
import { onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox, FormInstance, FormRules } from 'element-plus'
import { useRouter } from 'vue-router';
import { loginApi } from '@/api/login'
import { findNavTreeApi } from '@/api/menu'
import { navTreeStore } from '@/store/navTree';
import { storeToRefs } from 'pinia';
import { permsStore } from '@/store/perm'
import { getPermissions } from '@/api/user';
import { getNickNameApi, getUserByName, nickAndIdenIsTrue, forgetPasswordApi } from '@/api/user';
import { userStore } from '@/store/nickName';
import { UserFilled, Lock, User, CircleClose } from '@element-plus/icons-vue'
import { AddUserModel } from '@/api/user/UserModel';
import { add } from 'lodash';
const userNickNameStore = userStore()
const permStore = permsStore()
const store = navTreeStore()
// const { navTree } = storeToRefs(store)
const router = useRouter()
//忘记密码
const forgetPasswordVisiable = ref(false)
const active = ref(0)
const handleClose = () => {
    forgetPasswordVisiable.value = false
}

const nextClickBtn = async () => {
    if (active.value == 3) {
        forgetPasswordVisiable.value = false
        active.value = 0
    } else if (active.value == 0) {
        if (addModel.name == '') {
            alert("用户名不能为空")
            return
        }
        let res = await getUserByName(addModel.name)
        if (res.data && res.code == 200) {
            ElMessage.success("存在该用户名")
            active.value++
        } else {
            ElMessage.error("该用户名不存在")
        }
    }
    else if (active.value == 1) {
        if (addModel.nickName == '' || addModel.identity == '') {
            alert("姓名和身份证不能为空")
            return
        }
        let res = await nickAndIdenIsTrue(addModel.nickName, addModel.identity, addModel.name)
        if (res.data && res.code == 200) {
            ElMessage.success("验证成功")
            active.value++
        } else {
            ElMessage.error("姓名或身份证错误，请重新输入！")
        }
    }
    else if (active.value == 2) {
        if (addModel.password == '' || addModel.mobile == '') {
            alert("请输入密码")
            return
        }
        if (addModel.mobile !== addModel.password) {
            alert("两次输入的密码不一样")
            return
        }
        let res = await forgetPasswordApi(addModel)
        if (res && res.code == 200) {
            ElMessage.success("修改密码成功")
            active.value++
        } else {
            ElMessage.error("修改密码失败")
        }

    }

}
const beforeClickBtn = () => {
    active.value--
}
//表单绑定的对象
const addModel = reactive({
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
    salt: '',
    prePassword: ''
})



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

onMounted(() => {
    getCookie()
})

const login = async (formEl1: FormInstance | undefined) => {
    if (!formEl1) return
    await formEl1.validate(async (valid, fields) => {
        if (valid) {
            loading.value = true
            loginApi(loginForm).then(async res => {
                if (res && res.data != 0) {
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
                    loading.value = false;
                    router.push('/index');
                } else {
                    loading.value = false;
                    ElMessage.error(res.msg);
                    router.push('/');
                }
            })
            // let res = await loginApi(loginForm)
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

const forgetPassword = () => {
    forgetPasswordVisiable.value = true
}

</script>

<style scoped lang="scss">
.forgetPassword_box {
    width: 100%;
    height: 400px;
}

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
            height: 500px;
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
                    width: 200px;
                    // height: 52px;
                }

                .logo-text {
                    font-weight: bold;
                    font-size: 32px;
                    padding-left: 5px;
                    margin-top: 10px;
                    margin-bottom: 20px;
                    white-space: nowrap;
                    color: #2d51e6;
                }
            }

            .flx-row {
                font-size: 14px;
                color: #2d51e6;

                .flx-col {
                    display: flex;
                    align-items: center;
                    cursor: pointer;
                }
            }

            .login-btn {
                margin-top: 15px;
                padding-bottom: 20px;
                display: flex;
                // justify-content: center;
                justify-content: space-between;
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
