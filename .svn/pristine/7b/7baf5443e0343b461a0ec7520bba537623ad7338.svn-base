/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import com.eos.system.annotation.Bizlet;

/**
 * @author 刘玉龙
 * @date 2017-03-14 20:23:33
 *
 */
@Bizlet("")
public class FieldDifferConvert {
	/***
	 * 本地应用主体评级向数据中心类型转换
	 * @param inParam 转换前的主体评级
	 * @return 转换后的主体评级
	 * @author 刘玉龙
	 */
	@Bizlet("本地应用主体评级映射到数据中心")
	public String mapIssueAppraiseToWind(String vcIssueAppraise){
		String outParam = null;
		if(vcIssueAppraise!=null && vcIssueAppraise!=""){
			outParam = "";
			String[] appraiseArray = vcIssueAppraise.split(",");
			for(int i=0; i<appraiseArray.length; i++){
				if(i!=0){
					outParam = outParam + ",";
				}
				if(appraiseArray[i].contains("AAA及以上")){
					outParam = outParam + "'1'";
				}else if(appraiseArray[i].contains("AA+")){
					outParam = outParam + "'3'";
				}else if(appraiseArray[i].contains("AA-")){
					outParam = outParam + "'5'";
				}else if(appraiseArray[i].contains("AA")){
					outParam = outParam + "'4'";
				}else if(appraiseArray[i].contains("A+")){
					outParam = outParam + "'P'";
				}else if(appraiseArray[i].contains("A及以下")){//A及以下:A、A-、BBB、BBB-、BB+、BB、BB-、B+、B、B-、CCC、CC、C、D、BBB+
					outParam = outParam + "'6','7','8','9','A','B','C','D','E','F','G','H','I','J','Q'";
				}else if(appraiseArray[i].contains("其他")){
					outParam = outParam + "'2','0'";
				}else if(appraiseArray[i].contains("无")){
					outParam = outParam + "''";
				}else{
					outParam = outParam + appraiseArray[i];
				}
			}
		}
		return outParam;
	}
	
	/***
	 * 本地应用主体评级向数据中心类型转换
	 * @param inParam 转换前的主体评级
	 * @return 转换后的主体评级
	 * @author 刘玉龙
	 */
	@Bizlet("本地应用债券评级映射到数据中心")
	public String mapBondAppraiseToWind(String vcBondAppraise){
		String outParam = null;
		if(vcBondAppraise!=null && vcBondAppraise!=""){
			outParam = "";
			String[] appraiseArray = vcBondAppraise.split(",");
			for(int i=0; i<appraiseArray.length; i++){
				if(i!=0){
					outParam = outParam + ",";
				}
				if(appraiseArray[i].contains("AAA及以上")){
					outParam = outParam + "'1'";
				}else if(appraiseArray[i].contains("AA+")){
					outParam = outParam + "'3'";
				}else if(appraiseArray[i].contains("AA-")){
					outParam = outParam + "'5'";
				}else if(appraiseArray[i].contains("AA")){
					outParam = outParam + "'4'";
				}else if(appraiseArray[i].contains("A+")){
					outParam = outParam + "'P'";
				}else if(appraiseArray[i].contains("A及以下")){//A及以下:A、A-、BBB、BBB-、BB+、BB、BB-、B+、B、B-、CCC、CC、C、D、BBB+
					outParam = outParam + "'6','7','8','9','A','B','C','D','E','F','G','H','I','J','Q','K','L','M'";
				}
//				else if(appraiseArray[i].contains("短融A-1")){
//					outParam = outParam + "'K','L','M'";
//				}
				else if(appraiseArray[i].contains("其他")){
					outParam = outParam + "'2','0','N','O'";
				}else if(appraiseArray[i].contains("无")){
					outParam = outParam + "''";
				}else{
					outParam = outParam + appraiseArray[i];
				}
			}
		}
		return outParam;
	}
}
