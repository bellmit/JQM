package com.cjhxfund.ats.fm.comm;

import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.RichTextString;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 普元Coframe补充功能
 * @author huangmizhi
 * @date 2015-10-16 11:14:33
 */
@Bizlet("")
public class CoframeSupplement {
	
	
	/**
	 * 获取机构员工表的所有userId
	 * @param conn 若未传入数据库连接，则获取默认连接
	 * @return
	 */
	@Bizlet("")
	public static Map<String,String> getOrgEmpUserIds(Connection conn){
		boolean needClose = true;
		Map<String,String> result = new HashMap<String,String>();
		try {
			if(conn==null || conn.isClosed()){
				//若未传入数据库连接，则获取默认连接
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			}else{
				needClose = false;
			}
			
			//获取主键ID、用户ID
			String sql = "select t.empid,t.userid from org_employee t";
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sql, null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String empid = map.get("EMPID");
					String userid = map.get("USERID");
					
					if(StringUtils.isNotEmpty(empid) && StringUtils.isNotEmpty(userid)){
						result.put(empid, userid);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(needClose){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
		return result;
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
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void createExcelSheet(HSSFWorkbook workbook, String sheetName, String[] sheetHeadTitle, String[] columnKeyArr, Object[] changeObjArr, List<DataObject> exportData, HSSFCellStyle sheetHeadFormat, HSSFCellStyle BoldUnderlineCENTRE, HSSFCellStyle BoldUnderlineLEFT){
		//将DataObject对象数据转换为字符串数组
		List<String[]> changeData = changeArr(exportData, columnKeyArr, changeObjArr);
		createExcelSheet(changeData, workbook, sheetName, sheetHeadTitle, sheetHeadFormat, BoldUnderlineCENTRE, BoldUnderlineLEFT);
	}
	
	/**
	 * 将业务数据导出Excel文件
	 * @param exportData 需导出的数据
	 * @param workbook Excel工作薄
	 * @param sheetName Sheet名称
	 * @param sheetHeadTitle Sheet列标题数组
	 * @param sheetHeadFormat Sheet列标题样式
	 * @param BoldUnderlineCENTRE 居中对齐样式
	 * @param BoldUnderlineLEFT 左对齐样式
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void createExcelSheet(List<String[]> exportData, HSSFWorkbook workbook, String sheetName, String[] sheetHeadTitle, HSSFCellStyle sheetHeadFormat, HSSFCellStyle BoldUnderlineCENTRE, HSSFCellStyle BoldUnderlineLEFT){
		//创建Sheet
		HSSFSheet sheet = workbook.createSheet(sheetName);
		//创建第一行（标题行）
		HSSFRow row0 = sheet.createRow(0);
		//创建第一列（标题列）
		for(int i=0; i<sheetHeadTitle.length; i++){
			HSSFCell cell = row0.createCell((short)i);
			cell.setCellValue((RichTextString)new HSSFRichTextString(sheetHeadTitle[i]));
			cell.setCellStyle(sheetHeadFormat);
			if(i==0){//序号
				sheet.setColumnWidth((short)i, (short)2000);//设置列宽
			}else{
				sheet.setColumnWidth((short)i, (short)5000);//设置列宽
			}
		}
		//导出数据
		for(int i=0; i<exportData.size(); i++){
			String[] strArr = exportData.get(i);
			//创建数据行
			HSSFRow row = sheet.createRow(i+1);
			//创建数据列
			for(int j=0; j<sheetHeadTitle.length; j++){
				HSSFCell cell = row.createCell((short)j);
				if(j==0){//序号
					cell.setCellStyle(BoldUnderlineCENTRE);
					cell.setCellValue((RichTextString)new HSSFRichTextString(String.valueOf(i+1)));
				}else{
					cell.setCellStyle(BoldUnderlineLEFT);
					cell.setCellValue((RichTextString)new HSSFRichTextString(strArr[j-1]));
				}
			}
		}
	}
	
	/**
	 * 将DataObject对象数据转换为字符串数组
	 * @param changeData 待转换的DataObject数据
	 * @param columnKeyArr 获取字段值关键key数组
	 * @param changeObjArr 值转换格式对象数组
	 * @return
	 * @author huangmizhi
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

	public static void main(String[] args) {
	}
}
