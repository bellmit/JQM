package com.cjhxfund.jy.excelUploadAdd;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import com.eos.system.annotation.Bizlet;
import com.primeton.ext.access.http.UploadFile;

/**
 * @author zhanglu
 * @date 2017-05-17 16:21:42
 *
 */
@Bizlet("")
public class MomUploalFild {
	
	/**
	 * Excel下载
	 * @param path  文件路径
	 * @param fileName  文件名称
	 * @return
	 */
	@Bizlet("")
	public static HashMap<String, Object> FileNameToMap(UploadFile file) {
		String prodcode = "";
		String busdate = "";
		String prodname = "";
		int index = 0;
		Date date = null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			String filename =  file.getClientPath();
			filename = filename.substring(0,filename.lastIndexOf('.'));
			index = filename.length()-9;
			prodcode = filename.substring(index,index+6);
			index = filename.length()-20;
			busdate = filename.substring(index,index+11);
			prodname = filename.substring(0,index);
			busdate = busdate.replace("年","");
			busdate = busdate.replace("月","");
			busdate = busdate.replace("日","");
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
			date=sdf.parse(busdate);
			map.put("prodcode",prodcode);
			map.put("prodname",prodname);
			map.put("busdate",date);		
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		return map;
	}
	public static void main(String[] args) {
		String s = "建信基金2017年05月15日JX0344估值表";
		String prodcode = s.substring(15,21);
		System.out.println(prodcode);
	}
}
