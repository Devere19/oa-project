import http from "@/http";
import { LoginModel } from "./LoginModel";

//登录
export const loginApi = (parm: LoginModel) => {
  return http.post("/login", parm)
}