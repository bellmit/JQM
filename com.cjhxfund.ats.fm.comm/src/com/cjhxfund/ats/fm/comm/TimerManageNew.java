/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author 王锡锋
 * @date 2018-03-15 09:25:00
 *
 */
@Bizlet("")
public class TimerManageNew {

	
	//扫描一级债指令表，满足待中标复核、新债缴款日为当天的记录，插入或跟新新债记录到新债待推送表中
		@Bizlet("新债推送定时器")
		public static boolean insertNewDebtTemp(){
			System.out.println(DateUtil.currentDateTimeString()+" insertNewDebtTemp start...");
	        List<Map<String, String>> result =null;
	        List<String> insert_sqls = new ArrayList<String>();
	        String insert_sql = "insert into t_ats_stock_issue_info_temp (L_STOCK_ISSUE_ID , C_SOURCE , C_STATUS) VALUES (%s,'1','1')";
			String query_sql = "select * from t_ats_stock_issue_info_temp where l_stock_issue_id = %s";
			String update_sql = "update t_ats_stock_issue_info_temp a set d_insert_time = sysdate where a.l_stock_issue_id = %s";
				
			//获取符合条件的指令记录
			String sql_query = "select b.l_stock_issue_id from t_ats_apply_inst a ,t_ats_stock_issue_info b " +
					"where a.en_pay_face_value is not null and a.en_ballot_price is not null and a.en_payment_money is not null" +
					" and a.l_valid_status = 0 and a.d_payment_date = to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') and a.l_stock_invest_no = b.l_stock_invest_no and b.c_status = '2'";
			result = JDBCUtil.executeQuery(JDBCUtil.DATA_SOURCE_DEFAULT, sql_query,null);
			//添加入新债推送表
			System.out.println("result size is " + result.size());
			for(int i=0;i<result.size();i++){
				Map<String, String> map = result.get(i);
				String l_stock_issue_id = map.get("L_STOCK_ISSUE_ID");
				List<Map<String, String>> list = JDBCUtil.query(String.format(query_sql, l_stock_issue_id));
				if(list.size()==0){
					insert_sqls.add(String.format(insert_sql, l_stock_issue_id));
				}else{
					JDBCUtil.update(String.format(update_sql, l_stock_issue_id));
				}
			}
			JDBCUtil.insertBatch(JDBCUtil.DATA_SOURCE_DEFAULT,insert_sqls);
			System.out.println(DateUtil.currentDateTimeString()+" insertNewDebtTemp end...");
			return true;
		}
}
