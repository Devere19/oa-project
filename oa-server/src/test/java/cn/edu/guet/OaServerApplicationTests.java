package cn.edu.guet;

import cn.edu.guet.util.PasswordUtils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class OaServerApplicationTests {

    @Test
    void contextLoads() {
        String password="b1c5b3d735dbe4cdb44cef856ba5c958";
        String salt="ec032ec23df44d2ebe87";
        System.out.println(PasswordUtils.matches(salt, "123456",password));
    }

}
