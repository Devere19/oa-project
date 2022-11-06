package cn.edu.guet.controller;

import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.UUID;

/**
 * @author 陶祎祎
 */
@RestController
public class PhotoController {

    @RequestMapping("/addContractPhoto")
    public HttpResult addContractPhoto(MultipartFile file){
        // 获取文件名
        String fileName = file.getOriginalFilename();
        // 获取文件后缀
        String prefix = fileName.substring(fileName.lastIndexOf("."));
        // 若须要防止生成的临时文件重复,能够在文件名后添加随机码
        System.out.println("文件名称:" + fileName.substring(0, fileName.lastIndexOf(".")) + prefix);

        //        生成uuid随机文件名
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");

        File oldFile=null;
        File tempFile =null;
        FileOutputStream imagePath=null;
        FileInputStream fileInputStream=null;
        InputStream inputStream=null;
        FileOutputStream image=null;
        try {
//            将MultipartFile文件转换成File文件
            tempFile = File.createTempFile(fileName.substring(0, fileName.lastIndexOf(".")), prefix);
            file.transferTo(tempFile);

//            创建本地图片文件
            imagePath = new FileOutputStream("static\\images\\" + uuid + ".jpg");
            fileInputStream = new FileInputStream(tempFile);
            // 将照片从二进制转换为jpg
            // 读取字节流
            inputStream = (InputStream) fileInputStream;
            int a;
            byte b[] = new byte[8192];
            while ((a = inputStream.read(b)) != -1) {
                image = (FileOutputStream) (imagePath);
                image.write(b, 0, a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                imagePath.close();
                fileInputStream.close();
                inputStream.close();
                image.close();
                //            删除临时文件
                System.out.println("删除临时文件结果" + tempFile.delete());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return ResultUtils.success("修改成功","http://localhost:9000/static/images/" + uuid + ".jpg");
    }

    @RequestMapping("/deletePhoto")
    public HttpResult deletePhoto(String photoURL){
        System.out.println(photoURL);
        File photo= new File("static\\images\\" + photoURL.split("/static/images/")[1]);
        if(photo.exists()){
            System.out.println("删除原文件结果"+photo.delete());
        }
        return ResultUtils.success("删除成功");
    }
}
