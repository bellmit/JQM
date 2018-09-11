/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.RichTextString;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.ExportBbSystemExcle;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * 指令信息导出
 * @author tongwei
 *
 */
public class instructExport {
	
	/** Excel文件名称前缀（指令查询页面）*/
	public static final String EXCEL_NAME_PREFIX_instructQuery = "指令查询_";
	
	/** Excel文件名称前缀(指令管理页面)*/
	public static final String EXCEL_NAME_PREFIX_instructManage = "指令管理_";
	
	/** Excel文件名称前缀(询价管理页面)*/
	public static final String EXCEL_NAME_PREFIX_inquiryManage = "询价管理_";
	
	/**
	 * 指令导出
	 * @param exportData	导出记录
	 * @param paramObject	导出条件参数
	 * @param saveExcelUrl
	 * @return
	 * @throws Exception
	 */
	@Bizlet("")
	public static String getInstructExport(List<DataObject> exportData, DataObject paramObject, String saveExcelUrl) throws Exception {
		try {
			//创建Excel文件
			HSSFWorkbook workbook = new HSSFWorkbook();
			
			//设置列头字体格式
			HSSFFont headFont = workbook.createFont();
			headFont.setFontName("宋体");
			headFont.setFontHeightInPoints((short) 11);// 字体大小
			headFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 加粗
			//设置列头字体对齐格式
			HSSFCellStyle sheetHeadFormat = workbook.createCellStyle();
			sheetHeadFormat.setFont(headFont);
			sheetHeadFormat.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			sheetHeadFormat.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			sheetHeadFormat.setLocked(true);
			sheetHeadFormat.setWrapText(true);// 自动换行
			
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
			
			
			String[] sheetHeadTitle = null;//Sheet列标题数组
			String[] columnKeyArr = null;//获取字段值关键key数组
			Object[] changeObjArr = null;//值转换格式对象数组
			String sheetName = "";
			// 导出页面类型（指令查询1,指令管理2,询价管理3）
			String webType = paramObject.getString("webType");
			if("1".equals(webType)){
				sheetName = EXCEL_NAME_PREFIX_instructQuery+StrUtil.changeNull(paramObject.getString("sheetName"));//Excel文件Sheet名称
			}else if("2".equals(webType)){
				sheetName = EXCEL_NAME_PREFIX_instructManage+StrUtil.changeNull(paramObject.getString("sheetName"));//Excel文件Sheet名称
			}else if("3".equals(webType)){
				sheetName = EXCEL_NAME_PREFIX_inquiryManage+StrUtil.changeNull(paramObject.getString("sheetName"));//Excel文件Sheet名称
			}
			// 查询类型（买卖指令1,回购指令2）
			String exportType = paramObject.getString("exportType");
			//指令类型（1-询价指令，2-完整指令）
			String exportInstructType = paramObject.getString("exportInstructType");
			if("1".equalsIgnoreCase(exportType)){
				sheetHeadTitle = new String[]{"指令状态", "产品名称", "组合名称", "清算速度", "业务类别", "委托方向", "交易对手", "对方交易员", "对手席位", "债券代码", "债券名称", "券面金额（万元）", " 录入日期", "交易日", "结算日", "净价", "全价", "到期收益率（%）", "行权收益率（%）", "录入时间", "复核时间", "确认时间", "投资经理确认时间", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "指令/建议序号", "备注" ,"指令复核审批意见"};
				columnKeyArr = new String[]{"cIsValid", "vcProductName", "vcCombiName", "vcSettleSpeed", "vcBizType", "vcEntrustDirection", "vcCounterpartyName", "vcCounterpartyTrader", "vcRivalSeat", "vcStockCode", "vcStockName", "enFaceAmount", "lResultDate", "lTradeDate", "lFirstSettleDate", "enNetPrice","enFullPrice","enMaturityYield", "enOptionYield", "tResultInputTime", "vcAdviserConfirm", "vcEntrustConfirm", "tFsSendTime", "tFsOperateTime", "tFsCheckTime", "tFsDealTime", "vcBsDealStatus", "lResultNo", "vcRemark" ,"vcComments"};
				changeObjArr = new Object[]{null, null, null, null, null, null, null, null, null, null, null, StrUtil.df4, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null ,null};
			
			}else if("2".equalsIgnoreCase(exportType)){
				if("1".equalsIgnoreCase(exportInstructType)){
					sheetHeadTitle = new String[]{"指令状态", "产品名称", "组合名称", "清算速度", "业务类别", "委托方向", "交易对手", "回购天数(天)", "回购金额(万元)", "回购利率(%)", 
							"录入日期", "交易日", "首次结算日", "到期结算日", "首次结算金额(元)", "到期结算金额(元)", "报价方式", "加权加点(bp)", "录入时间", "投资经理确认时间", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "债券代码", "债券名称", "券面金额(万元)", "折算比例(%)", "指令序号", "备注", "指令编号"};
					columnKeyArr = new String[]{"cIsValid", "vcProductName", "vcCombiName", "vcSettleSpeed", "vcBizType", "vcEntrustDirection",
							"vcCounterpartyName", "lRepoDays", "enFaceAmount", "enRepoRate", "lResultDate", "lTradeDate", "lFirstSettleDate", "lMaturitySettleDate", "enFullPriceAmount", 
							"enSettleAmount", "vcQuoteMode", "enWeightingValue", "tResultInputTime", "vcAdviserConfirm", "vcEntrustConfirm", "tFsSendTime",
							"tFsDealTime", "vcBsDealStatus", "vcStockCode", "vcStockName", "enFaceAmount", "conversionRatio", "lResultNo", "vcRemark", "lResultId"};
					changeObjArr = new Object[]{null, null, null, null, null, null, null, null, StrUtil.df4, null, null, null, null, null, StrUtil.df3, StrUtil.df3, null, null, null, null, null, null, null, null, null, null, StrUtil.df4, null, null, null, null};
				}else{
					sheetHeadTitle = new String[]{"指令状态", "产品名称", "组合名称", "清算速度", "业务类别", "委托方向", "交易对手", "回购天数(天)", "回购金额(万元)", "回购利率(%)", 
							"录入日期", "交易日", "首次结算日", "到期结算日", "首次结算金额(元)", "到期结算金额(元)", "报价方式", "加权加点(bp)", "录入时间", "复核时间", 
							"确认时间", "投资经理确认时间", "前台录单时间", "前台发送时间", "前台成交时间", "后台成交状态", "债券代码", "债券名称", "券面金额(万元)", "折算比例(%)", "指令序号", "备注", "指令复核审批意见", "指令来源", "指令编号"};
					columnKeyArr = new String[]{"cIsValid", "vcProductName", "vcCombiName", "vcSettleSpeed", "vcBizType", "vcEntrustDirection",
							"vcCounterpartyName", "lRepoDays", "enFaceAmount", "enRepoRate", "lResultDate", "lTradeDate", "lFirstSettleDate", "lMaturitySettleDate", "enFullPriceAmount", 
							"enSettleAmount", "vcQuoteMode", "enWeightingValue", "tResultInputTime", "vcAdviserConfirm", "vcEntrustConfirm", "tFsSendTime", "tFsOperateTime", "tFsCheckTime", 
							"tFsDealTime", "vcBsDealStatus", "vcStockCode", "vcStockName", "enFaceAmount", "conversionRatio", "lInstructNo", "vcRemark", "vcComments", "vcInstructSource", "lResultId"};
					changeObjArr = new Object[]{null, null, null, null, null, null, null, null, StrUtil.df4, null, null, null, null, null, StrUtil.df3, StrUtil.df3, null, null, null, null, null, null, null, null, null, null, null, null, StrUtil.df4, null, null, null, null, null, null};
				}
			}
			
			createExcelSheet(workbook, sheetName, sheetHeadTitle, columnKeyArr, changeObjArr, exportData, sheetHeadFormat, BoldUnderlineCENTRE, BoldUnderlineLEFT, paramObject);
			
			String fileName = sheetName +DateUtil.formatDateTimeYYYYMMDDHHMMSSS(new Date())+ ".xls";
			
			String pageUrl = ExportBbSystemExcle.exportExcel(workbook, fileName, saveExcelUrl);
			return pageUrl;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 将业务数据导出Excel文件
	 * @param workbook Excel工作薄
	 * @param sheetName Sheet名称
	 * @param sheetHeadTitle Sheet列标题数组
	 * @param columnKeyArr 获取字段值关键key数组
	 * @param changeObjArr 值转换格式对象数组
	 * @param exportData 需导出的数据
	 * @param sheetHeadFormat Sheet列标题样式
	 * @param BoldUnderlineCENTRE 居中对齐样式
	 * @param BoldUnderlineLEFT 左对齐样式
	 * @author tongwei
	 */
	@Bizlet("")
	public static void createExcelSheet(HSSFWorkbook workbook, String sheetName, String[] sheetHeadTitle, String[] columnKeyArr, Object[] changeObjArr, List<DataObject> exportData, HSSFCellStyle sheetHeadFormat, HSSFCellStyle BoldUnderlineCENTRE, HSSFCellStyle BoldUnderlineLEFT, DataObject paramObject){
		//将DataObject对象数据转换为字符串数组
		List<String[]> changeData = changeArr(exportData, columnKeyArr, changeObjArr);
		createExcelSheet(changeData, workbook, sheetName, sheetHeadTitle, sheetHeadFormat, BoldUnderlineCENTRE, BoldUnderlineLEFT, paramObject);
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
	 * 将业务数据导出Excel文件(区分是否有质押券)
	 * @param exportData 需导出的数据
	 * @param workbook Excel工作薄
	 * @param sheetName Sheet名称
	 * @param sheetHeadTitle Sheet列标题数组
	 * @param sheetHeadFormat Sheet列标题样式
	 * @param BoldUnderlineCENTRE 居中对齐样式
	 * @param BoldUnderlineLEFT 左对齐样式
	 * @author tongwei
	 */
	@Bizlet("")
	public static void createExcelSheet(List<String[]> exportData, HSSFWorkbook workbook, String sheetName, String[] sheetHeadTitle, HSSFCellStyle sheetHeadFormat, HSSFCellStyle BoldUnderlineCENTRE, HSSFCellStyle BoldUnderlineLEFT, DataObject paramObject){
		//导出类型(买卖指令1，回购指令2)
		String exportType = paramObject.getString("exportType");
		//指令类型（1-询价指令，2-完整指令）
		String exportInstructType = paramObject.getString("exportInstructType");
		//创建Sheet
		HSSFSheet sheet = workbook.createSheet(sheetName);
		//创建第一行（标题行）
		HSSFRow row0 = sheet.createRow(0);
		// 表头长度
		int sheetHeadTitleLength = sheetHeadTitle.length;
		//创建第一列（标题列）
		if(exportType.equals("2")){
			sheetHeadTitleLength = sheetHeadTitleLength-1;
		}
		for(int i=0; i<sheetHeadTitleLength; i++){
			HSSFCell cell = row0.createCell((short)i);
			cell.setCellValue((RichTextString)new HSSFRichTextString(sheetHeadTitle[i]));
			cell.setCellStyle(sheetHeadFormat);
			sheet.setColumnWidth((short)i, (short)5500);//设置列宽
		}
		int index_excleTable = 0;
		//导出数据
		for(int i=0; i<exportData.size(); i++){
			String[] strArr = exportData.get(i);
			// 导出类型(vcBizType = strArr[7]=5=质押式回购)
			if(exportType.equals("2")){
				// 结果指令id
				String lResultId = "";
				// 指令来源
				String instructResource = "";
				//获取质押券信息
				DataObject[] bonds = null;
				if("1".equalsIgnoreCase(exportInstructType)){
					// 结果指令id
					lResultId = strArr[30];
					try {
						ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.ats.sm.inquiry.inquiryResultManage");
						Object[] objArr = comp.invoke("getMortgageInfo", new String[] {lResultId});//调用逻辑流的方法
						if (objArr != null && objArr.length > 0) {
							bonds = (DataObject[]) objArr[0];
						}
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}else{
					lResultId = strArr[33];
					instructResource = strArr[32]; 
					if("3".equals(instructResource)){
						strArr[32] = "新版本";
					}else if("2".equals(instructResource) || "1".equals(instructResource)){
						strArr[32] = "老版本";
					}
					try {
						
						ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.ats.sm.comm.InstructionManager");
						Object[] objArr = comp.invoke("getJqmAndSmMortgageInfo", new String[] {"", lResultId, instructResource });//调用逻辑流的方法
						if (objArr != null && objArr.length > 0) {
							bonds = (DataObject[]) objArr[0];
						}
					} catch (Throwable e) {
						e.printStackTrace();
					}
				}
				DataObject bond = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.atsSmData.TAtsInquiryResultMortagage");
				//存在债券信息
				if (bonds != null && bonds.length > 0) {
					for (int bondNum = 0; bondNum < bonds.length; bondNum++) {
						index_excleTable++;
						bond = bonds[bondNum];
						String vcStockCode = StrUtil.changeNull(bond.getString("vcStockCode"));
						String vcStockName = StrUtil.changeNull(bond.getString("vcStockName"));
						String enFaceAmount = StrUtil.changeNull(bond.getString("enFaceAmount")).replaceAll(",", "");
						String conversionRatio = StrUtil.changeNull(bond.getString("enMortagageRatio"));
						//判断券面总额(万元)是否为空，不为空时执行替换
						if(!conversionRatio.equals("")){
							conversionRatio = conversionRatio.replaceAll(",", "");
						}
						StrUtil.nf.setGroupingUsed(false);
						if (bondNum == 0) {
							if("1".equalsIgnoreCase(exportInstructType)){
								strArr[24] = vcStockCode;
								strArr[25] = vcStockName;
								strArr[26] = enFaceAmount;
								strArr[27] = conversionRatio;
							}else{
								strArr[26] = vcStockCode;
								strArr[27] = vcStockName;
								strArr[28] = enFaceAmount;
								strArr[29] = conversionRatio;
							}
							//创建数据行
							HSSFRow row = sheet.createRow(index_excleTable);
							//创建数据列
							for(int j=0; j<sheetHeadTitleLength; j++){
								HSSFCell cell = row.createCell((short)j);
								cell.setCellStyle(BoldUnderlineCENTRE);
								cell.setCellValue((RichTextString)new HSSFRichTextString(strArr[j]));
							}
						}else {
							String[] bondStrArr = new String[] {vcStockCode, vcStockName, enFaceAmount, conversionRatio};
							//创建数据行
							HSSFRow row = sheet.createRow(index_excleTable);
							//创建数据列
							for(int j=0; j<bondStrArr.length; j++){
								HSSFCell cell = null;
							
								if("1".equalsIgnoreCase(exportInstructType)){
									cell = row.createCell((short) (j + 24));

								}else{
									cell = row.createCell((short) (j + 26));
								}
								cell.setCellStyle(BoldUnderlineCENTRE);
								cell.setCellValue((RichTextString)(new HSSFRichTextString(bondStrArr[j])));
								
							}
						}
					} 
				}else{
					index_excleTable++;
					if("1".equalsIgnoreCase(exportInstructType)){
						strArr[24] = "";
						strArr[25] = "";
						strArr[26] = "";
						strArr[27] = "";
					}else{
						strArr[26] = "";
						strArr[27] = "";
						strArr[28] = "";
						strArr[29] = "";
					}
					//创建数据行
					HSSFRow row = sheet.createRow(index_excleTable);
					//创建数据列
					for(int j=0; j<sheetHeadTitleLength; j++){
						HSSFCell cell = row.createCell((short)j);
						cell.setCellStyle(BoldUnderlineCENTRE);
						cell.setCellValue((RichTextString)new HSSFRichTextString(strArr[j]));
					}
				}
			}else{
				index_excleTable++;
				//创建数据行
				HSSFRow row = sheet.createRow(index_excleTable);
				//创建数据列
				for(int j=0; j<strArr.length; j++){
					HSSFCell cell = row.createCell((short)j);
					cell.setCellStyle(BoldUnderlineCENTRE);
					cell.setCellValue((RichTextString)new HSSFRichTextString(strArr[j]));
				}
			}
		}
	}
	
	/**
	 * 把传入的类型dateobejct[] 转为  类型List<DataObject>
	 * @author tongwei
	 * @param data（类型dateobejct[]） 入参
	 * @param exportType 导出类型（买卖业务1.回购业务2）
	 * @return	list(类型List<DataObject>)
	 */
	@Bizlet("dataobject[]转List<DataObject>")
	public static List<DataObject> objectReplaceList(DataObject[] data, String exportType){
		List<DataObject> list = new ArrayList<DataObject>();
		if(data.length > 0){
			for(int i=0; i<data.length; i++){
				// 指令状态翻译
				if(data[i].getString("cIsValid") != null){
					String cIsValidText = getDictidName("instructStatus",data[i].getString("cIsValid"));
					data[i].setString("cIsValid", cIsValidText);
				}
				// 风控审批状态翻译
				if(data[i].getString("vcRiskApproveStatus") != null){
					String riskApproveStatusText = getDictidName("riskApproveStatus",data[i].getString("vcRiskApproveStatus"));
					data[i].setString("vcRiskApproveStatus", riskApproveStatusText);
				}else{
					data[i].setString("vcRiskApproveStatus", "--");
				}
				// 指令类型翻译
				if(data[i].getString("vcInstructType") != null){
					String vcInstructTypeText = getDictidName("instructType",data[i].getString("vcInstructType"));
					data[i].setString("vcInstructType", vcInstructTypeText);
				}
				// 买卖业务
				if(exportType.equals("1")){
					// 业务类别翻译
					if(data[i].getString("vcBizType") != null){
						String vcBizTypeText = getDictidName("bizTypeTransaction",data[i].getString("vcBizType"));
						data[i].setString("vcBizType", vcBizTypeText);
					}
					// 委托方向翻译
					if(data[i].getString("vcEntrustDirection") != null){
						String vcEntrustDirectionText = getDictidName("entrustDirectionTransaction",data[i].getString("vcEntrustDirection"));
						data[i].setString("vcEntrustDirection", vcEntrustDirectionText);
					}
				}
				// 回购业务
				if(exportType.equals("2")){
					// 业务类别翻译 
					if(data[i].getString("vcBizType") != null){
						String vcBizTypeText = getDictidName("bizTypeRepurchase",data[i].getString("vcBizType"));
						data[i].setString("vcBizType", vcBizTypeText);
					}
					// 委托方向翻译
					if(data[i].getString("vcEntrustDirection") != null){
						String vcEntrustDirectionText = getDictidName("entrustDirectionRepurchase",data[i].getString("vcEntrustDirection"));
						data[i].setString("vcEntrustDirection", vcEntrustDirectionText);
					}
					// 到期结算日期
					System.out.println(data[i].getString("lMaturitySettleDate"));
					if(data[i].getString("lMaturitySettleDate") != null && !"0".equals(data[i].getString("lMaturitySettleDate"))){
						String lMaturitySettleDateText = String.valueOf(data[i].getLong("lMaturitySettleDate"));
						lMaturitySettleDateText = lMaturitySettleDateText.substring(0,4)+"-"+lMaturitySettleDateText.substring(4,6)+"-"+lMaturitySettleDateText.substring(6,8);
						data[i].setString("lMaturitySettleDate", lMaturitySettleDateText);
					}else{
						data[i].setString("lMaturitySettleDate", "");
					}
					// 报价方式翻译
					if(data[i].getString("vcQuoteMode") != null){
						String vcQuoteModeText = getDictidName("quoteMode",data[i].getString("vcQuoteMode"));
						data[i].setString("vcQuoteMode", vcQuoteModeText);
					}
				}
				// 后台成交状态翻译
				if(data[i].getString("vcBsDealStatus") != null){
					String vcBsDealStatusText = getDictidName("CF_JY_HTCJZT",data[i].getString("vcBsDealStatus"));
					data[i].setString("vcBsDealStatus", vcBsDealStatusText);
				}
				// 交易市场翻译
				if(data[i].getString("vcMarket") != null){
					String vcMarketText = getDictidName("tradePlace",data[i].getString("vcMarket"));
					data[i].setString("vcMarket", vcMarketText);
				}
				// 清算速度翻译
				if(data[i].getString("vcSettleSpeed") != null){
					String vcSettleSpeedText = getDictidName("settleSpeed",data[i].getString("vcSettleSpeed"));
					data[i].setString("vcSettleSpeed", vcSettleSpeedText);
				}
				// 时间显示格式
				SimpleDateFormat dateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				// 指令下达时间
				//if(data[i].getString("tInitiateTime") != null){
					//String tInitiateTimeText = data[i].getString("vcInitiatorName") +" "+ dateTime.format(data[i].getDate("tInitiateTime"));
					//data[i].setString("tInitiateTime", tInitiateTimeText);
				//}
				// 询价结果录入时间
				if(data[i].getString("tResultInputTime") != null){
					String tResultInputTimeText = data[i].getString("vcResultInputerName") +" "+ dateTime.format(data[i].getDate("tResultInputTime"));
					data[i].setString("tResultInputTime", tResultInputTimeText);
				}
				// 投资经理确认时间
				if(data[i].getString("tFsSendTime") != null && data[i].getString("vcFsSenderName") != null){
					String tFsSendTimeText = data[i].getString("vcFsSenderName") +" "+ dateTime.format(data[i].getDate("tFsSendTime"));
					data[i].setString("tFsSendTime", tFsSendTimeText);
				}
				// 前台录单时间
				if(data[i].getString("tFsOperateTime") != null){
					String tFsOperateTimeText = data[i].getString("vcFsOperatorName") +" "+ dateTime.format(data[i].getDate("tFsOperateTime"));
					data[i].setString("tFsOperateTime", tFsOperateTimeText);
				}
				// 前台发送时间
				if(data[i].getString("tFsCheckTime") != null){
					String tFsCheckTimeText = data[i].getString("vcFsCheckerName") +" "+ dateTime.format(data[i].getDate("tFsCheckTime"));
					data[i].setString("tFsCheckTime", tFsCheckTimeText);
				}
				// 指令下达日期
				if(data[i].getString("lResultDate") != null){
					String lResultDateText = String.valueOf(data[i].getLong("lResultDate"));
					lResultDateText = lResultDateText.substring(0,4)+"-"+lResultDateText.substring(4,6)+"-"+lResultDateText.substring(6,8);
					data[i].setString("lResultDate", lResultDateText);
				}
				// 交易日
				if(data[i].getString("lTradeDate") != null){
					String lTradeDateText = String.valueOf(data[i].getLong("lTradeDate"));
					lTradeDateText = lTradeDateText.substring(0,4)+"-"+lTradeDateText.substring(4,6)+"-"+lTradeDateText.substring(6,8);
					data[i].setString("lTradeDate", lTradeDateText);
				}
				// 结算日
				if(data[i].getString("lFirstSettleDate") != null){
					String lFirstSettleDateText = String.valueOf(data[i].getLong("lFirstSettleDate"));
					lFirstSettleDateText = lFirstSettleDateText.substring(0,4)+"-"+lFirstSettleDateText.substring(4,6)+"-"+lFirstSettleDateText.substring(6,8);
					data[i].setString("lFirstSettleDate", lFirstSettleDateText);
				}
				// 前台成交时间
				if(data[i].getString("tFsDealTime") != null){
					String tFsDealTimeText = dateTime.format(data[i].getDate("tFsDealTime"));
					data[i].setString("tFsDealTime", tFsDealTimeText);
				}
				// 指令推送状态
				String fixValidStatus = data[i].getString("lFixValidStatus");
				if(fixValidStatus == null || fixValidStatus.equals("") || fixValidStatus.equals("0")){
					data[i].setString("lFixValidStatus", "未发送");
		    	}else if(fixValidStatus.equals("1")){
		    		data[i].setString("lFixValidStatus", "不启用");
		    	}else if(fixValidStatus.equals("2")){
		    		data[i].setString("lFixValidStatus", "发送中");
		    	}else if(fixValidStatus.equals("3")){
		    		data[i].setString("lFixValidStatus", "发送成功");
		    	}else if(fixValidStatus.equals("4")){
		    		data[i].setString("lFixValidStatus", "发送失败");
		    	}
				list.add(data[i]);
			}
		}
		return list;
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
