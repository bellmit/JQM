package com.cjhxfund.ats.ipo;

import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;

@Bizlet("")
public class CompareDataUtil {
	
	/**
	 * 组装对比后的数据，供页面显示
	 * @param purchaseInfo 本地申购指令对应的产品列表
	 * @param importDatas 外部导入申购产品列表
	 * @param instructInfo 本地申购指令数据
	 * @return
	 */
	@Bizlet("组装比较后的数据")
	public static DataObject[] concatInstruct(DataObject[] purchaseInfo,DataObject[] importDatas,DataObject instructInfo){
		DataObject[] result=null;
		//数据来源(0为本地数据库中的数据，1为通过Excel导入的数据)
//		String dsSource="0";
		//本地数据与Excel导入的数据唯一标识是否匹配，0 表示匹配，1表示不匹配
//		String primaryKey="0";
		//未匹配的本地数据List
		List<DataObject> dataList=new ArrayList<DataObject>();
		//未匹配的导入数据List
		List<DataObject> importList=new ArrayList<DataObject>();
		//已匹配的本地数据List
		List<DataObject> dataListEqual=new ArrayList<DataObject>();
		//已匹配的导入数据List
		List<DataObject> importListEqual=new ArrayList<DataObject>();
		
		/**
		 * 该段逻辑主要用于对比导入的数据与本地数据
		 */
		if(purchaseInfo!=null && purchaseInfo.length>0){
			if(importDatas!=null && importDatas.length>0){
				if(instructInfo!=null){
					String vcChangeNo=instructInfo.getString("vcExchangeNo");
					String vcPurchaseCode=instructInfo.getString("vcPurchaseCode");
					if(vcChangeNo!=null && !"".equals(vcChangeNo)){
						if("SH".equals(vcChangeNo)){
							for(int i=0;i<importDatas.length;i++){
								boolean flag=false;
								for(int j=0;j<purchaseInfo.length;j++){
									DataObject datas=null;
									DataObject impData=null;
									if(importDatas[i].getString("vcStockAccountSh").equals(purchaseInfo[j].getString("vcStockAccountSh"))){
										datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
										impData=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
										datas.set("dsSource", "0");
										datas.set("vcPurchaseCode", vcPurchaseCode);
										impData.set("dsSource", "1");
										datas.set("primaryKey", j);
										impData.set("primaryKey", j);
										datas.set("lPurchaseNo", purchaseInfo[j].get("lPurchaseNo"));
										datas.set("vcStockAccountSh", purchaseInfo[j].getString("vcStockAccountSh"));
										impData.set("vcStockAccountSh", importDatas[i].getString("vcStockAccountSh"));
										impData.set("vcPurchaseCode", importDatas[i].getString("vcPurchaseCode"));
										if(vcPurchaseCode.equals(importDatas[i].getString("vcPurchaseCode"))){
											datas.set("codeFlag", "0");
										}else{
											datas.set("codeFlag", "1");
										}
										if(importDatas[i].getString("vcRationProductName").equals(purchaseInfo[j].getString("vcRationProductName"))){
											datas.set("vcRationProductName", purchaseInfo[j].getString("vcRationProductName"));
											datas.set("nameFlag","0");
											impData.set("vcRationProductName", importDatas[i].getString("vcRationProductName"));
										}else{
											datas.set("vcRationProductName", purchaseInfo[j].getString("vcRationProductName"));
											datas.set("nameFlag","1");
											impData.set("vcRationProductName", importDatas[i].getString("vcRationProductName"));
										}
										if(importDatas[i].getBigDecimal("enPurchasePrice").compareTo(purchaseInfo[j].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP))==0){
											datas.set("enPurchasePrice", purchaseInfo[j].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchasePrice", importDatas[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											datas.set("priceFlag","0");
										}else{
											datas.set("enPurchasePrice", purchaseInfo[j].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchasePrice", importDatas[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											datas.set("priceFlag","1");
										}
										if(importDatas[i].getBigDecimal("enPurchaseNumber").compareTo(purchaseInfo[j].getBigDecimal("enPurchaseNumber"))==0){
											datas.set("enPurchaseNumber", purchaseInfo[j].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchaseNumber", importDatas[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											datas.set("numFlag","0");
										}else{
											datas.set("enPurchaseNumber", purchaseInfo[j].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchaseNumber", importDatas[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											datas.set("numFlag","1");
										}
										dataListEqual.add(datas);
										importListEqual.add(impData);
										flag=true;
										break;
									}else{
										flag=false;
									}
								}
								if(!flag){
									DataObject impDataNotEqual=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
									impDataNotEqual.set("dsSource", "1");
									impDataNotEqual.set("vcStockAccountSh", importDatas[i].getString("vcStockAccountSh"));
									impDataNotEqual.set("vcPurchaseCode",importDatas[i].getString("vcPurchaseCode"));
									impDataNotEqual.set("vcRationProductName", importDatas[i].getString("vcRationProductName"));
									impDataNotEqual.set("enPurchasePrice", importDatas[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
									impDataNotEqual.set("enPurchaseNumber", importDatas[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
									impDataNotEqual.set("recordFlag", "1");
									importList.add(impDataNotEqual);
								}
							}
							if(dataListEqual.size()!=purchaseInfo.length){
								for(int i=0;i<purchaseInfo.length;i++){
									boolean flag=false;
									for(int j=0;j<dataListEqual.size();j++){
										if(dataListEqual.get(j).getString("vcStockAccountSh").equals(purchaseInfo[i].getString("vcStockAccountSh"))){
											flag=true;
										}
									}
									if(!flag){
										DataObject dataNotEqual=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
										dataNotEqual.set("dsSource", "0");
										dataNotEqual.set("lPurchaseNo", purchaseInfo[i].get("lPurchaseNo"));
										dataNotEqual.set("vcPurchaseCode", vcPurchaseCode);
										dataNotEqual.set("vcStockAccountSh", purchaseInfo[i].getString("vcStockAccountSh"));
										dataNotEqual.set("vcRationProductName", purchaseInfo[i].getString("vcRationProductName"));
										dataNotEqual.set("enPurchasePrice", purchaseInfo[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
										dataNotEqual.set("enPurchaseNumber", purchaseInfo[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
										dataNotEqual.set("recordFlag", "2");
										dataList.add(dataNotEqual);
									}
								}
							}
							
						}else if("SZ".equals(vcChangeNo)){
							for(int i=0;i<importDatas.length;i++){
								boolean flag=false;
								for(int j=0;j<purchaseInfo.length;j++){
									DataObject datas=null;
									DataObject impData=null;
									if(importDatas[i].getString("vcRationProductCode").equals(purchaseInfo[j].getString("vcRationProductCode"))){
										datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
										impData=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
										datas.set("dsSource", "0");
										impData.set("dsSource", "1");
										datas.set("primaryKey", j);
										impData.set("primaryKey", j);
										datas.set("lPurchaseNo", purchaseInfo[j].get("lPurchaseNo"));
										datas.set("vcRationProductCode", purchaseInfo[j].getString("vcRationProductCode"));
										impData.set("vcRationProductCode",importDatas[i].getString("vcRationProductCode"));
										if(importDatas[i].getString("vcRationProductName").equals(purchaseInfo[j].getString("vcRationProductName"))){
											datas.set("vcRationProductName", purchaseInfo[j].getString("vcRationProductName"));
											impData.set("vcRationProductName", importDatas[i].getString("vcRationProductName"));
											datas.set("nameFlag","0");
										}else{
											datas.set("vcRationProductName", purchaseInfo[j].getString("vcRationProductName"));
											impData.set("vcRationProductName", importDatas[i].getString("vcRationProductName"));
											datas.set("nameFlag","1");
										}
										if(importDatas[i].getString("seatSz").equals(purchaseInfo[j].getString("seatSz"))){
											datas.set("seatSz", purchaseInfo[j].getString("seatSz"));
											impData.set("seatSz", importDatas[i].getString("seatSz"));
											datas.set("seatFlag","0");
										}else{
											datas.set("seatSz", purchaseInfo[j].getString("seatSz"));
											impData.set("seatSz", importDatas[i].getString("seatSz"));
											datas.set("seatFlag","1");
										}
										if(importDatas[i].getString("vcStockAccountSz").equals(purchaseInfo[j].getString("vcStockAccountSz"))){
											datas.set("vcStockAccountSz", purchaseInfo[j].getString("vcStockAccountSz"));
											impData.set("vcStockAccountSz", importDatas[i].getString("vcStockAccountSz"));
											datas.set("accountFlag","0");
										}else{
											datas.set("vcStockAccountSz", purchaseInfo[j].getString("vcStockAccountSz"));
											impData.set("vcStockAccountSz", importDatas[i].getString("vcStockAccountSz"));
											datas.set("accountFlag","1");
										}
										if(importDatas[i].getBigDecimal("enPurchasePrice").compareTo(purchaseInfo[j].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP))==0){
											datas.set("enPurchasePrice", purchaseInfo[j].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchasePrice", importDatas[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											datas.set("priceFlag","0");
										}else{
											datas.set("enPurchasePrice", purchaseInfo[j].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchasePrice", importDatas[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
											datas.set("priceFlag","1");
										}
										if(importDatas[i].getBigDecimal("enPurchaseNumber").compareTo(purchaseInfo[j].getBigDecimal("enPurchaseNumber"))==0){
											datas.set("enPurchaseNumber", purchaseInfo[j].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchaseNumber", importDatas[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											datas.set("numFlag","0");
										}else{
											datas.set("enPurchaseNumber", purchaseInfo[j].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											impData.set("enPurchaseNumber", importDatas[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
											datas.set("numFlag","1");
										}
										//新增证券代码 2017/11/16
										if(importDatas[i].getString("vcPurchaseCode").equals(vcPurchaseCode)){
											datas.set("vcPurchaseCode", vcPurchaseCode);
											impData.set("vcPurchaseCode", vcPurchaseCode);
											datas.set("purchaseFlag","0");
										}else{
											datas.set("vcPurchaseCode", vcPurchaseCode);
											impData.set("vcPurchaseCode", vcPurchaseCode);
											datas.set("purchaseFlag","1");
										}
										
										
										dataListEqual.add(datas);
										importListEqual.add(impData);
										flag=true;
										break;
									}else{
										flag=false;
									}
									
								}
								if(!flag){
									DataObject impDataNotEqual=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
									impDataNotEqual.set("dsSource", "1");
									impDataNotEqual.set("vcRationProductCode", importDatas[i].getString("vcRationProductCode"));
									impDataNotEqual.set("vcRationProductName", importDatas[i].getString("vcRationProductName"));
									impDataNotEqual.set("seatSz", importDatas[i].getString("seatSz"));
									impDataNotEqual.set("vcStockAccountSz", importDatas[i].getString("vcStockAccountSz"));
									impDataNotEqual.set("enPurchasePrice", importDatas[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
									impDataNotEqual.set("enPurchaseNumber", importDatas[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
									impDataNotEqual.set("recordFlag", "1");
									//新增证券代码 2017/11/16
									impDataNotEqual.set("vcPurchaseCode", importDatas[i].getString("vcPurchaseCode"));
									importList.add(impDataNotEqual);
								}
							}
							
							
							if(dataListEqual.size()!=purchaseInfo.length){
								for(int i=0;i<purchaseInfo.length;i++){
									boolean flag=false;
									for(int j=0;j<dataListEqual.size();j++){
										if(dataListEqual.get(j).getString("vcRationProductCode").equals(purchaseInfo[i].getString("vcRationProductCode"))){
											flag=true;
										}
									}
									if(!flag){
										DataObject dataNotEqual=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
										dataNotEqual.set("dsSource", "0");
										dataNotEqual.set("lPurchaseNo", purchaseInfo[i].get("lPurchaseNo"));
										dataNotEqual.set("vcRationProductCode", purchaseInfo[i].getString("vcRationProductCode"));
										dataNotEqual.set("vcRationProductName", purchaseInfo[i].getString("vcRationProductName"));
										dataNotEqual.set("seatSz", purchaseInfo[i].getString("seatSz"));
										dataNotEqual.set("vcStockAccountSz", purchaseInfo[i].getString("vcStockAccountSz"));
										dataNotEqual.set("enPurchasePrice", purchaseInfo[i].getBigDecimal("enPurchasePrice").setScale(4,RoundingMode.HALF_UP));
										dataNotEqual.set("enPurchaseNumber", purchaseInfo[i].getBigDecimal("enPurchaseNumber").setScale(4,RoundingMode.HALF_UP));
										dataNotEqual.set("recordFlag", "2");
										//新增证券代码 2017/11/16
										dataNotEqual.set("vcPurchaseCode", vcPurchaseCode);
										dataList.add(dataNotEqual);
									}
								}
							}
						}
					}
				}
			}
		}
		/**
		 * 
		 */
		int length=0;
		if(dataListEqual.size()>0 && importListEqual.size()>0){
			length=dataListEqual.size()+importListEqual.size()+dataList.size()+importList.size();
			result=new DataObject[length];
			int k=0;
			int rowid=0;
			//匹配上的数据
			for(int i=0;i<dataListEqual.size();i++){
				for(int j=0;j<importListEqual.size();j++){
					if(dataListEqual.get(i).getString("primaryKey").equals(importListEqual.get(j).getString("primaryKey"))){
						dataListEqual.get(i).set("rowid", rowid+1);
						importListEqual.get(j).set("rowid", rowid+1);
						result[k]=dataListEqual.get(i);
						result[k+1]=importListEqual.get(j);
						k=k+2;
						rowid=rowid+1;
					}
				}
			}
			int start=dataListEqual.size()+importListEqual.size();
			//本地未匹配上的数据
			if(dataList.size()>0){
				for(int i=0;i<dataList.size();i++){
					dataList.get(i).set("rowid", rowid+1);
					result[start+i]=dataList.get(i);
					rowid=rowid+1;
				}
			}
			//导入未匹配上的数据
			if(importList.size()>0){
				int startEnd=start+dataList.size();
				for(int i=0;i<importList.size();i++){
					importList.get(i).set("rowid", rowid+1);
					result[startEnd+i]=importList.get(i);
					rowid=rowid+1;
				}
			}
		}
		
		if(dataListEqual.size()>0){
			String vcChangeNo=instructInfo.getString("vcExchangeNo");
			for(int i=0;i<dataListEqual.size();i++){
				DataObject datas=dataListEqual.get(i);
				String recordFlag=datas.getString("recordFlag");
				if(recordFlag!=null && !"".equals(recordFlag)){
					if("2".equals(recordFlag)){
						instructInfo.set("vcCompareFlag", "0");
						break;
					}
				}else{
					instructInfo.set("vcCompareFlag", "1");
				}
				if("SH".equals(vcChangeNo)){
					String codeFlag=datas.getString("codeFlag");
					String nameFlag=datas.getString("nameFlag");
					String priceFlag=datas.getString("priceFlag");
					String numFlag=datas.getString("numFlag");
					System.out.println(numFlag);
					if(codeFlag!=null && !"".equals(codeFlag)){
						if("1".equals(codeFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(nameFlag!=null && !"".equals(nameFlag)){
						if("1".equals(nameFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(priceFlag!=null && !"".equals(priceFlag)){
						if("1".equals(priceFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(numFlag!=null && !"".equals(numFlag)){
						if("1".equals(numFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
				}else if("SZ".equals(vcChangeNo)){
					String codeFlag=datas.getString("codeFlag");
					String nameFlag=datas.getString("nameFlag");
					String priceFlag=datas.getString("priceFlag");
					String numFlag=datas.getString("numFlag");
					String seatFlag=datas.getString("seatFlag");
					String accountFlag=datas.getString("accountFlag");
					//新增证券代码 2017/11/16 
					String purchaseFlag= datas.getString("purchaseFlag");
					if(codeFlag!=null && !"".equals(codeFlag)){
						if("1".equals(codeFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(nameFlag!=null && !"".equals(nameFlag)){
						if("1".equals(nameFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(priceFlag!=null && !"".equals(priceFlag)){
						if("1".equals(priceFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(numFlag!=null && !"".equals(numFlag)){
						if("1".equals(numFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(seatFlag!=null && !"".equals(seatFlag)){
						if("1".equals(seatFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					if(accountFlag!=null && !"".equals(accountFlag)){
						if("1".equals(accountFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
					//新增证券代码 2017/11/16 
					if(purchaseFlag!=null && !"".equals(purchaseFlag)){
						if("1".equals(purchaseFlag)){
							instructInfo.set("vcCompareFlag", "0");
							break;
						}else{
							instructInfo.set("vcCompareFlag", "1");
						}
					}
				}
			}
			
			if(importList.size()>0){
				instructInfo.set("vcCompareFlag", "0");
			}
			if(dataList.size()>0){
				instructInfo.set("vcCompareFlag", "0");
			}
			String vcCompareFlag=instructInfo.getString("vcCompareFlag");
			if(vcCompareFlag!=null && !"".equals(vcCompareFlag)){
				DatabaseUtil.updateEntity("default", instructInfo);
			}
		}
		
		return result;
	}
	
	
	/*public static void main(String[] args) {
		DataObject data=DataObjectUtil.createDataObject("commonj.sdo.DataOject");
		data.set("a","123");
		data.set("b","1232");
		data.set("c","1233");
		data.set("d","1234");
		List dataList=data.getInstanceProperties();
		for(int i=0;i<dataList.size();i++){
			System.out.println(dataList.get(i));
		}
	}*/
}
