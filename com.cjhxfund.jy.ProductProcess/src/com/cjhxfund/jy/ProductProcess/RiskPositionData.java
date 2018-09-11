package com.cjhxfund.jy.ProductProcess;

public class RiskPositionData {
	private String fundId; //基金序号
	private String fundCode; //基金代码
	private String fundName; //基金名称
	private String marketNo; //交易市场
	private String trusteeShip; //托管机构:0-中证登,1-中债登,2-上清所
	private String bondCode; //债券代码
	private String bondName; //债券名称
	private Integer currentAmount; //当前数量
	private Integer frozenAmount; //冻结数量
	private Integer unfrozenAmount; //解冻数量
	private Double enableAmount; //T+0可用数量
	private Double enableAmountNext; //T+1可用数量
	private Double convertStdAmount; //折算T+0标准券数量
	private Double convertStdAmountNext; //折算T+1标准券数量
	private Double faPrice; //估值价格
	private String bondTypeWindFirst; //Wind一级债券类型
	private String bondTypeWindSecond; //Wind二级债券类型
	private String bondAppraise; //债项评级
	private String issuerAppraise; //主体评级
	private String issuerProperty; //企业性质
	public String getFundId() {
		return fundId;
	}
	public void setFundId(String fundId) {
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
	public String getMarketNo() {
		return marketNo;
	}
	public void setMarketNo(String marketNo) {
		this.marketNo = marketNo;
	}
	public String getTrusteeShip() {
		return trusteeShip;
	}
	public void setTrusteeShip(String trusteeShip) {
		this.trusteeShip = trusteeShip;
	}
	public String getBondCode() {
		return bondCode;
	}
	public void setBondCode(String bondCode) {
		this.bondCode = bondCode;
	}
	public String getBondName() {
		return bondName;
	}
	public void setBondName(String bondName) {
		this.bondName = bondName;
	}
	public Integer getCurrentAmount() {
		return currentAmount;
	}
	public void setCurrentAmount(Integer currentAmount) {
		this.currentAmount = currentAmount;
	}
	public Integer getFrozenAmount() {
		return frozenAmount;
	}
	public void setFrozenAmount(Integer frozenAmount) {
		this.frozenAmount = frozenAmount;
	}
	public Integer getUnfrozenAmount() {
		return unfrozenAmount;
	}
	public void setUnfrozenAmount(Integer unfrozenAmount) {
		this.unfrozenAmount = unfrozenAmount;
	}
	public Double getEnableAmount() {
		return enableAmount;
	}
	public void setEnableAmount(Double enableAmount) {
		this.enableAmount = enableAmount;
	}
	public Double getConvertStdAmount() {
		return convertStdAmount;
	}
	public void setConvertStdAmount(Double convertStdAmount) {
		this.convertStdAmount = convertStdAmount;
	}
	public Double getFaPrice() {
		return faPrice;
	}
	public void setFaPrice(Double faPrice) {
		this.faPrice = faPrice;
	}
	public String getBondTypeWindFirst() {
		return bondTypeWindFirst;
	}
	public void setBondTypeWindFirst(String bondTypeWindFirst) {
		this.bondTypeWindFirst = bondTypeWindFirst;
	}
	public String getBondTypeWindSecond() {
		return bondTypeWindSecond;
	}
	public void setBondTypeWindSecond(String bondTypeWindSecond) {
		this.bondTypeWindSecond = bondTypeWindSecond;
	}
	public String getBondAppraise() {
		return bondAppraise;
	}
	public void setBondAppraise(String bondAppraise) {
		this.bondAppraise = bondAppraise;
	}
	public String getIssuerAppraise() {
		return issuerAppraise;
	}
	public void setIssuerAppraise(String issuerAppraise) {
		this.issuerAppraise = issuerAppraise;
	}
	public String getIssuerProperty() {
		return issuerProperty;
	}
	public void setIssuerProperty(String issuerProperty) {
		this.issuerProperty = issuerProperty;
	}
	public Double getEnableAmountNext() {
		return enableAmountNext;
	}
	public void setEnableAmountNext(Double enableAmountNext) {
		this.enableAmountNext = enableAmountNext;
	}
	public Double getConvertStdAmountNext() {
		return convertStdAmountNext;
	}
	public void setConvertStdAmountNext(Double convertStdAmountNext) {
		this.convertStdAmountNext = convertStdAmountNext;
	}
	
	
}
