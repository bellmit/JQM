/**
 * 
 */
package com.cjhxfund.ats.sm.repurchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 罗倔怀
 * @date 2016-12-01 10:52:03
 *
 */
@Bizlet("发送消息组装类")
public class CombSendMsg {
	@Bizlet("组装T+0可质押数量、T+1可质押数量发送参数")
	public static DataObject comb(Object[] list,String vcMarket){
		int length = list.length;
		List<HashMap<String,String>> combis = new ArrayList<HashMap<String,String>>(); 
		DataObject sendMsg = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		for(int i =0;i<length;i++){
			DataObject temp2 = (DataObject) list[i];
			HashMap<String, String> temp = new HashMap<String, String>();
			temp.put("vcStockCode", temp2.getString("vcReportCode"));
			temp.put("vcAccount", temp2.getString("vcCombiCode"));
			if("5".equals(temp2.getString("vcExchange"))){
				temp.put("vcMarket", "OTC");
			}else if("1".equals(temp2.getString("vcExchange"))){
				temp.put("vcMarket", "SS");
			}else if("2".equals(temp2.getString("vcExchange"))){
				temp.put("vcMarket", "SZ");
			}
			temp.put("vcBusinType", "5");
			temp.put("vcInvestType", "1");
			combis.add(temp);
		}
		sendMsg.set("combis", combis.toArray());
		return sendMsg;
	}
	@Bizlet("组装T+0可卖数量发送参数")
	public static DataObject comb2(Object[] list,String vcMarket){
		int length = list.length;
		List<HashMap<String,String>> combis = new ArrayList<HashMap<String,String>>(); 
		DataObject sendMsg = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		for(int i =0;i<length;i++){
			DataObject temp2 = (DataObject) list[i];
			HashMap<String, String> temp = new HashMap<String, String>();
			temp.put("vcStockCode", temp2.getString("vcReportCode"));
			temp.put("vcAccount", temp2.getString("vcCombiCode"));
			if("5".equals(temp2.getString("vcExchange"))){
				temp.put("vcMarket", "OTC");
			}else if("1".equals(temp2.getString("vcExchange"))){
				temp.put("vcMarket", "SS");
			}else if("2".equals(temp2.getString("vcExchange"))){
				temp.put("vcMarket", "SZ");
			}
			temp.put("vcBusinType", "4");
			temp.put("vcInvestType", "1");
			combis.add(temp);
		}
		sendMsg.set("combis", combis.toArray());
		return sendMsg;
	}
	
	@Bizlet("组装T+0可质押数量、T+1可质押数量返回值")
	public static DataObject[] combAvai(List<DataObject> avaiList,DataObject[] entityList){
		int length = entityList.length;
		int length2 = avaiList.size();
		for(int i =0;i<length;i++){
			for(int j = 0;j<length2;j++){
				if(entityList[i].getString("vcReportCode").equals(avaiList.get(j).getString("VC_SYMBOL"))){
					entityList[i].set("vcAvailablequantityT0", avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T0"));
					entityList[i].set("vcAvailablequantityT1", avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T1"));
				}
			}
		}
		return entityList;
	}
	@Bizlet("组装T+0可卖数量返回值")
	public static DataObject[] combAvai2(List<DataObject> avaiList,DataObject[] entityList){
		int length = entityList.length;
		int length2 = avaiList.size();
		for(int i =0;i<length;i++){
			for(int j = 0;j<length2;j++){
				if(entityList[i].getString("vcReportCode").equals(avaiList.get(j).getString("VC_SYMBOL"))){
					entityList[i].set("canSellAmount", avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T0"));
				}
			}
		}
		return entityList;
	}
}
