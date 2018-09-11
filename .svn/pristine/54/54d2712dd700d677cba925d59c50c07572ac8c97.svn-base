/**
 * 
 */
package com.cjhxfund.jy.process;

import java.util.ArrayList;
import java.util.List;

import com.cjhxfund.jy.ProductProcess.ProductProcessUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-15 10:56:26
 *
 */
@Bizlet("")
public class SetRelative {

	/**
	 * @param objs
	 * @param userId
	 * @return
	 */
	@Bizlet("")
	public static List<DataObject> setRelativeEmpList(DataObject[] objs,String userId) {
		// TODO 自动生成的方法存根
		List<DataObject> obj = new ArrayList<DataObject>();
		//根据operater_id获取userId
		userId = ProductProcessUtil.getUserIdByOrgEmpId(userId);
		for(int i =0;i<objs.length;i++){
			
			if(!objs[i].getString("vcUserId").equals(userId)){
			 obj.add(objs[i]);	
			}
		}
		return  obj;
	}
	
	

}
