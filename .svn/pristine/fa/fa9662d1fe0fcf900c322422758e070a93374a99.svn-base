package com.cjhxfund.ats.fm.fix;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.CacheUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 章璐
 * @date 2017-02-25 15:00:10
 * fix下单到O32查询该券是否存在
 */
public class QueryO32Stock {
	
	/**
	 * fix下单到O32查询该券是否存在
	 * @param obj 待发送的指令基础数据
	 * @return	count
	 * @author zhanglu
	 */
	@Bizlet("")
	public static boolean QueryIsHave(DataObject obj){
		boolean ishave = false;
		StringBuffer sql = new StringBuffer();
		List<Map<String, String>> list_count = new ArrayList<Map<String, String>>();
		Connection conn_O32 = null;
		try {
			conn_O32 = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			String vcStockCode = obj.getString("vcStockCode");
			String cMarketNo = obj.getString("cMarketNo");
			sql.setLength(0);
	    	sql.append(" select count(*) as count from trade.tstockinfo a where a.c_market_no = '"+cMarketNo+"' and a.vc_report_code = '"+vcStockCode+"'");
	    	list_count = JDBCUtil.queryWithConn(conn_O32, sql.toString(), null);
	    	if(list_count.get(0).get("COUNT")!=null || list_count.get(0).get("COUNT")!=""){
	    		String sCnt = list_count.get(0).get("COUNT");
	    		if(!("0".equals(sCnt)))
	    		ishave = true;
	    	}
	    	return ishave;
		} catch (Exception e) {
            e.printStackTrace();
        }finally {
        	sql = null;
            JDBCUtil.releaseResource(conn_O32, null, null);
        }
		return ishave;
	}
}
