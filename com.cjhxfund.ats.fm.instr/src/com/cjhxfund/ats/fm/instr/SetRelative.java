
package com.cjhxfund.ats.fm.instr;

import java.util.ArrayList;
import java.util.List;

import com.cjhxfund.ats.fm.comm.ProductUtil;
import com.cjhxfund.commonUtil.model.TProductHandle;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;

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
		userId = ProductUtil.getUserIdByOrgEmpId(userId);
		for(int i =0;i<objs.length;i++){
			
			if(!objs[i].getString("vcUserId").equals(userId)){
			 obj.add(objs[i]);	
			}
		}
		return  obj;
	}
	
	/**
	 * @param TProductHandle
	 * @param userId
	 * @return
	 */
	@Bizlet("")
	public static List<TProductHandle> setRelativeEmpListPayMent(List<TProductHandle> objs,String userId) {
		
		// TODO 自动生成的方法存根
		List<TProductHandle> obj = new ArrayList<TProductHandle>();
		//根据operater_id获取userId
		userId = ProductUtil.getUserIdByOrgEmpId(userId);
		for(int i =0;i<objs.size();i++){
			
			if(!objs.get(i).getVcUserId().equals(userId)){
			 obj.add(objs.get(i));	
			}
		}
		return  obj;
	}
	/**
	 * 查询参与者
	 * @return
	 */
	public static List<WFParticipant> getParticipant(String activityID){
		List<WFParticipant> lst = new ArrayList<WFParticipant>();
		///ATS_FM_ASSISTANT_DIRECTOR  //主管
		///ATS_FM_CHARGE_LEADERSHIP  //分管
		///ATS_FM_EXECUTIVE_DIRECTOR  //总监
		//ATS_FM_ZJZLSP、ATS_FM_ZXZJFH、ATS_FM_FGLDFH
		//根据活动定义ID 获取系统参数名称
		String paramConfName="";
		if("ATS_FM_ZJZLSP".equals(activityID)){
			paramConfName="ATS_FM_ASSISTANT_DIRECTOR";//主管
		}else if("ATS_FM_FGLDFH".equals(activityID)){
			paramConfName="ATS_FM_CHARGE_LEADERSHIP";//分管
		}else if("ATS_FM_ZXZJFH".equals(activityID)){
			paramConfName="ATS_FM_EXECUTIVE_DIRECTOR";//总监  
		}
		//读取缓存
		DataObject temp=(DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", paramConfName);
		String userId="";
		if(temp!=null){
			userId=temp.getString("paramValue");
		}
		//查询参与者员工信息
		DataObject emp =  com.eos.foundation.data.DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.OrgEmployee");
		emp.setString("userid",userId);
		
		com.eos.foundation.database.DatabaseUtil.expandEntityByTemplate("default",emp,emp);
		//组装参与者
		WFParticipant part = new WFParticipant();
		part.setId(emp.getString("empid"));
		part.setName(emp.getString("empname"));
		part.setTypeCode("emp");
		lst.add(part);
		return lst;
	}

}
