/**
 * 
 */
package com.cjhxfund.ats.sm.comm;


import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import quickfix.Group;
import quickfix.field.Account;
import quickfix.field.NoAllocs;

import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.ProductCombiRightUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

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
		sendMsg.setString("vcBusinclass", "2");//13000-业务类别：2-银行间二级市场业务  A –开放式基金 B-存款业务 C-网下申购 D-债券一级市场
		
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
		try{
			//判断返回的list是否为null
			if(fixReceiveMsgList != null){
				//判断list是否有值
				if(fixReceiveMsgList.size() > 0){
					//查询可用金额结果集
					tempAvail = DatabaseExt.queryByNamedSql("default",
							"com.cjhxfund.ats.sm.comm.availableManage.queryAvailMnt",fixReceiveMsgList.get(0).getString("L_MSG_ID"));
					if(tempAvail.length>0){
						for(int i=0;i<tempAvail.length;i++){
							String[] array = null;
							//循环取得每一条可用金额（fix中返回来的）
							DataObject mapAvail = (DataObject)tempAvail[i];
							obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//创建空的dataObject对象接收fix查询出来的13211-可用信息解析后的值
							String soutputText = mapAvail.get("vcSoutputtext").toString();//从返回到的重复组数据中取到返回可用信息13211
							array = soutputText.split("\\|");//把可用信息取出来放在字符串数组
							
							//计算(流程还没走到O32的融券回购业务和买入业务的下单金额)
							String vcAssetCode = array[0].toString();//组合代码
							DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
							data.setString("vcAssetCode", vcAssetCode);
							//指令未下到O32并且交易日期是当天(或交易日为明天的T+0)的买入下单金额总数
							Object[] assetBuyAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryBuyAmt",data);
							if(assetBuyAmt!=null && assetBuyAmt[0]!=null){
								buyAmt = (Double) assetBuyAmt[0];
							}
							//指令未下到O32并且交易日期是当天(或交易日为明天的T+0)的逆回购下单金额总数
							Object[] assetRepoAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryRepoAmt",data);
							if(assetRepoAmt!=null && assetRepoAmt[0]!=null){
								repoAmt = (Double) assetRepoAmt[0];
							}
							//指令已到O32的且指令为修改审核中的买入下单总额
							Object[] assetUpdateBuyAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryUpdateBuyAmt",data);
							if(assetUpdateBuyAmt!=null && assetUpdateBuyAmt[0]!=null){
								updateBuyAmt = (Double) assetUpdateBuyAmt[0];
							}
							//指令已到O32的且指令为修改审核中的逆回购下单总额
							Object[] assetUpdateRepoAmt = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryUpdateRepoAmt",data);
							if(assetUpdateRepoAmt!=null && assetUpdateRepoAmt[0]!=null){
								updateRepoAmt = (Double) assetUpdateRepoAmt[0];
							}
							
							obj.set("VC_AVAILABLEAMOUNT_T0", Double.parseDouble(array[2].toString()) - buyAmt- repoAmt + updateBuyAmt + updateRepoAmt);//T+0可用金额
							obj.set("VC_AVAILABLEAMOUNT_T1", Double.parseDouble(array[3].toString()) - buyAmt- repoAmt + updateBuyAmt + updateRepoAmt);//T+1可用金额
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
		sendMsg.setString("vcBusinclass", "2");//13000-业务类别：2-银行间二级市场业务  A –开放式基金 B-存款业务 C-网下申购 D-债券一级市场
		
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
				//将我们系统和O32的委托方向代码值做转换处理
				if("01".equals(combi.get("vcBusinType").toString())){
					bean.setString("vcBusintype", "3");//13001-委托方向：债券买入
				}
				if("02".equals(combi.get("vcBusinType").toString())){
					bean.setString("vcBusintype", "4");//13001-委托方向：债券卖出
				}
				if("03".equals(combi.get("vcBusinType").toString())){
					bean.setString("vcBusintype", "5");//13001-委托方向：融资回购
				}
				if("04".equals(combi.get("vcBusinType").toString())){
					bean.setString("vcBusintype", "6");//13001-委托方向：融券回购
				}
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
							"com.cjhxfund.ats.sm.comm.availableManage.queryAvailQty",fixReceiveMsgList.get(0).getString("L_MSG_ID"));
					if(tempAvailableQuantity.length>0){
						for(int i=0;i<tempAvailableQuantity.length;i++){
							String[] array = null;
							String VC_SOUTPUTTEXT = null;
							//String cnMortgage = "0";//不可质押数量
							//String cnSell = "0";//不可卖数量
							//String cnMortgageSell = "0";//不可质押不可卖数量
							
							Long sellCount = (long) 0;
							Long pledgeCount = (long) 0;
							Long updateSellCount = (long) 0;
							Long updatePledgeCount = (long) 0;
							//循环取得每一条可用数量（fix中返回来的）
							DataObject mapAvailableQuantity = (DataObject)tempAvailableQuantity[i];
							obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//创建空的dataObject对象接收fix查询出来的13211-可用信息解析后的值
							VC_SOUTPUTTEXT = mapAvailableQuantity.get("vcSoutputtext").toString();//取到返回可用信息13211
							
							//解析可用数量信息以及跟锁定券做运算，取得最终可用数量
							array = VC_SOUTPUTTEXT.split("\\|");//把可用信息取出来放在字符串数组
							String vcStockcode = array[1].toString();//证券代码
							String vcExdestination = bondsList.get(0).get(i).getString("vcExdestination");//交易市场：从页面传过来的bondsList中获取（fix中返回来的重复组降序排序之后和页面传过来的重复组顺序一一对应）
							//String vcBusintype = bondsList.get(0).get(i).getString("vcBusintype");//委托方向
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
							//查询单条锁定券数量结果集（Object数组）
							//lockBondQuantity = DatabaseExt.queryByNamedSql("default",
							//		"com.cjhxfund.ats.sm.comm.bondManage.querySingleBondLockSql",dataObject);
							//判断是否查询到锁定券的数量
							//if(lockBondQuantity!=null && lockBondQuantity.length>0){
								//获取单条锁定券数据
							//	DataObject mapBondQuantity = (DataObject)lockBondQuantity[0];
								//获取单条锁定券的数量
							//	cnMortgage = mapBondQuantity.get("cnMortgage").toString();
							//	cnSell = mapBondQuantity.get("cnSell").toString();
							//	cnMortgageSell = mapBondQuantity.get("cnMortgageSell").toString();
							//}
							
							//查询结果指令表中指令未到O32之前的卖出数量('1','2','2A','3')的数据
							Object[] stockSell= DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryMortagageSell",dataObject);
							if(stockSell!=null && stockSell[0]!=null){
								sellCount = (Long) stockSell[0];
							}
							//查询结果指令表中指令未到O32之前的正回购业务质押数量('1','2','2A','3')的数据
							Object[] stockPledge = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryMortagageSellRepo",dataObject);
							if(stockPledge!=null && stockPledge[0]!=null){
								pledgeCount = (Long) stockPledge[0];
							}
							//ATS中所有对应 该组合下的这个券的 & 流程状态：已下达到O32 & 指令状态：修改审核中 & 委托方向：卖出业务指令的值
							Object[] stockUpdateSell = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryUpdateSell",dataObject);
							if(stockUpdateSell!=null && stockUpdateSell[0]!=null){
								updateSellCount = (Long) stockUpdateSell[0];
							}
							//ATS中所有对应 该组合下的这个券的 & 流程状态：已下达到O32 & 指令状态：修改审核中 & 委托方向：正回购 的指令的值
							Object[] stockUpdatePledge = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.ats.sm.comm.availableManage.queryUpdateSellRepo",dataObject);
							if(stockUpdatePledge!=null && stockUpdatePledge[0]!=null){
								updatePledgeCount = (Long) stockUpdatePledge[0];
							}
							obj.setString("VC_ACCOUNT",array[0].toString());//恒生系统组合编号
							obj.setString("VC_SYMBOL",array[1].toString());//证券申报代码
							obj.setString("VC_EXDESTINATION", vcExdestination);//交易市场
							//实际可用数量=O32可用数量-不可卖数量-不可质押不可卖数量-结果指令表中指令未到O32之前的卖出(或质押出去)数量('1','2','2A','3')+已到O32的修改审核中的卖出(或质押出去)数量('4','5','6')
							obj.setLong("VC_AVAILABLEQUANTITY_T0",Integer.parseInt(array[3].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount);//T+0可用数量
							obj.setLong("VC_AVAILABLEQUANTITY_T1",Integer.parseInt(array[4].toString())-sellCount-pledgeCount+updateSellCount+updatePledgeCount);//T+1可用数量
							
							obj.setString("VC_SHORT",array[5].toString());//股指期货当前空头数量
							obj.setString("VC_BULL",array[6].toString());//股指期货当前多头数量
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
	
	/**
	 * @author 吴艳飞
	 * @param vcMarket 交易市场
	 * @param vcBusinType 委托方向
	 * @param vcInvestType 投资类型
	 * @date 2016-12-01 10:52:03
	 *
	 */
		@Bizlet("组装T+0可用数量、T+1可用数量发送参数")
		public  DataObject comb(Object[] list, String vcBusinclass, String vcMarket, String vcBusinType, String vcInvestType){
			int length = list.length;
			List<HashMap<String,String>> combis = new ArrayList<HashMap<String,String>>(); 
			DataObject sendMsg = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
			for(int i =0;i<length;i++){
				DataObject temp2 = (DataObject) list[i];
				HashMap<String, String> temp = new HashMap<String, String>();
				temp.put("vcAccount", temp2.getString("vcCombiNo"));
				temp.put("vcStockCode", temp2.getString("vcStockCode"));
				temp.put("vcMarket", vcMarket);
				temp.put("vcBusinType", vcBusinType);
				temp.put("vcInvestType", vcInvestType);
				combis.add(temp);
			}
			sendMsg.set("vcBusinclass", vcBusinclass);
			sendMsg.set("combis", combis.toArray());
			return sendMsg;
		}
		
		/**
		 * @author 吴艳飞
		 * @param vcMarket 交易市场
		 * @date 2016-12-01 10:52:03
		 *
		 */
			@Bizlet("组装T+0可用金额、T+1可用金额发送参数")
			public  DataObject combiNo(DataObject list){
				List<HashMap<String,String>> combis = new ArrayList<HashMap<String,String>>(); 
				DataObject sendMsg = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				HashMap<String, String> temp = new HashMap<String, String>();
				temp.put("vcAccount", list.getString("vcCombiNo"));
				temp.put("exdestination", list.getString("exdestination"));
				combis.add(temp);
				sendMsg.set("combis", combis.toArray());
				return sendMsg;
			}
			
		@Bizlet("组装T+0可用数量、T+1可用数量返回值")
		public  DataObject[] combAvai(List<DataObject> avaiList,DataObject[] entityList){
			int length = entityList.length;
			int length2 = avaiList.size();
			for(int i =0;i<length;i++){
				for(int j = 0;j<length2;j++){
					if(entityList[i].getString("vcStockCode").equals(avaiList.get(j).getString("VC_SYMBOL"))){
						DecimalFormat format = new DecimalFormat("###,##0");
						if(avaiList.get(j).getString("C_LOCAL_AVAILABLE") != null){
							entityList[i].set("cLocalAvailable", format.format(Double.valueOf(avaiList.get(j).getString("C_LOCAL_AVAILABLE"))));
						}
						if(avaiList.get(j).getString("VC_O32_AVAILABLEQUANTITY_T0") != null){
							entityList[i].set("vcO32AvailablequantityT0", format.format(Double.valueOf(avaiList.get(j).getString("VC_O32_AVAILABLEQUANTITY_T0"))));
						}
						if(avaiList.get(j).getString("VC_O32_AVAILABLEQUANTITY_T1") != null){
							entityList[i].set("vcO32AvailablequantityT1", format.format(Double.valueOf(avaiList.get(j).getString("VC_O32_AVAILABLEQUANTITY_T1"))));
						}
						if(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T0") != null){
							entityList[i].set("vcAvailablequantityT0", format.format(Double.valueOf(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T0"))));
						}
						if(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T1") != null){
							entityList[i].set("vcAvailablequantityT1", format.format(Double.valueOf(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_T1"))));
						}
						// 询价
						if(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_INQUIRY_T0") != null){
							entityList[i].set("vcAvailableQuantityInquiryT0", format.format(Double.valueOf(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_INQUIRY_T0"))));
						}
						if(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_INQUIRY_T1") != null){
							entityList[i].set("vcAvailableQuantityInquiryT1", format.format(Double.valueOf(avaiList.get(j).getString("VC_AVAILABLEQUANTITY_INQUIRY_T1"))));
						}
					}
				}
			}
			return entityList;
		}
		
		@Bizlet("组装T+0可用金额、T+1可用金额返回值")
		public  DataObject[] combSum(DataObject[] sumList,DataObject[] entityList){
			int length = entityList.length;
			int length2 = sumList.length;
			for(int i =0;i<length;i++){
				for(int j = 0;j<length2;j++){
					if(sumList[j].getString("C_LOCAL_AVAILABLE") != null){
						entityList[i].set("cLocalAvailable", sumList[j].getString("C_LOCAL_AVAILABLE"));
					}
					if(sumList[j].getString("VC_O32_AVAILABLEAMOUNT_T0") != null){
						entityList[i].set("vcO32AvailableamountT0", sumList[j].getString("VC_O32_AVAILABLEAMOUNT_T0"));
					}
					if(sumList[j].getString("VC_O32_AVAILABLEAMOUNT_T1") != null){
						entityList[i].set("vcO32AvailableamountT1", sumList[j].getString("VC_O32_AVAILABLEAMOUNT_T1"));
					}
					if(sumList[j].getString("VC_AVAILABLEAMOUNT_T0") != null){
						entityList[i].set("vcAvailableamountT0", sumList[j].getString("VC_AVAILABLEAMOUNT_T0"));
					}
					if(sumList[j].getString("VC_AVAILABLEAMOUNT_T1") != null){
						entityList[i].set("vcAvailableamountT1", sumList[j].getString("VC_AVAILABLEAMOUNT_T1"));
					}
					if(sumList[j].getString("VC_TASSET") != null){
						entityList[i].set("VC_TASSET", sumList[j].getString("VC_TASSET"));
					}
				}
			}
			return entityList;
		}
		
		@Bizlet("可用数据做比较")
		public  DataObject availableDataCompare(DataObject[] sumList, DataObject entityData, DataObject oldEntityData){
			String mark = "0";
			String operatorType = entityData.getString("operatorType");//判断是否为修改指令:1-修改指令
			String vcEntrustDirection = entityData.getString("vcEntrustDirection");//委托方向
			double faceAmount = entityData.getDouble("enFaceAmount");//券面金额
			double fullPrice = entityData.getDouble("enFullPrice");//全价
			String vcSettleSpeed = entityData.getString("vcSettleSpeed");//清算速度
			String localAvailable = ParamConfig.getValue("ZHFWPT_LOCAL_AVAILABLE");
			DecimalFormat format = new DecimalFormat("###,##0.##");
			String vcInstructType =  entityData.getString("vcInstructType");  // 指令类型：1-完整指令，2-询价指令，3-投资经理风控试算
			
			LogUtil.logInfo("=========可用数据做比较开始==========",null);
			LogUtil.logInfo("C_LOCAL_AVAILABLE:"+sumList[0].getString("C_LOCAL_AVAILABLE")+"|VC_O32_AVAILABLEAMOUNT_T0:"+sumList[0].getDouble("VC_O32_AVAILABLEAMOUNT_T0")+
					"|VC_O32_AVAILABLEAMOUNT_T1:"+sumList[0].getDouble("VC_O32_AVAILABLEAMOUNT_T1")+"|VC_AVAILABLEAMOUNT_T0:"+sumList[0].getDouble("VC_AVAILABLEAMOUNT_T0")+
					"|VC_AVAILABLEAMOUNT_T1:"+sumList[0].getDouble("VC_AVAILABLEAMOUNT_T1")+"|VC_TASSET:"+sumList[0].getString("VC_TASSET")+"|VC_ACCOUNT :"+sumList[0].getString("VC_ACCOUNT ")+
					"|VC_CURRENTAMOUNT:"+sumList[0].getString("VC_CURRENTAMOUNT"),null);
			LogUtil.logInfo("是否为修改指令operatorType:"+operatorType,null);
			LogUtil.logInfo("委托方向vcEntrustDirection:"+vcEntrustDirection,null);
			LogUtil.logInfo("指令类型：1-完整指令，2-询价指令vcInstructType:"+vcInstructType,null);
			
			if(vcEntrustDirection.equals("3")){//买入校验可用金额
				String vcAvailableamountT0="0";
				String vcAvailableamountT1="0";
				if(sumList.length>0){
					vcAvailableamountT0 = sumList[0].getString("VC_AVAILABLEAMOUNT_T0");//t+0可用金额
					vcAvailableamountT1 = sumList[0].getString("VC_AVAILABLEAMOUNT_T1");//t+1可用金额
					LogUtil.logInfo("t+0可用金额："+vcAvailableamountT0,null);
					LogUtil.logInfo("t+1可用金额："+vcAvailableamountT1,null);
					//当不启用本地可用计算时：可用金额直接获取O32返回的值进行判断
					if("0".equals(localAvailable)){
						vcAvailableamountT0 = sumList[0].getString("VC_O32_AVAILABLEAMOUNT_T0");//t+0可用金额
						vcAvailableamountT1 = sumList[0].getString("VC_O32_AVAILABLEAMOUNT_T1");//t+0可用金额
						LogUtil.logInfo("O32t+0可用金额："+vcAvailableamountT0,null);
						LogUtil.logInfo("O32t+1可用金额："+vcAvailableamountT1,null);
					}
				}else{
					LogUtil.logInfo("头寸查询异常",null);
					LogUtil.logInfo("=========可用数据做比较结束==========",null);
				}
				double availableamountT0 = Double.parseDouble(vcAvailableamountT0);
				double availableamountT1 = Double.parseDouble(vcAvailableamountT1);
				if(operatorType != null && ((operatorType.equals("1") && "1".equals(oldEntityData.getString("cIsValid")))||(operatorType.equals("2") && "5".equals(oldEntityData.getString("cIsValid"))))){
					double formerAvailableamount = 0;
					if("0".equals(localAvailable)){
						if("4".equals(oldEntityData.getString("vcProcessStatus")) || "5".equals(oldEntityData.getString("vcProcessStatus")) || "6".equals(oldEntityData.getString("vcProcessStatus")) || "7".equals(oldEntityData.getString("vcProcessStatus"))){
							if(vcEntrustDirection.equals(oldEntityData.getString("vcEntrustDirection"))){
								formerAvailableamount = (oldEntityData.getDouble("enFaceAmount"))*(oldEntityData.getDouble("enFullPrice"))*100;
								//String tradeQty = entityData.getString("tradeQty");//修改指令的买入需另外加上的原指令可用金额
								//if(tradeQty!= null && !tradeQty.isEmpty()){
									//formerAvailableamount = Double.parseDouble(tradeQty);
								//}
							}
						}else{
							DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
							data.set("lResultNo", oldEntityData.getLong("lResultNo"));
							data.set("vcEntrustDirection", vcEntrustDirection);
							Object[] updateApprove = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.getUpdateSell",data); 
							if(updateApprove.length==1){
								DataObject mapAvail = (DataObject)updateApprove[0];
								if(entityData.getString("vcAssetCode").equals(mapAvail.getString("VC_ASSET_CODE"))){
									formerAvailableamount = (mapAvail.getDouble("EN_FACE_AMOUNT"))*(mapAvail.getDouble("EN_FULL_PRICE"))*100;
								}
							}
						}
					}else{
						String tradeQty = entityData.getString("tradeQty");//修改指令的买入需另外加上的原指令可用金额
						if(tradeQty!= null && !tradeQty.isEmpty()){
							formerAvailableamount = Double.parseDouble(tradeQty);
						}
					}
					availableamountT0 += formerAvailableamount;
					availableamountT1 += formerAvailableamount;
					LogUtil.logInfo("买入校验可用金额=可用金额+原指令可用金额",null);
					LogUtil.logInfo(availableamountT1+"="+(availableamountT1-formerAvailableamount)+"+"+formerAvailableamount,null);
				}
				//根据指令产品获取该指令透支情况
				String cOverdraft = "2";//可用金额是否允许透支 1:允许 2:不允许
				Object[] overdraft = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),
						"com.cjhxfund.commonUtil.productConf.whetherAllowOverdraft",entityData);
				if(overdraft[0]!=null){
					if("1".equals(overdraft[0])){
						cOverdraft = "1";
					}
				}
				
				//判断是否触发头寸不足判断
				if(vcSettleSpeed.equals("0")){
					String market = "银行间";
					if((entityData.getString("vcMarket")).equals("1")){
						market="上交所";
					}else if((entityData.getString("vcMarket")).equals("2")){
						market="深交所";
					}
					LogUtil.logInfo("买入T+0头寸信息：组合编号[{0}]债券代码[{1}]T+0可用金额[{2}] 指令金额[{3}] 是否可透支[{4}]", null, entityData.getString("vcCombiCode"),
							entityData.getString("vcStockCode"),format.format(availableamountT0),format.format(faceAmount*100*fullPrice),cOverdraft.equals("2")?"不允许透支":"允许透支");
					if((entityData.getString("vcMarket")).equals("5")){//银行间的买入需校验是否允许透支
						if(cOverdraft.equals("2")){//1:允许 2:不允许透支
							if(faceAmount*100*fullPrice > availableamountT0){
								if(sumList.length>0){
									mark = "1";
									// 组合编号[60]市场[银行间]T+0可用金额不足【可用金额：-1，指令金额：52,000】
									entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
										+"]市场["+market
										+"]T+0可用金额不足[可用金额:"+format.format(availableamountT0)+" 指令金额:"+format.format(faceAmount*100*fullPrice)+"].");
								}else{
									entityData.setString("rtnMsg","头寸校验失败");
								}
							}
						}
					}else{//非银行间
						if(faceAmount*100*fullPrice > availableamountT0){
							mark = "1";
							if(sumList.length>0){
								// 组合编号[60]市场[银行间]T+0可用金额不足【可用金额：-1，指令金额：52,000】
								entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
									+"]市场["+market
									+"]T+0可用金额不足[可用金额:"+format.format(availableamountT0)+" 指令金额:"+format.format(faceAmount*100*fullPrice)+"].");
							}else{
								entityData.setString("rtnMsg","头寸校验失败");
							}
						}
					}
				}else{
					String market = "银行间";
					if((entityData.getString("vcMarket")).equals("1")){
						market="上交所";
					}else if((entityData.getString("vcMarket")).equals("2")){
						market="深交所";
					}
					LogUtil.logInfo("买入T+1头寸信息：组合编号[{0}]债券代码[{1}]T+0可用金额[{2}] 指令金额[{3}] 是否可透支[{4}]", null, entityData.getString("vcCombiCode"),
							entityData.getString("vcStockCode"),format.format(availableamountT1),format.format(faceAmount*100*fullPrice),cOverdraft.equals("2")?"不允许透支":"允许透支");
					if((entityData.getString("vcMarket")).equals("5")){//银行间的买入需校验是否允许透支
						if(cOverdraft.equals("2")){
							if(faceAmount*100*fullPrice > availableamountT1){
								mark = "1";
								if(sumList.length>0){
									
									// 组合编号[60]市场[银行间]T+0可用金额不足【可用金额：-1，指令金额：52,000】
									entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
											+"]市场["+market
											+"]T+1可用金额不足[可用金额:"+format.format(availableamountT1)+" 指令金额:"+format.format(faceAmount*100*fullPrice)+"].");
								}else{
									entityData.setString("rtnMsg","头寸校验失败");
								}
							}
						}
					}else{
						if(faceAmount*100*fullPrice > availableamountT1){
							mark = "1";
							if(sumList.length>0){
								// 组合编号[60]市场[银行间]T+0可用金额不足【可用金额：-1，指令金额：52,000】
								entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
									+"]市场["+market
									+"]T+1可用金额不足[可用金额:"+format.format(availableamountT1)+" 指令金额:"+format.format(faceAmount*100*fullPrice)+"].");
							}else{
								entityData.setString("rtnMsg","头寸校验失败");
							}
							
						}
					}
					
				}
			}else{//卖出校验可用数量
				Integer availablequantityT0=0;
				Integer availablequantityT1=0;
				if(sumList.length>0){
					if("2".equals(vcInstructType)){
						availablequantityT0 = sumList[0].getInt("VC_AVAILABLEQUANTITY_INQUIRY_T0");//询价t+0可用数量
						availablequantityT1 = sumList[0].getInt("VC_AVAILABLEQUANTITY_INQUIRY_T1");//询价t+1可用数量
						LogUtil.logInfo("询价t+0可用数量："+availablequantityT0,null);
						LogUtil.logInfo("询价t+1可用数量："+availablequantityT1,null);
					}else if("3".equals(vcInstructType)){
						availablequantityT0 = sumList[0].getInt("VC_O32_AVAILABLEQUANTITY_T0");//t+0可用数量
						availablequantityT1 = sumList[0].getInt("VC_O32_AVAILABLEQUANTITY_T1");//t+1可用数量
						LogUtil.logInfo("t+0可用数量："+availablequantityT0,null);
						LogUtil.logInfo("t+1可用数量："+availablequantityT1,null);
					}else{
						availablequantityT0 = sumList[0].getInt("VC_AVAILABLEQUANTITY_T0");//t+0可用数量
						availablequantityT1 = sumList[0].getInt("VC_AVAILABLEQUANTITY_T1");//t+1可用数量
						LogUtil.logInfo("t+0可用数量："+availablequantityT0,null);
						LogUtil.logInfo("t+1可用数量："+availablequantityT1,null);
						if("0".equals(localAvailable)){//不启用本地可用计算
							availablequantityT0 = sumList[0].getInt("VC_O32_AVAILABLEQUANTITY_T0");//t+0可用数量
							availablequantityT1 = sumList[0].getInt("VC_O32_AVAILABLEQUANTITY_T1");//t+1可用数量
							LogUtil.logInfo("O32 t+0可用数量："+availablequantityT0,null);
							LogUtil.logInfo("O32 t+1可用数量："+availablequantityT1,null);
						}
					}
				}else{
					LogUtil.logInfo("可用查询异常",null);
				}
				if(operatorType != null && ((operatorType.equals("1") && "1".equals(oldEntityData.getString("cIsValid")))||(operatorType.equals("2") && "5".equals(oldEntityData.getString("cIsValid"))))){
					Object tradeQty = 0;
					if("4".equals(oldEntityData.getString("vcProcessStatus")) || "5".equals(oldEntityData.getString("vcProcessStatus")) || "6".equals(oldEntityData.getString("vcProcessStatus")) || "7".equals(oldEntityData.getString("vcProcessStatus"))){
						if(vcEntrustDirection.equals(oldEntityData.getString("vcEntrustDirection"))){
							tradeQty = (new Double((oldEntityData.getDouble("enFaceAmount"))*100)).intValue();//修改指令的买入需另外加上的原指令可用数量
						}
					}else{
						if("0".equals(localAvailable)){
							DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
							data.set("lResultNo", oldEntityData.getLong("lResultNo"));
							data.set("vcEntrustDirection", vcEntrustDirection);
							Object[] updateApprove = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.getUpdateSell",data); 
							if(updateApprove.length==1){
								DataObject mapAvail = (DataObject)updateApprove[0];
								tradeQty = (new Double((mapAvail.getDouble("EN_FACE_AMOUNT"))*100)).intValue();
							}
						}else{
							tradeQty = entityData.getInt("tradeQty");//修改指令的买入需另外加上的原指令可用数量
							if(oldEntityData.getInt("lTradeDate") != oldEntityData.getInt("lResultDate") && 
									("1".equals(oldEntityData.getString("vcProcessStatus")) || "2".equals(oldEntityData.getString("vcProcessStatus")) 
											|| "2A".equals(oldEntityData.getString("vcProcessStatus")) || "3".equals(oldEntityData.getString("vcProcessStatus")))){
								DataObject paramObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
								paramObject.setLong("lResultId", oldEntityData.getLong("lResultId"));
								paramObject.setString("vcCombiCode", oldEntityData.getString("vcCombiCode"));
								paramObject.setString("vcStockCode", oldEntityData.getString("vcStockCode"));
								paramObject.setString("vcMarket", oldEntityData.getString("vcMarket"));
								paramObject.setString("lockSource", "3");
								Object[] lockQtyObj = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.ats.sm.comm.bondManage.getInstructOneBondLock", paramObject);
								if(lockQtyObj != null && lockQtyObj.length>0){
									tradeQty=  lockQtyObj[0];
								}else{
									tradeQty= 0;
								}
							}
						}
					}
					Integer formerAvailableamount = (Integer) tradeQty;
					availablequantityT0 += formerAvailableamount;
					availablequantityT1 += formerAvailableamount;
					LogUtil.logInfo("卖出校验可用数量=可用数量+原指令可用数量",null);
					LogUtil.logInfo(availablequantityT1+"="+(availablequantityT1-formerAvailableamount)+"+"+formerAvailableamount,null);
				}
				if(vcSettleSpeed.equals("0")){
					LogUtil.logInfo("卖出T+0可用信息：组合编号[{0}]债券代码[{1}]T+0可用数量[{2}] 指令数量[{3}]", null, entityData.getString("vcCombiCode"),
							entityData.getString("vcStockCode"),format.format(availablequantityT0),format.format(faceAmount*100));
					if(faceAmount*100 > availablequantityT0){
						mark = "1";
						if(sumList.length>0){
							//组合序号[77]证券[101351007]T+0可用数量不足[可用数量:0.00 指令数量:5000.00].
							entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
								+"]证券["+entityData.getString("vcStockCode")+"-"+entityData.getString("vcStockName")
								+"]</br>T+0可用数量不足[可用数量:"+format.format(availablequantityT0)+" 指令数量:"+format.format(faceAmount*100)+"].");
						}else{
							entityData.setString("rtnMsg","可用校验失败");
						}
					}
				}else{
					LogUtil.logInfo("卖出T+1可用信息：组合编号[{0}]债券代码[{1}]T+0可用数量[{2}] 指令数量[{3}]", null, entityData.getString("vcCombiCode"),
							entityData.getString("vcStockCode"),format.format(availablequantityT1),format.format(faceAmount*100));
					if(faceAmount*100 > availablequantityT1){
						mark = "1";
						if(sumList.length>0){
							//组合序号[77]证券[101351007]T+0可用数量不足[可用数量:0.00 指令数量:5000.00].
							entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
								+"]证券["+entityData.getString("vcStockCode")+"-"+entityData.getString("vcStockName")
								+"]</br>T+1可用数量不足[可用数量:"+format.format(availablequantityT1)+" 指令数量:"+format.format(faceAmount*100)+"].");
						}else{
							entityData.setString("rtnMsg","可用校验失败");
						}
					}
				}
			}
			LogUtil.logInfo("=========可用数据做比较结束==========",null);
			entityData.setString("mark", mark);
			return entityData;
		}
		
		@Bizlet("可用数据做比较(回购)")
		public DataObject availableDataCompareRep(DataObject[] sumList,DataObject entityData,DataObject [] bonds,DataObject oldEntityData){
			String mark = "0";
			String operatorType = entityData.getString("operatorType");//判断是否为修改指令
			String vcEntrustDirection = entityData.getString("vcEntrustDirection");//委托方向
			double faceAmount = entityData.getDouble("enFaceAmount")*10000;//券面金额
			DecimalFormat format = new DecimalFormat("###,##0.##");
			String vcInstructType =  entityData.getString("vcInstructType");  // 指令类型：1-完整指令，2-询价指令
			if("6".equals(entityData.getString("vcBizType"))){
				faceAmount = entityData.getDouble("enFullPriceAmount");//券面金额
			}
			String vcSettleSpeed = entityData.getString("vcSettleSpeed");//清算速度
			String localAvailable = ParamConfig.getValue("ZHFWPT_LOCAL_AVAILABLE");
			
			LogUtil.logInfo("=========可用数据做比较开始==========",null);
			LogUtil.logInfo("C_LOCAL_AVAILABLE:"+sumList[0].getString("C_LOCAL_AVAILABLE")+"|VC_O32_AVAILABLEAMOUNT_T0:"+sumList[0].getDouble("VC_O32_AVAILABLEAMOUNT_T0")+
					"|VC_O32_AVAILABLEAMOUNT_T1:"+sumList[0].getDouble("VC_O32_AVAILABLEAMOUNT_T1")+"|VC_AVAILABLEAMOUNT_T0:"+sumList[0].getDouble("VC_AVAILABLEAMOUNT_T0")+
					"|VC_AVAILABLEAMOUNT_T1:"+sumList[0].getDouble("VC_AVAILABLEAMOUNT_T1")+"|VC_TASSET:"+sumList[0].getString("VC_TASSET")+"|VC_ACCOUNT :"+sumList[0].getString("VC_ACCOUNT ")+
					"|VC_CURRENTAMOUNT:"+sumList[0].getString("VC_CURRENTAMOUNT"),null);
			LogUtil.logInfo("是否为修改指令operatorType:"+operatorType,null);
			LogUtil.logInfo("委托方向vcEntrustDirection:"+vcEntrustDirection,null);
			LogUtil.logInfo("指令类型：1-完整指令，2-询价指令vcInstructType:"+vcInstructType,null);
			
			//银行间逆回购、协议式逆回购、协议式正回购到期
			if(vcEntrustDirection.equals("6") || vcEntrustDirection.equals("16") || vcEntrustDirection.equals("17")){//逆回购校验可用金额
				LogUtil.logInfo("银行间逆回购、协议式逆回购、协议式正回购到期vcEntrustDirection:"+vcEntrustDirection,null);
				//根据指令产品获取该指令透支情况
				String cOverdraft = "2";//可用金额是否允许透支 1:允许 2:不允许
				Object[] overdraft = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),
						"com.cjhxfund.commonUtil.productConf.whetherAllowOverdraft",entityData);
				if(overdraft[0]!=null){
					if("1".equals(overdraft[0])){
						cOverdraft = "1";
					}
				}
				LogUtil.logInfo("可用金额是否允许透支 1:允许 2:不允许===="+cOverdraft,null);
				
				double availableamountT0 = 0;
				double availableamountT1 = 0;
				if(sumList.length>0){
					availableamountT0 = sumList[0].getDouble("VC_AVAILABLEAMOUNT_T0");//t+0可用金额
					availableamountT1 = sumList[0].getDouble("VC_AVAILABLEAMOUNT_T1");//t+1可用金额
					LogUtil.logInfo("t+0可用金额："+availableamountT0,null);
					LogUtil.logInfo("t+1可用金额："+availableamountT1,null);
					if("0".equals(localAvailable)){//不启用本地可用计算
						availableamountT0 = sumList[0].getDouble("VC_O32_AVAILABLEAMOUNT_T0");//t+0可用金额
						availableamountT1 = sumList[0].getDouble("VC_O32_AVAILABLEAMOUNT_T1");//t+1可用金额
						LogUtil.logInfo("O32 t+0可用金额："+availableamountT0,null);
						LogUtil.logInfo("O32 t+1可用金额："+availableamountT1,null);
					}
				}else{
					LogUtil.logInfo("头寸查询异常",null);
					LogUtil.logInfo("=========可用数据做比较结束==========",null);
				}
				//当指令为修改指令，原指令为有效且修改后指令产品，委托方向未变动(原指令委托方向也为逆回购)时可用金额需加上原指令消耗的金额
				if(operatorType != null && ((operatorType.equals("1") && "1".equals(oldEntityData.getString("cIsValid")))||(operatorType.equals("2") && "5".equals(oldEntityData.getString("cIsValid"))))){
					double formerAvailableamount = 0;
					if("4".equals(oldEntityData.getString("vcProcessStatus")) || "5".equals(oldEntityData.getString("vcProcessStatus")) || "6".equals(oldEntityData.getString("vcProcessStatus")) || "7".equals(oldEntityData.getString("vcProcessStatus"))){
						if(entityData.getString("vcAssetCode").equals(oldEntityData.getString("vcAssetCode")) && vcEntrustDirection.equals(oldEntityData.getString("vcEntrustDirection"))){
							if("6".equals(entityData.getString("vcBizType"))){
								//formerAvailableamount = entityData.getDouble("tradeQty");
								formerAvailableamount = oldEntityData.getDouble("enFullPriceAmount");
							}else{
								//formerAvailableamount = (entityData.getDouble("tradeQty"))*10000;
								formerAvailableamount = (oldEntityData.getDouble("enFaceAmount"))*10000;
							}
						}
					}else{
						if("0".equals(localAvailable)){//不启用本地可用计算，只回填当前相同业务编号同委托方向且下到O32修改审核中的记录金额
							DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
							data.set("lResultNo", oldEntityData.getLong("lResultNo"));
							data.set("vcEntrustDirection", vcEntrustDirection);
							Object[] updateApprove = DatabaseExt.queryByNamedSql("default",
									"com.cjhxfund.commonUtil.availableManage.getUpdateSell",data); 
							if(updateApprove.length==1){
								DataObject mapAvail = (DataObject)updateApprove[0];
								if(entityData.getString("vcAssetCode").equals(mapAvail.getString("VC_ASSET_CODE"))){
									if("6".equals(entityData.getString("vcBizType"))){
										formerAvailableamount = mapAvail.getDouble("EN_FULL_PRICE_AMOUNT");
									}else{
										formerAvailableamount = (mapAvail.getDouble("EN_FACE_AMOUNT"))*10000;
									}
								}
							}
						}else{
							if(entityData.getString("vcAssetCode").equals(oldEntityData.getString("vcAssetCode")) && vcEntrustDirection.equals(oldEntityData.getString("vcEntrustDirection"))){
								SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd"); 
								String nextTrade = sf.format(new Date().getTime()) ;
								//获取系统下一交易日期
								Object[] o32NextTradeDate = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),
										"com.cjhxfund.commonUtil.dateUtil.getNextTradeDay",null);
								if(o32NextTradeDate[0]!=null){
									nextTrade = (String) o32NextTradeDate[0];
								}
								Date nowDate = new Date();
	//									Calendar calendar = new GregorianCalendar(); 
	//								    calendar.setTime(nowDate); 
	//								    calendar.add(Calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
	//								    Date nextDate = calendar.getTime();   //这个时间就是日期往后推一天的结果 
								//由于前面的可用金额中只是减去了交易日期为当天或者交易日为明天的t+0的金额,所有只有原指令是此中数据才会加回
							    if(sf.format(nowDate).equals(oldEntityData.getString("lTradeDate")) || (nextTrade.equals(oldEntityData.getString("lTradeDate")) && "0".equals(oldEntityData.getString("vcSettleSpeed")))){
							    	if("6".equals(entityData.getString("vcBizType"))){
										formerAvailableamount = entityData.getDouble("tradeQty");
									}else{
										formerAvailableamount = (entityData.getDouble("tradeQty"))*10000;
									}
							    	LogUtil.logInfo(sf.format(nowDate)+"======================="+nextTrade,null);
							    }
							}
						}
					}
					availableamountT0 += formerAvailableamount;
					availableamountT1 += formerAvailableamount;
					LogUtil.logInfo("可用金额=可用金额+原指令消耗的金额",null);
					LogUtil.logInfo(availableamountT1+"="+(availableamountT0-formerAvailableamount)+"+"+formerAvailableamount,null);
				}
				if(vcSettleSpeed.equals("0")){
					String market = "银行间";
					if((entityData.getString("vcMarket")).equals("1")){
						market="上交所";
					}else if((entityData.getString("vcMarket")).equals("2")){
						market="深交所";
					}
					LogUtil.logInfo("买入T+0头寸信息：组合编号[{0}]T+0可用金额[{1}] 指令金额[{2}] 是否可透支[{3}]", null, entityData.getString("vcCombiCode"),
							format.format(availableamountT0),format.format(faceAmount),cOverdraft.equals("2")?"不允许透支":"允许透支");
					if((entityData.getString("vcMarket")).equals("5")){//银行间的买入需校验是否允许透支
						if(cOverdraft == null || cOverdraft.equals("2")){//1:允许 2:不允许透支
							if(faceAmount > availableamountT0){
								mark = "1";
								if(sumList.length>0){
									entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
										+"]市场["+market
										+"]T+0可用金额不足[可用金额:"+format.format(availableamountT0)+" 指令金额:"+format.format(faceAmount)+"].");
								}else{
									entityData.setString("rtnMsg","头寸校验失败");
								}
								
							}
						}
					}else{//非银行间
						if(faceAmount > availableamountT0){
							mark = "1";
							if(sumList.length>0){
								entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
									+"]市场["+market
									+"]T+0可用金额不足[可用金额:"+format.format(availableamountT0)+" 指令金额:"+format.format(faceAmount)+"].");
							}else{
								entityData.setString("rtnMsg","头寸校验失败");
							}
						}
					}
				}else{
					String market = "银行间";
					if((entityData.getString("vcMarket")).equals("1")){
						market="上交所";
					}else if((entityData.getString("vcMarket")).equals("2")){
						market="深交所";
					}
					LogUtil.logInfo("买入T+1头寸信息：组合编号[{0}]T+1可用金额[{1}] 指令金额[{2}] 是否可透支[{3}]", null, entityData.getString("vcCombiCode"),
							format.format(availableamountT1),format.format(faceAmount),cOverdraft.equals("2")?"不允许透支":"允许透支");
					if((entityData.getString("vcMarket")).equals("5")){//银行间的买入需校验是否允许透支
						if(cOverdraft.equals("2")){
							if(faceAmount > availableamountT1){
								mark = "1";
								if(sumList.length>0){
									entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
										+"]市场["+market
										+"]T+1可用金额不足[可用金额:"+format.format(availableamountT1)+" 指令金额:"+format.format(faceAmount)+"].");
								}else{
									entityData.setString("rtnMsg","头寸校验失败");
								}
								
							}
						}
					}else{
						if(faceAmount > availableamountT1){
							mark = "1";
							if(sumList.length>0){
								entityData.setString("rtnMsg", "产品["+entityData.getString("vcProductName")+"]组合["+entityData.getString("vcCombiName")
									+"]市场["+market
									+"]T+1可用金额不足[可用金额:"+format.format(availableamountT1)+" 指令金额:"+format.format(faceAmount)+"].");
							}else{
								entityData.setString("rtnMsg","头寸校验失败");
							}
						}
					}
				}
			}else{//正回购校验可用数量
				for(int k = 0;k<bonds.length;k++){
					DataObject temp = bonds[k];
					Long availablequantityT0 = (long) 0;//t+0可用数量
					Long availablequantityT1 = (long) 0;//t+1可用数量
					for(int j = 0;j<sumList.length;j++){
						String vcExdestination = sumList[j].getString("VC_EXDESTINATION");
						if(sumList[j].getString("VC_ACCOUNT").equals(temp.get("vcCombiCode").toString()) && 
								sumList[j].getString("VC_SYMBOL").equals(temp.get("vcReportCode").toString()) &&
								vcExdestination.equals(temp.get("vcExchange").toString())){
							if("2".equals(vcInstructType)){
								availablequantityT0 = sumList[j].getLong("VC_AVAILABLEQUANTITY_INQUIRY_T0");//询价t+0可用数量
								availablequantityT1 = sumList[j].getLong("VC_AVAILABLEQUANTITY_INQUIRY_T1");//询价t+1可用数量
								LogUtil.logInfo("询价t+0可用数量："+availablequantityT0,null);
								LogUtil.logInfo("询价t+1可用数量："+availablequantityT1,null);
							}else if("3".equals(vcInstructType)){
								availablequantityT0 = sumList[j].getLong("VC_O32_AVAILABLEQUANTITY_T0");//t+0可用数量
								availablequantityT1 = sumList[j].getLong("VC_O32_AVAILABLEQUANTITY_T1");//t+1可用数量
								LogUtil.logInfo("t+0可用数量："+availablequantityT0,null);
								LogUtil.logInfo("t+1可用数量："+availablequantityT1,null);
							}else{
								availablequantityT0 = sumList[j].getLong("VC_AVAILABLEQUANTITY_T0");//t+0可用数量
								availablequantityT1 = sumList[j].getLong("VC_AVAILABLEQUANTITY_T1");//t+1可用数量
								LogUtil.logInfo("t+0可用数量："+availablequantityT0,null);
								LogUtil.logInfo("t+1可用数量："+availablequantityT1,null);
								if("0".equals(localAvailable)){//不启用本地可用计算
									availablequantityT0 = sumList[j].getLong("VC_O32_AVAILABLEQUANTITY_T0");//t+0可用数量
									availablequantityT1 = sumList[j].getLong("VC_O32_AVAILABLEQUANTITY_T1");//t+1可用数量
									LogUtil.logInfo("O32 t+0可用数量："+availablequantityT0,null);
									LogUtil.logInfo("O32 t+1可用数量："+availablequantityT1,null);
								}
							}
						}
					}
					if(availablequantityT0 != null){
						if(operatorType != null && ((operatorType.equals("1") && "1".equals(oldEntityData.getString("cIsValid")))||(operatorType.equals("2") && "5".equals(oldEntityData.getString("cIsValid"))))){
							Integer tradeQty =  0;//修改指令的买入需另外加上的原指令可用数量
							Object[] oldBonds = (Object[]) oldEntityData.get("bonds");
							if("4".equals(oldEntityData.getString("vcProcessStatus")) || "5".equals(oldEntityData.getString("vcProcessStatus")) || "6".equals(oldEntityData.getString("vcProcessStatus")) || "7".equals(oldEntityData.getString("vcProcessStatus"))){//原指令下到O32时都需要回填可用数量，再计算控制当前指令可用数量
								for(int i=0; i<oldBonds.length; i++){
									if(operatorType.equals("2")){
										DataObject bondData= (DataObject)oldBonds[i];
										if(temp.getString("vcCombiCode").equals(bondData.get("vcCombiCode").toString()) && 
												temp.getString("vcReportCode").equals(bondData.get("vcReportCode").toString()) &&
												temp.getString("vcExchange").equals(bondData.get("vcExchange").toString())){
											tradeQty = Integer.parseInt(bondData.get("enFaceAmount").toString())*100;
										}
									}else{
										Map<?, ?> bond = (Map<?, ?>)oldBonds[i];
										if(temp.getString("vcCombiCode").equals(bond.get("vcCombiCode").toString()) && 
												temp.getString("vcReportCode").equals(bond.get("vcReportCode").toString()) &&
												temp.getString("vcExchange").equals(bond.get("vcExchange").toString())){
											tradeQty = Integer.parseInt(bond.get("enFaceAmount").toString())*100;
										}
									}
								}
							}else{//原指令未下到O32
								if("0".equals(localAvailable)){//不启用本地可用计算
									//当同一投资编号业务之前的指令已下单到O32且状态为修改审核中状态，修改指令需要回填此审核中的可用数量
									DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
									data.set("lResultNo", oldEntityData.getLong("lResultNo"));
									data.set("vcEntrustDirection", vcEntrustDirection);
									data.set("vcCombiCode", temp.get("vcCombiCode").toString());
									data.set("vcStockCode", temp.get("vcReportCode").toString());
									data.set("vcExchange", temp.getString("vcExchange"));
									Object[] approveBonds = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.commonUtil.availableManage.getUpdateSellQty", data);
									if(approveBonds.length==1){
										DataObject mapAvail = (DataObject)approveBonds[0];
										tradeQty = Integer.parseInt(mapAvail.get("EN_FACE_AMOUNT").toString())*100;
									}
								}else{
									if(vcEntrustDirection.equals(oldEntityData.getString("vcEntrustDirection"))){
										for(int i=0; i<oldBonds.length; i++){
											Map<?, ?> bond = (Map<?, ?>)oldBonds[i];
											if(temp.getString("vcCombiCode").equals(bond.get("vcCombiCode").toString()) && 
													temp.getString("vcReportCode").equals(bond.get("vcReportCode").toString()) &&
													temp.getString("vcExchange").equals(bond.get("vcExchange").toString())){
												tradeQty = Integer.parseInt(bond.get("enFaceAmount").toString())*100;
												if(oldEntityData.getInt("lTradeDate") != oldEntityData.getInt("lResultDate")){//原指令为预置指令回填锁定券中锁定数量
													DataObject paramObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
													paramObject.setLong("lResultId", oldEntityData.getLong("lResultId"));
													paramObject.setString("vcCombiCode", bond.get("vcCombiCode").toString());
													paramObject.setString("vcStockCode", bond.get("vcReportCode").toString());
													paramObject.setString("vcMarket", bond.get("vcExchange").toString());
													paramObject.setString("lockSource", "3");
													Object[] lockQtyObj = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.ats.sm.comm.bondManage.getInstructOneBondLock", paramObject);
													if(lockQtyObj != null && lockQtyObj.length>0){
														tradeQty=(Integer) lockQtyObj[0];
													}
												}
											}
										}
									}
								}
							}
							availablequantityT0 += tradeQty;
							availablequantityT1 += tradeQty;
							LogUtil.logInfo("正回购校验可用数量=可用数量+原指令可用数量",null);
							LogUtil.logInfo(availablequantityT1+"="+(availablequantityT1-tradeQty)+"+"+tradeQty,null);
						}
						if(vcSettleSpeed.equals("0")){
							LogUtil.logInfo("正回购T+0可用数量：组合编号[{0}]证券[{1}]T+0可用信息[可用数量:{2} 指令数量{3}]。", null, temp.getString("vcCombiCode"), temp.get("vcStockCode"),
									format.format(availablequantityT0),format.format(Long.parseLong(temp.getString("enFaceAmount"))*100));
							if(Long.parseLong(temp.getString("enFaceAmount"))*100 > availablequantityT0){
								mark = "1";
								if(sumList.length>0){
									entityData.setString("rtnMsg", "产品["+temp.getString("vcProductName")+"]组合["+temp.getString("vcCombiName")
										+"]证券["+temp.getString("vcStockCode")+"-"+temp.get("vcStockName")
										+"]</br>T+0可用数量不足[可用数量:"+format.format(availablequantityT0)+" 指令数量:"+format.format(Long.parseLong(temp.getString("enFaceAmount"))*100)+"].");
								}else{
									entityData.setString("rtnMsg","可用校验失败");
								}
								break;
							}
						}else{
							LogUtil.logInfo("正回购T+1可用不足：组合编号[{0}]证券[{1}]T+1可用信息[可用数量:{2} 指令数量{3}]。", null, entityData.getString("vcCombiCode"), temp.get("vcStockCode"),
									format.format(availablequantityT1),format.format(Long.parseLong(temp.getString("enFaceAmount"))*100));
							if(Long.parseLong(temp.getString("enFaceAmount"))*100 > availablequantityT1){
								mark = "1";
								if(sumList.length>0){
									entityData.setString("rtnMsg", "产品["+temp.getString("vcProductName")+"]组合["+temp.getString("vcCombiName")
										+"]证券["+temp.getString("vcStockCode")+"-"+temp.get("vcStockName")
										+"]</br>T+0可用数量不足[可用数量:"+format.format(availablequantityT1)+" 指令数量:"+format.format(Long.parseLong(temp.getString("enFaceAmount"))*100)+"].");
								}else{
									entityData.setString("rtnMsg","可用校验失败");
								}
								break;
							}
						}
					}
				}
			}
			LogUtil.logInfo("=========可用数据做比较结束==========",null);
			entityData.setString("mark", mark);
			return entityData;
		}
		
		
		@SuppressWarnings({ "unchecked", "unused" })
		@Bizlet("可用数量不足邮件提醒")
		public void sendEmailForAvailQty(){
			//跨域查询数据源
			String dataSource= CacheUtil.getO32CacheDataSourceName();
			try{
				//创建接收可用数量查询的对象
				DataObject db = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				DataObject sendMsg = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				//得到明天到期的债券重复组数据列表，需要用来和fix返回的可用数量进行对比
				Object[] combis = DatabaseExt.queryByNamedSql("default",
						"com.cjhxfund.ats.sm.comm.availableManage.queryAvailQtyCombis",dataSource);
				//调用可用数量查询逻辑流
//				Object[] obb = new Object[]{db};
//				String componentNameE = "com.cjhxfund.ats.sm.comm.MailManager";
//	        	ILogicComponent logicComponentE = LogicComponentFactory.create(componentNameE);
//				Object[] combis = logicComponentE.invoke("queryExpiredBonds",obb);
				//定义自增变量，用于接收存放可用数量不足的原始数据赋值下标
				int k=0;
				//新定义数组，用于存放可用数量不足的原始数据
				Object[] retInfo = new Object[combis.length];
				//得到需要发送邮件的组合代码数组，循环发送邮件的时候需要用到当工具数组使用
				Object[] combiCodes = DatabaseExt.queryByNamedSql("default",
						"com.cjhxfund.ats.sm.comm.availableManage.queryAvailQtyCombiCodes",dataSource);
				//查询交易部所有人员ID和邮箱地址信息
				Object[] traders = DatabaseExt.queryByNamedSql("default",
						"com.cjhxfund.ats.sm.comm.availableManage.queryTradersEmail",null);
				/***主要业务逻辑处理：查询回来可用数量跟表里面的可用数量对比，提取数量不足的信息，进行邮件发送***/
				if(combis!=null && combis.length>0){
					db.set("sendMsg", sendMsg);
					db.set("combis", combis);
					log.info("成功组装可用数量查询条件...");
					//调用可用数量查询逻辑流
					Object[] ob = new Object[]{db};
	    			String componentName = "com.cjhxfund.commonUtil.AvaiableDataManager";
	            	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					Object[] result = logicComponent.invoke("queryAvailQty",ob);
					//接收可用数量返回的对象定义
					List<DataObject> returnQty = new ArrayList<DataObject>();
					returnQty.addAll((Collection<? extends DataObject>) result[0]);
					//组装数据和邮件发送逻辑编写
					if(returnQty!=null && !returnQty.isEmpty() && returnQty.size()>0){
						log.info("可用数量信息成功返回...");
						//将list的顺序倒序排列
//						Collections.reverse(returnQty);
						for(int h=0;h<returnQty.size();h++){
							@SuppressWarnings("rawtypes")
							Map combi = (Map)combis[h];
							//判断可用数量是否足够，不足够的数据将和原始数据重组(将可用数量字段添加到原始数据中)
							int flag = Integer.parseInt(returnQty.get(h).get("VC_AVAILABLEQUANTITY_T1").toString())-Integer.parseInt(combi.get("vcMortagageQty").toString());
							if(flag<=0){
								//将明天到期的数据进行重组
								combi.put("vcAvailQtyT1", returnQty.get(h).get("VC_AVAILABLEQUANTITY_T1").toString());
								retInfo[k] = combi;
								k++;
							}
						}
						log.info("循环发送邮件...");
						//循环发送邮件,按照每个组合发送一封邮件
						if(retInfo[0]!=null){
							//创建事务对象
							for(int i=0;i<combiCodes.length;i++){
								/***组装收件人邮箱信息***/
								String vcMailTo = "";//收件人邮箱，多个以分号隔开：a@test.com;b@test.com
								//查询产品具有查询权限的用户ID串，存放到临时数组中
								@SuppressWarnings("rawtypes")
								Map combiCodesMap = (Map)combiCodes[i];
								String[] userIdArr = null;
								String userIds= "";
								userIds = ProductCombiRightUtil.getUserIdsByProductCode(combiCodesMap.get("vcProductCode").toString());
								//如果返回的权限为空，则跳出此次循环继续下一次
								if("NoPermission".equals(userIds)){
									continue;	
								}else{
									userIdArr = userIds.split(",");
								}
								//将交易部所有符合条件的人员邮箱信息存入字符串vcMailTo中
								DataObject tradersEmail = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
								if(userIdArr!=null && userIdArr.length>0 && userIdArr[0]!=null){
									for(int t=0;t<userIdArr.length;t++){
										for(int m = 0;m<traders.length;m++){
											tradersEmail = (DataObject)traders[m];
											if (tradersEmail.get("userId").toString().equals(userIdArr[t])){
											    if(t==userIdArr.length-1){
											    	vcMailTo = vcMailTo + tradersEmail.get("email").toString();
											    }else{
											    	vcMailTo = vcMailTo + tradersEmail.get("email").toString() + ";";
											    }
											}
										}
									}
									/***组装邮件正文属性信息***/
									@SuppressWarnings("rawtypes")
									Map retMap = (Map)retInfo[0];
									DataObject templeteData = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//邮件正文属性
									templeteData.setString("vcProductCode", retMap.get("vcProductCode").toString());//产品代码
									templeteData.setString("vcProductName", retMap.get("vcProductName").toString());//产品名称
									templeteData.setString("vcCombiCode", retMap.get("vcAccount").toString());//组合代码
									templeteData.setString("vcCombiName", retMap.get("vcCombiName").toString());//组合名称
									List<DataObject> bonds = new ArrayList<DataObject>();//重复组债券信息对象列表
									DataObject bond = DataObjectUtil.createDataObject("commonj.sdo.DataObject");//创建空的dataObject对象
									for(int r=0;r<retInfo.length;r++){
										@SuppressWarnings("rawtypes")
										Map retInfoMap = (Map)retInfo[r];
										if(retInfoMap==null){
											break;
										}else{
											if(retInfoMap.get("vcProductCode").toString().equals(combiCodesMap.get("vcProductCode").toString())){
												bond.setString("vcStockCode", retInfoMap.get("vcStockCode").toString());//债券名称
												bond.setString("vcStockName", retInfoMap.get("vcStockName").toString());//债券代码
												bond.setString("vcMortagageQty", retInfoMap.get("vcMortagageQty").toString());//质押数量
												bond.setString("vcAvailQtyT1", retInfoMap.get("vcAvailQtyT1").toString());//可用数量
												bonds.add(bond);
											}
										}
									}
									//处理空的list
									if(bonds.size()==0){
										bonds = null;
									}
									templeteData.set("bonds", bonds);
									/***邮件发送***/
									String vcTitle = "可用数量不足提醒";//邮件标题
									String vcMailCc = "905324523@qq.com";//抄送人
									String vcMailSender = "";//发件人
									String vcNormalMail = "";//默认发件人
									String[] attachFileNames = null;//附件名称
									String[] attachFilePaths = null;//附件地址
									int type = 2;//需要调用的模版类型：1风控审批模版，2可用数量不足提醒模版
									Object[] resultMail = null;
									try{
										//调用公共逻辑流发送邮件
										Object[] mail = new Object[]{vcTitle,vcMailSender,vcMailTo,vcMailCc,attachFileNames,attachFilePaths,type,templeteData};
					        			String componentNameMail = "com.cjhxfund.commonUtil.MessageService";
					                	ILogicComponent logicComponentMail = LogicComponentFactory.create(componentNameMail);
					                	resultMail = logicComponentMail.invoke("setMailTemplete",mail);
									}catch(Throwable e){
										e.printStackTrace();
									}
									//接收返回值
									String rtnCode = (String)resultMail[0];
									if("0".equals(rtnCode)){
										log.info("成功发送第"+i+"封可用数量不足提醒邮件!!!");
									}else{
										System.out.println("失败发送第"+i+"封可用数量不足提醒邮件...");
										log.info("失败发送第"+i+"封可用数量不足提醒邮件...");
									}
								}else{
									log.info("收件人地址为空，退出...");
								}
							}
						}else{
							log.info("没有可用数量不足的数据，退出...");
						}
					}else{
						log.info("查询的可用数量信息为空...");
					}
				}else{
					log.info("重复组数据为空，需要发送的邮件数量为0，退出...");
				}
			}catch(Throwable e){
				e.printStackTrace();
			}
		}
		
		/**
		 * 
		 * @param actualPledgeQtyList	可质押数量信息
		 * @param putQtyList	可卖数量
		 * @param market	锁定类型（1.不可卖；2，不可质押；3.不可卖和不可质押）
		 * @param lockQty	锁定数量
		 * @param resultObj	返回值
		 * @return
		 */
		@Bizlet("添加锁定券验证可用数量")
		public DataObject addBondAvailableDataCompare(DataObject[] actualPledgeQtyList, DataObject[] putQtyList, String vcLockType, Double lockQty, DataObject resultObj){
			// t+0可用金额
			String vcAvailableamountT0 = null;
			// 可质押数量
			double actualPledgeQty = 0l;
			if(actualPledgeQtyList.length >0){
				for(int i=0; i<actualPledgeQtyList.length; i++){
					vcAvailableamountT0 = actualPledgeQtyList[i].getString("VC_AVAILABLEQUANTITY_T0"); 
					// 可质押数量
					actualPledgeQty = Double.parseDouble(vcAvailableamountT0);
				}
			}
			// 可卖数量
			double putQty = 0l;
			if(putQtyList.length >0){
				for(int i=0; i<putQtyList.length; i++){
					vcAvailableamountT0 = putQtyList[i].getString("VC_AVAILABLEQUANTITY_T0"); 
					// 可卖数量
					putQty = Double.parseDouble(vcAvailableamountT0);
				}
			}
			
			// 锁定类型（1.不可卖；2，不可质押；3.不可卖和不可质押）
			if(vcLockType != null && !vcLockType.equals("")){
				if(lockQty != null && !lockQty.equals("")){
					if(vcLockType.equals("1")){
						if(lockQty > putQty){
							resultObj.setString("rtnCode", "1");
							resultObj.setString("rtnMsg", "锁定数量大于可卖数量!");
						}else{
							resultObj.setString("rtnCode", "0");
							resultObj.setString("rtnMsg", "通过");
						}
					}else if(vcLockType.equals("2")){
						if(lockQty > actualPledgeQty){
							resultObj.setString("rtnCode", "1");
							resultObj.setString("rtnMsg", "锁定数量大于可质押数量!");
						}else{
							resultObj.setString("rtnCode", "0");
							resultObj.setString("rtnMsg", "通过");
						}
					}else{
						if(putQty < actualPledgeQty){
		 					if(lockQty > putQty){
		 						resultObj.setString("rtnCode", "1");
								resultObj.setString("rtnMsg", "锁定数量不能大于T+0可卖数量!");
		 					}else{
		 						resultObj.setString("rtnCode", "0");
								resultObj.setString("rtnMsg", "通过");
							}
						}else if(putQty == actualPledgeQty){
		 					if(lockQty > putQty){
		 						resultObj.setString("rtnCode", "1");
								resultObj.setString("rtnMsg", "锁定数量不能大于T+0可卖数量或者可质押数量!");
		 					}else{
		 						resultObj.setString("rtnCode", "0");
								resultObj.setString("rtnMsg", "通过");
							}
						}else if(putQty > actualPledgeQty){
							if(lockQty > actualPledgeQty){
		 						resultObj.setString("rtnCode", "1");
								resultObj.setString("rtnMsg", "锁定数量不能大于T+0可质押数量!");
		 					}else{
		 						resultObj.setString("rtnCode", "0");
								resultObj.setString("rtnMsg", "通过");
							}
						}
					}
				}else{
					resultObj.setString("rtnCode", "1");
					resultObj.setString("rtnMsg", "必填参数为空!");
				}
			}else{
				resultObj.setString("rtnCode", "1");
				resultObj.setString("rtnMsg", "必填参数为空!");
			}
			
			return resultObj;
		}
}
