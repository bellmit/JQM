package com.cjhxfund.foundation.fix.model;

import java.util.List;

import com.cjhxfund.foundation.fix.RiskCtrlCenterService;

public class RequestRecordModel {
	/**
	 * 风控请求参数集(保持参数与接口文档一致)
	 */
	//@NotNull
	private String isSync; // 同异步调用标志 0-同步 1-异步 2-异步调用fix 3-本地异步,fix异步
	private String requestId;
	//@NotNull
	private String instructionNo;
	//@NotNull
	private String callPoint;
	//@NotNull
	private String callSys;
	//@NotNull
	private String businessClass;
	private String beginDate;
	private String endDate;
	private String tradeDate;
	private String purposeType;
	private String futSettDate;
	private String futSettDate2;
	//@NotNull
	private String fixFlag;
	//@NotNull
	private String trialFlag;
	// 0 不检查
	// 1 检查
	// 该标志只对风控引擎生效对O32不起作用。不传入值默认是检查，在某些情况下为提高性能第一个流程节点检查了投资范围相关的风控，后续节点就可以不再检查。
	private String checkRangeRiskFlag;
	// 0 不检查
	// 1 检查
	// 该标志只对风控引擎生效对O32不起作用。不传入值默认是检查
	private String checkRatioRiskFlag;
	private String tempriskNo;
	//@NotNull
	private String clOrdId;
	private String senderSubId;
	private String processType;
	private String group;
	private String isO32Order;
	
	private String localInstructionNo;//本地指令序号
	
	private String waitingO32;//Fix同步时等待O32风控返回的最大时间

	public String getWaitingO32() {
		return waitingO32;
	}

	public void setWaitingO32(String waitingO32) {
		this.waitingO32 = waitingO32;
	}

	public String getLocalInstructionNo() {
		return localInstructionNo;
	}

	public void setLocalInstructionNo(String localInstructionNo) {
		this.localInstructionNo = localInstructionNo;
	}

	private List<RequestRecordDetail> recordDetails;

	public String getIsSync() {
		return isSync;
	}

	public void setIsSync(String isSync) {
		this.isSync = isSync;
	}

	public String getRequestId() {
		return requestId;
	}

	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}

	public String getInstructionNo() {
		return instructionNo;
	}

	public void setInstructionNo(String instructionNo) {
		this.instructionNo = instructionNo;
	}

	public String getCallPoint() {
		return callPoint;
	}

	public void setCallPoint(String callPoint) {
		this.callPoint = callPoint;
	}

	public String getCallSys() {
		return callSys;
	}

	public void setCallSys(String callSys) {
		this.callSys = callSys;
	}

	public String getBusinessClass() {
		return businessClass;
	}

	public void setBusinessClass(String businessClass) {
		this.businessClass = businessClass;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getTradeDate() {
		return tradeDate;
	}

	public void setTradeDate(String tradeDate) {
		this.tradeDate = tradeDate;
	}

	public String getPurposeType() {
		return purposeType;
	}

	public void setPurposeType(String purposeType) {
		this.purposeType = purposeType;
	}

	public String getFutSettDate() {
		return futSettDate;
	}

	public void setFutSettDate(String futSettDate) {
		this.futSettDate = futSettDate;
	}

	public String getFutSettDate2() {
		return futSettDate2;
	}

	public void setFutSettDate2(String futSettDate2) {
		this.futSettDate2 = futSettDate2;
	}

	public String getFixFlag() {
		return fixFlag;
	}

	public void setFixFlag(String fixFlag) {
		this.fixFlag = fixFlag;
	}

	public String getTrialFlag() {
		return trialFlag;
	}

	public void setTrialFlag(String trialFlag) {
		this.trialFlag = trialFlag;
	}

	public String getCheckRangeRiskFlag() {
		return checkRangeRiskFlag;
	}

	public void setCheckRangeRiskFlag(String checkRangeRiskFlag) {
		this.checkRangeRiskFlag = checkRangeRiskFlag;
	}

	public String getCheckRatioRiskFlag() {
		return checkRatioRiskFlag;
	}

	public void setCheckRatioRiskFlag(String checkRatioRiskFlag) {
		this.checkRatioRiskFlag = checkRatioRiskFlag;
	}

	public String getTempriskNo() {
		return tempriskNo;
	}

	public void setTempriskNo(String tempriskNo) {
		this.tempriskNo = tempriskNo;
	}

	public String getClOrdId() {
		return clOrdId;
	}

	public void setClOrdId(String clOrdId) {
		this.clOrdId = clOrdId;
	}

	public String getSenderSubId() {
		return senderSubId;
	}

	public void setSenderSubId(String senderSubId) {
		this.senderSubId = senderSubId;
	}

	public String getProcessType() {
		return processType;
	}

	public void setProcessType(String processType) {
		this.processType = processType;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getIsO32Order() {
		return isO32Order;
	}

	public void setIsO32Order(String isO32Order) {
		this.isO32Order = isO32Order;
	}

	public List<RequestRecordDetail> getRecordDetails() {
		return recordDetails;
	}

	public void setRecordDetails(List<RequestRecordDetail> recordDetails) {
		this.recordDetails = recordDetails;
	}
	
	/**
	 * 提供json格式的属性字符串   杨敏
	 * @return
	 */
	public String getToJsonStr(){
		String jsonStr="";//定义json 字符串
		/**根据接口文档要求 组装参数格式：
		 * {
  			Model,
		  	"recordDetails":[{
		  		record,
		  		"collateraDetails":[{
		  			collatera
		  		}]
		  	}]
		  }
		*/
		jsonStr = "{\"isSync\":"+RiskCtrlCenterService.isNull(this.getIsSync())+","+ 
				"\"requestId\":"+RiskCtrlCenterService.isNull(this.getRequestId())+","+ 
				"\"instructionNo\":"+RiskCtrlCenterService.isNull(this.getInstructionNo())+","+ 
				"\"callPoint\":"+RiskCtrlCenterService.isNull(this.getCallPoint())+","+ 
				"\"callSys\":"+RiskCtrlCenterService.isNull(this.getCallSys())+","+ 
				"\"businessClass\":"+RiskCtrlCenterService.isNull(this.getBusinessClass())+","+ 
				"\"beginDate\":"+RiskCtrlCenterService.isNull(this.getBeginDate())+","+ 
				"\"endDate\":"+RiskCtrlCenterService.isNull(this.getEndDate())+","+ 
				"\"tradeDate\":"+RiskCtrlCenterService.isNull(this.getTradeDate())+","+ 
				"\"purposeType\":"+RiskCtrlCenterService.isNull(this.getPurposeType())+","+ 
				"\"futSettDate\":"+RiskCtrlCenterService.isNull(this.getFutSettDate())+","+ 
				"\"futSettDate2\":"+RiskCtrlCenterService.isNull(this.getFutSettDate2())+","+ 
				"\"fixFlag\":"+RiskCtrlCenterService.isNull(this.getFixFlag())+","+ 
				"\"trialFlag\":"+RiskCtrlCenterService.isNull(this.getTrialFlag())+","+ 
				"\"checkRangeRiskFlag\":"+RiskCtrlCenterService.isNull(this.getCheckRangeRiskFlag())+","+ 
				"\"checkRatioRiskFlag\":"+RiskCtrlCenterService.isNull(this.getCheckRatioRiskFlag())+","+ 
				"\"tempriskNo\":"+RiskCtrlCenterService.isNull(this.getTempriskNo())+","+ 
				"\"clOrdId\":"+RiskCtrlCenterService.isNull(this.getClOrdId())+","+ 
				"\"senderSubId\":"+RiskCtrlCenterService.isNull(this.getSenderSubId())+","+ 
				"\"processType\":"+RiskCtrlCenterService.isNull(this.getProcessType())+","+ 
				"\"group\":"+RiskCtrlCenterService.isNull(this.getGroup())+","+ 
				"\"localInstructionNo\":"+RiskCtrlCenterService.isNull(this.getLocalInstructionNo())+","+ 
				"\"waitingO32\":"+RiskCtrlCenterService.isNull(this.getWaitingO32())+","+ 
				
				"\"isO32Order\":"+RiskCtrlCenterService.isNull(this.getIsO32Order())+"";
				jsonStr+=",\"recordDetails\":[";
				List<RequestRecordDetail> list = this.getRecordDetails();
				int k=1;
				if(list!=null){
					for (RequestRecordDetail requestRecordDetail : list) {
						jsonStr+="{"+requestRecordDetail.getToJsonStr()+"}";
						//最后一个不没有分号
						if(k<list.size()){
							jsonStr+=",";
							k++;
						}
					}
				}
				jsonStr=jsonStr+"]}";
		return jsonStr;
	}
}
