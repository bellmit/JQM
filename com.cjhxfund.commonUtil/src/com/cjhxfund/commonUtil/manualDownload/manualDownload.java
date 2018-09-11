/**
 * 
 */
package com.cjhxfund.commonUtil.manualDownload;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-03 16:21:42
 *
 */
@Bizlet("")
public class manualDownload {
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
	 * 操作手册下载
	 * @param path  文件路径
	 * @param fileName  文件名称
	 * @param response
	 * @param request
	 * @return
	 */
	@Bizlet("")
	public static HttpServletResponse manualFileDownload(HttpServletResponse response,HttpServletRequest request,String userType,String vcManualName) {
		BufferedInputStream fis = null;
		OutputStream toClient = null;
		
        String Path  = ApplicationContext.getInstance().getApplicationUserWorkingPath()+"/com.cjhxfund.commonUtil/META-INF/manual";
 
        //String fileName = getFile(Path,0,userType); 
        Path = Path + "/" + vcManualName;
        
		try {
            // 以流的形式下载文件。
            fis = new BufferedInputStream(new FileInputStream(Path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer); 
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.setContentType("application/octet-stream");
            
            response.setHeader("Content-Disposition", "attachment; filename=" + encodeChineseDownloadFileName(request, vcManualName));
            
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

	private static String getFile(String path, int deep, String userType) {
		//文件名称
		String fName = "";
		String name = "";
		//获得指定文件对象
		File file = new File(path);
		//获得该文件夹内的所有文件
		File[] array = file.listFiles();
		for(int a = 0;a<array.length;a++){
			if (array[a].isFile()){// 如果是文件
				//截取名字
				name = array[a].getName();
				
				if("2".equals(userType)){//如果是投顾权限,下载普通手册
					if(!"内部版".equals(name.substring(13,16))){
						fName = name;
					}
				}
				if("1".equals(userType)){//如果是内部员工，下载内部操作手册
					if("内部版".equals(name.substring(13,16))){
						fName = name;
					}
				}
			}
		}
		return fName;
	}
} 
