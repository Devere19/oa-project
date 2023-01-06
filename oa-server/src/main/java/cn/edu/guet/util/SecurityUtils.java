package cn.edu.guet.util;

import cn.edu.guet.bean.SysUser;
import cn.edu.guet.mapper.SysUserMapper;
import cn.edu.guet.security.JwtAuthenticationToken;
import cn.edu.guet.security.JwtUserDetails;
import cn.edu.guet.service.Impl.SysUserServiceImpl;
import cn.edu.guet.service.SysUserService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 * Security相关操作
 *
 * @Author Liwei
 * @Date 2021-08-13 06:55
 */
@Component
public class SecurityUtils {
    private static SecurityUtils securityUtils;

    @Resource
    private SysUserMapper sysUserMapper;

    @PostConstruct
    public void init() {
        securityUtils = this;
        securityUtils.sysUserMapper = this.sysUserMapper;
    }

    // public static String driver = "com.mysql.cj.jdbc.Driver";
    // public static String url = "jdbc:mysql://8.141.150.151:3306/oa_project?useSSL=false&serverTimezone=GMT%2B8&allowPublicKeyRetrieval=true";
    // public static String user = "root";
    // public static String password = "Guoleyuan0627!";


    /**
     * 系统登录认证
     *
     * @param request
     * @param username
     * @param password
     * @param authenticationManager
     * @return
     */
    public static JwtAuthenticationToken login(HttpServletRequest request, String username, String password, AuthenticationManager authenticationManager) {
        JwtAuthenticationToken token = new JwtAuthenticationToken(username, password);
        token.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        // 执行登录认证过程
        Authentication authentication = authenticationManager.authenticate(token);
        // 认证成功存储认证信息到上下文
        SecurityContextHolder.getContext().setAuthentication(authentication);
        // 生成令牌并返回给客户端
        token.setToken(JwtTokenUtils.generateToken(authentication));
        return token;
    }

    /**
     * 获取令牌进行认证
     *
     * @param request
     */
    public static void checkAuthentication(HttpServletRequest request) {
        // 获取令牌并根据令牌获取登录认证信息
        Authentication authentication = JwtTokenUtils.getAuthenticationeFromToken(request);
        // 设置登录认证信息到上下文
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    /**
     * 获取当前用户名
     *
     * @return
     */
    public static String getUsername() {
        String username = null;
        Authentication authentication = getAuthentication();
        if (authentication != null) {
            // 获取登录用户名
            Object principal = authentication.getPrincipal();
            // 因为这里 principal instanceof UserDetails 可能为假
            if (principal != null && principal instanceof UserDetails) {
                username = ((JwtUserDetails) principal).getNickName();
            } else {
                username = (String) principal;
            }
        }
        // String nickNameByName = securityUtils.sysUserMapper.getNickNameByName(username);
        System.out.println("当前登陆人"+username);
        //通过username去拿到nickName
        return username;
    }

    /**
     * 获取用户名
     *
     * @return
     */
    public static String getUsername(Authentication authentication) {
        String username = null;
        if (authentication != null) {
            Object principal = authentication.getPrincipal();
            if (principal != null && principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            } else {
                username = (String) principal;
            }
        }
        return securityUtils.sysUserMapper.getNickNameByName(username);
    }

    /**
     * 获取当前登录信息
     *
     * @return
     */
    public static Authentication getAuthentication() {
        if (SecurityContextHolder.getContext() == null) {
            return null;
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication;
    }
}
