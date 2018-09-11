package com.cjhxfund.commonUtil;

import java.util.regex.Pattern;

import com.eos.system.annotation.Bizlet;

/**
 * 
 * @Description 校验字符串是否正确等字符串处理
 * @ClassName VerifyStrUtil
 * @Date 2017年2月15日 下午2:51:03
 * @Author liangjilong
 * @Copyright (c) All Right Reserved CJHXFUND, 2017.
 */
public class VerifyStrUtil {
	/** 教育经历 */
	public static final String patternJYJL = "教育经历$";
	/** 性别 */
	public static final String patternXB = "(男|女)";
	/** 验证是否包含身份证格式信息 */
	public static final String patternSF = "^(.*\\D)?[1-9][0-9]{16}[0-9a-zA-Z](\\D.*)?$";
	/** 验证是否包含学历格式信息 */
	public static final String patternXL = "^.*((本科)|(大专)|(研究生)|(博士)|(专科)).*$";
	public static final String patternXLX = ".*((本科)|(大专)|(研究生)|(博士)|(专科)).*";
	public static final String patternYearMonth2 = "(.*\\W)?\\d{4}(.|/)?([0-9]{1,2})";
	/** 验证是否包含学历格式信息,for html解析 */
	public static final String patternXLhtml = "(本科|大专|研究生|博士|专科)";
	/** Email现居地与户口 */
	public static final String patternEML = "[\u4e00-\u9fa5]{2}$";
	public static final String patternXJ = "^(.*\\W)?现居\\W[\u4e00-\u9fa5]{1}(\\W.*)?$";
	/** 验证是否包含户口格式信息 */
	public static final String patternHK = "^(.*\\W)?户口\\W[\u4e00-\u9fa5]{1}(\\W.*)?$";
	/** 年月开头结尾 */
	public static final String patternYearMonth = "^\\d{4}(-|/|.)?([0-9]{1,2})|至今";
	/** 婚否 */
	public static final String patternHF = "(未婚|已婚)";
	/** 验证是否包含日期格式信息 */
	public static final String patternSR = "^(.*\\D)?([0-9]{4})((年)|([.])|(-))([0-9]{1,2})((月)|([.])|(-))([0-9]{1,2})(\\D.*)?$";
	/** 验证是否包含手机格式信息 */
	public static final String patternSJ = "^(.*\\D)?[0-9]{11}(\\D.*)?$";
	/** 验证是否包含手机格式信息 */
	public static final String patternMobile = "[0-9]{11}";
	/** 验证是否包含邮箱格式信息 */
	public static final String patternYX = "^(.*\\W)?([0-9a-zA-Z]|[_])+@[0-9a-zA-Z]+[.][a-zA-Z]+(\\W.*)?$";
	public static final String patternYXX = "([0-9a-zA-Z]|[_])+@[0-9a-zA-Z]+[.][a-zA-Z]+(\\W.*)?";
	/** 验证是否包含居住地格式信息 */
	public static final String patternJZ = "^(.*\\W)?居\\W[\\u4e00-\\u9fa5]{1}(\\W.*)?$";
	/** 验证是否包含姓名格式信息 */
	public static final String patternXM = "^(?!简历|免费发布|职位管理|应聘职位)[\u4e00-\u9fa5]{2,4}$";
	public static final String REG_DATE = "^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$";

	/**
	 * 截取身份信息字符串
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:39:05
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getSFString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 18) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int dLimit = 1;
			int uLImit = 0;
			int index = -1;
			// 确定身份格式信息所在位置
			for (int i = 0; i < sbf.length(); ++i) {
				for (int j = i; j < i + 17; ++j) {
					dLimit = dLimit * (sbf.charAt(j) - 47);
					uLImit = uLImit + sbf.charAt(j) / 58;
					if (!(dLimit > 0 && uLImit == 0)) {
						break;
					}
				}
				if (dLimit > 0 && uLImit == 0) {
					if (i >= 1
							&& (sbf.charAt(i - 1) >= '0' && sbf.charAt(i - 1) <= '9')) {
						continue;
					}
					if (i + 18 < sbf.length()
							&& (sbf.charAt(i + 18) >= '0' && sbf.charAt(i + 18) <= '9')) {
						continue;
					}
					if ((sbf.charAt(i + 17) >= '0' && sbf.charAt(i + 17) <= '9')
							|| (sbf.charAt(i + 17) >= 'a' && sbf.charAt(i + 17) <= 'z')) {
						index = i;
						break;
					}

				}
				dLimit = 1;
				uLImit = 0;
			}
			// 找到位置截取信息
			if (index != -1) {
				temp = value.substring(index, index + 18);
			}
		}
		return temp;
	}

	/**
	 * 截取学历信息
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:59
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getXLString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 2) {
				return null;
			}
			int index = -1;
			int lastIndex = -1;
			if (value.indexOf("专科") != -1) {
				index = value.indexOf("专科");
			}
			if (value.indexOf("大专") != -1) {
				index = value.indexOf("大专");
			}
			if (value.indexOf("本科") != -1) {
				index = value.indexOf("本科");
			}
			if (value.indexOf("研究生") != -1) {
				index = value.indexOf("研究生");
				lastIndex = value.lastIndexOf("研究生");
			}
			if (value.indexOf("博士") != -1) {
				index = value.indexOf("博士");
			}
			if (index != -1) {
				if (lastIndex != -1) {
					temp = value.substring(index, index + 3);
				} else {
					temp = value.substring(index, index + 2);
				}
			}
		}
		return temp;
	}

	/**
	 * 截取生日信息（日期格式）
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:52
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getSRString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 8) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int index = -1;
			String year = null;
			String month = null;
			String day = null;
			for (int i = 0; i < sbf.length(); ++i) {
				if (sbf.charAt(i) >= '0' && sbf.charAt(i) <= '9') {
					if (sbf.charAt(i + 1) >= '0' && sbf.charAt(i + 1) <= '9') {
						if (sbf.charAt(i + 2) >= '0'
								&& sbf.charAt(i + 2) <= '9') {
							if (sbf.charAt(i + 3) >= '0'
									&& sbf.charAt(i + 3) <= '9') {
								// 找到类似位置解析
								index = i;
								year = sbf.substring(index, index + 4);
								if (!(sbf.charAt(index + 6) >= '0' && sbf
										.charAt(index + 6) <= '9')) {
									month = sbf.substring(index + 5, index + 6);
									if (!(index + 8 < sbf.length()
											&& sbf.charAt(index + 8) >= '0' && sbf
											.charAt(index + 8) <= '9')) {
										day = sbf.substring(index + 7,
												index + 8);
									} else {
										day = sbf.substring(index + 7,
												index + 9);
									}
								} else {
									month = sbf.substring(index + 5, index + 7);
									if (!(index + 9 < sbf.length()
											&& sbf.charAt(index + 9) >= '0' && sbf
											.charAt(index + 9) <= '9')) {
										day = sbf.substring(index + 8,
												index + 9);
									} else {
										day = sbf.substring(index + 8,
												index + 10);
									}
								}
								if (patternReg(year + "-" + month + "-" + day,
										REG_DATE)) {
									temp = year + "-" + month + "-" + day;
									break;
								}
							}
						}
					}
				}
			}
		}
		return temp;
	}

	/**
	 * 截取姓名信息
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:45
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getXMString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 11) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value);
			int indexLast = sbf.length();
			int boudLeft = -1;
			for (int i = indexLast - 1; i >= 0; --i) {
				if (sbf.charAt(i) == ' ') {
					boudLeft = i + 1;
					break;
				}
				boudLeft = i;
			}
			if (boudLeft >= 0) {
				temp = value.substring(boudLeft, indexLast);

			}
		}
		return temp;

	}

	/**
	 * 截取居住地信息
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:38
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getJZString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 11) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int indexLast = sbf.length();
			int boudLeft = -1;
			for (int i = indexLast - 1; i >= 0; --i) {
				if (sbf.charAt(i) != '\u5c45') {
				} else {
					boudLeft = i + 1;
					break;
				}
				boudLeft = i;

			}
			if (boudLeft >= 0) {
				temp = value.substring(boudLeft, indexLast);

			}
		}
		return temp;

	}

	/**
	 * 截取户口信息
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:33
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getHKString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 11) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int indexLast = sbf.length();
			int boudLeft = -1;
			for (int i = indexLast - 1; i >= 0; --i) {
				if (sbf.charAt(i) != '\uff1a') {
				} else {
					boudLeft = i + 1;
					break;
				}
				boudLeft = i;

			}
			if (boudLeft >= 0) {
				temp = value.substring(boudLeft, indexLast);

			}
		}
		return temp;

	}

	/**
	 * 截取户口信息,解析html
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:26
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getHKhtmlString(String value) {

		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 4) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int indexLast = sbf.length();
			int boudLeft = -1;
			for (int i = indexLast - 1; i >= 0; --i) {
				if (sbf.charAt(i) != '\uff1a') {
				} else {
					boudLeft = i + 1;
					break;
				}
				boudLeft = i;
			}
			if (boudLeft >= 0) {
				temp = value.substring(boudLeft, indexLast);
			}
		}
		return temp;

	}

	/**
	 * 截取手机格式信息
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:19
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getSJString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 11) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int dLimit = 1;
			int uLImit = 0;
			int index = -1;
			// 确定身份格式信息所在位置
			for (int i = 0; i < sbf.length(); ++i) {
				for (int j = i; j < i + 11; ++j) {
					dLimit = dLimit * (sbf.charAt(j) - 47);
					uLImit = uLImit + sbf.charAt(j) / 58;
					if (!(dLimit > 0 && uLImit == 0)) {
						break;
					}
				}
				if (dLimit > 0 && uLImit == 0) {
					if (i >= 1
							&& (sbf.charAt(i - 1) >= '0' && sbf.charAt(i - 1) <= '9')) {
						continue;
					}
					if (i + 11 < sbf.length()
							&& (sbf.charAt(i + 11) >= '0' && sbf.charAt(i + 11) <= '9')) {
						continue;
					}
					index = i;
					break;
				}
				dLimit = 1;
				uLImit = 0;
			}
			// 找到位置截取信息
			if (index != -1) {
				temp = value.substring(index, index + 11);
			}

		}
		return temp;
	}

	/**
	 * 截取邮箱信息
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:12
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getYXString(String value) {
		String temp = null;
		if (StrUtil.isNotEmpty(value)) {
			if (value.length() < 5) {
				return null;
			}
			StringBuffer sbf = new StringBuffer(value.toLowerCase());
			int indexFirst = sbf.indexOf("@");
			int indexLast = sbf.indexOf(".", indexFirst);
			int boudLeft = -1;
			int boudRght = -1;
			// 确定@和最近.的位置
			while (true) {
				int tempF = sbf.indexOf("@", indexFirst + 1);
				if (tempF != -1 && tempF < indexLast) {
					indexFirst = tempF;
					continue;
				} else {
					break;
				}
			}
			// @向左延伸遇到非字符退出
			for (int i = indexFirst - 1; i >= 0; --i) {
				if ((sbf.charAt(i) >= '0' && sbf.charAt(i) <= '9')
						|| (sbf.charAt(i) >= 'a' && sbf.charAt(i) <= 'z')
						|| sbf.charAt(i) == '_') {
				} else {
					boudLeft = i + 1;
					break;
				}
				boudLeft = i;
			}
			// .向右延伸遇到非字母退出
			for (int i = indexLast + 1; i < sbf.length(); ++i) {
				if (sbf.charAt(i) >= 'a' && sbf.charAt(i) <= 'z') {
				} else {
					boudRght = i - 1;
					break;
				}
				boudRght = i;
			}
			if (boudLeft >= 0 && boudRght >= 0) {
				temp = value.substring(boudLeft, boudRght + 1);
			}

		}
		return temp;
	}

	/**
	 * 截取婚否字符串
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:38:05
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getHFString(String value) {
		String temp = null;
		if (value.length() < 12) {
			return null;
		}
		int index = -1;
		if (value.indexOf("已婚") != -1) {
			index = value.indexOf("已婚");
		}
		if (value.indexOf("未婚") != -1) {
			index = value.indexOf("未婚");
		}
		if (index != -1) {
			temp = value.substring(index, index + 2);
		}
		return temp;
	}

	/**
	 * 截取现居地字符串
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:37:57
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getXJString(String value) {
		String temp = null;
		if (value.length() < 12) {
			return null;
		}
		StringBuffer sbf = new StringBuffer(value);
		int indexLast = sbf.length();
		int boudLeft = -1;
		for (int i = indexLast - 1; i >= 0; --i) {
			if (sbf.charAt(i) != '居') {
			} else {
				boudLeft = i + 1;
				break;
			}
			boudLeft = i;
		}
		if (boudLeft >= 0) {
			temp = value.substring(boudLeft, indexLast);
		}
		return temp;
	}

	/**
	 * 截取姓名字符串,for html解析
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:37:47
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getXMhtmlString(String value) {
		String temp = null;
		if (value.length() < 2) {
			return null;
		}
		StringBuffer sbf = new StringBuffer(value);
		int indexLast = sbf.length();
		int boudLeft = -1;
		for (int i = indexLast - 1; i >= 0; --i) {
			if (sbf.charAt(i) == ' ') {
				boudLeft = i + 1;
				break;
			}
			boudLeft = i;
		}
		if (boudLeft >= 0) {
			temp = value.substring(boudLeft, indexLast);
		}
		return temp;
	}

	/**
	 * 截取学历信息,for html解析
	 * 
	 * @Author liangjilong
	 * @Date 2017年2月15日 下午2:37:37
	 * @param value
	 * @return 参数
	 * @return String 返回类型
	 */
	@Bizlet("")
	public static String getXLhtmlString(String value) {
		String temp = null;
		if (value.length() < 2) {
			return null;
		}
		int index = -1;
		int lastIndex = -1;
		if (value.indexOf("专科") != -1) {
			index = value.indexOf("专科");
		}
		if (value.indexOf("大专") != -1) {
			index = value.indexOf("大专");
		}
		if (value.indexOf("本科") != -1) {
			index = value.indexOf("本科");
		}
		if (value.indexOf("研究生") != -1) {
			index = value.indexOf("研究生");
			lastIndex = value.lastIndexOf("研究生");
		}
		if (value.indexOf("博士") != -1) {
			index = value.indexOf("博士");
		}
		if (index != -1) {
			if (lastIndex != -1) {
				temp = value.substring(index, index + 3);
			} else {
				temp = value.substring(index, index + 2);
			}
		}
		return temp;
	}

	/**
	 * 正则表达式验证 验证邮箱：xxx@xxx.xxx格式 验证手机号：11有效数字 验证身份证号:15位或18位，最后可为字母
	 * 传入比较值和QQUtils正则表达式字段
	 */
	@Bizlet("")
	public static boolean patternReg(String value, String QQField) {
		boolean flag = false;
		Pattern p = Pattern.compile(QQField);
		flag = p.matcher(value).matches();
		return flag;
	}
}
