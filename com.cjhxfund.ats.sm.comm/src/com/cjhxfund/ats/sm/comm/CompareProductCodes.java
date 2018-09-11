/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import com.eos.system.annotation.Bizlet;

/**
 * @param paramArr 页面选中的多条产品代码数组
 * @param rtnCodes 查询公共接口返回的产品代码串
 * @author 陈迪
 * @date 2016-12-16 14:16:34
 * @return boolean 如果rtn转换成数组(rtnArr)包含paramArr，返回true，否则返回false
 *
 */
@Bizlet("")
public class CompareProductCodes {
	@Bizlet("产品代码数组比对")
	public String compareCodes(String[] paramArr,String rtnCodes) {
		//计数变量
		int k = 0;
		//比对结果标志
		String flag = "1";
		if(!rtnCodes.isEmpty()){
			//将产品代码串转换为数组
			String[] rtnArr = rtnCodes.split(",");
			//rtn转换成数组(rtnArr)和paramArr进行比对
			for (int i = 0; i < paramArr.length; i++) {
				flag = "1";
				for (int j = 0; j < rtnArr.length; j++) {
					if (paramArr[i].equals(rtnArr[j])) {
						k++;
						continue;
					}
				}
				if (k == paramArr.length) {
					flag = "0";
				}
			}
		}
		return flag;
	}
}
