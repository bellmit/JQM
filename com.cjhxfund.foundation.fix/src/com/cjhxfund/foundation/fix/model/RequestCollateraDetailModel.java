package com.cjhxfund.foundation.fix.model;

import com.cjhxfund.foundation.fix.RiskCtrlCenterService;

/**
 * 接收参数集：回购指令抵押券明细参数详情
 *
 * @author lujinfu
 * @date 2017年4月14日
 */
public class RequestCollateraDetailModel {
	/**
	 * 风控回购指令抵押券明细返回参数集(保持参数与接口文档一致)
	 */
	private String exDestination;
	private String combinNo;
	private String investType;
	private String symbol;
	private String collateralRatio;
	private String collateralQty;
	private String collateralValue;

	public String getExDestination() {
		return exDestination;
	}

	public void setExDestination(String exDestination) {
		this.exDestination = exDestination;
	}

	public String getCombinNo() {
		return combinNo;
	}

	public void setCombinNo(String combinNo) {
		this.combinNo = combinNo;
	}

	public String getInvestType() {
		return investType;
	}

	public void setInvestType(String investType) {
		this.investType = investType;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getCollateralRatio() {
		return collateralRatio;
	}

	public void setCollateralRatio(String collateralRatio) {
		this.collateralRatio = collateralRatio;
	}

	public String getCollateralQty() {
		return collateralQty;
	}

	public void setCollateralQty(String collateralQty) {
		this.collateralQty = collateralQty;
	}

	public String getCollateralValue() {
		return collateralValue;
	}

	public void setCollateralValue(String collateralValue) {
		this.collateralValue = collateralValue;
	}
	/**
	 * 提供json格式的属性字符串   杨敏
	 * @return
	 */
	public String getToJsonStr(){
		String jsonStr="";//定义json 字符串
		
		jsonStr = "\"exDestination\":"+RiskCtrlCenterService.isNull(this.getExDestination())+","+
				"\"combinNo\":"+RiskCtrlCenterService.isNull(this.getCombinNo())+","+
				"\"investType\":"+RiskCtrlCenterService.isNull(this.getInvestType())+","+
				"\"symbol\":"+RiskCtrlCenterService.isNull(this.getSymbol())+","+
				"\"collateralRatio\":"+RiskCtrlCenterService.isNull(this.getCollateralRatio())+","+
				"\"collateralQty\":"+RiskCtrlCenterService.isNull(this.getCollateralQty())+","+
				"\"collateralValue\":"+RiskCtrlCenterService.isNull(this.getCollateralValue())+"";
		return jsonStr;
	}
}
