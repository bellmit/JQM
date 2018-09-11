package com.cjhxfund.ats.sm.comm;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
/**
 * 买断式回购成交单
 * @author zhoujing
 *
 */
public class BuyOutBuyBack {
	private Configuration configuration = null;

	public BuyOutBuyBack() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("UTF-8");
	}

	public static void main(String[] args) {
		BuyOutBuyBack test = new BuyOutBuyBack();
		test.createWord();
	}

	public void createWord() {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		getData(dataMap);
		// 这里我们的模板是放在comm包下面的
		configuration.setClassForTemplateLoading(this.getClass(), ""); // FTL文件所存在的位置
		Template t = null;
		try {
			t = configuration.getTemplate("BoughtDealBuyBack.xml"); // 文件名
		} catch (IOException e) {
			e.printStackTrace();
		}
		File outFile = new File("E:/" + "买断式回购成交单" + ".doc");
		Writer out = null;

		try {
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
					outFile), "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		try {
			t.process(dataMap, out);
		} catch (TemplateException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}

	private void getData(Map<String, Object> dataMap) {
		dataMap.put("dealDate", "标题");
		dataMap.put("dealIndicia", "2012");
		dataMap.put("institution", "2");
		dataMap.put("institution1", "13");
		dataMap.put("dealer", "唐鑫");
		dataMap.put("dealer1", "13020265912");
		dataMap.put("telephone", "占文涛");
		dataMap.put("telephone1", "占文涛");
		dataMap.put("portraiture", "占文涛");
		dataMap.put("portraiture1", "占文涛");
		dataMap.put("corporateRepresentative", "占文涛");
		dataMap.put("corporateRepresentative1", "占文涛");
		dataMap.put("address", "占文涛");
		dataMap.put("address1", "占文涛");
		dataMap.put("bondsCode", "占文涛");
		dataMap.put("bondsName", "占文涛");
		dataMap.put("businessBreed", "占文涛");
		dataMap.put("buyBackTimeLimit", "占文涛");
		dataMap.put("buyBackInterestRate", "占文涛");
		dataMap.put("surfaceTotalSum", "占文涛");
		dataMap.put("firstnetPriceNetPrice", "占文涛");
		dataMap.put("firstnetPriceIncomeAmount", "占文涛");
		dataMap.put("firstnetPriceAccruedInterest", "占文涛");
		dataMap.put("becomeDueNetPrice", "占文涛");
		dataMap.put("becomeDueIncomeAmount", "占文涛");
		dataMap.put("becomeDueAccruedInterest", "占文涛");
		dataMap.put("firstnetPriceFullRate", "占文涛");
		dataMap.put("firstnetPriceSettlementAmount", "占文涛");
		dataMap.put("firstnetPriceMethodOfSA", "占文涛");
		dataMap.put("becomeDueFullRate", "占文涛");
		dataMap.put("becomeDueSettlementAmount", "占文涛");
		dataMap.put("becomeDueMethodOfSA", "占文涛");
		dataMap.put("becomeDueFullRate", "占文涛");
		dataMap.put("becomeDueSettlementAmount", "占文涛");
		dataMap.put("becomeDueMethodOfSA", "占文涛");
		dataMap.put("firstnetPriceAccountDay", "占文涛");
		dataMap.put("becomeDueAccountDay", "占文涛");
		dataMap.put("realityBondFatalism", "占文涛");
		dataMap.put("fundAccountName", "占文涛");
		dataMap.put("fundAccountName1", "占文涛");
		dataMap.put("fundBankOfDeposit", "占文涛");
		dataMap.put("fundBankOfDeposit2", "占文涛");
		dataMap.put("fundaccount", "占文涛");
		dataMap.put("fundaccount3", "占文涛");
		dataMap.put("paysystemNumber", "占文涛");
		dataMap.put("paysystemNumber4", "占文涛");
		dataMap.put("depositAccountName", "占文涛");
		dataMap.put("depositAccountName5", "占文涛");
		dataMap.put("depositInstitution", "占文涛");
		dataMap.put("depositInstitution6", "占文涛");
		dataMap.put("depositAccount", "占文涛");
		dataMap.put("depositAccounts7", "占文涛");
		
		/*
		 * List<Map<String, Object>> list = new ArrayList<Map<String,
		 * Object>>(); for (int i = 0; i < 10; i++) { Map<String, Object> map =
		 * new HashMap<String, Object>(); map.put("number", i);
		 * map.put("content", "内容" + i); list.add(map); }
		 */

		// dataMap.put("list", list);
	}
}
