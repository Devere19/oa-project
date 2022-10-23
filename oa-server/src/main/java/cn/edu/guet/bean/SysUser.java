package cn.edu.guet.bean;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Liwei
 * @Date 2021-08-13 17:39
 */
@Data
@TableName("sys_user")
public class SysUser extends BaseModel {

    private String name;

    private String nickName;

    private String avatar;

    private String password;

    private String salt;

    private String email;

    private String mobile;

    private Byte status;

    private Long deptId;

    private Byte delFlag;

	//表明roleId字段不属于sys_user表，需要排除
	@TableField(exist = false)
	private Long roleId;
	// 非数据库字段
	@TableField(exist = false)
    private String roleNames;
    // 非数据库字段
	@TableField(exist = false)
    private List<SysUserRole> userRoles = new ArrayList<>();

}