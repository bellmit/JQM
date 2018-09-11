/**
 * 
 */
package com.cjhxfund.jy.ProductProcess;

import com.eos.system.annotation.Bizlet;

/**
 * @author chendi
 * @date 2017-06-12 20:05:56
 * 
 */
@Bizlet("")
public class UnitAssetInfos {
	// 资产单元ID
	private String assetId;
	// 资产单元名称
	private String assetName;
	
	private String currentCash;
	private String otherExpense;
	private String otherProfit;
	private String stockAsset;
	private String bondAsset;
	private String fundAsset;
	private String hgAsset;
	private String warrantAsset;
	private String otherAsset;
	private String futureAsset;
	private String optionAsset;
	private String recSecAsset;
	private String paySecAsset;
	private String assetShare;
	private String assetValue;
	private String assetTotalValue;
	private String futuresBalance;
	private String futuresPrepare;
	private String enableBalance;
	private String currencyNo;

	public String getAssetId() {
		return assetId;
	}

	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public String getCurrentCash() {
		return currentCash;
	}

	public void setCurrentCash(String currentCash) {
		this.currentCash = currentCash;
	}

	public String getOtherExpense() {
		return otherExpense;
	}

	public void setOtherExpense(String otherExpense) {
		this.otherExpense = otherExpense;
	}

	public String getOtherProfit() {
		return otherProfit;
	}

	public void setOtherProfit(String otherProfit) {
		this.otherProfit = otherProfit;
	}

	public String getStockAsset() {
		return stockAsset;
	}

	public void setStockAsset(String stockAsset) {
		this.stockAsset = stockAsset;
	}

	public String getBondAsset() {
		return bondAsset;
	}

	public void setBondAsset(String bondAsset) {
		this.bondAsset = bondAsset;
	}

	public String getFundAsset() {
		return fundAsset;
	}

	public void setFundAsset(String fundAsset) {
		this.fundAsset = fundAsset;
	}

	public String getHgAsset() {
		return hgAsset;
	}

	public void setHgAsset(String hgAsset) {
		this.hgAsset = hgAsset;
	}

	public String getWarrantAsset() {
		return warrantAsset;
	}

	public void setWarrantAsset(String warrantAsset) {
		this.warrantAsset = warrantAsset;
	}

	public String getOtherAsset() {
		return otherAsset;
	}

	public void setOtherAsset(String otherAsset) {
		this.otherAsset = otherAsset;
	}

	public String getFutureAsset() {
		return futureAsset;
	}

	public void setFutureAsset(String futureAsset) {
		this.futureAsset = futureAsset;
	}

	public String getOptionAsset() {
		return optionAsset;
	}

	public void setOptionAsset(String optionAsset) {
		this.optionAsset = optionAsset;
	}

	public String getRecSecAsset() {
		return recSecAsset;
	}

	public void setRecSecAsset(String recSecAsset) {
		this.recSecAsset = recSecAsset;
	}

	public String getPaySecAsset() {
		return paySecAsset;
	}

	public void setPaySecAsset(String paySecAsset) {
		this.paySecAsset = paySecAsset;
	}

	public String getAssetShare() {
		return assetShare;
	}

	public void setAssetShare(String assetShare) {
		this.assetShare = assetShare;
	}

	public String getAssetValue() {
		return assetValue;
	}

	public void setAssetValue(String assetValue) {
		this.assetValue = assetValue;
	}

	public String getAssetTotalValue() {
		return assetTotalValue;
	}

	public void setAssetTotalValue(String assetTotalValue) {
		this.assetTotalValue = assetTotalValue;
	}

	public String getFuturesBalance() {
		return futuresBalance;
	}

	public void setFuturesBalance(String futuresBalance) {
		this.futuresBalance = futuresBalance;
	}

	public String getFuturesPrepare() {
		return futuresPrepare;
	}

	public void setFuturesPrepare(String futuresPrepare) {
		this.futuresPrepare = futuresPrepare;
	}

	public String getEnableBalance() {
		return enableBalance;
	}

	public void setEnableBalance(String enableBalance) {
		this.enableBalance = enableBalance;
	}

	public String getCurrencyNo() {
		return currencyNo;
	}

	public void setCurrencyNo(String currencyNo) {
		this.currencyNo = currencyNo;
	}

	@Override
	public String toString() {
		return "UnitAssetInfos [assetId=" + assetId + ", assetName="
				+ assetName + ", currentCash=" + currentCash
				+ ", otherExpense=" + otherExpense + ", otherProfit="
				+ otherProfit + ", stockAsset=" + stockAsset + ", bondAsset="
				+ bondAsset + ", fundAsset=" + fundAsset + ", hgAsset="
				+ hgAsset + ", warrantAsset=" + warrantAsset + ", otherAsset="
				+ otherAsset + ", futureAsset=" + futureAsset
				+ ", optionAsset=" + optionAsset + ", recSecAsset="
				+ recSecAsset + ", paySecAsset=" + paySecAsset
				+ ", assetShare=" + assetShare + ", assetValue=" + assetValue
				+ ", assetTotalValue=" + assetTotalValue + ", futuresBalance="
				+ futuresBalance + ", futuresPrepare=" + futuresPrepare
				+ ", enableBalance=" + enableBalance + ", currencyNo="
				+ currencyNo + "]";
	}
	
}
