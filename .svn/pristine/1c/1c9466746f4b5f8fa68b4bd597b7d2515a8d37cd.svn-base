package com.cjhxfund.jy.ProductProcess;

import java.io.File;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.RichTextString;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.cjhxfund.commonUtil.commonUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.primeton.workflow.commons.utility.StringUtil;

import commonj.sdo.DataObject;

/**
 * 导出指令/建议
 * @author huangmizhi
 */
@Bizlet("")
public class ProductProcessExport {
	
	/** 导出类型：0-不过滤权限，否则过滤投顾权限 */
	public static final String EXPORT_TYPE_ALL = "0";
	
	/**
	 * 导出指令/建议
	 * @param productProcessData
	 * @param exportType 导出类型：0-不过滤权限，否则过滤投顾权限
	 * @param webType 页面类型：指令查询页面=1，机器猫页面（默认为空）
	 * @return
	 * @throws Exception
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String productProcessExport(DataObject[] productProcessData, String exportType, String webType) throws Exception {
//		String fileDir = "D:\\TestWorkspace";
//		String fileTitle = "投顾场外交易指令单";
//		String filePath = fileDir+File.separator+fileTitle+"_"+DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER)+".xls";
		String pageUrl = "";
		try {
			//创建Excel文件
			HSSFWorkbook workbook = new HSSFWorkbook();
			
			//设置列头字体格式
			HSSFFont headFont = workbook.createFont();
			headFont.setFontName("宋体");
			headFont.setFontHeightInPoints((short) 11);// 字体大小
			headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗
			//设置列头字体对齐格式
			HSSFCellStyle headFormat = workbook.createCellStyle();
			headFormat.setFont(headFont);
			headFormat.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			headFormat.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			headFormat.setLocked(true);
			headFormat.setWrapText(true);// 自动换行
			
			//设置字体格式
			HSSFFont columnHeadFont = workbook.createFont();
			columnHeadFont.setFontName("宋体");
			columnHeadFont.setFontHeightInPoints((short) 10);// 字体大小
			//左对齐
			HSSFCellStyle BoldUnderlineLEFT = workbook.createCellStyle();
			BoldUnderlineLEFT.setFont(columnHeadFont);
			BoldUnderlineLEFT.setLocked(true);
			BoldUnderlineLEFT.setWrapText(true);// 自动换行
			//居中对齐
			HSSFCellStyle BoldUnderlineCENTRE = workbook.createCellStyle();
			BoldUnderlineCENTRE.setFont(columnHeadFont);
			BoldUnderlineCENTRE.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			BoldUnderlineCENTRE.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			BoldUnderlineCENTRE.setLocked(true);
			BoldUnderlineCENTRE.setWrapText(true);// 自动换行
			
			//债券买卖
			HSSFSheet sheet_ZQMM = workbook.createSheet("债券买卖");
			//创建第一行
			HSSFRow row0_ZQMM = sheet_ZQMM.createRow(0);
			String[] headTitle_ZQMM = new String[]{"序号", "业务日期", "有效截止日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号", "业务类别"
					, "债券代码", "债券名称", "债券类别", "主体评级", "债券评级", "清算速度", "清算类型", "交易场所", "券面金额（万元）", "交易对手", "净价（元/百元面值）"
					, "全价（元/百元面值）", "收益率类型", "收益率", "交易员代码", "席位号", "约定号"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
					
			//创建列
			int export_length_ZQMM = headTitle_ZQMM.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_ZQMM = headTitle_ZQMM.length;
			}
			for(int i=0; i<export_length_ZQMM; i++){
				HSSFCell cell = row0_ZQMM.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_ZQMM[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_ZQMM.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_ZQMM.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			
			//正逆回购
			HSSFSheet sheet_ZNHG = workbook.createSheet("正逆回购");
			//创建第一行
			HSSFRow row0_ZNHG = sheet_ZNHG.createRow(0);
			String[] headTitle_ZNHG = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号", "业务类别"
					, "交易对手", "券面总额合计（万元）", "交易金额（万元）", "回购期限（天）", "回购利率（%）", "首次结算日", "到期结算日", "债券代码", "债券名称", "券面总额（万元）"
					, "折算比例（%）", "首次净价（元）"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
			
			//创建列
			int export_length_ZNHG = headTitle_ZNHG.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_ZNHG = headTitle_ZNHG.length;
			}
			for(int i=0; i<export_length_ZNHG; i++){
				HSSFCell cell = row0_ZNHG.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_ZNHG[i])));
				//cell.setCe
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_ZNHG.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_ZNHG.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			
			//申购缴款
			HSSFSheet sheet_ZQSJ = workbook.createSheet("申购缴款");
			//创建第一行
			HSSFRow row0_ZQSJ = sheet_ZQSJ.createRow(0);
			String[] headTitle_ZQSJ = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号", "业务类别"
					, "债券代码", "债券名称", "债券类别", "主体评级", "债券评级", "缴款场所", "评级机构", "交易数量（万元）", "投标利率", "投标价格（元/百元面值）"
					, "投标场所", "承销商", "清算速度", "交割方式"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
			
			//创建列
			int export_length_ZQSJ = headTitle_ZQSJ.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_ZQSJ = headTitle_ZQSJ.length;
			}
			for(int i=0; i<export_length_ZQSJ; i++){
				HSSFCell cell = row0_ZQSJ.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_ZQSJ[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_ZQSJ.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_ZQSJ.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			
			//基金申赎
			HSSFSheet sheet_JJSS = workbook.createSheet("基金申赎");
			//创建第一行
			HSSFRow row0_JJSS = sheet_JJSS.createRow(0);
			String[] headTitle_JJSS = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号", "业务类别"
					, "基金代码", "基金名称", "数量（元/份额）", "转入基金代码", "转入基金名称"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
			
			//创建列
			int export_length_JJSS = headTitle_JJSS.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_JJSS = headTitle_JJSS.length;
			}
			for(int i=0; i<export_length_JJSS; i++){
				HSSFCell cell = row0_JJSS.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_JJSS[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_JJSS.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_JJSS.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			/*
			//同业存取
			HSSFSheet sheet_TYCQ = workbook.createSheet("同业存取");
			//创建第一行
			HSSFRow row0_TYCQ = sheet_TYCQ.createRow(0);
			String[] headTitle_TYCQ = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号", "业务类别"
					, "数量（万元）", "起息日", "到期日", "存款利率", "存款期限", "提前支取条款", "交易对手"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
			
			//创建列
			int export_length_TYCQ = headTitle_TYCQ.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_TYCQ = headTitle_TYCQ.length;
			}
			for(int i=0; i<export_length_TYCQ; i++){
				HSSFCell cell = row0_TYCQ.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_TYCQ[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_TYCQ.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_TYCQ.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			
			//追加提取
			HSSFSheet sheet_ZJZT = workbook.createSheet("追加提取");
			//创建第一行
			HSSFRow row0_ZJZT = sheet_ZJZT.createRow(0);
			String[] headTitle_ZJZT = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号", "业务类别"
					, "金额", "要求到账时间"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
			
			//创建列
			int export_length_ZJZT = headTitle_ZJZT.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_ZJZT = headTitle_ZJZT.length;
			}
			for(int i=0; i<export_length_ZJZT; i++){
				HSSFCell cell = row0_ZJZT.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_ZJZT[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_ZJZT.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_ZJZT.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			*/
			
			//大宗交易
			HSSFSheet sheet_DZJY = workbook.createSheet("大宗交易");
			//创建第一行
			HSSFRow row0_DZJY = sheet_DZJY.createRow(0);
			String[] headTitle_DZJY = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号"
					,"证券代码","证券名称", "买卖方向","指令价格","委托数量","对方席位号","约定号"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "执行交易员ID", "执行交易员姓名", "交易员执行时间"};
			
			//创建列
			int export_length_DZJY = headTitle_DZJY.length-6;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_DZJY = headTitle_DZJY.length;
			}
			for(int i=0; i<export_length_DZJY; i++){
				HSSFCell cell = row0_DZJY.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_DZJY[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_DZJY.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_DZJY.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			
			//投票
			HSSFSheet sheet_TP = workbook.createSheet("投票");
			//创建第一行
			HSSFRow row0_TP = sheet_TP.createRow(0);
			String[] headTitle_TP = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号"
					, "证券代码", "证券名称", "赞成议案", "反对议案", "弃权议案"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "执行交易员ID", "执行交易员姓名", "交易员执行时间"};
			
			//创建列
			int export_length_TP = headTitle_TP.length-6;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_TP = headTitle_TP.length;
			}
			for(int i=0; i<export_length_TP; i++){
				HSSFCell cell = row0_TP.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_TP[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_TP.setColumnWidth((short)i, (short)2000);//设置列宽
				}else if(i == 9 || i == 10 || i == 11){
					sheet_TP.setColumnWidth((short)i, (short)15000);//设置列宽
				}else{
					sheet_TP.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			
			//其他指令/建议
			HSSFSheet sheet_QTZL = workbook.createSheet("其他指令|建议");
			//创建第一行
			HSSFRow row0_QTZL = sheet_QTZL.createRow(0);
			String[] headTitle_QTZL = new String[]{"序号", "业务日期", "产品代码", "产品名称", "投资组合编号", "投资组合名称", "编号"
					, "内容"
					, "废弃原因", "废弃时间", "备注", "交易状态", "询价员ID", "询价员姓名", "询价时间", "询价修改时间", "录入员ID", "录入员姓名", "录入时间", "录入修改时间"
					, "补齐员ID", "补齐员姓名", "补齐时间", "补齐修改时间", "确认员ID", "确认员姓名", "确认时间", "下单投资经理ID", "下单投资经理姓名", "投资经理下单时间", "填单交易员ID", "填单交易员姓名", "交易员填单时间"
					, "交易已发送执行员ID", "交易已发送执行员姓名", "交易已发送执行时间", "前台已成交执行员ID", "前台已成交执行员姓名", "前台已成交执行时间", "后台已成交执行员ID", "后台已成交执行员姓名", "后台已成交执行时间"};
			
			//创建列
			int export_length_QTZL = headTitle_QTZL.length-15;
			if(EXPORT_TYPE_ALL.equals(exportType)){
				export_length_QTZL = headTitle_QTZL.length;
			}
			for(int i=0; i<export_length_QTZL; i++){
				HSSFCell cell = row0_QTZL.createCell((short)i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_QTZL[i])));
				cell.setCellStyle(headFormat);
				if(i==0){//序号
					sheet_QTZL.setColumnWidth((short)i, (short)2000);//设置列宽
				}else{
					sheet_QTZL.setColumnWidth((short)i, (short)5000);//设置列宽
				}
			}
			
			//二级债页面导出
			HSSFSheet sheet_SM_MM = null;
			HSSFRow row0_SM_MM = null;
			String[] HeadTitle_SM_MM = null;
			int export_length_SM_MM = 0;
			HSSFSheet sheet_SM_HG = null;
			HSSFRow row0_SM_HG = null;
			String[] HeadTitle_SM_HG = null;
			int export_length_SM_HG = 0;
			
			if(webType!=null && "1".equals(webType)){
			//  二级债买卖指令
				sheet_SM_MM = workbook.createSheet("现券买卖");
				//创建第一行
				row0_SM_MM = sheet_SM_MM.createRow(0);
				HeadTitle_SM_MM = new String[]{"序号", "指令序号", "风控审批状态", "指令状态", "产品名称", "组合名称", "业务类别", "清算速度", "委托方向", "债券代码", "债券名称", "券面金额（万元）", " 投资建议录入日期", 
						"交易日", "结算日", "指令净价", "指令全价", "指令到期收益率（%）", "指令行权收益率（%）", "投资建议录入时间", "投顾确认时间", "委托人确认时间", "投资经理确认时间",
						"指令推送状态", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "备注"};
				//创建列
				export_length_SM_MM = HeadTitle_SM_MM.length;
				for(int i=0; i<export_length_SM_MM; i++){
					HSSFCell cell = row0_SM_MM.createCell((short)i);
					cell.setCellValue((RichTextString)(new HSSFRichTextString(HeadTitle_SM_MM[i])));
					cell.setCellStyle(headFormat);
					if(i==0){//序号
						sheet_SM_MM.setColumnWidth((short)i, (short)2000);//设置列宽
					}else{
						sheet_SM_MM.setColumnWidth((short)i, (short)5000);//设置列宽
					}
				}
				
				//  二级债回购指令
				sheet_SM_HG = workbook.createSheet("回购业务");
				//创建第一行
				row0_SM_HG = sheet_SM_HG.createRow(0);
				HeadTitle_SM_HG = new String[]{"序号", "指令序号", "风控审批状态", "指令状态", "产品名称", "组合名称", "业务类别", "清算速度", "委托方向", "回购天数(天)", "回购利率(%)", "投资建议录入日期", "交易日", "首次结算日", "到期结算日", "首次结算金额(元)", "到期结算金额(元)", "报价方式", "加权加点(bp)", "投资建议录入时间", "投顾确认时间", "委托人确认时间", "投资经理确认时间", "指令推送状态", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "债券代码", "债券名称", "券面金额(万元)", "折算比例(%)", "备注", "指令编号"};
				//创建列
				export_length_SM_HG = HeadTitle_SM_HG.length;
				for(int i=0; i<export_length_SM_HG; i++){
					HSSFCell cell = row0_SM_HG.createCell((short)i);
					cell.setCellValue((RichTextString)(new HSSFRichTextString(HeadTitle_SM_HG[i])));
					cell.setCellStyle(headFormat);
					if(i==0){//序号
						sheet_SM_HG.setColumnWidth((short)i, (short)2000);//设置列宽
					}else{
						sheet_SM_HG.setColumnWidth((short)i, (short)5000);//设置列宽
					}
				}
			}
			
			//初始化下标
			int index_ZQMM = 0;//债券买卖
			int index_ZNHG = 0;//正逆回购
			int index_ZQSJ = 0;//申购缴款
			int index_JJSS = 0;//基金申赎
			int index_TYCQ = 0;//同业存取
			int index_ZJZT = 0;//追加提取
			int index_QTZL = 0;//其他指令/建议
			int index_DZJY = 0;//大宗交易
			int index_TP = 0;//投票
			int index_SM_MM = 0;//买卖
			int index_SM_HG = 0;//回购
			
			for (int i=0; i<productProcessData.length; i++) {
				DataObject obj = productProcessData[i];

				String vcBizType = StrUtil.changeNull(obj.getString("vcBizType"));
				// 二级债买卖和回购指令
				if("1".equals(vcBizType) || "2".equals(vcBizType) || "3".equals(vcBizType) || "4".equals(vcBizType) || "5".equals(vcBizType) || "6".equals(vcBizType) || "7".equals(vcBizType)){
					
					String lInstructNo = StrUtil.changeNull(obj.getString("lInstructNo"));
					String vcRiskApproveStatus = StrUtil.changeNull(obj.getString("vcRiskApproveStatus"));
					String cIsValid = StrUtil.changeNull(obj.getString("cIsValid"));
					String vcProductName = StrUtil.changeNull(obj.getString("vcProductName"));
					String vcCombiName = StrUtil.changeNull(obj.getString("vcCombiName"));
					String vcSettleSpeed = StrUtil.changeNull(obj.getString("vcSettleSpeed"));
					String vcEntrustDirection = StrUtil.changeNull(obj.getString("vcEntrustDirection"));
					String vcStockCode = StrUtil.changeNull(obj.getString("vcStockCode"));
					String vcStockName = StrUtil.changeNull(obj.getString("vcStockName"));
					String enFaceAmount = StrUtil.changeNull(obj.getString("enFaceAmount"));
					String lIssueDate = "";
					String lTradeDate = "";
					String lFirstSettleDate = "";
					String vcBizTypeText = ""; 
					String lMaturitySettleDate = "";
					// 指令下达日期
					if(obj.getDate("lIssueDate") != null){
						lIssueDate = String.valueOf(obj.getLong("lIssueDate"));
						lIssueDate = lIssueDate.substring(0,4)+"-"+lIssueDate.substring(4,6)+"-"+lIssueDate.substring(6,8);
					}
					// 交易日
					if(obj.getString("lTradeDate") != null){
						lTradeDate = String.valueOf(obj.getLong("lTradeDate"));
						lTradeDate = lTradeDate.substring(0,4)+"-"+lTradeDate.substring(4,6)+"-"+lTradeDate.substring(6,8);
					}
					// 结算日
					if(obj.getString("lFirstSettleDate") != null){
						lFirstSettleDate = String.valueOf(obj.getLong("lFirstSettleDate"));
						lFirstSettleDate = lFirstSettleDate.substring(0,4)+"-"+lFirstSettleDate.substring(4,6)+"-"+lFirstSettleDate.substring(6,8);
					}
					// 委托方向翻译
					if(obj.getString("vcEntrustDirection") != null){
						vcEntrustDirection = getDictidName("entrustDirection", vcEntrustDirection);
					}
					// 业务类别翻译
					if(obj.getString("vcBizType") != null){
						vcBizTypeText = getDictidName("bizTypeAll", vcBizType);
					}
					String enNetPrice = StrUtil.changeNull(obj.getString("enNetPrice"));
					String enFullPrice = StrUtil.changeNull(obj.getString("enFullPrice"));
					String enMaturityYield = StrUtil.changeNull(obj.getString("enMaturityYield"));
					String maturityYield = StrUtil.changeNull(obj.getString("enMaturityYield"));
					String vcAdviserConfirm = StrUtil.changeNull(obj.getString("vcAdviserConfirm"));
					String vcEntrustConfirm = StrUtil.changeNull(obj.getString("vcEntrustConfirm"));
					String tFsSendTime = "";
					String vcFsSenderName = "";
					String fixValidStatus = StrUtil.changeNull(obj.getString("lFixValidStatus"));
					String tFsOperateTime = "";
					String tFsCheckTime = "";
					String tFsDealTime = "";
					
					String vcBsDealStatus = StrUtil.changeNull(obj.getString("vcBsDealStatus"));
					String vcMarket = StrUtil.changeNull(obj.getString("vcMarket"));
					String tInitiateTime = "";
					String tResultInputTime = "";
					String enOptionYield = StrUtil.changeNull(obj.getString("enOptionYield"));
					String vcRemark = StrUtil.changeNull(obj.getString("vcRemark"));
					// 时间显示格式
					SimpleDateFormat dateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					// 指令下达时间
					if(obj.getString("tInitiateTime") != null){
						tInitiateTime = obj.getString("vcInitiatorName") +" "+ dateTime.format(obj.getDate("tInitiateTime"));
					}
					// 询价结果录入时间
					if(obj.getString("tResultInputTime") != null){
						tResultInputTime = obj.getString("vcResultInputerName") +" "+ dateTime.format(obj.getDate("tResultInputTime"));
					}
					// 投资经理确认时间
					if(obj.getString("tFsSendTime") != null && obj.getString("vcFsSenderName") != null){
						tFsSendTime = obj.getString("vcFsSenderName") +" "+ dateTime.format(obj.getDate("tFsSendTime"));
					}
					// 前台录单时间
					if(obj.getString("tFsOperateTime") != null){
						tFsOperateTime = obj.getString("vcFsOperatorName") +" "+ dateTime.format(obj.getDate("tFsOperateTime"));
					}
					// 前台发送时间
					if(obj.getString("tFsCheckTime") != null){
						tFsCheckTime = obj.getString("vcFsCheckerName") +" "+ dateTime.format(obj.getDate("tFsCheckTime"));
					}
					// 前台成交时间
					if(obj.getString("tFsDealTime") != null){
						tFsDealTime = dateTime.format(obj.getDate("tFsDealTime"));
					}
					// 指令状态翻译
					if(cIsValid != ""){
						cIsValid = getDictidName("instructStatus", cIsValid);
					}
					// 风控审批状态翻译
					if(vcRiskApproveStatus != ""){
						vcRiskApproveStatus = getDictidName("riskApproveStatus", vcRiskApproveStatus);
					}else{
						vcRiskApproveStatus = "--";
					}
					// 后台成交状态翻译
					if(vcBsDealStatus != ""){
						vcBsDealStatus = getDictidName("CF_JY_HTCJZT", vcBsDealStatus);
					}
					// 交易市场翻译
					if(vcMarket != ""){
						vcMarket = getDictidName("tradePlace", vcMarket);
					}
					// 清算速度翻译
					if(vcSettleSpeed != ""){
						vcSettleSpeed = getDictidName("settleSpeed", vcSettleSpeed);
					}
					// 指令推送状态
					fixValidStatus = obj.getString("lFixValidStatus");
					if(fixValidStatus == null || fixValidStatus.equals("") || fixValidStatus.equals("0")){
						fixValidStatus = "未发送";
			    	}else if(fixValidStatus.equals("1")){
			    		fixValidStatus = "不启用";
			    	}else if(fixValidStatus.equals("2")){
			    		fixValidStatus = "发送中";
			    	}else if(fixValidStatus.equals("3")){
			    		fixValidStatus = "发送成功";
			    	}else if(fixValidStatus.equals("4")){
			    		fixValidStatus = "发送失败";
			    	}
					// 二级债--买卖业务
					if("1".equals(vcBizType) || "2".equals(vcBizType) || "3".equals(vcBizType) || "4".equals(vcBizType)){
						index_SM_MM++;
						String[] column = new String[]{String.valueOf(index_SM_MM), lInstructNo, vcRiskApproveStatus, cIsValid, vcProductName, vcCombiName, vcBizTypeText
								, vcSettleSpeed, vcEntrustDirection, vcStockCode, vcStockName, enFaceAmount, lIssueDate, lTradeDate
								, lFirstSettleDate, enNetPrice, enFullPrice, enMaturityYield, enOptionYield, tInitiateTime, vcAdviserConfirm, vcEntrustConfirm, tFsSendTime, fixValidStatus, 
								tFsOperateTime, tFsCheckTime, tFsDealTime
								, vcBsDealStatus, vcRemark};
						
						//创建行
						HSSFRow row = sheet_SM_MM.createRow(index_SM_MM);
						//创建列
						for(int j=0; j<export_length_SM_MM; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
					}
					// 二级债--回购业务
					if("5".equals(vcBizType) || "6".equals(vcBizType) || "7".equals(vcBizType)){
						index_SM_HG++;
						// 到期结算日期
						if(obj.getString("lMaturitySettleDate") != null){
							lMaturitySettleDate = String.valueOf(obj.getLong("lMaturitySettleDate"));
							lMaturitySettleDate = lMaturitySettleDate.substring(0,4)+"-"+lMaturitySettleDate.substring(4,6)+"-"+lMaturitySettleDate.substring(6,8);
						}
						// 报价方式翻译
						String vcQuoteMode = "";
						if(obj.getString("vcQuoteMode") != null){
							vcQuoteMode = getDictidName("quoteMode",obj.getString("vcQuoteMode"));
						}
						String lRepoDays = obj.getString("lRepoDays");
						String enRepoRate = obj.getString("enRepoRate");
						String enFullPriceAmount = obj.getString("enFullPriceAmount");
						String enSettleAmount = obj.getString("enSettleAmount");
						String enWeightingValue = obj.getString("enWeightingValue");
						String conversionRatio = obj.getString("conversionRatio");
						String lResultId = obj.getString("lResultId");
						String[] column = new String[]{String.valueOf(index_SM_HG), lInstructNo, vcRiskApproveStatus, cIsValid, vcProductName, vcCombiName, vcBizTypeText
								, vcSettleSpeed, vcEntrustDirection, lRepoDays, enRepoRate, lIssueDate, lTradeDate, lFirstSettleDate
								, lMaturitySettleDate, enFullPriceAmount, enSettleAmount, vcQuoteMode, enWeightingValue, tInitiateTime, vcAdviserConfirm, vcEntrustConfirm, tFsSendTime, 
								fixValidStatus, tFsOperateTime, tFsCheckTime
								, tFsDealTime, vcBsDealStatus, vcStockCode, vcStockName, enFaceAmount, conversionRatio, vcRemark, lResultId};
						//获取质押券信息
						DataObject[] bonds = null;
						try {
							ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.commonUtil.ProductManager");
							Object[] objArr = comp.invoke("exportBbGetMortgageInfo", new String[] { lResultId });//调用逻辑流的方法
							if (objArr != null && objArr.length > 0) {
								bonds = (DataObject[]) objArr[0];
							}
						} catch (Throwable e) {
							e.printStackTrace();
						}
						DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsInquiryResultMortagage");
						//存在债券信息
						if (bonds != null && bonds.length > 0) {
							for (int bondNum = 0; bondNum < bonds.length; bondNum++) {
								bond = bonds[bondNum];
								vcStockCode = StrUtil.changeNull(bond.getString("vcStockCode"));
								vcStockName = StrUtil.changeNull(bond.getString("vcStockName"));
								enFaceAmount = StrUtil.changeNull(bond.getString("enFaceAmount")).replaceAll(",", "");
								conversionRatio = StrUtil.changeNull(bond.getString("enMortagageRatio"));
								//判断券面总额(万元)是否为空，不为空时执行替换
								if(!conversionRatio.equals("")){
									conversionRatio = conversionRatio.replaceAll(",", "");
								}
								StrUtil.nf.setGroupingUsed(false);
								if (bondNum == 0) {
									column[28] = vcStockCode;
									column[29] = vcStockName;
									column[30] = enFaceAmount;
									column[31] = conversionRatio;
									//创建数据行
									HSSFRow row = sheet_SM_HG.createRow(index_SM_HG);
									//创建数据列
									for(int j=0; j<export_length_SM_HG; j++){
										HSSFCell cell = row.createCell((short)j);
										cell.setCellStyle(BoldUnderlineCENTRE);
										cell.setCellValue((RichTextString)new HSSFRichTextString(column[j]));
									}
								}else {
									String[] bondStrArr = new String[] {vcStockCode, vcStockName, enFaceAmount, conversionRatio};
									//创建数据行
									HSSFRow row = sheet_SM_HG.createRow(index_SM_HG);
									//创建数据列
									for(int j=0; j<bondStrArr.length; j++){
										HSSFCell cell = null;
										if (j == 0) {
											cell = row.createCell((short) (j + 28));
										} else {
											cell = row.createCell((short) (j + 28));
										}
										cell.setCellStyle(BoldUnderlineCENTRE);
										cell.setCellValue((RichTextString)(new HSSFRichTextString(bondStrArr[j])));
										
									}
								}
							} 
						}else{
							column[28] = "";
							column[29] = "";
							column[30] = "";
							column[31] = "";
							//创建数据行
							HSSFRow row = sheet_SM_HG.createRow(index_SM_HG);
							//创建数据列
							for(int j=0; j<export_length_SM_HG; j++){
								HSSFCell cell = row.createCell((short)j);
								cell.setCellStyle(BoldUnderlineCENTRE);
								cell.setCellValue((RichTextString)new HSSFRichTextString(column[j]));
							}
						}
					}
					
				}else{
					String processId = StrUtil.changeNull(obj.getString("processId"));//主键ID
					String processDate = DateUtil.format(obj.getDate("processDate"));//处理日期
					String expiredate = DateUtil.format(obj.getDate("expiredate"));//指令有效日期
					String combProductCode = StrUtil.changeNull(obj.getString("combProductCode"));//产品代码
					String combProductName = StrUtil.changeNull(obj.getString("combProductName"));//产品名称
					String vcCombiNo = StrUtil.changeNull(obj.getString("vcCombiNo"));//投资组合编号
					String vcCombiName = StrUtil.changeNull(obj.getString("vcCombiName"));//投资组合名称
					String vcAssetId = StrUtil.changeNull(obj.getString("vcAssetId"));//资产单元序号
					String investProductNum = StrUtil.changeNull(obj.getString("investProductNum"));//编号
					String processType = StrUtil.changeNull(obj.getString("processType"));//业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;16-交易所协议正回购;17-交易所协议逆回购;99-其他指令/建议;
					String processStatus = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_STATUS, StrUtil.changeNull(obj.getString("processStatus")));//指令/建议流程处理状态：-2-指令/建议询价录入完成；-1-交易员填单指令/建议补齐完成；0-投资顾问录入完成；1-指令/建议录入确认完成；2-投资经理下单确认完成；3-交易员填单确认完成；4-交易已发送确认完成；5-前台已成交确认完成；6-后台已成交确认完成；
					String validStatus = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_VALID_STATUS, StrUtil.changeNull(obj.getString("validStatus")));//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
					String abandonedReasons = StrUtil.changeNull(obj.getString("abandonedReasons"));//废弃原因
					String isNotExport = StrUtil.changeNull(obj.getString("isNotExport"));//是否已经导出：0-否;1-是;			
					String isInquiry = StrUtil.changeNull(obj.getString("isInquiry"));//是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
					String inquiryId = StrUtil.changeNull(obj.getString("inquiryId"));//询价员ID
					String inquiryName = StrUtil.changeNull(obj.getString("inquiryName"));//询价员姓名
					String inquiryCd = DateUtil.formatDateTime(obj.getDate("inquiryCd"));//询价时间
					String inquiryMd = DateUtil.formatDateTime(obj.getDate("inquiryMd"));//询价修改时间				
					String completeInstructionsId = StrUtil.changeNull(obj.getString("completeInstructionsId"));//指令/建议补齐员ID
					String completeInstructionsName = StrUtil.changeNull(obj.getString("completeInstructionsName"));//指令/建议补齐员姓名
					String completeInstructionsCd = DateUtil.formatDateTime(obj.getDate("completeInstructionsCd"));//指令/建议补齐时间
					String completeInstructionsMd = DateUtil.formatDateTime(obj.getDate("completeInstructionsMd"));//指令/建议补齐修改时间
					String investAdviserId = StrUtil.changeNull(obj.getString("investAdviserId"));//指令/建议录入ID
					String investAdviserName = StrUtil.changeNull(obj.getString("investAdviserName"));//指令/建议录入姓名
					String investAdviserCd = DateUtil.formatDateTime(obj.getDate("investAdviserCd"));//指令/建议录入时间
					String investAdviserMd = DateUtil.formatDateTime(obj.getDate("investAdviserMd"));//指令/建议录入修改时间
					String investAdviserConfirmId = StrUtil.changeNull(obj.getString("investAdviserConfirmId"));//指令/建议确认ID
					String investAdviserConfirmName = StrUtil.changeNull(obj.getString("investAdviserConfirmName"));//指令/建议确认姓名
					String investAdviserConfirmCd = DateUtil.formatDateTime(obj.getDate("investAdviserConfirmCd"));//指令/建议确认时间
					String investManagerId = StrUtil.changeNull(obj.getString("investManagerId"));//下单投资经理ID
					String investManagerName = StrUtil.changeNull(obj.getString("investManagerName"));//下单投资经理姓名
					String investManagerCd = DateUtil.formatDateTime(obj.getDate("investManagerCd"));//投资经理下单时间
					String traderId = StrUtil.changeNull(obj.getString("traderId"));//填单交易员ID
					String traderName = StrUtil.changeNull(obj.getString("traderName"));//填单交易员姓名
					String traderCd = DateUtil.formatDateTime(obj.getDate("traderCd"));//交易员填单时间
					String reviewId = StrUtil.changeNull(obj.getString("reviewId"));//交易已发送执行员ID
					String reviewName = StrUtil.changeNull(obj.getString("reviewName"));//交易已发送执行员姓名
					String reviewCd = DateUtil.formatDateTime(obj.getDate("reviewCd"));//交易已发送执行时间
					String sendId = StrUtil.changeNull(obj.getString("sendId"));//前台已成交执行员ID
					String sendName = StrUtil.changeNull(obj.getString("sendName"));//前台已成交执行员姓名
					String sendCd = DateUtil.formatDateTime(obj.getDate("sendCd"));//前台已成交执行时间
					String backstageTraderId = StrUtil.changeNull(obj.getString("backstageTraderId"));//后台已成交员ID
					String backstageTraderName = StrUtil.changeNull(obj.getString("backstageTraderName"));//后台已成交员姓名
					String backstageTraderCd = DateUtil.formatDateTime(obj.getDate("backstageTraderCd"));//后台已成交执行时间
					String remark = StrUtil.changeNull(obj.getString("remark"));//备注
					String investProductName = StrUtil.changeNull(obj.getString("investProductName"));//1.3.债券名称/2.质押券名称/4.基金名称/5.存款产品
					String investProductCode = StrUtil.changeNull(obj.getString("investProductCode"));//1.3.债券代码/2.质押券代码（逆回购质押券可以空）/4.基金代码
					String investCount = StrUtil.changeNull(obj.getString("investCount"));//1.3.交易数量（万元）/2.券面总额合计（万元）/4.数量（万元\份额）/5.数量（万元）/6.金额
					String netPrice = StrUtil.changeNull(obj.getString("netPrice"));//1.净价（元/百元面值）/3.投标价格（元/百元面值）
					String fullPrice = StrUtil.changeNull(obj.getString("fullPrice"));//1.全价(元/百元面值) 
					String interestRate = StrUtil.changeNull(obj.getString("interestRate"));//1.收益率（到期/行权）/3.投标利率（到期/行权）
					String bondRating = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_BOND_RATING, obj.getString("bondRating"));//1.3.债券评级：01-AAA及以上;02-AA+;03-AA;04-AA-;05-A及以下;06-短融A-1;99-其他;
					//----////
					String investCategory = StrUtil.changeNull(obj.getString("investCategory"));//1.3.债券类别[01-利率债;02-公司债;03-中票;04-短融;05-企业债;06-小公募;07-非公开企业债;08-PPN;09-ABS优先级;10-ABS劣后级;99-其他;]/2.交易品种/4.基金类别
					String tradingOpponent = StrUtil.changeNull(obj.getString("tradingOpponent"));//1.2.5交易对手
					String clearingSpeed = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_CLEARING_SPEED, obj.getString("clearingSpeed"));//1.3.清算速度：T+0、T+1
					String cleartype = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_CLEAR_TYPE, obj.getString("cleartype"));//清算类型:1-全额结算;2-净额结算;
					//----////
					String deliveryMethod = StrUtil.changeNull(obj.getString("deliveryMethod"));//1.3.交割方式/4.交易方向
					String pledgeRatio = StrUtil.changeNull(obj.getString("pledgeRatio"));//2.质押比率
					String tradingRate = StrUtil.changeNull(obj.getString("tradingRate"));//2.回购利率（%）/5.存款利率
					String actualDays = StrUtil.changeNull(obj.getString("actualDays"));//2.回购期限（天）
					String dueDate = StrUtil.changeNull(obj.getString("dueDate"));//2.到期日期/5.到期日
					String firstSettlement = StrUtil.changeNull(obj.getString("firstSettlement"));//2.首期结算方式
					String dueSettlement = StrUtil.changeNull(obj.getString("dueSettlement"));//2.到期结算方式
					String subjectRating = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_SUBJECT_RATING, StrUtil.changeNull(obj.getString("subjectRating")));//1.3.主体评级：01-AAA及以上;02-AA+;03-AA;04-AA-;05-A及以下;99-其他;
					String ratingAgencies = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_RATING_AGENCIES, StrUtil.changeNull(obj.getString("ratingAgencies")));//3.评级机构：01-大公国际;02-联合信用;03-东方金诚;04-鹏元资信;05-中诚信;06-上海新世纪;07-中债资信;
					String paymentPlace = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PAYMENT_PLACE, StrUtil.changeNull(obj.getString("paymentPlace")));//3.缴款场所：01-中债;02-上清;03-主承;
					String leadUnderwriter = StrUtil.changeNull(obj.getString("leadUnderwriter"));//3.主承销商
					String tradingTime = StrUtil.changeNull(obj.getString("tradingTime"));//4.交易时间
					String memo = StrUtil.changeNull(obj.getString("memo"));//4.备注（基金公司联系人、基金转换为哪支基金等信息）/5.备注（托管行联系人等信息）
					String startInterestDate = StrUtil.changeNull(obj.getString("startInterestDate"));//5.起息日
					String depositTerm = StrUtil.changeNull(obj.getString("depositTerm"));//5.存款期限
					String earlyWithdrawalClause = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_EARLY_WITHDRAWAL_CLAUSE, StrUtil.changeNull(obj.getString("earlyWithdrawalClause")));//5.提前支取条款：01-利息不变;02-利息损失;
					String demandArrivalTime = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_DEMAND_ARRIVAL_TIME, StrUtil.changeNull(obj.getString("demandArrivalTime")));//6.要求到账时间：10:00、11:00、13:00、14:00、15:00、16:00、17:00
					String interestRateType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE ,StrUtil.changeNull(obj.getString("interestRateType")));//1.收益率类型：01-到期;02-行权;
					String traderCode = StrUtil.changeNull(obj.getString("traderCode"));//1.交易员代码
					String agreementNum = StrUtil.changeNull(obj.getString("agreementNum"));//1.约定号
					String seatNum = StrUtil.changeNull(obj.getString("seatNum"));//1.席位号
					//----////
					String tradingPlace = StrUtil.changeNull(obj.getString("tradingPlace"));//1.交易场所[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]/3.投标场所[01-银行间;02-交易所;]
					String tranAmount = StrUtil.changeNull(obj.getString("tranAmount"));//2.交易金额（万元）
					String firstSettlementDate = StrUtil.changeNull(obj.getString("firstSettlementDate"));//2.首次结算日（日期）
					String expiryDate = StrUtil.changeNull(obj.getString("expiryDate"));//2.到期结算日（日期）
					String transformFundCode = StrUtil.changeNull(obj.getString("transformFundCode"));//4.转入基金代码
					String transformFundName = StrUtil.changeNull(obj.getString("transformFundName"));//4.转入基金名称
					String tpZcya = StrUtil.changeNull(obj.getString("tpZcya"));//赞成议案
					String tpFdyz = StrUtil.changeNull(obj.getString("tpFdyz"));//反对议案
					String tpQqya = StrUtil.changeNull(obj.getString("tpQqya"));//弃权议案
					
					
					//债券买卖：01-债券买入;02-债券卖出;
					if("01".equals(processType) || "02".equals(processType)){
						index_ZQMM++;
						
						processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM, processType);
						investCategory = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_BOND_CATEGORY, investCategory);//1.3.债券类别[01-利率债;02-公司债;03-中票;04-短融;05-企业债;06-小公募;07-非公开企业债;08-PPN;09-ABS优先级;10-ABS劣后级;99-其他;]
						tradingPlace = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_TRADING_PLACE, tradingPlace);//1.交易场所[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]/3.投标场所[01-银行间;02-交易所;]
						String[] column = new String[]{String.valueOf(index_ZQMM), processDate, expiredate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
								, investProductCode, investProductName, investCategory, subjectRating, bondRating, clearingSpeed, cleartype, tradingPlace, investCount, tradingOpponent, netPrice
								, fullPrice, interestRateType, interestRate, traderCode, seatNum, agreementNum
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
								, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
						
						//创建行
						HSSFRow row = sheet_ZQMM.createRow(index_ZQMM);
						//创建列
						for(int j=0; j<export_length_ZQMM; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
						
						
					//03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;16-交易所协议正回购;17-交易所协议逆回购;21-交易所正回购；22-交易所逆回购；
					}else if("03".equals(processType) || "04".equals(processType) || "05".equals(processType) || "06".equals(processType) || "16".equals(processType) || "17".equals(processType) || "21".equals(processType) || "22".equals(processType)){
						processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG, processType);
						
						//获取债券信息
						DataObject[] bonds = null;
						try {
							ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.jy.ProductProcess.JY_ZNHG");
							Object[] objArr = comp.invoke("JY_ZNHG_queryBondsByProcessId", new String[]{processId});//调用逻辑流的方法
							if(objArr!=null && objArr.length>0){
								bonds =  (DataObject[]) objArr[0];
							}
						} catch (Throwable e) {
							e.printStackTrace();
						}
						
						String bondCode = "";//债券代码
						String bondName = "";//债券名称
						String bondAmount = "";//券面总额（万元）
						String conversionRatio = "";//折算比例（%）
						String firstNetValue = "";//首次净价（元）
						DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhgBond");
						
						//存在债券信息
						if(bonds!=null && bonds.length>0){
							for(int bondNum=0; bondNum<bonds.length; bondNum++){
								index_ZNHG++;
								bond = bonds[bondNum];
								bondCode = StrUtil.changeNull(bond.getString("bondCode"));
								bondName = StrUtil.changeNull(bond.getString("bondName"));
								bondAmount = StrUtil.changeNull(bond.getString("bondAmount"));
								conversionRatio = StrUtil.changeNull(bond.getString("conversionRatio"));
								firstNetValue = StrUtil.changeNull(bond.getString("firstNetValue"));
								
								if(bondNum==0){
									String[] column = new String[]{String.valueOf(index_ZNHG), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
											, tradingOpponent, investCount, tranAmount, actualDays, tradingRate, firstSettlementDate, expiryDate, bondCode, bondName, bondAmount
											, conversionRatio, firstNetValue
											, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
											, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
											, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
									
									//创建行
									HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
									//创建列
									for(int j=0; j<export_length_ZNHG; j++){
										HSSFCell cell = row.createCell((short)j);
										cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
										if(j==0){
											cell.setCellStyle(BoldUnderlineCENTRE);
										}else{
											cell.setCellStyle(BoldUnderlineCENTRE);
										}
									}
									
								}else{
									String[] column = new String[]{String.valueOf(index_ZNHG), bondCode, bondName, bondAmount, conversionRatio, firstNetValue};
									//创建行
									HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
									//创建列
									for(int j=0; j<column.length; j++){
										HSSFCell cell = null;
										if(j==0){
											cell = row.createCell((short)(j));
										}else{
											cell = row.createCell((short)(j+14));
										}
										cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
										cell.setCellStyle(BoldUnderlineCENTRE);
									}
								}
							}
							
							
						//不存在债券信息
						}else{
							index_ZNHG++;
							String[] column = new String[]{String.valueOf(index_ZNHG), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
									, tradingOpponent, investCount, tranAmount, actualDays, tradingRate, firstSettlementDate, expiryDate, bondCode, bondName, bondAmount
									, conversionRatio, firstNetValue
									, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
									, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
									, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
							
							//创建行
							HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
							//创建列
							for(int j=0; j<export_length_ZNHG; j++){
								HSSFCell cell = row.createCell((short)j);
								cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
								if(j==0){
									cell.setCellStyle(BoldUnderlineCENTRE);
								}else{
									cell.setCellStyle(BoldUnderlineCENTRE);
								}
							}
						}
						
					//07-债券申购;08-债券缴款;
					}else if("07".equals(processType) || "08".equals(processType)){
						index_ZQSJ++;
						
						processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ, processType);
						investCategory = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_BOND_CATEGORY, investCategory);//1.3.债券类别[01-利率债;02-公司债;03-中票;04-短融;05-企业债;06-小公募;07-非公开企业债;08-PPN;09-ABS优先级;10-ABS劣后级;99-其他;]/2.交易品种/4.基金类别
						tradingPlace = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_TRADING_PLACE_3, tradingPlace);//1.交易场所[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]/3.投标场所[01-银行间;02-交易所;]
						String[] column = new String[]{String.valueOf(index_ZQSJ), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
								, investProductCode, investProductName, investCategory, subjectRating, bondRating, paymentPlace, ratingAgencies, investCount, interestRate, netPrice
								, tradingPlace, leadUnderwriter, clearingSpeed, deliveryMethod
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
								, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
						
						//创建行
						HSSFRow row = sheet_ZQSJ.createRow(index_ZQSJ);
						//创建列
						for(int j=0; j<export_length_ZQSJ; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
						
					//09-基金申购;10-基金赎回;11-基金转换;
					}else if("09".equals(processType) || "10".equals(processType) || "11".equals(processType)){
						index_JJSS++;
						
						processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS, processType);
						String[] column = new String[]{String.valueOf(index_JJSS), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
								, investProductCode, investProductName, investCount, transformFundCode, transformFundName
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
								, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
						
						//创建行
						HSSFRow row = sheet_JJSS.createRow(index_JJSS);
						//创建列
						for(int j=0; j<export_length_JJSS; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
						
						/*//12-同存存入;13-同存提取;
					}
					else if("12".equals(processType) || "13".equals(processType)){
						index_TYCQ++;
						
						processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_TYCQ, processType);
						String[] column = new String[]{String.valueOf(index_TYCQ), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
								, investCount, startInterestDate, dueDate, tradingRate, depositTerm, earlyWithdrawalClause, tradingOpponent
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
								, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
						
						//创建行
						HSSFRow row = sheet_TYCQ.createRow(index_TYCQ);
						//创建列
						for(int j=0; j<export_length_TYCQ; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
					//14-资金追加;15-资金提取;
					}else if("14".equals(processType) || "15".equals(processType)){
						index_ZJZT++;
						
						processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZJZT, processType);
						String[] column = new String[]{String.valueOf(index_ZJZT), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum, processType
								, investCount, demandArrivalTime
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
								, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
						
						//创建行
						HSSFRow row = sheet_ZJZT.createRow(index_ZJZT);
						//创建列
						for(int j=0; j<export_length_ZJZT; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
					
						
						*/
					//19-大宗交易;
					}else if("19".equals(processType)){
						index_DZJY++;
						
						deliveryMethod = getDictName(ProductProcessUtil.CF_JY_MMFX, deliveryMethod);
						
						String[] column = new String[]{String.valueOf(index_DZJY), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum
								, investProductCode, investProductName, deliveryMethod, netPrice, investCount, seatNum, agreementNum
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd};
						
						//创建行
						HSSFRow row = sheet_DZJY.createRow(index_DZJY);
						//创建列
						for(int j=0; j<export_length_DZJY; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
						
					//20-投票;
					}else if("20".equals(processType)){
						index_TP++;
						
						String[] column = new String[]{String.valueOf(index_TP), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum
								, investProductCode, investProductName, tpZcya, tpFdyz, tpQqya
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd};
						
						//创建行
						HSSFRow row = sheet_TP.createRow(index_TP);
						//创建列
						for(int j=0; j<export_length_TP; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
					
					//99-其他指令/建议;
					}else if("99".equals(processType)){
						index_QTZL++;
						
						String[] column = new String[]{String.valueOf(index_QTZL), processDate, combProductCode, combProductName, vcCombiNo, vcCombiName, investProductNum
								, memo
								, abandonedReasons, investAdviserMd, remark, validStatus, inquiryId, inquiryName, inquiryCd, inquiryMd, investAdviserId, investAdviserName, investAdviserCd, investAdviserMd
								, completeInstructionsId, completeInstructionsName, completeInstructionsCd, completeInstructionsMd, investAdviserConfirmId, investAdviserConfirmName, investAdviserConfirmCd, investManagerId, investManagerName, investManagerCd, traderId, traderName, traderCd
								, reviewId, reviewName, reviewCd, sendId, sendName, sendCd, backstageTraderId, backstageTraderName, backstageTraderCd};
						
						//创建行
						HSSFRow row = sheet_QTZL.createRow(index_QTZL);
						//创建列
						for(int j=0; j<export_length_QTZL; j++){
							HSSFCell cell = row.createCell((short)j);
							cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
							if(j==0){
								cell.setCellStyle(BoldUnderlineCENTRE);
							}else{
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
					}
				}
				
			}
			
			//写入数据并关闭文件
			//ByteArrayOutputStream out = new ByteArrayOutputStream();
			//workbook.write(out);
			//byte[] data = out.toByteArray();
			//out.close();
			
			//组装附件名称
			String filename = "OrderExport.xls";
			//导出excel
			pageUrl = exportExcel(workbook,filename);
			return pageUrl;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 获取数据字典名称
	 * @param dictTypeId 业务字典类型
	 * @param dictId 字典值
	 * @return
	 * @author huangmizhi
	 */
	public static String getDictName(String dictTypeId, String dictId){
		if(StringUtils.isBlank(dictId)){
			return StrUtil.changeNull(dictId);
		}
		String result = BusinessDictUtil.getDictName(dictTypeId, dictId);
		//若查出来数据字典名称为空，则返回原值
		if(StringUtil.isEmpty(result)){
			return dictId;
		}
		return result;
	}
	
	/**
	 * 质押式正逆回购导出
	 * @param productProcessData
	 * @param exportType 导出类型：0-不过滤权限，否则过滤投顾权限
	 * @return
	 * @throws Exception
	 * @author chenpeng
	 */
	@Bizlet("")
	public static String PledgedRepoExport(DataObject[] productProcessData,	String exportType,DataObject process) throws Exception {
		String pageUrl = "";
		try {
			//创建Excel文件
			HSSFWorkbook workbook = new HSSFWorkbook();

			//设置列头字体格式
			HSSFFont headFont = workbook.createFont();
			headFont.setFontName("宋体");
			headFont.setFontHeightInPoints((short) 11);// 字体大小
			headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗
			//设置列头字体对齐格式
			HSSFCellStyle headFormat = workbook.createCellStyle();
			headFormat.setFont(headFont);
			headFormat.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			headFormat.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			headFormat.setLocked(true);
			headFormat.setWrapText(true);// 自动换行

			//设置字体格式
			HSSFFont columnHeadFont = workbook.createFont();
			columnHeadFont.setFontName("宋体");
			columnHeadFont.setFontHeightInPoints((short) 10);// 字体大小
			//左对齐
			HSSFCellStyle BoldUnderlineLEFT = workbook.createCellStyle();
			BoldUnderlineLEFT.setFont(columnHeadFont);
			BoldUnderlineLEFT.setLocked(true);
			BoldUnderlineLEFT.setWrapText(true);// 自动换行
			//居中对齐
			HSSFCellStyle BoldUnderlineCENTRE = workbook.createCellStyle();
			BoldUnderlineCENTRE.setFont(columnHeadFont);
			BoldUnderlineCENTRE.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			BoldUnderlineCENTRE.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			BoldUnderlineCENTRE.setLocked(true);
			BoldUnderlineCENTRE.setWrapText(true);// 自动换行

			//正逆回购
			HSSFSheet sheet_ZNHG = workbook.createSheet("银行间质押式正逆回购");
			//创建第一行
			HSSFRow row0_ZNHG = sheet_ZNHG.createRow(0);

			String[] headTitle_ZNHG = new String[] {  "对手方", "对手方交易员",
					"交易方向", "交易金额(元)", "回购利率(%)", "回购期限(天)", "清算速度", "首次结算方式",
					"到期结算方式", "清算类型", "有效时间", "补充条款", "资金开户行", "账户", "账户名",
					"资金开户行支付系统行号", "托管机构名称", "托管帐号", "托管账户户名", "债券代码", "债券名称",
					"券面总额(万元)", "折算比例(%)", "债券币种", "结算币种"};

			//创建列
			int export_length_ZNHG = headTitle_ZNHG.length;
			System.out.println("HSSFWorkbook =                     "+  HSSFWorkbook.class.getProtectionDomain().getCodeSource().getLocation()); 
			for (int i = 0; i < export_length_ZNHG; i++) {
				HSSFCell cell = row0_ZNHG.createCell((short) i);
				cell.setCellValue((RichTextString)new HSSFRichTextString(headTitle_ZNHG[i]));
				cell.setCellStyle(headFormat);
				if (i == 0) {//序号
					sheet_ZNHG.setColumnWidth((short) i, (short) 5000);//设置列宽
				} else {
					sheet_ZNHG.setColumnWidth((short) i, (short) 5000);//设置列宽
				}
			}
			int index_ZNHG = 0;
			for (int i = 0; i < productProcessData.length; i++) {
				DataObject obj = productProcessData[i];

				String processId = StrUtil.changeNull(obj.getString("processId"));//主键ID
				String tradingOpponent = StrUtil.changeNull(obj.getString("tradingOpponent"));//1.2.5交易对手
				String tradingOpponents[] = tradingOpponent.trim().replaceAll("  ", " ").replaceAll("  ", " ").replaceAll("-", " ").split(" ");
				String tradingOpponentName = ""; //对手方交易员
				if (tradingOpponents.length == 1) {
					tradingOpponent = tradingOpponents[0];
				} else {
					tradingOpponent = tradingOpponents[0];
					tradingOpponentName = tradingOpponents[1];
				}
				//业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;16-交易所协议正回购;17-交易所协议逆回购;99-其他指令/建议;
				String processType = StrUtil.changeNull(obj.getString("processType"));
				String tranAmount = StrUtil.changeNull(obj.getString("tranAmount"));//2.交易金额（万元）
				String tradingRate = StrUtil.changeNull(obj.getString("tradingRate"));//2.回购利率（%）/5.存款利率
				String actualDays = StrUtil.changeNull(obj.getString("actualDays"));//2.回购期限（天）
				String clearingSpeed = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_CLEARING_SPEED, obj.getString("clearingSpeed"));//1.3.清算速度：T+0、T+1
				String firstSettlement = StrUtil.changeNull(obj.getString("firstSettlement"));//2.首期结算方式
				String dueSettlement = StrUtil.changeNull(obj.getString("dueSettlement"));//2.到期结算方式
				String settlementType = ""; //清算类型
				String effectiveTime = ""; //有效时间
				String subsidiaryClause = ""; //补充条款
				String capitalAccount = ""; //资金开户行
				String account = ""; //账户
				String accountName = StrUtil.changeNull(obj.getString("combProductName"));//产品名称; //账户名
				String paymentNumber = ""; //资金开户行支付系统行号
				String custodianName = ""; //托管机构名称
				String escrowAccount = ""; //托管账户
				String escrowAccountName = ""; //托管账户户名
				String investProductCode = StrUtil.changeNull(obj.getString("investProductCode"));//1.3.债券代码/2.质押券代码（逆回购质押券可以空）/4.基金代码
				String investProductName = StrUtil.changeNull(obj.getString("investProductName"));//1.3.债券名称/2.质押券名称/4.基金名称/5.存款产品
				String investCount = StrUtil.changeNull(obj.getString("investCount"));//1.3.交易数量（万元）/2.券面总额合计（万元）/4.数量（万元\份额）/5.数量（万元）/6.金额
				String bondCurrency = "CNY";//债券币种
				String settlementCurrency = "CNY";//结算币种
				
				
				processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG, processType);

				//获取债券信息
				DataObject[] bonds = null;
				try {
					ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.jy.ProductProcess.JY_ZNHG");
					Object[] objArr = comp.invoke("JY_ZNHG_queryBondsByProcessId", new String[] { processId });//调用逻辑流的方法
					if (objArr != null && objArr.length > 0) {
						bonds = (DataObject[]) objArr[0];
					}
				} catch (Throwable e) {
					e.printStackTrace();
				}

				String bondCode = "";//债券代码
				String bondName = "";//债券名称
				String bondAmount = "";//券面总额（万元）
				String conversionRatio = "";//折算比例（%）
				String firstNetValue = "";//首次净价（元）
				DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhgBond");

				//存在债券信息
				if (bonds != null && bonds.length > 0) {
					for (int bondNum = 0; bondNum < bonds.length; bondNum++) {
						index_ZNHG++;
						bond = bonds[bondNum];
						bondCode = StrUtil.changeNull(bond.getString("bondCode"));
						bondName = StrUtil.changeNull(bond.getString("bondName"));
						bondAmount = StrUtil.changeNull(bond.getString("bondAmount"));
						//判断券面总额(万元)是否为空，不为空时执行替换
						if(!bondAmount.equals("")){
							bondAmount = bondAmount.replaceAll(",", "");
						}
						conversionRatio = StrUtil.changeNull(bond.getString("conversionRatio"));
						firstNetValue = StrUtil.changeNull(bond.getString("firstNetValue"));
						double dTranAmount = (Double.valueOf(tranAmount.replaceAll(",", ""))*10000);
						StrUtil.nf.setGroupingUsed(false);
						
						if (bondNum == 0) {
							String[] column = new String[] {
									tradingOpponent,tradingOpponentName,processType.substring(6,processType.length()),
									String.valueOf(StrUtil.nf.format(dTranAmount)),tradingRate, actualDays, clearingSpeed,
									firstSettlement, dueSettlement,
									settlementType, effectiveTime,
									subsidiaryClause, capitalAccount, account,
									accountName, paymentNumber, custodianName,
									escrowAccount, escrowAccountName, bondCode,
									bondName, bondAmount, conversionRatio, bondCurrency, settlementCurrency};

							//创建行
							HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
							//创建列
							for (int j = 0; j < export_length_ZNHG; j++) {
								HSSFCell cell = row.createCell((short) j);
								cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
								if (j == 0) {
									cell.setCellStyle(BoldUnderlineCENTRE);
								} else {
									cell.setCellStyle(BoldUnderlineCENTRE);
								}
							}

						} else {
							String[] column = new String[] {bondCode, bondName, bondAmount, conversionRatio };
							//创建行
							HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
							//创建列
							for (int j = 0; j < column.length; j++) {
								HSSFCell cell = null;
								if (j == 0) {
									cell = row.createCell((short) (j + 19));
								} else {
									cell = row.createCell((short) (j + 19));
								}
								cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
								cell.setCellStyle(BoldUnderlineCENTRE);
							}
						}
					}
				}
			}
			//获取导出债券类型
			String dictName = BusinessDictUtil.getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG,process.getString("processType"));
			
			Date date = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
			//组装附件名称
			String filename = process.getString("combProductName") + "_" + dictName.substring(0, 6) +"_" + format.format(date) +".xls";
			
			//导出excel
			pageUrl = exportExcel(workbook,filename);

			return pageUrl;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 买断式正逆回购导出
	 * @param productProcessData
	 * @param exportType 导出类型：0-不过滤权限，否则过滤投顾权限
	 * @return
	 * @throws Exception
	 * @author chenpeng
	 */
	@Bizlet("")
	public static String OutrightExport(DataObject[] productProcessData, String exportType,DataObject process) throws Exception {
		String pageUrl="";
		try{
			//创建Excel文件
			HSSFWorkbook workbook = new HSSFWorkbook();

			//设置列头字体格式
			HSSFFont headFont = workbook.createFont();
			headFont.setFontName("宋体");
			headFont.setFontHeightInPoints((short) 11);// 字体大小
			headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗
			//设置列头字体对齐格式
			HSSFCellStyle headFormat = workbook.createCellStyle();
			headFormat.setFont(headFont);
			headFormat.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			headFormat.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			headFormat.setLocked(true);
			headFormat.setWrapText(true);// 自动换行

			//设置字体格式
			HSSFFont columnHeadFont = workbook.createFont();
			columnHeadFont.setFontName("宋体");
			columnHeadFont.setFontHeightInPoints((short) 10);// 字体大小
			//左对齐
			HSSFCellStyle BoldUnderlineLEFT = workbook.createCellStyle();
			BoldUnderlineLEFT.setFont(columnHeadFont);
			BoldUnderlineLEFT.setLocked(true);
			BoldUnderlineLEFT.setWrapText(true);// 自动换行
			//居中对齐
			HSSFCellStyle BoldUnderlineCENTRE = workbook.createCellStyle();
			BoldUnderlineCENTRE.setFont(columnHeadFont);
			BoldUnderlineCENTRE.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			BoldUnderlineCENTRE.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			BoldUnderlineCENTRE.setLocked(true);
			BoldUnderlineCENTRE.setWrapText(true);// 自动换行

			//正逆回购
			HSSFSheet sheet_ZNHG = workbook.createSheet("银行间买断式正逆回购");
			//创建第一行
			HSSFRow row0_ZNHG = sheet_ZNHG.createRow(0);

			String[] headTitle_ZNHG = new String[] {  "对手方", "对手方交易员","交易方向","债券代码", "债券名称",
					  "回购利率(%)", "首次净价(元)", "到期净价(元)", "首次收益率(%)",
					"到期收益率(%)", "券面总额(万元)", "回购期限(天)", "清算速度", "首次结算方式","到期结算方式","清算类型", "报价有效时间"
					,"补充条款",  "账户名","资金开户行","账户",
					"资金开户行支付系统行号", "托管账户户名","托管机构名称", "托管帐号",};

			//创建列
			int export_length_ZNHG = headTitle_ZNHG.length - 15;
			if (EXPORT_TYPE_ALL.equals(exportType)) {
				export_length_ZNHG = headTitle_ZNHG.length;
			}
			for (int i = 0; i < export_length_ZNHG; i++) {
				HSSFCell cell = row0_ZNHG.createCell((short) i);
				cell.setCellValue((RichTextString)(new HSSFRichTextString(headTitle_ZNHG[i])));
				cell.setCellStyle(headFormat);
				if (i == 0) {//序号
					sheet_ZNHG.setColumnWidth((short) i, (short) 5000);//设置列宽
				} else {
					sheet_ZNHG.setColumnWidth((short) i, (short) 5000);//设置列宽
				}
			}
			int index_ZNHG = 0;
			for (int i = 0; i < productProcessData.length; i++) {
				DataObject obj = productProcessData[i];

				String processId = StrUtil.changeNull(obj.getString("processId"));//主键ID
				String tradingOpponent = StrUtil.changeNull(obj.getString("tradingOpponent"));//1.2.5交易对手
				String tradingOpponents[] = tradingOpponent.trim().replaceAll("  ", " ").replaceAll("  ", " ").replaceAll("-", " ").split(" ");
				String tradingOpponentName = ""; //对手方交易员
				if (tradingOpponents.length == 1) {
					tradingOpponent = tradingOpponents[0];
				} else {
					tradingOpponent = tradingOpponents[0];
					tradingOpponentName = tradingOpponents[1];
				}
				//业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;16-交易所协议正回购;17-交易所协议逆回购;99-其他指令/建议;
				String processType = StrUtil.changeNull(obj.getString("processType"));
				//String tranAmount = StrUtil.changeNull(obj.getString("tranAmount"));//2.交易金额（万元）
				String tradingRate = StrUtil.changeNull(obj.getString("tradingRate"));//2.回购利率（%）/5.存款利率
				String actualDays = StrUtil.changeNull(obj.getString("actualDays"));//2.回购期限（天）
				String clearingSpeed = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_CLEARING_SPEED, obj.getString("clearingSpeed"));//1.3.清算速度：T+0、T+1
				String firstSettlement = StrUtil.changeNull(obj.getString("firstSettlement"));//2.首期结算方式
				String dueSettlement = StrUtil.changeNull(obj.getString("dueSettlement"));//2.到期结算方式
				String settlementType = ""; //清算类型
				String effectiveTime = ""; //有效时间
				String subsidiaryClause = ""; //补充条款
				String capitalAccount = ""; //资金开户行
				String account = ""; //账户
				String accountName = StrUtil.changeNull(obj.getString("combProductName"));//产品名称; //账户名
				String paymentNumber = ""; //资金开户行支付系统行号
				String custodianName = ""; //托管机构名称
				String escrowAccount = ""; //托管账户
				String escrowAccountName = ""; //托管账户户名
				//String investProductCode = StrUtil.changeNull(obj.getString("investProductCode"));//1.3.债券代码/2.质押券代码（逆回购质押券可以空）/4.基金代码
				//String investProductName = StrUtil.changeNull(obj.getString("investProductName"));//1.3.债券名称/2.质押券名称/4.基金名称/5.存款产品
				//String investCount = StrUtil.changeNull(obj.getString("investCount"));//1.3.交易数量（万元）/2.券面总额合计（万元）/4.数量（万元\份额）/5.数量（万元）/6.金额

				processType = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG, processType);
				
				//获取债券信息
				DataObject[] bonds = null;
				try {
					ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.jy.ProductProcess.JY_ZNHG");
					Object[] objArr = comp.invoke("JY_ZNHG_queryBondsByProcessId", new String[] { processId });//调用逻辑流的方法
					if (objArr != null && objArr.length > 0) {
						bonds = (DataObject[]) objArr[0];
					}
				} catch (Throwable e) {
					e.printStackTrace();
				}

				String bondCode = "";//债券代码
				String bondName = "";//债券名称
				String bondAmount = "";//券面总额（万元）
				String conversionRatio = "";//折算比例（%）
				String firstNetValue = "";//首次净价（元）
				DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhgBond");

				//存在债券信息
				if (bonds != null && bonds.length > 0) {
					for (int bondNum = 0; bondNum < bonds.length; bondNum++) {
						index_ZNHG++;
						bond = bonds[bondNum];
						bondCode = StrUtil.changeNull(bond.getString("bondCode"));
						bondName = StrUtil.changeNull(bond.getString("bondName"));
						bondAmount = StrUtil.changeNull(bond.getString("bondAmount")).replaceAll(",", "");
						conversionRatio = StrUtil.changeNull(bond.getString("conversionRatio"));
						firstNetValue = StrUtil.changeNull(bond.getString("firstNetValue"));

							String[] column = new String[] {
									tradingOpponent,tradingOpponentName,processType.substring(6, processType.length()),bondCode,bondName
									,tradingRate,firstNetValue,"","","",bondAmount,actualDays,clearingSpeed
									,firstSettlement,dueSettlement,settlementType,effectiveTime,subsidiaryClause,accountName,capitalAccount
									,account,paymentNumber,escrowAccountName,custodianName,escrowAccount
							};

							//创建行
							HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
							//创建列
							for (int j = 0; j < export_length_ZNHG; j++) {
								HSSFCell cell = row.createCell((short) j);
								cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
								if (j == 0) {
									cell.setCellStyle(BoldUnderlineCENTRE);
								} else {
									cell.setCellStyle(BoldUnderlineCENTRE);
								}
							}

					}
				}
			}
			//写入数据并关闭文件
			//ByteArrayOutputStream out = new ByteArrayOutputStream();
			//workbook.write(out);
			//byte[] data = out.toByteArray();
			//out.close();
			
			//获取导出债券类型
			String dictName = BusinessDictUtil.getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG,process.getString("processType"));
			
			//组装附件名称
			String filename = process.getString("combProductName") + "_" + dictName.substring(0, 6) +"_" + DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER) +".xls";
			//导出excel
			pageUrl = exportExcel(workbook,filename);

			return pageUrl;
			//return data;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 导出excel
	 * @param excel文档信息
	 * @param 指令信息
	 * @return
	 */
	public static String exportExcel(HSSFWorkbook workbook,String filename){
		String pageUrl = "";
		try{
			
	        //设置URL
	        pageUrl = commonUtil.DOWNLOAD_FILE_EXCEL_EXPORT + filename;
	        File file = new File(pageUrl);
	        //判断文件夹是否存在,如果不存在则创建文件夹
	        if (!file.exists() && !file.isDirectory()) {
	        	new File(commonUtil.DOWNLOAD_FILE_EXCEL_EXPORT).mkdirs();
	        }
	        
	        //判断文件是否存在，不存在创建文件
	        if(!file.exists()){      
	           file.createNewFile();
	        }
	                
	        //写入数据并关闭文件
			FileOutputStream fout = new FileOutputStream(file.getPath());  
			workbook.write(fout);
			fout.close();
			return pageUrl + "," + filename;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String[] args) {
	}

	
	/**
	 * 将DataObject对象数据转换为字符串数组
	 * @param changeData 待转换的DataObject数据
	 * @param columnKeyArr 获取字段值关键key数组
	 * @param changeObjArr 值转换格式对象数组
	 * @return
	 * @author tongwei
	 */
	@Bizlet("")
	public static List<String[]> changeArr(List<DataObject> changeData, String[] columnKeyArr, Object[] changeObjArr){
		List<String[]> result = new ArrayList<String[]>();
		for(int i=0; i<changeData.size(); i++){
			DataObject dataObj = changeData.get(i);
			String[] strArr = new String[columnKeyArr.length];
			for(int j=0; j<columnKeyArr.length; j++){
				String columnKey = columnKeyArr[j];
				String value = StrUtil.changeNull(dataObj.getString(columnKey));
				Object obj = changeObjArr[j];
				if(obj instanceof DecimalFormat){
					DecimalFormat df = (DecimalFormat)obj;
					strArr[j] = StrUtil.addThousandth(value, df);
				}else{
					strArr[j] = value;
				}
			}
			result.add(strArr);
		}
		return result;
	}
	
	/**
	 * 根据字典名称和翻译项id获取翻译项名称
	 * @param dicttypeid 字典项id
	 * @param dictid	字典参数表id
	 * @author tongwei
	 * @return
	 */
	public static String getDictidName(String dicttypeid, String dictid) {
		String dictidName = null;
		DataObject[] objs = BusinessDictUtil.getDictInfoByType(dicttypeid);
		Map<String, String> maps = new HashMap<String, String>();
		for (int i = 0; i < objs.length; i++) {
			maps.put(objs[i].getString("dictID"), objs[i].getString("dictName"));
		}
		if(!dictid.equals("") && dictid != null){
			dictidName = maps.get(dictid);
		}
		return dictidName;
	}
}

