/**
 * 
 */
package com.cjhxfund.ats.fm.fix;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import quickfix.Group;
import quickfix.field.Account;
import quickfix.field.NoAllocs;

import com.cjhxfund.ats.fm.comm.DateUtil;
import com.cjhxfund.ats.fm.comm.ParamConfig;
import com.cjhxfund.ats.fm.comm.StrUtil;
import com.cjhxfund.commonUtil.ProductUtil;
import com.cjhxfund.foundation.fix.FixToUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DatabaseExt;

import commonj.sdo.DataObject;

/**
 * @author 刘玉龙
 * @date 2016-08-18 10:51:54
 *
 */
@Bizlet("指令与报文间数据转换")
public class FixMsgTransform {
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
	 * 组装风控统一fix接口Fix报文对应的标准对象（sendMsg）
	 * @param obj 待发送的指令基础数据
	 * @param clordid 第三方编号,每次生产新的
	 * @param isStock 债券是否存在O32中
	 * @param timeParam 是否调用风控中心
	 * @return
	 * @author 
	 * @throws Exception 
	 */
	@Bizlet("")
	public static Map<Object, Object> getRiskFixSendMsgInfo(DataObject obj, String vcMsgtype,Boolean isStock,String clordid,String timeParam) throws Exception{
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.fix.customEntity.SendMessage");

		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		String vcSendersubid = FixToUtil.getO32OperatorNo(obj.getString("vcProductCode"));
		if("".equals(vcSendersubid)){
			LogUtil.logError("下单人员编号为空，风控接口组装参数失败！产品代码【"+obj.getString("vcProductCode")+"】", null, null);
			throw new Exception("风控接口组装参数失败！");
		}
		sendMsg.setString("vcClordid",clordid);
		sendMsg.setString("vcIsO32Order",obj.getString("lFixValidStatus")==null?"1":obj.getString("lFixValidStatus"));
		sendMsg.setString("vcCallPoint",obj.getString("sortno")==null?"1":obj.getString("sortno"));
		sendMsg.setString("vcBusinclass","D");
		
		obj.setString("vcOrigordId",obj.getString("vcClordId")==obj.getString("vcOrigordId")?"0":obj.getString("vcOrigordId"));
		
		sendMsg.setString("vcInstructionno",obj.getString("vcOrigordId")==null?"0":obj.getString("vcOrigordId"));//instructionNo
		if("".equals(obj.getString("dApplicationTime")) || obj.getString("dApplicationTime")==null){
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			//为获取当前系统时间
			obj.setString("dApplicationTime",df.format(new Date()));
		}
		sendMsg.setString("vcBegindate",getIntData(obj.getString("dApplicationTime"),"yyyyMMdd"));
		sendMsg.setString("vcExpiredate",getIntData(obj.getString("dApplicationTime"),"yyyyMMdd"));
		
		sendMsg.setString("vcMarketdate", getIntData(obj.getString("dApplicationTime"),"yyyyMMdd"));//15203 指令开始日期，此处为交易日期
		sendMsg.setString("vcMarketenddate",getIntData(obj.getString("dApplicationTime"),"yyyyMMdd"));//432 指令有效日期，由于指令为当日指令 此处为开始日期
		
		sendMsg.setString("vcSendersubid", vcSendersubid);
		sendMsg.setString("vcProcesstype","4");
		sendMsg.setString("vcMsgtype","H");
		sendMsg.setString("vcIsInquiry","0");
		//判断债券是否存在，如果不存在，只调用风控中心的【本地风控】，否则两者借调用
		if(isStock==false){
			sendMsg.setString("vcFixFlag","1");
		}
		
		//sendMsg.setString("vcLocalInstructionNo",obj.getString("lInvestNo"));
		
		
		Group group = null;
		group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 55, 100, 13001, 14000, 38, 44, 152, 40, 0});//组装重复组数据
		
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();
		List<DataObject> List = new ArrayList<DataObject>();
		DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendRepeatGroup");
		
		bond.setString("vcProductCode",obj.getString("vcProductCode"));
		bond.setString("lProductId",obj.getString("lProductId"));
		bond.setString("vcAccount",obj.getString("vcCombiNo"));
		bond.setString("vcSymbol",obj.getString("vcStockCode"));
		
		String vcExdestination = "OTC";
		String marketNo = obj.getString("cMarketNo");
		if("1".equals(marketNo)){
			vcExdestination = "SS";//上交所
		}else if("2".equals(marketNo)){
			vcExdestination = "SZ";//深交所
		}
		
		bond.setString("vcExdestination","1".equals(timeParam)?vcExdestination:marketNo);//根据风控调用走向
		bond.setString("vcStockType","2");//0其他，2债券，3股票，4基金
	    bond.setString("vcInvesttype","1");
	    bond.setString("vcBusintype","K");
	    bond.setString("vcOrdtype","2");//1-金额控，2-数量控
	    bond.setString("vcPrice",obj.getString("enInterestRate")==null?"100":obj.getString("enInterestRate"));//缴款去发行价格
		bond.setString("vcOrderqty",obj.getLong("enInvestBalance")*100+"");///enInvestBalance 投标金额    enBallotAmount 中签数量
		bond.setString("vcCashorderqty",obj.getLong("enInvestBalance")*10000+"");//EN_BALLOT_BALANCE中签金额  --EN_PAYMENT_MONEY缴款金额
		bond.setString("vcExecbroker",obj.getString("vcBusinessObject"));//	
		
		
		////enInvestBalance 当缴款信息不为空时，直接取缴款信息的 数量和金额 作为风控参数
		if(!"".equals(obj.getString("enPaymentMoney")) && obj.getString("enPaymentMoney")!=null){
			bond.setString("vcOrderqty",obj.getLong("enPayFaceValue")*100+"");//enPayFaceValue
			BigDecimal bd = new BigDecimal(String.valueOf(obj.getLong("enPaymentMoney")*10000));
			bond.setString("vcCashorderqty", bd.toPlainString());//缴款金额
			bond.setString("vcPrice",obj.getString("enBallotPrice"));
		}
		
		List.add(bond);
		bondsList.add(List);
		groupList.add(group);
		
		map.put("sendMsg", sendMsg);
		map.put("groupList", groupList);
		map.put("bondsList", bondsList);
		map.put("insertList", insertList);
		return map;
	}
	
	
	/**
	 * 将指令对象转换成与Fix报文对应的标准对象
	 * @param obj 待发送的指令基础数据
	 * @return
	 * @author liuyulong
	 */
	@Bizlet("")
	public static Map<Object, Object> getFixSendMsgApplyInst(DataObject obj, String vcMsgtype) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.fix.customEntity.SendMessage");

		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		//String vcSendersubid = FixToUtil.getO32OperatorNo(obj.getString("vcProductCode"));
		String vcSendersubid = FixToUtil.getO32OperatorNo(obj.getString("vcProductCode"),obj.getString("managerName"));
		
		String vcExdestination = "OTC";
		String marketNo = obj.getString("cMarketNo");
		if("1".equals(marketNo)){
			vcExdestination = "SS";//上交所
		}else if("2".equals(marketNo)){
			vcExdestination = "SZ";//深交所
		}
		sendMsg.setString("vcMsgtype", vcMsgtype);
		sendMsg.setString("vcSendersubid", vcSendersubid);
		
		sendMsg.setString("vcClordid", obj.getString("vcClordId"));
		if("G".equals(vcMsgtype)){
			sendMsg.setString("vcOrigordid", obj.getString("vcOrigordId"));
			//sendMsg.setString("vcListid", obj.getString("vcOrigordId"));
		}			
		sendMsg.setString("vcBusinclass", "D");//业务类别:D-债券一级市场
		sendMsg.setString("vcBusintype", "K");//委托方向:J-承销买入、 K-分销买入、L-分销卖出
		sendMsg.setString("vcAccount", obj.getString("vcCombiNo"));//来源于恒生系统的组合编号
		sendMsg.setString("vcSymbol", obj.getString("vcStockCode"));//证券申报代码
		sendMsg.setString("vcSecurityid", obj.getString("vcStockCode"));//等于证券申报代码（vcSymbol）
		sendMsg.setString("vcSide", "1");//1 - 买入、2 - 卖出
		sendMsg.setString("vcExdestination", vcExdestination);//交易市场：OTC 场外、SS 上交所、SZ 深交所
		sendMsg.setString("vcInvesttype", "1");//投资类型:
		sendMsg.setString("vcSettltype", "0");//清算速度:0-T+0
		sendMsg.setString("vcPrice", obj.getString("enBallotPrice"));//指令价格:大于0
		sendMsg.setString("vcOrdtype", "2");//价格模式：1 - 市价（表示不限制委托价格，在涨跌停范围内即可）；2 - 限价（表示限制委托价格，买入不高于，卖出不低于）；
		BigDecimal enBallotAmount = new BigDecimal(String.valueOf(obj.getDouble("enPayFaceValue")*100));  //计算指令数量，指令数量=缴款面值*100
		sendMsg.setString("vcOrderqty", enBallotAmount.toPlainString());//指令数量
		BigDecimal bd = new BigDecimal(String.valueOf(obj.getDouble("enPaymentMoney")*10000));
		sendMsg.setString("vcCashorderqty", bd.toPlainString());//缴款金额
		
		System.out.println("=================================================");
		System.out.println(bd.toPlainString());
		System.out.println("=================================================");
		sendMsg.setString("vcFee", "0");//手序费
		sendMsg.setString("vcTimeinforce", "0");//指令有效模式:0–Day 当日有效 。  1–GTC，一直有效直到完成或撤     。 6–GTD 到置顶日前有效
		//sendMsg.setString("vcBegindate", obj.getString("dPaymentDate"));//vcTimeinforce为0时可以不传
		//sendMsg.setString("vcExpiredate", obj.getString("dPaymentDate"));//当vcTimeinforce=6时，指定该指令的有效日期，其他无需指定
		if(StringUtils.isNotBlank(obj.getString("dPaymentDate"))){
			sendMsg.setString("vcFutsettdate", StrUtil.changeNull(obj.getString("dPaymentDate").replaceAll("-", "").split("T")[0]));//缴款截止日
		}
		sendMsg.setString("vcFeecalctype", "1");//手序费方式:1-手序费不另返、2-手序费另返、3-不计手序费
		sendMsg.setString("vcBondsettletype", "3");//结算方式:1-见款付券、2- 见券付款、3-券款对付、4-纯券过户
		sendMsg.setString("vcJudgeavailable", "1");//判断可用: 0-不判， 1-判
		sendMsg.setString("vcJudgerisk", "1");//判断风控 :0-不判， 1-判
		sendMsg.setString("vcInstructionlevel", "0");//指令操作级别：0无 1快速 2一般 3慢速；数据字典40345项
		//sendMsg.setString("vcDirectinsteadoperator", null);//代下达人编号：该字段允许为空、为空时取的是指令下达人（vcSendersubid）
		sendMsg.setString("vcInstructiontype", "1");//指令类型:1-个股；2-组合；3-个股批量；4-组合批量；个股：以多条个股形式下达；个股批量：同一个证券不同的组合；组合：重复组里同一个组合多个证券；组合批量：重复组里多个组合多个证券；缺省1-个股
		sendMsg.setString("vcText", obj.getString("vcRemarks"));//备注

		sendMsg.setString("lInstructionId", obj.get("lBizId").toString());//指令编号-主键ID
		sendMsg.setString("lInstructionNo", obj.get("lInvestNo").toString());//指令序号-业务ID
		sendMsg.setString("vcBizTblName", "t_ats_biz_process");//业务主表名，用于反馈回填状态
		sendMsg.setString("vcApvTblName", "t_ats_apply_inst");//业务子表名（指令表），用于反馈回填状态
		sendMsg.setString("vcStatusFldName", "l_fix_valid_status");//回馈修改字段，用于反馈回填状态
		sendMsg.setString("vcStatusValues", "3|4");//字段值域，用于反馈回填状态3表是成功回填的值，4代表失败时回填的值
		sendMsg.setString("vcKeyFldName", "vc_clord_id");//业务表中存放第三方指令编号的字段名称（指令表），用于反馈回填状态
		
		map.put("sendMsg", sendMsg);
		map.put("groupList", null);
		map.put("bondsList", null);
		map.put("insertList", insertList);
		return map;
	}
	
	
	
	/**
	 * 将指令对象转换为Fix报文发送对象（指令撤销[废弃]）
	 * @param obj 将要发送的报文对象【需求：】
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static Map<Object, Object> getFixOrderCancelRequest(DataObject obj){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<DataObject> insertList = new ArrayList<DataObject>();
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.fix.customEntity.SendMessage");//创建数据对象

		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		String vcSendersubid = FixToUtil.getO32OperatorNo(obj.getString("vcProductCode"));
		
		sendMsg.setString("vcMsgtype", obj.getString("vcMsgtype"));//业务类型：D-指令下达； G-指令修改；F-指令撤销；
		sendMsg.setString("vcSendersubid", vcSendersubid);//指令下达人的操作员编号
		sendMsg.setString("vcClordid", "F"+obj.getString("vcClordId"));//第三方系统指令编号
		sendMsg.setString("vcOrigordid", obj.getString("vcOrigordId"));//要撤销的指令的第三方指令编号
		sendMsg.setString("vcListid", obj.getString("vcOrigordId"));//要撤销的指令的第三方指令编号
		
		sendMsg.setDate("dCreated", DateUtil.getDate());//记录插入数据时间
		
		sendMsg.setString("lInstructionId", obj.getString("lApplyInstId"));//指令序号-主键ID
		sendMsg.setString("lInstructionNo", obj.getString("lInvestNo"));//指令编号-业务ID
		sendMsg.setString("vcBizTblName", "t_ats_biz_process");//业务主表名，用于反馈回填状态
		sendMsg.setString("vcApvTblName", "t_ats_apply_inst");//业务子表名（指令表），用于反馈回填状态
		sendMsg.setString("vcStatusFldName", "l_fix_valid_status");//回馈修改字段，用于反馈回填状态
		sendMsg.setString("vcKeyFldName", "3|4");//字段值域，用于反馈回填状态3表是成功回填的值，4代表失败时回填的值
		
		insertList.add(sendMsg);
		map.put("sendMsg", sendMsg);
		map.put("groupList", null);
		map.put("bondsList", null);
		map.put("insertList", insertList);
		
		return map;
	}
	
	/**
	 * 将指令对象转换为Fix报文发送对象（风控试算）
	 * @param obj 将要发送的报文对象
	 * @return 
	 * @author chenpeng--
	 */
	@Bizlet("")
	public static Map<Object,Object> getOrderStatusRequest(DataObject obj, String vcMsgtype){
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Group> groupList = new ArrayList<Group>();//重复组对象列表
		List<List<DataObject>> bondsList = new ArrayList<List<DataObject>>();//重复组债券信息对象列表
		List<DataObject> insertList = new ArrayList<DataObject>();//需插入指令表的数据对象列表
		DataObject sendMsg = DataObjectUtil.createDataObject("com.cjhxfund.foundation.fix.FixToDataset.TAtsFixSendMsg");//创建数据对象
		DatabaseExt.getPrimaryKey(sendMsg);//生成主键
		System.out.println(obj.getString("vcProductCode"));
		//String sendersubid = FixToUtil.queryOperatorNo(obj.getString("vcProductCode"), null);//根据产品代码获取指令下达人的操作员编号
		//当实时查询O32系统获取投资经理报错时，从缓存中获取默认投资经理
		//if(StringUtils.isBlank(sendersubid)){
		//	sendersubid = ParamConfig.getValue(FixToUtil.ZHFWPT_DEFAULT_SENDERSUBID);
		//}
		//获取FIX指令下达到O32的产品对应的操作员编号，先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
		String sendersubid = FixToUtil.getO32OperatorNo(obj.getString("vcProductCode"));
		String vcExdestination = "OTC";
		String marketNo = obj.getString("cMarketNo");
		if("1".equals(marketNo)){
			vcExdestination = "SS";//上交所
		}else if("2".equals(marketNo)){
			vcExdestination = "SZ";//深交所
		}
		
		sendMsg.setString("vcMsgtype", vcMsgtype);//35-消息类型
		sendMsg.setString("vcClordid", obj.getString("vcClordId"));//11:第三方编号 ,需生成一个
		sendMsg.setString("vcProcesstype", "4");//15999:4-风险试算
		sendMsg.setString("vcBusinclass", "D");//13000:2-银行间二级市场业务 A –开放式基金B-存款业务C-网下申购D-债券一级市场
		sendMsg.setString("vcInstructionNo", "0");//41:指令下达时指令序号必须传入0，指令修改时传入具体的指令序号
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
		bean.setString("vcSymbol", obj.getString("vcStockCode"));//55-证券申报代码
		bean.setString("vcExdestination", vcExdestination);//100-交易市场
		bean.setString("vcBusintype", obj.getString("vcEntrustdirection"));//13001-委托方向
		bean.setString("vcInvesttype", "1");//14000-投资类型 1-可交易
		bean.setString("vcOrderqty", "0");//38-指令数量
		bean.setString("vcPrice", obj.getString("enInterestRate"));//44-指令价格
		bean.setString("vcCashorderqty", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("enInvestBalance"))*10000));//152-指令金额
		//bean.set("vcExecbroker", "21");//76-交易对手编号【只用于银行间债券、质押式回购和存款业务】
		//bean.setString("vcInterest", String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("interestRate"))/100));//159-应计利息【只用于银行间债券和质押式回购】
		bean.setString("vcOrdtype", "1");//40-证券控制类型:1-金额控 、2-数量控、缺省按2-数量控
		//bean.set("vcBondsettletype", obj.getString("bondsettletype"));//13204-结算方式【只用于银行间债券和质押式回购】
		
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

}
