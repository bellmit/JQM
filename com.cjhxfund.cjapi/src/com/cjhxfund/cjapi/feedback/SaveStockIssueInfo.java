package com.cjhxfund.cjapi.feedback;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.cjhxfund.commonUtil.StrUtil;
import com.cjhxfund.commonUtil.commonUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;

import commonj.sdo.DataObject;

public class SaveStockIssueInfo {
	public static DataObject stockPropelling(String vcInvestNo){
			
			//String vcInvestNo = oldApplyInfo.getString("vcInvestNo");
			//获取老机器猫指令
			DataObject businessBone =  DataObjectUtil.createDataObject("com.cjhxfund.jy.process.FirstGradeBond.CfJyBusinessBoneTable");
			businessBone.setString("investproductnum", vcInvestNo);
			businessBone.setString("validStatus", "0");
			com.eos.foundation.database.DatabaseUtil.expandEntityByTemplate("default", businessBone, businessBone);
			//判断是否匹配成功
			boolean ishave = false;
			DataObject stockInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsStockIssueInfo");
			Object[] temp = null;
			String market = "6";
			//通过交易市场和债券代码去匹配新债信息表
			HashMap<String, String> paraMap = new HashMap<String, String>();
			if(StringUtils.isNotBlank(businessBone.getString("paymentplace"))){
				if("01,04,05".indexOf(businessBone.getString("paymentplace")) > -1){
					market = "5"; 
				}else if("02".equals(businessBone.getString("paymentplace"))){
					market = "1";
				}else if("03".equals(businessBone.getString("paymentplace"))){
					market = "2";
				}else{
					market = "6";
				}
				if(StringUtils.isNotBlank(businessBone.getString("investProductCode"))){
					paraMap.put("stockCode", businessBone.getString("investProductCode"));
					paraMap.put("market", market);
					//则不放入List中进行更新
					temp=DatabaseExt.queryByNamedSql("default", 
							"com.cjhxfund.cjapi.feedback.StockIssueInfo.getStockInfoByMarketAndStockCode", 
							paraMap);
					if(temp.length>0&&temp[0]!=null){
						stockInfo = (DataObject) temp[0];
						ishave = true;
						return stockInfo;
					}
				}
				//通过交易市场和债券名称。发行主体全称去匹配新债信息表
				if(!ishave){
					if(StringUtils.isNotBlank(businessBone.getString("investProductName")) && StringUtils.isNotBlank(businessBone.getString("ratingname"))){
						paraMap.put("market", market);
						paraMap.put("stockName", businessBone.getString("investProductName"));
						paraMap.put("issueName", businessBone.getString("ratingname"));
						
						//则不放入List中进行更新
						temp=DatabaseExt.queryByNamedSql("default", 
								"com.cjhxfund.cjapi.feedback.StockIssueInfo.getStockInfoByMarketAndStockName", 
								paraMap);
						if(temp.length>0&&temp[0]!=null){
							stockInfo = (DataObject) temp[0];
							ishave = true;
							return stockInfo;
						}
					}
				}
			}
			
			try {
				//找不到匹配数据，新增新债信息
				stockInfo.set("cMarketNo", market);//"String,交易场所"//根据登记托管机构转换
				String vcPaymentPlace = businessBone.getString("paymentplace");
				if(StringUtils.isNotBlank(vcPaymentPlace)){
					if("01".equals(vcPaymentPlace)){
						vcPaymentPlace = "99";
					}else if("02".equals(vcPaymentPlace)){
						vcPaymentPlace = "03";
					}else if("03".equals(vcPaymentPlace)){
						vcPaymentPlace = "04";
					}else if("04".equals(vcPaymentPlace)){
						vcPaymentPlace = "01";
					}else if("05".equals(vcPaymentPlace)){
						vcPaymentPlace = "02";
					}
				}
				stockInfo.set("vcPaymentPlace", vcPaymentPlace);
				//判空债券代码
				if(!StringUtils.isNotBlank(businessBone.getString("investProductCode"))){
					//生成债券代码
					String componentName = "com.cjhxfund.ats.fm.comm.common";//路径
					Object[] resultObjs = null;//bCode
					//调用生成代码的逻辑流
					Object[] params = new Object[1];
					params[0] = "";

					resultObjs = GenericBaseDaoSupport.invokeBizMethod(componentName, "getBondCode", params);
					if(resultObjs.length>0){
						String vcStockCode = (String) resultObjs[0];
						businessBone.setString("investProductCode", vcStockCode);
					}else{
						LogUtil.logError("新债转换方法，指令无债券代码，自动生成债券代码失败！",null, null);
						throw new Exception("新债转换方法，指令无债券代码，自动生成债券代码失败！");
					}
				}
				
				//生产债券内码
				Object[] feedbackParams = new Object[2];
				feedbackParams[0]=market;
				feedbackParams[1]=businessBone.getString("investProductCode");
				String componentName = "com.cjhxfund.ats.fm.comm.common";//路径
				Object[] resultObjs = null;
				resultObjs = GenericBaseDaoSupport.invokeBizMethod(componentName, "generateIntCode", feedbackParams);
				String vcInterCode = null;
				if(resultObjs != null){
					vcInterCode = (String) resultObjs[0];
					stockInfo.set("vcInterCode", resultObjs[0]);//"String,债券内码"//自动生成  lStockInvestNo
				}else{
					throw new Exception("新债转换方法，生成债券内码失败！");
				}
				
				String stockcode =  businessBone.getString("investProductCode");
				if(StringUtils.isNotBlank(stockcode)){
					if(stockcode.indexOf(".") > -1){
						stockcode = stockcode.substring(stockcode.indexOf("."), stockcode.length());
					}
				}else{
					stockcode = commonUtil.getStockCode(vcInterCode);
				}
				stockInfo.set("vcStockCode", stockcode);//"String,债券代码"
				stockInfo.set("vcStockName", businessBone.getString("investProductName"));//"String,债券简称"//使用债券全称
				stockInfo.set("vcStockNameFull", businessBone.getString("investProductName"));//"String,债券全称"
				String vcStockType = businessBone.getString("investcategory");
				if(StringUtils.isNotBlank(vcStockType)){		
					if("01".equals(vcStockType)){ 
						vcStockType = "0";
					}else if("02".equals(vcStockType)){
						vcStockType = "G2";
					}else if("03".equals(vcStockType)){
						vcStockType = "H";
					}else if("04".equals(vcStockType)){
						vcStockType = "I";
					}else if("05".equals(vcStockType)){
						vcStockType = "F";
					}else if("06".equals(vcStockType)){
						vcStockType = "G";
					}else if("07".equals(vcStockType)){
						vcStockType = "G2";
					}else if("08".equals(vcStockType)){
						vcStockType = "J";
					}else if("09".equals(vcStockType)){
						vcStockType = "M";
					}else if("10".equals(vcStockType)){
						vcStockType = "M";
					}else if("11".equals(vcStockType)){
						vcStockType = "O";
					}else if("12".equals(vcStockType)){
						vcStockType = "B";
					}else if("13".equals(vcStockType)){
						vcStockType = "E";
					}else if("14".equals(vcStockType)){
						vcStockType = "D";
					}else if("15".equals(vcStockType)){
						vcStockType = "E";
					}
				}else{
					vcStockType = "0";
				}
				stockInfo.set("vcStockType", vcStockType);//"String,债券类型"//债券种类:01.利率债;02.公司债;03.中票;04.短融;05.企业债;06.小公募;07.非公开企业债;08.PPN;09.ABS优先级;10.ABS劣后级;11.可转债;99.其他;
				
				if(businessBone.getString("categorydate")!=null && businessBone.getString("categorydate")!=""){
					stockInfo.setBigDecimal("enExistLimite", new BigDecimal(businessBone.getString("categorydate")));//"Number,发行期限(年)"
				}else{
					stockInfo.setBigDecimal("enExistLimite", new BigDecimal(0));//"Number,发行期限(年)"
				}
				
				
				if(businessBone.getString("issueSize")!=null && businessBone.getString("issueSize")!=""){
					stockInfo.setBigDecimal("enIssueBalance", new BigDecimal(StrUtil.delThousandthEmptyTo0(businessBone.getString("issueSize"))).divide(new BigDecimal(10000),8,2));//" Number发行额度(亿)"
				}else{
					stockInfo.setBigDecimal("enIssueBalance", new BigDecimal(0));//" Number发行额度(亿)"
				}
				
				String cBondAppraise = businessBone.getString("bondrating");
				if(StringUtils.isNotBlank(cBondAppraise)){		
					if("01".equals(cBondAppraise)){ //债券评级大范围转小
						cBondAppraise = "1";
					}else if("02".equals(cBondAppraise)){
						cBondAppraise = "3";
					}else if("03".equals(cBondAppraise)){
						cBondAppraise = "4";
					}else if("04".equals(cBondAppraise)){
						cBondAppraise = "5";
					}else if("05".equals(cBondAppraise)){
						cBondAppraise = "6";
					}else if("06".equals(cBondAppraise)){
						cBondAppraise = "7";
					}else if("07".equals(cBondAppraise)){
						cBondAppraise = "P";
					}else if("98".equals(cBondAppraise)){
						cBondAppraise = "";
					}else if("99".equals(cBondAppraise)){
						cBondAppraise = "O";
					}else{
						cBondAppraise = "O";
					}
				}
				stockInfo.setString("cBondAppraise", cBondAppraise);//"String,债券评级"
				stockInfo.setString("vcBondAppraiseOrgan","ratingagencies");//"String,债券评级机构"
				//从发行主体表中获取，如果中文匹配不存在，则为0，多条取第一条  ratingname
				DataObject issueInfo = null;
				if(StringUtils.isNotBlank(businessBone.getString("ratingname"))){
					String issueName=businessBone.getString("ratingname");
					Object[] issueInfos =  DatabaseExt.queryByNamedSql("default", 
							"com.cjhxfund.ats.fm.baseinfo.issuerInfo.select_underwriter", issueName);
					if(issueInfos.length>0){
						issueInfo=(DataObject) issueInfos[0];//取第一条
					
						stockInfo.setString("vcIssuerName",issueInfo.getString("vcIssueName"));//"String,发行主体名称"  ratingname
						stockInfo.setString("vcIssuerNameFull",issueInfo.getString("vcIssueNameFull"));//"String,发行主体名称"  ratingname	
					}
				}
				stockInfo.setString("lIssuerId",issueInfo==null?"0":issueInfo.getString("lIssuerId"));//" Number,发行主体序号" 
				stockInfo.setString("vcIssueProperty",businessBone.getString("vcIssueProperty"));//"String,主体类型"
				stockInfo.setString("cIssueAppraise",businessBone.getString("cIssueAppraise"));//"String,主体评级"
				stockInfo.setInt("lPayDate",DateUtil.getDateStrNumber(businessBone.getString("paymentDate")));//" Date,缴款日期" 
				stockInfo.setInt("lBegincalDate",DateUtil.getDateStrNumber(businessBone.getString("startingDateInterest")));//" Date,起息日期"
				stockInfo.setInt("lEndincalDate",DateUtil.getDateStrNumber(businessBone.getString("deadlineInterest")));//" Date,到期日期"
				//System.out.println(businessBone.getString("paymentDate")+"=="+businessBone.getString("startingDateInterest")+"=="+businessBone.getString("deadlineInterest"));
				String enPayInteval = businessBone.getString("frequency"); //付息频率
				if(StringUtils.isNotBlank(enPayInteval)){
					if("1".equals(enPayInteval)){
						enPayInteval = "4";
					}else if("2".equals(enPayInteval)){
						enPayInteval = "1";
					}else if("3".equals(enPayInteval)){
						enPayInteval = "0";
					}else if("4".equals(enPayInteval)){
						enPayInteval = "-1";
					}
				}
				if(enPayInteval!=null && enPayInteval!=""){
					stockInfo.setBigDecimal("enPayInteval",new BigDecimal(enPayInteval));//" Number,次/年" //付息频率
				}				
				String cInterestType = businessBone.getString("modeRepayment");
				if(StringUtils.isNotBlank(cInterestType)){
					if("1".equals(cInterestType)){
						cInterestType = "1";
					}else if("2".equals(cInterestType)){
						cInterestType = "2";
					}else if("4".equals(cInterestType)){
						cInterestType = "2";//到期付息和利随本清
					}else if("3".equals(cInterestType)){
						cInterestType = "";
					}
				}
				stockInfo.set("cInterestType",cInterestType);//"String,利率类型" //付息频率需要转换
				
				String cPayInterestType = businessBone.getString("modeRepayment");
				if(StringUtils.isNotBlank(cPayInterestType)){
					if("1".equals(cPayInterestType)){
						cPayInterestType = "1";
					}else if("2".equals(cPayInterestType)){
						cPayInterestType = "2";
					}else if("4".equals(cPayInterestType)){
						cPayInterestType = "2";//到期付息和利随本清
					}else if("3".equals(cPayInterestType)){
						cPayInterestType = "";
					}
				}
				stockInfo.set("cPayInterestType",cPayInterestType);//"息票品种"

				long key = JDBCUtil.getNextSequence("SEQSTOCKISSUENO");
				stockInfo.setLong("lStockIssueId",key);//
				stockInfo.setLong("lBizId",0);//
				stockInfo.setLong("lStockInvestNo", key);//投资编号 INVESTPRODUCTNUM
				stockInfo.setInt("lDate", DateUtil.currentDateYYYYMMDDInt());//日期
				//stockInfo.setLong("lOperatorNo",null );//操作员
				stockInfo.setLong("cStatus", 2);//状态
				stockInfo.setLong("cSource", 1);//数据来源，手工录入
				stockInfo.setLong("lValidStatus",0);//
				if(businessBone.getString("couponRate")!=null && businessBone.getString("couponRate")!=""){
					stockInfo.setBigDecimal("enFaceRate",new BigDecimal(businessBone.getString("couponRate")));//" Number,票面利率"
				}				
				String cPayType = businessBone.getString("transactionType");
				if(StringUtils.isNotBlank(cPayType)){
					if("1".equals(cPayType)){
						cPayType = "3";
					}else if("2".equals(cPayType) && "02".equals(vcPaymentPlace)){
						cPayType = "1";
					}else{
						cPayType = "2";
					}
				}
				stockInfo.setString("cPayType",cPayType);//"String,缴款方式"//交易方式:1.缴款;2.DVP;
				stockInfo.setString("vcMainUnderwriter",businessBone.getString("mainBearingMechanism"));//"String,主承销商"
				stockInfo.setString("cIsHaveSaleback",businessBone.getString("resaleRight"));//"String,是否具有回售权"
				stockInfo.setString("cIsHaveBuyback",businessBone.getString("redemptionRight"));//"String,是否具有赎回权"
				stockInfo.setBigDecimal("enResaleYear",new BigDecimal(businessBone.getString("resaleYear")==null?"0":businessBone.getString("resaleYear")));//"Number,回售行权年"
				stockInfo.setBigDecimal("enRedemptionYear",new BigDecimal(businessBone.getString("redemptionYear")==null?"0":businessBone.getString("redemptionYear")));//"Number,赎回行权年"
				LogUtil.logInfo("新债推送，转后的新债实体：{0}", null, stockInfo);
				try{
					DatabaseUtil.insertEntity("default",stockInfo);
				}catch(Exception e){
					LogUtil.logInfo("新债推送，重置发行规模为0", e, "");
					stockInfo.setBigDecimal("enIssueBalance", new BigDecimal(0));//
					DatabaseUtil.insertEntity("default",stockInfo);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return stockInfo;
		} 
}
