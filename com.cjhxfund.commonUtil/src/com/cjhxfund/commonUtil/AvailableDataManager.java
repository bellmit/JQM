/**
 * 
 */
package com.cjhxfund.commonUtil;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import quickfix.Group;
import quickfix.field.Account;
import quickfix.field.NoAllocs;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @param dataObject fix查询接口中返回的信息列表
 * @param boundObject 根据债券代码和市场编码查出来的锁定券数量列表
 * @author 陈迪
 * @date 2016-11-09 19:12:19
 *
 */
@Bizlet("可用数据工具类")
public class AvailableDataManager {
	@SuppressWarnings("unused")
	private static final Log log = LogFactory.getLog(AvailableDataManager.class);
	/**
	 * @param obj 指令基础数据包：包含指令基础数据sendMsg和重复组数据combis
	 * @param clordid 第三方系统订单编号，全程唯一
	 * @author 陈迪
	 * @date 2016-11-09 19:12:19
	 * 
	 */
	@Bizlet("组装可用金额数据")
	public Map<Object, Object> setAvailAmtData(DataObject obj, String clordid){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();//重复组债券信息对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建指令数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		//组装指令数据
		sendMsg.setString("vcMsgtype", "H");//35-消息类型
		sendMsg.setString("vcClordid", clordid);//11-第三方系统订单编号，全程唯一
		sendMsg.setString("vcProcesstype", "5");//15999-业务类别：5-可用金额查询
		
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		insertList.add(sendMsg);
		
		Group group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 100, 0});//按照业务需要自定义重复组
		List<DataObject> beanList = new ArrayList<DataObject>();
		
		Object[] combis = (Object[])obj.get("combis");
		if(combis.length>0){
			for(int i=0; i<combis.length; i++){
				DataObject bean = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
				@SuppressWarnings("rawtypes")
				Map combi = (Map)combis[i];
				bean.setString("vcAccount", combi.get("vcAccount").toString());//1:恒生系统组合编号，指定指令下达到恒生的哪个组合下。若债券的组合编号为空，则取指令的组合编号
				bean.setString("vcExdestination", combi.get("exdestination").toString());//【前端设置OTC】 100-交易市场
				
				DatabaseExt.getPrimaryKey(bean);
				bean.setString("lMsgId", sendMsg.getString("lMsgId"));
				bean.setDate("dCreated", DateUtil.getDate());
				
				beanList.add(bean);				
				insertList.add(bean);
			}
			
		}
		
		//组装重复组数据
		groupList.add(group);
		bondsList.add(beanList);
		//把指令所有数据和保存的数据分别组装到map中
		map.put("sendMsg", sendMsg);
		map.put("groupList", groupList);
		map.put("bondsList", bondsList);
		map.put("insertList", insertList);
		
		return map;
	}
	
	/**
	 * 把fix中查询回来的结果中的T+0和T+1可用金额数解析出来
	 * @param fixReceiveMsgList fix查询返回的结果
	 * @author 陈迪
	 * @return 可用金额的DataObject列表
	 * @date 2016-11-09 19:12:19
	 * 
	 */
	@Bizlet("实际可用金额")
	public List<DataObject> getAvailAmtData(List<DataObject> fixReceiveMsgList){
		DataObject obj = null;
		List<DataObject> availList = new ArrayList<DataObject>();
		Object[] tempAvail = null;
		
		Double buyAmt = (Double) 0.0;//(清算速度为t+0、流程还没走到O32买入业务的下单金额)
		Double repoAmt = (Double) 0.0;//(清算速度为t+1、流程还没走到O32买入业务的下单金额)
		Double updateBuyAmt = (Double) 0.0;//指令金额(流程走到O32且修改审核中的买入业务)
		Double updateRepoAmt = (Double) 0.0;//指令金额(流程走到O32且修改审核中的融券回购业务)
		@SuppressWarnings("unused")
		Double assetInfoApplyInfoAmt = (Double) 0.0;//一级债未到O32的下单金额
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd"); 
		String nextTrade = format.format(new Date().getTime()+24*3600*1000) ;
		//获取系统下一交易日期
		Object[] o32NextTradeDate = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),
				"com.cjhxfund.commonUtil.dateUtil.getNextTradeDay",null);
		if(o32NextTradeDate.length>0 && o32NextTradeDate[0]!=null){
			nextTrade = (String) o32NextTradeDate[0];
		}
		try{
			//判断返回的list是否为null
			if(fixReceiveMsgList != null){
				//判断list是否有值
				if(fixReceiveMsgList.size() > 0){
					//查询可用金额结果集
					tempAvail = DatabaseExt.queryByNamedSql("default",
							"com.cjhxfund.commonUtil.availableManage.queryAvailMnt",fixReceiveMsgList.get(0).getString("L_MSG_ID"));
					if(tempAvail.length>0){
						for(int i=0;i<tempAvail.length;i++){
							String[] array = null;
							//循环取得每一条可用金额（fix中返回来的）
							DataObject mapAvail = (DataObject)tempAvail[i];
							obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//创建空的dataObject对象接收fix查询出来的13211-可用信息解析后的值
							String soutputText = mapAvail.get("vcSoutputtext").toString();//从返回到的重复组数据中取到返回可用信息13211
							array = soutputText.split("\\|");//把可用信息取出来放在字符串数组
							//------------------以下为二级债部分--------------------//
							//计算(流程还没走到O32的融券回购业务和买入业务的下单金额)
							String vcAssetCode = array[0].toString();//组合代码
							DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
							data.setString("vcAssetCode", vcAssetCode);
							data.setString("nextTradeDate", nextTrade);
							//指令未下到O32并且交易日期是当天(或交易日为明天的T+0)的买入下单金额总数
							Object[] assetBuyAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryBuyAmt",data);
							if(assetBuyAmt[0]!=null){
								buyAmt = (Double) assetBuyAmt[0];
							}
							//指令未下到O32并且交易日期是当天(或交易日为明天的T+0)的逆回购下单金额总数
							Object[] assetRepoAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryRepoAmt",data);
							if(assetRepoAmt[0]!=null){
								repoAmt = (Double) assetRepoAmt[0];
							}
							//指令已到O32的且指令为修改审核中的买入下单总额
							Object[] assetUpdateBuyAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryUpdateBuyAmt",data);
							if(assetUpdateBuyAmt[0]!=null){
								updateBuyAmt = (Double) assetUpdateBuyAmt[0];
							}
							//指令已到O32的且指令为修改审核中的逆回购下单总额
							Object[] assetUpdateRepoAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryUpdateRepoAmt",data);
							if(assetUpdateRepoAmt[0]!=null){
								updateRepoAmt = (Double) assetUpdateRepoAmt[0];
							}
							//------------------以下为一级债部分--------------------//
							//一级债未到O32的指令金额
							Object[] assetInfoApplyInfoMoney = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryAssetInfoApplyInfoMoney",data);
							if(assetInfoApplyInfoMoney[0]!=null){
								assetInfoApplyInfoAmt = (Double) assetInfoApplyInfoMoney[0];
							}
							//------------------以下为实际可用计算--------------------//
							//实际可用金额=O32-二级债未下单到O32(卖出+正回购)-一级债未下单到O32+二级债已下单到O32并且修改审核中的指令金额(买入+逆回购)
							obj.set("C_LOCAL_AVAILABLE", ParamConfig.getValue("ZHFWPT_LOCAL_AVAILABLE"));//可用 是否启用本机计算:0-不启用，1-启用
							obj.set("VC_O32_AVAILABLEAMOUNT_T0", Double.parseDouble(array[2].toString()));
							obj.set("VC_O32_AVAILABLEAMOUNT_T1", Double.parseDouble(array[3].toString()));
							obj.set("VC_AVAILABLEAMOUNT_T0", Double.parseDouble(array[2].toString()) - buyAmt- repoAmt  + updateBuyAmt + updateRepoAmt);//T+0可用金额
							obj.set("VC_AVAILABLEAMOUNT_T1", Double.parseDouble(array[3].toString()) - buyAmt- repoAmt  + updateBuyAmt + updateRepoAmt);//T+1可用金额
							obj.setString("VC_TASSET", array[0].toString());//恒生系统资产单元编号
							obj.set("VC_ACCOUNT", array[1].toString());//恒生系统组合编号
							obj.setString("VC_CURRENTAMOUNT", array[4].toString());//当前金额
							availList.add(obj);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		return availList;
	}
	/**
	 * 将向fix发送可用数量查询指令需要的数据封装
	 * @param obj 指令基础数据包：包含指令基础数据sendMsg和重复组数据combis
	 * @param clordid 第三方系统订单编号，全程唯一
	 * @author 陈迪
	 * @date 2016-11-09 19:12:19
	 * 
	 */
	@Bizlet("组装可用数量数据")
	public Map<Object, Object> setAvailQtyData(DataObject obj, String clordid){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();//重复组债券信息对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建指令数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		//组装指令数据
		sendMsg.setString("vcMsgtype", "H");//35-消息类型
		sendMsg.setString("vcClordid", clordid);//11-第三方系统订单编号，全程唯一
		sendMsg.setString("vcProcesstype", "6");//15999-业务类别：6-可用数量查询
		sendMsg.setString("vcBusinclass", obj.getString("vcBusinclass"));//13000-业务类别：2-银行间二级市场业务  A –开放式基金 B-存款业务 C-网下申购 D-债券一级市场
		
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		insertList.add(sendMsg);
		
		Group group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 55, 100, 13001, 14000, 0});//按照业务需要自定义重复组
		List<DataObject> beanList = new ArrayList<DataObject>();
		
		Object[] combis = (Object[]) obj.get("combis");
		if(combis!=null && combis.length>0){
			for(int i=0; i<combis.length; i++){
				DataObject bean = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
				@SuppressWarnings("rawtypes")
				Map combi = (Map)combis[i];
				bean.setString("vcAccount", combi.get("vcAccount").toString());//1-恒生系统组合编号，指定指令下达到恒生的哪个组合下。若债券的组合编号为空，则取指令的组合编号
				bean.setString("vcSymbol", combi.get("vcStockCode").toString());//55-证券申报代码
				bean.setString("vcExdestination", combi.get("vcMarket").toString());//100-【前端设置OTC】 100-交易市场
				bean.setString("vcBusintype", combi.get("vcBusinType").toString());//13001-委托方向：债券买入
				//将我们系统和O32的委托方向代码值做转换处理
//				if("01".equals(combi.get("vcBusinType").toString())){
//					bean.setString("vcBusintype", "3");//13001-委托方向：债券买入
//				}
//				if("02".equals(combi.get("vcBusinType").toString())){
//					bean.setString("vcBusintype", "4");//13001-委托方向：债券卖出
//				}
//				if("03".equals(combi.get("vcBusinType").toString())){
//					bean.setString("vcBusintype", "5");//13001-委托方向：融资回购
//				}
//				if("04".equals(combi.get("vcBusinType").toString())){
//					bean.setString("vcBusintype", "6");//13001-委托方向：融券回购
//				}
				bean.setString("vcInvesttype", combi.get("vcInvestType").toString());//14000-投资类型：1-可交易 2-持有到期 3-可供出售 4-贷款和应收款项
				DatabaseExt.getPrimaryKey(bean);
				bean.setString("lMsgId", sendMsg.getString("lMsgId"));
				bean.setDate("dCreated", DateUtil.getDate());
				
				beanList.add(bean);
				insertList.add(bean);
			}
			
		}
		
		//组装重复组数据
		groupList.add(group);
		bondsList.add(beanList);
		
		map.put("sendMsg", sendMsg);
		map.put("groupList", groupList);
		map.put("bondsList", bondsList);
		map.put("insertList", insertList);
		
		return map;
	}	
	/**
	 * 把fix中查询回来的结果中的T+0和T+1可用数量解析出来，然后和锁定券数量进行运算操作得出实际的可用数量
	 * @param fixReceiveMsgList fix查询可用数量返回结果数据
	 * @author 陈迪
	 * @return 可用数量的DataObject列表
	 * @date 2016-11-09 19:12:19
	 * 
	 */
	@Bizlet("实际可用数量")
	public List<DataObject> getAvailQtyData(List<DataObject> fixReceiveMsgList,List<List<DataObject>> bondsList){
		DataObject obj = null;
		List<DataObject> availableQuantityList = new ArrayList<DataObject>();
		Object[] tempAvailableQuantity = null;
		
		//先判断返回的list是否有值
		try{
			if(fixReceiveMsgList != null){
				if(fixReceiveMsgList.size() > 0){
					//查询可用数量结果集
					tempAvailableQuantity = DatabaseExt.queryByNamedSql("default",
							"com.cjhxfund.commonUtil.availableManage.queryAvailQty",fixReceiveMsgList.get(0).getString("L_MSG_ID"));
					if(tempAvailableQuantity.length>0){
						System.out.println("==========输出实际可用数量信息开始===========");
						//获取系统下一交易日期
						SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd"); 
						String nextTrade = format.format(new Date().getTime()+24*3600*1000);
						Object[] o32NextTradeDate = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),
								"com.cjhxfund.commonUtil.dateUtil.getNextTradeDay",null);
						if(o32NextTradeDate.length>0 && o32NextTradeDate[0]!=null){
							nextTrade = (String) o32NextTradeDate[0];
						}
						for(int i=0;i<tempAvailableQuantity.length;i++){
							String[] array = null;
							String VC_SOUTPUTTEXT = null;
							String cnMortgage = "0";//t0不可质押数量
							String cnSell = "0";//t0不可卖数量
							String cnMortgageSell = "0";//t0不可质押不可卖数量
							String t1_cnMortgageSell = "0";//t1不可质押不可卖数量
							
							Long sellCount = (long) 0;
							Long pledgeCount = (long) 0;
							Long updateSellCount = (long) 0;
							Long updatePledgeCount = (long) 0;
							Long inquiryMortagageSell = (long) 0;
							Long inquirySellQuantity = (long) 0;
							//循环取得每一条可用数量（fix中返回来的）
							DataObject mapAvailableQuantity = (DataObject)tempAvailableQuantity[i];
							System.out.println("fix中返回来的信息===lMsgId:"+mapAvailableQuantity.getString("lMsgId")+"---vcExdestination:"+mapAvailableQuantity.getString("vcExdestination")
									+"---vcSymbol:"+mapAvailableQuantity.getString("vcSymbol")+"---恒生系统组合编号|证券申报代码|投资类型|T+0可用数量|T+1可用数量|股指期货当前空头数量|股指期货当前多头数量:"+mapAvailableQuantity.getString("vcSoutputtext"));
							obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//创建空的dataObject对象接收fix查询出来的13211-可用信息解析后的值
							VC_SOUTPUTTEXT = mapAvailableQuantity.get("vcSoutputtext").toString();//取到返回可用信息13211
							
							//解析可用数量信息以及跟锁定券做运算，取得最终可用数量
							array = VC_SOUTPUTTEXT.split("\\|");//把可用信息取出来放在字符串数组
							String vcStockcode = array[1].toString();//证券代码
							String vcExdestination = bondsList.get(0).get(i).getString("vcExdestination");//交易市场：从页面传过来的bondsList中获取（fix中返回来的重复组降序排序之后和页面传过来的重复组顺序一一对应）
							String vcBusintype = bondsList.get(0).get(i).getString("vcBusintype");//委托方向
							String vcCombiCode = bondsList.get(0).get(i).getString("vcAccount");//组合代码
							//将交易市场转换为市场编码
							if("OTC".equals(vcExdestination)){
								vcExdestination = "5";
							}
							if("SS".equals(vcExdestination)){
								vcExdestination = "1";
							}
							if("SZ".equals(vcExdestination)){
								vcExdestination = "2";
							}
							//创建空的DataObject,作为查询单条锁定券数量的参数
							DataObject dataObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
							dataObject.setString("vcMarket", vcExdestination);
							dataObject.setString("vcStockCode", vcStockcode);
							dataObject.setString("vcCombiCode", vcCombiCode);
							dataObject.setString("nextTradeDate", nextTrade);
							//T+0查询单条锁定券数量结果集（Object数组）
							Object[] lockBondQuantity = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.querySingleBondLockSql",dataObject);
							//判断是否查询到锁定券的数量
							if(lockBondQuantity.length>0 && lockBondQuantity[0]!=null){
								//获取单条锁定券数据
								DataObject mapBondQuantity = (DataObject)lockBondQuantity[0];
								//获取单条锁定券的数量t0
								cnMortgage = mapBondQuantity.get("cnMortgage").toString();
								cnSell = mapBondQuantity.get("cnSell").toString();
								cnMortgageSell = mapBondQuantity.get("cnMortgageSell").toString();
								// 获取单条锁定券数量t1
								t1_cnMortgageSell = mapBondQuantity.get("t1CnMortgageSell").toString();
							}
							//查询结果指令表中指令未到O32之前的卖出数量('1','2','2A','3')的数据
							Object[] stockSell= DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryMortagageSell",dataObject);
							if(stockSell[0]!=null){
								sellCount = (Long) stockSell[0];
							}
							//查询结果指令表中指令未到O32之前的正回购业务质押数量('1','2','2A','3')的数据
							Object[] stockPledge = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryMortagageSellRepo",dataObject);
							if(stockPledge[0]!=null){
								pledgeCount = (Long) stockPledge[0];
							}
							//ATS中所有对应 该组合下的这个券的 & 流程状态：已下达到O32 & 指令状态：修改审核中 & 委托方向：卖出业务指令的值
							Object[] stockUpdateSell = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryUpdateSell",dataObject);
							if(stockUpdateSell[0]!=null){
								updateSellCount = (Long) stockUpdateSell[0];
							}
							//ATS中所有对应 该组合下的这个券的 & 流程状态：已下达到O32 & 指令状态：修改审核中 & 委托方向：正回购 的指令的值
							Object[] stockUpdatePledge = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryUpdateSellRepo",dataObject);
							if(stockUpdatePledge[0]!=null){
								updatePledgeCount = (Long) stockUpdatePledge[0];
							}
							
							// 查询询价结果已提交投资经理未审批的质押券数量
							Object[] inquiryMortagageSellRepo = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryInquiryMortagageSellRepo",dataObject);
							if(inquiryMortagageSellRepo[0]!=null){
								inquiryMortagageSell = (Long) inquiryMortagageSellRepo[0];
							}
							// 查询询价结果已提交投资经理未审批的卖出数量
							Object[] inquirySellQuantityObj = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.queryInquirySellQuantity",dataObject);
							if(inquirySellQuantityObj[0]!=null){
								inquirySellQuantity = (Long) inquirySellQuantityObj[0];
							}
							
							obj.setString("VC_ACCOUNT",array[0].toString());//恒生系统组合编号
							obj.setString("VC_SYMBOL",array[1].toString());//证券申报代码
							obj.setString("VC_EXDESTINATION", vcExdestination);//交易市场
							int availQtyBuyT0 = Integer.parseInt(cnSell)+Integer.parseInt(cnMortgageSell);
							int availQtyBuyT1 = Integer.parseInt(cnSell)+Integer.parseInt(t1_cnMortgageSell);
							int availQtyRepoT0 = Integer.parseInt(cnMortgage)+Integer.parseInt(cnMortgageSell);
							int availQtyRepoT1 = Integer.parseInt(cnMortgage)+Integer.parseInt(t1_cnMortgageSell);
							
							//O32返回可用数量
							obj.set("C_LOCAL_AVAILABLE", ParamConfig.getValue("ZHFWPT_LOCAL_AVAILABLE"));//可用 是否启用本机计算:0-不启用，1-启用
							obj.setLong("VC_O32_AVAILABLEQUANTITY_T0", Integer.parseInt(array[3].toString()));
							obj.setLong("VC_O32_AVAILABLEQUANTITY_T1", Integer.parseInt(array[4].toString()));
							System.out.println("委托方向vcBusintype:"+vcBusintype);
							if("3".equals(vcBusintype)||"4".equals(vcBusintype)){
								//实际可用数量=O32可用数量-锁定数量（不可卖锁定、不可质押不可卖锁定）-结果指令表中指令未到O32之前的卖出(或质押出去)数量('1','2','2A','3')+已到O32的修改审核中的卖出(或质押出去)数量('4','5','6')
								obj.setLong("VC_AVAILABLEQUANTITY_T0",Integer.parseInt(array[3].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount-availQtyBuyT0);//T+0可用数量
								obj.setLong("VC_AVAILABLEQUANTITY_T1",Integer.parseInt(array[4].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount-availQtyBuyT1);//T+1可用数量
							}else if("5".equals(vcBusintype)||"6".equals(vcBusintype)||"15".equals(vcBusintype)||"16".equals(vcBusintype)
										||"17".equals(vcBusintype)||"18".equals(vcBusintype)||"26".equals(vcBusintype)||"27".equals(vcBusintype)||"30".equals(vcBusintype)||"31".equals(vcBusintype)){
								//实际可用数量=O32可用数量-锁定数量（不可质押锁定、不可质押不可卖锁定）-结果指令表中指令未到O32之前的卖出(或质押出去)数量('1','2','2A','3')+已到O32的修改审核中的卖出(或质押出去)数量('4','5','6')
								obj.setLong("VC_AVAILABLEQUANTITY_T0",Integer.parseInt(array[3].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount-availQtyRepoT0);//T+0可用数量
								obj.setLong("VC_AVAILABLEQUANTITY_T1",Integer.parseInt(array[4].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount-availQtyRepoT1);//T+1可用数量
							}
							System.out.println("实际可用数量=O32可用数量-锁定数量（不可质押锁定、不可质押不可卖锁定）-结果指令表中指令未到O32之前的卖出(或质押出去)数量('1','2','2A','3')+已到O32的修改审核中的卖出(或质押出去)数量('4','5','6')");
							System.out.println("实际可用数量=Integer.parseInt(array[3].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount-availQtyBuyT0");
							System.out.println("实际可用数量(T+0可用数量)="+Integer.parseInt(array[3].toString())+"-"+sellCount+"-"+pledgeCount+"+"+updateSellCount+"+"+updatePledgeCount+"-"+availQtyBuyT0);
							System.out.println("实际可用数量(T+1可用数量)="+Integer.parseInt(array[4].toString())+"-"+sellCount+"-"+pledgeCount+"+"+updateSellCount+"+"+updatePledgeCount+"-"+availQtyBuyT1);
							// 询价结果可用数量实际可用数量  = O32可用数量 - 询价银行间正回购质押券数量-询价银行间卖出数量；（质押券数量和卖出取已提交但是投资经理未确认部分）
							obj.setLong("VC_AVAILABLEQUANTITY_INQUIRY_T0",Integer.parseInt(array[3].toString())-inquiryMortagageSell-inquirySellQuantity);//T+0可用数量
							obj.setLong("VC_AVAILABLEQUANTITY_INQUIRY_T1",Integer.parseInt(array[4].toString())-inquiryMortagageSell-inquirySellQuantity);//T+1可用数量
							System.out.println("询价结果可用数量实际可用数量  = O32可用数量 - 询价银行间正回购质押券数量-询价银行间卖出数量；（质押券数量和卖出取已提交但是投资经理未确认部分）");
							System.out.println("询价结果可用数量实际可用数量  = Integer.parseInt(array[3].toString())-inquiryMortagageSell-inquirySellQuantity");
							System.out.println("询价结果可用数量实际可用数量(T+0可用数量)="+Integer.parseInt(array[3].toString())+"-"+inquiryMortagageSell+"-"+inquirySellQuantity);
							System.out.println("询价结果可用数量实际可用数量(T+1可用数量)="+Integer.parseInt(array[4].toString())+"-"+inquiryMortagageSell+"-"+inquirySellQuantity);
							
							obj.setString("VC_SHORT",array[5].toString());//股指期货当前空头数量
							obj.setString("VC_BULL",array[6].toString());//股指期货当前多头数量
							System.out.println(mapAvailableQuantity.getString("lMsgId")+"|恒生系统组合编号VC_ACCOUNT:"+obj.getString("VC_ACCOUNT")+"|证券申报代码VC_SYMBOL:"+obj.getString("VC_SYMBOL")+
									"|交易市场VC_EXDESTINATION:"+obj.getString("VC_EXDESTINATION")+"|是否启用本机计算C_LOCAL_AVAILABLE:"+obj.getString("C_LOCAL_AVAILABLE")+
									"|实际可用VC_O32_AVAILABLEQUANTITY_T0:"+obj.getLong("VC_O32_AVAILABLEQUANTITY_T0")+"|实际可用VC_O32_AVAILABLEQUANTITY_T1:"+obj.getLong("VC_O32_AVAILABLEQUANTITY_T1")+
									"|询价结果可用数量实际可用数量VC_AVAILABLEQUANTITY_INQUIRY_T0:"+obj.getLong("VC_AVAILABLEQUANTITY_INQUIRY_T0")+"|询价结果可用数量实际可用数量VC_AVAILABLEQUANTITY_INQUIRY_T0:"+obj.getLong("VC_AVAILABLEQUANTITY_INQUIRY_T1"+
									"|股指期货当前空头数量VC_SHORT:")+obj.getString("VC_SHORT")+"|股指期货当前多头数量VC_BULL:"+obj.getString("VC_BULL"));
							System.out.println("==========输出实际可用数量信息结束===========");
							availableQuantityList.add(obj);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return availableQuantityList;
	}
	
	public static void main(String[] args){
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd"); 
		System.out.println(format.format(new Date().getTime()));
	}
}
