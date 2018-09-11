package com.cjhxfund.commonUtil.model;

import com.eos.system.annotation.Bizlet;

/**
 * 产品组合与处理人员权限关系的实体类
 * @author huangmizhi
 * @date 2016-11-09
 */
@Bizlet("")
public class TProductHandle {
	
	/** 权限关系类型 */
	private String vcRelateType;
	/** 用户账号ID，如：huangmizhi */
	private String vcUserId;
	/** 用户名称，如：黄秘志 */
	private String vcUserName;
	/** 产品序号，如：1001 */
	private String lProductId;
	/** 产品代码，如：001199 */
	private String vcProductCode;
	/** 产品名称，如：创金合信聚利债券（工行） */
	private String vcProductName;
	/** 资产单元序号，如：31 */
	private String lAssetId;
	/** 资产单元编号(代码)，如：00119900 */
	private String vcAssetNo;
	/** 资产单元名称，如：聚利债券 */
	private String vcAssetName;
	/** 组合序号，如：29 */
	private String lCombiId;
	/** 组合编号(代码)，如：1001_000 */
	private String vcCombiNo;
	/** 组合名称，如：缺省组合 */
	private String vcCombiName;
	
	/** 用户账号ID+用户名称，如：huangmizhi,黄秘志 */
	private String vcUserIdName;
	/** 产品序号+产品名称，如：1001,创金合信聚利债券（工行） */
	private String vcProductIdName;
	/** 产品代码+产品名称，如：001199,创金合信聚利债券（工行） */
	private String vcProductCodeName;
	/** 产品序号+产品代码+产品名称，如：1001,001199,创金合信聚利债券（工行） */
	private String vcProductIdCodeName;
	/** 资产单元序号+资产单元名称，如：31,聚利债券 */
	private String vcAssetIdName;
	/** 资产单元编号(代码)+资产单元名称，如：00119900,聚利债券 */
	private String vcAssetNoName;
	/** 资产单元序号+资产单元编号(代码)+资产单元名称，如：31,00119900,聚利债券 */
	private String vcAssetIdNoName;
	/** 组合序号+组合名称，如：29,缺省组合 */
	private String vcCombiIdName;
	/** 组合编号(代码)+组合名称，如：1001_000,缺省组合 */
	private String vcCombiNoName;
	/** 组合序号+组合编号(代码)+组合名称，如：29,1001_000,缺省组合 */
	private String vcCombiIdNoName;
	
	@Bizlet("")
	public String getVcRelateType() {
		return vcRelateType;
	}
	@Bizlet("")
	public void setVcRelateType(String vcRelateType) {
		this.vcRelateType = vcRelateType;
	}
	@Bizlet("")
	public String getVcUserId() {
		return vcUserId;
	}
	@Bizlet("")
	public void setVcUserId(String vcUserId) {
		this.vcUserId = vcUserId;
	}
	@Bizlet("")
	public String getVcUserName() {
		return vcUserName;
	}
	@Bizlet("")
	public void setVcUserName(String vcUserName) {
		this.vcUserName = vcUserName;
	}
	@Bizlet("")
	public String getlProductId() {
		return lProductId;
	}
	@Bizlet("")
	public void setlProductId(String lProductId) {
		this.lProductId = lProductId;
	}
	@Bizlet("")
	public String getVcProductCode() {
		return vcProductCode;
	}
	@Bizlet("")
	public void setVcProductCode(String vcProductCode) {
		this.vcProductCode = vcProductCode;
	}
	@Bizlet("")
	public String getVcProductName() {
		return vcProductName;
	}
	@Bizlet("")
	public void setVcProductName(String vcProductName) {
		this.vcProductName = vcProductName;
	}
	@Bizlet("")
	public String getlAssetId() {
		return lAssetId;
	}
	@Bizlet("")
	public void setlAssetId(String lAssetId) {
		this.lAssetId = lAssetId;
	}
	@Bizlet("")
	public String getVcAssetNo() {
		return vcAssetNo;
	}
	@Bizlet("")
	public void setVcAssetNo(String vcAssetNo) {
		this.vcAssetNo = vcAssetNo;
	}
	@Bizlet("")
	public String getVcAssetName() {
		return vcAssetName;
	}
	@Bizlet("")
	public void setVcAssetName(String vcAssetName) {
		this.vcAssetName = vcAssetName;
	}
	@Bizlet("")
	public String getlCombiId() {
		return lCombiId;
	}
	@Bizlet("")
	public void setlCombiId(String lCombiId) {
		this.lCombiId = lCombiId;
	}
	@Bizlet("")
	public String getVcCombiNo() {
		return vcCombiNo;
	}
	@Bizlet("")
	public void setVcCombiNo(String vcCombiNo) {
		this.vcCombiNo = vcCombiNo;
	}
	@Bizlet("")
	public String getVcCombiName() {
		return vcCombiName;
	}
	@Bizlet("")
	public void setVcCombiName(String vcCombiName) {
		this.vcCombiName = vcCombiName;
	}
	
	@Bizlet("")
	public String getVcUserIdName() {
		return vcUserId+","+vcUserName;
	}
	@Bizlet("")
	public String getVcProductIdName() {
		return lProductId+","+vcProductName;
	}
	@Bizlet("")
	public String getVcProductCodeName() {
		return vcProductCode+","+vcProductName;
	}
	@Bizlet("")
	public String getVcProductIdCodeName() {
		return lProductId+","+vcProductCode+","+vcProductName;
	}
	@Bizlet("")
	public String getVcAssetIdName() {
		return lAssetId+","+vcAssetName;
	}
	@Bizlet("")
	public String getVcAssetNoName() {
		return vcAssetNo+","+vcAssetName;
	}
	@Bizlet("")
	public String getVcAssetIdNoName() {
		return lAssetId+","+vcAssetNo+","+vcAssetName;
	}
	@Bizlet("")
	public String getVcCombiIdName() {
		return lCombiId+","+vcCombiName;
	}
	@Bizlet("")
	public String getVcCombiNoName() {
		return vcCombiNo+","+vcCombiName;
	}
	@Bizlet("")
	public String getVcCombiIdNoName() {
		return lCombiId+","+vcCombiNo+","+vcCombiName;
	}
	
}
