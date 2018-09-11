package com.cjhxfund.jy.ProductProcess;

import java.util.List;

public class BasePostion {
	
	public BasePostion(){}
	/**返回码 */
	private String code;
	/**返回信息 */
	private String msg;
	/**头寸预测信息列表 */
	private List<RealPostion> data;
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
	public List<RealPostion> getData() {
		return data;
	}
	public void setData(List<RealPostion> data) {
		this.data = data;
	}
	
	
}
