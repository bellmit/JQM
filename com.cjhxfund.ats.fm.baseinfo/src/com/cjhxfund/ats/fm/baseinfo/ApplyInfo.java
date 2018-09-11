package com.cjhxfund.ats.fm.baseinfo;


//报量信息pojo
public class ApplyInfo {
	String rate;
	String amount;
	
	public ApplyInfo(String rate,String amount){
		this.rate = rate;
		this.amount = amount;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	
}
