package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.eos.foundation.common.utils.StringUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.workflow.api.PageCond;

import commonj.sdo.DataObject;

/**
 * 针对代理单独做筛选和排序
 * @author chenxing
 *
 */
@Bizlet("针对代理单独做筛选和排序")
public class AgentTaskDeal {

	/**
	 * 数据筛选
	 * @param tasklist 
	 * @param checkMap 
	 */
	@Bizlet("数据筛选")
	public DataObject[] processAgentTaskCheck(DataObject[] tasklist, Map<String,String> checkMap) {
		
		String processType = checkMap.get("processType");
		String prodName = checkMap.get("prodName");
		boolean isBlank1 = StringUtil.isBlank(processType);
		boolean isBlank2 = StringUtil.isBlank(prodName);
		String processInstName;
		String procInsProductName;
		String procInsProcessType;
		//return value
		DataObject[] resultArr;
		//返回dataobject下标
		int i=0;
		//数据筛选
        if(!isBlank1 || !isBlank2){
        	   List<DataObject> resultList=new ArrayList<DataObject>();
				for (DataObject dataObject : tasklist) {
					processInstName = dataObject.getString("processInstName");
					procInsProcessType = splitValue("processType",processInstName);
					procInsProductName = splitValue("prodName",processInstName);
					dataObject.setString("processType", procInsProcessType);
					dataObject.setString("productName", procInsProductName);
					if(!isBlank1 && !isBlank2){
						//if(procInsProcessType.indexOf(processType)!=-1 && procInsProductName.indexOf(prodName)!=-1){
						if(procInsProcessType.indexOf(processType)!=-1 && procInsProductName.contains(prodName)){
							resultList.add(dataObject);
						}
					}else{
						if(!isBlank1){
							if(procInsProcessType.indexOf(processType)!=-1){
								resultList.add(dataObject);
							}
						}else if(!isBlank2){
							//if(procInsProductName.indexOf(prodName)!=-1){
							 if(procInsProductName.contains(prodName)){
								resultList.add(dataObject);
							}
						}else{
						}
					}
				}
				resultArr=DataObjectUtil.convertDataObjects(resultList, "com.eos.workflow.data.WFWorkItem", true);
		 }else{
			 resultArr = tasklist;
			 for (DataObject dataObject : resultArr) {
					processInstName = dataObject.getString("processInstName");
					procInsProcessType = splitValue("processType",processInstName);
					procInsProductName = splitValue("prodName",processInstName);
					dataObject.setString("processType", procInsProcessType);
					dataObject.setString("productName", procInsProductName);
			 }
		 }
        return resultArr;
		
	}
    /**
     * 拆分产品名称和流程类型
     */
	public String splitValue(String type,String processInstName){
		String result="";
		//[]
		int processInstFront;
		int processInstEnd;
		//- --
		int processInstSign1;
		int processInstSign2;
		if(type.equals("processType")){
			processInstFront = processInstName.indexOf("【");
			processInstEnd = processInstName.indexOf("】");
			//流程类型
			result = processInstName.substring((processInstFront+1),processInstEnd);
		}else if(type.equals("prodName")){
			processInstSign1 = processInstName.indexOf("-");
			processInstSign2 = processInstName.indexOf("--");
			//--存在
			if(processInstSign2!=-1){
				//产品名称
				result = processInstName.substring((processInstSign1+1),processInstSign2);
			}else{
				result = processInstName.substring((processInstSign1+1),processInstName.length());
			}
		}else{
		}
		return result;
	}
    
	/**
	 * 数据分页
	 * @param tasklist 
	 * @param checkMap 
	 * @param fieldName 
	 * @param fieldOrder 
	 */
	@Bizlet("计算page")
	public DataObject[] getPageData(DataObject[] list,DataObject pagecond) {
		int count=list.length;
		int length=pagecond.getInt("length");
		int totalPage=(int)Math.ceil((double)count/length);
		int begin=pagecond.getInt("begin");
		int currentPage=0;
		String processInstName;
		String procInsProductName;
		String procInsProcessType;
		if(begin==0){
			currentPage=1;
		}else{
			currentPage=begin/length+1;
		}
		int end=currentPage*length;
		if (end>count)
			end=count;
		List<DataObject> resultList=new ArrayList<DataObject>();
		for(int i=begin;i<end;i++){
			DataObject dataObject = list[i];
			processInstName = dataObject.getString("processInstName");
			procInsProcessType = splitValue("processType",processInstName);
			procInsProductName = splitValue("prodName",processInstName);
			dataObject.setString("processType", procInsProcessType);
			dataObject.setString("productName", procInsProductName);
			resultList.add(dataObject);
		}
		if(currentPage==1){
			pagecond.set("isFirst", true);
			pagecond.set("isLast", false);
		}else if (currentPage==totalPage){
			pagecond.set("isFirst",false);
			pagecond.set("isLast", true);
		}
		pagecond.set("count", count);
		pagecond.set("totalPage", totalPage);
		pagecond.set("currentPage", currentPage);
		DataObject[] result=DataObjectUtil.convertDataObjects(resultList, "com.eos.workflow.data.WFWorkItem", true);
	   return result;
       
	}
}
