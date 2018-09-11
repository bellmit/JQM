/**
 * 
 */
package com.cjhxfund.jy.process;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

import com.cjhxfund.jy.ProductProcess.ProductProcessUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-03 16:21:42
 *
 */
@Bizlet("")
public class FileDownload {
	/**
	 * 解决IE 、frreFox、chrome导出文件名兼容问题
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
	 * @param request
	 * @param response
	 * @author CJ-WB-DT13
	 */
	@Bizlet("")
	public static void downloadFiles(HttpServletRequest request,
			HttpServletResponse response,DataObject[] objs , String workItemName) throws  IOException{
		request.setCharacterEncoding("UTF-8");
       
       List<File> files = new ArrayList<File>();
       List<String> fileNames = new ArrayList<String>();

       for(DataObject ele : objs)
       {
          String filePath = ele.getString("attachAdd");
          File file = new File(filePath);
          files.add(file);
          fileNames.add(ele.getString("attachName"));
       }
       String fileName = workItemName + ".zip";
       //String fileName = UUID.randomUUID().toString() + ".zip";
       //在服务器端创建打包下载的临时文件
       String outFilePath = ProductProcessUtil.UPLOAD_FILE_PATH_LIUCHENG + File.separator + fileName;
       File file = new File(outFilePath);
       //文件输出流
       FileOutputStream outStream = new FileOutputStream(file);
       //压缩流
       ZipOutputStream toClient = new ZipOutputStream(outStream);
       toClient.setEncoding("gbk");
       zipFile(files, toClient,fileNames);
       toClient.close();
       outStream.close();
       downloadZip(file, response);
	}

	/**
	 * @param inputFile
	 * @author CJ-WB-DT13
	 * @throws IOException 
	 */
	@Bizlet("")
	public static void zipFile(File inputFile,ZipOutputStream outputStream,String fileName) throws IOException {
		try{
            if(inputFile.exists())
            {
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
	@Bizlet("")
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
	@Bizlet("")
	public static void downloadZip(File file, HttpServletResponse response) {
		BufferedInputStream fis = null;
		try {
           // 以流的形式下载文件。
           fis = new BufferedInputStream(new FileInputStream(file.getPath()));
           byte[] buffer = new byte[fis.available()];
           fis.read(buffer);
           // 清空response
           response.reset();
   System.out.println(file.getName());
          OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
           response.setContentType("application/octet-stream");
           response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(file.getName(),"utf-8"));
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
	
	@Bizlet("")
	public static HttpServletResponse SingleFileDownload(String path,String fileName, HttpServletResponse response) {
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
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName,"utf-8"));
            //response.addHeader("Content-Length", "" + file.length());
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
	
	@Bizlet("")
	public static HttpServletResponse SingleFileDownload(String path,String fileName,HttpServletRequest request,HttpServletResponse response) {
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
            //response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName,"utf-8"));
            response.setHeader("Content-Disposition", "attachment; filename=" + encodeChineseDownloadFileName(request, fileName));
            //response.addHeader("Content-Length", "" + file.length());
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
	/*public static byte[] getByte(String name){
		ByteArrayOutputStream toClient = null;
		try {
			FileInputStream is = new FileInputStream(new File(name));
			toClient = new ByteArrayOutputStream();
			 byte[] buffer = new byte[1024 * 1024 * 4];   
             int i = -1;   
             while ((i = is.read(buffer)) != -1) {   
                 toClient.write(buffer, 0, i);  
                 
             }   
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return toClient.toByteArray();
	}*/

}
