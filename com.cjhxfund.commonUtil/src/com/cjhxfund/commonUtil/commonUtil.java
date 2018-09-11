/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-07-26 16:32:55
 *
 */
@Bizlet("")
public class commonUtil {
	
	/** 上传文件保存路径-流程文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG = "/home/ats/FileUploadPath/JQM/LiuCheng/";
	/** 上传文件保存路径-流程文件-用印文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG_YONGYIN = "/home/ats/FileUploadPath/JQM/LiuCheng/YongYin/";
	/** 上传文件保存路径-投票业务文件 */
	public static final String UPLOAD_FILE_PATH_TOUPIAO = "/home/ats/FileUploadPath/JQM/TouPiao/";
	/** 上传文件保存路径-传真文件 */
	public static final String UPLOAD_FILE_PATH_CHUANZHEN = "/home/ats/FileUploadPath/JQM/ChuanZhen/";
	/** 机器猫原Excel导出功能文件存放路径 */
	public static final String DOWNLOAD_FILE_EXCEL_EXPORT = "/home/ats/FileProcess/JQM/ExcelExport/";
	
	
	/**
	 * @param 组装参与者
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
	 * @param 组装参与者
	 * @return
	 * @author 
	 */
	@Bizlet("交易员2复核是剔除流程发起人和交易员1")
	public static List<WFParticipant> setRelativeEmpList2(List<WFParticipant> participants,String userId) {
		// TODO 自动生成的方法存根
		for (int i = 0; i < participants.size(); i++) {
			if(participants.get(i).getId().equals(userId)){
				participants.remove(i);
			}
		}
		return participants;
	}
	
	/**
	 * @param wf
	 * @return
	 * @author 陈鹏
	 */
	@Bizlet("组装活动实例")
	public static String[] assembleActivityInstance(DataObject wflist) {
		// TODO 自动生成的方法存根
		String[] str = new String[1];
		System.out.println(wflist.getString("vcRollbackItemId"));
		str[0] = wflist.getString("vcRollbackItemId");

		return str;
	}
	/**
	 * 获取债券code
	 * @param dobjs 债券集合
	 * @author 杨敏
	 */
	@Bizlet("获取债券code")
	public static String getBondCode(DataObject[] dobjs){
		if(dobjs.length<1){
			return "";
		}
		return dobjs[0].getString("BCODE");
		
	}
	/**
	 * 获取债券code
	 * @param String code 债券集合
	 * @author 
	 */
	@Bizlet("获取债券code")
	public static String getStockCode(String code){
		if(code.length()>0){
			return code.substring(0, code.length()-2);
		}
		return code;
		
	}
	
	/**
	 * 判断当前登录人是否是交易员
	 * @param 当前登录人角色集合
	 * @param 角色ID
	 * @return 判断角色ID是否存在与当前登录人角色集合
	 */
	@Bizlet("判断角色")
	public static int JudgeRole(String roleList,String roleId){
		int judge = roleList.indexOf(roleId);
		return judge;
	}
	
	/**
	 * Tab页权限
	 * @param 当前页面的code
	 * @param  
	 * @return 根据code判断权限，如果有对应的权限则显示该菜单，否则隐藏
	 */
	@Bizlet("权限控制")
	public static String TabPageRight(String funcCode){
		String funcCodeRel = "'" + funcCode.replace(",", "','") + "'";				
		return funcCodeRel;
	}
	
	/**
	 * 根据指令来源获取指令集合
	 * @param instructList	指令列表
	 * @return
	 */
	@Bizlet("机器猫债券买卖指令根据指令来源获取指令列表")
	public static List<DataObject> getJqmInstructListByInstructSource(DataObject[] instructList){
		List<DataObject> list = new ArrayList<DataObject>();
		for(int i = 0; i<instructList.length; i++){
			DataObject jqmObj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZqmm");
			// 获取指令来源
			String instructSource = instructList[i].getString("vcInstructSource");
			if("1".equals(instructSource) || "2".equals(instructSource)){
				jqmObj.set("processId", Long.parseLong(instructList[i].getString("processId")));
				String processStatus = instructList[i].getString("processStatus");
				// 流程从二级债状态改为老机器猫
				if("2".equals(processStatus)){
					processStatus = "0";
				}else if("3".equals(processStatus)){
					processStatus = "1";
				}else if("5".equals(processStatus)){
					processStatus = "2";
				}else if("6".equals(processStatus)){
					processStatus = "3";
				}else if("7".equals(processStatus)){
					processStatus = "4";
				}else if("8".equals(processStatus)){
					processStatus = "5";
				}else if("9".equals(processStatus)){
					processStatus = "6";
				}
				jqmObj.set("processStatus", processStatus);
				list.add(jqmObj);
			}
		}
		return list;
	}
	
	/**
	 * 
	 * @param instructList
	 * @return
	 * @author tongwei
	 */
	@Bizlet("二级债根据指令来源获取指令列表")
	public static List<DataObject> getSmInstructListByInstructSource(DataObject[] instructList){
		List<DataObject> list = new ArrayList<DataObject>();
		for(int i = 0; i<instructList.length; i++){
			// 获取指令来源
			String instructSource = instructList[i].getString("vcInstructSource");
			if("3".equals(instructSource)){
				DataObject smObj = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultInstruct");
				smObj.set("lResultId",Long.parseLong(instructList[i].getString("processId")));
				list.add(smObj);
			}
		}
		return list;
	}
	
	/**
	 * 
	 * @param instructList
	 * @return
	 * @author tongwei
	 */
	@Bizlet("机器猫指令根据指令来源获取指令列表（正逆回购）")
	public static List<DataObject> getZnhgInstructListByInstructSource(DataObject[] instructList){
		List<DataObject> list = new ArrayList<DataObject>();
		for(int i = 0; i<instructList.length; i++){
			DataObject jqmObj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhg");
			// 获取指令来源
			String instructSource = instructList[i].getString("vcInstructSource");
			if("1".equals(instructSource) || "2".equals(instructSource)){
				jqmObj.set("processId", Long.parseLong(instructList[i].getString("processId")));
				String processStatus = instructList[i].getString("processStatus");
				// 流程从二级债状态改为老机器猫
				if("2".equals(processStatus)){
					processStatus = "0";
				}else if("3".equals(processStatus)){
					processStatus = "1";
				}else if("5".equals(processStatus)){
					processStatus = "2";
				}else if("6".equals(processStatus)){
					processStatus = "3";
				}else if("7".equals(processStatus)){
					processStatus = "4";
				}else if("8".equals(processStatus)){
					processStatus = "5";
				}else if("9".equals(processStatus)){
					processStatus = "6";
				}
				jqmObj.set("processStatus", processStatus);
				list.add(jqmObj);
			}
		}
		return list;
	}
	
	/**
	 * 根据入参信息组装可处理工作项记录
	 * @param instructInfo 指令信息
	 * @return result -1=不可审批，0=可以审批
	 * @author tongwei
	 */
	@Bizlet()
	public String assemblyWorkInfo(DataObject instructInfo){
		// -1=不可审批，0=可以审批
		String result = "-1";
		String processId = "";
		String userId = "";
		DataObject[] workInfos = null;
		
		if(instructInfo != null){
			// 先判断流程状态是否在待审批
			if("2".equals(instructInfo.get("vcProcessStatus")) || "3".equals(instructInfo.get("vcProcessStatus"))){
				processId = instructInfo.get("lProcessinstId").toString();
				// 查询是否有审批权限
				ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.ats.sm.comm.TaskManager");
				try {
					Object[] workInfo = comp.invoke("queryProcessApproveUsersByProcessid", new String[] { processId });
					userId = workInfo[1].toString();
					workInfos = (DataObject[])workInfo[0];
					if(workInfos.length > 0){
						for(int j=0; j<workInfos.length; j++){
							if(workInfos[j].getString("vcUserId").equals(userId)){
								result = "0";
							}
						}
					}
				} catch (Throwable e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}
	
	/**
	 * 
	 * @param paramItem
	 * @return
	 */
	@Bizlet()
	public DataObject assemblyParamInfo(HashMap paramItem){
		DataObject resultObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		if(paramItem != null){
			resultObj.set("vcInstructSource", paramItem.get("vcInstructSource"));
			resultObj.set("processId", paramItem.get("processId"));
			resultObj.set("processStatus", paramItem.get("processStatus"));
		}
		
		return resultObj;
	}
}
