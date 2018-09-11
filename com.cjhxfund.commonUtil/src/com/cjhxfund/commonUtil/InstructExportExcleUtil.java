package com.cjhxfund.commonUtil;

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

import com.cjhxfund.jy.ProductProcess.ProductProcessUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.primeton.workflow.commons.utility.StringUtil;

import commonj.sdo.DataObject;

/**
 * 指令导出类
 * @author tongwei
 *
 */
public class InstructExportExcleUtil {

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
			

			
			//二级债页面导出
			HSSFSheet sheet_SM_MM = null;
			HSSFRow row0_SM_MM = null;
			String[] HeadTitle_SM_MM = null;
			int export_length_SM_MM = 0;
			
			if(webType!=null && "1".equals(webType)){
				//  二级债买卖指令
				sheet_SM_MM = workbook.createSheet("债券买卖");
				//创建第一行
				row0_SM_MM = sheet_SM_MM.createRow(0);
				HeadTitle_SM_MM = new String[]{"指令状态", "产品名称", "组合名称", "清算速度", "业务类别", "委托方向", "交易对手", "对方交易员", "对手席位", "债券代码", "债券名称", "券面金额（万元）", "录入日期", "交易日", "结算日", "净价", "全价", "到期收益率（%）", "行权收益率（%）", "录入时间", "复核时间", "确认时间", "投资经理确认时间", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "指令/建议序号", "备注"};
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
			}
			
			//正逆回购
			HSSFSheet sheet_ZNHG = workbook.createSheet("正逆回购");
			//创建第一行
			HSSFRow row0_ZNHG = sheet_ZNHG.createRow(0);
			String[] headTitle_ZNHG = new String[]{"指令状态", "产品名称", "组合名称", "清算速度", "业务类别", "委托方向", "交易对手", "回购天数(天)", "回购金额(万元)", "回购利率(%)", 
					"录入日期", "交易日", "首次结算日", "到期结算日", "首次结算金额(元)", "到期结算金额(元)", "报价方式", "加权加点(bp)", "录入时间", "复核时间", 
					"确认时间", "投资经理确认时间", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "债券代码", "债券名称", "券面金额(万元)", "折算比例(%)", "指令序号", "备注", "指令来源", "指令编号"};
	
			//创建列
			int export_length_ZNHG = 0;
			export_length_ZNHG = headTitle_ZNHG.length-1;
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
			
			//一级债数据
			HSSFSheet sheet_YJXZ = null;
			HSSFRow row0_YJXZ = null;
			String[] HeadTitle_YJXZ = null;
			int export_length_YJXZ = 0;
			
			if(webType!=null && "1".equals(webType)){
				// 一级债数据指令
				sheet_YJXZ = workbook.createSheet("一级新债");
				//创建第一行
				row0_YJXZ = sheet_YJXZ.createRow(0);
				HeadTitle_YJXZ = new String[]{"序号",  "产品代码", "产品名称", "债券代码", "债券简称", "债券类别", "发行期限"
						, "发行规模", "主体评级", "登记托管机构",  "投标截止日期"
						, "缴款日期", "废债券全称", "发行主体", "主体类型", "投资编号", "业务时间", "fix发送状态"};
				//创建列
				export_length_YJXZ = HeadTitle_YJXZ.length;
				for(int i=0; i<export_length_YJXZ; i++){
					HSSFCell cell = row0_YJXZ.createCell((short)i);
					cell.setCellValue((RichTextString)(new HSSFRichTextString(HeadTitle_YJXZ[i])));
					cell.setCellStyle(headFormat);
					if(i==0){//序号
						sheet_YJXZ.setColumnWidth((short)i, (short)2000);//设置列宽
					}else{
						sheet_YJXZ.setColumnWidth((short)i, (short)5000);//设置列宽
					}
				}
			}
			
			//基金申赎
			HSSFSheet sheet_JJSS = workbook.createSheet("场外基金");
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
			
			//大宗交易
			HSSFSheet sheet_DZJY = workbook.createSheet("股票大宗");
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
			
			//行权管理
			HSSFSheet sheet_TP = workbook.createSheet("行权管理");
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
			
			
			//其他投资
			HSSFSheet sheet_QTZL = workbook.createSheet("其他投资");
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
			
			
			//初始化下标
			int index_SM_MM = 0;//债券买卖
			int index_ZNHG = 0;//正逆回购
			int index_JJSS = 0;//基金申赎
			int index_QTZL = 0;//其他指令/建议
			int index_TP = 0;//投票
			int index_YJXZ = 0;//基金申赎
			int index_DZJY = 0;//大宗交易
			
			for (int i=0; i<productProcessData.length; i++) {
				DataObject obj = productProcessData[i];

				String vcBizType = StrUtil.changeNull(obj.getString("vcBizType"));
				String vcProcessType = StrUtil.changeNull(obj.getString("vcProcessType"));//一级债标识
				String vcCombiName = "";
				// 二级债买卖和回购指令
				if("1".equals(vcBizType) || "2".equals(vcBizType) || "3".equals(vcBizType) || "4".equals(vcBizType)|| "5".equals(vcBizType) || "6".equals(vcBizType) || "7".equals(vcBizType) || "10".equals(vcBizType)){
					/***********************************************二级债指令****************************************/
					String lInstructNo = StrUtil.changeNull(obj.getString("lInstructNo"));
					String vcRiskApproveStatus = StrUtil.changeNull(obj.getString("vcRiskApproveStatus"));
					String cIsValid = StrUtil.changeNull(obj.getString("cIsValid"));
					String vcProductName = StrUtil.changeNull(obj.getString("vcProductName"));
					vcCombiName = StrUtil.changeNull(obj.getString("vcCombiName"));
					String vcSettleSpeed = StrUtil.changeNull(obj.getString("vcSettleSpeed"));
					String vcEntrustDirection = StrUtil.changeNull(obj.getString("vcEntrustDirection"));
					String vcStockCode = StrUtil.changeNull(obj.getString("vcStockCode"));
					String vcStockName = StrUtil.changeNull(obj.getString("vcStockName"));
					String enFaceAmount = StrUtil.changeNull(obj.getString("enFaceAmount"));
					String lIssueDate = "";
					String lTradeDate = "";
					String lFirstSettleDate = "";
					String vcBizTypeText = ""; 
					String lResultDate = "";

					// 指令下达日期
					if(obj.getDate("lIssueDate") != null){
						lIssueDate = String.valueOf(obj.getLong("lIssueDate"));
						lIssueDate = lIssueDate.substring(0,4)+"-"+lIssueDate.substring(4,6)+"-"+lIssueDate.substring(6,8);
					}
					// 指令录入日期
					if(obj.getDate("lResultDate") != null){
						lResultDate = String.valueOf(obj.getLong("lResultDate"));
						lResultDate = lResultDate.substring(0,4)+"-"+lResultDate.substring(4,6)+"-"+lResultDate.substring(6,8);
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
						vcBizTypeText = getDictidName("bizTypeAll", obj.getString("vcBizType"));
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
					String vcCounterpartyName = StrUtil.changeNull(obj.getString("vcCounterpartyName"));
					String vcCounterpartyTrader = StrUtil.changeNull(obj.getString("vcCounterpartyTrader"));
					String vcRivalSeat = StrUtil.changeNull(obj.getString("vcRivalSeat"));
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

					if("1".equals(vcBizType) || "2".equals(vcBizType) || "3".equals(vcBizType) || "4".equals(vcBizType)){

						index_SM_MM++;
						String[] column = new String[]{cIsValid,vcProductName,vcCombiName,vcSettleSpeed,vcBizTypeText,vcEntrustDirection,vcCounterpartyName,vcCounterpartyTrader,vcRivalSeat,vcStockCode,vcStockName,enFaceAmount,lResultDate,lTradeDate,lFirstSettleDate,enNetPrice,enFullPrice,enMaturityYield,enOptionYield,tResultInputTime,vcAdviserConfirm,vcEntrustConfirm,tFsSendTime,tFsOperateTime,tFsCheckTime,tFsDealTime,vcBsDealStatus,lInstructNo,vcRemark};
						
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
					}else{
						String lRepoDays = StrUtil.changeNull(obj.getString("lRepoDays"));
						String enRepoRate = StrUtil.changeNull(obj.getString("enRepoRate"));
						String lMaturitySettleDate = "";
						// 到期结算日期
						if(obj.getString("lMaturitySettleDate") != null){
							lMaturitySettleDate = String.valueOf(obj.getLong("lMaturitySettleDate"));
							lMaturitySettleDate = lMaturitySettleDate.substring(0,4)+"-"+lMaturitySettleDate.substring(4,6)+"-"+lMaturitySettleDate.substring(6,8);
						}
						String enFullPriceAmount = StrUtil.changeNull(obj.getString("enFullPriceAmount"));
						String enSettleAmount = StrUtil.changeNull(obj.getString("enSettleAmount"));
						String vcQuoteMode = StrUtil.changeNull(obj.getString("vcQuoteMode"));

						// 报价方式翻译
						if(vcQuoteMode != null){
							vcQuoteMode = getDictidName("quoteMode",vcQuoteMode);
						}
						String enWeightingValue = StrUtil.changeNull(obj.getString("enWeightingValue"));
						String conversionRatio = StrUtil.changeNull(obj.getString("conversionRatio"));
						String lResultId = StrUtil.changeNull(obj.getString("lResultId"));
						String vcInstructSource = StrUtil.changeNull(obj.getString("vcInstructSource"));
						String instructSourceText = "";
						if("3".equals(vcInstructSource)){
							instructSourceText = "新版本";
						}else if("2".equals(vcInstructSource) || "1".equals(vcInstructSource)){
							instructSourceText = "老版本";
						}
						String[] column = new String[]{cIsValid, vcProductName, vcCombiName, vcSettleSpeed, vcBizTypeText, vcEntrustDirection,
								vcCounterpartyName, lRepoDays, enFaceAmount, enRepoRate, lResultDate, lTradeDate, lFirstSettleDate, lMaturitySettleDate, enFullPriceAmount, 
								enSettleAmount, vcQuoteMode, enWeightingValue, tResultInputTime, vcAdviserConfirm, vcEntrustConfirm, tFsSendTime, tFsOperateTime, tFsCheckTime, 
								tFsDealTime, vcBsDealStatus, vcStockCode, vcStockName, enFaceAmount, conversionRatio, lInstructNo, vcRemark, instructSourceText, lResultId};
						
						//获取质押券信息
						DataObject[] bonds = null;
						try {
							ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.ats.sm.comm.InstructionManager");
							Object[] objArr = comp.invoke("getJqmAndSmMortgageInfo", new String[] {"", lResultId, vcInstructSource });//调用逻辑流的方法
							if (objArr != null && objArr.length > 0) {
								bonds = (DataObject[]) objArr[0];
							}
						} catch (Throwable e) {
							e.printStackTrace();
						}
						DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultMortagage");
						
						//存在债券信息
						if (bonds != null && bonds.length > 0) {
							for (int bondNum = 0; bondNum < bonds.length; bondNum++) {
								index_ZNHG++;
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
									column[26] = vcStockCode;
									column[27] = vcStockName;
									column[28] = enFaceAmount;
									column[29] = conversionRatio;
									//创建数据行
									HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
									//创建数据列
									for(int j=0; j<export_length_ZNHG; j++){
										HSSFCell cell = row.createCell((short)j);
										cell.setCellStyle(BoldUnderlineCENTRE);
										cell.setCellValue((RichTextString)new HSSFRichTextString(column[j]));
									}
								}else {
									String[] bondStrArr = new String[] {vcStockCode, vcStockName, enFaceAmount, conversionRatio};
									//创建数据行
									HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
									//创建数据列
									for(int j=0; j<bondStrArr.length; j++){
										HSSFCell cell = null;
										if (j == 0) {
											cell = row.createCell((short) (j + 26));
										} else {
											cell = row.createCell((short) (j + 26));
										}
										cell.setCellStyle(BoldUnderlineCENTRE);
										cell.setCellValue((RichTextString)(new HSSFRichTextString(bondStrArr[j])));
										
									}
								}
							} 
						}else{
							index_ZNHG++;
							column[26] = "";
							column[27] = "";
							column[28] = "";
							column[29] = "";
							//创建数据行
							HSSFRow row = sheet_ZNHG.createRow(index_ZNHG);
							//创建数据列
							for(int j=0; j<export_length_ZNHG; j++){
								HSSFCell cell = row.createCell((short)j);
								cell.setCellStyle(BoldUnderlineCENTRE);
								cell.setCellValue((RichTextString)new HSSFRichTextString(column[j]));
							}
						}
					}
				}else if("1".equals(vcProcessType) || "5".equals(vcProcessType) || "8".equals(vcProcessType) ){
					
					/***********************************************一级债指令****************************************/
					/*{"序号", "产品代码", "产品名称", "债券代码", "债券简称", "债券类别", "发行期限"
					, "发行规模", "主体评级", "登记托管机构",  "投标截止日期"
					, "缴款日期", "废债券全称", "发行主体", "主体类型", "投资编号", "业务时间", "fix发送状态"};*/
					
					String lBizId = StrUtil.changeNull(obj.getString("lBizId"));
					if(lBizId.equals("1") || lBizId.equals("1")){
						lBizId="申购流程";
				 	}else if(lBizId=="8"){
				 		lBizId="缴款流程";
				 	}
					
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String vcProductName = StrUtil.changeNull(obj.getString("vcProductName"));
					String vcStockCode = StrUtil.changeNull(obj.getString("vcStockCode"));
					String vcStockName = StrUtil.changeNull(obj.getString("vcStockName"));
					String vcStocktypeName = StrUtil.changeNull(obj.getString("vcStocktypeName"));
					String enExistLimite = StrUtil.changeNull(obj.getString("enExistLimite")); 
					String enIssueBalance = StrUtil.changeNull(obj.getString("enIssueBalance"));
					String cIssueAppraise = getDictidName("issuerRating",StrUtil.changeNull(obj.getString("cIssueAppraise")));
					String vcPaymentPlace = getDictidName("CF_JY_DJTGCS",StrUtil.changeNull(obj.getString("vcPaymentPlace")));
					//String workitemname = StrUtil.changeNull(obj.getString("workitemname"));
					String dBidLimitTime = StrUtil.changeNull(obj.getDate("dBidLimitTime")!=null?df.format(obj.getDate("dBidLimitTime")):"");
					String dPaymentDate = StrUtil.changeNull(obj.getString("dPaymentDate"));
					String vcStockNameFull = StrUtil.changeNull(obj.getString("vcStockNameFull"));
					String vcProductCode = StrUtil.changeNull(obj.getString("vcProductCode"));
					String vcIssuerName = StrUtil.changeNull(obj.getString("vcIssuerName"));
					String vcIssueProperty = getDictidName("ATS_FM_ISSUE_PROPERTY",StrUtil.changeNull(StrUtil.changeNull(obj.getString("vcIssueProperty"))));
					String lInvestNo = StrUtil.changeNull(obj.getString("lInvestNo"));
					String dApplicationTime = StrUtil.changeNull(obj.getDate("dApplicationTime")!=null?df.format(obj.getDate("dApplicationTime")):"");
					String lFixValidStatus = StrUtil.changeNull(obj.getString("lFixValidStatus"));					
					
					if(lFixValidStatus.equals("0")){
						lFixValidStatus = "未发送";
					}else if(lFixValidStatus.equals("1")){
						lFixValidStatus = "修改后未发送";
					}else if(lFixValidStatus.equals("2")){
						lFixValidStatus = "发送中";
					}else if(lFixValidStatus.equals("3")){
						lFixValidStatus = "发送成功";
					}else if(lFixValidStatus.equals("4")){
						lFixValidStatus = "发送失败";
					}
               
					
					/*{"序号",  "产品代码", "产品名称", "债券代码", "债券简称", "债券类别", "发行期限"
						, "发行规模", "主体评级", "登记托管机构",  "投标截止日期"
						, "缴款日期", "废债券全称", "发行主体", "主体类型", "投资编号", "业务时间", "fix发送状态"}*/
					index_YJXZ++;
					String[] column = new String[]{String.valueOf(index_YJXZ),vcProductCode,vcProductName, vcStockCode, vcStockName, vcStocktypeName
							, enExistLimite, enIssueBalance, cIssueAppraise, vcPaymentPlace, dBidLimitTime, dPaymentDate
							, vcStockNameFull, vcIssuerName, vcIssueProperty, lInvestNo, dApplicationTime, lFixValidStatus};
					
					//创建行
					//headTitle_YJXZ
					HSSFRow row = sheet_YJXZ.createRow(index_YJXZ);
					//创建列
					for(int j=0; j<export_length_YJXZ; j++){
						HSSFCell cell = row.createCell((short)j);
						cell.setCellValue((RichTextString)(new HSSFRichTextString(column[j])));
						if(j==0){
							cell.setCellStyle(BoldUnderlineCENTRE);
						}else{
							cell.setCellStyle(BoldUnderlineCENTRE);
						}
					}
				}else{
					/***********************************************机器猫指令****************************************/
					String processDate = DateUtil.format(obj.getDate("processDate"));//处理日期
					String combProductCode = StrUtil.changeNull(obj.getString("combProductCode"));//产品代码
					String combProductName = StrUtil.changeNull(obj.getString("combProductName"));//产品名称
					String vcCombiNo = StrUtil.changeNull(obj.getString("vcCombiNo"));//投资组合编号
					vcCombiName = StrUtil.changeNull(obj.getString("vcCombiName"));//投资组合名称
					String investProductNum = StrUtil.changeNull(obj.getString("investProductNum"));//编号
					String processType = StrUtil.changeNull(obj.getString("processType"));//业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）：01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;16-交易所协议正回购;17-交易所协议逆回购;99-其他指令/建议;
					String validStatus = getDictName(ProductProcessUtil.CF_JY_PRODUCT_PROCESS_VALID_STATUS, StrUtil.changeNull(obj.getString("validStatus")));//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
					String abandonedReasons = StrUtil.changeNull(obj.getString("abandonedReasons"));//废弃原因
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
					//----////
					String deliveryMethod = StrUtil.changeNull(obj.getString("deliveryMethod"));//1.3.交割方式/4.交易方向
					String memo = StrUtil.changeNull(obj.getString("memo"));//4.备注（基金公司联系人、基金转换为哪支基金等信息）/5.备注（托管行联系人等信息）
					String agreementNum = StrUtil.changeNull(obj.getString("agreementNum"));//1.约定号
					String seatNum = StrUtil.changeNull(obj.getString("seatNum"));//1.席位号
					//----////
					String transformFundCode = StrUtil.changeNull(obj.getString("transformFundCode"));//4.转入基金代码
					String transformFundName = StrUtil.changeNull(obj.getString("transformFundName"));//4.转入基金名称
					String tpZcya = StrUtil.changeNull(obj.getString("tpZcya"));//赞成议案
					String tpFdyz = StrUtil.changeNull(obj.getString("tpFdyz"));//反对议案
					String tpQqya = StrUtil.changeNull(obj.getString("tpQqya"));//弃权议案
					
					if("09".equals(processType) || "10".equals(processType) || "11".equals(processType)){
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
			
			//组装附件名称
			String filename = "指令导出"+DateUtil.formatDateTimeYYYYMMDDHHMMSSS(new Date()) +".xls";
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
}
