/**
 * 
 */
package com.cjhxfund.cjapi.common;

import java.util.HashMap;
import java.util.Map;

import javax.xml.namespace.QName;

import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;

import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.cjhxfund.cjapi.model.ObjectParamVo;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.das.entity.criteria.CriteriaType;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.system.exception.EOSRuntimeException;

import commonj.sdo.DataObject;



import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
/**
 * @author tankai
 * 
 */
public class CJAPICommonUtil {
	
	/**查询用户信息的命名sql的路径Id*/
	private static final String QUERY_ORG_EMPLOYEENS_NSQL_ID = "com.cjhxfund.cjapi.common.OrgEmployeens.queryORGEmployeeAll";
	/**查询新债信息命名sql的路径Id*/
	private static final String QUERY_NEW_STOCKINFO_BY_STOCKCODE_NSQL_ID = "com.cjhxfund.cjapi.WSBasicInfons.queryNewStockInfoByStockCode";
	/**查询获取债券信息实体名称EntityName*/
	private static final String STOCK_ISSUEINFO_ENTITY_NAME = "com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsStockIssueInfo";
	/**根据传入的天数查询回购期限(天)对应的申报代码命名sqlId*/
	private static final String QUERY_REPORT_CODE_NSQL_ID ="com.cjhxfund.cjapi.CJApiCommonns.queryReportCode";
	
	/***
	 * @Description 获取创建日期和创建时间
	 * @Author liangjilong
	 * @Date 2016年11月29日 下午1:39:43
	 * @param dataObj
	 * @return 参数
	 * @return DataObject 返回类型
	 */
	@Bizlet("获取创建日期和创建时间")
	public static DataObject getCreateDateAndCreateTime(DataObject dataObj) {
		dataObj.setInt("lCreateDate", DateUtil.currentDateYYYYMMDDInt());// L_CREATE_DATE // 创建日期YYYYMMDD
		dataObj.setInt("lCreateTime", DateUtil.currentTimeInt());// L_CREATE_TIME // 创建时间HHMMSS
		return dataObj;
	}
	
	@Bizlet("获取创建日期和创建时间")
	public static void getCreateDateAndCreateTime(Map<String, Object> map) {
		map.put("lCreateDate", DateUtil.currentDateYYYYMMDDInt());// L_CREATE_DATE // 创建日期YYYYMMDD
		map.put("lCreateTime", DateUtil.currentTimeInt());// L_CREATE_TIME // 创建时间HHMMSS
	}
	

	/***
	 * @Description 获取更新日期和更新时间
	 * @Author liangjilong
	 * @Date 2016年11月29日 下午1:39:43
	 * @param dataObj
	 * @return 参数
	 * @return DataObject 返回类型
	 */
	@Bizlet("获取更新日期和更新时间")
	public static DataObject getUpdateDateAndUpdateTime(DataObject dataObj) {
		dataObj.setInt("lUpdateDate", DateUtil.currentDateYYYYMMDDInt());// L_Update_DATE // 更新日期YYYYMMDD
		dataObj.setInt("lUpdateTime", DateUtil.currentTimeInt());// L_Update_TIME // 更新时间HHMMSS
		return dataObj;
	}
	
	/**
	 * 根据债券代码获取债券信息
	 * @param stockCode	债券代码
	 * @return
	 */
	@Bizlet("根据债券代码获取债券信息")
	public static DataObject getStockInfo(String stockCode){
		
		/** 定义返回对象 */
		DataObject newStockInfo = DataObjectUtil.createDataObject(STOCK_ISSUEINFO_ENTITY_NAME);
		/**
		 * 定义查询参数
		 */
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put("vcStockCode", stockCode);
		//调用命名sql查询
		Object[] datas =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT,QUERY_NEW_STOCKINFO_BY_STOCKCODE_NSQL_ID,paramters);
		
		if(datas!=null&& datas.length > 0 ){
			newStockInfo = objectsToDataObjects(datas)[0];
		}
		return newStockInfo;
	}
	
	/**
	 * @Description 保存或者更新的动作.
	 * @Author		liangjilong
	 * @Date		2016年12月5日 下午2:55:39
	 * @param 		paramters 参数信息
	 * @param 		executeType执行类型(true/false)
	 * @param 		entityName实体数据模型路径
	 * @return 		void 返回类型
	 */
	public static void saveOrUpdate(DataObject paramters, boolean executeType, String entityName) throws Exception{
		try {
			//创建DataObject,获取值，并设置值到实体属性,转换成EOS底层的DataObject
			DataObject convertDataObject = DataObjectUtil.convertDataObject(paramters, entityName, true);
			
			if(executeType){
				//VC_CURRENCY 币种（默认CNY）如果由CMB调用接口传过来为空，给默认值
				String vcCurrency = paramters.getString("vcCurrency");
				convertDataObject.setString("vcCurrency",(vcCurrency==null||vcCurrency==""?"CNY":vcCurrency));
				//指令下达时将第三方指令编号作为最初第三方指令编号
				if(convertDataObject.getString("vcFirstClordId")==null || "".equals(convertDataObject.getString("vcFirstClordId"))){
					convertDataObject.set("vcFirstClordId", convertDataObject.getString("vcClordId"));
				}
				DatabaseUtil.insertEntity(CJAPIConstants.DS_DEFAULT, convertDataObject);//保存信息
			}else{
				DatabaseUtil.updateEntity(CJAPIConstants.DS_DEFAULT, convertDataObject);
			}
		} catch (Exception e) {
			throw new AppException(CJAPIConstants.ERROR_INSERT_OR_UPDATE_DATA, 
					CJAPIConstants.ERROR_INSERT_OR_UPDATE_DATA_MSG);
		}
	}
	
	/****
	 * 通过下单人员的名字查询操作ID
	 * @param vcSenderSubId	下单人员编号
	 * @return 操作ID，查找不到的情况下返回null
	 * @throws AppException
	 */
	@Bizlet("通过下单人员的名字查询操作ID")
	public static String getOperatorId(String vcSenderSubId) throws AppException{
		DataObject dataObj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put("vcSenderSubId", vcSenderSubId);
		//调用命名sql查询
		Object[] datas = null;
		try{
			datas =  DatabaseExt.queryByNamedSql(CJAPIConstants.DS_DEFAULT,QUERY_ORG_EMPLOYEENS_NSQL_ID,paramters);
		} catch(EOSRuntimeException e){
			LogUtil.logError("当前类"+getCurrentClassName()+"通过下单人员的名字查询操作ID"+e.getMessage(), e);
			throw new AppException(CJAPIConstants.ERROR_SYSTEM, CJAPIConstants.ERROR_SYSTEM_MSG);
		}
		
		if(datas!=null && datas.length > 0 ){
			dataObj = objectsToDataObjects(datas)[0];
			return dataObj.getString("operatorId");
		} else {
			return null;
		}
	}
	
	 
	/**
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author		liangjilong
	 * @Date		2016年11月30日 上午9:59:29
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	private static String getCurrentClassName(){
		return CJAPICommonUtil.class.getName()+".";
	}
	
	/**
	 * @Description 调用招行webservice带命名空间url
	 * @Author		jinwenxuan
	 * @Date		2017年1月5日 下午14:59:51
	 * @param namespaceUri命名空间连接（如：namespace="http://CMB.GMS.BT.BTTS.OrderState"）
	 * @param operationMethodName操作方法
	 * @param paramName请求参数名称
	 * @param parameters参数数据	 * 
	 * @return 		参数
	 * @return 		String 返回类型
	 * @throws AppException 
	 */
	@Bizlet("调用招行webservice")
	public static String callCMBWebService(String namespaceUri,String operationMethodName, String paramName, String parameters)throws AppException {
		//1.调用读取系统参数配置的逻辑流,查询出wsdl文件地址
		String componentName = "com.cjhxfund.commonUtil.zhfwptparamconfbiz";;
		Object[] params  = new Object[1];;//入参
		Object[] ip;//返回值数组
		Object[] port;//返回值数组
		Object[] path;//返回值数组
		Object[] timeoutObj;//返回值数组
		//预防调用失败，赋予wsdl文件地址一个默认值
		String reqUri = "http://10.201.200.68:8077/BTTSCJHX/WcfService_CMB_GMS_BT_BTTS.svc?wsdl";
		//超时时间默认值
		long timeout = 60000;	
		
		params[0]="ATS_CJAPI_CMB_REQ_IP";//PARAM_KEY
		ip = GenericBaseDaoSupport.invokeBizMethod(componentName, "getParamValue", params);
		params[0]="ATS_CJAPI_CMB_REQ_PORT";//PARAM_KEY
		port = GenericBaseDaoSupport.invokeBizMethod(componentName, "getParamValue", params);
		params[0]="ATS_CJAPI_CMB_REQ_PATH";//PARAM_KEY
		path = GenericBaseDaoSupport.invokeBizMethod(componentName, "getParamValue", params);
		params[0]="ATS_CJAPI_CMB_REQ_TIMEOUT";//PARAM_KEY
		timeoutObj = GenericBaseDaoSupport.invokeBizMethod(componentName, "getParamValue", params);
		//从系统参数配置表ZHFWPT_PARAM_CONF中读取PARAM_KEY对应的PARAM_VALUE
		if(ip!=null&&ip.length>0&&port!=null&&port.length>0&&path!=null&&path.length>0){
			if(ip[0]!=null&&port[0]!=null&&path[0]!=null){
				reqUri = "http://" + ip[0].toString() + ":" + port[0].toString() + path[0].toString();
			}
		}
		//读取超时时间
		if(timeoutObj != null && timeoutObj.length > 0){
			if(timeoutObj[0]!=null){
				timeout = Long.valueOf(timeoutObj[0].toString());
			}
		}
		
		String callback = callWebService(reqUri,namespaceUri,operationMethodName,parameters,paramName,timeout);
		LogUtil.logInfo(callback,null);
		return callback;
	}
	
	/**
	 * 
	 * @Description 调用webservice
	 * @Author		liangjilong
	 * @Date		2017年1月5日 下午4:44:43
	 * @param reqUrl请求连接
	 * @param namespaceUri请求命名连接
	 * @param methodName操作方法
	 * @param reqParams请求参数
	 * @param paramName请求参数名称
	 * @return 		String 返回类型
	 * @throws AppException 
	 */
    public static String callWebService(String reqUrl,String namespaceUri,String methodName,String reqParams,String paramName,long timeout) throws AppException {  
    	String result = "";
    	Object [] invokeObjs=null;
        try{  
            RPCServiceClient client = new RPCServiceClient();  //创建RPCServiceClient
            Options options = client.getOptions();   //创建Options
            EndpointReference end = new EndpointReference(reqUrl);  
            options.setTo(end);  //发送请求连接
            options.setProperty(paramName, String.class);
            options.setTimeOutInMilliSeconds(timeout);
            Object[] obj = new Object[]{reqParams};  //设置请求参数
            Class<?>[] classes = new Class[] {String.class };   //创建Class
            QName qname = new QName(namespaceUri, methodName); //设置命名空间和操作方法
            invokeObjs = client.invokeBlocking(qname, obj,classes);//调用远程的webservice
        	
        }catch(Exception e){ 
        	String errMsg = String.format(CJAPIConstants.ERROR_CALL_WEB_SERVICE_INFERACE_MSG,methodName);
    		LogUtil.logError("当前类"+getCurrentClassName()+"调用callWebService，出现异常，异常信息为："+e.getMessage(), e);
    		LogUtil.logInfo("调用是否失败的WebService地址：连接：{0},命名连接：{1},操作方法：{2},请求参数：{3}，请求参数名：{4} ", null,reqUrl,namespaceUri,methodName,reqParams,paramName);
    		throw new AppException(CJAPIConstants.ERROR_CALL_WEB_SERVICE_INFERACE_CODE, errMsg);
        }
        if(StrUtil.isNotEmpty(invokeObjs)){
        	return  (String)invokeObjs[0];//获取返回的信息参数
        }
        return result;
    }  
    public static void main(String[] args)  throws Exception {
    	 //服务的地址
        URL wsUrl = new URL("http://192.168.1.100:6789/hello");
        
        HttpURLConnection conn = (HttpURLConnection) wsUrl.openConnection();
        
        conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "text/xml;charset=UTF-8");
        
        OutputStream os = conn.getOutputStream();
        
        //请求体
        String soap = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://ws.itcast.cn/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" + 
                      "<soapenv:Body> <q0:sayHello><arg0>aaa</arg0>  </q0:sayHello> </soapenv:Body> </soapenv:Envelope>";
        
        os.write(soap.getBytes());
        
        InputStream is = conn.getInputStream();
        
        byte[] b = new byte[1024];
        int len = 0;
        String s = "";
        while((len = is.read(b)) != -1){
            String ss = new String(b,0,len,"UTF-8");
            s += ss;
        }
        System.out.println(s);
        
        is.close();
        os.close();
        conn.disconnect();
	}
    
    
    
    /**
	 * 根据传入的天数查询回购期限(天)对应的申报代码
	 * @param days 天数
	 * @return 回购期限(天)对应的申报代码
	 * @Author		liangjilong
	 * @Date		2017年1月11日 下午3:04:07
	 * @param days天数
	 * @return 		参数
	 * @return 		String 返回类型
     */
	@Bizlet("根据传入的天数查询回购期限(天)对应的申报代码")
	public static String queryReportCode(String days){
		Map<String, Object> paramters = new HashMap<String, Object>();
		paramters.put("days", days);//设置参数.
		Object [] datas   =  DatabaseExt.queryByNamedSql(CacheUtil.getO32CacheDataSourceName(),QUERY_REPORT_CODE_NSQL_ID,paramters);
		if(StrUtil.isNotEmpty(datas)){
			DataObject dataObject = (DataObject)datas[0];
			if(StrUtil.isNotEmpty(dataObject)){
				String vcReportCode = dataObject.getString("vcReportCode");//获取申报代码
				if(!StrUtil.isBlank(vcReportCode)){
					return vcReportCode;
				}
			}
		}
		return null;
	}
    
	/**
	 * @Description object数组集合转换成DataObjects数组集合
	 * @Author		liangjilong
	 * @Date		2017年2月21日 下午6:03:00
	 * @param objects
	 * @return 		参数
	 * @return 		DataObject[] 返回类型
	 */
	@Bizlet("object数组集合转换成DataObjects数组集合")
	public static DataObject [] objectsToDataObjects(Object [] objects){
		DataObject dataObjects [] = null;
		if(StrUtil.isNotEmpty(objects)){
			//数据转换
			dataObjects = new DataObject[objects.length];
			//循环遍历
			if(dataObjects!=null&&dataObjects.length>0){
				for (int i = 0; i < dataObjects.length; i++) {
					dataObjects[i]=(DataObject)objects[i];
				}
			}
		}
		return dataObjects;
	}
	
	/**
	 * @Description 根据vcClordId检测是否存在订单
	 * @Author		liangjilong
	 * @Date		2017年3月16日 下午2:57:26
	 * @param objectVo
	 * @throws AppException 		参数
	 * @return 		DataObject 返回类型
	 */
	@Bizlet("根据vcClordId检测是否存在订单")
	public static DataObject [] checkExistOrderByClordId(ObjectParamVo objectVo)throws AppException{ 
		DataObject paramters = objectVo.getParamters();
		String entityName = objectVo.getEntityName();
		String vcClordId =(String)paramters.get("vcClordId");
		String vals [] = new String [] {vcClordId};
		String keys [] = new String [] {"vcClordId"};
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,new String[]{"="});
		//2、查询
		DataObject [] queryList = DatabaseUtil.queryEntitiesByCriteriaEntity(CJAPIConstants.DS_DEFAULT, criteriaType);
		if(StrUtil.isNotEmpty(queryList)){
			return queryList;
		}else{
			return null;
		}
	}
	
	/**
	 * @Description 根据通过动态参数检测是否存在订单
	 * @Author		liangjilong
	 * @Date		2017年3月16日 下午4:26:29
	 * @param vals
	 * @param keys
	 * @param pros
	 * @param entityName
	 * @throws AppException 		参数
	 * @return 		DataObject[] 返回类型
	 */
	@Bizlet("根据通过动态参数检测是否存在订单")
	public static DataObject [] checkExistOrderByDynamicParamter(String [] vals,String [] keys,String [] pros,String entityName)throws AppException{ 
		CriteriaType criteriaType = GenericBaseDaoSupport.createCriteriaType(entityName, keys,vals,pros);
		DataObject [] queryList = DatabaseUtil.queryEntitiesByCriteriaEntity(CJAPIConstants.DS_DEFAULT, criteriaType);
		if(StrUtil.isNotEmpty(queryList)){
			return queryList;
		}else{
			return null;
		}
	}
}

 