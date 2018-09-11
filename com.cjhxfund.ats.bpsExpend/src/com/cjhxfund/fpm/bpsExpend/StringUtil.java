package com.cjhxfund.fpm.bpsExpend;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;

import commonj.sdo.DataObject;
import edu.emory.mathcs.backport.java.util.Arrays;

@Bizlet("分割字符")
public class StringUtil {
      //循环分割字符
 @Bizlet("分割字符1")
     public String[] splitArgs(String args,String type){
		 if(args==null||"".equals(args)){
			 return null;
		 } else {
	         String[] strarray=args.split(type);
	    	 return strarray;
		 }
     }
     
	 @Bizlet("字符串加入字符串数组")
	 public String[] appendString(String[] strs,String str){
	     List<String> oldList = new ArrayList<String>();
	     oldList.addAll(Arrays.asList(strs));
	     
	     oldList.add(str);
		 return (String[])oldList.toArray(new String[oldList.size()]);
	 }
	//以point为最后字符，分割strs，例：一二三四五，三 -->[一二三，四五]
		 @Bizlet("切割字符串")
		 public String[] subStringByChar(String strs,String point){
			 StringBuffer sb = new StringBuffer();
			 String[] cutStr = new String[2];
			 int k = 0;
			 if(point==null||"".equals(point)) return null;
			 
			 String[] array = strs.split("");
			 for(int i=0;i<array.length;i++){
				 sb.append(array[i]);
				 if(point.equals(array[i])) {
					 k=i;
					 break;
				 }
			 }
			 cutStr[0] =sb.toString();
			 sb =new StringBuffer();
			 for(int j=k+1;j<array.length;j++){
				 sb.append(array[j]);
			 }
			 cutStr[1] = sb.toString();
			 return cutStr;
		 }
		 
//	     public static void main(String[] args){
//	    	 StringUtil su = new StringUtil();
//	    	 System.out.println(su.subStringByChar("招商银行股份有限公司","司")[1]);
//	     }  
	
 /**
  * nameArrayStr格式 XXX,XXX,XXX
  * @param nameArrayStr
  * @param name
  * @return boolean
  */
 @Bizlet("判断名字在名字数组字符串中是否存在")
 	public String checkSameName(String nameArrayStr,String name){
	 	String flag = "false";
	 	if(!(nameArrayStr==null)){
	 		if(nameArrayStr.indexOf(",") > -1){
	 			String[] nameArray = nameArrayStr.split(",");
	 			for(int i = 0; i < nameArray.length; i++){
	 				if(nameArray[i].equals(name)){
	 					flag = "true";
	 				}
	 			}
	 		} else {
	 			if(nameArrayStr.equals(name)) flag = "true";
	 		}
	 	}
 		return flag;
 	}
 
 
 
 	//拼接对象数组中的字段column,拼接字符为concatChar
 	@Bizlet("拼接对象数组中的字段")
 	public String concatObjectColumn (DataObject[] obj,String column,String concatChar){
 		if(obj.length == 0) return null;
 		else {
	 		StringBuilder stringTemp = new StringBuilder();
	 		int length = obj.length;
	 		for(int i = 0; i < length; i++){
	 			stringTemp.append(obj[i].getString(column));
	 			if(i != length-1) stringTemp.append(concatChar);
	 		}
	 		String concatString = stringTemp.toString();
	 		return concatString;
 		}
 	}
 	
 	/**
 	 * 
 	 * @param dataObjs
 	 * @return  {1111,xxx;2222,yyy}
 	 */
 	@Bizlet("拼接emp人员对象")
 	public String concatEmpStr4MutiEmp(DataObject[] dataObjs){
 		String empStr = "";
		for(int i=0;i<dataObjs.length;i++){
			empStr += dataObjs[i].getString("empid");
			empStr += ",";
		    empStr +=	 dataObjs[i].getString("empname");
		    if(i<dataObjs.length-1){
		    	empStr += ";";
		    }
		}
 			return empStr;
 	}
 	
 	/**
 	 * 
 	 * @param participant
 	 * @return  1111,xxx;2222,yyy
 	 */
 	@Bizlet("拼接participant人员对象")
 	public String concatPart4MutiEmp(WFParticipant[] dataObjs){
 		String empStr = "";
		for(int i=0;i<dataObjs.length;i++){
			empStr += dataObjs[i].getId();
			empStr += ",";
		    empStr +=	 dataObjs[i].getName();
		    if(i<dataObjs.length-1){
		    	empStr += ";";
		    }
		}
 			return empStr;
 	}
 	
 	@Bizlet("拼接userName对象")
 	public String splitUser(String user){
 		String userName = "";
 		String userId = "";
 		String[] userArray2;
 		
 		if(("").equals(user)||user == null){
 			return null;
 		}else{
 			String[] userArray = user.split(";");
 			for(int i=0;i<userArray.length;i++){
 	 	    	userArray2 = userArray[i].split(",");
 	 	    	if(userArray2.length>1){
 	 	    		userName += userArray2[1];
 	 	    		if(i<userArray.length-1){
 	 	    			userName +=",";
 	 	    		}
 	 	    	}
 	 	    }
 			return userName;
 		}
 	}
 	
 	@Bizlet("拼接marmanager人员对象")
 	public String concatMgrmanagerStr4MutiEmp(DataObject[] dataObjs){
 		String empStr = "";
		for(int i=0;i<dataObjs.length;i++){
			empStr += dataObjs[i].getString("id");
			empStr += ",";
		    empStr +=	 dataObjs[i].getString("name");
		    if(i<dataObjs.length-1){
		    	empStr += ";";
		    }
		}
 			return empStr;
 	}
 	
 	/**
 	 * 
 		 * @Description TODO
 		 * @Author		wjh
 		 * @Date		2016年11月2日 下午3:41:20
 		 * @param @param dictCode 业务字典代码
 		 * @param @param dictId 子字典ID(101,102,103)
 		 * @param @return 参数
 		 * @return String 返回类型 
 		 * @throws
 	 */
 	@Bizlet("根据多选业务字典ID并返回字典拼接的显示值")
 	public String concatDictName(String dictCode,String dictId){
 		if(dictId!=null&&!"".equals(dictId)){
 			String[] dictArr = dictId.split(",");
 			String[] dicrNameArr = new String[dictArr.length];
 			for(int i=0;i<dictArr.length;i++){
 				dicrNameArr[i] = BusinessDictUtil.getDictName(dictCode, dictArr[i]);
 			}
 			return com.eos.foundation.common.utils.StringUtil.concat(",", dicrNameArr);
 		}
 		return "";
 	}
 	
 	@Bizlet("将date类型转换为String类型")
 	public String changeDateToString(Date time){
 		String resultTime = null;
 		if(time!=null){
 			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
 			resultTime=sdf.format(time);
 		}
		return resultTime;
 	}
 	
 	/**
 	 * 
 	 * @param str 
 	 * @param beforeStr 被替换的字符串
 	 * @param afterStr 替换的字符串
 	 * @return
 	 */
 	@Bizlet("替换字符串方法")
 	public String replaceStr(String str,String beforeStr,String afterStr){
 		if(str==null||"".equals(str)||beforeStr==null||"".equals(beforeStr)) return str;
 		return str.replace(beforeStr, afterStr);
 	}
}
