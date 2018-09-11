/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.math.BigDecimal;

import com.eos.system.annotation.Bizlet;

/**
 * @author caikaifa
 * @date 2018-05-28 17:17:34
 * 
 */
@Bizlet("")
public class ArithUtil {

	// 默认除法的运算精度-保留十位小数
	private static final int DEF_DIV_SCALE = 10;

	// 这个类不能实例化
	private ArithUtil() {
	}

	/**
	 * 提供精确的加法运算
	 * 
	 * @param v1	被加数
	 * @param v2	加数
	 * @return 两个参数的和
	 */
	@Bizlet("")
	public static double add(double v1, double v2) {
		return add(Double.toString(v1), Double.toString(v2));
	}
	
	/**
	 * 提供精确的加法运算
	 * 
	 * @param v1	被加数
	 * @param v2	加数
	 * @return 两个参数的和
	 */
	@Bizlet("")
	public static double add(String v1, String v2) {
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.add(b2).doubleValue();
	}
	
	
	/**
     * 提供精确的减法运算
     * 
     * @param v1	被減数
     * @param v2	減数
     * @return 两个参数的差
     */
	@Bizlet("")
    public static double sub(double v1, double v2) {
        return sub(Double.toString(v1), Double.toString(v2));
    }
    
    /**
     * 提供精确的减法运算
     * 
     * @param v1	被減数
     * @param v2	減数
     * @return 两个参数的差
     */
	@Bizlet("")
    public static double sub(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.subtract(b2).doubleValue();
    }
	
    /**
     * 提供精确的乘法运算
     *
     * @param v1	被乘数
     * @param v2	乘数
     * @return 两个参数的积
     */
	@Bizlet("")
    public static double mul(double v1, double v2) {
        return mul(Double.toString(v1), Double.toString(v2));
    }
    
    /**
     * 提供精确的乘法运算
     *
     * @param v1	被乘数
     * @param v2	乘数
     * @return 两个参数的积
     */
	@Bizlet("")
    public static double mul(String v1, String v2) {
        BigDecimal b1 = new BigDecimal(v1);
        BigDecimal b2 = new BigDecimal(v2);
        return b1.multiply(b2).doubleValue();
    }
	
    
    /**
     * 提供（相对）精确的除非运算，当发生除不尽的情况时，精确到小数点以后10位，以后的数字四舍五入
     * 
     * @param v1	被除數
     * @param v2	除數
     * @return 兩個參數的商
     */
	@Bizlet("")
    public static double div(double v1, double v2) {
        return div(Double.toString(v1), Double.toString(v2));
    }
    
    /**
     * 提供（相对）精确的除非运算，当发生除不尽的情况时，精确到小数点以后10位，以后的数字四舍五入
     * 
     * @param v1	被除數
     * @param v2	除數
     * @return 兩個參數的商
     */
	@Bizlet("")
    public static double div(String v1, String v2) {
        return div(v1, v2, DEF_DIV_SCALE);
    }
    
    /**
	 * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指定精度，以后的数字四舍五入
	 * 
	 * @param v1		被除數
	 * @param v2		除數
	 * @param scale		表示表示需要精確到小數點以後位数。
	 * @return 兩個參數的商
	 */
	@Bizlet("")
	public static double div(double v1, double v2, int scale) {
		return div(Double.toString(v1), Double.toString(v2), scale);
	}
    
    /**
	 * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指定精度，以后的数字四舍五入
	 * 
	 * @param v1		被除數
	 * @param v2		除數
	 * @param scale		表示表示需要精確到小數點以後位数。
	 * @return 兩個參數的商
	 */
	@Bizlet("")
	public static double div(String v1, String v2, int scale) {
		if (scale < 0) {
			throw new IllegalArgumentException(
					"The scale must be a positive integer or zero");
		}
		BigDecimal b1 = new BigDecimal(v1);
		BigDecimal b2 = new BigDecimal(v2);
		return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
}
