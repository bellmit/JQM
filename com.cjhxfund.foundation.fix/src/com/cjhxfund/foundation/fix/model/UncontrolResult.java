package com.cjhxfund.foundation.fix.model;

/**
 * 不能控制风控明细
@author  wanglunzhang
@date 2017年3月21日 下午6:38:31 
@version 1.0
@return  */

public class UncontrolResult {
	String riskNos; //风控序号
	
	String fundCode; //基金代码
	
	String riskSummary; //不能控制的风控说明
	
	String remark; //备注

	public String getRiskNos() {
		return riskNos;
	}

	public void setRiskNos(String riskNos) {
		this.riskNos = riskNos;
	}

	public String getFundCode() {
		return fundCode;
	}

	public void setFundCode(String fundCode) {
		this.fundCode = fundCode;
	}

	public String getRiskSummary() {
		return riskSummary;
	}

	public void setRiskSummary(String riskSummary) {
		this.riskSummary = riskSummary;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}

