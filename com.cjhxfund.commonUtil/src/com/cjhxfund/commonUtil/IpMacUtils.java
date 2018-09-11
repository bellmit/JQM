package com.cjhxfund.commonUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;

import javax.servlet.http.HttpServletRequest;

import com.eos.system.annotation.Bizlet;


/**
 * @Project		JQM
 * @Description	MAC地址工具
 * @ClassName	MacUtils
 * @Date		2016年12月26日 下午1:20:07
 * @Author		liangjilong
 * @Copyright (c) All Right Reserved CJHXFUND, 2016.
 * @author liangjilong
 * @date 2016-12-26 13:20:07
 */

@Bizlet("")
public class IpMacUtils {

	/**
	 * 获取当前操作系统名称. return 操作系统名称 例如:windows,Linux,Unix等.
	 */
	public static String getOSName() {
		return System.getProperty("os.name").toLowerCase();
	}

	/**
	 * 获取Unix网卡的mac地址.
	 * 
	 * @return mac地址
	 */
	@Bizlet("获取Unix网卡的mac地址")
	public static String getUnixMACAddress() {
		String mac = null;
		BufferedReader bufferedReader = null;
		Process process = null;
		try {
			/**
			 * Unix下的命令，一般取eth0作为本地主网卡 显示信息中包含有mac地址信息
			 */
			process = Runtime.getRuntime().exec("ifconfig eth0");
			bufferedReader = new BufferedReader(new InputStreamReader(
					process.getInputStream()));
			String line = null;
			int index = -1;
			while ((line = bufferedReader.readLine()) != null) {
				/**
				 * 寻找标示字符串[hwaddr]
				 */
				index = line.toLowerCase().indexOf("hwaddr");
				/**
				 * 找到了
				 */
				if (index != -1) {
					/**
					 * 取出mac地址并去除2边空格
					 */
					mac = line.substring(index + "hwaddr".length() + 1).trim();
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			bufferedReader = null;
			process = null;
		}

		return mac;
	}

	/**
	 * 获取Linux网卡的mac地址.
	 * 
	 * @return mac地址
	 */
	@Bizlet("获取Linux网卡的mac地址")
	public static String getLinuxMACAddress() {
		String mac = null;
		BufferedReader bufferedReader = null;
		Process process = null;
		try {
			/**
			 * linux下的命令，一般取eth0作为本地主网卡 显示信息中包含有mac地址信息
			 */
			process = Runtime.getRuntime().exec("ifconfig eth0");
			bufferedReader = new BufferedReader(new InputStreamReader(
					process.getInputStream()));
			String line = null;
			int index = -1;
			while ((line = bufferedReader.readLine()) != null) {
				index = line.toLowerCase().indexOf("硬件地址");
				/**
				 * 找到了
				 */
				if (index != -1) {
					/**
					 * 取出mac地址并去除2边空格
					 */
					mac = line.substring(index + 4).trim();
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			bufferedReader = null;
			process = null;
		}
		
		// 取不到，试下Unix取发
		if (mac == null){
			return getUnixMACAddress();
		}

		return mac;
	}

	/**
	 * 获取widnows网卡的mac地址.
	 * @return mac地址
	 */
	@Bizlet("获取widnows网卡的mac地址")
	public static String getWindowsMACAddress() {
		String mac = null;
		BufferedReader bufferedReader = null;
		Process process = null;
		try {
			/**
			 * windows下的命令，显示信息中包含有mac地址信息
			 */
			process = Runtime.getRuntime().exec("ipconfig /all");
			bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line = null;
			int index = -1;
			while ((line = bufferedReader.readLine()) != null) {
				/**
				 * 寻找标示字符串[physical address]
				 */
				//index = line.toLowerCase().indexOf("physical address");
				//if (index != -1) {
				if (line.split("-").length == 6){
					index = line.indexOf(":");
					if (index != -1) {
						/**
						 * 取出mac地址并去除2边空格
						 */
						mac = line.substring(index + 1).trim();
					}
					break;
				}
				index = line.toLowerCase().indexOf("物理地址");
				if (index != -1) {
					index = line.indexOf(":");
					if (index != -1) {
						/**
						 * 取出mac地址并去除2边空格
						 */
						mac = line.substring(index + 1).trim();
					}
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (bufferedReader != null) {
					bufferedReader.close();
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			bufferedReader = null;
			process = null;
		}

		return mac;
	}

	@Bizlet("获取getMac地址")
	public static String getMac(){
		String os = getOSName();
		String mac;
		if (os.startsWith("windows")) {
			mac = getWindowsMACAddress();
		} else if (os.startsWith("linux")) {
			mac = getLinuxMACAddress();
		} else {
			mac = getUnixMACAddress();
		}
		return mac == null ? "" : mac;
	}

	/**
	 * @Description 获取MAC地址的方法
	 * @Author		liangjilong
	 * @Date		2016年12月26日 下午1:22:40
	 * @param ia
	 * @return
	 * @throws Exception 		参数
	 * @return 		String 返回类型
	 */
	@Bizlet("获取MAC地址的方法")
	public static String getMACAddress(InetAddress ia) throws Exception {
		// 获得网络接口对象（即网卡），并得到mac地址，mac地址存在于一个byte数组中。
		byte[] mac = NetworkInterface.getByInetAddress(ia).getHardwareAddress();
		// 下面代码是把mac地址拼装成String
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < mac.length; i++) {
			if (i != 0) {
				sb.append("-");
			}
			// mac[i] & 0xFF 是为了把byte转化为正整数
			String s = Integer.toHexString(mac[i] & 0xFF);
			sb.append(s.length() == 1 ? 0 + s : s);
		}
		// 把字符串所有小写字母改为大写成为正规的mac地址并返回
		return sb.toString().toUpperCase();
	}
	
	/**
	 * @Description 获得用户远程地址
	 * @Author		liangjilong
	 * @Date		2016年12月26日 下午1:25:10
	 * @param request
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	@Bizlet("获得用户远程地址")
	public static String getRemoteAddr(HttpServletRequest request){
		String remoteAddr = request.getHeader("X-Real-IP");
        if (StrUtil.isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("X-Forwarded-For");
        }else if (StrUtil.isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("Proxy-Client-IP");
        }else if (StrUtil.isNotBlank(remoteAddr)) {
        	remoteAddr = request.getHeader("WL-Proxy-Client-IP");
        }
        return remoteAddr != null ? remoteAddr : request.getRemoteAddr();
	}
	
	
	/**
	 * 测试用的main方法.
	 * 
	 * @param argc 运行参数.
	 */
	
	public static void main(String[] argc) {
		String os = getOSName();
		System.out.println("os: " + os);
		if (os.startsWith("windows")) {
			String mac = getWindowsMACAddress();
			System.out.println("mac: " + mac);
		} else if (os.startsWith("linux")) {
			String mac = getLinuxMACAddress();
			System.out.println("mac: " + mac);
		} else {
			String mac = getUnixMACAddress();
			System.out.println("mac: " + mac);
		}
	}

}
