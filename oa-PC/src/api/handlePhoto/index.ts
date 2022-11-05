import http from "@/http";

// 删除照片
export const deletePhotoApi = (photoURL: string) => {
    return http.get("deletePhoto", { photoURL: photoURL });
}