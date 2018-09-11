<!-- 
  - Author(s): 石浩
  - Date: 2016-08-19 
  - Description: 导出032新债信息
-->
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.cjhxfund.ats.fm.comm.ProductUtil"%>
<%@page import="org.apache.tools.zip.ZipOutputStream"%>
<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="java.io.*"%>
<%@page import="com.eos.web.taglib.util.*" %><%
   //获取标签中使用的国际化资源信息
    String fileNotExist=com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_fileNotExist");
    Object root= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext);
    //String localFile=(String)XpathUtil.getObjectByXpath(root,"downloadFile");
    Map<String,String> map=(HashMap)XpathUtil.getObjectByXpath(root,"fileMap");
    
    List<File> files = new ArrayList<File>();
    List<String> fileNames = new ArrayList<String>();
    Iterator iterator = map.keySet().iterator();
    while(iterator.hasNext()){
       String key = (String)iterator.next();
       String value = map.get(key);
       if(value.endsWith(".XLS")){
       		File file =  new File(value);
       		files.add(file);
       		fileNames.add(file.getName());
       }
    }
    String fileName = "导出到O32Excel.zip";
    String outFilePath = ProductUtil.UPLOAD_FILE_PATH_LIUCHENG + File.separator + fileName;///home/ats/FileUploadPath/fm/LiuCheng\\导出到O32Excel.zip
    File file = new File(outFilePath);
    //文件输出流
    FileOutputStream outStream = new FileOutputStream(file);
    //压缩流
    ZipOutputStream toClient = new ZipOutputStream(outStream);
    toClient.setEncoding("gbk");
    FileDownload.zipFile(files, toClient,fileNames);
    toClient.close();
    outStream.close();
    FileDownload.downloadZip(file, response, request);
    //file.delete();
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		System.out.print("应用服务器为：tomcat");
		out.clear();
		out = pageContext.pushBody();
		
	}else if("weblogic".equals(serverId)){

	}else{

	}
%>