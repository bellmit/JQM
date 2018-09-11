/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.cjhxfund.ats.fm.comm.JDBCUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.data.WFActivityDefine;
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
	public static List<WFActivityDefine> interceptWorkitem(List<WFActivityDefine> wflist,DataObject workItem) {
		// TODO 自动生成的方法存根
			
		List<WFActivityDefine> objs = new ArrayList<WFActivityDefine>();
		System.out.println(wflist.size());
		for (int i = 0; i < wflist.size(); i++) {
			//判断节点是否为人工活动
			if(wflist.get(i).getType().equals("manual")){
				//过滤回退环节不允许有当前正在处理的环节
				System.out.println(wflist.get(i).getId());
				if (!wflist.get(i).getId().equals(workItem.getString("activityDefID"))) {	
					
					if(workItem.getString("activityDefID").indexOf("CZ") != -1){
						//判断环节等于中标确认时
						if(workItem.getString("activityDefID").equals("ATS_FM_CZ_ZBQR")){
							//过滤掉传真环节之前的环节
							if(wflist.get(i).getId().indexOf("CZ") != -1 && !wflist.get(i).getId().equals("ATS_FM_CZ_ZBFH")){
								objs.add(wflist.get(i));
								continue;
							}else{
								continue;
							}
						}
						
						//判断环节等于中标复核时
						if(workItem.getString("activityDefID").equals("ATS_FM_CZ_ZBFH")){
							//过滤掉传真环节
							if(!wflist.get(i).getId().equals("ATS_FM_CZ_TBZX")){
								//过滤掉传真环节之前的环节
								if(wflist.get(i).getId().indexOf("CZ") != -1){
									objs.add(wflist.get(i));
									continue;
								}else{
									continue;
								}
							}
						}
						
						//过滤环节不包含传真标示的环节
						System.out.println("AAA========" + wflist.get(i).getId().indexOf("CZ"));
						if(workItem.getString("activityDefID").equals("ATS_FM_CZ_TBZX")){
							if(wflist.get(i).getId().indexOf("CZ") == -1){
								objs.add(wflist.get(i));
								continue;
							}else{
								continue;
							}
						}
						
	
						if(workItem.getString("activityDefID").indexOf("CZ") != -1){
							if(!wflist.get(i).getId().equals("ATS_FM_CZ_TBZX") && !wflist.get(i).getId().equals("ATS_FM_CZ_ZBQR")  && wflist.get(i).getId().indexOf("CZ") != -1){
								objs.add(wflist.get(i));
								continue;
							}
						}	
						
					}else{
						objs.add(wflist.get(i));
						continue;
					}
				}
			}	
		}
		//去除集合中的重复数据
		for (int i = 0; i < objs.size() - 1; i++) {
			for (int j = objs.size() - 1; j > i; j--) {
				if (objs.get(j).getId().equals(objs.get(i).getId())) {
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
	public static List<WFParticipant> getByIdEmpList(String userId,String empCode) {
		// TODO 自动生成的方法存根
		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		WFParticipant ipant = new WFParticipant();
		//查询用户信息
		DataObject user = DataObjectUtil
				.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		if(empCode != null && empCode != ""){
			user.set("empcode", empCode);
		}else{
			user.set("empid", userId);
		}
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
	public static List<WFActivityDefine> deleteIink(List<WFActivityDefine> activitys) {
		// TODO 自动生成的方法存根
		List<WFActivityDefine> objs = new ArrayList<WFActivityDefine>();
		for (int i = 0; i < activitys.size(); i++) {
			//当环节为分管领导复核时
			if (activitys.get(i).getId().equals("ATS_FM_FGLDFH")) {
				continue;
			}
			//当环节为执行总监审核特批交易时
			if (activitys.get(i).getId().equals("ATS_FM_ZXZJFH")) {
				continue;
			}
			//当环节为报价修改后的人工审核环节时
			if (activitys.get(i).getId().equals("manualActivity15")) {
				continue;
			}
			//当环节为投顾复核时剔除。所有流程业务通用
			if(activitys.get(i).getId().equals("投顾审核")){
				continue;
			}
			objs.add(activitys.get(i));
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
		//去除重复记录
		traders1 = concat(traders1);
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
	public static String assembleDateTime(Date dateTime,String activityDefID,String lBizId) throws Exception{
		//实例化日期处理类
		Calendar calendar = Calendar.getInstance();
		DataObject bizprocess = null;
		SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			Thread.sleep(1*1000);
			//随机生成的5-10之间秒数
			int randomNumber = 20; 
			//当环节为分管领导审核时阻塞线程1秒
			if(activityDefID.equals("ATS_FM_TZJLFH")){
				randomNumber = randomNumber + (int)(Math.random() * 6 + 15);
			}else if(activityDefID.equals("ATS_FM_ZJZLSP")){
				randomNumber = randomNumber + (int)(Math.random() * 6 + 52);
			}else if(activityDefID.equals("ATS_FM_ZXZJFH")){
				randomNumber = randomNumber + (int)(Math.random() * 6 + 117);
			}else if(activityDefID.equals("ATS_FM_FGLDFH")){
				randomNumber = randomNumber + (int)(Math.random() * 6 + 158);
			}
			System.out.println("randomNumber======" + randomNumber);
	        calendar.setTime(dateTime);
	      //设置秒数加上随机生成的5-10之间秒数
	        calendar.add(Calendar.SECOND, randomNumber);  
	        
	        //当环节为分管领导复核时修流程改业务信息表中当前操作时间
	        if(activityDefID.equals("ATS_FM_FGLDFH")){
	        	//实例化流程业务表对象
	        	bizprocess = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsBizProcess");
	        	bizprocess.setString("lBizId", lBizId);
	        	 
	        	bizprocess.setDate("dCurOperateTime", DateFormat.parse(DateFormat.format(calendar.getTime())));
	        	//调用修改方法
	        	DatabaseUtil.updateEntity(JDBCUtil.DATA_SOURCE_DEFAULT, bizprocess);
	        }
	        
		}catch(Exception e){
			e.printStackTrace();
		}
		return  DateFormat.format(calendar.getTime());
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
	
	/**
	 * 剔除重复记录
	 * @param 参与者集合列表
	 * @return 剔除重复记录后的参与者集合
	 */
	public static List<WFParticipant> concat(List<WFParticipant> objs) {  
		//去除集合中的重复数据
		for (int i = 0; i < objs.size() - 1; i++) {
			for (int j = objs.size() - 1; j > i; j--) {
				if (objs.get(j).getId().equals(objs.get(i).getId())) {
					objs.remove(j);
				}
			}
		}
		return objs;
	}
	
	/**
	 * 
	 * @param userId  当前流程处理人
	 * @param users	  用户集合
	 * @return 剔除当前流程处理人集合
	 */
	@Bizlet("在流程转办、征求意见选择人员时剔除当前处理人")
	public List<DataObject> queryUserList(String userId,DataObject[] users){
		List<DataObject> list = new ArrayList<DataObject>();
		for(int i = 0;i < users.length; i++){
			System.out.println(userId +"                           "  + users[i].getString("userid"));
			if(!userId.equals(users[i].getString("userid"))){
				list.add(users[i]);
			}
		}
		return list;
	}
	
	/**
	 * 判断上一环节操作时间是否大于当前操作时间，大于时不能提交流程
	 * @param dCurOperateTime 上一环节操作时间
	 * @return 0-可以提交 1-不能提交
	 */
	@Bizlet("")
	public static int checkDate(String dCurOperateTime){
		int i = 0;
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		//判断传入的上一环节操作时间是否为空
		if((dCurOperateTime == "" && dCurOperateTime.equals("")) || null==dCurOperateTime){
			return i;
		}else{
			try{
				Date endDate = new Date();
				//将字符串日期转换成日期格式
				Date strDate = df.parse(dCurOperateTime);
				if(strDate.getTime() > endDate.getTime()){
					i = 1;
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return i;
	}
	
	public static void main(String[] args) {
		try {
			/*System.out.println("ATS_FM_TZJLFH    =================" + assembleDateTime(new Date(),"ATS_FM_TZJLFH","1"));
			System.out.println("ATS_FM_ZJZLSP    =================" + assembleDateTime(new Date(),"ATS_FM_ZJZLSP","1"));
			System.out.println("ATS_FM_ZXZJFH    =================" + assembleDateTime(new Date(),"ATS_FM_ZXZJFH","1"));
			System.out.println("ATS_FM_FGLDFH    =================" + assembleDateTime(new Date(),"ATS_FM_FGLDFH","1"));*/
			Calendar cal = Calendar.getInstance();;
			cal.setTime(new Date());
			System.out.println(cal.getTime());
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
}
