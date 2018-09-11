package com.cjhxfund.ats.fm.baseinfo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DatabaseExt;

import commonj.sdo.DataObject;

public class SysAccountInfoBysjzx {
	@Bizlet("")
    public boolean SysAccountInfo() {
        boolean isSuccess = false;
	        System.out.println("[SysAccountInfoBysjzx]"+"开始获取账户信息...");
	        LogUtil.logInfo("[SysAccountInfoBysjzx]"+"开始获取账户信息...", null, new Object[]{});	
	        Long beforeTime=(new Date()).getTime();
	        
	        isSuccess = getAccountInfo();
	        if (!isSuccess) {
	            LogUtil.logError("[SysAccountInfoBysjzx]"+"SysAccountInfoBysjzx.getAccountInfo函数执行失败,掉用getAccountInfo出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        
	        Long afterTime=(new Date()).getTime();
	        String className=Thread.currentThread().getStackTrace()[1].getClassName();
	        String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
	        QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
	        
	        LogUtil.logInfo("[SysAccountInfoBysjzx]"+"结束获取账户信息...", null, new Object[]{});
	        System.out.println("[SysAccountInfoBysjzx]"+"结束获取账户信息...");
	        return isSuccess;
    }
	@Bizlet("")
	 public static boolean getAccountInfo(){
		SynCommonUtil.insertMsg("2", "开始获取账户信息", 0, "获取账户信息", "开始获取账户信息");
		System.out.println("[getAccountInfo]"+"开始获取账户信息...");
        LogUtil.logInfo("[getAccountInfo]"+"开始获取账户信息...", null, new Object[]{});
        boolean isSuccess = true;
        StringBuffer sql = new StringBuffer();
        DataObject objAccountInfo = null;
        Connection conn_qjy = null;
        List<Map<String, String>> list_tg = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_zqsz = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_zqsh = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_yh = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_jg = new ArrayList<Map<String, String>>();
      //1.查询ATS历史评级表中有没有数据和最大的日期时间
        try {
        	conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
        	//托管户信息
        	sql.setLength(0);
			sql.append( "select distinct(c.fund_code),")
		       .append( "	(select l_account_id from t_ats_account_info")
    		   .append( "	where vc_product_code = c.fund_code ")
	           .append( "	and vc_account_type = '3' and vc_account_no = fiduciary_account and rownum =1) l_account_id ,")
	           .append( "	(select c_source from t_ats_account_info")
	           .append(	"	where vc_product_code = c.fund_code and vc_account_type = '3' ")
	           .append(	"	and vc_account_no = fiduciary_account and rownum =1) c_source,")
	           .append( "	c.prod_name,t.fiduciary_name,t.fiduciary_openbank_name,")
	           .append( "	t.fiduciary_account as vc_account_no,t.Fiduciary_Big_Pay_Number ")
	           .append( "	from isp.plms_pm_prod_fiduciary t,isp.plms_pm_prod_comm_info c")
	           .append( "	where t.prod_id = c.sysid");
        	list_tg = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
        	//证券户信息深圳
        	sql.setLength(0);
        	sql.append( "select distinct(c.fund_code),")
      		   .append( "	(select l_account_id from t_ats_account_info")
 		       .append( "	where vc_product_code = c.fund_code ")
	           .append( "	and vc_account_type = '1' and vc_account_no = t.sz_stock_account and rownum =1) l_account_id ,")
	           .append( "	(select c_source from t_ats_account_info")
	           .append(	"	where vc_product_code = c.fund_code and vc_account_type = '1' ")
	           .append(	"	and vc_account_no = t.sz_stock_account and rownum =1) c_source,")
        	   .append( "	c.prod_name,t.stock_name,t.sz_stock_account as vc_account_no,")
        	   .append( "	t.main_trading_unit ")
        	   .append( "	from isp.plms_pm_prod_stock t,isp.plms_pm_prod_comm_info c")
        	   .append( "	where t.prod_id = c.sysid");
        	list_zqsz = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
        	//证券户信息上海
        	sql.setLength(0);
        	sql.append( "select distinct(c.fund_code),")
 		       .append( "	(select l_account_id from t_ats_account_info")
 		       .append( "	where vc_product_code = c.fund_code ")
	           .append( "	and vc_account_type = '1' and vc_account_no = t.sh_stock_account and rownum =1) l_account_id ,")
	           .append( "	(select c_source from t_ats_account_info")
	           .append(	"	where vc_product_code = c.fund_code and vc_account_type = '1' ")
	           .append(	"	and vc_account_no = t.sh_stock_account and rownum =1) c_source,")
        	   .append( "	c.prod_name,t.stock_name,t.sh_stock_account as vc_account_no,")
        	   .append( "	t.sh_trading_unit ")
        	   .append( "	from isp.plms_pm_prod_stock t,isp.plms_pm_prod_comm_info c")
        	   .append( "	where t.prod_id = c.sysid");
        	list_zqsh = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
        	//银行间信息
        	sql.setLength(0);
        	sql.append( "select distinct(c.fund_code),")
		       .append( "	(select l_account_id from t_ats_account_info")
		       .append( "	where vc_product_code = c.fund_code ")
	           .append( "	and vc_account_type = '2' and (vc_account_no = t.open_bond_account or vc_account_no = t.settle_owner_accont) and rownum =1) l_account_id ,")
	           .append( "	(select c_source from t_ats_account_info")
	           .append(	"	where vc_product_code = c.fund_code and vc_account_type = '2' ")
	           .append(	"	and vc_account_no = t.open_bond_account and rownum =1) c_source,")
	           .append( "	c.prod_name,case when t.BANK_TYPE = 'zzd' then'中债登' when t.BANK_TYPE = 'sqs' then'上清所' end payment_place ,")
	           .append( "	case when t.bank_type = 'sqs' then t.settle_owner_name else t.open_account_name end as open_account_name,")
	           .append( "   case when t.bank_type = 'zzd' then t.open_bond_account else t.settle_owner_accont end as vc_account_no")
	    	   .append( "	from isp.plms_pm_prod_bank t,isp.plms_pm_prod_comm_info c ")
	           .append( "	where t.prod_id = c.sysid and t.bank_type in ('zzd','sqs')");
        	list_yh = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
        	//机构间信息
        	sql.setLength(0);
        	sql.append( "select distinct(c.fund_code),")
		       .append( "	(select l_account_id from t_ats_account_info")
		       .append( "	where vc_product_code = c.fund_code ")
	           .append( "	and vc_account_type = '4' and vc_account_no = t.prod_account and rownum =1) l_account_id ,")
	           .append( "	(select c_source from t_ats_account_info")
	           .append(	"	where vc_product_code = c.fund_code and vc_account_type = '4' ")
	           .append(	"	and vc_account_no = t.prod_account and rownum =1) c_source,")
	           .append(	"	c.prod_name,t.account_name,t.bank_account,t.prod_account as vc_account_no")
	           .append(	"	from isp.plms_pm_prod_org t,isp.plms_pm_prod_comm_info c")
	           .append(	"	where t.prod_id = c.sysid");
        	list_jg = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
		} catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
			SynCommonUtil.insertMsg("1", e.getMessage(), 0, "查询账户信息", "查询账户信息异常");
            LogUtil.logError("[getBondAppraise]"+"函数执行失败,查询Ats历史评级表报错！ ", e, new Object[]{});
		}finally{
			sql.setLength(0);
			sql = null;
		}
        System.out.println("[getAccountInfo]"+"结束获取账户信息...");
        LogUtil.logInfo("[getAccountInfo]"+"结束获取账户信息...", null, new Object[]{});
        //2.将账户信息插入ATS账户信息表中
        System.out.println("[getAccountInfo]"+"开始将账户信息插入ATS账户信息表中...");
        LogUtil.logInfo("[getAccountInfo]"+"开始将账户信息插入ATS账户信息表中...", null, new Object[]{});
        try {
        	conn_qjy.setAutoCommit(false);
            /*将托管户信息插入账户信息表中*/
            if (!list_tg.isEmpty() && list_tg.size() > 0) {
                List<DataObject> objAccountInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_tg.size(); i++) {
                    Map<String, String> map = list_tg.get(i);
                    objAccountInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.TAtsAccountInfo");
                    if(map.get("C_SOURCE") == "1" || map.get("FUND_CODE") == null || map.get("FUND_CODE") == "" 
                    		|| map.get("VC_ACCOUNT_NO") == null || map.get("VC_ACCOUNT_NO") == ""){
                    	continue;
                    }
                    if(map.get("L_ACCOUNT_ID") == null || map.get("L_ACCOUNT_ID") == ""){
                    	DatabaseExt.getPrimaryKey(objAccountInfo);
                    }else{
                    	objAccountInfo.setInt("lAccountId", Integer.parseInt(map.get("L_ACCOUNT_ID")));
                    }
                    objAccountInfo.setString("vcAccountType", "3");
                    objAccountInfo.setString("vcProductCode", map.get("FUND_CODE"));
                    objAccountInfo.setString("vcProductName", map.get("PROD_NAME"));
                    objAccountInfo.setString("vcTrusteePlace", map.get("FIDUCIARY_NAME"));
                    objAccountInfo.setString("vcAccountName", map.get("FIDUCIARY_OPENBANK_NAME"));
                    objAccountInfo.setString("vcAccountNo", map.get("VC_ACCOUNT_NO"));
                    objAccountInfo.setString("vcLargePaymentNo", map.get("FIDUCIARY_BIG_PAY_NUMBER"));
                    objAccountInfo.setString("cSource",	"2");
                    objAccountInfo.setString("cStatus", "2");
                    objAccountInfos.add(objAccountInfo);
                    objAccountInfo = null;
                }
                DataObject objActInfos[] = new DataObject[objAccountInfos.size()];
                objAccountInfos.toArray(objActInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objActInfos);
                SynCommonUtil.insertMsg("0", "新增账户信息托管户", objActInfos.length, "新增托管户", "将账户信息托管户信息新增到账户信息表中");
                objAccountInfos = null;
                objActInfos = null;
                list_tg = null;
            	}
            /*将证券户信息插入账户信息表中*/
            if (!list_zqsh.isEmpty() && list_zqsh.size() > 0) {
                List<DataObject> objAccountInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_zqsh.size(); i++) {
                    Map<String, String> map = list_zqsh.get(i);
                    objAccountInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.TAtsAccountInfo");
                    if(map.get("C_SOURCE") == "1" || map.get("FUND_CODE") == null || map.get("FUND_CODE") == "" 
                    		|| map.get("VC_ACCOUNT_NO") == null || map.get("VC_ACCOUNT_NO")== ""){
                    	continue;
                    }
                    if(map.get("L_ACCOUNT_ID") == null || map.get("L_ACCOUNT_ID") == ""){
                    	DatabaseExt.getPrimaryKey(objAccountInfo);
                    }else{
                    	objAccountInfo.setInt("lAccountId", Integer.parseInt(map.get("L_ACCOUNT_ID")));
                    }
                    objAccountInfo.setString("vcAccountType", "1");
                    objAccountInfo.setString("vcProductCode", map.get("FUND_CODE"));
                    objAccountInfo.setString("vcProductName", map.get("PROD_NAME"));
                    objAccountInfo.setString("vcAccountName", map.get("STOCK_NAME"));
                    objAccountInfo.setString("vcAccountNo", map.get("VC_ACCOUNT_NO"));
                    objAccountInfo.setString("vcTrusteeSeatNoSh", map.get("SH_TRADING_UNIT"));
                    objAccountInfo.setString("cSource",	"2");
                    objAccountInfo.setString("cStatus", "2");
                    objAccountInfos.add(objAccountInfo);
                    objAccountInfo = null;
                }
                DataObject objActInfos[] = new DataObject[objAccountInfos.size()];
                objAccountInfos.toArray(objActInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objActInfos);
                SynCommonUtil.insertMsg("0", "新增账户信息上海证券户", objActInfos.length, "新增上海证券户", "将账户信息上海证券户信息新增到账户信息表中");
                objAccountInfos = null;
                objActInfos = null;
                list_zqsh = null;
            	}
            /*将证券户信息插入账户信息表中*/
            if (!list_zqsz.isEmpty() && list_zqsz.size() > 0) {
                List<DataObject> objAccountInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_zqsz.size(); i++) {
                    Map<String, String> map = list_zqsz.get(i);
                    objAccountInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.TAtsAccountInfo");
                    if(map.get("C_SOURCE") == "1" || map.get("FUND_CODE") == null || map.get("FUND_CODE") == "" 
                    		|| map.get("VC_ACCOUNT_NO") == null || map.get("VC_ACCOUNT_NO") == ""){
                    	continue;
                    }
                    if(map.get("L_ACCOUNT_ID") == null || map.get("L_ACCOUNT_ID") == ""){
                    	DatabaseExt.getPrimaryKey(objAccountInfo);
                    }else{
                    	objAccountInfo.setInt("lAccountId", Integer.parseInt(map.get("L_ACCOUNT_ID")));
                    }
                    objAccountInfo.setString("vcAccountType", "1");
                    objAccountInfo.setString("vcProductCode", map.get("FUND_CODE"));
                    objAccountInfo.setString("vcProductName", map.get("PROD_NAME"));
                    objAccountInfo.setString("vcAccountName", map.get("STOCK_NAME"));
                    objAccountInfo.setString("vcAccountNo", map.get("VC_ACCOUNT_NO"));
                    objAccountInfo.setString("vcTrusteeSeatNoSz", map.get("MAIN_TRADING_UNIT"));
                    objAccountInfo.setString("cSource",	"2");
                    objAccountInfo.setString("cStatus", "2");
                    objAccountInfos.add(objAccountInfo);
                    objAccountInfo = null;
                }
                DataObject objActInfos[] = new DataObject[objAccountInfos.size()];
                objAccountInfos.toArray(objActInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objActInfos);
                SynCommonUtil.insertMsg("0", "新增账户信息深圳证券户", objActInfos.length, "新增深圳证券户", "将账户信息深圳证券户信息新增到账户信息表中");
                objAccountInfos = null;
                objActInfos = null;
                list_zqsz = null;
            	}
            /*将银间户信息插入账户信息表中*/
            if (!list_yh.isEmpty() && list_yh.size() > 0) {
                List<DataObject> objAccountInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_yh.size(); i++) {
                    Map<String, String> map = list_yh.get(i);
                    objAccountInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.TAtsAccountInfo");
                    if(map.get("C_SOURCE") == "1" || map.get("FUND_CODE") == null || map.get("FUND_CODE") == "" 
                    		|| map.get("VC_ACCOUNT_NO") == null || map.get("VC_ACCOUNT_NO") == ""){
                    	continue;
                    }
                    if(map.get("L_ACCOUNT_ID") == null || map.get("L_ACCOUNT_ID") == ""){
                    	DatabaseExt.getPrimaryKey(objAccountInfo);
                    }else{
                    	objAccountInfo.setInt("lAccountId", Integer.parseInt(map.get("L_ACCOUNT_ID")));
                    }
                    objAccountInfo.setString("vcAccountType", "2");
                    objAccountInfo.setString("vcProductCode", map.get("FUND_CODE"));
                    objAccountInfo.setString("vcProductName", map.get("PROD_NAME"));
                    objAccountInfo.setString("vcPaymentPlace", map.get("PAYMENT_PLACE"));
                    objAccountInfo.setString("vcAccountName", map.get("OPEN_ACCOUNT_NAME"));
                    objAccountInfo.setString("vcAccountNo", map.get("VC_ACCOUNT_NO"));
                    objAccountInfo.setString("cSource",	"2");
                    objAccountInfo.setString("cStatus", "2");
                    objAccountInfos.add(objAccountInfo);
                    objAccountInfo = null;
                }
                DataObject objActInfos[] = new DataObject[objAccountInfos.size()];
                objAccountInfos.toArray(objActInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objActInfos);
                SynCommonUtil.insertMsg("0", "新增账户信息银间户", objActInfos.length, "新增银间户", "将账户信息银间户信息新增到账户信息表中");
                objAccountInfos = null;
                objActInfos = null;
                list_yh = null;
            	}
            /*将机构户信息插入账户信息表中*/
            if (!list_jg.isEmpty() && list_jg.size() > 0) {
                List<DataObject> objAccountInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_jg.size(); i++) {
                    Map<String, String> map = list_jg.get(i);
                    objAccountInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.applyTemplet.TAtsAccountInfo");
                    if(map.get("C_SOURCE") == "1" || map.get("FUND_CODE") == null || map.get("FUND_CODE") == "" 
                    		|| map.get("VC_ACCOUNT_NO") == null || map.get("VC_ACCOUNT_NO") == ""){
                    	continue;
                    }
                    if(map.get("L_ACCOUNT_ID") == null || map.get("L_ACCOUNT_ID") == ""){
                    	DatabaseExt.getPrimaryKey(objAccountInfo);
                    }else{
                    	objAccountInfo.setInt("lAccountId", Integer.parseInt(map.get("L_ACCOUNT_ID")));
                    }
                    objAccountInfo.setString("vcAccountType", "4");
                    objAccountInfo.setString("vcProductCode", map.get("FUND_CODE"));
                    objAccountInfo.setString("vcProductName", map.get("PROD_NAME"));
                    objAccountInfo.setString("vcAccountName", map.get("ACCOUNT_NAME"));
                    objAccountInfo.setString("vcBankAccount", map.get("BANK_ACCOUNT"));
                    objAccountInfo.setString("vcAccountNo", map.get("VC_ACCOUNT_NO"));
                    objAccountInfo.setString("cSource",	"2");
                    objAccountInfo.setString("cStatus", "2");
                    objAccountInfos.add(objAccountInfo);
                    objAccountInfo = null;
                }
                DataObject objActInfos[] = new DataObject[objAccountInfos.size()];
                objAccountInfos.toArray(objActInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objActInfos);
                SynCommonUtil.insertMsg("0", "新增账户信息机构户", objActInfos.length, "新增机构户", "将账户信息机构户信息新增到账户信息表中");
                objAccountInfos = null;
                objActInfos = null;
                list_jg = null;
            	}
            conn_qjy.commit();
            conn_qjy.setAutoCommit(true);
            } catch (Exception e) {
            	try {
					conn_qjy.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
            	isSuccess = false;
                e.printStackTrace();
                SynCommonUtil.insertMsg("1", e.getMessage(), 0, "新增账户信息", "将账户信息新增账户信息表失败");
                LogUtil.logError("[getAccountInfo]"+"函数执行失败,将账户信息新增账户信息表失败!", e, new Object[]{});
            }finally{
            	JDBCUtil.releaseResource(conn_qjy, null, null);
            }
        SynCommonUtil.insertMsg("2", "结束获取账户信息", 0, "获取账户信息", "结束获取账户信息");
        System.out.println("[getAccountInfo]"+"结束将账户信息插入ATS账户信息表中...");
        LogUtil.logInfo("[getAccountInfo]"+"结束将账户信息插入ATS账户信息表中...", null, new Object[]{});
			return isSuccess;
	}
}
