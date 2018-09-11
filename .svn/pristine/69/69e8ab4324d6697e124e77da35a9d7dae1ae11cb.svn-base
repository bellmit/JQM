package com.cjhxfund.cjapi.primaryMarket;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.BaseDataUtils;
import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.DomainValueTrans;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.common.ParamUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/***
 * 一级市场指令下达
 * @author luwenxing
 *
 */
@Bizlet("")
public class PrimaryOrderIssued {
	private String json;
	private DataObject params;
	
	/**非可转债*/
	private static final String NONE_CONVERTIBLE_BOND="1";
	public PrimaryOrderIssued(String json){
		this.json = json;
	}
	/***
	 * 1.  记录原始参数
	 */
	public void logJson(){
		LogUtil.logInfo("[primaryOrderIssued]一级市场指令下达接收参数：{0}", null, this.json);
	}
	
	/***
	 * 2. 解析参数
	 * @return DataObject 解析后的参数
	 * @throws AppException 
	 */
	public  DataObject parseParam() throws AppException{
		this.params = ParamUtil.paramCheck("primaryOrderIssued", json);  							// 参数检测
		this.params.set("vcOrderType", CJAPIConstants.ORDER_TYPE_ADD);						//	新增指令
		this.params.set("vcOrderStatus", PrimaryMarketUtil.ORDER_STATUS_UNKNOW); 	    // 未知状态
		this.params.set("vcOrderProcess", PrimaryMarketUtil.ORDER_PROCESS_START); 	    // 未知状态
		return this.params;
	}
	
	/***
	 * 3. 参数入库
	 * @param param DataObject 解析后的参数
	 * @throws AppException 
	 */
	public DataObject orderToDB(boolean isAdd) throws Exception{
		String entityName = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiPMarket";
		CJAPICommonUtil.getUpdateDateAndUpdateTime(this.params);					// 更新时间
		if (isAdd) {
			BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(this.params,entityName)); 
			CJAPICommonUtil.getCreateDateAndCreateTime(this.params);					// 创建时间
			this.params.set("lPrimaryMarkeId", DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_P_MARKET));
			this.params.set("vcFirstClordId", this.params.getString("vcClordId"));
			this.params =DataObjectUtil.convertDataObject(this.params, entityName, true);	
			DatabaseUtil.insertEntity(CJAPIConstants.DS_DEFAULT, this.params); 		// 保存信息
		} else {
			DatabaseUtil.updateEntity(CJAPIConstants.DS_DEFAULT, this.params); 	// 更新信息
		}
		return this.params;
	}
	
	/***
	 * 4. 调用机器猫下达指令
	 * @param param
	 * @throws AppException 
	 */
	 
	public Object[] callJQM() throws AppException{
		/** 调用机器猫接口*/
		Object[] result = null;
		// 逻辑构件名称
		String componentName = "com.cjhxfund.jy.process.FirstGradeBond.debtInterface";
		// 逻辑流名称
		String operationName = "addCfJyBusinessBoneTable";
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		// 逻辑流的输入参数
		Map<String, Object> toJqmParams = convertToJQMParams(this.params);
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		for(Map.Entry<String, Object> entry : toJqmParams.entrySet()) {
			dataObj.set(entry.getKey(), entry.getValue());
		}
		String vcSenderSubId = this.params.getString("vcSenderSubId");
		
		Object[] object = new Object[3];		// 机器猫接口需要3个参数
		object[0] = dataObj;							// 申购指令
		object[1] = PrimaryOrderIssued.NONE_CONVERTIBLE_BOND;			// 限定为非可转债
		object[2] = vcSenderSubId;
		
		try {
			result = logicComponent.invoke(operationName, object);
		} catch (Throwable e) {
			LogUtil.logError("调用机器猫下达指令出现异常，异常信息为："+e.getMessage(), e);
			throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);
		}
		return result;
	}
	
	/***
	 * 5. 处理机器猫返回的结果。
	 * 机器猫返回结果：
	 * 0: 下单成功
	 * 1: 下单失败
	 * 需将机器猫的返回码转换CJAPI定义的规范码
	 * @param resultObjs
	 * @throws Exception 
	 */
	public void dealJQMResult(Object[] resultObjs) throws AppException{
		try {
			String retJson =  new Gson().toJson(resultObjs[0]);
			Map<String, Object> jqmRetMap = JSONUtil.jsonToMap(retJson);	// 机器猫返回的结果
			if (jqmRetMap.containsKey("returnCode") && jqmRetMap.get("returnCode")!=null && "0".equals(jqmRetMap.get("returnCode"))) {
				this.params.set("vcInvestNo", jqmRetMap.get("investNo"));
				this.params.set("vcOrderProcess", PrimaryMarketUtil.ORDER_PROCESS_START);
				this.params.set("vcOrderStatus", PrimaryMarketUtil.ORDER_STATUS_VALID);
			} else {
				throw new AppException(CJAPIConstants.STATUS_JQM_ORDER_ERROR, CJAPIConstants.STATUS_JQM_ORDER_ERROR_MSG);
			} 
		} catch (Exception e) {
			LogUtil.logError("处理机器猫返回的结果出现异常，异常信息为："+e.getMessage(), e);
			if(e instanceof AppException) {
				throw (AppException)e;
			} else {
				throw new AppException(CJAPIConstants.ERROR_JQM_RETURN_PARAM, CJAPIConstants.ERROR_JQM_RETURN_PARAM_MSG);
			}
		}
	}
	
	
	/***
	 * 一级市场指令下达 转换成机器猫所需要的参数格式
	 * @param orderName 接口名称
	 * @param inParam	输入参数
	 * @return	转换后的参数
	 * @throws AppException
	 */
	private Map<String, Object> convertToJQMParams(DataObject inParam) throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("processDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));			// 业务时间。用当前日期
		retMap.put("combProductCode", inParam.get("vcProductCode"));			// 产品代码
		retMap.put("combProductName", inParam.get("vcProductName"));			// 产品名称
		retMap.put("vcCombiNo", inParam.get("vcCombiNo"));						// 组合编号
		retMap.put("vcCombiName", inParam.get("vcCombiName"));			// 组合名称
		retMap.put("investProductCode", inParam.get("vcBondCode"));			// 债券代码
		retMap.put("investProductName", inParam.get("vcBondName"));			// 债券名称
		retMap.put("interestrate", inParam.get("enPrice1"));							// 投标利率
		retMap.put("investcount", inParam.get("enOrderBalance1"));			// 投标金额
		String vcPaymentPlace = DomainValueTrans.domainValueTrans("vcPaymentPlace",  inParam.getString("vcPaymentPlace"));	// 交易场所
		if(!StrUtil.isEmpty(vcPaymentPlace)){
			retMap.put("paymentplace", vcPaymentPlace);			
		}else{
			retMap.put("paymentplace", "99");//找不到就给默认值其他
		}
		String vcStockType = DomainValueTrans.domainValueTrans("T_ATS_STOCK_TYPE", inParam.getString("vcStockType"));	// 债券类型
		if(StrUtil.isEmpty(vcStockType)){
			retMap.put("investcategory", "99");	//找不到默认其他类型（99）
			/*String businessTypeMsg = CJAPIConstants.BUSINESS_TYPE_MSG;
			String msg = String.format(businessTypeMsg, "vcStockType等于"+inParam.getString("vcStockType"));
			throw new AppException(CJAPIConstants.BUSINESS_TYPE_CODE, msg);*/
		}else{
			retMap.put("investcategory", vcStockType);		
		}
		
		if(!StrUtil.isEmpty(inParam.get("enExistLimite"))){
			retMap.put("categorydate", inParam.get("enExistLimite"));			// 发行期限(年)
		}else{
			retMap.put("categorydate", 0);			// 发行期限(年)
		}
		
		if(!StrUtil.isEmpty(inParam.get("enIssueBalance"))){
			retMap.put("issueSize", inParam.get("enIssueBalance"));			   // 发行额度(万元)
		}else{
			retMap.put("issueSize", 0);			   // 发行额度(万元)
		}
		
		//临时方案，增加多档报量
		String str="";
		for(int i=2;i<6;i++){
			if(inParam.getString("enPrice"+i)!=null || inParam.getString("enOrderBalance"+i)!=null){
				str+="报量"+i+"："+inParam.get("enOrderBalance"+i)+",报价"+i+"："+inParam.get("enPrice"+i)+";";
			}
		}
		///String str="报量2："+inParam.get("enPrice2")+",报价2："+inParam.get("enOrderBalance2")+";"+"报量3："+inParam.get("enPrice3")+",报量3："+inParam.get("enOrderBalance3");
		
		if(str!=""){
			if(inParam.getString("vcRemark")==null || inParam.getString("vcRemark")=="null" || inParam.getString("vcRemark")==""){
				retMap.put("remarks","剩余报量信息【"+str+"】");
			}else{
				retMap.put("remarks", inParam.getString("vcRemark")+"：剩余报量信息【"+str+"】"); // 备注
			}
		}else{
			retMap.put("remarks", (inParam.getString("vcRemark")));
		}
		
		return retMap;
	}
 
}
