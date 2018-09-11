/**
 * 
 */
package com.cjhxfund.ats.fm.instr;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.model.TProductHandle;
import com.cjhxfund.foundation.fix.FixToMsgUtil;
import com.eos.foundation.common.utils.DateUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.data.WFActivityDefine;
import com.eos.workflow.data.WFWorkItem;
import com.eos.workflow.omservice.WFParticipant;
import com.eos.workflow.omservice.WIParticipantInfo;
import com.primeton.das.entity.impl.hibernate.criterion.NullExpression;

import commonj.sdo.DataObject;



/**
 * @author 杨敏
 * @date 2016-08-24 11:08:11
 *
 */
@Bizlet("")
public class ApplyInstUtil {
	//定义指令申购流程中标确认前的所有节点
	public static final String[] REPROTS_ACTS={"ATS_FM_TGLR","ATS_FM_TGFH","ATS_FM_WTRFH","ATS_FM_XXHD1","ATS_FM_XXHD2","ATS_FM_TZJLFH",
							"ATS_FM_ZJZLSP","ATS_FM_ZXZJFH","ATS_FM_FGLDFH","ATS_FM_FKRGSH","ATS_FM_TBYY","ATS_FM_CZ_TBZX"};
	//定义缴款流程的所有节点
	public static final String[] PAYMENT_ACTS={"ATS_FM_TGLR","ATS_FM_TGFH","ATS_FM_WTRFH","ATS_FM_XXHD1","ATS_FM_XXHD2","ATS_FM_TZJLFH",
									"ATS_FM_ZJZLSP","ATS_FM_ZXZJFH","ATS_FM_FGLDFH","ATS_FM_FKRGSH","ATS_FM_XYYYPD","ATS_FM_XYYY1","ATS_FM_XYYY2","ATS_FM_SCSFYYXY"
									,"ATS_FM_ZJQS","ATS_FM_PDFXYYY","ATS_FM_FXYYYFH","ATS_FM_FXYYY"};
	/**
	 * 验证工作项是否在传真之前
	 * @param wfs
	 * @return
	 * @throws Exception 
	 */
	@Bizlet("验证工作项是否在传真之前")
	public static int isCZWork(DataObject[] wfs) throws Exception {
		if(wfs.length<1){
			throw new Exception("验证工作项是否为传真节点是，发现找不到相关工作项数据！！");
		}
		for (int i = 0; i < wfs.length; i++) {
			DataObject dataObject = wfs[i];
			String activityDefID = dataObject.getString("activityDefID");
			if(activityDefID.indexOf("ATS_FM_CZ")>=0 && !activityDefID.equals("ATS_FM_CZ_TBZX")){
				return 1;
			}
			
		}
		return 2;
	}
	/**
	 * 验证参与者是否被包含
	 * @param wfs
	 * @return
	 * @throws Exception 
	 */
	@Bizlet("验证工作项是否在传真之前")
	public static int isEqualParticipant(DataObject[] wfs,String userId) throws Exception {
		if(wfs.length<1){
			return -1;
		}
		for (int i = 0; i < wfs.length; i++) {
			DataObject dataObject = wfs[i];
			String activityDefID = dataObject.getString("PARTICIPANTID")+",";
			if(activityDefID.indexOf(userId+",")!=-1){
				return 1;
			}
		}
		return -1;
	}
	/**
	 * 获取当前流程在报量修改过程中所处的状态
	 * @return
	 */
	@Bizlet("获取当前流程在报量修改过程中所处的状态")
	public static int getWFGradation(DataObject[] list){
		//当前节点，代表流程审批还未执行。
		String[] Reprot1={"ATS_FM_TGLR","ATS_FM_TGFH","ATS_FM_WTRFH","ATS_FM_XXHD1","ATS_FM_XXHD2","ATS_FM_TZJLFH"};
		String[] Reprot2={"ATS_FM_ZJZLSP","ATS_FM_ZXZJFH","ATS_FM_FGLDFH","ATS_FM_FKRGSH","ATS_FM_TBYY","ATS_FM_CZ_TBZX"};
		String[] Reprot3={"ATS_FM_CZ_ZBQR"};
		
		
		for (DataObject wfActivityDefine : list) {
			//不需求启动子流程，运行当前流程的报量修改处理
			for(int i=0;i<Reprot1.length;i++){
				//if(wfActivityDefine.getActivityDefID().equals(Reprot1[i])){
				if(wfActivityDefine.getString("activityDefID").equals(Reprot1[i])){
					return 1;
				}
			}
			//启动修改报量流程
			for(int i=0;i<Reprot2.length;i++){
				if(wfActivityDefine.getString("activityDefID").equals(Reprot2[i])){
					return 2;
				}
			}
			//启动中标确认修改报量流程
			for(int i=0;i<Reprot3.length;i++){
				if(wfActivityDefine.getString("activityDefID").equals(Reprot3[i])){
					return 3;
				}
			}
			//不能修改报量
			return 4;
			
		}
		//流程已结束
		return -2;
	}
	/**
	 * 获取报量报价修改回退的节点
	 * @param list 所经全部活动定义
	 * @return
	 */
	@Bizlet("获取报量报价修改回退的节点")
	public static String getBackActivityDefine(List<WFActivityDefine> list){
		//获取逻辑，存在复核节点则直接回退复核节点，不存在则回退录入节点
		//ATS_FM_TZJYLR录入，ATS_FM_TGFH复核
		for (WFActivityDefine wfActivityDefine : list) {
			if(wfActivityDefine.getId().equals("ATS_FM_TGFH")){
				return "ATS_FM_TGFH";
			}
		}
		return "ATS_FM_TGLR";
	}
	/**
	 * 获取缴款流程的 报量报价修改回退节点
	 * @param list 所经全部活动定义
	 * @return
	 */
	@Bizlet("获取报量报价修改回退的节点")
	public static String getPaymentBackActivityDefine(List<WFActivityDefine> list,int isAlike){
		/*缴款流程回退节点：
		过资金清算（不含本身）节点，如果票面面值没有改大且缴款信息没有变化，那么直接回退到交易员1判断非协议用印，仅缴款面值没有改大那么需要回退到 交易员协议用印判定
		流程经历过复核节点，则回退复核节点，否则回退录入节点*/
		
		for (WFActivityDefine wfActivityDefine : list) {
			if(wfActivityDefine.getId().equals("ATS_FM_ZJQS")){
				if(isAlike==3){
					return "ATS_FM_PDFXYYY";
				}else if(isAlike==2){
					return "ATS_FM_XYYYPD";
				}
				
			}
		}
		
		//ATS_FM_TZJYLR录入，ATS_FM_TGFH复核
		for (WFActivityDefine wfActivityDefine : list) {
			if(wfActivityDefine.getId().equals("ATS_FM_TGFH")){
				return "ATS_FM_TGFH";
			}
		}
		return "ATS_FM_TGLR";
	}
	/**
	 * 将日期转化成int型
	 * @param Date 日期
	 * @return int
	 */
	@Bizlet("将日期型转化成Int型")
	public  static int parseToNumber(Date date){
		int number = 0;
		if(date==null){
			return number;
		}else{
			String ymd = DateUtil.format(date, "yyyyMMdd");
			try{
				number = Integer.parseInt(ymd);
			}catch(Exception e){
				return number;
			}
			return number;
		}
		
	}
	/**
	 * 验证工作项是否为指定环节
	 * @param wfs
	 * @param activityDefName 
	 * @return
	 * @throws Exception 
	 */
	@Bizlet("验证工作项是否为指定环节")
	public static int isActivity(DataObject[] wfs,String activityDefName) throws Exception {
		if(wfs.length<1){
			throw new Exception("验证工作项是否为指定环节，发现找不到相关工作项数据！！");
		}
		for (int i = 0; i < wfs.length; i++) {
			DataObject dataObject = wfs[i];
			String activityDefID = dataObject.getString("activityDefID");
			if(activityDefID==activityDefName){
				return 1;
			}
		}
		return 2;
	}
	/**
	 * 获取一条参与者数据类型为角色的id
	 * @param list
	 * @return
	 */
	@Bizlet("获取一条参与者数据类型为角色的id")
	public static String getRelt(List<WIParticipantInfo> list){
		
		for (int i = 0; i < list.size(); i++) {
			WIParticipantInfo wipt=list.get(i);
			if(wipt.getTypeCode().equals("role")){
				
				return wipt.getId();
			}
		}
		return null;
	}
	/**
	 * 对比报量的数据差异
	 * @param reports 新的
	 * @param oldReports 旧的
	 * @return 是否有差异 1相同，2不同
	 */
	@Bizlet("对比报量的数据差异")
	public static int compareReport(DataObject[] reports,DataObject[] oldReports){
		
		//仅比较 报量和报价两项值，不比较其他值
		//算法：先比较来个数组的长度；然后在循环比较，两个长度相同的数组，一个数组的所有数据均能在另一个数组中匹配到，则相同，否不同 ；注意两个数组的数据顺序不一样，所以不能直接 使用下标对比。
		if(reports.length!=reports.length){
			return 2;
		}
		for(int i=0;i<reports.length;i++){
			int isAlike=2;//是否相同
			for(int j=0;j<oldReports.length;j++){
				//判定到相同，则标记
				if(reports[i].getString("enReport")==oldReports[j].getString("enReport") && reports[i].getString("enOffer")==oldReports[j].getString("enOffer")){
					isAlike=1;
				}
			}
			//有数据没与匹配到相同数据，直接结束
			if(isAlike==2){
				return 2;
			}
		}
		return 1;
	}
	/**
	 * 判定风控条件的报量改变(中标确认中)
	 * @param oldReport 原来的报量
	 *  @param  report 新插入的报量
	 * @return 1过风控，0不过风控
	 */
	@Bizlet("设置报价修改后风控条件(中标确认中)")
	public static int setFixValue(int oldReport,int report) {
		 //过风控
		 if(oldReport<report){
			 return 1;
		 }
		//不过风控
		return 0;
	}
	/**
	 * 中标确认时获取投标信息（金额、利率） 
	 * @param dobj 报量信息
	 * @param applyInst 必须包含 报量方式，票面利率
	 * @return
	 */
	@Bizlet("中标确认时获取投标信息（金额、利率） ")
	public static DataObject getBiddingInfo(DataObject[] dobj,DataObject applyInst){
		
		double enPayFaceValue=applyInst.getDouble("enCouponRate");//票面利率
		
		double maxEnOffer=0;//最大报价
		int maxReport=0;//最大报量
		if(applyInst.getInt("cReportType")==1){
			//累计式，取小于票面利率的最大报价的  报价和报量值
			for (int i = 0; i < dobj.length; i++) {
				if(dobj[i].getDouble("enOffer")<=enPayFaceValue && maxEnOffer<dobj[i].getDouble("enOffer")){
					maxEnOffer=dobj[i].getDouble("enOffer");
					maxReport=dobj[i].getInt("enReport");
				}
			}
		}else{
			//非累计式，取小于取小于票面利率的 所有报量累计值为报量，最大值为报价
			for (int i = 0; i < dobj.length; i++) {
				if(dobj[i].getDouble("enOffer")<=enPayFaceValue){
					if(maxEnOffer<dobj[i].getDouble("enOffer")){
						maxEnOffer=dobj[i].getDouble("enOffer");
					}
					maxReport+=dobj[i].getInt("enReport");
				}
			}
		}
		//回填投标利率，投标金额
		applyInst.setBigDecimal("enInvestBalance", new BigDecimal(maxReport));//投标金额
		applyInst.setBigDecimal("enInterestRate", new BigDecimal(enPayFaceValue));//投标利率
		
		return applyInst;
	}
	/**
	 * 判定风控条件的报量改变(中标确认前)
	 * @param reports 修改后
	 * @param oldReports 修改前
	 * @param reportType 报量方式
	 * @return 需要风控1  不需要风控0
	 */
	@Bizlet("设置报价修改后风控条件(中标确认前)")
	public static int setFixValue(DataObject[] reports,int reportType,int oldReport) {
		 
		/**
		 * 判定报量改大，比较改动后 报量是否变大 ，变大则需要风控
		 * 算法： 1、获取修改前、后的所有报量信息。
		 *	   2、根据修改前、后各自的报量方式  获取到 报量的总量（规则：累计式--获取最大的报量，非累计式--所有报量累加）。
		 *	   3、然后将算出的报量总量 进行比较，总量改大则过风控，改小则不过风控。
		 *	   4、报价的改变不影响 风控条件。
		 */
		//获取报量总量
		int sumReports=getSumReport(reports,reportType);
		if(sumReports==0){
			//报量数据异常
			return -1;
		}
		//报量总量 进行比较
		if(oldReport < sumReports){
			//需要风控
			return 1;
		}
		//不需要风控
		return 0;
	}
	/**
	 * 获取报量的总量
	 * @param reports 报量
	 * @param reportType 报量方式
	 * @return
	 */
	@Bizlet("获取报量的总量")
	public static int getSumReport(DataObject[] reports,int reportType ){
		int max=0;
		if(reportType==1){
			//累计式
			for (int i = 0; i < reports.length; i++) {
				//循环去最大值
				if(max<=reports[i].getInt("enReport")){
					max=reports[i].getInt("enReport");
				}
			}
		}else{
			//非累计式
			for (int i = 0; i < reports.length; i++) {
				//循环累加
				max+=reports[i].getInt("enReport");
			}
			
		}
		return max;
	}
	@Bizlet("比较两个节点的顺序")
	public static int commIsNodeOrder(String node1,String node2,String type){
		if(type=="1"){
			//可转债申购
			return isNodeOrder(node1, node2, REPROTS_ACTS);
		}else if(type=="2"){
			//缴款申购
			return isNodeOrder(node1, node2, PAYMENT_ACTS);
		}
		return -1;
	}
	/**
	 * 拼接报量和报价
	 * @param Reprots 报量信息
	 * @return 拼接后的字符串
	 */
	@Bizlet("拼接报量和报价")
	public static String getReprotsStr(DataObject[] Reprots){
		String reprotsStr="";
		for (int i = 0; i < Reprots.length; i++) {
			reprotsStr+="报量："+Reprots[i].getString("enReport")+",报价："+Reprots[i].getString("enOffer")+";";
		}
		return reprotsStr;
	}
	/**
	 * 拼接缴款金额及发行价格
	 * @param Reprots 报量信息
	 * @return 拼接后的字符串
	 */
	@Bizlet("拼接缴款金额及发行价格")
	public static String getenPaymentMoneyStr(DataObject[] Reprots){
		String reprotsStr="";
		for (int i = 0; i < Reprots.length; i++) {
			reprotsStr+="缴款金额："+Reprots[i].getString("enPaymentMoney")+",发行价格："+Reprots[i].getString("enBallotPrice")+";";
		}
		return reprotsStr;
	}
	/**
	 * 判定两个节点的顺序
	 * @param node1   当前节点
	 * @param node2 报量修改发生节点【修改发生时：修改点同回退点】或者 流程回退的节点
	 * @return 返回节点顺序 0相等，1前小于后，2前大于后，-1异常
	 */
	public static int isNodeOrder(String node1,String node2,String[] Reprots){
		
		//定义node1找到的位置
		int nodeIndex=-1;
		
		if(node1=="" || node2=="" || node1==null || node2==null){
			return nodeIndex;
		}
		
		//定义 中标确认前的所有节点
		if(node1.equals(node2)){
			//等于
			return 0;
		}
		
		//不考虑节点不在这个集合内的情况。
		for (int i = 0; i < Reprots.length; i++) {
			if(Reprots[i].equals(node1)){
				//标识已经找到节点。
				nodeIndex=i;
			}
			if(Reprots[i].equals(node2)){
				//为-1说明，node1还未找到，非-1说明已经找到；先找到的则在前，
				if(nodeIndex==-1){
					//node1大于node2
					return 2;
				}else{
					//node1小于node2
					return 1;
				}
			}
		}
		//异常
		return nodeIndex;
	}
	/**
	 * 判定当前节点是否需要自动审批
	 * @param act 当前节点
	 * @param upAct 报量修改发生节点【修改发生时：修改点同回退点】
	 * @param backAct 流程回退节点(发生点)
	 * @param type流程类型
	 * @return 1自动过，2人工审批
	 */
	@Bizlet("判定当前节点是否需要自动审批")
	public static int getSystemApprove(String act,String upAct,String backAct,String type){
		
		int nodeOrder=2;
		if("1".equals(type) || "5".equals(type)){
			//可转债申购
			nodeOrder=isNodeOrder(act,upAct,REPROTS_ACTS);
		}else if("8".equals(type)){
			//缴款申购
			nodeOrder=isNodeOrder(act,upAct,PAYMENT_ACTS);
		}
		if(nodeOrder==1){
			//当前节点在修改点之前
			//自动过
			return 1;
		}else{
			//所有的回退均需要人工审批，例如：在流程没有走过修改点前提下，有修改点前 的回退 不影响自动过（优先判定修改点的自动过）；
			//修改点之后的，修改点已经不存（总助节点删除修改点），那么回退均需要人工审批。
			//人工审批
			return 2;
			/*nodeOrder=isNodeOrder(act,backAct);
			//当前节点 在回退节点前 或者相等
			if(nodeOrder==0 || nodeOrder==1 || backAct=="" || backAct==null){
				//人工审批
				return 2;
			}else{
				//自动过
				return 1;
			}*/
		}
	}
	
	@Bizlet("获取债券类型树形数据")
	public static List<Map<String,String>> getStockTypeTree(DataObject[] stockTypeDefines){
		List<Map<String,String>> lst = new ArrayList<Map<String,String>>();
		
		for (int i = 0; i < stockTypeDefines.length; i++) {
			DataObject dataObject = stockTypeDefines[i];
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", dataObject.getString("vcStockType"));
			map.put("text", dataObject.getString("vcStocktypeName"));
			if(dataObject.getString("vcParentStockType")!="" && dataObject.getString("vcParentStockType")!=null){
				map.put("pid", dataObject.getString("vcParentStockType"));
			}
			map.put("isLeaf", dataObject.getString("lIsLeaf"));
			
			lst.add(map);
		}
		return lst;
	}	
	
	@Bizlet("获取债券类型下拉框数据")
	public static List<Map<String,String>> getStockTypeCombo(DataObject[] stockType){
		List<Map<String,String>> lst = new ArrayList<Map<String,String>>();
		
		for (int i = 0; i < stockType.length; i++) {
			DataObject dataObject = stockType[i];
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", dataObject.getString("cStockType"));
			map.put("text", dataObject.getString("vcStocktypeName"));
			lst.add(map);
		}
		return lst;
	}
	
	/**
	 * fix发送前的逻辑处理
	 * @param boneTable 指令信息
	 * @return
	 */
	@Bizlet("fix发送前的逻辑处理")
	public static DataObject setSendFixStatus(DataObject boneTable)  {
		
		String origordId = boneTable.getString("vcOrigordId");
		String clordId = boneTable.getString("vcClordId");
		String fixStatus = boneTable.getString("lFixValidStatus");
		/**
		 * 5、开始推送O32逻辑：
		 * 1）如果状态为“修改后未发送” 或者 “发送失败”且cid 和 oid 不相等，直接采用cid 和 oid 进行推送。
		 * 2）如果状态为“未发送”（cid 为 A 和 oid为null） ，直接使用（cid 为 A 和 oid为null）进行推送
		 * 3）如果状态为“发送成功”且（cid A - oid A 相等），则重新生成新的cid （cid B - oid A），进行推送。
		 * */
		if(StringUtils.isBlank(clordId)){
			String cid = com.cjhxfund.foundation.fix.FixToUtil.getClOrdID();
			clordId=cid;
		}
		//未发送
		if("0".equals(fixStatus)){
			//origordId 为空 且 clordId不为空
			if(StringUtils.isBlank(origordId) && StringUtils.isNotBlank(clordId)){
				return boneTable;
			}else{
				LogUtil.logError("fix异常，状态为:"+fixStatus+"， oid不为空", null, fixStatus);
			}
			
		}else if("2".equals(fixStatus)){//发送中
			LogUtil.logError("fix状态为:"+fixStatus+"，fix为发送中，重复发送", null, fixStatus);
			return boneTable;
			
		}else if(("1".equals(fixStatus) || "4".equals(fixStatus)) && StringUtils.isNotBlank(clordId)){
			//如果状态为“修改后未发送” 或者 “发送失败”
			if(clordId != origordId){
				return boneTable;
			}else{
				LogUtil.logError("fix异常，状态为:"+fixStatus+"，但cid 与 oid相等", null, fixStatus);
			}
		}else if("3".equals(fixStatus)){
			//如果状态为“发送成功”
			if(clordId.equals(origordId) && StringUtils.isNotBlank(clordId)){
				//重新获取cid
				String cid = com.cjhxfund.foundation.fix.FixToUtil.getClOrdID();
				boneTable.setString("vcClordId", cid);
				return boneTable;
			}else{
				LogUtil.logError("fix异常，状态为:"+fixStatus+"，但cid 与 oid不相等", null, fixStatus);
			}
			
		}else{
			LogUtil.logError("fix异常，状态为:"+fixStatus+"，fix状态不可以", null, fixStatus);
		}
		//异常情况返回null
		return null;
	}
	/**
	 * fix发送成功后的状态处理
	 * @param boneTable
	 * @return
	 */
	@Bizlet("fix发送成功后的状态处理")
	public static DataObject setReturnFixStatus(DataObject boneTable)  {
		String origordId = boneTable.getString("vcOrigordId");
		String clordId = boneTable.getString("vcClordId");
		String fixStatus = boneTable.getString("lFixValidStatus");
		/**
		 * 1）成功，则将(cid B 和 oid A ) 或者 (cid A 和 oid null ) 改为 (cid B 和 oid B ) 或者 (cid A 和 oid A ) ，
		 * 并标记状态为“发送成功”。
		 * 2）失败((cid B 和 oid A ) 或者 (cid A 和 oid null ) ，则将生成新的cid （cid c ,oid A） 或者
		 *  (cid C 和 oid null) ，并标识"发送失败"。
		 */
		
		if("4".equals(fixStatus)){//发送失败
			String cid = com.cjhxfund.foundation.fix.FixToUtil.getClOrdID();
			boneTable.setString("vcClordId", cid);
		}else if("3".equals(fixStatus)){//发送成功
			boneTable.setString("vcOrigordId", clordId);
		}else if("2".equals(fixStatus)){//发送中
			return boneTable;
		}else{
			return null;
		}
		return boneTable;
	}
	/**
	 * fix延迟反馈状态处理
	 * @param vcClordid
	 * @param isSuccess fix发送结果 true成功， false失败
	 */
	@Bizlet("fix延迟反馈状态处理")
	public static void fixOutTimeReturn(String vcClordid , boolean isSuccess)  {
		DataObject applyInst = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.instr.firstGradeDebt.TAtsApplyInst");
		
		applyInst.setString("vcClordId", vcClordid);
		applyInst.setString("lValidStatus","0");
		int i= com.eos.foundation.database.DatabaseUtil.expandEntityByTemplate("default",applyInst,applyInst);
		if(i!=1){
			LogUtil.logError("fix延迟反馈的vcClordid："+vcClordid+"，值无法匹配到一级债指令", null, vcClordid);
			return;
		}
		String lFixValidStatus="4";
		if(isSuccess==true){
			lFixValidStatus="3";
		}
		//fix状态：0-未发送,1-修改后未发送,2-发送中,3-发送成功,4-发送失败
		applyInst.setString("lFixValidStatus",lFixValidStatus);
		//调用fix发送成功后的状态处理
		applyInst = setReturnFixStatus(applyInst);
		//组装反馈数据
		DataObject applyInstTemp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.instr.firstGradeDebt.TAtsApplyInst");
		DataObject applyInstDate = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.instr.firstGradeDebt.TAtsApplyInst");
		
		applyInstTemp.setString("lBizId",applyInst.getString("lBizId"));
		applyInstTemp.setString("lValidStatus","0");
		
		applyInstDate.setString("vcOrigordId", applyInst.getString("vcOrigordId"));
		applyInstDate.setString("vcClordId", applyInst.getString("vcClordId"));
		applyInstDate.setString("lFixValidStatus", applyInst.getString("lFixValidStatus"));
	    //更新指令数据
		com.eos.foundation.database.DatabaseUtil.updateEntityByTemplate("default",applyInstDate,applyInstTemp);
	} 
	
	/**
	 * 判断当前指令状态，修改Fix指令编号
	 * @param boneTable  一级债申购指令对象
	 * @param clordId    Fix指令编号
	 * @return
	 */
	@Bizlet("判断当前指令状态，修改Fix指令编号")
	public static DataObject setFixValidStatus(DataObject boneTable,String clordId) {
		int lFixValidStatus = boneTable.getInt("lFixValidStatus");    //获取指令状态
		String vcClordId = boneTable.getString("vcClordId");   //第三方唯一编号
		String vcOrigordId = boneTable.getString("vcOrigordId");  //要修改的第三方唯一编号
		int validStatus = 0;
		
		LogUtil.logDebug("原指令状态:{0}第三方唯一编号:{1}要修改的第三方唯一编号:{2}", null, lFixValidStatus,vcClordId,vcOrigordId);
		
		if(lFixValidStatus == 0){ //指令状态 0-未发送
			return boneTable;
		}else if(lFixValidStatus == 1){ //指令状态  1-修改后未发送
			return boneTable;
 		}else if(lFixValidStatus == 2){ //指令状态 2-发送中 3-发送成功 
 			//查询Fix指令返回数据
			DataObject result = getTAtsFixReceiveMsg(vcClordId,boneTable.getString("lInvestNo"));
			 LogUtil.logDebug("getTAtsFixReceiveMsg方法传入参数【第三方唯一编号:{0},指令编号：{1}】,返回值：【Fix反馈指令记录:{2}】", null, vcClordId,boneTable.getString("lInvestNo"),result);
			if(result == null){
				return boneTable;
			}else{
				//获取Fix指令发送装台true:成功，false:失败
			    DataObject FixStatis = FixToMsgUtil.getExecutionReportStatus(result);
			    LogUtil.logDebug("FixToMsgUtil.getExecutionReportStatus方法传入参数【Fix指令反馈记录:{0}】,返回值【Fix指令发送状态:{1}】", null, result,FixStatis);
				if(FixStatis.getBoolean("isSuccess") == false){
					validStatus = 4;
					//修改上一Fix指令编号为当前Fix指令编号
					boneTable.setString("vcClordId", clordId);
					if(vcClordId==vcOrigordId)
					{
						boneTable.setString("vcOrigordId", clordId);
					}
					else
					{
						boneTable.setString("vcOrigordId", vcClordId);
					}
					
					//修改状态为 1-修改后未发送
					boneTable.setLong("lFixValidStatus", 1);
				}else{
					validStatus = 3;
				}
				boneTable.setString("failReason", result.getString("failReason"));
				LogUtil.logInfo("原指令状态:{0}-Fix指令发送中,重新生成的指令状态:{0}第三方唯一编号:{1}要修改的第三方唯一编号:{2}", null,lFixValidStatus,1,clordId,vcOrigordId);
			}
		}else if(lFixValidStatus == 3){
			//重新生Fix指令编号
			boneTable.setString("vcClordId", clordId);
			//修改上一Fix指令编号为当前Fix指令编号
			boneTable.setString("vcOrigordId", vcClordId);
			//修改状态为 1-修改后未发送
			boneTable.setLong("lFixValidStatus", 1);
			LogUtil.logInfo("原指令状态:{0}-Fix指令发送成功,重新生成的指令状态:{1}重新生Fix指令编号:{2}要修改的第三方唯一编号:{3}", null, lFixValidStatus,1,clordId,vcClordId);
		}else if(lFixValidStatus == 4){  //指令状态 4-发送失败 
			String OrigordId = "";
			//修改上一Fix指令编号为当前Fix指令编号
			//重新生Fix指令编号
			boneTable.setString("vcClordId", clordId);
			if(vcClordId.equalsIgnoreCase(vcOrigordId))
			{
				OrigordId = clordId;
			}
			else
			{
				OrigordId = vcClordId;
			} 
			OrigordId = vcClordId;
			boneTable.setString("vcOrigordId", OrigordId);
			//修改状态为 1-修改后未发送
			boneTable.setLong("lFixValidStatus", 1);
			LogUtil.logInfo("原指令状态:{0}-Fix指令发送失败,重新生成的指令状态:{1}重新生Fix指令编号:{2}要修改的第三方唯一编号:{3}", null, lFixValidStatus,1,clordId,OrigordId);
		}
		return boneTable;
	}
	
	/**
	 * 查询Fix指令反馈数据
	 * @param vcClordId  指令编号
	 * @param lInvestNo  投资编码
	 * @return Fix指令反馈数据
	 */
	public static DataObject getTAtsFixReceiveMsg(String vcClordId,String lInvestNo){
		LogUtil.logInfo("获取Fix指令记录,方法名：ApplyInstUtil.getTAtsFixReceiveMsg，传入参数【指令编号：{0},指令编码：{1}】", null , vcClordId,lInvestNo);
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);

			//拼接SQL语句
			sb.append("select t.vc_msgtype,t.vc_procetype,t.vc_ordstatus,t.vc_exectype,t.vc_failreason ")//产品代码
			  .append("  from T_ATS_FIX_RECEIVE_MSG t ")
			  .append(" where 1 = 1 ");
			
			//新增查询条件
			if(StringUtils.isNotBlank(vcClordId)){
				sb.append(" and t.vc_clordid ='" + vcClordId +"'");
			}
			if(StringUtils.isNotBlank(lInvestNo)){
				sb.append(" and t.l_instruction_no = '" + lInvestNo +"'");
			}

			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i); 
					String vc_msgtype = map.get("VC_MSGTYPE");
					String vc_procetype = map.get("VC_PROCETYPE");
					String vc_failreason = map.get("VC_FAILREASON");
					String VC_ORDSTATUS = map.get("VC_ORDSTATUS");
					String vcExectype = map.get("VC_EXECTYPE");
					vc_failreason = FixToMsgUtil.changeFailReason(vc_failreason,"</br>");
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.CombProduct");
					obj.setString("vcMsgtype", vc_msgtype);
					obj.setString("vcProcetype", vc_procetype);
					obj.setString("failReason", vc_failreason);
					obj.setString("vcOrdstatus", VC_ORDSTATUS);
					obj.setString("vcExectype", vcExectype);
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			LogUtil.logError("获取Fix指令记录失败，指令编号：{0},指令编码：{1}", e , vcClordId,lInvestNo);
			//e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return  result.size() == 0 ? null:result.get(0);
	}
	
	/**
	 * 根据修改状态与投资金额、缴款金额、投标利率、票面利率判断"中标确认报价修改状态"值是否修改，流程是否提交
	 * @param enPayFaceValue  缴款面值
	 * @param enInvestBalance 投标金额
	 * @param enInterestRate  投标利率
	 * @param enCouponRate    票面利率
	 * @param cReportUpdateStatus  中标确认报价修改状态
	 * @return 1-可以提交并修改状态 2,3-不能提交并且不能修改状态    4-不修改状态并且不提交流程
	 */
	@Bizlet("")
	public static int  JudgeDataState(double enPayFaceValue,double enInvestBalance,double enInterestRate,double enCouponRate,String cReportUpdateStatus){
		int UpdateStatus = 1;
		if(cReportUpdateStatus != null){
			//判断"中标确认报价修改状态"值是否为0,6. 0-默认,6-报价已修改
			if(cReportUpdateStatus.equals("0") || cReportUpdateStatus.equals("6")){
				UpdateStatus = 1;
			}else if(cReportUpdateStatus.equals("3") || cReportUpdateStatus.equals("4") || cReportUpdateStatus.equals("5")){  //3-风控审批不通过;4-委托人审批不通过;5-投顾复核不通过
				//判断投标金额是否等于缴款金额并且票面利率是否等于投标利率
				if(enInvestBalance <= enPayFaceValue ){
					UpdateStatus = 2;
				}else if(enInterestRate <= enCouponRate){
					UpdateStatus = 3;
				}else{
					UpdateStatus = 1;
				}
			}else if(cReportUpdateStatus.equals("1") || cReportUpdateStatus.equals("2")){  //1-已通知投顾修改  2-投顾修改报价审批中
				UpdateStatus = 4;
			}
		}
		return UpdateStatus;
	}
	/**
	 * 比较缴款信息，判定改变前后的数据，是否需要过风控
	 * @param applyInst
	 * @param oldApplyInst
	 * @return 1需要过，2不需要过
	 */
	@Bizlet("")
	public static int comparePayment(DataObject applyInst,String enPayFaceValue){
		
		//缴款流程过风控的条件，缴款面值改大 则过风控
		if(Float.parseFloat(applyInst.getString("enPayFaceValue"))> Float.parseFloat(enPayFaceValue)){
			return 1;
		}
		return 2;
	}
	
	/**
	 * 缴款-判定当前节点是否需要自动审批
	 * @param act 当前节点
	 * @param upAct 报量修改发生节点【修改发生时：修改点同回退点】
	 * @param backAct 流程回退节点(发生点)
	 * @return 1自动过，2人工审批
	 */
	@Bizlet("判定当前节点是否需要自动审批")
	public static int getPaymentSystemApprove(String act,String upAct,String backAct){
		
		int nodeOrder=isNodeOrder(act,upAct,PAYMENT_ACTS);
		if(nodeOrder==1){
			//当前节点在修改点之前
			//自动过
			return 1;
		}else{
			//所有的回退均需要人工审批，例如：在流程没有走过修改点前提下，有修改点前 的回退 不影响自动过（优先判定修改点的自动过）；
			//修改点之后的，修改点已经不存（总助节点删除修改点），那么回退均需要人工审批。
			//人工审批
			return 2;
		}
	}
	/**
	 * 根据权限code判定是否存在该权限
	 * @param authList 权限集合
	 * @param relateType 权限代码，格式如下：01  或者  A2  等
	 * @return 1存在，0不存在
	 */
	@Bizlet("判定是否存在投资经理权限")
	public static int checkInvestPMAuth(List<TProductHandle> authList,String relateType){
		
		for(int i=0;i<authList.size();i++){
			TProductHandle tp=authList.get(i);
			//判定是否存在该权限
			if(relateType.equals(tp.getVcRelateType())){
				return 1;
			}
		}
		return 0;
	}
	/**
	 * 判定复核人包含指定人
	 * @param list 参与者集合
	 * @param userId 当前用户empid
	 * @return 1存在，0不存在
	 */
	@Bizlet("判定复核人包含指定人")
	public static int checkString(List<WFParticipant> list,String userId){
		
		for (WFParticipant wf : list) {
			if(wf.getId().equals(userId)){
				return 1;
			}
		}
		return 0;
	}
	/**
	 * 获取数组的第一个值
	 * @param dobjs
	 * @param name
	 * @return
	 */
	@Bizlet("获取数组的第一个值")
	public static String getIndexValue(DataObject[] dobjs,String name){
		if(dobjs.length>0){
			return dobjs[0].getString(name);
		}
		return null;
	}
	
	
	/**
	 * 获取要删除的传真ID数组
	 * @param lDataIdStr
	 * @return faxArrayLong
	 */
	@Bizlet("获取要删除的传真ID数组")
	public static Long[] getDeleteFaxArray(String lDataIdStr){
		String[] faxArray = lDataIdStr.split(",");
		Long[] faxArrayLong = new Long[faxArray.length];
		for(int i=0;i<faxArray.length;i++){
			faxArrayLong[i] = Long.parseLong(faxArray[i]);
		}
		return faxArrayLong;
	}
	
	
	/**
	 * 获取传真值集合
	 * @param dobjs
	 * @param name
	 * @return
	 */
	@Bizlet("获取传真值集合")
	public static List<String> getFaxValueArray(String faxValue,String detailType,String type,String sysName){
		String[] faxArray = faxValue.split(",");
		List<String> insertFaxList = new ArrayList<String>(); 
		for (String fax : faxArray){
			insertFaxList.add(fax);
		}
		return insertFaxList;
	}
	/**
	 * 获取中标确认 流程走向的值，是否中标（前），是否对方用印（后）
	 * @return
	 */
	@Bizlet("获取中标确认 流程走向的值")
	public static String[] getZBQRIfValue(String yn){
		if("".equals(yn)){
			LogUtil.logError("中标确认异常，流程走向的【是否中标，是否对方用印】值为空。", null, yn);
			throw new NullPointerException("中标确认异常，流程走向的【是否中标，是否对方用印】值为空");
		}
		String[] str = yn.split(",");
		if(str.length!=2){
			LogUtil.logError("中标确认异常，流程走向的【是否中标，是否对方用印】值解析错误。【yn】:"+yn, null, yn);
			throw new NullPointerException("中标确认异常，流程走向的【是否中标，是否对方用印】值解析错误");
		}
		return str;
	}
	/**
	 * 通过资产单元序号查找O32寸头可用情况T+0交易可用
	 * @param 
	 * @return
	 * @author xiehaiguang
	 */
	@Bizlet("")
	public static List<DataObject> getTradeO32JYKY(){
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct jyky.l_asset_id,jyky.t0jyky ")
			  .append(" from o32_cj.to32_pos_rst jyky ");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String l_asset_id = map.get("L_ASSET_ID");//资产单元序号
					String t0jyky = map.get("T0JYKY");//T+0交易可用
					
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					obj.setString("lAssetId", l_asset_id);
					obj.setString("t0jyky", t0jyky);
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	 /* @param wf
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装T+0交易可用信息到业务中")
	public static DataObject[] assembleTradeO32JYKYInfo(DataObject[] wflist) {
		List<DataObject> workitems= getTradeO32JYKY();
		// TODO 自动生成的方法存根
		if(workitems != null){
			for(int j =0;j<wflist.length;j++){
				for(int k =0;k<workitems.size();k++){
					if(workitems.get(k).getString("lAssetId").equals(wflist[j].getString("lAssetId"))){
						if(Double.parseDouble(workitems.get(k).getString("t0jyky"))>=Double.parseDouble(wflist[j].getString("enPaymentMoney")==null?"0":wflist[j].getString("enPaymentMoney"))*10000){
							wflist[j].setString("t0jyky", "O32头寸充足");
						}else{
							wflist[j].setString("t0jyky", "O32头寸不足");
						}
						break;
					}else{
						wflist[j].setString("t0jyky", "O32无对应头寸");
					}

				}
			 }
		 }
		return wflist;
	}
	@Bizlet
	public static Map[] addMapSValue(Map[] maps,String[] workid){
		maps[0].put("workItemId", workid[0]);
		
		return maps;
	}
	@Bizlet
	public static String getWorkItemId(DataObject[] dobj){
		return dobj[0].getString("workItemId");
	}
}

