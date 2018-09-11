/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

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
	
	public static final String OVERDUE_TIME="16:55";//过期时间，过期就作废

	/**
	 * 将从不同Excel中获取更新数据的List，整合成一个方法
	 * @param path excel文件本地存储路径
	 * @return
	 */
	@Bizlet("导入文件")
	public List<BackStageTraderInfo> importExcel(String path,String param){
		//更新信息列表
		List<BackStageTraderInfo> backStageTraderInfoList = new ArrayList<BackStageTraderInfo>();
		//判断path是否为空
		if(!(path == null || path.length() <= 0)){
			if(path.indexOf("结算指令下载")!=-1 && "xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
				//列表中加入结算指令下载、结算合同下载的数据
				backStageTraderInfoList.addAll(processDataOfCNBond(path));
		    }
			if(path.indexOf("结算合同下载")!=-1 && "xlsx".equals(path.substring(path.lastIndexOf(".")+1))){
				//列表中加入结算指令下载、结算合同下载的数据
				backStageTraderInfoList.addAll(processDataOfContract(path));
		    }
			if(!"1".equals(param)){//当开启了上清接口功能时，上清后台交收状态不再根据excel数据进行更新，直接通过O32上清接口进行状态更新
				if(path.indexOf("现券交易列表")!=-1 && "xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-现券交易列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingBondTrade(path));
			    }
			    if(path.indexOf("质押式回购列表")!=-1 && "xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-质押式回购列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingPledgedRepo(path));
			    }
			    if(path.indexOf("买断式回购列表")!=-1 && "xls".equals(path.substring(path.lastIndexOf(".")+1))){
			    	//列表中加入上清-全额结算指令列表的数据
					backStageTraderInfoList.addAll(processDataOfSHClearingBuyoutRepurchase(path));
			    }
			    if(path.indexOf("全额结算指令列表")!=-1 && "xls".equals(path.substring(path.lastIndexOf(".")+1))){
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
	 * 结算指令下载、结算合同下载excel 进行数据处理（此处只针对中债登首期指令交收状态处理）
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
		backStageTraderStatusDict.put("失败", "20");
		backStageTraderStatusDict.put("逾期完成", "21");
		backStageTraderStatusDict.put("其他", "99");
		
		//交易方向
		String tradeDirection = null;
		//业务标识号(成交编号)
		String vcDealNo = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的结算指令下载表结果集
		Object[] datas = null;
		//查询已经落地的结算合同下载表结果集
		Object[] contractDatas = null;
		//当前交收状态
		String backstageTraderStatus = null;
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		//判断《结算合同下载》中是否有与《结算指令下载》配对的业务编号的标识，
		//ture对应“把数据放入更新实体类列表”，false则不把数据放入更新列表
		Boolean hasMatchedData = true;
		
		//查询已经落地的结算指令下载列表数据，进行解析处理
		datas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryTallyOrder",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//若需要进入《结算合同下载》的，会再进行一次判断
					hasMatchedData = true;
					String checker = "";//复核员
					String confirmer = "";//确认员
					String latestUpdateTime = "";//最近更新时间
					String vcFrstdlvrydt="";//首次交割日（即结算日期）
					String subUpdateTime = "";
					//最近更新时间第70列（BR列），用于筛选掉昨日的数据
					latestUpdateTime = data.getString("latestUpdateTime");
					vcFrstdlvrydt = data.getString("vcFrstdlvrydt");
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					if(latestUpdateTime != null && latestUpdateTime.length()>7){
						subUpdateTime = latestUpdateTime.substring(0, 8);
						//最近更新日期为当天的进行更新，对excel中包含的昨日数据进行筛选
						String today=sdf.format(new Date());
						if(today.equals(subUpdateTime)||today.equals(vcFrstdlvrydt)){//最近更新日期或者结算日期在今天
							tradeDirection = data.getString("tradeDirection");//从第13列（M列）获取买卖方向
							vcDealNo = data.getString("businessId");//从第32列（AF列）获取业务标识号（vcDealNo）单元格可能为数字，需进行类型转换
							//判断成交编号是否为空
							if(!(vcDealNo == null || vcDealNo == "")){
								checker = data.getString("checker");//复核人(62列BK)
								confirmer = data.getString("confirmer");//确认员(63列BL)
								backStageTraderInfo =new BackStageTraderInfo();
								//确定委托方向（C_ENTRUST_DIRECTION：结算指令没有到期，直接取O32成交信息表委托方向），
								temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection", vcDealNo);
								//回购业务的委托方向填入实体放入条件中查询，其他业务不把委托方向作为查询条件
								if(temp.length>0 && temp[0]!=null){
									backStageTraderInfo.setcRepoType(temp[0].toString());
								}else{
									backStageTraderInfo.setcRepoType(null);
								}
								//查看指令表成交状态
								temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchVcBsSetmtStatus", vcDealNo);
								if(temp.length>0&&temp[0]!=null){
									backstageTraderStatus = temp[0].toString();
								}else{
									//指令表如果没查到状态则去查交收表（对于非机器猫下的单在指令表中是查不到的，但交收表中能查到）
									HashMap<String, String> backStatusMap = new HashMap<String, String>();
									backStatusMap.put("entrustDirection", backStageTraderInfo.getcRepoType());
									backStatusMap.put("vcDealNo", vcDealNo);
									temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchBackStatusBySetmtTrace", backStatusMap);
									if(temp.length>0&&temp[0]!=null){
										backstageTraderStatus = temp[0].toString();
									}else{
										backstageTraderStatus =null;
									}
								}
								//如果后台成交状态不在结算合同范围，则进行后续操作
								if(!("09".equals(backstageTraderStatus)||"11".equals(backstageTraderStatus)||"13".equals(backstageTraderStatus)||"14".equals(backstageTraderStatus)
										||"18".equals(backstageTraderStatus)||"20".equals(backstageTraderStatus)||"21".equals(backstageTraderStatus))){
									//根据确认员、复核员是否有值，确定放入实体类的后台交易状态
									if("买".equals(tradeDirection)){
										if(("".equals(checker)||checker==null)&&!("".equals(confirmer)||confirmer==null)){//复核人空，确认人非空
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if(!("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){//复核人非空，确认人空
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认")); 
										}else if(("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方"));//复核人空，确认人空
										}else if(checker!="" && checker!=null && confirmer!="" && confirmer!=null){//“复核人非空，确认人非空”双方都已经确认，此时的后续状态要从“中债-结算合同下载.xlsx”读取
											//查询已经落地的结算指令下载列表数据，进行解析处理
											contractDatas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryTallyContract",data);
											//遍历《结算合同下载》，状态逻辑判断
											if(contractDatas!=null && contractDatas.length>0){
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
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等我方款"));
														}else if("等券".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等对方券，请催对手方"));
														}else if("成功".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("后台已成交"));
														}else if("失败".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("失败"));
														}else if("逾期完成".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("逾期完成"));
														}
														hasMatchedData = true;
													}
												}
											}
										}
									}else if("卖".equals(tradeDirection)){
										if(("".equals(checker)||checker==null)&&!("".equals(confirmer)||confirmer==null)){//复核人空，确认人非空
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认")); 
										}else if(!("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){//复核人非空，确认人空
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if(("".equals(checker)||checker==null)&&("".equals(confirmer)||confirmer==null)){//复核人空，确认人空
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if(checker!=""&&checker!=null&&confirmer!=""&&confirmer!=null){//“复核人非空，确认人非空”表示 双方都已经确认后续状态要从“中债-结算合同下载.xlsx”读取
											//查询已经落地的结算指令下载列表数据，进行解析处理
											contractDatas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryTallyContract",data);
											//遍历《结算合同下载》，状态逻辑判断
											if(contractDatas!=null && contractDatas.length>0){
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
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等对方款，请催对手方"));
														}else if("等券".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等我方券"));
														}else if("成功".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("后台已成交"));
														}else if("失败".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("失败"));
														}else if("逾期完成".equals(contractRemark)){
															backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("逾期完成"));
														}
														hasMatchedData = true;
													}
												}
											}else{
												hasMatchedData = false;
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
										//成交编号
										backStageTraderInfo.setVcDealNo(vcDealNo);
										//将此条更新信息放入列表
										backStageTraderInfoList.add(backStageTraderInfo);
									}
								}
							}
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 中债登结算合同下载 进行数据处理（此处只处理到期指令交收状态）
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfContract(String path){
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
		backStageTraderStatusDict.put("失败", "20");
		backStageTraderStatusDict.put("逾期完成", "21");
		backStageTraderStatusDict.put("其他", "99");
		
		//业务标识号(成交编号)
		String vcDealNo = null;
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的结算指令下载表结果集
		Object[] datas = null;
		//业务类型
		String vcBizTp = null;
		//当前后台成交状态
		String backstageTraderStatus = null;
		//委托方向
		String entrustDirection = null;
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		//判断《结算合同下载》中是否有与《结算指令下载》配对的业务编号的标识，
		//ture对应“把数据放入更新实体类列表”，false则不把数据放入更新列表
		Boolean hasMatchedData = true;
		
		//查询已经落地的结算指令下载列表数据，进行解析处理
		datas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryTallyContract",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					vcBizTp = data.getString("vcBizTp");
					if(vcBizTp.indexOf("到期")!=-1){
						backStageTraderInfo =new BackStageTraderInfo();
						vcDealNo = data.getString("contractBusinessId");//结算合同下载中的业务标识号13列（成交编号）
						//回购业务的委托方向填入实体放入条件中查询，其他业务不把委托方向作为查询条件
						temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection_end", vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							entrustDirection = temp[0].toString();
							backStageTraderInfo.setcRepoType(temp[0].toString());
						}else{
							backStageTraderInfo.setcRepoType(null);
						}
						//从交收表查询后台成交状态
						HashMap<String, String> backStatusMap = new HashMap<String, String>();
						backStatusMap.put("entrustDirection", entrustDirection);
						backStatusMap.put("vcDealNo", vcDealNo);
						//则不放入List中进行更新
						temp=DatabaseExt.queryByNamedSql("default", 
								"com.cjhxfund.ats.sm.comm.fundManage.searchBackStatusBySetmtTrace", 
								backStatusMap);
						if(temp.length>0&&temp[0]!=null){
							backstageTraderStatus = temp[0].toString();
						}else{
							backstageTraderStatus =null;
						}
						//若到期指令现已记录交收状态为09（已交收）、11（担保交收）、13（未成交）不再更新其状态
						if(!("09".equals(backstageTraderStatus)||"11".equals(backstageTraderStatus)||"13".equals(backstageTraderStatus)||"14".equals(backstageTraderStatus)
								||"18".equals(backstageTraderStatus)||"20".equals(backstageTraderStatus)||"21".equals(backstageTraderStatus))){
							String contractRemark = data.getString("contractRemark");//合同状态描述55列
							if("7".equals(entrustDirection)){//正回购到期
								if("等款".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等我方款"));
								}else if("等券".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等对方券，请催对手方"));
								}else if("成功".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("后台已成交"));
								}else if("失败".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("失败"));
								}else if("逾期完成".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("逾期完成"));
								}
								hasMatchedData = true;
							}else if("8".equals(entrustDirection)){//逆回购到期
								if("等款".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等对方款，请催对手方"));
								}else if("等券".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等我方券"));
								}else if("成功".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("后台已成交"));
								}else if("失败".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("失败"));
								}else if("逾期完成".equals(contractRemark)){
									backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("逾期完成"));
								}
								hasMatchedData = true;
							}
							//标识为true的数据，放入实体类
							if(hasMatchedData){
								//后台交易时间
								SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								backStageTraderInfo.setBackStageTraderCd(df.format(new Date()));
								//操作用户为系统管理员
								backStageTraderInfo.setBackStageTraderId("sysadmin");
								backStageTraderInfo.setBackStageTraderName("sysadmin");
								//成交编号
								backStageTraderInfo.setVcDealNo(vcDealNo);
								//将此条更新信息放入列表
								backStageTraderInfoList.add(backStageTraderInfo);
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
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		//当前成交状态
		String backstageTraderStatus = null;
		
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
		datas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryBondTrade",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//获取交易日期(之前excel的第三列)，用于筛选掉昨日的数据
					String setmtDate = data.getString("setmtDate");
					//将excel中取出来的日期类型处理为字符串、并且将其格式和本地日期处理为一致
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					//最近更新时间重日期为当天的进行更新，对excel中包含的昨日数据进行筛选
					if(sdf.format(new Date()).equals(setmtDate)){
						backStageTraderInfo =new BackStageTraderInfo();
						//设置成交编号
						vcDealNo = data.getString("businessId");
						//判断成交编号是否为空
						if(!(vcDealNo == null || vcDealNo == "")){
							//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
							temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection", vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								entrustDirection = temp[0].toString();
							}else{
								entrustDirection =null;
							}
							//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
							temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.queryClordid", vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								clordid = temp[0].toString();
							}else{
								clordid = null;
							}
							//查询后台成交状态，若已经为后续状态（已经从《上清-全额结算指令列表》中获取过状态），
							//则不放入List中进行更新
							temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchVcBsSetmtStatus", vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								backstageTraderStatus = temp[0].toString();
							}else{
								backstageTraderStatus =null;
							}
							//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
							if(!"04".equals(backstageTraderStatus)&&!"05".equals(backstageTraderStatus)&&
									!"06".equals(backstageTraderStatus)&&!"07".equals(backstageTraderStatus)&&
											!"08".equals(backstageTraderStatus)&&!"09".equals(backstageTraderStatus)&&!"11".equals(backstageTraderStatus)&&
											!"10".equals(backstageTraderStatus)&&!"13".equals(backstageTraderStatus)&&!"14".equals(backstageTraderStatus)&&
											!"18".equals(backstageTraderStatus)&&!"20".equals(backstageTraderStatus)&&!"21".equals(backstageTraderStatus)){
								//通过跨域查询能查询到更新后台状态用的clordid以及买卖方向，不为空则进行后续操作
								if(!(clordid == null || clordid== "")&&
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
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认"));
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方已确认，调款中"));
										}
									}
									//委托方向4为债券卖出
									else if("4".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认"));
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方已确认，调款中"));
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
									System.out.println(backStageTraderInfo.toString());
									//将此条更新信息放入列表
									backStageTraderInfoList.add(backStageTraderInfo);
								}else{
									SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
								}
							}
						}else{
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							LogUtil.logInfo("update failed:现券交易列表数据列表更新失败，成交编号为空！  "+df.format(new Date()), null, new Object[]{});
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	
	/**
	 * 上清-质押式回购列表 数据处理（首期）
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfSHClearingPledgedRepo(String path){
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
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		//当前成交状态
		String backstageTraderStatus = null;
		
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
		datas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryPledgeStyleRepo",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//获取成交日期，用于筛选掉昨日的数据
					String setmtDate = data.getString("setmtDate");
					//将excel中取出来的日期类型处理为字符串、并且将其格式和本地日期处理为一致
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					//最近更新时间重日期为当天的进行更新，对excel中包含的昨日数据进行筛选
					if(sdf.format(new Date()).equals(setmtDate)){
						backStageTraderInfo =new BackStageTraderInfo();
						//设置成交编号
						vcDealNo = data.getString("businessId");
						//判断成交编号是否为空
						if(!(vcDealNo == null || vcDealNo == "")){
							//查询委托方向（C_ENTRUST_DIRECTION），6逆回购首期，7正回购到期，5正回购首期，8逆回购到期
							temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection", vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								entrustDirection = temp[0].toString();
							}else{
								entrustDirection =null;
							}
							//回购业务的委托方向填入实体放入条件中查询，其他业务不把委托方向作为查询条件
							if(temp.length>0&&temp[0]!=null&&("5".equals(temp[0].toString())||"6".equals(temp[0].toString())||
									"7".equals(temp[0].toString())||"8".equals(temp[0].toString()))){
								backStageTraderInfo.setcRepoType(temp[0].toString());
							}else{
								backStageTraderInfo.setcRepoType(null);
							}
							//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
							temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.queryClordid", vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								clordid = temp[0].toString();
							}else{
								clordid = null;
							}
							//查询后台成交状态，若已经为后续状态（已经从《上清-全额结算指令列表》中获取过状态），
							//则不放入List中进行更新
							temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchVcBsSetmtStatus", vcDealNo);
							if(temp.length>0&&temp[0]!=null){
								backstageTraderStatus = temp[0].toString();
							}else{
								backstageTraderStatus =null;
							}
							//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
							if(!"04".equals(backstageTraderStatus)&&!"05".equals(backstageTraderStatus)&&
									!"06".equals(backstageTraderStatus)&&!"07".equals(backstageTraderStatus)&&
										!"08".equals(backstageTraderStatus)&&!"09".equals(backstageTraderStatus)&&!"11".equals(backstageTraderStatus)&&
											!"10".equals(backstageTraderStatus)&&!"13".equals(backstageTraderStatus)&&!"14".equals(backstageTraderStatus)
											&&!"18".equals(backstageTraderStatus)&&!"20".equals(backstageTraderStatus)&&!"21".equals(backstageTraderStatus)){
								//通过跨域查询能查询到更新后台状态用的clordid以及买卖方向，不为空则进行后续操作
								if(!(entrustDirection == null || entrustDirection == "")){
									backStageTraderInfo.setClordid(clordid);
									//获取正回购方状态
									buyerStatus = data.getString("buyerStatus");
									//获取逆回购方状态
									sellerStatus = data.getString("sellerStatus");
									//委托方向为逆回购首期、正回购到期
									if("6".equals(entrustDirection)||"7".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认"));
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方已确认，调款中"));
										}
									//委托方向为正回购首期、逆回购到期
									}else if("5".equals(entrustDirection)||"8".equals(entrustDirection)){
										if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认"));
										}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
										}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
											backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方已确认，调款中"));
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
									 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
								}
							}
						}else{
							SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							LogUtil.logInfo("update failed:质押式回购列表数据列表更新失败，成交编号为空！  "+df.format(new Date()), null, new Object[]{});
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	
	/**
	 * 上清-全额结算指令列表 数据处理(由于取数逻辑为：合同结算日期：T日至T日，所以更新后台成交状态的时候不需要过滤昨天的数据)
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
		//后台交收状态
		String backstageTraderStatus = null;
		//業務類型
		String businessType = null;
		String frstorscnd = null;
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		
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
		datas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryFullTallyOrder", null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//创建后台成交赋值对象(属性包括：)
					backStageTraderInfo =new BackStageTraderInfo();
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//设置成交编号并且跳过成交编号为空或者成交编号长度小于3的数据
					vcDealNo = data.getString("businessId");
					//判断成交编号是否为空
					if (!(vcDealNo == null || vcDealNo =="")) {
						//查询委托方向（C_ENTRUST_DIRECTION），需跨域查询
						businessType = data.getString("bizTp");
						frstorscnd = data.getString("frstorscnd");
						if(("质押式回购".equals(businessType)&&"到期".equals(frstorscnd)) || ("买断式回购".equals(businessType)&&"到期".equals(frstorscnd))){
							temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection_end", vcDealNo);
						}else{
							temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection", vcDealNo);
						}
						if(temp.length>0&&temp[0]!=null){
							entrustDirection = temp[0].toString();
						}else{
							entrustDirection =null;
						}
						//回购业务的委托方向填入实体放入条件中查询，其他业务不把委托方向作为查询条件
						if(temp.length>0&&temp[0]!=null&&("5".equals(temp[0].toString())||"6".equals(temp[0].toString())||
								"7".equals(temp[0].toString())||"8".equals(temp[0].toString()))){
							backStageTraderInfo.setcRepoType(temp[0].toString());
						}else{
							backStageTraderInfo.setcRepoType(null);
						}
						
						//查询第三方系统指令编号（O32中为VC_SOURCE_NO，交易系统中为CLORDID）
						temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.queryClordid", vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							clordid = temp[0].toString();
						}else{
							clordid = null;
						}
						//从交收表查询后台成交状态
						HashMap<String, String> backStatusMap = new HashMap<String, String>();
						backStatusMap.put("entrustDirection", entrustDirection);
						backStatusMap.put("vcDealNo", vcDealNo);
						//则不放入List中进行更新
						temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchBackStatusBySetmtTrace", backStatusMap);
						if(temp.length>0&&temp[0]!=null){
							backstageTraderStatus = temp[0].toString();
						}else{
							backstageTraderStatus =null;
						}
						//通过跨域查询能查询到更新后台状态用的clordid以及买卖方向，不为空则进行后续操作
						if(!("09".equals(backstageTraderStatus)||"11".equals(backstageTraderStatus)||"13".equals(backstageTraderStatus)||"14".equals(backstageTraderStatus)
								||"18".equals(backstageTraderStatus)||"20".equals(backstageTraderStatus)||"21".equals(backstageTraderStatus))){
							backStageTraderInfo.setClordid(clordid);
							//从H列、I列读取产品结算状态、资金结算状态
							productClearingStatus = data.getString("productClearingStatus");
							fundClearingStatus = data.getString("fundClearingStatus");
							if(!(entrustDirection == null || entrustDirection == "")){
								//委托方向为债券买入、逆回购首期、正回购到期
								if("3".equals(entrustDirection)||"6".equals(entrustDirection)||"7".equals(entrustDirection)){
									if("等券".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等款等券，请催对手方")); 
									}else if("券足".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等我方款")); 
									}else if("等券".equals(productClearingStatus)&&"款足".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等对方券，请催对手方"));
									}else if("成功".equals(productClearingStatus)&&"成功".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("后台已成交"));
									}
								//委托方向为债券卖出、正回购首期、逆回购到期
								}else if("4".equals(entrustDirection)||"5".equals(entrustDirection)||"8".equals(entrustDirection)){
									if("等券".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等款等券，请催对手方")); 
									}else if("券足".equals(productClearingStatus)&&"等款".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等对方款，请催对手方"));
									}else if("等券".equals(productClearingStatus)&&"款足".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("等我方券")); 
									}else if("成功".equals(productClearingStatus)&&"成功".equals(fundClearingStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("后台已成交"));
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
								
								backStatusMap = null;
							}else{
								SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
							}
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
	 * 上清-买断式回购列表 数据处理(由于取数逻辑为：合同结算日期：T-1日至T日，所以更新后台成交状态的时候需要过滤昨天的数据)
	 * @param path excel文件本地存储路径
	 * @return
	 */
	public List<BackStageTraderInfo> processDataOfSHClearingBuyoutRepurchase(String path){
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
		//中间数据查询临时结果集
		Object[] temp = null;
		//查询已经落地的全额结算列表结果集
		Object[] datas = null;
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		//当前成交状态
		String backstageTraderStatus = null;
		
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
		datas=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.queryBuyoutRepurchase",null);
		if(datas !=null){
			if(datas.length >0){
				for(int i=0;i<datas.length;i++){
					//解析每一条全额结算列表数据
					DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					data = (DataObject)datas[i];
					//获取成交日期，用于筛选掉昨日的数据
					String setmtDate = data.getString("setmtDate");
					//将excel中取出来的日期类型处理为字符串、并且将其格式和本地日期处理为一致
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
					//最近更新时间重日期为当天的进行更新，对excel中包含的昨日数据进行筛选
					if(sdf.format(new Date()).equals(setmtDate)){
						backStageTraderInfo =new BackStageTraderInfo();
						//设置成交编号
						vcDealNo = data.getString("businessId");
						//查询委托方向（C_ENTRUST_DIRECTION），6逆回购首期，7正回购到期，5正回购首期，8逆回购到期
						temp=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection", vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							entrustDirection = temp[0].toString();
						}else{
							entrustDirection =null;
						}
						//回购业务的委托方向填入实体放入条件中查询，其他业务不把委托方向作为查询条件
						if(temp.length>0&&temp[0]!=null&&("5".equals(temp[0].toString())||"6".equals(temp[0].toString())||
								"7".equals(temp[0].toString())||"8".equals(temp[0].toString()))){
							backStageTraderInfo.setcRepoType(temp[0].toString());
						}else{
							backStageTraderInfo.setcRepoType(null);
						}
						//查询后台成交状态，若已经为后续状态（已经从《上清-全额结算指令列表》中获取过状态），
						//则不放入List中进行更新
						temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchVcBsSetmtStatus", vcDealNo);
						if(temp.length>0&&temp[0]!=null){
							backstageTraderStatus = temp[0].toString();
						}else{
							backstageTraderStatus =null;
						}
						//若后台成交状态不为后续状态（04、05、06、07、08、09、10），则进行更新
						if(!"04".equals(backstageTraderStatus)&&!"05".equals(backstageTraderStatus)&&
						   !"06".equals(backstageTraderStatus)&&!"07".equals(backstageTraderStatus)&&
						   !"08".equals(backstageTraderStatus)&&!"09".equals(backstageTraderStatus)&&!"21".equals(backstageTraderStatus)&&
						   !"10".equals(backstageTraderStatus)&&!"11".equals(backstageTraderStatus)&&!"13".equals(backstageTraderStatus)&&
						   !"14".equals(backstageTraderStatus)&&!"18".equals(backstageTraderStatus)&&!"20".equals(backstageTraderStatus)){
							if(!(vcDealNo == null || "".equals(vcDealNo))&&
									!(entrustDirection == null || entrustDirection.length() <= 0)){
								//正回购方状态
								buyerStatus = data.getString("buyerStatus");
								//逆回购方状态
								sellerStatus = data.getString("sellerStatus");
								
								//委托方向为逆回购首期、正回购到期
								if("6".equals(entrustDirection)||"7".equals(entrustDirection)){
									if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
									}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
									}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认"));
									}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方已确认，调款中"));
									}
								//委托方向为正回购首期、逆回购到期
								}else if("5".equals(entrustDirection)||"8".equals(entrustDirection)){
									if("待确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方待确认，请催对手方")); 
									}else if("已确认".equals(buyerStatus)&&"待确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("我方待确认"));
									}else if("待确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("对方待确认，请催对手方")); 
									}else if("已确认".equals(buyerStatus)&&"已确认".equals(sellerStatus)){
										backStageTraderInfo.setBackStageTraderStatus(backStageTraderStatusDict.get("双方已确认，调款中"));
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
								//第三方指令编号--买断式回购没有第三方指令编号
								backStageTraderInfo.setClordid("");
								//将此条更新信息放入列表
								backStageTraderInfoList.add(backStageTraderInfo);
							}else{
								SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
								 LogUtil.logInfo("update failed:  "+vcDealNo+"  "+df.format(new Date()), null, new Object[]{});
							}
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 获取需要删除重复数据的交易指令管理表名列表
	 * T_ATS_BS_DISTRIBUTION			分销数据列表 (已经不使用此表)
	 * T_ATS_BS_BOND_TRADE				现券交易列表
	 * T_ATS_BS_PLEDGE_STYLE_REPO		质押式回购列表
	 * T_ATS_BS_BUYOUT_REPURCHASE		买断式回购列表
	 * @return
	 * @author chendi
	 */
	@Bizlet("获取需要删除重复数据的交易指令管理表名数组")
	public DataObject[] getTableNames(){
		//定义数组长度
		int length = 3;
		String tableName = "T_ATS_BS_BOND_TRADE,T_ATS_BS_PLEDGE_STYLE_REPO,T_ATS_BS_BUYOUT_REPURCHASE";
		String[] tableNames = tableName.split(",");
		DataObject[] datas = new DataObject[length];
		DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		for(int i=0;i<length;i++){
			data.setString("vcTableName", tableNames[i]);
			datas[i] = data;
		}
		return datas;
	}
	
	/**
	 * 上清所交易指令管理数据列表处理（只有首期，没有到期）；只针对本地交收状态不在（04、05、06、07、08、09、10）结算和调款中状态进行更新。
	 * 结算状态描述：等我方款04、等对方款，请催对手方05、等我方券06、等对方券，请催对手方07、后台已成交09、等券等款，请催对手方10
	 * 买方状态    卖方状态        后台成交状态---------买入、分销、逆回购首期业务------		    
	 * 待确认0     待确认0         双方待确认，请催对手方03
	 * 已确认4     待确认0         对方待确认，请催对手方02
	 * 待确认0     已确认4         我方待确认01
	 * 已确认4     已确认4         双方已确认，调款中08
	 * 买方状态    卖方状态        后台成交状态---------卖出、正回购首期业务----------		    
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
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		
		//查询O32上清所交易指令管理数据列表
		tradeDatas=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.backStageTrader.queryTradeOrderData",null);
		if(tradeDatas.length>0){
			for(int i=0,l=tradeDatas.length;i<l;i++){
				//创建后台成交赋值对象(属性包括：)
				backStageTraderInfo =new BackStageTraderInfo();
				//解析每一条全额结算列表数据
				DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				data = (DataObject)tradeDatas[i];
				//获取成交编号
				Object vcDealNoObj = data.get("vcSrctradeid");
				if(vcDealNoObj !=null && !"".equals(vcDealNoObj)){
					vcDealNo = vcDealNoObj.toString();
					//确定委托方向（C_ENTRUST_DIRECTION），交易指令没有到期数据：首期指令委托方向可直接取O32成交信息表中的委托方向
					temp=DatabaseExt.queryByNamedSql(dataSource,"com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection",vcDealNo);
					if(temp.length>0&&temp[0]!=null){
						vcEntrustDirection = temp[0].toString();
					}
					//查询当前后台成交状态
					temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchVcBsSetmtStatus", vcDealNo);
					if(temp.length>0&&temp[0]!=null){
						bsStatus = temp[0].toString();
					}else{
						HashMap<String, String> backStatusMap = new HashMap<String, String>();
						backStatusMap.put("entrustDirection", vcEntrustDirection);
						backStatusMap.put("vcDealNo", vcDealNo);
						temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchBackStatusBySetmtTrace", backStatusMap);
						if(temp.length>0 && temp[0]!=null){
						    bsStatus =temp[0].toString();
						}else{
							bsStatus=null;
						}
					}
					//如果当前交收状态为调款中或者结算的状态，无需再更新到确认状态
					if(!"04".equals(bsStatus) && !"05".equals(bsStatus)&&
					   !"06".equals(bsStatus) && !"07".equals(bsStatus)&&
					   !"08".equals(bsStatus) && !"09".equals(bsStatus)&&
					   !"10".equals(bsStatus)&&!"14".equals(bsStatus)&&!"11".equals(bsStatus)&&
					   !"13".equals(bsStatus)&&!"18".equals(bsStatus)&&!"20".equals(bsStatus)&&!"21".equals(bsStatus)){
						if(vcEntrustDirection != null && vcEntrustDirection != ""){
							backStageTraderInfo.setcRepoType(vcEntrustDirection);
							buyerStatus = data.getString("cBuyerstatus");//买方状态:0-待确认、4-已确认
							sellerStatus = data.getString("cSellerstatus");//卖方状态:0-待确认、4-已确认
							Date currentDate=new Date();
							String currentDateStr=DateUtil.format(currentDate, "yyyy-MM-dd");
							String overdueTime=currentDateStr+" "+OVERDUE_TIME;
							//如果未超过16:55(过期)
							if(currentDate.before(DateUtil.parse(overdueTime, "yyyy-MM-dd HH:mm"))){
								//买入、逆回购首期
								if("3".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)){
									if("0".equals(buyerStatus)&&"0".equals(sellerStatus)){//双方待确认，请催对手方03
										backStageTraderInfo.setBackStageTraderStatus("03"); 
									}else if("4".equals(buyerStatus)&&"0".equals(sellerStatus)){//对方待确认，请催对手方02
										backStageTraderInfo.setBackStageTraderStatus("02"); 
									}else if("0".equals(buyerStatus)&&"4".equals(sellerStatus)){//我方待确认01
										backStageTraderInfo.setBackStageTraderStatus("01");
									}else if("4".equals(buyerStatus)&&"4".equals(sellerStatus)){//双方已确认，调款中08
										backStageTraderInfo.setBackStageTraderStatus("08");
									}else if("3".equals(buyerStatus)||"3".equals(sellerStatus)){//作废(我方或卖方确认拒绝)
										backStageTraderInfo.setBackStageTraderStatus("14");
										//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
										backStageTraderInfo.setcRepoType(null);
									}else{
										backStageTraderInfo.setBackStageTraderStatus("99");//其他
									}
									//卖出、正回购首期
								}else if("4".equals(vcEntrustDirection)||"5".equals(vcEntrustDirection)){
									if("0".equals(buyerStatus)&&"0".equals(sellerStatus)){//双方待确认，请催对手方03
										backStageTraderInfo.setBackStageTraderStatus("03"); 
									}else if("4".equals(buyerStatus)&&"0".equals(sellerStatus)){//我方待确认01
										backStageTraderInfo.setBackStageTraderStatus("01");
									}else if("0".equals(buyerStatus)&&"4".equals(sellerStatus)){//对方待确认，请催对手方02
										backStageTraderInfo.setBackStageTraderStatus("02"); 
									}else if("4".equals(buyerStatus)&&"4".equals(sellerStatus)){//双方已确认，调款中08
										backStageTraderInfo.setBackStageTraderStatus("08");
									}else if("3".equals(buyerStatus)||"3".equals(sellerStatus)){//作废(卖方或我方确认拒绝)
										backStageTraderInfo.setBackStageTraderStatus("14");
										//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
										backStageTraderInfo.setcRepoType(null);
									}else{
										backStageTraderInfo.setBackStageTraderStatus("99");//其他
									}
								}
							}else{//如果超过16:55(过期)
								String todayNumberStr=DateUtil.format(currentDate, "yyyyMMdd");
								String settleDateStr=data.getString("lSettlementdate");
								if(("0".equals(buyerStatus)||"0".equals(sellerStatus))&&todayNumberStr.equals(settleDateStr)){//如果结算日期为今天
									backStageTraderInfo.setBackStageTraderStatus("14");//任意一方待确认都置为作废 wzx 2017-11-15
									//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
									backStageTraderInfo.setcRepoType(null);
								//买入、逆回购首期
								}else if("3".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)){
									if("0".equals(buyerStatus)&&"0".equals(sellerStatus)){//双方待确认，请催对手方03
										backStageTraderInfo.setBackStageTraderStatus("03"); 
									}else if("4".equals(buyerStatus)&&"0".equals(sellerStatus)){//对方待确认，请催对手方02
										backStageTraderInfo.setBackStageTraderStatus("02"); 
									}else if("0".equals(buyerStatus)&&"4".equals(sellerStatus)){//我方待确认01
										backStageTraderInfo.setBackStageTraderStatus("01");
									}else if("4".equals(buyerStatus)&&"4".equals(sellerStatus)){//双方已确认，调款中08
										backStageTraderInfo.setBackStageTraderStatus("08");
									}else if("3".equals(buyerStatus)||"3".equals(sellerStatus)){//作废(卖方或我方确认拒绝)
										backStageTraderInfo.setBackStageTraderStatus("14");
										//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
										backStageTraderInfo.setcRepoType(null);
									}else{
										backStageTraderInfo.setBackStageTraderStatus("99");//其他
									}
								//卖出、正回购首期	
								}else if("4".equals(vcEntrustDirection)||"5".equals(vcEntrustDirection)){
									if("0".equals(buyerStatus)&&"0".equals(sellerStatus)){//双方待确认，请催对手方03
										backStageTraderInfo.setBackStageTraderStatus("03"); 
									}else if("4".equals(buyerStatus)&&"0".equals(sellerStatus)){//我方待确认01
										backStageTraderInfo.setBackStageTraderStatus("01");
									}else if("0".equals(buyerStatus)&&"4".equals(sellerStatus)){//对方待确认，请催对手方02
										backStageTraderInfo.setBackStageTraderStatus("02"); 
									}else if("4".equals(buyerStatus)&&"4".equals(sellerStatus)){//双方已确认，调款中08
										backStageTraderInfo.setBackStageTraderStatus("08");
									}else if("3".equals(buyerStatus)||"3".equals(sellerStatus)){//作废(卖方或我方确认拒绝)
										backStageTraderInfo.setBackStageTraderStatus("14");
										//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
										backStageTraderInfo.setcRepoType(null);
									}else{
										backStageTraderInfo.setBackStageTraderStatus("99");//其他
									}
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
							//将此条更新信息放入列表（若将要更新的状态和指令当前状态相同不更新）
							if(backStageTraderInfo.getBackStageTraderStatus()!=null && backStageTraderInfo.getBackStageTraderStatus()!="" && !backStageTraderInfo.getBackStageTraderStatus().equals(bsStatus)){
								backStageTraderInfoList.add(backStageTraderInfo);
							}
						}
					}
				}
			}
		}
		return backStageTraderInfoList;
	}
	
	/**
	 * 上清所全额结算管理数据列表处理；针对本地系统交收状态不在后台已成交（10）、担保交收（11）、未成交(13)进行交收状态更新
	 * 买方状态    卖方状态        后台成交状态---------买入、分销、正回购到期、逆回购首期业务------		    
	 * 等券2         等款2/应履行1        等券等款，请催对手方10
	 * 券足3         等款2             等我方款04
	 * 等券2         款足3             等对方券，请催对手方07
	 * 成功8         成功8             后台已成交09
	 * 失败A     失败 A      作废
	 * 买方状态    卖方状态        后台成交状态---------卖出、正回购首期、逆回购到期业务----------		    
	 * 等券2         等款2/应履行1        等券等款，请催对手方10
	 * 券足2         等款3             等对方款，请催对手方05
	 * 等券3         款足2             等我方券06
	 * 
	 * 成功8         成功8             后台已成交09
	 * 失败A     失败 A      作废
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
		//跨域查询数据源
		String dataSource= CacheUtil.getO32CacheDataSourceName();
		
		//查询O32上清所全额结算数据列表
		fullDatas=DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.ats.sm.comm.backStageTrader.queryFullTallyOrderData",null);
		if(fullDatas.length>0){
			for(int i=0,l=fullDatas.length;i<l;i++){
				//创建后台成交赋值对象(属性包括：)
				backStageTraderInfo =new BackStageTraderInfo();
				//解析每一条全额结算列表数据
				DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				data = (DataObject)fullDatas[i];
				//获取成交编号
				Object vcDealNoObj = data.get("vcSrctradeid");
				if(vcDealNoObj !=null && !"".equals(vcDealNoObj)){
					vcDealNo = vcDealNoObj.toString();
					//确定委托方向（首期直接拿O32成交信息表委托方向，到期取O32待交割到期委托方向）
					if("1".equals(data.getString("cFullordertype"))){
						temp=DatabaseExt.queryByNamedSql(dataSource,"com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection_end",vcDealNo);
						backStageTraderInfo.setBackStageTraderRemark("到期");
					}else{
						temp=DatabaseExt.queryByNamedSql(dataSource,"com.cjhxfund.ats.sm.comm.fundManage.searchEntrustDirection",vcDealNo);
					}
					if(temp.length>0&&temp[0]!=null){
						vcEntrustDirection = temp[0].toString();
					}else{
						vcEntrustDirection =null;
					}
					//查询当后台交收状态
					if("1".equals(data.getString("cFullordertype")) && vcEntrustDirection!=null){//1-到期
						HashMap<String, String> backStatusMap = new HashMap<String, String>();
						backStatusMap.put("entrustDirection", vcEntrustDirection);
						backStatusMap.put("vcDealNo", vcDealNo);
						temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchBackStatusBySetmtTrace", backStatusMap);
					}else{
						temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchVcBsSetmtStatus", vcDealNo);
						if(temp.length==0){
							HashMap<String, String> backStatusMap = new HashMap<String, String>();
							backStatusMap.put("entrustDirection", vcEntrustDirection);
							backStatusMap.put("vcDealNo", vcDealNo);
							temp=DatabaseExt.queryByNamedSql("default", "com.cjhxfund.ats.sm.comm.fundManage.searchBackStatusBySetmtTrace", backStatusMap);
						}
					}
					if(temp.length>0&&temp[0]!=null){
						bsStatus = temp[0].toString();
					}else{
						bsStatus =null;
					}
					//如果当前后台成交状态为调款中或者结算的状态,13为“未成交”，手工置交收时设置
					if(!"09".equals(bsStatus)&&!"11".equals(bsStatus)&&!"13".equals(bsStatus)&&!"14".equals(bsStatus)&&!"18".equals(bsStatus)&&!"20".equals(bsStatus)&&!"21".equals(bsStatus)){
						if(vcEntrustDirection != null && !"".equals(vcEntrustDirection)){
							backStageTraderInfo.setcRepoType(vcEntrustDirection);//委托方向
							productStatus = data.getString("cProductstatus");//产品结算状态:2-等券、3-券足、8-成功
							fundSetStatus = data.getString("cFundsettstatus");//资金结算状态:2-等款、3-款足、8-成功
							//分销、买入、正回购到期、逆回购首期
							if("3".equals(vcEntrustDirection)||"6".equals(vcEntrustDirection)||"7".equals(vcEntrustDirection)){
								if("2".equals(productStatus)&&("2".equals(fundSetStatus)||"1".equals(fundSetStatus))){//等券等款，请催对手方 10
									backStageTraderInfo.setBackStageTraderStatus("10"); 
								}else if("3".equals(productStatus)&&"2".equals(fundSetStatus)){//*等我方款04
									backStageTraderInfo.setBackStageTraderStatus("04"); 
								}else if("2".equals(productStatus)&&"3".equals(fundSetStatus)){//*等对方券，请催对手方07
									backStageTraderInfo.setBackStageTraderStatus("07");
								}else if("8".equals(productStatus)&&"8".equals(fundSetStatus)){//后台已成交09
									backStageTraderInfo.setBackStageTraderStatus("09");
								}else if("A".equals(productStatus)&&"A".equals(fundSetStatus)){//失败
									backStageTraderInfo.setBackStageTraderStatus("14");//失败置为作废 wzx 2017-11-15
									//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
									backStageTraderInfo.setcRepoType(null);
								}else if("1".equals(productStatus)&&productStatus.equals(fundSetStatus)){//应履行
									backStageTraderInfo.setBackStageTraderStatus("16");
								}else if("4".equals(productStatus)&&productStatus.equals(fundSetStatus)){//交割中
									backStageTraderInfo.setBackStageTraderStatus("17");
								}else if("9".equals(productStatus)&&productStatus.equals(fundSetStatus)){//终止
									backStageTraderInfo.setBackStageTraderStatus("18");
								}else if("5".equals(fundSetStatus)){//截止中
									backStageTraderInfo.setBackStageTraderStatus("19");//其他
								}else{
									backStageTraderInfo.setBackStageTraderStatus("99");//其他
								}
							//卖出、正回购首期、逆回购到期
							}else if("4".equals(vcEntrustDirection)||"5".equals(vcEntrustDirection)||"8".equals(vcEntrustDirection)){
								if("2".equals(productStatus)&&("2".equals(fundSetStatus)||"1".equals(fundSetStatus))){//等券等款，请催对手方 10
									backStageTraderInfo.setBackStageTraderStatus("10"); 
								}else if("3".equals(productStatus)&&"2".equals(fundSetStatus)){//*等对方款，请催对手方05
									backStageTraderInfo.setBackStageTraderStatus("05");
								}else if("2".equals(productStatus)&&"3".equals(fundSetStatus)){//*等我方券06
									backStageTraderInfo.setBackStageTraderStatus("06"); 
								}else if("8".equals(productStatus)&&"8".equals(fundSetStatus)){//后台已成交09
									backStageTraderInfo.setBackStageTraderStatus("09");
								}else if("A".equals(productStatus)&&"A".equals(fundSetStatus)){//失败
									backStageTraderInfo.setBackStageTraderStatus("14");//失败置为作废 wzx 2017-11-15
									//如果是作废则更新交收表中成交编号匹配的数据,不加委托方向，因为如果是回购则把首期与到期一起作废了（首期与到期的成交编号相同）
									backStageTraderInfo.setcRepoType(null);
								}else if("1".equals(productStatus)&&productStatus.equals(fundSetStatus)){//应履行
									backStageTraderInfo.setBackStageTraderStatus("16");
								}else if("4".equals(productStatus)&&productStatus.equals(fundSetStatus)){//交割中
									backStageTraderInfo.setBackStageTraderStatus("17");
								}else if("9".equals(productStatus)&&productStatus.equals(fundSetStatus)){//终止
									backStageTraderInfo.setBackStageTraderStatus("18");
								}else if("5".equals(fundSetStatus)){//截止中
									backStageTraderInfo.setBackStageTraderStatus("19");//其他
								}else{
									backStageTraderInfo.setBackStageTraderStatus("99");//其他
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
							//将此条更新信息放入列表
							if(backStageTraderInfo.getBackStageTraderStatus()!=null && backStageTraderInfo.getBackStageTraderStatus()!="" && !backStageTraderInfo.getBackStageTraderStatus().equals(bsStatus)){
								backStageTraderInfoList.add(backStageTraderInfo);
							}
						}
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
}