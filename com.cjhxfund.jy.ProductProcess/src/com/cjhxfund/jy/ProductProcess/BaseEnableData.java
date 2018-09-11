package com.cjhxfund.jy.ProductProcess;

import java.util.List;
/**
 * 计算总明细
 * @author chendi
 *
 */
public class BaseEnableData {
	/**返回码**/
	private String code;
	/**返回信息**/
	private String msg;
	/**返回详情列表**/
	private List<CashEnableDtlData> data;
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
	public List<CashEnableDtlData> getData() {
		return data;
	}
	public void setData(List<CashEnableDtlData> data) {
		this.data = data;
	}
}
