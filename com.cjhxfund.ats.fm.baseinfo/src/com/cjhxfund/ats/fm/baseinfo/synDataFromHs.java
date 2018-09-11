package com.cjhxfund.ats.fm.baseinfo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;

/**
 * @author 徐福羊
 * @date 2016-08-16 15:28:10
 * 
 */
@Bizlet("")
public class synDataFromHs {
    @Bizlet("")
    public boolean sysBaseInfoByHs() {
        boolean isSuccess = false;
        isSuccess = SynCommonUtil.synControl();
        if(isSuccess){
	        System.out.println("[sysBaseInfoByHs]"+"开始同步O32系统数据...");
	        LogUtil.logInfo("[sysBaseInfoByHs]"+"开始同步O32系统数据...", null, new Object[]{});
	        isSuccess = getDtataFromO32();
	        if (!isSuccess) {
	            LogUtil.logError("[sysBaseInfoByHs]"+"synDataFromHs.getDtataFromO32函数执行失败,同步O32系统数据出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        isSuccess = callSynProcedureByHs();
	        if (!isSuccess) {
	            LogUtil.logError("[sysBaseInfoByHs]"+"synDataFromHs.callSynProcedureByHs函数执行失败,执行存储过程sp_sync_data_hs出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        LogUtil.logInfo("[sysBaseInfoByHs]"+"结束同步O32系统数据...", null, new Object[]{});
	        System.out.println("[sysBaseInfoByHs]"+"结束同步O32系统数据...");
        }else{
        	LogUtil.logInfo("[synStockIssueInfo]"+"当前配置为手工操作，定时器不做任何操作。。。。", null, new Object[]{});
        }
        return isSuccess;
    }
    @Bizlet("")
    public static boolean getDtataFromO32() {
    	SynCommonUtil.insertMsg("2", "开始获取O32数据", 0, "获取O32数据", "开始获取O32数据,清空数据接口表并查询O32数据");
        Boolean flag = true;
        Connection conn_O32 = null;
        Connection conn_qjy = null;
        DataObject objIntfMarketInfo = null;
        DataObject objIntfStockType = null;
        DataObject objIntfIssuerInfo = null;
        DataObject objIntfStockIssueInfo = null;
        StringBuffer sql = new StringBuffer();
        StringBuffer sql_qjy = new StringBuffer();
        List<String> sqls = new ArrayList<String>();
        List<Map<String, String>> list_marketinfo = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_stocktype = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_issuerinfo = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_stockissue = new ArrayList<Map<String, String>>();
        System.out.println("[getDtataFromO32]"+"开始同步O32数据..");
        LogUtil.logInfo("[getDtataFromO32]"+"开始同步O32数据..", null, new Object[]{});
        
        /*01.清空接口表数据*/
        System.out.println("[getDtataFromO32]"+"开始清空接口表数据...");
        LogUtil.logInfo("[getDtataFromO32]"+"开始清空接口表数据...", null, new Object[]{});
        try {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_market_info");
            sqls.add(sql_qjy.toString());
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_stock_type");
            sqls.add(sql_qjy.toString());
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_issuer_info");
            sqls.add(sql_qjy.toString());
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_stock_issue_info");
            sqls.add(sql_qjy.toString());
            JDBCUtil.executeUpdateBatchWithConn(conn_qjy, sqls);
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            LogUtil.logError("[getDtataFromO32]"+"函数执行失败,清空表数据出错!", e, new Object[]{});
        } finally {
            sql_qjy.setLength(0);
            //sql_qjy = null;
            JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        if (!flag) return flag;
        System.out.println("[getDtataFromO32]"+"结束清空接口表数据...");
        LogUtil.logInfo("[getDtataFromO32]"+"结束清空接口表数据...", null, new Object[]{});
        /*02.拼接SQL语句从O32数据库中查询数据信息*/
        System.out.println("[getDtataFromO32]"+"开始拼接SQL语句从O32数据库中查询数据...");
        LogUtil.logInfo("[getDtataFromO32]"+"开始拼接SQL语句从O32数据库中查询数据...", null, new Object[]{});
        boolean execute = true;
        while (execute) {
            try {
                conn_O32 = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
                /*拼接获取O32交易市场表的SQL语句*/
                sql.setLength(0);
                sql.append("select a.c_market_no                   c_market_no,")
                   .append("       a.vc_market_status              vc_market_status,")
                   .append("       a.vc_market_char                vc_market_char,")
                   .append("       a.vc_market_name                vc_market_name,")
                   .append("       a.vc_market_caption             vc_market_caption,")
                   .append("       a.c_stop                        c_stop,")
                   .append("       nvl(a.l_morning_open_time,0)    l_morning_open_time,")
                   .append("       nvl(a.l_morning_close_time,0)   l_morning_close_time,")
                   .append("       nvl(a.l_afternoon_open_time,0)  l_afternoon_open_time,")
                   .append("       nvl(a.l_afternoon_close_time,0) l_afternoon_close_time,")
                   .append("       a.l_length_min                  l_length_min,")
                   .append("       a.l_length_max                  l_length_max,")
                   .append("       a.en_time_zone                  en_time_zone,")
                   .append("       a.vc_tradeday_type              vc_tradeday_type,")
                   .append("       nvl(a.l_dzjy_close_time,0)      l_dzjy_close_time,")
                   .append("       nvl(a.l_gdsy_close_time,0)      l_gdsy_close_time,")
                   .append("       nvl(a.l_last_trade_date,0)      l_last_trade_date,")
                   .append("       nvl(a.l_next_trade_date,0)      l_next_trade_date")
                   .append("  from trade.tmarketinfo a ")
                   .append("where a.c_market_no in ('1', '2', '5', '6')")
                   .append("  order by a.c_market_no asc");
                list_marketinfo = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
                /*拼接获取O32证券类别表的SQL语句*/
                sql.setLength(0);
                sql.append("select a.c_stock_type                 c_stock_type,")
                   .append("       a.c_market_no                  c_market_no,")
                   .append("       a.c_asset_class                c_asset_class,")
                   .append("       a.vc_stocktype_name            vc_stocktype_name,")
                   .append("       nvl(a.l_amount_per_hand,0)     l_amount_per_hand,")
                   .append("       nvl(a.l_buy_unit,0.00)         l_buy_unit,")
                   .append("       nvl(a.l_sale_unit,0.00)        l_sale_unit,")
                   .append("       nvl(a.en_face_values,0.00)     en_face_values,")
                   .append("       a.vc_entrust_right             vc_entrust_right,")
                   .append("       nvl(a.l_buy_max,0.00)          l_buy_max,")
                   .append("       nvl(a.l_sale_max,0.00)         l_sale_max,")
                   .append("       nvl(a.c_unit_control_type,'1') c_unit_control_type")
                   .append("  from trade.tstocktype a ")
                   .append("where a.c_market_no in ('1', '2', '5', '6') ")
                   .append("  order by a.c_stock_type asc");
                list_stocktype = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
                /*拼接获取O32发行人信息表的SQL语句*/
                sql.setLength(0);
                sql.append("select a.l_issuer_id       l_issuer_id,")
                   .append("       a.vc_issuer_name    vc_issue_name,")
                   .append("       a.vc_full_name      vc_issue_name_full,")
                   .append("       a.vc_issuer_code    vc_issuer_code,")
                   .append("       a.c_issuer_type     vc_issue_property,")
                   .append("       a.c_outer_appraise  c_issue_appraise,")
                   .append("       a.vc_appraise_organ vc_issue_appraise_organ,")
                   .append("       ''                  vc_industry,")
                   .append("       ''                  vc_province")
                   .append("  from trade.tissuer a ")
                   //.append("  from trade.tissuer a where rownum=1 ")
                   .append("  order by a.l_issuer_id asc");
                list_issuerinfo = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
                /*拼接获取O32新债发行信息表的SQL语句*/
                sql.setLength(0);
                sql.append("select 0 l_stock_issue_id,")
                   .append("       0 l_biz_id,")
                   .append("       0 l_stock_invest_no,")
                   .append("       '2' c_status,")
                   .append("       0 l_valid_status,")
                   .append("       to_number(to_char(sysdate, 'yyyymmdd')) l_date,")
                   .append("       b.c_market_no c_market_no,")
                   .append("       b.vc_inter_code vc_inter_code,")
                   .append("       b.vc_report_code vc_stock_code,")
                   .append("       b.vc_stock_name vc_stock_name,")
                   .append("       b.vc_stock_fullname vc_stock_name_full,")
                   .append("       b.c_stock_type vc_stock_type,")
                   .append("       b.vc_mixed_type vc_mixed_type,") //杂项分类
                   .append("       c.en_exist_limite en_exist_limite,")
                   .append("       a.l_issue_amount * 100.0 / 100000000 en_issue_balance,")//O32发行额度是张为单位，转换为亿
                   .append("       c.c_outer_appraise c_bond_appraise,")
                   .append("       c.vc_appraise_organ vc_bond_appraise_organ,")
                   .append("       d.l_issuer_id l_issuer_id,")
                   .append("       d.vc_issuer_name vc_issuer_name,")
                   .append("       d.vc_full_name vc_issuer_name_full,")
                   .append("       d.c_issuer_type vc_issue_property,")
                   .append("       d.c_outer_appraise c_issue_appraise,")
                   .append("       d.vc_appraise_organ vc_issue_appraise_organ,")
                   .append("       '' vc_industry,")
                   .append("       '' vc_province,")
                   .append("       nvl(decode(nvl(a.c_assure_type, '0'), '1', c.l_guarantor_id, 0),0) l_guarantor_id,")
                   .append("       case when nvl(a.c_assure_type, '0') <> '0' then")
                   .append("          (select tb.vc_issuer_name from trade.tissuer tb where tb.l_issuer_id = c.l_guarantor_id)")
                   .append("       else '' end vc_guarantor_name,")
                   .append("       case when nvl(a.c_assure_type, '0') <> '0' then")
                   .append("          (select tb.vc_summary from trade.tissuer tb where tb.l_issuer_id = c.l_guarantor_id)")
                   .append("       else '' end vc_guarantor_summary,")
                   .append("       c.l_publish_date l_issue_post_date,")
                   .append("       b.l_publish_date l_issue_begin_date,")
                   .append("       a.l_pay_limit_date l_pay_date,")
                   .append("       c.l_market_date l_publish_date,")
                   .append("       c.l_begincal_date l_begincal_date,")
                   .append("       0 l_endincal_date,")
                   .append("       c.c_interest_type c_interest_type,")
                   .append("       c.c_pay_interest_type c_pay_interest_type,")
                   .append("       c.en_pay_inteval en_pay_inteval,")
                   .append("       c.en_year_rate * 100 en_face_rate,")
                   .append("       a.c_bid_type c_bid_type,")
                   .append("       '' c_pay_type,")
                   .append("       '' vc_special_text,")
                   .append("       '' vc_main_underwriter,")
                   .append("       '' vc_deputy_underwriter,")
                   .append("       '' c_underwrite_type,")
                   .append("       '' vc_group_underwriter,")
                   .append("       0 l_next_exercise_date,")
                   .append("       '' c_is_small_raised,")
                   .append("       decode(nvl(c.c_investor_operation_type, '0'), '1', '1', '0') c_is_have_saleback,") 
                   .append("       0 l_bond_issue_file,")
                   .append("       0 l_raise_inst_file,")
                   .append("       0 l_rate_report_file,")
                   .append("       '3' c_source,")
                   .append("       0 l_operator_no,")
                   .append("       0 l_credit_analyze_no,")
                   .append("       '' vc_credit_analyze,")
                   .append("       0 l_attch_count,")
                   .append("       case when (b.vc_stock_name like '%(增%' or b.vc_stock_name like '%(续%') then decode(f.c_market_no,'5',decode(nvl(g.c_trustee,'0'),'1','01','2','02','99'),'1','03','2','04','99')")
                   .append("            else decode(b.c_market_no,'5',decode(nvl(c.c_trustee,'0'),'1','01','2','02','99'),'1','03','2','04','99') end vc_payment_place,")
                   .append("      case when (a.en_lower_price<>0 or a.en_upper_price<>0) then to_char(a.en_lower_price,'990.99')||'-'|| to_char(a.en_upper_price,'990.99') end vc_tender_interval")
                   .append("      from trade.tstockissueinfo a ")
	               .append("      inner join trade.tstockinfo b on a.vc_inter_code = b.vc_inter_code ")
	               .append("      inner join trade.tbondproperty c on  a.vc_inter_code = c.vc_inter_code ")
	               .append("      inner join trade.tstocktype e on b.c_market_no = e.c_market_no and  b.c_stock_type = e.c_stock_type ") 
	               .append("      inner join trade.tissuer d on b.l_company_id = to_number(d.l_issuer_id) ")
	               .append("      left outer join   trade.tstockinfo f on substr(b.vc_stock_name,1,instr(b.vc_stock_name,'(')-1) = f.vc_stock_name ")
	               .append("      left outer join trade.tbondproperty g on f.vc_inter_code = g.vc_inter_code ")
	               .append("      where  ((b.c_market_no='6' and instr(',3,>,',','||b.c_stock_type||',')>0) or ")  
	               .append("         (b.c_market_no='5' and instr(',3,4,6,D,G,K,T,>,',','||b.c_stock_type||',')>0) or ")  
	               .append("          (instr(',1,2,',b.c_market_no)>0 and instr(',a,d,k,',','||b.c_stock_type||',')<=0 and e.c_asset_class='3')) ")   
	               .append("      and b.c_market_no in ('1','2','5') ")                     
	               .append("      order by b.c_market_no,b.l_publish_date asc ") ;
                   /*.append("  from trade.tstockissueinfo a, trade.tstockinfo b, trade.tbondproperty c, trade.tissuer d,trade.tstocktype e, trade.tstockinfo f,trade.tbondproperty g ")
                   .append("where a.vc_inter_code = b.vc_inter_code")
                   .append("  and a.vc_inter_code = c.vc_inter_code")
                   .append("  and b.c_market_no = e.c_market_no")
                   .append("  and b.c_stock_type = e.c_stock_type")
                   .append("  and ((b.c_market_no='6' and instr(',3,>,',','||b.c_stock_type||',')>0) or")
                   .append("       (b.c_market_no='5' and instr(',3,4,6,D,G,K,T,>,',','||b.c_stock_type||',')>0) or")
                   .append("       (instr(',1,2,',b.c_market_no)>0 and instr(',a,d,k,',','||b.c_stock_type||',')<=0 and e.c_asset_class='3'))")
                   .append("  and b.l_company_id = to_number(d.l_issuer_id)")
                   .append("  and b.c_market_no in ('1','2','5')")
                   .append("  and substr(b.vc_stock_name,1,instr(b.vc_stock_name,'(')-1) = f.vc_stock_name(+) ")
                   .append("  and f.vc_inter_code = g.vc_inter_code")
                   .append("  order by b.c_market_no,b.l_publish_date asc");*/
                list_stockissue = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
                SynCommonUtil.insertMsg("2", sql.toString(), 0, "获取O32数据", "查询O32新债信息SQL");
                execute = false;
            } catch (Exception e) {
                flag = false;
                execute = false;
                e.printStackTrace();
                SynCommonUtil.insertMsg("1", e.getMessage(), 0, "获取O32数据", "查询O32数据信息");
                LogUtil.logError("[getDtataFromO32]"+"函数执行失败,拼接SQL语句从O32数据库中查询数据出错!", e, new Object[]{});
            } finally {
                sql.setLength(0);
                sql = null;
                execute = false;
                JDBCUtil.releaseResource(conn_O32, null, null);
            }
        }
        if (!flag) return flag;
        System.out.println("[getDtataFromO32]"+"结束拼接SQL语句从O32数据库中查询数据...");
        LogUtil.logInfo("[getDtataFromO32]"+"结束拼接SQL语句从O32数据库中查询数据...", null, new Object[]{});
        /*03.将O32表中的数据插入到接口表中*/
        System.out.println("[getDtataFromO32]"+"开始将O32表中的数据插入到接口表...");
        LogUtil.logInfo("[getDtataFromO32]"+"开始将O32表中的数据插入到接口表...", null, new Object[]{});
        try {           
            /*将O32的交易市场信息表数据插入到接口表*/
            if (!list_marketinfo.isEmpty() && list_marketinfo.size() > 0) {
                List<DataObject> objIntfMarketInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_marketinfo.size(); i++) {
                    Map<String, String> map = list_marketinfo.get(i);
                    objIntfMarketInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfMarketInfo");
                    objIntfMarketInfo.setString("cMarketNo", map.get("C_MARKET_NO"));
                    objIntfMarketInfo.setString("sMarketStatus", map.get("VC_MARKET_STATUS"));
                    objIntfMarketInfo.setString("sMarketChar", map.get("VC_MARKET_CHAR"));
                    objIntfMarketInfo.setString("sMarketName", map.get("VC_MARKET_NAME"));
                    objIntfMarketInfo.setString("sMarketCaption", map.get("VC_MARKET_CAPTION"));
                    objIntfMarketInfo.setString("cStop", map.get("C_STOP"));
                    objIntfMarketInfo.setLong("iMorningOpenTime", Long.parseLong(map.get("L_MORNING_OPEN_TIME")));
                    objIntfMarketInfo.setLong("iMorningCloseTime", Long.parseLong(map.get("L_MORNING_CLOSE_TIME")));
                    objIntfMarketInfo.setLong("iAfternoonOpenTime", Long.parseLong(map.get("L_AFTERNOON_OPEN_TIME")));
                    objIntfMarketInfo.setLong("iAfternoonCloseTime", Long.parseLong(map.get("L_AFTERNOON_CLOSE_TIME")));
                    objIntfMarketInfo.setLong("iLengthMin", Long.parseLong(map.get("L_LENGTH_MIN")));
                    objIntfMarketInfo.setLong("iLengthMax", Long.parseLong(map.get("L_LENGTH_MAX")));
                    objIntfMarketInfo.setDouble("dTimeZone", Double.parseDouble(map.get("EN_TIME_ZONE")));
                    objIntfMarketInfo.setString("sTradedayType", map.get("VC_TRADEDAY_TYPE"));
                    objIntfMarketInfo.setLong("iDzjyCloseTime", Long.parseLong(map.get("L_DZJY_CLOSE_TIME")));
                    objIntfMarketInfo.setLong("iGdsyCloseTime", Long.parseLong(map.get("L_GDSY_CLOSE_TIME")));
                    objIntfMarketInfo.setLong("iLastTradeDate", Long.parseLong(map.get("L_LAST_TRADE_DATE")));
                    objIntfMarketInfo.setLong("iNextTradeDate", Long.parseLong(map.get("L_NEXT_TRADE_DATE")));
                    objIntfMarketInfos.add(objIntfMarketInfo);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfMarketInfo);
                    objIntfMarketInfo = null;
                }
                DataObject objIntfMarketInfoss[] = new DataObject[objIntfMarketInfos.size()];
                objIntfMarketInfos.toArray(objIntfMarketInfoss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfMarketInfoss);
                SynCommonUtil.insertMsg("0", "获取交易市场完成", objIntfMarketInfoss.length, "获取交易市场", "将O32交易市场表数据归集到交易市场接口表");
                objIntfMarketInfos = null;
            }
            /*将O32的证券资料表数据插入到接口表*/
            if (!list_stocktype.isEmpty() && list_stocktype.size() > 0) {
                List<DataObject> objIntfStockTypes = new ArrayList<DataObject>();
                for (int i = 0; i < list_stocktype.size(); i++) {
                    Map<String, String> map = list_stocktype.get(i);
                    objIntfStockType = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfStockType");
                    objIntfStockType.setString("cStockType", map.get("C_STOCK_TYPE"));
                    objIntfStockType.setString("cMarketNo", map.get("C_MARKET_NO"));
                    objIntfStockType.setString("cAssetClass", map.get("C_ASSET_CLASS"));
                    objIntfStockType.setString("sStocktypeName", map.get("VC_STOCKTYPE_NAME"));
                    objIntfStockType.setLong("iAmountPerHand", Long.parseLong(map.get("L_AMOUNT_PER_HAND")));
                    objIntfStockType.setDouble("iBuyUnit", Double.parseDouble(map.get("L_BUY_UNIT")));
                    objIntfStockType.setDouble("iSaleUnit", Double.parseDouble(map.get("L_SALE_UNIT")));
                    objIntfStockType.setDouble("dFaceValues", Double.parseDouble(map.get("EN_FACE_VALUES")));
                    objIntfStockType.setString("sEntrustRight", map.get("VC_ENTRUST_RIGHT"));
                    objIntfStockType.setDouble("iBuyMax", Double.parseDouble(map.get("L_BUY_MAX")));
                    objIntfStockType.setDouble("iSaleMax", Double.parseDouble(map.get("L_SALE_MAX")));
                    objIntfStockType.setString("cUnitControlType", map.get("C_UNIT_CONTROL_TYPE"));
                    objIntfStockTypes.add(objIntfStockType);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfStockType);
                    objIntfStockType = null;
                }
                DataObject objIntfStockTypess[] = new DataObject[objIntfStockTypes.size()];
                objIntfStockTypes.toArray(objIntfStockTypess);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfStockTypess);
                SynCommonUtil.insertMsg("0", "获取证券类型完成", objIntfStockTypess.length, "获取证券类型", "将O32证券类型表数据归集到债券类型接口表");
                objIntfStockTypes = null;
            }
            /*将O32的发行人信息表数据插入到接口表*/
            if (!list_issuerinfo.isEmpty() && list_issuerinfo.size() > 0) {
                List<DataObject> objIntfIssuerInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_issuerinfo.size(); i++) {
                    Map<String, String> map = list_issuerinfo.get(i);
                    objIntfIssuerInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfIssuerInfo");
                    objIntfIssuerInfo.setLong("iIssuerId", Long.parseLong(map.get("L_ISSUER_ID")));
                    objIntfIssuerInfo.setString("sIssueName", map.get("VC_ISSUE_NAME"));
                    objIntfIssuerInfo.setString("sIssueNameFull", map.get("VC_ISSUE_NAME_FULL"));
                    objIntfIssuerInfo.setString("sIssuerCode", map.get("VC_ISSUER_CODE"));
                    objIntfIssuerInfo.setString("sIssueProperty", map.get("VC_ISSUE_PROPERTY"));
                    objIntfIssuerInfo.setString("cIssueAppraise", map.get("C_ISSUE_APPRAISE"));
                    objIntfIssuerInfo.setString("sIssueAppraiseOrgan", map.get("VC_ISSUE_APPRAISE_ORGAN"));
                    objIntfIssuerInfo.setString("sIndustry", map.get("VC_INDUSTRY"));
                    objIntfIssuerInfo.setString("sProvince", map.get("VC_PROVINCE"));
                    objIntfIssuerInfos.add(objIntfIssuerInfo);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfIssuerInfo);
                    objIntfIssuerInfo = null;
                }
                DataObject objIntfIssuerInfoss[] = new DataObject[objIntfIssuerInfos.size()];
                objIntfIssuerInfos.toArray(objIntfIssuerInfoss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfIssuerInfoss);
                SynCommonUtil.insertMsg("0", "获取发行人信息完成", objIntfIssuerInfoss.length, "获取发行人信息", "将O32发行人信息表数据归集到发行人信息接口表");
                objIntfIssuerInfos = null;
            }
            /*将O32的新债发行信息表数据插入到接口表*/
            System.out.println("新债信息表：======"+list_stockissue.size());
            if (!list_stockissue.isEmpty() && list_stockissue.size() > 0) {
                List<DataObject> objIntfStockIssueInfos = new ArrayList<DataObject>();
                for (int i = 0; i < list_stockissue.size(); i++) {
                    Map<String, String> map = list_stockissue.get(i);
                    
                    objIntfStockIssueInfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfStockIssueInfo");
                    objIntfStockIssueInfo.setLong("iStockIssueId", Long.parseLong(map.get("L_STOCK_ISSUE_ID")));
                    objIntfStockIssueInfo.setLong("iBizId", Long.parseLong(map.get("L_BIZ_ID")));
                    objIntfStockIssueInfo.setLong("iStockInvestNo", Long.parseLong(map.get("L_STOCK_INVEST_NO")));
                    objIntfStockIssueInfo.setString("cStatus", map.get("C_STATUS"));
                    objIntfStockIssueInfo.setLong("iValidStatus", Long.parseLong(map.get("L_VALID_STATUS")));
                    objIntfStockIssueInfo.setLong("iDate", Long.parseLong(map.get("L_DATE")));
                    objIntfStockIssueInfo.setString("cMarketNo", map.get("C_MARKET_NO"));
                    objIntfStockIssueInfo.setString("sInterCode", map.get("VC_INTER_CODE"));
                    objIntfStockIssueInfo.setString("sStockCode", map.get("VC_STOCK_CODE"));
                    objIntfStockIssueInfo.setString("sStockName", map.get("VC_STOCK_NAME"));
                    objIntfStockIssueInfo.setString("sStockNameFull", map.get("VC_STOCK_NAME_FULL"));
                    objIntfStockIssueInfo.setString("sStockType", "0");
                    objIntfStockIssueInfo.setString("sStockTypeO32", map.get("VC_STOCK_TYPE"));
                    objIntfStockIssueInfo.setDouble("dExistLimite", Double.parseDouble(map.get("EN_EXIST_LIMITE")));
                    objIntfStockIssueInfo.setDouble("dIssueBalance", Double.parseDouble(map.get("EN_ISSUE_BALANCE")));
                    objIntfStockIssueInfo.setString("cBondAppraise", map.get("C_BOND_APPRAISE"));
                    objIntfStockIssueInfo.setString("sBondAppraiseOrgan", map.get("VC_BOND_APPRAISE_ORGAN"));
                    objIntfStockIssueInfo.setLong("iIssuerId", Long.parseLong(map.get("L_ISSUER_ID")));
                    objIntfStockIssueInfo.setString("sIssuerName", map.get("VC_ISSUER_NAME"));
                    objIntfStockIssueInfo.setString("sIssuerNameFull", map.get("VC_ISSUER_NAME_FULL"));
                    objIntfStockIssueInfo.setString("sIssueProperty", map.get("VC_ISSUE_PROPERTY"));
                    objIntfStockIssueInfo.setString("cIssueAppraise", map.get("C_ISSUE_APPRAISE"));
                    objIntfStockIssueInfo.setString("sIssueAppraiseOrgan", map.get("VC_ISSUE_APPRAISE_ORGAN"));
                    objIntfStockIssueInfo.setString("sIndustry", map.get("VC_INDUSTRY"));
                    objIntfStockIssueInfo.setString("sProvince", map.get("VC_PROVINCE"));
                    objIntfStockIssueInfo.setLong("iGuarantorId", Long.parseLong(map.get("L_GUARANTOR_ID")));
                    objIntfStockIssueInfo.setString("sGuarantorName", map.get("VC_GUARANTOR_NAME"));
                    objIntfStockIssueInfo.setString("sGuarantorSummary", map.get("VC_GUARANTOR_SUMMARY"));
                    objIntfStockIssueInfo.setLong("iIssuePostDate", Long.parseLong(map.get("L_ISSUE_POST_DATE")));
                    objIntfStockIssueInfo.setLong("iIssueBeginDate", Long.parseLong(map.get("L_ISSUE_BEGIN_DATE")));
                    objIntfStockIssueInfo.setLong("iPayDate", Long.parseLong(map.get("L_PAY_DATE")));
                    objIntfStockIssueInfo.setLong("iPublishDate", Long.parseLong(map.get("L_PUBLISH_DATE")));
                    objIntfStockIssueInfo.setLong("iBegincalDate", Long.parseLong(map.get("L_BEGINCAL_DATE")));
                    objIntfStockIssueInfo.setLong("iEndincalDate", Long.parseLong(map.get("L_ENDINCAL_DATE")));
                    objIntfStockIssueInfo.setString("cInterestType", map.get("C_INTEREST_TYPE"));
                    objIntfStockIssueInfo.setString("cPayInterestType", map.get("C_PAY_INTEREST_TYPE"));
                    objIntfStockIssueInfo.setDouble("dPayInteval", Double.parseDouble(map.get("EN_PAY_INTEVAL")));
                    objIntfStockIssueInfo.setDouble("dFaceRate", Double.parseDouble(map.get("EN_FACE_RATE")));
                    objIntfStockIssueInfo.setString("cBidType", map.get("C_BID_TYPE"));
                    objIntfStockIssueInfo.setString("cPayType", map.get("C_PAY_TYPE"));
                    objIntfStockIssueInfo.setString("sSpecialText", map.get("VC_SPECIAL_TEXT"));
                    objIntfStockIssueInfo.setString("sMainUnderwriter", map.get("VC_MAIN_UNDERWRITER"));
                    objIntfStockIssueInfo.setString("sDeputyUnderwriter", map.get("VC_DEPUTY_UNDERWRITER"));
                    objIntfStockIssueInfo.setString("cUnderwriteType", map.get("C_UNDERWRITE_TYPE"));
                    objIntfStockIssueInfo.setString("sGroupUnderwriter", map.get("VC_GROUP_UNDERWRITER"));
                    objIntfStockIssueInfo.setLong("iNextExerciseDate", Long.parseLong(map.get("L_NEXT_EXERCISE_DATE")));
                    objIntfStockIssueInfo.setString("cIsSmallRaised", map.get("C_IS_SMALL_RAISED"));
                    objIntfStockIssueInfo.setString("cIsHaveSaleback", map.get("C_IS_HAVE_SALEBACK"));
                    objIntfStockIssueInfo.setLong("iBondIssueFile", Long.parseLong(map.get("L_BOND_ISSUE_FILE")));
                    objIntfStockIssueInfo.setLong("iRaiseInstFile", Long.parseLong(map.get("L_RAISE_INST_FILE")));
                    objIntfStockIssueInfo.setLong("iRateReportFile", Long.parseLong(map.get("L_RATE_REPORT_FILE")));
                    objIntfStockIssueInfo.setString("cSource", map.get("C_SOURCE"));
                    objIntfStockIssueInfo.setLong("iOperatorNo", Long.parseLong(map.get("L_OPERATOR_NO")));
                    objIntfStockIssueInfo.setLong("iCreditAnalyzeNo", Long.parseLong(map.get("L_CREDIT_ANALYZE_NO")));
                    objIntfStockIssueInfo.setString("sCreditAnalyze", map.get("VC_CREDIT_ANALYZE"));
                    objIntfStockIssueInfo.setLong("iAttchCount", Long.parseLong(map.get("L_ATTCH_COUNT")));
                    objIntfStockIssueInfo.setString("sPaymentPlace", map.get("VC_PAYMENT_PLACE"));
                    objIntfStockIssueInfo.setString("sMixedType", map.get("VC_MIXED_TYPE"));
                    objIntfStockIssueInfo.setString("vcTenderInterval", map.get("VC_TENDER_INTERVAL"));
                    objIntfStockIssueInfos.add(objIntfStockIssueInfo);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfStockIssueInfo);
                    objIntfStockIssueInfo = null;
                }
                DataObject objIntfStockIssueInfoss[] = new DataObject[objIntfStockIssueInfos.size()];
                objIntfStockIssueInfos.toArray(objIntfStockIssueInfoss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfStockIssueInfoss);
                SynCommonUtil.insertMsg("0", "获取新债信息完成", objIntfStockIssueInfoss.length, "获取新债信息", "将O32新债信息表数据归集到新债信息接口表");
                objIntfStockIssueInfos = null;
                sql_qjy = null;
                JDBCUtil.releaseResource(conn_qjy, null, null);
            }else{
            	SynCommonUtil.insertMsg("2", "没有获取到新债信息", 0, "获取新债信息", "将O32新债信息表数据归集到新债信息接口表");
            }
            flag = true;
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            SynCommonUtil.insertMsg("1", e.getMessage(), 0, "获取O32数据", "将O32基础信息数据归集到数据接口表");
            LogUtil.logError("[getDtataFromO32]"+"函数执行失败,将O32表中的数据插入到接口表出错!", e, new Object[]{});
        }
        if (!flag) return flag;
        LogUtil.logInfo("[getDtataFromO32]"+"结束将O32表中的数据插入到接口表...", null, new Object[]{});
        System.out.println("[getDtataFromO32]"+"结束将O32表中的数据插入到接口表...");
        LogUtil.logInfo("[getDtataFromO32]"+"结束同步O32数据..", null, new Object[]{});
        System.out.println("[getDtataFromO32]"+"结束同步O32数据..");
        SynCommonUtil.insertMsg("2", "结束获取O32数据", 0, "获取O32数据", "结束获取O32数据");
        return flag;
    }
    @Bizlet("")
	public static boolean callSynProcedureByHs() {
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[callSynProcedureByHs]"+"开始执行存储过程sp_sync_data_hs..");
        LogUtil.logInfo("[callSynProcedureByHs]"+"开始执行存储过程sp_sync_data_hs..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call sp_sync_data_hs(?,?)}";
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
                    LogUtil.logError("[callSynProcedureByHs]"+"函数执行失败,将接口表数据同步到正式表出错!", null, new Object[]{});
                }
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[callSynProcedureByHs]"+"函数执行失败,将接口表数据同步到正式表出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        System.out.println("[callSynProcedureByHs]"+"结束执行存储过程sp_sync_data_hs..");
        LogUtil.logInfo("[callSynProcedureByHs]"+"结束执行存储过程sp_sync_data_hs..", null, new Object[]{});
        return isSuccess;
    }
    
}
