package com.cjhxfund.jy.ProductProcess;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import quickfix.Group;
import quickfix.field.Account;
import quickfix.field.NoAllocs;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.cjhxfund.foundation.fix.FixToMsgUtil;
import com.cjhxfund.foundation.fix.FixToUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.primeton.spring.support.DatabaseExt;

import commonj.sdo.DataObject;

/**
 * Fix消息发送公共类
 * @author huangmizhi
 * @date 2016-08-11 14:32:14
 */
@Bizlet("")
public class FixMsgSender {
	
	/** 轮询结束时间-执行老机器猫指令前台成交状态自动更新 */
	private static Date endTime_updateJQMRealDealStatus = null;
	
	/**
	 * 将指令对象转换为Fix报文发送对象（债券买卖_银行间）
	 * @param obj 将要发送的报文对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static Map<Object, Object> getFixSendMsgZQMM(DataObject obj){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		
		String processType = obj.getString("processType");//业务类别：01-债券买入;02-债券卖出;
		String busintype = "01".equals(processType)?"3":"4";//债券：3–债券买入；4–债券卖出；
		String side = "01".equals(processType)?"1":"2";//买卖方向，目前恒生系统对该Tag不处理：1-买入；2-卖出；
		String clearingSpeed = obj.getString("clearingSpeed");//清算速度：0-[T+0]；1-[T+1]；
		if("T+0".equalsIgnoreCase(clearingSpeed)){
			clearingSpeed = "0";
		}else if("T+1".equalsIgnoreCase(clearingSpeed)){
			clearingSpeed = "1";
		}
		String interestRateType = obj.getString("interestRateType");//收益率类型：01-到期；02-行权；
		if("01".equalsIgnoreCase(interestRateType)){//【只用于银行间业务】1-到期收益率；2-行权收益率；
			interestRateType = "1";
		}else if("02".equalsIgnoreCase(interestRateType)){
			interestRateType = "2";
		}
		
		//String sendersubid = FixToUtil.queryOperatorNo(obj.getString("combProductCode"), null);//根据产品代码获取指令下达人的操作员编号
		//String sendersubid = null;//根据业务需求，暂时指定为投资助理“张贺章-1093”，从系统参数获取；
		//当实时查询O32系统获取投资经理报错时，从缓存中获取默认投资经理
		//if(StringUtils.isBlank(sendersubid)){
		//	sendersubid = ParamConfig.getValue(FixToUtil.ZHFWPT_DEFAULT_SENDERSUBID);
		//}
		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		//String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("combProductCode"));
		String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("combProductCode"),obj.getString("investManagerName"));
		
		sendMsg.setString("vcBusinclass", obj.getString("businclass"));//【前端设置】业务类别 2-银行间二级市场业务
		sendMsg.setString("vcInstructionlevel", obj.getString("instructionlevel"));//【前端设置】指令操作级别：0无；1快速；2一般；3慢速；数据字典40345项
		sendMsg.setString("vcBondsettletype", obj.getString("bondsettletype"));//【前端设置】结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户；
		sendMsg.setString("vcBondsettletype2", obj.getString("bondsettletype2"));//【前端设置】【只用于银行间回购】到期结算方式：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户；
		sendMsg.setString("vcInvesttype", obj.getString("investtype"));//【前端设置】 投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易，具体取值和O3保持一致。
		sendMsg.setString("vcOrdtype", obj.getString("ordtype"));  //【前端设置】 价格模式：1 - 市价（表示不限制委托价格，在涨跌停范围内即可）；2 - 限价（表示限制委托价格，买入不高于，卖出不低于）；
		sendMsg.setString("vcExdestination", obj.getString("exdestination"));//【前端设置】 交易市场：OTC-场外；
		sendMsg.setString("vcJudgeavailable", obj.getString("judgeavailable"));//【前端设置】判断可用（风控）：0-不判；1-判；
		sendMsg.setString("vcJudgerisk", obj.getString("judgerisk"));//【前端设置】判断风控：0-不判；1-判；
		
		sendMsg.setString("vcMsgtype", obj.getString("msgtype"));//业务类型：D-指令下达； G-指令修改；F-指令撤销；H-指令查询；
		sendMsg.setString("vcSendersubid", sendersubid);//指令下达人的操作员编号
		sendMsg.setString("vcClordid", obj.getString("clordid"));//第三方系统指令编号
		sendMsg.setString("vcOrigordid", obj.getString("origordid"));//被修改的第三方编号
		sendMsg.setString("vcListid", obj.getString("origordid"));//要撤销的指令的第三方指令编号
		sendMsg.setString("vcBusintype",  busintype);//指令修改-委托方向
		sendMsg.setString("vcSide", side);//买卖方向
		sendMsg.setString("vcAccount", obj.getString("vcCombiNo"));//恒生系统组合编号
		sendMsg.setString("vcSymbol", obj.getString("investProductCode"));//证券申报代码  在债券买卖业务中为证券代码
		sendMsg.setString("vcSecurityid", obj.getString("investProductCode"));//证券申报代码 在债券买卖业务中为证券代码
		sendMsg.setString("vcPrice", obj.getString("netPrice"));//指令价格，取机器猫净价
		sendMsg.setString("vcOrderqty", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("investCount"))*10000/100));//指令数量(张)，机器猫前端页面单位为万元，所以需要乘以10000(元)，又因100元/张，所以再需要除以100.
		sendMsg.setString("vcCashorderqty", obj.getString("cashorderqty"));//指令金额
		sendMsg.setString("vcTimeinforce", "6");  //指令有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效；
		sendMsg.setString("vcTransacttime", obj.getString("transacttime"));//订单发起时间
		sendMsg.setString("vcDirectinsteadoperator", obj.getString("directinsteadoperator"));//代下达人编号
		sendMsg.setString("vcInstructiontype", obj.getString("instructiontype"));//指令类型：1-个股；缺省1-个股；
		sendMsg.setString("vcText", obj.getString("text"));//指令备注
		sendMsg.setString("vcSettltype", clearingSpeed);//清算速度
		sendMsg.setString("vcInterest", obj.getString("interest"));//应计利息
		sendMsg.setString("vcYtm", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("interestRate"))/100));//债券收益率
		sendMsg.setString("vcYieldratiotype", interestRateType);//债券收益率类型【只用于银行间业务】1-到期收益率；2-行权收益率；
		sendMsg.setString("vcTraderival", obj.getString("traderival"));//交易对手编号
		sendMsg.setString("vcTargetsubid", obj.getString("targetsubid"));//交易对手编号
		sendMsg.setString("vcRivaltraderid", obj.getString("rivaltraderid"));//对方交易员编号
		sendMsg.setString("vcRivalaccount", obj.getString("rivalaccount"));//对方银行帐户编号
		sendMsg.setString("vcCleartype", obj.getString("cleartype"));//【只用于银行间债券】清算类型：1-	全额结算；2-净额结算；缺省为1，取自数据字典60151-银行间指令清算类型
		if(obj.getDate("processDate") != null){
			sendMsg.setString("vcBegindate", DateUtil.format(obj.getDate("processDate"), DateUtil.YMD_NUMBER));//指令有效开始日期
		}
		if(obj.getDate("expiredate") != null){
			sendMsg.setString("vcExpiredate", DateUtil.format(obj.getDate("expiredate"), DateUtil.YMD_NUMBER));//指令有效结束日期
		}
		sendMsg.setString("vcFutsettdate", DateUtil.getCalculateTradeDay(null, sendMsg.getString("vcBegindate"), null, Integer.getInteger(clearingSpeed)));//首次交割日
		sendMsg.setString("lInstructionId", obj.getString("processId"));//主表主键ID
		sendMsg.setString("lInstructionNo", obj.getString("investProductNum"));//唯一编码
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		insertList.add(sendMsg);
		
		map.put("sendMsg", sendMsg);
		map.put("groupList", null);
		map.put("bondsList", null);
		map.put("insertList", insertList);
		return map;
	}
	
	/**
	 * 将指令对象转换为Fix报文发送对象（正逆回购_质押式）
	 * @param obj 将要发送的报文对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static Map<Object, Object> getFixSendMsgZNHGZYS(DataObject obj){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();//重复组债券信息对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		
		String processType = obj.getString("processType");//业务类别_质押式回购：03-质押式正回购；04-质押式逆回购；
		String busintype = "03".equals(processType)?"5":"6";//回购：5–融资回购；6–融券回购；
		String side = "03".equals(processType)?"1":"2";//买卖方向，目前恒生系统对该Tag不处理：1-买入；2-卖出；
		String clearingSpeed = obj.getString("clearingSpeed");//清算速度：0-[T+0]；1-[T+1]；
		if("T+0".equalsIgnoreCase(clearingSpeed)){
			clearingSpeed = "0";
		}else if("T+1".equalsIgnoreCase(clearingSpeed)){
			clearingSpeed = "1";
		}
		//String sendersubid = FixToUtil.queryOperatorNo(obj.getString("combProductCode"), null);//根据产品代码获取指令下达人的操作员编号
		//String sendersubid = null;//根据业务需求，暂时指定为投资助理“张贺章-1093”，从系统参数获取；
		//当实时查询O32系统获取投资经理报错时，从缓存中获取默认投资经理
		//if(StringUtils.isBlank(sendersubid)){
		//	sendersubid = ParamConfig.getValue(FixToUtil.ZHFWPT_DEFAULT_SENDERSUBID);
		//}
		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		//String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("combProductCode"));
		String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("combProductCode"),obj.getString("investManagerName"));
		
		sendMsg.setString("vcBusinclass", obj.getString("businclass"));//【前端设置】业务类别 2-银行间二级市场业务
		sendMsg.setString("vcInstructionlevel", obj.getString("instructionlevel"));//【前端设置】指令操作级别：0无；1快速；2一般；3慢速；数据字典40345项
		sendMsg.setString("vcBondsettletype", obj.getString("bondsettletype"));//【前端设置】结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户；
		sendMsg.setString("vcBondsettletype2", obj.getString("bondsettletype2"));//【前端设置】【只用于银行间回购】到期结算方式：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户；
		sendMsg.setString("vcInvesttype", obj.getString("investtype"));//【前端设置】 投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易，具体取值和O3保持一致。
		sendMsg.setString("vcOrdtype", obj.getString("ordtype"));  //【前端设置】 价格模式：1 - 市价（表示不限制委托价格，在涨跌停范围内即可）；2 - 限价（表示限制委托价格，买入不高于，卖出不低于）；
		sendMsg.setString("vcExdestination", obj.getString("exdestination"));//【前端设置】 交易市场：OTC-场外；
		sendMsg.setString("vcPurposetype", obj.getString("purposetype"));//【前端设置】 回购用途类别：1：等期限套利；2：不等期限套利；3：短期资金运用；4：超配；5：放大；
		sendMsg.setString("vcJudgeavailable", obj.getString("judgeavailable"));//【前端设置】判断可用（风控）：0-不判；1-判；
		sendMsg.setString("vcJudgerisk", obj.getString("judgerisk"));//【前端设置】判断风控：0-不判；1-判；
		
		sendMsg.setString("vcMsgtype", obj.getString("msgtype"));//业务类型：D-指令下达； G-指令修改；F-指令撤销；H-指令查询；
		sendMsg.setString("vcSendersubid", sendersubid);//指令下达人的操作员编号
		sendMsg.setString("vcClordid", obj.getString("clordid"));//第三方编号
		sendMsg.setString("vcOrigordid", obj.getString("origordid"));//被修改的第三方编号
		sendMsg.setString("vcListid", obj.getString("origordid"));//要撤销的指令的第三方指令编号
		sendMsg.setString("vcBusintype",  busintype);//委托方向：银行间二级市场业务，债券：3 – 债券买入，4 – 债券卖出；回购：5 – 融资回购，6 – 融券回购
		sendMsg.setString("vcSide", side);//买卖方向，目前恒生系统对该Tag不处理，1 - 买入；2 - 卖出
		sendMsg.setString("vcAccount", obj.getString("vcCombiNo"));//恒生系统组合编号，指定指令下达到恒生的哪个组合下。（投资组合表：TCOMBI[VC_COMBI_NO]）
		sendMsg.setString("vcSymbol", obj.getString("symbol"));//证券申报代码
		sendMsg.setString("vcSecurityid", obj.getString("symbol"));//证券申报代码
		
		//sendMsg.setString("vcPrice", obj.getString("tranAmount"));//指令价格，取机器猫的“交易金额（万元）”????????????????????
		//sendMsg.setString("vcOrderqty", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("investCount"))*10000/100));//指令数量(张)，机器猫前端页面单位为万元，所以需要乘以10000(元)，又因100元/张，所以再需要除以100.
		sendMsg.setString("vcCashorderqty", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("tranAmount"))*10000));//指令金额
		sendMsg.setString("vcTimeinforce", "6");  //指令有效模式，默认为0-Day：0 – Day，当日有效；1 – GTC，一直有效，直到完成或撤销；6 – GTD，到指定日前有效；
		sendMsg.setString("vcTransacttime", obj.getString("transacttime"));//订单发起时间
		if(obj.getDate("processDate") != null){
			sendMsg.setString("vcBegindate", DateUtil.format(obj.getDate("processDate"), DateUtil.YMD_NUMBER));//指令有效开始日期
		}
		if(obj.getDate("expiredate") != null){
			sendMsg.setString("vcExpiredate", DateUtil.format(obj.getDate("expiredate"), DateUtil.YMD_NUMBER));//指令有效结束日期
		}
		sendMsg.setString("vcDirectinsteadoperator", obj.getString("directinsteadoperator"));//代下达人编号
		sendMsg.setString("vcInstructiontype", obj.getString("instructiontype"));//指令类型：1-个股；缺省1-个股；
		sendMsg.setString("vcText", obj.getString("text"));//指令备注
		sendMsg.setString("vcSettltype", clearingSpeed);//清算速度
		sendMsg.setString("vcInterest", obj.getString("interest"));//应计利息
		//sendMsg.setString("vcYtm", obj.getString("ytm"));//债券收益率
		//sendMsg.setString("vcYieldratiotype", obj.getString("yieldratiotype"));//债券收益率类型【只用于银行间业务】1-到期收益率；2-行权收益率；
		sendMsg.setString("vcTraderival", obj.getString("traderival"));//交易对手编号
		sendMsg.setString("vcTargetsubid", obj.getString("targetsubid"));//交易对手编号
		sendMsg.setString("vcRivaltraderid", obj.getString("rivaltraderid"));//对方交易员编号
		sendMsg.setString("vcRivalaccount", obj.getString("rivalaccount"));//对方银行帐户编号
		sendMsg.setString("vcCleartype", obj.getString("cleartype"));//【只用于银行间债券】清算类型：1-	全额结算；2-净额结算；缺省为1，取自数据字典60151-银行间指令清算类型
		sendMsg.setString("lInstructionId", obj.getString("processId"));//主表主键ID
		sendMsg.setString("lInstructionNo", obj.getString("investProductNum"));//唯一编码
		sendMsg.setString("vcFutsettdate", StrUtil.changeNull(obj.getString("firstSettlementDate")).replaceAll("-", ""));//首次交割日
		sendMsg.setString("vcFutsettdate2", StrUtil.changeNull(obj.getString("expiryDate")).replaceAll("-", ""));//到期交割日：0-表示取当天；
		//sendMsg.setString("vcReporate", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("tradingRate"))/100));//【只用于银行间债券、回购和存款】回购利率，回购业务必须填写，如回购利率3%时需填入0.03；存款和存款支取取的是存款利率,银行间债券买卖、回购和存款业务的指令状态、委托和成交数据需返回外，其它业务均不返回该字段。
		sendMsg.setString("vcReporate", "0");//因传入真实回购利率可能触发风控，逸雯建议先按市价传入。若该值为0时，则按市价传入回购利率。--by huangmizhi 2016.12.22
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		insertList.add(sendMsg);
		
		//获取将要发送报文对象的债券信息列表
		DataObject[] bonds = null;
		try {
			ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.jy.ProductProcess.JY_ZNHG");
			Object[] objArr = comp.invoke("JY_ZNHG_queryBondsByProcessId", new String[]{obj.getString("processId")});//调用逻辑流的方法
			if(objArr!=null && objArr.length>0){
				bonds =  (DataObject[]) objArr[0];
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		if(bonds!=null && bonds.length>0){
			DataObject bond = null;
			DataObject bean = null;
			Group group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 14000, 13211, 13212, 13213});//组装重复组数据
			groupList.add(group);
			
			List<DataObject> beanList = new ArrayList<DataObject>();
			for(int i=0; i<bonds.length; i++){
				bond = bonds[i];
				bean = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
				
				bean.setString("vcAccount", StringUtils.isNotBlank(bond.getString("vcCombiNo"))?bond.getString("vcCombiNo"):sendMsg.getString("vcAccount"));//恒生系统组合编号，指定指令下达到恒生的哪个组合下。若债券的组合编号为空，则取指令的组合编号
				bean.setString("vcInvesttype", StringUtils.isNotBlank(bond.getString("investtype"))?bond.getString("investtype"):sendMsg.getString("vcInvesttype"));//投资类型：1-可交易；2-持有到期；3-可供出售。若债券的投资类型为空，则取指令的投资类型
				bean.setString("vcPledgebond", bond.getString("bondCode"));//债券代码
				bean.setString("vcPledgeratio", String.valueOf(StrUtil.delThousandthEmptyTo0(bond.getString("conversionRatio"))/100));//质押比例，抵押的比例90％填0.9，机器猫前台单位为%，所以需除以100.
				bean.setString("vcPledgedqty", String.valueOf(StrUtil.delThousandthEmptyTo0Int(bond.getString("bondAmount"))*10000/100));//质押数量(张)，机器猫前端页面单位为万元，所以需要乘以10000(元)，又因100元/张，所以再需要除以100.
				bean.setString("lMsgId", sendMsg.getString("lMsgId"));
				bean.setDate("dCreated", DateUtil.getDate());
				
				//生成主键
				DatabaseExt.getPrimaryKey(bean);
				beanList.add(bean);
				insertList.add(bean);
			}
			bondsList.add(beanList);
		}
		
		map.put("sendMsg", sendMsg);
		map.put("groupList", groupList);
		map.put("bondsList", bondsList);
		map.put("insertList", insertList);
		return map;
	}
	
	/**
	 * 将回购指令对象转换为风控试算Fix报文发送对象（风控试算）
	 * @param obj 将要发送的报文对象
	 * @return
	 * @author liuyulong
	 */

	@Bizlet("")
	public static Map<Object, Object> riskControlMsgForPurchase(DataObject obj){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();//重复组债券信息对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		//String sendersubid = FixToUtil.queryOperatorNo(obj.getString("combProductCode"), null);//根据产品代码获取指令下达人的操作员编号
		//当实时查询O32系统获取投资经理报错时，从缓存中获取默认投资经理
		//if(StringUtils.isBlank(sendersubid)){
		//	sendersubid = ParamConfig.getValue(FixToUtil.ZHFWPT_DEFAULT_SENDERSUBID);
		//}
		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("combProductCode"));
		
		sendMsg.setString("vcMsgtype", "H");//35-消息类型
		sendMsg.setString("vcClordid", obj.getString("clordid"));//11:第三方编号 ,需生成一个
		sendMsg.setString("vcProcesstype", "4");//15999:4-风险试算
		sendMsg.setString("vcBusinclass", obj.getString("businclass"));//13000:2-银行间二级市场业务 A –开放式基金B-存款业务C-网下申购D-债券一级市场
		sendMsg.setString("vcInstructionno", "0");//41:指令下达时指令序号必须传入0，指令修改时传入具体的指令序号
		sendMsg.setString("vcMarketdate", DateUtil.format(obj.getDate("processDate"), DateUtil.YMD_NUMBER));//15203-起始日期：允许为空，若为空则取当天日期。存款支取传的是支取日期。
		sendMsg.setString("vcMarketenddate", DateUtil.format(obj.getDate("processDate"), DateUtil.YMD_NUMBER));//15204-结束日期：允许为空，若为空则取当天日期。存款和支取传的是到期日。
		sendMsg.setString("vcSendersubid", sendersubid);//50:指令下达人的操作员编号【定义在消息头header】
		sendMsg.setString("vcPurposetype", "1");//15400:用途类别
		sendMsg.setString("vcFutsettdate", DateUtil.format(obj.getDate("firstSettlementDate"), DateUtil.YMD_NUMBER));//64:首期交割日期
		sendMsg.setString("vcFutsettdate2", DateUtil.format(obj.getDate("expiryDate"), DateUtil.YMD_NUMBER));//193:到期交割日期
		
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		insertList.add(sendMsg);
		
		Group group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 55, 100, 13001, 14000, 38, 44, 152, 159, 40, 76, 13204, 14058});//组装重复组数据
		groupList.add(group);
		List<DataObject> beanList = new ArrayList<DataObject>();
		DataObject bean =DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
		Object[] bonds = (Object[]) obj.get("bonds");
		if(bonds.length > 0){
			bean = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
			bean.setString("vcAccount", obj.getString("vcCombiNo"));//1:恒生系统组合编号，指定指令下达到恒生的哪个组合下。若债券的组合编号为空，则取指令的组合编号
			bean.setString("vcSymbol", obj.getString("symbol"));//55-证券申报代码
			bean.setString("vcExdestination", obj.getString("exdestination"));//100-交易市场
			bean.setString("vcBusintype", obj.getString("businclass"));//13001-委托方向
			bean.setString("vcInvesttype", obj.getString("investtype"));//14000-投资类型
			Double tranAmount = StrUtil.delThousandthEmptyTo0(obj.getString("tranAmount"))*10000;//交易金额合计
			int vcOrderqty = (int) (tranAmount/100);
			System.out.println(tranAmount);
			System.out.println(vcOrderqty);
			System.out.println();
			bean.setString("vcOrderqty", String.valueOf(vcOrderqty));//38-指令数量
			bean.setString("vcPrice", "100");//44-指令价格
			bean.setString("vcCashorderqty", String.valueOf(tranAmount));//152-指令金额
			String checkMemo = "";
			for(int i=0 ; i < bonds.length; i++){
				@SuppressWarnings("rawtypes")
				Map bond = (Map) bonds[i];				
				//int bondAmount = Integer.parseInt((String) bond.get("bondAmount"))*10000;
				Double bondAmount = StrUtil.delThousandthEmptyTo0((String) bond.get("bondAmount"))*10000;//券面总额
				//int conversionRatio =  Integer.parseInt((String) bond.get("conversionRatio"));
				Double conversionRatio = StrUtil.delThousandthEmptyTo0((String) bond.get("conversionRatio"))/100;//质押比率
				int orderqty = (int) (bondAmount*conversionRatio/100);
				System.out.println(bondAmount);
				System.out.println(orderqty);
				System.out.println(bondAmount);
				checkMemo += obj.getString("vcCombiNo")+"|"+obj.getString("investtype")+"|"+bond.get("bondCode")+"|"+bond.get("conversionRatio")+"|"+orderqty;
				if(i != bonds.length-1){
					checkMemo += ";";
				}
			}
			bean.setString("vcInterest",  String.valueOf(obj.getDouble("tradingRate")/100)); //159-应计利息【只用于银行间债券和质押式回购】
			bean.setString("vcOrdtype", obj.getString("ordtype"));//40-证券控制类型
			bean.set("vcExecbroker", obj.getString("tradingOpponent"));//76-交易对手编号【只用于银行间债券、质押式回购和存款业务】
			bean.set("vcBondsettletype", obj.getString("bondsettletype"));//13204-结算方式【只用于银行间债券和质押式回购】
			bean.set("vcBondSettleType2", obj.getString("bondsettletype2"));//13208-【只用于银行间质押式回购】到期结算方式
			bean.setString("vcMortagageinfo", checkMemo);//14058-质押券信息
			
			bean.setString("lMsgId", sendMsg.getString("lMsgId"));
			bean.setDate("dCreated", DateUtil.getDate());
			DatabaseExt.getPrimaryKey(bean);
			beanList.add(bean);
			insertList.add(bean);
		}
		bondsList.add(beanList);

		map.put("sendMsg", sendMsg);
		map.put("groupList", groupList);
		map.put("bondsList", bondsList);
		map.put("insertList", insertList);
		return map;
	}
	
	/**
	 * 将买卖指令对象转换为风控试算Fix报文发送对象（风控试算）
	 * @param obj 将要发送的报文对象
	 * @return
	 * @author 
	 */

	@Bizlet("")
	public static Map<Object, Object> riskControlMsgForBond(DataObject obj){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();//重复组债券信息对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		
		//String sendersubid = FixToUtil.queryOperatorNo(obj.getString("combProductCode"), null);//根据产品代码获取指令下达人的操作员编号
		//当实时查询O32系统获取投资经理报错时，从缓存中获取默认投资经理
		//if(StringUtils.isBlank(sendersubid)){
		//	sendersubid = ParamConfig.getValue(FixToUtil.ZHFWPT_DEFAULT_SENDERSUBID);
		//}
		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("combProductCode"));
		
		sendMsg.setString("vcMsgtype", "H");//35-消息类型
		sendMsg.setString("vcClordid", obj.getString("clordid"));//11:第三方编号 ,需生成一个
		sendMsg.setString("vcProcesstype", "4");//15999:4-风险试算
		sendMsg.setString("vcBusinclass", obj.getString("businclass"));//13000:2-银行间二级市场业务 A –开放式基金B-存款业务C-网下申购D-债券一级市场
		sendMsg.setString("vcInstructionno", "0");//41:指令下达时指令序号必须传入0，指令修改时传入具体的指令序号
		if(obj.getDate("processDate") != null){
			sendMsg.setString("vcMarketdate", DateUtil.format(obj.getDate("processDate"), DateUtil.YMD_NUMBER));//15203-起始日期：允许为空，若为空则取当天日期。存款支取传的是支取日期。
		}
		if(obj.getDate("expiredate") != null){
			sendMsg.setString("vcMarketenddate", DateUtil.format(obj.getDate("expiredate"), DateUtil.YMD_NUMBER));//15204-结束日期：允许为空，若为空则取当天日期。存款和支取传的是到期日。
		}
		sendMsg.setString("vcSendersubid", sendersubid);//50:指令下达人的操作员编号【定义在消息头header】
		
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		
		Group group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 55, 100, 13001, 14000, 38, 44, 152, 76, 159, 40, 13204});//组装重复组数据
		groupList.add(group);
		
		List<DataObject> beanList = new ArrayList<DataObject>();
		DataObject bean = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
		bean.setString("vcAccount", obj.getString("vcCombiNo"));//1:恒生系统组合编号，指定指令下达到恒生的哪个组合下。若债券的组合编号为空，则取指令的组合编号
		bean.setString("vcSymbol", obj.getString("investProductCode"));//55-证券申报代码
		bean.setString("vcExdestination", obj.getString("exdestination"));//100-交易市场
		bean.setString("vcBusintype", obj.getString("businclass"));//13001-委托方向
		bean.setString("vcInvesttype", obj.getString("investtype"));//14000-投资类型
		bean.setString("vcOrderqty", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("investCount"))*10000/100));//38-指令数量
		bean.setString("vcPrice", obj.getString("netPrice"));//44-指令价格
		bean.setString("vcCashorderqty", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("investCount"))*10000));//152-指令金额
		bean.set("vcExecbroker", "21");//76-交易对手编号【只用于银行间债券、质押式回购和存款业务】
		bean.setString("vcInterest", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("interestRate"))/100));//159-应计利息【只用于银行间债券和质押式回购】
		bean.setString("vcOrdtype", obj.getString("ordtype"));//40-证券控制类型:1-金额控 、2-数量控、缺省按2-数量控
		bean.set("vcBondsettletype", obj.getString("bondsettletype"));//13204-结算方式【只用于银行间债券和质押式回购】
		
		bean.setString("lMsgId", sendMsg.getString("lMsgId"));
		bean.setDate("dCreated", DateUtil.getDate());

		//bean.setString("vcAdvancelimitflag", "");//13231-支取限制【只用于存款】
		//bean.setString("vcWithdrawtype", "");//13224-支取类型【只用于存款支取】
		//bean.setString("vcIssuedate", "");//13226-起息日【只用于协议存款和定期存款】
		//bean.setString("vcReporate", "");//13107-存款利率【只用于存款】
		//bean.set("vcEarnestBalance", "");//137-定金金额【只用于网下申购】

		DatabaseExt.getPrimaryKey(bean);
		insertList.add(sendMsg);
		insertList.add(bean);
		beanList.add(bean);
		bondsList.add(beanList);

		map.put("sendMsg", sendMsg);
		map.put("groupList", groupList);
		map.put("bondsList", bondsList);
		map.put("insertList", insertList);
		return map;
	}
	
	/**
	 * 根据Fix成交反馈报文更新债券买卖、正逆回购（质押式）前台成交状态
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void setDealBackStatus(){
		Connection conn = null;
		try {
			//获取默认数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			DataObject tempObject = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ExecutionEntity");
			List<DataObject> receiveMsgs = FixToMsgUtil.queryFixReceiveMsg(null, null, DateUtil.currentDateDefaultString()+" 00:00:00");//仅查询当天的成交
			if(receiveMsgs!=null && !receiveMsgs.isEmpty() && receiveMsgs.size()>0){
				for(int i=0; i<receiveMsgs.size(); i++){
					DataObject receiveMsg = receiveMsgs.get(i);
					//3-回馈tag15999=3（成交反馈）
					if("3".equals(receiveMsg.getString("VC_PROCETYPE"))){
						tempObject.set("vcMsgtype", receiveMsg.getString("VC_MSGTYPE"));
						tempObject.set("vcProcetype", receiveMsg.getString("VC_PROCETYPE"));
						tempObject.set("vcOrdstatus", receiveMsg.getString("VC_ORDSTATUS"));
						tempObject.set("vcExectype", receiveMsg.getString("VC_EXECTYPE"));
						DataObject statusObject = FixToMsgUtil.getExecutionReportStatus(tempObject);
						if(statusObject.getBoolean("isSuccess")){
							//A08-部分成交：35=8;15999=3;39=1;150=1;  A09-全部成交：35=8;15999=3;39=2;150=2;
							if("A08".equals(statusObject.getString("resultMsgType"))||"A09".equals(statusObject.getString("resultMsgType"))){
								List<DataObject> zqmms = ProductProcessUtil.getZqmmByClordid(conn, receiveMsg.getString("VC_CLORDID"));
								List<DataObject> zqhgs = ProductProcessUtil.getZnhgByClordid(conn, receiveMsg.getString("VC_CLORDID"));
								if(zqmms!=null && !zqmms.isEmpty() && zqmms.size()>0){
									for(int j=0; j<zqmms.size(); j++){
										DataObject zqmm = zqmms.get(j);
										//买卖业务流程处理状态： 5-前台成交;  6-后台成交 ;
										if(!"5".equals(zqmm.getString("processStatus")) && !"6".equals(zqmm.getString("processStatus"))){
											zqmm.setInt("processStatus", Integer.valueOf("5"));
											zqmm.setString("sendId", "sysadmin");
											zqmm.setString("sendName", "sysadmin");
											zqmm.setDate("sendCd", new Date());
											ProductProcessUtil.updateZqmmByDealStatus(conn, zqmm);
										}
									}
								}
								
								if(zqhgs!=null && !zqhgs.isEmpty() && zqhgs.size()>0){
									for(int j=0; j<zqhgs.size(); j++){
										DataObject zqhg = zqhgs.get(j);
										//买卖业务流程处理状态： 5-前台成交;  6-后台成交 ;
										if(!"5".equals(zqhg.getString("processStatus")) && !"6".equals(zqhg.getString("processStatus"))){
											zqhg.setInt("processStatus", Integer.valueOf("5"));
											zqhg.setString("sendId", "sysadmin");
											zqhg.setString("sendName", "sysadmin");
											zqhg.setDate("sendCd", new Date());
											ProductProcessUtil.updateZnhgByDealStatus(conn, zqhg);
										}
									}
								}
							}
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
	}
	
	/**
	 * 执行老机器猫指令前台成交状态自动更新
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认3分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认17:00
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean updateJQMRealDealStatus(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  执行老机器猫指令前台成交状态自动更新开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = 3;
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FixMsgSender.updateJQMRealDealStatus fail: 轮询间隔时间格式错误，取默认3分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认3分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认17:00
			String date = DateUtil.currentDateDefaultString();
			endTime_updateJQMRealDealStatus = DateUtil.parse(date+" 17:00:00", DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					endTime_updateJQMRealDealStatus = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("FixMsgSender.updateJQMRealDealStatus fail: 轮询结束时间格式错误，取默认17:00！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认17:00！", null, new Object[]{});
			}
			
			//循环执行
			while(execute){
				System.out.println(DateUtil.currentDateTimeString()+"  updateJQMRealDealStatus begin ...");
				Long beforeTime=(new Date()).getTime();
				
				try {
					conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);//获取默认数据库连接
					
					DataObject tempObject = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ExecutionEntity");
					List<DataObject> receiveMsgs = FixToMsgUtil.queryFixReceiveMsg(null, null, DateUtil.currentDateDefaultString()+" 00:00:00");//仅查询当天的成交
					if(receiveMsgs!=null && !receiveMsgs.isEmpty() && receiveMsgs.size()>0){
						for(int i=0; i<receiveMsgs.size(); i++){
							DataObject receiveMsg = receiveMsgs.get(i);
							//3-回馈tag15999=3（成交反馈）
							if("3".equals(receiveMsg.getString("VC_PROCETYPE"))){
								tempObject.set("vcMsgtype", receiveMsg.getString("VC_MSGTYPE"));
								tempObject.set("vcProcetype", receiveMsg.getString("VC_PROCETYPE"));
								tempObject.set("vcOrdstatus", receiveMsg.getString("VC_ORDSTATUS"));
								tempObject.set("vcExectype", receiveMsg.getString("VC_EXECTYPE"));
								DataObject statusObject = FixToMsgUtil.getExecutionReportStatus(tempObject);
								if(statusObject.getBoolean("isSuccess")){
									//A08-部分成交：35=8;15999=3;39=1;150=1;  A09-全部成交：35=8;15999=3;39=2;150=2;
									if("A08".equals(statusObject.getString("resultMsgType"))||"A09".equals(statusObject.getString("resultMsgType"))){
										List<DataObject> zqmms = ProductProcessUtil.getZqmmByClordid(conn, receiveMsg.getString("VC_CLORDID"));
										List<DataObject> zqhgs = ProductProcessUtil.getZnhgByClordid(conn, receiveMsg.getString("VC_CLORDID"));
										if(zqmms!=null && !zqmms.isEmpty() && zqmms.size()>0){
											for(int j=0; j<zqmms.size(); j++){
												DataObject zqmm = zqmms.get(j);
												//买卖业务流程处理状态： 5-前台成交;  6-后台成交 ;
												if(!"5".equals(zqmm.getString("processStatus")) && !"6".equals(zqmm.getString("processStatus"))){
													zqmm.setInt("processStatus", Integer.valueOf("5"));
													zqmm.setString("sendId", "sysadmin");
													zqmm.setString("sendName", "sysadmin");
													zqmm.setDate("sendCd", new Date());
													ProductProcessUtil.updateZqmmByDealStatus(conn, zqmm);
												}
											}
										}
										
										if(zqhgs!=null && !zqhgs.isEmpty() && zqhgs.size()>0){
											for(int j=0; j<zqhgs.size(); j++){
												DataObject zqhg = zqhgs.get(j);
												//买卖业务流程处理状态： 5-前台成交;  6-后台成交 ;
												if(!"5".equals(zqhg.getString("processStatus")) && !"6".equals(zqhg.getString("processStatus"))){
													zqhg.setInt("processStatus", Integer.valueOf("5"));
													zqhg.setString("sendId", "sysadmin");
													zqhg.setString("sendName", "sysadmin");
													zqhg.setDate("sendCd", new Date());
													ProductProcessUtil.updateZnhgByDealStatus(conn, zqhg);
												}
											}
										}
									}
								}
							}
						}
					}
					
					Long afterTime=(new Date()).getTime();
					String className=Thread.currentThread().getStackTrace()[1].getClassName();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
					
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					JDBCUtil.releaseResource(conn, null, null);
				}
				System.out.println(DateUtil.currentDateTimeString()+"  updateJQMRealDealStatus end !!!");
				Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
				if(DateUtil.currentDate().after(endTime_updateJQMRealDealStatus)){//若当前系统时间大于轮询结束时间，则跳出循环
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
		System.out.println(DateUtil.currentDateTimeString()+"  执行老机器猫指令前台成交状态自动更新结束!!!");
		return isSuccess;
	}
	
	/**
	 * 关闭老机器猫指令前台成交状态自动更新功能
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static boolean closeUpdateJQMRealDealStatus(){
		endTime_updateJQMRealDealStatus = DateUtil.getNow();
		System.out.println(DateUtil.currentDateTimeString()+"  关闭老机器猫指令前台成交状态自动更新功能成功，结束时间："+endTime_updateJQMRealDealStatus);
		return true;
	}
	
	/**
	 * 根据第三方唯一编号查询反馈记录表判断该指令之前是否下达成功，下达成功返回true，否则返回false
	 * （A01-指令下达成功：35=8;15999=2;39=A;150=A;）
	 * @param clOrdId 第三方唯一编号
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean orderSendIsSuccess(String clOrdId){
		boolean isSuccess = false;
		//若第三方唯一编号为空，直接返回false
		if(StringUtils.isBlank(clOrdId)){
			return isSuccess;
		}
		//获取指令下达、指令修改、指令撤销等的反馈信息
		List<DataObject> list = FixToMsgUtil.queryFixReceiveMsg(clOrdId, null, null);
		if(!list.isEmpty() && list.size()>0){
			for(int i=0; i<list.size(); i++){
				DataObject obj = list.get(i);
				if(obj != null){
					obj.setString("vcMsgtype", obj.getString("VC_MSGTYPE"));//35
					obj.setString("vcProcetype", obj.getString("VC_PROCETYPE"));//15999
					obj.setString("vcOrdstatus", obj.getString("VC_ORDSTATUS"));//39
					obj.setString("vcExectype", obj.getString("VC_EXECTYPE"));//150
					
					//获取反馈报文状态等信息：Fix指令发送的报文“成功”或者“失败”的状态 && 指令反馈结果情况类型
					DataObject resultDataObject = FixToMsgUtil.getExecutionReportStatus(obj);
					//若该指令之前已下达成功（A01-指令下达成功：35=8;15999=2;39=A;150=A;），则返回true并调出循环
					if(resultDataObject!=null && resultDataObject.getBoolean("isSuccess") && "A01".equals(resultDataObject.getString("resultMsgType"))){
						isSuccess = true;
						break;
					}
				}
			}
		}
		return isSuccess;
	}
	
}
