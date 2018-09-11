
package com.cjhxfund.cjapi.exchange;

import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.BaseDataUtils;
import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.ParamUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.exception.ExceptionUtil;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.cjapi.model.SecondMarketParamVo;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @Description	交易所质押式回购指令
 * @ClassName	ExchangePledgeRepoUtil
 * @author 金文轩
 * @date 2016-12-07 17:43:52
 *
 */
@Bizlet("交易所质押式回购指令")
public class ExchangePledgeRepoUtil { 
	/**是否有（有收益率和收益率类型）1代表有，2代表无	*/
	private static final String HAS_INTEREST_RATE ="2";
	
	
	/**===================================交易所质押式回购指令下达=Begin====================================================**/
	/***
	 * @Description 交易所质押式回购指令下达
	 * @Author jinwenxuan
	 * @Date 2016年12月7日 下午5:49:37 
	 * @parameter  json
	 * @throws 
	 * @return	map
	 */
	@Bizlet("交易所质押式回购指令下达")
	public static Map<String, Object> exchangePledgeRepoIssued(String json){
		String exchangePledgeRepoIssued = CJAPIConstants.EXCHANGE_PLEDGEREPO_ISSUED;
		Map<String, Object> retMap = new HashMap<String, Object>();
		boolean flag=false;
		try {
			retMap = saveOrUpdate(json, retMap, flag, true, false,true);
		} catch (AppException e) {
			//处理异常
			String errorFunc = getCurrentClassName()+exchangePledgeRepoIssued;
			String errorMsg = "交易所质押式回购指令下达,方法"+exchangePledgeRepoIssued+"出现异常，异常信息为："+e.getMsg();
			retMap = ExceptionUtil.retExceptionInfo(retMap, e, errorFunc, errorMsg);
		}
		
		return retMap;
	}
	
	/**===================================交易所质押式回购指令修改=Begin====================================================**/
	/**
	 * 
	 * @Description 交易所质押式回购指令修改
	 * @Author jinwenxuan
	 * @Date 2016年12月7日 下午6:07:58 
	 * @parameter json
	 * @throws 
	 * @return
	 */
	@Bizlet("交易所质押式回购指令修改")
	public static Map<String, Object> exchangePledgeRepoModify(String json){
		String exchangePledgeRepoModify = CJAPIConstants.EXCHANGE_PLEDGEREPO_MODIFY;
		Map<String, Object> retMap = new HashMap<String, Object>();
		boolean flag=false;
		try {
			retMap = saveOrUpdate(json, retMap, flag, false, true,true);
		} catch (AppException e) {
			//处理异常
			String errorFunc = getCurrentClassName()+exchangePledgeRepoModify;
			String errorMsg = "交易所质押式回购指令修改,方法"+exchangePledgeRepoModify+"出现异常，异常信息为："+e.getMsg();
			retMap = ExceptionUtil.retExceptionInfo(retMap, e, errorFunc, errorMsg);
		}
		return retMap;
	}
	
	
 
	/**===================================调用处理机器猫和其他逻辑代码=====================================================**/

	/**
	 *  
	 * @Description  调用处理机器猫和其他逻辑代码
	 * @Author jinwenxuan
	 * @Date 2016年12月7日 下午6:12:50 
	 * @param 		json 被检测的JSON字符串
	 * @param 		retMap返回的信息
	 * @param 		flag返回是否(true/false)
	 * @param 		excuteType执行类型/是否检测有人员姓名(add/edit)添加/更新(true/false)
	 * @param 		isAdd是否要执行更新时间(add/edit)添加/更新(true/false)
	 * @return 		Map<String,Object> 返回类型
	 * @throws 
	 */
	private static Map<String, Object> saveOrUpdate(String json, Map<String, Object> retMap, boolean flag, boolean excuteType,boolean isAdd , boolean isFirstUpd) 
			throws AppException{
		DataObject paramters = null;
		String executeTypeStr = "";
		if(excuteType){
			executeTypeStr = CJAPIConstants.EXCHANGE_PLEDGEREPO_ISSUED;
		}else{
			executeTypeStr = CJAPIConstants.EXCHANGE_PLEDGEREPO_MODIFY;
		}
		paramters = ParamUtil.paramCheck(executeTypeStr,json);//检测json
		if(StrUtil.isNotEmpty(paramters)){
			String vcSenderSubId = (String)paramters.get("vcSenderSubId");
			retMap = BaseDataUtils.checkIsExistOperator(vcSenderSubId,true);
			if(retMap.isEmpty()){
				//2、保存到本地数据库.
				try {
					saveOrUpdateInfo(paramters,executeTypeStr,true,isAdd ,isFirstUpd);
				}   catch (Exception e) {
					if(e instanceof AppException) {
						throw (AppException)e;
					} else {
						throw new AppException(CJAPIConstants.ERROR_SYSTEM, CJAPIConstants.ERROR_SYSTEM_MSG);
					}
				} 
			 
				//调用机器猫程序
				flag = invokeJQMOrderSaveOrUpdateService(paramters, excuteType, isAdd);
				//更新本地被修改的指令状态
				if(executeTypeStr.equals(CJAPIConstants.EXCHANGE_PLEDGEREPO_MODIFY)){
					String tableName = CJAPIConstants.EXCHANGE_PLEDGE_REPO_TABLE_NAME;
					String vcOrigOrdId = paramters.getString("vcOrigOrdId");
					BaseDataUtils.updateModifiedOrderStatus(tableName,vcOrigOrdId,CJAPIConstants.ORDER_STATUS_INVALID_MODIFY);
				}
			}
		}
		if(flag){
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		}
		return retMap;
	}
	
	/**
	 * 
	 * @Description 将质押式回购息保存至本地
	 * @Author jinwenxuan
	 * @Date 2016年12月7日 下午6:15:49 
	 * @param 		paramters
	 * @param 		executeType (true/false)add/edit执行动作类型
	 * @param 		isAdd是否要添加更新时间 (true/false)
	 * @throws 		Exception 异常参数
	 * @return 		void 返回类型
	 */
	private static void saveOrUpdateInfo(DataObject paramters,String execute,boolean executeType,boolean isAdd , boolean isFirstUpd) throws Exception{
		//1、实体名称路径
		String entityName="";
		String nextPledgeRepoId = CJAPIConstants.SEQ_CJAPI_E_P_REPO;
		String lBackId = CJAPIConstants.SEQ_CJAPI_E_P_REPO_BACK;
		if(execute.equals(CJAPIConstants.EXCHANGE_PLEDGEREPO_ISSUED)){
			 entityName=CJAPIConstants.EXCHANGE_PLEDGE_REPO_ENTITY_NAME;
			 if(executeType){
				 BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(paramters,entityName)); 
				 paramters.set("lExchangePledgeRepoId", DatabaseExt.getNextSequence(nextPledgeRepoId));//获取主键
			 }
			 paramters.setString("vcOrderType",  CJAPIConstants.ORDER_TYPE_ADD);//VC_ORDER_TYPE 	add-新增  edit-修改
		}else if(execute.equals(CJAPIConstants.EXCHANGE_PLEDGEREPO_MODIFY)){
			 entityName=CJAPIConstants.EXCHANGE_PLEDGE_REPO_ENTITY_NAME;
			 if(executeType){
				 BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(paramters,entityName)); 
			 }
			 ObjectParamVo objectParamVo = new ObjectParamVo(paramters,entityName,false,executeType);
			 DataObject oldData = BaseDataUtils.getOrderInfoByOrigordId(objectParamVo);//获取原指令信息
			 if(StrUtil.isEmpty(oldData)){
				 String msg = BaseDataUtils.getOrigordIdMsg(paramters);
				 throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR,msg);
			 }else{
				 if(isFirstUpd){
					 paramters.set("vcOrderStatus", CJAPIConstants.ORDER_STATUS_INVALID_AWAIT);
				 }else{
					 paramters.set("vcOrderStatus", CJAPIConstants.ORDER_STATUS_VALID);
				 }
				 paramters.setString("vcOrderType", CJAPIConstants.ORDER_TYPE_EDIT);//VC_ORDER_TYPE 	add-新增  edit-修改
				 paramters.set("vcInstructionId", paramters.getString("vcOrigOrdId"));//原指令Id，下达是没原指令Id.
				 if(executeType){
					paramters.set("lExchangePledgeRepoId",DatabaseExt.getNextSequence(nextPledgeRepoId));//获取主键
				 }
			 }	
		}else if(execute.equals(CJAPIConstants.EXCHANGE_PLEDGEREPO_FEEDBACK)){
			
			entityName=CJAPIConstants.EXCHANGE_PLEDGE_REPO_BACK_ENTITY_NAME;
			paramters.set("lBackId", DatabaseExt.getNextSequence(lBackId));//获取主键
		}
		CJAPICommonUtil.getCreateDateAndCreateTime(paramters);//获取创建日期和创建时间
		
		//反馈表无更新时间字段
		if(isAdd && (!execute.equals(CJAPIConstants.EXCHANGE_PLEDGEREPO_FEEDBACK))
				 &&(!execute.equals(CJAPIConstants.BANK_PLEDGE_TICKETINFO))){
			 CJAPICommonUtil.getUpdateDateAndUpdateTime(paramters);//获取修改日期和修改时间
		}
		
		CJAPICommonUtil.saveOrUpdate(paramters, executeType, entityName);
	}
	
	/**
	 * 
	 * @Description 调用JQM交易所质押式回购指令下达(逆回购
	 * 						调用机器猫下达和修改指令逻辑流方法
	 * @Author jinwenxuan
	 * @Date 2016年12月7日 下午6:17:05 
	 * @param 		paramters 接口参数信息
	 * @param 		executeType (true/false)add/edit执行动作类型
	 * @param 		isAdd是否要添加更新时间 (true/false)
	 * @throws 		AppException 	参数
	 * @return 		boolean 返回类型
	 */
	private static boolean invokeJQMOrderSaveOrUpdateService(DataObject paramters,boolean executeType,boolean isAdd) throws AppException{
		
		boolean flag = false;
		String componentName = CJAPIConstants.JQM_ORDER_ZNHG_COMPONENT_NAME;// 逻辑构件名称
		String operationName = "",executeMethod="";	// 逻辑流名称，执行方法
		if(executeType){
			executeMethod = CJAPIConstants.EXCHANGE_PLEDGEREPO_ISSUED;//下达指令方法
			operationName = CJAPIConstants.JQM_ZNHG_ORDER_ADD_BIZ_METHOD;//添加
			paramters.setString("msgtype","D");//指令请求消息类型：D-指令下达；F-指令撤销；G-指令修改；H-指令查询
			paramters.setString("processStatus","1");
		}else{
			executeMethod = CJAPIConstants.EXCHANGE_PLEDGEREPO_MODIFY;//指令修改方法
			operationName = CJAPIConstants.JQM_ZNHG_ORDER_UPDATE_BIZ_METHOD;//修改
			paramters.setString("msgtype","G");
		}
		paramters.setString("price","100");
		try {
			ILogicComponent logicComponent = LogicComponentFactory.create(componentName);//创建组建工程
			Object[] object = new Object[1];
			SecondMarketParamVo vo = new SecondMarketParamVo(executeType, null,  CJAPIConstants.JQM_JY_ZNHG_ENTITY_NAME, HAS_INTEREST_RATE,false);
			object[0] = BaseDataUtils.convertDataFormatToJQMZNHG(paramters,vo);// 把数据转换成机器猫识别的格式
			Object[] result = logicComponent.invoke(operationName, object);//调用逻辑流
			flag = BaseDataUtils.saveOrUpdateRetParamInfo(paramters, result,executeType==true?true:false);//处理返回参数信息
			
			saveOrUpdateInfo(paramters,executeMethod,false,isAdd,false);//保存回调信息
			 
		} catch (Throwable e) {
			flag = false;
			String error="调用方法invokeJQMOrderSaveOrUpdateService机器猫逻辑流出现异常，异常信息为:"+e.getMessage();
			LogUtil.logError(error, e);
			if(e instanceof AppException){
				throw (AppException)e;
			}else{
				throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);
			}
		}
		return flag;
	 
	}
	
	
	/**===================================调用处理机器猫和其他逻辑代码====End=================================================**/
	
	/**
	 * 
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author jinwenxuan
	 * @Date 2016年12月7日 下午6:19:12 
	 * @parameter 
	 * @throws 
	 * @return
	 */
	private static String getCurrentClassName(){
		return ExchangePledgeRepoUtil.class.getName()+".";
	}
}
 