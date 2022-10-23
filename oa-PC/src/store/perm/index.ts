import { defineStore } from 'pinia'

//定义store
export const permsStore = defineStore('permsStore', {
  //定义states
  state: () => {
    return {
      perms: [] as any,
    }
  },
  persist: {
    enabled: true
  },
  //定义getter
  getters: {
    //获取state里面的count
    getPerms(state) {
      return state.perms;
    },
  },
  //定义actions
  actions: {
    //设置count的值，这里不能使用箭头函数
    setPerms(perms: any) {
      this.perms = perms;
    }
  }
})