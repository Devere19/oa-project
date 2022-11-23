package cn.edu.guet.bean.log;

import cn.edu.guet.bean.BaseModel;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author Liwei
 * @Date 2021-08-13 17:37
 */
@TableName("sys_log")
@Data
public class SysLog extends BaseModel {
	@TableId(type = IdType.AUTO)
	private Long id;

    private String userName;

    private String operation;

    private String method;

    private String params;

    private Long time;

    private String ip;




}