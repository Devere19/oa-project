package cn.edu.guet.util;

import java.math.BigDecimal;

/**
 * @author 陶祎祎
 */
public class UnitUtils {
    public static BigDecimal TtoG(BigDecimal data){
        return data.multiply(BigDecimal.valueOf(2000));
    }

    public static BigDecimal GtoT(BigDecimal data){
        return data.divide(BigDecimal.valueOf(2000));
    }
}
