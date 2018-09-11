/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.util.ArrayList;
import java.util.List;

import com.eos.system.annotation.Bizlet;

import org.apache.commons.lang.StringUtils;

import com.eos.engine.component.ILogicComponent;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;


/**
 * @author chenpeng
 * @date 2016-04-05 16:37:13
 *
 */
@Bizlet("")
public class FaxInvoker {
	
	//邮件地址
	private static String mailAddress ="294806367@qq.com"; 
	
	/**
	 * 调用逻辑流发送邮件
	 * @param mailTitle 邮件标题
	 * @param mailContent 邮件内容
	 * @param PmAttachInfos 附件列表
	 * @author chenpeng
	 */
	@Bizlet("")
	public static void sendFax(String mailTitle,String mailContent,DataObject[] PmAttachInfos){
		List<String> filePaths = new ArrayList<String>();   //定义附件路径集合
		List<String> fileNames = new ArrayList<String>();   //定义附件名称集合
		
		//解析附件集合并给福建路径集合与附件名称集合赋值
		for(int i = 0 ; i < PmAttachInfos.length ; i++){
			DataObject PmAttachInfo = PmAttachInfos[i];
			filePaths.add("c://" + PmAttachInfo.getString("attachAdd"));
			fileNames.add(PmAttachInfo.getString("attachName"));
		}
		
		FaxInvoker.invokeSendEmailLogic(mailTitle, mailContent, FaxInvoker.mailAddress , filePaths, fileNames);
	}
	/**
	 * 调用逻辑流发送邮件
	 * @param mailTitle 邮件标题
	 * @param mailContent 邮件内容
	 * @param mailAddress 邮件地址
	 * @param filePaths 附件路径(List)
	 * @param fileNames 附件名称(List)
	 * @author zhengpx
	 */
	 public static void invokeSendEmailLogic(String mailTitle, String mailContent, String mailAddress, List<String> filePaths, List<String> fileNames){
		try {
			ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.commonUtil.MessageService");
			String T [] = new String[]{};
			Object[] params = new Object[5];
			params[0] = mailTitle;//邮件标题
			params[1] = StringUtils.isBlank(mailContent) ? mailTitle : mailContent;//邮件内容
			params[2] = mailAddress;//邮件地址，多个时以分号隔开
			params[3] = filePaths.toArray(T);//附件绝对路径，数组
			params[4] = fileNames.toArray(T);//附件文件名，数组
			//调用逻辑流的方法
			comp.invoke("sendMultiMailExt", params);
		} catch (Throwable e) {
			// TODO 自动生成 catch 块
			e.printStackTrace();
		}
	}
}
