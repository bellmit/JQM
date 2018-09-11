/**
 * 
 */
package com.cjhxfund.ats.sm.comm;


import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;


/**
 * @author 罗倔怀
 * @date 2016-12-20 16:16:03
 *
 */
@Bizlet("批量转换为拼音")
public class TraderivalToPinyin {
	 public static enum Type {  
	        UPPERCASE,              //全部大写  
	        LOWERCASE,              //全部小写  
	        FIRSTUPPER              //首字母大写  
	    }  
	  
	 
	@Bizlet("批量把交易对手转换为拼音")
	public static DataObject[] translateToPinyin(DataObject [] traderList) throws BadHanyuPinyinOutputFormatCombination{
		int size = traderList.length;
		HanyuPinyinOutputFormat f = new HanyuPinyinOutputFormat();
		 f.setCaseType(HanyuPinyinCaseType.LOWERCASE);  
		 f.setToneType(HanyuPinyinToneType.WITHOUT_TONE);  
		String trader = "";
		for(int i =0;i<size;i++){
			trader = traderList[i].getString("vcName");
			int length = trader.length();
			String traderPinyin = "";
			String firstWord = "";
			for(int j = 0;j<length;j++){
				char charA = trader.charAt(j);
				String [] temp =  PinyinHelper.toHanyuPinyinStringArray(charA,f);
				String pinyinchar = temp == null ? String.valueOf(charA) : temp[0];
				firstWord = pinyinchar == "" ?"" : pinyinchar.substring(0,1);
				traderPinyin = traderPinyin + firstWord;
			}
			traderList[i].set("pinyin", traderPinyin);
		}
		return traderList;
	}
	
	@Bizlet("批量把产品名称转换为拼音")
	public static DataObject[] productToPinyin(DataObject [] productList) throws BadHanyuPinyinOutputFormatCombination{
		int size = productList.length;
		HanyuPinyinOutputFormat f = new HanyuPinyinOutputFormat();
		 f.setCaseType(HanyuPinyinCaseType.LOWERCASE);  
		 f.setToneType(HanyuPinyinToneType.WITHOUT_TONE);  
		String name = "";
		for(int i =0;i<size;i++){
			name = productList[i].getString("vcProductName");
			int length = name.length();
			String traderPinyin = "";
			String firstWord = "";
			for(int j = 0;j<length;j++){
				char charA = name.charAt(j);
				String [] temp =  PinyinHelper.toHanyuPinyinStringArray(charA,f);
				String pinyinchar = temp == null ? String.valueOf(charA) : temp[0];
				firstWord = pinyinchar == "" ?"" : pinyinchar.substring(0,1);
				traderPinyin = traderPinyin + firstWord;
			}
			productList[i].set("vcProductNamePinyin", traderPinyin);
		}
		return productList;
	}
	
	@Bizlet("组装交易对手拼音对象")
	public static DataObject[] combTraderPinyin(DataObject [] traderList){
		int length = traderList.length;
		DataObject [] traderPinyins = new DataObject[length];
		for(int i =0;i<length;i++){
			DataObject traderPinyin = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.Ttraderivalpinyin");
			traderPinyin.setInt("lRivalId", traderList[i].getInt("lRivalId"));
			traderPinyin.setString("vcRivalCode", traderList[i].getString("vcRivalCode"));
			traderPinyin.setString("vcName", traderList[i].getString("vcName"));
			traderPinyin.setString("vcAllName", traderList[i].getString("vcAllName"));
			traderPinyin.setString("vcPinyin", traderList[i].getString("pinyin"));
			traderPinyin.setString("vcIssuerName", traderList[i].getString("vcIssuerName"));
			traderPinyin.setString("vcIssuerFullname", traderList[i].getString("vcIssuerFullname"));
			traderPinyins[i] = traderPinyin;
		}
		return traderPinyins;
	}
	@Bizlet("组装对手方账户对象")
	public static DataObject[] combBankAccount(DataObject [] bankAccountList){
		int length = bankAccountList.length;
		DataObject [] bankAccounts = new DataObject[length];
		for(int i =0;i<length;i++){
			DataObject bankAccount = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsCounterpartyAccount");
			bankAccount.setInt("lOrgId", bankAccountList[i].getInt("lOrgId"));
			bankAccount.setString("vcAccount", bankAccountList[i].getString("vcAccount"));
			bankAccount.setString("vcAccountName", bankAccountList[i].getString("vcAccountName"));
			bankAccount.setString("vcPayNo", bankAccountList[i].getString("vcPayNo"));
			bankAccount.setString("vcId", bankAccountList[i].getString("vcId"));
			bankAccount.setString("cBusinClass", bankAccountList[i].getString("cBusinClass"));
			bankAccount.setString("vcBankName", bankAccountList[i].getString("vcBankName"));
			bankAccounts[i] = bankAccount;
		}
		return bankAccounts;
	}
}
