package org.cjhxfund.sys;

import java.sql.Connection;
import java.sql.Statement;

import com.eos.common.connection.ConnectionHelper;
import com.eos.foundation.eoscommon.LogUtil;

/**
 * 
 * @author liupinghui
 * 
 */
public class DBUtils {

	// 获取数据源的构件包
	private static String dsPackage = "org.gocom.components.coframe.auth";

	// 缺省数据源名称
	private static String dsName = "default";

	private DBUtils() {

	}

	/**
	 * 获取数据库连接
	 * 
	 * @return 数据库连接
	 */
	public static Connection getConn() {
		Connection conn = null;
		conn = DBUtils.getConnection();

		return conn;
	}

	/**
	 * 获得org.gocom.abframe.auth构件包的数据源default数据源
	 * 
	 * @return
	 */
	public static Connection getConnection() {
		return getConnection(null);
	}

	/**
	 * 从org.gocom.abframe.auth构件包中根据数据源的别名获得数据库连接。
	 * 
	 * @param dsName
	 *            数据源名称。
	 * @return 获得数据库连接。
	 */
	public static Connection getConnection(String name) {
		if (name == null || name.trim().equals(""))
			name = dsName;

		return getConnection(dsPackage, name);
	}

	/**
	 * 从当前的contribution中根据数据源的别名获得数据库连接。
	 * 
	 * @param dsName
	 *            数据源名称。
	 * @return 获得数据库连接。
	 */
	public static Connection getConnection(String packname, String name) {
		Connection conn = null;
		if (name == null || name.trim().equals("")) {
			name = dsName;
		}
		if (packname == null || packname.trim().equals("")) {
			packname = dsPackage;
		}
		LogUtil.logDebug("获得构件包{0}中的别名为{1}的数据源", null, new Object[] { packname,
				name });
		try {
			conn = ConnectionHelper.getContributionConnection(packname, name);
		} catch (Exception e) {
			LogUtil.logError("获取数据源出错", e, (Object) null);
		}
		return conn;
	}
	
	public static void free(Connection conn){
		if(conn!=null){
			try{
				conn.close();
				conn=null;
			}catch(Exception e){
				
			}
		}
	}
	
	public static void free(Statement statement){
		if(statement!=null){
			try{
				statement.close();
				statement=null;
			}catch(Exception e){
				
			}
		}
	}
}
