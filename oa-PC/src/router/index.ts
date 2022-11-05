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
  {
    path: '/purchase',
    component:Layout,
    redirect: '/purchaseContract',
    children: [{
      path: '/purchaseContract',
      component:  ()=>import('@/views/purchase/PurchaseContract.vue'),
      name: 'purchaseContract',
      meta: {
        title: '采购单',
        icon: 'Setting',
        // roles: ['sys:manage'],
      },
    }]
  },
  {
    path: '/cashier',
    name: 'cashier',
    component: Layout,
    meta: {
      name: '出纳',
      icon: 'Shop',
      // roles: ["sys:manage"]
    },
    children: [
      {
        path: '/cashier/cashierPurchaseList',
        name: 'cashierPurchaseList',
        component: () => import('@/views/cashier/purchase/CashierPurchaseList.vue'),
        meta: {
          name: '出纳采购单',
          icon: 'User',
          // roles: ["sys:user"]
        }
      },
      {
        path: '/cashier/cashierSaleList',
        name: 'cashierSaleList',
        component: () => import('@/views/cashier/sale/CashierSaleList.vue'),
        meta: {
          name: '出纳销售单',
          icon: 'Avatar',
          // roles: ["sys:role"]
        }
      },
      {
        path: '/cashier/cashierLogisticsList',
        name: 'cashierLogisticsList',
        component: () => import('@/views/cashier/logistics/CashierLogisticsList.vue'),
        meta: {
          name: '出纳物流单',
          icon: 'Menu',
          // roles: ["sys:menu"]
        }
      },
      {
        path: '/cashier/cashierShippingList',
        name: 'cashierShippingList',
        component: () => import('@/views/cashier/shipping/CashierShippingList.vue'),
        meta: {
          name: '出纳海运单',
          icon: 'Menu',
          // roles: ["sys:menu"]
        }
      }
    ]
  },
  {
    path: '/warehouse',
    component:Layout,
    redirect: '/warehouseManagement',
    children: [{
      path: '/warehouseManagement',
      component:  ()=>import('@/views/warehouse/WarehouseManagement.vue'),
      name: 'warehouseManagement',
      meta: {
        title: '仓库管理',
        icon: 'Setting',
        // roles: ['sys:manage'],
      },
    }]
  },
  {
    path: '/sale',
    component:Layout,
    redirect: '/saleContract',
    children: [{
      path: '/saleContract',
      component:  ()=>import('@/views/sale/SaleContract.vue'),
      name: 'saleContract',
      meta: {
        title: '销售单',
        icon: 'Setting',
        // roles: ['sys:manage'],
      },
    }]
  },
  {
    path: '/outbound',
    name: 'outbound',
    component: Layout,
    meta: {
      name: '出库信息',
      icon: 'Shop',
      // roles: ["sys:manage"]
    },
    children: [
      {
        path: '/outbound/outboundLogisticsList',
        name: 'outboundLogisticsList',
        component: () => import('@/views/outbound/logistics/OutboundLogisticsList.vue'),
        meta: {
          name: '出库物流单',
          icon: 'User',
          // roles: ["sys:user"]
        }
      },
      {
        path: '/outbound/outboundShippingList',
        name: 'outboundShippingList',
        component: () => import('@/views/outbound/shipping/OutboundShippingList.vue'),
        meta: {
          name: '出库海运单',
          icon: 'Avatar',
          // roles: ["sys:role"]
        }
      },
    ]
  },
  {
    path: '/finance',
    name: 'finance',
    component: Layout,
    meta: {
      name: '财务管理',
      icon: 'Shop',
      // roles: ["sys:manage"]
    },
    children: [
      {
        path: '/finance/reportAnalysis',
        name: 'reportAnalysis',
        component: () => import('@/views/finance/reportAnalysis/ReportAnalysis.vue'),
        meta: {
          name: '报表分析',
          icon: 'User',
          // roles: ["sys:user"]
        }
      },
      {
        path: '/finance/officeExpense',
        name: 'officeExpense',
        component: () => import('@/views/finance/officeExpense/OfficeExpense.vue'),
        meta: {
          name: '办公经费',
          icon: 'Avatar',
          // roles: ["sys:role"]
        }
      },
    ]
  },
  {
    path: '/purchasePayment',
    component:Layout,
    redirect: '/purchasePaymentContract',
    children: [{
      path: '/purchasePaymentContract',
      component:  ()=>import('@/views/purchasePayment/PurchasePaymentContract.vue'),
      name: 'purchasePaymentContract',
      meta: {
        title: '采购付款单',
        icon: 'Setting',
        // roles: ['sys:manage'],
      },
    }]
  },
  {
    path: '/logisticsPayment',
    component:Layout,
    redirect: '/logisticsPaymentContract',
    children: [{
      path: '/logisticsPaymentContract',
      component:  ()=>import('@/views/logisticsPayment/LogisticsPaymentContract.vue'),
      name: 'logisticsPaymentContract',
      meta: {
        title: '物流付款单',
        icon: 'Setting',
        // roles: ['sys:manage'],
      },
    }]
  },
  {
    path: '/client',
    component:Layout,
    redirect: '/clientGetList',
    children: [{
      path: '/clientGetList',
      component:  ()=>import('@/views/client/clientGetList.vue'),
      name: 'clientGetList',
      meta: {
        title: '客户管理',
        icon: 'Setting',
        // roles: ['sys:manage'],
      },
    }]
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