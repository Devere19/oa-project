package cn.edu.guet.controller;

import cn.edu.guet.bean.PageParm;
import cn.edu.guet.bean.SysRole;
import cn.edu.guet.bean.SysUser;
import cn.edu.guet.bean.SysUserRole;
import cn.edu.guet.http.HttpResult;
import cn.edu.guet.http.ResultUtils;
import cn.edu.guet.service.SysRoleService;
import cn.edu.guet.service.SysUserRoleService;
import cn.edu.guet.service.SysUserService;
import cn.edu.guet.util.PasswordUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 用户控制器
 *
 * @Author Liwei
 * @Date 2021-08-17 07:15
 */
@RestController
@RequestMapping("/api/user")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @Resource
    private SysUserRoleService sysUserRoleService;

    @Resource
    private SysRoleService sysRoleService;

    @GetMapping(value = "/findPermissions")
    public HttpResult findPermissions(@RequestParam String name) {
        System.out.println("查找权限：" + name);
        System.out.println("find");
        return ResultUtils.success("查询成功", sysUserService.findPermissions(name));
    }

    //新增
    @PostMapping
    public HttpResult add(@RequestBody SysUser sysUser) {
        // sysUser.setCreateTime(new Date());
        System.out.println("新增用户" + sysUser);
        if (StringUtils.isNotEmpty(sysUser.getPassword())) {
            String salt = PasswordUtils.getSalt();
            String encode = PasswordUtils.encode(sysUser.getPassword(), salt);
            sysUser.setPrePassword(sysUser.getPassword());
            sysUser.setPassword(encode);
            sysUser.setSalt(salt);
            // sysUser.setCreateTime(new Date());
        }
        //判断该用户是否存在
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getName, sysUser.getName());
        SysUser one = sysUserService.getOne(query);
        if (one != null) {
            return ResultUtils.error("该账户已经被注册");
        }
        //保存
        sysUserService.addUser(sysUser);
        return ResultUtils.success("新用户注册成功！");

    }

    //编辑
    @PutMapping
    public HttpResult edit(@RequestBody SysUser sysUser) {
        // sysUser.setLastUpdateTime(new Date());
        if (StringUtils.isNotEmpty(sysUser.getPassword())) {
            sysUser.setPrePassword(sysUser.getPassword());
            sysUser.setPassword(PasswordUtils.encode(sysUser.getPassword(), sysUser.getSalt()));
        }
        //判断该用户是否存在
        System.out.println(sysUser);
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getId, sysUser.getId());
        SysUser one = sysUserService.getOne(query);

        if (one != null) {
            //更新
            sysUserService.editUser(sysUser);
            return ResultUtils.success("更新成功！");
        }
        return ResultUtils.error("更新失败！");
    }

    //删除
    @DeleteMapping("/{Id}")
    public HttpResult delete(@PathVariable("Id") Long Id) {
        sysUserService.deleteUser(Id);
        System.out.println("delete");
        return ResultUtils.success("删除成功！");
    }


    //查询列表
    @GetMapping("/list")
    public HttpResult list(PageParm parm) {
        IPage<SysUser> list = sysUserService.getList(parm);
        if (list.getRecords().size() > 0) {
            list.getRecords().forEach(item -> {
                item.setPassword(item.getPrePassword());
            });
        }
        System.out.println(list.getRecords());
        return ResultUtils.success("查询成功", list);
    }

    //根据用户id查询角色id
    @GetMapping("/role")
    public HttpResult getRole(Long userId) {
        System.out.println(userId);
        QueryWrapper<SysUserRole> query = new QueryWrapper<>();
        query.lambda().eq(SysUserRole::getUserId, userId);
        // SysUserRole one = sysUserRoleService.getOne(query);
        List<SysUserRole> list = sysUserRoleService.list(query);
        ArrayList<Long> roleList = new ArrayList<>();
        for (SysUserRole sysUserRole : list) {
            Long roleId = sysUserRole.getRoleId();
            roleList.add(roleId);
        }
        return ResultUtils.success("查询成功", roleList);
    }

    //通过username获取user信息
    @GetMapping("/nickName/{name}")
    public HttpResult getNickName(@PathVariable("name") String name) {
        System.out.println("需要的username是：" + name);
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getName, name);
        SysUser sysUser = sysUserService.getOne(query);
        //赋值roleId和roleName
        QueryWrapper<SysUserRole> sysUserRoleQueryWrapper = new QueryWrapper<>();
        sysUserRoleQueryWrapper.lambda().eq(SysUserRole::getUserId, sysUser.getId());
        // SysUserRole sysUserRole = sysUserRoleService.getOne(sysUserRoleQueryWrapper);
        List<SysUserRole> sysUserRoleList = sysUserRoleService.list(sysUserRoleQueryWrapper);
        List<Long> roleIdList = new ArrayList<>();
        List<String> roleNameList = new ArrayList<>();
        for (SysUserRole sysUserRole : sysUserRoleList) {
            QueryWrapper<SysRole> sysRoleQueryWrapper = new QueryWrapper<>();
            sysRoleQueryWrapper.lambda().eq(SysRole::getId, sysUserRole.getRoleId());
            SysRole sysRole = sysRoleService.getOne(sysRoleQueryWrapper);
            roleIdList.add(sysRole.getId());
            roleNameList.add(sysRole.getName());
        }
        sysUser.setRoleId(roleIdList);
        sysUser.setRoleNames(roleNameList);
        return ResultUtils.success("查询成功", sysUser);
    }

    //验证是否有该用户名
    @GetMapping("/user/{name}")
    public HttpResult getUserByName(@PathVariable("name") String name) {
        Boolean result = sysUserService.getUserByName(name);
        return ResultUtils.success("查询成功", result);
    }

    //验证该用户的姓名和身份证号是否一致
    @GetMapping("/user/{nickName}/{identity}/{name}")
    public HttpResult nickAndIdenIsTrue(@PathVariable("nickName") String nickName, @PathVariable("identity") String identity, @PathVariable("name") String name) {
        Boolean result = sysUserService.nickAndIdenIsTrue(nickName, identity, name);
        return ResultUtils.success("查询成功", result);
    }

    //修改密码
    @PutMapping("/user")
    public HttpResult forgetPassword(@RequestBody SysUser sysUser) {
        //拿到该用户
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getName, sysUser.getName());
        SysUser one = sysUserService.getOne(query);
        //修改password
        if (StringUtils.isNotEmpty(sysUser.getPassword())) {
            one.setPrePassword(sysUser.getPassword());
            one.setPassword(PasswordUtils.encode(sysUser.getPassword(), one.getSalt()));
        }
        //更新
        sysUserService.updateById(one);
        return ResultUtils.success("修改密码成功");
    }


}
