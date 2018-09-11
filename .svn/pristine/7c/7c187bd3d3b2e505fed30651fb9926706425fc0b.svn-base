package com.cjhxfund.cjapi.primaryMarket;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.BaseDataUtils;
import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.common.ParamUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.exception.EOSRuntimeException;
import com.google.gson.Gson;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;
@Bizlet("")
public class PrimaryOrderModify {
	private String json;
	private DataObject params;
	
	public PrimaryOrderModify(String json){
		this.json = json;
	}
	
	public String getClordId(){
		return this.params.getString("vcClordId");
	}
	
	/***
	 * 1.  记录原始参数
	 */
	public void logJson(){
		LogUtil.logInfo("[PrimaryOrderModify]一级市场指令下达接收参数：{0}", null, this.json);
	}
	
	/***
	 * 2. 解析参数
	 * @return DataObject 解析后的参数
	 * @throws AppException 
	 */
	public  DataObject parseParam() throws AppException{
		this.params = ParamUtil.paramCheck("primaryOrderModify", json);  							// 参数检测
		return this.params;
	}
	
	/***
	 * 判断指令是否可以被修改
	 * 若不可修改，抛出异常
	 */
	public boolean canModify(DataObject oldData) throws AppException{
		if (!"0".equals(oldData.getString("vcOrderStatus"))) {
			throw new AppException(CJAPIConstants.ORDER_VALID_STATUS_CODE, CJAPIConstants.ORDER_VALID_STATUS_MSG);
		}
		return true;
	}
	
	
	/***
	 * 通过原指令ID获取整条指令数据
	 * @param vcClordId
	 * @return 
	 */
	public DataObject getOrderByInstruction() throws AppException{
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put("vcClordId", this.params.get("vcOrigOrdId"));
		//调用命名sql查询
		Object[] datas = null;
		try{
			datas =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT,"com.cjhxfund.cjapi.WSPrimaryMarketns.queryPrimaryMarketByInstrunctionId",paramters);
		} catch(EOSRuntimeException e){
			LogUtil.logError("通过原指令ID获取整条指令数据错误：{0}", e, e.getMessage());
			throw new AppException(CJAPIConstants.ERROR_SYSTEM, CJAPIConstants.ERROR_SYSTEM_MSG);
		}
		
		if(datas!=null && datas.length > 0 ){
			dataObj = CJAPICommonUtil.objectsToDataObjects(datas)[0];
			return dataObj;
		} else {
			return null;
		}
	}
	
	/***
	 * 将原指令和修改的指令融合
	 * @param modifyData
	 * @param oldData
	 * @return 新的指令数据
	 */
	public void mergeOrderData(DataObject oldData){
		if (oldData == null) {
			return ;
		} 
		this.params.set("vcVersion", oldData.get("vcVersion"));
		this.params.set("vcProductCode", oldData.get("vcProductCode"));
		this.params.set("vcProductName", oldData.get("vcProductName"));
		this.params.set("vcCombiNo", oldData.get("vcCombiNo"));
		this.params.set("vcCombiName", oldData.get("vcCombiName"));
		this.params.set("vcBondName", oldData.get("vcBondName"));
		this.params.set("vcBondCode", oldData.get("vcBondCode"));
		this.params.set("vcBusinClass", oldData.get("vcBusinClass"));
		this.params.set("vcBusinType", oldData.get("vcBusinType"));
		this.params.set("vcExDestination", oldData.get("vcExDestination"));
		this.params.set("vcPaymentPlace", oldData.get("vcPaymentPlace"));
		this.params.set("vcOrderType", "edit");
		this.params.set("vcOrderStatus", oldData.get("vcOrderStatus"));
		this.params.set("vcOrderProcess", oldData.get("vcOrderProcess"));
		this.params.set("vcInvestNo", oldData.get("vcInvestNo"));
	}
	
	/***
	 * 保存修改指令
	 * @param paramters
	 * @param isAdd 新增
	 * @return 成功与否
	 * @throws Exception 
	 */
	public  DataObject paramToDB(boolean isAdd,String vcFirstClordId) throws AppException {
		try {
			String entityName = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiPMarket";   // 实体名称
			CJAPICommonUtil.getUpdateDateAndUpdateTime(this.params);	// 更新时间
			if (isAdd) {
				BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(this.params,entityName)); 
				CJAPICommonUtil.getCreateDateAndCreateTime(this.params);					// 创建时间
				this.params.set("lPrimaryMarkeId", DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_P_MARKET));
				this.params.set("vcFirstClordId", this.params.getString("vcClordId"));
				this.params =DataObjectUtil.convertDataObject(this.params, entityName, false);	
				DatabaseUtil.insertEntity(CJAPIConstants.DS_DEFAULT, this.params); 		// 保存信息
			}else {
				this.params.set("vcFirstClordId", vcFirstClordId);
				DatabaseUtil.updateEntity(CJAPIConstants.DS_DEFAULT, this.params); 	// 更新信息
			}
		} catch (Exception e) {
			throw new AppException(CJAPIConstants.ERROR_INSERT_OR_UPDATE_DATA, 
					CJAPIConstants.ERROR_INSERT_OR_UPDATE_DATA_MSG);
		}
		return this.params;
	}
	
	/***
	 * 4. 调用机器猫下达修改指令
	 * @param param
	 * @throws AppException 
	 */
	 
	public Object[] callJQM(DataObject oldData) throws AppException{
		// 准备参数
		//获取修改之前的投标金额与投标利率
		String beforeEnOrderBalance1 = this.params.getString("enOrderBalance1");
		String beforeEnPrice1 = this.params.getString("enPrice1");
		//将修改前投标金额与投标利率转为高精度浮点型(BigDecimal)
		BigDecimal  beforeEnOrderBalance2 = new BigDecimal(beforeEnOrderBalance1);
		BigDecimal  beforeEnPrice2 = new BigDecimal(beforeEnPrice1);
		//去除投标金额与投标利率后面的0
		beforeEnOrderBalance2=(beforeEnOrderBalance2 == null?new BigDecimal(0):beforeEnOrderBalance2.stripTrailingZeros());
		beforeEnPrice2=(beforeEnPrice2==null?new BigDecimal(0):beforeEnPrice2.stripTrailingZeros());
		
		//获取修改后的投标金额与投标利率
		String afterEnOrderBalance1 = oldData.getString("enOrderBalance1");
		String	afterPrice1 = oldData.getString("enPrice1");
		//将修改后投标金额与投标利率转为高精度浮点型(BigDecimal)
		BigDecimal  afterEnOrderBalance2 = new BigDecimal(afterEnOrderBalance1);
		BigDecimal  afterPrice2 = new BigDecimal(afterPrice1);
		//去除投标金额与投标利率后面的0
		afterEnOrderBalance2=(afterEnOrderBalance2==null?new BigDecimal(0):afterEnOrderBalance2.stripTrailingZeros());
		afterPrice2 = (afterPrice2==null?new BigDecimal(0):afterPrice2.stripTrailingZeros());
		
		//组装参数
		DataObject jqmParam =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");		// 机器猫所需参数
		jqmParam.set("investNo", oldData.get("vcInvestNo"));
		jqmParam.set("investcount", beforeEnOrderBalance2.toPlainString());// 修改前投标金额
		jqmParam.set("interestrate",beforeEnPrice2.toPlainString());// 修改前投标利率
		//临时方案，增加多档报量
		String str="";
		for(int i=2;i<6;i++){
			if(!"".equals(oldData.getString("enPrice"+i)) || !"".equals(oldData.getString("enOrderBalance"+i))){
				str+="报量"+i+"："+oldData.get("enPrice"+i)+",报价"+i+"："+oldData.get("enOrderBalance"+i)+";";
			}
		}
		jqmParam.set("remarks", oldData.get("vcRemark")+"；剩余报量信息【"+str+"】");	
		
		String vcSenderSubId = this.params.getString("vcSenderSubId");
		Object[] object = new Object[4];		// 机器猫接口需要3个参数
		object[0] = jqmParam;							// 申购指令
		object[1] = afterEnOrderBalance2.toPlainString();		// 修改后投标金额
		object[2] = afterPrice2.toPlainString(); 				// 修改后投标利率
		object[3] = vcSenderSubId;
		
		Object[] result = null;
		// 逻辑构件名称
		String componentName = "com.cjhxfund.jy.process.FirstGradeBond.debtInterface";
		// 逻辑流名称
		String operationName = "firstGradeBondBJXG";
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
		
		try {
			result = logicComponent.invoke(operationName, object);
		} catch (Throwable e) {
			LogUtil.logError("调用机器猫下达修改指令出现异常，异常信息为："+e.getMessage(), e);
			throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);
		}
		return result;
	}
	
	/***
	 * 5. 处理机器猫返回的结果
     * 机器猫返回结果：
	 *	returnCode  returnValue
	 *	0                     流程提交成功
	 *	1                     流程提交失败
	 *	2                     当前节点不是报量修改节点，不能修改报量  
	 * 需将机器猫的返回码转换CJAPI定义的规范码
	 * @param resultObjs
	 * @throws Exception 
	 */
	public void dealJQMResult(Object[] resultObjs,String vcClordId,String vcFirstClordId,String vcSenderSubId) throws Exception{
		String retJson =  new Gson().toJson(resultObjs[0]);
		Map<String, Object> jqmRetMap = JSONUtil.jsonToMap(retJson);				// 机器猫返回的结果
		Object returnCode = jqmRetMap.get("returnCode");
		if (returnCode == null){
			throw new AppException(CJAPIConstants.STATUS_JQM_ORDER_ERROR, CJAPIConstants.STATUS_JQM_ORDER_ERROR_MSG);
		}else if ("0".equals(returnCode)) {
			this.params.set("vcOrderStatus", PrimaryMarketUtil.ORDER_STATUS_VALID);
		}else if ("2".equals(returnCode)) {
			updatePrimaryMarketStatusByClordId(vcClordId,vcFirstClordId,false);
			throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_PRICE_ERROR, CJAPIConstants.STATUS_JQM_MODIFY_PRICE_ERROR_MSG);
		}else if ("7".equals(returnCode)) {
			updatePrimaryMarketStatusByClordId(vcClordId,vcFirstClordId,true);
			String msg =String.format( CJAPIConstants.CURRENT_USER_NOT_IN_WORKFLOW_NODE_MSG, vcSenderSubId);
			throw new AppException(CJAPIConstants.CURRENT_USER_NOT_IN_WORKFLOW_NODE_CODE, msg);
		} else
			throw new AppException(CJAPIConstants.STATUS_JQM_ORDER_ERROR, CJAPIConstants.STATUS_JQM_ORDER_ERROR_MSG);
	}

	/**
	 * @Description 根据主键ID进行更新
	 * @Author		liangjilong
	 * @Date		2017年3月8日 下午5:30:14
	 * @param vcClordId 		参数
	 * @param vcFirstClordId
	 * @param isUpdate(true/false) true表示修改之前查询指令留痕状态为(0)的信息为无效(-1)
	 * @return 		void 返回类型
	 * 
	 */
	private void updatePrimaryMarketStatusByClordId(String vcClordId,String vcFirstClordId,boolean isUpdate) {
		DataObject object = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		CJAPICommonUtil.getUpdateDateAndUpdateTime(object);	// 更新时间
		object.set("vcClordId", vcClordId);
		object.set("vcFirstClordId", vcFirstClordId);
		if(isUpdate){
			object.set("vcOrderStatus", PrimaryMarketUtil.ORDER_STATUS_UNKNOW);
		}
		DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.WSPrimaryMarketns.updatePrimaryMarketStatusByClordId", object);
	}
	
	 
	
	/***
	 * 
	 * 将原指令置为修改-废弃状态
	 * 注意：此函数会修改传入的DataObject
	 * @param oldData
	 */
	public void abandonOldOrder(DataObject oldData){
		CJAPICommonUtil.getUpdateDateAndUpdateTime(oldData);	// 更新时间
		oldData.set("vcOrderStatus", PrimaryMarketUtil.ORDER_STATUS_INVALID_MODIFY);
		DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.WSPrimaryMarketns.updatePrimaryMarketStatus", oldData);
	}
}
