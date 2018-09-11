package com.cjhxfund.ats.fm.comm;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import org.apache.commons.lang.StringUtils;

import com.eos.system.annotation.Bizlet;

/**
 * 字符串处理公共类
 * @author huangmizhi
 */
@Bizlet("")
public class StrUtil {
	
	/** 格式为 [#,##0.00] */
	public static DecimalFormat df1 = new DecimalFormat("#,##0.00");
	/** 格式为 [#,###] */
	public static DecimalFormat df2 = new DecimalFormat("#,###");
	/** 格式为 [###0.00] */
	public static DecimalFormat df3 = new DecimalFormat("###0.00");
	/** 格式为 [#,##0.0000] */
	public static DecimalFormat df4 = new DecimalFormat("#,##0.0000");
	/** 格式为 [#,##0.000] */
	public static DecimalFormat df5 = new DecimalFormat("#,##0.000");
	/** 格式化对象 */
	public static NumberFormat nf = NumberFormat.getInstance();

	/**
	 * 将NULL转换为空字符串
	 * @param str
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String changeNull(String str){
		if(str==null){
			str = "";
		}
		return str;
	}
	
	/**
	 * 判断str是否包含在arrStrs当中
	 * @param arrStrs 数组字符串,以英文逗号隔开
	 * @param str 字符串
	 * @return 包含返回true,否则返回false
	 */
	@Bizlet("")
	public static boolean isContains(String arrStrs, String str){
		if(arrStrs==null || "".equals(arrStrs.trim()) || str==null || "".equals(str.trim())){
			return false;
		}
		boolean result = false;
		String[] arr = arrStrs.split(",");
		for(int i=0; i<arr.length; i++){
			String temp = arr[i].trim();
			if(temp.equals(str.trim())){
				result = true;
				break;
			}
		}
		return result;
	}
	
	/**
	 * 将字符串拼凑成SQL in 条件的格式
	 * @param str 需转换的字符串，以英文逗号或分号分隔
	 * @return
	 */
	@Bizlet("")
	public static String changeInStr(String str){
		if(StringUtils.isBlank(str)){
			return "";
		}
		String result = "";
		StringBuffer sb = new StringBuffer();
		String[] strArr = str.replaceAll(";", ",").split(",");
		for(int i=0; i<strArr.length; i++){
			if(StringUtils.isNotEmpty(strArr[i])){
				sb.append("'").append(strArr[i]).append("',");
			}
		}
		if(sb.length()>0){
			result = sb.substring(0, sb.length()-1);
		}
		return result;
	}
	
	/**
	 * 将数值添加千分位返回
	 * @param str 需添加千分位的数值
	 * @param df 千分位数值格式对象
	 * @return 返回已添加千分位的数值
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String addThousandth(String str, DecimalFormat df){
		if(StringUtils.isBlank(str)){
			return "";
		}
		String result = str.trim();
		try {
			double val = Double.parseDouble(str.trim().replaceAll(",", ""));
			if(df==null){
				if(str.indexOf(".")==-1){//没有小数点
					result = df2.format(val);
				}else{//包含小数点
					result = df1.format(val);
				}
			}else{
				result = df.format(val);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 将数值添加千分位返回，若数值为零，返回空字符串
	 * @param str 需添加千分位的数值
	 * @param df 千分位数值格式对象
	 * @return 返回已添加千分位的数值，若数值为零，返回空字符串
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String addThousandth0ToEmpty(String str, DecimalFormat df){
		if(StringUtils.isBlank(str)){
			return "";
		}
		String result = str.trim();
		try {
			double val = Double.parseDouble(str.trim().replaceAll(",", ""));
			if(val==0){
				result = "";
			}else{
				if(df==null){
					if(str.indexOf(".")==-1){//没有小数点
						result = df2.format(val);
					}else{//包含小数点
						result = df1.format(val);
					}
				}else{
					result = df.format(val);
				}
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 将数值零转换为空字符串
	 * @param str 需转换的数值
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String change0ToEmpty(String str){
		if(StringUtils.isBlank(str)){
			return "";
		}
		String result = str.trim();
		try {
			double val = Double.parseDouble(str.trim().replaceAll(",", ""));
			if(val==0){
				result = "";
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 将基金代码名称拆分为字符串数组（代码名称以“-”分隔）
	 * @param fundCodeName 基金代码名称
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String[] getFundCodeAndName(String fundCodeName){
		if(StringUtils.isBlank(fundCodeName)){
			return null;
		}
		
		int index = fundCodeName.indexOf("-");
		String fundCode = fundCodeName.substring(0, index);
		String fundName = fundCodeName.substring(index+1, fundCodeName.length());
		return new String[]{fundCode,fundName};
	}
	
	/**
	 * 根据文件路径读取文件
	 * @param filePath 文件路径
	 * @param charsetName 编码格式，默认为：UTF-8
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static StringBuffer findContent(String filePath, String charsetName) {
		StringBuffer sb = new StringBuffer();
	    FileInputStream fis = null;
	    InputStreamReader isr = null;
	    BufferedReader reader = null;
	    try {
	    	if(StringUtils.isBlank(charsetName)){
	    		charsetName = "UTF-8";
	    	}
	    	fis = new FileInputStream(filePath);
	    	isr = new InputStreamReader(fis, charsetName);
	    	reader = new BufferedReader(isr);
	    	String line = null;
	    	while ((line = reader.readLine()) != null){
	    		sb.append(line).append("\r\n");
	    	}
	    } catch (IOException e) {
	    	e.printStackTrace();
	    } finally {
	    	try {
	    		if(fis!=null){fis.close();fis=null;}
	    		if(isr!=null){isr.close();isr=null;}
	    		if(reader!=null){reader.close();reader=null;}
			} catch (IOException e) {
				e.printStackTrace();
			}
	    }
	    return sb;
	}
	
	/**
	 * 根据文件路径读取文件,返回文件内容字符串
	 * @param filePath 文件路径
	 * @param charsetName 编码格式，默认为：UTF-8
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String findContentStr(String filePath, String charsetName){
		return findContent(filePath, charsetName).toString();
	}
	
	/**
	 * 删除千分号，若数值为空返回0
	 * @param str
	 * @return
	 * @author chenpeng
	 */
	@Bizlet("")
	public static String delThousandth(String str){
		String result = str;
		try{
			result = changeNull(str).replaceAll(",", "").replaceAll("，", "").trim();
			if(StringUtils.isBlank(result)){
				result = "0";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 删除千分位，若数值为空或转换错误，则返回0
	 * @param str
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static Double delThousandthEmptyTo0(String str){
		double result = 0;
		try {
			result = Double.valueOf(delThousandth(str));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 将传入字符串根据每行字符长度插入换行标志
	 * @param msgStr 传入字符串
	 * @param newlineFlag 换行标志
	 * @param stringLength 每行字符长度
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String addNewlineFlag(String msgStr, String newlineFlag, int stringLength){
		if(StringUtils.isBlank(msgStr)){
			return "";
		}
		StringBuffer sb = new StringBuffer();
		int count1 = msgStr.length()/stringLength;
		int count2 = msgStr.length()%stringLength;
		for(int i=0; i<count1; i++){
			String temp = msgStr.substring(i*stringLength, (i+1)*stringLength);
			if(count2==0 && i==count1-1){
				sb.append(temp);
			}else{
				sb.append(temp).append(newlineFlag);
			}
		}
		sb.append(msgStr.substring(count1*stringLength));
		return sb.toString();
	}
	
	public static void main(String[] args) {
		String[] arr = getFundCodeAndName("131811-Ｒ-002");
		System.out.println("代码："+arr[0]);
		System.out.println("名称："+arr[1]);
	}
}
