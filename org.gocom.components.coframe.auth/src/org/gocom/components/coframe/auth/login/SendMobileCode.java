package org.gocom.components.coframe.auth.login;



import java.io.IOException;

import com.eos.foundation.eoscommon.LogUtil;

import msnc.com.cn.util.HttpConnectionUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * @author chen.kai
 * @see  使用各个接口必须要有通知中心提供的msnc.jar
 *       短信接口调用案例。短信，微信，邮件接口调用情况基本类似，无太大差异
 *       具体差异和说明，请参考接口文档说明书
 *       同步接口提供即时通讯结果，异步消息提供回调接口，为防止消息安全到达，建议使用异步接口
 *       本案例只提供简单案例，具体实现和整合根据自己项目实际情况调整
 */
public class SendMobileCode {

	//同步群发相同短信内容接口url
	
	private final String  eq_url="http://10.201.235.11:8080/msnc/interface/mobile/sendEqualContent";
	//同步群发不同短信内容接口url
	private final String  not_eq_url="http://10.201.235.11:8080/msnc/interface/mobile/sendNotEqualContent";
	
	//同步群发相同短信内容接口url
	private final String  async_eq_url="http://10.201.235.11:8080/msnc/interface/mobile/sendAsyncEqualContent";
	//同步群发不同短信内容接口url
	private final String  async_not_eq_url="http://10.201.235.11:8080/msnc/interface/mobile/sendAsyncNotEqualContent";
	

	public  JSONObject sendTxt(String url,String phone,String mscnCode,String userId,String mscnId){
		JSONObject  data=new  JSONObject();
		data.put("seenumber", mscnId);//业务系统自定义的长度最大32位的流水号
		data.put("fromuser", userId);//接口调用人，业务系统自己填写
		data.put("fromsystem", "ATS_1");//业务系统名称或简称，有业务系统自己填写
		data.put("fromsystemid", "ATS_1");//业务系统id,有业务系统自己填写，该id有通知中心为每一个业务系统分配
		//ATS_1	20170628	b8e8fa9ab8b44594b3db0718b7aeda4e

		//定义body
		JSONObject  body=new  JSONObject();
		body.put("phone", phone);//手机号
		body.put("count", 1);//手机号个数
		body.put("content", "尊敬的 "+userId+" 用户，您本次的全交易系统登录验证码为："+mscnCode);//短信内容
		//封装短信主题内容
		data.put("body", body);
		JSONObject json = null;
		try {
			json = HttpConnectionUtil.post(url,data);
			//HttpClientService.postByJson(eq_url,data);
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			LogUtil.logError("发送短信验证码异常！", e, null);
			e.printStackTrace();
		}
        return json;
	}
	/**
	 * 
	 * @see 短信群发相同内容,发送模版内容，模版当中没有替换内容
	 *      比如模版内容为：亲爱的京东用户，双11来临，新一轮的抢购高潮来临。剁手党们还在等什么，快来抢！抢！抢！
	 *      那么短信内容为当前的模版内容：亲爱的京东用户，双11来临，新一轮的抢购高潮来临。剁手党们还在等什么，快来抢！抢！抢！
	 *      所有数据的key都不可以乱写，必须按照文档说明来写，区分大小写
	 * @return
	 * @throws IOException 
	 */
	public JSONObject sendOnlyTempateTxt() throws IOException{
		JSONObject  data=new  JSONObject();
		data.put("seenumber", "205105f02d0f5s00202sdf");//业务系统自定义的长度最大32位的流水号
		data.put("fromuser", "test");//接口调用人，业务系统自己填写
		data.put("fromsystem", "msnc");//业务系统名称或简称，有业务系统自己填写
		data.put("fromsystemid", "msnc001");//业务系统id,有业务系统自己填写，该id有通知中心为每一个业务系统分配
		//定义body
		JSONObject  body=new  JSONObject();
		body.put("phone", "13012345678,13112345678");//手机号
		body.put("count", 2);//手机号个数
		body.put("modelcode", "msnc_mobile_001");//模版编号
		//封装短信主题内容
		data.put("body", body);
		JSONObject  json= HttpConnectionUtil.post(eq_url,data);
        return json;
	}
	
	/**
	 * 
	 * @see 短信群发相同内容,发送模版内容，模版当中有替换内容
	 *      比如模版内容为：亲爱的${user}，你本月账户余额${count}元！ 
	 *      参数定义的时候必须定义user和count,否则消息会发送失败。
	 *      比如参数user="张三"，count="1000",最后发送的短信消息为：亲爱的张三，你本月账户余额1000元！
	 *      所有数据的key都不可以乱写，必须按照文档说明来写，区分大小写
	 * @return
	 * @throws IOException 
	 */
	public JSONObject sendTempateTxt() throws IOException{
		JSONObject  data=new  JSONObject();
		data.put("seenumber", "205105f02d0f5s00202sdf");
		data.put("fromuser", "test");
		data.put("fromsystem", "msnc");
		data.put("fromsystemid", "msnc001");
		//定义body
		JSONObject  body=new  JSONObject();
		body.put("phone", "13012345678,13112345678 ");
		body.put("count", 2);
		body.put("modelcode", "msnc_mobile_001");

		//定义content，其参数与模版内容中的占位参数保持一致，参考上面的模版举例
		JSONObject  context=new  JSONObject();
		context.put("user", "张三");
		context.put("count", 10000);
		//封装content模版里面的自定义参数
		body.put("content", context);
		//封装邮件主题内容
		data.put("body", body);
		JSONObject  json= HttpConnectionUtil.post(eq_url,data);
        return json;
	}
	
	/**
	 * 
	 * @see 短信群发不同内容,发送模版内容，模版当中有替换内容
	 *      比如模版内容为：亲爱的${user}，你本月账户余额${count}元！ 
	 *      参数定义的时候必须定义user和count,否则消息会发送失败。
	 *      比如参数user="张三"，count="1000",最后发送的短信消息为：亲爱的张三，你本月账户余额1000元！
	 *      所有数据的key都不可以乱写，必须按照文档说明来写，区分大小写
	 * @return
	 * @throws IOException 
	 */
	public JSONObject sendAsyncTempateTxt() throws IOException{
		JSONObject  data=new  JSONObject();
		data.put("seenumber", "205105f02d0f5s00202sdf");
		data.put("fromuser", "test");
		data.put("fromsystem", "msnc");
		data.put("fromsystemid", "msnc001");
		//定义body
		JSONObject  body=new  JSONObject();
		body.put("modelcode","模版编号");
		//定义contents
		JSONArray  contents=new JSONArray();
		JSONObject  content1=new JSONObject();
		content1.put("phone", "13012345678");
		content1.put("user", "张三");
		content1.put("count", "10000");
		JSONObject  content2=new JSONObject();
		content2.put("phone", "13112345678");
		content2.put("user", "李四");
		content2.put("count", "1000");
		contents.add(content1);
		contents.add(content2);
		body.put("contents", contents);
		//封装短信主题内容
		data.put("body", body);
		JSONObject  json= HttpConnectionUtil.post(not_eq_url,data);
		return json;
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//测试同步不带模版的接口
		
	}

}

