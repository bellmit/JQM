package com.cjhxfund.ats.ipo;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.formula.functions.Count;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

@Bizlet("计算产品价格数量及对应的比率")
public class CalculatePriceAndNumber {
	
	@Bizlet("计算申报数量及申报金额")
	public static DataObject[] caclculateNumber(DataObject[] rationProducts,DataObject instructInfo){
		DataObject[] resultRationData=null;
		List<DataObject> rationList=new ArrayList<DataObject>();
		//合计申购总数
		BigDecimal purchaseCountNumber= new BigDecimal(0);
		if(rationProducts!=null && rationProducts.length>0){
			if(instructInfo!=null){
				//网下发行上限
				BigDecimal enOfflineUpperNumber=instructInfo.getBigDecimal("enOfflineUpperNumber");
				//网下申购下限
				BigDecimal enOfflineUnderNumber=instructInfo.getBigDecimal("enOfflineUnderNumber");
				//申购步长
				BigDecimal enPurchaseSize=instructInfo.getBigDecimal("enPurchaseSize");
				//预计获配率
				BigDecimal enPredictRate=instructInfo.getBigDecimal("enPredictDistributionRate");
				//市值门槛
				BigDecimal enMarketValueThreshold=instructInfo.getBigDecimal("enMarketValueThreshold");
				
				//区分交易所 SZ SH
				String vcExchangeNo=instructInfo.getString("vcExchangeNo");
				//询价日
				String lInquiryDate=instructInfo.getString("lInquiryDate");
				
				for(int i=0;i<rationProducts.length;i++){
					BigDecimal purchaseNumber=null;
					//资产类别，00为总资产，01为净资产
					String vcAssetType=rationProducts[i].getString("vcAssetType");
					
					//申购价格
					//BigDecimal purchasePrice=rationProducts[i].getBigDecimal("enPurchasePrice");
					//申报价格
					BigDecimal enPurchasePrice=rationProducts[i].getBigDecimal("enPurchasePrice");
					if(vcAssetType!=null && !"".equals(vcAssetType)){
						if("00".equals(vcAssetType)){
							//总资产
							BigDecimal assetType=rationProducts[i].getBigDecimal("assetValue");
							if(assetType!=null && enPurchasePrice!=null){
								//两个资产总值除以申报价格
								assetType=assetType.setScale(6, BigDecimal.ROUND_HALF_UP);
								purchaseNumber=assetType.divide(enPurchasePrice,4,RoundingMode.HALF_UP);
							}
						}
						if("01".equals(vcAssetType)){
							//净资产
							BigDecimal assetNetValue=rationProducts[i].getBigDecimal("assetNetValue");
							if(assetNetValue!=null && enPurchasePrice!=null){
								//净资产总值除以申报价格
								purchaseNumber=assetNetValue.divide(enPurchasePrice,4,RoundingMode.HALF_UP);
							}
						}
					}
					
					if(enOfflineUpperNumber==null || enOfflineUnderNumber==null || purchaseNumber==null || enPurchaseSize==null){
//						return null;
						continue;
					}else{
						//申购价格
						if(enPurchasePrice!=null){
							
							if(lInquiryDate!=null&&!"".equals(lInquiryDate)){
								String lEndTime=DateUtil.getCalculateTradeDay(null, lInquiryDate, "00", -1);
								rationProducts[i].set("lEndTime",lEndTime);
							}
							
							//判断计算得出的申购数量是否大于网下申购下限
							if(purchaseNumber.compareTo(enOfflineUnderNumber)>=0){
								//判断计算得出的申购数量是否大于网下发行上限
								if(purchaseNumber.compareTo(enOfflineUpperNumber)>=0){
									//如果大于等于网下发行上限(万股) 则 等于 以网下发行上限(万股)
									rationProducts[i].set("enPurchaseNumber", enOfflineUpperNumber);
									//申购金额(万元) = 申报价格 * 申报数量(万股){1}
									rationProducts[i].set("enPurchaseMoney",(enPurchasePrice.multiply(enOfflineUpperNumber)).setScale(6, RoundingMode.HALF_UP));
									
								}else{
									//申报数量(万股){1} % 申购步长 （其中返回的数组有为数据，有两个值，[0]为两个数相除的商，[1]为余数）
									BigDecimal[] purchaseRemain=purchaseNumber.divideAndRemainder(enPurchaseSize);
									//如果处于两者之间 则 申报数量(万股) = 申报数量(万股){1} - (申报数量(万股){1} % 申购步长)
									purchaseNumber=purchaseNumber.subtract(purchaseRemain[1]);
									
									BigDecimal enTotalMoney=enPurchasePrice.multiply(purchaseNumber).setScale(6, RoundingMode.HALF_UP);
									//配售对象使用总资产值进行计算
									if("00".equals(vcAssetType)){
										BigDecimal assetType=rationProducts[i].getBigDecimal("assetValue").setScale(6, RoundingMode.HALF_UP);
										if(enTotalMoney.compareTo(assetType)>0){
											purchaseNumber=purchaseNumber.subtract(purchaseRemain[1]);
										}
									}
									//配售对象使用净资产值进行计算
									if("01".equals(vcAssetType)){
										BigDecimal assetNetValue=rationProducts[i].getBigDecimal("assetNetValue").setScale(6, RoundingMode.HALF_UP);
										if(enTotalMoney.compareTo(assetNetValue)>0){
											purchaseNumber=purchaseNumber.subtract(purchaseRemain[1]);
										}
									}
									//设置申报数量
									rationProducts[i].set("enPurchaseNumber",purchaseNumber);
									//申购金额(万元) = 申报价格 * 申报数量(万股){1}
									rationProducts[i].set("enPurchaseMoney",enTotalMoney);
								}
								//合计汇总申购数量
								if("SZ".equalsIgnoreCase(vcExchangeNo)){
									BigDecimal marketValueSz = rationProducts[i].getBigDecimal("marketValueSz");
									if(marketValueSz.compareTo(enMarketValueThreshold)>0){
										purchaseCountNumber=purchaseCountNumber.add(rationProducts[i].getBigDecimal("enPurchaseNumber"));
									}
								}else{
									BigDecimal marketValueSh = rationProducts[i].getBigDecimal("marketValueSh");
									if(marketValueSh.compareTo(enMarketValueThreshold)>0){
										purchaseCountNumber=purchaseCountNumber.add(rationProducts[i].getBigDecimal("enPurchaseNumber"));
									}
								}
								
								BigDecimal enPurchaseMoney=rationProducts[i].getBigDecimal("enPurchaseMoney");
								if("00".equals(vcAssetType)){
									//总资产
									BigDecimal assertType=rationProducts[i].getBigDecimal("assetValue");
									if(assertType!=null && enPurchaseMoney!=null){
										//申购金额占净值比例 = 申购金额(万元){4} / (基金资产或者基金净资产)
										rationProducts[i].set("enPurchaseMoneyRate",enPurchaseMoney.divide(assertType,6,RoundingMode.HALF_UP));
										//预计获配占净值比例 = (申购金额(万元){4}*预计获配率)/(基金资产或者基金净资产)
										rationProducts[i].set("enDistributionRate",(enPurchaseMoney.multiply(enPredictRate)).divide(assertType,6,RoundingMode.HALF_UP));
									}
								}
								if("01".equals(vcAssetType)){
									//净资产
									BigDecimal assetNetValue=rationProducts[i].getBigDecimal("assetNetValue");
									if(assetNetValue!=null && enPurchaseMoney!=null){
										//申购金额占净值比例 = 申购金额(万元){4} / (基金资产或者基金净资产)
										rationProducts[i].set("enPurchaseMoneyRate",enPurchaseMoney.divide(assetNetValue,6,RoundingMode.HALF_UP));
										//预计获配占净值比例 = (申购金额(万元){4}*预计获配率)/(基金资产或者基金净资产)
										rationProducts[i].set("enDistributionRate",(enPurchaseMoney.multiply(enPredictRate)).divide(assetNetValue,6,RoundingMode.HALF_UP));
									}
								}
								rationList.add(rationProducts[i]);
							}
						}
					}
				}
				//将汇总数据添加到指令对象中  EN_TOTAL_ISSUER_RATE
				instructInfo.set("enTotalPurchaseSize", purchaseCountNumber);
				//发行总股本
				BigDecimal enTotalEquity=instructInfo.getBigDecimal("enTotalEquity");
				if(enTotalEquity!=null){
					if(enTotalEquity.compareTo(BigDecimal.ZERO)>0){
						//申购量占总股本比例 = 合计申购股数(万股){3}/发行人总股本(万股)
						instructInfo.set("enTotalPurchaseRate", purchaseCountNumber.divide(enTotalEquity,4,RoundingMode.HALF_UP));
						//获配数量占发行人总股本比例 = (预计获配率*合计申购股数(万股){3}) / 发行人总股本(万股)
						instructInfo.set("enTotalIssuerRate", (purchaseCountNumber.multiply(enPredictRate)).divide(enTotalEquity,4,RoundingMode.HALF_UP));
					}
				}
			}
		}
		resultRationData=new DataObject[rationList.size()];
		for(int i=0;i<rationList.size();i++){
			resultRationData[i]=rationList.get(i);
		}
		return resultRationData;
	}
	
	/**
	 * 
	 * @param localProduct 查询本地已参与的配售对象
	 * @param modifyProduct 页面修改的配售对象
	 * @param instructInfo 指令数据对象
	 * @return 计算后的指令合计数据
	 */
	@Bizlet("重新计算指令合计数据")
	public static DataObject calculateModify(DataObject[] localProduct,DataObject[] modifyProduct,DataObject instructInfo){
		//预计获配率
		BigDecimal enPredictRate=null;
		if(instructInfo!=null){
			enPredictRate=instructInfo.getBigDecimal("enPredictDistributionRate");
		}
		
		if(enPredictRate!=null){
			//判断查询出来的本地数据产品已参与的数据
			if(localProduct!=null && localProduct.length>0){
				//定义汇总数申购数量
				BigDecimal enTotalNumber=new BigDecimal(0);
				//循环已参与申购的产品
				for(int i=0;i<localProduct.length;i++){
					//用于判断是否存在已参与的产品，页面上作了修改，默认false为没有修改
					boolean flag=false;
					//判断是否页面对配售对象有数据数据信息的修改
					if(modifyProduct!=null && modifyProduct.length>0){
						//获取本地数据的配售对象编码
						String localCode=localProduct[i].getString("vcRationProductCode");
						//页面表格框作了修改的产品
						for(int j=0;j<modifyProduct.length;j++){
							if(localCode!=null && !"".equals(localCode)){
								//判断本地参与的配售对象与页面修改的配售对象是否相等
								if(localCode.equals(modifyProduct[i].getString("vcRationProductCode"))){
									BigDecimal enPurchaseNumber=modifyProduct[i].getBigDecimal("enPurchaseNumber");
									if(enPurchaseNumber!=null){
										enTotalNumber=(enTotalNumber.add(enPurchaseNumber)).setScale(4, RoundingMode.HALF_UP);
										flag =true;
										break;
									}
								}
							}
						}
						//针对没有发生修改的问题，只参与者的数据重新计算
					}else{
						BigDecimal enPurchaseNumber=localProduct[i].getBigDecimal("enPurchaseNumber");
						if(enPurchaseNumber!=null){
							enTotalNumber=(enTotalNumber.add(enPurchaseNumber)).setScale(4, RoundingMode.HALF_UP);
							flag =true;
						}
					}
					//已参与的数据没有发现页面有修改的数据
					if(!flag){
						BigDecimal enPurchaseNumber=localProduct[i].getBigDecimal("enPurchaseNumber");
						if(enPurchaseNumber!=null){
							enTotalNumber=(enTotalNumber.add(enPurchaseNumber)).setScale(4, RoundingMode.HALF_UP);
						}
					}
				}
				//设置汇总申购数量
				instructInfo.set("enTotalPurchaseSize", enTotalNumber);
				//发行总股本
				BigDecimal enTotalEquity=instructInfo.getBigDecimal("enTotalEquity");
				if(enTotalEquity!=null){
					if(enTotalEquity.compareTo(BigDecimal.ZERO)>0){
						//申购量占总股本比例 = 合计申购股数(万股){3}/发行人总股本(万股)
						instructInfo.set("enTotalPurchaseRate", enTotalNumber.divide(enTotalEquity,4,RoundingMode.HALF_UP));
						//获配数量占发行人总股本比例 = (预计获配率*合计申购股数(万股){3}) / 发行人总股本(万股)
						instructInfo.set("enTotalIssuerRate", (enTotalNumber.multiply(enPredictRate)).divide(enTotalEquity,4,RoundingMode.HALF_UP));
					}
				}
			}
		}
		return instructInfo;
	}
	
	/**
	 * 数量修改后重新计算金额及比例
	 * @param purchaseEntity 修改前申购实体对象
	 * @param purchaseInfo 页面传递的参数，修改后的数量和原因
	 * @param insructInfo 指令实体对象
	 * @param rationProduct 对应修改的净值及资产总值
	 * @return
	 */
	@Bizlet("数量修改后重新计算金额及比例")
	public static DataObject calculateMoney(DataObject purchaseEntity,DataObject purchaseInfo,DataObject instructInfo,DataObject rationProduct){
		//修改后的申购数量
		BigDecimal newEnPurchaseNumber=purchaseInfo.getBigDecimal("enPurchaseNumber");
		//修改前的申购数量
		BigDecimal oldEnPurchaseNumber=purchaseEntity.getBigDecimal("enPurchaseNumber");
		BigDecimal enPurchaseNumber=null;
		//指令合计申购数量
		BigDecimal enTotalPurchaseSize=instructInfo.getBigDecimal("enTotalPurchaseSize");
		//申报价格
		BigDecimal enPurchasePrice=purchaseEntity.getBigDecimal("enPurchasePrice");
		//预计获配率
		BigDecimal enPredictRate=instructInfo.getBigDecimal("enPredictDistributionRate");
		
		if(oldEnPurchaseNumber.compareTo(newEnPurchaseNumber)==1){
			enPurchaseNumber=oldEnPurchaseNumber.subtract(newEnPurchaseNumber);
			enTotalPurchaseSize=enTotalPurchaseSize.subtract(enPurchaseNumber);
			BigDecimal enPurchaseMoney=(enPurchasePrice.multiply(newEnPurchaseNumber).setScale(6, RoundingMode.HALF_UP));
			//申购金额(万元) = 申报价格 * 申报数量(万股){1}
			purchaseInfo.set("enPurchaseMoney",enPurchaseMoney);
			String vcAssetType=rationProduct.getString("vcAssetType");
			if(vcAssetType!=null && !"".equals("vcAssetType")){
				if("00".equals(vcAssetType)){
					//总资产
					BigDecimal assertType=rationProduct.getBigDecimal("assetValue");
					if(assertType!=null && enPurchaseMoney!=null){
						//申购金额占净值比例 = 申购金额(万元){4} / (基金资产或者基金净资产)
						purchaseInfo.set("enPurchaseMoneyRate",enPurchaseMoney.divide(assertType,6,RoundingMode.HALF_UP));
						//预计获配占净值比例 = (申购金额(万元){4}*预计获配率)/(基金资产或者基金净资产)
						purchaseInfo.set("enDistributionRate",(enPurchaseMoney.multiply(enPredictRate)).divide(assertType,6,RoundingMode.HALF_UP));
					}
				}
				if("01".equals(vcAssetType)){
					//净资产
					BigDecimal assetNetValue=rationProduct.getBigDecimal("assetNetValue");
					if(assetNetValue!=null && enPurchaseMoney!=null){
						//申购金额占净值比例 = 申购金额(万元){4} / (基金资产或者基金净资产)
						purchaseInfo.set("enPurchaseMoneyRate",enPurchaseMoney.divide(assetNetValue,6,RoundingMode.HALF_UP));
						//预计获配占净值比例 = (申购金额(万元){4}*预计获配率)/(基金资产或者基金净资产)
						purchaseInfo.set("enDistributionRate",(enPurchaseMoney.multiply(enPredictRate)).divide(assetNetValue,6,RoundingMode.HALF_UP));
					}
				}
			}
			//将汇总数据添加到指令对象中  EN_TOTAL_ISSUER_RATE
			instructInfo.set("enTotalPurchaseSize", enTotalPurchaseSize);
			//发行总股本
			BigDecimal enTotalEquity=instructInfo.getBigDecimal("enTotalEquity");
			if(enTotalEquity!=null){
				if(enTotalEquity.compareTo(BigDecimal.ZERO)>0){
					//申购量占总股本比例 = 合计申购股数(万股){3}/发行人总股本(万股)
					instructInfo.set("enTotalPurchaseRate", enTotalPurchaseSize.divide(enTotalEquity,4,RoundingMode.HALF_UP));
					//获配数量占发行人总股本比例 = (预计获配率*合计申购股数(万股){3}) / 发行人总股本(万股)
					instructInfo.set("enTotalIssuerRate", (enTotalPurchaseSize.multiply(enPredictRate)).divide(enTotalEquity,4,RoundingMode.HALF_UP));
				}
			}
			
		}
		return purchaseInfo;
	}
	
	/**
	 * 根据万德数据获取的新股数据中，总股本数据有可能是0，
	 * 为0时，将发行前数量加上发行后数量
	 * 在于0时，直接取总股本数据
	 * @param stockWind 从万德查询得到的新股数据
	 * @return 返回计算后的发行后总股本
	 */
	@Bizlet("计算发行后总股本（其中发行人总股本等于发行后总股本）")
	public static BigDecimal calculateIssueTotal(DataObject stockWind){
		BigDecimal resultEnTotalEquity=null;
		if(stockWind!=null){
			//发行后总股本
			BigDecimal enTotalEquity=stockWind.getBigDecimal("enTotalEquity");
			//发行数量
			BigDecimal enIssueNumber=stockWind.getBigDecimal("enIssueNumber");
			//发行前数量
			BigDecimal enBeforeIssuerNumber=stockWind.getBigDecimal("enBeforeIssuerNumber");
			if(enTotalEquity!=null){
				if(enTotalEquity.compareTo(BigDecimal.ZERO)==0){
					if(enIssueNumber!=null && enBeforeIssuerNumber!=null){
						resultEnTotalEquity=enIssueNumber.add(enBeforeIssuerNumber);
					}
				}
				if(enTotalEquity.compareTo(BigDecimal.ZERO)>0){
					if(enIssueNumber!=null && enBeforeIssuerNumber!=null){
						resultEnTotalEquity=enTotalEquity;
					}
				}
			}
		}
		return resultEnTotalEquity;
	}
	
	/**
	 * 针对风控不合规的产品不计算在汇总数据内
	 * @param purchaseInfo 满足要求并合规的产品
	 * @param instructInfo 对应的指令数据
	 * @return 计算汇总后的指令对象
	 */
	@Bizlet("风控提交完成触发事件")
	public static DataObject calcInstructSum(DataObject[] purchaseInfo,DataObject instructInfo){
		//预计获配率
		BigDecimal enPredictRate=instructInfo.getBigDecimal("enPredictDistributionRate");
		
		//合计申购股数
		BigDecimal enTotalPurchaseSize=new BigDecimal(0);
		if(purchaseInfo!=null && purchaseInfo.length>0){
			//循环满足要求的申购产品，将申购数据汇总
			for(int i=0;i<purchaseInfo.length;i++){
				//取出产品的申购股数
				BigDecimal enPurchaseNumber=purchaseInfo[i].getBigDecimal("enPurchaseNumber");
				if(enPurchaseNumber!=null){
					enTotalPurchaseSize=enTotalPurchaseSize.add(enPurchaseNumber);
				}
			}
		}
		//指令合计的申购股数
		instructInfo.set("enTotalPurchaseSize", enTotalPurchaseSize);
		//发行总股本
		BigDecimal enTotalEquity=instructInfo.getBigDecimal("enTotalEquity");
		if(enTotalEquity!=null){
			if(enTotalEquity.compareTo(BigDecimal.ZERO)>0){
				//申购量占总股本比例 = 合计申购股数(万股){3}/发行人总股本(万股)
				instructInfo.set("enTotalPurchaseRate", enTotalPurchaseSize.divide(enTotalEquity,4,RoundingMode.HALF_UP));
				//获配数量占发行人总股本比例 = (预计获配率*合计申购股数(万股){3}) / 发行人总股本(万股)
				instructInfo.set("enTotalIssuerRate", (enTotalPurchaseSize.multiply(enPredictRate)).divide(enTotalEquity,4,RoundingMode.HALF_UP));
			}
		}
		return instructInfo;
	}
	
//	
//	public static void main(String[] args) {
//		BigDecimal a=new BigDecimal(0.00);
//		BigDecimal b=new BigDecimal(0.0000);
//		DataObject data1=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
//		DataObject data2=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
//		DataObject data3=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
//		
//		data1.set("str1", "123");
//		data1.set("str2", "234");
//		data2.set("str1", "124");
//		data2.set("str2", "235");
//		data3.set("str1", "126");
//		data3.set("str2", "237");
//		DataObject[] dataObjects=new DataObject[3];
//		dataObjects[0]=data1;
//		dataObjects[1]=data2;
//		dataObjects[2]=data3;
//		System.out.println(a.compareTo(BigDecimal.ZERO));
//		String[] astr=new String[]{"123","234","345"};
//		astr=testString(astr);
//		System.out.println(astr.length);
//		for(int i=0;i<astr.length;i++){
//			System.out.println("astr["+i+"]="+astr[i]);
//		}
//		dataObjects=testDataObject(dataObjects);
//		for(int i=0;i<dataObjects.length;i++){
//			System.out.println(dataObjects[i]);
//			System.out.println("datas-str1:"+dataObjects[i].getString("str1"));
//		}
//	}
	public static DataObject[] testDataObject(DataObject[] datas){
		List<DataObject> strList=new ArrayList<DataObject>();
		DataObject[] dats=null;
		if(datas!=null && datas.length>0){
			for(int i=0;i<datas.length;i++){
				String str1=datas[i].getString("str1");
				if(!"123".equals(str1)){
					strList.add(datas[i]);
				}
			}
		}
		
		for(int i=0;i<strList.size();i++){
			dats=new DataObject[strList.size()];
			dats[i]=strList.get(i);
		}
		return dats;
	}
	
	public static String[] testString(String[] str){
		List<String> strList=new ArrayList<String>();
		String[] strs=null;
		if(str!=null && str.length>0){
			for(int i=0;i<str.length;i++){
				if(!"345".equals(str[i])){
					strList.add(str[i]);
				}
			}
		}
		for(int i=0;i<strList.size();i++){
			System.out.println("strList.get("+i+")="+strList.get(i));
		}
		for(int i=0;i<strList.size();i++){
			strs=new String[strList.size()];
			strs[i]=strList.get(i);
			System.out.println(strs[i]);
		}
		return strs;
	}
	
}
