package com.cjhxfund.ats.fm.comm;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import commonj.sdo.DataObject;

/**
 * 参数配置服务类
 * @author huangmizhi
 */
public class ParamConfig {

	private static Map<String,String> map = new HashMap<String,String>();
	
	/**
	 * 初始化参数设置
	 * @author huangmizhi
	 */
	static{
		loadData();
	}
	
	/**
	 * 查询所有参数配置记录存放到map中
	 * @author huangmizhi
	 */
	@Bizlet("查询所有参数配置记录存放到map中")
	public static boolean loadData(){
		boolean result = false;
		if(map==null){
			map = new HashMap<String,String>();
		}
		DataObject[] dataObjs = queryParamConfList();
		if(dataObjs!=null && dataObjs.length>0){
			for(int i=0; i<dataObjs.length; i++){
				DataObject data = dataObjs[i];
				String paramKey = data.getString("paramKey");
				String paramValue = data.getString("paramValue");
				if(StringUtils.isNotEmpty(paramKey)){
					map.put(paramKey, paramValue);
				}
			}
			reloadConstantVal();
			result = true;
		}
		return result;
	}
	
	/**
	 * 从map中通过key查询value
	 * @param key
	 * @return String
	 * @author huangmizhi 
	 */
	@Bizlet("从map中通过key查询value")
	public static String getValue(String key){
		if(StringUtils.isBlank(key)){
			return "";
		}
		if(map==null || map.isEmpty()){
			loadData();
		}
		return map.get(key)==null?"":map.get(key);
	}
	
	
	/**
	 * 查询所有参数配置记录
	 * @return DataObject[]
	 * @author huangmizhi 
	 */
	@Bizlet("查询所有参数配置记录")
	public static DataObject[] queryParamConfList(){
		DataObject [] dataObjs = null;
		// 逻辑流名称
		String operationName = "queryParamConf"; 
		// 构建包名称				
		String componentName = "com.cjhxfund.commonUtil.zhfwptparamconfbiz";
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		try {
			Object[] objs = logicComponent.invoke(operationName, new Object[]{});
			if(null != objs && objs.length > 0){
				dataObjs = (DataObject[]) objs[0];
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dataObjs;
	}
	
	/**
	 * 重新设置配置参数属性值
	 * @author huangmizhi 
	 */
	@Bizlet("")
	public static void reloadConstantVal(){
	}
	
}
