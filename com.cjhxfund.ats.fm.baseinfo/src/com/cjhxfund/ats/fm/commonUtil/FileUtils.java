/**
 * 
 */
package com.cjhxfund.ats.fm.commonUtil;

import java.io.File;
import com.eos.system.annotation.Bizlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import commonj.sdo.DataObject;

/**
 * @author 翟静
 * @date 2016-12-02 14:48:41
 *
 */
@Bizlet("downLoadFile")
public class FileUtils {
	 HttpServletResponse response;
	 HttpServletRequest request;
	@Bizlet
	public  boolean fileTure(DataObject[] objs){
		boolean isExits = true;
		//单个下载
		if(objs.length == 1){//判断文件是否存在。
			  //获取要下载文件的地址
			  String address = objs[0].getString("vcAttachAdd");
				File file = new File(address);
				if(!file.exists()){
			        //FileDownload.SingleFileDownload(objs[0].getString("vcAttachAdd"), objs[0].getString("vcAttachName"), response, request);
					isExits = false;
			   }
		}else{//批量下载,判断文件是否存在。
			//FileDownload.downloadFiles(request, response, objs , "附件信息管理");
			for(int i=0;i<objs.length;i++){
				String addressList = objs[i].getString("vcAttachAdd");
				File file = new File(addressList);
				if(!file.exists()){
					isExits = false;
				}
			}
		}
			return isExits;	
	}
    }
