package com.cjhxfund.cjapi.exception;

import com.eos.system.annotation.Bizlet;


/**
 * 定义创金API公共常量
 * 
 * @author luwenxing
 * @date 2016-11-23 19:57:54
 * 
 */
@Bizlet("")
public class CJAPIConstants {
	/** -----------------异常定义-----begin------ **/

	/** 应用级别异常 **/
	public static final int EXCEPTION_LEVEL_APP = 1;
	/** 系统级异常 **/
	public static final int EXCEPTION_LEVEL_SYSTEM = 2;
	
	/** 正常返回代码 **/
	public static final int SUCCESS_RETURN_CODE = 0;
	public static final String SUCCESS_RETURN_MSG = "success!!!";
	
	/** 失败返回代码 **/
	public static final int FAIL_RETURN_CODE = -1;
	public static final String FAIL_RETURN_MSG = "fail!!!";

	/** 传入的参数字符串为空 **/
	public static final int ERROR_PARAM_NULL = 1101;
	public static final String ERROR_PARAM_NULL_MSG = "传入的参数字符串为空";
	
	/** 传入的参数字符串非json对象(解析json出错) **/
	public static final int ERROR_JSON_STRING_ILLEGAL = 1102;
	public static final String ERROR_JSON_STRING_ILLEGAL_MSG = "传入的参数字符串非json对象";
	/** 缺少参数 **/
	public static final int ERROR_PARAM_MISS = 1103;
	public static final String ERROR_PARAM_MISS_MSG = "缺少参数[%s]，请核对";
	/** 参数类型错误 **/
	public static final int ERROR_PARAM_TYPE = 1104;
	public static final String ERROR_PARAM_TYPE_MSG = "传入参数[%s]数据类型错误，请核对";
	
	/** 调用异常 **/
	public static final int ERROR_INVOKE = 1105;
	public static final String ERROR_INVOKE_MSG = "调用异常";
	
	/** 机器猫参数返回错误*/
	public static final int ERROR_JQM_RETURN_PARAM = 1106;
	public static final String ERROR_JQM_RETURN_PARAM_MSG = "机器猫参数返回错误";
	 
	/**当前推送系统人员*/
	public static final int EXIST_OPERATOR_CODE = 1107;
	public static final String EXIST_OPERATOR_MSG = "暂无当前推送系统人员姓名";
	
	/**传入的接口名称错误*/
	public static final int ERROR_PARAM_INTERFACE = 1108;
	public static final String ERROR_PARAM_INTERFACE_MSG = "输入的接口名字[%s]错误";
	
	/** 参数值长度超出 **/
	public static final int ERROR_PARAM_LENGTH = 1109;
	public static final String ERROR_PARAM_LENGTH_MSG = "传入参数[%s]参数值长度超出限制，请核对";
	
	/** 参数值小数位数过长 **/
	public static final int ERROR_PARAM_SCALE = 1110;
	public static final String ERROR_PARAM_SCALE_MSG = "传入参数[%s]参数值小数位数过长，请核对";
	
	/**非法指令下单人员*/
	public static final int ERROR_ORDER_SENDER = 1111;
	public static final String ERROR_ORDER_SENDER_MSG = "[%s]为非法指令操作人员";
	
	/**查找债券信息错误*/
	public static final int ERROR_NO_BOND = 1112;
	public static final String ERROR_NO_BOND_MSG = "查找债券信息错误";
	
	/**找不到原指令id*/
	//public static final int ERROR_NO_ORIGINAL_ORDER = 1113;
	//public static final String ERROR_NO_ORIGINAL_ORDER_MSG = "找不到原指令id[%s]数据";
	/**找不到对应用的产品代码*/
	public static final int ERROR_NO_ORIGINAL_ORDER = 1113;
	public static final String ERROR_NO_ORIGINAL_ORDER_MSG = "无效的产品[%s]组合[%s]";
	
	/**[净价价格][全价价格][债券收益率]三者必须选其一*/
	public static final int ERROR_PRICERATE_INPUT = 1114;
	public static final String ERROR_PRICERATE_INPUT_MSG = "净价价格[enNetPrice]全价价格[enFullPrice]债券收益率[enInterestRate]三者必须选其一";
	
	/**[净价价格][全价价格][债券收益率]传入的为[债券收益率]时，[收益率类型]不能为空*/
	public static final int ERROR_RATE_INPUT = 1115;
	public static final String ERROR_RATE_INPUT_MSG = 
			"净价价格[enNetPrice]全价价格[enFullPrice]债券收益率[enInterestRate]传入的为债券收益率[enInterestRate]时，"
					+"收益率类型[vcInterestRateType]不能为空";
	
	
	/** 插入或更新数据库数据异常 **/
	public static final int ERROR_INSERT_OR_UPDATE_DATA = 1116;
	public static final String ERROR_INSERT_OR_UPDATE_DATA_MSG = "插入或更新数据库数据异常";
	
	
	/** 调用WebService接口异常信息 **/
	public static final int ERROR_CALL_WEB_SERVICE_INFERACE_CODE = 1117;
	public static final String ERROR_CALL_WEB_SERVICE_INFERACE_MSG = "调用 WebService的[%s]接口暂无响应数据";
	
	/** O32查询不到与提供的债券代码相关的债券信息 **/
	public static final int BONDCODE_NOT_IN_O32_CODE = 1118;
	public static final String BONDCODE_NOT_IN_O32_MSG = "交易系统无此债券代码:[%s]";
	
	/** 净价价格[enNetPrice]全价价格[enFullPrice]二者必须选其一*/
	public static final int ERROR_PRICE_INPUT = 1119;
	public static final String ERROR_PRICE_INPUT_MSG = "净价价格[enNetPrice]全价价格[enFullPrice]二者必须选其一";
	
	/** 系统异常 **/
	public static final int ERROR_SYSTEM = 9999;
	public static final String ERROR_SYSTEM_MSG = "系统异常";
	
	/** -----------------异常定义-----end------ **/
	
	/** -----------------机器猫返回结果-----begin------*/
	
	/**机器猫返回下单成功**/
	public static final int STATUS_JQM_ORDER_SUCESS = 0; 
	/**向机器猫下单中**/
	public static final int STATUS_JQM_ORDER_ISSUED = 1201;
	/**机器猫返回下单错误**/
	public static final int STATUS_JQM_ORDER_ERROR = 1202;
	public static final String STATUS_JQM_ORDER_ERROR_MSG="下单错误";
	
	/**机器猫返回修改订单错误编码**/
	public static final int STATUS_JQM_MODIFY_ORDER_ERROR =1203; 
	/**机器猫返回修改订单失败信息**/
	public static final String STATUS_JQM_MODIFY_ORDER_ERROR_MSG = "指令修改返回有错误";
	
	/**下单确认失败*/
	public static final int STATUS_JQM_BID_CONFIRM_ERROR=1204;
	/**下单确认失败信息*/
	public static final String STATUS_JQM_BID_CONFIRM_ERROR_MSG="下单确认失败";
	
	
	/**找不到有效的原指令信息编码**/
	public static final int STATUS_JQM_MODIFY_ORDER_INFO_ERROR =1205; 
	/**找不到有效的原指令信息**/
	public static final String STATUS_JQM_MODIFY_ORDER_INFO_ERROR_MSG = "找不到有效的原指令[%s]信息";
	
	/**当前节点不为报量修改节点，不能修改报量*/
	public static final int STATUS_JQM_MODIFY_PRICE_ERROR = 1206;
	public static final String STATUS_JQM_MODIFY_PRICE_ERROR_MSG = "当前节点不为报量修改节点，不能修改报量";
	
	/**提交机器猫失败*/
	public static final int STATUS_JQM_SUBMIT_ERROR=1207;
	/**下单确认失败信息*/
	public static final String STATUS_JQM_SUBMIT_ERROR_MSG="提交失败";
	
	/**订单存在并有效编码*/
	public static final int STATUS_ORDER_EXIST_CODE=1208;
	/**订单存在并有效信息*/
	public static final String STATUS_ORDER_EXIST_MSG="传入参数[%s]值已经存在，此订单为有效状态，请核对";
	
	/**业务类型编码*/
	public static final int BUSINESS_TYPE_CODE=1209;
	/**业务类型类型信息*/
	public static final String BUSINESS_TYPE_MSG="传入参数[%s]不符合业务操作，请核对";
	
	/**找不到相应的数据编码*/
	public static final int NOT_FIND_DATA_CODE=1210;
	/**找不到相应的数据信息*/
	public static final String NOT_FIND_DATA_MSG="找不到相应的数据";
	
	/**订单存在且无效编码*/
	public static final int STATUS_ORDER_EXIST_CODE_WHEN_INVALID=1211;
	/**订单存在且无效信息*/
	public static final String STATUS_ORDER_EXIST_MSG_WHEN_INVALID="传入参数[%s]值已经存在，且此订单为无效状态，请核对";
	
	/**已撤销的订单撤销失败编码*/
	public static final int CANCLE_FAIL_CODE_WHEN_ALREADY_CANCELED=1212;
	/**已撤销的订单撤销失败信息*/
	public static final String CANCLE_FAIL_MSG_WHEN_ALREADY_CANCELED="撤销失败，原指令origordId[%s]已被撤销";
	
	public static final int ORDER_CANCEL_FAIL_RET_CODE1 = 1213;
	public static final String ORDER_CANCEL_FAIL_RET_MSG1 = "撤销失败，原指令[%s]无效不能撤销";

	/**指令状态信息编码*/
	public static final int ORDER_VALID_STATUS_CODE=1301; 
	/**验证指令状态信息*/
	public static final String ORDER_VALID_STATUS_MSG="该指令/建议已无效，不能再做任何操作";
	/**废弃失败*/
	public static final int ORDER_CANCLE_ERROR_CODE = 1302;
	public static final String ORDER_CANCLE_ERROR_MSG = "撤销失败";
	/**已经中标确认的结果不能撤销指令编码*/
	public static final int ORDER_PROCESS_BID_COMFIRM_RESULT_CODE=1303;
	/**已经中标确认的结果不能撤销指令信息*/
	public static final String ORDER_PROCESS_BID_COMFIRM_RESULT_MSG="已经中标确认的结果不能撤销指令";
	/**回购天数编码*/
	public static final int REPURCHASE_DAYS_CODE=1304;
	/**回购天数信息*/
	public static final String REPURCHASE_DAYS_MSG="交易系统无[%s]回购期限(天)对应的证券代码,请联系交易员先新增该回购期限对应证券代码";
	/**百分率编码*/
	public static final int PERCENT_RATE_CODE=1305;
	/**百分率信息*/
	public static final String PERCENT_RATE_MSG="传入参数[%s]超过最大值1,范围必须为0~1之间";
	/**参数匹配编码*/
	public static final int PARAM_REG_CODE=1306;
	/**参数匹配信息*/
	public static final String PARAM_REG_MSG="传入参数[%s]必须为[%s],请核对！";
	/**当前操作失败，该指令之前驳回时失败，请重新发送新指令编码*/
	public static final int BID_CONFIRM_FAIL_CODE4 = 1307;
	/**当前操作失败，该指令之前驳回时失败，请重新发送新指令信息*/
	public static final String BID_CONFIRM_FAIL_MSG4 = "当前操作失败，该指令[%s]之前驳回时失败，请重新发送新指令";
	/**中标确认失败编码*/
	public static final int BID_CONFIRM_FAIL_RET_CODE1 = 1308;
	/**中标确认失败信息*/
	public static final String BID_CONFIRM_FAIL_RET_MSG1 = "该指令[%s]中标确认失败";
	/**驳回失败编码*/
	public static final int BID_CONFIRM_FAIL_RET_CODE2 = 1309;
	/**驳回失败编码*/
	public static final String BID_CONFIRM_FAIL_RET_MSG2 = "该指令[%s]驳回失败";
	/**该指令中标确认成功编码*/
	public static final int BID_CONFIRM_SUCCESS_RET_CODE1 = 1310;
	/**该指令中标确认成功信息*/
	public static final String BID_CONFIRM_SUCCESS_RET_MSG1 = "该指令[%s]中标确认成功";
	/**该指令驳回失败编码*/
	public static final int BID_CONFIRM_SUCCESS_RET_CODE2 = 1311;
	/**该指令驳回失败信息*/
	public static final String BID_CONFIRM_SUCCESS_RET_MSG2 = "该指令[%s]驳回成功";
	/**该指令已经中标确认成功，不能再次确认编码*/
	public static final int BID_CONFIRM_FAIL_CODE1 = 1312;
	/**该指令已经中标确认成功，不能再次确认信息*/
	public static final String BID_CONFIRM_FAIL_MSG1 = "该指令[%s]已经中标确认成功，不能再次确认";
	public static final int BID_CONFIRM_FAIL_CODE2 = 1313;
	public static final String BID_CONFIRM_FAIL_MSG2 = "该指令[%s]之前中标确认时失败，请重新发送新指令";
	/**该指令已经驳回成功，不能再次驳回编码*/
	public static final int BID_CONFIRM_FAIL_CODE3 = 1314;
	/**该指令已经驳回成功，不能再次驳回信息*/
	public static final String BID_CONFIRM_FAIL_MSG3 = "该指令[%s]已经驳回成功，不能再次驳回";
	
	
	/**传入的用户不是当前环节参与者,不能修改报价编码*/
	public static final int CURRENT_USER_NOT_IN_WORKFLOW_NODE_CODE = 1315;
	/**传入的用户不是当前环节参与者,不能修改报价信息*/
	public static final String CURRENT_USER_NOT_IN_WORKFLOW_NODE_MSG = "传入的用户[%s]不是当前环节参与者,不能修改报价,请切换角色!";
	
	
	
	/** -----------------机器猫返回结果-----end------*/

	
	/** -----------------数据源-----begin------ **/
	/** CJAPI默认的数据源 **/
	public static final String DS_DEFAULT = "default";
	/** ods的数据源 **/
	public static final String DS_SJZX = "DS_SJZX";//
	/** o32的数据源 **/
	public static final String DS_O32 = "DS_O32";// o32的数据源
	/** -----------------数据源-----end------ **/
	
	/** -----------------指令类型-----begin---- **/
	/**新增指令*/
	public static final String ORDER_TYPE_ADD = "add";
	/**指令修改*/
	public static final String ORDER_TYPE_EDIT = "edit";
	/** -----------------指令类型-----end------ **/
	
	
	/*** -------------------------方法字符串----begin------------------*/
	
	//基础信息
	/**新债基础信息*/
	public static final String BASE_QUERY_NEWSTOCKINFO="queryNewStockInfo";	
	/**交易对手信息*/
	public static final String BASE_QUERY_TRADERIVALINFO="queryTradeRivalInfo";
	/**机构组合产品信息*/
	public static final String BASE_QUERY_ORGCOMBPRDINFO="queryOrgCombPrdInfo";	
	/**估值*/
	public static final String BASE_QUERY_APPRAISEMENTINFO="queryAppraisementInfo";
	/**获取值域信息*/
	public static final String BASE_QUERY_DOMAINVALUE="queryDomainValue";	
	/**产品信息*/
	public static final String BASE_QUERY_PRODUCTINFO="queryProductInfo";	
	

    /**
     * ---------------一级市场---------------
     */
	/**一级市场指令下达*/
	public static final String PRIMARY_ORDERISSUED="primaryOrderIssued";
	/**一级市场指令修改*/
	public static final String PRIMARY_ORDER_MODIFY="primaryOrderModify";
	/**一级市场指令反馈*/
	public static final String PRIMARY_ORDER_FEEDBACK="primaryOrderFeedback";
	/**中标确认*/
	public static final String BID_CONFIRM="bidConfirm";

	
	/**
	 * ---------------银行间二级市场---------------
	 */
	
	/**银行间二级市场指令下达*/
	public static final String BANK_SECOND_ORDER_ISSUED="bankSecondOrderIssued";
	/**银行间二级市场指令修改*/
	public static final String BANK_SECOND_ORDER_MODIFY="bankSecondOrderModify";
	/**银行间二级市场指令反馈*/
	public static final String BANK_SECOND_ORDER_FEEDBACK="bankSecondOrderFeedback";

	
	/**
	 * ---------------交易所二级市场---------------
	 */
	/**交易所二级市场指令下达*/
	public static final String EXCHANGE_SECOND_ORDER_ISSUED="exchangeSecondOrderIssued";	
	/**交易所二级市场指令修改*/
	public static final String EXCHANGE_SECOND_ORDER_MODIFY="exchangeSecondOrderModify";	
	/**交易所二级市场指令反馈*/
	public static final String EXCHANGE_SECOND_ORDER_FEEDBACK="exchangeSecondOrderFeedback";
	
	/**
	 * ---------------银行间质押式回购指令---------------
	 */
	/**银行间质押式回购指令下达*/
	public static final String BANK_PLEDGEREPO_ISSUED="bankPledgeRepoIssued";
	/**银行间质押式回购指令修改*/
	public static final String BANK_PLEDGEREPO_MODIFY="bankPledgeRepoModify";	
	/**银行间质押式回购指令反馈*/
	public static final String BANK_PLEDGEREPO_FEEDBACK="bankPledgeRepoFeedback";	
	/**质押券信息*/
	public static final String BANK_PLEDGE_TICKETINFO="pledgeTicketInfo";

	
	/**
	 * ---------------交易所质押式回购指令---------------
	 */
	
	/**交易所质押式回购指令下达*/
	public static final String EXCHANGE_PLEDGEREPO_ISSUED="exchangePledgeRepoIssued";	
	/**交易所质押式回购指令修改*/
	public static final String EXCHANGE_PLEDGEREPO_MODIFY="exchangePledgeRepoModify";
	/**交易所质押式回购指令反馈*/
	public static final String EXCHANGE_PLEDGEREPO_FEEDBACK="exchangePledgeRepoFeedback";	
	
	
	/**
	 * ---------------公共指令---------------
	 */
	/**指令撤销*/
	public static final String 	COMMON_ORDER_CANCEL="orderCancel";
	/**指令操作状态*/
	public static final String 	COMMON_ORDER_STATUS="orderStatus";

	/*** -------------------------方法字符串----end-------------------------*/
	
	
	/**----------------- 指令状态 begin ---------------**/
	// -1待生效,0-有效;1-无效-修改;2-无效-废弃;3-有效-退回;4-无效-退回;
	/**-1待生效**/
	public static final int ORDER_STATUS_INVALID_AWAIT = -1;
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

	/**----------------- 指令状态 end ---------------**/
	
	/**----------------- 反馈状态 begin ---------------**/
	/**1-未执行**/
	public static final int BACK_STATUS_UNEXECUTED= 1;
	/**2-部分执行**/
	public static final int BACK_STATUS_PARTIAL_EXECUTED= 2;
	/**3-完成**/
	public static final int BACK_STATUS_FINISH= 3;
	
	/**----------------- 反馈状态 end ---------------**/
	
	
	/***  =======================数据模型实体路径常量======Begin============  */
	
	//--------------------一级市场----------------------------------------------------------------
	/** 一级市场指令 */
	public static final String PRIMARK_MARKET_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiPMarket";
	/** 一级市场成交反馈 */
	public static final String PRIMARK_MARKET_BACK_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiPMarketBack";
	
	//--------------------银行间---------------------------------------------------------
	/***银行间二级市场指令实体模型路径**/
	public static final String BANK_SECOND_MARKET_ENTITY_NAME ="com.cjhxfund.cjapi.CJAPIData.TAtsCjapiBSMarket";
	/***银行间质押式回购实体模型路径**/
	public static final String BANK_SECOND_MARKET_BACK_ENTITY_NAME ="com.cjhxfund.cjapi.CJAPIData.TAtsCjapiBSMarketBack";

	/************银行间质押式回购指令实体模型路径**********/
	public static final String  BANK_PLEDGE_REPO_ENTITY_NAME="com.cjhxfund.cjapi.CJAPIData.TAtsCjapiBPRepo";
	/************银行间质押式回购反馈实体模型路径**********/
	public static final String BANK_PLEDGE_REPO_BACK_ENTITY_NAME="com.cjhxfund.cjapi.CJAPIData.TAtsCjapiBPRepoBack";
	
	//--------------------交易所----------------------------------------------------------------
	
	/**交易所二级市场指令实体模型路径*/
	public static final String EXCHANGE_SECOND_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiESMarket";
	/**交易所二级市场反馈实体模型路径*/
	public static final String EXCHANGE_SECOND_BACK_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiESMarketBack";
	
	/**交易所质押式回购指令实体模型路径**/
	public static final String EXCHANGE_PLEDGE_REPO_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiEPRepo";
	/**交易所质押式回购反馈实体模型路径**/
	public static final String EXCHANGE_PLEDGE_REPO_BACK_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiEPRepoBack";
	
	/**日志信息实体模型路径*/
	public static final String CJAPI_LOGINFO_ENTITY_NAME = "com.cjhxfund.cjapi.common.CJAPICommon.TAtsCjapiLogInfo";
	
	/**中标确认信息表实体模型路径**/
	public static final String CJAPI_BID_CONFIRM_INFO_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiBidConfirmInfo";
	
	/**质押券信息表实体模型路径**/
	public static final String CJAPI_PLEDGE_STAMPS_ENTITY_NAME = "com.cjhxfund.cjapi.CJAPIData.TAtsCjapiPledgeStamps";
	
	
	/**机器猫逆回购实体模型路径**/
	public static final String JQM_JY_ZNHG_ENTITY_NAME = "com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhg";
	/**机器猫交易证券买卖实体路径*/
	public static final String JQM_JY_ZQMM_ENTITY_NAME = "com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZqmm";
	/**新二级债指令实体路径*/
	public static final String JQM_JY_XQJY_ENTITY_NAME = "com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultInstruct";
	
	
	/*** =======================数据模型实体路径常量======end============ */
	
	
	/*******************************************componentName Begin***************************************/
	
	/**调用机器猫正逆回购componentName路径*/
	public static final String JQM_ORDER_ZNHG_COMPONENT_NAME = "com.cjhxfund.jy.ProductProcess.JY_ZNHG";
	
	/**调用机器猫债券买卖componentName路径*/
	public static final String JQM_ORDER_ZQMM_COMPONENT_NAME = "com.cjhxfund.jy.ProductProcess.JY_ZQMM";
	
	/**机器猫查询逻辑的componentName路径*/
	public static final String JQM_CFJY_PRODUCT_PROCESS_COMPONENT_NAME = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz";
	
	/**机器猫查询逻辑的componentName路径一级债指令废弃*/ 
	public static final String JQM_FIRST_GRADEBOND_PROCESS_COMPONENT_NAME ="com.cjhxfund.jy.process.FirstGradeBond.debtInterface";
	
	/*******************************************componentName End***************************************/
	
	
	/*******************************************Biz Begin***************************************/
	/**获取债券买卖订单流程状态Biz*/
	public static final String  JQM_QUERY_ORDER_ZQMM_PROCESS_STATUS_BIZ_METHOD = "getProcessStatus_ZQMM";
	/**获取债券买卖订单交易状态Biz*/
	public static final String JQM_QUERY_ORDER_ZQMM_VALID_STATUS_BIZ_METHOD ="getValidStatus_ZQMM";
	/**债券买卖撤销订单Biz*/
	public static final String JQM_ORDER_ZQMM_DELETE_BIZ_METHOD = "JY_ZQMM_CMB_delete";//"JY_ZQMM_delete";
	
	
	/**获取正逆回购订单流程状态Biz*/
	public static final String JQM_QUERY_ORDER_ZNHG_PROCESS_STATUS_BIZ_METHOD = "getProcessStatus_ZNHG";
	/**获取正逆回购订单交易状态Biz*/
	public static final String JQM_QUERY_ORDER_ZNHG_VALID_STATUS_BIZ_METHOD = "getValidStatus_ZNHG";
	/**正逆回购撤销订单Biz*/
	public static final String JQM_ORDER_ZNHG_DELETE_BIZ_METHOD ="JY_ZNHG_CMB_delete";// "JY_ZNHG_delete" ;
	
	
	/**银行间或交易所质押式回购指令下达逻辑流方法*/
	public static final String JQM_ZNHG_ORDER_ADD_BIZ_METHOD ="JY_ZNHG_add_Order";
	/**银行间或交易所质押式回购指令修改逻辑流方法*/
	public static final String JQM_ZNHG_ORDER_UPDATE_BIZ_METHOD = "JY_ZNHG_update_Order";
	
	
	/**机器猫指令下达逻辑流方法*/
	public static final String JQM_ZQMM_ORDER_ADD_BIZ_METHOD = "JY_ZQMM_Save";
	/**机器猫指令修改逻辑流方法*/
	public static final String JQM_ZQMM_ORDER_UPDATE_BIZ_METHOD = "JY_ZQMM_Update_Order";
	

	/**通过证券代码和市场交易码获取投资产品信息逻辑流方法*/
	public static final String JQM_INVEST_PRODUCTINFO_LOGIC_METHOD = "getInvestProductInfoByMarketNoAndReportCode";
	/**根据搜索关键字搜索机器猫相应投资产品的信息的逻辑流方法*/
	public static final String JQM_INVEST_PRODUCTS_BYKEY_LOGIC_METHOD = "getInvestProductsByKey";
	
	/**机器猫废弃biz方法*/
	public static final String JQM_FIRSTGRADE_BONDE_ABANDONED_LOGIC_METHOD = "firstGradeBondeAbandoned";
	
	/*******************************************Biz End***************************************/
	
	
	/******************************表序列Begin******************************/
	
	/**一级市场表序列*/
	public static final String SEQ_CJAPI_P_MARKET = "SEQ_CJAPI_P_MARKET";
	/**一级市场成交反馈表序列*/
	public static final String SEQ_CJAPI_P_MARKET_BACK = "SEQ_CJAPI_P_MARKET_BACK";
	/**银行间二级市场指令表序列*/
	public static final String SEQ_CJAPI_B_S_MARKET = "SEQ_CJAPI_B_S_MARKET";
	/**银行间二级市场反馈表序列*/
	public static final String SEQ_CJAPI_B_S_MARKET_BACK = "SEQ_CJAPI_B_S_MARKET_BACK";
	/**交易所二级市场指令表序列*/
	public static final String SEQ_CJAPI_E_S_MARKET = "SEQ_CJAPI_E_S_MARKET";
	/**交易所二级市场反馈表序列*/
	public static final String SEQ_CJAPI_E_S_MARKET_BACK = "SEQ_CJAPI_E_S_MARKET_BACK";
	/**银行间质押式回购指令表序列*/
	public static final String SEQ_CJAPI_B_P_REPO = "SEQ_CJAPI_B_P_REPO";
	/**银行间质押式回购反馈序列*/
	public static final String SEQ_CJAPI_B_P_REPO_BACK = "SEQ_CJAPI_B_P_REPO_BACK";
	/**交易所质押式回购指令表序列*/
	public static final String SEQ_CJAPI_E_P_REPO = "SEQ_CJAPI_E_P_REPO";
	/**交易所质押式回购反馈表序列*/
	public static final String SEQ_CJAPI_E_P_REPO_BACK = "SEQ_CJAPI_E_P_REPO_BACK";
	/**字典综合表序列*/
	public static final String SEQ_CJAPI_DICT_CONFIG = "SEQ_CJAPI_DICT_CONFIG";
	/**参数检测序列*/
	public static final String SEQ_CJAPI_PARAM_CHECK = "SEQ_CJAPI_PARAM_CHECK";
	/**中标确认信息表序列*/
	public static final String SEQ_CJAPI_BID_CONFIRM_INFO = "SEQ_CJAPI_BID_CONFIRM_INFO";
	
	/**质押券信息表序列*/
	public static final String SEQ_CJAPI_PLEDGE_STAMPS = "SEQ_CJAPI_PLEDGE_STAMPS";

	/******************************表序列End******************************/
	
	
	
	/***  =======================本地留痕表名常量======Begin============  */
	
	/*** 一级市场指令 **/
	public static final String PRIMARK_MARKET_TABLE_NAME = "T_ATS_CJAPI_P_MARKET";
	/***银行间二级市场指令**/
	public static final String BANK_SECOND_MARKET_TABLE_NAME ="T_ATS_CJAPI_B_S_MARKET";
	/***银行间质押式回购指令**/
	public static final String BANK_PLEDGE_REPO_TABLE_NAME="T_ATS_CJAPI_B_P_REPO";
	/**交易所二级市场指令*/
	public static final String EXCHANGE_SECOND_TABLE_NAME = "T_ATS_CJAPI_E_S_MARKET";
	/**交易所质押式回购指令**/
	public static final String EXCHANGE_PLEDGE_REPO_TABLE_NAME = "T_ATS_CJAPI_E_P_REPO";
	
	
	
	/***  =======================招行接口namespace======Begin============  */
	/***质押式成交反馈 **/
	public static final String REPO_BACK_NAMESPACE = "http://CMB.GMS.BT.BTTS.ZRDealRecv";
	/***指令状态反馈**/
	public static final String ORDER_STATE_NAMESPACE ="http://CMB.GMS.BT.BTTS.OrderState";
	/***中标信息返回**/
	public static final String BIDCFG_NAMESPACE = "http://CMB.GMS.BT.BTTS.BidCfg";
	/***债券成交反馈**/
	public static final String MARKET_BACK_NAMESPACE = "http://CMB.GMS.BT.BTTS.BondDealRecv";
	/**中标确认新债推送*/
	public static final String BIDCFG_STOCK_INFO = "http://CMB.GMS.BT.BTTS.NBInfoRecv";
	
	/***=====================指令交收状态  09:后台已成交,11:担保交收,14:作废,15:过期==========================*/
	public static final String DEAL_STATUS_DEALED="09";
	
	public static final String DEAL_STATUS_GUARANTEE="11";
	
	public static final String DEAL_STATUS_CANCEL="14";
	
	public static final String DEAL_STATUS_OVERDUE="15";
}
