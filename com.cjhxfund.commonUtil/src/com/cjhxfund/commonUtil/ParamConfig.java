package com.cjhxfund.commonUtil;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.eos.common.cache.CacheFactory;
import com.eos.common.cache.ICache;
import com.eos.common.cache.ICacheLoader;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.CacheUtil;
import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.annotation.Bizlet;
import com.eos.system.logging.Logger;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * 参数配置服务类
 * @author huangmizhi
 */
public class ParamConfig {

	private static final Logger logger = TraceLoggerFactory.getLogger(ParamConfig.class);
	private static Map<String,String> map = new HashMap<String,String>();
	/** 系统参数配置表-缓存名称，需跟配置文件user-config.xml的“系统配置数据缓存”的名称对应 */
	public static final String RELOAD_PARAM_CONF = "ReloadParamConf1";
	
	/**
	 * 初始化参数设置
	 * @author huangmizhi
	 */
//	static{
//		loadData();
//	}
	
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
	 * 通过缓存名称重新加载缓存
	 * @param cacheName Governor中配置的缓存名称
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("通过缓存名称重新加载缓存")
	public static boolean reloadCacheByName(String cacheName){
		boolean result = false;
		//若传入缓存名称为空，则取默认值
		if(StringUtils.isEmpty(cacheName)){
			cacheName = RELOAD_PARAM_CONF;
		}
		try{
			//通过名称获取Cache
			ICache cache = CacheFactory.getInstance().findCache(cacheName);
			//获取CacheLoader
			ICacheLoader cacheLoader = cache.getCacheLoader();
			//重新获取到预加载数据
			Map map = cacheLoader.preLoad();
			//清空缓存
			cache.clear();
			//重新加载缓存
			cache.putAll(map);
			//刷新成功
			result = true;
			
		}catch (Exception e){
			logger.error("更新缓存发生异常："+e.getMessage(),e);
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
//		if(map==null || map.isEmpty()){
//			loadData();
//		}
//		return map.get(key)==null?"":map.get(key);
		
		//修改为从Governor缓存中读取
		DataObject obj = (DataObject) CacheUtil.getValue(RELOAD_PARAM_CONF, key);
		return obj.getString("paramValue");
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
	
	/**
	 * 根据参数key更新系统参数值
	 * @param paramKey 参数key
	 * @param paramValue 参数值
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean updateParamValueByParamKey(String paramKey, String paramValue){
		boolean isSuccess = false;//根据参数key更新参数值
		//逻辑流名称
		String operationName = "updateParamValueByParamKey";
		//构建包名称
		String componentName = "com.cjhxfund.commonUtil.zhfwptparamconfbiz";
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		try {
			Object[] objs = logicComponent.invoke(operationName, new Object[]{paramKey, paramValue});
			if(objs!=null && objs.length>0){
				isSuccess = (Boolean) objs[0];
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
}
