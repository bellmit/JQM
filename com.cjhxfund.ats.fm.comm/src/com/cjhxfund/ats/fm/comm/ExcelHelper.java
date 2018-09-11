package com.cjhxfund.ats.fm.comm;



import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.das.entity.criteria.ExprType;
import com.eos.das.entity.criteria.LogicType;
import com.eos.das.entity.criteria.impl.CriteriaTypeImpl;
import com.eos.das.entity.criteria.impl.ExprTypeImpl;
import com.eos.das.entity.criteria.impl.LogicTypeImpl;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.access.http.UploadFile;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;




/**
 * Excel组件
 * 
 * @author 杨敏
 * @version 1.0
 * @since 1.0
 */
@Bizlet("")
public  class ExcelHelper {

	/**
	 * Excel 2003
	 */
	private final static String XLS = "xls";
	/**
	 * Excel 2007
	 */
	private final static String XLSX = "xlsx";
	/**
	 * 分隔符
	 */
	private final static String SEPARATOR = "|";
	
	@Bizlet("执行上传回调")
	public static Object[]  callBackBiz(String UpSuccessBiz,Object[] UpSuccessBizParm,UploadFile Fdata){
		Object[] result = null;
		if(UpSuccessBiz=="" || UpSuccessBiz==null){
			LogUtil.logDebug("单个文件上传，回调逻辑流为空，回调失败！", null, null);
			return result;
		}
		String operationName="";//定义逻辑流请求方法名
		String componentName="";// 逻辑构件名称
		try{
			String[] s=UpSuccessBiz.split("\\.");
			operationName=s[s.length-1];
			for(int i=0;i<s.length-1;i++){
				if(i==0){
					componentName=s[i];
				}else{
					componentName=componentName+"."+s[i];
				}
				
			}
		}catch(Exception e){
			LogUtil.logDebug("单个文件上传，回调逻辑流全称解析异常，回调失败！[{0}]", e, UpSuccessBiz);
			e.printStackTrace();
			return result;
		}
		
		ILogicComponent logicComponent = LogicComponentFactory
				.create(componentName);
		
		// 逻辑流的输入参数，这里的参数组装必须按照 逻辑流的参数顺序组装，
		Object[] params =  new Object[UpSuccessBizParm.length+1];
		params[0]=Fdata;
		for (int i = 0; i < UpSuccessBizParm.length; i++) {
			params[i+1] = UpSuccessBizParm[i];
		}
		
		try {
			//params中按顺序给 逻辑流参数赋值.所以 Fdata参数必须在回调逻辑流的第一位
			result=logicComponent.invoke(operationName, params);
		} catch (Throwable e) {
			LogUtil.logDebug("单个文件上传，回调逻辑流全称解析异常,回调逻辑流执行失败！方法：[{0}]，参数：[{1}]", e, UpSuccessBiz,params);
			e.printStackTrace();
			return result;
		}
		return result;
	}
	
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
		return ExcelHelper.exportListFromExcel (new File(file), 0);
		 
	}
	/**
	 * 调用逻辑构件ScoreManager下面的逻辑流sendEMail
	 *
	 * 需要为逻辑流准备好输入的参数，返回值是一个Object[]
	 *
	 * @return Object[]
	 * @throws Throwable
	 */
	@Bizlet("")
	public Object[] callLogicBusiness(String componentName,String operationName,List<List<Object>> listData) throws Throwable {
		Object[] result = null;
		// 逻辑构件名称
		//String componentName = "com.primeton.samples.base.logicflow.ScoreManager";
		// 逻辑流名称
		//String operationName = "sendEMail";
		ILogicComponent logicComponent = LogicComponentFactory
				.create(componentName);
		int size = 1;
		// 逻辑流的输入参数
		Object[] params = new Object[size];
		params[0] = listData;
		result = logicComponent.invoke(operationName, params);
		// 逻辑流的返回值
		return result;
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
			
			List<Object> l = new ArrayList<Object>();
			if(k==0){
				minColIx = row.getFirstCellNum();
				maxColIx = row.getLastCellNum();
				k++;
			}
			//System.out.println(minColIx+"---->"+maxColIx);
			int cellNum=0;//空单元格数量
			for (short colIx = minColIx; colIx <= maxColIx; colIx++) {
				//System.out.println(colIx+":");
				Cell cell = row.getCell(new Integer(colIx));

				if (cell == null || cell.toString().trim().equals("")) {
					cellNum++;
					l.add(null);
					continue;
				}
				
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);//改变单元格的类型为String
				CellValue cellValue = evaluator.evaluate(cell);
				if (cellValue == null) {
					l.add(null);
					continue;
				}
				
				// 经过公式解析，最后只存在Boolean、Numeric和String三种数据类型，此外就是Error了
				// 其余数据类型，根据官方文档，完全可以忽略http://poi.apache.org/spreadsheet/eval.html
				switch (cellValue.getCellType()) {
				case Cell.CELL_TYPE_BOOLEAN:
					
					l.add(cellValue.getBooleanValue());
					//sb.append(SEPARATOR + cellValue.getBooleanValue());
					break;
				case Cell.CELL_TYPE_NUMERIC:
					l.add(cell.getDateCellValue());
					// 这里的日期类型会被转换为数字类型，需要判别后区分处理
					// 注意这个类的应用 是org.apache.poi.ss.usermodel.DateUtil
					/*if (DateUtil.isCellDateFormatted(cell)) {
						l.add(cell.getDateCellValue());
						//sb.append(SEPARATOR + cell.getDateCellValue());
					} else {
//						int num = Integer.parseInt(cellValue.getNumberValue());
						String str = String.valueOf(cell.getNumericCellValue());
						l.add(str.substring(0, str.lastIndexOf(".")));
						//sb.append(SEPARATOR + cellValue.getNumberValue());
					}*/
					//System.out.println("非string:"+cellValue);
					break;
				case Cell.CELL_TYPE_STRING:
					//System.out.println(cellValue);
					l.add(cellValue.getStringValue());
					//sb.append(SEPARATOR + cellValue.getStringValue());
					break;
				case Cell.CELL_TYPE_FORMULA:
					//System.out.println(cellValue);
					break;
				case Cell.CELL_TYPE_BLANK:
					//System.out.println(cellValue);
					break;
				case Cell.CELL_TYPE_ERROR:
					//System.out.println(cellValue);
					break;
				default:
					//System.out.println(cellValue);
					break;
				}
				
			}
			if(cellNum < maxColIx){
				list.add(l);
			}
			
		}
		return list;
	}
	
	/**
	 * 特殊主承由Excel文件的Sheet导出至List
	 * 
	 * @param file
	 * @param sheetNum
	 * @return
	 */
	public static List<List<Object>> exportListFromExcelUnderwriter(File file, int sheetNum)
			throws IOException {
		return exportListFromExcelUnderwriter(new FileInputStream(file),
				FilenameUtils.getExtension(file.getName()), sheetNum);
	}
	
	/**
	 * 特殊主承由Excel流的Sheet导出至List
	 * 
	 * @param is
	 * @param extensionName
	 * @param sheetNum
	 * @return
	 * @throws IOException
	 */
	public static List<List<Object>> exportListFromExcelUnderwriter(InputStream is,
			String extensionName, int sheetNum) throws IOException {

		Workbook workbook = null;

		if (extensionName.toLowerCase().equals(XLS)) {
			workbook = new HSSFWorkbook(is);
		} else if (extensionName.toLowerCase().equals(XLSX)) {
			workbook = new XSSFWorkbook(is);
		}

		return exportListFromExcelUnderwriter(workbook, sheetNum);
	}
	
	/**
	 * 特殊主承由指定的Sheet导出至List
	 * 
	 * @param workbook
	 * @param sheetNum
	 * @return
	 * @throws IOException
	 */
	private static List<List<Object>> exportListFromExcelUnderwriter(Workbook workbook,
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
			if(row==null){
				continue;
			}
			boolean mybool= sheet.getRow(rowIx).getZeroHeight();//判断Excel是否隐藏行
			if(mybool){
				continue;
			}
			
			List<Object> l = new ArrayList<Object>();
			if(k==0){
				//minColIx = row.getFirstCellNum();
				maxColIx = row.getLastCellNum();
				k++;
			}
			//System.out.println(minColIx+"---->"+maxColIx);
			int cellNum=0;//空单元格数量
			for (short colIx = minColIx; colIx <= maxColIx; colIx++) {
				//System.out.println(colIx+":");
				Cell cell = row.getCell(new Integer(colIx));

				String strMerge=null;
				//判断是否为日期类型
				if(cell!=null){
					if(cell.getCellType()==cell.CELL_TYPE_NUMERIC){
						//用于转化为日期格式
						//System.out.println("date："+cell.getDateCellValue()+"==int:"+cell.getNumericCellValue()+"==判断值："+cell.getCellStyle().getDataFormat());
						SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
						if (HSSFDateUtil.isCellDateFormatted(cell) || cell.getCellStyle().getDataFormat()==58 || cell.getCellStyle().getDataFormat()==31) {
					        Date date = cell.getDateCellValue();
					        strMerge = formater.format(date);
					    } 
					}
				}
				//是否合并单元格
				boolean bool= isMergedRow(sheet,rowIx,colIx);
				if(bool){
					strMerge=getMergedRegionValue(sheet,rowIx,colIx);
					//System.out.println("合并行单元格的值："+str);
				}
				
				if ((cell == null || cell.toString().trim().equals("")) && bool==false) {
					cellNum++;
					l.add(null);
					continue;
				}
				
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);//改变单元格的类型为String
				CellValue cellValue = evaluator.evaluate(cell);
				if (cellValue == null && bool==false) {
					l.add(null);
					continue;
				}
				
				// 经过公式解析，最后只存在Boolean、Numeric和String三种数据类型，此外就是Error了
				// 其余数据类型，根据官方文档，完全可以忽略http://poi.apache.org/spreadsheet/eval.html
				switch (cellValue.getCellType()) {
				case Cell.CELL_TYPE_BOOLEAN:
					
					l.add(cellValue.getBooleanValue());
					break;
				case Cell.CELL_TYPE_NUMERIC:
					l.add(cell.getDateCellValue());
					break;
				case Cell.CELL_TYPE_STRING:
					//System.out.println(cellValue);
					if(strMerge != null){
						l.add(strMerge);
					}else{
						l.add(cellValue.getStringValue());
					}
					//sb.append(SEPARATOR + cellValue.getStringValue());
					break;
				case Cell.CELL_TYPE_FORMULA:
					//System.out.println(cellValue);
					break;
				case Cell.CELL_TYPE_BLANK:
					//System.out.println(cellValue);
					break;
				case Cell.CELL_TYPE_ERROR:
					//System.out.println(cellValue);
					break;
				default:
					//System.out.println(cellValue);
					break;
				}
				
			}
			if(cellNum < maxColIx){
				list.add(l);
			}
			
		}
		//去除重复数据，主要去除重复表头
		Set set  =   new  HashSet();
	    List newList  =   new  ArrayList();
	    int tablehand=0;
	    for(Iterator iter  =  list.iterator(); iter.hasNext();)  {
	         Object element  =  iter.next();
	         if  (set.add(element)){
	        	tablehand++;
	            newList.add(element);
	            //删除所有表头
	            int ind=element.toString().indexOf("原始权益人全称,");
	            int ind1=element.toString().indexOf("发行人/发起机构全称,");
	            int ind2=element.toString().indexOf("小计,");
	            int ind3=element.toString().indexOf("合计,");
	            int ind5=element.toString().indexOf("信用评级,");
	            int ind7=element.toString().indexOf("发行人全称,");
	            int ind8=element.toString().indexOf("债券类型,");
	            int ind9=element.toString().indexOf("债券名称,");
	            int ind10=element.toString().indexOf("发行人,");
	            int ind11=element.toString().indexOf("发行人名称,");
	            int ind12=element.toString().indexOf("东吴证券待发固收产品列表,");
	            int ind13=element.toString().indexOf("债券全称,");
	            int ind14=element.toString().indexOf("债券简称,");
	        	if(ind>0 || ind1>0 || ind2>0 || ind3>0 || ind5>0 || ind7>0 || ind8>0 || ind9>0 || ind10>0 || ind11>0 || ind12>0 || ind13>0 || ind14>0){
	        		newList.remove(element);
	        	}
	        	int ind4=element.toString().indexOf("联系方式,");
	        	int ind6=element.toString().indexOf("券种,");
	        	if(ind4>0 || ind6>0){
	        		newList.remove(element);
	        		continue;
	        	}
	         }
	     } 
	     list.clear();
	     list.addAll(newList);
		return list;
	}
	/*
	 * 判断是否合并行单元格
	 * */
	 private static boolean isMergedRow(Sheet sheet,int row ,int column) {  
	      
	      int sheetMergeCount = sheet.getNumMergedRegions();  
	      for (int i = 0; i < sheetMergeCount; i++) {  
	        CellRangeAddress range = sheet.getMergedRegion(i);  
	        int firstColumn = range.getFirstColumn();  
	        int lastColumn = range.getLastColumn();  
	        int firstRow = range.getFirstRow();  
	        int lastRow = range.getLastRow();  
	        if(row > firstRow && row <= lastRow){   
	            if(column >= firstColumn && column <= lastColumn){  
	                return true;  
	            }  
	        }  
	      }  
	      return false;  
	    }  
	 /*
	  * 获取合并单元格的值
	  * */
	 public static String getMergedRegionValue(Sheet sheet ,int row , int column){      
	        int sheetMergeCount = sheet.getNumMergedRegions();      
	              
	        for(int i = 0 ; i < sheetMergeCount ; i++){      
	            CellRangeAddress ca = sheet.getMergedRegion(i);      
	            int firstColumn = ca.getFirstColumn();      
	            int lastColumn = ca.getLastColumn();      
	            int firstRow = ca.getFirstRow();      
	            int lastRow = ca.getLastRow();      
	                  
	            if(row >= firstRow && row <= lastRow){      
	                if(column >= firstColumn && column <= lastColumn){      
	                    Row fRow = sheet.getRow(firstRow);      
	                    Cell fCell = fRow.getCell(firstColumn);      
	                    return getCellValue(fCell) ;      
	                }      
	            }      
	        }      
	              
	        return null ;      
	    }  
	 
	 /*
	  * 拼接合并行上未合并行单元格的值
	  * */
	 public static Map getMergedRegionValuePJ(Sheet sheet ,int row , int column){      
	        int sheetMergeCount = sheet.getNumMergedRegions();      
	        Map map=new HashMap<String, Object>();
	        for(int i = 0 ; i < sheetMergeCount ; i++){      
	            CellRangeAddress ca = sheet.getMergedRegion(i);      
	            int firstRow = ca.getFirstRow();      
	            int lastRow = ca.getLastRow();      
	            if(row >= firstRow && row <= lastRow){
	            	int k=0;
		            String retString="";
		            for(int j=firstRow;j<=lastRow;j++){     
		                    Row fRow = sheet.getRow(firstRow+k);      
		                    Cell fCell = fRow.getCell(column);
		                    k++;
		                    if(retString != ""){
		                    	retString=retString+";"+getCellValue(fCell);
		                    }else{
		                    	retString=getCellValue(fCell);
		                    }
		            }
		            map.put("retString", retString);
		            map.put("count", k);
		            return map;
	            }
	        }
	        return null ;      
	    }   
	    
	     /* 
	      * 获取单元格的值  
	      * */
	    public static String getCellValue(Cell cell){      
	        if(cell == null) return "";      
	        if(cell.getCellType() == Cell.CELL_TYPE_STRING){      
	            return cell.getStringCellValue();      
	        }else if(cell.getCellType() == Cell.CELL_TYPE_BOOLEAN){      
	            return String.valueOf(cell.getBooleanCellValue());      
	        }else if(cell.getCellType() == Cell.CELL_TYPE_FORMULA){      
	            return cell.getCellFormula() ;      
	        }else if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC){      
	            return String.valueOf(cell.getNumericCellValue());      
	        }  
	        return "";      
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
