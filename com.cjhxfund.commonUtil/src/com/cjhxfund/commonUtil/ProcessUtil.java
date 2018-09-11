/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;

import org.apache.commons.lang.StringUtils;

import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-01 14:39:10
 *
 */
@Bizlet("")
public class ProcessUtil {

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
	@Bizlet("组装流程环节信息到业务中")
	public static DataObject[] assembleWorkItemInfo(DataObject[] wflist,DataObject[] workitems) {
		// TODO 自动生成的方法存根
		if(workitems != null){
			for(int j =0;j<wflist.length;j++){
				for(int k =0;k<workitems.length;k++){
					if(workitems[k].getString("processInstID").equals(wflist[j].getString("lProcessInstId"))){
						wflist[j].setString("workitemNames", workitems[k].getString("workItemName"));
						wflist[j].setString("workItemID", workitems[k].getString("workItemID"));
						wflist[j].setString("activityDefID", workitems[k].getString("activityDefID"));
						wflist[j].setString("actionURL", workitems[k].getString("actionURL"));
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
	 * 当环节为中标确认节点时可以退办到传真节点
	 * 中标复核及以后的节点，均不可以回退到传真节点
	 * 中标复核以后的节点，可以回退到中标确认节点
	 * @param 处理过环节数组
	 * @param 当前工作项信息
	 * @return
	 */
	@Bizlet("组装流程信息集合")
	public static List<DataObject> interceptWorkitem(DataObject[] wflist,DataObject workItem) {
		// TODO 自动生成的方法存根
		List<DataObject> objs = new ArrayList<DataObject>();
		for (int i = 0; i < wflist.length; i++) {
			//过滤回退环节不允许有当前正在处理的环节
			System.out.println(wflist[i].getString("activityDefID") +"          "+ workItem.getString("activityDefID"));
			if (!wflist[i].getString("activityDefID").equals(workItem.getString("activityDefID"))) {	
				//判断环节等于中标确认时
				if(workItem.getString("activityDefID").equals("ATS_FM_CZ_ZBQR")){
					//过滤掉传真环节之前的环节
					if(wflist[i].getString("activityDefID").indexOf("CZ") != -1){
						objs.add(wflist[i]);
						continue;
					}else{
						continue;
					}
				}
				//判断环节等于中标复核时
				if(workItem.getString("activityDefID").equals("ATS_FM_CZ_ZBFH")){
					//过滤掉传真环节
					if(!wflist[i].getString("activityDefID").equals("ATS_FM_CZ")){
						//过滤掉传真环节之前的环节
						if(wflist[i].getString("activityDefID").indexOf("CZ") != -1){
							objs.add(wflist[i]);
							continue;
						}else{
							continue;
						}
					}
				}
				
				if(workItem.getString("activityDefID").indexOf("CZ") != -1){
					if(wflist[i].getString("activityDefID").indexOf("CZ") != -1 && !wflist[i].getString("activityDefID").equals("ATS_FM_CZ") && !wflist[i].getString("activityDefID").equals("ATS_FM_ZBQR")){
						objs.add(wflist[i]);
						continue;
					}else{
						if(wflist[i].getString("activityDefID").indexOf("CZ") == -1 && workItem.getString("activityDefID").indexOf("CZ") == -1){
							objs.add(wflist[i]);
							continue;
						}
					}
				}	
				
				//过滤环节不包含传真标示的环节
				System.out.println("AAA========"+wflist[i].getString("activityDefID").indexOf("CZ"));
				if(workItem.getString("activityDefID").equals("ATS_FM_CZ")){
					objs.add(wflist[i]);
					continue;
				}
			}else{
				System.out.println("1111111111111111111111111111111111");
				break;
			}
		}
		//去除集合中的重复数据
		for (int i = 0; i < objs.size() - 1; i++) {
			for (int j = objs.size() - 1; j > i; j--) {
				if (objs.get(j).getString("activityDefID").equals(objs.get(i).getString("activityDefID"))) {
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
				user.set("userid", obj.getString("userId"));
				DatabaseUtil.expandEntityByTemplate("default", user, user);

				ipant.setId(user.getString("empid"));
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
					"ATS_FM_FGLDFH")) {
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
	
	
	/**
	 * @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("合并交易员1与交易员2参与者集合")
	public static List<WFParticipant> removedParticipantsList(List<WFParticipant> traders1,List<WFParticipant> traders2) {
		// TODO 自动生成的方法存根
		List<WFParticipant> list =new ArrayList<WFParticipant>();
		for(int i = 0;i < traders2.size();i++){
			for(int k= 0;k < traders1.size();k++){
				if(!traders1.get(k).getId().equals(traders2.get(i).getId())){
					list.add(traders1.get(k));
				}
			}
		}
		
		return list;
	}

	
	/**
	 * 查询当前登录人处理过的业务ID 
	 * @param userId 登录人ID
	 * @return
	 */
	@Bizlet("查询当前登录人处理过的业务ID")
	public static String getUserIdById(String userId,String today){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select distinct t.process_inst_id from cf_jy_prc_aprv_info t where 1=1 ");
			if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_code='").append(userId).append("' ");
			}
			//判断当天已办流程条件是否为空与是否等于true,等于时组装参数查询今天数据
			if(StringUtils.isNotBlank(today)){
				if(today.equals("true")){
					sb.append(" and to_char(t.create_time,'yyyy-MM-dd') = to_char(sysdate,'yyyy-MM-dd')");
				}
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 查询用过印的流程ID
	 * @param userId 用户ID
	 * @return
	 */
	@Bizlet("查询用过印的业务Id")
	public static String getIndiaById(String userId,String today){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select distinct t.process_inst_id from cf_jy_attach_info t where t.whetherindia = '1'");
			/*if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_id='").append(userId).append("' ");
			}*/
			if(StringUtils.isNotBlank(today)){
				if(today.equals("true")){
					sb.append(" and to_char(t.create_time,'yyyy-MM-dd') = to_char(sysdate,'yyyy-MM-dd')");
				}
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
	/**
	 * 获取今天已处理过流程ID
	 * @return
	 */
	@Bizlet("获取今天已处理过流程ID")
	public static String getTodayById(){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select distinct  w.processinstid from wfworkitem w where to_char(w.endtime,'yyyy-MM-dd') = to_char(sysdate,'yyyy-mm-dd')");

			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
	/**
	 * 当前时间加上随机5-10之间的秒数
	 * @param dateTime  当前时间
	 * @return
	 * @throws Exception
	 */
	@Bizlet("组装需要修改的时间")
	public static String assembleDateTime(Date dateTime) throws Exception{
		//随机生成的5-10之间秒数
		int randomNumber = (int)(Math.random()*6+5); 
		//实例化日期处理类
		Calendar calendar = Calendar.getInstance();  
        calendar.setTime(dateTime);
      //设置秒数加上随机生成的5-10之间秒数
        calendar.add(Calendar.SECOND, randomNumber);  
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());
	}
	
	
	/**
	 * 根据权限关系类型、用户ID、产品代码获取该用户可查看的产品投资组合代码（若条件为空，则查找所有记录）
	 * @param relaType 关系类型：01-组合与投顾录入权限；07-组合与投顾确认权限；02-组合与投资经理权限；03-组合与交易员权限；04-组合与复核员权限；05-组合与送单员权限；06-组合与后台成交员权限；98-后台成交确认阶段权限；99-交易确认阶段权限；A1-投顾录入确认可为同一人员；（为空则不过滤该条件）
	 * @param userId 用户ID（为空则不过滤该条件）
	 * @param combProductCodes 产品代码（为空则不过滤该条件）
	 * @return
	 * @author 陈鹏
	 */
	@Bizlet("")
	public static String getCombiNos(String relaType, String userId, String combProductCodes){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select t.vc_combi_no from CF_JY_COMB_PRODUCT_HANDLE t where 1=1 ");
			if(StringUtils.isNotBlank(relaType)){
				sb.append(" and t.rela_type='").append(relaType).append("' ");
			}
			if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_id='").append(userId).append("' ");
			}
			if(StringUtils.isNotBlank(combProductCodes)){
				sb.append(" and t.comb_product_code in (").append(JDBCUtil.changeInStr(combProductCodes)).append(") ");
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	//循环分割字符
	@Bizlet("分割字符1")
	public String[] splitArgs(String args,String type){
		String[] strarray=args.split(type);
	    return strarray;
	}
	
	public static <T> T[] concat(T[] first, T[] second) {  
		  T[] result = Arrays.copyOf(first, first.length + second.length);  
		  System.arraycopy(second, 0, result, first.length, second.length);  
		  return result;  
	}   

}
