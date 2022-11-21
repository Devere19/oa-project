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
import Layout from "@/layout/Index.vue";
const store = navTreeStore()
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

const menus = computed(() => {
  let tree = store.getNavTree
  return tree
})
// const menus = reactive([
//   {
//     path: '/dashboard',
//     component: 'Layout',
//     name: 'dashboard',
//     meta: {
//       title: '首页',
//       icon: 'HomeFilled',
//       roles: ['sys:dashboard'],
//     },
//   },
//   {
//     path: '/system',
//     component: 'Layout',
//     name: 'system',
//     meta: {
//       title: '系统管理',
//       icon: 'Setting',
//       roles: ['sys:manage'],
//     },
//     children: [
//       {
//         path: '/userList',
//         component: '/system/user/UserList',
//         name: 'userList',
//         meta: {
//           title: '员工管理',
//           icon: 'UserFilled',
//           roles: ['sys:user'],
//         },
//       },
//       {
//         path: '/roleList',
//         component: '/system/role/RoleList',
//         name: 'roleList',
//         meta: {
//           title: '角色管理',
//           icon: 'Wallet',
//           roles: ['sys:role'],
//         },
//       },
//       {
//         path: '/menuList',
//         component: '/system/menu/MenuList',
//         name: 'menuList',
//         meta: {
//           title: '菜单管理',
//           icon: 'Menu',
//           roles: ['sys:menu'],
//         },
//       },
//     ],
//   },
//   {
//     path: '/purchaseContract',
//     component: 'Layout',
//     name: 'purchaseContract',
//     meta: {
//       title: '采购单',
//       icon: 'ShoppingCart',
//       roles: ['sys:purchaseContract'],
//     },
//   },
//   {
//     path: '/cashier',
//     component: 'Layout',
//     name: 'cashier',
//     meta: {
//       title: '出纳',
//       icon: 'Money',
//       roles: ['sys:cashier'],
//     },
//     children: [
//       {
//         path: '/cashier/cashierPurchasePayment',
//         component: '/cashier/purchasePayment/CashierPurchasePayment',
//         name: 'cashierPurchasePayment',
//         meta: {
//           title: '采购付款单',
//           icon: 'Money',
//           roles: ['sys:cashierPurchasePayment'],
//         },
//       },
//       {
//         path: '/cashier/cashierSale',
//         component: '/cashier/sale/CashierSale',
//         name: 'cashierSale',
//         meta: {
//           title: '出纳销售单',
//           icon: 'Money',
//           roles: ['sys:cashierSale'],
//         },
//       },
//       {
//         path: '/cashier/cashierLogisticsPayment',
//         component: '/cashier/logisticsPayment/CashierLogisticsPayment',
//         name: 'cashierLogisticsPayment',
//         meta: {
//           title: '物流付款单',
//           icon: 'Money',
//           roles: ['sys:cashierLogisticsPayment'],
//         },
//       },
//       {
//         path: '/cashier/cashierShipping',
//         component: '/cashier/shipping/CashierShipping',
//         name: 'cashierShipping',
//         meta: {
//           title: '出纳海运单',
//           icon: 'Money',
//           roles: ['sys:cashierShipping'],
//         },
//       },
//       {
//         path: '/cashier/cashierOfficeExpense',
//         component: '/cashier/officeExpense/CashierOfficeExpense',
//         name: 'cashierOfficeExpense',
//         meta: {
//           title: '办公经费',
//           icon: 'Money',
//           roles: ['sys:cashierOfficeExpense'],
//         },
//       },
//     ],
//   },
//   {
//     path: '/warehouseManagement',
//     component: 'Layout',
//     name: 'warehouseManagement',
//     meta: {
//       title: '仓库管理',
//       icon: 'Discount',
//       roles: ['sys:warehouseManagement'],
//     },
//   },
//   {
//     path: '/saleContract',
//     component: 'Layout',
//     name: 'saleContract',
//     meta: {
//       title: '销售单',
//       icon: 'Document',
//       roles: ['sys:saleContract'],
//     },
//   },
//   {
//     path: '/outbound',
//     component: 'Layout',
//     name: 'outbound',
//     meta: {
//       title: '出库信息',
//       icon: 'Shop',
//       roles: ['sys:outbound'],
//     },
//     children: [
//       {
//         path: '/outbound/outboundLogisticsList',
//         component: '/outbound/logistics/OutboundLogisticsList',
//         name: 'outboundLogisticsList',
//         meta: {
//           title: '出库物流单',
//           icon: 'Bicycle',
//           roles: ['sys:outboundLogisticsList'],
//         },
//       },
//       {
//         path: '/outbound/outboundShippingList',
//         component: '/outbound/shipping/OutboundShippingList',
//         name: 'outboundShippingList',
//         meta: {
//           title: '出库海运单',
//           icon: 'Ship',
//           roles: ['sys:outboundShippingList'],
//         },
//       },
//     ],
//   },
//   {
//     path: '/finance',
//     component: 'Layout',
//     name: 'finance',
//     meta: {
//       title: '财务管理',
//       icon: 'Coin',
//       roles: ['sys:finance'],
//     },
//     children: [
//       {
//         path: '/finance/reportAnalysis',
//         component: '/finance/reportAnalysis/ReportAnalysis',
//         name: 'reportAnalysis',
//         meta: {
//           title: '报表分析',
//           icon: 'TrendCharts',
//           roles: ['sys:reportAnalysis'],
//         },
//       },
//       {
//         path: '/finance/officeExpense',
//         component: '/finance/officeExpense/OfficeExpense',
//         name: 'officeExpense',
//         meta: {
//           title: '办公经费',
//           icon: 'TrendCharts',
//           roles: ['sys:officeExpense'],
//         },
//       },
//       {
//         path: '/finance/priceTrend',
//         component: '/finance/priceTrend/PriceTrend',
//         name: 'priceTrend',
//         meta: {
//           title: '单价走势',
//           icon: 'TrendCharts',
//           roles: ['sys:priceTrend'],
//         },
//       },
//     ],
//   },
//   {
//     path: '/purchasePaymentContract',
//     component: 'Layout',
//     name: 'purchasePaymentContract',
//     meta: {
//       title: '采购付款单',
//       icon: 'Document',
//       roles: ['sys:purchasePaymentContract'],
//     },
//   },
//   {
//     path: '/logisticsPaymentContract',
//     component: 'Layout',
//     name: 'logisticsPaymentContract',
//     meta: {
//       title: '物流付款单',
//       icon: 'Document',
//       roles: ['sys:logisticsPaymentContract'],
//     },
//   },
//   {
//     path: '/customerList',
//     component: 'Layout',
//     name: 'customerList',
//     meta: {
//       title: '客户管理',
//       icon: 'User',
//       roles: ['sys:customerList'],
//     },
//   },

// ])
</script>

<style>
.el-menu:not(.el-menu--collapse) {
  width: 230px;
  border-right: none;
}

.el-menu {
  border-right: solid 1px #545c64;
}
</style>