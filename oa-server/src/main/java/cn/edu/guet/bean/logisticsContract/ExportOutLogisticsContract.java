package cn.edu.guet.bean.logisticsContract;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 物流单
 * @TableName logistics_contract
 */

@Data
public class ExportOutLogisticsContract implements Serializable {

    /**
     * 物流单合同编号（运输合同编号）
     */
    @Excel(name = "物流单合同编号")
    private String logisticsContractNo;

    /**
     * 销售单合同编号
     */
    @Excel(name = "销售单合同编号")
    private String saleContractNo;

    /**
     * 己方公司名
     */
    @Excel(name = "己方公司名")
    private String ownCompanyName;
    /**
     * 销售单合同总重量
     */
    @Excel(name = "物流合同总重量")
    private BigDecimal totalWeight;

    /**
     * 货物单位
     */
    @Excel(name = "货物单位")
    private String goodsUnit;

    /**
     * 运费
     */
    @Excel(name = "运费")
    private BigDecimal freight;



    /**
     * 物流单合同签订时间
     */
    @Excel(name = "物流单合同签订时间")
    private String logisticsContractTime;

    /**
     * 榨季
     */
    @Excel(name = "榨季")
    private String squeezeSeason;



    /**
     * 创建者名称
     */
    @Excel(name = "创建者名称")
    private String createBy;




}