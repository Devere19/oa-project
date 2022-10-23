import { defineStore } from 'pinia'
//定义store
export const navTreeStore = defineStore('navTreeStore', {

  //定义states
  state: () => {
    return {
      navTree: [] as any
    }
  },
  persist: {
    enabled: true
  },
  //定义getter
  getters: {
    //获取state里面的count
    getNavTree(state) {
      return state.navTree;
    }
  },
  //定义actions
  actions: {
    //设置count的值，这里不能使用箭头函数
    setNaveTree(navTree: any) {
      this.navTree = navTree;
    }
  }
})