/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.cjhxfund.ats.sm.comm.ComparatorTrader;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 童伟
 * @date 2017-11-15 13:22:35
 *
 */
@Bizlet("指令管理公共类")
public class InstructManager {

	/**
	 * @param args
	 * @author 童伟
	 */
	public static void main(String[] args) {
		// TODO 自动生成的方法存根

	}
	
	/**
	 * @author 童伟
	 * @param reportData
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Bizlet("报量信息处理")
	public List<DataObject> assembleReportList(DataObject[] reportData){
		Map<String, ReportInfoEntity> map = new HashMap<String, ReportInfoEntity>();
		List<ReportInfoEntity> reportList = new ArrayList<ReportInfoEntity>();
		if(StrUtil.isNotEmpty(reportData)){
			for(int i=0; i<reportData.length; i++){
				String lApplyInstId = reportData[i].getString("lApplyInstId");
				String vcReportRemark = "";
				String enOffer = "";
				if(reportData[i].getString("vcReportRemark") != null){
					vcReportRemark = reportData[i].getString("vcReportRemark");
				}
				if(reportData[i].getString("enOffer") != null){
					enOffer = reportData[i].getString("enOffer");
				}
				String reportInfo = "报量（万元）："+reportData[i].getString("enReport")+"，"+
						"报价（%）："+enOffer+"，"+
						"报价说明："+vcReportRemark;		
				ReportInfoEntity obj = new ReportInfoEntity();
				if(map.containsKey(lApplyInstId)){
					String reportInfoValue = map.get(lApplyInstId).getReportInfo() + "</br>" + reportInfo;
					obj.setlApplyInstId(lApplyInstId);
					obj.setReportInfo(reportInfoValue);
					map.put(lApplyInstId, obj);
				}else{
					obj.setlApplyInstId(lApplyInstId);
					obj.setReportInfo(reportInfo);
					map.put(lApplyInstId, obj);
				}
			}
		}

		for(Entry<String, ReportInfoEntity> entry: map.entrySet()) {
			reportList.add((ReportInfoEntity) entry.getValue());
		}
		// 给拼装后的集合按照顺序排列
		ComparatorTrader comparator=new ComparatorTrader();
			Collections.sort(reportList, new Comparator<Object>() {
	            public int compare(Object o1, Object o2) {
	            	ReportInfoEntity sort1 = (ReportInfoEntity)o1;
	            	ReportInfoEntity sort2 = (ReportInfoEntity)o2;
	        		if(Integer.parseInt(sort1.getlApplyInstId())<Integer.parseInt(sort2.getlApplyInstId())){
	        			return 0;
	        		}else{
	        			return 1;
	        		}
	            }
	        }
		);
		List<DataObject> list = new ArrayList<DataObject>();
		for(int j=0; j<reportList.size(); j++){	
			DataObject resultObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
			resultObj.setString("lApplyInstId", reportList.get(j).getlApplyInstId());
			resultObj.setString("reportInfo", reportList.get(j).getReportInfo());
			list.add(resultObj);
		}
		return list;
	}
	
	
	
}
