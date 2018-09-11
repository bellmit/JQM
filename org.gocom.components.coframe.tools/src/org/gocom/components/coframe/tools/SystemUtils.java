package org.gocom.components.coframe.tools;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IRequestMap;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.common.muo.MUODataContextHelper;

import commonj.sdo.DataObject;

/**
 * 获取系统的信息
 * 
 * @author 谭凯
 */
public final class SystemUtils {
	
	/**
	 * 获取访问者IP 在一般情况下使用Request.getRemoteAddr()即可，但是经过nginx等反向代理软件后，这个方法会失效。
	 * 
	 * 本方法先从Header中获取X-Real-IP，如果不存在再从X-Forwarded-For获得第一个IP(用,分割)，
	 * 如果还不存在则调用Request .getRemoteAddr()。
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Real-IP");
		if (ip != null && !"".equals(ip) && !"unknown".equalsIgnoreCase(ip)) {
			return ip;
		}
		ip = request.getHeader("X-Forwarded-For");
		if (ip != null && !"".equals(ip) && !"unknown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个IP值，第一个为真实IP。
			int index = ip.indexOf(',');
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		} else {
			return request.getRemoteAddr();
		}
	}
	
	/**
	 * 获取来访者的浏览器版本
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequestBrowserInfo(HttpServletRequest request) {
		String browserVersion = null;
		String header = request.getHeader("user-agent").toLowerCase();
		if (header == null || header.equals("")) {
			return "";
		}
		if (header.indexOf("firefox") > 0) {
			browserVersion = "Firefox";
		} else if (header.indexOf("chrome") > 0) {
			browserVersion = "Chrome";
		} else if (header.indexOf("safari") > 0) {
			browserVersion = "Safari";
		} else if (header.indexOf("camino") > 0) {
			browserVersion = "Camino";
		} else if (header.indexOf("konqueror") > 0) {
			browserVersion = "Konqueror";
		} else if (header.indexOf("msie 7") > 0) {
			browserVersion = "IE7";
		} else if (header.indexOf("msie 8") > 0) {
			browserVersion = "IE8";
		} else if (header.indexOf("msie 9") > 0) {
			browserVersion = "IE9";
		} else if (header.indexOf("msie 10") > 0) {
			browserVersion = "IE10";
		} else if (header.indexOf("msie") > 0) {
			browserVersion = "IE";
		} else if (header.indexOf("opera") > 0) {
			browserVersion = "opera";
		} else if (header.indexOf("webkit") > 0) {
			return "webkit";
		} else if (header.indexOf("gecko") > 0 && header.indexOf("rv:11") > 0) {
			browserVersion = "IE11";
		} else {
			browserVersion = "Others";
		}
		return browserVersion;
	}
	
	/**
	 * 获取系统版本信息
	 * 
	 * @param request
	 * @return
	 */
	public static String getRequestSystemInfo(HttpServletRequest request) {
		String systenInfo = null;
		String header = request.getHeader("user-agent");
		if (header == null || header.equals("")) {
			return "";
		}
		// 得到用户的操作系统
		if (header.indexOf("NT 6.0") > 0) {
			systenInfo = "Windows Vista/Server 2008";
		} else if (header.indexOf("NT 5.2") > 0) {
			systenInfo = "Windows Server 2003";
		} else if (header.indexOf("NT 5.1") > 0) {
			systenInfo = "Windows XP";
		} else if (header.indexOf("NT 6.0") > 0) {
			systenInfo = "Windows Vista";
		} else if (header.indexOf("NT 6.1") > 0) {
			systenInfo = "Windows 7";
		} else if (header.indexOf("NT 6.2") > 0) {
			systenInfo = "Windows Slate";
		} else if (header.indexOf("NT 6.3") > 0) {
			systenInfo = "Windows 9";
		} else if (header.indexOf("NT 5") > 0) {
			systenInfo = "Windows 2000";
		} else if (header.indexOf("NT 4") > 0) {
			systenInfo = "Windows NT4";
		} else if (header.indexOf("Me") > 0) {
			systenInfo = "Windows Me";
		} else if (header.indexOf("98") > 0) {
			systenInfo = "Windows 98";
		} else if (header.indexOf("95") > 0) {
			systenInfo = "Windows 95";
		} else if (header.indexOf("Mac") > 0) {
			systenInfo = "Mac";
		} else if (header.indexOf("Unix") > 0) {
			systenInfo = "UNIX";
		} else if (header.indexOf("Linux") > 0) {
			systenInfo = "Linux";
		} else if (header.indexOf("SunOS") > 0) {
			systenInfo = "SunOS";
		}
		return systenInfo;
	}
	
	/**
	 * 获取来访者的主机名称
	 * 
	 * @param ip
	 * @return
	 */
	public static String getHostName(String ip) {
		InetAddress inet;
		try {
			inet = InetAddress.getByName(ip);
			return inet.getHostName();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/**
	 * 命令获取mac地址
	 * @param cmd
	 * @return
	 */
	private static String callCmd(String[] cmd) {
		String result = "";
		String line = "";
		try {
			Process proc = Runtime.getRuntime().exec(cmd);
			InputStreamReader is = new InputStreamReader(proc.getInputStream());
			BufferedReader br = new BufferedReader(is);
			while ((line = br.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 
	 * @param cmd 第一个命令
	 * @param another 第二个命令
	 * @return 第二个命令的执行结果
	 */
	private static String callCmd(String[] cmd, String[] another) {
		String result = "";
		String line = "";
		try {
			Runtime rt = Runtime.getRuntime();
			Process proc = rt.exec(cmd);
			proc.waitFor(); // 已经执行完第一个命令，准备执行第二个命令
			proc = rt.exec(another);
			InputStreamReader is = new InputStreamReader(proc.getInputStream());
			BufferedReader br = new BufferedReader(is);
			while ((line = br.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * @param ip 目标ip,一般在局域网内
	 * @param sourceString 命令处理的结果字符串
	 * @param macSeparator mac分隔符号
	 * @return mac地址，用上面的分隔符号表示
	 */
	private static String filterMacAddress(final String ip, final String sourceString, final String macSeparator) {
		String result = "";
		String regExp = "((([0-9,A-F,a-f]{1,2}" + macSeparator + "){1,5})[0-9,A-F,a-f]{1,2})";
		Pattern pattern = Pattern.compile(regExp);
		Matcher matcher = pattern.matcher(sourceString);
		while (matcher.find()) {
			result = matcher.group(1);
			if (sourceString.indexOf(ip) <= sourceString.lastIndexOf(matcher.group(1))) {
				break; // 如果有多个IP,只匹配本IP对应的Mac.
			}
		}
		return result;
	}
	
	/**
	 * @param ip 目标ip
	 * @return Mac Address
	 */
	private static String getMacInWindows(final String ip) {
		String result = "";
		String[] cmd = { "cmd", "/c", "ping " + ip };
		String[] another = { "cmd", "/c", "arp -a" };
		String cmdResult = callCmd(cmd, another);
		result = filterMacAddress(ip, cmdResult, "-");
		return result;
	}
	
	/**
	 * @param ip 目标ip
	 * @return Mac Address
	 */
	private static String getMacInLinux(final String ip) {
		String result = "";
		String[] cmd = { "/bin/sh", "-c", "ping " + ip + " -c 2 && arp -a" };
		String cmdResult = callCmd(cmd);
		result = filterMacAddress(ip, cmdResult, ":");
		return result;
	}
	
	/**
	 * 获取MAC地址
	 * @return 返回MAC地址
	 */
	public static String getMacAddress(String ip) {
		String macAddress = "";
		String os = System.getProperty("os.name");
		if(StringUtils.isNotEmpty(os) && os.toLowerCase().startsWith("win")){
			macAddress = getMacInWindows(ip).trim();
		}else{
			macAddress = getMacInLinux(ip).trim();
		}
		return macAddress;
	}
	
	/**
	 * 获取用户登录信息
	 * @param loginInfo
	 * @return
	 */
	@Bizlet("")
	public static DataObject getLoginUserInfo(DataObject loginInfo) {
		IRequestMap requestMap = DataContextManager.current().getRequestCtx();
		if (requestMap == null) {
			requestMap = MUODataContextHelper.getMapContextFactory().getRequestMap();
		}
		Object reqObject = requestMap.getRootObject();
		HttpServletRequest request = (HttpServletRequest) reqObject;
		/**
		 * 获取IP
		 */
		String vcIpAddress = loginInfo.getString("vcIpAddress");
		if(StringUtils.isBlank(vcIpAddress)){
			vcIpAddress = SystemUtils.getIpAddr(request);
		}
		LogUtil.logInfo("IP地址："+vcIpAddress, null, null);
		loginInfo.set("vcIpAddress", vcIpAddress);
		/**
		 * 获取mac
		 */
		//String mac = SystemUtils.getMacAddress(vcIpAddress);
		String mac = "";//获取mac地址方法拿不到真实用户的MAC，会影响登录效率，暂时先不获取。
		LogUtil.logInfo("MAC地址："+mac, null, null);
		loginInfo.set("vcMac", mac);
		/**
		 * 获取浏览器信息
		 */
		String vcBrowserInfo = SystemUtils.getRequestBrowserInfo(request);
		LogUtil.logInfo("浏览器版本："+vcBrowserInfo, null, null);
		loginInfo.set("vcBrowserInfo", vcBrowserInfo);
		/**
		 * 获取服务器版本信息
		 */
		String systemInfo = SystemUtils.getRequestSystemInfo(request);
		LogUtil.logInfo("系统版本信息："+systemInfo, null, null);
		loginInfo.set("vcSystemInfo", systemInfo);
		/**
		 * 获取机器名称
		 */
//		String vcComputerName = SystemUtils.getHostName(ip);
//		LogUtil.logInfo("机器名：" + vcComputerName, null, null);
//		loginInfo.set("vcComputerName", vcComputerName);
		return loginInfo;
	}
	
	public static void main(String[] args) {
		System.out.println(SystemUtils.getHostName("10.201.224.154"));
	}

}