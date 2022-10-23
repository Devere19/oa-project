import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router"
import Layout from '@/layout/index.vue'
const routes: Array<RouteRecordRaw> = [
  // {
  //   path: '/',
  //   component: () => import('@/views/login/login.vue')
  // },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [{
      path: '/dashboard',
      component: () => import('@/layout/Index/Index.vue'),
      name: 'index',
      meta: {
        name: '首页',
        icon: 'house'
      },
    }]
  },

  {
    path: '/system',
    name: 'system',
    component: Layout,
    meta: {
      name: '系统管理',
      icon: 'Shop',
      // roles: ["sys:manage"]
    },
    children: [
      {
        path: '/userList',
        name: 'userList',
        component: () => import('@/views/system/user/UserList.vue'),
        meta: {
          name: '用户管理',
          icon: 'User',
          // roles: ["sys:user"]
        }
      },
      {
        path: '/roleList',
        name: 'roleList',
        component: () => import('@/views/system/role/RoleList.vue'),
        meta: {
          name: '角色管理',
          icon: 'Avatar',
          // roles: ["sys:role"]
        }
      },
      {
        path: '/menuList',
        name: 'menuList',
        component: () => import('@/views/system/menu/MenuList.vue'),
        meta: {
          name: '菜单管理',
          icon: 'Menu',
          // roles: ["sys:menu"]
        }
      }
    ]
  },
  // {
  //   path: '/goodsList',
  //   redirect: '/goodsList',
  //   component: Layout,
  //   children: [
  //     {
  //       path: '/goodsList',
  //       name: 'goodsList',
  //       component: () => import('@/views/goods/GoodsList.vue'),
  //       meta: {
  //         name: '商品管理',
  //         icon: 'Goods',
  //         // roles: ["sys:goods"]
  //       }
  //     },
  //   ]
  // },
  // {
  //   path: '/shoppingCart',
  //   redirect: '/shoppingCart',
  //   component: Layout,
  //   children: [
  //     {
  //       path: '/shoppingCart',
  //       name: 'shoppingCart',
  //       component: () => import('@/views/shoppingCart/shoppingCart.vue'),
  //       meta: {
  //         name: '订单管理',
  //         icon: 'ShoppingCart',
  //         // roles: ["sys:order"]
  //       }
  //     },
  //   ]
  // },
  // {
  //   path: '/trendCharts',
  //   redirect: '/trendCharts',
  //   component: Layout,
  //   children: [
  //     {
  //       path: '/trendCharts',
  //       name: 'trendCharts',
  //       component: () => import('@/views/analysis/analysis.vue'),
  //       meta: {
  //         name: '销售分析',
  //         icon: 'TrendCharts',
  //         // roles: ["sys:analysis"]
  //       }
  //     },
  //   ]
  // },
  // {
  //   path: '/member',
  //   redirect: '/member',
  //   component: Layout,
  //   children: [
  //     {
  //       path: '/member',
  //       name: 'member',
  //       component: () => import('@/views/member/memberList.vue'),
  //       meta: {
  //         name: '会员信息',
  //         icon: 'Present',
  //         // roles: ["sys:member"]
  //       }
  //     },
  //   ]
  // },
  // {
  //   path: '/giftList',
  //   redirect: '/giftList',
  //   component: Layout,
  //   children: [
  //     {
  //       path: '/giftList',
  //       name: 'giftList',
  //       component: () => import('@/views/image/imageList.vue'),
  //       meta: {
  //         name: '节日礼盒',
  //         icon: 'GoodsFilled',
  //         // roles: ["sys:goods"]
  //       }
  //     },
  //   ]
  // },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes: routes
})

export default router