package com.cjhxfund.jy.ProductProcess;

import java.util.List;
/**
 * 存款业务
 * @author chendi
 *
 */
public class BaseDpstData {
	/**返回码**/
	private String code;
	/**返回信息**/
	private String msg;
	/**返回详情列表**/
	private List<DpstBizDtlData> data;
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
	public List<DpstBizDtlData> getData() {
		return data;
	}
	public void setData(List<DpstBizDtlData> data) {
		this.data = data;
	}
}
