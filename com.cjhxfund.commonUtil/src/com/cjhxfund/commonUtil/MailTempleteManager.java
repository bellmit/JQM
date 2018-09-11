/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.io.IOException;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

import freemarker.template.TemplateException;

/**
 * @author 陈迪
 * @date 2016-12-13 11:03:21
 *
 */
@Bizlet("调用模版类")
public class MailTempleteManager {
	/***
	 * 
	 * @param data 模版中需要的对象
	 * @param type 模版类型 1：触发风控类审批模版 2：可用数量不足模版
	 * @return
	 * @throws IOException
	 * @throws TemplateException
	 */
	@Bizlet("邮件正文模版设置")
	public String getTemplate(DataObject data,int type) throws IOException, TemplateException {
		//设置模版名称
		String templateName ="";
		//传过来的不同类型值设置不同模版名称
		switch(type){
			case 1:
				//触发风控审批模版名称
				templateName = "riskApprovalMail.ftl";
				break;
			case 2:
				//可用数量不足提醒模版
				templateName = "availQtyMail.ftl";
				break;
			case 3:
				//新股IPO标题模板
				templateName = "ipoMailTitle.ftl";
				break;
			case 4:
				//新股IPO邮件正文模板
				templateName = "ipoMailTemplate.ftl";
				break;
			default:
				//测试
				templateName = "riskApprovalMail.ftl";
		}
		//邮件正文辅助对象创建(主要用于ftl模版中解析各个属性)
		DataObject dataObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		dataObject.set("data", data);
	    String ret = MailTemplateUtil.getStringFromFtl(templateName, dataObject);
	    return ret;
	}
}
