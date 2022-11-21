<template>
  <template v-for="menu in menus" :key="menu.url">
    <el-sub-menu v-if="menu.children && menu.children.length > 0" :index="menu.url">
      <template #title>
        <el-icon>
          <component :is="menu.icon"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </template>
      <menu-item :menus="menu.children"></menu-item>
    </el-sub-menu>

    <el-menu-item v-else :index="menu.url">
      <el-icon>
        <component :is="menu.icon" />
      </el-icon>
      <span>{{ menu.name }}</span>
    </el-menu-item>
  </template>
</template>

<script setup lang="ts">
//import { useRouter } from 'vue-router';
defineProps(["menus"]);
//const router=useRouter()
//const toPath=(item:string)=>{
//  router.push({name:item})
//}
</script>

<style scoped>

</style>