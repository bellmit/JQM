/**
 * 
 */
package com.cjhxfund.ats.ipo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
		if(data==null){
			data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//创建空的dataObject对象
			data.setString("vcdate", "2017-01-09");
			data.setString("vcCombiName", "白银有色");
			data.setString("vcProductCode", "601212");
		}
		//传过来的不同类型值设置不同模版名称
		switch(type){
			case 1:
				//标题模版
				templateName = "ipoMailTitle.ftl";
				break;
			default:
				//正文模板
				templateName = "ipoMailTemplate.ftl";
		}
		//创建空的dataObject对象，供freemarker模版取值用 
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		dataObj.set("data", data);
	    String ret = MailTemplateUtil.getStringFromFtl(templateName, dataObj);
	    System.out.println(ret);
	    return ret;
	}
}
