package cn.edu.guet.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

/**
 * @author 陶祎祎
 */
@Configuration
public class ResourceConfig {
//    @Bean
//    public WebMvcConfigurer webMvcConfigurer(){
//        return new WebMvcConfigurer() {
//            @Override
//            public void addResourceHandlers(ResourceHandlerRegistry registry) {
//                //            在服务器上用这个
//                File upload = new File("/static/");
//                if(!upload.exists()) {
//                    upload.mkdirs();
//                }
//                System.out.println(upload.getAbsolutePath());
//                registry.addResourceHandler("/static/**").addResourceLocations("file:/static/");
//            }
//        };
//    }
}
