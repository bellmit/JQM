/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;
import commonj.sdo.DataObject;

/**
 * @author CJ-WB-DT13
 * @date 2016-07-26 16:32:55
 *
 */
@Bizlet("")
public class commonUtil {
	
	/** 上传文件保存路径-流程文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG = "/home/ats/FileUploadPath/JQM/LiuCheng/";
	/** 上传文件保存路径-流程文件-用印文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG_YONGYIN = "/home/ats/FileUploadPath/JQM/LiuCheng/YongYin/";
	/** 上传文件保存路径-投票业务文件 */
	public static final String UPLOAD_FILE_PATH_TOUPIAO = "/home/ats/FileUploadPath/JQM/TouPiao/";
	/** 上传文件保存路径-传真文件 */
	public static final String UPLOAD_FILE_PATH_CHUANZHEN = "/home/ats/FileUploadPath/JQM/ChuanZhen/";
	/** 上传文件保存路径-mom用印文件 */
	public static final String UPLOAD_FILE_PATH_MOM_YONGYIN = "/home/ats/FileUploadPath/WTD/";
	
	
	/**
	 * @param 组装参与者
	 * @return
	 * @author CJ-WB-DT13
	 */
	@Bizlet("组装参与者并剔除上一环节参与者")
	public static List<WFParticipant> setRelativeEmpList(DataObject[] objs,String userId) {
		// TODO 自动生成的方法存根

		List<WFParticipant> participants = new ArrayList<WFParticipant>();

		for (int i = 0; i < objs.length; i++) {
			DataObject obj = objs[i];
			if (obj != null) {
				if(!obj.getString("EMPCODE").equals(userId)) {
					WFParticipant ipant = new WFParticipant();

					ipant.setId(obj.getString("EMPID"));
					ipant.setName(obj.getString("EMPNAME"));
					ipant.setTypeCode("emp");
					participants.add(ipant);
				}	
			}
		}

		return participants;
	}
	
	/**
	 * 剔除用户
	 * @param objs 员工集合
	 * @param userId 当前登录人
	 * @return 
	 */
	@Bizlet("")
	public static List<DataObject> eliminateUser(DataObject[] objs,String userId){
		List<DataObject> participants = new ArrayList<DataObject>();
		for (int i = 0; i < objs.length; i++) {
			DataObject obj = objs[i];
			if (obj != null) {
				if(!obj.getString("EMPCODE").equals(userId)) {
					participants.add(obj);
				}
			}
		}
		return participants;
	}
	
	/**
	 * @param 组装参与者
	 * @return
	 * @author 
	 */
	@Bizlet("交易员2复核是剔除流程发起人和交易员1")
	public static List<WFParticipant> setRelativeEmpList2(List<WFParticipant> participants,String userId) {
		// TODO 自动生成的方法存根
		for (int i = 0; i < participants.size(); i++) {
			if(participants.get(i).getId().equals(userId)){
				participants.remove(i);
			}
		}
		return participants;
	}
	/**
	 * @param wf
	 * @return
	 * @author 陈鹏
	 */
	@Bizlet("组装活动实例")
	public static String[] assembleActivityInstance(DataObject wflist) {
		// TODO 自动生成的方法存根
		String[] str = new String[1];
		System.out.println(wflist.getString("vcRollbackItemId"));
		str[0] = wflist.getString("vcRollbackItemId");

		return str;
	}
	/**
	 * 获取债券code
	 * @param dobjs 债券集合
	 * @author 杨敏
	 */
	@Bizlet("获取债券code")
	public static String getBondCode(DataObject[] dobjs){
		if(dobjs.length<1){
			return "";
		}
		return dobjs[0].getString("BCODE");
		
	}
	/**
	 * 获取债券code
	 * @param String code 债券集合
	 * @author 
	 */
	@Bizlet("获取债券code")
	public static String getStockCode(String code){
		if(code.length()>0){
			return code.substring(0, code.length()-2);
		}
		return code;
		
	}
	
	/**
	 * 判断当前登录人员是交易员还是投资经理
	 * @param userId  用户ID
	 * @return 反馈状态 
	 */
	@Bizlet("判断角色")
	public static int CheckRole(String userId){
		int judge = -1;
		DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmployee");
		Object [] temp = null;
		//根据用户ID查询相应员工信息
		if(StringUtils.isNotBlank(userId)){
			temp = DatabaseExt.queryByNamedSql("default", 
					"com.cjhxfund.ats.fm.comm.wf.selectUserListByjyy", userId);
			//判断当前登录用户是否是交易员
			for(int i = 0; i < temp.length; i++){
				emp=(DataObject)temp[i];
				if(emp.getString("userid").equals(userId)){
					judge = 1;
					return judge;
				}
			}
			temp = DatabaseExt.queryByNamedSql("default", 
					"com.cjhxfund.ats.fm.comm.wf.selectUserListBytzjl", userId);
			//判断当前登录用户是否是投资经理
			for(int i = 0; i < temp.length; i++){
				emp=(DataObject)temp[i];
				if(emp.getString("userid").equals(userId)){
					judge = 0;
					return judge;
				}
			}
		}
		return judge;
	}
	
	/**
	 * 判断当前登录人员是否为投顾
	 * @param userId  用户ID
	 * @return 反馈状态 
	 */
	@Bizlet("判断角色")
	public static int JudgeRole(String userId){
		int judge = 0;
		//根据用户ID查询相应员工信息
		DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmployee");
		emp.setString("userid", userId);
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emp, emp);
		
		//根据员工ID查询所属的机构
		DataObject emporg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmporg");
		emporg.setString("empid", emp.getString("empid"));
		DataObject[] objs = DatabaseUtil.queryEntitiesByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emporg);
		
		//判断当前登录用户是否是投顾
		for(int i = 0; i < objs.length; i++){
			if(objs[i].getString("orgid").equals("4")){
				judge = 1;
				return judge;
			}
		}
		return judge;
	}
	/**
	 * 判断当前登录人员是否为交易员
	 * @param userId  用户ID
	 * @return 反馈状态 
	 */
	@Bizlet("判断是否交易员")
	public static int JudgeRoleJYY(String userId){
		int judge = 0;
		//根据用户ID查询相应员工信息
		DataObject emp = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmployee");
		emp.setString("userid", userId);
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emp, emp);
		
		//根据员工ID查询所属的机构
		DataObject emporg = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.OrgEmporg");
		emporg.setString("empid", emp.getString("empid"));
		DataObject[] objs = DatabaseUtil.queryEntitiesByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, emporg);
		
		//判断当前登录用户是否是投顾
		for(int i = 0; i < objs.length; i++){
			if(objs[i].getString("orgid").equals("2")){
				judge = 1;
				return judge;
			}
		}
		return judge;
	}
	
	/**
	 * Tab页权限
	 * @param 当前页面的code
	 * @param  
	 * @return 根据code判断权限，如果有对应的权限则显示该菜单，否则隐藏
	 */
	@Bizlet("权限控制")
	public static String TabPageRight(String funcCode){
		String funcCodeRel = "'" + funcCode.replace(",", "','") + "'";				
		return funcCodeRel;
	}
	
	/**
	 * 移动和重命名文件
	 * @param filePath老的文件路劲
	 * @param filePath老的文件名称 
	 * @return 是否成功
	 */
	@Bizlet("")
	public static String moveAndRenameFile(String filePath,String fileName){ 
		File dirFile = null;
		boolean isHave = false;
		String filename  = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String filedate = df.format(new Date());
		try{  
	        dirFile = new File(UPLOAD_FILE_PATH_MOM_YONGYIN);  
	        if (!(dirFile.exists())&&!(dirFile.isDirectory())) {  
	        	isHave = dirFile.mkdirs();  
	        }else{  
	        	isHave = true;  
	        }  
	        if(isHave){
	        	filename = UPLOAD_FILE_PATH_MOM_YONGYIN+ filedate+"_"+fileName;
	        	if(copyFile(filePath,filename)){
	        		return filename;
	        	}
	        }
	    }catch(Exception se){
	        se.printStackTrace();  
	    }
		return filename;
	}
	
	/** 
	* 复制单个文件 
	* @param oldPath String 原文件路径 如：c:/fqf.txt 
	* @param newPath String 复制后路径 如：f:/fqf.txt 
	* @return boolean 
	*/ 
	@Bizlet("")
	public static boolean copyFile(String oldPath,String newPath) { 
		boolean isSucces = false;
		try { 
			int bytesum = 0; 
			int byteread = 0;
			File oldfile = new File(oldPath);
			if (oldfile.exists()) { //文件存在时 
				InputStream inStream = new FileInputStream(oldPath); //读入原文件 
				FileOutputStream fs = new FileOutputStream(newPath); 
				byte[] buffer = new byte[1024]; 
				while ( (byteread = inStream.read(buffer)) != -1) { 
					bytesum += byteread; //字节数 文件大小 
					fs.write(buffer, 0, byteread); 
				}
				isSucces = true;
				inStream.close();
				fs.close();
			} 
		} 
		catch (Exception e) { 
			System.out.println("复制单个文件操作出错"); 
			e.printStackTrace(); 
		} 
		return isSucces;
	} 
	
	/**
	 * 移动和重命名文件
	 * @param filePath老的文件路劲
	 * @param fileName老的文件名称 
	 * @param newfilePath新的文件路劲
	 * @param newfileName新的文件名称
	 * @return 是否成功
	 */
	@Bizlet("")
	public static String moveAndRenameFileUtil(String filePath,String fileName,String newfilePath,String newfileName){ 
		File dirFile = null;
		boolean isHave = false;
		String tfilename  = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String filedate = df.format(new Date());
		try{  
	        dirFile = new File(newfilePath);  
	        if (!(dirFile.exists())&&!(dirFile.isDirectory())) {  
	        	isHave = dirFile.mkdirs();  
	        }else{  
	        	isHave = true;  
	        }  
	        if(isHave){
	        	//如没有给新的名字则为原文件名
	        	if(StringUtils.isNotBlank(newfileName)){
	        		tfilename = newfilePath +File.separator+ filedate + "_" + newfileName;
	        	}else{
	        		tfilename = newfilePath +File.separator+ filedate + "_" + fileName;
	        	}
	        	if(copyFile(filePath,tfilename)){
	        		return tfilename;
	        	}
	        }
	    }catch(Exception se){
	        se.printStackTrace();  
	    }
		return tfilename;
	}
	
	/**
	 * 	附件类型根据上传文件名称赋值
	 * 	vcAttachBizType：缴款流程-1，申购流程：1
	 *	vcAttachType:缴款文件-1,申购文件：1
	 *	
	 * @param attachName	附件名
	 * @return
	 */
	@Bizlet("")
	public static DataObject attachTypeConvert(String attachName){
		DataObject attachTypeObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		// processType 缴款-1，授权-2
		if(attachName != null){
			if(attachName.indexOf("正式缴款")>=0 ){
				attachTypeObj.set("attachBizType", "1");
				attachTypeObj.set("attachType", "1");
				// 正式授权缴款
				attachTypeObj.set("cPaymentAuthStatus", "2");
				attachTypeObj.set("processType", "1");
			}else if(attachName.indexOf("正式申购")>=0){
				attachTypeObj.set("attachBizType", "1");
				attachTypeObj.set("attachType", "1");
				// 正式授权申购
				attachTypeObj.set("cApplyAuthStatus", "0");
				attachTypeObj.set("processType", "2");
			}
		}
		return attachTypeObj;
	}
	/**
	 * 将本地的模板文件长传至目标文件夹内
	 * @param filePath 待上传模板文件路径
	 * @param fileName 模板文件名称
	 * @param templateDirPath 上传目标文件夹
	 * @return
	 */
	@Bizlet("")
	public static String upLoadTemplate(String filePath,String fileName,String templateDirPath){ 
		boolean isHave = true;
		String templatePath  = templateDirPath +File.separator + fileName;
		try{  
			File templateDir = new File(templateDirPath);  
	        if (!(templateDir.exists())&&!(templateDir.isDirectory())) {  
	        	isHave = templateDir.mkdirs();  
	        }
	        //上传模板前，将旧模板删除
	        File stockTemplate = new File(templatePath);
			if(stockTemplate.exists()&&!stockTemplate.isDirectory()){
				stockTemplate.delete();
			}
	        if(isHave){
	        	//File file = new File(filePath);
	        	//如没有给新的名字则为原文件名
	        	//File newFile = new File(templatePath);
	        	copyFile(filePath,templatePath);
	        }
	    }catch(Exception se){
	        se.printStackTrace();  
	    }
		return templatePath;
	}
}
