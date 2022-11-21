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
    redirect: '/dashboard',
    children: [{
      path: '/dashboard',
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
    path: '/system',
    name: 'system',
    component: Layout,
    meta: {
      name: '系统管理',
      icon: 'Shop',
      roles: ['sys:manage'],
    },
    children: [
      {
        path: '/userList',
        name: 'userList',
        component: () => import('@/views/system/user/UserList.vue'),
        meta: {
          title: '员工管理',
          icon: 'UserFilled',
          roles: ['sys:user'],
        },
      },
      {
        path: '/roleList',
        name: 'roleList',
        component: () => import('@/views/system/role/RoleList.vue'),
        meta: {
          title: '角色管理',
          icon: 'Wallet',
          roles: ['sys:role'],
        },
      },
      {
        path: '/menuList',
        name: 'menuList',
        component: () => import('@/views/system/menu/MenuList.vue'),
        meta: {
          title: '菜单管理',
          icon: 'Menu',
          roles: ['sys:menu'],
        },
      }
    ]
  },
  {
    path: '/purchaseContract',
    component: Layout,
    redirect: '/purchaseContract',
    children: [{
      path: '/purchaseContract',
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
    path: '/cashier',
    name: 'cashier',
    component: Layout,
    meta: {
      title: '出纳',
      icon: 'Money',
      roles: ['sys:cashier'],
    },
    children: [
      {
        path: '/cashier/cashierPurchasePayment',
        name: 'cashierPurchasePayment',
        component: () => import('@/views/cashier/purchasePayment/CashierPurchasePayment.vue'),
        meta: {
          title: '采购付款单',
          icon: 'Money',
          roles: ['sys:cashierPurchasePayment'],
        },
      },
      {
        path: '/cashier/cashierSale',
        name: 'cashierSale',
        component: () => import('@/views/cashier/sale/CashierSale.vue'),
        meta: {
          title: '出纳销售单',
          icon: 'Money',
          roles: ['sys:cashierSale'],
        },
      },
      {
        path: '/cashier/cashierLogisticsPayment',
        name: 'cashierLogisticsPayment',
        component: () => import('@/views/cashier/logisticsPayment/CashierLogisticsPayment.vue'),
        meta: {
          title: '物流付款单',
          icon: 'Money',
          roles: ['sys:cashierLogisticsPayment'],
        },
      },
      {
        path: '/cashier/cashierShipping',
        name: 'cashierShipping',
        component: () => import('@/views/cashier/shipping/CashierShipping.vue'),
        meta: {
          title: '出纳海运单',
          icon: 'Money',
          roles: ['sys:cashierShipping'],
        },
      },
      {
        path: '/cashier/cashierOfficeExpense',
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
    path: '/warehouseManagement',
    component: Layout,
    redirect: '/warehouseManagement',
    children: [{
      path: '/warehouseManagement',
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
    path: '/saleContract',
    component: Layout,
    redirect: '/saleContract',
    children: [{
      path: '/saleContract',
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
    path: '/outbound',
    name: 'outbound',
    component: Layout,
    meta: {
      title: '出库信息',
      icon: 'Shop',
      roles: ['sys:outbound'],
    },
    children: [
      {
        path: '/outbound/outboundLogisticsList',
        name: 'outboundLogisticsList',
        component: () => import('@/views/outbound/logistics/OutboundLogisticsList.vue'),
        meta: {
          title: '出库物流单',
          icon: 'Bicycle',
          roles: ['sys:outboundLogisticsList'],
        },
      },
      {
        path: '/outbound/outboundShippingList',
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
    path: '/finance',
    name: 'finance',
    component: Layout,
    meta: {
      title: '财务管理',
      icon: 'Coin',
      roles: ['sys:finance'],
    },
    children: [
      {
        path: '/finance/reportAnalysis',
        name: 'reportAnalysis',
        component: () => import('@/views/finance/reportAnalysis/ReportAnalysis.vue'),
        meta: {
          title: '报表分析',
          icon: 'TrendCharts',
          roles: ['sys:reportAnalysis'],
        },
      },
      {
        path: '/finance/officeExpense',
        name: 'officeExpense',
        component: () => import('@/views/finance/officeExpense/OfficeExpense.vue'),
        meta: {
          title: '办公经费',
          icon: 'TrendCharts',
          roles: ['sys:officeExpense'],
        },
      },
      {
        path: '/finance/priceTrend',
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
    path: '/purchasePaymentContract',
    component: Layout,
    redirect: '/purchasePaymentContract',
    children: [{
      path: '/purchasePaymentContract',
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
    path: '/logisticsPaymentContract',
    component: Layout,
    redirect: '/logisticsPaymentContract',
    children: [{
      path: '/logisticsPaymentContract',
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
    path: '/customerList',
    component: Layout,
    redirect: '/customerList',
    children: [{
      path: '/customerList',
      component: () => import('@/views/customer/CustomerList.vue'),
      name: 'customerList',
      meta: {
        title: '客户管理',
        icon: 'User',
        roles: ['sys:customerList'],
      },
    }]
  },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes: routes
})

export default router