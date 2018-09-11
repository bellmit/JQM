package com.cjhxfund.foundation.fix;

import java.io.File;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.ParamConfig;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.cjhxfund.foundation.fix.impl.FixToDealBack;
import com.cjhxfund.foundation.fix.impl.FixToEntrustBack;
import com.cjhxfund.foundation.fix.impl.FixToInstrBack;
import com.cjhxfund.foundation.fix.impl.FixToInstrImport;
import com.cjhxfund.foundation.fix.impl.FixToInstruction;
import com.cjhxfund.foundation.fix.impl.FixToQuery;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.eoscommon.CacheUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
import quickfix.Application;
import quickfix.ConfigError;
import quickfix.DefaultMessageFactory;
import quickfix.FileLogFactory;
import quickfix.FileStoreFactory;
import quickfix.LogFactory;
import quickfix.SessionID;
import quickfix.SessionNotFound;
import quickfix.SessionSettings;
import quickfix.SocketInitiator;
import quickfix.fix44.MessageCracker;

/**
 * Fix报文收发公共处理类
 * @author huangmizhi
 */
@Bizlet("")
public class FixToUtil extends MessageCracker{
	
	/** 产品参数配置表-缓存名称，需跟配置文件user-config.xml的“产品参数数据缓存”的名称对应 */
	public static final String PRODUCT_CONF = "ProductConf";
	/** 是否启用Fix对接O32的参考key：ZHFWPT_ENABLE_FIX */
	public static String ENABLE_FIX_PARAM_KEY = "ZHFWPT_ENABLE_FIX";
	/** 是否启用Fix对接O32：0-启用； */
	public static String ENABLE_FIX_PARAM_KEY_OPEN = "0";
	/** 是否启用Fix对接O32：1-不启用； */
	public static String ENABLE_FIX_PARAM_KEY_CLOSE = "1";
	/** 轮询结束时间-定时器开启Fix会话对象 */    
	private static Date endTime_fixOpenService4Timer = null;
	
	/** 本机的IP */
	public static String LOCAL_HOST_ADDRESS = "";
	/** 本机的名称 */
	public static String LOCAL_HOST_NAME = "";
	/** 当前classpath的绝对URI路径 */
	public static String CLASS_PATH = "";
	/** FIX文件存放路径 */
	public static String FIX_FILE_PATH = "";
	
	/** FIX连接类型：initiator */
	public static String FIX_O32_CONNECTION_TYPE = "initiator";
	/** FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）] */
	public static String FIX_O32_SOCKET_CONNECT_HOST = "172.19.8.11";
	/** FIX服务端-指令下达会话端口：17201 */
	public static String FIX_O32_SOCKET_CONNECT_PORT_INSTRIMPORT = "17201";
	/** FIX服务端端口-指令状态反馈会话：17202 */
	public static String FIX_O32_SOCKET_CONNECT_PORT_INSTRBACK = "17202";
	/** FIX服务端端口-指令委托反馈会话：17203 */
	public static String FIX_O32_SOCKET_CONNECT_PORT_ENTRUSTBACK = "17203";
	/** FIX服务端端口-指令成交反馈会话：17204 */
	public static String FIX_O32_SOCKET_CONNECT_PORT_DEALBACK = "17204";
	/** FIX服务端端口-指令查询反馈会话：17205 */
	public static String FIX_O32_SOCKET_CONNECT_PORT_FIXQUERY = "17205";
	/**【新】FIX服务端-指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话端口：17201 */
	public static String FIX_O32_SOCKET_CONNECT_PORT_INSTRUCTION = "17201";
	/** FIX默认版本号：FIX.4.2 */
	public static String FIX_DEFAULT_BEGIN_STRING = "FIX.4.2";
	
	/** Fix指令下达会话对象 */
	public static SocketInitiator initiator_instrimport = null;
	/** Fix指令状态反馈会话对象 */
	public static SocketInitiator initiator_instrback = null;
	/** Fix指令委托反馈会话对象 */
	public static SocketInitiator initiator_entrustback = null;
	/** Fix指令成交反馈会话对象 */
	public static SocketInitiator initiator_dealback = null;
	/** Fix指令查询反馈会话对象 */
	public static SocketInitiator initiator_fixquery = null;
	/** 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象 */
	public static SocketInitiator initiator_instruction = null;
	
	/** Fix指令下达会话对象 */
	public static SessionID instrimport_sessionID = null;
	/** Fix指令状态反馈会话对象 */
	public static SessionID instrback_sessionID = null;
	/** Fix指令委托反馈会话对象 */
	public static SessionID entrustback_sessionID = null;
	/** Fix指令成交反馈会话对象 */
	public static SessionID dealback_sessionID = null;
	/** Fix指令查询反馈会话对象 */
	public static SessionID fixquery_sessionID = null;
	/** 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象 */
	public static SessionID instruction_sessionID = null;
	
	/** Fix指令下达会话对象配置参数 */
	public static Map<String,String> instrimport_session_conf = null;
	/** Fix指令状态反馈会话对象配置参数 */
	public static Map<String,String> instrback_session_conf = null;
	/** Fix指令委托反馈会话对象配置参数 */
	public static Map<String,String> entrustback_session_conf = null;
	/** Fix指令成交反馈会话对象配置参数 */
	public static Map<String,String> dealback_session_conf = null;
	/** Fix指令查询反馈会话对象配置参数 */
	public static Map<String,String> fixquery_session_conf = null;
	/** 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象配置参数 */
	public static Map<String,String> instruction_session_conf = null;
	
	/** 指令状态、成交数据反馈接口查询次数 */
	public static int EXECUTION_REPORT_QUERY_TIME = 15;
	/** 指令状态、成交数据反馈接口查询等待时间（毫秒） */
	public static int EXECUTION_REPORT_WAIT_TIME = 1000;
	
	public static final String REASON_SPLIT = "★";
	/** 回购交易回购期限(天)对应的申报代码为空时返回消息：回购期限(天)对应的申报代码为空  */
	public static final String VC_REPORT_CODE_IS_EMPTY ="回购期限(天)对应的申报代码为空";
	/** 默认投资经理，当实时查询O32系统获取投资经理报错时，从缓存中获取默认投资经理  */
	public static final String ZHFWPT_DEFAULT_SENDERSUBID ="ZHFWPT_DEFAULT_SENDERSUBID";
	
	static {
		String os = System.getProperty("os.name");
		Enumeration<NetworkInterface> netInterfaces = null;
		try {
		    netInterfaces = NetworkInterface.getNetworkInterfaces();
		    while (netInterfaces.hasMoreElements()) {
		        NetworkInterface ni = netInterfaces.nextElement();
		        if(ni.isLoopback() || ni.isVirtual() || !ni.isUp()){
		        	continue;
		        }
//                for (InterfaceAddress address : ni.getInterfaceAddresses()){
//                	 if (address.getAddress() instanceof Inet4Address) {
//                		 Inet4Address inet4Address = (Inet4Address) address.getAddress();
//                		 System.out.println("===================="+inet4Address.getHostAddress()+"==========================");
//                	 }
//                }
                Enumeration<InetAddress> ips = ni.getInetAddresses();
                while (ips.hasMoreElements()) {
	            	InetAddress  ip = (InetAddress) ips.nextElement();
	                if( ip.isSiteLocalAddress() && !ip.isLoopbackAddress() && ip.getHostAddress().indexOf(":")==-1){
	                	LOCAL_HOST_ADDRESS = ip.getHostAddress();
	                	LOCAL_HOST_NAME = ip.getHostName();
	                }
                }
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		
		if(StringUtils.isNotEmpty(os) && os.toLowerCase().startsWith("win")){
			CLASS_PATH = FixToUtil.class.getResource("/").getPath().substring(1);
			try {
				InetAddress ia = InetAddress.getLocalHost();
				LOCAL_HOST_NAME = ia.getHostName();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
		}else{
			CLASS_PATH = FixToUtil.class.getResource("/").getPath();
		}
		FIX_FILE_PATH = CLASS_PATH + "com" + File.separator + "cjhxfund" + File.separator + "foundation" + File.separator + "fix" + File.separator;
    	System.out.println("操作系统："+os+"   本机IP："+LOCAL_HOST_ADDRESS+"   本机名称："+LOCAL_HOST_NAME);
	}
	
	
	/**
	 * 指令是否使用转换机进行推送O32[判断条件：fix是否启用(0-启用；1-不启用)、对应产品是否配置使用fix]
	 * @param productCode 产品代码
	 * @return
	 * @author liuyulong
	 */
	@Bizlet("")
	public static boolean fixEnbleStatus(String productCode){
		//获取系统参数中是否启用Fix对接O32：“0-启用”（0-启用；1-不启用；）
		String fixEnable = ParamConfig.getValue(FixToUtil.ENABLE_FIX_PARAM_KEY);
		if("0".equals(fixEnable)){
			//fix可用的情况下判断对应的产品是否配置了使用fix推送O32
			DataObject paramObj =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");
			paramObj.setString("vcProductId", productCode);
			paramObj.setString("vcConfCode", "2");//产品参数代码：此代码对应于产品参数字典中的 “交易自动推送O32”字典项
			DataObject obj = (DataObject) CacheUtil.getValue(FixToUtil.PRODUCT_CONF, paramObj);
			if(obj != null && "0".equals(obj.getString("vcConfValue"))){
				return false;
			}else{
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 定时器开启Fix会话对象（需在恒生转换机启动之后再启动）
	 * Fix会话对象开启成功后同步将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认3分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认10:00
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean fixOpenService4Timer(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  定时器开启Fix会话对象开始...");
		//是否调用成功
		boolean isSuccess = false;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = 3;
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FixToUtil.fixOpenService4Timer fail: 轮询间隔时间格式错误，取默认3分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认3分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认10:00
			String date = DateUtil.currentDateDefaultString();
			endTime_fixOpenService4Timer = DateUtil.parse(date+" 10:00:00", DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					endTime_fixOpenService4Timer = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("FixToUtil.fixOpenService4Timer fail: 轮询结束时间格式错误，取默认10:00！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认10:00！", null, new Object[]{});
			}
			
			//获取主服务器IP地址
			String mainServerAddress = ParamConfig.getValue("ZHFWPT_SERVER_MAIN_ADDRESS");
			//获取FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
			String fixO32SocketConnectHost = ParamConfig.getValue("ZHFWPT_FIX_O32_SOCKET_CONNECT_HOST");
			
			while(execute){
				//获取Fix会话对象开启是否成功
				boolean isSuccess_fix = fixOpenService(mainServerAddress, fixO32SocketConnectHost, null);
				
				//若Fix会话对象开启失败，则等待轮询间隔时间后继续执行开启
				if(!isSuccess_fix){
					fixCloseServiceCommon();//关闭Fix会话对象（若不关闭，Fix引擎会一直尝试连接）
					Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
					if(DateUtil.currentDate().after(endTime_fixOpenService4Timer)){//若当前系统时间大于轮询结束时间，则跳出循环
						execute = false;
					}
					
				//若Fix会话对象开启成功，则同步将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
				}else{
					
					//将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
					boolean isSuccess_update = ParamConfig.updateParamValueByParamKey(FixToUtil.ENABLE_FIX_PARAM_KEY, FixToUtil.ENABLE_FIX_PARAM_KEY_OPEN);
					//重新加载缓存
					boolean isSuccess_reload = ParamConfig.reloadCacheByName(null);
					//更新标志位跳出循环
					execute = false;
					
					//是否调用成功
					isSuccess = isSuccess_update && isSuccess_reload;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(DateUtil.currentDateTimeString()+"  定时器开启Fix会话对象结束!!!"+(isSuccess==true?"【成功】":"【失败】"));
		return isSuccess;
	}
	
	/**
	 * 【新】定时器开启Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象（需在恒生转换机启动之后再启动）
	 * Fix会话对象开启成功后同步将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认3分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认10:00
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean fixOpenServiceInstruction4Timer(String pIntervalTime, String pEndTime){
		System.out.println(DateUtil.currentDateTimeString()+"  【新】定时器开启Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象开始...");
		//是否调用成功
		boolean isSuccess = false;
		boolean execute = true;
		try {
			//获取轮询间隔时间，为空或格式错误时取默认3分钟
			int intervalTime = 3;
			if(StringUtils.isNotBlank(pIntervalTime)){
				try {
					intervalTime = Integer.valueOf(pIntervalTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FixToUtil.fixOpenServiceInstruction4Timer fail: 轮询间隔时间格式错误，取默认3分钟！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询间隔时间为空，取默认3分钟！", null, new Object[]{});
			}
			
			//获取轮询结束时间，为空或格式错误时取默认10:00
			String date = DateUtil.currentDateDefaultString();
			endTime_fixOpenService4Timer = DateUtil.parse(date+" 10:00:00", DateUtil.YMDHMS_PATTERN);
			if(StringUtils.isNotBlank(pEndTime)){
				try {
					endTime_fixOpenService4Timer = DateUtil.parse(date+" "+pEndTime.trim()+":00", DateUtil.YMDHMS_PATTERN);
				} catch (Exception e) {
					LogUtil.logError("FixToUtil.fixOpenServiceInstruction4Timer fail: 轮询结束时间格式错误，取默认10:00！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("轮询结束时间为空，取默认10:00！", null, new Object[]{});
			}
			
			//获取主服务器IP地址
			String mainServerAddress = ParamConfig.getValue("ZHFWPT_SERVER_MAIN_ADDRESS");
			//获取FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
			String fixO32SocketConnectHost = ParamConfig.getValue("ZHFWPT_FIX_O32_SOCKET_CONNECT_HOST");
			
			while(execute){
				Long beforeTime=(new Date()).getTime();
				
				//获取Fix会话对象开启是否成功
				boolean isSuccess_fix = fixOpenServiceInstruction(mainServerAddress, fixO32SocketConnectHost, null);
				
				Long afterTime=(new Date()).getTime();
				String className=Thread.currentThread().getStackTrace()[1].getClassName();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
				//若Fix会话对象开启失败，则等待轮询间隔时间后继续执行开启
				if(!isSuccess_fix){
					fixCloseServiceCommon();//关闭Fix会话对象（若不关闭，Fix引擎会一直尝试连接）
					Thread.sleep(intervalTime * 60000);//暂停设定的轮询间隔时间
					if(DateUtil.currentDate().after(endTime_fixOpenService4Timer)){//若当前系统时间大于轮询结束时间，则跳出循环
						execute = false;
					}
					
				//若Fix会话对象开启成功，则同步将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
				}else{
					
					//将是否启用Fix对接O32设置为“0-启用”（0-启用；1-不启用；）
					boolean isSuccess_update = ParamConfig.updateParamValueByParamKey(FixToUtil.ENABLE_FIX_PARAM_KEY, FixToUtil.ENABLE_FIX_PARAM_KEY_OPEN);
					//重新加载缓存
					boolean isSuccess_reload = ParamConfig.reloadCacheByName(null);
					//更新标志位跳出循环
					execute = false;
					
					//是否调用成功
					isSuccess = isSuccess_update && isSuccess_reload;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(DateUtil.currentDateTimeString()+"  【新】定时器开启Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象结束!!!"+(isSuccess==true?"【成功】":"【失败】"));
		return isSuccess;
	}
	
	/**
	 * Fix会话对象开启（需在恒生转换机启动之后再启动）
	 * @param mainServerAddress 主服务器IP地址
	 * @param fixO32SocketConnectHost FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
	 * @param executionReportQueryTime 指令状态、成交数据反馈接口查询次数，为空或格式错误时取默认15次
	 * @return
	 * @throws ConfigError
	 * @throws InterruptedException
	 * @throws SessionNotFound
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean fixOpenService(String mainServerAddress, String fixO32SocketConnectHost, String executionReportQueryTime) throws ConfigError, InterruptedException, SessionNotFound{
		//是否调用成功
		boolean isSuccess = false;
		try {
			//设置Fix会话连接参数
			setFixSessionConf(mainServerAddress, fixO32SocketConnectHost);
			
			//获取指令状态、成交数据反馈接口查询次数，为空或格式错误时取默认15次
			if(StringUtils.isNotBlank(executionReportQueryTime)){
				try {
					EXECUTION_REPORT_QUERY_TIME = Integer.valueOf(executionReportQueryTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FixToUtil.fixOpenService fail: 指令状态、成交数据反馈接口查询次数格式错误，取默认15次！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("指令状态、成交数据反馈接口查询次数为空，取默认15次！", null, new Object[]{});
			}
			
			//Fix会话对象关闭（需在恒生转换机关闭之前先关闭），启动Fix会话之前，若之前会话存在，则先关闭之前会话.
			fixCloseServiceCommon();
			
			//创建信息工厂类
			DefaultMessageFactory msgFactory = new DefaultMessageFactory();
			List<Map<String,String>> sessionConfList = new ArrayList<Map<String,String>>();
			
			//Fix指令导入 客户端会话开启...
			FixToInstrImport instrimportApp = new FixToInstrImport();//Fix指令导入回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(instrimport_session_conf);
			FixToUtil.initiator_instrimport = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction_instrimport.cfg", instrimportApp, msgFactory);
			FixToUtil.initiator_instrimport.start();
			
			//Fix指令状态反馈 客户端会话开启...
			FixToInstrBack instrbackApp = new FixToInstrBack();   //Fix指令状态反馈回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(instrback_session_conf);
			FixToUtil.initiator_instrback = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction_instrback.cfg", instrbackApp, msgFactory);
			FixToUtil.initiator_instrback.start();
			
			//Fix指令委托反馈 客户端会话开启...
			FixToEntrustBack entrustbackApp = new FixToEntrustBack();//Fix指令委托反馈回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(entrustback_session_conf);
			FixToUtil.initiator_entrustback = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction_entrustback.cfg", entrustbackApp, msgFactory);
			FixToUtil.initiator_entrustback.start();
			
			//Fix指令成交反馈 客户端会话开启...
			FixToDealBack dealbackApp = new FixToDealBack(); //Fix指令成交反馈回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(dealback_session_conf);
			FixToUtil.initiator_dealback = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction_dealback.cfg", dealbackApp, msgFactory);
			FixToUtil.initiator_dealback.start();
			
			//Fix指令查询反馈 客户端会话开启...
			FixToQuery fixqueryApp = new FixToQuery(); //Fix指令查询反馈回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(fixquery_session_conf);
			FixToUtil.initiator_fixquery = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction_fixquery.cfg", fixqueryApp, msgFactory);
			FixToUtil.initiator_fixquery.start();
			
			Thread.sleep(3000);//线程等待3秒钟，以准确判定是否连接成功
			
			System.out.println("*****fix init begin...********************************************************************");
			LogUtil.logInfo("*****fix init begin...********************************************************************", null, new Object[]{});
			System.out.println("本机IP是: " + LOCAL_HOST_ADDRESS + "   本机名称是: " + LOCAL_HOST_NAME + "   系统参数配置的主服务器IP地址: " + mainServerAddress + "   FIX服务端（O32转换机）连接IP地址: " + FIX_O32_SOCKET_CONNECT_HOST);
			LogUtil.logInfo("本机IP是: " + LOCAL_HOST_ADDRESS + "   本机名称是: " + LOCAL_HOST_NAME + "   系统参数配置的主服务器IP地址: " + mainServerAddress + "   FIX服务端（O32转换机）连接IP地址: " + FIX_O32_SOCKET_CONNECT_HOST, null, new Object[]{});
			boolean isOnLogon_instrimport = instrimportApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("Fix指令导入 客户端会话开启["+(isOnLogon_instrimport==true?"成功":"失败")+"]!!!   [BeginString="+instrimport_session_conf.get("beginString")+"  SenderCompID="+instrimport_session_conf.get("senderCompID")+"  TargetCompID="+instrimport_session_conf.get("targetCompID")+"]");
			boolean isOnLogon_instrback = instrbackApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("Fix指令状态反馈 客户端会话开启["+(isOnLogon_instrback==true?"成功":"失败")+"]!!!   [BeginString="+instrback_session_conf.get("beginString")+"  SenderCompID="+instrback_session_conf.get("senderCompID")+"  TargetCompID="+instrback_session_conf.get("targetCompID")+"]");
			boolean isOnLogon_entrustback = entrustbackApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("Fix指令委托反馈 客户端会话开启["+(isOnLogon_entrustback==true?"成功":"失败")+"]!!!   [BeginString="+entrustback_session_conf.get("beginString")+"  SenderCompID="+entrustback_session_conf.get("senderCompID")+"  TargetCompID="+entrustback_session_conf.get("targetCompID")+"]");
			boolean isOnLogon_dealback = dealbackApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("Fix指令成交反馈 客户端会话开启["+(isOnLogon_dealback==true?"成功":"失败")+"]!!!   [BeginString="+dealback_session_conf.get("beginString")+"  SenderCompID="+dealback_session_conf.get("senderCompID")+"  TargetCompID="+dealback_session_conf.get("targetCompID")+"]");
			boolean isOnLogon_fixquery = fixqueryApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("Fix指令查询反馈 客户端会话开启["+(isOnLogon_fixquery==true?"成功":"失败")+"]!!!   [BeginString="+fixquery_session_conf.get("beginString")+"  SenderCompID="+fixquery_session_conf.get("senderCompID")+"  TargetCompID="+fixquery_session_conf.get("targetCompID")+"]");
			LogUtil.logInfo("*****fix init end!!!********************************************************************", null, new Object[]{});
			System.out.println("*****fix init end!!!********************************************************************");
			
			//设置调用是否成功
			isSuccess = isOnLogon_instrimport && isOnLogon_instrback && isOnLogon_entrustback && isOnLogon_dealback && isOnLogon_fixquery;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/**
	 * 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象开启（需在恒生转换机启动之后再启动）
	 * @param mainServerAddress 主服务器IP地址
	 * @param fixO32SocketConnectHost FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
	 * @param executionReportQueryTime 指令状态、成交数据反馈接口查询次数，为空或格式错误时取默认15次
	 * @return
	 * @throws ConfigError
	 * @throws InterruptedException
	 * @throws SessionNotFound
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean fixOpenServiceInstruction(String mainServerAddress, String fixO32SocketConnectHost, String executionReportQueryTime) throws ConfigError, InterruptedException, SessionNotFound{
		//是否调用成功
		boolean isSuccess = false;
		try {
			//【新】设置Fix会话连接参数
			setFixSessionConfInstruction(mainServerAddress, fixO32SocketConnectHost);
			
			//获取指令状态、成交数据反馈接口查询次数，为空或格式错误时取默认15次
			if(StringUtils.isNotBlank(executionReportQueryTime)){
				try {
					EXECUTION_REPORT_QUERY_TIME = Integer.valueOf(executionReportQueryTime.trim());
				} catch (NumberFormatException e) {
					LogUtil.logError("FixToUtil.fixOpenServiceInstruction fail: 指令状态、成交数据反馈接口查询次数格式错误，取默认15次！", e, new Object[]{});
				}
			}else{
				LogUtil.logInfo("指令状态、成交数据反馈接口查询次数为空，取默认15次！", null, new Object[]{});
			}
			
			//Fix会话对象关闭（需在恒生转换机关闭之前先关闭），启动Fix会话之前，若之前会话存在，则先关闭之前会话.
			fixCloseServiceCommon();
			
			//【新】创建信息工厂类
			DefaultMessageFactory msgFactory = new DefaultMessageFactory();
			List<Map<String,String>> sessionConfList = new ArrayList<Map<String,String>>();
			
			//【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后 客户端会话开启...
			FixToInstruction instructionApp = new FixToInstruction();//【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(instruction_session_conf);
			FixToUtil.initiator_instruction = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction.cfg", instructionApp, msgFactory);
			FixToUtil.initiator_instruction.start();
			
			//Fix指令查询反馈 客户端会话开启...
			FixToQuery fixqueryApp = new FixToQuery(); //Fix指令查询反馈回调类
			sessionConfList.clear();//清空会话配置参数列表
			sessionConfList.add(fixquery_session_conf);
			FixToUtil.initiator_fixquery = getSocketInitiator(sessionConfList, "FixTo_hsfix_instruction_fixquery.cfg", fixqueryApp, msgFactory);
			FixToUtil.initiator_fixquery.start();
			
			Thread.sleep(3000);//线程等待3秒钟，以准确判定是否连接成功
			
			System.out.println("*****[new]fix init begin...********************************************************************");
			LogUtil.logInfo("*****[new]fix init begin...********************************************************************", null, new Object[]{});
			System.out.println("本机IP是: " + LOCAL_HOST_ADDRESS + "   本机名称是: " + LOCAL_HOST_NAME + "   系统参数配置的主服务器IP地址: " + mainServerAddress + "   FIX服务端（O32转换机）连接IP地址: " + FIX_O32_SOCKET_CONNECT_HOST);
			LogUtil.logInfo("本机IP是: " + LOCAL_HOST_ADDRESS + "   本机名称是: " + LOCAL_HOST_NAME + "   系统参数配置的主服务器IP地址: " + mainServerAddress + "   FIX服务端（O32转换机）连接IP地址: " + FIX_O32_SOCKET_CONNECT_HOST, null, new Object[]{});
			boolean isOnLogon_instruction = instructionApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后 客户端会话开启["+(isOnLogon_instruction==true?"成功":"失败")+"]!!!   [BeginString="+instruction_session_conf.get("beginString")+"  SenderCompID="+instruction_session_conf.get("senderCompID")+"  TargetCompID="+instruction_session_conf.get("targetCompID")+"]");
			boolean isOnLogon_fixquery = fixqueryApp.getIsOnLogon();//是否连接成功并登录成功
			System.out.println("Fix指令查询反馈 客户端会话开启["+(isOnLogon_fixquery==true?"成功":"失败")+"]!!!   [BeginString="+fixquery_session_conf.get("beginString")+"  SenderCompID="+fixquery_session_conf.get("senderCompID")+"  TargetCompID="+fixquery_session_conf.get("targetCompID")+"]");
			LogUtil.logInfo("*****[new]fix init end!!!********************************************************************", null, new Object[]{});
			System.out.println("*****[new]fix init end!!!********************************************************************");
			
			//设置调用是否成功
			isSuccess = isOnLogon_instruction && isOnLogon_fixquery;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/**
	 * Fix会话对象关闭（需在恒生转换机关闭之前先关闭）
	 * 同时将是否启用Fix对接O32设置为“1-不启用”（0-启用；1-不启用；）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static boolean fixCloseService() throws ConfigError, InterruptedException, SessionNotFound{
		System.out.println(DateUtil.currentDateTimeString()+"  Fix会话对象关闭开始...");
		
		//是否调用成功
		boolean isSuccess = false;
		try{
			Long beforeTime=(new Date()).getTime();
			
			//关闭Fix会话对象
			fixCloseServiceCommon();
			
			//将是否启用Fix对接O32设置为“1-不启用”（0-启用；1-不启用；）
			boolean isSuccess_update = ParamConfig.updateParamValueByParamKey(FixToUtil.ENABLE_FIX_PARAM_KEY, FixToUtil.ENABLE_FIX_PARAM_KEY_CLOSE);
			//重新加载缓存
			boolean isSuccess_reload = ParamConfig.reloadCacheByName(null);
			
			//将“定时器开启Fix会话对象-轮询结束时间”设置为当前时间，以便于定时器即时退出循环
			endTime_fixOpenService4Timer = DateUtil.getNow();
			
			//是否调用成功
			isSuccess = isSuccess_update && isSuccess_reload;
			
			Long afterTime=(new Date()).getTime();
			String className=Thread.currentThread().getStackTrace()[1].getClassName();
			String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
			QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		System.out.println(DateUtil.currentDateTimeString()+"  Fix会话对象关闭结束!!!"+(isSuccess==true?"【成功】":"【失败】"));
		return isSuccess;
	}
	
	/**
	 * 【公共调用方法】Fix会话对象关闭（需在恒生转换机关闭之前先关闭）
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void fixCloseServiceCommon(){
		try{
			if(FixToUtil.initiator_instrimport != null){
				FixToUtil.initiator_instrimport.stop();//Fix指令下达客户端会话关闭!!!
			}
			if(FixToUtil.initiator_instrback != null){
				FixToUtil.initiator_instrback.stop();//Fix指令状态反馈客户端会话关闭!!!
			}
			if(FixToUtil.initiator_entrustback != null){
				FixToUtil.initiator_entrustback.stop();//Fix指令委托反馈客户端会话关闭!!!
			}
			if(FixToUtil.initiator_dealback != null){
				FixToUtil.initiator_dealback.stop();//Fix指令成交反馈客户端会话关闭!!!
			}
			if(FixToUtil.initiator_fixquery != null){
				FixToUtil.initiator_fixquery.stop();//Fix指令查询反馈客户端会话关闭!!!
			}
			if(FixToUtil.initiator_instruction != null){
				FixToUtil.initiator_instruction.stop();//【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话关闭!!!
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取第三方系统指令编号，全程唯一，已有指令结束归档后该编号可以再使用。
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static synchronized String getClOrdID(){
		return DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSSS_NUMBER);
	}
	
	/**
	 * 设置Fix会话连接参数
	 * @param mainServerAddress 主服务器IP地址
	 * @param fixO32SocketConnectHost FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void setFixSessionConf(String mainServerAddress, String fixO32SocketConnectHost){
		//设置FIX服务端（O32转换机）连接IP地址
		if(StringUtils.isNotBlank(fixO32SocketConnectHost)){
			FIX_O32_SOCKET_CONNECT_HOST = fixO32SocketConnectHost;
		}
		//本机为主服务器
		if(LOCAL_HOST_ADDRESS.equalsIgnoreCase(mainServerAddress)){
			
			/** Fix指令下达会话对象配置参数 */
			instrimport_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_INSTRIMPORT, FIX_DEFAULT_BEGIN_STRING, "SBI1", null, null, "SBI0", null, null, null);
			/** Fix指令状态反馈会话对象配置参数 */
			instrback_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_INSTRBACK, FIX_DEFAULT_BEGIN_STRING, "SBI3", null, null, "SBI2", null, null, null);
			/** Fix指令委托反馈会话对象配置参数 */
			entrustback_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_ENTRUSTBACK, FIX_DEFAULT_BEGIN_STRING, "SBI5", null, null, "SBI4", null, null, null);
			/** Fix指令成交反馈会话对象配置参数 */
			dealback_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_DEALBACK, FIX_DEFAULT_BEGIN_STRING, "SBI7", null, null, "SBI6", null, null, null);
			/** Fix指令查询反馈会话对象配置参数 */
			fixquery_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_FIXQUERY, FIX_DEFAULT_BEGIN_STRING, "SBI9", null, null, "SBI8", null, null, null);
			
		//本机为从（备）服务器
		}else{
			
			/** Fix指令下达会话对象配置参数 */
			instrimport_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_INSTRIMPORT, FIX_DEFAULT_BEGIN_STRING, "SBI11", null, null, "SBI0", null, null, null);
			/** Fix指令状态反馈会话对象配置参数 */
			instrback_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_INSTRBACK, FIX_DEFAULT_BEGIN_STRING, "SBI13", null, null, "SBI2", null, null, null);
			/** Fix指令委托反馈会话对象配置参数 */
			entrustback_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_ENTRUSTBACK, FIX_DEFAULT_BEGIN_STRING, "SBI15", null, null, "SBI4", null, null, null);
			/** Fix指令成交反馈会话对象配置参数 */
			dealback_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_DEALBACK, FIX_DEFAULT_BEGIN_STRING, "SBI17", null, null, "SBI6", null, null, null);
			/** Fix指令查询反馈会话对象配置参数 */
			fixquery_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_FIXQUERY, FIX_DEFAULT_BEGIN_STRING, "SBI19", null, null, "SBI8", null, null, null);
		}
	}
	
	/**
	 * 【新】设置Fix会话连接参数（Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话）
	 * @param mainServerAddress 主服务器IP地址
	 * @param fixO32SocketConnectHost FIX服务端（O32转换机）连接IP地址：172.19.8.11 [O32转换机（主）]、172.19.8.12 [O32转换机（备）]
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void setFixSessionConfInstruction(String mainServerAddress, String fixO32SocketConnectHost){
		//设置FIX服务端（O32转换机）连接IP地址
		if(StringUtils.isNotBlank(fixO32SocketConnectHost)){
			FIX_O32_SOCKET_CONNECT_HOST = fixO32SocketConnectHost;
		}
		//本机为主服务器
		if(LOCAL_HOST_ADDRESS.equalsIgnoreCase(mainServerAddress)){
			
			/** 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象配置参数 */
			instruction_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_INSTRUCTION, FIX_DEFAULT_BEGIN_STRING, "SBI1", null, null, "SBI0", null, null, null);
			/** Fix指令查询反馈会话对象配置参数 */
			fixquery_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_FIXQUERY, FIX_DEFAULT_BEGIN_STRING, "SBI9", null, null, "SBI8", null, null, null);
			
		//本机为从（备）服务器
		}else{
			
			/** 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象配置参数 */
			instruction_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_INSTRUCTION, FIX_DEFAULT_BEGIN_STRING, "SBI3", null, null, "SBI2", null, null, null);
			/** Fix指令查询反馈会话对象配置参数 */
			fixquery_session_conf = getFixSessionConfMap(FIX_O32_CONNECTION_TYPE, FIX_O32_SOCKET_CONNECT_HOST, FIX_O32_SOCKET_CONNECT_PORT_FIXQUERY, FIX_DEFAULT_BEGIN_STRING, "SBI7", null, null, "SBI6", null, null, null);
		}
	}
	
	/**
	 * 获取Fix会话配置参数Map对象
	 * @param connectionType 连接类型：initiator 或 acceptor
	 * @param socketConnectHost 连接对方主机IP
	 * @param socketConnectPort 连接对方主机端口号
	 * @param beginString Fix版本号
	 * @param senderCompID
	 * @param senderSubID
	 * @param senderLocationID
	 * @param targetCompID
	 * @param targetSubID
	 * @param targetLocationID
	 * @param sessionQualifier
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static Map<String,String> getFixSessionConfMap(String connectionType, String socketConnectHost, String socketConnectPort, String beginString, String senderCompID, String senderSubID, String senderLocationID, String targetCompID, String targetSubID, String targetLocationID, String sessionQualifier){
		Map<String,String> map = new HashMap<String,String>();
		map.put("connectionType", connectionType);
		map.put("socketConnectHost", socketConnectHost);
		map.put("socketConnectPort", socketConnectPort);
		map.put("beginString", beginString);
		map.put("senderCompID", senderCompID);
		map.put("senderSubID", senderSubID);
		map.put("senderLocationID", senderLocationID);
		map.put("targetCompID", targetCompID);
		map.put("targetSubID", targetSubID);
		map.put("targetLocationID", targetLocationID);
		map.put("sessionQualifier", sessionQualifier);
		return map;
	}
	
	/**
	 * 根据最新配置参数重新加载会话配置对象
	 * @param sessionSettings 会话配置对象 
	 * @param sessionConfList 会话配置参数列表（connectionType, socketConnectHost, socketConnectPort, beginString, senderCompID, senderSubID, senderLocationID, targetCompID, targetSubID, targetLocationID, sessionQualifier）
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void reloadSessionSettings(SessionSettings sessionSettings, List<Map<String,String>> sessionConfList){
		if(!sessionConfList.isEmpty() && sessionConfList.size()>0){
			for(int i=0; i<sessionConfList.size(); i++){
				Map<String,String> sessionConfMap = sessionConfList.get(i);
				SessionID sessionID = getSessionID(sessionConfMap);//新建Fix会话
				sessionSettings.setString(sessionID, "ConnectionType", sessionConfMap.get("connectionType"));//设置FIX连接类型：initiator
				sessionSettings.setString(sessionID, "SocketConnectHost", sessionConfMap.get("socketConnectHost"));//设置FIX服务端（O32转换机）连接IP地址
				sessionSettings.setString(sessionID, "SocketConnectPort", sessionConfMap.get("socketConnectPort"));//设置FIX服务端（O32转换机）端口
			}
		}
	}
	
	/**
	 * 获取SocketInitiator连接引擎
	 * @param sessionConfList 会话配置参数列表
	 * @param cfgFile 配置文件
	 * @param application 应用对象
	 * @param defaultMessageFactory 消息工厂对象
	 * @return
	 * @throws ConfigError
	 * @throws InterruptedException
	 * @throws SessionNotFound
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SocketInitiator getSocketInitiator(List<Map<String,String>> sessionConfList, String cfgFile, Application application, DefaultMessageFactory defaultMessageFactory) throws ConfigError, InterruptedException, SessionNotFound{
		/** 读取配置文件参数并创建会话 */
		SessionSettings sessionSettings = new SessionSettings(FIX_FILE_PATH + "conf" + File.separator + cfgFile);
		/** 根据最新配置参数重新加载会话配置对象 */
		reloadSessionSettings(sessionSettings, sessionConfList);
		FileStoreFactory fileStoreFactory = new FileStoreFactory(sessionSettings);
		LogFactory logFactory = new FileLogFactory(sessionSettings);
		SocketInitiator socketInitiator = new SocketInitiator(application, fileStoreFactory, sessionSettings, logFactory, defaultMessageFactory);
		return socketInitiator;
	}
	
	/**
	 * 根据配置参数获取Session会话
	 * @param sessionConf 配置参数（connectionType, socketConnectHost, socketConnectPort, beginString, senderCompID, senderSubID, senderLocationID, targetCompID, targetSubID, targetLocationID, sessionQualifier）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getSessionID(Map<String,String> sessionConf){
		SessionID sessionID = null;
		if(!sessionConf.isEmpty()){
			sessionID = new SessionID(sessionConf.get("beginString"), sessionConf.get("senderCompID"), sessionConf.get("senderSubID"), sessionConf.get("senderLocationID"), sessionConf.get("targetCompID"), sessionConf.get("targetSubID"), sessionConf.get("targetLocationID"), sessionConf.get("sessionQualifier"));
		}else{
			sessionID = new SessionID();
		}
		return sessionID;
	}
	
	/**
	 * 获取Fix指令下达会话对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getInstrImportSessionID(){
		if(FixToUtil.instrimport_sessionID == null){
			FixToUtil.instrimport_sessionID = getSessionID(FixToUtil.instrimport_session_conf);
		}
		return FixToUtil.instrimport_sessionID;
	}
	
	/**
	 * 获取Fix指令状态反馈会话对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getInstrBackSessionID(){
		if(FixToUtil.instrback_sessionID == null){
			FixToUtil.instrback_sessionID = getSessionID(FixToUtil.instrback_session_conf);
		}
		return FixToUtil.instrback_sessionID;
	}
	
	/**
	 * 获取Fix指令委托反馈会话对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getEntrustBackSessionID(){
		if(FixToUtil.entrustback_sessionID == null){
			FixToUtil.entrustback_sessionID = getSessionID(FixToUtil.entrustback_session_conf);
		}
		return FixToUtil.entrustback_sessionID;
	}
	
	/**
	 * 获取Fix指令成交反馈会话对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getDealBackSessionID(){
		if(FixToUtil.dealback_sessionID == null){
			FixToUtil.dealback_sessionID = getSessionID(FixToUtil.dealback_session_conf);
		}
		return FixToUtil.dealback_sessionID;
	}
	
	/**
	 * 获取Fix指令查询反馈会话对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getFixQuerySessionID(){
		if(FixToUtil.fixquery_sessionID == null){
			FixToUtil.fixquery_sessionID = getSessionID(FixToUtil.fixquery_session_conf);
		}
		return FixToUtil.fixquery_sessionID;
	}
	
	/**
	 * 【新】获取Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的会话对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static SessionID getInstructionSessionID(){
		if(FixToUtil.instruction_sessionID == null){
			FixToUtil.instruction_sessionID = getSessionID(FixToUtil.instruction_session_conf);
		}
		return FixToUtil.instruction_sessionID;
	}
	
	/**
	 * 将xml字符串转换成map
	 * @param xml
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
    public static Map<String,String> readStringXmlOut(String xml){
        Map<String,String> map = new HashMap<String,String>();
        Document doc = null;
        String reason = "";
        int reasonCount = 0;
        try {
        	if(StringUtils.isBlank(xml)){
        		return map;
        	}
        	if(!xml.startsWith("<")){
        		xml = xml.substring(xml.indexOf("<"));
        	}
            doc = DocumentHelper.parseText(xml);//将字符串转为XML
            Element rootElt = doc.getRootElement();//获取根节点
            
            for(Iterator<?> i=rootElt.elementIterator(); i.hasNext(); ){
	            Element employee = (Element) i.next();
	            for(Iterator<?> j=employee.elementIterator(); j.hasNext(); ){
		            Element node = (Element) j.next();
		            //System.out.println(node.getName()+":"+node.getText());
		            
		            if(StringUtils.isEmpty(reason)){
	                	reason = node.getText();
	                }else{
	                	reason = reason + FixToUtil.REASON_SPLIT + node.getText();
	                }
		            reasonCount++;
	            }
            }
            map.put("failReasonType", rootElt.attributeValue("type"));
            map.put("reasonCount", String.valueOf(reasonCount));
            map.put("reason", reason);
            
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
	
	/**
	 * 根据传入的天数查询回购期限(天)对应的申报代码
	 * @param l_ratio 天数
	 * @return 回购期限(天)对应的申报代码
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String queryReportCode(String l_ratio){
		String ratio = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		try{
			//回购天数对应的回购申报代码
			sb.append("select b.vc_report_code ")
			  .append("  from trade.thgratio a, trade.tstockinfo b ")
			  .append(" where a.vc_inter_code = b.vc_inter_code ")
			  .append("   and b.c_market_no = '5' ")
			  .append("   and a.c_parameter_type = '1' ")
			  .append("   and a.l_ratio = '" + StrUtil.changeNull(l_ratio) + "' ");//回购天数
			
			conn = JDBCUtil.getConnByDataSourceId(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName());
			ratio = JDBCUtil.getValueBySql(conn, sb.toString());
			
			//判断回购期限(天)对应的申报代码是否为空
			if(StringUtils.isBlank(ratio)){
				return VC_REPORT_CODE_IS_EMPTY;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return ratio;
	}
	
	/**
	 * 获取FIX指令下达到O32的产品对应的操作员编号
	 * 先从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
	 * @param vcProductCode 产品代码
	 * @return 产品对应O32的操作员代码，如1063-金依文；1093-张贺章；
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getO32OperatorNo(String vcProductCode){
		String sendersubid = null;
		DataObject paramObj =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		paramObj.setString("vcProductId", vcProductCode);
		paramObj.setString("vcConfCode", "3");//产品参数代码：此代码对应于产品参数字典中的 “3-交易自动推送O32”字典项
		DataObject sendersub = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue(FixToUtil.PRODUCT_CONF, paramObj);
		//从机器猫配置的产品参数获取产品对应O32的投资经理
		if(sendersub != null && StringUtils.isNotBlank(sendersub.getString("vcConfValue"))){
			sendersubid = sendersub.getString("vcConfValue");
		//机器猫产品参数获取不到，则再实时到O32去获取该产品实际的投资经理
		}else{
			sendersubid = FixToUtil.queryOperatorNo(vcProductCode, null);
		}
		return sendersubid;
	}
	
	
	/**
	 * 获取FIX指令下达到O32的产品对应的操作员编号
	 * 首先根据传入投资经理中文获取对应编号 若无 则 从机器猫配置的产品参数获取产品对应O32的投资经理，若参数获取不到，则再实时到O32去获取该产品实际的投资经理
	 * @param vcProductCode 产品代码
	 * @param vcOperatorName 投资经理中文名称
	 * @return 产品对应O32的操作员代码，如1063-金依文；1093-张贺章；
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getO32OperatorNo(String vcProductCode, String vcOperatorName){
		String sendersubid = null;
		DataObject paramObj =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		if(vcOperatorName!=null && !"".equals(vcOperatorName)){
			paramObj.setString("vcFundCode", vcProductCode);
			paramObj.setString("vcOperatorName", vcOperatorName);
			Object[] o32OperatorNos = DatabaseExt.queryByNamedSql(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName(),
					"com.cjhxfund.foundation.fix.model.interfaceMessageManager.getO32InvestManagerOperatorId",paramObj);
			if(o32OperatorNos.length>0){
				DataObject o32OperatorNo = (DataObject) o32OperatorNos[0];
				sendersubid = o32OperatorNo.getString("L_OPERATOR_NO");
			}
		}
		if(sendersubid == null){
			paramObj.setString("vcProductId", vcProductCode);
			paramObj.setString("vcConfCode", "3");//产品参数代码：此代码对应于产品参数字典中的 “3-交易自动推送O32”字典项
			DataObject sendersub = (DataObject) com.eos.foundation.eoscommon.CacheUtil.getValue(FixToUtil.PRODUCT_CONF, paramObj);
			//从机器猫配置的产品参数获取产品对应O32的投资经理
			if(sendersub != null && StringUtils.isNotBlank(sendersub.getString("vcConfValue"))){
				sendersubid = sendersub.getString("vcConfValue");
			//机器猫产品参数获取不到，则再实时到O32去获取该产品实际的投资经理
			}else{
				sendersubid = FixToUtil.queryOperatorNo(vcProductCode, null);
			}
		}
		return sendersubid;
	}
	
	
	/**
	 * 获取债券收益率类型
	 * @param vcStockCode 产品代码
	 * @param vcMarketNo 市场编号
	 * @return 债券收益率：1-到期收益率，2-行权收益率
	 * @author liuyulong
	 */
	@Bizlet("")
	public static String getO32BondYideldType(String vcStockCode, String vcMarketNo,String lFirstSettleDate){
		String bondYideldType = null;
		DataObject paramObj =  DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		paramObj.setString("vcStockCode", vcStockCode);
		paramObj.setString("cMarketNo", vcMarketNo);
		paramObj.setString("lFirstSettleDate", lFirstSettleDate);
		String dataSource=com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName();
		Object[] temp = DatabaseExt.queryByNamedSql(dataSource, "com.cjhxfund.foundation.fix.model.interfaceMessageManager.getBondYideldType", paramObj);
		LogUtil.logInfo("传入值：债券代码{0}、市场编号{1}，结算日期{2}，数据源{3}", null, vcStockCode,vcMarketNo,lFirstSettleDate,dataSource);
		if(temp.length> 0&& temp[0]!=null){
			LogUtil.logInfo("收益率查询结果:结果{0}", null, temp[0].toString());
			bondYideldType = temp[0].toString();
		}else{
			bondYideldType = "1";
		}
		return bondYideldType;
	}
	
	/**
	 * 根据传入的基金代码、操作员角色ID查询操作员编号
	 * @param vcFundCode 基金代码
	 * @param lRoleId 操作员角色ID，不传默认“2-投资经理”
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String queryOperatorNo(String vcFundCode, String lRoleId){
			String operatorNo = null;
			Connection conn = null;
			StringBuffer sb = new StringBuffer();
			try{
				if(StringUtils.isBlank(lRoleId)){
					lRoleId = "2";
				}
				
				/**
				 * toperator 	  系统操作员表
				 * toprolerights 操作员角色关系表
				 * tfundinfo	  基金产品信息表
				 * l_role_id 	  角色类型  : 2-投资经理;3-投资助理;
				 */
				sb.append("select distinct (a.l_operator_no) ")//
				  .append("  from trade.topfundright  a, ")//操作员基金权限表
				  .append("       trade.toperator     b, ")//系统操作员表
				  .append("       trade.toprolerights c, ")//操作员角色关系表
				  .append("       trade.tfundinfo     d ")//基金产品信息表
				  .append(" where a.l_fund_id = d.l_fund_id ")//基金序号
				  .append("   and a.l_operator_no = b.l_operator_no ")//
				  .append("   and a.l_operator_no = c.l_operator_no ")//
				  .append("   and instr(a.vc_rights, '2') > 0 ")//多个数字或字母的组合，没有分隔符：1：查询；2：操作，就是指令下达、证券调整、资金调整等（不再细分，结合菜单权限可以满足实际要求了）；3: 复核 能够复核该基金下达的指令等；4; 审批 拥有该基金的指令等的审批权限；
				  .append("   and b.c_operator_status = '1' ")//1-正常;
				  .append("   and c.l_role_id = '" + StrUtil.changeNull(lRoleId) + "' ")//2-投资经理;3-投资助理;
				  .append("   and d.vc_fund_code = '" + StrUtil.changeNull(vcFundCode) + "' ");//基金代码
				
				conn = JDBCUtil.getConnByDataSourceId(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName());
				operatorNo = JDBCUtil.getValueBySql(conn, sb.toString());
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				sb.setLength(0);
				sb = null;
				JDBCUtil.releaseResource(conn, null, null);
			}
		return operatorNo;
	}
	
	/**
	 * 通过关键字、产品代码、组合编号到O32系统查找产品、投资组合等信息
	 * @param searchKey 关键字
	 * @param productCodes 产品代码（为空则不过滤该条件）
	 * @param combiNos 投资组合编号（为空则不过滤该条件）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getProductCombisByKey(String searchKey, String productCodes, String combiNos){
		searchKey = searchKey==null?"":searchKey;
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct t1.vc_fund_code, ")//产品代码
			  .append("                t1.vc_fund_name, ")//产品名称
			  .append("                t1.vc_fund_code || '-' || t1.vc_fund_name fundCodeName, ")//产品代码+产品名称
			  .append("                t2.vc_combi_no, ")//投资组合编号
			  .append("                t2.vc_combi_name, ")//投资组合名称
			  .append("                t2.l_asset_id, ")//资产单元序号
			  .append("                t1.vc_fund_code || '|' || t1.vc_fund_name || '|' || t2.vc_combi_no || '|' || t2.vc_combi_name || '|' || t2.l_asset_id fundInfo ")//产品投资组合信息
			  .append("  from trade.tfundinfo t1, trade.tcombi t2 ")
			  .append(" where t1.l_fund_id = t2.l_fund_id ");
			  
			if(StringUtils.isNotBlank(searchKey)){
				sb.append("   and (t1.vc_fund_code like '%").append(searchKey).append("%' or t1.vc_fund_name like '%").append(searchKey).append("%' or t2.vc_combi_no like '%").append(searchKey).append("%' or t2.vc_combi_name like '%").append(searchKey).append("%') ");
			}
			if(StringUtils.isNotBlank(productCodes)){
				sb.append("   and t1.vc_fund_code in (").append(StrUtil.changeInStr(productCodes)).append(") ");
			}
			if(StringUtils.isNotBlank(combiNos)){
				sb.append("   and t2.vc_combi_no in (").append(StrUtil.changeInStr(combiNos)).append(") ");
			}
			//限制每次只查询20条记录
			sb.append("   and rownum <= 20 ")
			  .append(" order by t1.vc_fund_code asc ");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_fund_code = map.get("VC_FUND_CODE");
					String vc_fund_name = map.get("VC_FUND_NAME");
					String fundCodeName = map.get("FUNDCODENAME");
					String vc_combi_no = map.get("VC_COMBI_NO");
					String vc_combi_name = map.get("VC_COMBI_NAME");
					String l_asset_id = map.get("L_ASSET_ID");
					String fundInfo = map.get("FUNDINFO");
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.CombProduct");
					obj.setString("fundCode", vc_fund_code);
					obj.setString("fundName", vc_fund_name);
					obj.setString("fundCodeName", fundCodeName);
					obj.setString("vcCombiNo", vc_combi_no);
					obj.setString("vcCombiName", vc_combi_name);
					obj.setString("lAssetId", l_asset_id);
					obj.setString("fundInfo", fundInfo);
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
	/**
	 * 通过关键字到O32系统查找投资的债券、股票等产品信息
	 * @param searchKey 关键字
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getInvestProductsByKey(String stockCode, String marketCode){
		stockCode = stockCode==null?"":stockCode;
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName());
		
		//拼接SQL语句
			sb.append("select distinct t.vc_report_code, ")//债券、股票代码
			  .append("                t.vc_stock_name, ")//债券、股票名称
			  .append("                t.vc_report_code || '-' || t.vc_stock_name vc_stock, ")//债券、股票代码+债券、股票名称
			  .append("                t.c_market_no, ")//交易市场编号
		      .append("                t.vc_inter_code ")//证券内码
		      .append("  from trade.TSTOCKINFO t ")
		      .append(" where 1 = 1 ");
			
			if(StringUtils.isNotBlank(stockCode)){
				sb.append("   and (t.vc_report_code like '%").append(stockCode).append("%' or t.vc_stock_name like '%").append(stockCode).append("%') ");
			}
			if(StringUtils.isNotBlank(marketCode) && StringUtils.isNotBlank(stockCode)){
				sb.append("   and  t.vc_inter_code = '").append(stockCode+marketCode).append("'");
			}
			sb.append("   and rownum<=20 ")//限制每次只查询20条记录
			  .append(" order by t.vc_report_code asc ");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_report_code = map.get("VC_REPORT_CODE");//债券代码
					String vc_stock_name = map.get("VC_STOCK_NAME");//债券名称
					String vc_stock = map.get("VC_STOCK");//债券代码名称
					String c_market_no = map.get("C_MARKET_NO");//交易市场编号
					String vc_inter_code = map.get("VC_INTER_CODE");//证券内码
					
					sb.setLength(0);
					sb.append(vc_report_code)//债券代码
					  .append(",").append(vc_stock_name)//债券名称
					  .append(",").append(c_market_no)//交易市场编号
					  .append(",").append(vc_inter_code);//证券内码
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.InvestProduct");
					obj.setString("investProductCode", vc_report_code);//债券代码
					obj.setString("investProductName", vc_stock_name);//债券名称
					obj.setString("investProduct", vc_stock);//债券代码名称
					obj.setString("investProductInfo", sb.toString());//投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
	public static void main(String[] args) {
		String xml = "<FailReason type=\"2\"><Reasons><Reason>2|3|3026_000|150201|YH|375|H|0.006000|0.014377|债券成交收益率不超过公允收益率60bp</Reason><Reason>4|1|3026_000|150201|YH|374|I|0.000000|0.000000|+1头寸为负的情况下允许作银行间买券和逆回购</Reason><Reason>4|1|3026_000|150201|YH|33|J|0.000000|0.000000|5日同向交易监控</Reason><Reason>4|1|3026_000|150201|YH|32|J|0.000000|0.000000|3日内同向监控预警</Reason></Reasons></FailReason>";
		Map<String,String> map = readStringXmlOut(xml);
		System.out.println("failReasonType="+map.get("failReasonType"));
		System.out.println("reasonCount="+map.get("reasonCount"));
		System.out.println(""+map.get("reason"));
		
		
		//保存备注信息
//		if(StringUtils.isNotBlank(failreason)){
//			Map<String,String> map = FixToUtil.readStringXmlOut(failreason);
//			if(StringUtils.isNotBlank(map.get("Reason")) && map.get("Reason").split("\\|").length>=5){
//				fixReceiveMsg.setString("text", map.get("Reason").split("\\|")[4]);//一般情况下内容跟58标签内容相同
//			}
//		}
	}
}
