package com.cjhxfund.jy.DataProcess;

public class PositionBasic {
	
	private Long lFundId; //基金序号
	private String lDate; //日期	
	private String vcFundCode; //基金代码
	private String vcFundName; //基金名称
	private String vcCombiNo; //组合代码
	private String vcCombiName; //组合名称
	private String vcInterCode; //证券内码
	private String vcReportCode; //证券代码
	private String vcStockName; //证券名称
	private String cStockType; //证券类别
	private Long lUsableAmount; //可用数量
	private Long lCurrentAmount; //持仓
	private String cPositionFlag; //持仓多空标志
	private String cMarketNo; //交易市场代码
	private String cTrustee; //托管机构
	private String vcInterCodeWind2; //万得代码
	private String isBuyBack; //是否为买断式正回购
	private String isSellBack; //是否为买断式逆回购
	private String vcTag; //标记状态
	private String bIssuerCode; //
	private String sInfoName;
	private String bDelistDate;
	private Long bCnbd;
	private String bIC1;
	private String bIC2;
	private String bIC3;
	private String bIC4;
	private String bPaymentDate;
	private String bICD;
	private String bGuarantorNature;
	private String bRatingOutlook;
	private String isCityInvest;
	private String bPtmyear;
	private String sIndustryName2;
	private String province;
	private String isPayEarly;
		
	
	public String getcStockType() {
		return cStockType;
	}
	public void setcStockType(String cStockType) {
		this.cStockType = cStockType;
	}
	public String getcTrustee() {
		return cTrustee;
	}
	public void setcTrustee(String cTrustee) {
		this.cTrustee = cTrustee;
	}
	public String getVcTag() {
		return vcTag;
	}
	public void setVcTag(String vcTag) {
		this.vcTag = vcTag;
	}
	public String getcPositionFlag() {
		return cPositionFlag;
	}
	public void setcPositionFlag(String cPositionFlag) {
		this.cPositionFlag = cPositionFlag;
	}
	public String getIsBuyBack() {
		return isBuyBack;
	}
	public void setIsBuyBack(String isBuyBack) {
		this.isBuyBack = isBuyBack;
	}
	public String getIsSellBack() {
		return isSellBack;
	}
	public void setIsSellBack(String isSellBack) {
		this.isSellBack = isSellBack;
	}
	
	public String getbIssuerCode() {
		return bIssuerCode;
	}
	public void setbIssuerCode(String bIssuerCode) {
		this.bIssuerCode = bIssuerCode;
	}
	
	public String getsInfoName() {
		return sInfoName;
	}
	public void setsInfoName(String sInfoName) {
		this.sInfoName = sInfoName;
	}
	public String getbDelistDate() {
		return bDelistDate;
	}
	public void setbDelistDate(String bDelistDate) {
		this.bDelistDate = bDelistDate;
	}
	public Long getbCnbd() {
		return bCnbd;
	}
	public void setbCnbd(Long bCnbd) {
		this.bCnbd = bCnbd;
	}
	public String getbIC1() {
		return bIC1;
	}
	public void setbIC1(String bIC1) {
		this.bIC1 = bIC1;
	}
	public String getbIC2() {
		return bIC2;
	}
	public void setbIC2(String bIC2) {
		this.bIC2 = bIC2;
	}
	
	public String getbIC3() {
		return bIC3;
	}
	public void setbIC3(String bIC3) {
		this.bIC3 = bIC3;
	}
	public String getbIC4() {
		return bIC4;
	}
	public void setbIC4(String bIC4) {
		this.bIC4 = bIC4;
	}
	public String getbPaymentDate() {
		return bPaymentDate;
	}
	public void setbPaymentDate(String bPaymentDate) {
		this.bPaymentDate = bPaymentDate;
	}
	public String getbICD() {
		return bICD;
	}
	public void setbICD(String bICD) {
		this.bICD = bICD;
	}
	public String getbGuarantorNature() {
		return bGuarantorNature;
	}
	public void setbGuarantorNature(String bGuarantorNature) {
		this.bGuarantorNature = bGuarantorNature;
	}
	public String getbRatingOutlook() {
		return bRatingOutlook;
	}
	public void setbRatingOutlook(String bRatingOutlook) {
		this.bRatingOutlook = bRatingOutlook;
	}
	
	public String getIsCityInvest() {
		return isCityInvest;
	}
	public void setIsCityInvest(String isCityInvest) {
		this.isCityInvest = isCityInvest;
	}
	public String getbPtmyear() {
		return bPtmyear;
	}
	public void setbPtmyear(String bPtmyear) {
		this.bPtmyear = bPtmyear;
	}
	public String getsIndustryName2() {
		return sIndustryName2;
	}
	public void setsIndustryName2(String sIndustryName2) {
		this.sIndustryName2 = sIndustryName2;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	
	public String getIsPayEarly() {
		return isPayEarly;
	}
	public void setIsPayEarly(String isPayEarly) {
		this.isPayEarly = isPayEarly;
	}
	public Long getlFundId() {
		return lFundId;
	}
	public void setlFundId(Long lFundId) {
		this.lFundId = lFundId;
	}
	public String getlDate() {
		return lDate;
	}
	public void setlDate(String lDate) {
		this.lDate = lDate;
	}
	public String getVcFundCode() {
		return vcFundCode;
	}
	public void setVcFundCode(String vcFundCode) {
		this.vcFundCode = vcFundCode;
	}
	public String getVcFundName() {
		return vcFundName;
	}
	public void setVcFundName(String vcFundName) {
		this.vcFundName = vcFundName;
	}
	public String getVcCombiNo() {
		return vcCombiNo;
	}
	public void setVcCombiNo(String vcCombiNo) {
		this.vcCombiNo = vcCombiNo;
	}
	public String getVcCombiName() {
		return vcCombiName;
	}
	public void setVcCombiName(String vcCombiName) {
		this.vcCombiName = vcCombiName;
	}
	public String getVcInterCode() {
		return vcInterCode;
	}
	public void setVcInterCode(String vcInterCode) {
		this.vcInterCode = vcInterCode;
	}
	public String getVcReportCode() {
		return vcReportCode;
	}
	public void setVcReportCode(String vcReportCode) {
		this.vcReportCode = vcReportCode;
	}
	public String getVcStockName() {
		return vcStockName;
	}
	public void setVcStockName(String vcStockName) {
		this.vcStockName = vcStockName;
	}
	public Long getlUsableAmount() {
		return lUsableAmount;
	}
	public void setlUsableAmount(Long lUsableAmount) {
		this.lUsableAmount = lUsableAmount;
	}
	public Long getlCurrentAmount() {
		return lCurrentAmount;
	}
	public void setlCurrentAmount(Long lCurrentAmount) {
		this.lCurrentAmount = lCurrentAmount;
	}
	public String getcMarketNo() {
		return cMarketNo;
	}
	public void setcMarketNo(String cMarketNo) {
		this.cMarketNo = cMarketNo;
	}
	public String getVcInterCodeWind2() {
		return vcInterCodeWind2;
	}
	public void setVcInterCodeWind2(String vcInterCodeWind2) {
		this.vcInterCodeWind2 = vcInterCodeWind2;
	}
	
	@Override
	public String toString() {
		return "PositionBasic [lFundId=" + lFundId + ", lDate=" + lDate + ", vcFundCode=" + vcFundCode
				+ ", vcFundName=" + vcFundName + ", vcCombiNo=" + vcCombiNo + ", vcCombiName=" + vcCombiName
				+ ", vcInterCode=" + vcInterCode + ", vcReportCode=" + vcReportCode + ", vcStockName=" + vcStockName
				+ ", lUsableAmount=" + lUsableAmount + ", lCurrentAmount=" + lCurrentAmount + ", cMarketNo="
				+ cMarketNo + ", vcInterCodeWind2=" + vcInterCodeWind2 + ", bIssuerCode=" + bIssuerCode
				+ ", sInfoName=" + sInfoName + ", bDelistDate=" + bDelistDate + ", bCnbd=" + bCnbd + ", bIC1=" + bIC1
				+ ", bIC2=" + bIC2 + ", bPaymentDate=" + bPaymentDate + ", bICD=" + bICD + ", bGuarantorNature=" + bGuarantorNature
				+ ", bRatingOutlook=" + bRatingOutlook + ", isCityInvest=" + isCityInvest + ", bPtmyear=" + bPtmyear
				+ ", sIndustryName2=" + sIndustryName2 + ", province=" + province + ", isPayEarly=" + isPayEarly
				+ "]";
	}
	
}
