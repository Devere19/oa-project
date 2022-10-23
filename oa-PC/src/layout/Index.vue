<template>
    <div class="layout">
        <el-container>
            <el-aside>
                <el-header>
                    <logo :collapsed="collapsed"></logo>
                </el-header>
                <SiderBar :collapsed="collapsed"></SiderBar>
            </el-aside>
            <el-container>
                <el-header>
                    <!-- 侧边栏展开折叠按钮 -->
                    <el-row>
                        <el-icon style="font-size: 30px;" @click="() => { collapsed = !collapsed }">
                            <component :is="collapsed ? Expand : Fold"></component>
                        </el-icon>
                    </el-row>
                    <HeaderVue class="userMessage"></HeaderVue>
                </el-header>
                <el-main>
                    <AppMainVue></AppMainVue>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>

<script setup lang="ts">
import logo from './aside/Logo.vue'
import SiderBar from './aside/MenuBar.vue'
import AppMainVue from './main/AppMain.vue'
import { Expand, Fold } from '@element-plus/icons-vue'
import { ref } from 'vue'
import HeaderVue from './header/Header.vue'

const collapsed = ref<boolean>(false);
</script>
<style lang="scss" scoped>
.layout {
    height: 100vh;
    display: flex;
    .el-header {
    display: flex;
    flex-wrap: nowrap;
    align-items: center;
    background-color: #009688;
    color: var(--el-text-color-primary);
    text-align: center;
    line-height: 40px;
}

.el-aside {
    background-color:#545c64;
    text-align: center;
    line-height: 200px;
    width: fit-content;
}

.el-main {
    background-color: white;
    color: var(--el-text-color-primary);
    // text-align: center;
    // line-height: 160px;
}

.el-aside>.el-header {
    background-color: #545c64;
}
}


</style>