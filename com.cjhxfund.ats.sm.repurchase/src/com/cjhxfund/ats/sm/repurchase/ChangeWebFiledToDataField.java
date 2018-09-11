package com.cjhxfund.ats.sm.repurchase;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.eos.system.annotation.Bizlet;

/**
 * @author 罗倔怀
 * @date 2017-08-21
 *
 */
@Bizlet("排序转换字段类")
public class ChangeWebFiledToDataField {
	private static HashMap<String, String> fieldMap = null;
	
	private static void putDataField(){
		if(fieldMap == null){
			fieldMap = new HashMap<String,String>();
			fieldMap.put("vcReportCode","ats.vc_report_code");
			fieldMap.put("vcStockName","bon.vc_stock_name");
			fieldMap.put("lCurrentAmount","ats.l_current_amount");
			fieldMap.put("enCbValueNetValue","bon.en_cb_value_net_value");
			fieldMap.put("enCbValueAllValue","bon.EN_CB_VALUE_ALL_VALUE");
			fieldMap.put("vcBondAppraise","bon.vc_bond_appraise");
			fieldMap.put("vcIssueAppraise","bon.vc_issue_appraise");
			fieldMap.put("lRatingForecast","bon.l_rating_forecast");
			fieldMap.put("lDelistingDate","bon.L_DELISTING_DATE");
			fieldMap.put("lNextExerciseDate","bon.L_NEXT_EXERCISE_DATE");
			fieldMap.put("vcIssueProperty","bon.vc_issue_property");
		}
	}
	@Bizlet("把web字段转成数据库字段")
	public String webFieldToDataField(String webField){
		if(webField == null){
			return null;
		}
		putDataField();
		String dataField = fieldMap.get(webField);
		if(dataField == null){
			return webField;
		}else{
			return dataField;
		}
	}
}
