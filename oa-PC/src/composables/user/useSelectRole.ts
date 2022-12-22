import { getRoleApi, getSelectApi } from "@/api/user";
import { SelectRole } from "@/api/user/UserModel";
import { reactive, ref } from "vue";


export default function useSelectRole() {

  const roleId = ref([])
  // const roleId = reactive([])

  //定义角色列表数据
  const roleData = reactive<SelectRole>({
    list: []
  })

  //获取数据
  const listRole = async () => {
    let res = await getSelectApi()
    if (res && res.code == 200) {
      roleData.list = res.data
    }
  }

  //根据用户id查询角色
  const getRole = async (userId: string) => {
    roleId.value = []
    let res = await getRoleApi(userId)
    if (res && res.code == 200 && res.data) {
      console.log("根据用户id查询到的角色", res)
      roleId.value = res.data
    }
  }

  return {
    roleData,
    listRole,
    getRole,
    roleId
  }
}