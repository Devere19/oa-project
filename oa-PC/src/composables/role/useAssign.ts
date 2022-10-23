import { AssignParm } from "@/api/role/RoleModel";
import { onMounted, reactive } from "vue";
import { getAllMenuApi } from "@/api/menu/index"
export default function useAssign() {
  //树的属性配置
  const defaultProps = reactive({
    children: 'children',
    label: 'name',
  })
  const menulist = reactive({
    data: [],
  }
  )


  onMounted(async () => {
    menulist.data = []
    let res = await getAllMenuApi()
    if (res && res.code == 200) {
      menulist.data = res.data[0].children
    }
  })

  return {
    defaultProps, menulist
  }
}