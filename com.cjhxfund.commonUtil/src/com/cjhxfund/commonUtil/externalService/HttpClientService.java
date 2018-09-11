package com.cjhxfund.commonUtil.externalService;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;

/**
 * http请求外部服务工具类
 * @author chengbichao
 */
public class HttpClientService {
	
	/**
	 * 以JSON格式正文发送post请求（支持https协议）
	 * @param  url    请求地址
	 * @param  json   请求正文JSON字符串
	 * @return result 响应正文
	 */
	public static String postByJson(String url, String json){
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Content-Type", "application/json;charset=UTF-8");
		String result = null;
		try {
			HttpClient client = new SSLClient();
	        StringEntity se = new StringEntity(json);
	        se.setContentType("text/json");
	        httpPost.setEntity(se);
	        HttpResponse response = client.execute(httpPost);
	        if(response!=null){
	        	HttpEntity entity = response.getEntity();
	        	result = EntityUtils.toString(entity, "UTF-8");
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static void main(String[] args) {
		System.out.println(postByJson("http://10.201.224.169:8080/ats/com.cjhxfund.ats.sm.comm.TraderivalManager.QueryTraderByPinyin.biz.ext","{vcPinyin:'1'}"));
	}
	
}
