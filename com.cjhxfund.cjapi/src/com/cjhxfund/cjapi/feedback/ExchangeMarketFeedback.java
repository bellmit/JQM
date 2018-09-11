package com.cjhxfund.cjapi.feedback;

import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.foundation.database.DatabaseExt;

import commonj.sdo.DataObject;

/***
 * 交易所成交反馈，含：1. 交易所二级市场指令反馈 		2. 交易所质押式回购
 * @author luwenxing
 *
 */
public class ExchangeMarketFeedback {

	/***
	 * 交易所二级市场指令反馈
	 * 1. 获取未完成的数据
	 * 2. 根据要素查找O32库，获取未成交信息
	 * @throws Exception 
	 */
	public void secondMarketFeedback() throws Exception{
		// 1. 读表获取成交未完成的数据		
		Object[]  orderObjs =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
				"com.cjhxfund.cjapi.OrderFeedbackns.queryESMarketUnfinishOrder", null);
		if (orderObjs == null || orderObjs.length == 0) {
			return;
		}
		
		for (Object orderObj : orderObjs) {
			DataObject orderDataObj = (DataObject)orderObj;			// 指令数据对象
			long lDailyInstructionNo = orderDataObj.getLong("lDailyInstructionNo");		// 指令编号
			boolean isFirst = lDailyInstructionNo == -1;
			Map<String, Object> o32RealDealParam = new HashMap<String, Object>();
			
			if (isFirst) {
				// 首次查询
				// 查找O32指令表TINSTRUCTION获取指令
				Map<String, Object> o32InsParam = new HashMap<String, Object>();
				o32InsParam.put("vcProductCode", orderDataObj.get("vcProductCode"));
				o32InsParam.put("vcCombiNo", orderDataObj.get("vcCombiNo"));
				o32InsParam.put("vcStockCode", orderDataObj.get("vcStockCode"));
				o32InsParam.put("vcBusinType", orderDataObj.get("vcBusinType"));
				Object[] realDealObjs = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
						"com.cjhxfund.cjapi.OrderFeedbackns.queryO32Instruction", o32InsParam);
				if (realDealObjs == null || realDealObjs.length != 1) {
					continue;
				}
				DataObject instData = (DataObject)realDealObjs[0];			// 指令数据
				o32RealDealParam.put("lDailyInstructionNo", instData.getLong("lDailyInstructionNo"));
				o32RealDealParam.put("lDealTime",0);		// 当成交时间为0的时候，会查找出全部的成交数据
			} else {
				o32RealDealParam.put("lDailyInstructionNo", lDailyInstructionNo);
				// 通过指令获取表中已存的最后成交时间
				Object[] maxTimeObjs = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
						"com.cjhxfund.cjapi.OrderFeedbackns.getMaxDealTimeForExchangeSecondMarket", o32RealDealParam);
				if (maxTimeObjs == null || maxTimeObjs.length != 1) {
					// TODO
					// 错误处理
				}
				long lDealTime = ((DataObject)maxTimeObjs[0]).getLong("lDealTime");	// 成交时间
				o32RealDealParam.put("lDealTime",lDealTime);	
			}
			
			// 在实时成交表TREALDEAL中查找成交数据
			Object[] realDealObjects = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
					"com.cjhxfund.cjapi.OrderFeedbackns.queryO32ExchangeSecondMarketRealDeal", o32RealDealParam);
			
			// 将所有的成交数据插入成交反馈表
			for(Object dealObj : realDealObjects) {
				DataObject dealData = (DataObject)dealObj;
				// 新增交易所二级市场指令反馈信息 
				dealData.set("lExchangeSecondMarketId",orderDataObj.get("lExchangeSecondMarketId"));
				dealData.set("vcClordId", orderDataObj.get("vcClordId"));
				dealData.set("vcStockCode", orderDataObj.get("vcStockCode"));
				CJAPICommonUtil.getCreateDateAndCreateTime(dealData);
				dealData.set("lBackId",DatabaseExt.getNextSequence("SEQ_CJAPI_E_S_MARKET_BACK"));
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
						"com.cjhxfund.cjapi.OrderFeedbackns.insertExchangeSecondMarketFeedback", dealData);
				
				// 判断是否全部成交 
				String vcBackStatus = OrderFeedback.getInstrunctionStatus(lDailyInstructionNo);
				
				// 更新指令表状态
				orderDataObj.set("vcBackStatus",vcBackStatus);				// 1：未执行 2：部分执行 3：完成
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
						"com.cjhxfund.cjapi.OrderFeedbackns.updateExchangeSecondMarketOrderStatus", orderDataObj);
			}
		}
	}

	/***
	 * 交易所质押式回购
	 * @throws Exception 
	 */
	public void pledgeRepoFeedback() throws Exception{
		// 1. 读表获取数据		
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put("notStatus", "3");		//vcBackStatus：反馈状态。 1：未执行 2：部分执行 3：完成
		Object[]  orderObjs =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
				"com.cjhxfund.cjapi.OrderFeedbackns.queryExchangePledgeRepoOrderStatus", paramters);
		if (orderObjs == null || orderObjs.length == 0) {
			return;
		}
		
		// 2. 处理交易未全部完成的指令
		for (Object orderObj : orderObjs) {
			DataObject orderDataObj = (DataObject)orderObj;			// 指令信息
			long lDailyInstructionNo = orderDataObj.getLong("lDailyInstructionNo");		// 指令编号
			boolean isFirst = lDailyInstructionNo == -1;		// lDailyInstructionNo初始默认值为-1
			Map<String, Object> o32RealDealParam = new HashMap<String, Object>();
			
			if (isFirst) {		
				// 首次查询
				// 查找O32指令表TINSTRUCTION获取指令
				Map<String, Object> o32InsParam = new HashMap<String, Object>();
				o32InsParam.put("vcProductCode", orderDataObj.get("vcProductCode"));
				o32InsParam.put("vcCombiNo", orderDataObj.get("vcCombiNo"));
				o32InsParam.put("vcStockCode", orderDataObj.get("vcStockCode"));
				o32InsParam.put("vcBusinType", orderDataObj.get("vcBusinType"));
				Object[] realDealObjs = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
						"com.cjhxfund.cjapi.OrderFeedbackns.queryO32Instruction", o32InsParam);
				if (realDealObjs == null || realDealObjs.length != 1) {
					continue;
				}
				DataObject instData = (DataObject)realDealObjs[0];	// 指令数据
				o32RealDealParam.put("lDailyInstructionNo", instData.getLong("lDailyInstructionNo"));
				o32RealDealParam.put("lDealTime",0);		// 当成交时间为0的时候，会查找出全部的成交数据
			} else {
				o32RealDealParam.put("lDailyInstructionNo", lDailyInstructionNo);
				// 通过指令获取表中已存的最后成交时间
				Object[] maxTimeObjs = DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT, 
						"com.cjhxfund.cjapi.OrderFeedbackns.getMaxDealTimeForExchangePledgeRepo", o32RealDealParam);
				if (maxTimeObjs == null || maxTimeObjs.length != 1) {
					// TODO
					// 错误处理
				}
				long lDealTime = ((DataObject)maxTimeObjs[0]).getLong("lDealTime");	// 成交时间
				o32RealDealParam.put("lDealTime",lDealTime);	
			}
			
			// 在实时成交表TREALDEAL中查找成交数据
			Object[] realDealObjects = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
					"com.cjhxfund.cjapi.OrderFeedbackns.queryO32ExchangePledgeRepoRealDeal", o32RealDealParam);
			
			// 将所有的成交数据插入成交反馈表
			for(Object dealObj : realDealObjects) {
				DataObject dealData = (DataObject)dealObj;
				// 新增交易所二级市场指令反馈信息
				dealData.set("lExchangePledgeRepoId",orderDataObj.get("lExchangePledgeRepoId"));
				dealData.set("vcClordId", orderDataObj.get("vcClordId"));
				dealData.set("vcStockCode", orderDataObj.get("vcStockCode"));
				CJAPICommonUtil.getCreateDateAndCreateTime(dealData);
				dealData.set("lBackId",DatabaseExt.getNextSequence("SEQ_CJAPI_E_P_REPO_BACK"));
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
						"com.cjhxfund.cjapi.OrderFeedbackns.insertExchangePledgeRepoFeedback", dealData);
				
				// 判断是否全部成交 
				String vcBackStatus = OrderFeedback.getInstrunctionStatus(lDailyInstructionNo);
				
				// 更新指令表状态
				orderDataObj.set("vcBackStatus",vcBackStatus);				// 1：未执行 2：部分执行 3：完成
				DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT, 
						"com.cjhxfund.cjapi.OrderFeedbackns.updateExchangePledgeRepoOrderStatus", orderDataObj);
			}
		}
	}
}
