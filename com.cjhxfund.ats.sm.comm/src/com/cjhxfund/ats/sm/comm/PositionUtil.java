/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 刘玉龙
 * @date 2016-10-28 09:58:50
 *
 */
@Bizlet("")
public class PositionUtil {
	/**
	 * 获取所有指定组合不重复的所有债券
	 * @param combiNos 组合代码串
	 * @return String 证券代码与交易市场组合串的合集
	 * @author liuyulong
	 */
	@Bizlet("")
	public static String queryQuoteAuthorityPositionReport(String combiNos){
		String resultReport = "";
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			//拼接SQL语句
			sb.append("select distinct b.vc_report_code, ")//证券代码
			  .append("       b.c_market_no ")//交易市场
			  .append("from o32_cj.ats_vunitstock a, trade.tstockinfo b, trade.tcombi c ")
			  .append("where a.vc_inter_code = b.vc_inter_code ")
			  .append("and a.l_basecombi_id = c.l_combi_id ");
			if(StringUtils.isNotBlank(combiNos)){
				sb.append("and c.vc_combi_no in (").append(combiNos).append(")");
			}
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					if(i==list.size()-1){
						resultReport += "('"+map.get("VC_REPORT_CODE")+"'," + "'"+ map.get("C_MARKET_NO") +"')";
					}else{
						resultReport += "('"+map.get("VC_REPORT_CODE")+"'," + "'"+ map.get("C_MARKET_NO") +"'),";
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return resultReport;

	}

	/**
	 * 获取指定组合持仓信息
	 * @param combiNo 组合代码
	 * @return List 持仓信息列表
	 * @author liuyulong
	 */
	@Bizlet("")
	public static List<DataObject> queryQuoteAuthorityPosition(String combiNo){
		List<DataObject> resultObject = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			//拼接SQL语句
			sb.append("select b.vc_report_code, ")//证券代码
			  .append("       b.c_market_no ")//交易市场
			  .append("from o32_cj.ats_vunitstock a, trade.tstockinfo b, trade.tcombi c ")
			  .append("where a.vc_inter_code = b.vc_inter_code ")
			  .append("and a.l_basecombi_id = c.l_combi_id");
			if(StringUtils.isNotBlank(combiNo)){
				sb.append("and c.vc_combi_no = ").append(combiNo);
			}
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.commEntity.consumEntity");
					obj.setString("vcReportCode", map.get("VC_REPORT_CODE"));
					obj.setString("cMarketNo", map.get("C_MARKET_NO"));
					resultObject.add(obj);
					obj = null;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return resultObject;
	}
	
	/**
	 * 获取指定组合持仓信息
	 * @param combiNo 组合代码
	 * @return List 持仓信息列表
	 * @author liuyulong
	 */
	@Bizlet("")
	public static List<DataObject> queryReportPosition(String combiNo){
		List<DataObject> resultObject = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			//拼接SQL语句
			sb.append("select b.vc_report_code, ")//证券代码
			  .append("       b.c_market_no ")//交易市场
			  .append("from o32_cj.ats_vunitstock a, trade.tstockinfo b, trade.tcombi c ")
			  .append("where a.vc_inter_code = b.vc_inter_code ")
			  .append("and a.l_basecombi_id = c.l_combi_id");
			if(StringUtils.isNotBlank(combiNo)){
				sb.append("and c.vc_combi_no = ").append(combiNo);
			}
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.sm.comm.commEntity.consumEntity");
					obj.setString("vcReportCode", map.get("VC_REPORT_CODE"));
					obj.setString("cMarketNo", map.get("C_MARKET_NO"));
					resultObject.add(obj);
					obj = null;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return resultObject;
	}
	
	/**
	 * 转换持仓占比
	 * @param dealPosition 持仓信息
	 * @author wuyanfei
	 */
	@Bizlet("持仓比转换")
	public  DataObject[] convertRatio(DataObject[] dealPosition){
		int length = dealPosition.length;
		try{
			if(length > 0){
				for(int i =0;i<length;i++){
					Double enBondAsset = (Double)dealPosition[i].get("enBondAsset");//市值
					Double enFundValue = (Double)dealPosition[i].get("enFundValue");//净资产
					if(enFundValue <= 0){
						dealPosition[i].set("positionRatio", "0.0000");
					}else{
						Double position = (enBondAsset/enFundValue)*100;
						String [] positionInfo= position.toString().split("\\.");
						if(positionInfo[1].length() >6){
							positionInfo[1] = positionInfo[1].substring(0,5);
						}
						String value =positionInfo[0]+"."+positionInfo[1];
						String positionRatio = String.format("%.4f", Double.valueOf(value));
						dealPosition[i].set("positionRatio", positionRatio);
					}
					DecimalFormat format = new DecimalFormat("###,##0.00");
					dealPosition[i].set("enFundValue", format.format(enFundValue));
				}
			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return dealPosition;
	}
	
}
