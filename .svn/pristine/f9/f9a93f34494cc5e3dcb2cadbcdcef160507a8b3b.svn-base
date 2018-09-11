package com.cjhxfund.ats.sm.comm;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
/**
 * 现卷买卖成交单导出
 * @author zhoujing
 *
 */
public class thisVolumeBusinesss {

	private Configuration configuration = null;

	public thisVolumeBusinesss() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("UTF-8");
	}

	public static void main(String[] args) {
		thisVolumeBusinesss test = new thisVolumeBusinesss();
		test.createWord();
	}

	public void createWord() {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		getData(dataMap);
		// 这里我们的模板是放在comm包下面的
		configuration.setClassForTemplateLoading(this.getClass(), ""); // FTL文件所存在的位置
		Template t = null;
		try {
			t = configuration.getTemplate("thisVolumeBusiness.xml"); // 文件名
		} catch (IOException e) {
			e.printStackTrace();
		}
		File outFile = new File("E:/" + "现卷买卖成交单" + ".doc");
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
		dataMap.put("bondsCode", "测试");
		dataMap.put("bondsName", "测试");
		dataMap.put("netPrice", "测试");
		dataMap.put("surfaceTotalSum", "测试");
		dataMap.put("becomeDueIncomeAmount", "测试");
		dataMap.put("transactionAmount", "测试");
		dataMap.put("accruedInterest", "测试");
		dataMap.put("becomeDueAccruedInterest", "测试");
		dataMap.put("fullRate", "测试");
		dataMap.put("settlementAmount", "测试");
		dataMap.put("settleAccounts", "测试");
		dataMap.put("accountDay", "测试");
		dataMap.put("fundAccountName", "测试");
		dataMap.put("fundAccountName1", "测试");
		dataMap.put("fundBankOfDeposit", "测试");
		dataMap.put("fundBankOfDeposit2", "测试");
		dataMap.put("fundaccount", "测试");
		dataMap.put("fundaccount3", "测试");
		dataMap.put("paysystemNumber", "测试");
		dataMap.put("paysystemNumber4", "测试");
		dataMap.put("depositAccountName", "测试");
		dataMap.put("depositAccountName5", "测试");
		dataMap.put("depositInstitution", "测试");
		dataMap.put("depositInstitution6", "测试");
		dataMap.put("depositAccount", "测试");
		dataMap.put("depositAccounts7", "测试");
		
		
		/*
		 * List<Map<String, Object>> list = new ArrayList<Map<String,
		 * Object>>(); for (int i = 0; i < 10; i++) { Map<String, Object> map =
		 * new HashMap<String, Object>(); map.put("number", i);
		 * map.put("content", "内容" + i); list.add(map); }
		 */

		// dataMap.put("list", list);
	}

}
