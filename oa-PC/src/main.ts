import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import * as ELIcons from '@element-plus/icons'
//引入国际化
import zhCn from 'element-plus/es/locale/lang/zh-cn'
//引入信息确认框
import myconFirm from './utils/myconfirm'
//引入对象快速复制
import objCopy from './utils/objCopy'
//引入element plus
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
//引入pinia
import { createPinia } from 'pinia'
// 持久化存储pinia
import piniaPluginPersist from 'pinia-plugin-persist'
import print from 'vue3-print-nb'


const app = createApp(App)


//ELIcons作为全局变量使用
for (const name in ELIcons) {
    app.component(name, (ELIcons as any)[name])
}
app.use(ElementPlus, {
    locale: zhCn,
})
app.use(createPinia().use(piniaPluginPersist))
app.use(router).use(print).mount('#app')

//全局挂载使用
app.config.globalProperties.$myconfirm = myconFirm
app.config.globalProperties.$objCopy = objCopy