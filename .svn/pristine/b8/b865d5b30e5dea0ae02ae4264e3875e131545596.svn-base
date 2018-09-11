package com.cjhxfund.cjapi.model;

import java.io.Serializable;

import commonj.sdo.DataObject;

/**
 * 
 * @Description	对象参数Vo
 * @ClassName	ObjectParamVo
 * @Date		2016年12月9日 下午2:03:05
 * @Author		liangjilong
 * @Copyright (c) All Rights Reserved, 2016.
 */
@SuppressWarnings("all")
public class ObjectParamVo implements Serializable{

	/**entityName 动态实体名称（这样查询多张表字段都一样，可以减少命名SQL配置查询工作量）*/
	private String entityName;
	/**isNeedParam是否需要参数(是/否)true/false*/
	private boolean isNeedParam;
	/**参数对象*/
	private DataObject paramters;
	/**是否新增留痕 (是/否)true/false*/ 
	private boolean isAdd;

	public ObjectParamVo() {
		super();
	}
	
	public ObjectParamVo(DataObject paramters,String entityName) {
		super();
		this.paramters = paramters;
		this.entityName = entityName;
	}
	
	public ObjectParamVo(DataObject paramters,String entityName, boolean isNeedParam,boolean isAdd) {
		super();
		this.paramters = paramters;
		this.entityName = entityName;
		this.isNeedParam = isNeedParam;
		this.isAdd=isAdd;
	}
	 
	public DataObject getParamters() {
		return paramters;
	}
	public void setParamters(DataObject paramters) {
		this.paramters = paramters;
	}
	public String getEntityName() {
		return entityName;
	}
	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	public boolean isAdd() {
		return isAdd;
	}

	public void setIsAdd(boolean isAdd) {
		this.isAdd = isAdd;
	}
	
	public boolean getIsNeedParam() {
		return isNeedParam;
	}

	public void setIsNeedParam(boolean isNeedParam) {
		this.isNeedParam = isNeedParam;
	}
	
}
