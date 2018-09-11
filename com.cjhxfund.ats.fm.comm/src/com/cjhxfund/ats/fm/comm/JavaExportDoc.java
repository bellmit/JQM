package com.cjhxfund.ats.fm.comm;

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

import com.cjhxfund.ats.fm.comm.DateUtil;
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
			DataObject objs,String fileName) {
		
		isExist(exportFilePath);
		
		Template t = null;
		// 1、导入模板
		configuration.setClassForTemplateLoading(this.getClass(), "");

		try {
			// test.ftl为要装载的模板
			t = configuration.getTemplate(modelName);
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 2、打包数据--每次导出的word文件模板不同，打包数据的方法要单独写
		Map<String, Object> dataMap = new HashMap<String, Object>();
		getData(dataMap, objs);

		// 3、导出文件
		// 输出文档路径及名称
		File outFile = new File(exportFilePath + File.separator + fileName);
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
	
	/**
	  * 
	  * @param path 文件夹路径
	  */
	 public static void isExist(String path) {
		  File file = new File(path);
		  //判断文件夹是否存在,如果不存在则创建文件夹
		  if (!file.exists()) {
			  try {    
				  	file.setWritable(true, false);
				  	file.mkdirs();
			        //file.createNewFile();    
			    } catch (Exception e) {    
			        // TODO Auto-generated catch block    
			        e.printStackTrace();    
			    }  
		  }
	 }
	

	//把数据打包成map;dataMap里存放的数据Key值要与模板中的参数相对应
	private void getData(Map<String, Object> dataMap, DataObject obj) {
		String resale ="";
		double issueSize;
		try {
		int resaleYear = obj.getInt("enResaleYear"); //回售行权年
		int redemptionYear = obj.getInt("enRedemptionYear"); //赎回行权年
		System.out.println(obj.getInt("enExistLimite"));
		//判断赎回行权年是否为空
		if(redemptionYear != 0){
			//计算回售行权年N+N第二个N值
			int enExistLimite = obj.getInt("enExistLimite") - redemptionYear;
			//当N值小于0时置为0
			if(enExistLimite < 0){
				enExistLimite = 0;
			}
			resale =  "赎回：" + redemptionYear + "+" + enExistLimite;
		}

		//判断回售行权年是否为空
		if (resaleYear != 0) {
			//计算回售行权年N+N第二个N值
			int enExistLimite = obj.getInt("enExistLimite") - resaleYear;
			//当N值小于0时置为0
			if(enExistLimite < 0){
				enExistLimite = 0;
			}
			resale = resale +"," + "回售：" + resaleYear + "+" + enExistLimite;  
		} 
		//获取登记托管场所
		String paymentplace = getDictMap("CF_JY_DJTGCS").get(obj.getString("vcPaymentPlace"));
		//获取主体评级
		String subjectrating = getDictMap("issuerRating").get(obj.getString("cIssueAppraise"));
		//获取债券评级
		String bondrating = getDictMap("creditRating").get(obj.getString("cBondAppraise")); 

		//获取债券种类
		String investcategory = obj.getString("vcStocktypeName");
		
		if(investcategory == null){
			if(obj.getInt("vcProcessType") == 2){
				investcategory = "可转债";
			}
		}
		System.out.println(obj.getString("lInvestNo"));
		dataMap.put("titleName", "[" + obj.getString("lInvestNo") + "]" + "_" +obj.getString("vcProductName") + "_" + obj.getString("vcStockName"));
		
		//发行人名称
		dataMap.put("IssuerName", obj.getString("vcIssuerNameFull") == null ? "" : obj.getString("vcIssuerNameFull"));
		//债券代码
		dataMap.put("vcStockCode", obj.getString("vcStockCode") == null ? "" : obj.getString("vcStockCode"));
		//登记托管场所 上清/中债/上海/深圳 
		dataMap.put("paymentplace", paymentplace == null ? "" : paymentplace);
		//债券名称
		dataMap.put("vcStockName", obj.getString("vcStockName") == null ? "" : obj.getString("vcStockName"));
		//主体评级
		dataMap.put("subjectrating", subjectrating == null ? "" : subjectrating);
		
		//债项评级
		dataMap.put("bondrating", bondrating == null ? "" : bondrating);  
		
		//转换千分位
		if(obj.getString("enIssueBalance") == null){
			issueSize = 0;
		}else{
			issueSize = new DecimalFormat().parse(obj.getString("enIssueBalance")).doubleValue();
		}
		dataMap.put("issueSize", issueSize);
		
		//票面利率
		dataMap.put("interestrate", obj.getString("enCouponRate") == null ? "": obj.getString("enCouponRate"));
		
		//债券类别(企业/公司/中小/ABS/PPN等)
		dataMap.put("investcategory", investcategory == null ? "" : investcategory);
		
		
		//计息起始日
		dataMap.put("InterestStartDate",obj.getString("startingDateInterest") == null ? "" : obj.getString("startingDateInterest").substring(0, 10));

		//计息截止日
		dataMap.put("InterestEndDate", obj.getString("dBidLimitTime") == null ? "" : obj.getString("dBidLimitTime").substring(0, 10));
		//付息方式
		String frequency = getDictMap("ATS_CF_JY_FREQUENCY").get(obj.getString("vcFrequency"));
		String frequency1 = obj.getString("vcFrequency") ==null ? "" : obj.getString("vcFrequency");
		dataMap.put("paymentType", frequency == null ? frequency1 : frequency);
		
		//缴款截止日
		dataMap.put("paymentDate", obj.getDate("dPaymentDate") == null ? "" : DateUtil.format(obj.getDate("dPaymentDate")));
		
		//首次付息日
		System.out.println(obj.getString("dInitInterestPaymentDate"));
		dataMap.put("InterestDate", obj.getString("dInitInterestPaymentDate") == null ? "" : DateUtil.formatDate(obj.getString("dInitInterestPaymentDate"),"yyyy-MM-dd"));
		
		//债券年限
		dataMap.put("categorydate", obj.getString("enExistLimite") == null ? "" : obj.getString("enExistLimite"));
		
		String isHave="";
		//赎回权
		String cIsHaveBuyback=obj.getString("cIsHaveBuyback") == null ? "0" : obj.getString("cIsHaveBuyback");
		//回售
		String cIsHaveSaleback =obj.getString("cIsHaveSaleback") == null ? "0" : obj.getString("cIsHaveSaleback");
		if("1".equals(cIsHaveBuyback)){
			isHave="赎回";
		}
		if("1".equals(cIsHaveSaleback)){
			isHave="回售  "+isHave;
		}
		//行权(赎回,回售)
		dataMap.put("exercise", isHave);
		
		//String vcSpecialLimite = obj.getString("vcSpecialLimite");   
		//行权年
		dataMap.put("WithRightTime", resale);
		
		//到期/分期还本
		String modeRepayment = getDictMap("CF_JY_MODE_REPAYMENT").get(obj.getString("vcModeRepayment"));
		dataMap.put("modeRepayment", modeRepayment == null ? "" : modeRepayment);
		
		//利率类型
		String cInterestType = getDictMap("rateType").get(obj.getString("cInterestType"));
		dataMap.put("cInterestType", cInterestType == null ? "" : cInterestType);

		//发行价格
		String issuePrice = obj.getString("enIssuePrice");
		if(issuePrice == null){
			issuePrice = "100";
		}
		dataMap.put("issuePrice", issuePrice);
		
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
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
	public static File wordDownload(String modelName, String filePath,DataObject objs,String fileName) {
		JavaExportDoc dh = new JavaExportDoc();
		File retrunValue = dh.createDoc(modelName, filePath, objs,fileName);
		return retrunValue;
	}

	public static void main(String[] args) {
		JavaExportDoc dh = new JavaExportDoc();
		DataObject objs = DataObjectUtil
				.createDataObject("com.cjhxfund.jy.process.FirstGradeBond.FirstGradeBondEntity");
		objs.set("bizId", "281");
		DatabaseUtil.expandEntityByTemplate("", objs, objs);
		//String filePath = "D:/outFile.doc";//导出doc文件的路径
		//String modelName = "test.xml";//模板名称
		//dh.createDoc(modelName, filePath, objs);
		System.out.println("	导出成功");
	}

}
