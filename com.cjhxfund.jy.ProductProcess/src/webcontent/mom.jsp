<%@page import="java.security.spec.InvalidKeySpecException"%>
<%@page import="java.security.InvalidKeyException"%>
<%@page import="javax.crypto.spec.DESKeySpec"%>
<%@page import="javax.crypto.SecretKeyFactory"%>
<%@page import="javax.crypto.SecretKey"%>
<%@page import="com.eos.data.datacontext.UserObject"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="javax.crypto.KeyGenerator"%>
<%@page import="java.security.Key"%>
<%@page import="sun.misc.BASE64Encoder"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): yuejing
  - Date: 2017-07-06 13:21:46
  - Description:
-->
<head>
<title>跳转到MOM</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
<%
class FrameMd5Util {
	
	private final String HEX_DIGITS[] = {
		"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
		"A", "B", "C", "D", "E", "F"
	};

	private FrameMd5Util() {
	}

	private String byteArrayToHexString(byte b[]) {
		StringBuilder result = new StringBuilder();
		for (int i = 0; i < b.length; i++) {
			result.append(byteToHexString(b[i]));
		}
		return result.toString().toUpperCase();
	}

	private String byteToHexString(byte b) {
		int n = b;
		if (n < 0) {
			n += 256;
		}
		int d1 = n / 16;
		int d2 = n % 16;
		return (new StringBuilder(String.valueOf(HEX_DIGITS[d1]))).append(HEX_DIGITS[d2]).toString();
	}

	private byte[] md5Digest(byte src[]) throws NoSuchAlgorithmException {
		MessageDigest alg = MessageDigest.getInstance("MD5");
		return alg.digest(src);
	}

	public String encodePassword(String string) {
		return encodePassword(string, null);
	}

	public String encodePassword(String string, String expStr) {
		String resultString = null;
		if(expStr == null) {
			resultString = new String(string);
		} else {
			resultString = new String(string + expStr);
		}
		try {
			resultString = byteArrayToHexString(md5Digest(resultString.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultString.toLowerCase();
	}

}
%>

<%
class FrameBase64Util {

	private static final String UTF_8 = "UTF-8";

	private FrameBase64Util() {
	}

	/**
	 * 编码
	 * @param str
	 * @return String
	 */
	public String encode(String str){
		return new sun.misc.BASE64Encoder().encode(str.getBytes());
	}

	/**
	 * 解码
	 * @param str
	 * @return string
	 */
	public String decode(String str){
		byte[] bt = null;
		try {
			sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();
			bt = decoder.decodeBuffer(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new String(bt);
	}

	/**
	 * 把经过BASE64编码的字符串转换为Map对象
	 * @param str
	 * @return
	 */
	public Map<String, String> convertBase64StringtoMap(String str) {
		if (str == null) {
			return null;
		}
		BASE64Decoder decoder = new BASE64Decoder();
		String keyValues = null;
		try {
			keyValues = new String(decoder.decodeBuffer(str), UTF_8);

		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		if (keyValues == null || keyValues.length() == 0) {
			return null;
		}

		String[] keyValueArray = keyValues.split("&");
		Map<String, String> map = new HashMap<String, String>();
		for (String keyValue : keyValueArray) {
			String[] s = keyValue.split("=");
			if (s == null || s.length != 2) {
				return null;
			}
			map.put(s[0], s[1]);
		}
		return map;
	}
}
%>

<%
class FrameDesUtil {
	
	private Key key;

	private FrameDesUtil() {
		setKey("12j3i3n3gy9a894");
	}

	/**
	 * 根据参数生成KEY
	 */
	public void setKey(String strKey) {
		try {
			KeyGenerator _generator = KeyGenerator.getInstance("DES");
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		    DESKeySpec keySpec = new DESKeySpec(strKey.getBytes());
		    keyFactory.generateSecret(keySpec);

			//_generator.init(new SecureRandom(strKey.getBytes()));
			this.key = keyFactory.generateSecret(keySpec);//_generator.generateKey();
			_generator = null;
		} catch (Exception e) {
			throw new RuntimeException(
					"Error initializing SqlMap class. Cause: " + e);
		}
	}
	
	/**
	 * 加密String明文输入,String密文输出
	 */
	public String encrypt(String string) {
		byte[] byteMi = null;
		byte[] byteMing = null;
		String strMi = "";
		BASE64Encoder base64en = new BASE64Encoder();
		try {
			byteMing = string.getBytes("UTF8");
			byteMi = this.getEncCode(byteMing);
			strMi = base64en.encode(byteMi);
		} catch (Exception e) {
			throw new RuntimeException(
					"Error initializing SqlMap class. Cause: " + e);
		} finally {
			base64en = null;
			byteMing = null;
			byteMi = null;
		}
		return strMi;
	}

	/**
	 * 解密 以String密文输入,String明文输出
	 * @param strMi
	 * @return
	 */
	public String decrypt(String string) {
		BASE64Decoder base64De = new BASE64Decoder();
		byte[] byteMing = null;
		byte[] byteMi = null;
		String strMing = "";
		try {
			byteMi = base64De.decodeBuffer(string);
			byteMing = this.getDesCode(byteMi);
			strMing = new String(byteMing, "UTF8");
		} catch (Exception e) {
			throw new RuntimeException(
					"Error initializing SqlMap class. Cause: " + e);
		} finally {
			base64De = null;
			byteMing = null;
			byteMi = null;
		}
		return strMing;
	}

	/**
	 * 加密以byte[]明文输入,byte[]密文输出
	 * @param byteS
	 * @return
	 */
	private byte[] getEncCode(byte[] byteS) {
		byte[] byteFina = null;
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byteFina = cipher.doFinal(byteS);
		} catch (Exception e) {
			throw new RuntimeException(
					"Error initializing SqlMap class. Cause: " + e);
		} finally {
			cipher = null;
		}
		return byteFina;
	}

	/**
	 * 解密以byte[]密文输入,以byte[]明文输出
	 * @param byteD
	 * @return
	 */
	private byte[] getDesCode(byte[] byteD) {
		Cipher cipher;
		byte[] byteFina = null;
		try {
			cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.DECRYPT_MODE, key);
			byteFina = cipher.doFinal(byteD);
		} catch (Exception e) {
			throw new RuntimeException(
					"Error initializing SqlMap class. Cause: " + e);
		} finally {
			cipher = null;
		}
		return byteFina;
	}
}
%>

<%
String model = request.getParameter("model");
//处理是内网还是外网
String remoteAddr = request.getRemoteAddr();
out.print("remoteAddr:" + remoteAddr + "<br/>");
String momUrl = null;
if(model == null) {
	if(remoteAddr != null && remoteAddr.startsWith("127.0.0.1")) {
		//开发
		momUrl = "http://127.0.0.1:9100";
	} else if(remoteAddr != null && remoteAddr.startsWith("10.201.")) {
		//内网
		momUrl = "http://10.201.235.51:9100";
	} else {
		//正式
		momUrl = "http://218.17.100.51:9100";
	}
} else if("release".equals(model)) {
	if(remoteAddr != null && remoteAddr.startsWith("10.201.")) {
		//内网
		//momUrl = "http://10.201.235.51:9100";
		momUrl = "https://weixin.cjhxfund.com";
	} else {
		//正式
		momUrl = "https://weixin.cjhxfund.com";
	}
} else if("dev".equals(model)) {
	if(remoteAddr != null && remoteAddr.startsWith("127.0.0.1")) {
		//开发
		momUrl = "http://127.0.0.1:9100";
	} else {
		//内网
		momUrl = "http://10.201.235.51:9100";
	}
}

//请求地址：
//开发：http://127.0.0.1:8080/default/ProductProcess/mom.jsp?momUrl=/ats/pres/jxfxbg&momParams={name:"zhangsan"}&model=dev
//测试：http://127.0.0.1:8080/default/ProductProcess/mom.jsp?momUrl=/ats/pres/jxfxbg&momParams={name:"zhangsan"}
//开发：http://127.0.0.1:8080/default/ProductProcess/mom.jsp?momUrl=/ats/pres/jxfxbg&model=dev&momParams={name:"zhangsan"}
String url = momUrl + request.getParameter("momUrl");
String params = request.getParameter("momParams");
String clientId = "155756696";
String token = "9307a39dfc7e4b783d6682f44s3r11es";
long time = System.currentTimeMillis();
String sign = new FrameMd5Util().encodePassword(clientId + time + token);
url = url + "?clientId=" + clientId + "&time=" + time + "&sign=" + sign;
url = url + "&paramString=" + new FrameBase64Util().encode(new FrameDesUtil().encrypt(params));
UserObject userObject = (UserObject)request.getSession().getAttribute("userObject");
String userName = userObject.getAttributes().get("EXTEND_USER_ID").toString();
url = url + "&userName=" + new FrameBase64Util().encode(new FrameDesUtil().encrypt(userName));
url = url + "&model=" + model;
url = url + "&reqHost=" + momUrl;
out.println("<input type=\"text\" style=\"width: 100%;\" value=\"" + url + "\">");
out.println("<br/><a href=\"" + url + "\">" + userObject.getAttributes().get("EXTEND_USER_ID") + " 前往&gt;&gt;</a>");
response.sendRedirect(url);
%>
</body>
</html>
