/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 新债数据处理类
 * @author 杨敏
 * @date 2016-12-06 10:11:26
 *
 */
@Bizlet("")
public class StockIssueInfo {

	/**
	 * 转换新债历史表数据
	 * @author 杨敏
	 * 
	 */
	@Bizlet("转换新债历史表数据")
	public static DataObject getStockIssueInfo(DataObject[] objs,DataObject obj) {
		String[] pamArray = new String[]
				{"lStockIssueId","lBizId","lStockInvestNo","cStatus","lValidStatus","lDate","cMarketNo","vcInterCode",
				"vcStockCode","vcStockName","vcStockNameFull","vcStockType","enExistLimite","enIssueBalance","cBondAppraise","vcBondAppraiseOrgan",
				"lIssuerId","vcIssuerName","vcIssueProperty","cIssueAppraise","vcIssueAppraiseOrgan","vcIndustry","vcProvince","lGuarantorId",
				"vcGuarantorName","vcGuarantorSummary","lIssuePostDate","lIssueBeginDate","lPayDate","lPublishDate","lBegincalDate","lEndincalDate",
				"cInterestType","cPayInterestType","enPayInteval","enFaceRate","cBidType","cPayType","vcSpecialText","vcMainUnderwriter","vcDeputyUnderwriter",
				"cUnderwriteType","vcGroupUnderwriter","lNextExerciseDate","cIsSmallRaised","cIsHaveSaleback","lBondIssueFile","lRaiseInstFile","lRateReportFile",
				"cSource","lOperatorNo","lCreditAnalyzeNo","vcCreditAnalyze","lAttchCount","vcUserId","dBidLimitTime","cIsHaveBuyback","enCategoryMoney","enResaleYear",
				"enRedemptionYear","vcPaymentPlace","lProcessInstId","vcStockCodeWind","vcIssuerNameFull","vcInterCodeWind","vcExistLimiteDesc","vcIssueBeginDateDesc",
				"vcTenderInterval","vcUnderwriterInfo","vcIssueAppraiseCsrc","vcMortStockName","vcMortStockAmount","vcMortStockCode","enIssuerNetValue","vcCityLevel",
				"lNInterestRateJumpPoints","vcIssueType","vcSpecialLimite","cAssureType","vcExistLimiteDesc","vcIssueBeginDateDesc","vcSpecialTextDesc","vcMainUnderwriterId",
				"vcDeputyUnderwriterId","vcGroupUnderwriterId"};

		
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义时间格式
		//解析数组中对于字段的值
		for (int i = 0; i < pamArray.length; i++) {
			//时间类型数据处理
			if("dBidLimitTime".equals(pamArray[i])){
				try {
					Date value=objs[0].getDate(pamArray[i]);
					//传入返回对象中
					obj.setDate(pamArray[i],value);
				} catch (Exception e) {
					LogUtil.logError("新债字段dBidLimitTime 时间格式转换失败:{0}", e, objs[0].getDate(pamArray[i]));
					e.printStackTrace();
				}
			}else{
				String value=objs[0].getString(pamArray[i]);
				//传入返回对象中
				obj.setString(pamArray[i], value);
			}
			
		}
		
		return obj;
	}

}
