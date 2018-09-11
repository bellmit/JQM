package com.cjhxfund.ats.riskMgr;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

public class RiskmgrUtil {

	/**
	 * 将指令对象转换为Fix报文发送对象（指令撤销[废弃]）
	 * @param obj 将要发送的报文对象
	 * @return
	 * @author liuyulong
	 */
	@Bizlet("")
	public static String parseRiskInterfaceMsg(DataObject obj){
		StringBuffer sb = new StringBuffer();
		Object[] riskMsgs = (Object[]) obj.get("resultDetail");
		if(riskMsgs.length>0){
			for(int i=0; i<riskMsgs.length;i++){
				StringBuffer sbMsg = new StringBuffer();
				Map riskMsg = (Map) riskMsgs[i];
				String riskType = "";
				if("1".equals(riskMsg.get("cRiskOperation").toString())){
					riskType = "-预警";
				}else if("2".equals(riskMsg.get("cRiskOperation").toString())){
					riskType = "-禁止";
				}else if("3".equals(riskMsg.get("cRiskOperation").toString())){
					riskType = "-申请指令审批";
				}else if("4".equals(riskMsg.get("cRiskOperation").toString())){
					riskType = "-申请风险阀值";
				}
				/** 示例：组合[1001_000]证券[100005]触发风控[375][禁止]：债券成交收益率不超过公允收益率60bp； */
				sbMsg.append("[")
					 .append(riskMsg.get("vcCombiNo").toString())
					 .append("][")
					 .append(riskMsg.get("vcSymbol").toString())
					 .append("]触发[")
					 .append(riskMsg.get("vcRuleId").toString())
					 .append(riskType)
					 .append("]：")
					 .append(riskMsg.get("vcRiskSummary").toString())
					 .append("；");
				sb.append(i+1).append("、").append(sbMsg.toString());
				System.out.println(sb.toString());
				if(i<riskMsgs.length-1){
					sb.append("</br>");
				}
			}
		}
		return sb.toString();
	}
	
	
	@Bizlet("通过风控编号过滤风控信息")
	/**
	 * 
	 * @param obj  风控信息
	 * @param filterRiskNo  不可用风控编号过滤
	 * @param availFilterRiskNo 可用不足风控过滤
	 * @return 风控信息
	 */
	public static DataObject filterByRiskNo(DataObject obj,String filterRiskNo,String availFilterRiskNo){
		if(obj==null||"".equals(obj)) return obj;
		Object[] riskMsgs = (Object[]) obj.get("resultDetail");
		List<DataObject> list = new ArrayList<DataObject>();
		String availMsg = "";
		if(riskMsgs != null&&riskMsgs.length>0){
			//过滤不可用风控
			if(!"".equals(filterRiskNo)&&filterRiskNo!=null){
				String[] filterRiskNoArray = filterRiskNo.split(",");
				for(int i=0; i<riskMsgs.length;i++){
					boolean isFilter = false;//是否过滤
					DataObject riskMsg = (DataObject) riskMsgs[i];
					for(String str:filterRiskNoArray){
						if(str!=null&&!"".equals(str)&&str.equals(riskMsg.getString("vcRuleId"))) isFilter=true;
					}
					if(!isFilter) list.add(riskMsg);
				}
			}
			//过滤可用不足风控
			if(!"".equals(availFilterRiskNo)&&availFilterRiskNo!=null){
				String[] availFilterRiskNoArray = availFilterRiskNo.split(",");
				Iterator<DataObject> iter = list.iterator();
				while(iter.hasNext()){
					DataObject riskMsg = iter.next();
					for(String str:availFilterRiskNoArray){
						if(str!=null&&!"".equals(str)&&str.equals(riskMsg.getString("vcRuleId"))) {
							availMsg = "".equals(availMsg)||availMsg==null?
									riskMsg.getString("vcRiskSummary"):availMsg+"<br>"+riskMsg.getString("vcRiskSummary");//记录可用不足风控说明
							iter.remove();
						}
					}
				}
			}
			
			if(list.isEmpty()){
				obj.setString("cRiskResult", "0");
			} else {
				int cRiskOperation = 0;
				for(DataObject dataObj : list){
					if(Integer.parseInt(dataObj.getString("cRiskOperation")) ==1 && cRiskOperation<=1){
						cRiskOperation = 1;//预警类
					} else if (Integer.parseInt(dataObj.getString("cRiskOperation")) ==2 && cRiskOperation<=2){
						cRiskOperation = 2;//禁止类
						break;
					} else if (Integer.parseInt(dataObj.getString("cRiskOperation")) ==3 && cRiskOperation<=3){
						cRiskOperation = 3;//审批类
					}
				}
				obj.setString("cRiskResult", String.valueOf(cRiskOperation));
			}
			obj.set("resultDetail",list.toArray(new Object[list.size()]));
			obj.setString("availMsg",availMsg);
		} 
		return obj;
	}
}
