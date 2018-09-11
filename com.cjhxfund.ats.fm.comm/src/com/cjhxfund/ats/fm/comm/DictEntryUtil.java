/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.util.ArrayList;
import java.util.List;

import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 陈鹏
 * @date 2016-04-05 09:22:17
 *
 */
@Bizlet("")
public class DictEntryUtil {

	/**
	 * @param 数据字典名称
	 * @param 过滤值
	 * @return 数据字典集合
	 * @author 陈鹏
	 */
	@Bizlet("")
	public static List<DataObject> getDictEntryList(String entryName,
			String filterValue) {
		// TODO 自动生成的方法存根
		
		DataObject[] objs = BusinessDictUtil.getCurrentDictInfoByType(entryName);
		String[] filterValues = filterValue.split(",");
		List<DataObject> lists = new ArrayList<DataObject>();
		
		for(int i =0;i<objs.length;i++){
			for(int k = 0;k<filterValues.length;k++){
				if(objs[i].getString("dictID").equals(filterValues[k])){
					lists.add(objs[i]);
				}
			}
		}
		
		return  lists;
	}

}
