package com.cjhxfund.cjapi.common;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
/**
 * 本模块负责参数处理
 * @author luwenxing
 * @date 2016年11月22日17:26:07
 */
@Bizlet("")
public class ParamUtil {
	
	private static boolean isInit = false;		// 是否初始化
	private static Map<String, ArrayList<ParamCondition>> mapParamCondition;
	
	private static boolean init(){
		Object[] objs = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.common.ParamCheckns.queryParamCheckAll", null);
		if (objs == null || objs.length == 0) {
			return false;
		}
		
		mapParamCondition = new HashMap<String, ArrayList<ParamCondition>>();
		for (Object obj : objs) {
			DataObject dataObj = (DataObject)obj;
			ParamCondition pc = new ParamCondition();
			// 数据库中读取数据
			String interfaceName = dataObj.getString("vcInterfaceName");
			pc.name = dataObj.getString("vcParamName");
			pc.type = dataObj.getString("vcParamType");
			pc.isNeed = dataObj.getString("vcIsNeed").trim().equals("1");
			pc.length = dataObj.getString("vcParamLength");
			
			if (!mapParamCondition.containsKey(interfaceName)) {
				ArrayList<ParamCondition> params = new ArrayList<ParamCondition>();
				mapParamCondition.put(interfaceName, params);
			}
			mapParamCondition.get(interfaceName).add(pc);
		}
		return true;
	}
	
	/***
	 * 
	 * @param interfaceName
	 * 						需要检查参数的接口名
	 * @param json
	 * 						接收到的json数据
	 * @return errorCode
	 * 						返回码，0表示无错误
	 */
	@Bizlet("接口参数合法性检测")
	public static DataObject paramCheck(String interfaceName, String json) throws AppException{
		if (json == null || json.isEmpty()) {
			throw new AppException(CJAPIConstants.ERROR_PARAM_NULL,CJAPIConstants.ERROR_PARAM_NULL_MSG);
		} else {
			LogUtil.logInfo(interfaceName+" 接收参数："+json,null);
		}
		if (!ParamUtil.isInit) {
			// 初始化
			ParamUtil.isInit = init();
		}
		
		Map<String, Object> mapParam = JSONUtil.jsonToMap(json);
		ArrayList<ParamCondition> listBaseParam = mapParamCondition.get(interfaceName);
		if (listBaseParam == null) {
			String msg  = String.format(CJAPIConstants.ERROR_PARAM_INTERFACE_MSG, interfaceName);
			throw new AppException(CJAPIConstants.ERROR_PARAM_INTERFACE,msg);
		}
		
		for (ParamCondition condition : listBaseParam) {
			Object param = mapParam.get(condition.name);
			if (condition.isNeed) {
				// 1. 判断参数是否缺少
				if (param == null||"".equals(param)) {
					String msg = String.format(CJAPIConstants.ERROR_PARAM_MISS_MSG,condition.name);
					throw new AppException(CJAPIConstants.ERROR_PARAM_MISS,msg);
				}
			} else {
				// 0. 可空，且为空，直接跳过；不为空则也需检测
				if(param == null||"".equals(param)){
					continue;
				} 
			}
			
			// 2. 判断参数类型是否正确
			if (!condition.type.equalsIgnoreCase(param.getClass().getSimpleName())) {
				String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,condition.name);
				throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
			}
			
			// 3.判断参数值长度是否超出
			Pattern pattern = Pattern.compile("[0-9]*");
			if(condition.length!=null&&!"".equals(condition.length)){//数据库VC_PARAM_LENGTH为空则不进行校验
				if ("String".equalsIgnoreCase(param.getClass().getSimpleName())){//String类型的参数
					if(pattern.matcher(condition.length).matches()){//数据库中存储的长度为数字
						if(String.valueOf(param).getBytes().length>Integer.parseInt(condition.length)){
							String msg = String.format(CJAPIConstants.ERROR_PARAM_LENGTH_MSG,condition.name);
							throw new AppException(CJAPIConstants.ERROR_PARAM_LENGTH, msg);
						}
					}
				}else if("BigDecimal".equalsIgnoreCase(param.getClass().getSimpleName())){//BigDecimal类型
					if(pattern.matcher(condition.length.split("\\,")[0]).matches()){//数据库中存储的有效位为数字
						//规定的有效位
						int precision = Integer.parseInt(condition.length.split("\\,")[0]);
						//规定的小数位数
						int scale = 0;
						if(condition.length.split("\\,").length==2&&
								pattern.matcher(condition.length.split("\\,")[1]).matches()){
							//数据库中存储的精度存在且为数字
							scale = Integer.parseInt(condition.length.split("\\,")[1]);
						}
						if(String.valueOf(param).split("\\.")[0].length()>(precision-scale)){
							//整数部分长度超出
							String msg = String.format(CJAPIConstants.ERROR_PARAM_LENGTH_MSG,condition.name);
							throw new AppException(CJAPIConstants.ERROR_PARAM_LENGTH, msg);
						}
						if(String.valueOf(param).split("\\.").length>1) {//参数有小数位
							if(String.valueOf(param).split("\\.")[1].length()>scale){
								//小数位数过长
								String msg = String.format(CJAPIConstants.ERROR_PARAM_SCALE_MSG,condition.name);
								throw new AppException(CJAPIConstants.ERROR_PARAM_SCALE, msg);
							}
			            }
					}
				}
			}
		}
		
		// 转换成DataObject
		DataObject dataObj =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		for(Map.Entry<String, Object> entry : mapParam.entrySet()) {
			dataObj.set(entry.getKey(), entry.getValue());
		}
		
		dataObj.setString("vcInvestType", "1");//投资类型只能接取“1”（可交易）
		//转换name userid
		String vcSenderSubId = getSenderSubInfo(dataObj.getString("vcSenderSubName"),dataObj.getString("vcProductCode"));
		if(vcSenderSubId==null || vcSenderSubId==""){
			LogUtil.logError("招行接口下单人员系统参数异常，为找到对应系统参数", null, new Object[0]);
			throw new AppException();
		}else{
			dataObj.set("vcSenderSubId", vcSenderSubId);
			LogUtil.logInfo("转换后的下单人员编号为：{0}", null, vcSenderSubId);
		}
		if(dataObj.getString("vcProductCode")!=null && !"".equals(dataObj.getString("vcProductCode")) && dataObj.getString("vcCombiNo")!=null && !"".equals(dataObj.getString("vcCombiNo"))){
			Map<String, String> map = new HashMap<String, String>();
			map.put("vcProductCode", dataObj.getString("vcProductCode"));
			map.put("vcCombiNo", dataObj.getString("vcCombiNo"));
			Object[] emps =  DatabaseExt.queryByNamedSql("default", "com.cjhxfund.cjapi.CJApiCommonns.getOrgCombPrdInfo", map);
			if(emps.length==0){
				LogUtil.logError("招行接口产品组合异常，系统中未找到对应产品组合， 产品代码【{0}】，组合代码【{1}】", null, new Object[]{dataObj.getString("vcProductCode"),dataObj.getString("vcCombiNo")});
				String msg = String.format(CJAPIConstants.ERROR_NO_ORIGINAL_ORDER_MSG, dataObj.getString("vcProductCode"), dataObj.getString("vcCombiNo"));
				throw new AppException(CJAPIConstants.ERROR_NO_ORIGINAL_ORDER, msg);
			}
		}
		return dataObj;
	}
	/***
	 * 根据下单员名字查找匹配到 机器猫对应的投顾 登录用户名（userId）
	 * @param SenderSubName 下单员名字
	 * @return userid
	 */
	public static String getSenderSubInfo(String SenderSubName,String pcode){
		
		/*if(SenderSubName==null || pcode==null || SenderSubName=="" || pcode==""){
			return "";
		}
		String userId="";
		Map<String, String> map = new HashMap<String, String>();
		map.put("empname", SenderSubName);
		map.put("pcode", pcode);
		//--查找满足在人员表中、投顾组、拥有产品权限、并且人名
		Object[] emps =  DatabaseExt.queryByNamedSql("default", 
				"com.cjhxfund.cjapi.CJApiCommonns.queryUserIdByName", map);
		
		if(emps.length>0){
			DataObject emp = (DataObject)emps[0];
			userId=emp.getString("USERID");
			return userId;
		}
		//--查找满足在人员表中、投顾组、拥有产品权限第一个人       
		emps =  DatabaseExt.queryByNamedSql("default", "com.cjhxfund.cjapi.CJApiCommonns.queryUserId", map);		
		if(emps.length>0){
			DataObject emp = (DataObject)emps[0];
			userId=emp.getString("USERID");
			return userId;
		}*/
		String userId="";
		try{
			DataObject temp=(DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_GMS_API_USERID");
			if(temp!=null){
				userId=temp.getString("paramValue");
			}
		}catch(Exception e){
			LogUtil.logError("获取招行接口下单人系统参数失败！", e, new Object[0]);
			e.printStackTrace();
		}
		
		return userId;
	}
	
	/***
	 * 
	 * @param interfaceName
	 * 						需要检查参数的接口名
	 * @param json
	 * 						接收到的json数据
	 * @return errorCode
	 * 						返回码，0表示无错误
	 */
	@Bizlet("接口参数合法性检测")
	public static DataObject paramCheck(String interfaceName, String json, String entryName) throws AppException{
		if (json == null || json.isEmpty()) {
			throw new AppException(CJAPIConstants.ERROR_PARAM_NULL,CJAPIConstants.ERROR_PARAM_NULL_MSG);
		}
		if (!ParamUtil.isInit) {
			// 初始化
			ParamUtil.isInit = init();
		}
		
		Map<String, Object> mapParam = JSONUtil.jsonToMap(json);
		ArrayList<ParamCondition> listBaseParam = mapParamCondition.get(interfaceName);
		if (listBaseParam == null) {
			throw new AppException(CJAPIConstants.ERROR_PARAM_NULL,CJAPIConstants.ERROR_PARAM_NULL_MSG);
		}
		
		for (ParamCondition condition : listBaseParam) {
			Object param = mapParam.get(condition.name);
			
			if (condition.isNeed) {
				// 1. 判断参数是否缺少
				if (param == null||"".equals(param)) {
					String msg = String.format(CJAPIConstants.ERROR_PARAM_MISS_MSG,condition.name);
					throw new AppException(CJAPIConstants.ERROR_PARAM_MISS,msg);
				}
			} else {
				// 0. 可空，且为空，直接跳过；不为空则也需检测
				if(param == null||"".equals(param)){
					continue;
				} 
			}
			
			// 2. 判断参数类型是否正确
			if (!condition.type.equalsIgnoreCase(param.getClass().getSimpleName())) {
				String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,condition.name);
				throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
			}
			// 3.判断参数值长度是否超出
			Pattern pattern = Pattern.compile("[0-9]*");
			if(condition.length!=null&&!"".equals(condition.length)){//数据库VC_PARAM_LENGTH为空则不进行校验
				if ("String".equalsIgnoreCase(param.getClass().getSimpleName())){//String类型的参数
					if(pattern.matcher(condition.length).matches()){//数据库中存储的长度为数字
						if(String.valueOf(param).length()>Integer.parseInt(condition.length)){
							String msg = String.format(CJAPIConstants.ERROR_PARAM_LENGTH_MSG,condition.name);
							throw new AppException(CJAPIConstants.ERROR_PARAM_LENGTH, msg);
						}
					}
				}else if("BigDecimal".equalsIgnoreCase(param.getClass().getSimpleName())){//BigDecimal类型
					if(pattern.matcher(condition.length.split("\\,")[0]).matches()){//数据库中存储的有效位为数字
						//规定的有效位
						int precision = Integer.parseInt(condition.length.split("\\,")[0]);
						//规定的小数位数
						int scale = 0;
						if(condition.length.split("\\,").length==2&&
								pattern.matcher(condition.length.split("\\,")[1]).matches()){
							//数据库中存储的精度存在且为数字
							scale = Integer.parseInt(condition.length.split("\\,")[1]);
						}
						if(String.valueOf(param).split("\\.")[0].length()>(precision-scale)){
							//整数部分长度超出
							String msg = String.format(CJAPIConstants.ERROR_PARAM_LENGTH_MSG,condition.name);
							throw new AppException(CJAPIConstants.ERROR_PARAM_LENGTH, msg);
						}
						if(String.valueOf(param).split("\\.").length>1) {//参数有小数位
							if(String.valueOf(param).split("\\.")[1].length()>scale){
								//小数位数过长
								String msg = String.format(CJAPIConstants.ERROR_PARAM_SCALE_MSG,condition.name);
								throw new AppException(CJAPIConstants.ERROR_PARAM_SCALE, msg);
							}
			            }
					}
				}
			}
		}
		// 4.银行间二级市场下达、修改的【净价价格】【全价价格】【债券收益率】三者选其一
		//如果填入【债券收益率】则【收益率类型】必填
		//如果这三个参数中传入了超过一个，则参数不符合要求，抛出异常
		if("bankSecondOrderIssued".equals(interfaceName)
				||"bankSecondOrderModify".equals(interfaceName)){
			ArrayList<Object> list = new ArrayList<Object>();
			//参数非空则加入list中
			if(mapParam.get("enNetPrice") != null&&!"".equals(mapParam.get("enNetPrice"))){
				list.add(mapParam.get("enNetPrice"));
			}
			if(mapParam.get("enFullPrice") != null&&!"".equals(mapParam.get("enFullPrice"))){
				list.add(mapParam.get("enFullPrice"));
			}
			if(mapParam.get("enInterestRate") != null&&!"".equals(mapParam.get("enInterestRate"))){
				list.add(mapParam.get("enInterestRate"));
			}
			//三个参数不为三选一则抛出异常
			if(list.size()!= 1){
				throw new AppException( CJAPIConstants.ERROR_PRICERATE_INPUT, CJAPIConstants.ERROR_PRICERATE_INPUT_MSG);
			}else{
				//满足三选一，且传入的为【债券收益率】时，【收益率类型】则必传，否则抛异常
				if(mapParam.get("enInterestRate") != null&&!"".equals(mapParam.get("enInterestRate"))){
					if(mapParam.get("vcInterestRateType") == null
							||"".equals(mapParam.get("enInterestRate"))){
						throw new AppException( CJAPIConstants.ERROR_RATE_INPUT, CJAPIConstants.ERROR_RATE_INPUT_MSG);
					}
				}
			}
		}
		
		// 转换成DataObject
		DataObject dataObj =  DataObjectUtil.createDataObject(entryName);
		for(Map.Entry<String, Object> entry : mapParam.entrySet()) {
			dataObj.set(entry.getKey(), entry.getValue());
		}
		return dataObj;
	}
	
	/**
	 * 将传入的json字符串转换成
	 * @param 传入的json字符串参数
	 * @return
	 */
	@Bizlet("将json字符串参数转化成DataObject")
	public static DataObject paramToDataObject (String json) throws AppException{
		Map<String, Object> mapParam = JSONUtil.jsonToMap(json);
		if (mapParam == null) {
			throw new AppException(CJAPIConstants.ERROR_JSON_STRING_ILLEGAL, CJAPIConstants.ERROR_JSON_STRING_ILLEGAL_MSG);
		}
		// 转换成DataObject
		DataObject dataObj =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		for(Map.Entry<String, Object> entry : mapParam.entrySet()) {
			dataObj.set(entry.getKey(), entry.getValue());
		}
		return dataObj;
	}
	
	/***
	 * 
	 */
	@Bizlet("通知重新初始化")
	public static void reInit(){
		ParamUtil.isInit = false;
	}
	
	
	/**
	 * @Description 添加或者修改参数检测信息 
	 * @Author		liangjilong
	 * @Date		2016年11月25日 下午3:13:39
	 * @param paramCheck  页面传过来的对象.
	 * @param opType 		参数
	 * @return 		void 返回类型
	 * @throws Exception 
	 */
	@Bizlet("添加或者修改参数检测信息")
	public void saveOrUpdate(DataObject paramCheck) throws Exception{
		reInit();
		//1、实体名称路径
		String entityName="com.cjhxfund.cjapi.CJAPIData.TAtsCjapiParamCheck";
		//2、判断不为空
		if(paramCheck!=null){
			String opType = paramCheck.getString("opType");//操作类型（add/edit）
			//3、判断是操作类型
			if(!StrUtil.isEmpty(opType) && "add".equals(opType)){
				//4、创建DataObject
				DataObject dataObject = DataObjectUtil.convertDataObject(paramCheck, entityName, true);
				dataObject.set("lParamCheckId", DatabaseExt.getNextSequence("SEQ_CJAPI_PARAM_CHECK"));//获取主键
				DatabaseUtil.insertEntity(CJAPIConstants.DS_DEFAULT, dataObject);//保存信息
			}else{
				DatabaseUtil.updateEntity(CJAPIConstants.DS_DEFAULT, paramCheck);//更新信息
			}
		}
	}
	
	public static class ParamCondition{
		/**变量名*/
		public String name;
		/**变量类型*/
		public String type;
		/**是否必须*/
		public boolean isNeed;
		/**参数值长度*/
		public String length;
	}
}
