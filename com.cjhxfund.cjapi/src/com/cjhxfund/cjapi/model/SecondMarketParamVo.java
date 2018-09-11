package com.cjhxfund.cjapi.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 
 * @Description	 用于二级市场参数传值的Vo对象
 * @ClassName	SecondMarketParamVo
 * @Date		2016年12月5日 下午4:01:10
 * @Author		liangjilong
 * @Copyright (c) All Rights Reserved, 2016.
 */
@SuppressWarnings("all")
public class SecondMarketParamVo implements Serializable{

	private boolean isAdd;//true/false(添加/修改)
	private String tradingPlace;//交易场所
	private String entityName;//实体路径
	private String hasInterestRate;//是否（有收益率和收益率类型）1代表有，2代表无	
	private boolean hasTradeRival;//是否有交易员代码和交易对手（true/false）有/无
	
	public SecondMarketParamVo() {
		super();
	}
	/***/
	public SecondMarketParamVo(boolean isAdd, String tradingPlace,
			String entityName, String hasInterestRate,boolean hasTradeRival) {
		super();
		this.isAdd = isAdd;
		this.tradingPlace = tradingPlace;
		this.entityName = entityName;
		this.hasInterestRate = hasInterestRate;
		this.hasTradeRival = hasTradeRival;
	}
	public String getHasInterestRate() {
		return hasInterestRate;
	}
	public void setHasInterestRate(String hasInterestRate) {
		this.hasInterestRate = hasInterestRate;
	}

	public boolean isAdd() {
		return isAdd;
	}
	public void setIsAdd(boolean isAdd) {
		this.isAdd = isAdd;
	}
	public String getTradingPlace() {
		return tradingPlace;
	}
	public void setTradingPlace(String tradingPlace) {
		this.tradingPlace = tradingPlace;
	}
	 
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	
	
	public boolean isHasTradeRival() {
		return hasTradeRival;
	}
	public void setHasTradeRival(boolean hasTradeRival) {
		this.hasTradeRival = hasTradeRival;
	}
	
	
}
