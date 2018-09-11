package com.cjhxfund.commonUtil.JQMHistory;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Bizlet("")
public class JavaExportDoc {
	private Configuration configuration = null;

	public JavaExportDoc() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("UTF-8");
	}

	// 2个参数分别是：模板的名称，导出文件的路径
	public File createDoc(String modelName, String exportFilePath,
			DataObject objs) {
		
		Template t = null;
		// 1、导入模板
		configuration.setClassForTemplateLoading(this.getClass(), "");

		try {
			// test.ftl为要装载的模板
			t = configuration.getTemplate("发行人名称.xml");
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 2、打包数据--每次导出的word文件模板不同，打包数据的方法要单独写
		Map<String, Object> dataMap = new HashMap<String, Object>();
		getData(dataMap, objs);

		// 3、导出文件
		// 输出文档路径及名称
		File outFile = new File(exportFilePath);
		Writer out = null;
		try {
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		try {
			t.process(dataMap, out);
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return outFile;
	}

	//把数据打包成map;dataMap里存放的数据Key值要与模板中的参数相对应
	private void getData(Map<String, Object> dataMap, DataObject obj) {
		String resale ="";
		double issueSize;
		try {
		int resaleYear = obj.getInt("resaleYear"); //回售行权年
		int redemptionYear = obj.getInt("redemptionYear"); //赎回行权年
		
		//判断赎回行权年是否为空
		if(redemptionYear != 0){
			resale =  "赎回：" + redemptionYear + "+" + (obj.getInt("categorydate") - redemptionYear);
		}
				
		//判断回售行权年是否为空
		if (resaleYear != 0) {
			resale = resale +"," + "回售：" + resaleYear + "+" + (obj.getInt("categorydate") - resaleYear);  
		} 
		

		//获取登记托管场所
		String paymentplace = getDictMap("CF_JY_DJTGCS").get(obj.getString("paymentplace"));
		//获取主体评级
		System.out.println(obj.getString("subjectrating"));
		String subjectrating = getDictMap("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING").get(obj.getString("subjectrating"));
		//获取债项评级
		String bondrating = getDictMap("CF_JY_PRODUCT_PROCESS_BOND_RATING").get(obj.getString("bondrating"));

		//获取债券种类
		String investcategory = getDictMap("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY").get(obj.getString("investcategory"));
		
		if(investcategory == null){
			if(obj.getInt("businesstype") == 2){
				investcategory = "可转债";
			}
		}
		
		//发行人名称
		dataMap.put("IssuerName", obj.getString("ratingname") == null ? "" : obj.getString("ratingname"));
		//债券代码
		dataMap.put("investProductCode", obj.getString("investProductCode"));
		//上清/中债/上海/深圳
		dataMap.put("paymentplace", paymentplace == null ? "" : paymentplace);
		//债券名称
		dataMap.put("investProductName", obj.getString("investProductName"));
		//主体评级
		dataMap.put("subjectrating", subjectrating == null ? "" : subjectrating);
		
		//债项评级
		dataMap.put("bondrating", bondrating == null ? "" : bondrating);
		
		//转换千分位
		if(obj.getString("issueSize") == null){
			issueSize = 0;
		}else{
			issueSize = new DecimalFormat().parse(obj.getString("issueSize")).doubleValue();
		}
		dataMap.put("issueSize", issueSize);
		
		//票面利率
		dataMap.put("interestrate", obj.getString("couponRate") == null ? "": obj.getString("couponRate"));
		
		//债券类别(企业/公司/中小/ABS/PPN等)
		dataMap.put("investcategory", investcategory == null ? "" : investcategory);
		
		//计息起始日
		dataMap.put("InterestStartDate",obj.getString("startingDateInterest") == null ? "" : obj.getString("startingDateInterest").substring(0, 10));

		//计息截止日
		dataMap.put("InterestEndDate", obj.getString("deadlineInterest") == null ? "" : obj.getString("deadlineInterest").substring(0, 10));
		
		//付息方式
		String frequency = getDictMap("CF_JY_FREQUENCY").get(obj.getString("frequency"));
		dataMap.put("paymentType", frequency == null ? "" : frequency);
		
		//缴款截止日
		dataMap.put("paymentDate", obj.getDate("paymentDate") == null ? "" : DateUtil.format(obj.getDate("paymentDate")));
		
		//首次付息日
		dataMap.put("InterestDate", obj.getDate("initialInterestPaymentDate") == null ? "" : DateUtil.format(obj.getDate("initialInterestPaymentDate")));
		
		//债券年限
		dataMap.put("categorydate", obj.getString("categorydate") == null ? "" : obj.getString("categorydate"));
		
		//行权(赎回,回售)
		dataMap.put("exercise", resale);
		
		//含权期限(N+N)
		//dataMap.put("WithRightTime", "");
		
		//到期/分期还本
		String modeRepayment = getDictMap("CF_JY_MODE_REPAYMENT").get(obj.getString("modeRepayment"));
		dataMap.put("modeRepayment", modeRepayment == null ? "" : modeRepayment);
		
		//发行价格
		String issuePrice = obj.getString("issuePrice");
		if(issuePrice == null){
			issuePrice = "100";
		}
		dataMap.put("issuePrice", issuePrice);
		
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		/*dataMap.put("IssuerName", "1");  
		dataMap.put("investProductCode", '1');  
		dataMap.put("paymentplace", '1');  
		dataMap.put("investProductName", "1");  
		dataMap.put("subjectrating", "1");  
		dataMap.put("bondrating", "1");  
		dataMap.put("issueSize", "1"); 
		dataMap.put("interestrate", "1"); 
		dataMap.put("investcategory", "1"); 
		dataMap.put("InterestStartDate", "1"); 
		dataMap.put("InterestEndDate", "1"); 
		dataMap.put("paymentType", "1"); 
		dataMap.put("categorydate", "1"); 
		dataMap.put("exercise", "1");
		dataMap.put("WithRightTime", "1");*/
	}

	//根据字典项编号获取数据字典
	public static Map<String, String> getDictMap(String dicttypeid) {
		DataObject[] objs = BusinessDictUtil.getDictInfoByType(dicttypeid);
		Map<String, String> maps = new HashMap<String, String>();
		for (int i = 0; i < objs.length; i++) {
			maps.put(objs[i].getString("dictID"), objs[i].getString("dictName"));
		}
		return maps;
	}
	
	/**
	 * @param request
	 * @param response
	 * @author CJ-WB-DT13
	 */
	@Bizlet("")
	public static File wordDownload(String modelName, String filePath,DataObject objs) {
		JavaExportDoc dh = new JavaExportDoc();
		File retrunValue = dh.createDoc(modelName, filePath, objs);
		return retrunValue;
	}

	public static void main(String[] args) {
		JavaExportDoc dh = new JavaExportDoc();
		DataObject objs = DataObjectUtil
				.createDataObject("com.cjhxfund.jy.process.FirstGradeBond.FirstGradeBondEntity");
		objs.set("bizId", "281");
		DatabaseUtil.expandEntityByTemplate("", objs, objs);
		String filePath = "D:/outFile.doc";//导出doc文件的路径
		String modelName = "test.xml";//模板名称
		dh.createDoc(modelName, filePath, objs);
		System.out.println("	导出成功");
	}

}
