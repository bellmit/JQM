<%@page import="com.cjhxfund.ats.fm.comm.FileDownload"%>
<%@page import="com.eos.foundation.common.utils.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="org.apache.tools.zip.ZipOutputStream"%>
<%@page import="org.apache.tools.zip.ZipEntry"%>
<%@page import="org.apache.tools.ant.taskdefs.Zip"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="java.io.*"%>
<%
      String   filename   =(String)request.getParameter("filename");  //文件名称
      if(filename==null||"".equals(filename)) filename = (String)request.getAttribute("filename");
      String   filepath   =  (String)request.getParameter("filepath");//文件在服务器上的路径
      if(filepath==null||"".equals(filepath)) filepath = (String)request.getAttribute("filepath");
      String  fileNameZip = (String)request.getParameter("fileNameZip")+".zip"; //压缩文件名字 
	  String[] filepaths =filepath.split(",");  //字符串分割成数组
	  String[] filenames =filename.split(",");
	  ZipOutputStream zos=null;
	  ServletOutputStream os=null;
	  if(filepaths.length>1){  //多文件下载时
		  try {     
		   byte[] buffer = new byte[2048]; 
		   int size = 0; 
		   response.reset();
		   out.clear();
	       out = pageContext.pushBody();
		   response.setContentType("application/octet-stream");
	 	   response.setHeader("Content-disposition", "attachment;filename=\""+ java.net.URLEncoder.encode(fileNameZip,"UTF-8")+ "\"");
		   InputStream is = null;
		     os = response.getOutputStream();
		     zos=new ZipOutputStream(os);
		     zos.setLevel(1);
		     zos.setEncoding("GBK");
		      //循环获取文件名与路径压缩
		     for(int i=0;i<filepaths.length;i++){
		         String FilePath=filepaths[i];
		         String FileName=filenames[i];
		         File f=new File(FilePath);
		         ZipEntry ze=new ZipEntry(FileName);
		         ze.setSize(f.length());
		         ze.setTime(f.lastModified());
		         zos.putNextEntry(ze);
		        
		         is=new BufferedInputStream(new FileInputStream(f));
		         while ((size = is.read(buffer,0,2048)) != -1) { 
			     zos.write(buffer, 0, size); 
			     }
			     is.close();
			     zos.closeEntry();
			     if(is!=null)is.close();
		     } 
	  	   } catch(Exception e) {
	          e.printStackTrace();
	       } finally {
	            try {
	             if(zos!=null)zos.close();
			     if(os!=null)os.close();
			   } catch (IOException e) {
			     e.printStackTrace();
			   }
	       }}
      else{  //单文件下载时
	      byte[] buffer = new byte[2048]; 
		  int size = 0; 
		  String singleFilename = FileDownload.encodeChineseDownloadFileName(request, filenames[0]);
		  String singleFilepath = filepaths[0];
		  response.reset();
		  response.setContentType("application/octet-stream");
	 	  //response.setHeader("Content-disposition", "attachment;filename=\""+ java.net.URLEncoder.encode(singleFilename,"UTF-8") + "\"");
	 	  response.setHeader("Content-disposition", "attachment;filename=\""+ singleFilename + "\"");
		  FileInputStream in = null;
		  try {
		     os = response.getOutputStream();
		     File downloadFile=new File(singleFilepath);
		     if(downloadFile!=null&&downloadFile.exists()){
			     in = new FileInputStream(new File(singleFilepath));
			     while ((size = in.read(buffer)) != -1) { 
			       os.write(buffer, 0, size); 
			     }
			    out.clear();
	         	out = pageContext.pushBody();
		     }else{
		        out.print("文件不存在！"); 
		     }
	  	  } catch(Exception e) {
	          e.printStackTrace();
	      } finally {
	      	  try {
	             if(in!=null)in.close();
			     if(os!=null)os.close();
			  } catch (IOException e) {
			     e.printStackTrace();
			  }
	      }
	  }
%>