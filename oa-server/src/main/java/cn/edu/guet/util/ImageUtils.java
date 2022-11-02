package cn.edu.guet.util;

/**
 * @Author Devere19
 * @Date 2022/11/2 10:47
 * @Version 1.0
 */

import java.util.ArrayList;
import java.util.List;

/**
 * 图片工具类
 */
public class ImageUtils {

    /**
     * 从数据库拿到图片路径，用，分割形成一个list
     * @param str
     * @return
     */
    public static List<String> imageSplit(String str){
        List<String> result = new ArrayList<>();
        for (String s : str.split(",")) {
            result.add(s);
        }
        return result;
    }

    /**
     * 从数据库拿到图片路径，取第一个图片的url
     * @param str
     * @return
     */
    public static String getFirstImageUrl(String str){
        String[] split = str.split(",");
        return split[0];
    }
}
