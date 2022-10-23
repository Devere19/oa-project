package cn.edu.guet.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.util.Date;

/**
 * 基础模型
 * @Author Liwei
 * @Date 2021-08-13 17:33
 */
@Data
public class BaseModel {

	@TableId(type = IdType.AUTO)
	private Long id;
	
    private String createBy;

    private Date createTime;

    private String lastUpdateBy;

    private Date lastUpdateTime;

    
}
