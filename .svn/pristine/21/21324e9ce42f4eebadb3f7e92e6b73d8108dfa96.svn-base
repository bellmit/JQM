package com.cjhxfund.fpm.bpsExpend;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.IWFOMService;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.workflow.api.ParticipantType;
import com.primeton.workflow.api.WFServiceException;
import com.primeton.ext.das.common.DataObjectHelper;

import commonj.sdo.DataObject;

/**
 * @author Aoxq
 * @date 2015-01-08 13:33:24
 * 通用工具类
 */
public class CommonUtil {
	
	
	//查询参与者Name
	@Bizlet("查询参与者名称")
	public static String getPaticipantName(String typeCode,String id) throws WFServiceException{
		IWFOMService FOMService=ServiceFactory.getWFOMService();
		WFParticipant participant=null;
		if(typeCode==null){
			List<ParticipantType> partType=FOMService.getParticipantTypes();
			for(ParticipantType type:partType ){
				String code=type.getCode();
				try{
					participant=FOMService.findParticipantByID(code, id);
				}catch(Exception e){
					
				}finally{
					if(participant!=null){
						break;
					}
				}
			}
		}else if(typeCode.equals("person")){
			String [] type=new String[2];
			type[0]="person";
			type[1]="emp";
			for(String code:type){
				try{
					participant=FOMService.findParticipantByID(code, id);
				}catch(Exception e){
					
				}finally{
					if(participant!=null){
						break;
					}
				}
			}
		}else{
			participant=FOMService.findParticipantByID(typeCode, id);
		}
		String name=null;
		if(participant!=null){
			name=participant.getName();
		}else{
			name=id;
		}
		
		return name;
	}
	
	//@Review  修改格式化时间的方法
	//格式化时间
	public static String transTime(String time) {
		if(time!=null){
			SimpleDateFormat transTime = new SimpleDateFormat("yyyyMMddHHmmss"); //@Review 1.14
			Date date = null;
			try {
				date = transTime.parse(time);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			transTime.applyPattern("yyyy-MM-dd HH:mm:ss");
			return transTime.format(date);
		}
		return null;
	}
	
	/**
	 * 分割参与者,参与选格式为 1223,小王
	 * @param partiInfo 入参选中的参与人,格式为1223,小王
	 * @return 返回值类似的为1223
	 */
	@Bizlet("获取参与者员工ID")
	public static String splitParti(String partiInfo){
		String empId=null;
		if(partiInfo!=null){
			String[] parts=partiInfo.split(",");
			if(parts!=null && parts.length>1){
				empId=parts[0];
			}
		}
		return empId;
	}
	
	/**
	 * 组装加签选择的参与者为流程的参与者对象WFParticipant
	 * @param askPartis 入参为选择的参与者字符串，格式为 1232,小王;1224,小刘
	 * @return
	 */
	@Bizlet("组装选择加签的人员")
	public static WFParticipant[] covParticipant(String askPartis){
		WFParticipant[] parts=null;
		if(askPartis!=null){
			String[] partsStr=askPartis.split(";");
			if(partsStr!=null && partsStr.length>0){
				parts=new WFParticipant[partsStr.length];
				for(int i=0;i<partsStr.length;i++){
					String[] part=partsStr[i].split(",");
					if(part!=null && part.length>1){
						parts[i]=new WFParticipant();
						parts[i].setId(part[0]);
						parts[i].setName(part[1]);
						parts[i].setTypeCode("emp");
					}
				}
				
			}
		}
		return parts;
	}
	
	/**
	 * 判断当前活动下选择的参与人是否已存在工作项
	 * @param workList 已经存在的工作项列表
	 * @param WFParticipant 所加签选择的参与人
	 * @return 返回 0 表示选择的人员不存工作项，1表示存在
	 */
	@Bizlet("判断当前活动下指令的人是否存在工作项")
	public static int judgePartExist(DataObject[] workList,WFParticipant[] partList){
		int resultInt=0;
		if(workList!=null && workList.length>0){
			if(partList!=null && partList.length>0){
				for(int i=0;i<workList.length;i++){
					String empId=workList[i].getString("participant");
					for(int j=0;j<partList.length;j++){
						String partId=partList[j].getId();
						if(empId.equals(partId) && workList[i].getInt("currentState")!=13){
							resultInt=1;
							break;
						}
					}
					if(resultInt==1){
						break;
					}
				}
			}
		}
		return resultInt;
	}
	
	
	
	/**
	 * nameArrayStr格式 aaa,bbb,ccc
	 * @param nameArrayStr
	 * @param name
	 * @return boolean
	 */
	@Bizlet("判断名字在名字数组字符串中是否存在")
 	public String checkSameName(String nameArrayStr,String name){
	 	String flag = "false";
	 	if(!(nameArrayStr==null)){
	 		if(nameArrayStr.indexOf(",") > -1){
	 			String[] nameArray = nameArrayStr.split(",");
	 			for(int i = 0; i < nameArray.length; i++){
	 				if(nameArray[i].equals(name)){
	 					flag = "true";
	 				}
	 			}
	 		} else {
	 			if(nameArrayStr.equals(name)) flag = "true";
	 		}
	 	}
 		return flag;
 	}
	 
	/**
	 * @param comment
	 * @return
	 * @author jiangbin
	 */
	@Bizlet("convertCommentToDict")
	public static DataObject[] convertCommentToDict(DataObject[] dataObjects) {
		
		List<DataObject> dictList = new ArrayList<DataObject>();
		if(null!=dataObjects && dataObjects.length>0){
			DataObject commentObj = dataObjects[0];
			String comment = commentObj.getString("commentText");
			if(null!=comment && comment.trim().length()>0){
				String[] comments = comment.split("\\|");
				for(int index=0;index<comments.length;index++){
					String comm = comments[index];
					DataObject dict = DataObjectHelper.createDataObject(null);
					dict.set("dictId",index+1);
					dict.set("dictName", comm);
					dictList.add(dict);
				}
				
			}
		}
		
		return dictList.toArray(new DataObject[dictList.size()]);
		
	}
	
	@Bizlet
	public String[] splitArgs(String args,String type){
		 if(args==null||"".equals(args)){
			 return null;
		 } else {
	         String[] strarray=args.split(type);
	    	 return strarray;
		 }
     }
	
	@Bizlet("对时间追加指定秒数")
	public static Date addDate(Date date, Integer sec){
		long time = date.getTime();
		time = time + sec * 1000;
		Date newDate = new Date(time);
		return newDate;
			
	}
	
	/**
	 * 
	 * @param theDate  有效日期
	 * @param addMonth  预定月数
	 * @return 是否发送邮件
	 */
	@Bizlet("判断当前时间是否达到给定的日期")
	public static int checkDateIsTheDate(Date theDate,int addMonth){
		boolean flag = true;
		Date nowDate = new Date();
		DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.FULL);
		int frequency = Integer.parseInt(CommonUtil.getSysParam("mail", "tipsFrequency"));//取出发送频率（天）
		System.out.println("<=========判断开始==========>");
		System.out.println("当前日期为："+dateFormat.format(nowDate));
		System.out.println("到期日期为："+dateFormat.format(theDate));
		//增加指定天数
		Calendar ca = Calendar.getInstance();//获取实例
		ca.setTime(nowDate);
		ca.add(Calendar.MONTH, addMonth);
		Date addDate = ca.getTime();//获取增加月数后的日期
		System.out.println("增加月后时间日期为："+dateFormat.format(addDate));
		System.out.print("提前"+addMonth+"个月内；");
		System.out.println("发送频率为"+frequency+"天次");
		long addDay = addDate.getTime()/(24 * 60 * 60 * 1000);//取当前时间+预定月数后的天
		long theDay = theDate.getTime()/(24 * 60 * 60 * 1000);//有效期时间的天
		
		if(frequency==-1){//如果频率为-1则不发邮件
			flag = false;
			return -1;
		}
		flag = checkFre(addDay,theDay,frequency,nowDate);
		System.out.println("本产品是否符合发送日期？"+flag);
		System.out.println("<=========判断结束==========>");
		if(flag){
			return (int)((theDate.getTime()-nowDate.getTime())/(24 * 60 * 60 * 1000))+1;
		} else {
			return -1;
		}
	}
	
	/**
	 * 
	 * @param addDay  当前时间与限定时间之和
	 * @param theDay  有效期时间
	 * @param frequency  频率时间
	 * @return 是否到达发送时间
	 */
	private static boolean checkFre(long addDay,long theDay,long frequency,Date nowDate) {
		boolean flag = true;
		long nowDay = nowDate.getTime()/(24 * 60 * 60 * 1000);
		if(theDay==addDay){
			System.out.println("到期日期==当前时间与提前月数之和");
			System.out.println(theDay+"=="+addDay+" = true");
			flag = true;
		} else if(addDay>theDay&&nowDay<=theDay){
			//当前日期加上限定月数大于有效期，并且当前日期小于有效期时，进入频率检查方法
			if(frequency==0){//如果频率为0则只发一次邮件
				flag = false;
				return flag;
			}
			long newAddSeconds = addDay-frequency;
			System.out.println("当前日期加上提前月数大于到期日期，并且当前日期小于到期日期");
			flag = checkFre(newAddSeconds,theDay,frequency,nowDate);
		} else {
			System.out.println("未到发送时间或正在发送频率间期");
			flag = false;
		}
		return flag;
	}
	
	
	@Bizlet("获取系统参数")
	public static String getSysParam(String paramKey,String paramName){
		String paramValue = "";
		DataObject sysParam = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.ZhfwptParamConf");
		sysParam.set("paramKey", paramKey);
		sysParam.set("paramName", paramName);
		sysParam.set("paramStatus", "1");
		DatabaseUtil.expandEntity("default", sysParam);
		paramValue = sysParam.getString("paramValue");
		return paramValue;
	}
	
	@Bizlet("添加延迟时间")
	public String addTime(String time){
		Long t = Long.parseLong(time);
		t = t+100;
		String newTime = t.toString();
		return newTime;
	}
	@Bizlet("把页面上排序的字段名转换成表中的列名")
	public String changeColumn(String inputIn,int type) {
		/**
		 * type==0 待处理任务
		 * type==1 流转中任务
		 * type==2已完成任务
		 * type==3待阅通知
		 * type==4已阅通知
		 */
		String result = "";
		if(type==0){
			if ("arrivalTime".equals(inputIn)) {
				result = "t.sortTime";
			} else if ("productName".equals(inputIn)) {
				result = "t.prod_name";
			} else if ("processActivityName".equals(inputIn)) {
				result = "t.activityinstname";
			} else if ("creator".equals(inputIn)) {
				result = "t.process_creator";
			} else if ("processType".equals(inputIn)) {
				result = "t.biz_type";
			} else if ("accountType".equals(inputIn)) {
				result = "t.type_name";
			} else if ("bussinessType".equals(inputIn)) {
				result = "t.prod_subtype_name";
			}else{
			}
		}else if(type==1 || type==2 || type==3 || type==4){
			
			result = "t."+inputIn;
			
		}
		return result;
	}

}
