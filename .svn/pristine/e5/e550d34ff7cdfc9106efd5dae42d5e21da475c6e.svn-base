package com.cjhxfund.ats.fm.baseinfo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 徐福羊
 * @date 2016-08-23 11:00:10
 * 
 */
@Bizlet("")
public class synDataFromWind {
    @Bizlet("")
    public boolean sysBaseInfoByWind() {
        boolean isSuccess = false;
        isSuccess = SynCommonUtil.synControl();
        if(isSuccess){
	        System.out.println("[sysBaseInfoByWind]"+"开始同步Wind系统数据...");
	        LogUtil.logInfo("[sysBaseInfoByWind]"+"开始同步Wind系统数据...", null, new Object[]{});
	        isSuccess = getDtataFromWind();
	        if (!isSuccess) {
	            LogUtil.logError("[sysBaseInfoByWind]"+"sysBaseInfoByWind.getDtataFromWind函数执行失败,同步Wind系统数据出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        isSuccess = callSynProcedureByWind();
	        if (!isSuccess) {
	            LogUtil.logError("[sysBaseInfoByWind]"+"sysBaseInfoByWind.callSynProcedureByWind函数执行失败,执行存储过程sp_sync_data_wind出错!", null, new Object[]{});
	            return isSuccess;
	        }
	        LogUtil.logInfo("[sysBaseInfoByWind]"+"结束同步Wind系统数据...", null, new Object[]{});
	        System.out.println("[sysBaseInfoByWind]"+"结束同步Wind系统数据...");
        }else{
        	LogUtil.logInfo("[synStockIssueInfo]"+"当前配置为手工操作，定时器不做任何操作。。。。", null, new Object[]{});
        }
        return isSuccess;
    }

    @Bizlet("")
	public static boolean getDtataFromWind() {
    	SynCommonUtil.insertMsg("2", "开始获取Wind数据", 0, "获取Wind数据", "开始获取Wind数据,清空数据接口表并查询Wind数据");
        Boolean flag = true;
        Connection conn_qjy = null;
        DataObject objIntfStockInfoWind = null;
        StringBuffer sql = new StringBuffer();
        StringBuffer sql_qjy = new StringBuffer();
        List<String> sqls = new ArrayList<String>();
        List<Map<String, String>> list_stockissue = new ArrayList<Map<String, String>>();
        /*01.清空接口表数据*/
        System.out.println("[getDtataFromWind]"+"开始清空接口表数据...");
        LogUtil.logInfo("[getDtataFromWind]"+"开始清空接口表数据...", null, new Object[]{});
        try {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            sql_qjy.setLength(0);
            sql_qjy.append("truncate table t_ats_intf_stock_info_wind");
            sqls.add(sql_qjy.toString());
            JDBCUtil.executeUpdateBatchWithConn(conn_qjy, sqls);
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            LogUtil.logError("[getDtataFromWind]"+"函数执行失败,清空表数据出错!", e, new Object[]{});
        } finally {
            sql_qjy.setLength(0);
            sql_qjy = null;
            JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        if (!flag) return flag;
        System.out.println("[getDtataFromWind]"+"结束清空接口表数据...");
        LogUtil.logInfo("[getDtataFromWind]"+"结束清空接口表数据...", null, new Object[]{});
        
        /*02.拼接SQL语句从Wind数据库中查询数据信息*/
        System.out.println("[getDtataFromWind]"+"开始拼接SQL语句从Wind数据库中查询数据...");
        LogUtil.logInfo("[getDtataFromWind]"+"开始拼接SQL语句从Wind数据库中查询数据...", null, new Object[]{});
        boolean execute = true;
        while (execute) {
            try {
                /*拼接获取Wind新债发行信息表的SQL语句*/
                sql.setLength(0);
                sql.append("");
                sql.append("select nvl(a.l_date,0)   l_date,")
                   	.append("  a.vc_market_type   vc_market_type,")
                   	.append("  a.vc_inter_code    vc_inter_code,")
                   	.append("  a.vc_stock_code    vc_stock_code,")
                   	.append("  a.vc_stock_name    vc_stock_name,")
                   	.append("  a.vc_stock_name_full  vc_stock_name_full,")
                   	.append("  a.vc_stock_type  vc_stock_type,")
                   	.append("  nvl(a.en_exist_limite,0)  en_exist_limite,")
					.append("  nvl(a.en_issue_balance,0)  en_issue_balance,")
					.append("  a.vc_bond_appraise   vc_bond_appraise,")
					.append("  a.vc_bond_appraise_organ  vc_bond_appraise_organ,")
					.append("  a.l_issuer_id  l_issuer_id,")
					.append("  a.vc_issuer_name_short  vc_issuer_name,")
					.append("  a.vc_issuer_name_full  vc_issuer_name_full,")
					.append("  a.vc_issue_property  vc_issue_property,")
					.append("  a.vc_issue_appraise  vc_issue_appraise,")
					.append("  a.vc_issue_appraise_organ  vc_issue_appraise_organ,")
					.append("  a.vc_industry    vc_industry,")
					.append("  a.vc_industry_1  vc_industry_wind1,")
					.append("  a.vc_industry_2  vc_industry_wind2,")
					.append("  a.vc_industry_3  vc_industry_wind3,")
					.append("  a.vc_industry_4  vc_industry_wind4,")
					.append("  a.vc_province  vc_province,")
					.append("  a.l_guarantor_id   l_guarantor_id,")
					.append("  a.vc_guarantor_name_full  vc_guarantor_name_full,")
					.append("  a.vc_guarantor_summary  vc_guarantor_summary,")
					.append("  nvl(a.l_issue_post_date,0)  l_issue_post_date,")
					.append("  nvl(a.l_issue_begin_date,0)  l_issue_begin_date,")
					.append("  nvl(a.l_issue_end_date,0)  l_issue_end_date,")
					.append("  nvl(a.l_pay_date,0)  l_pay_date,")
					.append("  nvl(a.l_publish_date,0)  l_publish_date,")
					.append("  nvl(a.l_begincal_date,0) l_begincal_date,")
					.append("  nvl(a.l_endincal_date,0) l_endincal_date,")
					.append("  a.c_interest_type  c_interest_type,")
					.append("  a.c_pay_interest_type   c_pay_interest_type,")
					.append("  nvl(a.en_pay_inteval,0)   en_pay_inteval,")
					.append("  nvl(a.en_face_rate,0)  en_face_rate,")
					.append("  a.c_bid_type   c_bid_type,")
					.append("  a.c_pay_type   c_pay_type,")
					.append("  a.vc_special_text  vc_special_text,")
					.append("  a.vc_main_underwriter_id  vc_main_underwriter_id,")
					.append("  a.vc_main_underwriter   vc_main_underwriter,")
					.append("  a.vc_deputy_underwriter_id  vc_deputy_underwriter_id,")
					.append("  a.vc_deputy_underwriter  vc_deputy_underwriter,")
					.append("  a.c_underwrite_type  c_underwrite_type,")
					.append("  a.vc_group_underwriter  vc_group_underwriter,")
					.append("  nvl(a.l_next_exercise_date,0)  l_next_exercise_date,")
					.append("  a.c_is_small_raised   c_is_small_raised,")
					.append("  a.c_is_have_saleback  c_is_have_saleback,")
					.append("  a.vc_payment_place  vc_payment_place,")
					.append("  a.vc_assure_type   vc_assure_type,")
					.append("  a.vc_special_text_desc  vc_special_text_desc,")
					.append("  a.vc_issue_type  vc_issue_type,")
					.append("  a.vc_special_limite   vc_special_limite,")
					.append("  a.vc_tender_interval   vc_tender_interval,")
					.append("  (case when VC_INDUSTRY_CSRC_4 is not null and  VC_INDUSTRY_CSRC_4 <> 0 then VC_INDUSTRY_CSRC_4 "
							+ "when VC_INDUSTRY_CSRC_3 is not null and  VC_INDUSTRY_CSRC_3 <> 0 then VC_INDUSTRY_CSRC_3  "
							+ "when VC_INDUSTRY_CSRC_2 is not null and  VC_INDUSTRY_CSRC_2 <> 0 then VC_INDUSTRY_CSRC_2 "
							+ "else VC_INDUSTRY_CSRC_1 end)  vc_issue_appraise_csrc,")
                    .append("  a.vc_city_level  vc_city_level,")
					.append("  a.l_n_interest_rate_jump_points  l_n_interest_rate_jump_points,")
					.append("  a.en_issuer_net_value   en_issuer_net_value,")
					.append("  a.vc_mortgage_stk_code  vc_mort_stock_code,")
					.append("  a.vc_mortgage_stk_code  vc_mort_stock_name,")
					.append("  a.vc_mortgage_stk_amount   vc_mort_stock_amount")
                   .append("  from isp.bondinfo_wind a, ")
                   .append("  (select a.l_date,row_number()over(order by a.l_date desc) as row_index from isp.tmarkettradeday a where a.vc_tradeday_type = '00' and a.c_trade_flag = '1' and a.l_date <= to_char(sysdate,'yyyymmdd')) b")
                   .append(" where a.vc_market_type in ('上海','深圳','银行间债券') ")
                   .append(" and  (a.vc_stock_type is not null or a.vc_stock_name like '%CD%')")
                   .append(" and  b.row_index = 4")
                   .append(" and (case when a.l_pay_date is not null then a.l_pay_date else 99999999 end) >= b.l_date ")
                   .append(" and (case when a.l_issue_end_date is not null then a.l_issue_end_date else 99999999 end) >= b.l_date ")
                   .append("    order by a.l_date,a.vc_market_type,a.vc_stock_code ");
                conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
                list_stockissue = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
                SynCommonUtil.insertMsg("2", sql.toString(), 0, "获取Wind数据", "查询Wind新债信息SQL");
                execute = false;
            } catch (Exception e) {
                flag = false;
                e.printStackTrace();
                SynCommonUtil.insertMsg("1", e.getMessage(), 0, "获取Wind数据", "查询Wind新债信息");
                LogUtil.logError("[getDtataFromWind]"+"函数执行失败,拼接SQL语句从Wind数据库中查询数据出错!", e, new Object[]{});
            } finally {
                sql.setLength(0);
                sql = null;
                JDBCUtil.releaseResource(conn_qjy, null, null);
            }
        }
        if (!flag) return flag;
        System.out.println("[getDtataFromWind]"+"结束拼接SQL语句从Wind数据库中查询数据...");
        LogUtil.logInfo("[getDtataFromWind]"+"结束拼接SQL语句从Wind数据库中查询数据...", null, new Object[]{});
        
        /*03.将Wind表中的数据插入到接口表中*/
        System.out.println("[getDtataFromWind]"+"开始将Wind表中的数据插入到接口表...");
        LogUtil.logInfo("[getDtataFromWind]"+"开始将Wind表中的数据插入到接口表...", null, new Object[]{});
        try {
            if (!list_stockissue.isEmpty() && list_stockissue.size() > 0) {
                List<DataObject> objIntfStockInfoWinds = new ArrayList<DataObject>();
                for (int i = 0; i < list_stockissue.size(); i++) {
                    Map<String, String> map = list_stockissue.get(i);
                    objIntfStockInfoWind = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsIntfStockInfoWind");
                    objIntfStockInfoWind.setLong("lDate", Long.parseLong(map.get("L_DATE")));
                    objIntfStockInfoWind.setString("vcMarketType", map.get("VC_MARKET_TYPE"));
                    objIntfStockInfoWind.setString("vcInterCode", map.get("VC_INTER_CODE"));
                    objIntfStockInfoWind.setString("vcStockCode", map.get("VC_STOCK_CODE"));
                    objIntfStockInfoWind.setString("vcStockName", map.get("VC_STOCK_NAME"));
                    objIntfStockInfoWind.setString("vcStockNameFull", map.get("VC_STOCK_NAME_FULL"));
                    objIntfStockInfoWind.setString("vcStockType", map.get("VC_STOCK_TYPE"));
                    objIntfStockInfoWind.setDouble("enExistLimite", Double.parseDouble(map.get("EN_EXIST_LIMITE")));
                    objIntfStockInfoWind.setDouble("enIssueBalance", Double.parseDouble(map.get("EN_ISSUE_BALANCE")));
                    objIntfStockInfoWind.setString("vcBondAppraise", map.get("VC_BOND_APPRAISE"));
                    objIntfStockInfoWind.setString("vcBondAppraiseOrgan", map.get("VC_BOND_APPRAISE_ORGAN"));
                    objIntfStockInfoWind.setString("lIssuerId", map.get("L_ISSUER_ID"));
                    objIntfStockInfoWind.setString("vcIssuerName", map.get("VC_ISSUER_NAME"));
                    objIntfStockInfoWind.setString("vcIssuerNameFull", map.get("VC_ISSUER_NAME_FULL"));
                    objIntfStockInfoWind.setString("vcIssueProperty", map.get("VC_ISSUE_PROPERTY"));
                    objIntfStockInfoWind.setString("vcIssueAppraise", map.get("VC_ISSUE_APPRAISE"));
                    objIntfStockInfoWind.setString("vcIssueAppraiseOrgan", map.get("VC_ISSUE_APPRAISE_ORGAN"));
                    objIntfStockInfoWind.setString("vcIndustry", map.get("VC_INDUSTRY"));
                    objIntfStockInfoWind.setString("vcIndustryWind1", map.get("VC_INDUSTRY_WIND1"));
                    objIntfStockInfoWind.setString("vcIndustryWind2", map.get("VC_INDUSTRY_WIND2"));
                    objIntfStockInfoWind.setString("vcIndustryWind3", map.get("VC_INDUSTRY_WIND3"));
                    objIntfStockInfoWind.setString("vcIndustryWind4", map.get("VC_INDUSTRY_WIND4"));
                    objIntfStockInfoWind.setString("vcProvince", map.get("VC_PROVINCE"));
                    objIntfStockInfoWind.setString("lGuarantorId", map.get("L_GUARANTOR_ID"));
                    objIntfStockInfoWind.setString("vcGuarantorNameFull", map.get("VC_GUARANTOR_NAME_FULL"));
                    objIntfStockInfoWind.setString("vcGuarantorSummary", map.get("VC_GUARANTOR_SUMMARY"));
                    objIntfStockInfoWind.setLong("lIssuePostDate", Long.parseLong(map.get("L_ISSUE_POST_DATE")));
                    objIntfStockInfoWind.setLong("lIssueBeginDate", Long.parseLong(map.get("L_ISSUE_BEGIN_DATE")));
                    objIntfStockInfoWind.setLong("lPayDate", Long.parseLong(map.get("L_PAY_DATE")));
                    objIntfStockInfoWind.setLong("lPublishDate", Long.parseLong(map.get("L_PUBLISH_DATE")));
                    objIntfStockInfoWind.setLong("lBegincalDate", Long.parseLong(map.get("L_BEGINCAL_DATE")));
                    objIntfStockInfoWind.setLong("lEndincalDate", Long.parseLong(map.get("L_ENDINCAL_DATE")));
                    objIntfStockInfoWind.setString("cInterestType", map.get("C_INTEREST_TYPE"));
                    objIntfStockInfoWind.setString("cPayInterestType", map.get("C_PAY_INTEREST_TYPE"));
                    objIntfStockInfoWind.setDouble("enPayInteval", Double.parseDouble(map.get("EN_PAY_INTEVAL")));
                    objIntfStockInfoWind.setDouble("enFaceRate", Double.parseDouble(map.get("EN_FACE_RATE")));
                    objIntfStockInfoWind.setString("cBidType", map.get("C_BID_TYPE"));
                    objIntfStockInfoWind.setString("cPayType", map.get("C_PAY_TYPE"));
                    objIntfStockInfoWind.setString("vcSpecialText", map.get("VC_SPECIAL_TEXT"));
                    objIntfStockInfoWind.setString("vcMainUnderwriter", map.get("VC_MAIN_UNDERWRITER"));
                    objIntfStockInfoWind.setString("vcMainUnderwriterId", map.get("VC_MAIN_UNDERWRITER_ID"));
                    objIntfStockInfoWind.setString("vcDeputyUnderwriter", map.get("VC_DEPUTY_UNDERWRITER"));
                    objIntfStockInfoWind.setString("vcDeputyUnderwriterId", map.get("VC_DEPUTY_UNDERWRITER_ID"));
                    objIntfStockInfoWind.setString("cUnderwriteType", map.get("C_UNDERWRITE_TYPE"));
                    objIntfStockInfoWind.setString("vcGroupUnderwriter", map.get("VC_GROUP_UNDERWRITER"));
                    objIntfStockInfoWind.setLong("lNextExerciseDate", Long.parseLong(map.get("L_NEXT_EXERCISE_DATE")));
                    objIntfStockInfoWind.setString("cIsSmallRaised", map.get("C_IS_SMALL_RAISED"));
                    objIntfStockInfoWind.setString("cIsHaveSaleback", map.get("C_IS_HAVE_SALEBACK"));
                    objIntfStockInfoWind.setString("vcPaymentPlace", map.get("VC_PAYMENT_PLACE"));
                    objIntfStockInfoWind.setString("vcAssureType", map.get("VC_ASSURE_TYPE"));
                    objIntfStockInfoWind.setString("vcSpecialTextDesc", map.get("VC_SPECIAL_TEXT_DESC"));
                    objIntfStockInfoWind.setString("vcIssueType", map.get("VC_ISSUE_TYPE"));
                    objIntfStockInfoWind.setString("vcSpecialLimite", map.get("VC_SPECIAL_LIMITE"));
                    objIntfStockInfoWind.setString("vcTenderInterval", map.get("VC_TENDER_INTERVAL"));
                    
                    objIntfStockInfoWind.setString("vcIssueAppraiseCsrc", map.get("VC_ISSUE_APPRAISE_CSRC"));
                    objIntfStockInfoWind.setString("vcCityLevel", map.get("VC_CITY_LEVEL"));
                    objIntfStockInfoWind.setString("lNInterestRateJumpPoints", map.get("L_N_INTEREST_RATE_JUMP_POINTS"));
                    objIntfStockInfoWind.setString("enIssuerNetValue", map.get("EN_ISSUER_NET_VALUE"));
                    objIntfStockInfoWind.setString("vcMortStockCode", map.get("VC_MORT_STOCK_CODE"));
                    objIntfStockInfoWind.setString("vcMortStockName", map.get("VC_MORT_STOCK_NAME"));
                    objIntfStockInfoWind.setString("vcMortStockAmount", map.get("VC_MORT_STOCK_AMOUNT"));
                   
          
                    objIntfStockInfoWinds.add(objIntfStockInfoWind);
                    // DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfStockInfoWind);
                    objIntfStockInfoWind = null;
                }
                DataObject objIntfStockInfoWindss[] = new DataObject[objIntfStockInfoWinds.size()];
                objIntfStockInfoWinds.toArray(objIntfStockInfoWindss);
                DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, objIntfStockInfoWindss);
                SynCommonUtil.insertMsg("0", "获取Wind数据完成", objIntfStockInfoWindss.length, "获取Wind数据", "将Wind新债数据插入到数据接口表");
                objIntfStockInfoWindss = null;
            }else{
            	SynCommonUtil.insertMsg("0", "没有获取到Wind数据", 0, "获取Wind数据", "将Wind新债数据插入到数据接口表");
            }
            flag = true;
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            SynCommonUtil.insertMsg("1", e.getMessage(), 0, "获取Wind数据", "将Wind新债数据插入到数据接口表");
            LogUtil.logError("[getDtataFromWind]"+"函数执行失败,将Wind表中的数据插入到接口表出错!", e, new Object[]{});
        }
        if (!flag) return flag;
        LogUtil.logInfo("[getDtataFromWind]"+"结束将Wind表中的数据插入到接口表...", null, new Object[]{});
        System.out.println("[getDtataFromWind]"+"结束将Wind表中的数据插入到接口表...");
        SynCommonUtil.insertMsg("2", "结束获取Wind数据", 0, "获取Wind数据", "结束Wind新债数据插入到数据接口表");
        return flag;
    }
    
    @Bizlet("")
	public static boolean callSynProcedureByWind() {
    	SynCommonUtil.insertMsg("2", "开始Wind数据转换", 0, "转换Wind数据格式", "开始Wind数据转换");
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[callSynProcedureByWind]"+"开始执行存储过程sp_sync_data_wind_bak..");
        LogUtil.logInfo("[callSynProcedureByWind]"+"开始执行存储过程sp_sync_data_wind_bak..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call sp_sync_data_wind_bak()}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.executeUpdate();
                int l_success = -1;
                isSuccess = true;
                l_success = cStmt_qjy.getInt(1);
                if (l_success != 0){
                    isSuccess = false;
                    execute = false;
                    LogUtil.logError("[callSynProcedureByWind]"+"函数执行失败,将接口表数据同步到正式表出错!", null, new Object[]{});
                }
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[callSynProcedureByWind]"+"函数执行失败,将接口表数据同步到正式表出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        SynCommonUtil.insertMsg("2", "结束Wind数据转换", 0, "转换Wind数据格式", "结束Wind数据转换");
        LogUtil.logInfo("[callSynProcedureByWind]"+"结束执行存储过程sp_sync_data_wind_bak..", null, new Object[]{});
        System.out.println("[callSynProcedureByWind]"+"结束执行存储过程sp_sync_data_wind_bak..");
        return isSuccess;
    }
    
}
