/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

import com.cjhxfund.ats.fm.comm.commonUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.system.utility.impl.Base64;

import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-03 16:21:42
 *
 */
@Bizlet("")
public class FileDownload {

	/**
	 * @param request
	 * @param response
	 * @author CJ-WB-DT13
	 */
	@Bizlet("多个附件下载")
	public static void downloadFiles(HttpServletRequest request,
			HttpServletResponse response,DataObject[] objs , String workItemName) throws  IOException{
		request.setCharacterEncoding("UTF-8");
       
       List<File> files = new ArrayList<File>();
       List<String> fileNames = new ArrayList<String>();
       
       //组装附件路径与附件名称集合
       for(DataObject ele : objs)
       {
          String filePath = ele.getString("vcAttachAdd");
          File file = new File(filePath);
          files.add(file);
          fileNames.add(ele.getString("vcAttachName"));
       }
       
       //生产压缩文件名称
       String fileName = workItemName + ".zip";
       //String fileName = UUID.randomUUID().toString() + ".zip";
       //在服务器端创建打包下载的临时文件
       String outFilePath = ProductUtil.UPLOAD_FILE_PATH_LIUCHENG + File.separator + fileName;
       File file = new File(outFilePath);
       
       //判断文件夹是否存在，不存在创建文件夹
       if(!file.exists() && !file.isDirectory()){
       	new File(ProductUtil.UPLOAD_FILE_PATH_LIUCHENG + File.separator).mkdirs();
       }
       //判断文件是否存在，不存在就创建文件夹
       if(!file.exists())    
       {     
          file.createNewFile();    
       }
       
       //文件输出流
       FileOutputStream outStream = new FileOutputStream(file);
       //压缩流
       ZipOutputStream toClient = new ZipOutputStream(outStream);
       toClient.setEncoding("gbk");
       //生产压缩文件并写到相应文件夹下
       zipFile(files, toClient,fileNames);
       toClient.close();
       outStream.close();
       //导出附件
       downloadZip(file, response, request);
	}
	
	/**
	 * @param request
	 * @param response
	 * @author CJ-WB-DT13
	 */
	@Bizlet("多个附件下载")
	public static void downloadFiles(HttpServletRequest request,
			HttpServletResponse response,List<String> list) throws  IOException{
		request.setCharacterEncoding("UTF-8");
       
       List<File> files = new ArrayList<File>();
       List<String> fileNames = new ArrayList<String>();
       
       //组装附件路径与附件名称集合
       for(int i=0;i<list.size();i++)
       {
          String filePath = list.get(i).substring(0, list.get(i).indexOf(","));
          File file = new File(filePath);
          files.add(file);
          String filename = list.get(i).substring(list.get(i).indexOf(",")+1, list.get(i).length());
          fileNames.add(filename);
       }
       
       Date createDate = new Date();
       SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
       String dateString = formatter.format(createDate);
       //生产压缩文件名称
       String fileName = dateString + "估值表.zip";
       //String fileName = UUID.randomUUID().toString() + ".zip";
       //在服务器端创建打包下载的临时文件
       String outFilePath = ProductUtil.UPLOAD_FILE_PATH_GZBEXCL + File.separator + fileName;
       File file = new File(outFilePath);
       
       //判断文件夹是否存在，不存在创建文件夹
       if(!file.exists() && !file.isDirectory()){
       	new File(ProductUtil.UPLOAD_FILE_PATH_GZBEXCL + File.separator).mkdirs();
       }
       //判断文件是否存在，不存在就创建文件夹
       if(!file.exists())    
       {     
          file.createNewFile();    
       }
       
       //文件输出流
       FileOutputStream outStream = new FileOutputStream(file);
       //压缩流
       ZipOutputStream toClient = new ZipOutputStream(outStream);
       toClient.setEncoding("gbk");
       //生产压缩文件并写到相应文件夹下
       zipFile(files, toClient,fileNames);
       toClient.close();
       outStream.close();
       //导出附件
       downloadZip(file, response, request);
	}

	/**
	 * @param inputFile
	 * @author CJ-WB-DT13
	 * @throws IOException 
	 */
	@Bizlet("生成压缩文件")
	public static void zipFile(File inputFile,ZipOutputStream outputStream,String fileName) throws IOException {
		try{
			//判断文件是否存在
            if(inputFile.exists())
            {
            	//检查路径名下的文件是否是一个正常的文件
               if(inputFile.isFile())
               {
                  FileInputStream inStream = new FileInputStream(inputFile);
                  BufferedInputStream bInStream = new BufferedInputStream(inStream);
                  //给附件设置名称
                  ZipEntry entry = new ZipEntry(fileName);
                  outputStream.putNextEntry(entry);
                   
                  final int MAX_BYTE = 10 * 1024 *1024;    //最大的流为10M
                  long streamTotal = 0;                      //接受流的容量
                  int streamNum = 0;                      //流需要分开的数量
                  int leaveByte = 0;                      //文件剩下的字符数
                  byte[] inOutbyte;                          //byte数组接受文件的数据
                  
                  streamTotal = bInStream.available();                        //通过available方法取得流的最大字符数
                  streamNum = (int)Math.floor(streamTotal / MAX_BYTE);    //取得流文件需要分开的数量
                  leaveByte = (int)streamTotal % MAX_BYTE;                //分开文件之后,剩余的数量
                  
                  if (streamNum > 0) 
                  {
                      for(int j = 0; j < streamNum; ++j)
                      {
                          inOutbyte = new byte[MAX_BYTE];
                          //读入流,保存在byte数组
                          bInStream.read(inOutbyte, 0, MAX_BYTE);
                          outputStream.write(inOutbyte, 0, MAX_BYTE);  //写出流
                       }
                  }
                  //写出剩下的流数据
                  inOutbyte = new byte[leaveByte];
                  bInStream.read(inOutbyte, 0, leaveByte);
                  outputStream.write(inOutbyte);
                  outputStream.closeEntry();     //关闭当前压缩入口和位置，以编写下一个输入流
                  bInStream.close();    //关闭
                  inStream.close();
             }
          }
          else
          {
              try {
				throw new ServletException("文件不存在！");
			} catch (ServletException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
          }
      }
      catch(IOException e)
      {
          throw e;
      }
	}

	/**
	 * @param files
	 * @author CJ-WB-DT13
	 */
	@Bizlet("压缩附件中的文件大小")
	public static void zipFile(List<File> files,ZipOutputStream outputStream,List<String> fileNames) throws IOException {
		int size = files.size();
		  //压缩列表中的文件
		  for(int i = 0; i < size; i++)
		  {
		      File file = (File) files.get(i);
		      String fileName = fileNames.get(i);
		      zipFile(file, outputStream,fileName);
		   }
	}

	/**
	 * @param file
	 * @param response
	 * @author CJ-WB-DT13
	 */
	@Bizlet("导出附件")
	public static void downloadZip(File file, HttpServletResponse response,HttpServletRequest request) {
		BufferedInputStream fis = null;
		try {
           // 以流的形式下载文件。
           fis = new BufferedInputStream(new FileInputStream(file.getPath()));
           byte[] buffer = new byte[fis.available()];
           fis.read(buffer);
           // 清空response
           response.reset();
           OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
           response.setContentType("application/octet-stream");
           
           response.setHeader("Content-Disposition", "attachment; filename=" + encodeChineseDownloadFileName(request, file.getName()));
           
           //response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(file.getName(),"utf-8"));
           toClient.write(buffer);
           toClient.flush();
           toClient.close();
           file.delete();        //将生成的服务器端文件删除
        } 
        catch (IOException ex) {
           ex.printStackTrace();
       }finally{
    	   try {
			fis.close();
			
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
       }
	}
	/**
	 * 解决IE 、frreFox、chrome导出文件名兼容问题（杨敏）
	 * @param request
	 * @param pFileName
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@Bizlet("")
	public static String encodeChineseDownloadFileName(HttpServletRequest request, String pFileName) throws UnsupportedEncodingException {
		String filename = null;
		String agent = request.getHeader("USER-AGENT");
		if (null != agent){
			if (-1 != agent.indexOf("Firefox")) {//Firefox
				filename = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(pFileName.getBytes("UTF-8"))))+ "?=";
			}else if (-1 != agent.indexOf("Chrome")) {//Chrome
				filename = new String(pFileName.getBytes(), "ISO8859-1");
			} else {//IE7+
				filename = java.net.URLEncoder.encode(pFileName, "UTF-8");
				filename = StringUtils.replace(filename, "+", "%20");//替换空格
			}
		} else {
			filename = pFileName;
		}
		return filename;
    }
	/**
	 * 单个附件下载
	 * @param path  文件路径
	 * @param fileName  文件名称
	 * @param response
	 * @param request
	 * @return
	 */
	@Bizlet("")
	public static HttpServletResponse SingleFileDownload(String path,String fileName, HttpServletResponse response,HttpServletRequest request) {
		BufferedInputStream fis = null;
		OutputStream toClient = null;
		try {
            // 以流的形式下载文件。
            fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer); 
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.setContentType("application/octet-stream");
            
            response.setHeader("Content-Disposition", "attachment; filename=" + encodeChineseDownloadFileName(request, fileName));
            
            //response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName,"utf-8"));
           
            toClient = new BufferedOutputStream(response.getOutputStream());
            toClient.write(buffer);
        } catch (IOException ex) {
        	try {
        		fis.close();
				toClient.close();
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
            ex.printStackTrace();
        }finally{
        	try {
				fis.close();
				toClient.flush();
				toClient.close();
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
        }
        return response;
    }

}
