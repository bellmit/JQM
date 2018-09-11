package com.cjhxfund.ats.ipo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;

/**
 * 指令模板对象
 * @author houzhiyong
 *
 */
public class InstructTemplate {
	//模板文件名
	private String templateFile;
	
	//模板定义的标题数组（标题变量名数组）
	private String[] titleNames;
	
	//指令字段值数组
	private String[] filedNames;
	
	//指令产品数组
	private String[] productNames;
	
	//输出的起始行,默认为-1,不输出
	private int startRow = -1;
	
	//默认字体大小
	private int fontSize = 10;
	
	//默认字体类型
	private String fontName = "宋体";
	
	//是否设置信息标题栏边框,默认情况设置边框
	private boolean titleCellBold = true;
	
	// 是否设置空白栏边框，默认情况不设置边框
	private boolean blankCellBold = false;
	
	//边框样式操作Cell
	private CellStyle borderStyle = null;
	
	//空白样式操作Cell
	private CellStyle noneStyle=null;
	
	//& 表示指令模版信息标题填充字段
	private final String TITLE_FLAG = "&";
	//# 表示指令模版中指令填充字段
	private final String CONTENT_FLAG = "#";
	//$ 表示指令模板中申购产品填充字段
	private final String PRODUCT_FLAG = "$";
	
	// 默认行号
	private int autoRowId = 1;
	
	//模板工作薄对象
	private Workbook wb = null;
	
	//模板工作表sheet对象
	private Sheet sheet=null;
	
	//默认构造函数
	public InstructTemplate() {
	}
	
	/**
	 * 初始化工作模版，获取模版配置起始行(start)以及对应字段填充位置(fieldNames) 调用此方法前需要设置fs 和 sheet 如果
	 * sheet为空则取 设置sheet=wb.getSheetAt(0)
	 * 
	 * @param sheet
	 */
	public boolean initialize() {
		if (sheet == null) {
			setSheet(wb.getSheetAt(0));
		}
		return initialize(sheet);

	}
	
	//初始化工作模版，获取模版配置起始行(start)以及对应字段填充位置(fieldNames)
	public boolean initialize(Sheet sheet) {
		boolean setStart = false;
		try {
			if (sheet != null) {
				int rows = sheet.getPhysicalNumberOfRows();
				for (int r = 0; r < rows; r++) {
					Row row = sheet.getRow(r);
					//CellRangeAddress cellRange=sheet.getMergedRegion(r);
					//System.out.println("FirstColumn="+cellRange.getFirstColumn());
					//System.out.println("LastColumn="+cellRange.getLastColumn());
					if (row != null) {
						int cells = row.getPhysicalNumberOfCells();
						for (short c = 0; c < cells; c++) {
							Cell cell = row.getCell(c);
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
									// 内容数据
									if (value.startsWith("$")) {
										//if (!setStart) {
											this.startRow = r;// 设置内容填充起始行，从字段设置行的下一行开始
											this.filedNames = new String[cells];
											//setStart = true;
										//}
										this.filedNames[c] = value.substring(1);// 初始化内容字段
										System.out.println(value);
									}else if(value.startsWith("#")){
										//if (!setStart) {
											this.startRow = r;// 设置内容填充起始行，从字段设置行的下一行开始
											this.productNames = new String[cells];
										//	setStart = true;
										//}
										this.productNames[c] = value.substring(1);// 初始化内容字段
										System.out.println(value);
									}else if(value.startsWith("&")){
										//if (!setStart) {
											this.startRow = r;// 设置内容填充起始行，从字段设置行的下一行开始
											this.titleNames = new String[cells];
										//	setStart = true;
										//}
										this.titleNames[c] = value.substring(1);// 初始化内容字段
										System.out.println(value);
									}

								}

							}

						}
					}
				}
			}
		} catch (Exception e) {
			setStart = false;
		}
		return setStart;
		
	}
	

	/**
	 * 生成填充模版标题数据
	 * 
	 * @param titleMap
	 * @param wb
	 * @param sheet
	 * @throws Exception
	 */
	public void generateTitleDatas(DataObject instructInfo) throws Exception {
		Sheet sheet = getSheet();
		int rows = sheet.getPhysicalNumberOfRows();
		DataObject instructTemp=DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		instructTemp.set("exChangeNo", "SH");
		for (int r = 0; r < rows; r++) {
			Row row = sheet.getRow(r);
			if (row != null) {
				int cells = row.getPhysicalNumberOfCells();
				for (short c = 0; c < cells; c++) {
					Cell cell = row.getCell(c);
					if (cell != null) {
						if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
							String value = cell.getRichStringCellValue().getString();
							if (value != null) {
								value = value.trim();
								if (value.startsWith("&")) {
									value = value.substring(1);
									String content="";
									if("SH".equals(instructTemp.getString("exChangeNo"))){
										if("marketValue".equals(value)){
											content="对应沪市日均市值";
										}
										if("account".equals(value)){
											content="沪市股东账户";
										}
										if("rationCode".equals(value)){
											content="上交所协会编码";
										}
									}
									// String
									// content=exportInfo.getString(value);
									// 重建Cell，填充标题值
									cell = row.createCell((short) c);
									cell.setCellType(Cell.CELL_TYPE_STRING);
									//cell.setCellValue(new RichTextString(content));
									cell.setCellValue(content);
									System.out.println("aaaa");
									/*if (!titleCellBold) {
										cell.setCellStyle(noneStyle);
									} else {
										cell.setCellStyle(borderStyle);
									}*/
								}
							}
						}
					}

				}
			}
		}
	}
	
	
	/**
	 * 将指定的对象数组resulset输出到指定的Excel位置
	 * 
	 * @param resultset
	 *            List<DataObject>对象数组
	 * @param wb
	 *            HSSFWorkbook
	 * @param sheet
	 *            HSSFSheet
	 */
/*	public void generateDictDatas(List<DataObject> resultset) {
		Sheet sheet = getSheet();

		for (Iterator it = resultset.iterator(); it.hasNext(); autoRowId++) {
			DataObject content = (DataObject) it.next();
			Row row = sheet.createRow(startRow);
			// String dictid = (String)
			// XPathLocator.newInstance().getValue(content, "dictid");
			// if (dictid != null) {
			// content.set("dicttypeid", content.get("eosDictType/dicttypeid"));
			// content.set("dicttypename",
			// content.get("eosDictType/dicttypename"));
			// }
			genOneLine(row, content);
			if (it.hasNext()) {
				shiftDown(sheet, startRow, sheet.getLastRowNum(), 1);
			}
			startRow++;
		}

	}
	*/

	/**
	 * 将指定的对象数组resulset输出到指定的Excel位置
	 * 
	 * @param resultset
	 *            List<DataObject>对象数组
	 * @param wb
	 *            HSSFWorkbook
	 * @param sheet
	 *            HSSFSheet
	 */
/*	public void generateContentDatas(List<DataObject> resultset) {
		Sheet sheet = getSheet();

		for (Iterator it = resultset.iterator(); it.hasNext(); autoRowId++) {
			DataObject content = (DataObject) it.next();
			startRow++;
			Row row = sheet.createRow(startRow);
			genOneLine(row, content);
			if (it.hasNext()) {
				shiftDown(sheet, startRow, sheet.getLastRowNum(), 1);
			}

		}

	}
	*/
	
	

	/**
	 * 生成一行excel数据
	 * 
	 * @param row
	 * @param content
	 */
/*	private void genOneLine(Row row, DataObject content) {
		for (int i = 0; i < fieldNames.length; i++) {
			// 输出自动生成的行号
			if (fieldNames[i] != null && fieldNames[i].equals(FIELD_AUTO_ID)) {
				Cell cell = row.createCell((short) i);
				cell.setCellStyle(borderStyle);
				cell.setCellType(Cell.CELL_TYPE_STRING);
				cell.setCellValue(autoRowId);
				continue;
			}

			if (fieldNames[i] != null) {
				Cell cell = row.createCell((short) i);
				cell.setCellStyle(borderStyle);
				if (content != null) {
					// 字段名支持xpath取值
					Object value = XPathLocator.newInstance().getValue(content, fieldNames[i]);

					// Object value=content.get(fieldNames[i]);
					if (value != null) {
						if (value instanceof Double || value instanceof BigDecimal) {
							cell.setCellType(Cell.CELL_TYPE_NUMERIC);
							cell.setCellValue(Double.parseDouble(value.toString()));
						} else {
							cell.setCellType(Cell.CELL_TYPE_STRING);
							cell.setCellValue(new RichTextString(value.toString()));
						}
					} else {
						cell.setCellType(Cell.CELL_TYPE_BLANK);
					}

				} else {

					cell.setCellType(Cell.CELL_TYPE_BLANK);
					if (!blankCellBold) {
						cell.setCellStyle(noneStyle);
					} else {
						cell.setCellStyle(borderStyle);
					}
				}
			}
		}
	}
	
*/
	
	/**
	 * 向下平推表格，并复制格式与内容
	 * 
	 * @param thisrow：当前行号
	 * @param lastrow：最后行号
	 * @param shiftcount：平推量
	 */
/*	private void shiftDown(Sheet sheet, int thisrow, int lastrow, int shiftcount) {
		sheet.shiftRows(thisrow, lastrow, shiftcount);

		for (int z = 0; z < shiftcount; z++) {
			Row row = sheet.getRow(thisrow);
			Row oldrow = sheet.getRow(thisrow + shiftcount);
			// 将各行的行高复制
			oldrow.setHeight(row.getHeight());
			// 将各个单元格的格式复制
			for (short i = 0; i <= oldrow.getPhysicalNumberOfCells(); i++) {

				Cell cell = row.createCell(i);
				Cell oldcell = oldrow.getCell(i);

				if (oldcell != null) {
					switch (oldcell.getCellType()) {
					case Cell.CELL_TYPE_STRING:
						cell.setCellType(Cell.CELL_TYPE_STRING);
						cell.setCellValue(oldcell.getRichStringCellValue());
						break;
					case Cell.CELL_TYPE_NUMERIC:
						cell.setCellType(Cell.CELL_TYPE_NUMERIC);
						cell.setCellValue(oldcell.getNumericCellValue());
						break;
					default:
						cell.setCellType(Cell.CELL_TYPE_STRING);
						cell.setCellValue(oldcell.getRichStringCellValue());

					}
					cell.setCellStyle(oldcell.getCellStyle());
				}
			}

			// 将有列跨越的复制
			Vector regs = findRegion(sheet, oldrow);
			if (regs.size() != 0) {
				for (int i = 0; i < regs.size(); i++) {
					Region reg = (Region) regs.get(i);
					reg.setRowFrom(row.getRowNum());
					reg.setRowTo(row.getRowNum());
					sheet.addMergedRegion(reg);
				}
			}
			thisrow++;
		}
	}
*/
	/**
	 * 查找所有的合并单元格
	 * 
	 * @param oldrow
	 * @return
	 */
/*	private Vector findRegion(Sheet sheet, Row oldrow) {
		Vector<Region> regs = new Vector<Region>();
		int num = sheet.getNumMergedRegions();
		int curRowid = oldrow.getRowNum();
		for (int i = 0; i < num; i++) {
			Region reg = sheet.getMergedRegionAt(i);
			if (reg.getRowFrom() == reg.getRowTo() && reg.getRowFrom() == curRowid) {
				regs.add(reg);
			}
		}
		return regs;
	}
	
	
*/	
	
	//根据模板文件名构造函数
	public InstructTemplate(String templateFile) {
		this.templateFile = templateFile;
		try {
			if(templateFile.endsWith(".xlsx")){
				setWb(new XSSFWorkbook(getFileInputStream(templateFile)));
	        }else if(templateFile.endsWith(".xls")){
	            setWb(new HSSFWorkbook(getFileInputStream(templateFile)));
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//获取文件输入流
	private FileInputStream getFileInputStream(String tempFilePath) throws FileNotFoundException {
	    return new FileInputStream(tempFilePath);
	  
	 }

	public String getTemplateFile() {
		return templateFile;
	}

	public void setTemplateFile(String templateFile) {
		this.templateFile = templateFile;
	}

	public String[] getTitleNames() {
		return titleNames;
	}

	public void setTitleNames(String[] titleNames) {
		this.titleNames = titleNames;
	}

	public String[] getFiledNames() {
		return filedNames;
	}

	public void setFiledNames(String[] filedNames) {
		this.filedNames = filedNames;
	}

	public String[] getProductNames() {
		return productNames;
	}

	public void setProductNames(String[] productNames) {
		this.productNames = productNames;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getFontSize() {
		return fontSize;
	}

	public void setFontSize(int fontSize) {
		this.fontSize = fontSize;
	}

	public String getFontName() {
		return fontName;
	}

	public void setFontName(String fontName) {
		this.fontName = fontName;
	}

	public boolean isTitleCellBold() {
		return titleCellBold;
	}

	public void setTitleCellBold(boolean titleCellBold) {
		this.titleCellBold = titleCellBold;
	}

	public boolean isBlankCellBold() {
		return blankCellBold;
	}

	public void setBlankCellBold(boolean blankCellBold) {
		this.blankCellBold = blankCellBold;
	}

	public CellStyle getBorderStyle() {
		return borderStyle;
	}

	public void setBorderStyle(CellStyle borderStyle) {
		this.borderStyle = borderStyle;
	}

	public CellStyle getNoneStyle() {
		return noneStyle;
	}

	public void setNoneStyle(CellStyle noneStyle) {
		this.noneStyle = noneStyle;
	}

	public int getAutoRowId() {
		return autoRowId;
	}

	public void setAutoRowId(int autoRowId) {
		this.autoRowId = autoRowId;
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
	
	
	
	
	public void outToFile(File file) throws IOException{
		
		//写入数据并关闭文件
		FileOutputStream fout = new FileOutputStream(file.getPath());  
		this.getWb().write(fout);
		fout.close();
	}
}
