/**
 * 
 */
package com.cjhxfund.cjapi.basicInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.common.ParamUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.exception.ExceptionUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 
 * 本模块处理基础数据
 * @author 谭凯
 * @date 2016-11-21 20:18:38
 * 
 */
@Bizlet("")
public class BasicInfoUtil {
	/**
	 * 转换属性名称
	 * 
	 * @param objs
	 *            业务字典对象
	 * @return
	 */
	@Bizlet("转换属性名称")
	public static DataObject[] convertField(DataObject[] objs) {
		// 设置值域公共字段
		for (DataObject dataObject : objs) {
			dataObject.set("vcFieldCode", dataObject.get("dictID"));
			dataObject.set("vcFieldValue", dataObject.get("dictName"));
		}
		return objs;
	}

	/**
	 * 获取查表通用值域信息
	 * 
	 * @param dictCode
	 * @return
	 */
	@Bizlet("获取查表通用类型")
	public static String concatField(String dictCode) {
		// 获取业务字典
		DataObject[] dicts = BusinessDictUtil.getDictInfoByType(dictCode);

		String queryField = "";
		// 组装查询条件
		for (DataObject dataObject : dicts) {
			queryField = queryField + dataObject.get("dictID") + ",";
		}
		if (!queryField.equalsIgnoreCase("")) {
			queryField = queryField.substring(0, queryField.length() - 1);
		}
		return queryField;
	}

	/**
	 * @Description 获取值域信息
	 * @Author		liangjilong
	 * @Date		2016年12月5日 下午6:08:39
	 * @param 		json接口方调用传过来的Json字符串
	 * @throws AppException 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("获取值域信息")
	public static Map<String, Object> queryDomainValue(String json) throws AppException  {
		Map<String, Object> retMap = new HashMap<String, Object>();

		try {
			/**
			 * 验证及转换参数
			 */
			DataObject paramters = ParamUtil.paramCheck(CJAPIConstants.BASE_QUERY_DOMAINVALUE, json);

			DataObject[] dicts = null;
			/**
			 * 获取业务字典(缓存)
			 */
			if ("D".equalsIgnoreCase(paramters.getString("vcDomainValue"))) {
				dicts = BusinessDictUtil.getDictInfoByType(paramters.getString("vcDomainCode"));
				dicts = convertField(dicts);
			}
			/**
			 * 获取业务字典(读表)
			 */
			if ("T".equalsIgnoreCase(paramters.getString("vcDomainValue"))) {
				String vcDomainCode = paramters.getString("vcDomainCode");
				if(StrUtil.isNotEmpty(vcDomainCode) && !"T_ATS_STOCK_TYPE_DEFINE".equalsIgnoreCase(vcDomainCode)){
					String paramRegMsg = CJAPIConstants.PARAM_REG_MSG;
					String msg = String.format(paramRegMsg, "vcDomainCode","T_ATS_STOCK_TYPE_DEFINE或t_ats_stock_type_define");
					throw new AppException(CJAPIConstants.PARAM_REG_CODE,msg);
				}else{
					Object [] datas = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.WSBasicInfons.queryDomainValue", paramters);
					dicts = CJAPICommonUtil.objectsToDataObjects(datas);
				}
			}
			List<Map<String, Object>> result = null;
			if(StrUtil.isNotEmpty(dicts)){
				 result = JSONUtil.objToListMap("vcFieldCode,vcFieldValue", dicts);
			}
			retMap.put("result", result);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		} catch (Exception e) {
			 
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_DOMAINVALUE, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("调用获取值域信息方法，"+CJAPIConstants.BASE_QUERY_DOMAINVALUE+"出现异常，异常信息为："+e.getMessage(), null);
		}
		return retMap;
	}
	
	/**
	 * @Description 估值查询
	 * @Author		liangjilong
	 * @Date		2016年11月28日 上午8:39:10
	 * @param 		json外部对应接口的时候传进来的Json字符串
	 * @return 		参数
	 * @return 		Map<String,Object> 返回类型
	 * @throws AppException 
	 */
	@Bizlet("估值查询")
	public static Map<String, Object> queryAppraisementInfo(String json) throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		try {
			//检测json是否合法,queryAppraisementInfo是接口名称
			DataObject paramters = ParamUtil.paramCheck(CJAPIConstants.BASE_QUERY_APPRAISEMENTINFO,json);
			//调用命名sql查询
			Object [] datas =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_SJZX,"com.cjhxfund.cjapi.WSBasicInfons.queryAppraisementInfo",paramters);
			DataObject [] list = CJAPICommonUtil.objectsToDataObjects(datas);
			List<Map<String, Object>> result=null;
			if(list!=null&&list.length>0){
				//把数据库查询出来的值转换传List
				result= JSONUtil.objToListMap("vcOrdName,vcProductCode,vcProductName,enNetAssetValue,vcValuationDate", list);
			}
			retMap.put("result", result);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
			
		} catch (Exception e) {
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_APPRAISEMENTINFO, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("调用估值查询方法，"+CJAPIConstants.BASE_QUERY_APPRAISEMENTINFO+"出现异常，异常信息为："+e.getMessage(), null);
		}
		
		return retMap;
	}
	
	
	/**
	 * @Description 新债基础信息
	 * @Author		liangjilong
	 * @Date		2016年11月28日 上午8:39:51
	 * @param 		json外部对应接口的时候传进来的Json字符串
	 * @return 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("新债基础信息")
	public static Map<String, Object> queryNewStockInfo(String json)throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		try {
			//检测json是否合法,queryNewStockInfo是接口名称
			DataObject paramters = ParamUtil.paramToDataObject(json);
			LogUtil.logInfo("新债查询接口,招行入参为："+json,null, null);
			//调用命名sql查询
			Object [] datas =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT,"com.cjhxfund.cjapi.WSBasicInfons.queryNewStockInfo",paramters);
			//数据转换
			DataObject [] list = CJAPICommonUtil.objectsToDataObjects(datas);
			List<Map<String, Object>> result=null;
			if(list!=null && list.length>0){
				//把数据库查询出来的值转换传List
				result= JSONUtil.objToListMap(getNewStockFields(), list);
			}
			LogUtil.logInfo("新债查询接口,反馈的新债数据为："+result.toString(),null, null);
			retMap.put("result", result);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		} catch (Exception e) {
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_NEWSTOCKINFO, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("调用新债基础信息方法，"+CJAPIConstants.BASE_QUERY_NEWSTOCKINFO+"出现异常，异常信息为："+e.getMessage(), null);
		}
		return retMap;
	}
	
	/**
	 * 
	 * @Description 交易对手信息
	 * @Author		liangjilong
	 * @Date		2016年11月28日 上午8:40:33
	 * @param 		json	外部对应接口的时候传进来的Json字符串
	 * @return 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("交易对手信息")
	public static Map<String, Object> queryTradeRivalInfo(String json)throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		try {
			//检测json是否合法,queryTradeRivalInfo是接口名称
			DataObject paramters = ParamUtil.paramToDataObject(json);
			//调用命名sql查询
			Object[] datas =  DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),"com.cjhxfund.cjapi.WSBasicInfons.queryTradeRivalInfo",paramters);
			//数据转换
			DataObject [] list = CJAPICommonUtil.objectsToDataObjects(datas);
			List<Map<String, Object>> result=null;
			if(list!=null && list.length>0){
				//把数据库查询出来的值转换传List
				result= JSONUtil.objToListMap("vcTradeRival,vcTradeRivalName", list);
			}
			retMap.put("result", result);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		} catch (Exception e) {
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_TRADERIVALINFO, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("调用交易对手信息方法，"+CJAPIConstants.BASE_QUERY_TRADERIVALINFO+"出现异常，异常信息为："+e.getMessage(), null);
		}
		return retMap;
	}
	
	
	/**
	 * @Description 机构组合
	 * @Author		liangjilong
	 * @Date		2016年11月28日 上午8:41:32
	 * @param 		json	外部对应接口的时候传进来的Json字符串
	 * @return 		参数
	 * @return 		Map<String,Object> 返回类型
	 * @throws AppException 
	 */
	@Bizlet("机构组合")
	public static Map<String, Object> queryOrgCombPrdInfo(String json) throws AppException
	{
		Map<String, Object> retMap = new HashMap<String, Object>();
	
		try {
			//检测json是否合法,queryOrgCombPrdInfo是接口名称
			DataObject paramters = ParamUtil.paramCheck(CJAPIConstants.BASE_QUERY_ORGCOMBPRDINFO, json);
			//调用命名sql查询
			Object[] datas =  DatabaseExt.queryByNamedSql("default","com.cjhxfund.cjapi.WSBasicInfons.queryOrgCombPrdInfo",paramters);
			//数据转换
			DataObject [] list = CJAPICommonUtil.objectsToDataObjects(datas);
			List<Map<String, Object>> result=null;
			if(list!=null && list.length>0){
				//把数据库查询出来的值转换传List
				result= JSONUtil.objToListMap("vcProductCode,vcProductName,vcCombiNo,vcCombiName", list);
			}
			retMap.put("result", result);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		} catch (Exception e) {
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_ORGCOMBPRDINFO, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("调用机构组合方法，"+CJAPIConstants.BASE_QUERY_ORGCOMBPRDINFO+"出现异常，异常信息为："+e.getMessage(), null);
		}
		
		return retMap;
	}
	
	
	/**
	 * @Description 获取新债字段.
	 * @Author		liangjilong
	 * @Date		2016年11月28日 上午11:24:33
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	public static String getNewStockFields(){
		StringBuffer buffer=new StringBuffer();//7+6+6+6+7+6+7=21+24=45
		buffer.append("cMarketNo,vcPaymentPlace,vcInterCode,vcStockCode,vcStockName,vcStockNameFull,vcStockType,");//7
		buffer.append("enExistLimite,enIssueBalance,cBondAppraise,vcBondAppraiseOrgan,lIssuerId,vcIssuerName,");//6
		buffer.append("vcIssueProperty,cIssueAppraise,vcIssueAppraiseOrgan,vcIndustry,vcProvince,lGuarantorId,");//6
		buffer.append("vcGuarantorName,vcGuarantorSummary,lIssuePostDate,lIssueBeginDate,lPayDate,lPublishDate,");//6
		buffer.append("lBegincalDate,lEndincalDate,cInterestType,cPayInterestType,enPayInteval,enFaceRate,cBidType,");//7
		buffer.append("cPayType,vcSpecialText,vcMainUnderwriter,vcDeputyUnderwriter,cUnderwriteType,vcGroupUnderwriter,");//6
		buffer.append("lNextExerciseDate,cIsSmallRaised,cIsHaveSaleback,dBidLimitTime,cIsHaveBuyback,enResaleYear,enRedemptionYear");//7
		return buffer.toString();
	}
	
	
	/**
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author		liangjilong
	 * @Date		2016年11月30日 上午9:59:29
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	public static String getCurrentClassName(){
		return BasicInfoUtil.class.getName()+".";
	}
	
	/**
	 * @Description 获取当前类名称
	 * @Author		liangjilong
	 * @Date		2016年11月30日 上午9:58:56
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	public static String getClassSimpleName(){
		return BasicInfoUtil.class.getSimpleName()+".";
	}
	
	/**
	 * @Description 根据用户Id进行查询相应的产品信息
	 * @Author		liangjilong
	 * @Date		2017年1月6日 下午2:12:30
	 * @param userId
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	@Bizlet("根据用户Id进行查询相应的产品信息")
	public static Map<String, Object> queryProductInfo(String json)throws AppException{
		/*String userId="";  //产品编码,用户ID
		Map<String, Object> retMap = new HashMap<String, Object>();
		try {
			//检测json是否合法,queryProductInfo是接口名称
			DataObject paramters = ParamUtil.paramCheck(CJAPIConstants.BASE_QUERY_PRODUCTINFO, json);
			userId = paramters.getString("userId");//获取userId信息.
			retMap = BaseDataUtils.checkIsExistOperator(userId,true);//判断是否有操作人
			List<Map<String, Object>> result = null;
			if(retMap.isEmpty()){
				List<TCombi> combiLists = ProductCombiRightUtil.getInvestAdviserInputCombiRightList(userId);
				if(StrUtil.isNotEmpty(combiLists)){
					List<DataObject> productList = new ArrayList<DataObject>();
					for(TCombi combi: combiLists){
						DataObject obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
						String vcProductCode = combi.getVcProductCode();
						String vcProductName = combi.getVcProductName();
						String vcCombiNo = combi.getVcCombiNo();
						String vcCombiName = combi.getVcCombiName();
						obj.set("vcProductCode",vcProductCode);
						obj.set("vcProductName",vcProductName);
						obj.set("vcCombiNo",vcCombiNo);
						obj.set("vcCombiName",vcCombiName);
						productList.add(obj);
					}
					result= JSONUtil.objsToListMap("vcProductCode,vcProductName,vcCombiNo,vcCombiName", productList);
				}
			}
			retMap.put("result", result);
			retMap.put("userId", userId);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		} catch (AppException e) {
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_PRODUCTINFO, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("根据用户Id进行查询相应的产品信息，"+CJAPIConstants.BASE_QUERY_PRODUCTINFO+"出现异常，异常信息为："+e.getMessage(), null);
		}
		return retMap;*/
		/**
		 * 招行目前只使用这个接口，使用查询的数据为机构组合的数据 20171201版本改造
		 */
		Map<String, Object> retMap = new HashMap<String, Object>();
		
		try {
			//检测json是否合法,queryOrgCombPrdInfo是接口名称
			DataObject paramters = ParamUtil.paramCheck(CJAPIConstants.BASE_QUERY_PRODUCTINFO, json);
			//调用命名sql查询   default
			Object[] datas =  DatabaseExt.queryByNamedSql("default","com.cjhxfund.cjapi.WSBasicInfons.queryOrgCombPrdInfo",paramters);
			//数据转换
			DataObject [] list = CJAPICommonUtil.objectsToDataObjects(datas);
			List<Map<String, Object>> result=null;
			if(list!=null && list.length>0){
				//把数据库查询出来的值转换传List
				result= JSONUtil.objToListMap("vcProductCode,vcProductName,vcCombiNo,vcCombiName", list);
			}
			retMap.put("result", result);
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		} catch (Exception e) {
			AppException ae = ExceptionUtil.exceptionDeal(getCurrentClassName()+CJAPIConstants.BASE_QUERY_ORGCOMBPRDINFO, e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			LogUtil.logError("调用机构组合方法，"+CJAPIConstants.BASE_QUERY_ORGCOMBPRDINFO+"出现异常，异常信息为："+e.getMessage(), null);
		}
		
		return retMap;
	}

}
