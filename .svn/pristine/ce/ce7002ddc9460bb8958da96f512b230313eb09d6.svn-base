package com.cjhxfund.fpm.bpsExpend;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import msnc.com.cn.util.HttpConnectionUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.das.entity.criteria.ExprType;
import com.eos.das.entity.criteria.impl.CriteriaTypeImpl;
import com.eos.das.entity.criteria.impl.ExprTypeImpl;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

@Bizlet("")
public class MailMNC {
		
		private static Logger log = Logger.getLogger(MailMNC.class);
		//测试环境同步发送
		public static final String TestSyn = "http://10.201.235.11:8080/msnc/interface/email/sendMail";
		//测试环境异步发送
		public static final String TestAsyn = "http://10.201.235.11:8080/msnc/interface/email/asyncSendMail";
		//测试环境同步发送
		public static final String Syn = "http://10.201.9.39:8080/msnc/interface/email/sendMail";
		//测试环境异步发送
		public static final String Asyn = "http://10.201.9.39:8080/msnc/interface/email/asyncSendMail";
		
		@Bizlet("调用消息中心接口发送邮件")
		public void SendMail(DataObject sendEmailInfo,String URL) throws IOException{
			
			JSONObject json = new JSONObject();
			//邮件信息
			String seenumber = sendEmailInfo.getString("seenumber");
			String fromuser = sendEmailInfo.getString("fromuser");
			String fromsystem = sendEmailInfo.getString("fromsystem");
			String fromsystemid = sendEmailInfo.getString("fromsystemid");
			String modelcode = sendEmailInfo.getString("modelcode");
			String to = sendEmailInfo.getString("to");
			String cc = sendEmailInfo.getString("cc");
			String subject = sendEmailInfo.getString("subject");
			String filename = sendEmailInfo.getString("filename");
			String filepath = sendEmailInfo.getString("filepath");
			String contentStr = sendEmailInfo.getString("mailContent");
			if(seenumber != null)
				json.put("seenumber", seenumber);
			if(fromuser != null)
				json.put("fromuser", fromuser);
			if(fromsystem != null)
				json.put("fromsystem", fromsystem);
			if(fromsystemid != null)
				json.put("fromsystemid", fromsystemid);
			JSONObject body = new JSONObject();
			if(modelcode != null)
				body.put("modelcode", modelcode);
			if(to != null)
				body.put("to", to);
			if(cc != null)
				body.put("cc", cc);
			if(subject != null)
				body.put("subject", subject);
			if(filename != null)
				body.put("filename", filename);
			if(filepath != null)
				body.put("filepath", filepath);
			JSONObject content = new JSONObject();
			
			//邮件内容
			if(contentStr == null || contentStr == ""){
				String modePara = sendEmailInfo.getString("modePara");
				String[] paras = modePara.split(";");
				for(int i=0;i<paras.length;i++){
					String para = sendEmailInfo.getString(paras[i]);;
					content.put(paras[i], para);
				}
				body.put("content", content);
			}
			else{
				body.put("content", contentStr);
			}
			json.put("body", body);
//			System.out.println("json: " + json.toString());
			
			//发送邮件
			JSONObject respond = HttpConnectionUtil.post(URL,json);				
//			System.out.println("respond:" + respond.toString());
			log.info("respond: "+respond.toString());
			
			
		}
		
		@Bizlet("下载文件")
		 public File downLoadFromUrl(String urlStr,String fileName,String savePath) throws IOException{
		        URL url = new URL(urlStr);  
		        HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
		        //设置超时间为3秒
		        conn.setConnectTimeout(3*1000);
		        //防止屏蔽程序抓取
		        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

		        //得到输入流
		        InputStream inputStream = conn.getInputStream();  
		        //获取自己数组
		        byte[] buffer = new byte[1024];  
		        int len = 0;  
		        ByteArrayOutputStream bos = new ByteArrayOutputStream();  
		        while((len = inputStream.read(buffer)) != -1) {
		        	System.out.println(buffer.toString());
		            bos.write(buffer, 0, len);  
		        }  
		        bos.close();
		        byte[] getData = bos.toByteArray();
		        System.out.println(getData.length);

		        //文件保存位置
		        File saveDir = new File(savePath);
		        if(!saveDir.exists()){
		            saveDir.mkdir();
		        }
		        File file = new File(saveDir+File.separator+fileName);    
		        FileOutputStream fos = new FileOutputStream(file);     
		        fos.write(getData); 
		        if(fos!=null){
		            fos.close();  
		        }
		        if(inputStream!=null){
		            inputStream.close();
		        }


		        System.out.println("info:"+url+" download success");
		        return file;

		    }
			
			@Bizlet("上传文件")
			public String uploadFiles(String filePaths,String url) throws Exception{
				
//				String  url="http://10.201.235.11:8080/msnc/file/uploadfiles";
				String title = url.split("msnc")[0];
				String realUrl = title + "msnc/file/uploadfiles";
				String systemid="msnc";
//				String  filepath1="D:/primeton/ide/eclipse/documents/2017/09/20170905141106348.docx";
//				String filepath2="D:/primeton/ide/eclipse/documents/2017/09/20170905141245965.xlsx";
//				File f1=new File(filepath1);
//				File f2=new File(filepath2);
//				File[] files=new File[]{f1,f2};
				String[] absolutePaths = filePaths.split(";");
				int length = absolutePaths.length;
				File[] files=new File[length];
				for(int i=0;i<length;i++){
					files[i] = new File(absolutePaths[i]);
				}
				JSONObject  json = (JSONObject) HttpConnectionUtil.upload(realUrl,files,systemid);
				String paths = "";
				JSONArray returnFiles = json.getJSONArray("files");
				for(int i=0;i<returnFiles.size();i++){
					paths +=returnFiles.getJSONObject(i).getString("location");
					if(i != returnFiles.size()-1)
						paths += ";";
				}
				return paths;
			}
		 	
			@Bizlet("获取邮件发送附件信息")
			public String[] getFileInfos(String fileCatalogue) throws Exception{
								
				CriteriaType criteria = new CriteriaTypeImpl();
				List<ExprType> exprTypes = new ArrayList<ExprType>();
				criteria.set_entity("com.cjhxfund.fpm.bpsExpend.task.PmSortFile");			
				ExprType exprType = new ExprTypeImpl();
				exprType.set_op("=");
				exprType.set("fileCatalogueId", Integer.parseInt(fileCatalogue));				
				exprTypes.add(exprType);
				ExprType exprType1 = new ExprTypeImpl();
				exprType1.set_op("=");
				exprType1.set("isEffective", 1);				
				exprTypes.add(exprType1);
				criteria.set_expr(exprTypes);
				DataObject[] files = DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteria);
				
				/*CriteriaType criteria1 = new CriteriaTypeImpl();
				List<ExprType> exprTypes1 = new ArrayList<ExprType>();
				criteria1.set_entity("com.cjhxfund.fpm.bpsExpend.task.ZhfwptParamConf");			
				ExprType exprType2 = new ExprTypeImpl();
				exprType2.set_op("=");
				exprType2.set("param_type", "mncMail");				
				exprTypes.add(exprType2);
				ExprType exprType3 = new ExprTypeImpl();
				exprType3.set_op("=");
				exprType3.set("param_name", "absoluteFile");				
				exprTypes1.add(exprType3);
				criteria.set_expr(exprTypes1);
				DataObject[] absolute = DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteria1);
				String absolutePath = absolute[0].getString("param_value");*/
				
				int length = files.length;
				String[] absolutePaths = new String[length];
				String filePaths = "";
				String fileNames = "";
				String[] res = new String[2];
				for(int i=0;i<length;i++){
					fileNames += files[i].getString("fileName");
					if(i != length-1){
						fileNames += ";";
					}
//					filePaths += absolutePath + files[i].getString("filePath");
					filePaths += files[i].getString("filePath");
					if(i != length-1){
						filePaths += ";";
					}
//					absolutePaths[i] = "D:/primeton/ide/eclipse/" + relativePath;
				}
				//filePaths = uploadFiles(absolutePaths,url);
				res[0] = fileNames;
				res[1] = filePaths;
				return res;
			}
			
			@Bizlet("邮件信息赋值")
			public DataObject[] getMailDatas(DataObject[] processMails){
				
				int size = processMails.length;
				DataObject[] mailDatas = new DataObject[size];
				for(int i=0;i<size;i++){
					DataObject mailData = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.MailData");
					String fromuser = processMails[i].getString("fromUser");
					String sendto = processMails[i].getString("sendto");
					String sendcc = processMails[i].getString("sendcc");
					String subject = processMails[i].getString("subject");
					String fromSystemid = processMails[i].getString("fromSystemid");
					String modelCode = processMails[i].getString("modelCode");
					String fileCatalogue = processMails[i].getString("fileCatalogue");
					mailData.set("fromuser",fromuser);
					mailData.set("to",sendto);
					mailData.set("cc",sendcc);
					mailData.set("subject",subject);
					mailData.set("fromsystemid",fromSystemid);
					mailData.set("modelcode",modelCode);
					mailData.set("fileCatalogue",fileCatalogue);				
					mailDatas[i] = mailData;
				}
				return mailDatas;
				
			}
			
			@Bizlet("获取下一项活动名")
			public String getNextActivities(DataObject[] nextWorkItems){
				
				int size = nextWorkItems.length;
				Set<String> activities = new HashSet<String>();
				String activityName = "";
				for(int i=0;i<size;i++){
					String name = nextWorkItems[i].getString("activityInstName");
					activities.add(name);
				}
				Iterator<String> it = activities.iterator();
				while(it.hasNext()){
					String an = it.next();
					activityName += an + ";";
				}
				if(activityName.length()>0)
					activityName = activityName.substring(0, activityName.length()-1);
				else
					activityName = null;
				return activityName;
				
			}
			
			@Bizlet("设置邮件模板参数")
			public DataObject setModePara(DataObject mailData,Map<String,String> map,String url) throws Exception{
				
				Iterator<String> keys = map.keySet().iterator();
				String modePara = "";
				String to = mailData.getString("to");
				String cc = mailData.getString("cc");
				String fileName = mailData.getString("fileName");
				String filePath = mailData.getString("filePath");
				while(keys.hasNext()){
					String key = keys.next();
					String value = map.get(key);
					if(key.equals("to")){
						if(value!=null && !value.equals("")){
							if(to!=null && !to.equals(""))
								to += ";" + value;
							else
								to = value;
						}
					}
					else if(key.equals("cc")){
						if(value!=null && !value.equals("")){
							if(cc!=null && !cc.equals(""))
								cc += ";" + value;
							else
								cc = value;
						}
					}
					else if(key.equals("fileName")){
						fileName = value;
					}
					else if(key.equals("filePath")){
						filePath = value;
					}
					else{
						mailData.set(key,value);
						modePara +=  key + ";";
					}					
				}
												
				modePara = modePara.substring(0, modePara.length()-1);
				mailData.set("modePara",modePara);
				mailData.set("to",to);
				mailData.set("cc",cc);
				if(fileName!=null && !fileName.equals("")){
					mailData.set("filename",fileName);
				}
				if(filePath!=null && !filePath.equals("")){
//					filePath = "D:/primeton/ide/eclipse/files/0a7498c0-f085-4b71-8f19-14d277bd0343.docx";
					String newpaths = uploadFiles(filePath,url);
					mailData.set("filepath",newpaths);
				}
				return mailData;
				
			}
			
}
