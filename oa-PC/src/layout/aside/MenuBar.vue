<template>
  <el-row class="tac">
    <el-col :span="12">
      <el-menu class="el-menu" active-text-color="#ffd04b" background-color="#545c64" text-color="#fff"
        :collapse="collapsed" router :default-active="activeIndex">
        <menu-item :menus="menus"></menu-item>
      </el-menu>
    </el-col>
  </el-row>
</template>

<script lang="ts" setup>
import { computed } from 'vue';
import MenuItem from './MenuItem.vue'
import { useRoute } from 'vue-router';
import { navTreeStore } from '@/store/navTree';
import { reactive } from "vue";
// const store = navTreeStore()
const route = useRoute()
defineProps({
  collapsed: {
    type: Boolean
  },
})
//获取激活的菜单
const activeIndex = computed(() => {
  const { path } = route;
  return path;
})

// const menus = computed(() => {
//   let tree = store.getNavTree
//   return tree
// })
let menus = reactive([
  {
    path: '/dashboard',
    component: 'Layout',
    name: 'dashboard',
    meta: {
      title: '首页',
      icon: 'HomeFilled',
      roles: ['sys:dashboard'],
    },
  },
  {
    path: '/system',
    component: 'Layout',
    name: 'system',
    meta: {
      title: '系统管理',
      icon: 'Setting',
      roles: ['sys:manage'],
    },
    children: [
      {
        path: '/userList',
        component: '/system/user/UserList',
        name: 'userList',
        meta: {
          title: '员工管理',
          icon: 'UserFilled',
          roles: ['sys:user'],
        },
      },
      {
        path: '/roleList',
        component: '/system/role/RoleList',
        name: 'roleList',
        meta: {
          title: '角色管理',
          icon: 'Wallet',
          roles: ['sys:role'],
        },
      },
      {
        path: '/menuList',
        component: '/system/menu/MenuList',
        name: 'menuList',
        meta: {
          title: '菜单管理',
          icon: 'Menu',
          roles: ['sys:menu'],
        },
      },
    ],
  },
  // {
  //   path: '/memberRoot',
  //   component: 'Layout',
  //   name: 'memberRoot',
  //   meta: {
  //     title: '会员管理',
  //     icon: 'Setting',
  //     roles: ['sys:memberRoot'],
  //   },
  //   children: [
  //     {
  //       path: '/cardType',
  //       component: '/member/type/CardType',
  //       name: 'cardType',
  //       meta: {
  //         title: '会员卡类型',
  //         icon: 'UserFilled',
  //         roles: ['sys:cardType'],
  //       },
  //     },
  //     {
  //       path: '/memberList',
  //       component: '/member/list/MemberList',
  //       name: 'memberList',
  //       meta: {
  //         title: '会员管理',
  //         icon: 'Wallet',
  //         roles: ['sys:memberList'],
  //       },
  //     },
  //     {
  //       path: '/myFee',
  //       component: '/member/fee/FeeList',
  //       name: 'myFee',
  //       meta: {
  //         title: '我的充值',
  //         icon: 'Menu',
  //         roles: ['sys:myFee'],
  //       },
  //     },
  //   ],
  // },
])
</script>

<style>
.el-menu:not(.el-menu--collapse) {
  width: 200%;
  height: 100%;
  border-right: solid 1px #545c64;
}

.el-menu {
  border-right: solid 1px #545c64;
}
</style>