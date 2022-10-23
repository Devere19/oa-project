import { defineStore } from 'pinia'

//定义store
export const userStore = defineStore('userStore', {
  //定义states
  state: () => {
    return {
      user: {},
    }
  },
  persist: {
    enabled: true
  },
  //定义getter
  getters: {
    //获取state里面的count
    getUser(state) {
      return state.user;
    },
  },
  //定义actions
  actions: {
    //设置count的值，这里不能使用箭头函数
    setUser(user: any) {
      this.user = user;
    }
  }
})