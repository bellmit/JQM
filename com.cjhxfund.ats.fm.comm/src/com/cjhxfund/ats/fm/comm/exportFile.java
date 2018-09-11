package com.cjhxfund.ats.fm.comm;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.eos.foundation.common.io.FileUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.infra.config.Configuration;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

public class exportFile {
	@SuppressWarnings("deprecation")
	@Bizlet("导出")
	
	public String exportExcel(DataObject[] data, String filename,String rulename,String modeName ){
		//获取配置对象文件
		Configuration config = ConfigFileUtil.getConfigFile(Constants.EXCEL_CONFIG_PATH);
		
		String importRuleStr = "";// 导出规则全量
		importRuleStr = config.getConfigValue("EXPORT_EXCEL",rulename,"rule");// 导出规则
		String downloadpath = "";// 下载路径
		if (importRuleStr.equals("")) {
			return null;
		}
		String[] fieldArray = importRuleStr.split(";");
		
		String time="_"+new java.text.SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
		StringBuffer sb = new StringBuffer(filename);
		sb.insert(filename.lastIndexOf("."), time);
		filename=sb.toString();
		System.out.println(filename);
		//获取WAR所在目录 
		String dir = "/exportfile/" + filename;
		String filepath = ApplicationContext.getInstance().getWarRealPath()+ dir;
		String filepathtemp = ApplicationContext.getInstance().getWarRealPath()+ "/exportfile";
		downloadpath = filepath;
		File file = new File(filepath);
		 
		// 当用户指定的模板文件不存在时，将自动生成指定的模板文件
	    if (!file.exists()) {
			// 创建临时目录
			try {
				FileUtil.mkDir(filepathtemp); //　创建文件夹
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		//导出excel
		try {
			long startTime = System.currentTimeMillis();
			String fileType = filename.substring(filename.lastIndexOf(".") + 1, filename.length());
			// 创建工作文档对象
			HSSFWorkbook Hwb  = null;
			XSSFWorkbook Xwb  = null;
			
			if (fileType.equals("xlsx")) {
				 Xwb = new XSSFWorkbook();
				 XSSFSheet sheet =null;
				//创建页
				 sheet = Xwb.createSheet(modeName);  
				
				//单元格格式
				XSSFFont titleFont = Xwb.createFont();
				titleFont.setFontName("微软雅黑");
				titleFont.setFontHeightInPoints((short) 12); // 字体大小
				titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);// 加粗

				XSSFFont contentFont = Xwb.createFont();
				contentFont.setFontName("微软雅黑");
				contentFont.setFontHeightInPoints((short) 9);
				
				XSSFDataFormat format = Xwb.createDataFormat(); 
				
				XSSFCellStyle stringStyle = Xwb.createCellStyle();
				stringStyle.setBorderBottom(CellStyle.BORDER_THIN);
				stringStyle.setBorderLeft(CellStyle.BORDER_THIN);
				stringStyle.setBorderRight(CellStyle.BORDER_THIN);
				stringStyle.setBorderTop(CellStyle.BORDER_THIN);
				stringStyle.setAlignment(CellStyle.ALIGN_CENTER);
				stringStyle.setFont(contentFont);
				stringStyle.setWrapText(true);//设置自动换行
				
				XSSFCellStyle longStyle = Xwb.createCellStyle();
				longStyle.setBorderBottom(CellStyle.BORDER_THIN);
				longStyle.setBorderLeft(CellStyle.BORDER_THIN);
				longStyle.setBorderRight(CellStyle.BORDER_THIN);
				longStyle.setBorderTop(CellStyle.BORDER_THIN);
				longStyle.setAlignment(CellStyle.ALIGN_CENTER);
				longStyle.setDataFormat(format.getFormat("0"));
				longStyle.setFont(contentFont);
				
				XSSFCellStyle intStyle = Xwb.createCellStyle();
				intStyle.setBorderBottom(CellStyle.BORDER_THIN);
				intStyle.setBorderLeft(CellStyle.BORDER_THIN);
				intStyle.setBorderRight(CellStyle.BORDER_THIN);
				intStyle.setBorderTop(CellStyle.BORDER_THIN);
				intStyle.setAlignment(CellStyle.ALIGN_CENTER);
				intStyle.setDataFormat(format.getFormat("0"));
				intStyle.setFont(contentFont);
				
				XSSFCellStyle doubleStyle = Xwb.createCellStyle();
				doubleStyle.setBorderBottom(CellStyle.BORDER_THIN);
				doubleStyle.setBorderLeft(CellStyle.BORDER_THIN);
				doubleStyle.setBorderRight(CellStyle.BORDER_THIN);
				doubleStyle.setBorderTop(CellStyle.BORDER_THIN);
				doubleStyle.setAlignment(CellStyle.ALIGN_CENTER);
				doubleStyle.setDataFormat(format.getFormat("0.00"));
				doubleStyle.setFont(contentFont);
				
				XSSFCellStyle dateStyle = Xwb.createCellStyle();
				dateStyle.setBorderBottom(CellStyle.BORDER_THIN);
				dateStyle.setBorderLeft(CellStyle.BORDER_THIN);
				dateStyle.setBorderRight(CellStyle.BORDER_THIN);
				dateStyle.setBorderTop(CellStyle.BORDER_THIN);
				dateStyle.setAlignment(CellStyle.ALIGN_CENTER);
				dateStyle.setDataFormat(format.getFormat("yyyy-MM-dd"));
				dateStyle.setFont(contentFont);
				
				
				XSSFCellStyle TimeStampStyle = Xwb.createCellStyle();
				TimeStampStyle.setBorderBottom(CellStyle.BORDER_THIN);
				TimeStampStyle.setBorderLeft(CellStyle.BORDER_THIN);
				TimeStampStyle.setBorderRight(CellStyle.BORDER_THIN);
				TimeStampStyle.setBorderTop(CellStyle.BORDER_THIN);
				TimeStampStyle.setAlignment(CellStyle.ALIGN_CENTER);
				TimeStampStyle.setDataFormat(format.getFormat("yyyy-MM-dd HH:mm:ss"));
				TimeStampStyle.setFont(contentFont);
				
				
				XSSFCellStyle  date1Style = Xwb.createCellStyle();
				date1Style.setBorderBottom(CellStyle.BORDER_THIN);
				date1Style.setBorderLeft(CellStyle.BORDER_THIN);
				date1Style.setBorderRight(CellStyle.BORDER_THIN);
				date1Style.setBorderTop(CellStyle.BORDER_THIN);
				date1Style.setAlignment(CellStyle.ALIGN_CENTER);
				date1Style.setDataFormat(format.getFormat("yyyyMMdd"));
				date1Style.setFont(contentFont);
				
				XSSFCellStyle fieldStyle = Xwb.createCellStyle();
				fieldStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);// 垂直
				fieldStyle.setAlignment(CellStyle.ALIGN_CENTER);
				fieldStyle.setBorderBottom(CellStyle.BORDER_THIN);
				fieldStyle.setBorderLeft(CellStyle.BORDER_THIN);
				fieldStyle.setBorderRight(CellStyle.BORDER_THIN);
				fieldStyle.setBorderTop(CellStyle.BORDER_THIN);
				fieldStyle.setFillForegroundColor(IndexedColors.LIGHT_TURQUOISE.getIndex());
				fieldStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
				fieldStyle.setFont(titleFont);
				
				
				XSSFCellStyle dictStyle = Xwb.createCellStyle();
				dictStyle.setBorderBottom(CellStyle.BORDER_THIN);
				dictStyle.setBorderLeft(CellStyle.BORDER_THIN);
				dictStyle.setBorderRight(CellStyle.BORDER_THIN);
				dictStyle.setBorderTop(CellStyle.BORDER_THIN);
				dictStyle.setAlignment(CellStyle.ALIGN_CENTER);
				dictStyle.setFont(contentFont);
				
				XSSFCellStyle emptyStyle = Xwb.createCellStyle();//创建空单元格样式
				emptyStyle.setBorderTop(CellStyle.BORDER_THIN);//上边框线(黑)
				emptyStyle.setBorderBottom(CellStyle.BORDER_THIN);//下边框线(黑)
				emptyStyle.setBorderLeft(CellStyle.BORDER_THIN);//左边框线(黑)
				emptyStyle.setBorderRight(CellStyle.BORDER_THIN);//右边框线(黑)
				emptyStyle.setAlignment(CellStyle.ALIGN_CENTER);//设置居中
				emptyStyle.setFont(contentFont);//设置字体
				
				//创建第一行
				XSSFRow row = sheet.createRow(0);
				row.setHeight((short) 350);
				
				// 写表头
				for (int i = 0; i < fieldArray.length; i++) {// 循环列
					String[] columnArray = fieldArray[i].split(",");
					String tableherd = columnArray[1];
					XSSFCell cell = row.createCell((short) i);// 生成列
					cell.setCellStyle(fieldStyle);//表头居中
					cell.setCellType(Cell.CELL_TYPE_STRING);// 文本格式
                   
					if(i==11){
						
						sheet.setColumnWidth(i,  20000); // 设置单元格宽度
					}
					else if(i==0){
	                	   sheet.setColumnWidth(i,  12000); // 设置单元格宽度
	                	}
					else  if(i==1){
	                	   sheet.setColumnWidth(i,  12000); // 设置单元格宽度
	                   }
					else  if(i==2){
	                	   sheet.setColumnWidth(i,  12000); // 设置单元格宽度
	                   }
					else{
					    sheet.setColumnWidth(i,   (tableherd.length()*2*512)); // 设置单元格宽度
					}
					
					//sheet.setColumnWidth((short)i,  (short) ((short)tableherd.length()* 2000)); // 设置单元格宽度
					//sheet.autoSizeColumn(i);  
					//sheet.setColumnWidth(i,columnArray[i].toString().length() * 512);
					cell.setCellValue(tableherd);
				}
				
				int rowid = 1;
				// 导出数据
				System.out.println("==========开始写入==============> " + new Date());

				for (int i = 0;i<data.length ; i++) {// 循环行
					row = sheet.createRow(rowid);
					row.setHeight((short) 310);
					 for (int y = 0; y < fieldArray.length; y++) {// 循环列
						String[] columnArray = fieldArray[y].split(",");
						String colname = columnArray[0];// 列英文名
						String ishaveywzd = columnArray[2];// 业务字典
						String shujutype = columnArray[3];// 数据类型
						String colvalue = "";
						XSSFCell cell = row.createCell((short) y);// 生成列
						
						if (shujutype.equals("String") ) {
							colvalue = data[i].getString(colname);
							cell.setCellStyle( stringStyle);
							
						} else if (shujutype.equals("Date") ) {
							colvalue =data[i].getDate(colname) == null ? "" : data[i].getDate(colname).toString();
							cell.setCellStyle( dateStyle);

						} else if (shujutype.equals("TimeStamp") ) {
							colvalue = data[i].getString(colname);
							cell.setCellStyle(TimeStampStyle);
							
						} else if (shujutype.equals("Int") ) {
							colvalue = data[i].getInt(colname)== 0 ? "0" : String.valueOf(data[i].getInt(colname));
							cell.setCellStyle( intStyle);
							
						} else if (shujutype.equals("Decimal") ) {
							colvalue = String.valueOf(data[i].getFloat(colname));
							cell.setCellStyle( doubleStyle);
							
						}else if (shujutype.equals("Long") ) {
							colvalue = String.valueOf(data[i].getLong(colname));
							cell.setCellStyle( longStyle);
							
						}else if (shujutype.equals("Date1") ) {
							colvalue = data[i].getString(colname);
							cell.setCellStyle( date1Style);
						}

						if (colvalue != null && !"".equals(colvalue.trim())) {
							if (ishaveywzd!=null && !"null".equals(ishaveywzd.trim()) && !"".equals(ishaveywzd.trim())) {// 如果有业务字典
								System.out.println("ishaveywzd："+ishaveywzd);
								System.out.println("colvalue："+colvalue);
								colvalue = BusinessDictUtil.getDictName(ishaveywzd,colvalue);// 返回业务字典对应的名称
								cell.setCellStyle( dictStyle);
							}
						} else {
							colvalue = "";
							cell.setCellStyle(emptyStyle);
						}
						
						
						cell.setCellValue(colvalue != null ? colvalue.toString() : "");
					}
					rowid++;
				 }
				
				OutputStream out = new FileOutputStream(file);// 创建输出流
				BufferedOutputStream bos = new BufferedOutputStream(out);
				
				Xwb.write(bos);// 输出
				bos.flush();
				out.close();// 关闭输出流
				System.out.println( System.currentTimeMillis() - startTime + "毫秒!");
				System.out.println("==========导出完毕==============> " + new Date());
				}
			
			
			else if (fileType.equals("xls")) {
				 Hwb = new HSSFWorkbook();
				 HSSFSheet sheet =null;
			//创建页
			 sheet = Hwb.createSheet(modeName);  
			
			
			//单元格格式
			HSSFFont titleFont = Hwb.createFont();
			titleFont.setFontName("微软雅黑");
			titleFont.setFontHeightInPoints((short) 12); // 字体大小
			titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);// 加粗

			HSSFFont contentFont = Hwb.createFont();
			contentFont.setFontName("微软雅黑");
			contentFont.setFontHeightInPoints((short) 9);
			
			HSSFDataFormat format = Hwb.createDataFormat(); 
			
			HSSFCellStyle stringStyle = Hwb.createCellStyle();
			stringStyle.setBorderBottom(CellStyle.BORDER_THIN);
			stringStyle.setBorderLeft(CellStyle.BORDER_THIN);
			stringStyle.setBorderRight(CellStyle.BORDER_THIN);
			stringStyle.setBorderTop(CellStyle.BORDER_THIN);
			stringStyle.setAlignment(CellStyle.ALIGN_CENTER);
			stringStyle.setFont(contentFont);
			
			HSSFCellStyle longStyle = Hwb.createCellStyle();
			longStyle.setBorderBottom(CellStyle.BORDER_THIN);
			longStyle.setBorderLeft(CellStyle.BORDER_THIN);
			longStyle.setBorderRight(CellStyle.BORDER_THIN);
			longStyle.setBorderTop(CellStyle.BORDER_THIN);
			longStyle.setAlignment(CellStyle.ALIGN_CENTER);
			longStyle.setDataFormat(format.getFormat("0"));
			longStyle.setFont(contentFont);
			
			HSSFCellStyle intStyle = Hwb.createCellStyle();
			intStyle.setBorderBottom(CellStyle.BORDER_THIN);
			intStyle.setBorderLeft(CellStyle.BORDER_THIN);
			intStyle.setBorderRight(CellStyle.BORDER_THIN);
			intStyle.setBorderTop(CellStyle.BORDER_THIN);
			intStyle.setAlignment(CellStyle.ALIGN_CENTER);
			intStyle.setDataFormat(format.getFormat("0"));
			intStyle.setFont(contentFont);
			
			HSSFCellStyle doubleStyle = Hwb.createCellStyle();
			doubleStyle.setBorderBottom(CellStyle.BORDER_THIN);
			doubleStyle.setBorderLeft(CellStyle.BORDER_THIN);
			doubleStyle.setBorderRight(CellStyle.BORDER_THIN);
			doubleStyle.setBorderTop(CellStyle.BORDER_THIN);
			doubleStyle.setAlignment(CellStyle.ALIGN_CENTER);
			doubleStyle.setDataFormat(format.getFormat("0.00"));
			doubleStyle.setFont(contentFont);
			
			HSSFCellStyle dateStyle = Hwb.createCellStyle();
			dateStyle.setBorderBottom(CellStyle.BORDER_THIN);
			dateStyle.setBorderLeft(CellStyle.BORDER_THIN);
			dateStyle.setBorderRight(CellStyle.BORDER_THIN);
			dateStyle.setBorderTop(CellStyle.BORDER_THIN);
			dateStyle.setAlignment(CellStyle.ALIGN_CENTER);
			dateStyle.setDataFormat(format.getFormat("yyyy-MM-dd"));
			dateStyle.setFont(contentFont);
			
			HSSFCellStyle TimeStampStyle = Hwb.createCellStyle();
			TimeStampStyle.setBorderBottom(CellStyle.BORDER_THIN);
			TimeStampStyle.setBorderLeft(CellStyle.BORDER_THIN);
			TimeStampStyle.setBorderRight(CellStyle.BORDER_THIN);
			TimeStampStyle.setBorderTop(CellStyle.BORDER_THIN);
			TimeStampStyle.setAlignment(CellStyle.ALIGN_CENTER);
			TimeStampStyle.setDataFormat(format.getFormat("yyyy-MM-dd HH:mm:ss"));
			TimeStampStyle.setFont(contentFont);
			
			HSSFCellStyle fieldStyle = Hwb.createCellStyle();
			fieldStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);// 垂直
			fieldStyle.setAlignment(CellStyle.ALIGN_CENTER);
			fieldStyle.setBorderBottom(CellStyle.BORDER_THIN);
			fieldStyle.setBorderLeft(CellStyle.BORDER_THIN);
			fieldStyle.setBorderRight(CellStyle.BORDER_THIN);
			fieldStyle.setBorderTop(CellStyle.BORDER_THIN);
			fieldStyle.setFillForegroundColor(IndexedColors.LIGHT_GREEN.getIndex());// 填暗红色
			fieldStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
			fieldStyle.setFont(contentFont);
			
			
			HSSFCellStyle dictStyle = Hwb.createCellStyle();
			dictStyle.setBorderBottom(CellStyle.BORDER_THIN);
			dictStyle.setBorderLeft(CellStyle.BORDER_THIN);
			dictStyle.setBorderRight(CellStyle.BORDER_THIN);
			dictStyle.setBorderTop(CellStyle.BORDER_THIN);
			dictStyle.setAlignment(CellStyle.ALIGN_CENTER);
			dictStyle.setFont(contentFont);
			
			
			//创建第一行
			HSSFRow row = sheet.createRow(0);
			row.setHeight((short) 350);
			// 写表头
			for (int i = 0; i < fieldArray.length; i++) {// 循环列
				String[] columnArray = fieldArray[i].split(",");
				String tableherd = columnArray[1];
				HSSFCell cell = row.createCell((short) i);// 生成列
				cell.setCellStyle( fieldStyle);//表头居中
				cell.setCellType(Cell.CELL_TYPE_STRING);// 文本格式
				
				
				sheet.setColumnWidth((short)i,  (short) ((short)tableherd.length()*2*256)); // 设置单元格宽度
				
				cell.setCellValue(tableherd);
			}
			
			
			
			
			
			int rowid = 1;
			// 导出数据
			System.out.println("==========开始写入==============> " + new Date());

			for (int i = 0;i<data.length ; i++) {// 循环行
				row = sheet.createRow(rowid);
				row.setHeight((short) 310);
				 for (int y = 0; y < fieldArray.length; y++) {// 循环列
					String[] columnArray = fieldArray[y].split(",");
					String colname = columnArray[0];// 列英文名
					String ishaveywzd = columnArray[2];// 业务字典
					String shujutype = columnArray[3];// 数据类型
					String colvalue = "";
					HSSFCell cell = row.createCell((short) y);// 生成列
					
					if (shujutype.equals("String") ) {
						colvalue = data[i].getString(colname);
						cell.setCellStyle( stringStyle);
						
					} else if (shujutype.equals("Date") ) {
						colvalue =data[i].getDate(colname) == null ? "" : data[i].getDate(colname).toString();
						cell.setCellStyle( dateStyle);

					} else if (shujutype.equals("Int") ) {
						colvalue = data[i].getInt(colname)== 0 ? "" : String.valueOf(data[i].getInt(colname));
						cell.setCellStyle( intStyle);
						
					} else if (shujutype.equals("Decimal") ) {
						colvalue = String.valueOf(data[i].getFloat(colname));
						cell.setCellStyle( doubleStyle);
						
					}else if (shujutype.equals("Long") ) {
						colvalue = String.valueOf(data[i].getLong(colname));
						cell.setCellStyle( longStyle);
					}

					if (colvalue != null) {
						if (!ishaveywzd.equals("null")) {// 如果有业务字典
							colvalue = BusinessDictUtil.getDictName(ishaveywzd,colvalue);// 返回业务字典对应的名称
							cell.setCellStyle( dictStyle);
						}
					} else {
						colvalue = "";
					}
					
					
					cell.setCellValue(colvalue != null ? colvalue.toString() : "");
				}
				 row = sheet.createRow(rowid+1);
				 
				 
				 for (int y = 0; y < fieldArray.length; y++) {// 循环列
						String[] columnArray = fieldArray[y].split(",");
						String colname = columnArray[0];// 列英文名
						String ishaveywzd = columnArray[2];// 业务字典
						String shujutype = columnArray[3];// 数据类型
						String colvalue = "";
						HSSFCell cell = row.createCell((short) y);// 生成列
						
						if (shujutype.equals("String") ) {
							colvalue = data[i].getString(colname);
							cell.setCellStyle( stringStyle);
							
						} else if (shujutype.equals("Date") ) {
							colvalue =data[i].getDate(colname) == null ? "" : data[i].getDate(colname).toString();
							cell.setCellStyle( dateStyle);

						} else if (shujutype.equals("Int") ) {
							colvalue = data[i].getInt(colname)== 0 ? "0" : String.valueOf(data[i].getInt(colname));
							cell.setCellStyle( intStyle);
							
						} else if (shujutype.equals("Decimal") ) {
							colvalue = String.valueOf(data[i].getFloat(colname));
							cell.setCellStyle( doubleStyle);
							
						}else if (shujutype.equals("Long") ) {
							colvalue = String.valueOf(data[i].getLong(colname));
							cell.setCellStyle( longStyle);
						}

						if (colvalue != null) {
							if (!ishaveywzd.equals("null")) {// 如果有业务字典
								colvalue = BusinessDictUtil.getDictName(ishaveywzd,colvalue);// 返回业务字典对应的名称
								cell.setCellStyle( dictStyle);
							}
						} else {
							colvalue = "";
						}
						
						
						cell.setCellValue(colvalue != null ? colvalue.toString() : "");
					}
				 
				 
				rowid++;
			}
			
			
			OutputStream out = new FileOutputStream(file);// 创建输出流
			BufferedOutputStream bos = new BufferedOutputStream(out);
			Hwb.write(bos);// 输出
			bos.flush();
			out.close();// 关闭输出流
			System.out.println( System.currentTimeMillis() - startTime + "毫秒!");
			System.out.println("==========导出完毕==============> " + new Date());
			}
			
			
			else{
				System.out.println("您的文档格式不正确！");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		downloadpath = downloadpath.replaceAll("\\\\", "/");
		return downloadpath;
	}
}
