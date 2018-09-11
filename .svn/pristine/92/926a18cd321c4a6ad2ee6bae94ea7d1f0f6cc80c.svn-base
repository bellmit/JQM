package com.cjhxfund.cjapi.feedback;

import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.cjapi.common.CJAPICommonUtil;
import com.cjhxfund.cjapi.common.JSONUtil;
import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;

import commonj.sdo.DataObject;

/**
 * 指令反馈
 * @author luwenxing
 * @date 2016-12-13 10:14:32
 *
 */
@Bizlet
public class OrderFeedback {
	/**
	 * 通过指令序列号获取指令的成交状态
	 * @param lDailyInstructionNo
	 * @return 指令的成交状态。找不到返回null
	 */
	public static String getInstrunctionStatus(Long lDailyInstructionNo){
		Object[] objs = DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(), 
				"com.cjhxfund.cjapi.OrderFeedbackns.queryEntrustExecuteStatus", lDailyInstructionNo);
		if (objs == null || objs.length ==0) {
			return null;
		}
		return (String)((DataObject)objs[0]).get("vcBackStatus");
	}
	
	/**
	 * 推送新债新到招行 
	 * @param lStockInvestNo 投资编号
	 * @return
	 */
	@Bizlet("新债推送")
	public static boolean stockPropelling(String lStockInvestNo){
		
		/*DataObject timeMap = (DataObject)com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "ATS_CJAPI_STOCK_ISSUE_OUT_TIME");
		//获取延迟时间
		String timeout = timeMap.getString("key");
		if("".equals(timeout) || timeout==null){
			timeout="1";//默认一分钟
		}
		try {
			//暂停执行
			Thread.sleep(1000*Integer.parseInt(timeout));
		} catch (Exception e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		}*/
		
		/*try{
		LogUtil.logInfo("正在调用新债推送方法.....，vcInvestNo：{0}",null,vcInvestNo);
		DataObject stockInfo = SaveStockIssueInfo.stockPropelling(vcInvestNo);//调用获取新债信息方法，将老机器猫的指令转换为新债表的数据 并返回。
		LogUtil.logInfo("获取到推送的新债信息，stockInfo：{0}",null,stockInfo);
		*/
		//查询新债信息
		DataObject stockInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsStockIssueInfo");
		stockInfo.setString("lStockInvestNo", lStockInvestNo);
		stockInfo.setString("lValidStatus", "0");
		int i=com.eos.foundation.database.DatabaseUtil.expandEntityByTemplate("default", stockInfo, stockInfo);
		if(i==0){
			LogUtil.logError("推送的新债状态（lValidStatus）的值非有效:lStockInvestNo：{0}", null, lStockInvestNo);
			return false;
		}
		//System.out.println(stockInfo.toString());
		//组装招行接口json
		Map<String,Object> parameters = new HashMap<String, Object>();
		
		parameters.put("cMarketNo", stockInfo.getString("cMarketNo"));//"String,交易场所"//根据登记托管机构转换
		parameters.put("vcPaymentPlace", stockInfo.getString("vcPaymentPlace"));//"String,登记托管机构"//交易场所：01.银行间;02.上交所固收平台;03.深交所综合协议平台|上交所大宗;04.中央结算公司;05.上海清算所
		parameters.put("vcInterCode", stockInfo.getString("vcInterCode"));//"String,债券内码"//自动生成
		parameters.put("vcStockCode", stockInfo.getString("vcStockCode"));//"String,债券代码"
		parameters.put("vcStockName", stockInfo.getString("vcStockName"));//"String,债券简称"//使用债券全称
		parameters.put("vcStockNameFull", stockInfo.getString("vcStockNameFull"));//"String,债券全称"
		parameters.put("vcStockType", stockInfo.getString("vcStockType"));//"String,债券类型"//债券种类:01.利率债;02.公司债;03.中票;04.短融;05.企业债;06.小公募;07.非公开企业债;08.PPN;09.ABS优先级;10.ABS劣后级;11.可转债;99.其他;
		parameters.put("enExistLimite", stockInfo.getInt("enExistLimite"));//"Number,发行期限(年)"
		parameters.put("enIssueBalance", stockInfo.getInt("enIssueBalance"));//" Number发行额度(亿)"
		parameters.put("cBondAppraise", stockInfo.getString("cBondAppraise"));//"String,债券评级"
		parameters.put("vcBondAppraiseOrgan",stockInfo.getString("vcBondAppraiseOrgan"));//"String,债券评级机构"
		
		parameters.put("lIssuerId",stockInfo.getString("lIssuerId"));//" Number,发行主体序号" //从发行主体表中获取，如果中文匹配不存在，则为0，多条取第一条
		parameters.put("vcIssuerName",stockInfo.getString("vcIssuerName"));//"String,发行主体名称"
		parameters.put("vcIssueProperty",stockInfo.getString("vcIssueProperty"));//"String,主体类型"
		parameters.put("cIssueAppraise",stockInfo.getString("cIssueAppraise"));//"String,主体评级"
		parameters.put("vcIssueAppraiseOrgan",stockInfo.getString("vcIssueAppraiseOrgan"));//"String,主体评级机构"
		parameters.put("vcIndustry",stockInfo.getString("vcIndustry"));//"String,所属行业"
		parameters.put("vcProvince",stockInfo.getString("vcProvince"));//"String,所属省份"
		parameters.put("lGuarantorId",stockInfo.getString("lGuarantorId"));//" Number,担保人序号"
		parameters.put("vcGuarantorName",stockInfo.getString("vcGuarantorName"));//"String,担保人名称"
		parameters.put("vcGuarantorSummary",stockInfo.getString("vcGuarantorSummary"));//"String,担保人简介"
		
		parameters.put("lIssuePostDate",DateUtil.getNumberDateStr(stockInfo.getString("lIssuePostDate")));//" Date,公告日期"
		parameters.put("lIssueBeginDate",DateUtil.getNumberDateStr(stockInfo.getString("lIssueBeginDate")));//" Date,发行日期"
		parameters.put("lPayDate",DateUtil.getNumberDateStr(stockInfo.getString("lPayDate")));//" Date,缴款日期"
		parameters.put("lPublishDate",DateUtil.getNumberDateStr(stockInfo.getString("lPublishDate")));//" Date,上市日期"
		parameters.put("lBegincalDate",DateUtil.getNumberDateStr(stockInfo.getString("lBegincalDate")));//" Date,起息日期"
		parameters.put("lEndincalDate",DateUtil.getNumberDateStr(stockInfo.getString("lEndincalDate")));//" Date,到期日期"
		parameters.put("cInterestType",stockInfo.getString("cInterestType"));//"String,利率类型" //还本方式 需要转换
		parameters.put("cPayInterestType",stockInfo.getString("cPayInterestType"));//"String,利息类型" //还本方式
		parameters.put("enPayInteval",stockInfo.getString("enPayInteval"));//" Number,次/年" //付息频率
		parameters.put("enFaceRate",stockInfo.getString("enFaceRate"));//" Number,票面利率"
		parameters.put("cBidType",stockInfo.getString("cBidType"));//"String,招标方式"
		parameters.put("cPayType",stockInfo.getString("cPayType"));//"String,缴款方式"//交易方式:1.缴款;2.DVP;
		parameters.put("vcSpecialText",stockInfo.getString("vcSpecialText"));//"String,特殊条款"
		parameters.put("vcMainUnderwriter",stockInfo.getString("vcMainUnderwriter"));//"String,主承销商"
		parameters.put("vcDeputyUnderwriter",stockInfo.getString("vcDeputyUnderwriter"));//"String,副主承销商"
		parameters.put("cUnderwriteType",stockInfo.getString("cUnderwriteType"));//"String,承销方式"
		parameters.put("vcGroupUnderwriter",stockInfo.getString("vcGroupUnderwriter"));//"String,承销团"
		parameters.put("lNextExerciseDate",DateUtil.getNumberDateStr(stockInfo.getString("lNextExerciseDate")));//" Date,下一行权日"
		
		parameters.put("cIsSmallRaised",stockInfo.getString("cIsSmallRaised"));//"String,是否小公募"
		parameters.put("cIsHaveSaleback",stockInfo.getString("cIsHaveSaleback"));//"String,是否具有回售权"
		parameters.put("dBidLimitTime",DateUtil.getNumberDateStr(stockInfo.getString("dBidLimitTime")));//" Date,投标截止时间"
		parameters.put("cIsHaveBuyback",stockInfo.getString("cIsHaveBuyback"));//"String,是否具有赎回权"
		parameters.put("enResaleYear",stockInfo.getString("enResaleYear"));//"Number,回售行权年"
		parameters.put("enRedemptionYear",stockInfo.getString("enRedemptionYear"));//"Number,赎回行权年"

		
		LogUtil.logInfo("中标确认新债推送,正在转换为json格式L:{0}", null, parameters.toString());
		String json = JSONUtil.mapToJson(parameters);//设置参数
		json="{\"request\":"+json+"}";
		LogUtil.logInfo("中标确认确认新债推送参数信息:{0}", null, json);
		
		/**
		 * String json = new Gson().toJson(cmparametersbMap);
		 * json = JSONUtil.jsonToJSON(json, "request");
		 * */
		
		try {
			//http://CMB.GMS.BT.BTTS.NBInfo NBInfoRecv
			String retMsg = CJAPICommonUtil.callCMBWebService(CJAPIConstants.BIDCFG_STOCK_INFO,"NBInfoRecv", "NBInfo", json);	 
			LogUtil.logInfo("中标确认新债推送回调招行返回信息:{0}", null, retMsg);
			return true;
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			LogUtil.logInfo("中标确认新债推送回失败....", e, json);
			e.printStackTrace();
		}
		
		return false;
	} 
	
	
}
