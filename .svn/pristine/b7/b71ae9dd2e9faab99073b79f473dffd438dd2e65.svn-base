/**
 * 
 */
package com.cjhxfund.ats.ipo;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.ProductCombiRightUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.data.WFWorkItem;
import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;

/**
 * @author 侯志勇
 * @date 2016-12-23 14:45:18
 *
 */
@Bizlet("")
public class ProcessNameUtil {
	
	@Bizlet("拼装流程实例名称")
	public static String getInstName(DataObject stockInfo){
		String instName=null;
		String vcIssuerNo=stockInfo.getString("vcIssuerNo");
		String vcCompanyName=stockInfo.getString("vcCompanyName");
		String today=DateUtil.currentDateDefaultString();
		instName=vcIssuerNo+"-"+vcCompanyName+"-"+"网下申购"+"-"+today;
		return instName;
	}
	
	/**
	 * 获取配售对象编码，组装成字符供后面方面的SQL查询条件
	 * @param ipoProductInfo 新股配售对象数组
	 * @return 返回结果为 I027650025,I027650026,I027650024 字符串
	 */
	@Bizlet("组装配售对象编号")
	public static String getRationCode(DataObject[] ipoProductInfo){
		String resultCode=null;
		if(ipoProductInfo!=null && ipoProductInfo.length>0){
			StringBuffer rationCode=new StringBuffer();
			for(int i=0;i<ipoProductInfo.length;i++){
				String code=ipoProductInfo[i].getString("vcRationProductCode");
				if(code!=null &&!"".equals(code)){
					if(i==ipoProductInfo.length-1){
						rationCode.append("'"+code+"'");
					}else{
						rationCode.append("'"+code+"'"+",");
					}
				}
			}
			resultCode=rationCode.toString();
		}
		return resultCode;
	}
	
	/**
	 * 获取配售对象编码，组装成字符供后面方面的SQL查询条件
	 * @param ipoProductInfo 新股配售对象数组
	 * @return 返回结果为 I027650025,I027650026,I027650024 字符串
	 */
	@Bizlet("组装配售对象编号")
	public static String getRationCodeByCriteria(DataObject[] ipoProductInfo){
		String resultCode=null;
		if(ipoProductInfo!=null && ipoProductInfo.length>0){
			StringBuffer rationCode=new StringBuffer();
			for(int i=0;i<ipoProductInfo.length;i++){
				String code=ipoProductInfo[i].getString("vcRationProductCode");
				if(code!=null &&!"".equals(code)){
					if(i==ipoProductInfo.length-1){
						rationCode.append(code);
					}else{
						rationCode.append(code+",");
					}
				}
			}
			resultCode=rationCode.toString();
		}
		return resultCode;
	}
	
	
	
	/**
	 * 
	 * @param purchaseInfo 申购产品数组本地数据
	 * @param rationValue 从估计表中获取的市值，净值等信息数组
	 * @return 将市值等信息添加到申购产品数组中
	 */
	@Bizlet("组装配售对象数组，将查询出来的对应市值，净值，总资产等添加到申购信息对象中")
	public static DataObject[] concatPurchaseInfo(DataObject[] purchaseInfo,DataObject[] rationValue,DataObject instructInfo){
		
		DataObject [] retObjects=new DataObject [rationValue.length]; 
		if(purchaseInfo!=null && purchaseInfo.length>0){
			if(rationValue!=null && rationValue.length>0){
				int o = 0;
				for(int i=0;i<purchaseInfo.length;i++){
					BigDecimal enPurchaseMoneyRate=purchaseInfo[i].getBigDecimal("enPurchaseMoneyRate");
					BigDecimal enDistributionRate=purchaseInfo[i].getBigDecimal("enDistributionRate");
					if(enPurchaseMoneyRate.compareTo(new BigDecimal(2))==1){
						purchaseInfo[i].set("enPurchaseMoneyRate",enPurchaseMoneyRate.setScale(4, RoundingMode.HALF_UP));
					}else{
						purchaseInfo[i].set("enPurchaseMoneyRate",(enPurchaseMoneyRate.multiply(new BigDecimal("100"))).setScale(4, RoundingMode.HALF_UP));
					}
					if(enDistributionRate.compareTo(new BigDecimal(2))==1){
						purchaseInfo[i].set("enDistributionRate",enDistributionRate.setScale(4, RoundingMode.HALF_UP));
					}else{
						purchaseInfo[i].set("enDistributionRate",(enDistributionRate.multiply(new BigDecimal("100"))).setScale(4, RoundingMode.HALF_UP));
					}
					
					for(int j=0;j<rationValue.length;j++){
						String vcRationProductCode=purchaseInfo[i].getString("vcRationProductCode");
						String objectId=rationValue[j].getString("objectId");
						if(vcRationProductCode!=null && !"".equals(vcRationProductCode)){
							String vcAssetType=purchaseInfo[i].getString("vcAssetType");
							if(objectId!=null && !"".equals(objectId)){
								if(objectId.equals(vcRationProductCode)){
									if(vcAssetType!=null && !"".equals(vcAssetType)){
										if("00".equals(vcAssetType)){
											purchaseInfo[i].set("assetValue", (rationValue[j].getBigDecimal("assetValue")).setScale(6, RoundingMode.HALF_UP));
											purchaseInfo[i].set("assetNetValue", null);
										}else if("01".equals(vcAssetType)){
											purchaseInfo[i].set("assetValue", null);
											purchaseInfo[i].set("assetNetValue", (rationValue[j].getBigDecimal("assetNetValue")).setScale(4, RoundingMode.HALF_UP));
										}
									}
									String riskState=purchaseInfo[i].getString("vcComplianceState");
									if(riskState!=null && !"".equals(riskState)){
										if("01".equals(riskState)){
											purchaseInfo[i].set("vcComplianceState1", "关联方检查不合规");
										}else if("02".equals(riskState)){
											purchaseInfo[i].set("vcComplianceState2", "投资比例检查不合规");
										}
										
									}
									purchaseInfo[i].set("prodCode", rationValue[j].getString("prodCode"));
									purchaseInfo[i].set("prodName", rationValue[j].getString("prodName"));
									purchaseInfo[i].set("seatSz", rationValue[j].getString("seatSz"));
									purchaseInfo[i].set("prodEndDate", rationValue[j].getString("prodEndDate"));
									purchaseInfo[i].set("marketValueSh", (rationValue[j].getBigDecimal("marketValueSh")).setScale(6, RoundingMode.HALF_UP));
									purchaseInfo[i].set("marketValueSz", (rationValue[j].getBigDecimal("marketValueSz")).setScale(6, RoundingMode.HALF_UP));
									//新股上市板块
//									String vcExchangeNo=instructInfo.getString("vcExchangeNo");
									retObjects[o] = purchaseInfo[i]; 
									o = o+1;
									break;
								}
							}
						}
						
					}
				}
			}
		}
		return retObjects;
	}
	
	
	/**
	 * 新股联络人专用
	 * @param purchaseInfo 申购产品数组本地数据
	 * @param rationValue 从估计表中获取的市值，净值等信息数组
	 * @return 将市值等信息添加到申购产品数组中
	 */
	@Bizlet("组装配售对象数组，将查询出来的对应市值，净值，总资产等添加到申购信息对象中")
	public static DataObject[] concatPurchaseInfo0040(DataObject[] purchaseInfo,DataObject[] rationValue,DataObject instructInfo){

		if(purchaseInfo!=null && purchaseInfo.length>0){
			if(rationValue!=null && rationValue.length>0){
				for(int i=0;i<purchaseInfo.length;i++){
					BigDecimal enPurchaseMoneyRate=purchaseInfo[i].getBigDecimal("enPurchaseMoneyRate");
					BigDecimal enDistributionRate=purchaseInfo[i].getBigDecimal("enDistributionRate");
					if(enPurchaseMoneyRate.compareTo(new BigDecimal(2))==1){
						purchaseInfo[i].set("enPurchaseMoneyRate",enPurchaseMoneyRate.setScale(4, RoundingMode.HALF_UP));
					}else{
						purchaseInfo[i].set("enPurchaseMoneyRate",(enPurchaseMoneyRate.multiply(new BigDecimal("100"))).setScale(4, RoundingMode.HALF_UP));
					}
					if(enDistributionRate.compareTo(new BigDecimal(2))==1){
						purchaseInfo[i].set("enDistributionRate",enDistributionRate.setScale(4, RoundingMode.HALF_UP));
					}else{
						purchaseInfo[i].set("enDistributionRate",(enDistributionRate.multiply(new BigDecimal("100"))).setScale(4, RoundingMode.HALF_UP));
					}
					
					for(int j=0;j<rationValue.length;j++){
						String vcRationProductCode=purchaseInfo[i].getString("vcRationProductCode");
						String objectId=rationValue[j].getString("objectId");
						if(vcRationProductCode!=null && !"".equals(vcRationProductCode)){
							String vcAssetType=purchaseInfo[i].getString("vcAssetType");
							if(objectId!=null && !"".equals(objectId)){
								if(objectId.equals(vcRationProductCode)){
									if(vcAssetType!=null && !"".equals(vcAssetType)){
										if("00".equals(vcAssetType)){
											purchaseInfo[i].set("assetValue", (rationValue[j].getBigDecimal("assetValue")).setScale(6, RoundingMode.HALF_UP));
											purchaseInfo[i].set("assetNetValue", null);
										}else if("01".equals(vcAssetType)){
											purchaseInfo[i].set("assetValue", null);
											purchaseInfo[i].set("assetNetValue", (rationValue[j].getBigDecimal("assetNetValue")).setScale(4, RoundingMode.HALF_UP));
										}
									}
									String riskState=purchaseInfo[i].getString("vcComplianceState");
									if(riskState!=null && !"".equals(riskState)){
										if("01".equals(riskState)){
											purchaseInfo[i].set("vcComplianceState1", "关联方检查不合规");
										}else if("02".equals(riskState)){
											purchaseInfo[i].set("vcComplianceState2", "投资比例检查不合规");
										}
										
									}
									purchaseInfo[i].set("prodCode", rationValue[j].getString("prodCode"));
									purchaseInfo[i].set("prodName", rationValue[j].getString("prodName"));
									purchaseInfo[i].set("seatSz", rationValue[j].getString("seatSz"));
									purchaseInfo[i].set("prodEndDate", rationValue[j].getString("prodEndDate"));
									purchaseInfo[i].set("marketValueSh", (rationValue[j].getBigDecimal("marketValueSh")).setScale(6, RoundingMode.HALF_UP));
									purchaseInfo[i].set("marketValueSz", (rationValue[j].getBigDecimal("marketValueSz")).setScale(6, RoundingMode.HALF_UP));
									//新股上市板块
//									String vcExchangeNo=instructInfo.getString("vcExchangeNo");
									break;
								}
							}
						}
						
					}
				}
			}
		}
		return purchaseInfo;
	}
	
	
	@Bizlet("查询前驱活动实例ID，组装成字符串查询")
	public static String concatActInstID(DataObject[] actInsts){
		String result=null;
		if(actInsts!=null && actInsts.length>0){
			StringBuffer actInstIdStr=new StringBuffer();
			for(int i=0;i<actInsts.length;i++){
				if("manual".equals(actInsts[i].getString("activityType"))){
					if(i==actInsts.length-1){
						actInstIdStr.append("'"+actInsts[i].getString("activityInstID")+"'");
					}else{
						actInstIdStr.append("'"+actInsts[i].getString("activityInstID")+"'"+",");
					}
				}
			}
			result=actInstIdStr.toString();
			if(result.endsWith(",")){
				//去掉最后一个字符逗号
				result=result.substring(0,result.length()-1);
			}
		}
		return result;
	}
	
	/**
	 * 将当前工作项设置到DataObject对象中，包括当前工作项名称，及前驱活动数量（是多个，还是一个）
	 * @param approveInfos
	 * @param workItem
	 * @param activityInsts
	 * @return
	 */
	@Bizlet("将当前的工作项名称设置到审批对象数组中的下标为0的数组中")
	public static DataObject[] setCurrentWork(DataObject[] approveInfos,WFWorkItem workItem,DataObject[] activityInsts){
		if(approveInfos!=null && approveInfos.length>0){
			approveInfos[0].set("currentWorkItemName", workItem.getWorkItemName());
			if(activityInsts!=null && activityInsts.length>1){
				approveInfos[0].set("actInstNum","1");
				StringBuffer actInstIds=new StringBuffer();
				for(int i=0;i<activityInsts.length;i++){
					if("manual".equals(activityInsts[i].getString("activityType"))){
						if(i==activityInsts.length-1){
							actInstIds.append(activityInsts[i].getString("activityInstID"));
						}else{
							actInstIds.append(activityInsts[i].getString("activityInstID")+",");
						}
					}
				}
				if(actInstIds.toString().endsWith(",")){
					//去掉最后一个以逗号结尾的字符
					approveInfos[0].set("previousID", actInstIds.toString().substring(0, actInstIds.toString().length()-1));
				}else{
					approveInfos[0].set("previousID", actInstIds.toString());
				}
			}
			if(activityInsts!=null && activityInsts.length==1){
				approveInfos[0].set("actInstNum","0");
			}
		}else{
			approveInfos=new DataObject[1];
			DataObject approveInfo=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
			approveInfo.set("processInstName",workItem.getProcessInstName());
			approveInfo.set("currentWorkItemName",workItem.getWorkItemName());
			approveInfos[0]=approveInfo;
		}
		
		
		return approveInfos;
	}
	
	@Bizlet("查询产品参与信息并添加到产品对象中")
	public static DataObject[] getProductJoinType(DataObject[] productInfo,DataObject[] instructProducts){
		if(productInfo!=null && productInfo.length>0){
			if(instructProducts!=null && instructProducts.length>0){
				for(int i=0;i<instructProducts.length;i++){
					for(int j=0;j<productInfo.length;j++){
//						System.out.println("productInfo-j="+j+"==="+productInfo[j].getString("vcRationProductCode"));
//						System.out.println("instructProducts"+instructProducts[i].getString("vcRationProductCode"));
						if(productInfo[j].getString("vcRationProductCode").equals(instructProducts[i].getString("vcRationProductCode"))){
							productInfo[j].set("vcProductParticipantion", instructProducts[i].getString("vcProductParticipantion"));
							productInfo[j].set("vcCreator", instructProducts[i].getString("vcCreator"));
							productInfo[j].set("vcLastupdator", instructProducts[i].getString("vcLastupdator"));
						}
					}
				}
			}
		}
		return productInfo;
	}

	/**
	 * 将估值表中查询出来的数据添加到本地产品对象中
	 * 总资产，净市，市值，产品代码，产品简称等
	 * @param productInfo 本地配售对对象数组
	 * @param rationProduct 估值表查询出的配售对象
	 * @return 返回本地配售对象数组
	 */
	@Bizlet("将估值表中查询出来的数据添加到本地配售对象中")
	public static DataObject[] getProductAssetValue(DataObject[] productInfo,DataObject[] rationProduct){
		if(productInfo!=null && productInfo.length>0){
			if(rationProduct!=null && rationProduct.length>0){
				/*for(int i=0;i<rationProduct.length;i++){
					for(int j=0;j<productInfo.length;j++){
						if(rationProduct[i].getString("objectId").equals(productInfo[j].getString("vcRationProductCode"))){
							productInfo[j].set("prodCode", rationProduct[i].getString("prodCode"));
							productInfo[j].set("prodName", rationProduct[i].getString("prodName"));
							productInfo[j].set("seatSz", rationProduct[i].getString("seatSz"));
							productInfo[j].set("assetValue",(rationProduct[i].getBigDecimal("assetValue")).setScale(6, RoundingMode.HALF_UP));
							productInfo[j].set("assetNetValue",(rationProduct[i].getBigDecimal("assetNetValue")).setScale(2, RoundingMode.HALF_UP));
							productInfo[j].set("prodEndDate", rationProduct[i].getDate("prodEndDate"));
							productInfo[j].set("marketValueSh", (rationProduct[i].getBigDecimal("marketValueSh")).setScale(6, RoundingMode.HALF_UP));
							productInfo[j].set("marketValueSz", (rationProduct[i].getBigDecimal("marketValueSz")).setScale(6, RoundingMode.HALF_UP));
						}
					}
				}*/
				
				for(int i=0;i<productInfo.length;i++){
					for(int j=0;j<rationProduct.length;j++){
						if(rationProduct[j].getString("objectId").equals(productInfo[i].getString("vcRationProductCode"))){
							rationProduct[j].set("vcRationProductCode", productInfo[i].getString("vcRationProductCode"));
							rationProduct[j].set("lProductNo", productInfo[i].getLong("lProductNo"));
							rationProduct[j].set("vcRationProductName", productInfo[i].getString("vcRationProductName"));
							rationProduct[j].set("vcRationProductType", productInfo[i].getString("vcRationProductType"));
							rationProduct[j].set("vcAssociationCode", productInfo[i].getString("vcAssociationCode"));
							rationProduct[j].set("vcStockAccountSh", productInfo[i].getString("vcStockAccountSh"));
							rationProduct[j].set("vcStockAccountSz", productInfo[i].getString("vcStockAccountSz"));
							rationProduct[j].set("vcStockAccountSzName", productInfo[i].getString("vcStockAccountSzName"));
							rationProduct[j].set("vcAssetType", productInfo[i].getString("vcAssetType"));
							rationProduct[j].set("vcRecordType", productInfo[i].getString("vcRecordType"));
							rationProduct[j].set("vcRecordRemark", productInfo[i].getString("vcRecordRemark"));
						}
					}
				}
			}
		}
		//return productInfo;
		return rationProduct;
	}
	
	/**
	 * 获取满足市值要求的配售对象
	 * @param rationMarkValues 所有未操作的配售对象（投顾及主动管理）对应的市值(只针对投顾产品)
	 * @param instructInfo 指令对象实体
	 * @return 符合要求市值的配售对象数组
	 */
	@Bizlet("获取满足市值要求的配售对象")
	public static DataObject[] getRequireObject(DataObject[] rationMarkValues,DataObject instructInfo){
		List<DataObject> rationList=new ArrayList<DataObject>();
		DataObject[] rationObjects=null;
		if(rationMarkValues!=null && rationMarkValues.length>0){
			if(instructInfo!=null){
				String vcExchangeNo=instructInfo.getString("vcExchangeNo");
				BigDecimal instructValue=instructInfo.getBigDecimal("enMarketValueThreshold");
				if(vcExchangeNo!=null && !"".equals(vcExchangeNo) && instructValue!=null){
					if("SZ".equals(vcExchangeNo)){
						for(int i=0;i<rationMarkValues.length;i++){
							BigDecimal marketValueSz=rationMarkValues[i].getBigDecimal("marketValueSz");
							if(marketValueSz!=null){
								marketValueSz = marketValueSz.setScale(6, RoundingMode.HALF_UP);
								String vcRationProductType=rationMarkValues[i].getString("vcRationProductType");
								if(vcRationProductType!=null && !"".equals(vcRationProductType)){
									//针对投顾类产品，joinType 00 表示参与，01表示不参与
									if("00".equals(vcRationProductType)){
										if(marketValueSz.compareTo(instructValue)>=0){
											rationMarkValues[i].set("joinType", "00");
										}else{
											rationMarkValues[i].set("joinType", "01");
										}
										
									}else{
										//针对非投顾类产品，joinType 00表示市值满足要求（默认参与），02表示市值不满足要求
										//针对02，后续环节会过滤（02默认不参与，除非手工确认参与）
										if(marketValueSz.compareTo(instructValue)>=0){
											rationMarkValues[i].set("joinType", "00");
										}else{
											rationMarkValues[i].set("joinType", "02");
										}
									}
									rationList.add(rationMarkValues[i]);
								}
							}
						}
					}
					if("SH".equals(vcExchangeNo)){
						for(int i=0;i<rationMarkValues.length;i++){
							BigDecimal marketValueSh=rationMarkValues[i].getBigDecimal("marketValueSh");
							if(marketValueSh!=null){
								marketValueSh = marketValueSh.setScale(6, RoundingMode.HALF_UP);
								String vcRationProductType=rationMarkValues[i].getString("vcRationProductType");
								if(vcRationProductType!=null && !"".equals(vcRationProductType)){
									//针对投顾类产品，joinType 00 表示参与，01表示不参与
									if("00".equals(vcRationProductType)){
										if(marketValueSh.compareTo(instructValue)>=0){
											rationMarkValues[i].set("joinType", "00");
										}else{
											rationMarkValues[i].set("joinType", "01");
										}
										
									}else{
										//针对非投顾类产品，joinType 00表示市值满足要求（默认参与），02表示市值不满足要求
										//针对02，后续环节会过滤（02默认不参与，除非手工确认参与）
										if(marketValueSh.compareTo(instructValue)>=0){
											rationMarkValues[i].set("joinType", "00");
										}else{
											rationMarkValues[i].set("joinType", "02");
										}
									}
									rationList.add(rationMarkValues[i]);
								}
							}
						}
					}
				}
			}
		}
		
		if(rationList.size()>0){
			rationObjects=new DataObject[rationList.size()];
			for(int i=0;i<rationList.size();i++){
				rationObjects[i]=rationList.get(i);
			}
		}
		return rationObjects;
	}
	
	/**
	 * 便于页面展示，根据资产类别对应将对应的资产设置空，并添加申报价格
	 * @param rationProducts 参与申购的产品列表
	 * @param instructInfo 指令实体对象
	 * @return 返回申购产品列表（其中包括根据资产类别只有对应的资产有值，并还有申报价格）
	 */
	@Bizlet("便于页面展示，根据资产类别对应将对应的资产设置空，并添加申报价格")
	public static DataObject[] getCapitalByAssetType(DataObject[] rationProducts,DataObject instructInfo){
		if(rationProducts!=null && rationProducts.length>0){
			if(instructInfo!=null){
				for(int i=0;i<rationProducts.length;i++){
					String vcAssetType=rationProducts[i].getString("vcAssetType");
					if(vcAssetType!=null && !"".equals(vcAssetType)){
						if("00".equals(vcAssetType)){
							rationProducts[i].set("assetNetValue", null);
						}
						if("01".equals(vcAssetType)){
							rationProducts[i].set("assetValue", null);
						}
						rationProducts[i].set("enPurchasePrice", instructInfo.getBigDecimal("enSuggestPrice"));
					}
				}
			}
		}
		return rationProducts;
	}
	
	/**
	 * 判断传入的配售对象是多个还是一个，
	 * 用于给命名SQL使用
	 * @param rationCode
	 * @return
	 */
	@Bizlet("判断传入的是配售对象编码是多个还有一个")
	public static int rationCodeType(String rationCode){
		int resultInt=0;
		if(rationCode!=null && !"".equals(rationCode)){
			String[] rationCodes=rationCode.split(",");
			if(rationCodes.length>1){
				resultInt=1;
			}
		}
		return resultInt;
		
	}

	
	/**
	 * 判断传入的配售对象编码是否带单引号
	 * 用于给命名SQL使用
	 * @param rationCode
	 * @return
	 */
	@Bizlet("判断传入的配售对象编码是否带单引号")
	public static String rationSingleCode(String rationCode){
		if(rationCode!=null && !"".equals(rationCode)){
			if(rationCode.endsWith("'")){
				rationCode=rationCode.replaceAll("'", "");
			}
		}
		return rationCode;
	}
	
	
	/**
	 * 查询对应用户的产品列表
	 * @param userId 当前登陆用户
	 * @param relateType 权限类型
	 * @return 返回查询出的产品字符串
	 */
	@Bizlet("查询用户对应的产品code字符串")
	public static String getProdCode(String userId,String relateType){
		String resultCodes=null;
		if(userId!=null && !"".equals(userId)){
			if(relateType!=null && !"".equals(relateType)){
				//根据当前用户，对应的权限获取对应的产品字符串
				String prodCodes=ProductCombiRightUtil.getProductCodeByRelateTypeAndUserId(relateType, userId);
				if(prodCodes!=null && !"".equals(prodCodes)){
					String[] prodCode=prodCodes.split(",");
					if(prodCode!=null && prodCode.length>0){
						StringBuffer prodCodeBuffer=new StringBuffer();
						for(int i=0;i<prodCode.length;i++){
							if(i==prodCode.length-1){
								prodCodeBuffer.append("'"+prodCode[i]+"'");
							}else{
								prodCodeBuffer.append("'"+prodCode[i]+"',");
							}
						}
						resultCodes=prodCodeBuffer.toString();
					}
				}
			}
		}
		return resultCodes;
	}
	
	/**
	 * 主要用于添加审批信息，参与申购的产品是否存在于当前操作
	 * 用户权限的产品
	 * @param rationProductInfo 对应的配售对象市值
	 * @param ipoProductInfo 指令下参与申购的配售对象关联信息对象数组（包括投顾对应产品是否参与）
	 * @param prodCode 产品Code
	 * @param currentUser 当前操作用户
	 * @return
	 */
	@Bizlet("对比参与申购的产品是否在用户权限产品列表中")
	public static String compareProductCode(DataObject[] rationProductInfo,DataObject[] ipoProductInfo,String prodCode,String currentUser){
		//默认值为00，表示初始值
		String reVal="0";
		//判断配售对象是否存
		if(rationProductInfo!=null && rationProductInfo.length>0){
			//判断产品传入的参数是否存在，其中NoPermission是不存在产品
			if(prodCode!=null && !"".equals(prodCode) && !"NoPermission".equals(prodCode)){
				String[] prodCodes=prodCode.split(",");
				//用户对应的产品Code
				for(int i=0;i<prodCodes.length;i++){
					//带市值和产品代码的配售对象数据
					for(int j=0;j<rationProductInfo.length;j++){
						//传入的产品代码是否与配售对象中的产品代码一致
						if(prodCodes[i].equals(rationProductInfo[j].getString("prodCode"))){
							//指令下参与的配售对象数组
							for(int k=0;k<ipoProductInfo.length;k++){
								//判断对应产品代码的配售对象编码是否与参与申购的配售对象编码是否一致
								if(rationProductInfo[j].getString("objectId").equals(ipoProductInfo[k].getString("vcRationProductCode"))){
									//判断用户权限下的产品列表是不大于1个
									if(prodCodes.length>1){
										//判断配售对象的参与类是否为00（00表示参与）
										if("00".equals(ipoProductInfo[k].getString("vcProductParticipantion"))){
											if(currentUser.equals(ipoProductInfo[k].getString("vcCreator"))||currentUser.equals(ipoProductInfo[k].getString("vcLastupdator"))){
												//设置返回值标识符条件表达式01为参与
												reVal=reVal+","+"01"+"-产品名称："+rationProductInfo[j].getString("prodName");
											}else{
												//设置返回标识符03，表示放弃
												reVal=reVal+","+"03";
											}
											
											break;
											//数据实体对应中的01表示不参与
										}else if("01".equals(ipoProductInfo[k].getString("vcProductParticipantion"))){
											//设置标识符条件表达式00为不参与
											if(currentUser.equals(ipoProductInfo[k].getString("vcCreator"))||currentUser.equals(ipoProductInfo[k].getString("vcLastupdator"))){
												//设置返回值标识符条件表达式01为参与
												reVal=reVal+","+"00";
											}else{
												//设置返回标识符03，表示放弃
												reVal=reVal+","+"03";
											}
											
											break;
										}
									}else if(prodCodes.length==1){
										if("00".equals(ipoProductInfo[k].getString("vcProductParticipantion"))){
											if(currentUser.equals(ipoProductInfo[k].getString("vcCreator"))||currentUser.equals(ipoProductInfo[k].getString("vcLastupdator"))){
												//设置返回值标识符条件表达式01为参与
												reVal="01";
											}else{
												//设置返回标识符03，表示放弃
												reVal="03";
											}
											break;
										}else if("01".equals(ipoProductInfo[k].getString("vcProductParticipantion"))){
											if(currentUser.equals(ipoProductInfo[k].getString("vcCreator"))||currentUser.equals(ipoProductInfo[k].getString("vcLastupdator"))){
												//设置返回值标识符条件表达式00为不参与
												reVal="00";
											}else{
												//设置返回标识符03，表示放弃
												reVal="03";
											}
											break;
										}
									}
								}
								
							}
							
						}
						if("01".equals(reVal)|| "03".equals(reVal)){
							break;
						}
					}
				}
			}
		}
		
		System.out.println("reVal:"+reVal);
		
		String[] reVals=reVal.split(",");
		int count=0;
		int countThree=0;
		//主要针对一个投顾管理多个产品的处理
		if(reVals.length>1){
			String prodName=null;
			for(int i=1;i<reVals.length;i++){
				String reValsCode=null;
				if(reVals[i].split("-").length>1){
					reValsCode=reVals[i].split("-")[0];
					prodName=reVals[i].split("-")[1];
				}else{
					reValsCode=reVals[i];
				}
				//选择了参与操作的处理
				if("01".equals(reValsCode)){
					count=count+1;
				//未选择参与操作的处理（注：这里处理的是和别人有共同的产品，
				//	同时另外的人已处理过，当前操作人未作任何操作，直接自动提交）
				}else if("03".equals(reValsCode)){
					countThree=countThree+1;
				}
			}
			if(count==reVals.length-1 ){
				reVal="01";
			}
			if(count==0 && countThree==0){
				reVal="03";
			}else if(countThree==reVals.length-1){
				reVal="03";
			}else{
				reVal="02"+"-"+prodName;
			}
		}
		//针对投顾未作任务参与操作
		if("0".equals(reVal)){
			reVal="03";
		}
		System.out.println("return reVal="+reVal);
		return reVal;
	}
	
	@Bizlet("获取参与操作类型")
	public static String getReVale(String reVal){
		if(reVal.split("-").length>1){
			return reVal.split("-")[0];
		}else{
			return reVal;
		}
	}
	
	@Bizlet("获取参与的产品类型")
	public static String getProdName(String reVal){
		if(reVal.split("-").length>1){
			return "部分参与，"+reVal.split("-")[1];
		}else{
			return "部分参与";
		}
	}
	
	/**
	 * 主要用于投顾当日12点自动完成工作项
	 * 计算工作项创建到12点之间的时间
	 * @param startTime 传入工作项的创建时间
	 * @return 计算后的时间
	 */
	@Bizlet("计算超时时间")
	public static String setTimeOutNum(String dateStr){
		String remindTime=null;
		Date date=null;
		if(dateStr!=null && !"".equals(dateStr)){
			date=DateUtil.parse(dateStr, "yyyyMMddHHmmss");
		}else{
			date=new Date();
		}
		if(date!=null){
			int hours=DateUtil.getHour(date);
			int minutes=DateUtil.getMinute(date);
			remindTime=String.valueOf(16-hours)+"."+String.valueOf(60-minutes);
		}
		return remindTime;
	}
	@Bizlet("查询员工信息")
	public static DataObject getEmpById(String userid){
		//查询用户信息
		DataObject user = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		user.set("userid", userid);
		DatabaseUtil.expandEntityByTemplate("default", user, user);
		return user;
	}
	/**
	 * 完成工作项
	 * @param workitemId 工作项ID
	 */
	@Bizlet("完成工作项")
	public static void finishWorkItem(long workitemId, DataObject user){
		try {
			//将当前的操作人员通知BPS引擎，用来进行权限控制
			BPSServiceClientFactory.getLoginManager().setCurrentUser(user.getString("userid"), user.getString("empname")); 
			//创建BPS流程引擎实例
			IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient();
			//创建工作项管理构建实例
			IWFWorkItemManager workitemManager = client.getWorkItemManager();
			//调用完成工作项方法
			workitemManager.finishWorkItem(workitemId, false);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
	}
	/**
	 * 过滤关联方
	 * @param leadUnderwriter
	 * @return
	 */
	@Bizlet("过滤关联方")
	public static boolean checkLeadUnderwriter(String leadUnderwriter){
		//判断关联方，关联方位第一创业
		if(leadUnderwriter.indexOf("第一创业") > -1){
			//存在关联
			return true;
		}
		return false;
	}
	/**
	 * 过滤关联方-暂停时间
	 * @param leadUnderwriter
	 * @return
	 * @throws InterruptedException 
	 */
	@Bizlet("过滤关联方")
	public static void suspendTime() throws InterruptedException{
		Thread.sleep(1000);//暂停1秒
	}
}
