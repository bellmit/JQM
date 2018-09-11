package com.cjhxfund.ats.fm.baseinfo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
/**
 * @author 章璐
 * @date 2017-05-04 10:28:10
 * 
 */
@Bizlet("")
public class SynTradeRivalAndBankNo {
	@Bizlet("")
    public boolean synTradeRivalAndBankNo() {
        boolean isSuccess = false;
        isSuccess = SynCommonUtil.synControl();
        if(isSuccess){
	        System.out.println("[synTradeRivalAndBankNo]"+"开始同步O32交易对手和银行账号...");
	        LogUtil.logInfo("[synTradeRivalAndBankNo]"+"开始同步O32交易对手和银行账号...", null, new Object[]{});
	        isSuccess = getTradeRivalFromO32();
	        if (!isSuccess) {
	            LogUtil.logError("[synTradeRivalAndBankNo]"+"getTradeRivalFromO32函数执行失败,同步O32交易对手出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        isSuccess = getBankNoFromO32();
	        if (!isSuccess) {
	            LogUtil.logError("[synTradeRivalAndBankNo]"+"getBankNoFromO32函数执行失败,同步O32银行账号出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        LogUtil.logInfo("[synTradeRivalAndBankNo]"+"结束同步O32交易对手和银行账号...", null, new Object[]{});
	        System.out.println("[synTradeRivalAndBankNo]"+"结束同步O32交易对手和银行账号...");
        }else{
        	LogUtil.logInfo("[synTradeRivalAndBankNo]"+"当前配置为手工操作，定时器不做任何操作。。。。", null, new Object[]{});
        }
        return isSuccess;
    }
	@Bizlet("")
    public static boolean getTradeRivalFromO32() {
		SynCommonUtil.insertMsg("2", "开始获取O32交易对手", 0, "获取O32交易对手", "开始获取O32交易对手,清空数据接口表并查询O32交易对手");
		boolean isSuccess = true;
        Connection conn_O32 = null;
        Connection conn_qjy = null;
        DataObject objTradeRival = null;
        StringBuffer sql_qjy = new StringBuffer();
        List<Map<String, String>> list_TradeRival = new ArrayList<Map<String, String>>();
        System.out.println("[getTradeRivalFromO32]"+"开始获取O32交易对手...");
        //1.查询O32的交易对手
        try {
        	conn_O32 = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
        	sql_qjy.setLength(0);
        	sql_qjy.append( "	select A.L_RIVAL_ID,")
			       .append( "	A.VC_RIVAL_CODE,")
	    		   .append( "	A.VC_NAME, ")
		           .append( "	A.VC_ALL_NAME,")
		           .append(	"	A.C_STATUS,")
		           .append( "	A.L_ISSUER_ID ")
		           .append(	"	from trade.TTRADERIVAL A")
		           .append( "	WHERE A.C_STATUS = '1' ")
		           .append( "	ORDER BY L_RIVAL_ID");
        	list_TradeRival = JDBCUtil.queryWithConn(conn_O32, sql_qjy.toString(), null);
        } catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
			SynCommonUtil.insertMsg("1", e.getMessage(), 0, "查询O32交易对手", "查询O32交易对手异常");
            LogUtil.logError("[getTradeRivalFromO32]"+"函数执行失败,查询O32交易对手表报错！ ", e, new Object[]{});
		}finally{
			sql_qjy.setLength(0);
			sql_qjy = null;
		}
      //2.将交易对手信息插入ATS中
        System.out.println("[getTradeRivalFromO32]"+"开始将交易对手数据插入ATS交易对手表中...");
        try {
            if (!list_TradeRival.isEmpty() && list_TradeRival.size() > 0) {
                List<DataObject> objTradeRivals = new ArrayList<DataObject>();
                for (int i = 0; i < list_TradeRival.size(); i++) {
                    Map<String, String> map = list_TradeRival.get(i);
                    objTradeRival = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsCounterpartyInfo");
                    
                    objTradeRival.setInt("lRivalId", Integer.parseInt(map.get("L_RIVAL_ID")));
                    objTradeRival.setString("vcRivalCode", map.get("VC_RIVAL_CODE"));
                    objTradeRival.setString("vcName", map.get("VC_NAME"));
                    objTradeRival.setString("vcAllName", map.get("VC_ALL_NAME"));
                    objTradeRival.setString("lIssuerId", map.get("L_ISSUER_ID"));
                    objTradeRival.setString("cStatus", map.get("C_STATUS"));

                    objTradeRivals.add(objTradeRival);
                    objTradeRival = null;
                }
                DataObject objInfos[] = new DataObject[objTradeRivals.size()];
                objTradeRivals.toArray(objInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objInfos);
                SynCommonUtil.insertMsg("0", "新增交易对手", objInfos.length, "新增交易对手", "将新增交易对手信息新增到交易对手表中");
                objTradeRivals = null;
                objInfos = null;
                list_TradeRival = null;
            	}
        } catch (Exception e) {
        	isSuccess = false;
            e.printStackTrace();
            SynCommonUtil.insertMsg("1", e.getMessage(), 0, "新增交易对手", "将新增交易对手信息新增到交易对手表中失败");
        }finally{
        	JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        SynCommonUtil.insertMsg("2", "结束获取交易对手", 0, "获取交易对手", "结束获取交易对手");
        System.out.println("[getTradeRivalFromO32]"+"结束将交易对手信息插入ATS交易对手表中...");
		return isSuccess;
		
	}
	@Bizlet("")
    public static boolean getBankNoFromO32() {
		SynCommonUtil.insertMsg("2", "开始获取O32银行账号", 0, "获取O32银行账号", "开始获取O32银行账号,清空数据接口表并查询O32银行账号");
		boolean isSuccess = true;
        Connection conn_O32 = null;
        Connection conn_qjy = null;
        DataObject objBankNo = null;
        StringBuffer sql_qjy = new StringBuffer();
        List<Map<String, String>> list_BankNo = new ArrayList<Map<String, String>>();
        System.out.println("[getBankNoFromO32]"+"开始获取O32银行账号...");
        //1.查询O32的银行账号
        try {
        	conn_O32 = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
        	sql_qjy.setLength(0);
        	sql_qjy.append( " select A.VC_BANK_NAME, ")
            	   .append(	" A.VC_ACCOUNT, ")
            	   .append(	" A.VC_ACCOUNT_NAME, ")
            	   .append(	" A.VC_PAY_NO, ")
            	   .append(	" A.VC_ID, ")
            	   .append(	" A.C_BUSIN_CLASS, ")
            	   .append(	" A.L_ORG_ID ")
            	   .append(	" FROM trade.TBANKACCOUNT A, trade.TCITY B, trade.TBANKINFO C ")
            	   .append(	" WHERE (A.C_BUSIN_CLASS <> '!' OR A.VC_SUB_TYPE <> '-1') ")
            	   .append(	" AND A.VC_CITY = B.VC_CITYNO(+) ")
            	   .append(	" AND A.L_BANK_NO = C.L_BANK_NO(+) ")
            	   .append(	" AND C_BUSIN_CLASS IN ('2', 'C', 'D', 'G', 'N', 'P') ")
            	   .append(	" order by C_BUSIN_CLASS, a.vc_ID, a.VC_BANK_NAME ");
        	list_BankNo = JDBCUtil.queryWithConn(conn_O32, sql_qjy.toString(), null);
        } catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
			SynCommonUtil.insertMsg("1", e.getMessage(), 0, "查询O32银行账号", "查询O32银行账号异常");
            LogUtil.logError("[getBankNoFromO32]"+"函数执行失败,查询O32银行账号表报错！ ", e, new Object[]{});
		}finally{
			sql_qjy.setLength(0);
			sql_qjy = null;
		}
      //2.将银行账号信息插入ATS中
        System.out.println("[getBankNoFromO32]"+"开始将银行账号数据插入ATS银行账号表中...");
        try {
            if (!list_BankNo.isEmpty() && list_BankNo.size() > 0) {
                List<DataObject> objBankNos = new ArrayList<DataObject>();
                for (int i = 0; i < list_BankNo.size(); i++) {
                    Map<String, String> map = list_BankNo.get(i);
                    objBankNo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsCounterpartyAccount");
                    objBankNo.setString("vcBankName", map.get("VC_BANK_NAME"));
                    objBankNo.setString("vcAccount", map.get("VC_ACCOUNT"));
                    objBankNo.setString("vcAccountName", map.get("VC_ACCOUNT_NAME"));
                    objBankNo.setString("vcPayNo", map.get("VC_PAY_NO"));
                    objBankNo.setString("vcId", map.get("VC_ID"));
                    objBankNo.setString("cBusinClass", map.get("C_BUSIN_CLASS"));
                    objBankNo.setString("lOrgId", map.get("L_ORG_ID"));
                    objBankNos.add(objBankNo);
                    objBankNo = null;
                }
                DataObject objInfos[] = new DataObject[objBankNos.size()];
                objBankNos.toArray(objInfos);
                DatabaseUtil.saveEntities(JDBCUtil.DATA_SOURCE_DEFAULT, objInfos);
                SynCommonUtil.insertMsg("0", "新增银行账号", objInfos.length, "新增银行账号", "将新增银行账号信息新增到银行账号表中");
                objBankNos = null;
                objInfos = null;
                list_BankNo = null;
            	}
        } catch (Exception e) {
        	isSuccess = false;
            e.printStackTrace();
            SynCommonUtil.insertMsg("1", e.getMessage(), 0, "新增交易对手", "将新增银行账号信息新增到银行账号表中失败");
        }finally{
        	JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        SynCommonUtil.insertMsg("2", "结束获取银行账号", 0, "获取银行账号", "结束获取银行账号");
        System.out.println("[getBankNoFromO32]"+"结束将银行账号信息插入ATS银行账号表中...");
		return isSuccess;
	}
}
