/**
 * 
 */
package com.cjhxfund.jy.ProductProcess;

import java.sql.CallableStatement;
import java.sql.Connection;




import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.system.annotation.Bizlet;

/**
 * @author 王锡锋
 * @date 2018-03-14 17:29:25
 *
 */
@Bizlet("")
public class ZhxxcxUtilNew {
	
	
	/**
	 * 执行O32计算T+0、T+1头寸指标值等存储过程
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认5分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认17:00
	 * @return
	 * @author wangxifeng
	 */
	@Bizlet("执行O32计算T+0、T+1头寸指标值等存储过程")
	public static boolean callO32Procedure(){
		System.out.println(DateUtil.currentDateTimeString()+"  [call o32_cj.to32_position()]调用O32存储过程开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		CallableStatement cStmt = null;
		try {
			String procedure = "{call o32_cj.to32_position()}";
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getProdO32CacheDataSourceName());//重新获取连接
			try {
				//执行的O32存储过程
				cStmt = conn.prepareCall(procedure);
				cStmt.execute();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, cStmt, null);
			}
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, cStmt, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  [call o32_cj.to32_position()]调用O32存储过程结束!!!");
		return isSuccess;
	}
	
	/**
	 * 执行O32计算T+0、T+1头寸指标值等存储过程-新（连接本地O32备库4.56）
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认3分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认17:00
	 * @return
	 * @author wangxifeng
	 */
	@Bizlet("执行O32计算T+0、T+1头寸指标值等存储过程-新")
	public static boolean callO32ProcedureNew(){
		System.out.println(DateUtil.currentDateTimeString()+"  [call o32_cj.to32_position()][4.56]调用O32存储过程开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		CallableStatement cStmt = null;
		try {
			String procedure = "{call o32_cj.to32_position()}";
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getBakO32CacheDataSourceName());//重新获取连接
			try {
				//执行的O32存储过程
				cStmt = conn.prepareCall(procedure);
				cStmt.execute();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, cStmt, null);
			}
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, cStmt, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  [call o32_cj.to32_position()][4.56]调用O32存储过程结束!!!");
		return isSuccess;
	}
	
}
