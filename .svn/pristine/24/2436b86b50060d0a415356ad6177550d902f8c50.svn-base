/**
 * 
 */
package com.cjhxfund.ats.qrtz;

import java.util.Date;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 王锡锋
 * @date 2018-03-15 15:07:37
 *
 */
@Bizlet("")
public class QrtzUtil {
	
	@Bizlet("获取出现异常的任务名串：用逗号隔开")
	public static String getErrorTasks(DataObject[] tasks){
		String taskStr = "";
		try{
			for(DataObject obj:tasks){
				String vcRunState = obj.getString("vcRunState");//定时器状态
				String vcStatus = obj.getString("vcStatus");//监控状态
				String vcTaskCode = obj.getString("vcTaskCode");//任务编码
				if(vcRunState!=null&&vcRunState.equals("0")){
					if(vcStatus!=null){
						if(vcStatus.equals("3")||vcStatus.equals("5")||vcStatus.equals("6")){
							taskStr = taskStr + vcTaskCode + ",";
						}
					}
				}
			}
			if(!taskStr.equals("")){
				taskStr = taskStr.substring(0, taskStr.length()-1);
				System.out.println("监控定时器异常："+taskStr+"----"+new Date());
				
			}
			return taskStr;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
}
