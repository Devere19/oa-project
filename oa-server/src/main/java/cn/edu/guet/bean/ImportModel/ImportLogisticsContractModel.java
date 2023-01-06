package cn.edu.guet.bean.ImportModel;

import cn.edu.guet.bean.logisticsContract.LogisticsDetail;
import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @Author Devere19
 * @Date 2022/11/29 20:55
 * @Version 1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImportLogisticsContractModel {


    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "运输合同编号")
    private String logisticsContractNo;

    /**
     * 物流单类型
     */
    @ExcelProperty(value = "物流单类型（1：加工单 0：销售单）")
    private Integer upperType;

    /**
     * 销售/加工单合同编号
     */
    @ExcelProperty(value = "销售/加工单合同编号")
    private String saleContractNo;

    /**
     * 物流单合同签订时间
     */
    @ExcelProperty(value = "物流单合同签订时间")
    private Date logisticsContractTime;


    /**
     * 销售单合同总重量
     */
    @ExcelProperty(value = "销售单合同总重量")
    private BigDecimal totalWeight;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位")
    private String goodsUnit;

    /**
     * 运费
     */
    @ExcelProperty(value = "运费")
    private BigDecimal freight;


    /**
     * 榨季
     */
    @ExcelProperty(value = "榨季")
    private String squeezeSeason;

    /**
     * 己方公司名
     */
    @ExcelProperty(value = "己方公司名")
    private String ownCompanyName;



    //物流详情但1
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）1")
    private String logisticsContractNo1;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型1")
    private String upperType1;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号1")
    private String purchaseContractNo1;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期1")
    private Date outboundTime1;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名1")
    private String goodsFactory1;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号1")
    private String licensePlateNumber1;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量1")
    private BigDecimal goodsWeight1;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位1")
    private String goodsUnit1;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价1")
    private BigDecimal unitPrice1;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点1")
    private String unloadingLocation1;

    //物流详情但2
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）2")
    private String logisticsContractNo2;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型2")
    private String upperType2;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号2")
    private String purchaseContractNo2;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期2")
    private Date outboundTime2;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名2")
    private String goodsFactory2;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号2")
    private String licensePlateNumber2;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量2")
    private BigDecimal goodsWeight2;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位2")
    private String goodsUnit2;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价2")
    private BigDecimal unitPrice2;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点2")
    private String unloadingLocation2;

    //物流详情但3
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）3")
    private String logisticsContractNo3;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型3")
    private String upperType3;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号3")
    private String purchaseContractNo3;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期3")
    private Date outboundTime3;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名3")
    private String goodsFactory3;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号3")
    private String licensePlateNumber3;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量3")
    private BigDecimal goodsWeight3;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位3")
    private String goodsUnit3;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价3")
    private BigDecimal unitPrice3;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点3")
    private String unloadingLocation3;

    //物流详情但4
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）4")
    private String logisticsContractNo4;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型4")
    private String upperType4;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号4")
    private String purchaseContractNo4;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期4")
    private Date outboundTime4;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名4")
    private String goodsFactory4;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号4")
    private String licensePlateNumber4;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量4")
    private BigDecimal goodsWeight4;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位4")
    private String goodsUnit4;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价4")
    private BigDecimal unitPrice4;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点4")
    private String unloadingLocation4;

    //物流详情但5
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）5")
    private String logisticsContractNo5;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型5")
    private String upperType5;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号5")
    private String purchaseContractNo5;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期5")
    private Date outboundTime5;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名5")
    private String goodsFactory5;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号5")
    private String licensePlateNumber5;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量5")
    private BigDecimal goodsWeight5;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位5")
    private String goodsUnit5;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价5")
    private BigDecimal unitPrice5;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点5")
    private String unloadingLocation5;

    //物流详情但6
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）6")
    private String logisticsContractNo6;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型6")
    private String upperType6;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号6")
    private String purchaseContractNo6;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期6")
    private Date outboundTime6;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名6")
    private String goodsFactory6;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号6")
    private String licensePlateNumber6;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量6")
    private BigDecimal goodsWeight6;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位6")
    private String goodsUnit6;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价6")
    private BigDecimal unitPrice6;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点6")
    private String unloadingLocation6;

    //物流详情但7
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）7")
    private String logisticsContractNo7;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型7")
    private String upperType7;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号7")
    private String purchaseContractNo7;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期7")
    private Date outboundTime7;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名7")
    private String goodsFactory7;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号7")
    private String licensePlateNumber7;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量7")
    private BigDecimal goodsWeight7;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位7")
    private String goodsUnit7;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价7")
    private BigDecimal unitPrice7;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点7")
    private String unloadingLocation7;

    //物流详情但8
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）8")
    private String logisticsContractNo8;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型8")
    private String upperType8;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号8")
    private String purchaseContractNo8;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期8")
    private Date outboundTime8;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名8")
    private String goodsFactory8;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号8")
    private String licensePlateNumber8;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量8")
    private BigDecimal goodsWeight8;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位8")
    private String goodsUnit8;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价8")
    private BigDecimal unitPrice8;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点8")
    private String unloadingLocation8;

    //物流详情但9
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）9")
    private String logisticsContractNo9;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型9")
    private String upperType9;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号9")
    private String purchaseContractNo9;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期9")
    private Date outboundTime9;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名9")
    private String goodsFactory9;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号9")
    private String licensePlateNumber9;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量9")
    private BigDecimal goodsWeight9;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位9")
    private String goodsUnit9;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价9")
    private BigDecimal unitPrice9;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点9")
    private String unloadingLocation9;

    //物流详情但10
    /**
     * 物流单合同编号（运输合同编号）
     */
    @ExcelProperty(value = "物流单合同编号（运输合同编号）10")
    private String logisticsContractNo10;

    /**
     * 物流详情单类型
     */
    @ExcelProperty(value = "物流详情单类型10")
    private String upperType10;


    /**
     * 采购/加工合同编号
     */
    @ExcelProperty(value = "采购/加工合同编号10")
    private String purchaseContractNo10;

    /**
     * 出库日期
     */
    @ExcelProperty(value = "出库日期10")
    private Date outboundTime10;


    /**
     * 取货厂名
     */
    @ExcelProperty(value = "取货厂名10")
    private String goodsFactory10;


    /**
     * 车牌号
     */
    @ExcelProperty(value = "车牌号10")
    private String licensePlateNumber10;

    /**
     * 载货量
     */
    @ExcelProperty(value = "载货量10")
    private BigDecimal goodsWeight10;

    /**
     * 货物单位
     */
    @ExcelProperty(value = "货物单位10")
    private String goodsUnit10;

    /**
     * 运输单价
     */
    @ExcelProperty(value = "运输单价10")
    private BigDecimal unitPrice10;


    /**
     * 卸货地点
     */
    @ExcelProperty(value = "卸货地点10")
    private String unloadingLocation10;
}
