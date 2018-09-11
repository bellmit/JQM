package com.cjhxfund.fpm.bpsExpend;
import org.cjhxfund.sys.SysParamUtil;

import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * 
 * @author chen.kai
 * date:2016-10-12
 * 将最新的审批流程或者活动流程发送短信到员工手机
 *
 */
public class SendMobileCode {
	
	
	/**
	 * @param sendType 发送类型
	 * @param titile 标题
	 * @param participants 接收人
	 * @param nextActivityInstName 下一次活动名称
	 * @param currentActivity 当前活动名称
	 * @param prodName 产品名称
	 */
	@Bizlet("")
 public int sendMobileCodeInfo(String sendType,WFParticipant[] participants,
    		   String nextActivityInstName,String currentActivity,String prodName){
	int flag=-1;
	String mailState = SysParamUtil.getSysParam("mail", "state");
	if("on".equals(mailState)){
		//如果是短信发送类型，就进行下面的操作
 		if(sendType.contains("Note")){
	    	//如果接收人不为空，就循环接收人  
			if(participants.length>0){
	    		   String empid="";
	    		   for(int i=0;i<participants.length;i++){
	    			   if(i<(participants.length-1))empid+=participants[i].getId().concat(",");
	    			   else empid+=participants[i].getId();
	    	          } 
	    		   //调用逻辑流获取手机号
	    	Object[] object=null;
	    	try {  
	    		   //逻辑构件名称
    			   String componentName="com.cjhxfund.fpm.bpsExpend.taskNotification";
    			   //逻辑流名称
    			   String operationName="getMobilePhone";
    			   //传入参数
    			   Object[] params=new Object[]{empid};
    			   //利用java访问逻辑流，然后得到所有的手机号码
     			   object=callLogicBusiness(componentName, operationName, params);
				} catch (Throwable e) {
						e.printStackTrace();
				}
	    	   //对所有的数据进行拼接
    		   String  context=getContext(sendType, prodName, nextActivityInstName, currentActivity);
    		   //取出所有的手机号，因为员工可能有多个手机号码,所以还要处理
    		   String phones[]=null;
    		   String phone = null;
    		   /**
    		    *chen.kai 2016-10-31 对手机号进行处理
    		    */
    		  /* if(object.length!=0){
    			   for (int i = 0; i < object.length; i++) {
    				 //将同一个员工的多个手机号进行拆分
    				   objects=(String[])object[i];
	    				 for (int j = 0; j < objects.length; j++) {
	    					 phone=objects[j].split(";");
							 for (int k = 0; k < phone.length; k++)
								//循环发送邮件
								MobileCodeUtil.getMobileCode(phone[k], context);
						} 
				  }
    		   }*/
    		   if(object.length!=0){
    			   String settingType = SysParamUtil.getSysParam("sysState", "settingType");
    			   if("4".equals(settingType)){
    				  String[] phoneAttay =(String[])object[0];
    				  phone = phoneAttay.length>0?phoneAttay[0]==null?"":phoneAttay[0]:"";
    			   } else{
    				   phone =  SysParamUtil.getSysParam("phone", "testNumber");
    			   }
    			   if("".equals(phone)) return -2;
    			   phones= phone.split(",");
    			   //将同一个员工的多个手机号进行拆分
    			   for (int i = 0; i < phones.length; i++) {
    				   if(phones[i].indexOf(";")>-1) phones[i] = (phones[i].split(";"))[0];
    			   }
    			   
				   if(phones.length>0&&phones.length<101){
					   String phoneStr="";
					   for(int i=0;i<phones.length;i++){
						   if(i==0)phoneStr = phones[i];
							else phoneStr += ","+phones[i];
					   }
					   //发送短信
					   //MobileCodeUtil.getMobileCode(phoneStr, context);
				   		//发送成功
						System.out.println("发送成功");
						flag=0;
				   } else  if(phones.length>100){
					   //每次调用接口最多发送100个手机号，求出调用接口的次数
					   int count=phones.length/100==0?phones.length/100:phones.length/100+1;			
						for (int p = 0; p < count; p++) {
							String phoneStr="";
							int strartIndex=p*100;
							int endIndex=(p+1)*100<phones.length?(p+1)*100:phones.length;
							for (int j = strartIndex; j < endIndex; j++) {
								if(j==endIndex-1)phoneStr+=phones[j];
								else phoneStr+=phones[j].concat(",");
							}
							//分批发送短信，每次发送100个
							//MobileCodeUtil.getMobileCode(phoneStr, context);
							//发送成功
							System.out.println("发送成功");
							flag=0;
						}
				   } else {
					   System.out.println("没有电话号码");
					   flag=-2;
				   }
    		   }
    	   }
	 
 		}
 		return flag;
	}
	System.out.println("短信发送接口状态没开...");
 	return flag;
}
//	@Bizlet("短信测试")
//	public void testMode(String context){
//		Object[] object=null;
//    	try {  
//    		   //逻辑构件名称
//			   String componentName="com.cjhxfund.fpm.util.taskNotification";
//			   //逻辑流名称
//			   String operationName="getMobilePhone";
//			   //传入参数
//			   Object[] params=new Object[]{1442};
//			   //利用java访问逻辑流，然后得到所有的手机号码
// 			   object=callLogicBusiness(componentName, operationName, params);
//			} catch (Throwable e) {
//					e.printStackTrace();
//			}
//    	 String[] phone=null;
//		 String objects[]=null;
//    	if(object.length!=0){
//			   for (int i = 0; i < object.length; i++) {
//				 //将同一个员工的多个手机号进行拆分
//			   objects=(String[])object[i];
//			   if(objects!=null){
// 			   phone=objects[0].split(",");
// 			   //如果手机号小于100个则直接调用接口发送
//				   if(phone.length<101) MobileCodeUtil.getMobileCode(objects[0], context);
//				   else{
//					   //求出调用接口的次数
//					   int count=phone.length/100==0?phone.length/100:phone.length/100+1;			
//						for (int p = 0; p < count; p++) {
//							String phones="";
//							int strartIndex=p*100;
//							int endIndex=(p+1)*100<phone.length?(p+1)*100:phone.length;
//							for (int j = strartIndex; j < endIndex; j++) {
//								if(j==endIndex-1)phones+=phone[j];
//								else phones+=phone[j].concat(",");
//							}
//							//分批发送短信，每次发送100个
//							MobileCodeUtil.getMobileCode(phones, context);
//						}
//				   }
//		     }
//			}
//		   }
//	}
//	
	/**
	 * 需要为逻辑流准备好输入的参数，返回值是一个Object[]
	 * @param componentName  逻辑构件名称
	 * @param operationName 逻辑流名称
	 * @param params 逻辑流的输入参数
	 * @return Object[]
	 * @throws Throwable
	 */
	public Object[] callLogicBusiness(String componentName,String operationName,Object[] params) throws Throwable {
		Object[] result = null;
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		result = logicComponent.invoke(operationName, params);
		// 逻辑流的返回值
		return result;
	}
    
	public  String getContext(String sendType,String prodName,String nextActivityName,String currentActivityName){
		String context="尊敬的用户您好！";
		//待办内容
		if(sendType.contains("auditNote")){
			context+="["+prodName+"]已经完成了"+currentActivityName+"环节,正在进行的环节是"+nextActivityName+",您可登录到产品生命周期系统查询相关信息！";
		}
		//退办内容
		if(sendType.contains("backNote")){
			context+="["+prodName+"]已经从"+currentActivityName+"环节退办到"+nextActivityName+"环节,您可登录到产品生命周期系统查询相关信息！";
		}
		//只读内容
		if(sendType.contains("viewNote")){
			context+="["+prodName+"]已经通过了"+currentActivityName+"环节,正在进行的环节是"+nextActivityName+",您可登录到产品生命周期系统查询相关信息！";
		}
		//征求意见内容
		if(sendType.contains("suggestNote")){
			context+="征求意见邮件";
		}
		//已完成内容
		if(sendType.contains("finishNote")){
			context="["+prodName+"]已经顺利完成了,您可登录到产品生命周期系统查询相关信息！";
		}
		//审批完成内容
		if(sendType.contains("reviewNote")){
			context+="["+prodName+"]已经通过评审,您可登录到产品生命周期系统查询相关信息！";
		}
		//账户有效期截止提醒
		if(sendType.contains("accountTipsNote")){
			context+="["+prodName+"]至账户有效期截止时间剩余不足3个月,您可登录到产品生命周期系统查询相关信息！";
		}
		return context;
	}
	
	/**
	 * 跟均下一活动是否为空，判断当前活动是已完结，还是代办当中的
	 * @param sendType 发送类型
	 * @param nextActivityInstName 下一环节轰动名称
	 * @param currentActivity 当前活动名称
	 * @return 返回精确的发送类型
	 */
	@Bizlet("")
	public static String setSendType(String sendType,String nextActivityInstName,String currentActivity){
		//返回的字符串
		StringBuilder type = new StringBuilder();
		
		if(null!=sendType&&!"".equals(sendType)){
			
			//截取sendType,防止最后一位是“，”,对其截取，保持数据的纯净
			if(sendType.lastIndexOf(",")==(sendType.length()-1))sendType=sendType.substring(0, sendType.length()-1);
			String sendTypes[]=sendType.split(",");	
			
			//当前流程状态
			String flowState = "audit";
			if (nextActivityInstName == null || nextActivityInstName.equals("")) flowState = "finish";
			
			for (int i = 0; i < sendTypes.length; i++) {
				if (sendTypes[i].length() < 8) type.append(flowState);
				type.append(sendTypes[i]);
				if (i != sendTypes.length-1) type.append(",");
			}
		}
		return type.toString();
	}
	
//	public static void main(String[] args) {
//		String str[]=new String[]{"123","132","1212","32","212121","abc"};
//		
//		if(str.length<2)System.out.println("1123");
//		else{
//			int count=str.length/3==0?str.length/3:str.length/3+1;			
//			for (int i = 0; i < count; i++) {
//				String sts="";
//				int strartIndex=i*3;
//				int endIndex=(i+1)*3<str.length?(i+1)*3:str.length;
//				for (int j = strartIndex; j < endIndex; j++) {
//					if(j==endIndex-1)sts+=str[j];
//					else sts+=str[j].concat(",");
//				}
//				System.out.println(sts);
//			}
//		}
//		
//	}
}
