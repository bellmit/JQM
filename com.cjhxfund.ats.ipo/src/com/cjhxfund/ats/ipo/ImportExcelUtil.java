package com.cjhxfund.ats.ipo;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;

public class ImportExcelUtil {
	
	//针对Excel2003文件，即.xls文件操作类
	private HSSFWorkbook hssfWork=null;
	private HSSFSheet hssfSheet=null;
	
	//针对Excel版本2007,2010，即.xlsx文件操作类
	private XSSFWorkbook xxfWork=null;
	private XSSFSheet xxfSheet=null;
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
	public XSSFWorkbook getXxfWork() {
		return xxfWork;
	}
	public void setXxfWork(XSSFWorkbook xxfWork) {
		this.xxfWork = xxfWork;
	}
	public XSSFSheet getXxfSheet() {
		return xxfSheet;
	}
	public void setXxfSheet(XSSFSheet xxfSheet) {
		this.xxfSheet = xxfSheet;
	}
	
	
	//根据模板文件加载Excel操作类
	private void loadExcelFile(String path) {
		try {
			if(path.endsWith(".xlsx")){
				loadExcelFile2007(path);
				loadExcelSheet2007();
	        }else if(path.endsWith(".xls")){
	        	loadExcelFile2003(path);
	        	loadExcelSheet2003();
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//针对Excel2003,即.xls 文件创建workbook操作类
	private void loadExcelFile2003(String path)throws Exception{
		setHssfWork(new HSSFWorkbook(getFileInputStream(path)));
	}
	//针对Excel2007,2010,即.xlsx 文件创建workbook操作类
	private void loadExcelFile2007(String path)throws Exception{
		setXxfWork(new XSSFWorkbook(getFileInputStream(path)));
	}
	
	//获取Excel2003,对应的sheet
	private void loadExcelSheet2003(){
		setHssfSheet(getHssfWork().getSheetAt(0));
	}
	//获取Excel2007,2010,对应的sheet
	private void loadExcelSheet2007(){
		setXxfSheet(getXxfWork().getSheetAt(0));
	}
	
	//获取文件输入流
	private FileInputStream getFileInputStream(String tempFilePath) throws FileNotFoundException {
	    return new FileInputStream(tempFilePath);
	}
	
	
	/**
	 * 导入本地的Excel文件
	 * @param path
	 * @return
	 */
	public DataObject[] importFile(String path,String vcExchangeNo){
		//加载Excel文件
		loadExcelFile(path);
		//String sheetName=null;
		//String[] sheetNames=null;
		DataObject[] importExcelData=null;
		//加载Excel文件中的sheet
		//if(getXxfSheet()!=null){
		//	sheetName=getXxfSheet().getSheetName();
		//}else if(getHssfSheet()!=null){
			//sheetName=getHssfSheet().getSheetName();
		//}
		if(vcExchangeNo!=null && !"".equals(vcExchangeNo)){
			if("SZ".equals(vcExchangeNo)){
				if(getXxfSheet()!=null){
					importExcelData=getExcelDataForSZ2007();
				}else if(getHssfSheet()!=null){
					importExcelData=getExcelDataForSZ2003();
				}
			}else if("SH".equals(vcExchangeNo)){
				if(getXxfSheet()!=null){
					importExcelData=getExcelDataForSH2007();
				}else if(getHssfSheet()!=null){
					importExcelData=getExcelDataForSH2003();
				}
			}
		}
		
		//if(sheetName!=null && !"".equals(sheetName)){
			//sheetNames=sheetName.split("-");
			//if(sheetNames!=null && sheetNames.length>1){
			//	if(getXxfSheet()!=null){
			//		importExcelData=getExcelDataForSZ2007();
			//	}else if(getHssfSheet()!=null){
			//		importExcelData=getExcelDataForSZ2003();
			//	}
			//}else{
				
			//}
		//}
		return importExcelData;
	}
	
	
	public DataObject[] getExcelDataForSH2003(){
		List<Short> cellList=new ArrayList<Short>();
		DataObject[] excelData=null;
		List<DataObject> excelList=new ArrayList<DataObject>();
		Map<String,String> excelKey=new HashMap<String,String>();
		if(getHssfSheet()!=null){
			HSSFRow firstRow=getHssfSheet().getRow(0);
			if(firstRow!=null){
				int cells = firstRow.getPhysicalNumberOfCells();
				for(short c=0;c<cells;c++){
					HSSFCell firstCell=firstRow.getCell(c);
					if(firstCell!=null){
						String value = null;
						if (firstCell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
							value = "" + firstCell.getNumericCellValue();
						} else if (firstCell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {
							value = "" + firstCell.getBooleanCellValue();
						} else {
							value = firstCell.getRichStringCellValue().getString();
						}
						if (value != null && !"".equals(value)) {
							value = value.trim();
							if("证券代码".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcPurchaseCode");
							}else if(value.contains("配售对象代码")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcStockAccountSh");
							}else if("配售对象名称".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationProductName");
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
			
			int rows = getHssfSheet().getPhysicalNumberOfRows();
			for (int r = 1; r < rows; r++) {
				HSSFRow row= getHssfSheet().getRow(r);
				DataObject datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				if (row != null) {
					for(int c=0;c<cellShort.length;c++){
						HSSFCell cell = row.getCell(cellShort[c]);
						if (cell != null) {
							String value = null;
							if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
								value = "" + cell.getNumericCellValue();
							} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {
								value = "" + cell.getBooleanCellValue();
							} else {
								value = cell.getRichStringCellValue().getString();
							}
							if (value != null && !"".equals(value)) {
								value = value.trim();
								String key=excelKey.get(String.valueOf(cellShort[c]));
								if(key!=null && !"".equals(key)){
									datas.set(key, value);
								}
							}
						}
					}
					excelList.add(datas);
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
	 * 上交所Excel指令表数据
	 * @return
	 */
	public DataObject[] getExcelDataForSH2007(){
		List<Short> cellList=new ArrayList<Short>();
		DataObject[] excelData=null;
		List<DataObject> excelList=new ArrayList<DataObject>();
		Map<String,String> excelKey=new HashMap<String,String>();
		if(getXxfSheet()!=null){
			XSSFRow firstRow=getXxfSheet().getRow(0);
			if(firstRow!=null){
				int cells = firstRow.getPhysicalNumberOfCells();
				for(short c=0;c<cells;c++){
					XSSFCell firstCell=firstRow.getCell(c);
					if(firstCell!=null){
						String value = null;
						if (firstCell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
							value = "" + firstCell.getNumericCellValue();
						} else if (firstCell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN) {
							value = "" + firstCell.getBooleanCellValue();
						} else {
							value = firstCell.getRichStringCellValue().getString();
						}
						if (value != null && !"".equals(value)) {
							value = value.trim();
							if("证券代码".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcPurchaseCode");
							}else if(value.contains("配售对象代码")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcStockAccountSh");
							}else if("配售对象名称".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationProductName");
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
			
			int rows = getXxfSheet().getPhysicalNumberOfRows();
			for (int r = 1; r < rows; r++) {
				DataObject datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				XSSFRow row= getXxfSheet().getRow(r);
				if (row != null) {
					for(int c=0;c<cellShort.length;c++){
						XSSFCell cell = row.getCell(cellShort[c]);
						if (cell != null) {
							String value = null;
							if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
								value = "" + cell.getNumericCellValue();
							} else if (cell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN) {
								value = "" + cell.getBooleanCellValue();
							} else {
								value = cell.getRichStringCellValue().getString();
							}
							if (value != null && !"".equals(value)) {
								value = value.trim();
								String key=excelKey.get(String.valueOf(cellShort[c]));
								if(key!=null && !"".equals(key)){
									datas.set(key, value);
								}
							}
						}
					}
					excelList.add(datas);
				}
			}
		}
		
		excelData=new DataObject[excelList.size()];
		for(int i=0;i<excelData.length;i++){
			excelData[i]=excelList.get(i);
		}
		return excelData;
	}
	


	public DataObject[] getExcelDataForSZ2003(){
		List<Short> cellList=new ArrayList<Short>();
		DataObject[] excelData=null;
		List<DataObject> excelList=new ArrayList<DataObject>();
		Map<String,String> excelKey=new HashMap<String,String>();
		if(getHssfSheet()!=null){
			HSSFRow firstRow=getHssfSheet().getRow(0);
			if(firstRow!=null){
				int cells = firstRow.getPhysicalNumberOfCells();
				for(short c=0;c<cells;c++){
					HSSFCell firstCell=firstRow.getCell(c);
					if(firstCell!=null){
						String value = null;
						if (firstCell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
							value = "" + firstCell.getNumericCellValue();
						} else if (firstCell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {
							value = "" + firstCell.getBooleanCellValue();
						} else {
							value = firstCell.getRichStringCellValue().getString();
						}
						////序号	券代码证	配售对象编码	 配售对象名称	证券账号	托管席位号	自愿锁定期（月）	申报价格（元）	拟申购数量（万股）	       备注   
						if (value != null && !"".equals(value)) {
							value = value.trim();
							if(value.contains("配售对象编码")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationProductCode");
							}else if("配售对象名称".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationProductName");
							}else if("托管席位".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "seatSz");
							}else if(value.contains("申报价格")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchasePrice");
							}else if(value.contains("证券账户")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcStockAccountSz");
							}else if(value.contains("申购数量")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchaseNumber");
							}else if(value.contains("锁定期")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "lLockTime");
							}else if("证券代码".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcPurchaseCode");
							}
						}
					}
				}
			}
			
			short[] cellShort=new short[cellList.size()];
			for(int i=0;i<cellList.size();i++){
				cellShort[i]=cellList.get(i).shortValue();
			}
			
			int rows = getHssfSheet().getPhysicalNumberOfRows();
			for (int r = 1; r < rows; r++) {
				HSSFRow row= getHssfSheet().getRow(r);
				DataObject datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				if (row != null) {
					for(int c=0;c<cellShort.length;c++){
						HSSFCell cell = row.getCell(cellShort[c]);
						if (cell != null) {
							String value = null;
							if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
								value = "" + cell.getNumericCellValue();
							} else if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {
								value = "" + cell.getBooleanCellValue();
							} else {
								value = cell.getRichStringCellValue().getString();
							}
							if (value != null && !"".equals(value)) {
								value = value.trim();
								
								String key=excelKey.get(String.valueOf(cellShort[c]));
								if(key!=null && !"".equals(key)){
									datas.set(key, value);
								}
							}
						}
					}
					excelList.add(datas);
				}
			}
		}
		
		excelData=new DataObject[excelList.size()];
		for(int i=0;i<excelData.length;i++){
			excelData[i]=excelList.get(i);
		}
		return excelData;
	}
	
	
	public DataObject[] getExcelDataForSZ2007(){
		List<Short> cellList=new ArrayList<Short>();
		DataObject[] excelData=null;
		List<DataObject> excelList=new ArrayList<DataObject>();
		Map<String,String> excelKey=new HashMap<String,String>();
		if(getXxfSheet()!=null){
			XSSFRow firstRow=getXxfSheet().getRow(0);
			if(firstRow!=null){
				int cells = firstRow.getPhysicalNumberOfCells();
				for(short c=0;c<cells;c++){
					XSSFCell firstCell=firstRow.getCell(c);
					if(firstCell!=null){
						String value = null;
						if (firstCell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
							value = "" + firstCell.getNumericCellValue();
						} else if (firstCell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN) {
							value = "" + firstCell.getBooleanCellValue();
						} else {
							value = firstCell.getRichStringCellValue().getString();
						}
						//序号	证券代码	配售对象编码	 配售对象名称	证券账号	托管席位号	自愿锁定期（月）	申报价格（元）	拟申购数量（万股）	       备注    2017/11/16更新
						if (value != null && !"".equals(value)) {
							value = value.trim();
							if(value.contains("配售对象编码")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationProductCode");
							}else if("配售对象名称".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcRationProductName");
							}else if("托管席位号".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "seatSz");
							}else if(value.contains("申报价格")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchasePrice");
							}else if(value.contains("证券账户") || value.contains("证券账号")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcStockAccountSz");
							}else if(value.contains("申购数量")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "enPurchaseNumber");
							}else if(value.contains("锁定期")){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "lLockTime");
							}else if("证券代码".equals(value)){
								cellList.add(c);
								excelKey.put(String.valueOf(c), "vcPurchaseCode");
							}
						}
					}
				}
			}
			
			short[] cellShort=new short[cellList.size()];
			for(int i=0;i<cellList.size();i++){
				cellShort[i]=cellList.get(i).shortValue();
			}
			
			int rows = getXxfSheet().getPhysicalNumberOfRows();
			for (int r = 1; r < rows; r++) {
				XSSFRow row= getXxfSheet().getRow(r);
				DataObject datas=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
				if (row != null) {
					for(int c=0;c<cellShort.length;c++){
						XSSFCell cell = row.getCell(cellShort[c]);
						if (cell != null) {
							String value = null;
							if (cell.getCellType() == XSSFCell.CELL_TYPE_NUMERIC) {
								value = "" + cell.getNumericCellValue();
							} else if (cell.getCellType() == XSSFCell.CELL_TYPE_BOOLEAN) {
								value = "" + cell.getBooleanCellValue();
							} else {
								value = cell.getRichStringCellValue().getString();
							}
							if (value != null && !"".equals(value)) {
								value = value.trim();
								String key=excelKey.get(String.valueOf(cellShort[c]));
								if(key!=null && !"".equals(key)){
									datas.set(key, value);
								}
							}
						}
					}
					excelList.add(datas);
				}
			}
		}
		
		excelData=new DataObject[excelList.size()];
		for(int i=0;i<excelData.length;i++){
			excelData[i]=excelList.get(i);
		}
		return excelData;
	}

}
