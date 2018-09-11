package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.IWFRelativeDataManager;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;

@Bizlet("RollbackServiceUtil")
public class RollbackServiceUtil {
	/**
	 * 业务控制添加技术前驱控制，取交集
	 * @param activitys
	 * @param previousActivitys
	 * @return
	 */
	@Bizlet("业务查询和技术查询取交集")
	public static DataObject[] gatherTask(DataObject[] activitys,DataObject[] previousActivitys,DataObject[] bpsAuths,String processDefName,String currentActivityDefID,String processInstID){
		
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		ArrayList<DataObject> previousActivitysList = new ArrayList<DataObject>();
		//去除重复环节
		for(DataObject temp1: previousActivitys){
		    boolean isRecover = false;
			for(DataObject temp2: previousActivitysList){
		    	if(temp1.get("id").equals(temp2.get("id"))&&temp1.get("name").equals(temp2.get("name"))){
		    		isRecover = true;
		    		break;
		    	}
		    }
			if(!isRecover){
				previousActivitysList.add(temp1);
			}
		}
		
		//判断流程名称是否等于开户名称
		if( "com.cjhxfund.fpm.openAccount.openAccount".equals(processDefName)){
			resultList = setAccountBackActs(previousActivitys,currentActivityDefID);
		}
		//判断流程名称是否等于专户储备名称，志文20161216
		if( "com.cjhxfund.fpm.draft.spclProdReserveFlow".equals(processDefName)&&!"manualActivitym1".equals(currentActivityDefID)&&!"manualActivitym31".equals(currentActivityDefID)&&!"manualActivitym3b1".equals(currentActivityDefID)){
			resultList = setSpclResBack(currentActivityDefID);
		}
		//判断流程名称是否等于合同用印名称
		if( "com.cjhxfund.fpm.constractSeal.constractAuditSeal".equals(processDefName)){
			Long id= Long.parseLong(processInstID);
			resultList = setSealBack(currentActivityDefID,id);
		}
		//判断流程名称是否等于一对多产品募集名称
		if( "com.cjhxfund.fpm.onetomanyRaise.onetomanyRaise".equals(processDefName)){
			
			for(int i=0;i<activitys.length;i++){
				DataObject activity = activitys[i];
				String activityName = ((String) activity.get("activitydefid")).split("\\$")[0];
				if(!activityName.contains("P")){
					resultList.add(activity);
				}       
			}
			
		}		
		if(resultList.size()==0){   //执行正常回退控制
			for (int j = 0; j < activitys.length; j++) {
				DataObject activity = activitys[j];
				String targetBpsAuth = getTargetActivityBpsAuth(bpsAuths,activity);   //BpsAuth表中backAuth，-1，0，1
				String keyActivityDefID = getKeyActivityDefID(bpsAuths);
				for (int k = 0; k < previousActivitysList.size(); k++) {
					DataObject preActivity = previousActivitysList.get(k);
					if(activity.get("activitydefid").equals(preActivity.get("id"))//查询出的流程环节是前驱环节，可以回退
							&&isBusActivityDefID(processDefName,targetBpsAuth,currentActivityDefID,activity.getString("activitydefid"),keyActivityDefID)){
						resultList.add(activity);
					}
				}
			}
		}
		
		//判断流程名称是否等于公募注册 by zengjing
		if( "com.cjhxfund.fpm.pubReg.pubRegister".equals(processDefName)){
			resultList = setPubRegBack(resultList);
		}
		//判断流程名称是否等于公募合同用印 by wjh
		if( "com.cjhxfund.fpm.pubSeal.pubSealFlow".equals(processDefName)){
			resultList = setPubSealBack(resultList, currentActivityDefID);
		}
		
		//判断流程名称是否等于合同审核用印 by zengjing
		if( "com.cjhxfund.fpm.constractSeal.constractExtraAuditSeal".equals(processDefName)){
			resultList = setExtraAuditBack(resultList,currentActivityDefID);
		}
		
		//判断流程名称是否等于公募合同用印 by wjh
		if( "com.cjhxfund.fpm.raise.onetooneEstablish.onetooneEstablish".equals(processDefName)){
			resultList = setOTOEstablishBack(resultList,currentActivityDefID);
		}
		
		if(resultList.size()==0) return null;
		return (DataObject[])resultList.toArray(new DataObject[resultList.size()]);
	}
	
	
	
	/**
	 *  账户特殊退办方法
	 * @param previousActivitys
	 * @param currentActivityDefID
	 * @return
	 */
	private static  ArrayList<DataObject> setAccountBackActs(DataObject[] previousActivitys,String currentActivityDefID){
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		boolean ishave = false;
		//对环节的所有前驱活动进行遍历，判断有无活动manualActivitym7（有无补录环节）
		for (int k = 0; k < previousActivitys.length; k++) {
			DataObject previousActivityk = previousActivitys[k];
			String activitydefid  = previousActivityk.get("id").toString();
			if("manualActivitym7".equals(activitydefid)){
				ishave = true;
			}
		}
		//如果有manualActivitym7
		if(ishave == true&&(!"manualActivitym8".equals(currentActivityDefID))&&(!"manualActivitym7".equals(currentActivityDefID))){
			//判断当前环节是否为manualActivitym4，manualActivitym5，manualActivitym6，
			if("manualActivitym4".equals(currentActivityDefID)||"manualActivitym5".equals(currentActivityDefID)||"manualActivitym6".equals(currentActivityDefID)){
				DataObject acitvity1= accountBackAct("manualActivitym7","录入账户信息");
				resultList.add(acitvity1);
				return resultList;
			}
		}
		return resultList;
	}
	
	
	private static ArrayList<DataObject> setSpclResBack(String currentActivityDefID) {
		//如果当前环节不等于确认投资经理或者提交专户储备	
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		DataObject acitvity1= accountBackAct("manualActivitym1","提交专户储备");
		resultList.add(acitvity1);
		return resultList;
	}
	
	/**	 
	 * 合同审核用印的特殊处理方法
	 * @param sourceList 
	 * @param backActDefId
	 * @param backActDefName
	 * @Date  2016-10-29
	 * @Author fanghb
	 */
	private static  ArrayList<DataObject> setSealBack(String currentActivityDefID,long processInstID){
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		//判断当前环节是否为manualActivitym10
		if("manualActivitym10".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym4","产品经理征求意见");
			DataObject acitvity2= accountBackAct("manualActivitym9","会签");
			resultList.add(acitvity1);
			resultList.add(acitvity2);
			return resultList;
			
			//manualActivitym12,manualActivitym2,manualActivitym15
		}else if("manualActivitym12".equals(currentActivityDefID)||"manualActivitym2".equals(currentActivityDefID)||"manualActivitym15".equals(currentActivityDefID)){
			if("manualActivitym2".equals(currentActivityDefID)){
				try {
					IWFRelativeDataManager dataManager = ServiceFactory.getWFRelativeDataManager();
					Object obj=dataManager.getRelativeData(processInstID, "isConferenceReview");
					if(null==obj){
						DataObject acitvity1= accountBackAct("manualActivitym1","提交用印材料");
						resultList.add(acitvity1);
						return resultList;
					}
					String isConferenceReview=obj.toString();
					//是否需要合规、运营、风控会审，为否的时候，退办到第二个节点
					if(isConferenceReview.equals("N")){
						DataObject acitvity1= accountBackAct("manualActivitym12","复核用印材料");
						resultList.add(acitvity1);
						return resultList;
					}else{
						DataObject acitvity1= accountBackAct("manualActivitym14","产品经理征求意见并提交用印材料定稿");
						resultList.add(acitvity1);
						return resultList;
					}
					
				} catch (WFServiceException e) {
					e.printStackTrace();
				}
			}
			currentActivityDefID=currentActivityDefID.replaceAll("manualActivitym", "");
			int index=Integer.parseInt(currentActivityDefID);
			if(index==12){//如果活动id为12				
				DataObject acitvity1= accountBackAct("manualActivitym1","提交用印材料");
				resultList.add(acitvity1);
			}else{//退上一个环节
				DataObject acitvity1= accountBackAct("manualActivitym4","产品经理征求意见");
				resultList.add(acitvity1);
			}
		}

		return resultList;
	}
	
	
	/**
	 * 查询权限表中的权限逻辑
	 * @param bpsAuths
	 * @param activity
	 * @return
	 */
	private static String getTargetActivityBpsAuth(DataObject[] bpsAuths,DataObject activity) {
		String bpsAuth = null;
		for (DataObject bpsObj : bpsAuths) {
			if(bpsObj.get("activityDefId").equals(activity.get("activitydefid"))){
				bpsAuth =  bpsObj.get("backAuth").toString();
			}
		}
		return bpsAuth;
	}
	
	/**
	 * 获取bps权限为1的关键活动定义
	 * @param bpsAuths
	 * @param activity
	 * @return
	 */
	private static String getKeyActivityDefID(DataObject[] bpsAuths) {
		String keyActivityDefID = null;
		int keynum = 0;
		for (DataObject bpsObj : bpsAuths) {
			int activityNum = 0;
			//System.out.println(bpsObj.get("backAuth")+"||"+bpsObj.get("backAuth").toString().equals("1"));
			if(bpsObj.get("backAuth").toString().equals("1")){
				String activityDefId = (String) bpsObj.get("activityDefId");
				activityDefId = activityDefId.replace("manualActivity", "");//去manualActivity前缀
				activityDefId = activityDefId.replace("m", "");//去m前缀
				activityNum = Integer.parseInt(activityDefId);
				if(activityNum>keynum){
					keyActivityDefID = bpsObj.get("activityDefId").toString();
				}
			}
		}
		return keyActivityDefID;
	}
	
	
	/**
	 * 通过业务规则筛选可回退的活动ID
	 * @param processDefName
	 * @param currentActivityDefID 当前流程所处环节
	 * @param targetActivityDefID 要过滤的流程环节
	 * @return
	 */
	private static boolean isBusActivityDefID(String processDefName,String targetBpsAuth,String currentActivityDefID,String targetActivityDefID,String keyActivityDefID){
		boolean result = true;
		
		if(targetBpsAuth!=null&&targetBpsAuth.equals("-1")){//该环节不可回退
			result = false;
		}
		
		if(keyActivityDefID!=null&&!keyActivityDefID.equals("")){//该环节执行后，之前的环节不可回退
			currentActivityDefID = currentActivityDefID.replace("manualActivity", "");//去manualActivity前缀
			targetActivityDefID = targetActivityDefID.replace("manualActivity", "");//去manualActivity前缀
			keyActivityDefID = keyActivityDefID.replace("manualActivity", "");//去manualActivity前缀
			
			String  currentDefID = currentActivityDefID.replace("m", "");//去m前缀
			if(currentDefID.length()>1) currentDefID = currentDefID.substring(0, 1); //去a1/b1后缀
			String targetDefID = targetActivityDefID.replace("m", "");//去m前缀
			if(targetDefID.length()>1) targetDefID = targetDefID.substring(0, 1); //去a1/b1后缀
			String keyDefID = keyActivityDefID.replace("m", "");//去m前缀
			if(keyDefID.length()>1) keyDefID = keyDefID.substring(0, 1); //去a1/b1后缀
			
			int currentDefIDIDnum = Integer.parseInt(currentDefID);
			int targetDefIDNum = Integer.parseInt(targetDefID);
			int keyDefIDNum = Integer.parseInt(keyDefID);
			
			if(currentDefIDIDnum > keyDefIDNum && targetDefIDNum <= keyDefIDNum){
				result = false;
			}
			//System.out.println(currentDefIDIDnum+"|"+targetDefIDNum+"|"+result);
		}
		
		return result;
	}
	
	/**
	 * 合同审核用印退办环节的逻辑
	 * 只获取上一环节
	 * @param sourceList 已过滤的退办list
	 * @return
	 */
	private static ArrayList<DataObject> setExtraAuditBack(ArrayList<DataObject> sourceList,String currentActivityDefID) {
		//获取第一个
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		//2,3,4,7,9,13,18 加最后一个环节
		if("manualActivity02".equals(currentActivityDefID)||"manualActivity03".equals(currentActivityDefID)||"manualActivity04".equals(currentActivityDefID)
			||"manualActivity07".equals(currentActivityDefID)||"manualActivity09".equals(currentActivityDefID)||"manualActivity13".equals(currentActivityDefID)
			||"manualActivity18".equals(currentActivityDefID)){
			if(sourceList.size()>0){
				resultList.add(sourceList.get(0));
			}
		}
		//2,3,4,6,7 加第一个环节
		if("manualActivity02".equals(currentActivityDefID)||"manualActivity03".equals(currentActivityDefID)||"manualActivity04".equals(currentActivityDefID)
			||"manualActivity06".equals(currentActivityDefID)||"manualActivity07".equals(currentActivityDefID)){
			if(sourceList.size()>0&&!sourceList.get(0).get("activitydefid").equals("manualActivity01")){//避免重复添加
				DataObject acitvity1= accountBackAct("manualActivity01","提交用印材料");
				resultList.add(acitvity1);
			}
		}
		return resultList;
	}
	
	/**
	 * 公募注册获取退办环节的逻辑
	 * 只获取上一环节
	 * @param sourceList 已过滤的退办list
	 * @return
	 */
	private static ArrayList<DataObject> setPubRegBack(ArrayList<DataObject> sourceList) {
		//获取第一个
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		if(sourceList.size()>0){
			resultList.add(sourceList.get(0));
		}
		return resultList;
	}
	
	
	/**
	 * 公募合同获取退办环节的逻辑
	 * @param sourceList 已过滤的退办list
	 * @param currentActivityDefID 当前环节名
	 * @return
	 */
	private static ArrayList<DataObject> setPubSealBack(ArrayList<DataObject> sourceList,String currentActivityDefID) {
		if(sourceList.size()==0)return sourceList;
		//获取第一个
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		if("manualActivity07".equals(currentActivityDefID)||"manualActivity11".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivity03","汇总意见并修改基金合同/托管协议");
			DataObject acitvity2= accountBackAct("manualActivity06","汇总意见并修改招募说明书等其他文件");
			resultList.add(acitvity1);
			resultList.add(acitvity2);
		} else {
			int i = 0;
			String activitydefid = sourceList.get(i).getString("activitydefid");
			if("manualActivity08".equals(activitydefid)) i++;
			if(sourceList.size()>0){
				resultList.add(sourceList.get(i));
			}
		}
		return resultList;
	}
	
	/**
	 * 一对一成立退办环节的逻辑
	 * @param currentActivityDefID 当前环节名
	 * @return
	 */
	private static ArrayList<DataObject> setOTOEstablishBack(ArrayList<DataObject> sourceList,String currentActivityDefID) {
		//获取第一个
		ArrayList<DataObject> resultList = new ArrayList<DataObject>();
		if("manualActivitym02".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym01","起草节点");
			resultList.add(acitvity1);
		} else if("manualActivitym10".equals(currentActivityDefID)){
			DataObject acitvity01= accountBackAct("manualActivitym01","起草节点");
			DataObject acitvity02= accountBackAct("manualActivitym02","直线领导审批");
			DataObject acitvity1= accountBackAct("manualActivitym07","反馈起始运作时间");
			DataObject acitvity2= accountBackAct("manualActivitym08","投资经理确认节点");
			DataObject acitvity3= accountBackAct("manualActivitym09","交易参数准备");
			resultList.add(acitvity01);
			resultList.add(acitvity02);
			resultList.add(acitvity1);
			resultList.add(acitvity2);
			resultList.add(acitvity3);
		} else if("manualActivitym09".equals(currentActivityDefID)){
			DataObject acitvity01= accountBackAct("manualActivitym01","起草节点");
			DataObject acitvity02= accountBackAct("manualActivitym02","直线领导审批");
			DataObject acitvity1= accountBackAct("manualActivitym07","反馈起始运作时间");
			DataObject acitvity2= accountBackAct("manualActivitym08","投资经理确认节点");
			resultList.add(acitvity01);
			resultList.add(acitvity02);
			resultList.add(acitvity1);
			resultList.add(acitvity2);
		} else if("manualActivitym08".equals(currentActivityDefID)){
			DataObject acitvity01= accountBackAct("manualActivitym01","起草节点");
			DataObject acitvity02= accountBackAct("manualActivitym02","直线领导审批");
			DataObject acitvity1= accountBackAct("manualActivitym07","反馈起始运作时间");
			resultList.add(acitvity01);
			resultList.add(acitvity02);
			resultList.add(acitvity1);
		} else if("manualActivitym07".equals(currentActivityDefID)){
			DataObject acitvity01= accountBackAct("manualActivitym01","起草节点");
			DataObject acitvity02= accountBackAct("manualActivitym02","直线领导审批");
			resultList.add(acitvity01);
			resultList.add(acitvity02);
		} else if("manualActivitym14".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym13","权限审批节点");
			resultList.add(acitvity1);
		} else if("manualActivitym21".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym19","交易支持主管审批");
			DataObject acitvity2= accountBackAct("manualActivitym20","起始运作通知书用印");
			resultList.add(acitvity1);
			resultList.add(acitvity2);
		} else if("manualActivitym20".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym19","交易支持主管审批");
			resultList.add(acitvity1);
		} else if("manualActivitym34".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym25","发送估值表-估值表权限设置");
			DataObject acitvity2= accountBackAct("manualActivitym26","客服审核");
			resultList.add(acitvity1);
			resultList.add(acitvity2);
		} else if("manualActivitym26".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym25","发送估值表-估值表权限设置");
			resultList.add(acitvity1);
		} else if("manualActivitym28".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym27","补录起始运作信息");
			DataObject acitvity2= accountBackAct("manualActivitym33","复核备案系统及到期日");
			resultList.add(acitvity1);
			resultList.add(acitvity2);
		} else if("manualActivitym33".equals(currentActivityDefID)){
			DataObject acitvity1= accountBackAct("manualActivitym27","补录起始运作信息");
			resultList.add(acitvity1);
		} 
		if(resultList.size()==0){
			resultList.addAll(sourceList);
		}
		return resultList;
	}
	
	
	/**
	 * 账户特殊退办方法
	 * @param backActDefId
	 * @param backActDefName
	 * @return
	 */
	private static DataObject accountBackAct(String backActDefId,String backActDefName){
		DataObject acitvity = DataObjectUtil.createDataObject("com.eos.workflow.data.WFActivityInst");
		acitvity.setString("activitydefid", backActDefId);
		acitvity.setString("activityinstname", backActDefName);
		return acitvity;
	}
	
	@Bizlet
	public static String getActivity(String currentActivityDefID){
		String result = currentActivityDefID.split("\\$")[0];
		return result;
		
	}
}
