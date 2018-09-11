package com.cjhxfund.cjapi.feedback;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;

import commonj.sdo.DataObject;

/**
 * 招行指令反馈
 * 
 * yhjSecondMarketFeedback
 * jysSecondMarketFeedback
 * 这两个方法是预留
 * @author wuzhengxin
 *
 */
@Bizlet("")
public class CMBBankFeedback {
	
	@Bizlet("")
	public static void doTaskJob(){
		CMBBankFeedback job = new CMBBankFeedback();
		try {
			LogUtil.logInfo("2.0成交反馈接口 [CMBBankFeedback] 开始", null);
			job.yhjSecondMarketFeedback();
			job.jysSecondMarketFeedback();
			job.pledgeRepoFeedback(); 
			LogUtil.logInfo("2.0成交反馈接口 [CMBBankFeedback] 结束", null);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 交易所二级市场指令反馈（前台成交，查的是o32的数据）
	 */
	@Bizlet("")
	public void jysSecondMarketFeedback() throws Exception {
		// 1. 读表获取未完成的所以指令
		Object[] unfinishedObjs = DatabaseExt.queryByNamedSql(
				CJAPIConstants.DS_DEFAULT,
				"com.cjhxfund.cjapi.OrderFeedbackns.queryESUnfinishNewOrders",
				null);
		if (unfinishedObjs == null || unfinishedObjs.length == 0) {
			return;
		}

		for (Object unfinishedObj : unfinishedObjs) {
			DataObject unfinishedData = (DataObject) unfinishedObj;
			// 从O32查找银行间二级市场成交信息
			LogUtil.logInfo("2.0交易所定时器节点数据源：{0},参数：{1}", null,
					CacheUtil.getO32CacheDataSourceName(), unfinishedData);
			Object[] dealObjs = DatabaseExt.queryByNamedSql(
					CacheUtil.getO32CacheDataSourceName(),
					"com.cjhxfund.cjapi.OrderFeedbackns.queryO32ESDealData",
					unfinishedData);
			if (dealObjs == null || dealObjs.length == 0) {
				continue;
			}
			DataObject dealData = (DataObject) dealObjs[0];

			// 准备回调招行和入库留痕参数
			Map<String, Object> cmbMap = new HashMap<String, Object>();
			cmbMap.put("vcClordId", unfinishedData.getString("VC_CLORD_ID"));
			
			// 成交金额=成交价格*成交数量.金额统一使用万元作为单位
			BigDecimal enDealAmount=new BigDecimal(dealData.getString("L_DEAL_AMOUNT"));
			BigDecimal enDealPrice=new BigDecimal(dealData.getString("EN_DEAL_PRICE"));
			dealData.setString("EN_DEAL_BALANCE", enDealPrice.multiply(enDealAmount).toString());
			
			cmbMap.put("enDealBalance",
					(new BigDecimal(dealData.getString("EN_DEAL_BALANCE")))
							.divide(new BigDecimal(10000)));// 交易金额
			cmbMap.put("enDealAmount", dealData.getString("L_DEAL_AMOUNT"));// 交易数量
			//券面金额=面额*数量（面额都为100)
			Integer enQtyBalanceInt =Integer.parseInt(dealData.getString("L_DEAL_AMOUNT"))*100;
			BigDecimal enQtyBalanceBig=new BigDecimal(enQtyBalanceInt);
			BigDecimal unit=new BigDecimal(10000);//万元
			cmbMap.put("enQtyBalance", enQtyBalanceBig.divide(unit));//单位元转万元
			cmbMap.put("vcDealNo", dealData.getString("VC_DEAL_NO"));// 成交编号
			cmbMap.put("lDealDate", dealData.getString("L_DATE"));// 交易时间
			cmbMap.put("vcStockCode",
					unfinishedData.getString("VC_BOND_CODE_EXTERNAL"));// 代码
			cmbMap.put("enDealPrice", dealData.getString("EN_DEAL_PRICE"));// 交易价格（全价）
			cmbMap.put("vcProceStatus", dealData.getString("C_STATUS"));//完成状态
			cmbMap.put("lSettDate", dealData.getString("L_SETTLE_DATE"));//交割日期

			// 先保留回调招行的参数
			String json = new Gson().toJson(cmbMap);
			json = JSONUtil.jsonToJSON(json, "request");
			LogUtil.logInfo("2.0交易所二级市场成交反馈:{0}", null, json);

			// 回调招行接口
			String retMsg = CJAPICommonUtil.callCMBWebService(
					CJAPIConstants.MARKET_BACK_NAMESPACE, "BondDealRecv",
					"BondDeal", json);
			LogUtil.logInfo("2.0交易所二级市场成交反馈回调招行返回信息:{0}", null, retMsg);

			//测试代码
//			Map<String, Object> retMap = new HashMap<String,Object>();
//			retMap.put("result", "000000");
			
			Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
			Object result = retMap.get("result");
			if (result == null || !"000000".equals(retMap.get("result"))) {
				LogUtil.logError("2.0交易所二级市场成交反馈调用招行接口失败:retMsg:{0}", null, retMsg);
			} else {
				//插入银行间二级市场成交反馈 
				// 补全所需的参数
				cmbMap.put("lExchangeSecondMarketId",
						unfinishedData.get("L_EXCHANGE_SECOND_MARKET_ID"));
				CJAPICommonUtil.getCreateDateAndCreateTime(cmbMap);
				cmbMap.put(
						"lBackId",
						DatabaseExt
								.getNextSequence(CJAPIConstants.SEQ_CJAPI_E_S_MARKET_BACK));

				// 更新银行间二级市场成交状态
				dealData.set("L_EXCHANGE_SECOND_MARKET_ID",
						unfinishedData.get("L_EXCHANGE_SECOND_MARKET_ID"));
				DatabaseExt
						.executeNamedSql(
								CJAPIConstants.DS_DEFAULT,
								"com.cjhxfund.cjapi.OrderFeedbackns.updateESOrderStatus",
								dealData);
				// 反馈表留痕
				cmbMap.put("lDealTime", dealData.getString("L_BUSINESS_TIME"));
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT,
						"com.cjhxfund.cjapi.OrderFeedbackns.insertESFeedback",
						cmbMap);
			}
		}
	}
	
	
	/***
	 * 银行间二级市场指令反馈（前台成交，查的是o32的数据）
	 * @throws Exception 
	 */
	@Bizlet("")
	public void yhjSecondMarketFeedback() {
		
		try{
			// 1. 读表获取未完成的所以指令
			Object[] unfinishedObjs = DatabaseExt.queryByNamedSql(
					CJAPIConstants.DS_DEFAULT,
					"com.cjhxfund.cjapi.OrderFeedbackns.queryBSUnfinishNewOrders",
					null);
			if (unfinishedObjs == null || unfinishedObjs.length == 0) {
				return;
			}
			for (Object unfinishedObj : unfinishedObjs) {
				DataObject unfinishedData = (DataObject) unfinishedObj;
				try{
					// 从O32查找银行间二级市场成交信息
					LogUtil.logInfo("招行定时器节点数据源：{0},参数：{1}", null,
							CacheUtil.getO32CacheDataSourceName(), unfinishedData);
					Object[] dealObjs = DatabaseExt.queryByNamedSql(
							CacheUtil.getO32CacheDataSourceName(),
							"com.cjhxfund.cjapi.OrderFeedbackns.queryO32BSDealData",
							unfinishedData);
					if (dealObjs == null || dealObjs.length == 0) {
						continue;
					}
					DataObject dealData = (DataObject) dealObjs[0];

					// 准备回调招行和入库留痕参数
					Map<String, Object> cmbMap = new HashMap<String, Object>();
					cmbMap.put("vcClordId", unfinishedData.getString("VC_CLORD_ID"));
					// 金额统一使用万元作为单位
					if (dealData.getString("EN_DEAL_BALANCE") == null
							|| "".equals(dealData.getString("EN_DEAL_BALANCE"))) {
						dealData.setString("EN_DEAL_BALANCE", "0");
					}
					cmbMap.put("enDealBalance",
							(new BigDecimal(dealData.getString("EN_DEAL_BALANCE")))
									.divide(new BigDecimal(10000)));// 交易价格
					cmbMap.put("enDealAmount", dealData.getString("L_DEAL_AMOUNT"));// 交易数量
					cmbMap.put("lDealDate", dealData.getString("L_DATE"));// 交易时间
					cmbMap.put("vcStockCode",
							unfinishedData.getString("VC_BOND_CODE_EXTERNAL"));// 代码
					cmbMap.put("vcSettType", dealData.getString("C_FIRST_SETTLE_TYPE"));// 类型
					cmbMap.put("lSettDate", dealData.getString("L_FIRST_SETTLE_DATE"));// 设置时间
					cmbMap.put("enFullPrice", dealData.getString("EN_FIRST_FULL_PRICE"));// 全价
					cmbMap.put("vcTradeRivalName",
							dealData.getString("VC_RIVALTRADER_NAME"));// 对手名字
					// 金额统一使用万元作为单位
					if (dealData.getString("EN_BALANCE") == null
							|| "".equals(dealData.getString("EN_BALANCE"))) {
						dealData.setString("EN_BALANCE", "0");
					}
					cmbMap.put("enQtyBalance",
							(new BigDecimal(dealData.getString("EN_BALANCE")))
									.divide(new BigDecimal(10000)));
					cmbMap.put("vcProceStatus", dealData.getString("C_STATUS"));

					// 先保留回调招行的参数
					String json = new Gson().toJson(cmbMap);
					json = JSONUtil.jsonToJSON(json, "request");
					LogUtil.logInfo("银行间二级市场成交反馈:{0}", null, json);

					// 回调招行接口
					String retMsg = CJAPICommonUtil.callCMBWebService(
							CJAPIConstants.MARKET_BACK_NAMESPACE, "BondDealRecv",
							"BondDeal", json);
					LogUtil.logInfo("银行间二级市场成交反馈回调招行返回信息:{0}", null, retMsg);

					Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
					Object result = retMap.get("result");
					if (result == null || !"000000".equals(retMap.get("result"))) {
						LogUtil.logError("银行间二级市场成交反馈调用招行接口失败:retMsg:{0}", null, retMsg);
					} else {
						/** 插入银行间二级市场成交反馈 */
						// 补全所需的参数
						cmbMap.put("lBankSecondMarketId",
								unfinishedData.get("L_BANK_SECOND_MARKET_ID"));
						CJAPICommonUtil.getCreateDateAndCreateTime(cmbMap);
						cmbMap.put(
								"lBackId",
								DatabaseExt
										.getNextSequence(CJAPIConstants.SEQ_CJAPI_B_S_MARKET_BACK));

						// 更新银行间二级市场成交状态
						dealData.set("L_BANK_SECOND_MARKET_ID",
								unfinishedData.get("L_BANK_SECOND_MARKET_ID"));
						DatabaseExt
								.executeNamedSql(
										CJAPIConstants.DS_DEFAULT,
										"com.cjhxfund.cjapi.OrderFeedbackns.updateBSOrderStatus",
										dealData);
						// 反馈表留痕
						DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT,
								"com.cjhxfund.cjapi.OrderFeedbackns.insertBSFeedback",
								cmbMap);
					}
				}catch(Exception e){
					LogUtil.logError("2.0银行间二级市场成交反馈调用招行接口失败:L_BANK_SECOND_MARKET_ID:{0}", null,unfinishedData.get("L_BANK_SECOND_MARKET_ID"));
					continue;
				}
			}
		}catch(Exception e){
			LogUtil.logError("2.0银行间二级市场成交反馈异常", e,"");
		}
	}
	
	/***
	 * 银行间质押式回购指令反馈
	 * @throws Exception 
	 */
	public void pledgeRepoFeedback(){
		
		try{
			// 读取未完成的指令
			Object[]  unfinishedCordIdObjs =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
					"com.cjhxfund.cjapi.OrderFeedbackns.queryBPUnfinishOrder", null);
			if (unfinishedCordIdObjs == null || unfinishedCordIdObjs.length == 0) { 
				return;
			}
			for (Object unfinishedObj : unfinishedCordIdObjs) {
				DataObject unfinishData = (DataObject)unfinishedObj;
				try{
					// 从O32查找银行间质押式回购指令信息
					Object[] dealObjs = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
							"com.cjhxfund.cjapi.OrderFeedbackns.queryO32BPRDealData", unfinishData);
					if (dealObjs == null || dealObjs.length ==0) {
						continue;
					}
					DataObject dealData = (DataObject)dealObjs[0];		//成交数据
					dealData.set("L_BANK_PLEDGE_REPO_ID", unfinishData.get("L_BANK_PLEDGE_REPO_ID"));
					// 从O32查找银行间质押式回购成交债券信息
					Object[] bondObjs = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
							"com.cjhxfund.cjapi.OrderFeedbackns.queryO32BPRDealBondInfo", unfinishData);
					if (bondObjs == null || bondObjs.length ==0) {
						continue;
					}
					// 回调招行接口参数准备
					Map<String, Object> mapMain = new HashMap<String, Object>();
					mapMain.put("vcClordId", unfinishData.getString("VC_CLORD_ID"));
					mapMain.put("vcClearSpeed", dealData.getString("L_SETTLE_SPEED")); 
					mapMain.put("enDealPrice", dealData.getString("EN_RATE"));
					mapMain.put("lDealDate", dealData.getString("L_DATE"));
					//金额统一使用万元作为单位
					if(dealData.getString("EN_DEAL_BALANCE")==null||"".equals(dealData.getString("EN_DEAL_BALANCE"))){
						dealData.setString("EN_DEAL_BALANCE","0");
					}
					mapMain.put("enDealBalance", (new BigDecimal(dealData.getString("EN_DEAL_BALANCE"))).divide(new BigDecimal(10000)));
					mapMain.put("enInterest", dealData.getString("EN_HG_INTEREST"));
					mapMain.put("vcFutSettType", dealData.getString("C_FIRST_SETTLE_TYPE"));
					mapMain.put("vcLutSettType", dealData.getString("C_SECOND_SETTLE_TYPE"));
					mapMain.put("lFutSettDate", dealData.getString("L_FIRST_SETTLE_DATE"));
					mapMain.put("lLutSettDate", dealData.getString("L_SECOND_SETTLE_DATE"));
					mapMain.put("enTradeRivalId", dealData.getString("L_TRADE_RIVAL_NO"));
					
					mapMain.put("vcTradeRivalName", dealData.getString("VC_RIVALTRADER_NAME"));
					//金额统一使用万元作为单位
					if(dealData.getString("EN_BALANCE")==null||"".equals(dealData.getString("EN_BALANCE"))){
						dealData.setString("EN_BALANCE","0");
					}
					mapMain.put("enQtyBalance", (new BigDecimal(dealData.getString("EN_BALANCE"))).divide(new BigDecimal(10000)));
					mapMain.put("vcProceStatus", dealData.getString("C_STATUS"));
					mapMain.put("enDealAmount", dealData.getString("L_DEAL_AMOUNT"));
					
					Map<String, Object> feedbackMap =  new HashMap<String, Object>();
					feedbackMap.putAll(mapMain);		

					List<BondInfo> bondList = new ArrayList<BondInfo>(bondObjs.length);
					for (Object bondObj : bondObjs) {
						DataObject bondData = (DataObject)bondObj;
						BondInfo bond = new BondInfo();
						bond.vcClordId = unfinishData.getString("VC_CLORD_ID");
						bond.vcBondCode = bondData.getString("VC_REPORT_CODE");
//						bond.vcBondName = bondData.getString("VC_STOCK_NAME");
						bond.enPledgeRatio = bondData.getString("EN_RATIO");
						bond.enPledeQty = bondData.getString("L_MORTAGAGE_AMOUNT");
						bondList.add(bond);
					}
					
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("Main", mapMain);
					map.put("Bond", bondList);
					String json = new Gson().toJson(map);
					json = JSONUtil.jsonToJSON(json, "request");
					LogUtil.logInfo("银行间质押式回购成交反馈:{0}", null, json);
					System.out.println("银行间质押式回购成交反馈:"+json);
					String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.REPO_BACK_NAMESPACE,"ZRDealRecv", "ZRDeal", json);
					LogUtil.logInfo("银行间质押式回购成交反馈回调招行返回信息:{0}", null, retMsg);

					Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
					Object result = retMap.get("result");
					if(result == null || !"000000".equals(retMap.get("result"))){
						LogUtil.logError("银行间质押式回购成交反馈调用招行接口失败:retMsg:{0}", null, retMsg);
						System.out.println("银行间质押式回购成交反馈调用招行接口失败:retMsg:{"+retMsg+"}");
					}else{
						//配合本地留痕用vc来存储
						mapMain.put("vcTradeRivalId", mapMain.get("enTradeRivalId"));
						feedbackMap.putAll(mapMain);
						
						/**插入银行间质押式回购成交反馈**/
						feedbackMap.put("lBankPledgeRepoId", unfinishData.get("L_BANK_PLEDGE_REPO_ID"));
						CJAPICommonUtil.getCreateDateAndCreateTime(feedbackMap);
						feedbackMap.put("lBackId", DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_B_P_REPO_BACK));
						
						// 更新银行间质押式回购成交状态
						DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
								"com.cjhxfund.cjapi.OrderFeedbackns.updateBankPledgeRepoOrderStatus", dealData);
						//反馈表留痕
						DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.OrderFeedbackns.insertBankPledgeRepoFeedback", feedbackMap);
					}
				}catch(Exception e){
					LogUtil.logError("银行间质押式回购成交反馈异常,L_BANK_PLEDGE_REPO_ID:{0}",e, unfinishData.get("L_BANK_PLEDGE_REPO_ID"));
					continue;
				}
			}
		}catch(Exception e){
			LogUtil.logError("银行间质押式回购成交反馈异常", e, "");
		}
	}
	
	/***
	 * 银行间二级市场指令反馈(查指令表与交收表)
	 * @throws Exception 
	 */
	/**@Bizlet("")
	public void yhjSecondMarketFeedback2() throws Exception{
		// 1. 读表获取未完成的所以指令 
		Object[]  unfinishedObjs =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
				"com.cjhxfund.cjapi.OrderFeedbackns.queryBSUnfinishNewOrders", null);
		if (unfinishedObjs == null || unfinishedObjs.length == 0) {
			return;
		}
		for (Object unfinishedObj : unfinishedObjs) {
			DataObject unfinishedData = (DataObject)unfinishedObj;
			// 从O32查找银行间二级市场成交信息
			LogUtil.logInfo("2.0招行定时器节点数据源：{0},参数：{1}", null, CacheUtil.getO32CacheDataSourceName(),unfinishedData);
			Object[] dealObjs = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
					"com.cjhxfund.ats.sm.comm.instructionManage.getYhjUnFeedbackInstruct", unfinishedData);
			if (dealObjs == null || dealObjs.length ==0) {
				continue;
			}
			DataObject dealData = (DataObject)dealObjs[0];
			// 准备回调招行和入库留痕参数
			Map<String, Object> cmbMap = new HashMap<String, Object>();
			cmbMap.put("vcClordId", unfinishedData.getString("VC_CLORD_ID"));
			//金额统一使用万元作为单位
			if (dealData.getString("EN_DEAL_AMOUNT") != null
					&& !"".equals(dealData.getString("EN_DEAL_AMOUNT"))) {
				cmbMap.put("enDealBalance",
						(new BigDecimal(dealData.getString("EN_DEAL_AMOUNT")))
								.divide(new BigDecimal(10000)));// 交易价格
			} else {
				cmbMap.put("enDealBalance", "0");
			}
			cmbMap.put("enDealAmount", dealData.getString("L_DEAL_QUANTITY"));//交易数量
			cmbMap.put("lDealDate", dealData.getString("L_DEAL_DATE"));//交易时间
			cmbMap.put("vcStockCode", unfinishedData.getString("VC_BOND_CODE_EXTERNAL"));//代码
			cmbMap.put("vcSettType", dealData.getString("VC_FIRST_SETTLE_MODE"));//类型
			cmbMap.put("lSettDate", dealData.getString("L_FIRST_SETTLE_DATE"));//设置时间
			cmbMap.put("enFullPrice", dealData.getString("EN_FULL_PRICE"));//全价
			cmbMap.put("vcTradeRivalName", dealData.getString("VC_COUNTERPARTY_NAME"));//对手名字
			BigDecimal l_deal_quantity=new  BigDecimal(dealData.getString("L_DEAL_QUANTITY"));
			int quantity= l_deal_quantity.multiply(new BigDecimal(100)).intValue();
			cmbMap.put("enQtyBalance", quantity);//券面总额
			cmbMap.put("vcProceStatus", "3");//全部成交
			// 先保留回调招行的参数
			String json = new Gson().toJson(cmbMap);
			json = JSONUtil.jsonToJSON(json, "request");
			LogUtil.logInfo("2.0银行间二级市场成交反馈:{0}", null, json);
			// 回调招行接口
			String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.MARKET_BACK_NAMESPACE,"BondDealRecv", "BondDeal", json);
			LogUtil.logInfo("2.0银行间二级市场成交反馈回调招行返回信息:{0}", null, retMsg);
			
			Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
			Object result = retMap.get("result");
			if(result == null || !"000000".equals(retMap.get("result"))){
				LogUtil.logError("2.0银行间二级市场成交反馈调用招行接口失败:retMsg:{0}", null, retMsg);
			}else{
				// 插入银行间二级市场成交反馈 
				// 补全所需的参数
				cmbMap.put("lBankSecondMarketId", unfinishedData.get("L_BANK_SECOND_MARKET_ID"));
				CJAPICommonUtil.getCreateDateAndCreateTime(cmbMap);
				cmbMap.put("lBackId", DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_B_S_MARKET_BACK));
				// 更新银行间二级市场成交状态
				dealData.set("L_BANK_SECOND_MARKET_ID", unfinishedData.get("L_BANK_SECOND_MARKET_ID"));
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
									"com.cjhxfund.cjapi.OrderFeedbackns.updateBSOrderStatus", dealData);
				//反馈表留痕
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.OrderFeedbackns.insertBSFeedback", cmbMap);
			}
		}
	}
	**/
	
	/**
	 * 交易所二级市场指令反馈（查的指令与交收表）
	 */
	/**@Bizlet("")
	public void jysSecondMarketFeedback(){
		
		try{
			// 1. 读表获取未完成的所以指令 
			Object[]  unfinishedObjs =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
					"com.cjhxfund.cjapi.OrderFeedbackns.queryESUnfinishNewOrders", null);
			if (unfinishedObjs == null || unfinishedObjs.length == 0) {
				return;
			}
			for (Object unfinishedObj : unfinishedObjs) {
				
				DataObject unfinishedData = (DataObject)unfinishedObj;
				try{
					// 从O32查找银行间二级市场成交信息
					LogUtil.logInfo("2.0招行定时器节点数据源：{0},参数：{1}", null, CacheUtil.getO32CacheDataSourceName(),unfinishedData);
					Object[] dealObjs = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
							"com.cjhxfund.ats.sm.comm.instructionManage.getJysUnFeedbackInstruct", unfinishedData);
					if (dealObjs == null || dealObjs.length ==0) {
						continue;
					}
					DataObject dealData = (DataObject)dealObjs[0];
					// 准备回调招行和入库留痕参数
					Map<String, Object> cmbMap = new HashMap<String, Object>();
					cmbMap.put("vcClordId", unfinishedData.getString("VC_CLORD_ID"));
					// 金额统一使用万元作为单位
					if (dealData.getString("EN_DEAL_AMOUNT") != null
							&& !"".equals(dealData.getString("EN_DEAL_AMOUNT"))) {
						cmbMap.put("enDealBalance",
								(new BigDecimal(dealData.getString("EN_DEAL_AMOUNT")))
										.divide(new BigDecimal(10000)));// 交易价格
					} else {
						cmbMap.put("enDealBalance", "0");
					}
					cmbMap.put("enDealAmount", dealData.getString("L_DEAL_QUANTITY"));// 交易数量
					cmbMap.put("lDealDate", dealData.getString("L_DEAL_DATE"));// 交易时间
					cmbMap.put("vcStockCode", unfinishedData.getString("VC_BOND_CODE_EXTERNAL"));// 代码
					cmbMap.put("enDealPrice", dealData.getString("EN_PRICE"));
					cmbMap.put("vcDealNo", dealData.getString("VC_DEAL_NO"));
					cmbMap.put("vcProceStatus",dealData.getString("C_STATUS"));
					// 先保留回调招行的参数
					String json = new Gson().toJson(cmbMap);
					json = JSONUtil.jsonToJSON(json, "request");
					LogUtil.logInfo("2.0交易所二级市场成交反馈:{0}", null, json);
					// 回调招行接口
					String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.MARKET_BACK_NAMESPACE,"BondDealRecv", "BondDeal", json);
					LogUtil.logInfo("2.0交易所二级市场成交反馈回调招行返回信息:{0}", null, retMsg);
					
					Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
					Object result = retMap.get("result");
					if(result == null || !"000000".equals(retMap.get("result"))){
						LogUtil.logError("2.0交易所二级市场成交反馈调用招行接口失败:retMsg:{0}", null, retMsg);
					}else{
						//插入交易所二级市场成交反馈 
						// 补全所需的参数
						cmbMap.put("lExchangeSecondMarketId", unfinishedData.get("L_EXCHANGE_SECOND_MARKET_ID"));
						CJAPICommonUtil.getCreateDateAndCreateTime(cmbMap);
						cmbMap.put("lBackId", DatabaseExt.getNextSequence(CJAPIConstants.SEQ_CJAPI_E_S_MARKET_BACK));
						// 更新交易所二级市场成交状态
						dealData.set("L_EXCHANGE_SECOND_MARKET_ID", unfinishedData.get("L_EXCHANGE_SECOND_MARKET_ID"));
						DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
											"com.cjhxfund.cjapi.OrderFeedbackns.updateESOrderStatus", dealData);
						//反馈表留痕
						cmbMap.put("lDealTime", dealData.getString("T_FS_DEAL_TIME"));
						DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, "com.cjhxfund.cjapi.OrderFeedbackns.insertESFeedback", cmbMap);
					}
				}catch(Exception e){
					LogUtil.logError("2.0交易所二级市场成交反馈出现异常,lExchangeSecondMarketId：{0}", e, unfinishedData.getString("L_EXCHANGE_SECOND_MARKET_ID"));
					continue;
				}
			}
		}catch(Exception e){
			LogUtil.logError("2.0交易所二级市场成交反馈出现异常", e, "");
		}
	}
	
	**/
	
	
	public static void main(String args[]){
		BigDecimal enDealAmount=new BigDecimal("8000");
		BigDecimal enDealPrice=new BigDecimal("97.00000000");
		DataObject dealData = DataObjectUtil.createDataObject("commonj.sdo.DataObject");	
		dealData.setString("EN_DEAL_BALANCE", enDealPrice.multiply(enDealAmount).toString());
		BigDecimal d=new BigDecimal(dealData.getString("EN_DEAL_BALANCE")).divide(new BigDecimal(10000));
		System.out.println(d.toString());
//		cmbMap.put("enDealBalance",
//				(new BigDecimal(dealData.getString("EN_DEAL_BALANCE")))
//						.divide(new BigDecimal(10000)));// 交易金额
	}
	
}
