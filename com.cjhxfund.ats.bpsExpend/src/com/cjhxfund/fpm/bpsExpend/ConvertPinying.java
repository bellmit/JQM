package com.cjhxfund.fpm.bpsExpend;

import com.eos.system.annotation.Bizlet;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

/**
 * 将中文转换成英文全拼或英文首字母
 * @author chenxing
 *
 */
@Bizlet("将中文转换成英文全拼或英文首字母")
public class ConvertPinying {

	/**
	 * 将中文转换成英文全拼
	 * @param param 
	 * @return
	 */
	@Bizlet("将中文转换成英文全拼")
	public String convertPinying(String param) {
		if (param == null || "".endsWith(param)) {
			return "";
		}
		char[] words = param.toCharArray();
		int wordCount = words.length;
		String[] pinyin = new String[wordCount];
		HanyuPinyinOutputFormat outputFormat = new HanyuPinyinOutputFormat();
		outputFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		outputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		outputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);

		StringBuffer sb = new StringBuffer();
		try {
			for (int i = 0; i < wordCount; i++) {
				// System.out.println(t1[i]); 
				if (Character.toString(words[i]).matches("[\\u4E00-\\u9FA5]+")) {
					pinyin = PinyinHelper.toHanyuPinyinStringArray(words[i],
							outputFormat);
					sb.append(pinyin[0]);
				} else {
					sb.append(Character.toString(words[i]));
				}
			}
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

	/**
	 * 将中文转换成英文首字母
	 * @param param 
	 * @return
	 */
	@Bizlet("将中文转换成英文首字母")
	public String convertPinyingHeadChar(String param) {
		String convert = "";
		for (int j = 0; j < param.length(); j++) {
			char word = param.charAt(j);
			String[] pinyinArray = PinyinHelper.toHanyuPinyinStringArray(word);
			if (pinyinArray != null) {
				convert += pinyinArray[0].charAt(0);
			} else {
				convert += word;
			}
		}
		return convert;
	}

}
