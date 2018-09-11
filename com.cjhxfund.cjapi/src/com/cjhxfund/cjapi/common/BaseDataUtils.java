package com.cjhxfund.cjapi.common;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.cjapi.model.SecondMarketParamVo;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.cjhxfund.commonUtil.StrUtil;
import com.cjhxfund.jy.ProductProcess.ProductProcessUtil;
import com.eos.das.entity.criteria.CriteriaType;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.utility.StringUtil;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @Description	用于处理基础数据通用类
 * @ClassName	BaseDataUtils
 * @Date		2016年12月6日 下午4:16:39
 * @Author		liangjilong
 * Copyright (c) All Rights Reserved, 2016.
 */
@Bizlet("用于处理基础数据通用类")
public class BaseDataUtils {

	/**=====================================常量固定值=Begin===========================================**/
	/**是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）目前都是0*/
	private static final String IS_INQUIRY="0";
	/**数据来源（默认1，1-机器猫下的指令，2-CJAPI接口过来的数据）*/
	private static final String DATA_FROM_SOURCE="2";
	/**清算类型(固定值) Y 1-全额结算；2-净额结算**/
	private static final String CLEAR_TYPE="1";
	/**2-银行间二级市场*/
	private static final String VC_BUSIN_CLASS="2";
	/**结算方式(首次结算方式) ,：1-见款付券 2- 见券付款 3-券款对付;4-纯券过户*/
	private static final String BOND_SETTLE_TYPE="3";
	/**更新修改订单状态命名sql的id**/
	private static final String UPDATE_MODIFIED_ORDER_STATUS_NSQL_ID = "com.cjhxfund.cjapi.common.OrderStatusns.updateOrderStatus";
	/**更新操作执行订单流程状态命名sql的id**/
	private static final String UPDATE_ORDER_PROCESS_STATUS_NSQL_ID = "com.cjhxfund.cjapi.common.OrderStatusns.updateOrderProcessStatus";
	/**价格模式 1 - 市价（表示不限制委托价格，在涨跌停范围内即可）;2 - 限价（表示限制委托价格，买入不高于，卖出不低于）;*/
	private static final String ORDER_TYPE="2";
	/**交易市场：OTC-场外*/
	private static final String EXDESTINATION = "OTC";
	/**判断可用（风控）：0-不判；1-判*/
	private static final String JUDGEAVAILABLE = "1";
	/**判断风控：0-不判；1-判；*/
	private static final String JUDGERISK = "1";
	/**指令操作级别：0无；1快速；2一般；3慢速；数据字典40345项 ；*/
	private static final String INSTRUCTIONLEVEL = "0";
	/**【只用于银行间回购】到期结算方式：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户*/
	private static final String BONDSETTLETYPE2 = "3";
	/**回购用途类别：1：等期限套利；2：不等期限套利；3：短期资金运用；4：超配；5：放大；*/
	private static final String PURPOSETYPE = "";
	/**交易员代码*/
	private static final String  TRADERCODE = "R4404";
 
	
	
	/**
	 * @Description 转换机器猫识别格式的数据(JQMZQMM机器猫债券买卖)
	 * @Author		liangjilong
	 * @Date		2016年11月30日 下午4:37:04
	 * @param 		paramters接口传进来的参数数据
	 * @param       注释备注：（Y/N）备注后面Y代表是JQM那边必填的字段，N不必要填的字段.
	 * @param       isAdd(true/false) 是否添加/修改，如果是修改把主键返回给JQM接口
	 * @return 		Map<String,Object> 返回类型
	 * @throws AppException 
	 */
	@Bizlet("JQMZQMM机器猫债券买卖")
	public static DataObject convertDataFormatToNewJQMZQMM(DataObject paramters,SecondMarketParamVo paramVo){
		DataObject dataObj = DataObjectUtil.createDataObject(CJAPIConstants.JQM_JY_XQJY_ENTITY_NAME);//创建映射后数据对象
		/*处理接口参数字段映射*/
		dataObj.set("vcProductCode",paramters.getString("vcProductCode"));	//产品代码
		dataObj.set("vcProductName",paramters.getString("vcProductName"));	//产品名称
		dataObj.set("vcCombiCode",paramters.getString("vcCombiNo"));	//组合编号
		dataObj.set("vcCombiName",paramters.getString("vcCombiName"));	//组合编号
		dataObj.set("vcStockCode",paramters.getString("vcBondCode"));	//债券代码
		dataObj.set("vcStockName",paramters.getString("vcBondName"));	//债券名称
		dataObj.set("vcInvestType",paramters.getString("vcInvestType"));	//投资类型
		//委托方向：3-债券买入  4-债券卖出      买卖方向，1 - 买入 2 - 卖出
		if("01".equals(paramters.getString("vcBusinType"))){
			dataObj.setString("vcEntrustDirection","3");//委托方向
			dataObj.setString("side","1");//买卖方向
		}else if("02".equals(paramters.getString("vcBusinType"))){
			dataObj.setString("vcEntrustDirection","4");//委托方向
			dataObj.setString("side","2");//买卖方向
		}
		dataObj.set("vcSettleSpeed",paramters.getString("vcClearSpeed"));	//清算速度
		dataObj.set("vcCounterpartyId",paramters.get("vcTradeRivalId"));	//交易对手编号
		dataObj.set("vcCounterpartyName",paramters.getString("vcTradeRivalName")); //交易对手名称
		dataObj.set("enNetPrice",paramters.get("enNetPrice"));	//净价（元/百元面值）
		dataObj.set("enNetPriceAmount",paramters.get("enNetPriceAmount"));	//净价金额
		dataObj.set("enFullPrice",paramters.get("enFullPrice"));	//全价（元/百元面值）
		dataObj.set("enFullPriceAmount",paramters.get("enFullPriceAmount"));	//全价金额
		dataObj.set("enPrice",paramters.get("enPrice"));	//指令价格（净价计算时取净价、全价计算时取全价）
		dataObj.set("vcYieldType", paramters.get("vcYieldType"));//收益率类型
		dataObj.set("enMaturityYield",paramters.get("enMaturityYield"));//到期收益率
		dataObj.set("enOptionYield", paramters.get("enOptionYield"));//行权收益率
		dataObj.set("enFaceAmount",paramters.get("enOrderBalance"));//指令金额
		dataObj.set("lTradeQty",paramters.get("enOrderAmount"));//指令数量
		dataObj.set("vcCurrency",paramters.get("vcCurrency"));//币种
		dataObj.set("vcRemark",paramters.get("vcRemark"));//币种
		dataObj.set("vcAgreemtCode",paramters.get("vcAgreemtCode"));	//约定号
		dataObj.set("vcRivalSeat",paramters.get("vcRivalSeat"));	//对手席位号
		dataObj.set("vcCounterpartyTrader",paramters.get("vcCounterpartyTrader"));	//对方交易员
		/*处理个业务各自固定设置字段映射*/
		dataObj.set("vcInstructSource","2");//指令来源：2-CJAPI接口过来的数据
		dataObj.set("vcBizType",paramters.get("vcBizType"));//收益率类型
		dataObj.set("businClass", paramters.get("businClass"));//业务类别：2-银行间二级市场业务、E-交易所大宗交易、I-上交所固收
		dataObj.set("exdestination", paramters.get("exdestination"));//交易市场：场外【银行间业务】-OTC、上交所-SS、 深交所-SZ
		dataObj.set("vcMarket", paramters.get("vcMarket"));//市场代码：1-上交所、2-交易所、5-银行间
		dataObj.set("vcFirstSettleMode", BOND_SETTLE_TYPE);//结算方式-默认设置3-券款对付
		dataObj.set("judgeavailable", JUDGEAVAILABLE);//判可用-默认设置1-判
		dataObj.set("judgerisk", JUDGERISK);//判风控-默认设置1-判
		dataObj.set("vcProcessStatus", "1");//设置默认流程状态
		Long lTradeDate = (long) DateUtil.currentDateYYYYMMDDInt(); 
		dataObj.set("lTradeDate",lTradeDate);	//交易日期
		String lFirstSettleDate = DateUtil.getCalculateTradeDay(null,DateUtil.currentDateYYYYMMDDStr(),null,paramters.getInt("vcClearSpeed"));//根据交易日与清算速度计算结算日期
		dataObj.set("lFirstSettleDate",lFirstSettleDate);	//结算日期
		//判断银行间和交易所如下字段值
		//BigDecimal bdOrderAmount = paramters.getBigDecimal("enOrderAmount");
		//double orderAmountValue = StrUtil.toDouble(bdOrderAmount)/100;
		//券面总额(元)=指令数量*100, 券面金额（万元）=券面总额(元)/10000, 以万元传过来计算所以要除以100
		//dataObj.set("investCount",orderAmountValue);	//券面金额（万元）Y		
		return dataObj;
	}
	
	
	
	
	
	
	/**
	 * @Description 转换机器猫识别格式的数据(JQMZQMM机器猫债券买卖)
	 * @Author		liangjilong
	 * @Date		2016年11月30日 下午4:37:04
	 * @param 		paramters接口传进来的参数数据
	 * @param       注释备注：（Y/N）备注后面Y代表是JQM那边必填的字段，N不必要填的字段.
	 * @param       isAdd(true/false) 是否添加/修改，如果是修改把主键返回给JQM接口
	 * @return 		Map<String,Object> 返回类型
	 * @throws AppException 
	 */
	@Bizlet("JQMZQMM机器猫债券买卖")
	public static DataObject convertDataFormatToJQMZQMM(DataObject paramters,SecondMarketParamVo paramVo) throws AppException {
		
		String entityName = paramVo.getEntityName();//实体名称路径
		DataObject dataObj = DataObjectUtil.createDataObject(entityName);
		//获取债券类别
		String vcBondName = paramters.getString("vcBondName");//债券名称
		String vcBondCode = paramters.getString("vcBondCode");//债券编码
		paramters.setString("vcBondCodeExternal", vcBondCode);
		vcBondName = (vcBondName==""||vcBondName==null?"":vcBondName);
		vcBondCode = (vcBondCode==""||vcBondCode==null?"":vcBondCode);
		vcBondCode = getBondCodeExternal(vcBondCode);
		paramters.setString("vcBondCode",vcBondCode);
		try {
			String smInfoResult = getSecondMarketInfoByInvokeJQM(vcBondCode,vcBondName);
			if(!StringUtil.isBlank(smInfoResult)){
				//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
				String [] smInfoResults = smInfoResult.split(",");
				if(StrUtil.isNotEmpty(smInfoResults)){
					dataObj.set("investCategory",smInfoResults[2]);	//债券类别	N  有些产品查询不到就无值 
				}
			}else{
				//O32找不到与提供的债券代码相应的债券信息
				String msg =String.format(CJAPIConstants.BONDCODE_NOT_IN_O32_MSG,paramters.getString("vcBondCodeExternal"));
				LogUtil.logError(msg,null);
				throw new AppException(CJAPIConstants.BONDCODE_NOT_IN_O32_CODE, msg);
			}
		} catch (Throwable e) {
			if(e instanceof AppException){
				throw (AppException)e;
			}else{
				LogUtil.logError("获取二级（二级市场）债相关的信息,方法getSecondMarketInfoByInvokeJQM出现异常"+e.getMessage(), e, new Object[]{});
				throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);//调用异常，不用返回具体信息
			}
		}
		/*
		 * 业务类别vcBusinType（分六类：1.债券买卖;2.正逆回购;3.债券申缴;4.基金申赎;5.同业存取;6.资金追提;）：
		 * 01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;
		 * 07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;
		 * 15-资金提取;99-其他指令
		 * 有些产品查询不到就无值  cBondAppraise cIssueAppraise
		 */
		DataObject stockInfo = CJAPICommonUtil.getStockInfo(vcBondCode);	//根据债券代码获取债券评级和主体评级
		if(StrUtil.isNotEmpty(stockInfo)){
			dataObj.set("bondRating",stockInfo.getString("cBondAppraise"));	//债券评级	N  --1.3.债券评级：01-AAA及以上;02-AA+;03-AA;04-AA-;05-A及以下;06-短融A-1;99-其他;
			dataObj.set("subjectRating",stockInfo.getString("cIssueAppraise"));	//主体评级	N  --1.3.主体评级：01-AAA及以上;02-AA+;03-AA;04-AA-;05-A及以下;99-其他;
		}
		dataObj.set("processType",paramters.getString("vcBusinType"));	//业务类别
		dataObj.set("busintype",paramters.getString("vcBusinType"));	//委托方向
		dataObj.set("netPrice",paramters.get("enNetPrice"));	//净价（元/百元面值）	N
		dataObj.set("fullPrice",paramters.get("enFullPrice"));	//全价（元/百元面值）	N
		dataObj.set("processStatus",paramters.get("processStatus"));	//全价（元/百元面值）	N
		
		dataObj.set("seatNum","");//席位号	N (暂时接口未定义)
		dataObj.set("agreementNum",paramters.get("agreementNum"));	//约定号	N (暂时接口未定义)
		/**------通过Vo传值处理的信息.------*/
		if(paramVo.getTradingPlace()!=null){
			dataObj.set("tradingPlace",paramVo.getTradingPlace());	//交易场所	Y 01-银行间 02-上交所固收平台 03-深交所综合协议平台|上交所大宗
		}
		if("SS".equals(paramVo.getTradingPlace())){
			dataObj.set("tradingPlace","02");
		}
		if("SZ".equals(paramVo.getTradingPlace())){
			dataObj.set("tradingPlace","03");
		}
		//判断银行间和交易所如下字段值
		if(paramVo.getHasInterestRate()=="1"){
			dataObj.set("interestRateType",paramters.getString("vcInterestRateType"));	//收益率类型	N
			//收益率 N
			BigDecimal enInterestRate = paramters.getBigDecimal("enInterestRate");
			if(enInterestRate!=null){
				//在参数检测了长度,不会出现Double出现E,故不用做处理
				if(enInterestRate.compareTo(new BigDecimal(1)) ==1){
					String percentRateMsg = CJAPIConstants.PERCENT_RATE_MSG;//提示信息
					String errMsg = String.format(percentRateMsg,"enTradeRate");
					throw new AppException(CJAPIConstants.PERCENT_RATE_CODE,errMsg);
				}else{
					BigDecimal enTradeRateVal = enInterestRate.multiply(new BigDecimal(100));
					dataObj.set("interestRate",enTradeRateVal);//收益率（%）3%时需填入0.03--Y
				}
			}
			dataObj.set("businclass",VC_BUSIN_CLASS);	//业务类别	 
		}else{
			dataObj.set("businclass",paramters.getString("vcBusinClass"));	//业务类别	 
		}
		//买卖方向，目前恒生系统对该Tag不处理 1 - 买入 2 - 卖出
		if("01".equals(paramters.getString("vcBusinType"))){
			dataObj.setString("side","1");
		}else if("02".equals(paramters.getString("vcBusinType"))){
			dataObj.setString("side","2");
		}
		BigDecimal bdOrderAmount = paramters.getBigDecimal("enOrderAmount");
		double orderAmountValue = StrUtil.toDouble(bdOrderAmount)/100;
		//券面总额(元)=指令数量*100, 券面金额（万元）=券面总额(元)/10000, 以万元传过来计算所以要除以100
		dataObj.set("investCount",orderAmountValue);	//券面金额（万元）Y		
		
		if(!StringUtil.isBlank(paramters.getString("vcClearSpeed"))){
			dataObj.set("clearingSpeed","T+"+paramters.getString("vcClearSpeed"));	//清算速度	Y  0--T+0,1--T+1
		}
		
		getCommonDataPropertyValue(paramters, paramVo, dataObj);
		return dataObj;
	}

	/**
	 * @Description  把证券买卖和正逆回购相同的字段属性值抽取出来处理.
	 * @Author		liangjilong
	 * @Date		2016年12月5日 下午5:13:49
	 * @param 		paramters 接口传过来的数据参数对象
	 * @param		paramVo二级市场（银行间或者交易所参数值传Vo对象）
	 * @param 		dataObj组装最终的DataObject对象
	 * @return 		void 返回类型
	 */
	private static void getCommonDataPropertyValue(DataObject paramters, SecondMarketParamVo paramVo, DataObject dataObj)throws AppException {
		dataObj.set("expiredate",new Date());	//截止日期(默认当天指令时间)	Y
		dataObj.set("processDate",new Date());	//业务日期(默认当天指令时间)	Y
		dataObj.set("vcCombiNo",paramters.getString("vcCombiNo"));	//组合编号	Y
		dataObj.set("vcCombiName",paramters.getString("vcCombiName"));	//组合名称	Y
		dataObj.set("investProductCode",paramters.getString("vcBondCode"));	//债券代码	Y(ZHFWPT_JY_ZQMM表有，ZHFWPT_JY_ZNHG表没有)
		dataObj.set("investProductName",paramters.getString("vcBondName"));	//债券名称	Y(ZHFWPT_JY_ZQMM表有，ZHFWPT_JY_ZNHG表没有)
		String vcClearType = paramters.getString("vcClearType");//清算类型(固定值) Y 1-全额结算；2-净额结算；
		if(StrUtil.isNotEmpty(vcClearType)){
			dataObj.set("cleartype",vcClearType);	
		}else{
			dataObj.set("cleartype",CLEAR_TYPE);	
		}
		
		if(paramVo.isHasTradeRival()){
			dataObj.set("traderCode",TRADERCODE);	//交易员代码	N
			//dataObj.set("traderival",paramters.getString("vcTradeRivalId"));	//交易对手编号 N (经过测试加上JQM无法推送到O32系统)
			dataObj.set("tradingOpponent",paramters.getString("vcTradeRivalName"));	//交易对手方名称	Y
		}
		String vcRemark = paramters.getString("vcRemark");
		if(StrUtil.isNotEmpty(vcRemark)&&vcRemark.length()>500){
			String vcRemarkMsg = CJAPIConstants.ERROR_PARAM_LENGTH_MSG;
			String errMsg = String.format(vcRemarkMsg,"vcRemark");
			throw new AppException(CJAPIConstants.ERROR_PARAM_LENGTH, errMsg);
		}
		dataObj.set("remark",vcRemark);	//备注	N
		dataObj.set("combProductCode",paramters.getString("vcProductCode"));	//产品编码	Y
		dataObj.set("combProductName",paramters.getString("vcProductName"));	//产品名称	Y
		
		//------inquiryId和investAdviserId=m:userObject/attributes/EXTEND_USER_ID ，inquiryName和investAdviserName=m:userObject/userName
		dataObj.set("inquiryId", paramters.getString("vcSenderSubId"));// 指令下达人员编号  	--当前推送系统人员ID
		dataObj.set("inquiryName", paramters.getString("vcSenderSubName"));//指令下达人员姓名  --当前推送系统人员姓名
		dataObj.set("investAdviserId", paramters.getString("vcSenderSubId"));// 投资顾问ID  	--当前推送系统人员ID
		dataObj.set("investAdviserName", paramters.getString("vcSenderSubName"));//投资顾问姓名  --当前推送系统人员姓名
		String vcInvestType = paramters.getString("vcInvestType");
		dataObj.set("investtype",(vcInvestType==null||vcInvestType==""?"1":vcInvestType));//1- 可交易 2- 持有到期 3- 可供出售 默认为1
		
		/**初始fix需要必填的值*/
		
		String vcFirstSettleType = paramters.getString("vcFirstSettleType");//首次结算方式
		String vcLastSettleType = paramters.getString("vcLastSettleType");//到期结算方式
		if(StrUtil.isNotEmpty(vcFirstSettleType)){
			dataObj.set("bondsettletype",vcFirstSettleType);//结算方式(首次结算方式) ,：1-见款付券 2- 见券付款 3-券款对付;4-纯券过户
		}else{
			dataObj.set("bondsettletype",BOND_SETTLE_TYPE);//结算方式(首次结算方式) ,：1-见款付券 2- 见券付款 3-券款对付;4-纯券过户
		}
		if(StrUtil.isNotEmpty(vcLastSettleType)){
			dataObj.set("bondsettletype2",vcLastSettleType);
		}else{
			dataObj.set("bondsettletype2",BONDSETTLETYPE2);
		}
		dataObj.set("ordtype",ORDER_TYPE);//价格模式
		dataObj.set("dataSource", DATA_FROM_SOURCE);//数据来源（默认1，1-机器猫下的指令，2-CJAPI接口过来的数据）
		dataObj.set("isInquiry", IS_INQUIRY);//是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）目前都是0
		dataObj.set("exdestination",EXDESTINATION);//EXDESTINATION
		dataObj.set("judgeavailable",JUDGEAVAILABLE);//judgeavailable
		dataObj.set("judgerisk",JUDGERISK);//judgerisk
		dataObj.set("instructionlevel",INSTRUCTIONLEVEL);//instructionlevel
		//msgtype消息类型：D（Order Single）指令下达 E（Order List）批量指令下达 G（Order Cancel/Replace Request）指令修改
		dataObj.set("msgtype",paramters.getString("msgtype"));
		dataObj.set("price",paramters.get("price"));
		
		if(!paramVo.isAdd()){
			dataObj.set("processId", paramters.getLong("enProcessId"));
		}
	}
	
	/**
	 * @Description  转换机器猫识别的数据格式(JQMZNHG机器猫正逆回购)
	 * @Author		liangjilong
	 * @Date		2016年12月5日 下午1:30:25
	 * @param 		paramters接口传进来的参数数据
	 * @param       注释备注：（Y/N）备注后面Y代表是JQM那边必填的字段，N不必要填的字段.
	 * @param 		isAdd(true/false) 是否添加/修改，如果是修改把主键返回给JQM接口
	 * @throws 		AppException 		参数
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("JQMZNHG机器猫正逆回购")
	public static DataObject convertDataFormatToJQMZNHG(DataObject paramters,SecondMarketParamVo paramVo) throws AppException {
		
		String entityName = paramVo.getEntityName();//实体名称路径
		DataObject dataObj = DataObjectUtil.createDataObject(entityName);
		
		BigDecimal fdate=(BigDecimal)paramters.get("lFirstSettleDate");
		BigDecimal ldate=(BigDecimal)paramters.get("lLastSettleDate");
		String lFirstSettleDate = null;
		String lLastSettleDate = null;
		//判断银行间和交易所如下字段值
		if(paramVo.getHasInterestRate()=="1"){
			if(fdate!=null){
				lFirstSettleDate = DateUtil.formatDate(fdate.toString());
				dataObj.set("firstSettlementDate", lFirstSettleDate);//首次结算日（默认当日日期算起YYYYMMDD）--Y
			}
			if(ldate!=null){
				lLastSettleDate = DateUtil.formatDate(ldate.toString());
				dataObj.set("expiryDate", lLastSettleDate);//到期结算日(算出来)--Y
			}
			if(!StringUtil.isBlank(paramters.getString("vcClearSpeed"))){
				dataObj.set("clearingSpeed","T+"+paramters.getString("vcClearSpeed"));	//清算速度	Y  0--T+0,1--T+1
			}
		}else{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String currentDate = sdf.format(new Date());
			//若业务类型为：21-交易所正回购；22-交易所逆回购；则交易对手和质押券为非必填项，清算速度默认为T+1。
			String clearingSpeed = "1";
			String actualDays = paramters.getString("vcStockCode");
			String result = ProductProcessUtil.getSettlementDate(currentDate,clearingSpeed,actualDays);
			dataObj.set("firstSettlementDate", DateUtil.formatDate(result.split("\\,")[0]));//首次结算日（默认当日日期算起YYYYMMDD）--Y
			dataObj.set("expiryDate", DateUtil.formatDate(result.split("\\,")[1]));//到期结算日(算出来)--Y
			//若业务类型为：21-交易所正回购；22-交易所逆回购；则交易对手和质押券为非必填项，清算速度默认为T+1。
			dataObj.set("clearingSpeed","T+1");
		}
		BigDecimal enTradeRate = paramters.getBigDecimal("enTradeRate");
		if(enTradeRate!=null){
			if(enTradeRate.compareTo(new BigDecimal(1))==1){
				String percentRateMsg = CJAPIConstants.PERCENT_RATE_MSG;//提示信息
				String errMsg = String.format(percentRateMsg,"enTradeRate");
				throw new AppException(CJAPIConstants.PERCENT_RATE_CODE,errMsg);
			}else{
				BigDecimal enTradeRateVal = enTradeRate.multiply(new BigDecimal(100));
				dataObj.set("tradingRate",enTradeRateVal);//回购利率（%）回购利率3%时需填入0.03--Y
			}
		}
		dataObj.set("tranAmount",paramters.get("enOrderBalance"));//交易金额（万元）-N
		dataObj.set("actualDays",paramters.get("vcStockCode"));//回购期限（天）--Y  //String
		dataObj.set("processType",paramters.get("vcBusinType"));//业务类别(2-银行间二级市场)	--Y
		dataObj.set("busintype",paramters.getString("vcBusinType"));
		dataObj.set("investAdviserId",paramters.get("vcSenderSubId"));		//指令下达人员编号
		dataObj.set("investAdviserName",paramters.get("vcSenderSubName"));	//指令下达人员姓名
		dataObj.set("businclass",paramters.getString("vcBusinClass"));	//业务类别	 
		dataObj.set("purposetype",PURPOSETYPE);	//业务类别	 
		dataObj.set("processStatus",paramters.getString("processStatus"));	//业务类别	 
		
		String vcStockCode = paramters.getString("vcStockCode");//回购天数
		String reportCode = CJAPICommonUtil.queryReportCode(vcStockCode);
		if(reportCode == null){
			String repurchaseDaysMsg = CJAPIConstants.REPURCHASE_DAYS_MSG;//提示信息
			String errMsg = String.format(repurchaseDaysMsg,"vcStockCode");
			throw new AppException(CJAPIConstants.REPURCHASE_DAYS_CODE,errMsg);
		}else{
			dataObj.set("symbol",reportCode);	//证券申报代码	 
		}
		dataObj.setString("side","1");
		BigDecimal enOrderBalance = paramters.getBigDecimal("enOrderBalance");
		double investCountValue = StrUtil.toDouble(enOrderBalance);
		dataObj.set("investCount",investCountValue);	
		
		getCommonDataPropertyValue(paramters, paramVo, dataObj);
		
		return dataObj;
				
	}
	
	/**
	 * @Description 获取二级（银行间二级市场）债相关的信息
	 * @Author		liangjilong
	 * @Date		2016年12月1日 上午10:32:54
	 * @param 		vcBondCode债券编码
	 * @param 		vcBondName债券名称
	 * @return 		DataObject[] 返回类型
	 * @throws 		AppException 抛出的异常
	 */
	private static String getSecondMarketInfoByInvokeJQM(String vcBondCode,String vcBondName) throws AppException{
		String result = "";
		List<DataObject> stockInfoList = getStockInfoByInvokeJQM(vcBondCode,vcBondName);
		
		if(StrUtil.isNotBlank(stockInfoList)){
			//investProductInfo返回的结果是--->投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
			DataObject dataObject = stockInfoList.get(0);
			if(StrUtil.isNotEmpty(dataObject)){
				String investProductInfo = dataObject.getString("investProductInfo");
				if(!StringUtil.isBlank(investProductInfo)){
					String [] investProductInfos = investProductInfo.split(",");
					if(StrUtil.isNotEmpty(investProductInfos)){
						String stockCode = investProductInfos[0];//债券代码
						String markCode = investProductInfos[2];//交易市场编号
						String componentName = CJAPIConstants.JQM_CFJY_PRODUCT_PROCESS_COMPONENT_NAME;// 逻辑构件名称
						String operationName = CJAPIConstants.JQM_INVEST_PRODUCTINFO_LOGIC_METHOD;// 逻辑流名称
						ILogicComponent logicComponent = LogicComponentFactory.create(componentName);//调用机器猫程序
						Object[] object = new Object[2];// Object是用来存储方法的参数
						// 逻辑流的输入参数
						object[0] = markCode;
						object[1] = stockCode;
						try {
							//机器猫程序返回的结果是--->投资产品信息investProductInfo（债券代码,债券名称,交易市场编号,证券内码）
							Object obj= logicComponent.invoke(operationName, object)[0];//返回的是一个字符串
							if(StrUtil.isNotEmpty(obj)){
								result = (String)obj;//c_stock_type证券类别代码（债券类别代码）
							}
						} catch (Throwable e) {
							String error="调用"+CJAPIConstants.JQM_INVEST_PRODUCTINFO_LOGIC_METHOD+"逻辑流出现异常，异常信息为:"+e.getMessage();
							LogUtil.logError(error, e, new Object[]{});
							throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);//调用异常，不用返回具体信息
						}
					}
				}
			}
		}
		return result;
	}
	
	/**
	 * 
	 * @Description 通过债券代码或者债券名称获取债券信息
	 * @Author		liangjilong
	 * @Date		2016年12月1日 下午2:10:07
	 * @param 		vcBondCode	债券代码
	 * @param 		vcBondName 	债券名称
	 * @return 		void 返回类型
	 * @throws Throwable 
	 */
	@SuppressWarnings("all")
	public static List<DataObject> getStockInfoByInvokeJQM(String vcBondCode,String vcBondName) throws AppException{
		String componentName = CJAPIConstants.JQM_CFJY_PRODUCT_PROCESS_COMPONENT_NAME;// 逻辑构件名称
		String operationName = CJAPIConstants.JQM_INVEST_PRODUCTS_BYKEY_LOGIC_METHOD;// 逻辑流名称
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);//调用机器猫程序
		Object[] object = new Object[1];
		// 逻辑流的输入参数
		if(!StringUtil.isBlank(vcBondCode)){
			object[0] = vcBondCode;//债券代码	Y
		}else{
			object[0] = vcBondName; //债券名称	Y
		}
		List<DataObject> dataObjList = null;
		try {
			Object  data = logicComponent.invoke(operationName, object)[0];//把数据转换成机器猫识别的格式
			//返回的结果是--->投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
			if(StrUtil.isNotEmpty(data)){
				dataObjList=(List<DataObject>)data;//返回的是一个List数组investProducts
			}
		} catch (Throwable e) {
			String error="调用逻辑流"+CJAPIConstants.JQM_INVEST_PRODUCTS_BYKEY_LOGIC_METHOD+"出现异常，异常信息为:"+e.getMessage();
			LogUtil.logError(error, e, new Object[]{});
			throw new AppException(CJAPIConstants.ERROR_INVOKE,CJAPIConstants.ERROR_INVOKE_MSG);//调用异常，不用返回具体信息
		}
		return dataObjList;
	}
	
	/**
	 * @Description 根据origordId获取原来下达指令信息
	 * @Author		liangjilong
	 * @Date		2016年12月3日 上午9:40:30
	 * @param 		origordId 被修改指令的第三方指令编号
	 * @param 		entityName 动态实体名称（这样查询多张表字段都一样，可以减少命名SQL配置查询工作量）
	 * @param       isNeedParam是否参数(是/否)true/false
	 * @param 		isAdd是否为更新留痕 (true/false)
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("根据origordId获取原来下达指令信息")
	public static DataObject getOrderInfoByOrigordId(ObjectParamVo objectVo) throws AppException{ 
		DataObject paramters = objectVo.getParamters();
		String entityName = objectVo.getEntityName();
		String origordId =(String)paramters.get("vcOrigOrdId");//原指令Id
		String orderStatusValid = String.valueOf(CJAPIConstants.ORDER_STATUS_VALID);//订单交易状态
		String backStatusUnexecuted = String.valueOf(CJAPIConstants.BACK_STATUS_UNEXECUTED);//订单反馈状态
		String vals [] = new String [] {origordId,orderStatusValid, backStatusUnexecuted};
		String keys [] = new String [] {"vcClordId","vcOrderStatus","vcBackStatus"};
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,new String[]{"=","=","="});
		paramters = queryOrderInfoByCriteriaEntity(objectVo, paramters, entityName, criteriaType);
		return paramters;
	}
	@Bizlet("根据origordId获取原来下达指令信息")
	public static DataObject getOrderInfoByVcOrigordId(ObjectParamVo objectVo) throws AppException{ 
		DataObject paramters = objectVo.getParamters();
		String entityName = objectVo.getEntityName();
		String origordId =(String)paramters.get("vcOrigOrdId");//原指令Id
		String backStatusUnexecuted = String.valueOf(CJAPIConstants.BACK_STATUS_UNEXECUTED);//订单反馈状态
		String vals [] = new String [] {origordId, backStatusUnexecuted};
		String keys [] = new String [] {"vcClordId","vcBackStatus"};
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,new String[]{"=","="});
		paramters = queryOrderInfoByCriteriaEntity(objectVo, paramters, entityName, criteriaType);
		return paramters;
	}
	
	/**
	 * @Description 根据origordId获取原来下达指令信息（无vcBackStatus状态）
	 * @Author		liangjilong
	 * @Date		2017年2月8日 下午2:29:11
	 * @param objectVo
	 * @return
	 * @throws AppException 		参数
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("根据origordId获取原来下达指令信息")
	public static DataObject getOrderInfoByOrigOrdId(ObjectParamVo objectVo) throws AppException{ 
		DataObject paramters = objectVo.getParamters();
		String entityName = objectVo.getEntityName();
		String origordId =(String)paramters.get("vcOrigOrdId");//原指令Id
		String orderStatusValid = String.valueOf(CJAPIConstants.ORDER_STATUS_VALID);//订单交易状态
		String vals [] = new String [] {origordId,orderStatusValid};
		String keys [] = new String [] {"vcClordId","vcOrderStatus"};
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,new String[]{"=","="});
		paramters = queryOrderInfoByCriteriaEntity(objectVo, paramters,entityName, criteriaType);
		return paramters;
	}
	/**
	 * @Description 根据VcOrigOrdId获取原来下达指令信息
	 * @Author		liangjilong
	 * @Date		2017年3月16日 下午1:08:36
	 * @param objectVo
	 * @return
	 * @throws AppException 		参数
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("根据VcOrigOrdId获取原来下达指令信息")
	public static DataObject getOrderInfoByVcOrigOrdId(ObjectParamVo objectVo) throws AppException{ 
		DataObject paramters = objectVo.getParamters();
		String entityName = objectVo.getEntityName();
		String origordId =(String)paramters.get("vcOrigOrdId");//原指令Id
		String vals [] = new String [] {origordId};
		String keys [] = new String [] {"vcClordId"};
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,new String[]{"="});
		paramters = queryOrderInfoByCriteriaEntity(objectVo, paramters,entityName, criteriaType);
		return paramters;
	}

	/**
	 * @Description 查询实体对象信息
	 * @Author		liangjilong
	 * @Date		2017年2月8日 下午2:28:51
	 * @param objectVo
	 * @param paramters
	 * @param entityName
	 * @param criteriaType
	 * @return 		参数
	 * @return 		DataObject 返回类型
	 */
	private static DataObject queryOrderInfoByCriteriaEntity(ObjectParamVo objectVo, DataObject paramters, String entityName,
			CriteriaType criteriaType) {
		//2、查询
		DataObject[] queryList = DatabaseUtil.queryEntitiesByCriteriaEntity(CJAPIConstants.DS_DEFAULT, criteriaType);
		if(StrUtil.isNotEmpty(queryList)){
			DataObject dataObject = queryList[0];
			if(objectVo.isAdd()){
				paramters.set("enProcessId",dataObject.get("enProcessId"));//获取JQM指令流程Id
			}			
			getNewOrderInfo(paramters, dataObject,objectVo.getIsNeedParam(),entityName);//获取新指令信息
			getNeedPrimaryKeyId(objectVo.getIsNeedParam(), entityName,paramters, dataObject);//获取主键Id
		}else{
			paramters = null;//查询不到给一个null，用于返回接口调用方处理信息
		}
		return paramters;
	}
 
	/**
	 * @Description 根据vcClordId检测是否存在订单
	 * @Author		liangjilong
	 * @Date		2017年1月6日 下午1:41:05
	 * @param objectVo
	 * @return
	 * @throws AppException 		参数
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("根据vcClordId检测是否存在订单")
	public synchronized static void checkExistOrderByClordId(ObjectParamVo objectVo)throws AppException{ 
		DataObject paramters = objectVo.getParamters();
		String entityName = objectVo.getEntityName();
		String vcClordId =(String)paramters.get("vcClordId");
		String vals [] = new String [] {vcClordId};
		String keys [] = new String [] {"vcClordId"};
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,new String[]{"="});
		//2、查询
		DataObject[] queryList = DatabaseUtil.queryEntitiesByCriteriaEntity(CJAPIConstants.DS_DEFAULT, criteriaType);
		if(StrUtil.isNotEmpty(queryList)){
			String infoMsg = "";
			if("0".equals(queryList[0].getString("vcOrderStatus"))||"3".equals(queryList[0].getString("vcOrderStatus"))){
				infoMsg = String.format(CJAPIConstants.STATUS_ORDER_EXIST_MSG,"vcClordId等于"+vcClordId);
				LogUtil.logError(infoMsg, null);
				throw new AppException(CJAPIConstants.STATUS_ORDER_EXIST_CODE, infoMsg);
			}
			infoMsg =String.format(CJAPIConstants.STATUS_ORDER_EXIST_MSG_WHEN_INVALID,"vcClordId等于"+vcClordId);
			LogUtil.logError(infoMsg, null);
			throw new AppException(CJAPIConstants.STATUS_ORDER_EXIST_CODE_WHEN_INVALID, infoMsg);
		}
	}
	/**
	 * @Description 是否需要主键Id
	 * @Author		liangjilong
	 * @Date		2016年12月20日 下午3:45:09
	 * @param 		isNeedParam-(isNeedKey)
	 * @param 		entityName动态实体
	 * @param 		paramters 新DataObject
	 * @param 		dataObject 数据库查询处理的实体
	 */
	private static void getNeedPrimaryKeyId(boolean isNeedKey,String entityName, DataObject paramters,DataObject dataObject) {
		/**是否需要动态处理主键用来更新 @Date:2016-12-09*/
		if(isNeedKey){
			if(entityName==CJAPIConstants.PRIMARK_MARKET_ENTITY_NAME){
				paramters.set("lPrimaryMarkeId", dataObject.get("lPrimaryMarkeId"));
			}else if(entityName==CJAPIConstants.BANK_SECOND_MARKET_ENTITY_NAME){
				paramters.set("lBankSecondMarketId", dataObject.get("lBankSecondMarketId"));
			}else if(entityName==CJAPIConstants.BANK_PLEDGE_REPO_ENTITY_NAME){
				paramters.set("lBankPledgeRepoId", dataObject.get("lBankPledgeRepoId"));
			}else if(entityName==CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME){
				paramters.set("lExchangeSecondMarketId", dataObject.get("lExchangeSecondMarketId"));
			}else if(entityName==CJAPIConstants.EXCHANGE_PLEDGE_REPO_ENTITY_NAME){
				paramters.set("lExchangePledgeRepoId", dataObject.get("lExchangePledgeRepoId"));
			}
		}
	}
	/**
	 * 获取 (产品代码, 产品名称, 组合编号, 组合名称, 债券名称, 债券代码,投资类型,委托方向,币种,机器猫指令Id)
	 * 有些值不需要的，所以根据原指令Id查询获取dataObject对象里面查询出来的信息，并且DataObject支持实体模型
	 * 动态添加字段，即使paramters对象里面没有的key都作为临时变量，如果在命名sql里面查询一个表的不存在的字段就会报异常.
	 * @Author		liangjilong
	 * @Date		2016年12月20日 下午3:43:02
	 * @param 		paramters
	 * @param 		dataObject
	 * @param 		isNeedParam 是否需要的参数
	 */
	private static void getNewOrderInfo(DataObject paramters, DataObject dataObject,boolean isNeedParam , String entityName) {
		paramters.set("vcProductCode",dataObject.get("vcProductCode"));//
		paramters.set("vcProductName",dataObject.get("vcProductName"));//
		paramters.set("vcCombiNo",dataObject.get("vcCombiNo"));//
		paramters.set("vcCombiName",dataObject.get("vcCombiName"));//
		paramters.set("vcBondName",dataObject.get("vcBondName"));//
		paramters.set("vcBondCode",dataObject.get("vcBondCode"));//
		paramters.set("vcStockCode",dataObject.get("vcStockCode"));//
		paramters.set("vcInvestType",dataObject.get("vcInvestType"));//
		paramters.set("vcBusinClass",dataObject.get("vcBusinClass"));//
		paramters.set("vcBusinType",dataObject.get("vcBusinType"));//
		paramters.set("vcExDestination",dataObject.get("vcExDestination"));
		paramters.set("vcCurrency",dataObject.get("vcCurrency"));//
		paramters.set("vcFirstClordId",dataObject.get("vcFirstClordId"));//
		paramters.set("vcInvestNo",dataObject.get("vcInvestNo"));//
		paramters.set("vcOrderStatus",dataObject.get("vcOrderStatus"));//
		if(entityName.equalsIgnoreCase(CJAPIConstants.BANK_SECOND_MARKET_ENTITY_NAME) || 
				entityName.equalsIgnoreCase(CJAPIConstants.EXCHANGE_SECOND_ENTITY_NAME)){
			paramters.set("vcBondCodeExternal",dataObject.get("vcBondCodeExternal"));
		}
		if(isNeedParam){
			paramters.set("vcSenderSubId",dataObject.get("vcSenderSubId"));//
			paramters.set("vcSenderSubName",dataObject.get("vcSenderSubName"));//
			paramters.set("vcOrderProcess",dataObject.get("vcOrderProcess"));//
		}
	}

	/**
	 * @Description 处理返回参数信息
	 * @Author		liangjilong
	 * @Date		2016年12月5日 下午6:46:11
	 * @param 		paramters数据参数对象
	 * @param 		result返回的结果
	 * @param 		retType返回的结果类型（add/update）true/false
	 * @throws AppException 		参数
	 * @return 		boolean 返回类型
	 */
	@SuppressWarnings("all")
	public static boolean saveOrUpdateRetParamInfo(DataObject paramters, Object[] result,boolean retType) throws AppException {
		boolean flag;
		HashMap jqmRetMap =(HashMap) result[0];// 机器猫逻辑流返回的参数的结果是HashMap的就可以这样转换
		if (jqmRetMap!=null && jqmRetMap.containsKey("returnCode")
				&& "0".equals(jqmRetMap.get("returnCode"))) {
			Object processId = jqmRetMap.get("processId");
			if(StrUtil.isNotEmpty(processId)){
				paramters.set("enProcessId", processId);//机器猫指令订单主键Id
			}
			paramters.set("vcInvestNo", String.valueOf(jqmRetMap.get("investNo")));//投资编号
			paramters.set("vcOrderStatus", CJAPIConstants.STATUS_JQM_ORDER_SUCESS);
			flag = true;//下单成功
		} else {
			flag = false;//下单失败
			paramters.set("vcOrderStatus", CJAPIConstants.STATUS_JQM_ORDER_ERROR);
			if(retType){
				throw new AppException(CJAPIConstants.STATUS_JQM_ORDER_ERROR, CJAPIConstants.STATUS_JQM_ORDER_ERROR_MSG);
			}else{
				throw new AppException(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_ERROR, CJAPIConstants.STATUS_JQM_MODIFY_ORDER_ERROR_MSG);
			}
		}
		return flag;
	}
	
	/**
	 * @Description 检测是否存在当前推送系统人员姓名
	 * @Author		liangjilong
	 * @Date		2016年12月6日 下午7:16:21
	 * @param 		vcSenderSubId当前推送系统人员姓名
	 * @param 		isCheck(true/false)扩展值，是否检测由人员姓名,true代表检测,false代表不检测
	 * @return 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	public  static Map<String, Object> checkIsExistOperator(String vcSenderSubId,boolean isCheck) throws AppException{
		Map<String, Object> retMap = new HashMap<String, Object>();
		if(isCheck){
			String operatorId = CJAPICommonUtil.getOperatorId(vcSenderSubId);
			if(StringUtil.isBlank(operatorId)){
				retMap.put("vcRetCode", CJAPIConstants.ERROR_ORDER_SENDER);
				retMap.put("vcRetMsg", String.format(CJAPIConstants.ERROR_ORDER_SENDER_MSG, vcSenderSubId));
			}
		}
		return retMap;
	}
	
	/***
	 * @Description 更新被修改的指令状态
	 * @Author		jinwenxuan
	 * @Date		2016年12月15日 下午1:34:23
	 * @param tableName
	 * @param vcInstructionId
	 * @param vcOrderStatus
	 */
	@Bizlet("更新被修改的指令状态")
	public static void updateModifiedOrderStatus(String tableName,String vcInstructionId,int vcOrderStatus){
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		dataObj.set("tableName",tableName);
		dataObj.set("vcOrigordId",vcInstructionId);
		dataObj.set("vcOrderStatus",vcOrderStatus);
		DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT,UPDATE_MODIFIED_ORDER_STATUS_NSQL_ID, dataObj);
	}
	
	
	/**
	 * @Description 更新操作执行订单流程状态
	 * @Author		liangjilong
	 * @Date		2016年12月21日 下午3:20:25
	 * @param tableName
	 * @param processId 		参数
	 * @param processStatus 		参数
	 * @return 		void 返回类型
	 */
	@Bizlet("更新操作执行订单流程状态")
	public static void updateOrderProcessStatus(String tableName,Long processId,String processStatus){
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		dataObj.set("tableName",tableName);
		dataObj.set("processId",processId);
		dataObj.set("processStatus",processStatus);
		DatabaseExt.executeNamedSql(CJAPIConstants.DS_DEFAULT,UPDATE_ORDER_PROCESS_STATUS_NSQL_ID, dataObj);
	}
	
	
	/**
	 * @Description 根据流程Id进行查询原来指令信息
	 * @Author		liangjilong
	 * @Date		2016年12月21日 下午4:12:41
	 * @param entityName
	 * @param processId
	 * @param propertys查询的属性名称数组
	 * @return 		参数
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("查询原来指令信息")
	public static DataObject queryOrderInfoByProcessId(String entityName,Long processId,String [] propertKeys) throws AppException{
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, propertKeys,new String[]{String.valueOf(processId)},new String[]{"="});
		DataObject[] queryList = DatabaseUtil.queryEntitiesByCriteriaEntity(CJAPIConstants.DS_DEFAULT, criteriaType);
		if(StrUtil.isNotEmpty(queryList)) {
			return queryList[0];
		}
		return null;
	}
	
	/**
	 * @Description 获取原来Id的Msg信息
	 * @Author		liangjilong
	 * @Date		2017年3月14日 下午3:01:17
	 * @param paramters
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	public static String getOrigordIdMsg(DataObject paramters) {
		String msg = "";
		if(!StrUtil.isEmpty(paramters)){
			String origordId =(String)paramters.get("vcOrigOrdId");//原指令Id
			msg = String.format(CJAPIConstants.STATUS_JQM_MODIFY_ORDER_INFO_ERROR_MSG,origordId);
		}
		return msg;
	}
	
	/**
	 * 获取第三方代码
	 * @param vcBondCode
	 * @return
	 */
	@Bizlet("")
	public static String getBondCodeExternal(String vcBondCode){
		String vcBondCodeExternal = vcBondCode;
		
		if(vcBondCode.indexOf(".") > 0){
			vcBondCodeExternal = vcBondCode.substring(0, vcBondCode.indexOf("."));
		}
		
		return vcBondCodeExternal;
	}
}
 