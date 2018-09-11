package com.cjhxfund.ats.fm.baseinfo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 章璐
 * @date 2017-02-24 09:28:10
 * 
 */
@Bizlet("")
public class SysProductInfoByHs {
	@Bizlet("")
    public boolean sysProductInfo() {
		boolean isSuccess = false;
	        System.out.println("[SysProductInfoByHs]"+"开始同步O32系统数据...");
	        LogUtil.logInfo("[SysProductInfoByHs]"+"开始同步O32系统数据...", null, new Object[]{});
	        Long beforeTime=(new Date()).getTime();
	        
	        isSuccess = getProduct();
	        if (!isSuccess) {
	            LogUtil.logError("[SysProductInfoByHs]"+"SysProductInfoByHs.getProduct函数执行失败,同步O32系统数据出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        isSuccess = callSynProdcutInfo();
	        if (!isSuccess) {
	            LogUtil.logError("[SysProductInfoByHs]"+"SysProductInfoByHs.callSynProdcutInfo函数执行失败,执行存储过程sp_sync_prod_hs出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        
	        Long afterTime=(new Date()).getTime();
	        String className=Thread.currentThread().getStackTrace()[1].getClassName();
	        String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
	        QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
	        
	        LogUtil.logInfo("[SysProductInfoByHs]"+"结束同步O32系统数据...", null, new Object[]{});
	        System.out.println("[SysProductInfoByHs]"+"结束同步O32系统数据...");
        return isSuccess;
	}
	@Bizlet("")
    public static boolean getProduct() {
    	SynCommonUtil.insertMsg("2", "开始获取O32数据", 0, "获取O32数据", "开始获取O32数据,清空数据接口表并查询O32数据");
        Boolean flag = true;
        Connection conn_O32 = null;
        Connection conn_qjy = null;
        DataObject objIntfProductInfo = null;
        DataObject objIntfAssetInfo = null;
        DataObject objIntfCombiInfo = null;
        StringBuffer sql = new StringBuffer();
        StringBuffer sql_qjy = new StringBuffer();
        List<String> sqls = new ArrayList<String>();
        List<Map<String, String>> list_fundinfo = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_assetinfo = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_combiinfo = new ArrayList<Map<String, String>>();
        System.out.println("[getProduct]"+"开始同步O32数据..");
        LogUtil.logInfo("[getProduct]"+"开始同步O32数据..", null, new Object[]{});
        
        /*01.清空接口表数据*/
        System.out.println("[getProduct]"+"开始清空接口表数据...");
        LogUtil.logInfo("[getProduct]"+"开始清空接口表数据...", null, new Object[]{});
        try {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_product_info");
            sqls.add(sql_qjy.toString());
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_asset_info");
            sqls.add(sql_qjy.toString());
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_combi_info");
            sqls.add(sql_qjy.toString());
            JDBCUtil.executeUpdateBatchWithConn(conn_qjy, sqls);
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            LogUtil.logError("[getProduct]"+"函数执行失败,清空表数据出错!", e, new Object[]{});
        } finally {
            sql_qjy.setLength(0);
            //sql_qjy = null;
            JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        if (!flag) return flag;
        System.out.println("[getProduct]"+"结束清空接口表数据...");
        LogUtil.logInfo("[getProduct]"+"结束清空接口表数据...", null, new Object[]{});
        /*02.拼接SQL语句从O32数据库中查询数据信息*/
        System.out.println("[getProduct]"+"开始拼接SQL语句从O32数据库中查询数据...");
        LogUtil.logInfo("[getProduct]"+"开始拼接SQL语句从O32数据库中查询数据...", null, new Object[]{});
        boolean execute = true;
        while (execute) {
            try {
                conn_O32 = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
                /*拼接获取O32基金属性表的SQL语句*/
                sql.setLength(0);
                sql.append("select a.l_fund_id              l_product_id,")
                   .append("       a.vc_fund_code           vc_product_code,")
                   .append("       a.vc_fund_name           vc_product_name,")
                   .append("       a.vc_fund_caption        vc_product_caption,")
                   .append("       a.l_default_asset        l_default_asset,")
                   .append("       nvl(a.l_default_combi,0) l_default_combi,")
                   .append("       a.l_open_date            l_open_date,")
                   .append("       nvl(a.l_end_date,0)      l_end_date,")
                   .append("       a.c_fund_type            c_product_type,")
                   .append("       a.c_fund_status          c_product_status,")
                   .append("       a.vc_remarks             vc_remarks,")
                   .append("       nvl(a.en_fund_share,0)   en_product_share,")
                   .append("       a.vc_currency_no         vc_currency_no,")
                   .append("       a.vc_permit_market       vc_permit_market,")
                   .append("       a.c_multi_currency       c_multi_currency,")
                   .append("       a.c_cash_addup           c_cash_addup,")
                   .append("       a.l_business_date        l_business_date,")
                   .append("       a.vc_cash_control_point  vc_cash_control_point,")
                   .append("       a.vc_stock_control_point vc_stock_control_point,")
                   .append("       a.c_invest_type          c_invest_type")
                   .append("  from trade.tfundinfo a")
                   .append("  order by a.l_fund_id asc");
                list_fundinfo = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
                /*拼接获取O32资产单元表的SQL语句*/
                sql.setLength(0);
                sql.append("select a.l_asset_id            l_asset_id,")
                   .append("       a.l_fund_id             l_product_id,")
                   .append("       a.vc_asset_name         vc_asset_name,")
                   .append("       a.c_overdraft           c_overdraft,")
                   .append("       a.vc_remarks            vc_remarks,")
                   .append("       a.c_trust               c_trust,")
                   .append("       a.vc_asset_no           vc_asset_no,")
                   .append("       a.vc_invest_overdraft   vc_invest_overdraft,")
                   .append("       a.c_asset_status        c_asset_status,")
                   .append("       a.c_credit_asset        c_credit_asset,")
                   .append("       a.c_third_party_custody c_third_party_custody")
                   .append("  from trade.tasset a")
                   .append("  order by a.l_asset_id asc");
                list_assetinfo = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
                /*拼接获取O32组合表的SQL语句*/
                sql.setLength(0);
                sql.append("select a.l_combi_id            l_combi_id,")
                   .append("       a.vc_combi_no           vc_combi_no,")
                   .append("       a.vc_combi_name         vc_combi_name,")
                   .append("       a.c_combi_class         c_combi_class,")
                   .append("       a.l_fund_id             l_product_id,")
                   .append("       a.l_asset_id            l_asset_id,")
                   .append("       a.l_setup_date          l_setup_date,")
                   .append("       a.l_end_date            l_end_date,")
                   .append("       a.c_combi_status        c_combi_status,")
                   .append("       a.vc_remark             vc_remark,")
                   .append("       a.c_invest_type         c_invest_type,")
                   .append("       a.vc_stocktype_right    vc_stocktype_right,")
                   .append("       a.vc_entrdire_right     vc_entrdire_right,")
                   .append("       a.vc_permit_market      vc_permit_market,")
                   .append("       a.vc_permit_busin_class vc_permit_busin_class,")
                   .append("       a.vc_timestamp          vc_timestamp")
                   .append("  from trade.tcombi a")
                   .append("  order by a.l_combi_id asc");
                list_combiinfo = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);                                          
                SynCommonUtil.insertMsg("2", "结束获取O32数据", 0, "获取O32数据", "结束获取O32信息");
                execute = false;
            } catch (Exception e) {
                flag = false;
                execute = false;
                e.printStackTrace();
                SynCommonUtil.insertMsg("1", e.getMessage(), 0, "获取O32数据", "查询O32数据信息");
                LogUtil.logError("[getProduct]"+"函数执行失败,拼接SQL语句从O32数据库中查询数据出错!", e, new Object[]{});
            } finally {
                sql.setLength(0);
                sql = null;
                execute = false;
                JDBCUtil.releaseResource(conn_O32, null, null);
            }
        }
        if (!flag) return flag;
        System.out.println("[getProduct]"+"结束拼接SQL语句从O32数据库中查询数据...");
        LogUtil.logInfo("[getProduct]"+"结束拼接SQL语句从O32数据库中查询数据...", null, new Object[]{});
        /*03.将O32表中的数据插入到接口表中*/
        System.out.println("[getProduct]"+"开始将O32表中的数据插入到接口表...");
        LogUtil.logInfo("[getProduct]"+"开始将O32表中的数据插入到接口表...", null, new Object[]{});
        try {
            /*将O32的数据插入到接口表*/
            if (!list_fundinfo.isEmpty() && list_fundinfo.size() > 0) {
                List<DataObject> objIntfProductInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_fundinfo.size(); i++) {
                    Map<String, String> map = list_fundinfo.get(i);
                    objIntfProductInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfProductInfo");
                    objIntfProductInfo.setLong("iProductId", Long.parseLong(map.get("L_PRODUCT_ID")));
                    objIntfProductInfo.setString("sProductCode", map.get("VC_PRODUCT_CODE"));
                    objIntfProductInfo.setString("sProductName", map.get("VC_PRODUCT_NAME"));
                    objIntfProductInfo.setString("sProductCaption", map.get("VC_PRODUCT_CAPTION"));
                    objIntfProductInfo.setLong("iDefaultAsset", Long.parseLong(map.get("L_DEFAULT_ASSET")));
                    objIntfProductInfo.setLong("iDefaultCombi", Long.parseLong(map.get("L_DEFAULT_COMBI")));
                    objIntfProductInfo.setLong("iOpenDate", Long.parseLong(map.get("L_OPEN_DATE")));
                    objIntfProductInfo.setLong("iEndDate", Long.parseLong(map.get("L_END_DATE")));
                    objIntfProductInfo.setString("cProductType", map.get("C_PRODUCT_TYPE"));
                    objIntfProductInfo.setString("cProductStatus", map.get("C_PRODUCT_STATUS"));
                    objIntfProductInfo.setString("sRemarks", map.get("VC_REMARKS"));
                    objIntfProductInfo.setDouble("dProductShare", Double.parseDouble(map.get("EN_PRODUCT_SHARE")));
                    objIntfProductInfo.setString("sCurrencyNo", map.get("VC_CURRENCY_NO"));
                    objIntfProductInfo.setString("sPermitMarket", map.get("VC_PERMIT_MARKET"));
                    objIntfProductInfo.setString("cMultiCurrency", map.get("C_MULTI_CURRENCY"));
                    objIntfProductInfo.setString("cCashAddup", map.get("C_CASH_ADDUP"));
                    objIntfProductInfo.setLong("iBusinessDate", Long.parseLong(map.get("L_BUSINESS_DATE")));
                    objIntfProductInfo.setString("sCashControlPoint", map.get("VC_CASH_CONTROL_POINT"));
                    objIntfProductInfo.setString("sStockControlPoint", map.get("VC_STOCK_CONTROL_POINT"));
                    objIntfProductInfo.setString("cInvestType", map.get("C_INVEST_TYPE"));
                    objIntfProductInfo.setString("cInvestAdviseCheck", "1");
                    objIntfProductInfo.setString("cInvestClientCheck", "1");
                    objIntfProductInfos.add(objIntfProductInfo);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfProductInfo);
                    objIntfProductInfo = null;
                }
                DataObject objIntfAssetInfoss[] = new DataObject[objIntfProductInfos.size()];
                objIntfProductInfos.toArray(objIntfAssetInfoss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfAssetInfoss);
                SynCommonUtil.insertMsg("0", "获取产品属性完成", objIntfAssetInfoss.length, "获取产品属性", "将O32产品属性表数据归集到产品属性接口表");
                objIntfProductInfos = null;
            }
            /*将O32的资产单元信息表数据插入到接口表*/
            if (!list_assetinfo.isEmpty() && list_assetinfo.size() > 0) {
                List<DataObject> objIntfAssetInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_assetinfo.size(); i++) {
                    Map<String, String> map = list_assetinfo.get(i);
                    objIntfAssetInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfAssetInfo");
                    objIntfAssetInfo.setLong("iAssetId", Long.parseLong(map.get("L_ASSET_ID")));
                    objIntfAssetInfo.setLong("iProductId", Long.parseLong(map.get("L_PRODUCT_ID")));
                    objIntfAssetInfo.setString("sAssetName", map.get("VC_ASSET_NAME"));
                    objIntfAssetInfo.setString("cOverdraft", map.get("C_OVERDRAFT"));
                    objIntfAssetInfo.setString("sRemarks", map.get("VC_REMARKS"));
                    objIntfAssetInfo.setString("cTrust", map.get("C_TRUST"));
                    objIntfAssetInfo.setString("sAssetNo", map.get("VC_ASSET_NO"));
                    objIntfAssetInfo.setString("sInvestOverdraft", map.get("VC_INVEST_OVERDRAFT"));
                    objIntfAssetInfo.setString("cAssetStatus", map.get("C_ASSET_STATUS"));
                    objIntfAssetInfo.setString("cCreditAsset", map.get("C_CREDIT_ASSET"));
                    objIntfAssetInfo.setString("cThirdPartyCustody", map.get("C_THIRD_PARTY_CUSTODY"));
                    objIntfAssetInfos.add(objIntfAssetInfo);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfAssetInfo);
                    objIntfAssetInfo = null;
                }
                DataObject objIntfAssetInfoss[] = new DataObject[objIntfAssetInfos.size()];
                objIntfAssetInfos.toArray(objIntfAssetInfoss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfAssetInfoss);
                SynCommonUtil.insertMsg("0", "获取资产单元完成", objIntfAssetInfoss.length, "获取资产单元", "将O32资产单元表数据归集到资产单元接口表");
                objIntfAssetInfos = null;
            }
            /*将O32的组合信息表数据插入到接口表*/
            if (!list_combiinfo.isEmpty() && list_combiinfo.size() > 0) {
                List<DataObject> objIntfCombiInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_combiinfo.size(); i++) {
                    Map<String, String> map = list_combiinfo.get(i);
                    objIntfCombiInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfCombiInfo");
                    objIntfCombiInfo.setLong("iCombiId", Long.parseLong(map.get("L_COMBI_ID")));
                    objIntfCombiInfo.setString("sCombiNo", map.get("VC_COMBI_NO"));
                    objIntfCombiInfo.setString("sCombiName", map.get("VC_COMBI_NAME"));
                    objIntfCombiInfo.setString("cCombiClass", map.get("C_COMBI_CLASS"));
                    objIntfCombiInfo.setLong("iProductId", Long.parseLong(map.get("L_PRODUCT_ID")));
                    objIntfCombiInfo.setLong("iAssetId", Long.parseLong(map.get("L_ASSET_ID")));
                    objIntfCombiInfo.setLong("iSetupDate", Long.parseLong(map.get("L_SETUP_DATE")));
                    objIntfCombiInfo.setLong("iEndDate", Long.parseLong(map.get("L_END_DATE")));
                    objIntfCombiInfo.setString("cCombiStatus", map.get("C_COMBI_STATUS"));
                    objIntfCombiInfo.setString("sRemark", map.get("VC_REMARK"));
                    objIntfCombiInfo.setString("cInvestType", map.get("C_INVEST_TYPE"));
                    objIntfCombiInfo.setString("sStocktypeRight", map.get("VC_STOCKTYPE_RIGHT"));
                    objIntfCombiInfo.setString("sEntrdireRight", map.get("VC_ENTRDIRE_RIGHT"));
                    objIntfCombiInfo.setString("sPermitMarket", map.get("VC_PERMIT_MARKET"));
                    objIntfCombiInfo.setString("sPermitBusinClass", map.get("VC_PERMIT_BUSIN_CLASS"));
                    objIntfCombiInfo.setString("sTimestamp", map.get("VC_TIMESTAMP"));
                    objIntfCombiInfos.add(objIntfCombiInfo);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfCombiInfo);
                    objIntfCombiInfo = null;
                }
                DataObject objIntfCombiInfoss[] = new DataObject[objIntfCombiInfos.size()];
                objIntfCombiInfos.toArray(objIntfCombiInfoss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfCombiInfoss);
                SynCommonUtil.insertMsg("0", "获取组合信息完成", objIntfCombiInfoss.length, "获取组合信息", "将O32组合信息表数据归集到组合信息接口表");
                objIntfCombiInfos = null;
            }
            flag = true;
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            SynCommonUtil.insertMsg("1", e.getMessage(), 0, "获取O32数据", "将O32基础信息数据归集到数据接口表");
            LogUtil.logError("[getProduct]"+"函数执行失败,将O32表中的数据插入到接口表出错!", e, new Object[]{});
        }
        if (!flag) return flag;
        LogUtil.logInfo("[getProduct]"+"结束将O32表中的数据插入到接口表...", null, new Object[]{});
        System.out.println("[getProduct]"+"结束将O32表中的数据插入到接口表...");
        LogUtil.logInfo("[getProduct]"+"结束同步O32数据..", null, new Object[]{});
        System.out.println("[getProduct]"+"结束同步O32数据..");
        SynCommonUtil.insertMsg("2", "结束获取O32数据", 0, "获取O32数据", "结束获取O32数据");
        return flag;
    }
    @Bizlet("")
	public static boolean callSynProdcutInfo() {
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[callSynProdcutInfo]"+"开始执行存储过程sp_sync_prod_hs..");
        LogUtil.logInfo("[callSynProdcutInfo]"+"开始执行存储过程sp_sync_prod_hs..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call sp_sync_prod_hs(?,?)}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.registerOutParameter(1, Types.INTEGER);
                cStmt_qjy.registerOutParameter(2, Types.INTEGER);
                cStmt_qjy.executeUpdate();
                int l_success = -1;
                isSuccess = true;
                l_success = cStmt_qjy.getInt(1);
                if (l_success != 0){
                    isSuccess = false;
                    execute = false;
                    LogUtil.logError("[callSynProdcutInfo]"+"函数执行失败,将接口表数据同步到正式表出错!", null, new Object[]{});
                }
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[callSynProdcutInfo]"+"函数执行失败,将接口表数据同步到正式表出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        System.out.println("[callSynProdcutInfo]"+"结束执行存储过程sp_sync_prod_hs..");
        LogUtil.logInfo("[callSynProdcutInfo]"+"结束执行存储过程sp_sync_prod_hs..", null, new Object[]{});
        return isSuccess;
    }
    
}
