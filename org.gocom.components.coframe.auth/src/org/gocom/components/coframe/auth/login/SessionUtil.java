package org.gocom.components.coframe.auth.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

import javax.servlet.http.HttpSession;

import org.cjhxfund.sys.DBUtils;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.ISessionMap;
import com.eos.data.datacontext.IUserObject;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.common.muo.MUODataContextHelper;
import commonj.sdo.DataObject;

/**
 * 
 * @author liupinghui
 *
 */

@Bizlet("session工具类")
public class SessionUtil {
	
	private final static String USEROBJECT = "userObject"; //userObject对象名称
	
	public final static String DADDEFAULT_LOGOUT_REASON = "normal";//默认退出原因（正常）
	
	private static HttpSession getSession() {
		ISessionMap sessionMap = DataContextManager.current().getSessionCtx();
		if (sessionMap == null)
			sessionMap = MUODataContextHelper.getMapContextFactory()
					.getSessionMap();
		if (sessionMap != null) {
			Object rootObject = sessionMap.getRootObject();
			if (rootObject instanceof HttpSession)
				return (HttpSession) rootObject;
		}
		
	
		return null;
	}
	
	/**
	 * 记录用户日志（同时生成全球唯一编码);
	 *
	 */
	@Bizlet("记录用户登录日志")
	public static void logUserLogin() {
		
		HttpSession session = getSession();
		if (session != null) {
			IUserObject userobject = (IUserObject) session.getAttribute(USEROBJECT);
			if (userobject != null && userobject.getAttributes()!=null && userobject.getAttributes().get("EXTEND_USER_ID")!=null) {
				//String uuid = UUID.randomUUID().toString();// 生成全球唯一编号
				//userobject.getAttributes().put("uuid", uuid); // 设置全球唯一编号
				String userId=(String)userobject.getAttributes().get("EXTEND_USER_ID");
				String userName=(String)userobject.getUserName();
				DataObject sysLoginlog = DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.login.login.T_ATS_LOGIN_LOG");
				sysLoginlog.set("VC_USERCODE", userId);
				sysLoginlog.set("VC_USERNAME", userName);
				sysLoginlog.set("VC_IP", userobject.getUserRemoteIP());
				sysLoginlog.set("D_LOGINTIME", new Timestamp(System.currentTimeMillis()));
				DatabaseExt.getPrimaryKey(sysLoginlog);
				com.eos.foundation.database.DatabaseUtil.insertEntity("default", sysLoginlog);
				userobject.put("onlyid", sysLoginlog.get("L_ID"));
				
		      }
		}
	}
	
	/**
	 * 根据userObject对象记录用户退出日志(默认正常退出)
	 * @param userObject 
	 */
	@Bizlet("记录用户退出日志")
	public static void logUserLogout(IUserObject userObject) {
		logUserLogout(userObject, DADDEFAULT_LOGOUT_REASON);
	}
	
	/**
	 * 根据userObject对象记录用户退出日志
	 * @param userObject 
	 * @param logoutReason 退出原因
	 */
	@Bizlet("记录用户退出日志")
	public static void logUserLogout(IUserObject userObject, String logoutReason) {
		if (userObject != null && userObject.getAttributes()!=null && userObject.getUserId()!=null) {
			String uuid =   (String) userObject.getAttributes().get("onlyid").toString();
			
			String userId=(String)userObject.getAttributes().get("EXTEND_USER_ID");
			if (uuid != "" && userId != null) {
				logUserLogout(uuid, userId);
			}
		}
	}
	
	/**
	 * 记录用户退出日志(默认正常退出)
	 * @param uuid 全球唯一编号
	 * @param userid 用户id
	 */
	@Bizlet("记录用户退出日志")
	public static void logUserLogout(String uuid, String userid) {
		logUserLogout(uuid, userid, DADDEFAULT_LOGOUT_REASON);
	}
	
	/**
	 * 记录用户退出日志
	 * @param uuid 全球唯一编号
	 * @param userid 用户id
	 * @param logoutReason 退出原因
	 */
	@Bizlet("记录用户退出日志")
	public static void logUserLogout(String uuid, String userid,String logoutReason) {
		System.out.println("onlyid=" + uuid + "  userid=" + userid + "  退出记录日志");
		if (uuid != null && userid != null) {
			String sql = "update T_ATS_LOGIN_LOG set D_OUTTIME=? ,VC_OUTREASON=? where L_ID=? and VC_USERCODE=?";
			PreparedStatement ps = null;
			Connection conn = null;
			try {
				conn = DBUtils.getConn();
				ps = conn.prepareStatement(sql);
				ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
				ps.setString(2, logoutReason);
				ps.setString(3, uuid);
				ps.setString(4, userid);
				ps.execute();
			} catch (Exception e) {
				e.printStackTrace();
				com.eos.foundation.eoscommon.LogUtil.logError(e.getMessage(),e);
			} finally {
				DBUtils.free(conn);
				DBUtils.free(ps);
			}
		}
	}
}
