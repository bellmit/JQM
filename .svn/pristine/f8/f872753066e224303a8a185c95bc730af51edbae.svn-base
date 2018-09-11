/**
 * 
 */
package com.cjhxfund.commonUtil.manualDownload;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;

/**
 * @author CJ-WB-DT13
 * @date 2016-03-03 16:21:42
 *
 */
@Bizlet("获取操作手册相关信息")
public class getFileName {
	
	@Bizlet("获取操作手册名称")
	public static String getName(String userType) {
		String Path  = ApplicationContext.getInstance().getApplicationUserWorkingPath()+"/com.cjhxfund.commonUtil/META-INF/manual";
		//文件名称
      	String fName = "";
      	String name = "";
     	long time = 0; //获取文档最后修改时间
     	String versionNumber = "";
      	//获得指定文件对象
      	File file = new File(Path);
      	//获得该文件夹内的所有文件
      	File[] array = file.listFiles();
      	try{
	      	for(int a = 0;a < array.length; a++){
	      		if (array[a].isFile()){// 如果是文件
	      			//获取文件名称
	      			name = array[a].getName();
	      			//获取文档版本号
	      			String version = getFileName.getEdition(name, userType);
	      		
	      			//如果是投顾权限,下载普通手册
	      			if("2".equals(userType)){
	      				//判断文件是否为内部版本
	      				if(name.indexOf("内部版") == -1){
	      					
	      					//初始化文档最后修改时间
	      					if(time == 0){
	      						//获取文档最后修改时间，并为time设置初始值
	    	      				time = array[a].lastModified();
	      					}
	      					
	      					//初始化外部文档版本号
	      					if(versionNumber.equals("")){
	      						//设置版本号初始值
	    	      				versionNumber = getFileName.getEdition(name, userType);
	    	      				versionNumber = versionNumber.substring(1, versionNumber.length());
	      					}
	      					
	      					//比较版本号
	      					int i = getFileName.compareVersion(versionNumber, version.substring(1, version.length()));
	      					if(i < 0){ 
	      						fName = name;
	      						//设置最新的文档修改时间
	      						time = array[a].lastModified();
	      						versionNumber = version.substring(1,version.length());
	      					}else if(i == 0){ //版本号一致时
	      						//判断修改时间，获取最新修改的文档
	      						if(time <= array[a].lastModified()){
	      							fName = name;
	      							//设置最新的文档修改时间
	      							time = array[a].lastModified();
	      							versionNumber = version.substring(1,version.length());
	      						}
	      					}
	      				}
	      			}
	      			
	      			if("1".equals(userType)){//如果是内部员工，下载内部操作手册
	      				if(name.indexOf("内部版") != -1){
	      				//初始化文档最后修改时间
	      					if(time == 0){
	      						//获取文档最后修改时间，并为time设置初始值
	    	      				time = array[a].lastModified();
	      					}
	      					
	      					//初始化内部文档版本号
	      					if(versionNumber.equals("")){
	      						//设置版本号初始值
	    	      				versionNumber = getFileName.getEdition(name, userType);
	    	      				versionNumber = versionNumber.substring(1, versionNumber.length());
	      					}
	      					//比较版本号
	      					int i = getFileName.compareVersion(versionNumber, version.substring(1, version.length()));
	      					if(i < 0){
	      						fName = name;
	      						//设置最新的文档修改时间
	      						time = array[a].lastModified();
	      						versionNumber = version.substring(1,version.length());
	      					}else if(i == 0){
	      						if(time <= array[a].lastModified()){
	      							fName = name;
	      							//设置最新的文档修改时间
	      							time = array[a].lastModified();
	      							versionNumber = version.substring(1,version.length());
	      						}
	      					}	
	      				}
	      			}
	      		}
	      	}
      	}catch(Exception e){
      		e.printStackTrace();
      	}
      	return fName;
    }
	
    /** 
     * 比较版本号的大小,前者大则返回一个正数,后者大返回一个负数,相等则返回0 
     * @param version1 
     * @param version2 
     * @return 
     */  
    public static int compareVersion(String version1, String version2) throws Exception {  
        if (version1 == null || version2 == null) {  
            throw new Exception("compareVersion error:illegal params.");  
        }  
        String[] versionArray1 = version1.split("\\.");//注意此处为正则匹配，不能用"."；  
        String[] versionArray2 = version2.split("\\.");  
        int idx = 0;  
        int minLength = Math.min(versionArray1.length, versionArray2.length);//取最小长度值  
        int diff = 0;  
        while (idx < minLength  
                && (diff = versionArray1[idx].length() - versionArray2[idx].length()) == 0//先比较长度  
                && (diff = versionArray1[idx].compareTo(versionArray2[idx])) == 0) {//再比较字符  
            ++idx;  
        }  
        //如果已经分出大小，则直接返回，如果未分出大小，则再比较位数，有子版本的为大；  
        diff = (diff != 0) ? diff : versionArray1.length - versionArray2.length;  
        return diff;  
    }  
    
	
	/**
	 * 
	 * @param fName    附件名称
	 * @param userType 用户类型
	 * @return  版本号
	 */
	@Bizlet("获取操作手册版本")
	public static String getEdition(String fName,String userType) {
		//获取最后一个"."的位置
		int i = fName.lastIndexOf(".");
		//截取字符串，获取除文件后缀之外的文件名称
		fName = fName.substring(0,i);
		//获取最后一个"v"的位置
		int k = fName.toLowerCase().indexOf("v");
		//返回截取的文件版本号
		return fName.substring(k,fName.length());
	}
	
	/**
	 * 
	 * @param orgId 用户所属机构ID
	 * @param userOrgId   创金合信_投顾业务组ID
	 * @param wtywzOrgId  创金合信_委托业务组ID
	 * @return 员工所属权限 1-内部员工 2-投顾
	 */
	@Bizlet("获取操作人权限")
	public static String getUserType(String orgId,String userOrgId,String wtywzOrgId) {
		//设置权限 ： 1内部员工 ,2投顾人员
		String userType = "1";
		//判断登录员工不属于投顾业务组
		if(orgId.equals(userOrgId)){
			userType = "2";
		}else if(wtywzOrgId != "" && orgId.equals(wtywzOrgId)){ //判断登录员工不属于委托业务组
			userType = "2";
		}
		return userType;
	}
	
	public static void main(String[] args) {
		int i = 0;
		try {
			i = getFileName.compareVersion("1.3","1.5");
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		System.out.println(i);
	}
	
} 
