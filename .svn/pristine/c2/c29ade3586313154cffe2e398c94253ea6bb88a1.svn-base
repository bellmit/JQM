package com.cjhxfund.ats.fm.baseinfo;

import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFComment;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

import com.eos.foundation.common.io.FileUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.ConfigurationUtil;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

@Bizlet("")
public class ExportExcelUtil<T> {
	
	/**
	 * 输出文件名
	 */
	private String outputFile;
	
	/**
	 * 构造器
	 * @param outputFile 输出文件
	 */
	public ExportExcelUtil(String outputFile){
		this.outputFile=outputFile;
	}
	
	public ExportExcelUtil() {
		// TODO 自动生成的构造函数存根
	}

	public String[] exportExcelHeader(Class<T> clz){
		 Field   fields[]   =   clz.getDeclaredFields(); 
   	 String[]   name   =   new String[fields.length]; 
        try{ 
                  Field.setAccessible(fields,   true); 
                  for   (int   i   =   0;   i   <   fields.length;   i++)   { 
                         name[i]   =   fields[i].getName(); 
                         System.out.println(name[i]   +   "-> "); 
                  } 
        } 
        catch(Exception   e){ 
                 e.printStackTrace(); 
        } 
        return name;
	}
	public void exportExcel(Collection<T> dataset, OutputStream out) {
       exportExcel("导出EXCEL文档", null,null, dataset, out, "yyyy-MM-dd");
   }
   public void exportExcel(String[] headers, Collection<T> dataset,
           OutputStream out) {
       exportExcel("导出EXCEL文档", null,headers, dataset, out, "yyyy-MM-dd");
   }
   public void exportExcel(String title, String[] headers,
           Collection<T> dataset, OutputStream out) {
       exportExcel(title,null, headers, dataset, out, "yyyy-MM-dd");
   }
   public void exportExcel(String title,String[] headerTitle, String[] headers,
           Collection<T> dataset, OutputStream out) {
       exportExcel(title,headerTitle, headers, dataset, out, "yyyy-MM-dd");
   }
   public void exportExcel(String[] headerTitle,String[] headers, Collection<T> dataset,
           OutputStream out, String pattern) {
       exportExcel("导出EXCEL文档",headerTitle, headers, dataset, out, pattern);
   }
   /**
    * 这是一个通用的方法，利用了JAVA的反射机制，可以将放置在JAVA集合中并且符号一定条件的数据以EXCEL 的形式输出到指定IO设备上
    * 
    * @param title
    *            表格标题名
    *  @param headerTitle
    *  			表格属性列名数组（标题）若为null，默认显示headers
    * @param headers
    *            表格属性列名数组
    * @param dataset
    *            需要显示的数据集合,集合中一定要放置符合javabean风格的类的对象。此方法支持的
    *            javabean属性的数据类型有基本数据类型及String,Date,byte[](图片数据)
    * @param out
    *            与输出设备关联的流对象，可以将EXCEL文档导出到本地文件或者网络中
    * @param pattern
    *            如果有时间数据，设定输出格式。默认为"yyy-MM-dd"
    */
   @SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
   public void exportExcel(String title,String[] headerTitle, String[] headers,
           Collection<T> dataset, OutputStream out, String pattern) {
       // 声明一个工作薄
       HSSFWorkbook workbook = new HSSFWorkbook();
       // 生成一个样式
       HSSFCellStyle style = workbook.createCellStyle();
       // 设置这些样式
       style.setFillForegroundColor(HSSFColor.WHITE.index);
       style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
       style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
       style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
       style.setBorderRight(HSSFCellStyle.BORDER_THIN);
       style.setBorderTop(HSSFCellStyle.BORDER_THIN);
       style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
       // 生成一个字体
       HSSFFont font = workbook.createFont();
       font.setColor(HSSFColor.BLACK.index);
       font.setFontHeightInPoints((short) 12);
       font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
       // 把字体应用到当前的样式
       style.setFont(font);
       // 生成并设置另一个样式
       HSSFCellStyle style2 = workbook.createCellStyle();
       style2.setFillForegroundColor(HSSFColor.WHITE.index);
       style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
       style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
       style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
       style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
       style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
       style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
       style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
       // 生成另一个字体
       HSSFFont font2 = workbook.createFont();
       font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
       // 把字体应用到当前的样式
       style2.setFont(font2);
       int sheetCount = 1000;
       if (dataset.size() > sheetCount) {
           Iterator<T> it = dataset.iterator();
           for (int i = 0; i <= 4; i++) {
               int index = 0;
               List<T> list = new ArrayList<T>();
               while (it.hasNext()) {
                   index++;
                   if (index < sheetCount) {
                       list.add(it.next());
                   } else {
                       break;
                   }
               }
               try {
					generateSheet(list, style, style2, workbook, pattern,headerTitle, headers,
					        title + "_" + (i + 1));
				} catch (Exception e) {
					e.printStackTrace();
				}
           }
       } else {
           try {
				generateSheet(dataset, style, style2, workbook, pattern,headerTitle, headers,
				        title);
			} catch (Exception e) {
				e.printStackTrace();
			}
       }
       try {
           workbook.write(out);
       } catch (IOException e) {
           e.printStackTrace();
       }finally{
       	try {
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
       }
   }
   public void generateSheet(Collection<T> dataset, HSSFCellStyle style,
           HSSFCellStyle style2, HSSFWorkbook workbook, String pattern,
           String[] headerTitle,String[] headers, String title) throws Exception {
       // 生成一个表格
       HSSFSheet sheet = workbook.createSheet(title);
       // 设置表格默认列宽度为15个字节
       sheet.setDefaultColumnWidth((short) 15);
       // 声明一个画图的顶级管理器
       HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
       // 定义注释的大小和位置,详见文档
       HSSFComment comment = patriarch.createComment(new HSSFClientAnchor(0,
               0, 0, 0, (short) 4, 2, (short) 6, 5));
       // 设置注释内容
       comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));
       // 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.
       comment.setAuthor("author");
       // 产生表格标题行
       HSSFRow row = sheet.createRow(0);
       String[] showTitle = headers;
       if(headerTitle.length>0) showTitle = headerTitle;
       int indexTitle = 0;//excel列下标
       for (short i = 0; i < showTitle.length; i++) {
       	if(showTitle[i].isEmpty()) continue;
           HSSFCell cell = row.createCell(indexTitle);
           cell.setCellStyle(style);
           HSSFRichTextString text = new HSSFRichTextString(showTitle[i]);
           cell.setCellValue(text);
           indexTitle++;
       }
       if(dataset.isEmpty()) return;
       // 遍历集合数据，产生数据行
       Iterator<T> it = dataset.iterator();
       int index = 0;
       while (it.hasNext()) {
           index++;
           row = sheet.createRow(index);
           T t = (T) it.next();
           Class tCls = t.getClass();
           Method[] methods=t.getClass().getMethods();
           // 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
           Field[] fields=new Field[headers.length];
          
           for (short j = 0; j < headers.length; j++) {
           	if("".equals(headers[j]) || headers[j]==null)  continue;
           	    Field field1  = tCls.getDeclaredField(headers[j]);
				fields[j]=field1;
           }
           int indexText = 0;//excel列下标
           for (short i = 0; i < fields.length; i++) {
           	if( "".equals(fields[i])|| fields[i]==null) continue;
           	
               Field field = fields[i];
               HSSFCell cell = row.createCell(indexText);
              
               cell.setCellStyle(style2);
               
               String fieldName = field.getName();
               PropertyDescriptor pd=new PropertyDescriptor(fieldName,tCls);
               Method getMethod=pd.getReadMethod();
               Object value = getMethod.invoke(t, new Object[] {});
               // 判断值的类型后进行强制类型转换
               String textValue = null;
               if (value instanceof Boolean) {
                   boolean bValue = (Boolean) value;
                   textValue = "是";
                   if (!bValue) textValue = "否";
               } else if (value instanceof Date) {
                   Date date = (Date) value;
                   SimpleDateFormat sdf = new SimpleDateFormat(pattern);
                   textValue = sdf.format(date);
               } else if (value instanceof byte[]) {
                   // 有图片时，设置行高为60px;
                   row.setHeightInPoints(60);
                   // 设置图片所在列宽度为80px,注意这里单位的一个换算
                   sheet.setColumnWidth(indexText, (short) (35.7 * 80));
                   // sheet.autoSizeColumn(i);
                   byte[] bsValue = (byte[]) value;
                   HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0,
                           1023, 255, (short) 6, index, (short) 6, index);
                   anchor.setAnchorType(2);
                   patriarch.createPicture(anchor, workbook.addPicture(
                           bsValue, HSSFWorkbook.PICTURE_TYPE_JPEG));
               }  else {
                   // 其它数据类型都当作字符串简单处理
                   if (value == null)   value = "";
                   
                   textValue = value.toString();
               }
               // 如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成
               if (textValue != null) {
                   Pattern p = Pattern.compile("^//d+(//.//d+)?{1}quot;");
                   Matcher matcher = p.matcher(textValue);
                   if (matcher.matches()) {
                       // 是数字当作double处理
                       cell.setCellValue(Double.parseDouble(textValue));
                   } else {
                       HSSFRichTextString richString = new HSSFRichTextString(
                               textValue);
                       HSSFFont font3 = workbook.createFont();
                       font3.setColor(HSSFColor.BLACK.index);
                       richString.applyFont(font3);
                       cell.setCellValue(richString);
                   }
               }
               indexText++;
           }
       }
   }
   
   /**
	 * 生成EXCEL输出文件，默认带时间戳
	 * @param templateFilename 文件名
	 * @return
	 */
	private static String generateOutputExcel(String templateFilename){
		String filename=templateFilename;
		if(templateFilename.endsWith(".xls")){
			filename=templateFilename.substring(0,templateFilename.length()-4);
		}

		SimpleDateFormat format=new SimpleDateFormat("yyyyMMddHHmmss");
		String datetimeString=format.format(new Date());

		filename=filename+"_"+datetimeString+".xls";
		return filename;
	}
   
   /**
	 * 自定义excel导出
	 * @param headerTitle 标题名称
	 * * @param headers 标题名称对应的数据库字段
	 * @param resultset 结果集
	 * @throws Exception
	 */
	@SuppressWarnings("null")
	@Bizlet("自定义excel导出")
	public String generate(DataObject[] resultset,String headerTitle,String headers)throws Exception{
		if(resultset.length>0){
			String outputFileUrl=null;
			String[] headerTitle1 = headerTitle.split(",");
	        String[] headers1 = headers.split(",");
	        
	        List<TAtsUnderwriterStockinfo> resultsetList=new ArrayList<TAtsUnderwriterStockinfo>();
	        List<DataObject> resultsetList2=Arrays.asList(resultset);
	        TAtsUnderwriterStockinfo underwriterStockinfo =null;
	        //这里因为EOS格式问题，需要麻烦转换,注意实体的lunderwriterStockId大小写
	        for(Iterator it=resultsetList2.iterator();it.hasNext();){
	        	underwriterStockinfo=new TAtsUnderwriterStockinfo();
	        	DataObject content=(DataObject)it.next();
	        	//System.out.println("值："+content.getString("lUnderwriterStockId")+","+content.getString("vcMainUnderwriter"));
	        	underwriterStockinfo.setLunderwriterStockId(content.getString("lUnderwriterStockId"));
	        	underwriterStockinfo.setVcMainUnderwriter(content.getString("vcMainUnderwriter"));
	        	underwriterStockinfo.setVcUnderwriterContactInfo(content.getString("vcUnderwriterContactInfo"));
	        	underwriterStockinfo.setVcApplicationTime(content.getString("vcApplicationTime"));
	        	underwriterStockinfo.setVcEntryTime(content.getString("vcEntryTime"));
	        	underwriterStockinfo.setVcIssuerNameFull(content.getString("vcIssuerNameFull"));
	        	underwriterStockinfo.setVcStockType(content.getString("vcStockType"));
	        	underwriterStockinfo.setVcIssueType(content.getString("vcIssueType"));
	        	underwriterStockinfo.setVcStockName(content.getString("vcStockName"));
	        	underwriterStockinfo.setVcStockNameFull(content.getString("vcStockNameFull"));
	        	underwriterStockinfo.setVcIssueBalance(content.getString("vcIssueBalance"));
	        	underwriterStockinfo.setVcExistLimite(content.getString("vcExistLimite"));
	        	underwriterStockinfo.setVcExistLimiteDesc(content.getString("vcExistLimiteDesc"));
	        	underwriterStockinfo.setVcInquiryInterval(content.getString("vcInquiryInterval"));
	        	underwriterStockinfo.setVcIssueAppraise(content.getString("vcIssueAppraise"));
	        	underwriterStockinfo.setVcBondAppraise(content.getString("vcBondAppraise"));
	        	underwriterStockinfo.setVcAppraiseOrgan(content.getString("vcAppraiseOrgan"));
	        	underwriterStockinfo.setVcPaymentPlace(content.getString("vcPaymentPlace"));
	        	underwriterStockinfo.setVcDueDate(content.getString("vcDueDate"));
	        	underwriterStockinfo.setVcPayInteval(content.getString("vcPayInteval"));
	        	underwriterStockinfo.setVcBegincalDate(content.getString("vcBegincalDate"));
	        	underwriterStockinfo.setVcCreditSituation(content.getString("vcCreditSituation"));
	        	underwriterStockinfo.setVcEnterpriseProperty(content.getString("vcEnterpriseProperty"));
	        	underwriterStockinfo.setVcIsBid(content.getString("vcIsBid"));
	        	underwriterStockinfo.setVcMarkAssets(content.getString("vcMarkAssets"));
	        	underwriterStockinfo.setVcOldHolder(content.getString("vcOldHolder"));
	        	underwriterStockinfo.setVcIsPledge(content.getString("vcIsPledge"));
	        	underwriterStockinfo.setVcPropertyDesc(content.getString("vcPropertyDesc"));
	        	underwriterStockinfo.setVcHisIssue(content.getString("vcHisIssue"));
	        	underwriterStockinfo.setVcIsHaveFinancing(content.getString("vcIsHaveFinancing"));
	        	underwriterStockinfo.setCstatus(content.getString("cStatus"));
	        	underwriterStockinfo.setVcExportFilename(content.getString("vcExportFilename"));
	        	underwriterStockinfo.setLoperatorNo(content.getString("lOperatorNo"));
	        	underwriterStockinfo.setLreleaseCount(content.getString("lReleaseCount"));
	        	resultsetList.add(underwriterStockinfo);
	        }

			try{
				//临时路径是服务器当前war下面的excel-config目录    D:\ATSIDE75\apache-tomcat-7.0.54\webapps\ats\/WEB-INF/excel-config/
				String templateDir=ApplicationContext.getInstance().getWarRealPath()+ConfigurationUtil.getContributionConfig(ExcelUtilConfiguration.CONTRIBUTION_ABFRAME_UTILS,
						ExcelUtilConfiguration.MODULE_ABFRAME,
						ExcelUtilConfiguration.GROUP_EXCEL,
						ExcelUtilConfiguration.EXCEL_TEMPLATE_PATH);
				if(!templateDir.endsWith("/")){
					 templateDir+="/";
				  }
				  String tempDir=templateDir+"temp/";
				  File file=new File(tempDir);
				  if(!file.exists()){
				   //创建临时目录
				   FileUtil.mkDir(tempDir);
				   //file.createNewFile();
				  }
				outputFileUrl=tempDir+generateOutputExcel("underwriterTemplate.xls");
				ExportExcelUtil<TAtsUnderwriterStockinfo> ex = new ExportExcelUtil<TAtsUnderwriterStockinfo>();
		        FileOutputStream fileOut = new FileOutputStream(outputFileUrl);
		        ex.exportExcel("sheet1",headerTitle1,headers1, resultsetList, fileOut);
		        fileOut.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return outputFileUrl;
		}else{
			return "";
		}
	}
   
   //自定义导出excel列
    public static void main(String[] args) throws Exception {
    	MenuVo me =new MenuVo();
    	me.setUnid("101");
    	me.setName("aaaaa");
    	me.setPrivilege("44");
   	    ExportExcelUtil<MenuVo> ex = new ExportExcelUtil<MenuVo>();
   	    //String[] headers = ex.exportExcelHeader(MenuVo.class);
        List<MenuVo> list = new ArrayList<MenuVo>();//(List<MenuVo>) hashMap.get("list");
        list.add(me);
        list.add(me);
        String[] headerTitle = {"编号","名称"};
        String[] headers = {"unid","name"};
        OutputStream out = new FileOutputStream("D://c.xls");
        ex.exportExcel("自定义导出测试",headerTitle,headers, list, out);
        out.close();
        System.out.println("excel导出成功！");
    }

}
