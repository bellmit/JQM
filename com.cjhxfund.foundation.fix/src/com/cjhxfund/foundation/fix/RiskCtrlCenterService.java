package com.cjhxfund.foundation.fix;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import quickfix.Group;

import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.cjhxfund.foundation.fix.model.CheckResultReturn;
import com.cjhxfund.foundation.fix.model.RcCheckResultDto;
import com.cjhxfund.foundation.fix.model.RequestCollateraDetailModel;
import com.cjhxfund.foundation.fix.model.RequestRecordDetail;
import com.cjhxfund.foundation.fix.model.RequestRecordModel;
import com.cjhxfund.foundation.fix.model.UncontrolResult;
import com.eos.common.transaction.ITransactionDefinition;
import com.eos.common.transaction.ITransactionManager;
import com.eos.common.transaction.TransactionManagerFactory;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
/**
 * 风控接口参数类 提供参数的获取、转换、组装
 * @author yangminwb
 *
 */
public class RiskCtrlCenterService {
	
	/**
	 * 获取风控节点请求url
	 * @param operation 风控类型；CheckRisk风控检查，TryRisk风控试算
	 * @param uid 账户Id
	 * @return
	 */
	public static String getHttpUrl(String operation,String uid){
		String url="";
		//风控请求url参数 {Function}/{Operation}/{SoftVersion}/Accounts/{AccountSid}?sig={SigParameter}
		//1。获取请求域;缓存配置
		String baseUrl=getCacheValue("ATS_RISK_BASE_URL");
		//2.获取Function、缓存配置，默认为RiskControl
		String function=getCacheValue("ATS_RISK_FUN");
		//3.获取Operation；CheckRisk风控检查，TryRisk风控试算
		
		//4.获取SoftVersion、软件版本号，以风控引擎公布的版本号为准；缓存配置
		String softVersion=getCacheValue("ATS_SOFT_VERSION");
		//5.获取AccountSid、风控引擎为指定调用者统一安排身份ID；001 机器猫，002 指数平台
		String accountSid="001";
		//6.获取SigParameter;URL后必须带有sig参数，sig= MD5（账户Id + 账户授权令牌 + 时间戳），共32位(注:转成大写)。
		String SigParameter=getSigParameter(uid,"");
		//组装风控请求连接
		url=baseUrl+"/"+function+"/"+operation+"/"+softVersion+"/Accounts/"+accountSid+"?sig"+SigParameter;
		
		return url;
	}
	/**
	 * 获取风控请求 sig
	 * @param uid 用户ID
	 * @param token 账户授权令牌
	 * @return
	 */
	public static String getSigParameter(String uid,String token){
		/**
		 * sig= MD5（账户Id + 账户授权令牌 + 时间戳），共32位(注:转成大写)；使用MD5加密（账户Id + 账户授权令牌 + 时间戳），共32位；
		 *  时间戳是当前系统时间（24小时制），格式“yyyyMMddHHmmss”时间戳有效时间为24小时。
		 */
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

		String time = formatter.format(new Date()); 
		
		return com.eos.foundation.common.utils.CryptoUtil.digestByMD5(uid+token+time);
	}
	/**
	 * 转换时间格式字符串
	 * @param dataStr
	 * @return
	 */
	public static String getIntData(String dataStr,String dataType){
		SimpleDateFormat formatter = new SimpleDateFormat(dataType);
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(dataStr==null || dataStr=="" || "null".equals(dataStr)){
			return dataStr;
		}
		try {
			return formatter.format(formatter1.parse(dataStr));
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return dataStr;
	}
	
	/**
	 * 从缓存中获取参数
	 * @param cacheName 缓存key值
	 * @return
	 */
	public static String getCacheValue(String cacheName){
		//获取缓存中信息
		DataObject dojb = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", cacheName);
		//解析信息
		return dojb.getString("paramValue");
	}
	public static Object getMapObject(String className,Object newObj,Map mp) throws Exception{
		  
		  Class<?> clazz = Class.forName(className);
           
	       //得到类对象  
	       Class userCla = (Class) newObj.getClass();  
	       Field[] fs = userCla.getDeclaredFields();  
	       for(int i = 0 ; i < fs.length; i++){  
	           Field f = fs[i];  
	           f.setAccessible(true); //设置些属性是可以访问的  
	           f.set(newObj,mp.get(f.getName())) ; 
	       }
		return fs;
	}
	/**
	 * json字符串转换为CheckResultReturn类数据
	 * @param jsonStr json字符串
	 * @return getCheckResultReturn
	 * @throws Exception
	 */
	public static CheckResultReturn getCheckResultReturn(String jsonStr) throws Exception{
		Map<String, Object> mp =  JSONUtil.jsonToMap(jsonStr);
		if(jsonStr==null || jsonStr=="" || "null".equals(jsonStr)){
			LogUtil.logError("======>请求风控引擎接口超时！<=========", null, null);
			return null;
		}
		
		CheckResultReturn checkReturn =   new CheckResultReturn();
		RiskCtrlCenterService.getMapObject("com.cjhxfund.foundation.fix.model.CheckResultReturn", checkReturn, mp);

		//System.out.println(checkReturn.getClOrdId());
		List<RcCheckResultDto> list = checkReturn.getCheckResultDetail();
		//RcCheckResultDto 数据
		List checkResultDetail = new ArrayList();
		if(list!=null){
			for (int i = 0; i < list.size(); i++) {
				RcCheckResultDto dto = new RcCheckResultDto();
				RiskCtrlCenterService.getMapObject("com.cjhxfund.foundation.fix.model.RcCheckResultDto", dto, (Map)list.get(i));

				checkResultDetail.add(dto);
			}
		}
		
		//UncontrolResult 数据
		List<UncontrolResult> list1 = checkReturn.getUncontrolDetail();
		List UncontrolResult = new ArrayList();
		if(list1!=null){
			for (int i = 0; i < list1.size(); i++) {
				UncontrolResult un = new UncontrolResult();
				RiskCtrlCenterService.getMapObject("com.cjhxfund.foundation.fix.model.UncontrolResult", un, (Map)list1.get(i));

				UncontrolResult.add(un);
			}
		}
		
		checkReturn.setCheckResultDetail(checkResultDetail);
		checkReturn.setUncontrolDetail(UncontrolResult);
		return checkReturn;
	}
	public static boolean checkRiskNotNull(DataObject sendMsg, List<Group> groupList, List<List<DataObject>> bondsList){
		if(sendMsg.getString("vcClordid")==""){
			LogUtil.logError("新订单编号【vcClordid】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcIsO32Order")==""){
			LogUtil.logError("指令是否已经下达到O32【IsO32Order】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcBegindate")==""){
			LogUtil.logError("指令开始日期【vcBegindate】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcExpiredate")==""){
			LogUtil.logError("指令结束日期【vcExpiredate】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcProcesstype")==""){
			LogUtil.logError("【vcProcesstype】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcProductCode")==""){
			LogUtil.logError("基金代码【vcProductCode】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("lProductId")==""){
			LogUtil.logError("基金序号【lProductId】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcAccount")==""){
			LogUtil.logError("组合编号【vcAccount】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcSymbol")==""){
			LogUtil.logError("证券代码 【vcSymbol】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcExdestination")==""){
			LogUtil.logError("交易场所 【vcExdestination】不能为空！", null, null);
			return false;
		}
		if(sendMsg.getString("vcStockType")==""){
			LogUtil.logError("证券类型【vcStockType】不能为空！", null, null);
			return false;
		}
		return true;
	}
	/**
	 * 将fix参数转换为风控接口RequestRecordModel对象
	 * @param sendMsg 指令数据对象
	 * @param groupList 重复组对象列表
	 * @param bondsList 重复组债券信息对象列表
	 * @return
	 * @throws ParseException 
	 */
	public static RequestRecordModel setRequestRecordModel(DataObject sendMsg, List<Group> groupList, List<List<DataObject>> bondsList) throws ParseException{
		
		if(RiskCtrlCenterService.checkRiskNotNull(sendMsg, groupList, bondsList)==false){
			return null;
		}
		
		RequestRecordModel model = new RequestRecordModel();
		
		model.setClOrdId(sendMsg.getString("vcClordid"));
		model.setIsO32Order(sendMsg.getString("vcIsO32Order"));
		model.setCallPoint(sendMsg.getString("vcCallPoint"));
		model.setCallSys("0");//0 机器猫 1 指数平台
		model.setBusinessClass(sendMsg.getString("vcBusinclass"));
		model.setInstructionNo(sendMsg.getString("vcInstructionno"));
		model.setBeginDate(sendMsg.getString("vcBegindate"));
		model.setEndDate(sendMsg.getString("vcExpiredate"));
		model.setSenderSubId(sendMsg.getString("vcSendersubid"));
		model.setEndDate(sendMsg.getString("vcExpiredate"));
		model.setPurposeType(sendMsg.getString("vcPurposetype"));
		model.setFutSettDate(sendMsg.getString("vcFutsettdate"));
		model.setFutSettDate2(sendMsg.getString("vcFutsettdate2"));
		if(sendMsg.getString("vcTrialFlag")!="" && sendMsg.getString("vcTrialFlag")!=null){
			model.setTrialFlag(sendMsg.getString("vcTrialFlag"));//0 非试算，1 试算
		}else{
			model.setTrialFlag("0");//0 非试算，1 试算
		}
		if(sendMsg.getString("vcFixFlag")!="" && sendMsg.getString("vcFixFlag")!=null){
			model.setFixFlag(sendMsg.getString("vcFixFlag"));//0 本地和O32风控都调用；（默认值）1 只调用本地，不调用O32；2 只调O32风控；
		}else{
			model.setFixFlag("0");//0 本地和O32风控都调用；（默认值）1 只调用本地，不调用O32；2 只调O32风控；
		}
		
		model.setProcessType(sendMsg.getString("vcProcesstype"));
		if(sendMsg.getString("vcCheckRangeRiskFlag")!="" && sendMsg.getString("vcCheckRangeRiskFlag")!=null){
			model.setCheckRangeRiskFlag(sendMsg.getString("vcCheckRangeRiskFlag"));//0 非试算，1 试算
		}else{
			model.setCheckRangeRiskFlag("1");//是否检查范围内风控0 不检查，1 检查（默认值）
		}
		if(sendMsg.getString("vcCheckRatioRiskFlag")!="" && sendMsg.getString("vcCheckRatioRiskFlag")!=null){
			model.setCheckRatioRiskFlag(sendMsg.getString("vcCheckRatioRiskFlag"));//0 非试算，1 试算
		}else{
			model.setCheckRatioRiskFlag("1");//是否检查投资限制类风控0 不检查，1 检查 （默认值）
		}
		if(sendMsg.getString("vcIsSync")!="" && sendMsg.getString("vcIsSync")!=null){
			model.setIsSync(sendMsg.getString("vcIsSync"));
		}else{
			model.setIsSync("0");//0- 本地同步，Fix同步1- 本地异步，Fix同步2- 本地同步，Fix异步3- 本地异步，Fix异步 （默认值）
		}
		if(sendMsg.getString("vcGroup")!="" &&  sendMsg.getString("vcGroup")!=null){
			model.setGroup(sendMsg.getString("vcGroup"));
		}else{
			model.setGroup("1");//订单个数
		}
		
		
		//定义组装RequestRecordDetail
		List<RequestRecordDetail> detList= new ArrayList<RequestRecordDetail>();
		RequestRecordDetail recordDetail = new RequestRecordDetail();
		recordDetail.setFundCode(bondsList.get(0).get(0).getString("vcProductCode"));
		recordDetail.setFundId(bondsList.get(0).get(0).getString("lProductId"));
		recordDetail.setCombinNo(bondsList.get(0).get(0).getString("vcAccount"));
		recordDetail.setSymbol(bondsList.get(0).get(0).getString("vcSymbol"));
		recordDetail.setExDestination(bondsList.get(0).get(0).getString("vcExdestination"));
		recordDetail.setStype(bondsList.get(0).get(0).getString("vcStockType"));//0其他，2债券，3股票，4基金
		recordDetail.setCurrencyCode("CNY");
		recordDetail.setInterCode(bondsList.get(0).get(0).getString("vcInterCode"));//O32内码
		recordDetail.setInvestType(bondsList.get(0).get(0).getString("vcInvesttype"));
		recordDetail.setBusinType(bondsList.get(0).get(0).getString("vcBusintype"));
		
		
		recordDetail.setStockTargetType(bondsList.get(0).get(0).getString("vcOrdtype"));
		if(bondsList.get(0).get(0).getString("vcPrice")!=null && bondsList.get(0).get(0).getString("vcPrice")!=""){
			recordDetail.setPrice(new BigDecimal(bondsList.get(0).get(0).getString("vcPrice")));
		}
		if(bondsList.get(0).get(0).getString("vcOrderqty")!=null && bondsList.get(0).get(0).getString("vcOrderqty")!=""){
			recordDetail.setOrderQty(new BigDecimal(bondsList.get(0).get(0).getString("vcOrderqty")));
		}
		if((bondsList.get(0).get(0).getString("vcCashorderqty")!=null) && (bondsList.get(0).get(0).getString("vcCashorderqty")!="")){
			recordDetail.setCashOrderQty(new BigDecimal(bondsList.get(0).get(0).getString("vcCashorderqty")));
		}
		if(sendMsg.getString("vcIsInquiry")!="" && sendMsg.getString("vcIsInquiry")!=null){
			recordDetail.setIsInquiry(sendMsg.getString("vcIsInquiry"));
		}else{
			recordDetail.setIsInquiry("0");//是否询价指令
		}
		
		//recordDetail.setValueDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(bondsList.get(0).get(0).getString("vcIssuedateex")));
		recordDetail.setExecBroker(bondsList.get(0).get(0).getString("vcExecbroker"));
		recordDetail.setBondSettleType(bondsList.get(0).get(0).getString("vcBondsettletype"));
		recordDetail.setBondSettleType2(bondsList.get(0).get(0).getString("vcBondsettletype2"));
		
		if(bondsList.get(0).get(0).getString("vcBondYield") != null && bondsList.get(0).get(0).getString("vcBondYield") != ""){
			
			recordDetail.setBondYield(new BigDecimal(bondsList.get(0).get(0).getString("vcBondYield")).setScale(4,BigDecimal.ROUND_HALF_UP));
			
		}
		if(bondsList.get(0).get(0).getString("vcBondYield2") != null && bondsList.get(0).get(0).getString("vcBondYield2") != ""){
			recordDetail.setBondYield2(new BigDecimal(bondsList.get(0).get(0).getString("vcBondYield2")).setScale(4,BigDecimal.ROUND_HALF_UP));
		}
		if(bondsList.get(0).get(0).getString("vcRealBondInterest") != null && bondsList.get(0).get(0).getString("vcRealBondInterest") != ""){
			recordDetail.setRealBondInterest(new BigDecimal(bondsList.get(0).get(0).getString("vcRealBondInterest")).setScale(4,BigDecimal.ROUND_HALF_UP));
		}
		if(bondsList.get(0).get(0).getString("vcStopPrice") != null && bondsList.get(0).get(0).getString("vcStopPrice") != ""){
			recordDetail.setStopPrice(new BigDecimal(bondsList.get(0).get(0).getString("vcStopPrice")).setScale(4,BigDecimal.ROUND_HALF_UP));
		}
		
		//recordDetail.setBondSettleType2(bondsList.get(0).get(0).getString("vcBondsettletype2"));--多余
		
		detList.add(recordDetail);
		model.setRecordDetails(detList);
		
		
		//组装collateraDetails
		List<RequestCollateraDetailModel> collList= new ArrayList<RequestCollateraDetailModel>();
		
		String vcCheckmemo = bondsList.get(0).get(0).getString("vcCheckmemo");
		if(!"".equals(vcCheckmemo) && vcCheckmemo!=null){
			String[] bonds = vcCheckmemo.split(";");
			for(String bond: bonds){
				String[] strs = bond.split("\\|");
				if(strs.length==5){
					RequestCollateraDetailModel collModel = new RequestCollateraDetailModel();
					collModel.setExDestination(bondsList.get(0).get(0).getString("vcExdestination"));
					collModel.setCombinNo(strs[0]);
					collModel.setInvestType(strs[1]);
					collModel.setSymbol(strs[2]);
					collModel.setCollateralRatio(strs[3]);
					collModel.setCollateralQty(strs[4]);
					collModel.setCollateralValue(new BigDecimal(Double.parseDouble(strs[4])*100).toString());
					collList.add(collModel);
				} else if(strs.length==4){//买断式参数长度
					RequestCollateraDetailModel collModel = new RequestCollateraDetailModel();
					collModel.setExDestination(bondsList.get(0).get(0).getString("vcExdestination"));
					collModel.setCombinNo(strs[0]);
					collModel.setInvestType(strs[1]);
					collModel.setSymbol(strs[2]);
					collModel.setCollateralQty(strs[3]);
					collModel.setCollateralValue(new BigDecimal(Double.parseDouble(strs[3])*100).toString());
					collList.add(collModel);
				}
			}
		}
		
		recordDetail.setCollateraDetails(collList);
		return model;
	}
	/**
	 * 保存接口参数数据到数据库（兼容原fix参数）
	 * @param sendMsg
	 * @param requestDetailList
	 * @param collateraDetailsList
	 */
	public static void saveDataObjectRecordModel(DataObject sendMsg,List requestDetailList,List collateraDetailsList){
		ITransactionManager txManager = TransactionManagerFactory.getTransactionManager();
		txManager.begin(ITransactionDefinition.PROPAGATION_REQUIRED,ITransactionDefinition.ISOLATION_DEFAULT);
		try{ 
			 //创建实体对象
			 DataObject requestRecordModel = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskRequestModel");
			 //l_request_id
			 com.eos.foundation.database.DatabaseExt.getPrimaryKey(requestRecordModel);//获取主键
			 requestRecordModel.setString("cIsSync",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcInstructionNo",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcCallPoint",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcCallSys",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcBusinessClass",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("dBeginDate",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("dEndDate",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("dTradeDate",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cPurposeType",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("dFutSettDate",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("dFutSettDate2",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cFixFlag",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cTrialFlag",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cCheckRangeRiskFlag",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cCheckRatioRiskFlag",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcTempriskNo",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcClOrdId",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("vcSenderSubId",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cProcessType",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("lGgroup",sendMsg.getString("CallPoint"));
			 requestRecordModel.setString("cIsO32Order",sendMsg.getString("CallPoint"));
			 
			 //插入数据库
		     com.eos.foundation.database.DatabaseUtil.insertEntity("default", requestRecordModel);
			 
			 List<RequestRecordDetail> delist = requestDetailList;
			 //创建实体对象
			 DataObject[] requestDetails = new DataObject[delist.size()];
			 for (int i = 0; i < delist.size(); i++) {
				
				//创建实体对象
				 DataObject requestDetail = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskRequestDetail");
				 com.eos.foundation.database.DatabaseExt.getPrimaryKey(requestDetail);//获取主键
				 requestDetail.setString("lRequestId",sendMsg.getString("requestId"));
				 //requestDetail.setString("recordDetailId",delist.get(i).getRecordDetailId());
				 requestDetail.setString("vcFundCode",delist.get(i).getFundCode());
				 requestDetail.setString("vcFundId",delist.get(i).getFundId());
				 requestDetail.setString("vcCombinNo",delist.get(i).getCombinNo());
				 requestDetail.setString("vcExDestination",delist.get(i).getExDestination());
				 requestDetail.setString("vcStype",delist.get(i).getStype());
				 requestDetail.setString("vcCurrencyCode",delist.get(i).getCurrencyCode());
				 requestDetail.setString("vcInterCode",delist.get(i).getInterCode());
				 requestDetail.setString("cInvestType",delist.get(i).getInvestType());
				 requestDetail.setString("cBusinType",delist.get(i).getBusinType());
				 requestDetail.setString("vcBondType",delist.get(i).getBondType());
				 requestDetail.setString("vcMaturityYield1",delist.get(i).getMaturityYield1().toString());
				 requestDetail.setString("vcMaturityYield2",delist.get(i).getMaturityYield2().toString());
				 requestDetail.setString("vcInsideAppraise1",delist.get(i).getInsideAppraise1().toString());
				 requestDetail.setString("vcInsideAppraise2",delist.get(i).getInsideAppraise2().toString());
				 requestDetail.setString("vcOuterAppraise1",delist.get(i).getOuterAppraise1().toString());
				 requestDetail.setString("vcOuterAppraise2",delist.get(i).getOuterAppraise2().toString());
				 requestDetail.setString("vcIssueAppraise1",delist.get(i).getIssueAppraise1().toString());
				 requestDetail.setString("vcIssueAppraise2",delist.get(i).getIssueAppraise2().toString());
				 requestDetail.setString("vcLeftDays1",delist.get(i).getLeftDays1().toString());
				 requestDetail.setString("vcLeftDays2",delist.get(i).getLeftDays2().toString());
				 requestDetail.setString("vcHgDays1",delist.get(i).getHgDays1().toString());
				 requestDetail.setString("vcHgDays2",delist.get(i).getHgDays2().toString());
				 requestDetail.setString("cStockTargetType",delist.get(i).getStockTargetType());
				 requestDetail.setString("lPrice",delist.get(i).getPrice().toString());
				 requestDetail.setString("vcOrderQtyRequest",delist.get(i).getOrderQty().toString());
				 requestDetail.setString("vcCashOrderQty",delist.get(i).getCashOrderQty().toString());
				 requestDetail.setString("cRiskInfluenceFlag",delist.get(i).getRiskInfluenceFlag().toString());
				 requestDetail.setString("dExpirationDate",delist.get(i).getExpirationDate().toString());
				 requestDetail.setString("dValueDate",delist.get(i).getValueDate().toString());
				 requestDetail.setString("vcEarnestAmount",delist.get(i).getEarnestAmount().toString());
				 requestDetail.setString("vcInterest",delist.get(i).getInterest().toString());
				 requestDetail.setString("vcExecBroker",delist.get(i).getExecBroker().toString());
				 requestDetail.setString("vcBondSettleType",delist.get(i).getBondSettleType());
				 requestDetail.setString("bcBondSettleType2",delist.get(i).getBondSettleType2());
				 requestDetail.setString("cAdvanceLimitFlag",delist.get(i).getAdvanceLimitFlag());
				 requestDetail.setString("vcWithdrawTypeRequest",delist.get(i).getWithdrawType());
				 requestDetail.setString("vcRepoRate",delist.get(i).getRepoRate().toString());
				 requestDetail.setString("vcEarnestBalance",delist.get(i).getEarnestBalance().toString());
				 
				 requestDetails[i]=requestDetail;
				 
				 List<RequestCollateraDetailModel> collDetlist = collateraDetailsList;
				 //创建实体对象
				 DataObject[] collateraDetailss = new DataObject[collDetlist.size()];
				 for (int j = 0; j < collDetlist.size(); j++) {
					
					//创建实体对象
					 DataObject collateraDetails = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskCollateraDetails");
					 com.eos.foundation.database.DatabaseExt.getPrimaryKey(collateraDetails);//获取主键
					 collateraDetails.setString("lRequestId",sendMsg.getString("requestId"));
					 collateraDetails.setString("lRecordDetailId", delist.get(i).getRecordDetailId());
					 collateraDetails.setString("vcExDestination", collDetlist.get(j).getExDestination());
					 collateraDetails.setString("vcExCombinNo", collDetlist.get(j).getCombinNo());
					 collateraDetails.setString("vcExInvestType", collDetlist.get(j).getInvestType());
					 collateraDetails.setString("vcExSymbol", collDetlist.get(j).getSymbol());
					 collateraDetails.setString("vcExCollateralRatio", collDetlist.get(j).getCollateralRatio().toString());
					 collateraDetails.setString("vcExCollateralQty", collDetlist.get(j).getCollateralQty().toString());
					 collateraDetails.setString("vcExCollateralValue", collDetlist.get(j).getCollateralValue().toString());
					 collateraDetailss[j]=collateraDetails;
				 }
				//批量插入数据库
				com.eos.foundation.database.DatabaseUtil.insertEntityBatch("default", collateraDetailss);
			 }
			//批量插入数据库
			com.eos.foundation.database.DatabaseUtil.insertEntityBatch("default", requestDetails);
			//提交事物
			txManager.commit();
		}catch (Exception e) {
			// TODO: handle exception
			txManager.rollback();
			Object[] params = {sendMsg.getString("instructionNo"),sendMsg.getString("clOrdId")};
			LogUtil.logError("保存统一风控接口参数保存到数据库失败！[InstructionNo]:{0},[ClOrdID]:{1}", e, params);
			e.printStackTrace();
		}
	}
	/***
	 * 保存风控参数值到数据库
	 * @param recordModel
	 */
	public static void saveRiskRequestInfo(RequestRecordModel recordModel){
		ITransactionManager txManager = TransactionManagerFactory.getTransactionManager();
		txManager.begin(ITransactionDefinition.PROPAGATION_REQUIRED,ITransactionDefinition.ISOLATION_DEFAULT);
		try{ 
			 //创建实体对象
			 DataObject requestRecordModel = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskRequestModel");
			 //l_request_id
			 com.eos.foundation.database.DatabaseExt.getPrimaryKey(requestRecordModel);//获取主键
			 requestRecordModel.setString("cIsSync",recordModel.getIsSync());
			 requestRecordModel.setString("vcInstructionNo",recordModel.getInstructionNo());
			 requestRecordModel.setString("vcCallpoint",recordModel.getCallPoint());
			 requestRecordModel.setString("vcCallSys",recordModel.getCallSys());
			 requestRecordModel.setString("vcBusinessClass",recordModel.getBusinessClass());
			 requestRecordModel.setInt("lBeginDate", Integer.parseInt(recordModel.getBeginDate()));
			 requestRecordModel.setInt("lEndDate", Integer.parseInt(recordModel.getEndDate()));
			 //requestRecordModel.setDate("dBeginDate",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(recordModel.getBeginDate()));
			 //requestRecordModel.setDate("dEndDate",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(recordModel.getEndDate()));
			 if(recordModel.getTradeDate()!=null && recordModel.getTradeDate()!=""){
				 requestRecordModel.setInt("lTradeDate", Integer.parseInt(recordModel.getTradeDate()));
				 //requestRecordModel.setDate("dTradeDate",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(recordModel.getTradeDate()));
			 }
			 requestRecordModel.setString("cPurposeType",recordModel.getPurposeType());
			 if(recordModel.getFutSettDate()!=null && recordModel.getFutSettDate()!=""){
				 requestRecordModel.setInt("lTradeDate", Integer.parseInt(recordModel.getFutSettDate()));
				 //requestRecordModel.setDate("dFutSettDate",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(recordModel.getFutSettDate()));
			 }
			 if(recordModel.getFutSettDate2()!=null && recordModel.getFutSettDate2()!=""){
				 requestRecordModel.setInt("lTradeDate", Integer.parseInt(recordModel.getFutSettDate2()));
				 //requestRecordModel.setDate("dFutSettDate2",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(recordModel.getFutSettDate2()));
			 }
			 requestRecordModel.setString("cFixFlag",recordModel.getFixFlag());
			 requestRecordModel.setString("cTrialFlag",recordModel.getTrialFlag());
			 requestRecordModel.setString("cCheckRangeRiskFlag",recordModel.getCheckRangeRiskFlag());
			 requestRecordModel.setString("cCheckRatioRiskFlag",recordModel.getCheckRatioRiskFlag());
			 requestRecordModel.setString("vcTempriskNo",recordModel.getTempriskNo());
			 requestRecordModel.setString("vcClOrdId",recordModel.getClOrdId());
			 requestRecordModel.setString("vcSenderSubId",recordModel.getSenderSubId());
			 requestRecordModel.setString("cProcessType",recordModel.getProcessType());
			 requestRecordModel.setString("lGgroup",recordModel.getGroup());
			 requestRecordModel.setString("cIsO32Order",recordModel.getIsO32Order());
			 //插入数据库 
		     com.eos.foundation.database.DatabaseUtil.insertEntity("default", requestRecordModel);
			 
			 List<RequestRecordDetail> delist = recordModel.getRecordDetails();
			 //创建实体对象
			 DataObject[] requestDetails = new DataObject[delist.size()];
			 for (int i = 0; i < delist.size(); i++) {
				//创建实体对象
				 DataObject requestDetail = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskRequestDetail");
				 com.eos.foundation.database.DatabaseExt.getPrimaryKey(requestDetail);//获取主键
				 requestDetail.setString("lRequestId",requestRecordModel.getString("lRequestId"));
				 //requestDetail.setString("recordDetailId",delist.get(i).getRecordDetailId());
				 requestDetail.setString("vcFundCode",delist.get(i).getFundCode());
				 requestDetail.setString("vcFundId",delist.get(i).getFundId());
				 requestDetail.setString("vcCombinNo",delist.get(i).getCombinNo());
				 requestDetail.setString("vcExDestination",delist.get(i).getExDestination());
				 requestDetail.setString("vcStype",delist.get(i).getStype());
				 requestDetail.setString("vcCurrencyCode",delist.get(i).getCurrencyCode());
				 requestDetail.setString("vcInterCode",delist.get(i).getInterCode());
				 requestDetail.setString("cInvestType",delist.get(i).getInvestType());
				 requestDetail.setString("cBusinType",delist.get(i).getBusinType());
				 requestDetail.setString("vcBondType",delist.get(i).getBondType());
				 if(delist.get(i).getMaturityYield1()!=null && delist.get(i).getMaturityYield1().toString()!=""){
					 requestDetail.setString("vcMaturityYield1",delist.get(i).getMaturityYield1().toString());
				 }
				 if(delist.get(i).getMaturityYield2()!=null && delist.get(i).getMaturityYield2().toString()!=""){
					 requestDetail.setString("vcMaturityYield2",delist.get(i).getMaturityYield2().toString());
				 }
				 if(delist.get(i).getInsideAppraise1()!=null && delist.get(i).getInsideAppraise1().toString()!=""){
					 requestDetail.setString("vcInsideAppraise1",delist.get(i).getInsideAppraise1().toString());
				 }
				 if(delist.get(i).getInsideAppraise2()!=null && delist.get(i).getInsideAppraise2().toString()!=""){
					 requestDetail.setString("vcInsideAppraise2",delist.get(i).getInsideAppraise2().toString());
				 }
				 if(delist.get(i).getOuterAppraise1()!=null && delist.get(i).getOuterAppraise1().toString()!=""){
					 requestDetail.setString("vcOuterAppraise1",delist.get(i).getOuterAppraise1().toString());
				 }
				 if(delist.get(i).getOuterAppraise2()!=null && delist.get(i).getOuterAppraise2().toString()!=""){
					 requestDetail.setString("vcOuterAppraise2",delist.get(i).getOuterAppraise2().toString());
				 }
				 if(delist.get(i).getIssueAppraise1()!=null && delist.get(i).getIssueAppraise1().toString()!=""){
					 requestDetail.setString("vcIssueAppraise1",delist.get(i).getIssueAppraise1().toString());
				 }
				 if(delist.get(i).getIssueAppraise2()!=null && delist.get(i).getIssueAppraise2().toString()!=""){
					 requestDetail.setString("vcIssueAppraise2",delist.get(i).getIssueAppraise2().toString());
				 }
				 if(delist.get(i).getLeftDays1()!=null && delist.get(i).getLeftDays1().toString()!=""){
					 requestDetail.setString("vcLeftDays1",delist.get(i).getLeftDays1().toString());
				 }
				 if(delist.get(i).getLeftDays2()!=null && delist.get(i).getLeftDays2().toString()!=""){
					 requestDetail.setString("vcLeftDays2",delist.get(i).getLeftDays2().toString());
				 }
				 if(delist.get(i).getHgDays1()!=null && delist.get(i).getHgDays1().toString()!=""){
					 requestDetail.setString("vcHgDays1",delist.get(i).getHgDays1().toString());
				 }
				 if(delist.get(i).getHgDays2()!=null && delist.get(i).getHgDays2().toString()!=""){
					 requestDetail.setString("vcHgDays2",delist.get(i).getHgDays2().toString());
				 }
				 requestDetail.setString("cStockTargetType",delist.get(i).getStockTargetType());
				 if(delist.get(i).getPrice()!=null && delist.get(i).getPrice().toString()!=""){
					 requestDetail.setString("lPrice",delist.get(i).getPrice().toString());
				 }
				 if(delist.get(i).getOrderQty()!=null && delist.get(i).getOrderQty().toString()!=""){
					 requestDetail.setString("vcOrderQty",delist.get(i).getOrderQty().toString());
				 }
				 //vcOrderqty
				 if(delist.get(i).getCashOrderQty()!=null && delist.get(i).getCashOrderQty().toString()!=""){
					 requestDetail.setString("vcCashOrderQty",delist.get(i).getCashOrderQty().toString());
				 }
				 if(delist.get(i).getRiskInfluenceFlag()!=null && delist.get(i).getRiskInfluenceFlag().toString()!=""){
					 requestDetail.setString("cRiskInfluenceFlag",delist.get(i).getRiskInfluenceFlag().toString());
				 }
				 if(delist.get(i).getExpirationDate()!=null && delist.get(i).getExpirationDate().toString()!=""){
					 requestDetail.set("lExpirationDate", Integer.parseInt(delist.get(i).getExpirationDate()));
					 //requestDetail.setDate("dExpirationDate",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(delist.get(i).getExpirationDate().toString()));
				 }
				 if(delist.get(i).getValueDate()!=null && delist.get(i).getValueDate().toString()!=""){
					 requestDetail.set("lExpirationDate", Integer.parseInt(delist.get(i).getValueDate()));
					 //requestDetail.setDate("dValueDate",(new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" )).parse(delist.get(i).getValueDate().toString()));
				 }
				 if(delist.get(i).getEarnestAmount()!=null && delist.get(i).getEarnestAmount().toString()!=""){
					 requestDetail.setString("vcEarnestAmount",delist.get(i).getEarnestAmount().toString());
				 }
				 if(delist.get(i).getInterest()!=null && delist.get(i).getInterest().toString()!=""){
					 requestDetail.setString("vcInterest",delist.get(i).getInterest().toString());
				 }
				 if(delist.get(i).getExecBroker()!=null && delist.get(i).getExecBroker().toString()!=""){
					 requestDetail.setString("vcExecBroker",delist.get(i).getExecBroker().toString());
				 }
				 requestDetail.setString("vcBondSettleType",delist.get(i).getBondSettleType());
				 requestDetail.setString("bcBondSettleType2",delist.get(i).getBondSettleType2());
				 requestDetail.setString("cAdvanceLimitFlag",delist.get(i).getAdvanceLimitFlag());
				 requestDetail.setString("vcWithdrawTypeRequest",delist.get(i).getWithdrawType());
				
				 if(delist.get(i).getRepoRate()!=null && delist.get(i).getRepoRate().toString()!=""){
					 requestDetail.setString("vcRepoRate",delist.get(i).getRepoRate().toString());
				 }
				 if(delist.get(i).getEarnestBalance()!=null && delist.get(i).getEarnestBalance().toString()!=""){
					 requestDetail.setString("vcEarnestBalance",delist.get(i).getEarnestBalance().toString());
				 }
				 requestDetail.setString("cIsInquiry",delist.get(i).getIsInquiry());
				 
				 requestDetails[i]=requestDetail;
				 
				 List<RequestCollateraDetailModel> collDetlist = delist.get(i).getCollateraDetails();
				 //创建实体对象
				 DataObject[] collateraDetailss = new DataObject[collDetlist.size()];
				 for (int j = 0; j < collDetlist.size(); j++) {
					
					//创建实体对象
					 DataObject collateraDetails = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskCollateraDetails");
					 com.eos.foundation.database.DatabaseExt.getPrimaryKey(collateraDetails);//获取主键
					 collateraDetails.setString("lRequestId",requestRecordModel.getString("lRequestId"));
					 collateraDetails.setString("lRecordDetailId", requestDetail.getString("lRecordDetailId"));
					 
					 collateraDetails.setString("vcExDestination", collDetlist.get(j).getExDestination());
					 collateraDetails.setString("vcExCombinNo", collDetlist.get(j).getCombinNo());
					 collateraDetails.setString("vcExInvestType", collDetlist.get(j).getInvestType());
					 collateraDetails.setString("vcExSymbol", collDetlist.get(j).getSymbol());
					 if(collDetlist.get(j).getCollateralRatio()!=null && collDetlist.get(j).getCollateralRatio().toString()!=""){
						 collateraDetails.setString("vcExCollateralRatio", collDetlist.get(j).getCollateralRatio().toString());
					 }
					 if(collDetlist.get(j).getCollateralQty()!=null && collDetlist.get(j).getCollateralQty().toString()!=""){
						 collateraDetails.setString("vcExCollateralQty", collDetlist.get(j).getCollateralQty().toString());
					 }
					 if(collDetlist.get(j).getCollateralValue()!=null && collDetlist.get(j).getCollateralValue().toString()!=""){
						 collateraDetails.setString("vcExCollateralValue", collDetlist.get(j).getCollateralValue().toString());
					 }
					 
					 
					 collateraDetailss[j]=collateraDetails;
				 }
				//批量插入数据库
				com.eos.foundation.database.DatabaseUtil.insertEntityBatch("default", collateraDetailss);
			 }
			//批量插入数据库
			com.eos.foundation.database.DatabaseUtil.insertEntityBatch("default", requestDetails);
			//提交事物
			txManager.commit();
		}catch (Exception e) {
			// TODO: handle exception
			txManager.rollback();
			Object[] params = {recordModel.getInstructionNo(),recordModel.getClOrdId()};
			LogUtil.logError("保存统一风控接口参数保存到数据库失败！[InstructionNo]:{0},[ClOrdID]:{1}", e, params);
			e.printStackTrace();
		}
	}
	/**
	 * 保存风控接口返回值到数据库
	 * @param jsonStr
	 * @return
	 */
	public static void saveRiskReturnInfo(CheckResultReturn checkResult){
		
		
		//开启事物
		ITransactionManager txManager = TransactionManagerFactory.getTransactionManager();
		txManager.begin(ITransactionDefinition.PROPAGATION_REQUIRED,ITransactionDefinition.ISOLATION_DEFAULT);

		try{
			//创建实体对象
			DataObject checkResultReturn = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskCheckResultReturn");
			
			com.eos.foundation.database.DatabaseExt.getPrimaryKey(checkResultReturn);//获取主键
			//赋值插入实体
			checkResultReturn.setString("vcClordId",checkResult.getClOrdId());
			checkResultReturn.setString("vcProcessType",checkResult.getProcessType());
			checkResultReturn.setString("vcErrorCode",checkResult.getErrorCode());
			checkResultReturn.setString("vcErrorMsg",checkResult.getErrorMsg());
			checkResultReturn.setString("cRiskResult",checkResult.getRiskResult());
			checkResultReturn.setString("vcRcGroup",checkResult.getRcGroup());
			checkResultReturn.setString("vcUcGroup",checkResult.getUcGroup());
			
			//插入数据库
			com.eos.foundation.database.DatabaseUtil.insertEntity("default", checkResultReturn);
			//RcCheckResultDto 类型数据
			List<RcCheckResultDto> dtoList = checkResult.getCheckResultDetail();
			//创建实体对象
			DataObject[] checkResultDtos = new DataObject[dtoList.size()];
					
			for (int i=0;i<dtoList.size();i++) {
				//定义实体
				DataObject checkResultDto =  DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskCheckResultDto");
				//获取主键
				com.eos.foundation.database.DatabaseExt.getPrimaryKey(checkResultDto);//获取主键
				checkResultDto.setString("lCheckReturnId",checkResultReturn.getString("lCheckReturnId"));
				checkResultDto.setString("vcSymbol",dtoList.get(i).getSymbol());
				checkResultDto.setString("vcStype",dtoList.get(i).getStype());
				checkResultDto.setString("vcExDestination",dtoList.get(i).getExDestination());
				checkResultDto.setString("vcRuleId",dtoList.get(i).getRuleId());
				checkResultDto.setString("cRiskOperation",dtoList.get(i).getRiskOperation());
				checkResultDto.setString("vcRiskType",dtoList.get(i).getRiskType());
				checkResultDto.setString("vcThreshhold",dtoList.get(i).getThreshhold());
				checkResultDto.setString("vcFundCode",dtoList.get(i).getFundCode());
				checkResultDto.setString("vcCombiNo",dtoList.get(i).getCombiNo());
				checkResultDto.setString("cRcType",dtoList.get(i).getRcType());
				checkResultDto.setString("vcSettingValue",dtoList.get(i).getSettingValue());
				checkResultDto.setString("vcRealValue",dtoList.get(i).getRealValue());
				checkResultDto.setString("vcNumerator",dtoList.get(i).getNumerator());
				checkResultDto.setString("vcDenominator",dtoList.get(i).getDenominator());
				checkResultDto.setString("vcRiskSummary",dtoList.get(i).getRiskSummary());
				checkResultDto.setString("cRiskSource",dtoList.get(i).getRiskSource());
				checkResultDto.setString("vcInsApproveFlow",dtoList.get(i).getInsApproveFlow());
				checkResultDto.setString("vcRemark",dtoList.get(i).getRemark());
				//装入集合
				checkResultDtos[i]=checkResultDto;
			}
			if(checkResultDtos.length>0){
				//批量插入数据库
				com.eos.foundation.database.DatabaseUtil.insertEntityBatch("default",checkResultDtos);
			}
			//Uncontrol 类数据
			List<UncontrolResult> unList = checkResult.getUncontrolDetail();
			//创建实体对象
			DataObject[] uncontrolResults = new DataObject[unList.size()];
			
			for (int i=0;i<unList.size();i++) {
				DataObject uncontrolResult = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsRiskUncontrolResult");
				com.eos.foundation.database.DatabaseExt.getPrimaryKey(uncontrolResult);//获取主键
				uncontrolResult.setString("lCheckReturnId",checkResultReturn.getString("lCheckReturnId"));
				uncontrolResult.setString("vcUncontrolRiskNos",unList.get(i).getRiskNos());
				uncontrolResult.setString("vcUncontrolFundCode",unList.get(i).getFundCode());
				uncontrolResult.setString("vcUncontrolRiskSummary",unList.get(i).getRiskSummary());
				uncontrolResult.setString("vcUncontrolRemark",unList.get(i).getRemark());
				
				uncontrolResults[i]=uncontrolResult;
			}
			if(uncontrolResults.length>0){
				//批量插入数据库
				com.eos.foundation.database.DatabaseUtil.insertEntityBatch("default", uncontrolResults);
			}
			//提交事物
			txManager.commit();
		}catch (Exception e) {
			// TODO: handle exception
			txManager.rollback();
			Object[] params = {checkResult.getClOrdId(),checkResult.getRcGroup()};
			LogUtil.logError("保存统一风控接口返回值保存到数据库失败！[ClOrdID]:{0},[RcGroup]:{1}", e, params);
			e.printStackTrace();
		}
		
	}
	
	public static Object isNull(Object obj){
		
		if(obj!=null){
			if(obj.equals("null")){
				return null;
			}
			if (obj instanceof String) {
				obj="\""+obj.toString()+"\"";
			}
			else if(obj instanceof BigDecimal){
				obj = ((BigDecimal) obj).toPlainString();
			}
		}
		return obj;
		
	}
	
}
