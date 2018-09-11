package com.cjhxfund.commonUtil.manualDownload;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import com.cjhxfund.commonUtil.manualDownload.Constan;
import com.cjhxfund.commonUtil.DateUtil;
import com.eos.foundation.common.io.FileUtil;
import com.eos.foundation.eoscommon.CacheUtil;
import com.eos.foundation.eoscommon.ConfigurationUtil;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;
import com.eos.system.annotation.BizletParam;
import com.eos.system.annotation.ParamType;
import commonj.sdo.DataObject;

/**
 *
 * Excel文件操作工具类<BR>
 *
 * @author shihao
 */
@Bizlet("Excel工具操作类")
public class ExcelUtil {
	

	private ExcelUtil(){
		//工具类不允许实例化
	}


	/**
	 * 将Excel数据导入到数据库指定的表，默认每500条数据执行一次批处理导入
	 *
	 * @param excelFile Excel文件名
	 * @param entityFullName 导入的实体全名
	 * @return
	 * @throws Exception
	 */
	@Bizlet(
		value="将Excel数据导入到数据库指定的表",
		params = { 
			@BizletParam(index = 0, paramAlias = "excelFile",type=ParamType.CONSTANT),
	        @BizletParam(index = 1, paramAlias = "entityFullName",type=ParamType.CONSTANT)
	   }
	)
	public static int importExcel(String excelFile,String entityFullName)throws Exception{
		ExcelTemplate template=new ExcelTemplate();
		return template.importData(excelFile, entityFullName, 500);
	}

	
	/**
	 * 将指定的对象数组exportObjects导出到指定模板的Excel文件
	 *
	 * @param exportObjects 待导出的对象数组
	 * @param exportInfo  模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename 模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	@Bizlet(
		value="将指定的对象数组导出到指定模板的Excel文件",
		params = { 
			@BizletParam(index = 0, paramAlias = "exportObjects",type=ParamType.VARIABLE),
	        @BizletParam(index = 1, paramAlias = "exportInfo",type=ParamType.VARIABLE),
	        @BizletParam(index = 2, paramAlias = "templateFilename",type=ParamType.CONSTANT)
	    }
	)
	public static String exportExcel(DataObject[] exportObjects,DataObject exportInfo,String templateFilename,String id) throws Exception{
		if(exportObjects.length>0){
			return exportExcel(exportObjects,exportInfo,templateFilename,false,false,id);
		}else{
			return "";
		}
	}

	/**
	 * 分页将对象数组导出到指定的模板Excel文件,注意：此时模板文件必需包含Excel表格的分页符
	 * @param exportObjects 待导出的对象数组
	 * @param exportInfo  模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename 模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	@Bizlet(
		value="分页将对象数组导出到指定的模板Excel文件",
		params = { 
			@BizletParam(index = 0, paramAlias = "exportObjects",type=ParamType.VARIABLE),
	        @BizletParam(index = 1, paramAlias = "exportInfo",type=ParamType.VARIABLE),
	        @BizletParam(index = 2, paramAlias = "templateFilename",type=ParamType.CONSTANT)
	    }
	)
	public static String exportExcelWithPagnation(DataObject[] exportObjects,DataObject exportInfo,String templateFilename,String id) throws Exception{
		return exportExcel(exportObjects,exportInfo,templateFilename,true,false,id);
	}

	/**
	 * 分工作表将对象数组导出到指定的模板Excel文件，默认情况下输出工作表最大行:20000
	 * @param exportObjects 待导出的对象数组
	 * @param exportInfo  模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename 模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	@Bizlet(
		value="分工作表将对象数组导出到指定的模板Excel文件",
		params = { 
			@BizletParam(index = 0, paramAlias = "exportObjects",type=ParamType.VARIABLE),
	        @BizletParam(index = 1, paramAlias = "exportInfo",type=ParamType.VARIABLE),
	        @BizletParam(index = 2, paramAlias = "templateFilename",type=ParamType.CONSTANT)
	    }
	)
	public static String exportExcelWithSheet(DataObject[] exportObjects,DataObject exportInfo,String templateFilename,String id) throws Exception{
		return exportExcel(exportObjects,exportInfo,templateFilename,false,true,id);
	}

	/**
	 * 导出Excel文件,根据指定路径下的模板生成输出的Excel文件
	 *
	 * @param exportObjects 待导出的对象数组
	 * @param exportInfo 模板文件的其他附加信息(非结果集内容)
	 * @param templateFilename 模板文件名(不带扩展名),对应到在user-config.xml配置路径下的模板文件
	 * @param autoPagination 是否分页
	 * @param autoSheet 是否分工作表
	 * @return 返回生成的Excel文件下载路径
	 * @throws Exception
	 */
	private static String exportExcel(DataObject[] exportObjects,DataObject exportInfo,String templateFilename,boolean autoPagination,boolean autoSheet,String id) throws Exception{
		String filename=templateFilename;
		
		if(filename.indexOf(".xlsx")==-1 && ("WTRD_TZZCJFZXX").equals(filename)){
			filename+=".xlsx";
		}else if(filename.indexOf(".xls")==-1){
			filename+=".xls";
		}

		//临时路径是服务器当前war下面的excel-config目录    D:\ATSIDE75\apache-tomcat-7.0.54\webapps\ats\/WEB-INF/excel-config/
		String templateDir=ApplicationContext.getInstance().getWarRealPath()+ConfigurationUtil.getContributionConfig(ExcelUtilConfiguration.C_CONTRIBUTION_ABFRAME_UTILS,
				ExcelUtilConfiguration.C_MODULE_ABFRAME,
				ExcelUtilConfiguration.C_GROUP_EXCEL,
				ExcelUtilConfiguration.C_EXCEL_TEMPLATE_PATH);
		String excelExportMaxnum=ConfigurationUtil.getContributionConfig(ExcelUtilConfiguration.C_CONTRIBUTION_ABFRAME_UTILS,
				ExcelUtilConfiguration.C_MODULE_ABFRAME,
				ExcelUtilConfiguration.C_GROUP_EXCEL,
				ExcelUtilConfiguration.C_EXCEL_EXPORT_MAXNUM);//10000
		
		if(!templateDir.endsWith("/")){
			templateDir+="/";
		}
		
		//获取替换配置文件目录中的YYYYMMDD
		String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
		
		//写文件目录
		String key = Constan.MAP_EXCEL.get(templateFilename);//ATS_CJ_ZQXX_URL
		String filedir = null;
		if(key!=null){//说明是导出到O32的
			DataObject config = (DataObject)CacheUtil.getValue(Constan.CACHE_NAME, key);
			//导出文件完整路径，包含文件名
			filedir = config.getString("paramValue");///home/ats/atsxls/YYYYMMDD/ATS_CJ_ZQXX_YYYYMMDD.XLS
			filedir = filedir.replaceAll(Constan.PATH_FORMAT, replaceFileName);///home/ats/atsxls/20160927/ATS_CJ_ZQXX_20160927.XLS
			if(id!=null){
				File file=new File(filedir);//\home\ats\atsxls\20160927\ATS_CJ_ZQXX_20160927.XLS
				File parentFile = file.getParentFile();//\home\ats\atsxls\20160927
				if(!parentFile.exists()){
					parentFile.mkdirs();//创建20160927
					//创建YYYYMMDD目录
					//FileUtil.mkDir(parentFile.getPath());
				}
				//filedir = filedir.replaceAll(replaceFileName, replaceFileName+"/");///home/ats/atsxls/YYYYMMDD/export/ATS_CJ_ZQXX_YYYYMMDD.XLS
			}
			
			//filedir = filedir.replaceAll(Constan.PATH_FORMAT, replaceFileName);///home/ats/atsxls/20160923/export/ATS_CJ_ZQXX_20160923.XLS
			
			File file=new File(filedir);
			File parentFile = file.getParentFile();//\home\ats\atsxls\20160927\export
			//是否增量写Excel
			//boolean flag = true;
			if(!parentFile.exists()){
				parentFile.mkdirs();//创建完整记录
				//创建YYYYMMDD目录
				//FileUtil.mkDir(parentFile.getPath());
			}
				
			//如果文件存在，就删掉该文件
			if(file.isFile() && file.exists()){
				file.delete();
			}
		}else{//导出新债
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
			  filedir=tempDir+generateOutputExcelFile(filename);
		}
		
		//模板文件目录
		String templateFile=templateDir+filename;
		ExcelTemplate template=new ExcelTemplate(templateFile,filedir,false);
		template.setAutoPagination(autoPagination);
		template.setAutoSheet(autoSheet);
		int excelExportMaxnumInt = 0;
		try{
			excelExportMaxnumInt = Integer.parseInt(excelExportMaxnum);
		}catch (Exception e){
			e.printStackTrace();
		}
		template.setMaxRow(excelExportMaxnumInt);
		template.generate(Arrays.asList(exportObjects),exportInfo);//写数据

		return filedir;
	}

	/**
	 * 生成EXCEL输出文件，默认带时间戳
	 * @param templateFilename 文件名
	 * @return
	 */
	private static String generateOutputExcelFile(String templateFilename){
		String filename=templateFilename;
		if(templateFilename.endsWith(".xls")){
			filename=templateFilename.substring(0,templateFilename.length()-4);
		}

		SimpleDateFormat format=new SimpleDateFormat("yyyyMMddHHmmss");
		String datetimeString=format.format(new Date());

		filename=filename+"_"+datetimeString+".xls";
		return filename;
	}
	
	@Bizlet()
	public static String createDirName(String userId){
		SimpleDateFormat format=new SimpleDateFormat("yyyyMMddHHmmss");
		String datetimeString=format.format(new Date());
		return datetimeString+"_"+userId;
	}
	
}
