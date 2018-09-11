package com.cjhxfund.foundation.fix.model;

import java.math.BigDecimal;
import java.util.List;

public class CheckResultReturn {

	private String clOrdId;

	private String processType;

	// 0-表示计算正常 1-风控系统处理异常 2-风控系统正常,fix未返回结果 3-请求参数有误 4-未找到原请求记录
	private String errorCode;

	// 错误信息
	private String errorMsg;

	// 风控结果计数：如果ErrorCode为0且ResultCount为0表示未触发风控
	private String riskResult;

	// 详细信息包含的记录数对应O32Group
	private String rcGroup;
	//不能触发风控的记录数
	private String ucGroup;
	
	
	public String getUcGroup() {
		return ucGroup;
	}

	public void setUcGroup(String ucGroup) {
		this.ucGroup = ucGroup;
	}
	private List<RcCheckResultDto> checkResultDetail;

	private List<UncontrolResult> uncontrolDetail;

	public String getClOrdId() {
		return clOrdId;
	}

	public void setClOrdId(String clOrdId) {
		this.clOrdId = clOrdId;
	}

	public String getProcessType() {
		return processType;
	}

	public void setProcessType(String processType) {
		this.processType = processType;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getRiskResult() {
		return riskResult;
	}

	public void setRiskResult(String riskResult) {
		this.riskResult = riskResult;
	}

	public String getRcGroup() {
		return rcGroup;
	}

	public void setRcGroup(String rcGroup) {
		this.rcGroup = rcGroup;
	}

	public List<RcCheckResultDto> getCheckResultDetail() {
		return checkResultDetail;
	}

	public void setCheckResultDetail(List<RcCheckResultDto> checkResultDetail) {
		this.checkResultDetail = checkResultDetail;
	}

	public List<UncontrolResult> getUncontrolDetail() {
		return uncontrolDetail;
	}

	public void setUncontrolDetail(List<UncontrolResult> uncontrolDetail) {
		this.uncontrolDetail = uncontrolDetail;
	}
	
}
