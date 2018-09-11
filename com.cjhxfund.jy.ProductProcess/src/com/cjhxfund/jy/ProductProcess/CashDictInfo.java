package com.cjhxfund.jy.ProductProcess;

import java.util.HashMap;
import java.util.Map;

/**
 * 现金流字典map类
 * @author chendi
 *
 */
public class CashDictInfo {
	/**
	 * 
	 * @param entrustDirectionKey
	 * @return
	 */
	public String getEntrustDirectionDict(String entrustDirectionKey){
		//构造委托方向字典Map
		Map<String,String> entrustDirectionDict = new HashMap<String,String>();
		entrustDirectionDict.put("stockBuyBal","1");
		entrustDirectionDict.put("stockSaleBal","2"); 
		entrustDirectionDict.put("bondBuyBalGuar","3");
		entrustDirectionDict.put("bondBuyBalNonGuar","3");
		entrustDirectionDict.put("bondSaleBalGuar","4"); 
		entrustDirectionDict.put("bondSaleBalNonGuar","4");
		entrustDirectionDict.put("bondBuyBalCibm","3");
		entrustDirectionDict.put("bondSaleBalCibm","4");
		entrustDirectionDict.put("rzhgBal","5");
		entrustDirectionDict.put("rzhgBalCibm","5");
		entrustDirectionDict.put("rqhgBalCibm","6");
		entrustDirectionDict.put("rqhgBal","6");
		entrustDirectionDict.put("rzhgExpireBalCibm","7");
		entrustDirectionDict.put("rzhgExpireBal","7");
		entrustDirectionDict.put("rqhgExpireBalCibm","8");
		entrustDirectionDict.put("rqhgExpireBal","8");
		entrustDirectionDict.put("rzhgPactBal","15");
		entrustDirectionDict.put("rqhgBalPact","16");
		entrustDirectionDict.put("rzhgExpireBalPact","17");
		entrustDirectionDict.put("rqhgExpireBalPact","18");
		entrustDirectionDict.put("applyFundBal","p");
		entrustDirectionDict.put("redeemFundBal","q");
		entrustDirectionDict.put("distributeBuyBal","k");
		return entrustDirectionDict.get(entrustDirectionKey);
	}
	/**
	 * 
	 * @param marketKey
	 * @return
	 */
	public String getMarketDict(String marketKey){
		//构造交易市场字典Map
		Map<String,String> marketDict = new HashMap<String,String>();
		//银行间
		marketDict.put("bondBuyBalCibm","5"); 
		marketDict.put("bondSaleBalCibm","5");
		marketDict.put("rzhgBalCibm","5");
		marketDict.put("rzhgExpireBalCibm","5"); 
		marketDict.put("rqhgBalCibm","5");
		marketDict.put("rqhgExpireBalCibm","5");
		marketDict.put("netStlBalCibm","5");
		//交易所
		marketDict.put("stockBuyBal","1");
		marketDict.put("stockSaleBal","1");
		marketDict.put("bondBuyBalGuar","1");
		marketDict.put("bondSaleBalGuar","1");
		marketDict.put("bondBuyBalNonGuar","1");
		marketDict.put("bondSaleBalNonGuar","1");
		marketDict.put("rzhgBal","1");
		marketDict.put("rzhgExpireBal","1");
		marketDict.put("rqhgBal","1");
		marketDict.put("rqhgExpireBal","1");
		marketDict.put("rzhgPactBal","1");
		marketDict.put("rzhgExpireBalPact","1");
		marketDict.put("rqhgBalPact","1");
		marketDict.put("rqhgExpireBalPact","1");
		marketDict.put("netStlBal","1");
		//港股通
		marketDict.put("shareBuyBalHgt","n"); 
		marketDict.put("shareSaleBalHgt","n"); 
		marketDict.put("shareBuyBalSgt","n"); 
		marketDict.put("shareSaleBalSgt","n"); 
		marketDict.put("shareBuyBalGgt","n"); 
		marketDict.put("shareSaleBalGgt","n"); 
		//场外
		marketDict.put("applyFundBal","6");
		marketDict.put("redeemFundBal","6");
		return marketDict.get(marketKey);
	}
	
}
