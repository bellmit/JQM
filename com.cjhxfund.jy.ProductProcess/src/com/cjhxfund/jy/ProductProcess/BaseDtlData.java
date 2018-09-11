package com.cjhxfund.jy.ProductProcess;

import java.util.List;
/**
 * 付息兑付明细
 * @author chendi
 *
 */
public class BaseDtlData {
	/**返回码**/
	private String code;
	/**返回信息**/
	private String msg;
	/**返回详情列表**/
	private List<BizDtlData> data;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public List<BizDtlData> getData() {
		return data;
	}
	public void setData(List<BizDtlData> data) {
		this.data = data;
	}
	
}
