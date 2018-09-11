package com.cjhxfund.jy.BackStageTradeProcess;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
/**
 * @author 金文轩
 * @date 2016-09-09 15:20:45
 *
 */
@Bizlet("目录配置读取")
public class Consts {
	//从配置文件中读取共享目录
	private static Properties p = new Properties();
	static {
		InputStream in;
		try {
			in = Consts.class.getResourceAsStream( "o32.properties");
			p.load(in);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 本地操作目录路径从缓存中获取
	 * @return
	 */
	public static String getLocalPath() {
		//调用读取系统参数配置的逻辑流
		String componentName = "com.cjhxfund.commonUtil.zhfwptparamconfbiz";
    	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		Object[] params = new Object[1];
		params[0]="ZHFWPT_LOCAL_FOLDER_PATH";
		//预防调用失败，赋予本地操作目录一个默认值
		String localPath = "/home/ats/FileProcess/zhongzhai_shangqing";
		try {
			//从系统参数配置表ZHFWPT_PARAM_CONF中读取PARAM_KEY为"ZHFWPT_LOCAL_FOLDER_PATH"的PARAM_VALUE
			Object[] object = logicComponent.invoke("getParamValue",params);
			if(object!=null&&object.length>0){
				if(object[0]!=null){
					localPath = object[0].toString();
				}
			}
		} catch (Throwable e) {
			LogUtil.logError("从系统参数获取本地路径失败，使用默认路径: /home/ats/FileProcess/zhongzhai_shangqing", null, new Object[]{});
			e.printStackTrace();
		}
		return localPath;
	}
	/**
	 * 获取中债登Excel文件监听目录
	 * @return
	 */
	public static String getCNSourcePath(){
		//读取配置文件
		String result = p.getProperty("source_zhongzhai_excel_path");
		return result;
	}
	/**
	 * 获取上清所Excel文件监听目录
	 * @return
	 */
	public static String getSHSourcePath(){
		//读取配置文件
		String result = p.getProperty("source_shangqing_excel_path");
		return result;
	}
}
