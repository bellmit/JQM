package org.gocom.components.coframe.auth.login;




import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import net.sf.json.JSONObject;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import commonj.sdo.DataObject;


/**
 * 短信验证码服务类
 * @author yangminit
 *
 */
public class SendMsncService {
	
	/**
	 * 获取短信验证码开启状态
	 * @return
	 */
	@Bizlet("获取短信验证码开启状态")
	public static boolean getSendMsncStatus(String userId){
		try{
			DataObject temp=(DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "USER_MSCN_CODE");
			String status="";
			if(temp!=null){
				 status=temp.getString("paramValue");
			}
			
			if(status.equals("2")){
				//判断公测用户
				return getTrialUser(userId,"USER_MSCN");
			}else if(status.equals("3")){
				return true;
			}else{
				return false;
			}
		}catch(Exception e){
			LogUtil.logError("获取短信验证码开关，系统参数失败~", e,null);
			return false;
		}
		
	}
	public  boolean getSendMsncStatus2(String userId){
		
		try{
			DataObject temp=(DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "USER_MSCN_CODE");
			String status="";
			if(temp!=null){
				 status=temp.getString("paramValue");
			}
			
			if(status.equals("2")){
				//判断公测用户
				return getTrialUser(userId,"USER_MSCN");
			}else if(status.equals("3")){
				return true;
			}else{
				return false;
			}
		}catch(Exception e){
			LogUtil.logError("获取短信验证码开关，系统参数失败~", e,null);
			return false;
		}
	}
	/**
	 * 查询该用户是否为试用用户
	 * @param userId 用户ID
	 * @param trialFunCode 试用功能code
	 * @return
	 */
	public static boolean getTrialUser(String userId,String trialFunCode){
		DataObject trial =  com.eos.foundation.data.DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.TAtsTrialUser");
		trial.setString("userid",userId);
		trial.setString("trialFunCode", trialFunCode);
		
		int k = com.eos.foundation.database.DatabaseUtil.expandEntityByTemplate("default",trial,trial);
		if(k==0){
			return false;
		}else{
			return true;
		}
	}
	/**
	 * 获取短信接口
	 * @return
	 */
	public static String getSendMsncUrl(){
		DataObject temp=(DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue("ReloadParamConf1", "USER_MSCN_API_URL");
		String value="";
		if(temp!=null){
			value=temp.getString("paramValue");
		}
		return value;		
	}
	/** 
	  * 创建指定数量的随机字符串 
	  * @param numberFlag 是否是数字 
	  * @param length 
	  * @return 
	  */  
	 public static String createRandom(boolean numberFlag, int length){  
	  String retStr = "";  
	  String strTable = numberFlag ? "1234567890" : "1234567890abcdefghijkmnpqrstuvwxyz";  
	  int len = strTable.length();  
	  boolean bDone = true;  
	  do {  
	   retStr = "";  
	   int count = 0;  
	   for (int i = 0; i < length; i++) {  
	    double dblR = Math.random() * len;  
	    int intR = (int) Math.floor(dblR);  
	    char c = strTable.charAt(intR);  
	    if (('0' <= c) && (c <= '9')) {  
	     count++;  
	    }  
	    retStr += strTable.charAt(intR);  
	   }  
	   if (count >= 2) {  
	    bDone = false;  
	   }  
	  } while (bDone);  
	  
	  return retStr;  
	 } 
	/**
	 * 处理用户获取短信验证码请求方法
	 * @return
	 */
	@Bizlet("处理用户获取短信验证码请求方法")
	public int getSendMsncCode(String userId){
		//生产短信验证码
		String code=createRandom(true,6);
		System.out.println("产品短信验证码："+code);
		int msgCode=0;
		DataObject emp = null;
		try {
			emp = SendMsncService.getUserPhone(userId);
		} catch (Exception e) {
			msgCode=2;//获取用户信息失败
			LogUtil.logError("发送短信-获取用户信息失败", e,null);
			return msgCode;
		}
		String phone = emp.getString("otel");
		String email = emp.getString("oemail");
		
		if("".equals(phone)){
			msgCode=3;//手机号码为空
			return msgCode;
		}
		/*保存短信验证码到数据库*/
		DataObject mscnCode=null;
		try {
			 mscnCode = SendMsncService.saveMsncCode(code, phone,userId);
		} catch (Exception e) {
			msgCode=4;//保存数据到数据库失败
			LogUtil.logError("发送短信-保存数据到数据库失败{0},{1},{2}", e,code,phone,userId);
			return msgCode;
		}
		try{
			//发送邮件
			String ret = SendMsncService.sendEmail(email, code, userId);
		}catch(Exception e){
			
		}
		
		JSONObject json=null;
		try {
			LogUtil.logInfo("开始调用短信验证码......", null, null);
			LogUtil.logInfo("【调用短信验证码参数:{0}】", null, mscnCode);
			String url = SendMsncService.getSendMsncUrl();
			json = new SendMobileCode().sendTxt(url,mscnCode.getString("vcPhone"),mscnCode.getString("vcMscnCode"),mscnCode.getString("vcUserId"),mscnCode.getString("lMscnId"));
			LogUtil.logInfo("调用短信验证码结束......【回参】{0}", null, json);
		} catch (Exception e) {
			msgCode=5;//调用短信接口失败失败
			
			/*if("1".equals(ret)){
				msgCode=7;//邮件且短信发送失败
				LogUtil.logError("登录发送验证码，邮件和短信均发送失败{0},{1},{2}", null,code,phone,userId);
				return msgCode;
			}*/
			return msgCode;
		}
		
		if(json == null || !json.getString("retCode").equals("1")){
			msgCode=6;//发送短信失败
			LogUtil.logError("发送短信失败!【短信反馈】{0}", null, json);
			return msgCode;
		}
		
		return msgCode;
	}
	public static String sendEmail(String mail,String mscnCode,String userId){
		
			DataObject data =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.commonUtil.dataBase.TAtsSendmailInfo");
			if("".equals(mail)){
				return "1";
			}
			data.setString("vcMailTo", mail);
			data.setString("vcTitle", "机器猫系统登录验证码");
			data.setString("vcMailContext", "尊敬的 "+userId+" 用户，您本次的机器猫系统登录验证码为："+mscnCode);
			Object[] result = null;
			// 逻辑构件名称 data/vcTitle data/vcMailContext data/vcMailTo
			String componentName = "com.cjhxfund.commonUtil.MessageService";
			System.out.println("开始发送邮件~");
			//com.cjhxfund.jy.ProductProcess.o32tcjc.queryUserColumnSet.biz.ext
			// 逻辑流名称
			String operationName = "sendMail";
			String rtnCode="0";
		try{
			ILogicComponent logicComponent = LogicComponentFactory.create(componentName);
			int size = 1;
			// 逻辑流的输入参数
			Object[] params = new Object[size];
			params[0] = data;
			try {
				result = logicComponent.invoke(operationName, params);
			} catch (Throwable e) {
				// TODO: handle exception
				LogUtil.logError("发送邮件失败!【邮件信息】{0}", e, data);
				
			}
			//获取返回值
			DataObject[] r = (DataObject[])result[0];
			//rtnCode：0表示成功，1表示失败
			rtnCode = r[0].getString("rtnCode");
			System.out.println("邮件返回信息："+rtnCode);
		}catch(Exception e){
			
		}
		
		return rtnCode;
	}
	/**
	 * 获取用户的手机号
	 * @return
	 */
	@Bizlet("获取用户的手机号")
	public static DataObject getUserPhone(String userId){
		
		DataObject emp =  com.eos.foundation.data.DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.OrgEmployee");
		emp.setString("userid",userId);
		
		com.eos.foundation.database.DatabaseUtil.expandEntityByTemplate("default",emp,emp);
		
		return emp;
	}
	/**
	 * 保存短信验证码到数据库
	 * @param code 短信验证码
	 * @param phone 手机号
	 * @throws ParseException 
	 */
	public static DataObject saveMsncCode(String code,String phone,String userId) throws ParseException{
		DataObject msncCode =  com.eos.foundation.data.DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.TAtsUserMscnCode");
		msncCode.setString("vcMscnCode", code);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		
		
		
		//为获取当前系统时间
		//msncCode.setString("dBeginDtae", df.parse(df.format(new Date())));
		
		msncCode.setDate("dBeginDtae", df.parse(df.format(new Date())));
		msncCode.setString("cStatus", "0");//1已使用，0未使用，2失效
		msncCode.setString("vcPhone", phone);
		msncCode.setString("vcUserId", userId);
		com.eos.foundation.database.DatabaseExt.getPrimaryKey(msncCode);//获取主键
		System.out.println("保存到数据库。。。。。。");
		System.out.println(msncCode.toString());
		com.eos.foundation.database.DatabaseUtil.saveEntity("default",msncCode);//插入数据库
		
		//com.eos.foundation.database.DatabaseUtil.updateEntityByTemplate();
		
		return msncCode;
	}
	
	public static DataObject getQueryMscnData(DataObject dobj){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		System.out.println("当前时间：" + sdf.format(now));
		
		long time = 60*1000;//1分钟
		  
		Date beforeDate = new Date(now .getTime() - time);//1分钟前的时间
		dobj.setDate("beforeDate", beforeDate);
		dobj.setDate("nowDate", now);
		
		return dobj;
	}
	public static void main(String[] args) {
		
		
		 // System.out.println( new   Date(System.currentTimeMillis()));
		//System.out.println(new SendMobileCode().sendTxt("1391877674", "589651", "caile", "01"));
	}
}
