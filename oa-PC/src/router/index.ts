import { createRouter, createWebHashHistory, RouteRecordRaw } from "vue-router"
import Layout from '@/layout/index.vue'
const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    component: () => import('@/views/login/login.vue')
  },
  {
    path: '/index',
    component: Layout,
    redirect: '/oa/dashboard',
    children: [{
      path: '/oa/dashboard',
      component: () => import('@/layout/Index/Index.vue'),
      name: 'index',
      meta: {
        name: '首页',
        icon: 'house',
        roles: ['sys:dashboard'],
      },
    }]
  },
  {
    path: '/oa/system',
    name: 'system',
    component: Layout,
    meta: {
      name: '系统管理',
      icon: 'Setting',
      roles: ['sys:manage'],
    },
    children: [
      {
        path: '/oa/userList',
        name: 'userList',
        component: () => import('@/views/system/user/UserList.vue'),
        meta: {
          title: '员工管理',
          icon: 'UserFilled',
          roles: ['sys:user'],
        },
      },
      {
        path: '/oa/roleList',
        name: 'roleList',
        component: () => import('@/views/system/role/RoleList.vue'),
        meta: {
          title: '角色管理',
          icon: 'Wallet',
          roles: ['sys:role'],
        },
      },
      {
        path: '/oa/menuList',
        name: 'menuList',
        component: () => import('@/views/system/menu/MenuList.vue'),
        meta: {
          title: '菜单管理',
          icon: 'Menu',
          roles: ['sys:menu'],
        },
      },
      {
        path: '/oa/logList',
        name: 'logList',
        component: () => import('@/views/system/log/LogList.vue'),
        meta: {
          title: '日志管理',
          icon: 'Monitor',
          roles: ['sys:log'],
        },
      }
    ]
  },
  {
    path: '/oa/purchaseContract',
    component: Layout,
    redirect: '/oa/purchaseContract',
    children: [{
      path: '/oa/purchaseContract',
      component: () => import('@/views/purchase/PurchaseContract.vue'),
      name: 'purchaseContract',
      meta: {
        title: '采购单',
        icon: 'ShoppingCart',
        roles: ['sys:purchaseContract'],
      },
    }]
  },
  {
    path: '/oa/processContract',
    component: Layout,
    redirect: '/oa/processContract',
    children: [{
      path: '/oa/processContract',
      component: () => import('@/views/process/ProcessContract.vue'),
      name: 'processContract',
      meta: {
        title: '加工单',
        icon: 'Box',
        roles: ['sys:processContract'],
      },
    }]
  },
  {
    path: '/oa/cashier',
    name: 'cashier',
    component: Layout,
    meta: {
      title: '出纳',
      icon: 'Money',
      roles: ['sys:cashier'],
    },
    children: [
      {
        path: '/oa/cashier/cashierPurchasePayment',
        name: 'cashierPurchasePayment',
        component: () => import('@/views/cashier/purchasePayment/CashierPurchasePayment.vue'),
        meta: {
          title: '采购付款单',
          icon: 'Money',
          roles: ['sys:cashierPurchasePayment'],
        },
      },
      {
        path: '/oa/cashier/cashierProcessPayment',
        name: 'cashierProcessPayment',
        component: () => import('@/views/cashier/processPayment/CashierProcessPayment.vue'),
        meta: {
          title: '加工付款单',
          icon: 'Money',
          roles: ['sys:cashierProcessPayment'],
        },
      },
      {
        path: '/oa/cashier/cashierSale',
        name: 'cashierSale',
        component: () => import('@/views/cashier/sale/CashierSale.vue'),
        meta: {
          title: '出纳销售单',
          icon: 'Money',
          roles: ['sys:cashierSale'],
        },
      },
      {
        path: '/oa/cashier/cashierLogisticsPayment',
        name: 'cashierLogisticsPayment',
        component: () => import('@/views/cashier/logisticsPayment/CashierLogisticsPayment.vue'),
        meta: {
          title: '物流付款单',
          icon: 'Money',
          roles: ['sys:cashierLogisticsPayment'],
        },
      },
      {
        path: '/oa/cashier/cashierShipping',
        name: 'cashierShipping',
        component: () => import('@/views/cashier/shipping/CashierShipping.vue'),
        meta: {
          title: '出纳海运单',
          icon: 'Money',
          roles: ['sys:cashierShipping'],
        },
      },
      {
        path: '/oa/cashier/cashierOfficeExpense',
        name: 'cashierOfficeExpense',
        component: () => import('@/views/cashier/officeExpense/CashierOfficeExpense.vue'),
        meta: {
          title: '办公经费',
          icon: 'Money',
          roles: ['sys:cashierOfficeExpense'],
        },
      }
    ]
  },
  {
    path: '/oa/warehouseManagement',
    component: Layout,
    redirect: '/oa/warehouseManagement',
    children: [{
      path: '/oa/warehouseManagement',
      component: () => import('@/views/warehouse/WarehouseManagement.vue'),
      name: 'warehouseManagement',
      meta: {
        title: '仓库管理',
        icon: 'Discount',
        roles: ['sys:warehouseManagement'],
      },
    }]
  },
  {
    path: '/oa/saleContract',
    component: Layout,
    redirect: '/oa/saleContract',
    children: [{
      path: '/oa/saleContract',
      component: () => import('@/views/sale/SaleContract.vue'),
      name: 'saleContract',
      meta: {
        title: '销售单',
        icon: 'Document',
        roles: ['sys:saleContract'],
      },
    }]
  },
  {
    path: '/oa/outbound',
    name: 'outbound',
    component: Layout,
    meta: {
      title: '出库信息',
      icon: 'Shop',
      roles: ['sys:outbound'],
    },
    children: [
      {
        path: '/oa/outbound/outboundLogisticsList',
        name: 'outboundLogisticsList',
        component: () => import('@/views/outbound/logistics/OutboundLogisticsList.vue'),
        meta: {
          title: '出库物流单',
          icon: 'Bicycle',
          roles: ['sys:outboundLogisticsList'],
        },
      },
      {
        path: '/oa/outbound/outboundShippingList',
        name: 'outboundShippingList',
        component: () => import('@/views/outbound/shipping/OutboundShippingList.vue'),
        meta: {
          title: '出库海运单',
          icon: 'Ship',
          roles: ['sys:outboundShippingList'],
        },
      },
    ]
  },
  {
    path: '/oa/finance',
    name: 'finance',
    component: Layout,
    meta: {
      title: '财务管理',
      icon: 'Coin',
      roles: ['sys:finance'],
    },
    children: [
      {
        path: '/oa/finance/reportAnalysis',
        name: 'reportAnalysis',
        component: () => import('@/views/finance/reportAnalysis/ReportAnalysis.vue'),
        meta: {
          title: '报表分析',
          icon: 'TrendCharts',
          roles: ['sys:reportAnalysis'],
        },
      },
      {
        path: '/oa/finance/officeExpense',
        name: 'officeExpense',
        component: () => import('@/views/finance/officeExpense/OfficeExpense.vue'),
        meta: {
          title: '办公经费',
          icon: 'TrendCharts',
          roles: ['sys:officeExpense'],
        },
      },
      {
        path: '/oa/finance/priceTrend',
        name: 'priceTrend',
        component: () => import('@/views/finance/priceTrend/PriceTrend.vue'),
        meta: {
          title: '单价走势',
          icon: 'TrendCharts',
          roles: ['sys:priceTrend'],
        },
      },
    ]
  },
  {
    path: '/oa/purchasePaymentContract',
    component: Layout,
    redirect: '/oa/purchasePaymentContract',
    children: [{
      path: '/oa/purchasePaymentContract',
      component: () => import('@/views/purchasePayment/PurchasePaymentContract.vue'),
      name: 'purchasePaymentContract',
      meta: {
        title: '采购付款单',
        icon: 'Document',
        roles: ['sys:purchasePaymentContract'],
      },
    }]
  },
  {
    path: '/oa/processPaymentContract',
    component: Layout,
    redirect: '/processPaymentContract',
    children: [{
      path: '/oa/processPaymentContract',
      component: () => import('@/views/processPayment/ProcessPaymentContract.vue'),
      name: 'processPaymentContract',
      meta: {
        title: '加工付款单',
        icon: 'Document',
        roles: ['sys:processPaymentContract'],
      },
    }]
  },
  {
    path: '/oa/logisticsPaymentContract',
    component: Layout,
    redirect: '/oa/logisticsPaymentContract',
    children: [{
      path: '/oa/logisticsPaymentContract',
      component: () => import('@/views/logisticsPayment/LogisticsPaymentContract.vue'),
      name: 'logisticsPaymentContract',
      meta: {
        title: '物流付款单',
        icon: 'Document',
        roles: ['sys:logisticsPaymentContract'],
      },
    }]
  },
  {
    path: '/oa/customerList',
    component: Layout,
    redirect: '/oa/customerList',
    children: [{
      path: '/oa/customerList',
      component: () => import('@/views/customer/CustomerList.vue'),
      name: 'customerList',
      meta: {
        title: '客户管理',
        icon: 'User',
        roles: ['sys:customerList'],
      },
    }]
  },
  {
    path: '/oa/ownCompanyList',
    component: Layout,
    redirect: '/oa/ownCompanyList',
    children: [{
      path: '/oa/ownCompanyList',
      component: () => import('@/views/ownCompany/OwnCompanyList.vue'),
      name: 'ownCompanyList',
      meta: {
        title: '公司管理',
        icon: 'Management',
        roles: ['sys:ownCompanyList'],
      },
    }]
  },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes: routes
})

export default router