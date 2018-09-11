/**
 * 
 */
package com.cjhxfund.jy.BackStageTradeProcess;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.ats.sm.comm.TimerManage;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * 从excel中获取数据，确定要更新的信息
 * @author 金文轩
 * @date 2016-09-05 10:17:02
 *
 */
@Bizlet("获取后台成交信息")
public class GetBackStageTraderInfo {
	//不同的交易类型，数据将更新到不同的表
	public static String BOND_TRADE="ZHFWPT_JY_ZQMM";//债券买卖
	public static String SELL_REVERSE_REPO="ZHFWPT_JY_ZNHG";//正逆回购
	private static Date entTime_sqBsUpdateTask = null;//上清后台状态更新任务(定时器)
	/**
	 * 将从不同Excel中获取更新数据的List，整合成一个方法
	 * path：文件路径
	 * param 是否启用上清新接口：0不启用1启用
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@Bizlet("导入文件")
	public List<BackStageTraderInfo> importExcel(String path,String param){
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		//判断path是否为空
		if(!(path == null || path.length() <= 0)){
			//启用上清新接口
			if("1".equals(param)){
				if(path.indexOf("结算指令下载")!=-1&&
			    		"xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
					//列表中加入结算指令下载、结算合同下载的数据
					backStageTraderInfoList.addAll(processDataOfCNBond(path));
			    }
				if(path.indexOf("现券交易列表")!=-1&&
			    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-现券交易列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingBondTrade(path));
			    }
			    if(path.indexOf("质押式回购列表")!=-1&&
			    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-质押式回购列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingPledgedRepo(path));
			    }
			    if(path.indexOf("全额结算指令列表")!=-1&&
			    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-全额结算指令列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingTallyOrder(path));
			    }
			}else{//沿用上清excel下载的形式进行
				if(path.indexOf("结算指令下载")!=-1&&
			    		"xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
					//列表中加入结算指令下载、结算合同下载的数据
					backStageTraderInfoList.addAll(processDataOfCNBond(path));
			    }
			    if(path.indexOf("现券交易列表")!=-1&&
			    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-现券交易列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingBondTrade(path));
			    }
			    if(path.indexOf("质押式回购列表")!=-1&&
			    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-质押式回购列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingPledgedRepo(path));
			    }
			    if(path.indexOf("全额结算指令列表")!=-1&&
			    		"xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-全额结算指令列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingTallyOrder(path));
			    }
			}
			
		}else{
			System.out.println("文件路径为null");
			LogUtil.logError("文件路径为null", null, new Object[]{});
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 对中债登的两个excel：结算指令下载、结算合同下载 进行数据处理
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfCNBond(String path){
		BackStageTraderInfo backStageTraderInfo = null;
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		
		//后台成交状态字典
		Map<String,String> backStageTraderStatusDict = new HashMap<String,String>();
		backStageTraderStatusDict.put("我方待确认", "01");
		backStageTraderStatusDict.put("对方待确认，请催对手方", "02");
		backStageTraderStatusDict.put("双方待确认，请催对手方", "03");
		backStageTraderStatusDict.put("等我方款", "04");
		backStageTraderStatusDict.put("等对方款，请催对手方", "05");
		backStageTraderStatusDict.put("等我方券", "06");
		backStageTraderStatusDict.put("等对方券，请催对手方", "07");
		backStageTraderStatusDict.put("双方已确认，调款中", "08");
		backStageTraderStatusDict.put("后台已成交", "09");
		backStageTraderStatusDict.put("等款等券，请催对手方", "10");
		backStageTraderStatusDict.put("其他", "99");
		
		//交易方向
		String tradeDirection = null;
		//业务标识号
		String vcDealNo = null;
		//第三方系统指令编号
		String clordid = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的结算指令下载表结果集
		Object[] datas = null;
		//查询已经落地的结算合同下载表结果集
		Object[] contractDatas = null;
		//从缓存中获取跨域数据源
		String dataSource = CacheUtil.getO32CacheDataSourceName();
		//判断《结算合同下载》中是否有与《结算指令下载》配对的业务编号的标识，
		//ture对应“把数据放入更新实体类列表”，false则不把数据放入更新列表
		Boolean hasMatchedData = true;
		//当前后台成交状态
		String backstageTraderStatus = null;
		
		//查询已经落地的结算指令下载列表数据，进行解析处理
		datas=DatabaseExt.queryByNamedSql("default", 
				"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryTallyOrder",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//《结算指令下载》中每一条数据默认初始为true，是放入更新实体类列表的状态标识
					//若需要进入《结算合同下载》的，会再进行一次判断
					hasMatchedData = true;
					//复核员、确认员
					String confirmer = "";
					String checker = "";
					String latestUpdateTime = "";
					String subUpdateTime = "";
					//最近更新时间第70列（BR列），用于筛选掉昨日的数据
					latestUpdateTime = data.getString("latestUpdateTime");
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					if(latestUpdateTime!=null && latestUpdateTime.length()>7){
						subUpdateTime = latestUpdateTime.substring(0, 8);
						//最近更新时间重日期为当天的进行更新，对excel中包含的昨日数据进行筛选
						if(sdf.format(new Date()).equals(subUpdateTime)){
							//从第13列（M列）获取买卖方向
							tradeDirection = data.getString("tradeDirection");
							//从第32列（AF列）获取业务标识号（vcDealNo）单元格可能为数字，需进行类型转换
							vcDealNo = data.getString("businessId");
							//判断成交编号是否为空
							if(!(vcDealNo == null || vcDealNo == "")){
								//复核人(62列)
								confirmer = data.getString("confirmer");
								//确认员(63列)
								checker = data.getString("checker");
								backStageTraderInfo =new BackStageTraderInfo();
								
								//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
								temp=DatabaseExt.queryByNamedSql(dataSource, 
										"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryClordid", 
										vcDealNo);
								if(temp.length>0&&temp[0]!=null){
									clordid = temp[0].toString();
								}else{
									clordid = null;
								}
								//根据业务标识号开头字母的不同，区分是往交易系统的债券买卖表（ZHFWPT_JY_ZQMM）更新，
								//还是往正逆回购表（ZHFWPT_JY_ZNHG）更新
								if("CBT".equals(vcDealNo.substring(0, 3))){
									backStageTraderInfo.setTransactionType(BOND_TRADE);
									//查询当前后台交收状态
									temp=DatabaseExt.queryByNamedSql("default", 
											"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZQMM", 
											clordid);
								}else if("CR".equals(vcDealNo.substring(0, 2))){
									backStageTraderInfo.setTransactionType(SELL_REVERSE_REPO);
									//查询当前后台交收状态
									temp=DatabaseExt.queryByNamedSql("default", 
											"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZNHG", 
											clordid);
								}
								if(temp.length>0&&temp[0]!=null){
									backstageTraderStatus = temp[0].toString();
								}else{
									backstageTraderStatus =null;
								}
								//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
								if(!"09".equals(backstageTraderStatus)&&!"11".equals(backstageTraderStatus)&&!"13".equals(backstageTraderStatus)){
									//通过跨域查询能查询到更新后台状态用的clordid，则进行后续操作
									if(!(clordid == null || "".equals(clordid))){
										backStageTraderInfo.setClordid(clordid);
										//根据确认员、复核员是否有值，确定放入实体类的后台交易状态
										if("买".equals(tradeDirection)){
											if(("".equals(checker)||checker==null)&&!("".equals(confirmer)||confirmer==null)){
												backStageTraderInfo.setBackStageTraderStatus(
														backStageTraderStatusDict.get("我方待确认")); 
											}else if(!("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){
												backStageTraderInfo.setBackStageTraderStatus(
														backStageTraderStatusDict.get("对方待确认，请催对手方")); 
											}else if(("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){
												backStageTraderInfo.setBackStageTraderStatus(
														backStageTraderStatusDict.get("双方待确认，请催对手方")); 
											}
											//确认员有值+复核员有值表示 双方都已经确认此时的状态要从“中债-结算合同下载.xlsx”读取后续的状态
											else if(checker!=""&&checker!=null&&confirmer!=""&&confirmer!=null){
												//查询已经落地的结算指令下载列表数据，进行解析处理
												contractDatas=DatabaseExt.queryByNamedSql("default", 
														"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryTallyContract",null);
												//遍历《结算合同下载》，状态逻辑判断
												if(contractDatas!=null){
													if(contractDatas.length>0){
														for(int k=0;k<contractDatas.length;k++){
															//接收结算合同下载表数据
															DataObject contractData = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
															contractData = (DataObject)contractDatas[k];
															//结算合同下载中的业务标识号13列
															String contractBusinessId = contractData.getString("contractBusinessId");
															//合同状态描述55列
															String contractRemark = contractData.getString("contractRemark");
															//判断是否有匹配的业务标识号，若有则放入赋予标识true，放入实体类
															if(vcDealNo.equals(contractBusinessId)){
																//根据合同状态描述字段对应不同的状态来设置后台成交状态
																if("等款".equals(contractRemark)){
																	backStageTraderInfo.setBackStageTraderStatus(
																			backStageTraderStatusDict.get("等我方款"));
																}else if("等券".equals(contractRemark)){
																	backStageTraderInfo.setBackStageTraderStatus(
																			backStageTraderStatusDict.get("等对方券，请催对手方"));
																}else if("成功".equals(contractRemark)){
																	backStageTraderInfo.setBackStageTraderStatus(
																			backStageTraderStatusDict.get("后台已成交"));
																	backStageTraderInfo.setProcessStatus("6");
																}
																hasMatchedData = true;
															}
														}
													}
												}
											}
										}else if("卖".equals(tradeDirection)){
											if(("".equals(checker)||checker==null)&&!("".equals(confirmer)||confirmer==null)){
												backStageTraderInfo.setBackStageTraderStatus(
														backStageTraderStatusDict.get("对方待确认，请催对手方")); 
											}else if(!("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){
												backStageTraderInfo.setBackStageTraderStatus(
														backStageTraderStatusDict.get("我方待确认")); 
											}else if(("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){
												backStageTraderInfo.setBackStageTraderStatus(
														backStageTraderStatusDict.get("双方待确认，请催对手方")); 
											}
											//确认员有值+复核员有值表示 双方都已经确认此时的状态要从“中债-结算合同下载.xlsx”读取后续的状态
											else if(checker!=""&&checker!=null&&confirmer!=""&&confirmer!=null){
												//查询已经落地的结算指令下载列表数据，进行解析处理
												contractDatas=DatabaseExt.queryByNamedSql("default", 
														"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryTallyContract",null);
												//遍历《结算合同下载》，状态逻辑判断
												if(contractDatas!=null){
													if(contractDatas.length>0){
														for(int k=0;k<contractDatas.length;k++){
															//接收结算合同下载表数据
															DataObject contractData = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
															contractData = (DataObject)contractDatas[k];
															//结算合同下载中的业务标识号13列
															String contractBusinessId = contractData.getString("contractBusinessId");
															//合同状态描述55列
															String contractRemark = contractData.getString("contractRemark");
															//判断是否有匹配的业务标识号，若有则放入赋予标识true，放入实体类
															if(vcDealNo.equals(contractBusinessId)){
																if("等款".equals(contractRemark)){
																	backStageTraderInfo.setBackStageTraderStatus(
																			backStageTraderStatusDict.get("等对方款，请催对手方"));
																}else if("等券".equals(contractRemark)){
																	backStageTraderInfo.setBackStageTraderStatus(
																			backStageTraderStatusDict.get("等我方券"));
																}else if("成功".equals(contractRemark)){
																	backStageTraderInfo.setBackStageTraderStatus(
																			backStageTraderStatusDict.get("后台已成交"));
																	backStageTraderInfo.setProcessStatus("6");
																}
																hasMatchedData = true;
															}
														}
													}
												}
											}
										}
										//标识为true的数据，放入实体类
										if(hasMatchedData){
											//后台交易时间
											SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
											backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
											//操作用户为系统管理员
											backStageTraderInfo.setBackStageTraderId("sysadmin");
											backStageTraderInfo.setBackStageTraderName("sysadmin");
											//将此条更新信息放入列表
											backStageTraderInfoList.add(backStageTraderInfo);
										}
									}else{
										SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
										 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
									}
								}
							}else{
								SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								LogUtil.logInfo("update failed--vcInstrid:  "+data.get("vcInstrid")+"  "+df.format(new Date()), null, new Object[]{});
							}
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 上清-现券交易列表 数据处理
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfSHClearingBondTrade(
			String path){
		BackStageTraderInfo backStageTraderInfo = null;
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		
		//委托方向
		String entrustDirection  = null;
		//源交易编号列表
		String vcDealNo = null;
		//买方状态
		String buyerStatus = null;
		//卖方状态
		String sellerStatus = null;
		//第三方系统指令编号
		String clordid = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的全额结算列表结果集
		Object[] datas = null;
		//当前成交状态
		String backstageTraderStatus = null;
		//从缓存中获取跨域数据源
		String dataSource = CacheUtil.getO32CacheDataSourceName();
		
		//后台成交状态字典
		Map<String,String> backStageTraderStatusDict = new HashMap<String,String>();
		backStageTraderStatusDict.put("我方待确认", "01");
		backStageTraderStatusDict.put("对方待确认，请催对手方", "02");
		backStageTraderStatusDict.put("双方待确认，请催对手方", "03");
		backStageTraderStatusDict.put("等我方款", "04");
		backStageTraderStatusDict.put("等对方款，请催对手方", "05");
		backStageTraderStatusDict.put("等我方券", "06");
		backStageTraderStatusDict.put("等对方券，请催对手方", "07");
		backStageTraderStatusDict.put("双方已确认，调款中", "08");
		backStageTraderStatusDict.put("后台已成交", "09");
		backStageTraderStatusDict.put("等款等券，请催对手方", "10");
		backStageTraderStatusDict.put("其他", "99");
		
		//查询已经落地的全额结算列表数据，进行解析处理
		datas=DatabaseExt.queryByNamedSql("default", 
				"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryBondTrade",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//获取交易日期(之前excel的第三列)，用于筛选掉昨日的数据
					String setmtDate = data.getString("setmtDate");
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					//最近更新时间重日期为当天的进行更新，对excel中包含的昨日数据进行筛选
					if(sdf.format(new Date()).equals(setmtDate)){
						backStageTraderInfo =new BackStageTraderInfo();
						//设置成交编号
						vcDealNo = data.getString("businessId");
						//判断成交编号是否为空
						if(!(vcDealNo == null || vcDealNo == "")){
							//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
							temp=DatabaseExt.queryByNamedSql(dataSource, 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchEntrustDirection", 
									vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								entrustDirection = temp[0].toString();
							}else{
								entrustDirection =null;
							}
							//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
							temp=DatabaseExt.queryByNamedSql(dataSource, 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryClordid", 
									vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								clordid = temp[0].toString();
							}else{
								clordid =null;
							}
							//查询后台成交状态，若已经为后续状态（已经从《上清-全额结算指令列表》中获取过状态），
							//则不放入List中进行更新
							temp=DatabaseExt.queryByNamedSql("default", 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZQMM", 
									clordid);
							if(temp.length>0&&temp[0]!=null){
								backstageTraderStatus = temp[0].toString();
							}else{
								backstageTraderStatus =null;
							}
							//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
							if(!"04".equals(backstageTraderStatus)&&!"05".equals(backstageTraderStatus)&&
									!"06".equals(backstageTraderStatus)&&!"07".equals(backstageTraderStatus)&&
											!"08".equals(backstageTraderStatus)&&!"09".equals(backstageTraderStatus)&&
											!"10".equals(backstageTraderStatus)){
								//通过跨域查询能查询到更新后台状态用的clordid以及买卖方向，不为空则进行后续操作
								if(!(clordid == null || clordid == "")&&
										!(entrustDirection == null || entrustDirection == "")){
									backStageTraderInfo.setClordid(clordid);
									//获取买方状态
									buyerStatus = data.getString("buyerStatus");
									//获取卖方状态
									sellerStatus = data.getString("sellerStatus");
									//数据插入到债券买卖表
									backStageTraderInfo.setTransactionType(BOND_TRADE);
									
									//委托方向3为债券买入
									if("3".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("我方待确认"));
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方已确认，调款中"));
										}
									}
									//委托方向4为债券卖出
									else if("4".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("我方待确认"));
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方已确认，调款中"));
										}
									}
									
									//后台交易时间
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
									//操作用户为系统管理员
									backStageTraderInfo.setBackStageTraderId("sysadmin");
									backStageTraderInfo.setBackStageTraderName("sysadmin");
									//将此条更新信息放入列表
									backStageTraderInfoList.add(backStageTraderInfo);
								}else{
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
								}
							}
						}else{
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							 LogUtil.logInfo("update failed:现券交易列表更新失败，成交编号为空   "+df.format(new Date()), null, new Object[]{});
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	
	/**
	 * 上清-质押式回购列表 数据处理
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfSHClearingPledgedRepo(String path){
		BackStageTraderInfo backStageTraderInfo = null;
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		
		//委托方向
		String entrustDirection  = null;
		//成交编号
		String vcDealNo = null;
		//买方状态
		String buyerStatus = null;
		//卖方状态
		String sellerStatus = null;
		//第三方系统指令编号
		String clordid = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的全额结算列表结果集
		Object[] datas = null;
		//当前成交状态
		String backstageTraderStatus = null;
		//从缓存中获取跨域数据源
		String dataSource = CacheUtil.getO32CacheDataSourceName();
		
		//后台成交状态字典
		Map<String,String> backStageTraderStatusDict = new HashMap<String,String>();
		backStageTraderStatusDict.put("我方待确认", "01");
		backStageTraderStatusDict.put("对方待确认，请催对手方", "02");
		backStageTraderStatusDict.put("双方待确认，请催对手方", "03");
		backStageTraderStatusDict.put("等我方款", "04");
		backStageTraderStatusDict.put("等对方款，请催对手方", "05");
		backStageTraderStatusDict.put("等我方券", "06");
		backStageTraderStatusDict.put("等对方券，请催对手方", "07");
		backStageTraderStatusDict.put("双方已确认，调款中", "08");
		backStageTraderStatusDict.put("后台已成交", "09");
		backStageTraderStatusDict.put("等款等券，请催对手方", "10");
		backStageTraderStatusDict.put("其他", "99");
		
		//查询已经落地的全额结算列表数据，进行解析处理
		datas=DatabaseExt.queryByNamedSql("default", 
				"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryPledgeStyleRepo",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//获取成交日期，用于筛选掉昨日的数据
					String setmtDate = data.getString("setmtDate");
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					//最近更新时间重日期为当天的进行更新，对excel中包含的昨日数据进行筛选
					if(sdf.format(new Date()).equals(setmtDate)){
						backStageTraderInfo =new BackStageTraderInfo();
						//设置成交编号
						vcDealNo = data.getString("businessId");
						//判断成交编号是否为空
						if(!(vcDealNo == null || vcDealNo == "")){
							//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
							temp=DatabaseExt.queryByNamedSql(dataSource, 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchEntrustDirection", 
									vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								entrustDirection = temp[0].toString();
							}else{
								entrustDirection =null;
							}
							//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
							temp=DatabaseExt.queryByNamedSql(dataSource, 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryClordid", 
									vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								clordid = temp[0].toString();
							}else{
								clordid = null;
							}
							//查询后台成交状态，若已经为后续状态（已经从《上清-全额结算指令列表》中获取过状态），
							//则不放入List中进行更新
							temp=DatabaseExt.queryByNamedSql("default", 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZNHG", 
									clordid);
							if(temp.length>0&&temp[0]!=null){
								backstageTraderStatus = temp[0].toString();
							}else{
								backstageTraderStatus =null;
							}
							//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
							if(!"04".equals(backstageTraderStatus)&&!"05".equals(backstageTraderStatus)&&
									!"06".equals(backstageTraderStatus)&&!"07".equals(backstageTraderStatus)&&
										!"08".equals(backstageTraderStatus)&&!"09".equals(backstageTraderStatus)&&
											!"10".equals(backstageTraderStatus)){
								//通过跨域查询能查询到更新后台状态用的clordid以及买卖方向，不为空则进行后续操作
								if(!(clordid == null||clordid == "")&&
										!(entrustDirection == null||entrustDirection == "")){
									backStageTraderInfo.setClordid(clordid);
									//获取正回购方状态
									buyerStatus = data.getString("buyerStatus");
									//获取逆回购方状态
									sellerStatus = data.getString("sellerStatus");
									//数据插入到正逆回购表
									backStageTraderInfo.setTransactionType(SELL_REVERSE_REPO);
									
									//委托方向为逆回购首期、正回购到期
									if("6".equals(entrustDirection)||"7".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("我方待确认"));
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方已确认，调款中"));
										}
									//委托方向为正回购首期、逆回购到期
									}else if("5".equals(entrustDirection)||"8".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("我方待确认"));
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("双方已确认，调款中"));
										}
									}
									
									//后台交易时间
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
									//操作用户为系统管理员
									backStageTraderInfo.setBackStageTraderId("sysadmin");
									backStageTraderInfo.setBackStageTraderName("sysadmin");
									//将此条更新信息放入列表
									backStageTraderInfoList.add(backStageTraderInfo);
								}else{
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
								}
							}
						}else{
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							LogUtil.logInfo("update failed:上清质押式回购列表更新失败，成交编号为空！  "+df.format(new Date()), null, new Object[]{});
						}
					}
				}
			}	
		}
		
		return backStageTraderInfoList;
	}
	
	
	/**
	 * 上清-全额结算指令列表 数据处理
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfSHClearingTallyOrder(String path){
		BackStageTraderInfo backStageTraderInfo =null;
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		
		//委托方向
		String entrustDirection  = null;
		//成交编号
		String vcDealNo = null;
		//产品结算状态
		String productClearingStatus = null;
		//资金结算状态
		String fundClearingStatus = null;
		//第三方系统指令编号
		String clordid = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的全额结算列表结果集
		Object[] datas = null;
		//当前后台成交状态
		String backstageTraderStatus= null;
		//从缓存中获取跨域数据源
		String dataSource = CacheUtil.getO32CacheDataSourceName();
		
		
		//后台成交状态字典
		Map<String,String> backStageTraderStatusDict = new HashMap<String,String>();
		backStageTraderStatusDict.put("我方待确认", "01");
		backStageTraderStatusDict.put("对方待确认，请催对手方", "02");
		backStageTraderStatusDict.put("双方待确认，请催对手方", "03");
		backStageTraderStatusDict.put("等我方款", "04");
		backStageTraderStatusDict.put("等对方款，请催对手方", "05");
		backStageTraderStatusDict.put("等我方券", "06");
		backStageTraderStatusDict.put("等对方券，请催对手方", "07");
		backStageTraderStatusDict.put("双方已确认，调款中", "08");
		backStageTraderStatusDict.put("后台已成交", "09");
		backStageTraderStatusDict.put("等款等券，请催对手方", "10");
		backStageTraderStatusDict.put("其他", "99");
		
		//查询已经落地的全额结算列表数据，进行解析处理
		datas=DatabaseExt.queryByNamedSql("default", 
				"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryFullTallyOrder", 
				null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//创建后台成交赋值对象(属性包括：)
					backStageTraderInfo =new BackStageTraderInfo();
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//设置成交编号并且跳过成交编号为空或者成交编号长度小于2的数据
					vcDealNo = data.getString("businessId");
					if (!(vcDealNo == null || vcDealNo == "")) {
						//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
						temp=DatabaseExt.queryByNamedSql(dataSource, 
								"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchEntrustDirection", 
								vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							entrustDirection = temp[0].toString();
						}else{
							entrustDirection =null;
						}
						//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
						temp=DatabaseExt.queryByNamedSql(dataSource, 
								"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryClordid", 
								vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							clordid = temp[0].toString();
						}else{
							clordid = null;
						}
						//判断成交编号长度是否大于2
						if(vcDealNo.length()>2){
							//根据业务标识号开头字母的不同，区分是往交易系统的债券买卖表（ZHFWPT_JY_ZQMM）更新，
							//还是往正逆回购表（ZHFWPT_JY_ZNHG）更新
							if("CBT".equals(vcDealNo.substring(0, 3))){
								backStageTraderInfo.setTransactionType(BOND_TRADE);
								//查询当前后台交收状态
								temp=DatabaseExt.queryByNamedSql("default", 
										"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZQMM", 
										clordid);
							}else if("CR".equals(vcDealNo.substring(0, 2))){
								backStageTraderInfo.setTransactionType(SELL_REVERSE_REPO);
								//查询当前后台交收状态
								temp=DatabaseExt.queryByNamedSql("default", 
										"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZNHG", 
										clordid);
							}
							if(temp.length>0&&temp[0]!=null){
								backstageTraderStatus = temp[0].toString();
							}else{
								backstageTraderStatus =null;
							}
							//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
							if(!"09".equals(backstageTraderStatus)&&!"11".equals(backstageTraderStatus)
							   &&!"".equals(backstageTraderStatus)&&backstageTraderStatus!=null){
								//通过跨域查询能查询到更新后台状态用的clordid以及买卖方向，不为空则进行后续操作
								if(!(clordid == null || "".equals(clordid))&&
										!(entrustDirection == null || "".equals(entrustDirection))){
									backStageTraderInfo.setClordid(clordid);
									//从H列、I列读取产品结算状态、资金结算状态
									productClearingStatus = data.getString("productClearingStatus");
									fundClearingStatus = data.getString("fundClearingStatus");
									//委托方向为债券买入、逆回购首期、正回购到期
									if("3".equals(entrustDirection)||"6".equals(entrustDirection)||"7".equals(entrustDirection)){
										if("等券".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("等款等券，请催对手方")); 
										}else if("券足".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("等我方款")); 
										}else if("等券".equals(productClearingStatus)&&"款足".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("等对方券，请催对手方"));
										}else if("成功".equals(productClearingStatus)&&"成功".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("后台已成交"));
											backStageTraderInfo.setProcessStatus("6");
										}
									//委托方向为债券卖出、正回购首期、逆回购到期
									}else if("4".equals(entrustDirection)||"5".equals(entrustDirection)||"8".equals(entrustDirection)){
										if("等券".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("等款等券，请催对手方")); 
										}else if("券足".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("等对方款，请催对手方"));
										}else if("等券".equals(productClearingStatus)&&"款足".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("等我方券")); 
										}else if("成功".equals(productClearingStatus)&&"成功".equals(fundClearingStatus)){
											backStageTraderInfo.setBackStageTraderStatus(
													backStageTraderStatusDict.get("后台已成交"));
											backStageTraderInfo.setProcessStatus("6");
										}
									}
									//后台交易时间
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
									//操作用户为系统管理员
									backStageTraderInfo.setBackStageTraderId("sysadmin");
									backStageTraderInfo.setBackStageTraderName("sysadmin");
									//将此条更新信息放入列表
									backStageTraderInfoList.add(backStageTraderInfo);
								}else{
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
								}
							}
						}else{
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							LogUtil.logInfo("update failed:全额结算列表数据更新失败，成交编号长度不大于2！  "+df.format(new Date()), null, new Object[]{});
						}
					}else{
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						LogUtil.logInfo("update failed:全额结算列表数据更新失败，成交编号为空！  "+df.format(new Date()), null, new Object[]{});
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 将后台成交的信息反馈
	 * @param 
	 * @return
	 */
	@Bizlet("将后台成交的信息反馈")
	public static int infoFeedback (String clordid){
		//招行方面暂时不需要，在此注释掉指令状态反馈功能
		
//		Object[] temp=DatabaseExt.queryByNamedSql("default", 
//				"com.cjhxfund.cjapi.common.OrderStatusns.searchFeedbackInfoByClordId", 
//				clordid);
//		Map<String,Object> map = new HashMap<String,Object>();
//		String retMsg = null;
//		if(temp.length>0&&temp!=null){
//			//调用命名sql获取本地留痕的vcClordid、vcOrigOrdID、vcOperatorState("success")
//			map= (Map<String,Object>)temp[0];
//			//调用逻辑流进行反馈
//			String componentName = "com.cjhxfund.cjapi.WSCommOperatorService";
//			Object[] params = new Object[1];
//			params[0]=map;
//			
//			try {
//				Object[] object = GenericGenericBaseDaoSupport.invokeBizMethod(componentName, "orderState", params);
//				if(object[0]!=null){
//					retMsg = object[0].toString();
//				}
//				Map<String, Object> retMap = JSONUtil.jsonToMap(retMsg);
//				Object result = retMap.get("result");
//				if (result == null || !"000000".equals(retMap.get("result"))) {
//					LogUtil.logError("后台成交时调用招行接口指令状态反馈失败, vcClordid:{0}, retMsg:{1}", null, map.get("vcClordid"), retMsg);
//				} else {
//					LogUtil.logInfo("后台成交时调用招行接口指令状态反馈成功, vcClordid:{0}, retMsg:{1}", null, map.get("vcClordid"), retMsg);
//				}
//			} catch (Throwable e) {
//				e.printStackTrace();
//				LogUtil.logError("调用指令状态反馈逻辑流错误！", e);
//			}
//			return 0;
//		}else{
//			return -1;
//		}
		return 0;
	}
	
	/**
	 * 上清所交易指令管理数据列表处理；本币系统当前后台成交状态不在结算和调款中状态范围时进行更新(04、05、06、07、08、09、10)，否则跳过结算字典参考全额结算数据更新说明
	 * 买方状态    卖方状态        后台成交状态---------买入、分销、正回购到期、逆回购首期业务------		    
	 * 待确认0     待确认0         双方待确认，请催对手方03
	 * 已确认4     待确认0         对方待确认，请催对手方02
	 * 待确认0     已确认4         我方待确认01
	 * 已确认4     已确认4         双方已确认，调款中08
	 * 买方状态    卖方状态        后台成交状态---------卖出、正回购首期、逆回购到期业务----------		    
	 * 待确认0     待确认0         双方待确认，请催对手方03
	 * 已确认4     待确认0         对方待确认，请催对手方01
	 * 待确认0     已确认4         我方待确认02
	 * 已确认4     已确认4         双方已确认，调款中08
	 * @return
	 * @author chendi
	 */
	@Bizlet("获取上清所交易指令管理数据列表")
	public List<BackStageTraderInfo> getSqsTradeOrderDatas(){
		BackStageTraderInfo backStageTraderInfo =null;
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		//上清所交易指令管理数据列表
		Object[] tradeDatas = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//买方状态
		String buyerStatus = null;
		//卖方状态
		String sellerStatus = null;
		//成交编号
		String vcDealNo = null;
		//当前后台成交状态
		String bsStatus = null;
		//委托方向
		String vcEntrustDirection = null;
		//第三方指令编号
		String clordid = null;
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		
		//查询O32上清所交易指令管理数据列表
		tradeDatas=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryTradeOrderData",null);
		if(tradeDatas.length>0){
			for(int i=0,l=tradeDatas.length;i<l;i++){
				//创建后台成交赋值对象(属性包括：)
				backStageTraderInfo =new BackStageTraderInfo();
				//解析每一条全额结算列表数据
				DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				data = (DataObject)tradeDatas[i];
				//获取成交编号
				vcDealNo = data.get("vcSrctradeid").toString();
				if(vcDealNo !=null && vcDealNo !=""){
					//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
					temp=DatabaseExt.queryByNamedSql(dataSource, 
							"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryClordid", 
							vcDealNo);
					if(temp.length>0&&temp[0]!=null){
						clordid = temp[0].toString();
					}else{
						clordid = null;
					}
					//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
					temp=DatabaseExt.queryByNamedSql(dataSource, 
							"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchEntrustDirection", 
							vcDealNo);
					if(temp.length>0&&temp[0]!=null){
						vcEntrustDirection = temp[0].toString();
					}else{
						vcEntrustDirection =null;
					}
					//查询当前后台成交状态
					if("3".equals(vcEntrustDirection)||"4".equals(vcEntrustDirection)){
						backStageTraderInfo.setTransactionType(BOND_TRADE);
						//查询当前后台交收状态
						temp=DatabaseExt.queryByNamedSql("default", 
								"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZQMM",clordid);
					}else if("5".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)||
							 "7".equals(vcEntrustDirection)||"8".equals(vcEntrustDirection)){
						backStageTraderInfo.setTransactionType(SELL_REVERSE_REPO);
						//查询当前后台交收状态
						temp=DatabaseExt.queryByNamedSql("default", 
								"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZNHG",clordid);
					}
					if(temp.length>0&&temp[0]!=null){
						bsStatus = temp[0].toString();
					}else{
						bsStatus =null;
					}
					if(clordid!=null && !"".equals(clordid)){
						//如果当前后台成交状态为调款中或者结算的状态
						if(!"04".equals(bsStatus)&&!"05".equals(bsStatus)&&
						   !"06".equals(bsStatus)&&!"07".equals(bsStatus)&&
						   !"08".equals(bsStatus)&&!"09".equals(bsStatus)&&
						   !"10".equals(bsStatus)){
							if(vcEntrustDirection != null && vcEntrustDirection != ""){
								//分销、买入、正回购到期、逆回购首期
								if("3".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)||"7".equals(vcEntrustDirection)){
									buyerStatus = data.getString("cBuyerstatus");
									sellerStatus = data.getString("cSellerstatus");
									if("0".equals(buyerStatus)&&"0".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("03"); 
									}else if("4".equals(buyerStatus)&&"0".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("02"); 
									}else if("0".equals(buyerStatus)&&"4".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("01");
									}else if("4".equals(buyerStatus)&&"4".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("08");
									}
									//卖出、正回购首期、逆回购到期
								}else if("4".equals(vcEntrustDirection)||"5".equals(vcEntrustDirection)||"8".equals(vcEntrustDirection)){
									buyerStatus = data.getString("vcSelfconfStatus");
									sellerStatus = data.getString("vcRavilconfStatus");
									if("0".equals(buyerStatus)&&"0".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("03"); 
									}else if("4".equals(buyerStatus)&&"0".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("01");
									}else if("0".equals(buyerStatus)&&"4".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("02"); 
									}else if("4".equals(buyerStatus)&&"4".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus("08");
									}
								}
								//后台交易时间
								SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
								//操作用户为系统管理员
								backStageTraderInfo.setBackStageTraderId("sysadmin");
								backStageTraderInfo.setBackStageTraderName("sysadmin");
								//成交编号
								backStageTraderInfo.setVcDealNo(vcDealNo);
								//设置第三方指令编号
								backStageTraderInfo.setClordid(clordid);
								//将此条更新信息放入列表
								backStageTraderInfoList.add(backStageTraderInfo);
							}else{
								SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								LogUtil.logInfo("update failed--成交编号："+vcDealNo+"  委托方向："+vcEntrustDirection+" "+df.format(new Date()), null, new Object[]{});
							}
						}
					}else{
						LogUtil.logInfo("update failed--成交编号："+vcDealNo+"  委托方向："+vcEntrustDirection+" 第三方指令编号为空", null, new Object[]{});
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 上清所全额结算管理数据列表处理；本币系统当前后台成交状态不在后台已成交、担保交收、未成交(09、11、13)，否则跳过
	 * 买方状态    卖方状态        后台成交状态---------买入、分销、正回购到期、逆回购首期业务------		    
	 * 等券2         等款2             等券等款，请催对手方10
	 * 券足3         等款2             等我方款04
	 * 等券2         款足3             等对方券，请催对手方07
	 * 成功8         成功8             后台已成交09
	 * 买方状态    卖方状态        后台成交状态---------卖出、正回购首期、逆回购到期业务----------		    
	 * 等券2         等款2             等券等款，请催对手方10
	 * 券足2         等款3             等对方款，请催对手方05
	 * 等券3         款足2             等我方券06
	 * 成功8         成功8             后台已成交09
	 * trades 从O32查询的上清所全额结算管理数据列表
	 * @return
	 * @author chendi
	 */
	@Bizlet("获取上清所全额结算指令数据列表")
	public List<BackStageTraderInfo> getSqsFullTallyOrderDatas(){
		BackStageTraderInfo backStageTraderInfo =null;
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		//全额结算指令管理数据列表
		Object[] fullDatas = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//产品结算状态
		String productStatus = null;
		//资金结算状态
		String fundSetStatus = null;
		//成交编号
		String vcDealNo = null;
		//当前后台成交状态
		String bsStatus = null;
		//委托方向
		String vcEntrustDirection = null;
		//第三方指令编号
		String clordid = null;
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		
		//查询O32上清所全额结算数据列表
		fullDatas=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryFullTallyOrderData",null);
		if(fullDatas.length>0){
			for(int i=0,l=fullDatas.length;i<l;i++){
				//创建后台成交赋值对象(属性包括：)
				backStageTraderInfo =new BackStageTraderInfo();
				//解析每一条全额结算列表数据
				DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				data = (DataObject)fullDatas[i];
				//获取成交编号
				vcDealNo = data.get("vcSrctradeid").toString();
				if(vcDealNo !=null && !"".equals(vcDealNo)){
					//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
					temp=DatabaseExt.queryByNamedSql(dataSource, 
							"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.queryClordid", 
							vcDealNo);
					if(temp.length>0&&temp[0]!=null){
						clordid = temp[0].toString();
					}else{
						clordid = null;
					}
					if(clordid !=null && !"".equals(clordid)){
						//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
						temp=DatabaseExt.queryByNamedSql(dataSource, 
								"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchEntrustDirection", 
								vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							vcEntrustDirection = temp[0].toString();
						}else{
							vcEntrustDirection =null;
						}
						//查询当前后台成交状态
						if("3".equals(vcEntrustDirection)||"4".equals(vcEntrustDirection)){
							backStageTraderInfo.setTransactionType(BOND_TRADE);
							//查询当前后台交收状态
							temp=DatabaseExt.queryByNamedSql("default", 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZQMM", 
									clordid);
						}else if("5".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)||
								 "7".equals(vcEntrustDirection)||"8".equals(vcEntrustDirection)){
							backStageTraderInfo.setTransactionType(SELL_REVERSE_REPO);
							//查询当前后台交收状态
							temp=DatabaseExt.queryByNamedSql("default", 
									"com.cjhxfund.jy.BackStageTradeProcess.updateBackStageTraderStatus.searchBackstageTraderStatusfromZNHG", 
									clordid);
						}
						if(temp.length>0&&temp[0]!=null){
							bsStatus = temp[0].toString();
						}else{
							bsStatus =null;
						}
						if(bsStatus!=null && bsStatus !=""){
							//如果当前后台成交状态为后台已成交、担保交收、未成交，则不更新
							if(!"09".equals(bsStatus)&&!"11".equals(bsStatus)&&!"13".equals(bsStatus)){
								if(vcEntrustDirection != null && vcEntrustDirection != ""){
									//分销、买入、正回购到期、逆回购首期
									if("3".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)||"7".equals(vcEntrustDirection)){
										productStatus = data.getString("cProductstatus");
										fundSetStatus = data.getString("cFundsettstatus");
										if("2".equals(productStatus)&&"2".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("10"); 
										}else if("3".equals(productStatus)&&"2".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("04"); 
										}else if("2".equals(productStatus)&&"3".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("07");
										}else if("8".equals(productStatus)&&"8".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("09");
											//流程状态置为后台已成交
											backStageTraderInfo.setProcessStatus("6");
										}
									//卖出、正回购首期、逆回购到期
									}else if("4".equals(vcEntrustDirection)||"5".equals(vcEntrustDirection)||"8".equals(vcEntrustDirection)){
										productStatus = data.getString("cProductstatus");
										fundSetStatus = data.getString("cFundsettstatus");
										if("2".equals(productStatus)&&"2".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("10"); 
										}else if("3".equals(productStatus)&&"2".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("05");
										}else if("2".equals(productStatus)&&"3".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("06"); 
										}else if("8".equals(productStatus)&&"8".equals(fundSetStatus)){
											backStageTraderInfo.setBackStageTraderStatus("09");
											//流程状态置为后台已成交
											backStageTraderInfo.setProcessStatus("6");
										}
									}
									//后台交易时间
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
									//操作用户为系统管理员
									backStageTraderInfo.setBackStageTraderId("sysadmin");
									backStageTraderInfo.setBackStageTraderName("sysadmin");
									//成交编号
									backStageTraderInfo.setVcDealNo(vcDealNo);
									//第三方指令编号
									backStageTraderInfo.setClordid(clordid);
									//将此条更新信息放入列表
									backStageTraderInfoList.add(backStageTraderInfo);
								}else{
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									LogUtil.logInfo("update failed--成交编号："+vcDealNo+"  委托方向："+vcEntrustDirection+" "+df.format(new Date()), null, new Object[]{});
								}
							}
						}
					}else{
						LogUtil.logInfo("update failed--成交编号："+vcDealNo+"  委托方向："+vcEntrustDirection+" 第三方指令编号为空", null, new Object[]{});
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 获取系统参数
	 * @return
	 */
	@Bizlet()
	public static String getSqZzUpdateParam(){
		//上清中债缓存定义
		String sqZzInfo = null;
		try {
			//获取缓存中邮件信息
			DataObject dojb = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_SQ_UPDATE_PARAM");
			//上清中债缓存信息
			sqZzInfo=dojb.getString("paramValue");
		} catch (Exception e) {
			com.eos.foundation.eoscommon.LogUtil.logError("获取缓存数据失败，请检查缓存中相关配置;缓存key为：{0}", e, "ATS_SQ_UPDATE_PARAM");
			e.printStackTrace();
		}
		return sqZzInfo;
	}
	/**
	 * 上清后台状态更新任务(老机器猫)
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取系统参数（ATS_TIMER_POLLING_INTERVAL）默认配置间隔
	 * @param pEndTime 轮询结束时间，为空或格式错误时取系统参数（ATS_TIMER_END_TIME）默认配置时间
	 * @return
	 * @author chendi
	 */
	@Bizlet("老机器猫上清后台状态更新任务")
	public static boolean sqNewInterfaceForJqmTask(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  老机器猫上清后台状态更新任务开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = Integer.parseInt(ParamConfig.getValue(TimerManage.POLLING_INTERVAL_PARAM_KEY));
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("BackStageTrader.dealO32SqsDatas fail: 轮询间隔时间格式错误，取默认"+intervalTime+"分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认"+intervalTime+"分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			String endTime = ParamConfig.getValue(TimerManage.ENDTIME_PARAM_KEY);
			entTime_sqBsUpdateTask = DateUtil.parse(date+" "+endTime, DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					entTime_sqBsUpdateTask = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("BackStageTrader.dealO32SqsDatas fail: 轮询结束时间格式错误，取默认"+endTime+"！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认"+endTime+"！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"--老机器猫--dealO32SqsDatas begin ...");
				Long beforeTime=(new Date()).getTime();
				
				try {

					/***业务调用开始***/
					Object[] ob = new Object[]{};
        			String componentName = "com.cjhxfund.jy.BackStageTradeProcess.BackStageTradeStatusProcess";
                	ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
					logicComponent.invoke("dealO32SqsDatas",ob);
					/***业务调用结束***/

				} catch (Throwable e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				
				//刷新执行信息
				Long afterTime=(new Date()).getTime();
				String className=Thread.currentThread().getStackTrace()[1].getClassName();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+"--老机器猫--dealO32SqsDatas end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
				if(DateUtil.currentDate().after(entTime_sqBsUpdateTask)){//若当前系统时间大于轮询结束时间，则跳出循环
					execute = false;
				}
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  老机器猫上清后台状态更新任务结束!!!");
		return isSuccess;
	}
	/**
	 * 手动定时器结束时间(老机器猫上清新接口)
	 * @author 陈迪
	 */
	@Bizlet("")
	public static boolean closeSqNewInterfaceTask(){
		entTime_sqBsUpdateTask = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  老机器猫手动关闭执行定时器功能，结束时间："+entTime_sqBsUpdateTask);
		return true;
	}
}