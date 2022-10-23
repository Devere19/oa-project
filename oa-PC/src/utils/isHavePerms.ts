import { permsStore } from '@/store/perm'
import { onMounted, ref } from 'vue'
export default function isHavePerms(viewparm: string, editparm: string, deleteparm: string, addparm: string) {
  //获取权限
  const permStore = permsStore()
  let isSearch = ref(false)
  let isEdit = ref(false)
  let isDelete = ref(false)
  let isAdd = ref(false)

  onMounted(() => {
    // isSearch.value = !permStore.getPerms.includes(viewparm)
    // isEdit.value = !permStore.getPerms.includes(editparm)
    // isDelete.value = !permStore.getPerms.includes(deleteparm)
    // isAdd.value = !permStore.getPerms.includes(addparm)
    isSearch.value = false
    isEdit.value = false
    isDelete.value = false
    isAdd.value = false
  })

  return {
    isSearch,
    isEdit,
    isDelete,
    isAdd
  }
}