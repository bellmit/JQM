package com.cjhxfund.ats.fm.comm;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.QrtzUtil;


public class TimerManage {

	//扫描一级债指令表，满足待中标复核、新债缴款日为当天的记录，插入或跟新新债记录到新债待推送表中
	public static boolean insertNewDebtTemp(){
		System.out.println(DateUtil.currentDateTimeString()+" insertNewDebtTemp start...");
        List<Map<String, String>> result =null;
        List<String> insert_sqls = new ArrayList<String>();
        String insert_sql = "insert into t_ats_stock_issue_info_temp (L_STOCK_ISSUE_ID , C_SOURCE , C_STATUS) VALUES (%s,'1','1')";
		String query_sql = "select * from t_ats_stock_issue_info_temp where l_stock_issue_id = %s";
		String update_sql = "update t_ats_stock_issue_info_temp a set d_insert_time = sysdate where a.l_stock_issue_id = %s";
		while(true){
			
			int now = DateUtil.currentTimeInt();
			//判断当前是否在可执行时间内。
			if(now<112000||now>112500&&now<165000||now>165500){
				try {
					//刷新执行信息
					Long afterTime=(new Date()).getTime();
					String className=Thread.currentThread().getStackTrace()[1].getClassName();
					String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
					QrtzUtil.logTriggerInfo(className+"."+methodName, afterTime, afterTime);
					
					//暂停设定的轮询间隔时间
					System.out.println(DateUtil.currentDateTimeString()+" insertNewDebtTemp is sleeping...");
					Thread.sleep(1 * 60 *1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				continue;
			}
			
			if(now>=170000){
				//刷新执行信息
				Long afterTime=(new Date()).getTime();
				String className=Thread.currentThread().getStackTrace()[1].getClassName();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, afterTime, afterTime);
				
				System.out.println(DateUtil.currentDateTimeString()+" startIPOtask end...");
				break;
			}
			
			Long beforeTime=(new Date()).getTime();
			
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
			
			//刷新执行信息
			Long afterTime=(new Date()).getTime();
			String className=Thread.currentThread().getStackTrace()[1].getClassName();
			String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
			QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
			
			try {
				//暂停设定的轮询间隔时间
				System.out.println(DateUtil.currentDateTimeString()+" insertNewDebtTemp is sleeping...");
				Thread.sleep(1 * 60 *1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println(DateUtil.currentDateTimeString()+" insertNewDebtTemp end...");
		return true;
	}
	public static void main(String[] args){
		insertNewDebtTemp();
	}
}
