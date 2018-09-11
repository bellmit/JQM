/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 胥思明
 * @date 2016-11-15 09:41:32
 *
 */
@Bizlet("")
public class AccountInfoImport {
	/**
	 * 验证结果
	 */
	
	private final static String ERROR_NOTFOUND_PRODUCT = "无法根据产品代码和产品名称关联到产品ID";
	private final static String ERROR_LIMIT_VCPRODUCTCODE = "该用户无法获取当前产品的操作权限";
	private final static String ERROR_PRODUCTINFO_EMPTY = "产品名称、产品代码不能同时为空";
	private final static String ERROR_TRUSTEEPLACE_EMPTY = "当账户类型为托管账户时，托管行为必填";

	
	private final static String ERROR_LARGEPAYMENTNO_EMPTY = "当账户类型为托管账户时，大额支付号为必填";
	private final static String ERROR_TRUSTEESEATNOSH_EMPTY = "当账户类型为证券账户时，托管券商席位号（上海）为必填";
	private final static String ERROR_TRUSTEESEATNOSZ_EMPTY = "当账户类型为证券账户时，托管券商席位号（深圳）为必填";

	private final static String ERROR_NORANGE_VCTRUSTEEPLACE = "账户类型值不在值域中";
	private final static String ERROR_NORANGE_VCPAYMENTPLACE = "登记托管机构不在值域中";
	

	private final static String ERROR_PRODUCTCODE_EMPTY = "产品代码不能为空";
	private final static String ERROR_PRODUCTNAME_EMPTY = "产品名称不能为空";
	private final static String ERROR_PAYMENTPLACE_EMPTY = "登记托管机构不能为空";
	private final static String ERROR_ACCOUNTTYPE_EMPTY = "账户类型不能为空";
	private final static String ERROR_ACCOUNTNAME_EMPTY = "账户名称不能为空";
	private final static String ERROR_ACCOUNTNO_EMPTY = "账户号码不能为空";
	
	private final static String ERROR_ACCOUNTINFO = "更新数据库已经存在该账户号码的重复数据!";
	
	
	private static int NUM = 0;
	
	private static int SUCCESS_NUM = 0;

	private static int FAIL_NUM = 0;
	
	
	

    static String result = "";
    static List<DataObject> msgList = null;
	/**
	 * 获取导入数据及错误日志
	 * @param filePath
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取导入和错误日志数据") 
    public static List<List<DataObject>> getExportAndErrorList(String filePath, DataObject obj, String userid) throws IOException {  
		List<List<DataObject>> allList = new ArrayList<List<DataObject>>();
        List<List<Object>> list = null;  
        msgList = new ArrayList<DataObject>();
        
        list = ExcelHelper.exportListFromExcel(new File(filePath), 0);  
        if(list.size()<=1){//空模板
        	DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
			ob.setLong("id", 0);
			ob.setString("errorCode", "ERROR_NOTFOUND_PRODUCT");
			ob.setString("errorMsg", "模板数据为空，请检查数据.");
			msgList.add(ob);
        }
        //数据保存并基本校验
        List<DataObject> accountList = AccountInfoImport.checkAccountInfoValid(list, obj ,userid);
        
        AccountInfoImport.saveAccountInfo(list, accountList);
        allList.add(accountList);
        allList.add(msgList);
        return allList;
    }  
	
	/**
	 * 获取导入日志
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取导入的数据") 
    public static List<DataObject> getExportList(List<List<DataObject>> allList) throws IOException {  
		return allList.get(0);
    }  
	
	/**
	 * 获取错误日志日志
	 * @return
	 * @throws IOException 
	 */
	@Bizlet("获取错误日志的数据") 
    public static List<DataObject> getErrorList(List<List<DataObject>> allList) throws IOException {  
		
		return allList.get(1);
    } 
	/**
	 * 产品信息查询
	 * @param paramObject 查询条件对象
	 * @return
	 * @author xusiming
	 */
	@Bizlet("")
	public static List<Map<String,String>> queryProducts(DataObject paramObject){
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<Map<String, String>> productList = new ArrayList<Map<String, String>>();
		try {
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			//获取页面传进来的查询条件值
			String vcProductCode = paramObject.getString("vcProductCode");//可查看的产品代码字符串，当有多条记录时，结果值以英文逗号分隔
			String vcProductName = paramObject.getString("vcProductName");
			
			//拼接SQL语句
			sb.append("select distinct t.l_product_id, t.vc_product_code, ")//产品代码
			  .append("                t.vc_product_name, ")//产品名称
			  .append("                t.vc_product_code || '-' || t.vc_product_name fundCodeName ")//产品代码+产品名称
			  .append("  from t_ats_product_info t ")
			  .append(" where 1 = 1 ");
			
			//新增查询条件
			if(StringUtils.isNotBlank(vcProductCode)){
				sb.append(" and t.vc_product_code =").append(JDBCUtil.changeInStr(vcProductCode));
				
			}
			if(StringUtils.isNotBlank(vcProductName)){
				sb.append(" and t.vc_product_name =").append(JDBCUtil.changeInStr(vcProductName));
				
			}
			//查询结果集
			productList = JDBCUtil.query("default", sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return productList;
	}

	/**
	 * 数据解析
	 * 
	 */
	public static List<DataObject> analysisData(List<List<Object>> list, DataObject obj){
        List<DataObject> accountList = new ArrayList<DataObject>();
		for(int j = 1; j < list.size(); j++){
        	obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.TAtsAccountInfo");
			if(list.get(j).get(0) != null && !("").equals(list.get(j).get(0))){
				obj.setString("vcProductCode", list.get(j).get(0).toString().trim());
			} 
			if(list.get(j).get(1) != null && !("").equals(list.get(j).get(1))){
				obj.setString("vcProductName", list.get(j).get(1).toString().trim());
			} 
			if(list.get(j).get(2) != null && !("").equals(list.get(j).get(2))){
				obj.setString("vcPaymentPlace", list.get(j).get(2).toString().trim());
			}
			if(list.get(j).get(3) != null && !("").equals(list.get(j).get(3))){
				String vcAccountType = list.get(j).get(3).toString().trim();
				if(vcAccountType.equals("证券账户")){
					vcAccountType = "1";
				}else if(vcAccountType.equals("银行间")){
					vcAccountType = "2";
				}else if(vcAccountType.equals("托管账户")){
					vcAccountType = "3";
				}else if(vcAccountType.equals("机构间账户")){
					vcAccountType = "4";
				}else{
					vcAccountType = "";
				}
				obj.setString("vcAccountType", vcAccountType);
			}
			if(list.get(j).get(4) != null && !("").equals(list.get(j).get(4))){
				obj.setString("vcAccountName", list.get(j).get(4).toString().trim());
			}
			if(list.get(j).get(5) != null && !("").equals(list.get(j).get(5))){
				obj.setString("vcAccountNo", list.get(j).get(5).toString().trim());
			} 
			
        	if(list.get(j).get(6) != null && !("").equals(list.get(j).get(6))){
            	obj.setString("vcTrusteeSeatNoSh", list.get(j).get(6).toString().trim());
        	}
        	
        	if(list.get(j).get(7) != null && !("").equals(list.get(j).get(7))){
            	obj.setString("vcTrusteeSeatNoSz", list.get(j).get(7).toString().trim());
        	}
        	
        	if(list.get(j).get(8) != null && !("").equals(list.get(j).get(8))){
            	obj.setString("vcTrusteePlace", list.get(j).get(8).toString());
        	}
        	
        	if(list.get(j).get(9) != null && !("").equals(list.get(j).get(9))){
            	obj.setString("vcLargePaymentNo", list.get(j).get(9).toString());
        	}
        	
        	if(list.get(j).get(10) != null && !("").equals(list.get(j).get(10))){
            	obj.setString("vcBondAccount", list.get(j).get(10).toString());
        	}
        	
        	if(list.get(j).get(11) != null && !("").equals(list.get(j).get(11))){
            	obj.setString("vcRemarks", list.get(j).get(11).toString());
        	}
        	obj.setString("cSource", "2");
        	obj.setString("cStatus", "2");
        	List<Map<String, String>> productInfo = queryProducts(obj);
			if(productInfo.size() != 0){
				obj.setInt("lProductId",  Integer.parseInt(productInfo.get(0).get("L_PRODUCT_ID")));
			} else{
				obj.setInt("lProductId", 0);
			}
        	accountList.add(obj);
        }
		return accountList;
	}

	

	
	/**
	 * 账户信息校验
	 * @param list
	 * @return
	 */
	public static List<DataObject> checkAccountInfoNotNullValid(List<DataObject> list,String userid){
		/*
		1）证券账户：证券账户名称（上海）、证券账户号码（上海）、托管券商席位号（上海）、托管券商席位号（深圳）。
		2）银行间：上清所账户名、上清所账户号、中债账户名、中债账户号。
		3）托管账户信息：托管户户名、托管户账户号、托管行、大额支付号。
		
		1.账户类型不能为空
		2.校验产品名称、产品代码不能同时为空
		3.当账户类型为托管账户时，托管行、大额支付号为必填。
		4.当账户类型为证券账户时，托管券商席位号（上海）、托管券商席位号（深圳）为必填
		
		1.判断账户类型是否在值域范围内（值域：证券账户、银行间账户、托管账户）
		2.登记托管机构是否在范围内
		3.产品名称或产品代码是否能查找到产品

       */
		
		List<DataObject> objList = new ArrayList<DataObject>();
		for(int i = 0; i < list.size(); i++){
			int a = 0;
			if(list.get(i).getString("lProductId") == ""){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_NOTFOUND_PRODUCT");
				ob.setString("errorMsg", ERROR_NOTFOUND_PRODUCT);
				msgList.add(ob);
				a++;
			}
			if(list.get(i).getString("vcProductCode") == null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_PRODUCTCODE_EMPTY");
				ob.setString("errorMsg", ERROR_PRODUCTCODE_EMPTY);
				msgList.add(ob);
				a++;
			}
			if(list.get(i).getString("vcProductName") == null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_PRODUCTNAME_EMPTY");
				ob.setString("errorMsg", ERROR_PRODUCTNAME_EMPTY);
				msgList.add(ob);
				a++;
			}
			if(list.get(i).getString("vcPaymentPlace") == null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorMsg", "ERROR_PAYMENTPLACE_EMPTY");
				ob.setString("errorMsg", ERROR_PAYMENTPLACE_EMPTY);
				msgList.add(ob);
				a++;
			}
			if(list.get(i).getString("vcAccountType") == null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_ACCOUNTTYPE_EMPTY");
				ob.setString("errorMsg", ERROR_ACCOUNTTYPE_EMPTY);
				msgList.add(ob);
				a++;
			}
			if(list.get(i).getString("vcAccountName") == null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_ACCOUNTNAME_EMPTY");
				ob.setString("errorMsg", ERROR_ACCOUNTNAME_EMPTY);
				msgList.add(ob);
				a++;
			}
			if(list.get(i).getString("vcAccountNo") == null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_ACCOUNTNO_EMPTY");
				ob.setString("errorMsg", ERROR_ACCOUNTNO_EMPTY);
				msgList.add(ob);
				a++;
			}
			
			if(list.get(i).getString("vcProductName") == null && list.get(i).getString("vcProductCode")== null){
				DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
				ob.setLong("id", i+1);
				ob.setString("errorCode", "ERROR_PRODUCTINFO_EMPTY");
				ob.setString("errorMsg", ERROR_PRODUCTINFO_EMPTY);
				msgList.add(ob);
				a++;
			}
			
			if(list.get(i).getString("vcAccountType") != null){
				if(list.get(i).getString("vcAccountType").equals("3")){
					if(list.get(i).getString("vcTrusteePlace") == null){
						DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
						ob.setLong("id", i+1);
						ob.setString("errorCode", "ERROR_TRUSTEEPLACE_EMPTY");
						ob.setString("errorMsg", ERROR_TRUSTEEPLACE_EMPTY);
						msgList.add(ob);
						a++;
					}
					if(list.get(i).getString("vcLargePaymentNo") == null){
						DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
						ob.setLong("id", i+1);
						ob.setString("errorCode", "ERROR_LARGEPAYMENTNO_EMPTY");
						ob.setString("errorMsg", ERROR_LARGEPAYMENTNO_EMPTY);
						msgList.add(ob);
						a++;
					}
				}
				
				if(list.get(i).getString("vcAccountType").equals("1")){
					if(list.get(i).getString("vcTrusteeSeatNoSh") == null){
						DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
						ob.setLong("id", i+1);
						ob.setString("errorCode", "ERROR_TRUSTEESEATNOSH_EMPTY");
						ob.setString("errorMsg", ERROR_TRUSTEESEATNOSH_EMPTY);
						msgList.add(ob);
						a++;
					}
					if(list.get(i).getString("vcTrusteeSeatNoSz") == null){
						DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
						ob.setLong("id", i+1);
						ob.setString("errorCode", "ERROR_TRUSTEESEATNOSZ_EMPTY");
						ob.setString("errorMsg", ERROR_TRUSTEESEATNOSZ_EMPTY);
						msgList.add(ob);
						a++;
					}
				}
			}
			
			
			
			if(list.get(i).getString("vcAccountType") != null){
				if(list.get(i).getString("vcAccountType").equals("1") || list.get(i).getString("vcAccountType").equals("2")
						||list.get(i).getString("vcAccountType").equals("3")||list.get(i).getString("vcAccountType").equals("4")){
				}else {
					DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
					ob.setLong("id", i+1);
					ob.setString("errorCode", "ERROR_NORANGE_VCTRUSTEEPLACE");
					ob.setString("errorMsg", ERROR_NORANGE_VCTRUSTEEPLACE);
					msgList.add(ob);
					a++;
				}
			}
			//数据字典项校验   登记托管所
			if(!list.get(i).get("vcPaymentPlace").toString().equals("")){//
				String vcPaymentPlace = checkDict("CF_JY_DJTGCS",list.get(i).get("vcPaymentPlace").toString());
				if(vcPaymentPlace==""){
					DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
					ob.setLong("id", i+1);
					ob.setString("errorCode", "ERROR_NORANGE_VCPAYMENTPLACE");
					ob.setString("errorMsg", ERROR_NORANGE_VCPAYMENTPLACE);
					msgList.add(ob);
					a++;
				}else{
					list.get(i).setString("vcPaymentPlace",vcPaymentPlace);
				}
			}else{
				
			}
			if(list.get(i).getString("vcPaymentPlace") != null){
				if(list.get(i).getString("vcPaymentPlace").equals("01") || list.get(i).getString("vcPaymentPlace").equals("02")
						||list.get(i).getString("vcPaymentPlace").equals("03")||list.get(i).getString("vcPaymentPlace").equals("04")
						||list.get(i).getString("vcPaymentPlace").equals("99")){
				}else {
					
				}
			}
			//二次校验，主要针对当前角色是否具有产品操作权限
		    List<Map<String, String>> productList = AccountInfoImport.checkProductLimit(list, userid);
			//导入数据同查询到的产品数据进行对比
		    int b = 0;
			if(list.get(i).get("vcProductCode") != null && !("").equals(list.get(i).get("vcProductCode"))){
				for(int j = 0; j < productList.size(); j++){
					if(list.get(i).get("vcProductCode").toString().equals(productList.get(j).get("VC_PRODUCT_CODE").toString())){
						break;
					} else{
						b++;
					}
				}
				if(b == productList.size()){
					DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
					ob.setLong("id", i+1);
					ob.setString("errorCode", "ERROR_LIMIT_VCPRODUCTCODE");
					ob.setString("errorMsg", ERROR_LIMIT_VCPRODUCTCODE);
					msgList.add(ob);
					a++;
				}
			}
			//判断该条数据是否存在数据库，唯一约束索引---VC_PRODUCT_CODE, VC_ACCOUNT_TYPE, VC_ACCOUNT_NO
			if(a == 0){
				DataObject accountInfo = checkAccountInfo(list.get(i).get("vcProductCode").toString().trim(),list.get(i).getString("vcAccountType").toString().trim(),list.get(i).getString("vcAccountNo").toString().trim());
				if(accountInfo != null){//违反唯一约束，
					DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
					ob.setLong("id", i+1);
					ob.setString("errorCode", "ERROR_ACCOUNTINFO");
					ob.setString("errorMsg", ERROR_ACCOUNTINFO+"产品代码:"+accountInfo.getString("vcProductCode")+"账户号码:"+accountInfo.getString("vcAccountNo"));
					msgList.add(ob);
					//a++;
					list.get(i).setInt("lAccountId", accountInfo.getInt("lAccountId"));
				}
			}
			if(a == 0){
				objList.add(list.get(i));
			}
		}
		return objList;
	}
	
	/**
	 * 账户信息校验
	 * @param list
	 * @param obj
	 * @return
	 */
	public static List<DataObject> checkAccountInfoValid(List<List<Object>> list, DataObject obj, String userid){
		/*
		 *  1.必填字段验证（根据数据表字段是否必填作为验证规则）																			
			2.数据类型验证（可转换字段先转换，转换不了提示错误信息）																			
			3.产品信息是否存在（关联产品ID根据输入的产品代码得出，如果查询不到ID，则提示错误信息）																			
			4.有关数据字典的验证（验证输入值是否在数据字典的值域区间当中）																			
		 * */
		
		//解析数据
		List<DataObject> sysList = AccountInfoImport.analysisData(list, obj);
		
		//必填校验
		List<DataObject> notNullList = AccountInfoImport.checkAccountInfoNotNullValid(sysList,userid);
		
		return notNullList;
	}
	
	/**
	 * 产品权限校验
	 * @param dataList
	 * @param userid
	 * @return
	 */
	public static List<Map<String, String>> checkProductLimit(List<DataObject> dataList, String userid){
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<Map<String, String>> productList = new ArrayList<Map<String, String>>();
		try {
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			//获取页面传进来的查询条件值
//			String vcProductCode = paramObject.getString("vcProductCode");//可查看的产品代码字符串，当有多条记录时，结果值以英文逗号分隔
//			String vcProductName = paramObject.getString("vcProductName");
			
			//拼接SQL语句
			sb.append("select distinct t1.l_product_id,t1.vc_product_code,t1.vc_product_name ")//产品代码
			  .append("  from T_ATS_PRODUCT_INFO t1 ")
			  .append(" where vc_product_code in ")
			  .append("(select vc_product_code from T_ATS_PRODUCT_HANDLE  where  vc_relate_type='01'");
			
			//新增查询条件
			if(StringUtils.isNotBlank(userid)){
				sb.append(" and vc_user_id =").append(JDBCUtil.changeInStr(userid));
			}
			sb.append(")");
			//查询结果集
			productList = JDBCUtil.query("default", sb.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return productList;
	}
	/**
	 * 账户信息保存
	 * @param list
	 * @param obj
	 * @return
	 */
	public static List<DataObject> saveAccountInfo(List<List<Object>> list, List<DataObject> accountList){
		NUM = list.size()-1;
		SUCCESS_NUM = accountList.size();
		FAIL_NUM = NUM - SUCCESS_NUM;
		DataObject ob = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.MsgError");
		ob.setLong("num", NUM);
		ob.setLong("successNum", SUCCESS_NUM);
		ob.setLong("failNum", FAIL_NUM);
		msgList.add(ob);
		return accountList;
	}
	/**
	 * 过滤产品账户信息
	 * @param dobj 产品的所有账户信息
	 * @return 过滤后的账户信息
	 */
	@Bizlet("过滤产品账户信息")
	public static DataObject[] getAccountInfo(DataObject[] dobj ,DataObject[] dataobj,String vcPaymentPlace){
		/**
		 * 过滤规则
		 * 1、根据该指令的登记托管机构来过滤 产品账户信息
		 * 2、当前产品账户类型为   “托管户”，那么不用对登记托管机构进行过滤。
		 */
			for (int i = 0; i < dobj.length; i++) {
				//先判断是否为“银行间” 2
				if(!dobj[i].getString("vcAccountType").equals("3")){
					if("01".equals(vcPaymentPlace)){
						if(!(dobj[i].getString("vcAccountType").equals("2") && "中债登".equals(dobj[i].getString("vcPaymentPlace")))){ 
							dobj[i].delete();
						}
					}else if("02".equals(vcPaymentPlace)){
						if(!(dobj[i].getString("vcAccountType").equals("2") && "上清所".equals(dobj[i].getString("vcPaymentPlace")))){
							dobj[i].delete();
						}
					}else if("03".equals(vcPaymentPlace)){
						if(!(dobj[i].getString("vcAccountType").equals("1") && StringUtils.isNotBlank(dobj[i].getString("vcTrusteeSeatNoSh")))){
							dobj[i].delete();
						}
					}else if("04".equals(vcPaymentPlace)){
						if(!(dobj[i].getString("vcAccountType").equals("1") && StringUtils.isNotBlank(dobj[i].getString("vcTrusteeSeatNoSz")))){
							dobj[i].delete();
						}
					}
				}
			}
			
			for (int i = 0; i < dobj.length; i++) {
				if(StringUtils.isNotBlank(dobj[i].getString("vcAccountNo"))){
					for (int j = 0; j < dobj.length; j++) {
						if(StringUtils.isNotBlank(dobj[j].getString("vcAccountNo"))){
							if(dobj[i].getString("vcAccountNo").equals(dobj[j].getString("vcAccountNo")) && i!=j ){
								dobj[j].delete();
							}
						}
					}
				}
			}
			return dobj;
	}
	//根据字典项编号获取数据字典
	public static Map<String, String> getDictMap(String dicttypeid) {
		DataObject[] objs = BusinessDictUtil.getDictInfoByType(dicttypeid);
		Map<String, String> maps = new HashMap<String, String>();
		for (int i = 0; i < objs.length; i++) {
			maps.put(objs[i].getString("dictID"), objs[i].getString("dictName"));
		}
		return maps;
	}
	/**
     * 数据字典项校验【数据字典等】
     */
    @Bizlet("")
    public static String checkDict(String dicttypeid,String dictname){
    	String dictid = "";
    	try {
	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.debtIssueUploadManager";//逻辑构建名称
	        String operationName = "checkDictEntry";//逻辑流名称
	        
	        ILogicComponent comp = LogicComponentFactory.create(componentName);
	       
	        Object[] params = new Object[]{dicttypeid,dictname};
	        Object[] result = (Object[])comp.invoke(operationName,params);  	        
	        if(result != null){
	        	Object[] temp=(Object[]) result[0];
	    	    if(temp.length>0){
	    	    	DataObject data = (DataObject)temp[0];
    	    	    dictid =  data.getString("Dictid");
	    	    }
	        }
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return dictid;
    }
    /**
     * 根据系统参数   判断excel的数据在数据库中是否存在
     * 发行人全称|vcIssuerNameFull;债券全称|vcStockNameFull;发行期限|enExistLimite;发行额度|enIssueBalance;
     * 发行日期|lIssueBeginDate;主体评级|cIssueAppraise;企业性质|vcIssueProperty;登记托管机构|vcPaymentPlace;
     * 
     */
    @Bizlet("")
    public static DataObject checkAccountInfo(String vcProductCode,String vcAccountType,String vcAccountNo){
    	DataObject data = null;
    	Map<String, String> map = new HashMap<String, String>();
    	try {//com.cjhxfund.ats.fm.baseinfo.ApplyTemplet.checkAccountInfo
	    	String componentName = "com.cjhxfund.ats.fm.baseinfo.ApplyTemplet";//逻辑构建名称
	        String operationName = "checkAccountInfo";//逻辑流名称
	        ILogicComponent comp = LogicComponentFactory.create(componentName);
	        map.put("vcProductCode", vcProductCode);
	        map.put("vcAccountType", vcAccountType);
	        map.put("vcAccountNo", vcAccountNo);
	        Object[] params = new Object[]{map};
			Object[] result3 = (Object[])comp.invoke(operationName,params);
			
			if(result3 != null){
	        	Object[] temp=(Object[]) result3[0];
	    	    if(temp.length>0){
	    	    	data = (DataObject)temp[0];
	    	    }
	        }
			
		} catch (Throwable e) {
			e.printStackTrace();
		}
		return data;
    }
}
