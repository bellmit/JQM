<!-- 
  - Author(s): 石浩
  - Date: 2016-08-19 
  - Description: 导出新债信息
-->
<%@page pageEncoding="UTF-8"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="java.io.*"%>
<%@page import="com.primeton.system.utility.impl.Base64"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.eos.web.taglib.util.*" %><%
   //获取标签中使用的国际化资源信息
   String fileNotExist=com.eos.foundation.eoscommon.ResourcesMessageUtil.getI18nResourceMessage("l_fileNotExist");
   Object root= com.eos.web.taglib.util.XpathUtil.getDataContextRoot("request", pageContext);
   String localFile=(String)XpathUtil.getObjectByXpath(root,"downloadFile");
   byte[] buffer = new byte[512];
   String fileName = (String)XpathUtil.getObjectByXpath(root,"fileName");//"新债信息.xls";
   int size = 0;
   
   FileDownload.SingleFileDownload(localFile,fileName,response,request);
   
   //根据应用服务器类型，关闭输出流
	//1、获取应用服务器类型
	String serverId=com.cjhxfund.commonUtil.ServerDetector.getServerId();
	//判定和关闭流
	if("tomcat".equals(serverId) || "-tomcat".equals(serverId)){
		out.clear();
		out = pageContext.pushBody();
	}else if("weblogic".equals(serverId)){
		
	}
   
   /* response.reset();
   response.setContentType("application/vnd.ms-excel");
   //response.setHeader("Content-disposition", "attachment;filename=\""+ java.net.URLEncoder.encode("新债信息.xls","UTF-8") + "\"");
   //兼容火狐浏览器乱码问题
   String agent = (String)request.getHeader("USER-AGENT");  //获取 浏览器类型   
   if(agent != null && agent.indexOf("MSIE") == -1) {// FF 判断流浏览器为火狐      
       String enableFileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";    
       response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);    
   } else { // IE      
       response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName,"utf-8"));    
   }  
   
   ServletOutputStream os = null;
   FileInputStream in = null;
   try {
      os = response.getOutputStream();
      File downloadFile=new File(localFile);
      if(downloadFile!=null&&downloadFile.exists()){
       in = new FileInputStream(new File(localFile));
       while ((size = in.read(buffer)) != -1) {
         os.write(buffer, 0, size);
       }
        out.clear();
        out = pageContext.pushBody();
      }else{
         out.print(fileNotExist); //"文件不存在！"
      }
      } catch(Exception e) {
          e.printStackTrace();
       } finally {
            try {
             if(in!=null)in.close();
       if(os!=null)os.close();
       File file=new File(localFile);
       if (file!=null&&file.isFile()&&file.exists()) {
         file.delete();
       }
     } catch (IOException e) {
       e.printStackTrace();
     }
       } */
%>