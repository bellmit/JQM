package com.cjhxfund.cjapi.common;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.exception.ExceptionUtil;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.cjapi.primaryMarket.PrimaryMarketUtil;
import com.cjhxfund.commonUtil.Constants;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.common.transaction.ITransactionDefinition;
import com.eos.common.transaction.ITransactionManager;
import com.eos.common.transaction.TransactionManagerFactory;
import com.eos.das.entity.criteria.CriteriaType;
import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.data.datacontext.UserObject;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.primeton.ext.common.muo.MUODataContextHelper;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @Description	公共指令操作
 * @ClassName	CommOperatorUtil
 * @Date		2016年12月8日 上午10:28:59
 * @Author		liangjilong
 * @Copyright (c) All Rights Reserved, 2016.
 */
@Bizlet("公共指令操作")
@SuppressWarnings("all")
public class CommOperatorUtil {
	 
	/**
	 * ===========================指令/建议流程处理状态： ===========================
	 */
	/**6-后台已成交确认完成*/
	private static final int ORDER_PROCESS_STATUS_AMDIND_CONFIRM_END_CODE = 6;
 
	/**该指令/建议后台已成交，不能再做任何操作*/
	private static final String ORDER_OR_SUGGEST_AMDIN_DEAL_DONE_MSG ="该指令/建议后台已成交，不能再做任何操作";
	
	/**1、一级市场指令 2、 银行间二级市场指令 3、 银行间质押式回购指令  4、 交易所二级市场指令 5 、交易所质押式回购指令*/
	private static final int ORDER_TYPE_CODE1 = 1;
	private static final int ORDER_TYPE_CODE2 = 2;
	private static final int ORDER_TYPE_CODE3 = 3;
	private static final int ORDER_TYPE_CODE4 = 4;
	private static final int ORDER_TYPE_CODE5 = 5;
	
	/**业务类别，04-银行间质押式逆回购,22-交易所逆回购*/
	private static final String ORDER_PROCESS_TYPE_CODE3 = "03";
	private static final String ORDER_PROCESS_TYPE_CODE4 = "04";
	private static final String ORDER_PROCESS_TYPE_CODE21 = "21";
	private static final String ORDER_PROCESS_TYPE_CODE22 = "22";
	
	/**交易所，01-银行间,02-上交所固收平台 ,03-深交所综合协议平台|上交所大宗*/
	private static final String ORDER_TRADING_PLACE_CODE1 = "01";
	private static final String ORDER_TRADING_PLACE_CODE2 = "02";
	private static final String ORDER_TRADING_PLACE_CODE3 = "03";
	/**订单操作类型：1废弃，2确认*/
	private static final String ORDER_OPTYPE_CODE1 = "1";
	private static final String ORDER_OPTYPE_CODE2 = "2";
	
	
	/**
	 *1、根据vcOrigOrdId 要撤销的指令编号
	 *2、根据第一步获取，交易状态（0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回,1202-下单失败)）和processId
	 *3、调用逻辑流getProcessStatus_ZQMM/getProcessStatus_ZNHG
	 *4、根据第三步调用逻辑流处理processStatus(指令流程状态)
	 *5、再调用逻辑流getProcessStatus_ZQMM/getProcessStatus_ZNHG，提交之前再次实时查询指令单有效状态，
	 *   避免用户在操作界面停留时间太长导致界面数据状态与数据库不一致
	 *6、 若指令单有效，则继续执行
	 *7、处理逻辑流JY_ZQMM_delete/JY_ZNHG_delete进行废弃
	 * @Description 指令撤销
	 * @Author		liangjilong
	 * @Date		2016年12月8日 上午10:40:36
	 * @param 		json调用方传过来的字符串
	 * @throws 		AppException 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("指令撤销")
	public static Map<String, Object> orderCancel(String json) throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		try {
			retMap = retOrderCancelInfo(json, retMap);
		} catch (AppException e) {
			//处理异常
			String errorFunc = getCurrentClassName()+CJAPIConstants.COMMON_ORDER_CANCEL;
			String errorMsg = "指令撤销,"+CJAPIConstants.COMMON_ORDER_CANCEL+"方法出现异常，异常信息为："+e.getMsg();
			retMap = ExceptionUtil.retExceptionInfo(retMap, e, errorFunc, errorMsg);
	   }
		return retMap;
	}

	/**
	 * @Description 指令状态反馈
	 * @Author		jinwenxuan
	 * @Date		2016年12月26日 下午13:50:59
	 * @param		json调用方传过来的字符串
	 * @throws AppException 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("指令状态反馈")
	public static String orderState(Object param) throws AppException{
		String request = "{}";
		Map<String,Object> map = new HashMap<String,Object>();
		String requestJson = null;
		if(param instanceof Map){
			request = JSONUtil.mapToJson((Map<String,Object>)param);
		}else if(param instanceof DataObject){
			if(param!=null){
				map = JSONUtil.objToMap(
						"vcClordId,vcOrigOrdId,vcIsBidCfg,vcOperatorState", ((DataObject)param));
				if("".equals(map.get("vcClordId"))){
					map.put("vcClordId",null);
				}
				if("".equals(map.get("vcOrigOrdId"))){
					map.put("vcOrigOrdId",null);
				}
				if("".equals(map.get("vcIsBidCfg"))){
					map.put("vcIsBidCfg",null);
				}
				if("".equals(map.get("vcOperatorState"))){
					map.put("vcOperatorState",null);
				}
				request = JSONUtil.mapToJson(map);
			}
		}
		requestJson = JSONUtil.jsonToJSON(request, "request");
		//String requestJson ="{\"request\":"+request+"}";
		LogUtil.logInfo(requestJson,null);
		return requestJson;
	}
	
	/**
	 * @Description 指令状态反馈（废弃指令用）
	 * @Author		jinwenxuan
	 * @Date		2017年2月07日 下午15:50:59
	 * @param		json调用方传过来的字符串
	 * @throws AppException 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("指令状态反馈（废弃指令用）")
	public static String orderStateWhenObsoletingInstruction(Object param) throws AppException{
		String request = "{}";
		Map<String,Object> map = new HashMap<String,Object>();
		String requestJson = null;
		if(param instanceof Map){
			request = JSONUtil.mapToJson((Map<String,Object>)param);
		}else if(param instanceof DataObject){
			if(param!=null){
				map = JSONUtil.objToMap(
						"vcClordId,vcOrigOrdId,vcSenderSubId,vcSenderSubName,vcRetCode,vcRetMsg", 
						((DataObject)param));
				if("".equals(map.get("vcClordId"))){
					map.put("vcClordId",null);
				}
				if("".equals(map.get("vcOrigOrdId"))){
					map.put("vcOrigOrdId",null);
				}
				if("".equals(map.get("vcSenderSubId"))){
					map.put("vcSenderSubId",null);
				}
				if("".equals(map.get("vcSenderSubName"))){
					map.put("vcSenderSubName",null);
				}
				if("".equals(map.get("vcRetCode"))){
					map.put("vcRetCode",null);
				}
				if("".equals(map.get("vcRetMsg"))){
					map.put("vcRetMsg",null);
				}
				request = JSONUtil.mapToJson(map);
			}
		}
		requestJson = JSONUtil.jsonToJSON(request, "request");
		LogUtil.logInfo(requestJson,null);
		return requestJson;
	}
	/**
	 * 获取下单人员编号
	 * @param vcSenderSubName 指令下达人员姓名
	 * @param vcOrigOrdId 要撤销的指令编号
	 * @param enOrderType 1、一级市场指令 2、 银行间二级市场指令 3、 银行间质押式回购指令  4、 交易所二级市场指令 5 、交易所质押式回购指令
	 */
	public static String getSenderSubId(String vcSenderSubName,String vcOrigOrdId,String enOrderType){
		
		if(!"".equals(vcOrigOrdId) && !"".equals(enOrderType)){
			String sqlx="",vcPordCode="",vcSenderSubId="";
			
			if(enOrderType.equals("1.0")){//1、一级市场指令 
				sqlx="queryPProdcode";
			}else if(enOrderType.equals("2.0")){//2、 银行间二级市场指令
				sqlx="queryBSProdcode";
			}else if(enOrderType.equals("3.0")){//3、 银行间质押式回购指令
				sqlx="queryBPProdcode";
			}else if(enOrderType.equals("4.0")){//4、 交易所二级市场指令 
				sqlx="queryESProdcode";
			}else if(enOrderType.equals("5.0")){//5 、交易所质押式回购指令
				sqlx="queryEPProdcode";
			}else{
				return "";
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("vcOrigOrdId", vcOrigOrdId);
			//--根据第三方指令编号 查找产品代码
			Object[] objs =  DatabaseExt.queryByNamedSql("default","com.cjhxfund.cjapi.CJApiCommonns."+sqlx, map);
			
			if(objs.length<1){
				return "";
			}
			
			//取第一个数据
			DataObject obj = (DataObject)objs[0];
			String vcProductCode=obj.getString("VC_PRODUCT_CODE");
			
			if("".equals(vcProductCode)){
				return "";
			}
			
			//根据下单人员姓名和 产品代码获取 下单人员编号
			vcSenderSubId=ParamUtil.getSenderSubInfo(vcSenderSubName,vcProductCode);
			
			if("".equals(vcSenderSubId)){
				return "";
			}
			return vcSenderSubId;
			
		}
		return "";
	}
	/**
	 * 
	 * @Description 返回订单撤销的信息
	 * @Author		liangjilong
	 * @Date		2016年12月9日 下午2:38:37
	 * @param json
	 * @param retMap
	 * @return
	 * @throws AppException 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	private static Map<String, Object> retOrderCancelInfo(String json, Map<String, Object> retMap) throws AppException {
		DataObject paramters =  ParamUtil.paramCheck(CJAPIConstants.COMMON_ORDER_CANCEL,json);//检测json
		//必须在没改变paramters之前进行获取vcSenderSubId和vcSenderSubId
		String vcSenderSubId = (String)paramters.get("vcSenderSubId");//推送人Id(userId)
		String origordId = (String)paramters.get("vcOrigOrdId");//原指令Id
		
		String cjapiEntityName= getParamterNames(paramters)[0];//动态查询的实体
		String jqmEntityName= getParamterNames(paramters)[1];//动态查询的实体
		
		String enOrderType1 = paramters.getString("enOrderType");//操作类型
		String vcSenderSubName = paramters.getString("vcSenderSubName");//下单人员名册
		vcSenderSubId=getSenderSubId(vcSenderSubName, origordId, enOrderType1);//获取下单人员编号
		LogUtil.logInfo("撤销指令转换后的下单人员编号为：{0},第三方编号为：{1}", null, vcSenderSubId,origordId);
		retMap = BaseDataUtils.checkIsExistOperator(vcSenderSubId,true);//判断是否有操作人,需要的时候把false改成true即可
		
		DataObject jqmBoneObject = null;
		if(retMap.isEmpty()){
			//2、处理实体名称
			BigDecimal enOrderType = paramters.getBigDecimal("enOrderType");
			int orderType = enOrderType.intValue();
			
			//3 (1是处理一级市场)
			if(orderType==ORDER_TYPE_CODE1){
				//、根据vcOrigOrdId 要撤销的指令编号,获取到旧数据
				ObjectParamVo objectParamVo = new ObjectParamVo(paramters,cjapiEntityName,true,true);//设参数
				DataObject oldData =  BaseDataUtils.getOrderInfoByVcOrigOrdId(objectParamVo);//获取原指令信息
				if(!StrUtil.isEmpty(oldData)){
					oldData.setString("investNo", oldData.getString("vcInvestNo"));//获取投资编号转换成jqm使用的变量
					Object paramObjs [] = new Object[]{oldData};
					String componentName = "com.cjhxfund.jy.process.FirstGradeBond.debtInterface";//路径
					Object [] resultObjs = GenericBaseDaoSupport.invokeBizMethod(componentName, "getDateObject", paramObjs);//jqm
					if("0".equals(oldData.getString("vcOrderStatus"))){
						String vcOrderProcess = oldData.getString("vcOrderProcess");//订单流程
						String investNo =  oldData.getString("vcInvestNo");//投资编号
						//判断状态，vcOrderProcess实体默认为-1
						if (oldData.isSet("vcOrderProcess") && StrUtil.isNotEmpty(vcOrderProcess)) {
							int orderProcessCode =  StrUtil.toInteger(vcOrderProcess);
							DataObject object = (DataObject)resultObjs[2];
							String activityDefID = object.getString("activityDefID");//流程节点Id
							if(orderProcessCode >= PrimaryMarketUtil.ORDER_PROCESS_BID_COMFIRM_RESULT 
									&&((activityDefID == "manualActivity9" ||  activityDefID == "manualActivity10" || activityDefID == "manualActivity12" 
									|| activityDefID == "manualActivity14"))){
								throw new AppException(CJAPIConstants.ORDER_PROCESS_BID_COMFIRM_RESULT_CODE, 
										CJAPIConstants.ORDER_PROCESS_BID_COMFIRM_RESULT_MSG);
							}else{
								String jqmBoneTableEntity="com.cjhxfund.jy.process.FirstGradeBond.CfJyBusinessBoneTable";//实体路径
								String vals [] = new String [] {investNo};//投资编号
								String keys [] = new String [] {"investproductnum"};//投资编号
								DataObject [] jqmBusinessBoneTableList = CJAPICommonUtil.checkExistOrderByDynamicParamter(vals,keys,new String []{"="},jqmBoneTableEntity);
								if(StrUtil.isNotEmpty(jqmBusinessBoneTableList)){
									jqmBoneObject = jqmBusinessBoneTableList[0];
									for(int k = 0 ; k<jqmBusinessBoneTableList.length;k++){
										if(jqmBusinessBoneTableList[k].getInt("btId") > jqmBoneObject.getInt("btId")){
											jqmBoneObject = jqmBusinessBoneTableList[k];
										}
									}
									if(StrUtil.isNotEmpty(jqmBoneObject)){
										//指令单状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
										Long validStatus = jqmBoneObject.getLong("validStatus");//状态
										if(validStatus!=null && (validStatus==1||validStatus==4)){
											//撤销失败，该指令[%s]无效不能撤销;
											String msg = String.format(CJAPIConstants.ORDER_CANCEL_FAIL_RET_MSG1,origordId);
											LogUtil.logError(msg, null, null, null);
											throw new AppException(CJAPIConstants.ORDER_CANCEL_FAIL_RET_CODE1,msg);
										}else if(validStatus!=null &&(validStatus==2)){
											//撤销失败，该指令[%s]已经撤销
											String msg = String.format(CJAPIConstants.CANCLE_FAIL_MSG_WHEN_ALREADY_CANCELED,origordId);
											LogUtil.logError(msg, null, null, null);
											throw new AppException(CJAPIConstants.CANCLE_FAIL_CODE_WHEN_ALREADY_CANCELED,msg);
										}else if(validStatus==0 ||validStatus==3){
											//0 and 3
											//调用机器猫的废弃逻辑处理,一级债市场是没有enProcessId这个流程主键Id,处理断机
											if(!StrUtil.isEmpty(investNo)){
												retMap = invokePrimaryMarketCancleOrderInfo(investNo,paramters,oldData,retMap);
											}else{
												//缺少investNo也报废弃失败
												LogUtil.logError("指令废弃接口操作失败,InvestNo参数在机器猫废弃接口是必要条件", null, null, null);
												throw new AppException(CJAPIConstants.ORDER_CANCLE_ERROR_CODE,CJAPIConstants.ORDER_CANCLE_ERROR_MSG);
											}
										}
									}
								}
							}
						}
					}else{
						//api
						String msg = String.format(CJAPIConstants.CANCLE_FAIL_MSG_WHEN_ALREADY_CANCELED,origordId);
						LogUtil.logError(msg, null, null, null);
						throw new AppException(CJAPIConstants.CANCLE_FAIL_CODE_WHEN_ALREADY_CANCELED,msg);
					}
				}else{
					//api
					String msg = String.format(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR_MSG,origordId);
					LogUtil.logError(msg, null, null, null);
					throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR,msg);
				}
				
			//4 (2~5是处理银行间和交易所业务代码)
			} else if(orderType==ORDER_TYPE_CODE3||orderType==ORDER_TYPE_CODE5){
				ObjectParamVo objectParamVo = new ObjectParamVo(paramters,cjapiEntityName,true,true);//设参数
				DataObject oldData =  BaseDataUtils.getOrderInfoByVcOrigordId(objectParamVo);//获取原指令信息
				if(retMap.isEmpty() && StrUtil.isNotEmpty(oldData) && StrUtil.isNotEmpty(oldData.get("enProcessId"))){
					if("0".equals(oldData.getString("vcOrderStatus"))){
						DataObject jqmDataObj = DataObjectUtil.createDataObject(jqmEntityName);
						CriteriaType criteriaType =CriteriaType.FACTORY.create();
						criteriaType.set_entity(jqmEntityName);//设置动态的实体
						criteriaType.set("_expr[1]/investProductNum", paramters.get("vcInvestNo"));
						criteriaType.set("_expr[2]/validStatus", "0");
						int retCount = DatabaseUtil.expandEntityByCriteriaEntity("default", criteriaType, jqmDataObj);
						//String vcOrderProcess = oldData.getString("vcOrderProcess");//订单流程
						//String investNo =  oldData.getString("vcInvestNo");//投资编号
						//2、根据主键进行查询------begin
						//jqmDataObj.set("processId", oldData.get("enProcessId"));
						//int retCount = DatabaseUtil.expandEntity(CJAPIConstants.DS_DEFAULT, jqmDataObj);
						Long validStatus = jqmDataObj.getLong("validStatus");
						//根据主键进行查询------end
						if(retCount>0 && validStatus==0){
							//4、调用逻辑流invokeJQMBizService
							retMap = invokeJQMBizService(paramters, jqmDataObj.getLong("processId"));
							if(retMap.containsKey("vcRetCode")){
								Integer vcRetCode =(Integer) retMap.get("vcRetCode");
								if(vcRetCode!=null && vcRetCode.equals(0)){
									oldData.set("vcClordId", origordId);
									updateOrderInfoStatus(oldData);
								}
							}else{
								LogUtil.logError("指令废弃接口操作失败,vcRetCode参数在机器猫无返回信息", null, null, null);
								//防止机器猫接口误改不返回vcRetCode,也返回为废弃接口失败提示
								throw new AppException(CJAPIConstants.ORDER_CANCLE_ERROR_CODE,CJAPIConstants.ORDER_CANCLE_ERROR_MSG);
							}
						}else{
							//jqm表找不到原指令
							LogUtil.logError("撤销失败，原指令origordId["+origordId+"]已被撤销", null, null, null);
							throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, BaseDataUtils.getOrigordIdMsg(paramters));//找不到对应有效指令
						}
					}else{
						//api留痕表找不到原指令
						String msg = String.format(CJAPIConstants.CANCLE_FAIL_MSG_WHEN_ALREADY_CANCELED,origordId);
						LogUtil.logError(msg, null, null, null);
						throw new AppException(CJAPIConstants.CANCLE_FAIL_CODE_WHEN_ALREADY_CANCELED,msg);
					}
				}else{
					//api
					String msg = String.format(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR_MSG,origordId);
					LogUtil.logError(msg, null, null, null);
					throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, msg);
				}
			}else if(orderType==ORDER_TYPE_CODE2||orderType==ORDER_TYPE_CODE4){//对接新二级债指令撤销
				retMap = newSecondOrderCancel(paramters,cjapiEntityName);
			}else{
				String businessTypeMsg = String.format(CJAPIConstants.BUSINESS_TYPE_MSG,"enOrderType等于"+orderType+"和 vcOrigOrdId等于"+origordId);
				throw new AppException(CJAPIConstants.BUSINESS_TYPE_CODE, businessTypeMsg);
			}
		}
		return retMap;
	}
	
	/**
	 * @Description 新二级债指令撤销（回购业务）
	 * @Author		刘玉龙
	 * @Date		2017年1月6日 下午5:26:06
	 * @param investNo 		投资编号
	 * @param paramters     传过来Json的参数
	 * @param retMap        返回的Map对象
	 * @param oldData       根据之前的信息更新废弃信息状态.
	 * @throws AppException 
	 */
	private static  Map<String, Object> newSecondOrderCancel(DataObject paramters, String cjapiEntityName) throws AppException{
		ITransactionManager txManager = TransactionManagerFactory.getTransactionManager();
		txManager.begin(ITransactionDefinition.PROPAGATION_REQUIRED, ITransactionDefinition.ISOLATION_DEFAULT);
		ObjectParamVo objectParamVo = new ObjectParamVo(paramters,cjapiEntityName,true,true);//设参数
		try{
			DataObject oldData =  BaseDataUtils.getOrderInfoByVcOrigordId(objectParamVo);
			if(StrUtil.isNotEmpty(oldData) && StrUtil.isNotEmpty(oldData.get("vcInvestNo"))){
				DataObject srcInstruct = DataObjectUtil.createDataObject(CJAPIConstants.JQM_JY_XQJY_ENTITY_NAME);
				CriteriaType criteriaType =CriteriaType.FACTORY.create();
				criteriaType.set_entity(CJAPIConstants.JQM_JY_XQJY_ENTITY_NAME);//设置动态的实体
				criteriaType.set("_expr[1]/lResultNo", paramters.get("vcInvestNo"));
				criteriaType.set("_expr[2]/cIsValid", "1");
				int result = DatabaseUtil.expandEntityByCriteriaEntity("default", criteriaType, srcInstruct);
				Object[] results = null;
				if(result==1){
					if(!"8".equals(srcInstruct.getString("vcProcessStatus")) || !"9".equals(srcInstruct.getString("vcProcessStatus"))){
						Map<String, Object> userMap = new HashMap<String, Object>();
						UserObject userObject = new UserObject();
						userMap.put("EXTEND_USER_ID", paramters.getString("vcSenderSubId"));//用户账号
						Object[] emps =  DatabaseExt.queryByNamedSql("default", "com.cjhxfund.cjapi.CJApiCommonns.queryEmpIdByUserid", userMap);
						DataObject emp = (DataObject) emps[0];
						userObject.setUserId(emp.getString("EMPID"));//用户编号
						userObject.setUserOrgId(emp.getString("ORGID"));//组织机构编号
						userObject.setAttributes(userMap);
						userObject.setUserName(paramters.getString("vcSenderSubName"));//用户名称
						userMap.put(IUserObject.KEY_IN_CONTEXT, userObject);
						IMUODataContext muo = MUODataContextHelper.create(userMap);
						DataContextManager.current().setMUODataContext(muo);
						srcInstruct.setString("vcRejectReason",paramters.getString("vcAbandonedReasons"));
						srcInstruct.setString("operationSource","gms");
						results = GenericBaseDaoSupport.invokeBizMethod("com.cjhxfund.ats.sm.comm.InstructionManager", "instructRevocation", new Object[]{srcInstruct});
						if(results[0]==Constants.ATS_SUCCESS){
							updateOrderInfoStatus(oldData);
						}else{
							throw new AppException(CJAPIConstants.ORDER_CANCLE_ERROR_CODE, (String) results[1]);
						}
					}else{
						throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, ORDER_OR_SUGGEST_AMDIN_DEAL_DONE_MSG);
					}
				}else{
					throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, BaseDataUtils.getOrigordIdMsg(paramters));//找不到对应有效指令
				}
			}else{
				String msg = String.format(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR_MSG,paramters.getString("vcOrigOrdId"));
				throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, msg);
			}
			txManager.commit();
		}catch(AppException e){
			txManager.rollback();
			throw e;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
		resultMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		return resultMap;
	}
	
	
	/**
	 * @Description 根据投资编号进行调用机器猫的废弃逻辑处理
	 * @Author		liangjilong
	 * @Date		2017年1月6日 下午5:26:06
	 * @param investNo 		投资编号
	 * @param paramters     传过来Json的参数
	 * @param retMap        返回的Map对象
	 * @param oldData       根据之前的信息更新废弃信息状态.
	 */
	@SuppressWarnings("all")
	private static Map<String, Object>  invokePrimaryMarketCancleOrderInfo(String investNo,DataObject paramters,DataObject oldData,
			 Map<String, Object> retMap) throws AppException{
		boolean flag = false;
		String userId = paramters.getString("vcSenderSubId");//操作人
		String origordId =(String)paramters.get("vcOrigOrdId");
		String abandonedReasons = (String)paramters.get("vcAbandonedReasons");//废弃原因
		String componentName = getParamterNames(paramters)[2];//组件名称
		String bizMethodName = getParamterNames(paramters)[6];//业务逻辑方法
		Object reqParams [] = new Object[]{investNo, abandonedReasons,userId};//请求参数
		Object[] result = GenericBaseDaoSupport.invokeBizMethod(componentName, bizMethodName, reqParams);//调用一级债废弃逻辑流
		if(StrUtil.isNotEmpty(result)){
			HashMap jqmRetMap =(HashMap) result[0];// 机器猫逻辑流返回的参数的结果是HashMap的就可以这样转换
			if (jqmRetMap!=null&&jqmRetMap.containsKey("returnCode") 
					&&"0".equals(jqmRetMap.get("returnCode"))) {
				oldData.set("vcClordId", origordId);
				updateOrderInfoStatus(oldData);//更新一级市场表状态
				flag = true;
			}else{
				flag = false;
			}
		}else{
			flag = false;
		}
		if(flag){
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
			LogUtil.logInfo("一级市场撤销调用机器猫接口成功, investNo:{0}, retMsg:{1}", null, investNo, CJAPIConstants.SUCCESS_RETURN_MSG);
		}else{
			retMap.put("vcRetCode", CJAPIConstants.ORDER_CANCLE_ERROR_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.ORDER_CANCLE_ERROR_MSG);
			LogUtil.logError("一级市场撤销调用机器猫接口失败, investNo:{0}, retMsg:{1}", null, investNo, CJAPIConstants.FAIL_RETURN_MSG);
		}
		return retMap;
	} 
	
	
	/**===================================调用处理机器猫和其他逻辑代码=====================================================**/
	
	/**
	 * @Description 调用处理机器猫 
	 * @Author		liangjilong
	 * @Date		2016年12月8日 下午6:42:49
	 * @param paramters
	 * @param oldData
	 * @param executeType
	 * @throws AppException 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	private static Map<String, Object> invokeJQMBizService(DataObject paramters,Long processId) throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		int code = 0;
		//1、 逻辑构件名称，JQM实体名称,CJAP实体名称,返回的信息
		String componentName ="",jqmEntityName="",msg="",errorMsg="";
		//2、流程状态逻辑流biz，交易状态逻辑流biz,删除/废弃逻辑biz
		String proBizMethodName="",jyBizMethodName="",deleteBizMethodName="";
		try {
			//3、获取动态的值
			String [] paramterNames = getParamterNames(paramters);
			jqmEntityName = paramterNames[1];  
			componentName = paramterNames[2];  
			proBizMethodName = paramterNames[3];  
			jyBizMethodName = paramterNames[4];  
			deleteBizMethodName = paramterNames[5];  
			
			Object[] paramObject1 = new Object[1];
			//4、转换成机器猫识别的对象
			DataObject dataObj = DataObjectUtil.createDataObject(jqmEntityName);
			dataObj.set("processId", processId);
			paramObject1[0] = dataObj; 
			
			//5、处理调用JQM程序
			ILogicComponent logicComponent = LogicComponentFactory.create(componentName);//创建组建工程
			Object[] result1 = logicComponent.invoke(proBizMethodName, paramObject1);//调用流程状态逻辑流
			String processStatus = (String)result1[0];
			//该指令/建议后台已成交，不能再做任何操作
		    if(processStatus!=null && "6".equals(processStatus)){
        		msg  = ORDER_OR_SUGGEST_AMDIN_DEAL_DONE_MSG;
        		code = ORDER_PROCESS_STATUS_AMDIND_CONFIRM_END_CODE;
        	}else{
				result1 = logicComponent.invoke(jyBizMethodName, paramObject1);//调用交易状态逻辑流
				String validStatus = (String)result1[0];
				 //若指令单有效，则继续执行
	            if(validStatus!=null&&("0".equals(validStatus) || "3".equals(validStatus))){
	            	Object[] paramObject2 = new Object[1];
	            	//赋值格式，{zhfwptjyzqmms:[{processId:rows[0].processId, processStatus:processStatus, abandonedReasons:value}]});
	            	DataObject [] jqmDelObj = new DataObject[1];
	            	dataObj.set("processStatus", validStatus);
	            	String abandonedReasons = (String)paramters.get("vcAbandonedReasons");
	            	if(!StringUtil.isBlank(abandonedReasons)){
	            		dataObj.set("abandonedReasons",abandonedReasons);//废弃原因-- N
	            	}
	            	jqmDelObj[0] = dataObj;
	            	paramObject2[0] = jqmDelObj;
	            	//调用并获取值,返回的参数//无效指令单字符串,无效指令单记录数,无效指令单字符串（Fix错误信息）,有效指令单字符串（反馈报文失败原因[警告信息等]）
	            	Object [] result2 = logicComponent.invoke(deleteBizMethodName, paramObject2);//调用删除逻辑流
	            	if(StrUtil.isNotEmpty(result2)){
	            		String invalidStr = (String)result2[0];
	            		Integer invalidCount =(Integer)result2[1];
	            		String invalidFixStr =(String)result2[2];
	            		String validFixFailReason =(String)result2[3];
	            		if((invalidCount!=null  && invalidCount!=0) && (!StringUtil.isBlank(invalidFixStr))){
	            			String tempInvalidStrArr[] = invalidStr.split(",");
	            			String tempInvalidFixStrArr[] = invalidFixStr.split("★");
	            			for(int i=0; i<tempInvalidStrArr.length; i++){
	            				errorMsg += "【"+tempInvalidStrArr[i]+"-"+tempInvalidFixStrArr[i]+"】";
	            			}
	            			code = CJAPIConstants.ORDER_CANCLE_ERROR_CODE;
	            			msg = CJAPIConstants.ORDER_CANCLE_ERROR_MSG + invalidCount + " 条"+errorMsg+"原因为："+validFixFailReason;;
	            			LogUtil.logError("撤销调用机器猫接口成功, ORDER_CANCLE_ERROR_CODE:{0}, retMsg:{1}", null, code, msg);
	            		}else{
	            			code = CJAPIConstants.SUCCESS_RETURN_CODE;
	            			msg = CJAPIConstants.SUCCESS_RETURN_MSG;
	            			LogUtil.logInfo("撤销调用机器猫接口成功, SUCCESS_RETURN_CODE:{0}, retMsg:{1}", null, code, msg);
	            		}
	            	}else{
	            		throw new AppException(CJAPIConstants.NOT_FIND_DATA_CODE, CJAPIConstants.NOT_FIND_DATA_MSG);
	            	}
	            }else{
	            	 code = CJAPIConstants.ORDER_VALID_STATUS_CODE;
         		     msg = CJAPIConstants.ORDER_VALID_STATUS_MSG;
         		     LogUtil.logError("撤销调用机器猫接口成功, ORDER_VALID_STATUS_CODE:{0}, retMsg:{1}", null, code, msg);
	            }
        	}
			retMap.put("vcRetCode", code);
			retMap.put("vcRetMsg", msg);
		} catch (Throwable e) {
			String error="调用方法invokeJQMService机器猫逻辑流出现异常，异常信息为:"+e.getMessage();
			LogUtil.logError(error, e);
			throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);
		}
		return retMap;
	}
	
	/**
	 * @Description 更新指令信息的状态
	 * @Author		liangjilong
	 * @Date		2016年12月9日 下午1:38:17 		参数
	 * @return 		void 返回类型
	 */
	public static void updateOrderInfoStatus(DataObject paramters)throws AppException{
		String cjapiEntityName = getParamterNames(paramters)[0];
		CJAPICommonUtil.getUpdateDateAndUpdateTime(paramters);//获取更新日期和时间
		paramters.set("vcOrderStatus", CJAPIConstants.ORDER_STATUS_INVALID_ABANDON);
		GenericBaseDaoSupport.saveOrUpdate(paramters, false, cjapiEntityName,CJAPIConstants.DS_DEFAULT);
	} 
	
	/**
	 *1 一级市场指令 2 银行间二级市场指令 3 银行间质押式回购指令  4 交易所二级市场指令 5 交易所质押式回购指令
	 * @Description 获取实体名称路径
	 * @Author		liangjilong
	 * @Date		2016年12月8日 下午2:41:33
	 * @param 		paramters
	 * @return 		String 返回类型
	 */
	private static String [] getParamterNames(DataObject paramters) throws AppException{
		String [] paramterNames = new String [7];//存储参数名称
		// 逻辑构件名称,CJAPI实体名称，JQM实体名称
		String componentName  = "",cjapiEntityName = "",jqmEntityName="";
		//流程状态逻辑流biz，交易状态逻辑流biz,删除/废弃逻辑biz,一级债逻辑流名称
		String proBizMethodName="",jyBizMethodName="",deleteBizMethodName="",firstMarketBizMethodName="";
		//1、处理实体名称
		BigDecimal enOrderType = paramters.getBigDecimal("enOrderType");
		int orderType = enOrderType.intValue();
		if(orderType==ORDER_TYPE_CODE1){
			cjapiEntityName = CJAPIConstants.PRIMARK_MARKET_ENTITY_NAME;
		}else if(orderType==ORDER_TYPE_CODE2){
			cjapiEntityName = CJAPIConstants.BANK_SECOND_MARKET_ENTITY_NAME;
		}else if(orderType==ORDER_TYPE_CODE3){
			cjapiEntityName = CJAPIConstants.BANK_PLEDGE_REPO_ENTITY_NAME;
		}else if(orderType==ORDER_TYPE_CODE4){
			cjapiEntityName = CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME;
		}else if(orderType==ORDER_TYPE_CODE5){
			cjapiEntityName = CJAPIConstants.EXCHANGE_PLEDGE_REPO_ENTITY_NAME;
		}else{
			String origordId =(String)paramters.get("vcOrigOrdId");
			String businessTypeMsg = String.format(CJAPIConstants.BUSINESS_TYPE_MSG, "enOrderType等于"+orderType+"和 vcOrigOrdId等于"+origordId);
			throw new AppException(CJAPIConstants.BUSINESS_TYPE_CODE, businessTypeMsg);
		}
		
		//2、处理逻辑构件名称,逻辑流名称
		if(orderType==ORDER_TYPE_CODE1){
			componentName = CJAPIConstants.JQM_FIRST_GRADEBOND_PROCESS_COMPONENT_NAME;
			firstMarketBizMethodName = CJAPIConstants.JQM_FIRSTGRADE_BONDE_ABANDONED_LOGIC_METHOD;
		} else if(orderType==ORDER_TYPE_CODE2||orderType==ORDER_TYPE_CODE4){
			//债劵买卖
			jqmEntityName = CJAPIConstants.JQM_JY_ZQMM_ENTITY_NAME;
			componentName = CJAPIConstants.JQM_ORDER_ZQMM_COMPONENT_NAME;
			proBizMethodName = CJAPIConstants.JQM_QUERY_ORDER_ZQMM_PROCESS_STATUS_BIZ_METHOD;
			jyBizMethodName = CJAPIConstants.JQM_QUERY_ORDER_ZQMM_VALID_STATUS_BIZ_METHOD;
			deleteBizMethodName = CJAPIConstants.JQM_ORDER_ZQMM_DELETE_BIZ_METHOD;
			
		}else if(orderType==ORDER_TYPE_CODE3||orderType==ORDER_TYPE_CODE5){
			//逆回购
			jqmEntityName = CJAPIConstants.JQM_JY_ZNHG_ENTITY_NAME;
			componentName = CJAPIConstants.JQM_ORDER_ZNHG_COMPONENT_NAME;
			proBizMethodName = CJAPIConstants.JQM_QUERY_ORDER_ZNHG_PROCESS_STATUS_BIZ_METHOD;
			jyBizMethodName = CJAPIConstants.JQM_QUERY_ORDER_ZNHG_VALID_STATUS_BIZ_METHOD;
			deleteBizMethodName = CJAPIConstants.JQM_ORDER_ZNHG_DELETE_BIZ_METHOD;
		}
		paramterNames[0] = cjapiEntityName;
		paramterNames[1] = jqmEntityName;
		paramterNames[2] = componentName;
		paramterNames[3] = proBizMethodName;
		paramterNames[4] = jyBizMethodName;
		paramterNames[5] = deleteBizMethodName;
		paramterNames[6] = firstMarketBizMethodName;
		return paramterNames;
	}
	
	
	/**
	 * @Description 回调跟踪机器猫操作按钮流程状态或交易状态
	 * 				处理银行间二级市场/交易所二级市场的订单债券买卖 
	 * 				处理银行间质押式回购/交易所质押式回购订单正逆回购
	 * @Author		liangjilong
	 * @Date		2016年12月21日 下午1:54:27
	 * @param 		opType操作类型（1-废弃 2-确认）
	 * @param 		processId机器猫流程主键Id
	 * @param 		tableName 机器猫表名(ZHFWPT_JY_ZQMM或ZHFWPT_JY_ZNHG)
	 * @return 		void 返回类型
	 */
	@Bizlet("回调跟踪机器猫操作按钮流程状态或交易状态")
	public static String orderOperateCallBack(String opType,Long processId,String tableName) throws AppException{
		String result ="";
		//处理证券买卖
		if((!StringUtil.isBlank(tableName)&&"ZHFWPT_JY_ZQMM".equalsIgnoreCase(tableName) )&& processId!=null){
			tableName = tableName.toUpperCase();
			String jqmJyZqmmEntityName = CJAPIConstants.JQM_JY_ZQMM_ENTITY_NAME;
			result = orderLogic(opType, processId, jqmJyZqmmEntityName,tableName); 
		}
		//处理正逆回购
		if((!StringUtil.isBlank(tableName)&&"ZHFWPT_JY_ZNHG".equalsIgnoreCase(tableName) ) && processId!=null){
			tableName = tableName.toUpperCase();
			String jqmJyZNHGEntityName = CJAPIConstants.JQM_JY_ZNHG_ENTITY_NAME;
			result = orderLogic(opType, processId, jqmJyZNHGEntityName,tableName); 
		}
		return result;
	}

	/**
	 * @Description 处理订单业务逻辑
	 * @Author		liangjilong
	 * @Date		2016年12月22日 下午5:24:38
	 * @param opType
	 * @param processId
	 * @param jqmEntityName
	 * @param tableName 		参数
	 * @return 		void 返回类型
	 */
	private static String orderLogic(String opType, Long processId, String jqmEntityName,String tableName) throws AppException{	
		String cjapiTableName ="", cjapiEntityName = "", execuType = "",result="";
		DataObject jqmDataObject = BaseDataUtils.queryOrderInfoByProcessId(jqmEntityName, processId,new String[]{"processId"});
		if(!StringUtil.isBlank(opType) && (opType.equals(ORDER_OPTYPE_CODE1) || opType.equals(ORDER_OPTYPE_CODE2))){
			if(jqmDataObject!=null){
				Long processStatus = jqmDataObject.getLong("processStatus");//流程状态
				Long validStatus = jqmDataObject.getLong("validStatus");//指令单状态
				Long investNo = jqmDataObject.getLong("investProductNum");
				if("ZHFWPT_JY_ZQMM".equalsIgnoreCase(tableName)){
					//01-银行间,02-上交所固收平台 ,03-深交所综合协议平台|上交所大宗
					  execuType = jqmDataObject.getString("tradingPlace");//判断是否为（银行间/交易所）
					  if(!StringUtil.isBlank(execuType) && execuType.equals(ORDER_TRADING_PLACE_CODE1)){
							cjapiTableName = CJAPIConstants.BANK_SECOND_MARKET_TABLE_NAME;//动态表
							cjapiEntityName = CJAPIConstants.BANK_SECOND_MARKET_ENTITY_NAME;//动态实体名称
							result = callBackStatus(opType, processId, investNo, cjapiTableName, cjapiEntityName, processStatus,validStatus);
						}else if(!StringUtil.isBlank(execuType)&&(execuType.equals(ORDER_TRADING_PLACE_CODE2)
								||execuType.equals(ORDER_TRADING_PLACE_CODE3))){
							
							cjapiTableName = CJAPIConstants.EXCHANGE_SECOND_TABLE_NAME;//动态表
							cjapiEntityName = CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME;//动态实体名称
							result = callBackStatus(opType, processId, investNo, cjapiTableName, cjapiEntityName, processStatus,validStatus);
						}
				}else{
					//04-银行间质押式逆回购,22-交易所逆回购
					  execuType = jqmDataObject.getString("processType");//业务类别（银行间逆回购/交易所逆回购）
					  
					  if(!StringUtil.isBlank(execuType) && (execuType.equals(ORDER_PROCESS_TYPE_CODE3)||execuType.equals(ORDER_PROCESS_TYPE_CODE4))){
							cjapiTableName = CJAPIConstants.BANK_PLEDGE_REPO_TABLE_NAME;//动态表
							cjapiEntityName = CJAPIConstants.BANK_PLEDGE_REPO_ENTITY_NAME;//动态实体名称
							result = callBackStatus(opType, processId, investNo, cjapiTableName, cjapiEntityName, processStatus,validStatus);
						}else if(!StringUtil.isBlank(execuType) && (execuType.equals(ORDER_PROCESS_TYPE_CODE21)||execuType.equals(ORDER_PROCESS_TYPE_CODE22))){
							cjapiTableName = CJAPIConstants.EXCHANGE_PLEDGE_REPO_TABLE_NAME;//动态表
							cjapiEntityName = CJAPIConstants.EXCHANGE_PLEDGE_REPO_ENTITY_NAME;//动态实体名称
							result = callBackStatus(opType, processId, investNo, cjapiTableName, cjapiEntityName, processStatus,validStatus);
						}
				}//else -end
			}
		}
		return result;
	}


	/**
	 * 
	 * @Description 操作数据库状态信息
	 * @Author		liangjilong
	 * @Date		2016年12月22日 下午5:23:12
	 * @param opType
	 * @param processId
	 * @param cjapiTableName
	 * @param cjapiEntityName
	 * @param processStatus 		参数
	 * @return 		void 返回类型
	 */
	private static String callBackStatus(String opType, Long processId, Long investNo, String cjapiTableName, String cjapiEntityName, 
			Long processStatus,Long validStatus) throws AppException{
		String result  = "";
		DataObject objData = null;
		//获取旧数据
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(cjapiEntityName, new String[]{"vcInvestNo","vcOrderStatus"},new String[]{String.valueOf(investNo),"0"},new String[]{"=","="});
		DataObject[] queryList = DatabaseUtil.queryEntitiesByCriteriaEntity(CJAPIConstants.DS_DEFAULT, criteriaType);
		if(StrUtil.isNotEmpty(queryList)) {
			objData = queryList[0];
		}
		if(StrUtil.isNotEmpty(objData) && !StrUtil.isEmpty(validStatus) && validStatus==2L){
			//更新CJAPI指令信息状态,processStatus这个状态是指机器猫返回的状态是什么就更新什么状态.
			BaseDataUtils.updateOrderProcessStatus(cjapiTableName, objData.getLong("enProcessId"), String.valueOf(processStatus));
			if(!StrUtil.isEmpty(opType) && opType.equals(ORDER_OPTYPE_CODE1)){
				updateOriginalOrderStatus(objData.getLong("enProcessId"), cjapiEntityName);//更新CJAPI指令信息状态
			}
			//DataObject objData = BaseDataUtils.queryOrderInfoByProcessId(cjapiEntityName,processId,new String[]{"enProcessId"});
			//组装传入参数数据
			Map<String,Object> reqMap = new HashMap<String,Object>();
			reqMap.put("vcClordId",objData.get("vcClordId"));//指令Id
			reqMap.put("vcOrigOrdId",objData.get("vcOrigOrdId"));//原指令Id
			reqMap.put("vcSenderSubId",objData.get("vcSenderSubId"));//推送人Id
			reqMap.put("vcSenderSubName",objData.get("vcSenderSubName"));//推送人名称
			reqMap.put("vcRetCode","1400");//返回编码
			reqMap.put("vcRetMsg","指令废弃");//返回信息
			String parameters = orderStateWhenObsoletingInstruction(reqMap);
			//调用招商WebService接口
			String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.ORDER_STATE_NAMESPACE, "OrderState", "OrderState", parameters);
			if(StrUtil.isNotEmpty(retMsg)){
				Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
				if(StrUtil.isNotEmpty(retMap)){
					result = (String)retMap.get("result");
					//System.out.println(reqMap.get("vcClordId"));
					if (result==null || !"000000".equals(result)) {
						LogUtil.logError("指令废弃接口操作失败, vcClordId:{0}, retMsg:{1}", null, objData.get("vcClordId"), retMsg);
					} else {
						LogUtil.logInfo("指令废弃接口操作成功, vcClordId:{0}, retMsg:{1}", null, objData.get("vcClordId"), retMsg);
					}
				}
			}
		}
		return result;
	}

	/**
	 * @Description 反馈机器猫指令状态到GMS.
	 * @Author		liuyulong
	 * @Date		2017年11月14日 下午4:30:33
	 * @param cjapiEntityName 		参数
	 * @param vcInvestNo --投资编号
	 * @param vcOrderStatus 预调整状态
	 * @return 		void 返回类型
	 */
	public static String feedbackOrderStatus(String cjapiEntityName, String vcInvestNo, String vcOrderStatus) throws AppException{
		String result = "";
		DataObject oldOrder = DataObjectUtil.createDataObject(cjapiEntityName);
		CriteriaType criteriaType =CriteriaType.FACTORY.create();
		criteriaType.set_entity(cjapiEntityName);//设置动态的实体
		criteriaType.set("_expr[1]/vcInvestNo", vcInvestNo);
		criteriaType.set("_expr[2]/vcOrderStatus", "0");
		int resultQty = DatabaseUtil.expandEntityByCriteriaEntity("default", criteriaType, oldOrder);
		if(resultQty==1){
			//组装传入参数数据
			Map<String,Object> reqMap = new HashMap<String,Object>();
			reqMap.put("vcClordId",oldOrder.get("vcClordId"));//指令Id
			reqMap.put("vcOrigOrdId",oldOrder.get("vcOrigOrdId"));//原指令Id
			reqMap.put("vcSenderSubId",oldOrder.get("vcSenderSubId"));//推送人Id
			reqMap.put("vcSenderSubName",oldOrder.get("vcSenderSubName"));//推送人名称
			reqMap.put("vcRetCode","1400");//返回编码
			reqMap.put("vcRetMsg","指令废弃");//返回信息
			//String parameters = orderStateWhenObsoletingInstruction(reqMap);
			String paramJson = new Gson().toJson(reqMap);
			paramJson = JSONUtil.jsonToJSON(paramJson,  "request");
			System.out.println("指令撤销信息反馈, 推送信息:"+paramJson);
			//调用招商WebService接口
			String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.ORDER_STATE_NAMESPACE, "OrderState", "OrderState", paramJson);
			if(StrUtil.isNotEmpty(retMsg)){
				Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
				if(StrUtil.isNotEmpty(retMap)){
					result = (String)retMap.get("result");
					if (result==null || !"000000".equals(result)) {
						System.out.println("指令废弃接口操作失败, 指令编号:【"+oldOrder.get("vcClordId")+"】,失败原因："+retMsg);
					} else {
						oldOrder.setString("vcOrderStatus", vcOrderStatus);//指令状态(-1待生效,0-有效;1-无效-修改;2-无效-废弃;3-有效-退回;4-无效-退回，1202-下单失败)
						DatabaseUtil.updateEntity(CJAPIConstants.DS_DEFAULT, oldOrder);
						System.out.println("指令废弃接口操作成功, 指令编号:【"+oldOrder.get("vcClordId")+"】,返回信息："+retMsg);
					}
				}else{
					System.out.println("指令废弃接口操作失败, 指令编号:【"+oldOrder.get("vcClordId")+"】,失败原因："+retMsg);
				}
			}else{
				System.out.println("指令废弃接口操作失败, 指令编号:【"+oldOrder.get("vcClordId")+"】,失败原因："+retMsg);
			}
		}else{
			//抛出未找到原有效订单
			throw new AppException(CJAPIConstants.ORDER_CANCLE_ERROR_CODE, "未找到对应可撤销的订单，未执行撤销操作");
		}
		return result;
	}
	
	
	/**
	 * @Description 废弃原来的指令的状态信息，废弃动作不会新增一条指令.
	 * @Author		liangjilong
	 * @Date		2016年12月21日 下午4:56:33
	 * @param processId
	 * @param cjapiEntityName 		参数
	 * @return 		void 返回类型
	 */
	private static void updateOriginalOrderStatus(Long processId, String cjapiEntityName) throws AppException{
		DataObject oldData = BaseDataUtils.queryOrderInfoByProcessId(cjapiEntityName,processId,new String[]{"enProcessId"});//获取旧数据
		oldData.set("vcOrderStatus", CJAPIConstants.ORDER_STATUS_INVALID_ABANDON);
		GenericBaseDaoSupport.saveOrUpdate(oldData, false, cjapiEntityName,CJAPIConstants.DS_DEFAULT);
	}
	

	/**
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author		liangjilong
	 * @Date		2016年11月30日 上午9:59:29
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	private static String getCurrentClassName(){
		return CommOperatorUtil.class.getName()+".";
	} 
}

 
