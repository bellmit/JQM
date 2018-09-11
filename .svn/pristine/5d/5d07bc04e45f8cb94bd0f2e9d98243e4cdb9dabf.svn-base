/**
 * 
 */
package com.cjhxfund.cjapi.exchange;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import com.cjhxfund.ats.sm.comm.InstructionManagerUtil;
import com.cjhxfund.cjapi.common.BaseDataUtils;
import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.ParamUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.exception.ExceptionUtil;
import com.cjhxfund.cjapi.interBank.BankSecondMarketUtils;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.commonUtil.Constants;
import com.cjhxfund.commonUtil.DateUtil;
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
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.common.muo.MUODataContextHelper;

import commonj.sdo.DataObject;

/**
 * @author 金文轩
 * @date 2016-12-06 11:27:11
 *
 */
@Bizlet("")
public class ExchangeSecondMarketUtil {
	 
	//------------------------------------------银行间二级市场指令下达校验--Begin--------------------------------
	
	/**
	 * @Description 交易所二级市场指令下达
	 * @Author		liuyulong
	 * @Date		2016年11月28日 下午4:51:36
	 * @param 		BondOrder（债券下单、修改、撤销:BondOrder）
	 * @return 		参数
	 * @return 		DataObject[] 返回类型
	 * @throws 		AppException  
	 */
	@Bizlet("交易所二级市场指令修改")
	public static Map<String, Object> exchangeSecondOrderIssued(String json){
		String exchangeSecondOrderIssued = CJAPIConstants.EXCHANGE_SECOND_ORDER_ISSUED;
		Map<String, Object> retMap = new HashMap<String, Object>();
		DataObject paramters = null;
		try{
			paramters = checkSecondOrderData(exchangeSecondOrderIssued,json);//通用json检测,校验参数是否为空、字段类型、字段长度
			retMap = saveSecondOrder(paramters,exchangeSecondOrderIssued);
		} catch (AppException e) {
			String errorFunc = getCurrentClassName() + exchangeSecondOrderIssued;
			String errorMsg = "交易所二级市场指令下达," + exchangeSecondOrderIssued + "方法出现异常，异常信息为：" + e.getMsg();
			retMap = ExceptionUtil.retExceptionInfo(retMap, e, errorFunc, errorMsg);
			return retMap;
		}
		return retMap;
	}
	
	/**
	 * @Description 交易所二级市场指令修改
	 * @Author		liuyulong
	 * @Date		2016年11月28日 下午4:51:36
	 * @param 		BondOrder（债券下单、修改、撤销:BondOrder）
	 * @return 		参数
	 * @return 		DataObject[] 返回类型
	 * @throws 		AppException  
	 */
	@Bizlet("交易所二级市场指令修改")
	public static Map<String, Object> exchangeSecondOrderModify(String json){
		String exchangeSecondOrderIssued = CJAPIConstants.EXCHANGE_SECOND_ORDER_MODIFY;
		Map<String, Object> retMap = new HashMap<String, Object>();
		DataObject paramters = null;
		try{
			paramters = checkSecondOrderData(exchangeSecondOrderIssued,json);//通用json检测,校验参数是否为空、字段类型、字段长度
			retMap = saveSecondOrder(paramters,exchangeSecondOrderIssued);
		} catch (AppException e) {
			String errorFunc = getCurrentClassName() + exchangeSecondOrderIssued;
			String errorMsg = "交易所二级市场指令修改," + exchangeSecondOrderIssued + "方法出现异常，异常信息为：" + e.getMsg();
			retMap = ExceptionUtil.retExceptionInfo(retMap, e, errorFunc, errorMsg);
			return retMap;
		}
		return retMap;
	}

	/**===================================调用处理机器猫和其他逻辑代码====End=================================================**/
	/**
	 * @Description 接口参数校验
	 * @Author		liuyulong
	 * @Date		2017年11月02日 上午11:29:35
	 * @param json
	 * @throws AppException 		参数
	 * @return 		DataObject  返回类型
	 */
	private static DataObject checkSecondOrderData(String execute, String json) throws AppException{
		DataObject paramters = ParamUtil.paramCheck(execute,json);//通用json检测,校验参数是否为空、字段类型、字段长度
		if(StrUtil.isNotEmpty(paramters)){
			ArrayList<Object> list = new ArrayList<Object>();
			//校验净价、全价
			if(paramters.get("enNetPrice") != null && !"".equals(paramters.get("enNetPrice"))){
				list.add(paramters.get("enNetPrice"));
			}
			if(paramters.get("enFullPrice") != null && !"".equals(paramters.get("enFullPrice"))){
				list.add(paramters.get("enFullPrice"));
			}
			//净价、全价两个参数不为二选一则返回传值错误
			if(list.size()!= 1){
				throw new AppException(CJAPIConstants.ERROR_PRICE_INPUT, CJAPIConstants.ERROR_PRICE_INPUT_MSG);
			}
		}
		try{
			checkSaveOrUpdateInfo(paramters,execute);//校验是否可执行下单会修改操作、修改指令时并继承原指令部分信息（产品组合、债券信息）
		}catch (Exception e) {
			if(e instanceof AppException) {
				throw (AppException)e;
			} else {
				throw new AppException(CJAPIConstants.ERROR_SYSTEM, CJAPIConstants.ERROR_SYSTEM_MSG);
			}
		}
		return paramters;
	}
	
	/**
	 * @Description 执行二级债流程对接以及数据保存
	 * @Author		liuyulong
	 * @Date		2016年11月29日 上午11:29:35
	 * @param json
	 * @throws AppException 		参数
	 * @return 		void 返回类型
	 */
	private static Map<String, Object> saveSecondOrder(DataObject paramters, String executeTypeStr) throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		ITransactionManager txManager = TransactionManagerFactory.getTransactionManager();
		txManager.begin(ITransactionDefinition.PROPAGATION_REQUIRED, ITransactionDefinition.ISOLATION_DEFAULT);
		try {
			DataObject instructParameter = invokeOrderSaveOrUpdateData(paramters,false,false);//转换数据参数
			Object[] results = null;
			//设置用户对象
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
			//调用机器猫指令逻辑
			if(executeTypeStr.equals(CJAPIConstants.EXCHANGE_SECOND_ORDER_MODIFY)){//修改指令
				DataObject srcInstruct = DataObjectUtil.createDataObject(CJAPIConstants.JQM_JY_XQJY_ENTITY_NAME);
				CriteriaType criteriaType =CriteriaType.FACTORY.create();
				criteriaType.set_entity(CJAPIConstants.JQM_JY_XQJY_ENTITY_NAME);//设置动态的实体
				criteriaType.set("_expr[1]/lResultNo", paramters.get("vcInvestNo"));
				criteriaType.set("_expr[2]/cIsValid", "1");
				int result = DatabaseUtil.expandEntityByCriteriaEntity("default", criteriaType, srcInstruct);
				if(result==1){
					results = GenericBaseDaoSupport.invokeBizMethod("com.cjhxfund.ats.sm.comm.InstructionManager", "insertAndUpdateInstruct", new Object[]{instructParameter, srcInstruct, null});
					paramters.set("enProcessId", results[3]);
					paramters.set("vcInvestNo", results[4]);
				}else{
					throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, BaseDataUtils.getOrigordIdMsg(paramters));
				}
				//更新原指令记录状态为1（无效-修改）
				DataObject bSMarket = DataObjectUtil.createDataObject(CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME);
				CriteriaType criteriaType1 =CriteriaType.FACTORY.create();
				criteriaType1.set_entity(CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME);
				criteriaType1.set("_expr[1]/vcClordId", paramters.getString("vcOrigOrdId"));
				criteriaType1.set("_expr[2]/vcOrderStatus", CJAPIConstants.ORDER_STATUS_VALID);
				criteriaType1.set("_expr[3]/vcBackStatus", CJAPIConstants.BACK_STATUS_UNEXECUTED);
				bSMarket.setString("vcOrderStatus", "1");
				DatabaseUtil.updateEntityByCriteriaEntity("default", bSMarket, criteriaType1);
			}else{
				results = GenericBaseDaoSupport.invokeBizMethod("com.cjhxfund.ats.sm.comm.InstructionManager", "insertInstruct", new Object[]{instructParameter, null, null});
				paramters.set("enProcessId", results[4]);
				paramters.set("vcInvestNo", results[5]);
			}
			if(results[0]==Constants.ATS_SUCCESS){
				paramters.set("lExchangeSecondMarketId", DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_E_S_MARKET));//获取主键
				CJAPICommonUtil.saveOrUpdate(paramters, true, CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME);//保存接口数据
			}else{
				throw new AppException(CJAPIConstants.STATUS_JQM_SUBMIT_ERROR, (String)results[1]);
			}
			retMap.put("vcRetCode", CJAPIConstants.SUCCESS_RETURN_CODE);
			retMap.put("vcRetMsg", CJAPIConstants.SUCCESS_RETURN_MSG);
			txManager.commit();
		}  catch (Exception e) {
			txManager.rollback();
			if(e instanceof AppException) {
				throw (AppException)e;
			} else {
				throw new AppException(CJAPIConstants.ERROR_SYSTEM, CJAPIConstants.ERROR_SYSTEM_MSG);
			}
		}
		return retMap;
	}
	
	/***
	 * @Description 校验是否可下单（TAtsCjapiBSMarket）
	 * @Author		liuyulong
	 * @Date		2017年10月31日 下午6:24:26
	 * @param 		paramters；参数对象
	 * @param 		executeType 执行动作类型常量
	 * @param 		isAdd是否要添加更新时间 (true/false)
	 * @throws 		Exception 异常参数
	 * @return 		void 返回类型
	 */
	private static DataObject checkSaveOrUpdateInfo(DataObject paramters,String executeType) throws Exception{
		//1、实体名称路径
		String entityName = CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME;
		if(executeType.equals(CJAPIConstants.EXCHANGE_SECOND_ORDER_ISSUED)){		 
			BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(paramters,entityName)); //检测指令是否已存在记录表，已存在则抛出异常
			paramters.setString("vcOrderType",  CJAPIConstants.ORDER_TYPE_ADD);//VC_ORDER_TYPE 	add-新增  edit-修改
			
			paramters.setString("vcBondCodeExternal",  paramters.getString("vcBondCode"));
			String vcBondCode = BaseDataUtils.getBondCodeExternal(paramters.getString("vcBondCode"));
			paramters.setString("vcBondCode",  vcBondCode);
		}else if(executeType.equals(CJAPIConstants.EXCHANGE_SECOND_ORDER_MODIFY)){		 
			BaseDataUtils.checkExistOrderByClordId(new ObjectParamVo(paramters,entityName)); //检测指令是否已存在记录表，已存在则抛出异常
			ObjectParamVo objectParamVo=new ObjectParamVo(paramters,entityName,false,true);
			DataObject oldData = BaseDataUtils.getOrderInfoByOrigordId(objectParamVo);//获取原指令信息
			if(StrUtil.isEmpty(oldData)){
				String msg = BaseDataUtils.getOrigordIdMsg(paramters);
				throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR, msg);
			}else{
				paramters.setString("vcOrderType", CJAPIConstants.ORDER_TYPE_EDIT);//VC_ORDER_TYPE 	add-新增  edit-修改
				paramters.set("vcInstructionId", paramters.getString("vcOrigOrdId"));//原指令Id，下达是没原指令Id.
				//继承部分原指令信息
				paramters.set("vcProductCode", oldData.getString("vcProductCode"));//产品代码
				paramters.set("vcProductName", oldData.getString("vcProductName"));//产品名称
				paramters.set("vcCombiNo", oldData.getString("vcCombiNo"));//组合代码
				paramters.set("vcCombiName", oldData.getString("vcCombiName"));//组合代码
				paramters.set("vcBondCode", oldData.getString("vcBondCode"));//债券代码
				paramters.set("vcBondName", oldData.getString("vcBondName"));//债券名称
				paramters.set("vcInvestNo", oldData.getString("vcInvestNo"));//旧指令投资编号
				paramters.set("vcBondCodeExternal", oldData.get("vcBondCodeExternal"));
				paramters.set("vcFirstClordId", oldData.getString("vcFirstClordId"));//原指令投资编号
			}
		}
		paramters.set("vcOrderStatus", CJAPIConstants.ORDER_STATUS_VALID);//接口指令表指令状态
		CJAPICommonUtil.getCreateDateAndCreateTime(paramters);//获取创建日期和创建时间
		return paramters;
	}
	
	
	
	/***
	 * @Description 映射保存接参数到指令表
	 * @Author		liuyulong
	 * @Date		2017年10月30日 下午2:24:26
	 * @param 		paramters 接口参数
	 * @throws 		Exception 异常参数
	 * @param      特殊说明:
	 *              paramters.getString("vcBondName") 和 paramters.getString("vcBondCode")值
	 *              如下方法获取 {@link BankSecondMarketUtils#saveOrUpdateInfo} 和 {@link BaseDataUtils#getOrderInfoByOrigordId}
	 * @return 		DataObject 转换后的参数
	 */
	private static DataObject invokeOrderSaveOrUpdateData(DataObject paramters,boolean executeType,boolean isAdd) throws AppException{
		//调用机器猫程序
		DataObject dataObject = null;
		try {
			String vcAgreemtCode = paramters.getString("vcAgreemtCode");
			String vcRivalSeat = paramters.getString("vcRivalSeat");
			String vcCounterpartyTrader = paramters.getString("vcCounterpartyTrader");
			if("SS".equals(paramters.getString("vcExDestination"))){
				paramters.setString("vcMarket", "1");
				if("E".equals(paramters.getString("vcBusinClass"))||"I".equals(paramters.getString("vcBusinClass"))){
					if("E".equals(paramters.getString("vcBusinClass"))){
						paramters.setString("vcBizType", "2");//上交所大宗
						paramters.setString("businClass", "E");
						if(vcRivalSeat==null || "".equals(vcRivalSeat) || vcAgreemtCode==null || "".equals(vcAgreemtCode)){
							//String msg = String.format(CJAPIConstants.ERROR_PARAM_MISS_MSG,"vcRivalSeat");
							//throw new AppException(CJAPIConstants.ERROR_PARAM_MISS,msg);
						}else if(!Pattern.matches("[0-9]{6}", vcAgreemtCode)){//约定号 6位数字
							String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,"vcAgreemtCode");
							throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
						}else if(!Pattern.matches("[0-9]{5}", vcRivalSeat)){//对手席位5位数字
							String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,"vcRivalSeat");
							throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
						}
					}else{
						paramters.setString("vcBizType", "3");//上交所固收
						paramters.setString("businClass", "I");
						if(vcCounterpartyTrader == null || "".equals(vcCounterpartyTrader) || vcAgreemtCode==null || "".equals(vcAgreemtCode)){
							//String msg = String.format(CJAPIConstants.ERROR_PARAM_MISS_MSG,"vcCounterpartyTrader");
							//throw new AppException(CJAPIConstants.ERROR_PARAM_MISS,msg);
						}else if(!Pattern.matches("[0-9]{3}", vcAgreemtCode)){//约定号 3位数字
							String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,"vcAgreemtCode");
							throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
						}else if(!Pattern.matches("Z[0-9]{5}", vcCounterpartyTrader)){//对方交易员Z+5位数字
							String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,"vcCounterpartyTrader");
							throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
						}
					}
				}else{
					//add by chenxing 20180427
					if("1".equals(paramters.getString("vcBusinClass"))){
						paramters.setString("vcBizType", "8");     //竞价平台
						paramters.setString("businClass", "1");
					}else{
						if(paramters.getString("vcRemark").indexOf("大宗交易")!=-1){
							paramters.setString("vcBizType", "2");//上交所大宗
							paramters.setString("businClass", "E");
						}else{
							paramters.setString("vcBizType", "3");//上交所固收
							paramters.setString("businClass", "I");
						}
					}
				}
			}else if("SZ".equals(paramters.getString("vcExDestination"))){
				paramters.setString("vcMarket", "2");
				//add by chenxing 20180427
				if("1".equals(paramters.getString("vcBusinClass"))){
					paramters.setString("vcBizType", "9");     //竞价平台
					paramters.setString("businClass", "1");
					paramters.setString("vcBusinClass", "1");
				}else{
					//约定号 6位数字   对手席位6位数字
					paramters.setString("vcBizType", "4");//深交所大宗
					paramters.setString("businClass", "E");
					paramters.setString("vcBusinClass", "E");
					if(vcRivalSeat == null || "".equals(vcRivalSeat) || vcAgreemtCode==null || "".equals(vcAgreemtCode)){
						//String msg = String.format(CJAPIConstants.ERROR_PARAM_MISS_MSG,"vcRivalSeat");
						//throw new AppException(CJAPIConstants.ERROR_PARAM_MISS,msg);
					}else if(!Pattern.matches("[0-9]{6}", vcAgreemtCode)){//约定号 6位数字
						String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,"vcAgreemtCode");
						throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
					}else if(!Pattern.matches("[0-9]{6}", vcRivalSeat)){//对手席位6位数字
						String msg = String.format(CJAPIConstants.ERROR_PARAM_TYPE_MSG,"vcRivalSeat");
						throw new AppException(CJAPIConstants.ERROR_PARAM_TYPE, msg);
				    }
				 }
			}
			//paramters.setString("businClass", paramters.getString("vcBusinClass"));
			//根据债券代码与市场查询债券基本信息: 债券代码,债券名称,交易市场,债券内码
			String stockInfo = InstructionManagerUtil.getInvestProductsByReportCodeAndMarketNo(paramters.getString("vcBondCode"),paramters.getString("vcMarket"));
			if(stockInfo==null || "".equals(stockInfo)){
				throw new AppException(CJAPIConstants.BONDCODE_NOT_IN_O32_CODE, String.format(CJAPIConstants.BONDCODE_NOT_IN_O32_MSG,paramters.getString("vcBondCode")));
			}
			paramters.setString("vcInterCode", stockInfo.split(",")[3]);
			String vcClearSpeed = "";
			if(paramters.getString("vcClearSpeed") != null && !"".equals(paramters.getString("vcClearSpeed"))){
					if("1".equals(paramters.getString("vcClearSpeed"))){
						vcClearSpeed="T+1";
					}else{
						vcClearSpeed="T+0";
					}
			}
			//净价、全价、收益率三选一,计算得出：净价+"@"+全价（债券价格）+"@"+到期收益率+"@"+收益率类型+"@"+交易场所+"@"+清算速度+"行权收益率"
			String linkResult = InstructionManagerUtil.getLinkageValue(DateUtil.currentDateYYYYMMDDStr(), 
					paramters.getString("vcInterCode"), paramters.getString("enNetPrice"), paramters.getString("enFullPrice"),null, 
					null, paramters.getString("vcMarket"), vcClearSpeed);
			if(linkResult!=null && !"".equals(linkResult)){
				paramters.set("enNetPrice", linkResult.toString().split("@")[0]);
				paramters.set("enNetPriceAmount", Double.parseDouble(paramters.getString("enNetPrice"))*paramters.getLong("enOrderAmount"));
				paramters.set("enFullPrice", linkResult.toString().split("@")[1]);
				paramters.set("enFullPriceAmount", Double.parseDouble(paramters.getString("enFullPrice"))*paramters.getLong("enOrderAmount"));
				paramters.set("enMaturityYield", linkResult.toString().split("@")[2]);
				paramters.set("vcYieldType", linkResult.toString().split("@")[3]);
				paramters.set("enOptionYield", linkResult.toString().split("@")[6]);
			}
			//添加固有的额外的字段内容
			if(paramters.getString("enNetPrice")!=null && !"".equals(paramters.getString("enNetPrice"))){
				paramters.setDouble("enPrice", paramters.getDouble("enNetPrice"));
			}else{
				paramters.setDouble("enPrice", paramters.getDouble("enFullPrice"));
			}
			paramters.setString("processStatus","1");
			
			paramters.setString("exdestination", paramters.getString("vcExDestination"));
			dataObject = BaseDataUtils.convertDataFormatToNewJQMZQMM(paramters,null);// Object是用来存储方法的参数
		} catch (Throwable e) {
			
			if(e instanceof AppException){
				throw (AppException)e;
			}else{
				String error = "执行数据关系映射出现异常:"+e.getMessage();
				LogUtil.logError(error, e);
				throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);
			}
		}
		return dataObject;
	}



	/**
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author		liuyulong
	 * @Date		2016年11月30日 上午9:59:29
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	private static String getCurrentClassName(){
		return ExchangeSecondMarketUtil.class.getName()+".";
	}
	
	
	public static void main(String[] arg){
		String pattern = "Z[0-9]{5}";
		Boolean flag = Pattern.matches(pattern, "z23456");
		System.out.println(flag);
	}
}
