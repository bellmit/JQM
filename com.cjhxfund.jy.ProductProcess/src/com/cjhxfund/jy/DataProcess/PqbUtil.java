package com.cjhxfund.jy.DataProcess;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.eos.foundation.data.DataObjectUtil;

import commonj.sdo.DataObject;

public class PqbUtil {
	
public static List<String> splitCodition(List<PositionBasic> list,int batch){
		
		int size = list.size();
		StringBuilder sb = new StringBuilder();
    	Set<String> soleCode = new HashSet<String>();
    	List<String> split = new ArrayList<String>();
    	int count = 0;
        for(int i=0;i<size;i++){
        	
        	PositionBasic pb = list.get(i);  
        	if(!soleCode.contains(pb.getVcInterCodeWind2())){
        		sb.append("'").append(pb.getVcInterCodeWind2()).append("'");
        		sb.append(",");
        		soleCode.add(pb.getVcInterCodeWind2());
        		count++;
        		if(count == batch){
        			sb.delete(sb.length()-1, sb.length());
        			split.add(sb.toString());
        			sb.delete(0, sb.length());
        			count = 0;
        		}
        		

        	}
        	
        }
		return split;
		
	}

	public void deDuplicate(List<PositionBasic> list){
		
		List<Integer> delete = new ArrayList<Integer>();
		Map<String,PositionBasic> buyMap = new HashMap<String,PositionBasic>();
		Map<String,PositionBasic> sellMap = new HashMap<String,PositionBasic>();
		for(int i=0;i<list.size();i++){
			PositionBasic pb = list.get(i);
			String isBuyBack = pb.getIsBuyBack();
			String isSellBack = pb.getIsSellBack();
			String cPositionFlag = pb.getcPositionFlag();
			if(isBuyBack != null){
				delete.add(i);
				if(buyMap.containsKey(isBuyBack)){
					PositionBasic value = buyMap.get(isBuyBack);
					if(cPositionFlag.equals("1")){
						value.setlUsableAmount(pb.getlCurrentAmount());
					}
					else if(cPositionFlag.equals("5")){
						value.setlCurrentAmount(pb.getlCurrentAmount());
					}
				}
				else{
					PositionBasic value = new PositionBasic();
					setInfo(value,pb);
					buyMap.put(isBuyBack, value);
				}
			}
			
			if(isSellBack != null){
				delete.add(i);
				if(sellMap.containsKey(isSellBack)){
					PositionBasic value = sellMap.get(isSellBack);
					if(cPositionFlag.equals("1")){
						value.setlUsableAmount(pb.getlCurrentAmount());
						value.setlCurrentAmount(pb.getlCurrentAmount());
					}
				}
				else{
					PositionBasic value = new PositionBasic();
					setInfo(value,pb);
					sellMap.put(isSellBack, value);
				}
			}
		}
		
		//删除买断式回购数据
		for(int de:delete){
			list.remove(de);
		}
		
		//加入调整后数据
		for(PositionBasic buy:buyMap.values()){
			list.add(buy);
		}
		for(PositionBasic sell:sellMap.values()){
			list.add(sell);
		}
		
	}
	
	public void tagSellBack(List<PositionBasic> list,Map<String,String> map){
		
		for(PositionBasic pb:list){
			String key = pb.getlFundId().toString() + pb.getVcCombiNo() + pb.getVcInterCode();
			if(map.containsKey(key)){
				String date = map.get(key);
				String year = date.substring(0,4);
				String mon = date.substring(4,6);
				String day = date.substring(6,8);
				String tag = "买断式逆回购" + year + "年" + mon + "月" + day + "日到期";
				pb.setVcTag(tag);
			}
		}
		
	}
	
	public void setInfo(PositionBasic value,PositionBasic pb){
		value.setlFundId(pb.getlFundId());
		value.setlDate(pb.getlDate());
		value.setVcFundCode(pb.getVcFundCode());
		value.setVcFundName(pb.getVcFundName());
		value.setVcCombiNo(pb.getVcCombiNo());
		value.setVcCombiName(pb.getVcCombiName());
		value.setVcInterCode(pb.getVcInterCode());
		value.setVcReportCode(pb.getVcReportCode());
		value.setVcStockName(pb.getVcStockName());
		value.setlUsableAmount(pb.getlUsableAmount());
		value.setlCurrentAmount(pb.getlCurrentAmount());
		value.setcPositionFlag(pb.getcPositionFlag());
		value.setcMarketNo(pb.getcMarketNo());
		value.setVcInterCodeWind2(pb.getVcInterCodeWind2());
		value.setIsBuyBack(pb.getIsBuyBack());
		value.setIsSellBack(pb.getIsSellBack());
	}
	
	public DataObject[] transPbData(List<PositionBasic> list){
		int size = list.size();
		DataObject[] dataObjs = new DataObject[size];
		for(int i=0;i<size;i++){
			DataObject dataObj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.pqbDataset.TAtsFormPledge");
			PositionBasic pb = list.get(i);
			Long lFundId = pb.getlFundId();
			String lDate = pb.getlDate();
			String vcFundCode = pb.getVcFundCode();
			String vcFundName = pb.getVcFundName();
			String vcCombiNo = pb.getVcCombiNo();
			String vcCombiName = pb.getVcCombiName();
			String vcInterCode = pb.getVcInterCode();
			String vcReportCode = pb.getVcReportCode();
			String vcStockName = pb.getVcStockName();
			String cStockType = pb.getcStockType();
			Long lUsableAmount = pb.getlUsableAmount();
			Long lCurrentAmount = pb.getlCurrentAmount();
			String cPositionFlag = pb.getcPositionFlag();
			String cMarketNo = pb.getcMarketNo();
			String cTrustee = pb.getcTrustee();
			String vcInterCodeWind2 = pb.getVcInterCodeWind2();
			String vcTag = pb.getVcTag();
			String bIssuerCode = pb.getbIssuerCode();
			String sInfoName = pb.getsInfoName();
			String bDelistDate = pb.getbDelistDate();
			Long bCnbd = pb.getbCnbd();
			String bIC1 = pb.getbIC1();
			String bIC2 = pb.getbIC2();
			String bIC3 = pb.getbIC3();
			String bIC4 = pb.getbIC4();
			String bPaymentDate = pb.getbPaymentDate();
			String bICD = pb.getbICD();
			String bGuarantorNature = pb.getbGuarantorNature();
			String bRatingOutlook = pb.getbRatingOutlook();
			String isCityInvest = pb.getIsCityInvest();
			String bPtmyear = pb.getbPtmyear();
			String sIndustryName2 = pb.getsIndustryName2();
			String province = pb.getProvince();
			String isPayEarly = pb.getIsPayEarly();
			dataObj.set("tInputTime",lDate);
			dataObj.set("lFundId",lFundId);
			dataObj.set("vcFundCode",vcFundCode);
			dataObj.set("vcFundName",vcFundName);
			dataObj.set("vcCombiNo",vcCombiNo);
			dataObj.set("vcCombiName",vcCombiName);
			dataObj.set("vcInterCode",vcInterCode);
			dataObj.set("vcReportCode",vcReportCode);
			dataObj.set("vcStockName",vcStockName);
			dataObj.set("cStockType",cStockType);
			dataObj.set("lUsableAmount",lUsableAmount);
			dataObj.set("lCurrentAmount",lCurrentAmount);
			dataObj.set("cPositionFlag",cPositionFlag);
			dataObj.set("cMarketNo",cMarketNo);
			dataObj.set("cTrustee",cTrustee);
			dataObj.set("vcInterCodeWind2",vcInterCodeWind2);
			dataObj.set("vcTag",vcTag);
			dataObj.set("bInfoIssuercode",bIssuerCode);
			dataObj.set("sInfoName",sInfoName);
			dataObj.set("bInfoDelistdate",bDelistDate);
			dataObj.set("bAnalNetCnbd",bCnbd);
			dataObj.set("bic1",bIC1);
			dataObj.set("bic2",bIC2);
			dataObj.set("bic3",bIC3);
			dataObj.set("bic4",bIC4);
			dataObj.set("bInfoPaymentdate",bPaymentDate);
			dataObj.set("bInfoCallbkorputbkdate",bICD);
			dataObj.set("bAgencyGuarantornature",bGuarantorNature);
			dataObj.set("bRateRatingoutlook",bRatingOutlook);
			dataObj.set("isCityInvest",isCityInvest);
			dataObj.set("bAnalPtmyear",bPtmyear);
			dataObj.set("sInfoIndustryname2",sIndustryName2);
			dataObj.set("province",province);
			dataObj.set("isPayEarly",isPayEarly);
			dataObjs[i] = dataObj;
		}
		return dataObjs;
	}

}
