package com.cjhxfund.cjapi.primaryMarket;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.BaseDataUtils;
import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.CommOperatorUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.exception.ExceptionUtil;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.exception.EOSRuntimeException;
import com.google.gson.Gson;

import commonj.sdo.DataObject;

@Bizlet("")
@SuppressWarnings("all")
public class PrimaryMarketUtil {
	/**----------------- 一级市场指令流程节点 begin---------------**/
	/**未知状态*/
	public static final int ORDER_PROCESS_UNKNOW=-1; 
	/**开始**/
	public static final int ORDER_PROCESS_START=1; 
	/**投标指令下达**/
	public static final int ORDER_PROCESS_DLXD=4; 
	/**投顾复核**/
	public static final int ORDER_PROCESS_IA_CHECK_1= 8;
	/**信息核对(交易员1)**/
	public static final int ORDER_PROCESS_INFO_CHECK_1= 12;
	/**信息核对(交易员2)**/
	public static final int ORDER_PROCESS_INFO_CHECK_2= 16;
	/**投资经理*(IM, Investment Manager)确认**/
	public static final int ORDER_PROCESS_IM_CONFIRM_1= 20;
	/**总监助理(AD, Assistant Director) 审核**/
	public static final int ORDER_PROCESS_DA_CHECK=24;
	/**执行总监(ED, Executive Director) 审核**/
	public static final int ORDER_PROCESS_ED_CHECK=28;
	/**分管领导审核**/
	public static final int ORDER_PROCESS_LEADER_CHECK=32;
	/**人工审核特批交易**/
	public static final int ORDER_PROCESS_MANNUL_CHECK_1=36;
	/**报价修改**/
	public static final int ORDER_PROCESS_PRICE_MODIFY=40;
	/**人工审核特批交易**/
	public static final int ORDER_PROCESS_MANNUL_CHECK_2=44;
	/**投顾复核**/
	public static final int ORDER_PROCESS_IA_CHECK_2= 48;
	/**修改执行(交易员1)**/
	public static final int ORDER_PROCESS_MODIFY_IMPL_1=52;
	/**修改执行(交易员2)**/
	public static final int ORDER_PROCESS_MODIFY_IMPL_2=56;
	/**投资经理确认**/
	public static final int ORDER_PROCESS_IM_CONFIRM_2=60;
	/**投标用印**/
	public static final int ORDER_PROCESS_BID_SEAL=64;
	/**传真**/
	public static final int ORDER_PROCESS_FIX=68;
	/**中标确认信息**/
	public static final int ORDER_PROCESS_BID_COMFIRM_INFO=70;
	/**中标确认结果**/
	public static final int ORDER_PROCESS_BID_COMFIRM_RESULT=72;
	/**中标复核**/
	public static final int ORDER_PROCESS_BID_DOUBLE_CHECK=76;
	/**协议用印**/
	public static final int ORDER_PROCESS_PROTOCOL_SEAL=80;
	/**缴款执行**/
	public static final int ORDER_PROCESS_PAYMENT_EXECUTION=84;
	/**结束(成功)**/
	public static final int ORDER_PROCESS_DONE_FINISH=88;
	/**----------------- 一级市场指令流程节点 end---------------**/
	
	/**----------------- 指令状态 begin ---------------**/
	//-1-未知状态, 0-有效;1-无效-修改;2-无效-废弃;3-有效-退回;4-无效-退回,5-否决无效;
	/**未知状态*/
	public static final int ORDER_STATUS_UNKNOW= -1;
	/**0-有效**/
	public static final int ORDER_STATUS_VALID = 0;
	/**1-无效-修改**/
	public static final int ORDER_STATUS_INVALID_MODIFY =1;
	/**2-无效-废弃**/
	public static final int ORDER_STATUS_INVALID_ABANDON =2;
	/**3-有效-退回**/
	public static final int ORDER_STATUS_VALID_RETURN =3;
	/**4-无效-退回**/
	public static final int ORDER_STATUS_INVALID_RETURN =4;
	/**5-否决-无效**/
	public static final int ORDER_STATUS_VETO_RETURN =5;
	
	/**----------------- 一级市场指令流程节点 end---------------**/
	
	private static final SimpleDateFormat dateFormator = new SimpleDateFormat("yyyyMMdd");
	private static String QUERYPRIMARYMARKETBYINVESTNO_SQLXID = "com.cjhxfund.cjapi.WSPrimaryMarketns.queryPrimaryMarketByInvestNo";
 
	
	/**
	 * @param json 接收到的json参数
	 * @return
	 * @throws AppException
	 */
	@Bizlet("一级市场指令下达")
	public static Map<String, Object> primaryOrderIssued(String json)  throws AppException  {
		Map<String, Object> retMap = new HashMap<String, Object>();
		PrimaryOrderIssued order = new PrimaryOrderIssued(json);
		try {
			DataObject paramters = order.parseParam();	// 2. 参数校验及解析
			String vcSenderSubId = (String)paramters.get("vcSenderSubId");
			
			retMap = BaseDataUtils.checkIsExistOperator(vcSenderSubId,true);//判断是否有操作人
			if(retMap.isEmpty()){
				boolean isAdd = true;				
				order.orderToDB(isAdd);										// 3.参数入库留痕
				Object[] resultObjs = order.callJQM();					// 4. 调用机器猫接口下达指令
				order.dealJQMResult(resultObjs);							// 5. 处理机器猫返回的结果
				isAdd = false;
				order.orderToDB(isAdd);										// 6.将机器猫返回的结果更新到数据库
				// 返回成功信息
				retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
				retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
				
				
			}
		} catch(Exception e){
			if(e instanceof AppException){
				AppException ex=(AppException)e;
				LogUtil.logError("一级市场指令下达primaryOrderIssued接口出现异常，异常信息为："+ex.getMsg(), e);
			}else{
				LogUtil.logError("一级市场指令下达primaryOrderIssued接口出现异常，异常信息为："+e.getMessage(), e);
			}
			AppException ae = ExceptionUtil.exceptionDeal("PrimaryMarketUtil.primaryOrderIssued", e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
		}
		LogUtil.logInfo("一级债指令下达接口返回信息：{0},{1}", null, retMap.get("vcRetCode"),retMap.get("vcRetMsg"));
		return retMap;
	}
	
	/***
	 * @param json 接收到的json参数
	 * @throws AppException
	 */
	@Bizlet("一级市场指令修改")
	public static Map<String, Object> primaryOrderModify(String json)  throws AppException  {
		Map<String, Object> retMap = new HashMap<String, Object>();
		PrimaryOrderModify order = new PrimaryOrderModify(json);
		try {
			DataObject parseParam = order.parseParam();	// 2. 参数校验及解析
			String vcSenderSubId = (String)parseParam.get("vcSenderSubId");
			retMap = BaseDataUtils.checkIsExistOperator(vcSenderSubId,true);//判断是否有操作人
			if(retMap.isEmpty()){
				String entityName = CJAPIConstants.PRIMARK_MARKET_ENTITY_NAME;  // 实体名称
				DataObject oldData = order.getOrderByInstruction();
				//因为检测修改修改节点提前，所以判断原指令是否存在这个逻辑提前到 “判断vcClordId是否存在” 之前
				if(StrUtil.isEmpty(oldData)){
					String msg = BaseDataUtils.getOrigordIdMsg(parseParam);
					throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, msg);
				}
				String vcClordId = parseParam.getString("vcClordId");//指令Id
				String vcFirstClordId = oldData.getString("vcFirstClordId");//第三方系统指令编号（最初）
				oldData.setString("investNo", oldData.getString("vcInvestNo"));//获取投资编号转换成jqm使用的变量
				Object paramObjs [] = new Object[]{oldData};
				String componentName = "com.cjhxfund.jy.process.FirstGradeBond.debtInterface";//路径
				Object [] resultObjs = GenericBaseDaoSupport.invokeBizMethod(componentName, "getDateObject", paramObjs);
				if(StrUtil.isNotEmpty(resultObjs)){
					DataObject object = (DataObject)resultObjs[2];
					String retCode = (String)resultObjs[3];
					String activityDefID = object.getString("activityDefID");//流程节点Id
					String returnCode = "";
					if(!"manualActivity5".equalsIgnoreCase(activityDefID)){
						returnCode = "2";
					}else if(StrUtil.isNotEmpty(retCode) && "1".equalsIgnoreCase(retCode)){
						returnCode = "6";
					}else{
						returnCode= "0";
					}
					//在节点可以往下走.
					if ("0".equals(returnCode)) {
					} else if ("2".equals(returnCode)) {
						throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_PRICE_ERROR, CJAPIConstants.STATUS_JQM_MODIFY_PRICE_ERROR_MSG);
					}else if("6".equals(returnCode)) {
						throw new AppException(CJAPIConstants.NOT_FIND_DATA_CODE, CJAPIConstants.NOT_FIND_DATA_MSG);
					}else{
						throw new AppException(CJAPIConstants.STATUS_JQM_ORDER_ERROR, CJAPIConstants.STATUS_JQM_ORDER_ERROR_MSG);
					}
				}
				//检测修改修改节点
				BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(parseParam,entityName)); //判断vcClordId是否存在
				order.canModify(oldData);							// 判断指令是否可以修改
				order.mergeOrderData(oldData);
				boolean isAdd = true;	
				order.paramToDB(isAdd,vcFirstClordId);							// 3.参数入库留痕
				Object[] resultObjs2 = order.callJQM(oldData);
				order.dealJQMResult(resultObjs2,vcClordId,vcFirstClordId,vcSenderSubId);// 5. 处理机器猫返回的结果
				isAdd = false;
				order.paramToDB(isAdd,vcFirstClordId);						    // 6.将机器猫返回的结果更新到数据库
				order.abandonOldOrder(oldData);				// 7.将原指令置为"修改-废弃"状态
				// 返回成功信息
				retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
				retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
			}
		} catch(Exception e){
			if(e instanceof AppException){
				AppException ex=(AppException)e;
				LogUtil.logError("一级市场指令修改primaryOrderModify接口出现异常，异常信息为："+ex.getMsg(), e);
			}else{
				LogUtil.logError("一级市场指令修改primaryOrderModify接口出现异常，异常信息为："+e.getMessage(), e);
			}
			AppException ae = ExceptionUtil.exceptionDeal("PrimaryMarketUtil.primaryOrderModify", e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
		}
		return retMap;
	}
	
	/***
	 * 接收招行的中标确认信息（“确认”或“驳回”），并通知机器猫处理
	 * @param json 接收到的json参数
	 * @throws AppException
	 */
	@Bizlet("中标确认")
	public static Map<String, Object> bidConfirm(String json)  throws AppException  {
		Map<String, Object> retMap = new HashMap<String, Object>();
		PrimaryBidConfirm bid = new PrimaryBidConfirm(json);
		try {
			DataObject parseParam = bid.parseParam();						// 解析参数 
			ObjectParamVo objectVo = new ObjectParamVo(parseParam,CJAPIConstants.CJAPI_BID_CONFIRM_INFO_ENTITY_NAME);
			DataObject [] dataList = CJAPICommonUtil.checkExistOrderByClordId(objectVo);//检测是否存在中标与驳回信息
			if(StrUtil.isNotEmpty(dataList)){
				DataObject dataObject = dataList[0];
				if(StrUtil.isNotEmpty(dataObject)){
					//处理结果(1中标确认成功,2中标失败,3-驳回成功,4-驳回失败)
					String vcDealResult = dataObject.getString("vcDealResult");
					String vcClordId = parseParam.getString("vcClordId");
					if(StrUtil.isNotEmpty(vcDealResult) && "1".equals(vcDealResult)){
						String msg = String.format(CJAPIConstants.BID_CONFIRM_FAIL_MSG1,vcClordId);
						throw new AppException(CJAPIConstants.BID_CONFIRM_FAIL_CODE1,msg);
					}else if(StrUtil.isNotEmpty(vcDealResult) && "3".equals(vcDealResult)){
						String msg = String.format(CJAPIConstants.BID_CONFIRM_FAIL_MSG3,vcClordId);
						throw new AppException(CJAPIConstants.BID_CONFIRM_FAIL_CODE3,msg);
					}
				}
			}
			bid.getAndSetInstruction();	// 获取原指令数据
			Object[] resultObjs = bid.callJQM();//调用机器猫接口，通知机器猫该指令确认或者驳回
			bid.dealJQMResult(resultObjs,parseParam);//处理机器猫返回的结果
		} catch(Exception e){
			if(e instanceof AppException){
				AppException ex=(AppException)e;
				LogUtil.logError("中标确认bidConfirm接口出现异常，异常信息为："+ex.getMsg()+"异常编码为:"+ex.getCode(), e);
			}else{
				LogUtil.logError("中标确认bidConfirm接口出现异常，异常信息为："+e.getMessage(),e);
			}
			AppException ae = ExceptionUtil.exceptionDeal("PrimaryMarketUtil.bidConfirm", e);
			retMap.put("vcRetCode", ae.getCode());
			retMap.put("vcRetMsg", ae.getMsg());
			return retMap;
	    }
		// 返回成功信息
		retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
		retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
		return retMap;
	}

	/***
	 * 用于机器猫回调的接口，机器猫通过调用此接口通知CJAPI订单当前的状态
	 * 
	 * @param investNo
	 *            投资编号
	 * @param orderProcess
	 *            当期所处的流程节点
	 * @param orderStatus
	 *            指令状态
	 * @return 返回，
	 * 		 -1 处理失败
	 * 		 0  处理正常
	 * 		 1  找不到投资编号vcInvestNo的有效的记录信息数据 
	 * 		 2  找到投资编号vcInvestNo含多条有效的记录信息 
	 * 		 3  调用招行接口失败
	 * 	     4  请求参数超过长度【vcBallotNumber、enBallotPrice、enPaymentMoney、enCouponRate,paymentDate】必填
	 */
	@Bizlet("")
	public static int primaryCallBack(long investNo, int orderProcess, int orderStatus, DataObject infoDataObj) {
		// 1. 通过investNo找到指令信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vcInvestNo", String.valueOf(investNo));
		params.put("vcOrderStatus", String.valueOf(ORDER_STATUS_VALID));
		try {
			Object[] objs = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT,  QUERYPRIMARYMARKETBYINVESTNO_SQLXID, params);
			if (objs == null || objs.length == 0) {
				//1代表,找不到投资编号vcInvestNo的有效的记录信息数据
				return 1;
			} 
			
			if (objs.length != 1) {
				LogUtil.logError("vcInvestNo={0}, vcOrderStatus={1}含有{2}条记录", null, investNo, ORDER_STATUS_VALID, objs.length);
				//2代表, 找到投资编号vcInvestNo含多条有效的记录信息
				return 2;
			}
			
			Object obj = objs[0];
			DataObject dataObj = (DataObject)obj;
			CJAPICommonUtil.getUpdateDateAndUpdateTime(dataObj);	// 更新时间
			dataObj.set("vcOrderProcess",orderProcess);
			dataObj.set("vcOrderStatus",orderStatus);
			
			// 2. 更新数据库状态
			DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.WSPrimaryMarketns.updatePrimaryMarketStatus", dataObj);
			
			// 3. 中标确认信息
			if (orderProcess == ORDER_PROCESS_BID_COMFIRM_INFO){
				// 3.1 中标信息入库，并反馈个招行
				infoDataObj.set("vcInvestNo", String.valueOf(investNo));
				infoDataObj.set("vcClordId", dataObj.get("vcClordId"));
				infoDataObj.set("vcBondCode", dataObj.get("vcBondCode")); 
				infoDataObj.set("vcBondName", dataObj.get("vcBondName"));
				Map<String, Map<String, Object>> retMapObjs = saveBidInfo(infoDataObj);		// save into db
				Map<String, Object> CMBBidInfoMap = retMapObjs.get("retCmbBidInfoMap");//返回中标确认信息
				Map<String, Object> retCodeMap = retMapObjs.get("retCodeMap");//返回异常信息
				String retCode = (String) retCodeMap.get("retCode");//参数返回正常编码
				if(retCode!=null && "0".equals(retCode)){
					String paramJson = new Gson().toJson(CMBBidInfoMap);
					paramJson = JSONUtil.jsonToJSON(paramJson,  "request");
					String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.BIDCFG_NAMESPACE,"BidCfg", "BidCfg", paramJson);
					Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
					Object result = retMap.get("result");
					if (result == null || !"000000".equals(retMap.get("result"))) {
						LogUtil.logError("一级市场中标信息调用招行接口失败, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
						return 3;// 调用招行接口失败
					} else {
						LogUtil.logInfo("一级市场中标信息调用招行接口成功, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
					}
				}else if(retCode!=null && "4".equals(retCode)){
					return 4;// 请求参数超过长度【vcBallotNumber、enBallotPrice、enPaymentMoney、enCouponRate,lPaymentDate】
				}
			}
			
			// 4. 中标确认结果反馈给招行
			boolean flag = false; // 招行暂时不需要，暂时注释掉
			if (orderProcess == ORDER_PROCESS_BID_COMFIRM_RESULT && flag) {
				dataObj.setString("vcClordId",dataObj.getString("vcClordId"));
				dataObj.setString("vcOrigOrdId",dataObj.getString("vcInstructionId"));
				dataObj.setString("vcIsBidCfg","1");
				dataObj.setString("vcOperatorState","success");
				String componentName = "com.cjhxfund.cjapi.WSCommOperatorService";
				Object[] feedbackParams = new Object[1];
				feedbackParams[0]=dataObj;
				String retMsg = null;
				try {
					Object [] object = GenericBaseDaoSupport.invokeBizMethod(componentName, "orderState", feedbackParams);
					if(object[0]!=null){
						retMsg = object[0].toString();
					}
					Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
					Object result = retMap.get("result");
					if (result == null || !"000000".equals(retMap.get("result"))) {
						LogUtil.logError("中标确认调用招行接口指令状态反馈失败, vcClordId:{0}, retMsg:{1}", null, dataObj.getString("vcClordId"), retMsg);
						return 3;// 调用招行接口失败
					} else {
						LogUtil.logInfo("中标确认调用招行接口指令状态反馈成功, vcClordId:{0}, retMsg:{1}", null, dataObj.getString("vcClordId"), retMsg);
					}
				} catch (Throwable e) {
					e.printStackTrace();
					LogUtil.logError("调用指令状态反馈逻辑流错误！", e);
				}
			}
			
			// 5. (成交反馈-缴款执行)回调招行接口
			if (orderProcess == ORDER_PROCESS_PAYMENT_EXECUTION) {
				Map<String, String> map =new HashMap<String, String>();
				map.put("vcClordId", dataObj.getString("vcClordId"));
				map.put("vcProceStatus", "1");			// 招行约定
				String paramJson = new Gson().toJson(map);
				paramJson = JSONUtil.jsonToJSON(paramJson,  "request");
				String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.MARKET_BACK_NAMESPACE,"BondDealRecv", "BondDeal", paramJson);
				Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
				Object result = retMap.get("result");
				if (result == null || !"000000".equals(retMap.get("result"))) {
					LogUtil.logError("一级市场成交反馈调用招行接口失败, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
					return 3;// 调用招行接口失败
				} else {
					LogUtil.logInfo("一级市场成交反馈调用招行接口成功, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
				}
			}
			
			// 6. 指令被否决与废弃
			if (orderStatus == ORDER_STATUS_INVALID_ABANDON || orderProcess==ORDER_STATUS_VETO_RETURN) {
				Map<String, String> map =new HashMap<String, String>();
				map.put("vcClordId", dataObj.getString("vcClordId"));
				map.put("vcOrigOrdId", dataObj.getString("vcOrigOrdId"));			// 招行约定
				map.put("vcSenderSubId", dataObj.getString("vcSenderSubId"));			
				map.put("vcSenderSubName", dataObj.getString("vcSenderSubName"));	
				map.put("vcRetCode", "1400");	
				map.put("vcRetMsg", "指令废弃");
				
				String paramJson = new Gson().toJson(map);
				paramJson = JSONUtil.jsonToJSON(paramJson,  "request");
				String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.ORDER_STATE_NAMESPACE,"OrderState", "OrderState", paramJson);
				Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
				Object result = retMap.get("result");
				if (result == null || !"000000".equals(retMap.get("result"))) {
					LogUtil.logError("一级市场指令否决/废弃调用招行接口失败, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
					return 3;// 调用招行接口失败
				} else {
					LogUtil.logInfo("一级市场指令否决/废弃调用招行接口成功, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
				}
			}
		} catch (Exception e) {
			LogUtil.logError("调用primaryCallBack出现异常，参数investNo:{0},orderProcess{1},orderStatus:{2},infoDataObj:{3}，异常信息为：{4}",e,
					 investNo,orderProcess,orderStatus,infoDataObj,e.getMessage());
			if (e instanceof AppException){
				ExceptionUtil.exceptionDeal("PrimaryMarket.primaryCallBack", e);
			}
			return -1;
		}
		return 0;
	}
	
	/**
	 * @Description 已经到了一级投标修改报价环节
	 * @Date		2017年3月29日 下午12:30:47
	 * @param investNo投资编号
	 * @return 		void 返回类型
	 */
	@Bizlet("")
	public static int primaryNodeUpdateCallBack(Long investNo){
		int retCode = 1;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vcInvestNo", String.valueOf(investNo));
		params.put("vcOrderStatus", String.valueOf(ORDER_STATUS_VALID));
		Object datas [] =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT,QUERYPRIMARYMARKETBYINVESTNO_SQLXID,params);
		DataObject  [] dataObjects = CJAPICommonUtil.objectsToDataObjects(datas);
		if(dataObjects!=null && dataObjects.length>0){
			DataObject dataObj = dataObjects[0];
			if(dataObj!=null){
				//组装传入参数数据
				Map<String,Object> reqMap = new HashMap<String,Object>();
				reqMap.put("vcClordId",dataObj.get("vcClordId"));//指令Id
				reqMap.put("vcSenderSubId",dataObj.get("vcSenderSubId"));//推送人Id
				reqMap.put("vcSenderSubName",dataObj.get("vcSenderSubName"));//推送人名称
				reqMap.put("vcRetCode","1401");//返回编码
				reqMap.put("vcRetMsg","已经到达一级投标修改报价环节！");//返回信息
				try {
					//设置参数
					String parameters = CommOperatorUtil.orderStateWhenObsoletingInstruction(reqMap);
					//调用招商WebService接口
					String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.ORDER_STATE_NAMESPACE, "OrderState", "OrderState", parameters);
					if(StrUtil.isNotEmpty(retMsg)){
						Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
						if(StrUtil.isNotEmpty(retMap)){
							String result = (String)retMap.get("result");
							if (result==null || !"000000".equals(result)) {
								LogUtil.logError("页面流程反馈招行,已经到了一级投标修改报价环节失败!, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
								retCode = 1;
							} else {
								LogUtil.logInfo("页面流程反馈招行,已经到了一级投标修改报价环节成功!, investNo:{0}, retMsg:{1}", null, investNo, retMsg);
								retCode = 0;
							}
						}
					}
				} catch (AppException e) {
					LogUtil.logError("已经到了一级投标修改报价环节失败,异常信息为：, investNo:{0},retCode:{1}, retMsg:{2}",
							e,investNo,String.valueOf(e.getCode()), e.getMsg());
					e.printStackTrace();
					retCode = e.getCode();
				}
			}
		}
		return retCode;
	}
	
	/***
	 * 通过原指令ID获取整条指令数据
	 * @param vcClordId
	 */
	public static DataObject getOrderByInstruction(String vcClordId) throws AppException{
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put("vcClordId", vcClordId);
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
	/**
	 * @Description 保存中标确认信息
	 * @Author		liangjilong
	 * @Date		2017年3月8日 下午5:32:38
	 * @param bidInfo
	 * @throws Exception 		参数
	 * @return 		Map<String,Map<String,Object>> 返回类型
	 */
	private static Map<String, Map<String, Object>> saveBidInfo(DataObject bidInfo) throws Exception{
		LogUtil.logInfo("机器猫中标确认信息页面传入参数：bidInfo：{0}", null, bidInfo);
		//标识参数
		String flag1 = "0",flag2 ="0",flag3 = "0",flag4 ="0",flag5="0";
		Map<String, Map<String, Object>> retMapObjs = new HashMap<String, Map<String, Object>>();
		Map<String, Object> retCMBBidInfoMap = new HashMap<String, Object>();
		Map<String, Object> retCodeMap = new HashMap<String, Object>();
		DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		
		/*** 必填项检测**/
		Integer lPaymentDate = null;
		Date paymentDate = bidInfo.getDate("paymentDate");			// 缴款日，必填
		Date firstPayDate = bidInfo.getDate("initialInterestPaymentDate");   // 首次付息日，非必填
		Date bidLimitTime = bidInfo.getDate("deadlineInterest"); 	// 到期日，非必填
		Date DBidLimitTime = bidInfo.getDate("startingDateInterest");//计息起始日
		if (paymentDate == null) {			// 缴款日，必填
			flag5 ="5";
		}else{
			lPaymentDate = Integer.parseInt(dateFormator.format(paymentDate));	// 缴款时间
			data.set("lPaymentDate", lPaymentDate);
			flag5 ="0";
		}
		Integer lFirstPayDate = firstPayDate == null ? null : Integer.parseInt(dateFormator.format(firstPayDate));
		Integer lBidLimitTime = bidLimitTime == null ? null : Integer.parseInt(dateFormator.format(bidLimitTime));
		Integer lBegincalDate = DBidLimitTime == null ? null : Integer.parseInt(dateFormator.format(DBidLimitTime));
		data.set("vcClordId", bidInfo.get("vcClordId"));
		data.set("vcInvestNo", bidInfo.get("vcInvestNo"));		// 投资编号
		data.set("vcStockName", bidInfo.get("vcStockName"));
		data.set("vcStockCode", bidInfo.get("vcStockCode"));
		data.set("lFirstPayDate", lFirstPayDate);	
		data.set("lBidLimitTime", lBidLimitTime);	
		data.set("vcModeRepayment", bidInfo.get("modeRepayment"));
		data.set("vcFrequence", bidInfo.get("frequency"));
		data.set("vcDealResult", "0");
		CJAPICommonUtil.getCreateDateAndCreateTime(data);	
		
		Long newPayFaceValue = 0L;// 中标数量=缴款面值(万元) * 100  Number(16)
		String payFaceValueStr = String.valueOf(bidInfo.getString("payFaceValue"));
		if(StrUtil.isNotEmpty(payFaceValueStr)){
			if(!"e".contains(payFaceValueStr)||!"E".contains(payFaceValueStr)){
				if(payFaceValueStr!=null && payFaceValueStr.length()>16){
					flag1 = "1";
				}else{
					Double d = Double.parseDouble(payFaceValueStr.replace(",", ""));
					long payFaceValue = d.longValue();
					newPayFaceValue =payFaceValue*100;
					data.set("lBallotNumber", newPayFaceValue);				
					retCMBBidInfoMap.put("vcBallotNumber", newPayFaceValue);
					flag1 = "0";
				}
			}else{
				flag1 = "1";
			}
		}else{
			flag1 = "1";
		}
		
		String issuePrice = bidInfo.getString("issuePrice");//发行价格(元)Number(16,4)
		if(StrUtil.isNotEmpty(issuePrice)){
			String newIssuePrice = String.valueOf(issuePrice).replace(",", "").replace(".", "");
			//说明这个长度会出现科学计算法E
			if(!"e".contains(issuePrice)||!"E".contains(issuePrice)){
				if(String.valueOf(issuePrice).split("\\.")[0].length()>12 || newIssuePrice.length()>16){
					flag2 = "2";
				}else{
					String issuePriceStr = String.format("%.4f",Double.parseDouble(issuePrice)).replace(",", "");
					retCMBBidInfoMap.put("enBallotPrice", issuePriceStr);
					data.set("enBallotPrice", issuePriceStr);
					flag2 = "0";
				}
			}else{
				flag2 = "2";
			}
		}else{
			flag2 = "2";	
		}
		
		String paymentMoney = bidInfo.getString("paymentMoney");//缴款金额(万元)Number(16,4)
		if(StrUtil.isNotEmpty(paymentMoney)){
			String newPaymentMoney = paymentMoney.replace(",", "").replace(".", "");
			//说明这个长度会出现科学计算法E+
			if(!"e".contains(paymentMoney)||!"E".contains(paymentMoney)){
				if(String.valueOf(paymentMoney).split("\\.")[0].length()>12 || newPaymentMoney.length()>16){
					flag3 = "3";
				}else{
					String paymentMoneyStr = String.format("%.4f",Double.parseDouble(paymentMoney.replace(",", "")));
					retCMBBidInfoMap.put("enPaymentMoney", paymentMoneyStr);
					flag3 = "0";
				}
			}else{
				flag3 = "3";
			}
		}else{
			flag3 = "3";
		}
		
		String couponRate = bidInfo.getString("couponRate");//票面利率(%) Number(16,8)
		if(StrUtil.isNotEmpty(couponRate)){
			String newCouponRate = String.valueOf(couponRate).replace(",", "").replace(".", "");
			//说明这个长度会出现科学计算法E+
			if(!"e".contains(couponRate)||!"E".contains(couponRate)){
				if(String.valueOf(couponRate).split("\\.")[0].length()>8 || newCouponRate.length()>16){
					flag4 = "4";
				}else{
					String couponRateStr = String.format("%.4f",Double.parseDouble(couponRate.replace(",", "")));
					retCMBBidInfoMap.put("enCouponRate", couponRateStr);
					data.set("enCouponRate", couponRateStr);
					flag4 = "0";
				}
			}else{
				flag4 = "4";
			}
		}else{
			flag4 = "4";
		}
		ObjectParamVo vo = new ObjectParamVo(bidInfo,CJAPIConstants.CJAPI_BID_CONFIRM_INFO_ENTITY_NAME);
		DataObject retDatas [] = CJAPICommonUtil.checkExistOrderByClordId(vo);//查询出来的数据
		retCMBBidInfoMap.put("vcClordId", bidInfo.get("vcClordId"));
		retCMBBidInfoMap.put("lPaymentDate", lPaymentDate);
		retCMBBidInfoMap.put("vcOperatorState", "success");
		retCMBBidInfoMap.put("vcFrequency", bidInfo.get("frequency"));
		retCMBBidInfoMap.put("vcModeRepayment", bidInfo.get("modeRepayment"));
		retCMBBidInfoMap.put("lBegincalDate", lBegincalDate);
		retCMBBidInfoMap.put("lBidLimitTime", lBidLimitTime);
		retCMBBidInfoMap.put("vcStockName", bidInfo.get("vcBondName"));
		retCMBBidInfoMap.put("vcStockCode", bidInfo.get("vcBondCode"));
		retCMBBidInfoMap.put("lFirstPayDate", lFirstPayDate);
		
		if(flag1=="0" && flag2=="0" && flag3=="0" && flag4=="0" && flag5=="0" && StrUtil.isEmpty(retDatas)){
			//保存
			data.set("lBidConfirmId",DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_BID_CONFIRM_INFO));
			DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.WSPrimaryMarketns.insertBindConfirmInfo", data);
			retCodeMap.put("retCode", "0");
		}else if (flag1=="0" && flag2=="0" && flag3=="0" && flag4=="0" && flag5=="0" && StrUtil.isNotEmpty(retDatas)){
			//更新
			DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.WSPrimaryMarketns.updateBidConfirmInfoByClordId", data);
			retCodeMap.put("retCode", "0");
		}else{
			retCodeMap.put("retCode", "4");
		}
		 
		LogUtil.logInfo("中标确认参数, retCodeMap:{0}, retCmbBidInfoMap:{1}", null, retCodeMap, retCMBBidInfoMap);
		retMapObjs.put("retCodeMap", retCodeMap);
		retMapObjs.put("retCmbBidInfoMap", retCMBBidInfoMap);
		return retMapObjs;
	}
	

	
}
