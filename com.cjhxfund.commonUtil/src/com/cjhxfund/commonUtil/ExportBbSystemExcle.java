/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.RichTextString;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 童伟
 * @date 2016-12-08 10:02:59
 *	导出本币系统接口文件类
 */
@Bizlet("")
public class ExportBbSystemExcle {
	
	/**
	 * 导出本币系统接口文件（默认质押式回购）
	 * @param instructListByBiztypeAndCode(根据业务类别和产品代码分类后的map)
	 * @param instructListByBiztype(根据业务类别分类后的map)
	 * @param exportWebName(导出文件命名)
	 * @param saveExcelUrl(服务器临时保存地址)
	 * @param map（根据业务类别产品代码分类后的map）
	 * @return
	 * @throws Exception
	 * @author 童伟
	 */
	@SuppressWarnings("deprecation")
	@Bizlet("导出本币系统接口文件")
	public static String transactionManageExport(Map<String, List<DataObject>> instructListByBiztypeAndCode, Map<String, List<DataObject>> instructListByBiztype, String exportWebName, String saveExcelUrl) throws Exception {
		
		List<String> pageUrl = new ArrayList<String>();
		// 获取map内 区分不同产品和业务类别后记录
		if(!instructListByBiztypeAndCode.isEmpty() && !instructListByBiztype.isEmpty()){
			for(Entry<String, List<DataObject>> entry : instructListByBiztype.entrySet()){
				List<DataObject> instructList = entry.getValue();
				// 业务类别key
				String biztypeKey = entry.getKey().substring(0,1);
				
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
				
				// 质押式回购
				String[] pledgeRepurchase_headTitle_excleTable = new String[] {"本方", "对手方", "对手方交易员",
						"交易方向", "交易金额(元)", "回购利率(%)", "回购期限(天)", "清算速度", "首次结算方式",
						"到期结算方式", "清算类型", "有效时间", "补充条款", "资金开户行", "账户", "账户名",
						"资金开户行支付系统行号", "托管机构名称", "托管帐号", "托管账户户名", "债券代码", "债券名称",
						"券面总额(万元)", "折算比例(%)", "债券币种", "结算币种"};
				// 买断式回购
				String[] buyoutRepurchase_headTitle_excleTable = new String[] {"本方", "对手方", "对手方交易员", "交易方向","债券代码", "债券名称",
						  "回购利率(%)", "首次净价(元)", "到期净价(元)", "首次收益率(%)",
						"到期收益率(%)", "券面总额(万元)", "回购期限(天)", "清算速度", "首次结算方式","到期结算方式","清算类型", "报价有效时间"
						,"补充条款",  "账户名", "资金开户行","账户",
						"资金开户行支付系统行号", "托管账户户名", "托管机构名称", "托管帐号"};
				// 买卖业务
				String[] transactionDeal_headTitle_excleTable = new String[] {"本方", "对手方", "对手方交易员", "交易方向","代码", "名称",
						  "净价(元)", "到期收益率(%)", "行权收益率(%)",
						 "券面总额(万元)", "清算速度", "结算方式", "清算类型", "有效时间",
						"补充条款", "资金账户户名", "资金开户行名称", "资金账号", "支付系统行号",
						"托管账户户名", "托管机构名称", "托管帐号", "应计利息", "结算币种", "汇率"};
				
				String bizType = "";
				try {
					// 生成excle文件命名
					String filename = "";
					// 表头
					String[] headTitle_excleTable = null;
					// 业务类别
					if(biztypeKey.equals("1")){
						bizType = "银行间二级交易";
					}
					if(biztypeKey.equals("2")){
						bizType = "上海大宗交易";
					}
					if(biztypeKey.equals("3")){
						bizType = "上海固收平台";
					}
					if(biztypeKey.equals("4")){
						bizType = "深圳综合协议平台";
					}
					if(biztypeKey.equals("5")){
						bizType = "银行间质押式回购";
						headTitle_excleTable = pledgeRepurchase_headTitle_excleTable;
					}
					if(biztypeKey.equals("6")){
						bizType = "银行间买断式回购";
						headTitle_excleTable = buyoutRepurchase_headTitle_excleTable;
					}
					if(biztypeKey.equals("1") || biztypeKey.equals("2") || biztypeKey.equals("3") || biztypeKey.equals("4")){
						headTitle_excleTable = transactionDeal_headTitle_excleTable;
					}
					// 调用时生成excle文件方法
					filename = createExcle(instructList, bizType +"_"+ exportWebName, headTitle_excleTable, 
							workbook, headFormat, BoldUnderlineCENTRE, biztypeKey);
					// 根据产品代码分类生成其他的sheet
					for(Entry<String, List<DataObject>> productCodeMap : instructListByBiztypeAndCode.entrySet()){
						List<DataObject> instructByProductcodeList = productCodeMap.getValue();
						// 取产品名称
						String productName = instructByProductcodeList.get(0).getString("vcProductName");
						// 调用时生成excle文件方法，根据产品不通顺生成不同sheet页
						for(int i=0; i<instructByProductcodeList.size(); i++){
							// 业务类别
							String vcBizType = instructByProductcodeList.get(i).getString("vcBizType");
							if(vcBizType.equals(biztypeKey)){
								filename = createExcle(instructByProductcodeList, bizType +"_"+ productName, headTitle_excleTable, 
										workbook, headFormat, BoldUnderlineCENTRE, biztypeKey);
								break;
							}
						}
					}
					//导出excel
					String url = exportExcel(workbook, filename, saveExcelUrl);
					pageUrl.add(url);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			String resultUrl =FileDownload.batchDownloadFiles(pageUrl, saveExcelUrl);
			return resultUrl;
		}
		return null;
	}
	
	/**
	 * 导出excel
	 * @param workbook 生成的excel文件
	 * @param filename 文件名
	 * @return 文件路径和文件名拼接后的字符串
	 * @author 童伟
	 */
	public static String exportExcel(HSSFWorkbook workbook, String filename, String saveExcelUrl){
		String pageUrl = "";
		try{
			//设置URL
	        pageUrl = saveExcelUrl + filename;

	        File file = new File(pageUrl);
	        //判断文件夹是否存在,如果不存在则创建文件夹
	        if (!file.exists() && !file.isDirectory()) {
	        	new File(saveExcelUrl).mkdirs();
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
	
	/**
	 * 根据产品代码和业务类型拆分数组
	 * @param list	要处理的list数组
	 * @param	vcProductCode(产品代码)
	 * @param	vcBizType(业务类型)
	 * @return list 处理后的数组
	 * @author 童伟
	 */
	@Bizlet("根据产品代码和业务类型拆分数组")
	public static Map<String, List<DataObject>> splitExcleInstructList(DataObject[] paramList){
		// 定义返回时map
		Map<String, List<DataObject>> resultMap = new HashMap<String, List<DataObject>>();
		// 循环入参
		for(int i = 0; i<paramList.length; i++){
			// 把产品代码和业务类别赋值到key，后面判断key值相同的记录，添加到同一个list
			String bizType = (String) paramList[i].get("vcBizType");
			String productCode = (String)paramList[i].get("vcProductCode");
			String mapKey = bizType + "," + productCode;
			// 产品代码+业务类别
			if(resultMap.containsKey(mapKey)){
				List<DataObject> mapList = resultMap.get(mapKey);
				mapList.add(paramList[i]);
				resultMap.put(mapKey, mapList);
			}else{
				List<DataObject> list = new ArrayList<DataObject>();
				list.add(paramList[i]);
				resultMap.put(mapKey, list);
			}
		}
		return resultMap;
	}
	
	/**
	 * 根据业务类型拆分数组
	 * @param paramList	要处理的list数组
	 * @return resultMap 处理后的数组
	 * @author 童伟
	 */
	@Bizlet("根据业务类型拆分数组")
	public static Map<String, List<DataObject>> splitExcleInstructListByBizType(DataObject[] paramList){
		// 定义返回时map
		Map<String, List<DataObject>> resultMap = new HashMap<String, List<DataObject>>();
		// 循环入参
		for(int i = 0; i<paramList.length; i++){
			// 把业务类别和产品代码赋值到key，后面判断key值相同的记录，添加到同一个list
			String bizType = (String) paramList[i].get("vcBizType");
			String mapKey = bizType;
			// 产品代码
			if(resultMap.containsKey(mapKey)){
				List<DataObject> mapList = resultMap.get(mapKey);
				mapList.add(paramList[i]);
				resultMap.put(mapKey, mapList);
			}else{
				List<DataObject> list = new ArrayList<DataObject>();
				list.add(paramList[i]);
				resultMap.put(mapKey, list);
			}
		}
		return resultMap;
	}
	
	/**
	 * @author tongwei
	 * @param instructList
	 * @param exportWebName
	 * @param ExcleHeadTitle
	 * @param workbook
	 * @param headFormat
	 * @param BoldUnderlineCENTRE
	 * @param biztypeKey
	 * @return
	 */
	public static String createExcle(List<DataObject> instructList, String exportWebName, String[] ExcleHeadTitle, 
			HSSFWorkbook workbook, HSSFCellStyle headFormat, HSSFCellStyle BoldUnderlineCENTRE, String biztypeKey){

		// 产品名称
		String productName = "";
		// 交易对手
		String tradingOpponent = "";
		// 对方交易员
		String tradingOpponentName = "";
		// 本方
		String theSide = "";
		// 结果指令id
		String resultId = "";
		// 委托方向
		String processType = "";
		// 交易金额（万元）
		String tranAmount = "";
		// 回购利率（%）
		String tradingRate = "";
		// 回购期限（天）
		String actualDays = "";
		// 清算速度
		String clearingSpeed = "";
		// 首期结算方式
		String firstSettlement = "券款对付";
		// 到期结算方式
		String dueSettlement = "券款对付";
		// 清算类型
		String settlementType = "全额清算"; 
		// 有效时间
		String effectiveTime = "19:30"; 
		// 补充条款
		String subsidiaryClause = ""; 
		// 资金开户行
		String capitalAccount = ""; 
		// 账户
		String account = ""; 
		// 资金开户行支付系统行号
		String paymentNumber = ""; 
		// 托管机构名称
		String custodianName = ""; 
		// 托管账户
		String escrowAccount = ""; 
		// 托管账户户名
		String escrowAccountName = ""; 
		// 债券代码
		String vcStockCode = "";
		// 债券名称
		String vcStockName = "";
		// 卷面金额
		String investCount = "";
		// 折算比例（%）
		String conversionRatio = "";
		// 结算币种
		String currency = "CNY";
		// 首次净价（元）
		String enNetPriceInit = "";
		// 到期净价（元）	
		String enNetPriceFinal = "";
		// 首次收益率（%）	
		String enFirstYield = "";	
		// 到期收益率（%）	
		String enMaturityYield = "";
		// 行权收益率（%）	
		String enOptionYield = "";
		// 业务类别
		String bizType = "";
		// 净价(元)
		String enNetPrice = "";
		int index_excleTable = 0;
		
		// 创建一个excle表文件（存放相同业务不同的产品汇总）
		HSSFSheet excleTable = workbook.createSheet(exportWebName);
		//创建第一行
		HSSFRow row0_ExcleTable = excleTable.createRow(0);
		int export_length_excleTable = ExcleHeadTitle.length;
		
		for (int i = 0; i < export_length_excleTable; i++) {
			HSSFCell cell = row0_ExcleTable.createCell((short) i);
			cell.setCellValue((RichTextString)(new HSSFRichTextString(ExcleHeadTitle[i])));
			cell.setCellStyle(headFormat);
			
			if (i == 0) {//序号
				excleTable.setColumnWidth((short) i, (short) 5000);//设置列宽
			} else {
				excleTable.setColumnWidth((short) i, (short) 5000);//设置列宽
			}
		}
		Boolean isNum = false;//data是否为数值型
        Boolean isInteger=false;//data是否为整数
        Boolean isPercent=false;//data是否为百分数
		// 质押式和买断式回购
		if(biztypeKey.equals("5") || biztypeKey.equals("6")){
			for (int i = 0; i < instructList.size(); i++) {
				DataObject obj = instructList.get(i);
				// 本方
				theSide = StrUtil.changeNull(obj.getString("theSide"));
				//交易对手
				tradingOpponent = StrUtil.changeNull(obj.getString("vcCounterpartyName"));
				//对手方交易员
				tradingOpponentName = StrUtil.changeNull(obj.getString("vcCounterpartyTrader")); 
				// 结果指令id
				resultId = StrUtil.changeNull(obj.getString("lResultId"));
				// 委托方向
				processType = StrUtil.changeNull(obj.getString("vcEntrustDirection"));
				// 回购利率（%）
				tradingRate = StrUtil.changeNull(obj.getString("enRepoRate"));
				// 卷面金额
				investCount = StrUtil.changeNull(obj.getString("enFaceAmount"));
				// 清算速度
				clearingSpeed = StrUtil.changeNull(obj.getString("vcSettleSpeed"));
				// 回购期限（天）
				actualDays = StrUtil.changeNull(obj.getString("lRepoDays"));
				// 交易金额（万元）
				tranAmount = StrUtil.changeNull(obj.getString("enFaceAmount"));
				// 转换交易金额格式（元）
				double tranAmounts;
				if(!tranAmount.equals("")){
					// 转换交易金额格式（元）
					tranAmounts = (Double.valueOf(StrUtil.delThousandth(tranAmount))*10000);
				}else{
					tranAmounts = 0;
				}
				// 产品名称
				productName = StrUtil.changeNull(obj.getString("vcProductName"));
				// 托管机构名称
				custodianName = StrUtil.changeNull(obj.getString("vcDepository")); 
				
				// 交易方向
				if(processType.equals("5")){
					processType = "正回购";
				}
				if(processType.equals("6")){
					processType = "逆回购";
				}
				
				// 清算速度
				if(clearingSpeed.equals("0")){
					clearingSpeed = "T+0";
				}
				if(clearingSpeed.equals("1")){
					clearingSpeed = "T+1";
				}
				if(clearingSpeed.equals("9")){
					clearingSpeed = "不限";
				}
				
				// 托管机构，1-中债登，2-上清所
				if(!custodianName.equals("")){
					if(custodianName.equals("1")){
						custodianName = "中债登";
					}
					if(custodianName.equals("2")){
						custodianName = "上清所";
					}
				}
				
				// 指令来源
				String instructResource = StrUtil.changeNull(obj.getString("vcInstructSource")); 
				
				//获取质押券信息
				DataObject[] bonds = null;
				try {
					ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.ats.sm.comm.InstructionManager");
					Object[] objArr = comp.invoke("getJqmAndSmMortgageInfo", new String[] {"", resultId, instructResource });//调用逻辑流的方法
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
						index_excleTable++;
						bond = bonds[bondNum];
						// 质押式回购参数
						vcStockCode = StrUtil.changeNull(bond.getString("vcStockCode"));
						vcStockName = StrUtil.changeNull(bond.getString("vcStockName"));
						investCount = StrUtil.changeNull(bond.getString("enFaceAmount"));
						conversionRatio = StrUtil.changeNull(bond.getString("enMortagageRatio"));
						
						// 买断式回购参数
						// 首次净价（元）
						enNetPriceInit = String.valueOf(StrUtil.changeNull(bond.getString("enNetPriceInit")));
						// 到期净价（元）	
						enNetPriceFinal = String.valueOf(StrUtil.changeNull(bond.getString("enNetPriceFinal")));
						// 首次收益率（%）	
						enFirstYield = String.valueOf(StrUtil.changeNull(bond.getString("enFirstYield")));	
						// 到期收益率（%）	
						enMaturityYield = String.valueOf(StrUtil.changeNull(bond.getString("enMaturityYield")));
						
						StrUtil.nf.setGroupingUsed(false);
						if (bondNum == 0) {
							// 给excel表填入记录
							String[] column = null;
							long stockCodeLength; 
							if(biztypeKey.equals("5")){
								column = new String[] {theSide,
										tradingOpponent,tradingOpponentName,processType,
										String.valueOf(StrUtil.nf.format(tranAmounts)),tradingRate, actualDays, clearingSpeed,
										firstSettlement, dueSettlement,
										settlementType, effectiveTime,
										subsidiaryClause, capitalAccount, account,
										productName, paymentNumber, custodianName,
										escrowAccount, escrowAccountName, vcStockCode,
										vcStockName, investCount, conversionRatio, currency, currency};
								// 业务类别
								bizType = "银行间质押式回购";
								stockCodeLength = 20;
							}else{
								column = new String[] {theSide,
										tradingOpponent,tradingOpponentName,processType,
										vcStockCode, vcStockName, tradingRate, enNetPriceInit,
										enNetPriceFinal, enFirstYield,
										enMaturityYield, investCount,
										actualDays, clearingSpeed, firstSettlement,
										dueSettlement, settlementType, effectiveTime,
										subsidiaryClause, productName, capitalAccount,
										account, paymentNumber, escrowAccountName, custodianName, escrowAccount, currency};
								// 业务类别
								bizType = "银行间买断式回购";
								stockCodeLength = 4;
							}
							//创建行
							HSSFRow row = excleTable.createRow(index_excleTable);
							
							
							//创建列
							for (int j = 0; j < export_length_excleTable; j++) {
								HSSFCell cell = row.createCell((short) j);
						        if (column[j] != null || "".equals(column[j])) {
						            //判断data是否为数值型
						            isNum = column[j].toString().matches("^(-?\\d+)(\\.\\d+)?$");
						            //判断data是否为整数（小数部分是否为0）
						            isInteger=column[j].toString().matches("^[-\\+]?[\\d]*$");
						            //判断data是否为百分数（是否包含“%”）
						            isPercent=column[j].toString().contains("%");
						        }

						        //如果单元格内容是数值类型，涉及到金钱（金额、本、利），则设置cell的类型为数值型，设置data的类型为数值类型
						        if ((isNum && !isPercent) && j != stockCodeLength) {
						            // 设置单元格格式
						            cell.setCellStyle(BoldUnderlineCENTRE);
						            // 设置单元格内容为double类型
						            cell.setCellValue(Double.parseDouble(column[j]));
						        } else {
						        	cell.setCellStyle(BoldUnderlineCENTRE);
						            // 设置单元格内容为字符型
						        	cell.setCellValue(column[j]);
						        }
							}
						}else if(biztypeKey.equals("5")){
							String[] column = new String[] {vcStockCode, vcStockName, investCount, conversionRatio};
							//创建行
							HSSFRow row = excleTable.createRow(index_excleTable);
							//创建列
							for (int j = 0; j < column.length; j++) {
								HSSFCell cell = null;
								if (j == 0) {
									cell = row.createCell((short) (j + 20));
								} else {
									cell = row.createCell((short) (j + 20));
								}
								if (column[j] != null || "".equals(column[j])) {
						            //判断data是否为数值型
						            isNum = column[j].toString().matches("^(-?\\d+)(\\.\\d+)?$");
						            //判断data是否为整数（小数部分是否为0）
						            isInteger=column[j].toString().matches("^[-\\+]?[\\d]*$");
						            //判断data是否为百分数（是否包含“%”）
						            isPercent=column[j].toString().contains("%");
						        }

						        //如果单元格内容是数值类型，涉及到金钱（金额、本、利），则设置cell的类型为数值型，设置data的类型为数值类型
						        if ((isNum && !isPercent) && j != 0) {
						            // 设置单元格格式
						            cell.setCellStyle(BoldUnderlineCENTRE);
						            // 设置单元格内容为double类型
						            cell.setCellValue(Double.parseDouble(column[j]));
						        } else {
						        	cell.setCellStyle(BoldUnderlineCENTRE);
						            // 设置单元格内容为字符型
						        	cell.setCellValue(column[j]);
						        }
							}
						}
					} 
				}else if(biztypeKey.equals("5")){
					index_excleTable++;
					String[] column = new String[] {theSide,
							tradingOpponent,tradingOpponentName,processType,
							String.valueOf(StrUtil.nf.format(tranAmounts)),tradingRate, actualDays, clearingSpeed,
							firstSettlement, dueSettlement,
							settlementType, effectiveTime,
							subsidiaryClause, capitalAccount, account,
							productName, paymentNumber, custodianName,
							escrowAccount, escrowAccountName, "",
							"", "", "", "", ""};
					// 业务类别
					bizType = "银行间质押式回购";
					//创建行
					HSSFRow row = excleTable.createRow(index_excleTable);
					//创建列
					for (int j = 0; j < export_length_excleTable; j++) {
						HSSFCell cell = row.createCell((short) j);
						
						if (column[j] != null || "".equals(column[j])) {
				            //判断data是否为数值型
				            isNum = column[j].toString().matches("^(-?\\d+)(\\.\\d+)?$");
				            //判断data是否为整数（小数部分是否为0）
				            isInteger=column[j].toString().matches("^[-\\+]?[\\d]*$");
				            //判断data是否为百分数（是否包含“%”）
				            isPercent=column[j].toString().contains("%");
				        }

				        //如果单元格内容是数值类型，涉及到金钱（金额、本、利），则设置cell的类型为数值型，设置data的类型为数值类型
				        if ((isNum && !isPercent) && j != 20) {
				            // 设置单元格格式
				            cell.setCellStyle(BoldUnderlineCENTRE);
				            // 设置单元格内容为double类型
				            cell.setCellValue(Double.parseDouble(column[j]));
				        } else {
				        	cell.setCellStyle(BoldUnderlineCENTRE);
				            // 设置单元格内容为字符型
				        	cell.setCellValue(column[j]);
				        }
					}
				}
			}
		}
		// 买卖业务
		else if(biztypeKey.equals("1") || biztypeKey.equals("2") || biztypeKey.equals("3") || biztypeKey.equals("4")){
			for (int i = 0; i < instructList.size(); i++) {
				index_excleTable++;
				DataObject obj = instructList.get(i);
				// 本方
				theSide = StrUtil.changeNull(obj.getString("theSide"));
				productName = StrUtil.changeNull(obj.getString("vcProductName"));
				//交易对手
				tradingOpponent = StrUtil.changeNull(obj.getString("vcCounterpartyName"));
				//对手方交易员
				tradingOpponentName = StrUtil.changeNull(obj.getString("vcCounterpartyTrader")); 
				// 委托方向
				processType = StrUtil.changeNull(obj.getString("vcEntrustDirection"));
				// 债券名称
				vcStockName = StrUtil.changeNull(obj.getString("vcStockName"));
				// 债券代码
				vcStockCode = StrUtil.changeNull(obj.getString("vcStockCode"));
				// 净价
				enNetPrice = StrUtil.changeNull(obj.getString("enNetPrice"));
				// 到期收益率
				enMaturityYield = StrUtil.changeNull(obj.getString("enMaturityYield"));
				// 行权收益率
				enOptionYield = StrUtil.changeNull(obj.getString("enOptionYield"));
				// 卷面金额
				investCount = String.valueOf(Math.round(Double.valueOf(StrUtil.changeNull(obj.getString("enFaceAmount")))));
				// 清算速度
				clearingSpeed = StrUtil.changeNull(obj.getString("vcSettleSpeed"));
				// 托管机构名称
				custodianName = StrUtil.changeNull(obj.getString("vcDepository")); 
				
				// 交易方向
				if(processType.equals("3")){
					processType = "买入";
				}
				if(processType.equals("4")){
					processType = "卖出";
				}
				// 清算速度
				if(clearingSpeed.equals("0")){
					clearingSpeed = "T+0";
				}
				if(clearingSpeed.equals("1")){
					clearingSpeed = "T+1";
				}
				if(clearingSpeed.equals("9")){
					clearingSpeed = "不限";
				}
				// 托管机构，1-中债登，2-上清所
				if(!custodianName.equals("")){
					if(custodianName.equals("1")){
						custodianName = "中债登";
					}
					if(custodianName.equals("2")){
						custodianName = "上清所";
					}
				}
				// 给excel表填入记录
				String[] column = new String[] {theSide,
						tradingOpponent, tradingOpponentName, processType,
						vcStockCode, vcStockName, enNetPrice, enMaturityYield,
						enOptionYield, investCount,
						clearingSpeed, firstSettlement,
						settlementType, effectiveTime, null,
						null, null, null,
						null, null, null,
						null, null, currency, null};
				// 业务类别
				if(biztypeKey.equals("1")){
					bizType = "银行间二级交易";
				}
				if(biztypeKey.equals("2")){
					bizType = "上海大宗交易";
				}
				if(biztypeKey.equals("3")){
					bizType = "上海固收平台";
				}
				if(biztypeKey.equals("4")){
					bizType = "深圳综合协议平台";
				}
				//创建行
				HSSFRow row = excleTable.createRow(index_excleTable);
				//创建列
				for (int j = 0; j < export_length_excleTable; j++) {
					HSSFCell cell = row.createCell((short) j);
					if (column[j] != null || "".equals(column[j])) {
			            //判断data是否为数值型
			            isNum = column[j].toString().matches("^(-?\\d+)(\\.\\d+)?$");
			            //判断data是否为整数（小数部分是否为0）
			            isInteger=column[j].toString().matches("^[-\\+]?[\\d]*$");
			            //判断data是否为百分数（是否包含“%”）
			            isPercent=column[j].toString().contains("%");
			        }

			        //如果单元格内容是数值类型，涉及到金钱（金额、本、利），则设置cell的类型为数值型，设置data的类型为数值类型
			        if ((isNum && !isPercent) && j != 4) {
			            // 设置单元格格式
			            cell.setCellStyle(BoldUnderlineCENTRE);
			            // 设置单元格内容为double类型
			            cell.setCellValue(Double.parseDouble(column[j]));
			        } else {
			        	cell.setCellStyle(BoldUnderlineCENTRE);
			            // 设置单元格内容为字符型
			        	cell.setCellValue(column[j]);
			        }
				}
			}
		}
		
		
		//组装附件名称
		String filename = bizType + "_" + DateUtil.formatDateTimeYYYYMMDDHHMMSSS(new Date()) +".xls";
		
		return filename;
	}
	
}
