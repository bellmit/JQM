/**
 * 
 */
package com.cjhxfund.ats.fm.instr;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import com.cjhxfund.commonUtil.model.TProductHandle;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;

import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-01 14:39:10
 *
 */
@Bizlet("")
public class Assemble {

	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装流程信息集合")
	public static DataObject[] assembleParameter(DataObject[] wflist,DataObject[] workitems) {
		// TODO 自动生成的方法存根
		List<DataObject> objs = new ArrayList<DataObject>();
		for (int i = 0; i < wflist.length; i++) {
			DataObject obj = wflist[i].getDataObject("bizObject");
			obj.setString("workItemID", wflist[i].getString("workItemID"));
			obj.setString("workItemName", wflist[i].getString("workItemName"));
			obj.setString("actionURL", wflist[i].getString("actionURL"));
			obj.setString("partiName", wflist[i].getString("partiName"));
			obj.setString("currentState", wflist[i].getString("currentState"));

			objs.add(obj);
		}
		if(workitems != null){
			for(int k =0;k<workitems.length;k++){
				for(int j =0;j<objs.size();j++){
					
					if(workitems[k].getString("processInstID").equals(objs.get(j).getString("processinstid"))){
							objs.get(j).setString("workitemNames", workitems[k].getString("workItemName"));
					}

				}
			 }
		 }
		return objs.toArray(wflist);
	}
	
	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装流程信息集合")
	public static DataObject[] assembleParameter1(DataObject[] wflist,DataObject[] workitems) {
		// TODO 自动生成的方法存根
		//List<DataObject> objs = new ArrayList<DataObject>();
		/*for (int i = 0; i < wflist.length; i++) {
			DataObject obj = wflist[i].getDataObject("bizObject");
			obj.setString("workItemID", wflist[i].getString("workItemID"));
			obj.setString("workItemName", wflist[i].getString("workItemName"));
			obj.setString("actionURL", wflist[i].getString("actionURL"));
			obj.setString("partiName", wflist[i].getString("partiName"));
			obj.setString("currentState", wflist[i].getString("currentState"));

			objs.add(obj);
		}*/
		if(workitems != null){
			for(int j =0;j<wflist.length;j++){
				for(int k =0;k<workitems.length;k++){
					if(workitems[k].getString("processInstID").equals(wflist[j].getString("processinstid"))){
						wflist[j].setString("workitemNames", workitems[k].getString("workItemName"));
						wflist[j].setString("workItemID", workitems[k].getString("workItemID"));
						wflist[j].setString("activityDefID", workitems[k].getString("activityDefID"));
						break;
					}else{
						wflist[j].setString("workitemNames", "流程已结束");
					}

				}
			 }
		 }
		return wflist;
	}


	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装活动实例")
	public static String[] assembleActivityInstance(DataObject wflist) {
		// TODO 自动生成的方法存根
		String[] str = new String[1];
		System.out.println(wflist.getString("activityDefIdRollback"));
		str[0] = wflist.getString("activityDefIdRollback");

		return str;
	}

	/**
	 * @param 活动实例数组
	 * @return 活动实例数组
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装流程信息集合")
	public static List<DataObject> interceptWorkitem(DataObject[] wflist,
			DataObject workItem) {
		// TODO 自动生成的方法存根
		List<DataObject> objs = new ArrayList<DataObject>();
		for (int i = 0; i < wflist.length; i++) {
			if (!wflist[i].getString("activityDefID").equals(
					workItem.getString("activityDefID"))) {
				objs.add(wflist[i]);
			} else {
				break;
			}
		}
		//去除集合中的重复数据
		for (int i = 0; i < objs.size() - 1; i++) {
			for (int j = objs.size() - 1; j > i; j--) {
				if (objs.get(j).getString("activityDefID")
						.equals(objs.get(i).getString("activityDefID"))) {
					objs.remove(j);
				}
			}
		}

		return objs;
	}

	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装参与者集合")
	public static List<WFParticipant> assembleEmpList(DataObject[] wflist) {
		// TODO 自动生成的方法存根
		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		for (int i = 0; i < wflist.length; i++) {
			DataObject obj = wflist[i];
			if (obj != null) {
				WFParticipant ipant = new WFParticipant();

				//查询用户信息
				DataObject user = DataObjectUtil
						.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
				user.set("userid", obj.getString("vcUserId"));
				DatabaseUtil.expandEntityByTemplate("default", user, user);

				ipant.setId(user.getString("empid"));
				System.out.println(user.getString("empname"));
				ipant.setName(user.getString("empname"));
				ipant.setTypeCode("emp");
				participants.add(ipant);
			}
		}

		return participants;
	}

	
	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装参与者集合")
	public static List<WFParticipant> assembleEmpListPayMent(List<TProductHandle> wflist) {
		// TODO 自动生成的方法存根
		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		for (int i = 0; i < wflist.size(); i++) {
			TProductHandle obj = wflist.get(i);
			if (obj != null) {
				WFParticipant ipant = new WFParticipant();

				//查询用户信息
				DataObject user = DataObjectUtil
						.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
				user.set("userid", obj.getVcUserId());
				DatabaseUtil.expandEntityByTemplate("default", user, user);

				ipant.setId(user.getString("empid"));
				System.out.println(user.getString("empname"));
				ipant.setName(user.getString("empname"));
				ipant.setTypeCode("emp");
				participants.add(ipant);
			}
		}

		return participants;
	}

	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("根据userId组装参与者集合")
	public static List<WFParticipant> getByIdEmpList(String userId) {
		// TODO 自动生成的方法存根
		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		WFParticipant ipant = new WFParticipant();
		//查询用户信息
		DataObject user = DataObjectUtil
				.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("empid", userId);
		DatabaseUtil.expandEntityByTemplate("default", user, user);

		ipant.setId(user.getString("empid"));
		ipant.setName(user.getString("empname"));
		ipant.setTypeCode("emp");
		participants.add(ipant);

		return participants;
	}

	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装参与者并剔除上一环节参与者")
	public static List<WFParticipant> setRelativeEmpList(DataObject[] objs,String userId) {
		// TODO 自动生成的方法存根

		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		for (int i = 0; i < objs.length; i++) {
			DataObject obj = objs[i];
			if (obj != null) {
				if(!obj.getString("EMPCODE").equals(userId)) {
					WFParticipant ipant = new WFParticipant();

					ipant.setId(obj.getString("EMPID"));
					ipant.setName(obj.getString("EMPNAME"));
					ipant.setTypeCode("emp");
					participants.add(ipant);
				}	
			}
		}

		return participants;
	}

	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("剔除一级债券申购流程部分不允许回退的环节")
	public static List<DataObject> deleteIink(DataObject[] activitys) {
		// TODO 自动生成的方法存根
		List<DataObject> objs = new ArrayList<DataObject>();
		for (int i = 0; i < activitys.length; i++) {
			//当环节为投顾复核时
			if (activitys[i].getString("activityDefID").equals(
					"manualActivity4")) {
				continue;
			}
			//当环节为人工审核特批交易时
			if (activitys[i].getString("activityDefID").equals(
					"manualActivity16")) {
				continue;
			}
			//当环节为报价修改后的人工审核环节时
			if (activitys[i].getString("activityDefID").equals(
					"manualActivity15")) {
				continue;
			}
			//当环节为投顾复核时剔除。所有流程业务通用
			if(activitys[i].getString("activityInstName").equals("投顾审核")){
				continue;
			}
			objs.add(activitys[i]);
		}

		return objs;
	}
	
	
	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("合并交易员1与交易员2参与者集合")
	public static List<WFParticipant> MergeParticipantsList(List<WFParticipant> traders1,List<WFParticipant> traders2) {
		// TODO 自动生成的方法存根
		
		for(int i = 0;i < traders1.size();i++){
			for(int k= 0;k < traders2.size();k++){
				
				if(traders1.get(i).getId() != traders2.get(k).getId()){
					traders1.add(traders2.get(k));
				}
			}
		}
		
		return traders1;
	}
	
	@Bizlet("转换时间格式")
	public static Date formatDataTime(String dataTime){		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = null;
		try{
			date = sdf.parse(dataTime);
		}catch(Exception e){
			e.printStackTrace();
		}
		return date;
	}
	
	@Bizlet("转换时间格式")
	public static Date formatStringToData(String dataTime){		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try{
			if(dataTime!=null && dataTime!="" && !"0".equals(dataTime)){
				String str=dataTime.substring(0, 4)+"-"+dataTime.substring(4, 6)+"-"+dataTime.substring(6, 8);
				date = sdf.parse(str);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return date;
	}
	
	public static <T> T[] concat(T[] first, T[] second) {  
		  T[] result = Arrays.copyOf(first, first.length + second.length);  
		  System.arraycopy(second, 0, result, first.length, second.length);  
		  return result;  
	}   

}
