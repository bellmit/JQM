package com.cjhxfund.jy.ProductProcess;

public class CapitalPositionData {
	private Integer fundId; //基金序号
	private String fundCode; //基金代码
	private String fundName; //基金名称
	private Integer assetId; //资产单元序号
	private String assetName; //资产单元名称
	private Integer settleDate; //交割日期
	private Double settleBalance; //交割金额
	private Double cashEnableBalanceHgt; //沪港通交易端可用金额
	private Double cashEnableBalanceInstrHgt; //沪港通投资端可用金额
	private Double cashEnableBalanceSgt; //深港通交易端可用金额
	private Double cashEnableBalanceInstrSgt; //深港通投资端可用金额
	public Integer getFundId() {
		return fundId;
	}
	public void setFundId(Integer fundId) {
		this.fundId = fundId;
	}
	public String getFundCode() {
		return fundCode;
	}
	public void setFundCode(String fundCode) {
		this.fundCode = fundCode;
	}
	public String getFundName() {
		return fundName;
	}
	public void setFundName(String fundName) {
		this.fundName = fundName;
	}
	public Integer getAssetId() {
		return assetId;
	}
	public void setAssetId(Integer assetId) {
		this.assetId = assetId;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public Integer getSettleDate() {
		return settleDate;
	}
	public void setSettleDate(Integer settleDate) {
		this.settleDate = settleDate;
	}
	public Double getSettleBalance() {
		return settleBalance;
	}
	public void setSettleBalance(Double settleBalance) {
		this.settleBalance = settleBalance;
	}
	public Double getCashEnableBalanceHgt() {
		return cashEnableBalanceHgt;
	}
	public void setCashEnableBalanceHgt(Double cashEnableBalanceHgt) {
		this.cashEnableBalanceHgt = cashEnableBalanceHgt;
	}
	public Double getCashEnableBalanceInstrHgt() {
		return cashEnableBalanceInstrHgt;
	}
	public void setCashEnableBalanceInstrHgt(Double cashEnableBalanceInstrHgt) {
		this.cashEnableBalanceInstrHgt = cashEnableBalanceInstrHgt;
	}
	public Double getCashEnableBalanceSgt() {
		return cashEnableBalanceSgt;
	}
	public void setCashEnableBalanceSgt(Double cashEnableBalanceSgt) {
		this.cashEnableBalanceSgt = cashEnableBalanceSgt;
	}
	public Double getCashEnableBalanceInstrSgt() {
		return cashEnableBalanceInstrSgt;
	}
	public void setCashEnableBalanceInstrSgt(Double cashEnableBalanceInstrSgt) {
		this.cashEnableBalanceInstrSgt = cashEnableBalanceInstrSgt;
	}
	@Override
	public String toString() {
		return "CapitalPositionBean [fundId=" + fundId + ", fundCode="
				+ fundCode + ", fundName=" + fundName + ", assetId=" + assetId
				+ ", assetName=" + assetName + ", settleDate=" + settleDate
				+ ", settleBalance=" + settleBalance
				+ ", cashEnableBalanceHgt=" + cashEnableBalanceHgt
				+ ", cashEnableBalanceInstrHgt=" + cashEnableBalanceInstrHgt
				+ ", cashEnableBalanceSgt=" + cashEnableBalanceSgt
				+ ", cashEnableBalanceInstrSgt=" + cashEnableBalanceInstrSgt
				+ "]";
	}
	
}
