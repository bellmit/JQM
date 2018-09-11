/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.cjhxfund.ats.fm.commonUtil.Constan;
import com.eos.foundation.common.utils.FileUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.CacheUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DatabaseExt;

import commonj.sdo.DataObject;

/**
 * @author chenpeng
 * @date 2016-05-27 09:37:40
 * 传真服务
 */
@Bizlet("")
public class EastFax {
	//转换日期格式为yyyyMMddHHmmss
	public static SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");	
	public static SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	/**
	 * @param 文件名称
	 * @param 传真号
	 * @param 提交打印的账号
	 * @author 陈鹏
	 */
	@Bizlet("发送传真文件")
	public static void sendFaxs(DataObject[] files,Map<String,String> maps,String userId) {
		// TODO 自动生成的方法存根
		String curTime = format.format(new Date());
		//生成10位随机数
		String randomNumber = "ATSFM" + curTime;
		DataObject config = (DataObject)CacheUtil.getValue(Constan.CACHE_NAME, "ATS_FAX_URL");//获取系统配置缓存的传真文件路径
		//循环附件列表
		for(int i = 0;i<files.length;i++){
 		   String attachAdd = files[i].getString("vcAttachAdd");
 		   
		   //获取新文件路径
		   String newFileName =config.getString("paramValue")  + files[i].getString("vcAttachName");//传真文件需要读取系统参数
		   
		   //复制要传真的文件到指定文件目录
		   //ProductProcessUtil.UPLOAD_FILE_PATH_CHUANZHEN
		   FileUtil.copyFile(attachAdd, newFileName);
		   //修改新文件名称
		   String attachName = files[i].getString("vcAttachName");
		   String Suffix = attachName.substring(attachName.indexOf("."), attachName.length());
		   FileUtil.renameFile(newFileName,randomNumber +"_" + (i +1) +Suffix);
		}
		
		String theme = maps.get("theme") == null ? "" : maps.get("theme");  //获取传真主题
		String faxComments = maps.get("faxComments") == null ? "测试" : maps.get("faxComments");  //传真备注
		DataObject account = (DataObject)CacheUtil.getValue(Constan.CACHE_NAME, "ATS_FAX_ACCOUNT");//获取系统配置缓存的传真用户名
		//组装epi文件参数
		StringBuffer sb =new StringBuffer();//ATS_FAX_ACCOUNT--ATS_FAX_ACCOUNT
		sb.append("[General]\n");
		sb.append("Account = " + account.getString("paramValue") + "\n");	                              
		sb.append("Subject = " + theme + "\n");
		sb.append("Comments = " + faxComments + "");
		sb.append("FaxFlowAccounts = " + "zhangfan > limo > wangyan" + "\n");
		sb.append("SerialNO = " + randomNumber + "\n");  //传真流水号
		sb.append("Priority = " + "1" + "\n"); //传真优先级， 0 低， 1 普通， 2 高，该配置生效的前提是账户具有“重要传真优先发送”的权限，默认为 1
		sb.append("EmailResult = " + "" + "\n");
		
		String[] FaxNumbers = maps.get("FaxNumber").split(",");		//分割传真号
		String[] recvNames = maps.get("recvName").split(",");		//分割接收人名称
		String recvCompanys = maps.get("recvCompany");  			//获取接收人公司名称
		String[] recvCompany = recvCompanys == null ? null : maps.get("recvCompany").split(",");	//分割接收人公司名称
		
		for(int k = 0;k < FaxNumbers.length; k++){
			sb.append("ReceiverNumber_" + (k + 1) + " = " + FaxNumbers[k] + "\n"); //设置接收人传真号
			sb.append("ReceiverName_" + (k + 1) + " = " + recvNames[k] + "\n");  //设置接收人姓名
			if(recvCompany != null){
				sb.append("ReceiverCompany_" + (k + 1) + " = " + recvCompany[k] + "\n");  //设置接收人公司名称
			}else{
				sb.append("ReceiverCompany_" + (k + 1) + " = " + "" + "\n");  //设置接收人公司名称
			}
		}
			
		sb.append("SendTime = " + format.format(new Date()) + "\n");
		sb.append("EastFax = " + "Yes");
		
		
		System.out.println(sb.toString());
		
		//生成epi文件
		newEpiFile(sb.toString() , randomNumber,".epi");

		//保存发送的传真信息
		addEastFax(randomNumber,curTime,FaxNumbers,recvNames,recvCompany,maps,userId,files);
	}
	
	/**
	 * @param epi问价内容
	 * @param 文件名称
	 * @param 文件类型
	 * @return
	 * @author 陈鹏
	 */
	public static void addEastFax(String randomNumber,String curTime,String[] FaxNumbers,String[] recvNames,String[] recvCompany,Map<String,String> maps,String userId,DataObject[] files){
	
        try
        {
            DataObject obj = null;
            DataObject faxMap = null;
            for(int i = 0;i<FaxNumbers.length;i++){
            	obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsEastFax"); 
            	obj.setString("vcFaxAccount", userId); //传真号
            	obj.setString("vcFaxTheme", maps.get("theme")); //传真主题
            	obj.setString("vcFaxComments",  maps.get("faxComments")); //传真备注
            	obj.setString("vcSerialNo", randomNumber); //传真流水号
            	obj.setDate("dSendTime", format.parse(curTime)); //发送时间
            	obj.setString("lBizId", maps.get("bizId"));
            	obj.setString("lProcessInstId", maps.get("processinstid"));
            	obj.setString("vcRecvNumber", FaxNumbers[i]);
            	obj.setString("vcRecvName", recvNames[i]);
            	//判断接收人公司名称是否为空
            	if(recvCompany != null){
            		obj.setString("vcRecvCompany", recvCompany[i]);
            	}
            	obj.setString("vcUserName", maps.get("userName"));
            	obj.setString("vcUserId", userId);
            	obj.setString("lFaxStatus", "1001");
            	obj.setString("lValidStatus", "0");
            	obj.setString("lWorkItemId", maps.get("workItemID"));
            	//生成主键与保存数据
            	DatabaseExt.getPrimaryKey(obj);
            	DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, obj);
            	
            	//循环保存传真关联附件信息
            	for(int k = 0;k<files.length;k++){
            		faxMap = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsEastFaxMap");
            		faxMap.setString("lFaxId", obj.getString("lFaxId"));
            		faxMap.setString("lAttachId", files[k].getString("lAttachId"));
            		faxMap.setString("vcAttachName", files[k].getString("vcAttachName"));
            		DatabaseExt.getPrimaryKey(faxMap);
            		DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, faxMap);
            	}
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally{
        	
        }

	}
	
	/**
	 * @param epi问价内容
	 * @param 文件名称
	 * @param 文件类型
	 * @return
	 * @author 陈鹏
	 */
	public static File newEpiFile(String FileContent,String filename,String fileType){
		byte[] buff=new byte[]{};
		FileOutputStream out = null;
		File file = null;
		DataObject config = (DataObject)CacheUtil.getValue(Constan.CACHE_NAME, "ATS_FAX_URL");//获取系统配置缓存的传真文件路径
        try
        {   
            buff=FileContent.getBytes("GBK");
           //String new_str=new String(str.getBytes("utf-8"),"gbk")); 
           String filePath = config.getString("paramValue");
        		  filename = filename + fileType;//组装传epi文件存放路径
        	//生成路径
            file = new File(filePath + filename);
            //判断文件夹是否存在，不存在创建文件夹
            if(!file.exists() && !file.isDirectory()){
            	new File(filePath).mkdirs();
            }
            //判断文件是否存在，不存在就创建文件夹
            if(!file.exists())    
            {     
               file.createNewFile();    
            }
            //输出文件
            //file.getPath() + File.separator + filename + ".epi"
            out=new FileOutputStream(file.getPath());
            out.write(buff,0,buff.length); 
            System.out.println("epi文件存储位置："+filename);
            
            //FileUtil.copyFile(file.getPath(), "Z:/CE_CHUANZHEN" +  File.separator + filename + fileType);
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }finally{
        	try {
        		
				out.close();
				out.flush();
			} catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
        }
        return file;
	}
	
	//生成10位随机数
	public static String generateRandom(){
		StringBuilder str=new StringBuilder();//定义变长字符串
		Random random=new Random();
		//随机生成数字，并添加到字符串
		for(int i=0;i<10;i++){
			str.append(random.nextInt(10));
		}
		return str.toString();
	}
	
	
	
	/**
	 * @param 文件名称
	 * @param 传真号
	 * @param 提交打印的账号
	 * @author 陈鹏
	 */
	@Bizlet("查询传真返回数据，并组装数据")
	public static List<DataObject> assembleFaxList(DataObject eastFax,List<DataObject> objs) {
		Connection conn = null;
		StringBuffer sb = null;
		if(objs == null){
			objs = new ArrayList<DataObject>();
		}
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_HSFA);
			
			//组装查询语句
			sb = new StringBuffer();
			sb.append("select t.* from cc_eastfax.FAXSTAT t where 1=1 ");
			sb.append(" and t.send_account ='" + eastFax.getString("FAX_ACCOUNT") + "'");
			sb.append(" and t.recv_number ='" + eastFax.getString("RECV_NUMBER") + "'");
			sb.append(" and t.ord_no ='" + eastFax.getString("SERIALNO") + "'");
			
			//获取查询值，并分拆
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					eastFax.setString("VSLID_STATUS", map.get("STATUS"));
				}
			}
			objs.add(eastFax);	
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return objs;
	}
	
	@Bizlet("")
	public static void pollingEastFax(DataObject[] eastFaxs){
		String vcSerialNo = "";
		Connection conn = null;
		DataObject FaxTemplate = null;
		DataObject FaxValue = null;
		for(int i = 0;i<eastFaxs.length;i++){
			if(vcSerialNo == ""){
				vcSerialNo = "'" + eastFaxs[i].getString("vcSerialNo") + "'";
			}else{
				vcSerialNo = vcSerialNo + ",'" + eastFaxs[i].getString("vcSerialNo")+"'";//此处被修改，加入“'”
			}
		}
		
		StringBuffer sb = new StringBuffer();
		
		try{
			//获取CC系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_CC_CZ);
			
			sb.append("select fax.ORD_NO,fax.STATUS from FAXSTAT fax where 1=1");
			sb.append("and fax.ORD_NO in (" + vcSerialNo + ")");
			//获取查询值，并分拆
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//设置修改条件
					FaxTemplate = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsEastFax");
					FaxTemplate.setString("vcSerialNo", map.get("ORD_NO"));
					
					//设置要修改的值
					FaxValue = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.TAtsEastFax");
					FaxValue.setString("lFaxStatus", map.get("STATUS"));
					
					DatabaseUtil.updateEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, FaxValue,FaxTemplate);
				}
			}	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public static void main(String[] args) {
		StringBuffer sb =new StringBuffer();
		//生成10位随机数
		String randomNumber = format.format(new Date());
		//组装epi文件参数
		sb.append("[General]\n");
		sb.append("Account = huangmizhi\n");
		sb.append("Subject = 测试传真\n");
		sb.append("Comments = 测试n");
		sb.append("FaxFlowAccounts = " + "zhangfan > limo > wangyan" + "\n");
		sb.append("SerialNO = " + randomNumber + "\n");  //传真流水号
		sb.append("Priority = " + "1" + "\n"); //传真优先级， 0 低， 1 普通， 2 高，该配置生效的前提是账户具有“重要传真优先发送”的权限，默认为 1
		sb.append("EmailResult = " + "" + "\n");
		sb.append("ReceiverNumber_1 = lisi\n"); //设置接收人传真号
		sb.append("ReceiverName_1 = 李四\n");  //设置接收人姓名
		sb.append("ReceiverCompany_1 = \n");  //设置接收人公司名称
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");		
		sb.append("SendTime = " + format.format(new Date()) + "\n");
		sb.append("EastFax = " + "Yes");
		
	
		
		System.out.println(sb.toString()); 
		//生成epi文件
		newEpiFile(sb.toString() , randomNumber,".epi");
		//生成word文件  
		newEpiFile(sb.toString() , randomNumber+"_1",".doc");
		System.out.println("2");

		
	}
	
	
}
