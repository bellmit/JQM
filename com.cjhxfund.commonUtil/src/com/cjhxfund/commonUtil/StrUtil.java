package com.cjhxfund.commonUtil;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;
import org.apache.commons.lang.StringUtils;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 字符串处理公共类
 * @author huangmizhi
 */
@Bizlet("")
public class StrUtil extends org.apache.commons.lang.StringUtils{
	
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
	private static final char SEPARATOR = '_';
	private static final String CHARSET_NAME = "UTF-8";

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
	 * 删除千分位，若数值为空或转换错误，则返回0
	 * @param str
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static int delThousandthEmptyTo0Int(String str){
		int result = 0;
		try {
			result = Integer.valueOf(delThousandth(str));
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
	 
	/**
	 * @Description 判断对象不能为空
	 * @Author		liangjilong
	 * @Date		2016年12月26日 上午10:47:05
	 * @param obj
	 * @return 		参数
	 * @return 		boolean 返回类型(不为空的时候返回true，其他返回false)
	 */
	@Bizlet("判断对象不能为空")
	public static boolean isNotEmpty(Object obj){
		 return !isEmpty(obj);  
	}
	
	/**
	 * @Description 判断对象为空
	 * @Author		liangjilong
	 * @Date		2016年12月26日 上午10:47:05
	 * @param obj
	 * @return 		参数
	 * @return 		boolean 返回类型(不空的时候返回true，其他返回false)
	 */
	@Bizlet("判断对象为空")
	@SuppressWarnings("all")
	public static boolean isEmpty(Object obj){
		if (obj == null) {
			return true;
		} else if (obj instanceof String) {
			return ((String) obj).isEmpty();
		} else if (obj instanceof Map) {
			return ((Map) obj).size()==0 || ((Map) obj).isEmpty();
		} else if (obj instanceof HashMap) {
			return ((HashMap) obj).size()==0 || ((HashMap) obj).isEmpty();
		}else if (obj instanceof Vector) {
			return ((Vector) obj).size()==0 || ((Vector) obj).isEmpty();
		} else  if ((obj instanceof List)) {
			return ((List) obj).size() == 0 || ((List) obj).isEmpty();
		} else  if ((obj instanceof ArrayList)) {
			return ((ArrayList) obj).size() == 0 || ((ArrayList) obj).isEmpty();
		} else{
			return false;
		}
	}
	
	
	    
    /**
     * 转换为字节数组
     * @param str
     * @return
     */
    public static byte[] getBytes(String str){
    	if (str != null){
    		try {
				return str.getBytes(CHARSET_NAME);
			} catch (UnsupportedEncodingException e) {
				return null;
			}
    	}else{
    		return null;
    	}
    }
	    
    /**
     * 转换为字节数组
     * @param str
     * @return
     */
    public static String toString(byte[] bytes){
    	try {
			return new String(bytes, CHARSET_NAME);
		} catch (UnsupportedEncodingException e) {
			return EMPTY;
		}
    }
	    
    /**
     * 是否包含字符串
     * @param str 验证字符串
     * @param strs 字符串组
     * @return 包含返回true
     */
    public static boolean inString(String str, String... strs){
    	if (str != null){
        	for (String s : strs){
        		if (str.equals(trim(s))){
        			return true;
        		}
        	}
    	}
    	return false;
    }
	    
	/**
	 * 替换掉HTML标签方法
	 */
	public static String replaceHtml(String html) {
		if (isBlank(html)){
			return "";
		}
		String regEx = "<.+?>";
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(html);
		String s = m.replaceAll("");
		return s;
	}
		
	/**
	 * 替换为手机识别的HTML，去掉样式及属性，保留回车。
	 * @param html
	 * @return
	 */
	public static String replaceMobileHtml(String html){
		if (html == null){
			return "";
		}
		return html.replaceAll("<([a-z]+?)\\s+?.*?>", "<$1>");
	}
		
	/**
	 * 替换为手机识别的HTML，去掉样式及属性，保留回车。
	 * @param txt
	 * @return
	 */
	public static String toHtml(String txt){
		if (txt == null){
			return "";
		}
		return replace(replace(EncodesUtils.escapeHtml(txt), "\n", "<br/>"), "\t", "&nbsp; &nbsp; ");
	}

	/**
	 * 缩略字符串（不区分中英文字符）
	 * @param str 目标字符串
	 * @param length 截取长度
	 * @return
	 */
	@Bizlet("")
	public static String abbr(String str, int length) {
		if (str == null) {
			return "";
		}
		try {
			StringBuilder sb = new StringBuilder();
			int currentLength = 0;
			for (char c : replaceHtml(StringEscapeUtils.unescapeHtml(str)).toCharArray()) {
				currentLength += String.valueOf(c).getBytes("GBK").length;
				if (currentLength <= length - 3) {
					sb.append(c);
				} else {
					sb.append("...");
					break;
				}
			}
			return sb.toString();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return "";
	}
		
		 
		
	/**
	 * 转换为Double类型
	 */
	@Bizlet("")
	public static Double toDouble(Object val){
		if (val == null){
			return 0D;
		}
		try {
			return Double.valueOf(trim(val.toString()));
		} catch (Exception e) {
			return 0D;
		}
	}

	/**
	 * 转换为Float类型
	 */
	@Bizlet("")
	public static Float toFloat(Object val){
		return toDouble(val).floatValue();
	}

	/**
	 * 转换为Long类型
	 */
	@Bizlet("")
	public static Long toLong(Object val){
		return toDouble(val).longValue();
	}

	/**
	 * 转换为Integer类型
	 */
	@Bizlet("")
	public static Integer toInteger(Object val){
		return toLong(val).intValue();
	}
		
		 
	 

		/**
		 * 驼峰命名法工具
		 * @return
		 * 		toCamelCase("hello_world") == "helloWorld" 
		 * 		toCapitalizeCamelCase("hello_world") == "HelloWorld"
		 * 		toUnderScoreCase("helloWorld") = "hello_world"
		 */
		@Bizlet("")
	    public static String toCamelCase(String str) {
	        if (str == null) {
	            return null;
	        }
	        str = str.toLowerCase();
	        StringBuilder sb = new StringBuilder(str.length());
	        boolean upperCase = false;
	        for (int i = 0; i < str.length(); i++) {
	            char c = str.charAt(i);
	            if (c == SEPARATOR) {
	                upperCase = true;
	            } else if (upperCase) {
	                sb.append(Character.toUpperCase(c));
	                upperCase = false;
	            } else {
	                sb.append(c);
	            }
	        }
	        return sb.toString();
	    }

	    /**
		 * 驼峰命名法工具
		 * @return
		 * 		toCamelCase("hello_world") == "helloWorld" 
		 * 		toCapitalizeCamelCase("hello_world") == "HelloWorld"
		 * 		toUnderScoreCase("helloWorld") = "hello_world"
		 */
		@Bizlet("")
	    public static String toCapitalizeCamelCase(String str) {
	        if (str == null) {
	            return null;
	        }
	        str = toCamelCase(str);
	        return str.substring(0, 1).toUpperCase() + str.substring(1);
	    }
	    
	    /**
		 * 驼峰命名法工具
		 * @return
		 * 		toCamelCase("hello_world") == "helloWorld" 
		 * 		toCapitalizeCamelCase("hello_world") == "HelloWorld"
		 * 		toUnderScoreCase("helloWorld") = "hello_world"
		 */
	    public static String toUnderScoreCase(String str) {
	        if (str == null) {
	            return null;
	        }
	
	        StringBuilder builder = new StringBuilder();
	        boolean upperCase = false;
	        for (int i = 0; i < str.length(); i++) {
	            char c = str.charAt(i);
	            boolean nextUpperCase = true;
	            if (i < (str.length() - 1)) {
	                nextUpperCase = Character.isUpperCase(str.charAt(i + 1));
	            }
	            if ((i > 0) && Character.isUpperCase(c)) {
	                if (!upperCase || !nextUpperCase) {
	                    builder.append(SEPARATOR);
	                }
	                upperCase = true;
	            } else {
	                upperCase = false;
	            }
	            builder.append(Character.toLowerCase(c));
	        }
	        return builder.toString();
	    }
		 
	    /**
	     * 转换为JS获取对象值，生成三目运算返回结果
	     * @param objectString 对象串
	     *   例如：row.user.id
	     *   返回：!row?'':!row.user?'':!row.user.id?'':row.user.id
	     */
	    @Bizlet("判判断数组对象不为空")
	    public static String jsGetVal(String objectString){
	    	StringBuilder result = new StringBuilder();
	    	StringBuilder val = new StringBuilder();
	    	String[] vals = split(objectString, ".");
	    	for (int i=0; i<vals.length; i++){
	    		val.append("." + vals[i]);
	    		result.append("!"+(val.substring(1))+"?'':");
	    	}
	    	result.append(val.substring(1));
	    	return result.toString();
	    }
		/**
		 * @Description 判断数组对象不能为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param objs
		 * @return 		参数
		 * @return 		boolean 返回类型(不为空的时候返回true，其他返回false)
		 */
	    @Bizlet("判判断数组对象不为空")
		public static boolean isNotEmpty(Object [] objs){
			boolean reflag = true;
			if(objs!=null && objs.length>0){
				for(Object obj:objs){
					boolean flag = isNotEmpty(obj);
					if(flag){
						reflag = true;
						break;
					}
				}
			}else{
				reflag = false;
			}
			return reflag;
		}
		
		/**
		 * @Description 判断数组对象为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param 		objs 方法遍历之后允许每个，传进来的参数为" ",但是不允许""
		 * @return 		参数
		 * @return 		boolean 返回类型(不空的时候返回true，其他返回false)
		 */
		@Bizlet("判判断数组对象为空")
		public static boolean isEmpty(Object [] objs){
			boolean reflag = false;
			if(objs==null||objs.length==0){
				return true;
			}else{
				for(Object obj:objs){
					boolean flag = isEmpty(obj);
					if(flag){
						reflag = true;
						break;
					}
				}
			}
			return reflag;
		}
	
		
		
		/**
		 * @Description 判断数组对象不能为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param objs
		 * @return 		参数
		 * @return 		boolean 返回类型(不为空的时候返回true，其他返回false)
		 */
		@Bizlet("判判断集合对象不为空")
		public static boolean isNotEmpty(List<Object> objs){
			if(objs!=null && objs.size()>0){
				return true;
			} 
			return false;
		}
		
		/**
		 * @Description 判断数组对象为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param obj
		 * @return 		参数
		 * @return 		boolean 返回类型(不空的时候返回true，其他返回false)
		 */
		@Bizlet("判判断集合对象为空")
		public static boolean isEmpty(List<Object> objs){
			if(objs==null||objs.size()==0){
				return true;
			} 
			return false;
		}
		
		/**
		 * @Description 判断对象不能为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param obj
		 * @return 		参数
		 * @return 		boolean 返回类型(不为空的时候返回true，其他返回false)
		 */
		@Bizlet("判断DataObject对象不能为空")
		public static boolean isNotEmpty(DataObject obj){
			 return !isEmpty(obj);
		}
		
		/**
		 * @Description 判断对象为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param 		obj 方法允许 传进来的参数为" ",但是不允许""
		 * @return 		参数
		 * @return 		boolean 返回类型(不空的时候返回true，其他返回false)
		 */
		@Bizlet("判断DataObject对象为空")
		@SuppressWarnings("all")
		public static boolean isEmpty(DataObject obj){
			if (obj == null) {
				return true;
			}else if ((obj instanceof List)) {
				return ((List) obj).size() == 0 ||((List) obj).isEmpty();
			}else if (obj instanceof Map) {
				return ((Map) obj).size()==0 || ((Map) obj).isEmpty();
			} else if (obj instanceof HashMap) {
				return ((HashMap) obj).size()==0 || ((HashMap) obj).isEmpty();
			}else if (obj instanceof Vector) {
				return ((Vector) obj).size()==0 ||((Vector) obj).isEmpty();
			} else  if ((obj instanceof List)) {
				return ((List) obj).size() == 0 || ((List) obj).isEmpty();
			} else  if ((obj instanceof ArrayList)) {
				return ((ArrayList) obj).size() == 0 || ((ArrayList) obj).isEmpty();
			}else{
				return false;
			} 
		
		}
		
		/**
		 * @Description 判断数组对象不能为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param objs
		 * @return 		参数
		 * @return 		boolean 返回类型(不为空的时候返回true，其他返回false)
		 */
		@Bizlet("判断DataObject数组对象不为空")
		public static boolean isNotEmpty(DataObject []objs){
			boolean reflag = true;
			if(objs!=null && objs.length>0 ){
				for(DataObject obj:objs){
					boolean flag = isNotEmpty(obj);
					if(flag){
						reflag = true;
						break;
					}
				}
			}else{
				reflag =  false;
			} 
			return reflag;
		}
		
		/**
		 * @Description 判断数组对象为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param objs
		 * @return 		参数
		 * @return 		boolean 返回类型(不空的时候返回true，其他返回false)
		 */
		@Bizlet("判断DataObject数组对象为空")
		public static boolean isEmpty(DataObject [] objs){
			boolean reflag = false;
			if(objs==null||objs.length==0){
				return true;
			}else{
				for(DataObject obj:objs){
					boolean flag = isEmpty(obj);
					if(flag){
						reflag = true;
						break;
					}
				}
			}
			return reflag;
		}
	

		/**
		 * @Description 判断数组对象不能为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param objs
		 * @return 		参数
		 * @return 		boolean 返回类型(不为空的时候返回true，其他返回false)
		 */
		@Bizlet("判断DataObject集合对象不为空")
		public static boolean isNotBlank(List<DataObject> objs){
			if(objs!=null && objs.size()>0){
				return true;
			} 
			return false;
		}
		
		/**
		 * @Description 判断数组对象为空
		 * @Author		liangjilong
		 * @Date		2016年12月27日 上午10:47:05
		 * @param objs
		 * @return 		参数
		 * @return 		boolean 返回类型(不空的时候返回true，其他返回false)
		 */
		@Bizlet("判断DataObject集合对象为空")
		public static boolean isBlank(List<DataObject> objs){
			if(objs==null||objs.size()==0){
				return true;
			} 
			return false;
		}
		
		/**
		 * 获取从start开始用*替换len个长度后的字符串
		 * @param str  要替换的字符串
		 * @param start 开始位置
		 * @param len 长度
		 * @param repaceStr 要替换成永恒需要字符串
		 * @return 替换后的字符串
		 */
		@Bizlet("获取从start开始用*替换len个长度后的字符串")
		public static String abbr(String str, int start, int len,String repaceStr) {
			if (isEmpty(str)) {
				return str;
			}
			if (str.length() < start) {
				return str;
			}
			// 获取*之前的字符串
			String ret = str.substring(0, start);
			// 获取最多能打的*个数
			int strLen = str.length();
			if (strLen < start + len) {
				len = strLen - start;
			}
			// 替换成*
			for (int i = 0; i < len; i++) {
				ret += repaceStr;
			}
			// 加上*之后的字符串
			if (strLen > start + len) {
				ret += str.substring(start + len);
			}
			return ret;
		}
		
		/**
		 * 判断是否与给定字符串样式匹配
		 * @param str
		 *            字符串
		 * @param pattern
		 *            正则表达式样式
		 * @return 是否匹配是true,否false
		 */
		@Bizlet("判断是否与给定字符串样式匹配")
		public static boolean isMatch(String str, String pattern) {
			Pattern pattern_hand = Pattern.compile(pattern);
			Matcher matcher_hand = pattern_hand.matcher(str);
			boolean b = matcher_hand.matches();
			return b;
		}
		
		public static void main(String[] args) {
			String[] arr = getFundCodeAndName("131811-Ｒ-002");
			//System.out.println("代码："+arr[0]);
			//System.out.println("名称："+arr[1]);
			
			String  [] smInfoResults =new String[]{null,""};
			DataObject objs[] =new DataObject[]{};
			if(StrUtil.isNotEmpty(objs)){
				System.out.println(12);
			}else{
				System.out.println(111111);
			}
		}
		
		
		/**
		 * 给字符串添加引号
		 * 
		 * @Author		童伟
		 * 
		 * @param str
		 *            字符串（"a,b,c,d,e"）
		 * @return 
		 * 			       字符串（"'a','b','c','d','e'"）
		 */
		@Bizlet("给字符串添加引号")
		public static String disposeString(String str) {
			StringBuffer sb = new StringBuffer();
			String result = "";
			if(str == null || str.equals("")){
				str = "";
			}
			String[] temp = str.split(",");
			for (int i = 0; i < temp.length; i++) {
				if (!"".equals(temp[i]) && temp[i] != null)
					sb.append("'" + temp[i] + "',");
			}
			result = sb.toString();
			String tp = result.substring(result.length() - 1, result.length());
			if (",".equals(tp)){
				return result.substring(0, result.length() - 1);
			}else
				return result;
			
		}
		
		/**
		 * dataobject数组中的某个字段转为String字符串
		 * 
		 * @param paramData 入参
		 * @param value 要处理的字段
		 * @return result 返回用户id字符串（"'a','b','c','d','e'"）
		 */
		@Bizlet("dataobject集合中字段转string")
		public static String objectDisposeString(DataObject[] paramData, String value){
			StringBuffer sb = new StringBuffer();
			String result = "";
			if(paramData.length>0){
				for(int i = 0; i< paramData.length; i++){
					sb.append("'"+paramData[i].get(value) + "',");
				}
				result = sb.toString();
				String tp = result.substring(result.length() - 1, result.length());
				if (",".equals(tp)){
					return result.substring(0, result.length() - 1);
				}else
					return result;
			}else
			
			return result;
		}
		
		/**
		 * 对字符串中大写字母前面加下划线处理
		 * @param str
		 * @return
		 */
		@Bizlet()
		public static String StringAddUnderline(String str){
			if(str == null || ("").equals(str)){
				return str;
			}
			StringBuffer sb = new StringBuffer("");
		    for(int i=0;i<str.length();i++){
		        char tempChr=str.charAt(i);
		        if(tempChr>='A'&&tempChr<='Z'){
		        	// 如果是大写字母，则在字符前面插入一个下划线
		            sb.append("_");
		        }
		         sb.append(tempChr);
		    }
		    return sb.toString();
		}
		
		@Bizlet("转换成大写")
		public static String upper(String str){
			if(str == null || ("").equals(str)){
				return str;
			}
			return StringUtils.upperCase(str);
		}
		
		
	}



