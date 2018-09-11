/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.util.ArrayList;
import java.util.List;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFActivityInstManager;
import com.primeton.workflow.api.WFServiceException;

import commonj.sdo.DataObject;

/**
 * @author 陈迪
 * @date 2017-01-17 12:50:58
 *
 */
@Bizlet("")
public class FundSetmtTraceManage {
	/***
	 * 协议式回购当前质押券手工置交收的后台成交状态获取
	 * @param data
	 * @return
	 * @author chendi
	 */
	@Bizlet("")
	public String getBsFinishStatus(DataObject data){
		//是否全部成交
		boolean finish = false;
		//是否全部未成交
		boolean unfinished = false;
		//单个质押券成交状态定义
		String status = "";
		//结果指令表成交状态定义
		String vcBsDealStatus = null;
		//计数器，统计部分成交数据
		int k=0;
		//查询在途回购质押券表数据
		Object[] finishStatus = DatabaseExt.queryByNamedSql("default",
				"com.cjhxfund.ats.sm.comm.fundManage.queryBsDealIdList",data);
		DataObject db = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		//得到成交状态的boolean值
		if(finishStatus.length>0 && finishStatus[0]!=null){
			for(int i=0;i<finishStatus.length;i++){
				db = (DataObject)finishStatus[i];
				if(!"".equals(db.getString("vcBsDealStatus")) && db.get("vcBsDealStatus")!=null){
					status = db.get("vcBsDealStatus").toString().trim();
				}else{
					status = null;
				}
				if("09".equals(status)||"11".equals(status)){
					finish = true;
					k++;
				}else{
					finish = false;
				}
				if("13".equals(status)){
					unfinished = true;
				}else{
					unfinished = false;
				}
			}
		}
		//获取成交状态
		if(finish){
			//全部成交
			vcBsDealStatus = "09";
		}
		if(unfinished){
			//未成交
			vcBsDealStatus = "13";
		}
		if(k>0 && k<finishStatus.length){
			//部分成交
			vcBsDealStatus = "12";
		}
		return vcBsDealStatus;
	}
	/***
	 * 判断协议式回购当前质押券是否全部前台成交，如果全部前台成交(vcFsDealStatus==1)，否则(vcFsDealStatus==null)
	 * @param data
	 * @return
	 * @author chendi
	 */
	@Bizlet("")
	public DataObject getFsfinishStatus(DataObject data){
		DataObject fsDealInfo = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		//单个质押券成交状态定义
		String dealStatus = "-1";//-1:未成交    0:部分成交   1:全部成交
		StringBuilder vcFsDealNo = new StringBuilder();
		//查询在途回购质押券表数据
		Object[] finishStatus = DatabaseExt.queryByNamedSql("default",
				"com.cjhxfund.ats.sm.comm.fundManage.queryBsDealIdList",data);
		DataObject db = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		//得到成交状态的boolean值
		if(finishStatus.length>0 && finishStatus[0]!=null){
			for(int i=0;i<finishStatus.length;i++){
				db = (DataObject)finishStatus[i];
				if(!"".equals(db.getString("vcBsDealId")) && db.get("vcBsDealId")!=null)
					if(vcFsDealNo == null || vcFsDealNo.length()==0){
						vcFsDealNo.append(db.getString("vcBsDealId"));
					}else{
						vcFsDealNo.append(","+db.getString("vcBsDealId"));
					}
			}
			if(vcFsDealNo.toString().split(",").length > 0 && vcFsDealNo.toString().split(",").length != finishStatus.length){
				dealStatus = "0";
			}else if(vcFsDealNo.toString().split(",").length == finishStatus.length){
				dealStatus = "1";
			}
		}
		fsDealInfo.setString("vcFsDealStatus", dealStatus);
		fsDealInfo.setString("vcFsDealId", vcFsDealNo.toString());
		return fsDealInfo;
	}
	/***
	 * O32委托方向转换成本币系统对应的委托方向
	 * @param inParam 转换前的委托方向(O32委托方向)
	 * @return 转换后的委托方向
	 * @author chendi
	 */
	@Bizlet("O32委托方向转换成本币系统")
	public String convertEntrustDirectionToLocal(String inParam){
		String outParam = null;
		try{
			switch(Integer.parseInt(inParam)){
				case 3:				//银行间债券买入
					outParam = "01";
					break;
				case 4:				//银行间债券卖出
					outParam = "02";
					break;
				case 5:				//银行间融资回购
					outParam = "03";
					break;
				case 6:				//银行间融券回购
					outParam = "04";
					break;
				case 15:			//交易所融资回购
					outParam = "03";
					break;
				case 16:			//交易所融券回购
					outParam = "04";
					break;
			}
		}catch(NumberFormatException e){
			e.printStackTrace();
			System.out.println("委托方向转换出错，转换前的委托方向不为整数");
		}
		return outParam;
	}
	/***
	 * 本币系统对应的委托方向转化成O32委托方向
	 * @param inParam 转换前的委托方向(O32委托方向)
	 * @return 转换后的委托方向
	 * @author chendi
	 */
	@Bizlet("")
	public String convertEntrustDirectionToO32(String inParam){
		String outParam = null;
		try{
			switch(Integer.parseInt(inParam)){
				case 3:				//银行间债券买入
					outParam = "01";
					break;
				case 4:				//银行间债券卖出
					outParam = "02";
					break;
				case 5:				//银行间融资回购
					outParam = "03";
					break;
				case 6:				//银行间融券回购
					outParam = "04";
					break;
				case 15:			//交易所融资回购
					outParam = "03";
					break;
				case 16:			//交易所融券回购
					outParam = "04";
					break;
			}
		}catch(NumberFormatException e){
			e.printStackTrace();
			System.out.println("委托方向转换出错，本币系统委托方向不为整数");
		}
		return outParam;
	}
	
	/***
	 * 获取到前台成交额数据之后，先进行重复数据判断，如果资金交收跟踪管理表已经存在，则不对其进行重复交收和后续的操作
	 * @param info 定时轮询到的前台成交数据列表
	 * @return 去重后新的前台成交数据列表
	 * @author chendi
	 */
	@Bizlet("")
	public DataObject[] getNewFsList(DataObject[] info){
		String dealNo = "'";
		//拼接成交编号(用于查询已经存在资金交收跟踪管理的数据)作为查询条件
		for(int i=0;i<info.length;i++){
			if(i==info.length-1){
				dealNo = dealNo.concat(info[i].getString("vcFsDealId")+"'");
			}else{
				dealNo = dealNo.concat(info[i].getString("vcFsDealId")+"','");
			}
		}
		//查询本次扫描的前台成交数据中存在资金交收表的数据
		Object[] fundSetmtTraces = (Object[])DatabaseExt.queryByNamedSql("default",
				"com.cjhxfund.ats.sm.comm.fundManage.queryFundSetmtTraceByDealNoList",dealNo);
		//创建List接收不重复的自己交收数据
		List<DataObject> list = new ArrayList<DataObject>();
		DataObject fund = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		//将不存在资金交收表的数据作为新的列表存储起来
		for(int j=0;j<info.length;j++){
			boolean isSame = false;
			for(int jj=0;jj<fundSetmtTraces.length;jj++){
				fund = (DataObject)fundSetmtTraces[jj];
				if((info[j].getString("vcFsDealId").equals(fund.getString("vcDealNo")))){
					isSame = true;
					break;
				}
			}
			if(isSame){
				continue;
			}
			list.add(info[j]);
		}
		//将list转换为数组
		if(list.size()>0){
			return (DataObject[])list.toArray(new DataObject[list.size()]);
		}else{
			return null;
		}
	}
	
	/***
	 * 推动流程
	 * @param processInstID 流程实例id，activityDefID 活动实例id
	 * @return 
	 * @author chendi
	 */
	@Bizlet("完成流程实例")
	public void finishActivityInst(Long processInstID, String activityDefID) throws WFServiceException{
		BPSServiceClientFactory.getLoginManager().setCurrentUser("sysadmin", "sysadmin"); 
		IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
		IWFActivityInstManager activityInstManager = client.getActivityInstManager(); 
		activityInstManager.finishActivityInstByActivityID(processInstID,activityDefID); 
	}
	
	/***
	 * 根据交收状态判断指令状态
	 * @param information交收指令信息
	 * @return 
	 * @author chendi
	 */
	@Bizlet("根据交收状态判断指令状态")
	public DataObject assertInstructFromStetmt(DataObject information){
		String vcBsDealStatus = information.getString("vcBsDealStatus");
		if("09".equals(vcBsDealStatus) || "11".equals(vcBsDealStatus)){//09-后台已成交、 11-担保交收
			information.set("vcProcessStatus", "9");
		}else if("13".equals(vcBsDealStatus)){
			information.set("cIsValid", "4");
		}
		return information;
	}
	
	/***
	 * 获取业务类别
	 * @param data O32前台扫描源数据
	 * @return ATS统一的业务类别
	 * @author chendi
	 */
	@Bizlet("")
	public String getBizType(DataObject data){
		//
		String cEntrustDirection = data.get("cEntrustDirection").toString();
		String vcMarket = data.get("vcMarket").toString();
		String cBusinClass = data.get("cBusinClass").toString();
		String bizType = null;
		//银行间二级交易
		if(("3".equals(cEntrustDirection) || "4".equals(cEntrustDirection)) 
			 && "2".equals(cBusinClass) && "5".equals(vcMarket)){
			bizType = "1";
		}
		//上海大宗交易
		if("E".equals(cBusinClass) && "1".equals(vcMarket)){
			bizType = "2";
		}
		//上海固收平台
		if("I".equals(cBusinClass) && "1".equals(vcMarket)){
			bizType = "3";
		}
		//深圳综合协议平台
		if("E".equals(cBusinClass) && "2".equals(vcMarket)){
			bizType = "4";
		}
		//银行间质押式回购
		if(("5".equals(cEntrustDirection) || "6".equals(cEntrustDirection) 
			 ||"7".equals(cEntrustDirection) ||"8".equals(cEntrustDirection)) 
			 && "2".equals(cBusinClass) && "5".equals(vcMarket)){
			bizType = "5";
		}
		//银行间买断式回购
		if("O".equals(cBusinClass)){
			bizType = "6";
		}
		//上交所协议式回购
		if(("15".equals(cEntrustDirection) || "16".equals(cEntrustDirection) 
			 ||"17".equals(cEntrustDirection) ||"18".equals(cEntrustDirection)) 
			 && "I".equals(cBusinClass) && "1".equals(vcMarket)){
			bizType = "7";
		}
		return bizType;
	}
	
	/***
	 * 字符时间类型转换为long
	 * @param oldDate 传入时间
	 * @return long类型时间
	 * @author chendi
	 */
	@Bizlet("字符时间类型转换为long")
	public long today(String oldDate){
		return Long.valueOf(oldDate);
	}
}
