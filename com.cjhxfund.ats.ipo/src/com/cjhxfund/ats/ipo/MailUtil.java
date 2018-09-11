/**
 * 
 */
package com.cjhxfund.ats.ipo;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.data.WFWorkItem;

import commonj.sdo.DataObject;

/**
 * @author 张姚
 * @date 2017-01-12 15:00:50
 *
 */
@Bizlet("")
public class MailUtil {
	@Bizlet("查询工作项邮件的参与人，并拼装邮件地址")
	public String getMailData(WFWorkItem workItem){
		int currentState=workItem.getCurrentState();
		DataObject dataObject=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		String email=null;
		//判断当前工作项是不是运行状态
		if(currentState==10){
			//查询收件人邮箱地址信息
			String empId=workItem.getParticipant();
			if(empId!=null && !"".equals(empId)){
				dataObject.set("empId", empId);
				Object[] traders = DatabaseExt.queryByNamedSql("default",
						"com.cjhxfund.ats.ipo.mailOpr.querySinglePerson",dataObject);
				if(traders!=null && traders.length>0){
					email=((DataObject) traders[0]).getString("oEmail");
				}
			}
			//判断当前环节是不是待领取状态，即是不是角色或是多个人组装的参与者
		}else if(currentState==4){
			String participant=workItem.getParticipant();
			//当参与者为多个人组装的参与者时，参与者的表示形式为 1021|2013|1051
			String[] participants=participant.split("\\|");
			StringBuffer userSb=new StringBuffer();
			if(participants!=null && participants.length>1){
				for(int i=0;i<participants.length;i++){
					//将多个参与者组装成命名SQL查询条件的形式，即：1021,2013,1051
					if(participants[i]!=null && !"".equals(participants[i])){
						if(i==participants.length-1){
							userSb.append("'"+participants[i]+"'");
						}else{
							userSb.append("'"+participants[i]+"'"+",");
						}
					}
				}
				//根据组装好的查询条件查询用户的EMAIL
				if(userSb.toString().length()>0){
					dataObject.set("empId", userSb.toString());
					Object[] traders = DatabaseExt.queryByNamedSql("default",
							"com.cjhxfund.ats.ipo.mailOpr.queryEmailByMorePerson",dataObject);
					if(traders!=null && traders.length>0){
						email=(String) traders[0];
						//由于通过查询返回的结果形式为：email1,email2,email3，在发送邮件时，应将其转换成分号;
						email=email.replaceAll(",", ";");
					}
				}
				//针对参与者为角色的发送人邮件查询
			}else if(participants.length==1){
				if(participant!=null && !"".equals(participant)){
					//根据流程生成的角色ID查询该角色下对应的人员邮件
					dataObject.set("roleId", participant);
					Object[] traders = DatabaseExt.queryByNamedSql("default",
							"com.cjhxfund.ats.ipo.mailOpr.queryPersonByRole",dataObject);
					if(traders!=null && traders.length>0){
						email=(String) traders[0];
						//由于通过查询返回的结果形式为：email1,email2,email3，在发送邮件时，应将其转换成分号;
						email=email.replaceAll(",", ";");
					}
				}
			}
		}
		return email;
	}
	
}
