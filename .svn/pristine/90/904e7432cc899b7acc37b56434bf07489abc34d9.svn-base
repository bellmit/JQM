/**
 * 
 */
package com.cjhxfund.foundation.fix;

import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import quickfix.Field;
import quickfix.FieldNotFound;
import quickfix.Group;
import quickfix.IncorrectDataFormat;
import quickfix.IncorrectTagValue;
import quickfix.Message;
import quickfix.SessionID;
import quickfix.StringField;
import quickfix.UnsupportedMessageType;

import com.cjhxfund.ats.fm.instr.ApplyInstUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.ProductUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFActivityInstManager;
import com.eos.workflow.api.IWFProcessInstManager;
import com.eos.workflow.api.IWFRelativeDataManager;
import com.eos.workflow.data.WFProcessInst;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.eos.foundation.database.DatabaseExt;

import commonj.sdo.DataObject;

/**
 * Fix消息公共处理类
 * @author huangmizhi
 * @date 2016-06-27 09:54:29
 */
@Bizlet("")
public class FixToMsgUtil {
	
	/**
	 * 根据报文编号获取报文头消息内容
	 * @param message 报文
	 * @param fieldNum 报文编号
	 * @return
	 * @author huangmizhi
	 */
	public static String getHeaderFieldValue(Message message, int fieldNum){
		String result = "";
		try {
			result = message.getHeader().isSetField(fieldNum) ? message.getHeader().getString(fieldNum) : "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 根据报文编号获取报文内容
	 * @param message 报文
	 * @param fieldNum 报文编号
	 * @return
	 * @author huangmizhi
	 */
	public static String getFieldValue(Message message, int fieldNum) throws Exception{
		String result = "";
		try {
			result = message.isSetField(fieldNum) ? message.getString(fieldNum) : "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 使用指定编码解码报文信息
	 * @param message 报文信息
	 * @param charsetName 编码格式，默认为：GBK
	 * @throws Exception
	 * @author huangmizhi
	 */
	public static void decodeMessage(Message message, String charsetName) throws Exception{
		if(StringUtils.isEmpty(charsetName)){
			charsetName = "GBK";//默认使用GBK解码
		}
		Iterator<?> it = message.iterator();
		while(it.hasNext()){
			Field<?> field = (Field<?>) it.next();
			message.setString(field.getField(), new String(message.getString(field.getField()).getBytes("ISO-8859-1"), charsetName)); 
			if(message.hasGroup(field.getField())){
				System.out.println(message.getGroupCount(field.getField()));
				for(int i=1; i <= message.getGroupCount(field.getField()); i++){
					Group group = message.getGroup(i, field.getField());
					Iterator<?> it_group = group.iterator();
					while(it_group.hasNext()){
						Field<?> field_group = (Field<?>) it_group.next();
						group.setString(field_group.getField(), new String(group.getString(field_group.getField()).getBytes("ISO-8859-1"), charsetName)); 
					}
				}
			}
		}	
	}
	
	/**
	 * 解析接收到的报文并插入数据库
	 * @param msg 报文消息
	 * @param sessionID 会话ID
	 * @param msgType 消息类型
	 * @throws FieldNotFound
	 * @throws IncorrectDataFormat
	 * @throws IncorrectTagValue
	 * @throws UnsupportedMessageType
	 * @throws Exception
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void myFromApp(Message msg, SessionID sessionID, String msgType) throws FieldNotFound, IncorrectDataFormat, IncorrectTagValue, UnsupportedMessageType, Exception {
		decodeMessage(msg, null);//使用指定编码解码报文信息
		System.out.println(DateUtil.currentDateTimeString()+msgType+" fromApp 开始...\n" + msg);
		
		//创建返回接口数据对象
		DataObject fixReceiveMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixReceiveMsg");
		//报文重复组列表
		List<DataObject> repeatGroupList = new ArrayList<DataObject>();
		
		System.out.println("==================================================================");
		Iterator<?> it = msg.iterator();
		while(it.hasNext()){
			Field<?> field = (Field<?>) it.next();
			//System.out.println("getField =="+field.getField() +""+field.getTag() +""+field.getObject() +" "+field.toString());
			System.out.println("Fix指令成交反馈："+field.getTag()+"              "+field.getObject());
			
			//获取FIX接口tag值
			int fieldId = field.getTag();
			//将返回的报文封装进对象
			fixReceiveMsgToDataObject(fixReceiveMsg, repeatGroupList, fieldId, field, msg);
		}
		System.out.println("==================================================================");
		
		
		/**
		 * 以下是封装报文头属性对象
		 * */
		//获取定义在Header中的消息类型，并设置到对象中
		fixReceiveMsg.setString("vcMsgtype", getHeaderFieldValue(msg, 35)); //消息类型
		//获取定义在Header中的消息类型，并设置到对象中
		fixReceiveMsg.setString("vcSendersubid", getHeaderFieldValue(msg, 50)); //传入时的指令下达人编号
		//获取定义在Header中的消息类型，并设置到对象中
		fixReceiveMsg.setString("vcSendercompid", getHeaderFieldValue(msg, 49)); //发送方ID，通过引擎配置得到
		//获取定义在Header中的消息类型，并设置到对象中
		fixReceiveMsg.setString("vcTargetcompid", getHeaderFieldValue(msg, 56)); //接受方ID，通过引擎配置得到
		
		//记录插入数据时间
		fixReceiveMsg.setDate("dCreated", DateUtil.getDate());
		//生成主键并保存数据
		DatabaseExt.getPrimaryKey(fixReceiveMsg);
		
		//当tag14058存在反馈数据时解析出风控信息并记录到表中
		if(fixReceiveMsg.getString("vcFailreason")!=null){
			splitFailReasonRisk(fixReceiveMsg.getString("vcFailreason"),fixReceiveMsg.getString("vcClordid"), fixReceiveMsg.getLong("lMsgId"));
		}
		//循环保存返回数据重复组
		for(int i=0; i<repeatGroupList.size(); i++){
			DataObject fixReceiveRepeatGroup = repeatGroupList.get(i);
			fixReceiveRepeatGroup.setLong("lMsgId", fixReceiveMsg.getLong("lMsgId"));
			
			//保存重复组数据
		    DatabaseExt.getPrimaryKey(fixReceiveRepeatGroup);
		    DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, fixReceiveRepeatGroup);
		    
		    if((fixReceiveRepeatGroup.getString("vcRiskout")!=null || fixReceiveRepeatGroup.getString("vcRiskout")!="") && "7".equalsIgnoreCase(fixReceiveMsg.getString("vcProcetype"))){
		    	 DataObject fixReceiveRiskMsg = splitRiskOut(fixReceiveRepeatGroup.getString("vcRiskout"));
		    	 fixReceiveRiskMsg.setString("lDate", DateUtil.currentDateString(DateUtil.YMD_NUMBER));
		    	 fixReceiveRiskMsg.setString("lTime", DateUtil.currentDateString(DateUtil.HMS_PATTERN));
		    	 fixReceiveRiskMsg.setLong("lMsgId", fixReceiveMsg.getLong("lMsgId"));
		    	 fixReceiveRiskMsg.setString("vcClordid", fixReceiveMsg.getString("vcClordid"));
		    	 fixReceiveRiskMsg.setLong("lReceiveRepeatGroupId", fixReceiveRepeatGroup.getLong("lReceiveRepeatGroupId"));
		    	 fixReceiveRiskMsg.setString("cLogSource", "0");//日志来源：0-试算风险；1-正式下达；
		    	 DatabaseExt.getPrimaryKey(fixReceiveRiskMsg);
		    	 DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, fixReceiveRiskMsg);
		    	//清空对象
		    	 fixReceiveRiskMsg = null;
		    }
		    //清空对象
		    fixReceiveRepeatGroup = null;
		}
		DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, fixReceiveMsg);
		//更新流程主表、业务主表状态值
		updateBizTblStatusValue(fixReceiveMsg);
		if("2".equals(fixReceiveMsg.getString("vcProcetype"))){
			System.out.println(DateUtil.currentDateTimeString()+msgType+" 更新二级债等待fix反馈中的业务流程!!!");
			//更新二级债等待fix反馈中的业务流程
			updateInquiryResult(fixReceiveMsg);
		}
		System.out.println(DateUtil.currentDateTimeString()+msgType+" fromApp 结束!!!");
		
		/**
		 * 处理 一级债fix状态回填
		 */
		
		//获取反馈报文状态等信息：Fix指令发送的报文“成功”或者“失败”的状态 && 指令反馈结果情况类型
		DataObject resultDataObject = getExecutionReportStatus(fixReceiveMsg);
		String vcClordid = fixReceiveMsg.getString("vcClordid");
		boolean isSuccess = resultDataObject.getBoolean("isSuccess");//指令发送“成功”或者“失败”的状态
		ApplyInstUtil.fixOutTimeReturn(vcClordid,isSuccess);
	}
	
	/**
	 * 将返回的报文封装进对象
	 * @param fixReceiveMsg 报文对象
	 * @param repeatGroupList 报文重复组列表
	 * @param fieldId 报文编号
	 * @param field 报文属性
	 * @param message 返回的原始报文字符串
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static DataObject fixReceiveMsgToDataObject(DataObject fixReceiveMsg, List<DataObject> repeatGroupList, int fieldId, Field<?> field, Message message){
		/**
		 * 以下是封装报文属性对象
		 * */
		if(fieldId == 15999){
			fixReceiveMsg.setString("vcProcetype", field.getObject().toString()); //处理类型
		}
		if(fieldId == 11){
			fixReceiveMsg.setString("vcClordid", field.getObject().toString()); //第三方指令编号
		}
		if(fieldId == 37){
			fixReceiveMsg.setString("vcOrderid", field.getObject().toString()); //指令下达失败的指令状态
		}
		if(fieldId == 41){
			fixReceiveMsg.setString("vcOrigordid", field.getObject().toString()); //被修改/撤销指令的第三方指令编号
		}
		if(fieldId == 66){
			fixReceiveMsg.setString("vcListid", field.getObject().toString());//第三方系统传过来的清单编号
		}
		if(fieldId == 17){
			fixReceiveMsg.setString("vcExecid", field.getObject().toString());//流水号
		}
		if(fieldId == 19){
			fixReceiveMsg.setString("vcExecrefid", field.getObject().toString()); //要回溯的ExecID，返回指令状态和有效的成交数据时该字段为空。
		}
		if(fieldId == 20){
			fixReceiveMsg.setString("vcExectranstype", field.getObject().toString()); //反馈类型,FIX4.4版本不返回该字段:0 – 普通的反馈;注：固定为0 ;
		}
		if(fieldId == 39){
			fixReceiveMsg.setString("vcOrdstatus", field.getObject().toString()); //指令状态
		}
		if(fieldId == 150){
			fixReceiveMsg.setString("vcExectype", field.getObject().toString()); //执行状态
		}
		if(fieldId == 14008){
			fixReceiveMsg.setString("vcInstructionno", field.getObject().toString()); //O32内部指令序号
		}
		if(fieldId == 13302){
			fixReceiveMsg.setString("vcOperatorname", field.getObject().toString());
		}
		if(fieldId == 137){
			fixReceiveMsg.setString("vcFee", field.getObject().toString()); //费用
		}
		if(fieldId == 139){
			fixReceiveMsg.setString("vcMiscfeetype", field.getObject().toString()); //费用类型
		}
		if(fieldId == 13206){
			fixReceiveMsg.setString("vcReimbamt", field.getObject().toString()); //网下申购、开基申购、认购 退款金额（成交）
		}
		if(fieldId == 13207){
			fixReceiveMsg.setString("vcReimbsettledate", field.getObject().toString()); //网下申购、开基申购、认购 退款日期(成交)
		}
		if(fieldId == 63){
			fixReceiveMsg.setString("vcSettltype", field.getObject().toString()); //清算速度
		}
		if(fieldId == 64){
			fixReceiveMsg.setString("vcFutsettdate", field.getObject().toString()); //交割日（首次交割日）
		}
		if(fieldId == 193){
			fixReceiveMsg.setString("vcFutsettdate2", field.getObject().toString()); //到期交割日
		}
		if(fieldId == 55){
			fixReceiveMsg.setString("vcSymbol", field.getObject().toString()); //证券申报代码
		}
		if(fieldId == 48){
			fixReceiveMsg.setString("vcSecurityid", field.getObject().toString()); //证券申报代码
		}
		if(fieldId == 100){
			fixReceiveMsg.setString("vcExdestination", field.getObject().toString()); //交易市场
		}
		if(fieldId == 54){
			fixReceiveMsg.setString("vcSide", field.getObject().toString()); //买卖方向
		}
		if(fieldId == 1){
			fixReceiveMsg.setString("vcAccount", field.getObject().toString()); //组合编号
		}
		if(fieldId == 44){
			fixReceiveMsg.setString("vcPrice", field.getObject().toString());  //指令价格
		}
		if(fieldId == 38){
			fixReceiveMsg.setString("vcOrderqty", field.getObject().toString());  //指令数量
		}
		if(fieldId == 31){
			fixReceiveMsg.setString("vcLastpx", field.getObject().toString()); //反馈成交信息，当前笔成交价格
		}
		if(fieldId == 32){
			fixReceiveMsg.setString("vcLastshares", field.getObject().toString());  //反馈成交信息，当前笔成交数量
		}
		if(fieldId == 151){
			fixReceiveMsg.setString("vcLeavesqty", field.getObject().toString()); //反馈成交信息，剩余未成交数量
		}
		if(fieldId == 14){
			fixReceiveMsg.setString("vcCumqty", field.getObject().toString());  //反馈成交信息，累计成交数量
		}
		if(fieldId == 6){
			fixReceiveMsg.setString("vcAvgpx", field.getObject().toString());  //反馈成交信息，成交均价
		}
		if(fieldId == 13226){
			fixReceiveMsg.setString("vcIssuedate", field.getObject().toString());  //起息日
		}
		if(fieldId == 14001){
			fixReceiveMsg.setString("vcDealno", field.getObject().toString());  //成交编号
		}
		if(fieldId == 14002){
			fixReceiveMsg.setString("vcDealprice", field.getObject().toString());
		}
		if(fieldId == 14003){
			fixReceiveMsg.setString("vcReportseat", field.getObject().toString()); //申报席位
		}
		if(fieldId == 14004){
			fixReceiveMsg.setString("vcTodaydealamount", field.getObject().toString()); //当日累计成交数量
		}
		if(fieldId == 14005){
			fixReceiveMsg.setString("vcTodaydealbalance", field.getObject().toString()); //当日累计成交金额
		}
		if(fieldId == 14006){
			fixReceiveMsg.setString("vcReportserialno", field.getObject().toString()); //申报编号
		}
		if(fieldId == 14007){
			fixReceiveMsg.setString("vcBusinesstime", field.getObject().toString());  //成交时间
		}
		if(fieldId == 76){
			fixReceiveMsg.setString("vcExecbroker", field.getObject().toString());  //交易对手编号
		}
		if(fieldId == 13204){
			fixReceiveMsg.setString("vcBondsettletype", field.getObject().toString()); //结算方式(首次结算方式)
		}
		if(fieldId == 13208){
			fixReceiveMsg.setString("vcBondsettletype2", field.getObject().toString()); //到期结算方式
		}
		if(fieldId == 13107){
			fixReceiveMsg.setString("vcReporate", field.getObject().toString());  //回购利率
		}
		if(fieldId == 15402){
			fixReceiveMsg.setString("vcNetprice", field.getObject().toString());  //净价价格
		}
		if(fieldId == 159){
			fixReceiveMsg.setString("vcInterest", field.getObject().toString());  //应计利息
		}
		if(fieldId == 15403){
			fixReceiveMsg.setString("vcFullprice", field.getObject().toString());  //全价价格
		}
		if(fieldId == 15404){
			fixReceiveMsg.setString("vcFirstclearbalance", field.getObject().toString());  //首次资金清算额
		}
		if(fieldId == 15405){
			fixReceiveMsg.setString("vcSecondclearbalance", field.getObject().toString());  //到期资金清算额
		}
		if(fieldId == 13101){
			fixReceiveMsg.setString("vcDestsecurity", field.getObject().toString());  //转入证券内码
		}
		if(fieldId == 13102){
			fixReceiveMsg.setString("vcDestqty", field.getObject().toString());  //转入份额
		}
		if(fieldId == 13103){
			fixReceiveMsg.setString("vcDestprice", field.getObject().toString());  //转入净值
		}
		if(fieldId == 13104){
			fixReceiveMsg.setString("vcDestamt", field.getObject().toString());  //转入金额
		}
		if(fieldId == 13105){
			fixReceiveMsg.setString("vcDestfee", field.getObject().toString());  //转入费用
		}
		if(fieldId == 16004){
			fixReceiveMsg.setString("vcErrorcode", field.getObject().toString());  //错误码
		}
		if(fieldId == 16005){
			fixReceiveMsg.setString("vcErrormsg", field.getObject().toString());  //错误消息
		}
		if(fieldId == 14058){
			String failreason = field.getObject().toString();    //获取失败原因
			if(StringUtils.isNotBlank(failreason) && failreason.startsWith("son")){
				failreason = "<FailRea" + failreason;
			}
			fixReceiveMsg.setString("vcFailreason", failreason);
		}
		if(fieldId == 58){
			fixReceiveMsg.setString("vcText", field.getObject().toString());
		}
		
		
		/**
		 * 以下是封装重复组对象
		 * */
		//NoAllocs【只用于银行间回购成交数据】质押券重复组，表示后面的Tag是质押券信息。该Tag的值表示有几个券。
		if(fieldId == 78){
			fixReceiveMsg.setString("vcGroup", message.getGroupCount(fieldId)+"");  //接收重复组数量
			try {
				for(int i=1; i <= message.getGroupCount(fieldId); i++){
					Group group = message.getGroup(i, fieldId);
					DataObject fixReceiveRepeatGroup = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixReceiveRepeatGroup");
					fixReceiveRepeatGroup.setString("vcAccount", group.getString(1).toString());
					fixReceiveRepeatGroup.setString("vcInvesttype", group.getString(14000).toString());
					fixReceiveRepeatGroup.setString("vcPledgebond", group.getString(13211).toString());
					fixReceiveRepeatGroup.setString("vcPledgeratio", group.getString(13212).toString());
					fixReceiveRepeatGroup.setString("vcPledgedqty", group.getString(13213).toString());
					fixReceiveRepeatGroup.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
					repeatGroupList.add(fixReceiveRepeatGroup);
					//清空对象
					fixReceiveRepeatGroup = null;
				}
			} catch (FieldNotFound e) {
				e.printStackTrace();
			}
		}
		
		//NoContraBrokers:查询结果重复组
		if(fieldId == 382){
			fixReceiveMsg.setString("vcGroup", message.getGroupCount(fieldId)+"");  //接收重复组数量
			try {
				for(int i=1; i <= message.getGroupCount(fieldId); i++){
					Group group = message.getGroup(i, fieldId);
					DataObject fixReceiveRepeatGroup = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixReceiveRepeatGroup");
					//15999=7:风控试算结果
					if("7".equals(message.getString(15999))){
						//设置重复组参数
						fixReceiveRepeatGroup.setString("vcRiskout", group.getString(13211).toString());
						System.out.println(group.getField(new StringField(13211)));
					}
					//15999=8:可用金额查询结果
					if("8".equals(message.getString(15999))){
						fixReceiveRepeatGroup.setString("vcSoutputtext", group.getString(13211).toString());
						System.out.println(group.getField(new StringField(13211)));
					}
					//15999=9:可用数量查询结果
					if("9".equals(message.getString(15999))){
						fixReceiveRepeatGroup.setString("vcSoutputtext", group.getString(13211).toString());
						System.out.println(group.getField(new StringField(13211)));
					}
					fixReceiveRepeatGroup.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
					repeatGroupList.add(fixReceiveRepeatGroup);
					//清空对象
					fixReceiveRepeatGroup = null;
				}
			} catch (FieldNotFound e) {
				e.printStackTrace();
			}
			
		}
		
		//NoTradingSessions 指令券重复组，表示后面的Tag是证券信息。该Tag的值表示有几个券。
		if(fieldId == 386){
			fixReceiveMsg.setString("vcGroup", message.getGroupCount(fieldId)+"");  //接收重复组数量
			try {
				for(int i=1; i <= message.getGroupCount(fieldId); i++){
					Group group = message.getGroup(i, fieldId);
					DataObject fixReceiveRepeatGroup = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixReceiveRepeatGroup");
					fixReceiveRepeatGroup.setString("vcAccount", group.getString(1).toString());
					fixReceiveRepeatGroup.setString("vcSymbol", group.getString(55).toString());
					fixReceiveRepeatGroup.setString("vcSecurityid", group.getString(48).toString());
					fixReceiveRepeatGroup.setString("vcExdestination", group.getString(100).toString());
					fixReceiveRepeatGroup.setString("vcInvesttype", group.getString(14000).toString());
					fixReceiveRepeatGroup.setString("vcBusintype", group.getString(13001).toString());
					fixReceiveRepeatGroup.setString("vcPrice", group.getString(44).toString());
					fixReceiveRepeatGroup.setString("vcOrdtype", group.getString(40).toString());
					fixReceiveRepeatGroup.setString("vcOrderqty", group.getString(38).toString());
					fixReceiveRepeatGroup.setString("vcCashorderqty", group.getString(152).toString());
					fixReceiveRepeatGroup.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
					repeatGroupList.add(fixReceiveRepeatGroup);
					//清空对象
					fixReceiveRepeatGroup = null;
				}
			} catch (FieldNotFound e) {
				e.printStackTrace();
			}
		}
		return fixReceiveMsg;
	}
	
	/**
	 * 更新流程主表、业务主表状态值
	 * @param fixReceiveMsg Fix反馈报文对象
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void updateBizTblStatusValue(DataObject fixReceiveMsg){
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<String> sqls = new ArrayList<String>();
		try{
			//获取反馈报文状态等信息：Fix指令发送的报文“成功”或者“失败”的状态 && 指令反馈结果情况类型
			DataObject resultDataObject = getExecutionReportStatus(fixReceiveMsg);
			if(resultDataObject != null){
				boolean isSuccess = resultDataObject.getBoolean("isSuccess");//指令发送“成功”或者“失败”的状态
				//String resultMsgType = resultDataObject.getString("resultMsgType");//指令反馈结果情况类型
				
				//获取默认数据库连接
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				
				List<DataObject> list = queryFixSendMsgByClOrdId(conn, fixReceiveMsg.getString("vcClordid"));
				if(!list.isEmpty() && list.size()>0){
					for(int i=0; i<list.size(); i++){
						DataObject obj = list.get(i);
						if(obj != null){
							String VC_BIZ_TBL_NAME = obj.getString("VC_BIZ_TBL_NAME");//流程主表表名
							String VC_APV_TBL_NAME = obj.getString("VC_APV_TBL_NAME");//业务主表表名
							String VC_STATUS_FLD_NAME = obj.getString("VC_STATUS_FLD_NAME");//FIX状态字段名
							String VC_KEY_FLD_NAME = obj.getString("VC_KEY_FLD_NAME");//FIX关键字段名
							String VC_STATUS_VALUES = obj.getString("VC_STATUS_VALUES");//FIX状态值域：如(3|4)3成功,4失败
							
							//fix状态：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败;
							String success = "3";//成功
							String fail = "4";//失败
							String updateStatusValue = "";//更新状态值
							if(StringUtils.isNotBlank(VC_STATUS_VALUES) && VC_STATUS_VALUES.split("|").length==2){
								success = StringUtils.isNotBlank(VC_STATUS_VALUES.split("|")[0])?VC_STATUS_VALUES.split("|")[0]:"3";//成功
								fail = StringUtils.isNotBlank(VC_STATUS_VALUES.split("|")[1])?VC_STATUS_VALUES.split("|")[1]:"4";//失败
							}
							if(isSuccess){
								updateStatusValue = success;
							}else{
								updateStatusValue = fail;
							}
							
							//更新流程主表状态值
							if(StringUtils.isNotBlank(VC_BIZ_TBL_NAME) && StringUtils.isNotBlank(VC_STATUS_FLD_NAME) && StringUtils.isNotBlank(VC_KEY_FLD_NAME)){
								sb.setLength(0);
								sb.append("update ").append(VC_BIZ_TBL_NAME).append(" t set t.").append(VC_STATUS_FLD_NAME).append("='").append(updateStatusValue).append("' where t.").append(VC_KEY_FLD_NAME).append("='").append(fixReceiveMsg.getString("vcClordid")).append("'");
								sqls.add(sb.toString());
								LogUtil.logInfo("UpdateBizStatusSQL: "+sb.toString(), null, new Object[]{});
							}
							//更新业务主表状态值
							if(StringUtils.isNotBlank(VC_APV_TBL_NAME) && StringUtils.isNotBlank(VC_STATUS_FLD_NAME) && StringUtils.isNotBlank(VC_KEY_FLD_NAME)){
								sb.setLength(0);
								sb.append("update ").append(VC_APV_TBL_NAME).append(" t set t.").append(VC_STATUS_FLD_NAME).append("='").append(updateStatusValue).append("' where t.").append(VC_KEY_FLD_NAME).append("='").append(fixReceiveMsg.getString("vcClordid")).append("'");
								sqls.add(sb.toString());
								LogUtil.logInfo("UpdateBizStatusSQL: "+sb.toString(), null, new Object[]{});
							}
						}
					}
				}
				
				//执行更新操作
				JDBCUtil.executeUpdateBatchWithConn(conn, sqls);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.releaseResource(conn, null, null);
		}
	}
	
	/**
	 * 更新流程主表、业务主表状态值
	 * @param fixReceiveMsg Fix反馈报文对象
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void updateInquiryResult(DataObject fixReceiveMsg){
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		try{
			//获取反馈报文状态等信息：Fix指令发送的报文“成功”或者“失败”的状态 && 指令反馈结果情况类型
			DataObject resultDataObject = getExecutionReportStatus(fixReceiveMsg);
			if(resultDataObject != null){
				//获取默认数据库连接
				if(fixReceiveMsg.getString("vcClordid") != null && !"".equals(fixReceiveMsg.getString("vcClordid"))){
					conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
					boolean isSuccess = resultDataObject.getBoolean("isSuccess");//指令发送“成功”或者“失败”的状态
					Map<String, Object> o32Result = new HashMap<String, Object>();
					sb.setLength(0);
					sb.append("select t.l_result_id, ")
					  .append("	 	  t.l_fix_valid_status, ")
					  .append("	 	  t.vc_clord_id, ")
					  .append("	 	  t.l_processinst_id ")
					  .append("	 from t_ats_inquiry_result_instruct t ")
					  .append("	where t.c_is_valid = '1' ")
					  .append("	  and t.l_fix_valid_status = '2' ")
					  .append("	  and t.vc_clord_id = '").append(fixReceiveMsg.getString("vcClordid")).append("'");
					List<Map<String,String>> maps = JDBCUtil.queryWithConn(conn, sb.toString(), null);
					if(!maps.isEmpty() && maps.size()==1){
						Map<String, String> map = maps.get(0);
						BPSServiceClientFactory.getLoginManager().setCurrentUser("sysadmin", "sysadmin"); 
						IBPSServiceClient client = BPSServiceClientFactory.getDefaultClient(); 
						DataObject remind = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsRemind");
						if(isSuccess){//投资建议下单到O32
							o32Result.put("frmResult", "1");
							Map<String,String> vcFailreason = FixToUtil.readStringXmlOut(fixReceiveMsg.getString("vcFailreason"));
							String approveStatus = "1";
							//判断是否触发审批风控
							if(vcFailreason != null && "2".equals(vcFailreason.get("failReasonType"))){//风控信息
								String reason = vcFailreason.get("reason");
								String[] arr = reason.split(FixToUtil.REASON_SPLIT);
								for(int i=0; i<arr.length; i++){
									if(StringUtils.isNotBlank(arr[i])){
										String[] arrTemp = arr[i].split("\\|");
										if("3".equals(arrTemp[1])){//审批风控
											o32Result.put("frmResult", "4");
											approveStatus = "";
											break;
										}
									}
								}
							}
							//更新询价结果表
							sb.setLength(0);
							sb.append("update t_ats_inquiry_result_instruct t ")
							  .append("	  set t.vc_instructionno='").append(fixReceiveMsg.getString("vcInstructionno")).append("', ")
							  .append("	      t.l_fix_valid_status=").append(3).append(", ")
							  .append("	      t.vc_risk_approve_status=").append(approveStatus).append(", ")
							  .append("	      t.vc_origord_id='").append(fixReceiveMsg.getString("vcClordid")).append("' ")
							  .append(" where t.l_result_id=").append(map.get("L_RESULT_ID"));
							LogUtil.logInfo("UpdateBizStatusSQL: "+sb.toString(), null, new Object[]{});
							JDBCUtil.executeUpdateWithConn(conn, sb.toString(), null);
							//完成下发O32活动 开始
							//O32返回结果填入相关数据
							IWFRelativeDataManager relativeDataManager = client.getRelativeDataManager(); 
							WFParticipant relaData = new WFParticipant("sysadmin","sysadmin"); 
							o32Result.put("arr", new WFParticipant[]{relaData}); //arr是相关数据中定义的数组
							relativeDataManager.setRelativeDataBatch(Long.parseLong(map.get("L_PROCESSINST_ID")), o32Result);
							//完成下发O32活动
							IWFActivityInstManager activityInstManager = client.getActivityInstManager(); 
							activityInstManager.finishActivityInstByActivityID(Long.parseLong(map.get("L_PROCESSINST_ID")),"sendToO32"); 
							//完成下发O32活动 结束
						}else{//投资建议下到O32失败
							o32Result.put("frmResult", "3");
							sb.setLength(0);
							sb.append("update t_ats_inquiry_result_instruct t ")
							  .append("	      t.l_fix_valid_status=").append(4).append(", ")//fix状态码：1-未发送， 2-发送中， 3-发送成功，4-发送失败
							  .append("	      t.vc_clord_id='").append(ProductUtil.getClOrdID()).append("' ")//更替原信息的第三方指令编号
							  .append(" where t.l_result_id=").append(map.get("L_RESULT_ID"));
							LogUtil.logInfo("UpdateBizStatusSQL: "+sb.toString(), null, new Object[]{});
							//O32返回结果填入相关数据
							IWFRelativeDataManager relativeDataManager = client.getRelativeDataManager(); 
							WFParticipant relaData = new WFParticipant("sysadmin","sysadmin"); 
							o32Result.put("arr", new WFParticipant[]{relaData}); //arr是相关数据中定义的数组
							relativeDataManager.setRelativeDataBatch(Long.parseLong(map.get("L_PROCESSINST_ID")), o32Result);
							//流程回退
							
							DataObject instructInfo = (DataObject) relativeDataManager.getRelativeData(Long.parseLong(map.get("L_PROCESSINST_ID")), "instructInfo");
							String bizType = BusinessDictUtil.getDictName("bizTypeTransaction",instructInfo.getString("vcBizType"));
							if("5".equals(instructInfo.getString("vcBizType")) || "6".equals(instructInfo.getString("vcBizType")) || "7".equals(instructInfo.getString("vcBizType"))){
								bizType = BusinessDictUtil.getDictName("bizTypeRepurchase",instructInfo.getString("vcBizType"));
							}
							IWFProcessInstManager processInstManager = client.getProcessInstManager(); 
							WFProcessInst proInst = processInstManager.queryProcessInstDetail(Long.parseLong(map.get("L_PROCESSINST_ID")));
							String creator = proInst.getCreator();
							DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.OrgEmployee");
							emp.setInt("empid",Integer.parseInt(creator));
							DatabaseUtil.expandEntity("default", emp);
							remind.setString("vcTitle", "序号为【"+instructInfo.getString("lResultNo")+"】的【"+bizType+"】指令推送O32失败，请注意查收！");
							remind.setString("vcContent", "序号为【"+instructInfo.getString("lResultNo")+"】的【"+bizType+"】指令推送O32失败，流程被退回，请注意查看！");
							remind.setString("vcUserId", emp.getString("empcode"));
							remind.setString("userName", emp.getString("empname"));
							remind.setString("lProcessinstId", map.get("L_PROCESSINST_ID"));
							remind.setString("lInstructNo", instructInfo.getString("lResultNo"));
						}
						//调用保存提示信息的逻辑流
						ILogicComponent logicComponent = LogicComponentFactory.create("com.cjhxfund.commonUtil.MessageService");
						Object[] params = new Object[1];
						params[0] = remind;
						try {
							logicComponent.invoke("saveRemindData", params);
						} catch (Throwable e) {
							// TODO 自动生成的 catch 块
							e.printStackTrace();
						}

					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.releaseResource(conn, null, null);
		}
	}
	
	
	/**
	 * 将反馈报文失败原因格式化
	 * @param str 反馈报文失败原因（警告信息等）
	 * @param newlineFlag 换行标志
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String changeFailReason(String str, String newlineFlag){
		if(StringUtils.isBlank(str)){
			return "";
		}
		/** 从返回报文XML格式字符串提取出失败类型、失败原因等 */
		Map<String,String> map = FixToUtil.readStringXmlOut(str);
		/** Type属性值域，2-风控 */
		String failReasonType = map.get("failReasonType");
		//String reasonCount = map.get("reasonCount");
		/**1-可用Reason信息：组合编号|申报代码|交易市场|投资类型|可用不足提示说明
		 * 2-风控Reason信息：触警级别|触警操作|组合编号|证券编码|交易所|风控编号|风控类型|设置值|实际值|风控说明
		 */
		String reason = map.get("reason");
		
		StringBuffer sb = new StringBuffer();
		StringBuffer sbMsg = new StringBuffer();
		String[] arr = reason.split(FixToUtil.REASON_SPLIT);
		
		for(int i=0; i<arr.length; i++){
			sbMsg.setLength(0);
			
			/** 1-可用Reason信息 */
			if("1".equals(failReasonType)){
				if(StringUtils.isNotBlank(arr[i]) && arr[i].split("\\|").length>=5){
					sbMsg.append(arr[i].split("\\|")[4]).append("；");
				}
				
			/** 2-风控Reason信息 */
			}else if("2".equals(failReasonType)){
				if(StringUtils.isNotBlank(arr[i])){
					String[] arrTemp = arr[i].split("\\|");
					if(arrTemp.length>=10){
						/** 示例：[1001_000][100005]触发[375，申请指令审批]：债券成交收益率不超过公允收益率60bp； */
						sbMsg.append("[").append(arrTemp[2]).append("][").append(arrTemp[3]).append("]触发[").append(arrTemp[5]).append("，").append(getRiskCtrlOperateName(arrTemp[1])).append("]：").append(arrTemp[9]).append("；");
					}
				}
			}
			
			sb.append(i+1).append("、").append(sbMsg.toString());
			if(i<arr.length-1){
				sb.append(newlineFlag);
			}
		}
		return sb.toString();
	}
	
	
	/**
	 * 解析tag14058反馈的风控信息并保存数据库
	 * @param str tag=14058字段数据
	 * @param vcClordid 第三方指令编号
	 * @param lMsgId 反馈信息在反馈表中存入的Id
	 * @author 刘玉龙
	 */
	public static void splitFailReasonRisk(String str, String vcClordid, Long lMsgId){
		if(!StringUtils.isBlank(str)){
			/** 从返回报文XML格式字符串提取出失败类型、失败原因等 */
			Map<String,String> map = FixToUtil.readStringXmlOut(str);
			/** Type属性值域，2-风控 */
			String failReasonType = map.get("failReasonType");
			/**1-可用Reason信息：组合编号|申报代码|交易市场|投资类型|可用不足提示说明
			 * 2-风控Reason信息：触警级别|触警操作|组合编号|证券编码|交易所|风控编号|风控类型|设置值|实际值|风控说明
			 */
			String reason = map.get("reason");
			StringBuffer sbMsg = new StringBuffer();
			String[] arr = reason.split(FixToUtil.REASON_SPLIT);
			for(int i=0; i<arr.length; i++){
				sbMsg.setLength(0);
				/** 2-风控Reason信息 */
				if("2".equals(failReasonType)){
					if(StringUtils.isNotBlank(arr[i])){
						String[] arrTemp = arr[i].split("\\|");
						DataObject fixReceiveRiskWarn = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskWarnLog");
						if(arrTemp.length>=10){
							if(arrTemp[0] != null && arrTemp[0] != ""){
								fixReceiveRiskWarn.setString("cWarnLevel", arrTemp[0]);//风控阀值
							}
							if(arrTemp[1] != null && arrTemp[1] != ""){
								fixReceiveRiskWarn.setString("cWarnOperation", arrTemp[1]);//风控操作
							}
							if(arrTemp[2] != null && arrTemp[2] != ""){
								fixReceiveRiskWarn.setString("vcCombiNo", arrTemp[2]);//恒生系统组合编号
							}
							if(arrTemp[3] != null && arrTemp[3] != ""){
								fixReceiveRiskWarn.setString("vcStockCode", arrTemp[3]);//证券申报代码(证券代码)
							}
							if(arrTemp[4] != null && arrTemp[4] != ""){
								fixReceiveRiskWarn.setString("vcMarketCode", arrTemp[4]);//交易市场
							}
							if(arrTemp[5] != null && arrTemp[5] != ""){
								fixReceiveRiskWarn.setString("lRiskSerialNo", arrTemp[5]);//风控序号
							}
							if(arrTemp[6] != null && arrTemp[6] != ""){
								fixReceiveRiskWarn.setString("cRiskType", arrTemp[6]);//风控类别
							}
							if(arrTemp[7] != null && arrTemp[7] != ""){
								fixReceiveRiskWarn.setString("enSetvalue", arrTemp[7]);//设置值
							}
							if(arrTemp[8] != null && arrTemp[8] != ""){
								fixReceiveRiskWarn.setString("enValue", arrTemp[8]);//实际值
							}
							if(arrTemp[9] != null && arrTemp[9] != ""){
								fixReceiveRiskWarn.setString("vcSummary", arrTemp[9]);//风控说明
							}
							fixReceiveRiskWarn.setString("lDate", DateUtil.currentDateString(DateUtil.YMD_NUMBER));
							fixReceiveRiskWarn.setString("lTime", DateUtil.currentDateString(DateUtil.HMS_PATTERN));
							
							fixReceiveRiskWarn.setString("cLogSource", "1");//日志来源：0-试算风险；1-正式下达；
							fixReceiveRiskWarn.setString("vcClordid", vcClordid);
							fixReceiveRiskWarn.setLong("lMsgId", lMsgId);
							DatabaseExt.getPrimaryKey(fixReceiveRiskWarn);
							
						}
						DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, fixReceiveRiskWarn);
					}
				}
			}
		}
	}

	/**
	 * 解析风控试算反馈结果的风控返回信息
	 * @param riskStr 风控返回信息
	 * @return DataObject 风控试算解析后的风控信息
	 * @author 刘玉龙
	 */
	@Bizlet("")
	public static DataObject splitRiskOut(String riskStr){
		DataObject fixReceiveRiskWarn = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskWarnLog");
		if(StringUtils.isBlank(riskStr)){
			return null;
		}
		/**
		 * 风控返回信息信息：风控操作|风控序号|风控类别|风控说明|设置值|实际值|恒生系统组合编号|证券申报代码|交易市场|风控阀值|触发风控的说明
		 */
		String[] arrs = riskStr.split("\\|");
		if(arrs.length>0 && arrs[0] != null && arrs[0] != ""){
			fixReceiveRiskWarn.setString("cWarnOperation", arrs[0]);//风控操作
		}
		if(arrs.length>1 && arrs[1] != null && arrs[1] != ""){
			fixReceiveRiskWarn.setString("lRiskSerialNo", arrs[1]);//风控序号
		}
		if(arrs.length>2 && arrs[2] != null && arrs[2] != ""){
			fixReceiveRiskWarn.setString("cRiskType", arrs[2]);//风控类别
		}
		if(arrs.length>3 && arrs[3] != null && arrs[3] != ""){
			fixReceiveRiskWarn.setString("vcSummary", arrs[3]);//风控说明
		}
		if(arrs.length>4 && arrs[4] != null && arrs[4] != ""){
			fixReceiveRiskWarn.setString("enSetvalue", arrs[4]);//设置值
		}
		if(arrs.length>5 && arrs[5] != null && arrs[5] != ""){
			fixReceiveRiskWarn.setString("enValue", arrs[5]);//实际值
		}
		if(arrs.length>6 && arrs[6] != null && arrs[6] != ""){
			System.out.println(arrs[6]);
			fixReceiveRiskWarn.setString("vcCombiNo", arrs[6]);//恒生系统组合编号
		}
		if(arrs.length>7 && arrs[7] != null && arrs[7] != ""){
			fixReceiveRiskWarn.setString("vcStockCode", arrs[7]);//证券申报代码(证券代码)
		}
		if(arrs.length>8 && arrs[8] != null && arrs[8] != ""){
			fixReceiveRiskWarn.setString("vcMarketCode", arrs[8]);//交易市场
		}
		if(arrs.length>9 && arrs[9] != null && arrs[9] != ""){
			fixReceiveRiskWarn.setString("cWarnLevel", arrs[9]);//风控阀值
		}
		if(arrs.length>10 && arrs[10] != null && arrs[10] != ""){
			fixReceiveRiskWarn.setString("vcTriggerRemark", arrs[10]);//触发风控的说明
		}
		return fixReceiveRiskWarn;
	}
	
	
	/**
	 * 获取指令下达、指令修改、指令撤销等的反馈信息
	 * 因反馈信息为异步返回，所以当第一次查不到数据时，会等待一定时间（默认1秒）后重新查询，超过指定次数（默认5次）时，若还没查到结果，返回空
	 * 
	 * [35，MsgType]消息类型（Fix标准消息类型，定义在消息头）：
	 * 8 – Execution Report，表示指令状态、委托数据反馈、成交数据反馈；
	 * 8 – Execution Report，表示恒生系统下达指令失败导致的订单撤销(Fix标准定义)；
	 * 9 – Order Cancel Reject，表示恒生系统修改/撤销指令失败、fix报文格式本身错误、缺少必输项等导致的订单拒绝(Fix标准定义)；
	 * 
	 * [15999，ProceType]处理类型：
	 * 1 – 下达拒绝；
	 * 2 – 状态反馈(指令状态)；
	 * 3 – 成交反馈；
	 * 10 – 委托数据反馈；
	 * 
	 * [39，OrdStatus]指令状态：
	 * 0 – 已下达未成交(New)；
	 * 1 – 部分成交(Partial fill)；
	 * 2 – 全部成交（Fill）；
	 * 4 – 已撤销（Canceled）；
	 * 5 – 已修改（Replace）；
	 * 6 – 接收到撤销的指令（Pending Cancel）；
	 * 8 - 已拒绝(Rejected)；
	 * A – 接收到下达的指令（Pending New）；
	 * E – 接收到修改的指令（Pending Replace）；
	 * FIX4.4版本指令状态(tag)已删除5-已修改；注：状态变化过程见文档第三部分Fix反馈状态说明
	 * 
	 * [150，ExecType]执行状态，值域同指令状态：
	 * 4 – 已拒绝（Canceled）；
	 * 注：对于指令下达拒绝的时候填4,否则为空,状态变化过程见文档第三部分Fix反馈状态说明 
	 * 
	 * @param vcClOrdId 第三方指令编号
	 * @param vcMsgType 下单指令类型：D-指令下达；F-指令撤销；G-指令修改；H-指令查询；
	 * @param dCreated 数据插入时间
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> queryFixReceiveMsg(String vcClOrdId, String vcMsgType, String dCreated){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try{
			//获取默认数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			//查询SQL语句
			sb.append("select * from t_ats_fix_receive_msg t where 1=1 ");
			//组装查询条件
			if(StringUtils.isNotBlank(vcClOrdId)){
				sb.append(" and t.vc_clordid  in (").append(JDBCUtil.changeInStr(vcClOrdId)).append(") ");
			}
			if(StringUtils.isNotBlank(vcMsgType)){  //指令类型
				sb.append(" and t.vc_msgtype = '" + vcMsgType + "' ");
			}
			if(StringUtils.isNotBlank(dCreated)){
				sb.append(" and to_char(t.d_created,'yyyy-mm-dd hh24:mi:ss')>='" + dCreated + "' ");
			}
			//增加排序
			sb.append(" order by t.d_created asc");
			/*指令状态、成交数据反馈接口查询次数设置成参数:20180628*/
			String queryTimes = ParamConfig.getValue("ATS_EXECUTION_REPORT_QUERY_TIME");
			for(int k=1; k<=Integer.valueOf(queryTimes); k++){
				//查询结果集
				List<Map<String,String>> maps = JDBCUtil.queryWithConn(conn, sb.toString(), null);
				
				if(!maps.isEmpty() && maps.size()>0){
					for(int i=0; i<maps.size(); i++){
						Map<String, String> map = maps.get(i);
						
						obj = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.FixEntity");
						obj.setString("L_MSG_ID", map.get("L_MSG_ID"));   //主键ID
						obj.setString("VC_MSGTYPE", map.get("VC_MSGTYPE")); //消息类型
						obj.setString("VC_SENDERSUBID", map.get("VC_SENDERSUBID")); //指令下达人的操作员编号
						obj.setString("VC_PROCETYPE", map.get("VC_PROCETYPE")); //处理类型
						obj.setString("VC_CLORDID", map.get("VC_CLORDID"));  //第三方指令编号
						obj.setString("VC_ORDERID", map.get("VC_ORDERID"));  //指令下达失败的指令状态
						obj.setString("VC_ORIGORDID", map.get("VC_ORIGORDID")); //被修改/撤销指令的第三方指令编号
						obj.setString("VC_LISTID", map.get("VC_LISTID"));   //第三方系统传过来的清单编号
						obj.setString("VC_EXECID", map.get("VC_EXECID"));   //流水号
						obj.setString("VC_EXECREFID", map.get("VC_EXECREFID"));  //要回溯的ExecID
						obj.setString("VC_EXECTRANSTYPE", map.get("VC_EXECTRANSTYPE"));
						obj.setString("VC_ORDSTATUS", map.get("VC_ORDSTATUS"));  //指令状态
						obj.setString("VC_EXECTYPE", map.get("VC_EXECTYPE"));    //执行状态
						obj.setString("VC_INSTRUCTIONNO", map.get("VC_INSTRUCTIONNO"));  //O32内部指令序号
						obj.setString("VC_OPERATORNAME", map.get("VC_OPERATORNAME"));  //分发时反馈交易员姓名
						obj.setString("VC_FEE", map.get("VC_FEE"));   //费用
						obj.setString("VC_MISCFEETYPE", map.get("VC_MISCFEETYPE"));  //费用类型
						obj.setString("VC_REIMBAMT", map.get("VC_REIMBAMT"));  //网下申购、开基申购、认购 退款金额(成交) 因为是部分中签需要返回金额
						obj.setString("VC_REIMBSETTLEDATE", map.get("VC_REIMBSETTLEDATE"));  //网下申购、开基申购、认购 退款日期(成交) 因为是部分中签需要返回金额
						obj.setString("VC_SETTLTYPE", map.get("VC_SETTLTYPE")); //清算速度：0 = T+0  1 = T+1
						obj.setString("VC_FUTSETTDATE", map.get("VC_FUTSETTDATE"));  //交割日(首次交割日)
						obj.setString("VC_FUTSETTDATE2", map.get("VC_FUTSETTDATE2"));  //到期交割日
						obj.setString("VC_SYMBOL", map.get("VC_SYMBOL"));  //证券申报代码
						obj.setString("VC_SECURITYID", map.get("VC_SECURITYID")); //证券申报代码1
						obj.setString("VC_EXDESTINATION", map.get("VC_EXDESTINATION")); //交易市场
						obj.setString("VC_SIDE", map.get("VC_SIDE"));  //买卖方向
						obj.setString("VC_ACCOUNT", map.get("VC_ACCOUNT"));  //组合编号
						obj.setString("VC_PRICE", map.get("VC_PRICE"));   //指令价格
						obj.setString("VC_ORDERQTY", map.get("VC_ORDERQTY"));  //指令数量
						obj.setString("VC_LASTPX", map.get("VC_LASTPX"));  //反馈成交信息，当前笔成交价格
						obj.setString("VC_LASTSHARES", map.get("VC_LASTSHARES"));  //反馈成交信息，当前笔成交数量
						obj.setString("VC_LEAVESQTY", map.get("VC_LEAVESQTY"));  //反馈成交信息，剩余未成交数量
						obj.setString("VC_CUMQTY", map.get("VC_CUMQTY"));  //反馈成交信息，累计成交数量
						obj.setString("VC_AVGPX", map.get("VC_AVGPX"));    //反馈成交信息，成交均价
						obj.setString("VC_ISSUEDATE", map.get("VC_ISSUEDATE")); //起息日
						obj.setString("VC_DEALNO", map.get("VC_DEALNO"));  // 成交编号
						obj.setString("VC_DEALPRICE", map.get("VC_DEALPRICE"));//当前笔成交价格，对于回购业务该字段是100，其他业务同tag31的字段值，返回指令状态时该字段不返回
						obj.setString("VC_REPORTSEAT", map.get("VC_REPORTSEAT")); //申报席位
						obj.setString("VC_TODAYDEALAMOUNT", map.get("VC_TODAYDEALAMOUNT"));   //当日累计成交数量
						obj.setString("VC_TODAYDEALBALANCE", map.get("VC_TODAYDEALBALANCE")); //当日累计成交金额
						obj.setString("VC_REPORTSERIALNO", map.get("VC_REPORTSERIALNO"));  //申报编号
						obj.setString("VC_BUSINESSTIME", map.get("VC_BUSINESSTIME")); //成交时间
						obj.setString("VC_EXECBROKER", map.get("VC_EXECBROKER"));   //交易对手编号
						obj.setString("VC_BONDSETTLETYPE", map.get("VC_BONDSETTLETYPE")); //结算方式(首次结算方式) ：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户
						obj.setString("VC_BONDSETTLETYPE2", map.get("VC_BONDSETTLETYPE2")); //到期结算方式
						obj.setString("VC_REPORATE", map.get("VC_REPORATE"));  //回购利率
						obj.setString("VC_NETPRICE", map.get("VC_NETPRICE"));  //净价价格
						obj.setString("VC_INTEREST", map.get("VC_INTEREST"));  //应计利息
						obj.setString("VC_FULLPRICE", map.get("VC_FULLPRICE")); //全价价格
						obj.setString("VC_FIRSTCLEARBALANCE", map.get("VC_FIRSTCLEARBALANCE"));  //首次资金清算额
						obj.setString("VC_SECONDCLEARBALANCE", map.get("VC_SECONDCLEARBALANCE"));//到期资金清算额
						obj.setString("VC_DESTSECURITY", map.get("VC_DESTSECURITY"));  //转入证券内码
						obj.setString("VC_DESTQTY", map.get("VC_DESTQTY"));   //转入份额
						obj.setString("VC_DESTPRICE", map.get("VC_DESTPRICE")); //转入净值
						obj.setString("VC_DESTAMT", map.get("VC_DESTAMT"));  //转入金额
						obj.setString("VC_DESTFEE", map.get("VC_DESTFEE"));  //转入费用
						obj.setString("VC_FAILREASON", map.get("VC_FAILREASON")); //失败原因
						obj.setString("VC_SENDERCOMPID", map.get("VC_SENDERCOMPID"));  //发送方ID
						obj.setString("VC_TARGETCOMPID", map.get("VC_TARGETCOMPID"));  //接收方ID
						obj.setString("VC_TEXT", map.get("VC_TEXT")); //备注
						obj.setString("L_INSTRUCTION_ID", map.get("L_INSTRUCTION_ID"));  //指令序号-主键ID
						obj.setString("L_INSTRUCTION_NO", map.get("L_INSTRUCTION_NO"));  //指令编号-业务ID
						obj.setString("D_CREATED", map.get("D_CREATED"));  //数据插入时间
						
						//以下为风控试算、可用试算等功能用到字段
						obj.setString("VC_PROCESSTYPE", map.get("VC_PROCESSTYPE"));  //15999-处理类型：4-风险试算；5-可用金额查询；6-可用数量查询；7-风控试算结果；8-可用金额查询结果；9-可用数量查询结果；
						obj.setString("VC_ERRORCODE", map.get("VC_ERRORCODE"));  //16004-错误代码：0表示查询正常，反之表示查询错误。具体错误原因请看错误信息（ErrorMsg）
						obj.setString("VC_ERRORMSG", map.get("VC_ERRORMSG"));  //16005-错误信息只有错误代码为0时允许为空，非0状态必须返回错误信息。
						obj.setString("VC_GROUP", map.get("VC_GROUP"));  //382-分组结点下面允许包含多条告警信息。如果当前查询结果未触犯风控，那么分组结点不会创建。反之每条告警信息由“触警操作”、“风控编号”、“风控类型”及“风控说明”组成。
						obj.setString("VC_RISKOUT", map.get("VC_RISKOUT"));  //13211-风控返回的信息，以竖线分隔：风控阀值|风控序号|风控类型|风控说明|设置值|实际值|恒生系统组合编号|证券的申报代码|交易市场|风控操作。风控阀值：1.触警级别代表的是触犯了第几个阀值，关系如下：''A'' 系统错误  ''1'' 触犯阀值一；''2'' 触犯阀值二  ''3'' 触犯阀值三；''4'' 触犯开关类的风控（I、J类）；2.风控类型：就是A、B、C等风控类别；   3.交易市场：SS 上交所  SZ 深交所 OTC 场外；  4.风控操作：0：无  1:预警 2:禁止 3:申请指令审批  ；4:申请风险阀值；
						obj.setString("VC_SOUTPUTTEXT", map.get("VC_SOUTPUTTEXT"));  //13211-可用返回的信息，以竖线分隔：恒生系统资产单元编号|恒生系统组合编号| T+0可用金额| T+1可用金额|当前金额
						obj.setString("VC_BUSINCLASS", map.get("VC_BUSINCLASS"));  //13000-业务类别：2-银行间二级市场业务 ；A –开放式基金；B-存款业务；C-网下申购；D-债券一级市场；
						obj.setString("VC_BUSINTYPE", map.get("VC_BUSINTYPE"));  //13001-委托方向：债券：3–债券买入 4–债券卖出；回购：5–融资回购 6–融券回购；存款：F-存款 i-支取；开放式基金：p–场外申购 q–场外赎回 ；D–认购  z–分红设置 E–基金转换；债券一级：J-承销买入 K-分销买入 L-分销卖出；新股申购：C–申购；
						obj.setString("VC_INVESTTYPE", map.get("VC_INVESTTYPE"));  //14000-投资类型：交易所：1-可交易  2-持有到期；3-可供出售  4-贷款和应收款项
						
						
						result.add(obj);
					}
				}
				if(!result.isEmpty() && result.size()>0){
					break;
				}else{
					Thread.sleep(FixToUtil.EXECUTION_REPORT_WAIT_TIME);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 获取风控试算反馈的风控信息
	 * @param vcClOrdId 第三方指令编号
	 * @return List<DataObject> 指定指令的风控信息
	 * @author 刘玉龙
	 */
	@Bizlet("")
	public static List<DataObject> queryFixRiskMsg(String vcClOrdId){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try{
			//获取默认数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//查询SQL语句
			sb.append("select distinct t.l_risk_warn_log_id,")//主键ID
			  .append("                t.l_date, ")//日期，格式：yyyyMMdd
			  .append("                t.l_time, ")//时间，格式：HHmmss
			  .append("                t.l_msg_id, ")//Fix协议接收报文数据表主键ID
			  .append("                t.l_receive_repeat_group_id, ")//Fix协议接收报文重复组数据表主键ID
			  .append("                t.vc_clordid, ")//第三方指令编号
			  .append("                p.vc_product_name, ")//产品名称
			  .append("                t.vc_combi_no, ")//组合代码
			  .append("                c.vc_combi_name, ")//组合名称
			  .append("                t.vc_stock_code, ")//债券代码
			  .append("                b.vc_stock_name, ")//债券名称
			  .append("                t.vc_market_code, ")//市场代码
			  .append("                t.en_value, ")//实际值
			  .append("                t.en_setvalue, ")//设置值
			  .append("                t.vc_summary, ")//风控说明
			  .append("                t.vc_trigger_remark, ")//触发说明(备注)
			  .append("                t.l_risk_serial_no, ")//风控序号
			  .append("                t.c_risk_type, ")//风控类型
			  .append("                t.c_warn_level, ")//触警级别
			  .append("                t.c_warn_operation, ")//触警操作
			  .append("                t.c_log_source ")//#日志来源
			  .append("  from t_ats_risk_warn_log t ")
			  .append("  left join t_ats_combi_info c ")
			  .append("  	on t.vc_combi_no = c.vc_combi_no ")
			  .append("  left join t_ats_product_info p ")
			  .append("  	on c.l_product_id = p.l_product_id ")
			  .append("  left join vw_bondinfo_wind b ")
			  .append("  	on t.vc_stock_code = b.vc_stock_code ")
		      .append(" where 1 = 1 ");
			//组装查询条件
			if(StringUtils.isNotBlank(vcClOrdId)){
				sb.append(" and t.vc_clordid = ").append(JDBCUtil.changeInStr(vcClOrdId)).append("");
			}
			//增加排序
			//sb.append(" order by t.d_created asc");
			//查询结果集
			List<Map<String,String>> maps = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!maps.isEmpty() && maps.size()>0){
				for(int i=0; i<maps.size(); i++){
					Map<String, String> map = maps.get(i);
					obj = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskWarnLog");
					obj.setString("LRiskWarnLogId", map.get("L_RISK_WARN_LOG_ID"));   //主键ID
					obj.setString("lDate", map.get("L_DATE"));   //日期，格式：yyyyMMdd
					obj.setString("lTime", map.get("L_TIME"));   //时间，格式：HHmmss
					obj.setString("lMsgId", map.get("L_MSG_ID"));   //Fix协议接收报文数据表主键ID
					obj.setString("lReceiveRepeatGroupId", map.get("L_RECEIVE_REPEAT_GROUP_ID"));   //Fix协议接收报文重复组数据表主键ID
					obj.setString("vcClordid", map.get("VC_CLORDID"));   //第三方指令编号
					//obj.setString("lProductId", map.get("L_PRODUCT_ID"));   //产品序号表示指令、委托中的基金。具体触发的是哪个层次在风控设置中，触发的哪个层次序号，有新增加了 触发的层次 字段。
					//obj.setString("vcProductCode", map.get("VC_PRODUCT_CODE"));   //产品代码
					obj.setString("vcProductName", map.get("VC_PRODUCT_NAME"));   //产品名称
					//obj.setString("lAssetId", map.get("L_ASSET_ID"));   //资产单元序号						
					//obj.setString("vcAssetNo", map.get("VC_ASSET_NO"));   //资产单元编号						
					//obj.setString("vcAssetName", map.get("VC_ASSET_NAME"));   //资产单元名称
					//obj.setString("lBasecombiId", map.get("L_BASECOMBI_ID"));   //投资组合序号
					obj.setString("vcCombiNo", map.get("VC_COMBI_NO"));   //投资组合编号
					obj.setString("vcCombiName", map.get("VC_COMBI_NAME"));   //投资组合名称
					//obj.setString("vcSeatId", map.get("VC_SEAT_ID"));   //席位代码
					//obj.setString("vcStockholderId", map.get("VC_STOCKHOLDER_ID"));   //股东代码
					//obj.setString("vcInterCode", map.get("VC_INTER_CODE"));   //证券内码
					obj.setString("vcStockCode", map.get("VC_STOCK_CODE"));   //证券代码
					obj.setString("vcStockName", map.get("VC_STOCK_NAME"));   //证券名称
					obj.setString("vcMarketCode", map.get("VC_MARKET_CODE"));   //交易所/交易市场代码
					//obj.setString("vcMarketName", map.get("VC_MARKET_NAME"));   //交易所/交易市场名称
					//obj.setString("enCurrentEnable", map.get("EN_CURRENT_ENABLE"));   //当前金额/数量
					//obj.setString("enT0Enable", map.get("EN_T0_ENABLE"));   //T+0可用金额/数量
					//obj.setString("enT1Enable", map.get("EN_T1_ENABLE"));   //T+1可用金额/数量
					obj.setString("enValue", StrUtil.addThousandth(map.get("EN_VALUE"), new DecimalFormat("###0.00000")));   //实际值
					obj.setString("enSetvalue", StrUtil.addThousandth(map.get("EN_SETVALUE"), new DecimalFormat("###0.00000")));   //设置值
					//obj.setString("lOperatorNo", map.get("L_OPERATOR_NO"));   //操作员代码
					//obj.setString("lInstructionNo", map.get("L_INSTRUCTION_NO"));   //指令序号
					//obj.setString("lIndexModifyInstruction", map.get("L_INDEX_MODIFY_INSTRUCTION"));   //预置指令修改次序
					//obj.setString("lDailyInstructionNo", map.get("L_DAILY_INSTRUCTION_NO"));   //指令序号
					//obj.setString("lIndexDailyModify", map.get("L_INDEX_DAILY_MODIFY"));   //指令修改次序
					//obj.setString("lEntrustSerialNo", map.get("L_ENTRUST_SERIAL_NO"));   //委托序号
					//obj.setString("vcConnectionId", map.get("VC_CONNECTION_ID"));   //数据库连接ID＃
					//obj.setString("vcComputerName", map.get("VC_COMPUTER_NAME"));   //登录机器名＃
					//obj.setString("vcMac", map.get("VC_MAC"));   //网卡地址＃
					//obj.setString("vcVolserialNo", map.get("VC_VOLSERIAL_NO"));   //硬盘VOL序号＃
					obj.setString("vcSummary", map.get("VC_SUMMARY"));   //风控说明
					obj.setString("vcTriggerRemark", map.get("VC_TRIGGER_REMARK"));   //触发说明(备注)
					//obj.setString("vcReason", map.get("VC_REASON"));   //确认原因，对于预警如果需要填入原因，是前台风控交互时填入的；对于需要审批，是前台风控交互时填入的 申请原因；
					obj.setString("lRiskSerialNo", map.get("L_RISK_SERIAL_NO"));   //风控序号
					obj.setString("cRiskType", map.get("C_RISK_TYPE"));   //风控类型：就是A、B、C等风控类别；
					obj.setString("cWarnLevel", map.get("C_WARN_LEVEL"));   //触警级别：数据字典10046项；A-系统错误；1-触犯阀值一；2-触犯阀值二；3-触犯阀值三；4-触犯开关类的风控（I、J类）；
					if("A".equalsIgnoreCase(map.get("C_WARN_LEVEL"))){
						obj.setString("cWarnLevel", "系统错误");
					}
					if("1".equalsIgnoreCase(map.get("C_WARN_LEVEL"))){
						obj.setString("cWarnLevel", "触犯阀值一");
					}
					if("2".equalsIgnoreCase(map.get("C_WARN_LEVEL"))){
						obj.setString("cWarnLevel", "触犯阀值二");
					}
					if("3".equalsIgnoreCase(map.get("C_WARN_LEVEL"))){
						obj.setString("cWarnLevel", "触犯阀值三");
					}
					if("4".equalsIgnoreCase(map.get("C_WARN_LEVEL"))){
						obj.setString("cWarnLevel", "开关");
					}
					obj.setString("cWarnOperation", map.get("C_WARN_OPERATION"));   //触警操作：0-无;1-预警;2-禁止;3-申请指令审批;4-申请风险阀值;
					if("0".equalsIgnoreCase(map.get("C_WARN_OPERATION"))){
						obj.setString("cWarnOperation", "无");
					}
					if("1".equalsIgnoreCase(map.get("C_WARN_OPERATION"))){
						obj.setString("cWarnOperation", "预警");
					}
					if("2".equalsIgnoreCase(map.get("C_WARN_OPERATION"))){
						obj.setString("cWarnOperation", "禁止");
					}
					if("3".equalsIgnoreCase(map.get("C_WARN_OPERATION"))){
						obj.setString("cWarnOperation", "申请指令审批");
					}
					if("4".equalsIgnoreCase(map.get("C_WARN_OPERATION"))){
						obj.setString("cWarnOperation", "申请风险阀值");
					}
					//obj.setString("lTempNo", map.get("L_TEMP_NO"));   //临时序号：对于指令端：指令下达时，先前台调用风控服务时，如果有预警，并继续时，前台记录到预警记录（如果前台要输入原因的话），但此时还没有指令序号，先记录临时序号（唯一的）。指令下达后，指令服务再根据临时序号 把指令序号填入到预警记录表。对于交易端：是填0；另外：对于同一个组合指令，在临时指令表，也是用这个临时序号表明是同一个组合指令。
					//obj.setString("lLayerId", map.get("L_LAYER_ID"));   //*触发的层次序号：触犯风控的基金、或资产单元或投资计划、计划配置。-1:表示所有基金。资产单元、投资计划、计划配置不支持 汇总控制的；
					//obj.setString("cEntrustDirection", map.get("C_ENTRUST_DIRECTION"));   //委托方向
					//obj.setString("cInvestType", map.get("C_INVEST_TYPE"));   //投资类型：1-可交易；2-持有到期；3-可供出售；4-贷款和应收款项；
					//if("1".equalsIgnoreCase(map.get("C_INVEST_TYPE"))){
					//	obj.setString("cInvestType", "可交易");
					//}
					//if("2".equalsIgnoreCase(map.get("C_INVEST_TYPE"))){
					//	obj.setString("cInvestType", "持有到期");
					//}
					//if("3".equalsIgnoreCase(map.get("C_INVEST_TYPE"))){
					//	obj.setString("cInvestType", "可供出售");
					//}
					//if("4".equalsIgnoreCase(map.get("C_INVEST_TYPE"))){
					//	obj.setString("cInvestType", "贷款和应收款项");
					//}
					//obj.setString("lFactLayerId", map.get("L_FACT_LAYER_ID"));   //*实际控制层次：假设基金1属于委托人A，静态风控中当某个基金触发一条风控，之前只知道是委托人A触发的风控却不知道具体是A下的哪个基金触发的，增加实际控制层次记录具体是A下的哪个基金触发的。风控支持组合层后精度要调整到12位，与组合序号精度一致；
					//obj.setString("lStockSerialNo", map.get("L_STOCK_SERIAL_NO"));   //#指令证券号：旧版撮合业务使用，用以区分同一笔撮合业务中所有其他信息都相同的不同指令证券。其他业务均填0。
					//obj.setString("lDimensionId", map.get("L_DIMENSION_ID"));   //#维度编号：风控按维度/多维度控制时填写，其他控制方式填0。该字段属于唯一性索引中的字段，用以区分多维度控制时的不同维度。
					obj.setString("cLogSource", map.get("C_LOG_SOURCE"));   //#日志来源：0-试算风险；1-正式下达；
					result.add(obj);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			JDBCUtil.releaseResource(conn, null, null);
		}
			
		return result;
	}
	
	
	/**
	 * 根据第三方系统指令编号查询Fix协议发送报文数据记录
	 * @param conn 数据库连接，若不传入，则新建数据连接后再关闭
	 * @param vcClOrdId 第三方系统指令编号
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> queryFixSendMsgByClOrdId(Connection conn, String vcClOrdId){
		boolean isCloseConn = false;
		DataObject obj = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try{
			//获取默认数据库连接
			if(conn==null || conn.isClosed()){
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				isCloseConn = true;
			}
			
			//查询SQL语句
			sb.append("select t.vc_biz_tbl_name, ")//流程主表表名
			  .append("       t.vc_apv_tbl_name, ")//业务主表表名
			  .append("       t.vc_status_fld_name, ")//FIX状态字段名
			  .append("       t.vc_key_fld_name, ")//FIX关键字段名
			  .append("       t.vc_status_values ")//FIX状态值域：如(3|4)3成功,4失败
			  .append("  from t_ats_fix_send_msg t ")//Fix协议发送报文数据表
			  .append(" where 1 = 1 ");
			//组装查询条件
			if(StringUtils.isNotBlank(vcClOrdId)){
				sb.append("   and t.vc_clordid = '").append(vcClOrdId).append("' ");
			}
			//增加排序
			sb.append(" order by t.d_created asc");
			
			//查询结果集
			List<Map<String,String>> maps = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			
			if(!maps.isEmpty() && maps.size()>0){
				for(int i=0; i<maps.size(); i++){
					Map<String, String> map = maps.get(i);
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.FixEntity");
					obj.setString("VC_BIZ_TBL_NAME", map.get("VC_BIZ_TBL_NAME"));//
					obj.setString("VC_APV_TBL_NAME", map.get("VC_APV_TBL_NAME"));//
					obj.setString("VC_STATUS_FLD_NAME", map.get("VC_STATUS_FLD_NAME"));//
					obj.setString("VC_KEY_FLD_NAME", map.get("VC_KEY_FLD_NAME"));//
					obj.setString("VC_STATUS_VALUES", map.get("VC_STATUS_VALUES"));//
					
					result.add(obj);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			if(isCloseConn){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
		return result;
	}
	
	/**
	 * 将Fix向第三方系统发送的消息保存
	 * @param sendMsg 指令消息
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static DataObject insertFixSendMsg(DataObject sendMsg){
		DataObject insertSendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");
		DatabaseExt.getPrimaryKey(insertSendMsg);//生成主键
		insertSendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		
		if(sendMsg != null){
			if(StringUtils.isNotBlank(sendMsg.getString("vcMsgtype"))){
				insertSendMsg.setString("vcMsgtype", sendMsg.getString("vcMsgtype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcSendersubid"))){
				insertSendMsg.setString("vcSendersubid", sendMsg.getString("vcSendersubid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcClordid"))){
				insertSendMsg.setString("vcClordid", sendMsg.getString("vcClordid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBusinclass"))){
				insertSendMsg.setString("vcBusinclass", sendMsg.getString("vcBusinclass"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBusintype"))){
				insertSendMsg.setString("vcBusintype", sendMsg.getString("vcBusintype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcAccount"))){
				insertSendMsg.setString("vcAccount", sendMsg.getString("vcAccount"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcSymbol"))){
				insertSendMsg.setString("vcSymbol", sendMsg.getString("vcSymbol"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcSecurityid"))){
				insertSendMsg.setString("vcSecurityid", sendMsg.getString("vcSecurityid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcSide"))){
				insertSendMsg.setString("vcSide", sendMsg.getString("vcSide"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcExdestination"))){
				insertSendMsg.setString("vcExdestination", sendMsg.getString("vcExdestination"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInvesttype"))){
				insertSendMsg.setString("vcInvesttype", sendMsg.getString("vcInvesttype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcPrice"))){
				insertSendMsg.setString("vcPrice", sendMsg.getString("vcPrice"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcStopPrice"))){
				insertSendMsg.setString("vcStopPrice", sendMsg.getString("vcStopPrice"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcOrdtype"))){
				insertSendMsg.setString("vcOrdtype", sendMsg.getString("vcOrdtype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcOrderqty"))){
				insertSendMsg.setString("vcOrderqty", sendMsg.getString("vcOrderqty"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcCashorderqty"))){
				insertSendMsg.setString("vcCashorderqty", sendMsg.getString("vcCashorderqty"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcReporate"))){
				insertSendMsg.setString("vcReporate", sendMsg.getString("vcReporate"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcOthercombino"))){
				insertSendMsg.setString("vcOthercombino", sendMsg.getString("vcOthercombino"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcOtherinvesttype"))){
				insertSendMsg.setString("vcOtherinvesttype", sendMsg.getString("vcOtherinvesttype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcTimeinforce"))){
				insertSendMsg.setString("vcTimeinforce", sendMsg.getString("vcTimeinforce"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcTransacttime"))){
				insertSendMsg.setString("vcTransacttime", sendMsg.getString("vcTransacttime"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBegindate"))){
				insertSendMsg.setString("vcBegindate", sendMsg.getString("vcBegindate"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcExpiredate"))){
				insertSendMsg.setString("vcExpiredate", sendMsg.getString("vcExpiredate"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcJudgeavailable"))){
				insertSendMsg.setString("vcJudgeavailable", sendMsg.getString("vcJudgeavailable"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcJudgerisk"))){
				insertSendMsg.setString("vcJudgerisk", sendMsg.getString("vcJudgerisk"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInstructionlevel"))){
				insertSendMsg.setString("vcInstructionlevel", sendMsg.getString("vcInstructionlevel"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDirectinsteadoperator"))){
				insertSendMsg.setString("vcDirectinsteadoperator", sendMsg.getString("vcDirectinsteadoperator"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInstructiontype"))){
				insertSendMsg.setString("vcInstructiontype", sendMsg.getString("vcInstructiontype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcText"))){
				insertSendMsg.setString("vcText", sendMsg.getString("vcText"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcSettltype"))){
				insertSendMsg.setString("vcSettltype", sendMsg.getString("vcSettltype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInterest"))){
				insertSendMsg.setString("vcInterest", sendMsg.getString("vcInterest"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcYtm"))){
				insertSendMsg.setString("vcYtm", sendMsg.getString("vcYtm"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcTraderival"))){
				insertSendMsg.setString("vcTraderival", sendMsg.getString("vcTraderival"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBondsettletype"))){
				insertSendMsg.setString("vcBondsettletype", sendMsg.getString("vcBondsettletype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBondsettletype2"))){
				insertSendMsg.setString("vcBondsettletype2", sendMsg.getString("vcBondsettletype2"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcTargetsubid"))){
				insertSendMsg.setString("vcTargetsubid", sendMsg.getString("vcTargetsubid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcRivaltraderid"))){
				insertSendMsg.setString("vcRivaltraderid", sendMsg.getString("vcRivaltraderid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcRivalaccount"))){
				insertSendMsg.setString("vcRivalaccount", sendMsg.getString("vcRivalaccount"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcCleartype"))){
				insertSendMsg.setString("vcCleartype", sendMsg.getString("vcCleartype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcQuoteside"))){
				insertSendMsg.setString("vcQuoteside", sendMsg.getString("vcQuoteside"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcYieldratiotype"))){
				insertSendMsg.setString("vcYieldratiotype", sendMsg.getString("vcYieldratiotype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBonustype"))){
				insertSendMsg.setString("vcBonustype", sendMsg.getString("vcBonustype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBulktype"))){
				insertSendMsg.setString("vcBulktype", sendMsg.getString("vcBulktype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDeposittype"))){
				insertSendMsg.setString("vcDeposittype", sendMsg.getString("vcDeposittype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcIssuedate"))){
				insertSendMsg.setString("vcIssuedate", sendMsg.getString("vcIssuedate"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInterestpaytype"))){
				insertSendMsg.setString("vcInterestpaytype", sendMsg.getString("vcInterestpaytype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDepositinfo"))){
				insertSendMsg.setString("vcDepositinfo", sendMsg.getString("vcDepositinfo"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcTerm"))){
				insertSendMsg.setString("vcTerm", sendMsg.getString("vcTerm"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcBankhandoffice"))){
				insertSendMsg.setString("vcBankhandoffice", sendMsg.getString("vcBankhandoffice"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDepositbank"))){
				insertSendMsg.setString("vcDepositbank", sendMsg.getString("vcDepositbank"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcNoticedays"))){
				insertSendMsg.setString("vcNoticedays", sendMsg.getString("vcNoticedays"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcWithdrawtype"))){
				insertSendMsg.setString("vcWithdrawtype", sendMsg.getString("vcWithdrawtype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDepositaccountno"))){
				insertSendMsg.setString("vcDepositaccountno", sendMsg.getString("vcDepositaccountno"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDepositaccountname"))){
				insertSendMsg.setString("vcDepositaccountname", sendMsg.getString("vcDepositaccountname"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDepositplace"))){
				insertSendMsg.setString("vcDepositplace", sendMsg.getString("vcDepositplace"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDepositowner"))){
				insertSendMsg.setString("vcDepositowner", sendMsg.getString("vcDepositowner"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcAdvancelimitflag"))){
				insertSendMsg.setString("vcAdvancelimitflag", sendMsg.getString("vcAdvancelimitflag"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcLimitunit"))){
				insertSendMsg.setString("vcLimitunit", sendMsg.getString("vcLimitunit"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcProvincecode"))){
				insertSendMsg.setString("vcProvincecode", sendMsg.getString("vcProvincecode"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcCityno"))){
				insertSendMsg.setString("vcCityno", sendMsg.getString("vcCityno"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcFutsettdate"))){
				insertSendMsg.setString("vcFutsettdate", sendMsg.getString("vcFutsettdate"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcFutsettdate2"))){
				insertSendMsg.setString("vcFutsettdate2", sendMsg.getString("vcFutsettdate2"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcEarnestbalance"))){
				insertSendMsg.setString("vcEarnestbalance", sendMsg.getString("vcEarnestbalance"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcFee"))){
				insertSendMsg.setString("vcFee", sendMsg.getString("vcFee"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcFeecalctype"))){
				insertSendMsg.setString("vcFeecalctype", sendMsg.getString("vcFeecalctype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcDestsecurity"))){
				insertSendMsg.setString("vcDestsecurity", sendMsg.getString("vcDestsecurity"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcPurposetype"))){
				insertSendMsg.setString("vcPurposetype", sendMsg.getString("vcPurposetype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcRequireorigin"))){
				insertSendMsg.setString("vcRequireorigin", sendMsg.getString("vcRequireorigin"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcListid"))){
				insertSendMsg.setString("vcListid", sendMsg.getString("vcListid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcOrigordid"))){
				insertSendMsg.setString("vcOrigordid", sendMsg.getString("vcOrigordid"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcNotradingsessions"))){
				insertSendMsg.setString("vcNotradingsessions", sendMsg.getString("vcNotradingsessions"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcTotnoorders"))){
				insertSendMsg.setString("vcTotnoorders", sendMsg.getString("vcTotnoorders"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcNoorders"))){
				insertSendMsg.setString("vcNoorders", sendMsg.getString("vcNoorders"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInterestrates"))){
				insertSendMsg.setString("vcInterestrates", sendMsg.getString("vcInterestrates"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("lInstructionId"))){
				insertSendMsg.setString("lInstructionId", sendMsg.getString("lInstructionId"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("lInstructionNo"))){
				insertSendMsg.setString("lInstructionNo", sendMsg.getString("lInstructionNo"));
			}
			
			//以下为风控试算、可用试算等功能用到字段
			if(StringUtils.isNotBlank(sendMsg.getString("vcProcesstype"))){
				insertSendMsg.setString("vcProcesstype", sendMsg.getString("vcProcesstype"));//15999-处理类型：4-风险试算；5-可用金额查询；6-可用数量查询；7-风控试算结果；8-可用金额查询结果；9-可用数量查询结果；
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInstructionno"))){
				insertSendMsg.setString("vcInstructionno", sendMsg.getString("vcInstructionno"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcEnddate"))){
				insertSendMsg.setString("vcEnddate", sendMsg.getString("vcEnddate"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcGroup"))){
				insertSendMsg.setString("vcGroup", sendMsg.getString("vcGroup"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcStocktargettype"))){
				insertSendMsg.setString("vcStocktargettype", sendMsg.getString("vcStocktargettype"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcExecbroker"))){
				insertSendMsg.setString("vcExecbroker", sendMsg.getString("vcExecbroker"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcMortagageinfo"))){
				insertSendMsg.setString("vcMortagageinfo", sendMsg.getString("vcMortagageinfo"));
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcMarketdate"))){
				insertSendMsg.setString("vcMarketdate", sendMsg.getString("vcMarketdate"));//15203-起始日期：允许为空，若为空则取当天日期。存款和支取传的是到期日。
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcMarketenddate"))){
				insertSendMsg.setString("vcMarketenddate", sendMsg.getString("vcMarketenddate"));//15204-结束日期：允许为空，若为空则取当天日期。存款和支取传的是到期日。
			}
			
			//以下为在Fix状态报文返回时反向更新业务表相关字段
			if(StringUtils.isNotBlank(sendMsg.getString("vcBizTblName"))){
				insertSendMsg.setString("vcBizTblName", sendMsg.getString("vcBizTblName"));//流程主表表名
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcApvTblName"))){
				insertSendMsg.setString("vcApvTblName", sendMsg.getString("vcApvTblName"));//业务主表表名
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcStatusFldName"))){
				insertSendMsg.setString("vcStatusFldName", sendMsg.getString("vcStatusFldName"));//FIX状态字段名
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcKeyFldName"))){
				insertSendMsg.setString("vcKeyFldName", sendMsg.getString("vcKeyFldName"));//FIX关键字段名
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcStatusValues"))){
				insertSendMsg.setString("vcStatusValues", sendMsg.getString("vcStatusValues"));//FIX状态值域：如(3|4)3成功,4失败
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcClassFullName"))){
				insertSendMsg.setString("vcClassFullName", sendMsg.getString("vcClassFullName"));//回调类全名，反射Class.forName(类的全路径)方法加载的参数值
			}
			if(StringUtils.isNotBlank(sendMsg.getString("vcInvokeMethodName"))){
				insertSendMsg.setString("vcInvokeMethodName", sendMsg.getString("vcInvokeMethodName"));//回调方法名称，包含三个参数：第三方系统指令编号[字符串型]，Fix指令发送的报文“成功”或者“失败”的状态[布尔型]，指令反馈结果情况类型[字符串型]，如fixCallback(String vcClordid,boolean isSuccess,String resultMsgType)
			}
			
			//执行插入操作
			DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, insertSendMsg);
		}
		return insertSendMsg;
	}
	
	/**
	 * 将Fix向第三方系统发送的消息对应的重复组（债券信息）保存
	 * @param bondsList 重复组债券信息对象列表
	 * @param lMsgId 消息主键ID
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void insertFixSendRepeatGroup(List<List<DataObject>> bondsList, String lMsgId){
		if(!bondsList.isEmpty() && bondsList.size()>0){
			for(int i=0; i<bondsList.size(); i++){
				List<DataObject> beanList = bondsList.get(i);
				if(!beanList.isEmpty() && beanList.size()>0){
					for(int j=0; j<beanList.size(); j++){
						DataObject bean = beanList.get(j);
						if(bean != null){
							DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
							DatabaseExt.getPrimaryKey(bond);//生成主键
							bond.setString("lMsgId", lMsgId);//消息主键ID（外键）
							bond.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
							
							if(StringUtils.isNotBlank(bean.getString("vcNoallocs"))){
								bond.setString("vcNoallocs", bean.getString("vcNoallocs"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcAccount"))){
								bond.setString("vcAccount", bean.getString("vcAccount"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcInvesttype"))){
								bond.setString("vcInvesttype", bean.getString("vcInvesttype"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcPledgebond"))){
								bond.setString("vcPledgebond", bean.getString("vcPledgebond"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcPledgeratio"))){
								bond.setString("vcPledgeratio", bean.getString("vcPledgeratio"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcPledgedqty"))){
								bond.setString("vcPledgedqty", bean.getString("vcPledgedqty"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcNotradingsessions"))){
								bond.setString("vcNotradingsessions", bean.getString("vcNotradingsessions"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcSymbol"))){
								bond.setString("vcSymbol", bean.getString("vcSymbol"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcSecurityid"))){
								bond.setString("vcSecurityid", bean.getString("vcSecurityid"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcExdestination"))){
								bond.setString("vcExdestination", bean.getString("vcExdestination"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcBusintype"))){
								bond.setString("vcBusintype", bean.getString("vcBusintype"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcPrice"))){
								bond.setString("vcPrice", bean.getString("vcPrice"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcOrdtype"))){
								bond.setString("vcOrdtype", bean.getString("vcOrdtype"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcOrderqty"))){
								bond.setString("vcOrderqty", bean.getString("vcOrderqty"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcCashorderqty"))){
								bond.setString("vcCashorderqty", bean.getString("vcCashorderqty"));
							}
							
							//以下为风控试算、可用试算等功能用到字段
							if(StringUtils.isNotBlank(bean.getString("vcInterest"))){
								bond.setString("vcInterest", bean.getString("vcInterest"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcStocktargettype"))){
								bond.setString("vcStocktargettype", bean.getString("vcStocktargettype"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcExecbroker"))){
								bond.setString("vcExecbroker", bean.getString("vcExecbroker"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcBondsettletype"))){
								bond.setString("vcBondsettletype", bean.getString("vcBondsettletype"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcBondsettletype2"))){
								bond.setString("vcBondsettletype2", bean.getString("vcBondsettletype2"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcAdvancelimitflag"))){
								bond.setString("vcAdvancelimitflag", bean.getString("vcAdvancelimitflag"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcWithdrawtype"))){
								bond.setString("vcWithdrawtype", bean.getString("vcWithdrawtype"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcIssuedate"))){
								bond.setString("vcIssuedate", bean.getString("vcIssuedate"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcReporate"))){
								bond.setString("vcReporate", bean.getString("vcReporate"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcEarnestbalance"))){
								bond.setString("vcEarnestbalance", bean.getString("vcEarnestbalance"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcMortagageinfo"))){
								bond.setString("vcMortagageinfo", bean.getString("vcMortagageinfo"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcAccruedinterestamt"))){
								bond.setString("vcAccruedinterestamt", bean.getString("vcAccruedinterestamt"));//159-应计利息，【只用于银行间债券和质押式回购】
							}
							if(StringUtils.isNotBlank(bean.getString("vcRealBondInterest"))){
								bond.setString("vcRealBondInterest", bean.getString("vcRealBondInterest"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcBondYield"))){//首次收益率（传0.03表示3%）
								bond.setString("vcBondYield", bean.getString("vcBondYield"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcBondYield2"))){//到期收益率（传0.03表示3%）
								bond.setString("vcBondYield2", bean.getString("vcBondYield2"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcText"))){//备注
								bond.setString("vcText", bean.getString("vcText"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcStopPrice"))){//到期净价价格
								bond.setString("vcStopPrice", bean.getString("vcStopPrice"));
							}
							if(StringUtils.isNotBlank(bean.getString("vcTransactTime"))){//订单发起时间
								bond.setString("vcTransactTime", bean.getString("vcTransactTime"));
							}
							
							if(StringUtils.isNotBlank(bean.getString("vcIssuedateex"))){
								bond.setString("vcIssuedateex", bean.getString("vcIssuedateex"));//13226-起息日，【只用于协议存款和定期存款】如果起息日没指定或0，表示当天
							}
							if(StringUtils.isNotBlank(bean.getString("vcCheckmemo"))){
								bond.setString("vcCheckmemo", bean.getString("vcCheckmemo"));//14058-失败原因，质押券信息包含多条：组合0|投资类型0|质押券0|质押比例0|质押数量0；组合1|投资类型1|质押券1|质押比例1|质押数量1；组合n|投资类型n|质押券n|质押比例n|质押数量n
							}
							
							
							//执行插入操作
							DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, bond);
						}
					}
				}
			}
		}
	}
	
	/**
	 * 获取反馈报文状态等信息：Fix指令发送的报文“成功”或者“失败”的状态 && 指令反馈结果情况类型
	 * 
	 * A01-指令下达成功;A02-指令下达后成功分发;A03-指令撤销成功;
	 * A04-指令修改成功;A05-指令修改后成功分发;A06-部分委托;
	 * A07-全部委托;A08-部分成交;A09-全部成交;
	 * B01-指令接收到下达、修改信息后校验通不过（未插入接口表）;
	 * B02-指令接收到撤销信息后校验通不过（未插入接口表）;
	 * B03-指令下达失败（已插入接口表）;
	 * B04-指令修改/撤销失败，或者修改后被审批拒绝、分发拒绝;
	 * B05-查询数据校验不通过;
	 * B06-风控试算成功;
	 * B07-可用金额查询成功;
	 * B08-可用数量查询成功;
	 * 999-其它情况失败;
	 * 
	 * [35，MsgType]消息类型（Fix标准消息类型，定义在消息头）：
	 * 8 – Execution Report，表示指令状态、委托数据反馈、成交数据反馈；
	 * 8 – Execution Report，表示恒生系统下达指令失败导致的订单撤销(Fix标准定义)；
	 * 9 – Order Cancel Reject，表示恒生系统修改/撤销指令失败、fix报文格式本身错误、缺少必输项等导致的订单拒绝(Fix标准定义)；
	 * 
	 * [15999，ProceType]处理类型：1 – 下达拒绝；2 – 状态反馈(指令状态)；3 – 成交反馈；10 – 委托数据反馈；
	 * 
	 * [39，OrdStatus]指令状态：
	 * 0 – 已下达未成交(New)；1 – 部分成交(Partial fill)；2 – 全部成交（Fill）；4 – 已撤销（Canceled）；
	 * 5 – 已修改（Replace）；6 – 接收到撤销的指令（Pending Cancel）；8 - 已拒绝(Rejected)；
	 * A – 接收到下达的指令（Pending New）；E – 接收到修改的指令（Pending Replace）；
	 * FIX4.4版本指令状态(tag)已删除5-已修改；注：状态变化过程见文档第三部分Fix反馈状态说明
	 * 
	 * [150，ExecType]执行状态，值域同指令状态：4 – 已拒绝（Canceled）；
	 * 注：对于指令下达拒绝的时候填4,否则为空,状态变化过程见文档第三部分Fix反馈状态说明
	 * 
	 * @param paramDataObject 保存Fix返回报文状态对象
	 * @return isSuccess=true|false; resultMsgType=A01|A02|A03|A04|A05|A06|A07|A08|A09|B01|B02|B03|B04|B05|B06|B07|B08|999;
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static DataObject getExecutionReportStatus(DataObject paramDataObject){
		DataObject resultDataObject = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		boolean isSuccess = false;//指令发送“成功”或者“失败”的状态
		String resultMsgType = "999";//指令反馈结果情况类型
		String returnMsgType = paramDataObject.getString("vcMsgtype");//35
		String returnProceType = paramDataObject.getString("vcProcetype");//15999
		String returnOrdStatus = paramDataObject.getString("vcOrdstatus");//39
		String returnExecType = paramDataObject.getString("vcExectype");//150
		
		/** 指令发送成功 */
		if("8".equals(returnMsgType) && "2".equals(returnProceType) && "A".equals(returnOrdStatus) && "A".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "A01";//A01-指令下达成功：35=8;15999=2;39=A;150=A;
		
		}else if("8".equals(returnMsgType) && "2".equals(returnProceType) && "0".equals(returnOrdStatus) && "0".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "A02";//A02-指令下达后成功分发：35=8;15999=2;39=0;150=0;
			
		}else if("8".equals(returnMsgType) && "2".equals(returnProceType) && "4".equals(returnOrdStatus) && ("1".equals(returnExecType)||"2".equals(returnExecType)||"4".equals(returnExecType))){
			isSuccess = true;//指令发送成功
			resultMsgType = "A03";//A03-指令撤销成功：35=8;15999=2;39=4;150=1或150=2或150=4;
			
		}else if("8".equals(returnMsgType) && "2".equals(returnProceType) && "E".equals(returnOrdStatus) && ("1".equals(returnExecType)||"2".equals(returnExecType)||"E".equals(returnExecType))){
			isSuccess = true;//指令发送成功
			resultMsgType = "A04";//A04-指令修改成功：35=8;15999=2;39=E;150=1或150=2或150=E;
			
		}else if("8".equals(returnMsgType) && "2".equals(returnProceType) && "5".equals(returnOrdStatus) && ("1".equals(returnExecType)||"2".equals(returnExecType)||"5".equals(returnExecType))){
			isSuccess = true;//指令发送成功
			resultMsgType = "A05";//A05-指令修改后成功分发：35=8;15999=2;39=5;150=1或150=2或150=5;
			
		}else if("8".equals(returnMsgType) && "10".equals(returnProceType) && "1".equals(returnOrdStatus) && "1".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "A06";//A06-部分委托：35=8;15999=10;39=1;150=1;
			
		}else if("8".equals(returnMsgType) && "10".equals(returnProceType) && "2".equals(returnOrdStatus) && "2".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "A07";//A07-全部委托：35=8;15999=10;39=2;150=2;
			
		}else if("8".equals(returnMsgType) && "3".equals(returnProceType) && "1".equals(returnOrdStatus) && "1".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "A08";//A08-部分成交：35=8;15999=3;39=1;150=1;
			
		}else if("8".equals(returnMsgType) && "3".equals(returnProceType) && "2".equals(returnOrdStatus) && "2".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "A09";//A09-全部成交：35=8;15999=3;39=2;150=2;
			
		}else if("8".equals(returnMsgType) && "1".equals(returnProceType) && "8".equals(returnOrdStatus) && ("1".equals(returnExecType)||"2".equals(returnExecType)||"8".equals(returnExecType))){
			isSuccess = false;//指令发送失败
			resultMsgType = "B01";//B01-指令接收到下达、修改信息后校验通不过（未插入接口表）：35=8;15999=1;39=8;150=1或150=2或150=8;
			
		}else if("9".equals(returnMsgType) && "1".equals(returnProceType) && "8".equals(returnOrdStatus) && ("1".equals(returnExecType)||"2".equals(returnExecType)||"8".equals(returnExecType))){
			isSuccess = false;//指令发送失败
			resultMsgType = "B02";//B02-指令接收到撤销信息后校验通不过（未插入接口表）：35=9;15999=1;39=8;150=1或150=2或150=8;
			
		}else if("8".equals(returnMsgType) && "1".equals(returnProceType) && "8".equals(returnOrdStatus) && "8".equals(returnExecType)){
			isSuccess = false;//指令发送失败
			resultMsgType = "B03";//B03-指令下达失败（已插入接口表）：35=8;15999=1;39=8;150=8;
			
		}else if("9".equals(returnMsgType) && "1".equals(returnProceType) && "8".equals(returnOrdStatus) && "8".equals(returnExecType)){
			isSuccess = false;//指令发送失败
			resultMsgType = "B04";//B04-指令修改/撤销失败，或者修改后被审批拒绝、分发拒绝：35=9;15999=1;39=8;150=8;
			
		}else if("9".equals(returnMsgType) && "1".equals(returnProceType) && "4".equals(returnOrdStatus) && "4".equals(returnExecType)){
			isSuccess = false;//指令发送失败
			resultMsgType = "B05";//B05-查询数据校验不通过。35=9;15999=1;39=4;150=4;
			
		}else if("8".equals(returnMsgType) && "7".equals(returnProceType) && "0".equals(returnOrdStatus) && "0".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "B06";//B06-风控试算成功。35=8;15999=7;39=0;150=0;
			
		}else if("8".equals(returnMsgType) && "8".equals(returnProceType) && "0".equals(returnOrdStatus) && "0".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "B07";//B07-可用金额查询成功。35=8;15999=8;39=0;150=0;
			
		}else if("8".equals(returnMsgType) && "9".equals(returnProceType) && "0".equals(returnOrdStatus) && "0".equals(returnExecType)){
			isSuccess = true;//指令发送成功
			resultMsgType = "B08";//B08-可用数量查询成功。35=8;15999=9;39=0;150=0;

		/** 指令发送失败 */
		}else{
			isSuccess = false;//指令发送失败
			resultMsgType = "999";//指令反馈结果情况类型
		}
		
		resultDataObject.setBoolean("isSuccess", isSuccess);
		resultDataObject.setString("resultMsgType", resultMsgType);
		return resultDataObject;
	}
	
	
	/**
	 * 判断风控结果类型（0-未触发风控，1-预警型风控，2-禁止型风控 ，3-审批型风控，）
	 * @param 
	 * @param 
	 * @author 刘玉龙
	 */
	@SuppressWarnings("unused")
	@Bizlet("")
	public static String riskMsgAsert(List<DataObject> riskMsgs){
		String riskType = "0";
		int operation = 0;//触警操作为“无”的个数
		int alertOperation = 0;//触警操作为“预警”的个数
		int forbidOperation = 0;//触警操作为“禁止”的个数
		int approveOperation = 0;//触警操作为“申请指令审批”的个数
		int askOperation = 0;//触警操作为“申请风险阀值”的个数
		
		if(!riskMsgs.isEmpty() && riskMsgs.size()>0){
			for(int i=0; i<riskMsgs.size(); i++){
				DataObject riskMsg = riskMsgs.get(i);
				String warnOperation = riskMsg.getString("cWarnOperation");//触警操作
				if("无".equals(warnOperation)){//触警操作为“无”
					operation+=1;
				}else if("预警".equals(warnOperation)){//触警操作为“预警”
					alertOperation+=1;
				}else if("禁止".equals(warnOperation)){//触警操作为“禁止”
					forbidOperation+=1;
				}else if("申请指令审批".equals(warnOperation)){//触警操作为“申请指令审批”
					approveOperation+=1;
				}else if("申请风险阀值".equals(warnOperation)){//触警操作为“申请风险阀值”
					askOperation+=1;
				}
			}
		}
		if(forbidOperation!=0){
			riskType="3";//风控结果为禁止
		}else{
			if(approveOperation != 0){
				riskType="2";//风控结果为审批
			}else if(alertOperation != 0){
				riskType="1";//风控结果为预警
			}
		}
		return riskType;
	}
	
	/**
	 * 判断风控结果类型（0-未触发风控，1-预警型风控，2-禁止型风控 ，3-审批型风控，）
	 * @param 
	 * @param 
	 * @author 刘玉龙
	 */
	@SuppressWarnings("unused")
	@Bizlet("")
	public static String riskMsgAsert(DataObject[] riskMsgs){
		String riskType = "0";
		int operation = 0;//触警操作为“无”的个数
		int alertOperation = 0;//触警操作为“预警”的个数
		int forbidOperation = 0;//触警操作为“禁止”的个数
		int approveOperation = 0;//触警操作为“申请指令审批”的个数
		int askOperation = 0;//触警操作为“申请风险阀值”的个数
		
		if(riskMsgs.length>0){
			for(int i=0; i<riskMsgs.length; i++){
				DataObject riskMsg = riskMsgs[i];
				String warnOperation = riskMsg.getString("cRiskOperation");//触警操作
				if("0".equals(warnOperation)){//触警操作为“无”
					operation+=1;
				}else if("1".equals(warnOperation)){//触警操作为“预警”
					alertOperation+=1;
				}else if("2".equals(warnOperation)){//触警操作为“禁止”
					forbidOperation+=1;
				}else if("3".equals(warnOperation)){//触警操作为“申请指令审批”
					approveOperation+=1;
				}else if("4".equals(warnOperation)){//触警操作为“申请风险阀值”
					askOperation+=1;
				}
			}
		}
		if(forbidOperation!=0){
			riskType="2";//风控结果为禁止
		}else{
			if(approveOperation != 0 || askOperation != 0){
				riskType="3";//风控结果为审批
			}else if(alertOperation != 0){
				riskType="1";//风控结果为预警
			}
		}
		return riskType;
	}
	
	/**
	 * 将“O32风险对应操作代码”转换为“O32风险对应操作名称”
	 * 0-无;1-预警;2-禁止;3-申请指令审批;4-申请风险阀值;5-不提示;
	 * 
	 * @param riskCtrlCode O32风险对应操作代码
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getRiskCtrlOperateName(String riskCtrlCode){
		if(StringUtils.isBlank(riskCtrlCode)){
			return "";
		}
		String result = "";
		if("0".equals(riskCtrlCode)){
			
		}else if("1".equals(riskCtrlCode)){
			result = "预警";
		}else if("2".equals(riskCtrlCode)){
			result = "禁止";
		}else if("3".equals(riskCtrlCode)){
			result = "申请指令审批";
		}else if("4".equals(riskCtrlCode)){
			result = "申请风险阀值";
		}else if("5".equals(riskCtrlCode)){
			result = "不提示";
		}
		return result;
	}
	
	/**
	 * 根据债券代码+市场标识（YH,SZ,SS）获取债券名称
	 * 
	 * @param riskCtrlCode O32风险对应操作代码
	 * @return
	 * @author liuyulong
	 */
	@Bizlet("")
	public static void getO32StockName(DataObject[] resultDetails){
		try{
			String dataSource = CacheUtil.getO32CacheDataSourceName();
			for(DataObject resultDetail:resultDetails){
				Object[] results = DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.foundation.fix.model.interfaceMessageManager.getO32StockName", resultDetail);
				if(results.length>0 && results[0]!=null){
					DataObject result = (DataObject) results[0];
					resultDetail.setString("vcStockName", result.getString("VC_STOCK_NAME"));
				}
			}
		}catch(Exception e){
			System.out.println("风控试算，无债券风控试算从o32获取债券名称失败!");
		}
	}
	
	
}
