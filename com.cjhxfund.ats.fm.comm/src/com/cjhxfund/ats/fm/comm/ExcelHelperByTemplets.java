package com.cjhxfund.ats.fm.comm;



import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.eos.das.entity.criteria.ExprType;
import com.eos.das.entity.criteria.LogicType;
import com.eos.das.entity.criteria.impl.ExprTypeImpl;
import com.eos.das.entity.criteria.impl.LogicTypeImpl;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;




/**
 * Excel组件
 * 
 * @author 杨敏
 * @version 1.0
 * @since 1.0
 */
@Bizlet("")
public  class ExcelHelperByTemplets {

	/**
	 * Excel 2003
	 */
	private final static String XLS = "xls";
	/**
	 * Excel 2007
	 */
	private final static String XLSX = "xlsx";
	
	/**
	 * 由Excel文件的Sheet导出至List
	 * 
	 * @param file
	 * @param sheetNum
	 * @return
	 */
	@Bizlet("获取导入的数据") 
	public static List<List<Object>> getExportListFromExcel(String file, int sheetNum)
			throws IOException {
		return exportListFromExcel (new File(file), 0);
		 
	}


	/**
	 * 由Excel文件的Sheet导出至List
	 * 
	 * @param file
	 * @param sheetNum
	 * @return
	 */
	public static List<List<Object>> exportListFromExcel(File file, int sheetNum)
			throws IOException {
		return exportListFromExcel(new FileInputStream(file),
				FilenameUtils.getExtension(file.getName()), sheetNum);
	}

	/**
	 * 由Excel流的Sheet导出至List
	 * 
	 * @param is
	 * @param extensionName
	 * @param sheetNum
	 * @return
	 * @throws IOException
	 */
	public static List<List<Object>> exportListFromExcel(InputStream is,
			String extensionName, int sheetNum) throws IOException {

		Workbook workbook = null;

		if (extensionName.toLowerCase().equals(XLS)) {
			workbook = new HSSFWorkbook(is);
		} else if (extensionName.toLowerCase().equals(XLSX)) {
			workbook = new XSSFWorkbook(is);
		}

		return exportListFromExcel(workbook, sheetNum);
	}

	/**
	 * 由指定的Sheet导出至List
	 * 
	 * @param workbook
	 * @param sheetNum
	 * @return
	 * @throws IOException
	 */
	private static List<List<Object>> exportListFromExcel(Workbook workbook,
			int sheetNum) {

		Sheet sheet = workbook.getSheetAt(sheetNum);

		// 解析公式结果
		FormulaEvaluator evaluator = workbook.getCreationHelper()
				.createFormulaEvaluator();

		List<List<Object>> list = new ArrayList<List<Object>>();

		int minRowIx = sheet.getFirstRowNum();
		int maxRowIx = sheet.getLastRowNum();
		//System.out.println(minRowIx+"---->"+maxRowIx);
		short minColIx = 0;
		short maxColIx = 0;
		int k=0;
		for (int rowIx = minRowIx; rowIx <= maxRowIx; rowIx++) {
			Row row = sheet.getRow(rowIx);
			
			if(null == row){
				continue;
			}
			
			List<Object> l = new ArrayList<Object>();
			if(k==0){
				minColIx = row.getFirstCellNum();
				maxColIx = row.getLastCellNum();
				k++;
			}
			//System.out.println(minColIx+"---->"+maxColIx);
			int cellNum=0;//空单元格数量
			for (short colIx = minColIx; colIx <= maxColIx; colIx++) {
				
				Cell cell = row.getCell(new Integer(colIx));
				
				if (cell == null || cell.toString().trim().equals("") || cell.getCellType() == HSSFCell.CELL_TYPE_ERROR) {
					cellNum++;
					l.add(null);
					continue;
				}
				
				if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){
					if(HSSFDateUtil.isCellDateFormatted(cell)){
						//日期型解析
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date dt = HSSFDateUtil.getJavaDate(cell.getNumericCellValue());// 获取成DATE类型
						l.add(sdf.format(dt));
					}else{
						//数值型
						l.add(double2Str(cell.getNumericCellValue()));
					}
				}else if(cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA){
					//公式解析
					CellValue cellValue = evaluator.evaluate(cell);
					if(cellValue == null){
						cellNum++;
						l.add(null);
						continue;
					}
					l.add(cellValue.toString().trim());
				}else{
					l.add(cell.toString().trim());
				}
			}
			if(cellNum < maxColIx){
				list.add(l);
			}
			
		}
		return list;
	}
	
	public static String double2Str(Double d) {
        if (d == null) {
            return "";
        }
        NumberFormat nf = NumberFormat.getInstance();
        nf.setGroupingUsed(false);
        return (nf.format(d));
    }
	
	    /** 
	     * 	excelList：Excel数据
	     * 	templets：模板配置
	     */
	    @Bizlet("根据模板，获得导入的Excel数据")
	    public static Map<String, List<DataObject>> getExcelDataBytemplet(List<List<Object>> excelList, DataObject[] templets){
	    	Map<String, List<DataObject>> dataMap = new HashMap<String, List<DataObject>>();//返回值
	    	List<DataObject> insertList = new ArrayList<DataObject>();	//正常数据
	    	List<DataObject> errorList = new ArrayList<DataObject>();	//异常数据
	    	Map<String, String> repeatMap =  new HashMap<String, String>();//用于判断重复的
	    	List<DataObject> andList = new ArrayList<DataObject>();	//数据库查重条件
	    	
	    	Map<String, Map<String, String>> dictsMap = getDictMapByTemplets(templets);
	    	
	    	for(int i=1; i<excelList.size(); i++){	//从EXCEL的第二行开始取数
		    	DataObject obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
	    		obj.setInt("rowNo", i+1);	//当前行数
		    	Boolean error = false;	//判断行数据是否异常
		    	StringBuffer errorMsg = new StringBuffer();	//异常信息
		    	StringBuffer repertFieldValues = new StringBuffer();	//判断重复字段值
		    	List<Object> dataList = (List<Object>)excelList.get(i);	//Excel行数据
		    	
		    	for(int j=0; j<templets.length; j++){
	    			String vcFieldCode = templets[j].getString("vcFieldCode");	//字段code
	    			String vcFieldName = templets[j].getString("vcFieldName");	//字段name
	    			int lColumnIndex = templets[j].getInt("lColumnIndex");	//列索引
	    			String cAllowNull = templets[j].getString("cAllowNull");	//是否允许为空
	    			String vcDicttypeid = templets[j].getString("vcDicttypeid");	//字典
	    			String vcRegex = templets[j].getString("vcRegex");	//格式（正则表达式）
	    			String cFieldRepeat = templets[j].getString("cFieldRepeat");	//去重
	    			String value = dataList.get(lColumnIndex) == null ? null : dataList.get(lColumnIndex).toString();
		    		if(lColumnIndex<dataList.size()){
		    			if("0".equals(cAllowNull) && StringUtils.isBlank(value)){
		    				error = true;
			    			errorMsg.append(vcFieldName+"不能为空！");
			    			continue;
		    			}else{
		    				if(StringUtils.isBlank(value)){
	    						continue;	//允许为空值
	    					}
		    				if(!StringUtils.isBlank(vcDicttypeid)){
		    					//转换为业务字典值
		    					value = dictsMap.get(vcDicttypeid).get(value);
		    					if(StringUtils.isBlank(value)){
		    						error = true;
					    			errorMsg.append(vcFieldName+"未找到对应字典值！");
					    			continue;
		    					}
		    				}else{
		    					//校验格式
		    					if(!StringUtils.isBlank(vcRegex) && !Pattern.matches(vcRegex, dataList.get(lColumnIndex).toString())){
		    						error = true;
					    			errorMsg.append(vcFieldName+"不符合格式要求！");
					    			continue;
		    					}
		    				}
		    			}
		    		}else if("0".equals(cAllowNull)){
		    			error = true;
		    			errorMsg.append(vcFieldName+"不能为空！");
		    			continue;
		    		}
		    		
		    		if("1".equals(cFieldRepeat)){	//去重字段值（多个拼接）
		    			repertFieldValues.append("【" + vcFieldName + "：" + value + "】");
		    		}
    				//设置对象值
					obj.set(vcFieldCode, value);
				}

		    	//LogUtil.logInfo(repertFieldValues.toString(), null, null);
		    	if(error){
		    		obj.setString("errorMsg", errorMsg.toString());
		    		errorList.add(obj);
		    	}else if(!StringUtils.isBlank(repertFieldValues.toString())){	//存在去重字段
		    		if(StringUtils.isBlank(repeatMap.get(repertFieldValues.toString()))){
		    			repeatMap.put(repertFieldValues.toString(), obj.getString("rowNo"));
		    			insertList.add(obj);
		    			LogicType and = getLogicTypeByDataObject(obj, templets);
		    			andList.add(and);
		    		}else{
		    			obj.setString("errorMsg", "与行号"+repeatMap.get(repertFieldValues.toString())+"的数据重复");
		    			obj.setString("repertFieldValues", repertFieldValues.toString());
			    		errorList.add(obj);
		    		}
		    	}else{
		    		insertList.add(obj);
		    	}
	    	}
	    	dataMap.put("insertList", insertList);
	    	dataMap.put("errorList", errorList);
	    	if(andList.size()>0){
		    	dataMap.put("andList", andList);
	    	}
	    	return dataMap;
	    }
	    
	    //加载需要用到的业务字典
	    public static Map<String, Map<String, String>> getDictMapByTemplets(DataObject[] templets){
	    	Map<String, Map<String, String>> dictsMap = new HashMap<String, Map<String, String>>();
	    	for(int i=0; i<templets.length; i++){
	    		if(!StringUtils.isBlank(templets[i].getString("vcDicttypeid")) && dictsMap.get(templets[i].getString("vcDicttypeid"))==null){
	    			DataObject[] objs = BusinessDictUtil.getCurrentDictInfoByType(templets[i].getString("vcDicttypeid"));
	    			if(objs!=null){
	    		    	Map<String, String> dictMap = new HashMap<String, String>();
	    				for(int j=0; j<objs.length; j++){
	    					dictMap.put(objs[j].getString("dictName"), objs[j].getString("dictID"));
	    				}
	    				dictsMap.put(templets[i].getString("vcDicttypeid"), dictMap);
	    			}
	    		}
	    	}
	    	return dictsMap;
	    }
	    
	    //获得去重数据库查询条件
	    public static LogicType getLogicTypeByDataObject(DataObject obj, DataObject[] templets){
	    	List<ExprType> exprList = new ArrayList<ExprType>();
	    	for(DataObject templet : templets) {
	    		if("1".equals(templet.getString("cFieldRepeat"))){
		    		ExprType expr = new ExprTypeImpl();
		    		expr.set_property(templet.getString("vcFieldCode"));
		    		if(StringUtils.isBlank(obj.getString(templet.getString("vcFieldCode")))){
		    			expr.set_op("null");
		    		}else{
			    		expr.set_value(obj.getString(templet.getString("vcFieldCode")));
		    		}
		    		exprList.add(expr);
	    		}
			}
	    	LogicType and = new LogicTypeImpl();
	    	and.set_expr(exprList);
	    	return and;
	    }
	    
	    
}
