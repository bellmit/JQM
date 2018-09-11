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
 * 质押式回购成交单
 * @author zhoujing
 *
 */
public class PledgeBuyBack {

	private Configuration configuration = null;

	public PledgeBuyBack() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("UTF-8");
	}

	public static void main(String[] args) {
		PledgeBuyBack test = new PledgeBuyBack();
		test.createWord();
	}

	public void createWord() {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		getData(dataMap);
		// 这里我们的模板是放在comm包下面的
		configuration.setClassForTemplateLoading(this.getClass(), ""); // FTL文件所存在的位置
		Template t = null;
		try {
			t = configuration.getTemplate("PledgeBuyBack.xml"); // 文件名
		} catch (IOException e) {
			e.printStackTrace();
		}
		File outFile = new File("E:/" + "质押式回购" + ".doc");
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
		dataMap.put("dealDate", "测试");
		dataMap.put("dealIndicia", "测试");
		dataMap.put("institution", "测试");
		dataMap.put("institution1", "测试");
		dataMap.put("dealer", "测试");
		dataMap.put("dealer1", "测试");
		dataMap.put("telephone", "测试");
		dataMap.put("telephone1", "测试");
		dataMap.put("portraiture", "测试");
		dataMap.put("portraiture1", "测试");
		dataMap.put("corporateRepresentative", "测试");
		dataMap.put("corporateRepresentative1", "测试");
		dataMap.put("address", "测试");
		dataMap.put("address1", "测试");
		dataMap.put("buyBackTimeLimit", "测试");
		dataMap.put("buyBackInterestRate", "测试");
		dataMap.put("surfaceTotalSum", "测试");
		dataMap.put("ransactionAmount", "测试");
		dataMap.put("accruedInterest", "测试");
		dataMap.put("becomeDueSettlementAmount", "测试");
		dataMap.put("firstnetPriceMethodOfSA", "测试");
		dataMap.put("becomeDueMethodOfSA", "测试");
		dataMap.put("firstnetPriceAccountDay", "测试");
		dataMap.put("becomeDueMethodOfSA", "测试");
		dataMap.put("realityBondFatalism", "测试");
		dataMap.put("businessBreed", "测试");
		dataMap.put("volumeOfVolume", "测试");
		dataMap.put("conversioRatio", "测试");
		dataMap.put("fundAccountName", "测试");
		dataMap.put("fundAccountName1", "测试");
		dataMap.put("fundBankOfDeposit", "测试");
		dataMap.put("fundBankOfDeposit1", "测试");
		dataMap.put("fundaccount", "测试");
		dataMap.put("fundaccount1", "测试");
		dataMap.put("paysystemNumber", "测试");
		dataMap.put("paysystemNumber1", "测试");
		dataMap.put("depositAccountName", "测试");
		dataMap.put("depositAccountName1", "测试");
		dataMap.put("depositInstitution", "测试");
		dataMap.put("depositInstitution1", "测试");
		dataMap.put("depositAccount", "测试");
		dataMap.put("depositAccounts1", "测试");
		
	}

}
