package com.cjhxfund.ats.ipo;


import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;

/**
 * 导入Excel数据与指令单中的数据对比
 * @author houzhiyong
 *
 */
public class ImportExcel {
	
	//模板工作薄对象
	private Workbook wb = null;
	//针对Excel2003
	private HSSFWorkbook hssfWork=null;
	
	//模板工作表sheet对象
	private Sheet sheet=null;
	
	//针对Excel2003
	private HSSFSheet hssfSheet=null;
	
	/**
	 * 导入本地的Excel文件
	 * @param path
	 * @return
	 */
	public DataObject[] importFile(String path){
		//加载Excel文件
		loadExcelFile(path);
		//加载Excel文件中的sheet
		loadExcelSheet();
		String sheetName=getSheet().getSheetName();
		String[] sheetNames=null;
		DataObject[] importExcelData=null;
		if(sheetName!=null && !"".equals(sheetName)){
			sheetNames=sheetName.split("-");
			if(sheetNames!=null && sheetNames.length>1){
				importExcelData=getExcelDataForSZ();
			}else{
				importExcelData=getExcelDataForSH();
			}
		}
		return importExcelData;
	}
	
	/**
	 * 获取沪市导入的数据
	 * @return
	 */
	public DataObject[] getExcelDataForSH(){
		List<Short> cellList=new ArrayList<Short>();
		DataObject[] excelData=null;
		List<DataObject> excelList=new ArrayList<DataObject>();
		Map<String,String> excelKey=new HashMap<String,String>();
		if(getSheet()!=null){
			Row firstRow=sheet.getRow(0);
			if(firstRow!=null){
				int cells = firstRow.getPhysicalNumberOfCells();
				for(short c=0;c<cells;c++){
					Cell cell = firstRow.getCell(c);
					if (cell != null) {
						String value = null;
						if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							value = "" + cell.getNumericCellValue();
						} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
							value = "" + cell.getBooleanCellValue();
						} else {
							value = cell.getRichStringCellValue().getString();
						}
						if (value != null && !"".equals(value)) {
							value = value.trim();
							if("证券代码".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcStockCode");
							}else if(value.contains("配售对象代码")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationObjectCode");
							}else if("配售对象名称".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationObjectName");
							}else if(value.contains("申购价格")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchasePrice");
							}else if(value.contains("申购数量")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchaseNumber");
							}else if(value.contains("锁定期")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "lLockTime");
							}
						}
					}
				}
			}
			short[] cellShort=new short[cellList.size()];
			for(int i=0;i<cellList.size();i++){
				cellShort[i]=cellList.get(i).shortValue();
			}
			
			int rows = sheet.getPhysicalNumberOfRows();
			for (int r = 1; r < rows; r++) {
				Row row = sheet.getRow(r);
				if (row != null) {
					//int cells = row.getPhysicalNumberOfCells();
					//for (short c = 0; c < cells; c++) {
					for(int c=0;c<cellShort.length;c++){
						Cell cell = row.getCell(cellShort[c]);
						if (cell != null) {
							String value = null;
							if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
								value = "" + cell.getNumericCellValue();
							} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
								value = "" + cell.getBooleanCellValue();
							} else {
								value = cell.getRichStringCellValue().getString();
							}
							if (value != null && !"".equals(value)) {
								value = value.trim();
								DataObject datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
								String key=excelKey.get(String.valueOf(cellShort[c]));
								if(key!=null && !"".equals(key)){
									datas.set(key, value);
									excelList.add(datas);
								}
							}
						}
					}
				}
			}
		}
		
		excelData=new DataObject[excelList.size()];
		for(int i=0;i<excelData.length;i++){
			excelData[i]=excelList.get(i);
		}
		return excelData;
	}
	
	/**
	 * 获取深市导入的数据
	 * @return
	 */
	public DataObject[] getExcelDataForSZ(){
		List<Short> cellList=new ArrayList<Short>();
		DataObject[] excelData=null;
		List<DataObject> excelList=new ArrayList<DataObject>();
		Map<String,String> excelKey=new HashMap<String,String>();
		if(getSheet()!=null){
			Row firstRow=sheet.getRow(0);
			if(firstRow!=null){
				int cells = firstRow.getPhysicalNumberOfCells();
				for(short c=0;c<cells;c++){
					Cell cell = firstRow.getCell(c);
					if (cell != null) {
						String value = null;
						if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							value = "" + cell.getNumericCellValue();
						} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
							value = "" + cell.getBooleanCellValue();
						} else {
							value = cell.getRichStringCellValue().getString();
						}
						if (value != null && !"".equals(value)) {
							value = value.trim();
							if(value.contains("配售对象编码")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationObjectCode");
							}else if("配售对象名称".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationObjectName");
							}else if("托管席位".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcSeatNo");
							}else if(value.contains("申购价格")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchasePrice");
							}else if(value.contains("证券账户")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcAccountNo");
							}else if(value.contains("申购数量")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchaseNumber");
							}else if(value.contains("锁定期")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "lLockTime");
							}
						}
					}
				}
			}
			short[] cellShort=new short[cellList.size()];
			for(int i=0;i<cellList.size();i++){
				cellShort[i]=cellList.get(i).shortValue();
			}
			
			int rows = sheet.getPhysicalNumberOfRows();
			for (int r = 1; r < rows; r++) {
				Row row = sheet.getRow(r);
				if (row != null) {
					//int cells = row.getPhysicalNumberOfCells();
					//for (short c = 0; c < cells; c++) {
					for(int c=0;c<cellShort.length;c++){
						Cell cell = row.getCell(cellShort[c]);
						if (cell != null) {
							String value = null;
							if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
								value = "" + cell.getNumericCellValue();
							} else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
								value = "" + cell.getBooleanCellValue();
							} else {
								value = cell.getRichStringCellValue().getString();
							}
							if (value != null && !"".equals(value)) {
								value = value.trim();
								DataObject datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
								String key=excelKey.get(String.valueOf(cellShort[c]));
								if(key!=null && !"".equals(key)){
									datas.set(key, value);
									excelList.add(datas);
								}
							}
						}
					}
				}
			}
		}
		
		excelData=new DataObject[excelList.size()];
		for(int i=0;i<excelData.length;i++){
			excelData[i]=excelList.get(i);
		}
		return excelData;
	}

	
	//根据模板文件名构造函数
	private void loadExcelFile(String path) {
		try {
			if(path.endsWith(".xlsx")){
				setWb(new XSSFWorkbook(getFileInputStream(path)));
	        }else if(path.endsWith(".xls")){
	        	setHssfWork(new HSSFWorkbook(getFileInputStream(path)));
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void loadExcelSheet(){
		if(getWb()!=null){
			setSheet(getWb().getSheetAt(0));
		}else{
			setHssfSheet(getHssfWork().getSheetAt(0));
		}
	}
	//获取文件输入流
	private FileInputStream getFileInputStream(String tempFilePath) throws FileNotFoundException {
	    return new FileInputStream(tempFilePath);
	}

	public Workbook getWb() {
		return wb;
	}


	public void setWb(Workbook wb) {
		this.wb = wb;
	}


	public Sheet getSheet() {
		return sheet;
	}


	public void setSheet(Sheet sheet) {
		this.sheet = sheet;
	}

	public HSSFWorkbook getHssfWork() {
		return hssfWork;
	}

	public void setHssfWork(HSSFWorkbook hssfWork) {
		this.hssfWork = hssfWork;
	}

	public HSSFSheet getHssfSheet() {
		return hssfSheet;
	}

	public void setHssfSheet(HSSFSheet hssfSheet) {
		this.hssfSheet = hssfSheet;
	}
	
	
}
