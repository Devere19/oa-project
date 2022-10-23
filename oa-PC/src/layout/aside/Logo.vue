<template>
    <div class="logo">
        <img src="@/assets/logo.png" />
        <h2 class="title" v-show="!collapsed">vue3.admain</h2>
    </div>
</template>

<script setup lang="ts">

defineProps({
    collapsed: {
        type: Boolean
    }
})
</script>

<style scoped lang="scss">
.logo {
    display: flex;
    margin: 0;
    align-items: center;
    overflow: hidden;
    background-color: #545c64;
    color: #fff;
    height: 100%;

    img {
        height: 50px;
        width: 100%;
    }

    .title {
        width: 100%;
        font-size: 20px;
        color: white;
        margin-inline: 0;
    }
}
</style>