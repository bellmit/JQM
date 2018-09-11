package com.cjhxfund.cjapi.feedback;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.eos.common.transaction.ITransactionDefinition;
import com.eos.common.transaction.ITransactionManager;
import com.eos.common.transaction.TransactionManagerFactory;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;

import commonj.sdo.DataObject;

/**
 * 交易所买卖和回购的成交反馈
 * @author chenxing
 *
 */
@Bizlet("")
public class ExchangeBuyFeedBack {
	//查询次数
	private static int countNumber;
	//记录错误、0=无 ， 1=有  ，2=交叉匹配数据时没有匹配到数据
	private static int errorCnt;
	//是否已经反馈  0=未反馈  ， 1=已反馈
    private static int isSendCMS;
    //是否保存了O32的落地数据
    private static boolean isSaveO32Data;
	@Bizlet("")
	public static void doExchangeBuyJob() {
			ExchangeBuyFeedBack efb = new ExchangeBuyFeedBack();
			if(ParamConfig.getValue("atsExchangeToCMSNumber")!=null && !"".equals(ParamConfig.getValue("atsExchangeToCMSNumber"))){
			     countNumber = Integer.parseInt(ParamConfig.getValue("atsExchangeToCMSNumber"));
	        }else{
	        	countNumber=3;
	        }
			errorCnt=0;
			isSendCMS=0;
			isSaveO32Data=false;
			//将定时在每天16点钟触发
			LogUtil.logInfo("【ExchangeFeedBack (doExchangeJob)】启动交易所买卖的成交反馈。。。", null);
			int counts = 0;
			while (counts < countNumber) {
			    try {
			    	//如果没有保存就查询后，再发招行及其它操作。
			    	if(!isSaveO32Data){
					    //交易所债券买卖查询O32成交记录
					    efb.selAndSaveBuyFeedBackInfo();
			    	}else{
			    		//交叉匹配数据，并发送招行和保存交易所债券买卖成交反馈
						efb.exchangeBuyFeedBack();
			    	}
					if (counts >= countNumber || errorCnt==0) {
						break;
					}
				}catch (Exception e) {
					errorCnt=1;
					//如果报错，说明还有未反馈
					isSendCMS=0;
					LogUtil.logError("【ExchangeFeedBack (doExchangeJob)】交易所债债券买卖业务成交反馈出错："
									+ e.getMessage(), null);
				}finally{
					counts++;
				}
			}
			LogUtil.logInfo("【ExchangeFeedBack (doExchangeJob)】结束交易所买卖的成交反馈。。。", null);
		
	}

	/**
	 * 查询出当天的债券买卖成交反馈信息,并保存到临时表
	 * 然后，再调用发送招行接口方法
	 */
	public void selAndSaveBuyFeedBackInfo() {
		String dealDate = "";
		String settleDate = "";
		String reportCode = "";
		BigDecimal faceCount = null;
		BigDecimal faceCountUnit = null;
		String CStatus = "";
		BigDecimal enNetBalance = null;
		BigDecimal vcTradeRivalResult = null;
		String prodCode = "";
		BigDecimal lAmount = null;
		BigDecimal enBalance = null;
		String enDirection = "";
		String businessMarket = "";
		BigDecimal unit = new BigDecimal(10000);
		String vcDealNo="";
		String vcDealTime="";

		try {
			//获取买卖的成交反馈数据
			Object[] finishDealResponseArr = DatabaseExt
					.queryByNamedSql(
							CacheUtil.getO32CacheDataSourceName(),
							"com.cjhxfund.cjapi.feedback.ExchangeFeedBack.queryO32ExchangeBuyFeedBackInfo",
							null);
			if (finishDealResponseArr == null
					|| finishDealResponseArr.length == 0) {
				return;
			}
			Map<String, Object> buildParamMap = new HashMap<String, Object>();
			//组装数据
			for (Object finishDealResponse : finishDealResponseArr) {

				DataObject dealData = (DataObject) finishDealResponse;
				//成交编号
				vcDealNo=dealData.getString("VC_DEAL_NO");
				//成交日期
				dealDate = dealData.getString("L_DATE");
				//成交时间
				vcDealTime=dealData.getString("VC_DEAL_TIME");
				//产品ID
				prodCode = dealData.getString("L_FUND_ID");
				//指令数量
				lAmount = dealData.getBigDecimal("L_AMOUNT");
				//净价价格
				enBalance = dealData.getBigDecimal("EN_BALANCE");
				//交易方向
				enDirection = dealData.getString("C_ENTRUST_DIRECTION");
				//交割日期
				settleDate = dealData.getString("L_SETTLE_DATE");
				//债券代码
				reportCode = dealData.getString("VC_REPORT_CODE");
				//交易市场
				businessMarket = dealData.getString("C_MARKET_NO");
				//券面总额
				faceCount = dealData.getBigDecimal("FACE_COUNT");
				faceCountUnit = faceCount.divide(unit);
				//成交状态
				CStatus = dealData.getString("CSTATUS");
				//净价金额
				enNetBalance = dealData.getBigDecimal("EN_NET_BALANCE");
				//最后输出给招行的净价金额
				vcTradeRivalResult = enNetBalance.divide(unit);
				//开始组装数据
				buildParamMap
						.put("seqNo",
								DatabaseExt
										.getNextSequence(CJAPIConstants.SEQ_CJAPI_E_S_MARKET_BACK));
				buildParamMap.put("lDealDate", dealDate);
				buildParamMap.put("lSettDate", settleDate);
				buildParamMap.put("vcStockCode", reportCode);
				buildParamMap.put("enQtyBalance", faceCountUnit);
				buildParamMap.put("vcProceStatus", CStatus);
				buildParamMap.put("vcTradeRival", vcTradeRivalResult);

				buildParamMap.put("prodCode", prodCode);
				buildParamMap.put("lAmount", lAmount);
				buildParamMap.put("enBalance", enBalance);
				buildParamMap.put("enDirection", enDirection);
				buildParamMap.put("businessType", "1"); //交易类型(1=债券买卖，2=债券回购)
				buildParamMap.put("businessMarket", businessMarket);
				buildParamMap.put("enDealBance",
						dealData.getBigDecimal("EN_DEAL_BALANCE").divide(unit)); //成交金额
				buildParamMap.put("enDealAmount",
						dealData.getBigDecimal("L_DEAL_AMOUNT")); //成交数量
				buildParamMap.put("enDealPrice",
						dealData.getBigDecimal("EN_DEAL_PRICE")); //成交价格
				buildParamMap.put("vcDealNo", vcDealNo);
				buildParamMap.put("vcDealTime", vcDealTime);
				LogUtil.logInfo(
						"【ExchangeFeedBack (selAndSaveBuyFeedBackInfo)】交易所债债券买卖成交反馈保存临时表数据集：{0}",
						null, buildParamMap);
				//检查当前需要插入数据中是否已经插入过
				int count = DatabaseExt.countByNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.feedback.ExchangeFeedBack.countExchangeBuyRepoFeedback",
						buildParamMap);
				//保存信息
				if(count==0){
				      DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT,"com.cjhxfund.cjapi.feedback.ExchangeFeedBack.insertExchangeBuyRepoFeedback",
								buildParamMap);
				}
			}
			//已保存O32数据
			isSaveO32Data=true;
			//交叉匹配数据，并发送招行和保存交易所债券买卖成交反馈
			exchangeBuyFeedBack();
			LogUtil.logInfo("【ExchangeFeedBack (selAndSaveBuyFeedBackInfo)】交易所债债券买卖成交反馈错误记录标志：{0}",
					null, errorCnt);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			errorCnt=1;
			//如果报错，说明还有未反馈
			isSendCMS=0;
			LogUtil.logError(
					"【ExchangeFeedBack (selAndSaveBuyFeedBackInfo)】交易所债债券买卖成交反馈出错：{0}"
							+ e.getMessage(), null);
			e.printStackTrace();
		}

	}

	/**
	 * 获取vcClordID并发送招行，保存交易所债券买卖成交反馈
	 * paramList 需要发送到招行的数据集
	 * 
	 */
	public void exchangeBuyFeedBack() throws Exception {
		//查询出数据发给招行
			Object[] dataArray = DatabaseExt
					.queryByNamedSql(
							CJAPIConstants.DS_DEFAULT,
							"com.cjhxfund.cjapi.feedback.ExchangeFeedBack.querySendCMBBuyData",
							null);
			//更新指令表状态 ，并插入交易所二级市场成交反馈 
			LogUtil.logInfo(
					"【Class ExchangeFeedBack(exchangeBuyFeedBack)】交易所二级市场买卖保存成交反馈表时分组后的数据:{0}",
					null, dataArray);
			if (dataArray == null || dataArray.length == 0) {
                if(isSendCMS==0){
                   isSaveO32Data=false;
				   errorCnt=2;
                }else{
                   //如果全部反馈，清零
            	   errorCnt=0;	
                }
				return ;
			}
			for (Object data : dataArray) {
				DataObject sendData = (DataObject) data;
				Map<String, Object> buildParamMap = new HashMap<String, Object>();
				buildParamMap.put("vcClordId",sendData.getString("VC_CLORD_ID"));
				buildParamMap.put("vcDealNo",sendData.getString("L_DEAL_NO"));//
				buildParamMap.put("enDealPrice", sendData.getString("L_EN_DEAL_PRICE"));   //成交价格l_en_deal_price
				buildParamMap.put("enDealBalance", sendData.getString("L_EN_DEAL_BALANCE")); //成交金额l_en_deal_balance
				buildParamMap.put("enDealAmount", sendData.getString("L_EN_DEAL_AMOUNT"));  //成交数量l_en_deal_amount
				buildParamMap.put("lDealDate", sendData.getString("L_DATE"));   //成交日期
				//和陈小甫确认传给他们的债券代码需要增加.SH和。SZ
				if("SS".equals(sendData.getString("L_BUSINESS_MARKET"))){
				   buildParamMap.put("vcStockCode", sendData.getString("L_REPORT_CODE")+".SH"); //证券代码
			    }else if("SZ".equals(sendData.getString("L_BUSINESS_MARKET"))){
			      buildParamMap.put("vcStockCode", sendData.getString("L_REPORT_CODE")+".SZ"); //证券代码
			    }else{
			    	
			    }
				buildParamMap.put("vcProceStatus", sendData.getString("L_SUC_STATUS")); //成交状态
				buildParamMap.put("lSettDate", sendData.getString("L_SETTLE_DATE")); //交割日期
				buildParamMap.put("enQtyBalance", sendData.getString("L_FACE_COUNT")); //券面金额
				//开始组装参数并调用招行接口
				String json = new Gson().toJson(buildParamMap);
				json = JSONUtil.jsonToJSON(json, "request");
				LogUtil.logInfo(
						"【Class ExchangeFeedBack(exchangeBuyFeedBack)】交易所二级市场买卖成交反馈json数据:{0}",
						null, json);
				// 回调招行接口
				String retMsg = CJAPICommonUtil.callCMBWebService(
						CJAPIConstants.MARKET_BACK_NAMESPACE, "BondDealRecv",
						"BondDeal", json);
				LogUtil.logInfo(
						"【Class ExchangeFeedBack(exchangeBuyFeedBack)】交易所二级市场买卖成交反馈招行返回信息:{0}",
						null, retMsg);
				Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
				Object result = retMap.get("result");
				if (result == null || !"000000".equals(retMap.get("result"))) {
					LogUtil.logError(
							"【Class ExchangeFeedBack(exchangeBuyFeedBack)】交易所二级市场买卖成交反馈调用招行接口失败:retMsg:{0}",
							null, retMsg);
				} else {
					LogUtil.logInfo(
							"【Class ExchangeFeedBack(exchangeBuyFeedBack)】交易所二级市场买卖成交反馈更新指令表:{0}",
							null, buildParamMap);
					buildParamMap.put("vcStockCode", sendData.getString("L_REPORT_CODE"));
				    isSendCMS=1;
					//更新银行间二级市场成交状态
					DatabaseExt
							.executeNamedSql(
									CJAPIConstants.DS_DEFAULT,
									"com.cjhxfund.cjapi.feedback.ExchangeFeedBack.updateESOrderStatus",
									buildParamMap);
					//buildParamMap.put("lSeqNo", sendData.getString("L_SEQ_NO")); //临时表的成交编号
					//更新临时表状态
					DatabaseExt
							.executeNamedSql(
									CJAPIConstants.DS_DEFAULT,
									"com.cjhxfund.cjapi.feedback.ExchangeFeedBack.updateExchangeFeedBackTempStatus",
									buildParamMap);

					buildParamMap
							.put("lBackId",
									DatabaseExt
											.getNextSequence(CJAPIConstants.SEQ_CJAPI_E_S_MARKET_BACK));
					buildParamMap.put("exchangeOrderESId",
							sendData.getString("L_EXCHANGE_SECOND_MARKET_ID"));
					buildParamMap.put("enDealBalance",
							sendData.getBigDecimal("L_EN_DEAL_BALANCE"));
					buildParamMap.put("enDealAmount",
							sendData.getBigDecimal("L_EN_DEAL_AMOUNT"));
					buildParamMap.put("enDealDate",
							sendData.getString("L_DATE"));
					buildParamMap.put("vcStockCode",
							sendData.getBigDecimal("L_REPORT_CODE"));
					buildParamMap.put("enDealPrice",
							sendData.getBigDecimal("L_EN_DEAL_PRICE"));
					buildParamMap.put("lDealTime", sendData.getString("L_DEAL_TIME"));
					CJAPICommonUtil.getCreateDateAndCreateTime(buildParamMap);
					LogUtil.logInfo(
							"【Class ExchangeFeedBack(exchangeBuyFeedBack)】交易所二级市场买卖成交反馈插入成交反馈表:{0}",
							null, buildParamMap);
					// 反馈表留痕
					DatabaseExt
							.executeNamedSql(
									CJAPIConstants.DS_DEFAULT,
									"com.cjhxfund.cjapi.feedback.ExchangeFeedBack.insertESFeedback",
									buildParamMap);
				}
			}
		   //发送成交后把错误记数器，清零
     	   errorCnt=0;	

	}

}
