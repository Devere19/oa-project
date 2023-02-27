package cn.edu.guet.util;

import java.io.File;
import java.net.URI;
import java.net.URISyntaxException;

/**
 * @Author Devere19
 * @Date 2023/2/27 14:13
 * @Version 1.0
 */
public class Test {
    public static void main(String[] args) {
        String path = Thread.currentThread().getContextClassLoader().getResource("/static/model").getPath();
        System.out.println(path);
        File file = new File(path);
        for (File listFile : file.listFiles()) {
            System.out.println(listFile.getName());
        }
        // System.out.println(file.getName());
    }
}
