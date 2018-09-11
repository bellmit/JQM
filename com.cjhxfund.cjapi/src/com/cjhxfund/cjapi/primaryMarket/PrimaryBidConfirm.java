package com.cjhxfund.cjapi.primaryMarket;

import java.util.Map;

import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.common.ParamUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.feedback.OrderFeedback;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;

import commonj.sdo.DataObject;

/***
 * 一级市场中标确认
 * @author luwenxing
 *
 */
@Bizlet("")
public class PrimaryBidConfirm {
	private String json;
	private DataObject params;
	private DataObject orderData;
	
	public PrimaryBidConfirm(String json){
		this.json = json;
	}
	
	/***
	 * 1.  记录原始参数
	 */
	public void logJson(){
		LogUtil.logInfo("[primaryBidConfirm]中标确认接收参数：{0}", null, this.json);
	}
	
	/***
	 * 2. 解析参数
	 * @return DataObject 解析后的参数
	 * @throws AppException 
	 */
	public  DataObject parseParam() throws AppException{
		this.params = ParamUtil.paramCheck(CJAPIConstants.BID_CONFIRM, json);  							// 参数检测
		return this.params;
	}
	
	/**
	 * 3. 根据第三方指令ID获取指令数据
	 * @param vcClordId  
	 * @return	指令数据
	 * @throws AppException
	 */
	public boolean getAndSetInstruction() throws AppException{
		String vcClordId = this.params.getString("vcClordId");
		DataObject orderData = PrimaryMarketUtil.getOrderByInstruction(vcClordId);
		this.orderData = orderData;
		return true;
	}
 
	public boolean canBid() throws AppException{
		if (!"0".equals(this.orderData.getString("vcOrderStatus"))) {
			throw new AppException(CJAPIConstants.ORDER_VALID_STATUS_CODE, CJAPIConstants.ORDER_VALID_STATUS_MSG);
		}
		return true;
	}
	
	/***
	 * 4. 调用机器猫下达指令
	 * @param param
	 * @throws AppException 
	 */
	 
	public Object[] callJQM() throws AppException{
		Object[] result = null;
		String vcSenderSubId = orderData.getString("vcSenderSubId");
		String vcResult = this.params.getString("vcResult");
		String retMsg = this.params.getString("vcDealMessage");
		long investNo = orderData.getLong("vcInvestNo");
		Object[] object = new Object[5];		// 机器猫接口需要3个参数
		object[0] = investNo;							// 指令编号
		object[1] = vcSenderSubId;//推送人
		object[2] = vcResult; 					// 驳回状态
		object[3] = retMsg; 	    // 驳回理由 dealMessage
		object[4] = "bidConfirm";
		// 逻辑构件名称
		String componentName ="com.cjhxfund.jy.process.FirstGradeBond.debtInterface";
		
		if(StrUtil.isNotEmpty(vcResult) && "CFG".equals(vcResult)){
			result = GenericBaseDaoSupport.invokeBizMethod(componentName, "winningConfirm", object);// 中标确认
			LogUtil.logInfo("调用机器猫中标确认接口winningConfirm===="+result, null, null, null);
		}else if(StrUtil.isNotEmpty(vcResult) && "RJT".equals(vcResult)){
			result = GenericBaseDaoSupport.invokeBizMethod(componentName, "rejectedWorkitem", new Object[]{investNo,vcSenderSubId,retMsg});
			LogUtil.logInfo("调用机器猫中标驳回接口rejectedWorkitem===="+result, null, null, null);
		}else{
			String paramRegMsg = CJAPIConstants.PARAM_REG_MSG;
			String tipMsg = String.format(paramRegMsg, "vcResult","CFG或RJT");
			LogUtil.logError(tipMsg, null, null, null);
			throw new AppException(CJAPIConstants.PARAM_REG_CODE,tipMsg);
		}
		
		return result;
	}
	
	/**
	 * 5. 处理机器猫返回的结果。机器猫返回结果：0-成功 1-失败
	 * @param resultObjs
	 * @throws AppException
	 */
	public void dealJQMResult(Object[] resultObjs,DataObject parseParam) throws AppException{
		String retJson =  new Gson().toJson(resultObjs[0]);
		Map<String, Object> jqmRetMap = JSONUtil.jsonToMap(retJson);	// 机器猫返回的结果
		Object returnCode = jqmRetMap.get("returnCode");//机器猫返回的状态码
		String vcSenderSubId = this.orderData.getString("vcSenderSubId");//推送人
		long investNo = this.orderData.getLong("vcInvestNo");//投资编号
		String vcResult = parseParam.getString("vcResult");//处理结果(1中标确认成功,2中标失败,3-驳回成功,4-驳回失败)
		String  vcClordId = parseParam.getString("vcClordId");
		String vcDealMessage = "",msg ="" ;
		if(parseParam.isSet("vcDealMessage") && parseParam.getString("vcDealMessage")!=null){
			vcDealMessage = parseParam.getString("vcDealMessage");//驳回时必填
		}
		// 提交失败
		if (returnCode == null || !returnCode.equals("0")){
			LogUtil.logError("中标确认提交机器猫失败,vcSenderSubId:{0},vcInvestNo={1}, {2} ", null, vcSenderSubId, investNo, this.json);
			//CFG-确认中标，RJT-驳回
			if(StrUtil.isNotEmpty(vcResult) && "CFG".equals(vcResult)){
				updateBidConfirmInfoByClordId(vcResult, vcDealMessage,"2",vcClordId);
				//确认失败
				 msg = String.format(CJAPIConstants.BID_CONFIRM_FAIL_RET_MSG1,vcClordId);
				throw new AppException(CJAPIConstants.BID_CONFIRM_FAIL_RET_CODE1,msg);
			}
			if(StrUtil.isNotEmpty(vcResult) && "RJT".equals(vcResult)){
				updateBidConfirmInfoByClordId(vcResult, vcDealMessage,"4",vcClordId);
				//驳回失败
				 msg = String.format(CJAPIConstants.BID_CONFIRM_FAIL_RET_MSG2,vcClordId);
				throw new AppException(CJAPIConstants.BID_CONFIRM_FAIL_RET_CODE2,msg);
			}
		} else {
			//CFG-确认中标，RJT-驳回
			if(StrUtil.isNotEmpty(vcResult) && "CFG".equals(vcResult)){
				updateBidConfirmInfoByClordId(vcResult, vcDealMessage,"1",vcClordId);
				//确认成功
				msg = String.format(CJAPIConstants.BID_CONFIRM_SUCCESS_RET_MSG1,vcClordId);
				LogUtil.logInfo(msg, null, null, null);
			}
			if(StrUtil.isNotEmpty(vcResult) && "RJT".equals(vcResult)){
				updateBidConfirmInfoByClordId(vcResult, vcDealMessage,"3",vcClordId);
				//驳回成功
				msg = String.format(CJAPIConstants.BID_CONFIRM_SUCCESS_RET_MSG2,vcClordId);
				LogUtil.logInfo(msg, null, null, null);
			}
			// 提交成功
			LogUtil.logInfo("中标确认结果信息,vcSenderSubId:{0},vcInvestNo={1},{2} ", null, vcSenderSubId, investNo, this.json);
		}
	}
	/**
	 * @Description 更新中标确认回填状态信息
	 * @Author		liangjilong
	 * @Date		2017年3月16日 下午2:52:27
	 * @param vcResult 中标确认状态(CFG-确认中标，RJT-驳回）
	 * @param vcDealMessage 驳回理由(驳回时必填)
	 * @param vcDealResult 处理结果(1中标确认成功,2中标失败,3-驳回成功,4-驳回失败)
	 * @return 		void 返回类型
	 */
	private void updateBidConfirmInfoByClordId(String vcResult, String vcDealMessage,String vcDealResult,String vcClordId) {
		DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		CJAPICommonUtil.getUpdateDateAndUpdateTime(data);//更新时间
		data.set("vcDealResult", vcDealResult);
		data.set("vcDealMessage", vcDealMessage);
		data.set("vcBidStatus", vcResult);
		data.set("vcClordId", vcClordId);
		String sqlxId = "com.cjhxfund.cjapi.WSPrimaryMarketns.updateBidConfirmInfoByClordId";
		DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT,sqlxId, data);
	}
	 
}
