package com.cjhxfund.cjapi.common;

import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.eos.system.annotation.Bizlet;
import com.eos.foundation.database.DatabaseExt;
import commonj.sdo.DataObject;

public class DomainValueTrans {
	private static boolean isInit = false;
	private static Map<String, Map<String, String>> domainValueMap = new HashMap<String, Map<String, String>>();
	/**初始化*/
	private static boolean init(){

		Map<String, Object> paramters = new HashMap<String, Object>();
		Object[]  objs  = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
				"com.cjhxfund.cjapi.DictConfigns.queryDictAllForTrans", paramters);
		for (Object obj : objs){
			DataObject data = (DataObject)obj;
			String dictType = data.getString("dictType");//参数类型
			String dictId = data.getString("dictId");//接口的值
			String dictIdHs = data.getString("dictIdHs");//机器猫转换的值
			if (!domainValueMap.containsKey(dictType)) {
				domainValueMap.put(dictType, new HashMap<String, String>());
			}
			domainValueMap.get(dictType).put(dictId, dictIdHs);
		}
		return true;
	}

	
	/***
	 * 新老机器猫的值域的转换。
	 * 将老机器猫的字段的值域转换成新机器猫字段的值域
	 * @param fieldName		字段名
	 * @param code	老机器猫代码
	 * @return 新机器猫代码
	 */
	@Bizlet("值域转换")
	public static String domainValueTrans(String fieldName, String code){
		if (!isInit) {
			isInit = init();
		}
		Map<String, String> map = domainValueMap.get(fieldName);
		if (map == null) {
			
			return null;
		}
		return map.get(code);
	}


}
