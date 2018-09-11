package com.cjhxfund.commonUtil;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.eos.common.cache.CacheFactory;
import com.eos.common.cache.ICache;
import com.eos.common.cache.ICacheLoader;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.annotation.Bizlet;
import com.eos.system.logging.Logger;

import commonj.sdo.DataObject;

/**
 * @author 陈迪
 * @date 2016-12-20 19:12:40
 *
 */
@Bizlet("")
@SuppressWarnings("all")
public class CacheUtil {
	private static final Logger logger = TraceLoggerFactory.getLogger(ParamConfig.class);
	/** 系统参数配置表-缓存名称，需跟配置文件user-config.xml的“系统配置数据缓存”的名称对应 */
	public static final String RELOAD_PARAM_CONF = "ReloadParamConf1";
	/***
	 * 多主键命名sql缓存刷新，得到缓存数据，先拆分开，按照多主键命名sql赋值要求处理完毕再组合回来，重新加载缓存
	 * @param cacheName 缓存名称：user-config.xml中配置
	 * @param primaryNames 主键名称数组，把联合主键的各个主键名称放在数组中，务必按照联合主键的顺序排放
	 * @param entityPath 数据实体路径
	 * @author chendi
	 * @return 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Bizlet("多主键命名sql缓存刷新")
	public static boolean refreshCacheByName(String cacheName,String[] primaryNames,String entityPath){
		//定义返回值
		boolean result = false;
		//若传入缓存名称为空，则取默认值
		if(StringUtils.isEmpty(cacheName)){
			cacheName = RELOAD_PARAM_CONF;
			//System.out.println("---你输入的缓存名称为空，现启用默认缓存名称为：ReloadParamConf1---");
		}
		System.out.println("---刷新缓存开始，缓存名称为："+cacheName+" ---");
		try{
			//通过名称获取Cache
			ICache cache = CacheFactory.getInstance().findCache(cacheName);
			//获取CacheLoader
			ICacheLoader cacheLoader = cache.getCacheLoader();
			//重新获取到预加载数据，数据格式：map{object:{aaa|bbb|ccc},dataobject:{key:value...}}，此处的object和dataobject相当于map的key和value
			Map<Object,DataObject> map = cacheLoader.preLoad();
			/**定义临时map，主要是将预加载获取到的cache数据分割出来重新按照多主键命名sql缓存加载规则存放到临时定义的map中**/
			Map<DataObject, DataObject> temp = new HashMap<DataObject, DataObject>();
			for(Map.Entry<Object,DataObject> entry : map.entrySet()){
				//定义临时数组
				String[] array = null;
				//临时map的value值
				DataObject dataObjectValue = entry.getValue();
				//临时map的key值
				DataObject dataObj = DataObjectUtil.createDataObject(entityPath);
				//接收预加载的map中的object处理后的字符串
				array = entry.getKey().toString().split("\\|");
				//临时map的key值赋值
				if(primaryNames.length>0){
					for(int i=0;i<primaryNames.length;i++){
						dataObj.setString(primaryNames[i],array[i]);
					}
				}
				temp.put(dataObj,dataObjectValue);
			}
			//清空缓存
			cache.clear();
			//重新加载缓存
			cache.putAll(temp);
			//刷新成功
			result = true;
			System.out.println("---刷新缓存成功，缓存名称为："+cacheName+" ---");
		}catch (Exception e){
			logger.error("更新缓存发生异常："+e.getMessage(),e);
		}
		return result;
	}
	
	
	/**
	 * @Description 通过缓存名称重新加载缓存
	 * @param 	cacheName Governor中配置的缓存名称
	 * @Author		liangjilong
	 * @Date		2016年12月7日 下午6:37:18
	 * @param 		cacheName系统参数配置表-缓存名称，需跟配置文件user-config.xml的“系统配置数据缓存”的名称对应
	 * @return 		boolean 返回类型
	 */
	@Bizlet("通过缓存名称重新加载缓存")
	public static boolean reloadCacheByName(String cacheName){
		boolean result = false;
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
			logger.error("更新缓存发生异常："+getCurrentClassName()+e.getMessage(),e);
		}
		return result;
	}
	/**
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author		liangjilong
	 * @Date		2016年11月30日 上午9:59:29
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	private static String getCurrentClassName(){
		return CacheUtil.class.getName()+".";
	}
	
	/**
	 * @Description 获取缓存中当前O32数据源（含灾备库）链接名称，
	 * 				支持10.201.4.56等灾备库异常时快速切换到生产库。值域如下：
	 * 				深证通生产环境联通链路--DS_O32；（IP:172.19.8.244）
	 * 				深证通生产环境电信链路--DS_O32_172_119_8_244；（IP:172.119.8.244）
	 * 				创金本地灾备环境--DS_O32_LOCAL；（IP:10.201.4.56）
	 * 
	 * @param	缓存名称：ReloadParamConf1
	 * @param	缓存key: ATS_CURRENT_O32DATASOURCE
	 * @return	cacheName 缓存名称  DS_O32 或者 DS_O32_172_119_8_244 或者 DS_O32_LOCAL
	 * @Author 童伟
	 */
	@Bizlet("获取缓存中当前O32数据源（含灾备库）链接名称")
	public static String getO32CacheDataSourceName(){
		String cacheName = null;
		try {
			//获取缓存中数据源信息
			DataObject obj = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_CURRENT_O32DATASOURCE");
			cacheName =  obj.getString("paramValue").trim();
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存中当前O32数据源（含灾备库）链接名称失败，请检查缓存中数据源的相关配置;缓存key为：{0}", e, "ATS_CURRENT_O32DATASOURCE");
			e.printStackTrace();
		}
		return cacheName;
	}
	
	/**
	 * @Description 获取缓存中当前O32数据源（仅生产库）链接名称，主要用于仅部署在生产环境的程序（如实时计算T+0、T+1头寸的程序目前仅部署在生产库）。
	 * 				支持在创金连接到深证通的某一条链路断开时可快速切换到生产O32的另外一条链路上。值域如下：
	 * 				深证通生产环境联通链路--DS_O32；（IP:172.19.8.244）
	 * 				深证通生产环境电信链路--DS_O32_172_119_8_244；（IP:172.119.8.244）
	 * 
	 * @param	缓存名称：ReloadParamConf1
	 * @param	缓存key: ATS_CURRENT_O32DATASOURCE_PROD
	 * @return	cacheName 缓存名称  DS_O32 或者 DS_O32_172_119_8_244
	 * @Author  huangmizhi
	 */
	@Bizlet("获取缓存中当前O32数据源（仅生产库）链接名称")
	public static String getProdO32CacheDataSourceName(){
		String cacheName = null;
		try {
			//获取缓存中数据源信息
			DataObject obj = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_CURRENT_O32DATASOURCE_PROD");
			cacheName =  obj.getString("paramValue").trim();
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存中当前O32数据源（仅生产库）链接名称失败，请检查缓存中数据源的相关配置;缓存key为：{0}", e, "ATS_CURRENT_O32DATASOURCE_PROD");
			e.printStackTrace();
		}
		return cacheName;
	}
	
	/**
	 * @Description 获取缓存中当前O32数据源（仅灾备库）链接名称，主要用于仅部署在灾备库环境的程序（如头寸预测相关脚本仅存放在10.201.4.56环境）。
	 * 				支持在部署有存储过程等程序的灾备库环境链接异常时可快速切换到灾备库的另外一条链路上。（目前程序还仅放在4.56上面）值域如下：
	 * 				创金本地灾备环境--DS_O32_LOCAL；（IP:10.201.4.56）
	 * 
	 * @param	缓存名称：ReloadParamConf1
	 * @param	缓存key: ATS_CURRENT_O32DATASOURCE_BAK
	 * @return	cacheName 缓存名称  DS_O32_LOCAL
	 * @Author  huangmizhi
	 */
	@Bizlet("获取缓存中当前O32数据源（仅灾备库）链接名称")
	public static String getBakO32CacheDataSourceName(){
		String cacheName = null;
		try {
			//获取缓存中数据源信息
			DataObject obj = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_CURRENT_O32DATASOURCE_BAK");
			cacheName =  obj.getString("paramValue").trim();
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存中当前O32数据源（仅灾备库）链接名称失败，请检查缓存中数据源的相关配置;缓存key为：{0}", e, "ATS_CURRENT_O32DATASOURCE_BAK");
			e.printStackTrace();
		}
		return cacheName;
	}
	
}
