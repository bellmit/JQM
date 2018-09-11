package org.gocom.components.coframe.auth.ldap;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.cjhxfund.sys.SysParamUtil;
import org.gocom.components.coframe.tools.JDBCUtil;
import org.gocom.components.coframe.tools.StrUtil;

import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.ConfigurationUtil;
import com.eos.system.annotation.Bizlet;
import com.novell.ldap.LDAPConnection;
import com.novell.ldap.LDAPEntry;
import com.novell.ldap.LDAPException;
import com.novell.ldap.LDAPSearchResults;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * 同步AD域用户信息
 * @author huangmizhi
 */
@Bizlet("同步AD域用户信息")
public  class LDAPSync {
	
	private static Logger log = Logger.getLogger(LDAPSync.class);
	private static LDAPConnection lc;
	private static LDAPSearchResults rs = null;
	
	/** 创金合信_离职员工[CJHX_LZYG] */
	public static final String CJHX_LZYG = "CJHX_LZYG";
	
	/** 创金合信_待处理员工[CJHX_DCLYG] */
	public static final String CJHX_DCLYG = "CJHX_DCLYG";
	
	public LDAPSync(){
	}
	
	/**
	 *读取AD域中所有的用户，与机器猫系统中的记录对比
	 *1、将机器猫系统中缺少的用户添加上
	 *2、更新用户状态
	 *3、需要处理人员变动其它部门情况，做update
	*/
	@Bizlet("同步用户信息接口")
	public static void syncUserInfo() throws Throwable{
		long start = System.currentTimeMillis();
		Map<String, String> infoMap = new HashMap<String, String>();
		try {
			connectADServer(getADIP(), getADPORT());
			rs = searchAllUser();
			while (rs.hasMore()) {
				LDAPEntry entry = rs.next();
				if(entry.getAttribute("department") == null){
					System.out.println("this person is not dept:"+entry.getAttribute("sAMAccountname").getStringValue());
					log.info("this person is not deptment:"+entry.getAttribute("sAMAccountname").getStringValue());
				}
				infoMap.put("accountNo", entry.getAttribute("sAMAccountname")==null?"":entry.getAttribute("sAMAccountname").getStringValue());
				infoMap.put("accountName", entry.getAttribute("displayName")==null?"":entry.getAttribute("displayName").getStringValue());
				infoMap.put("dept", entry.getAttribute("department")==null?"":entry.getAttribute("department").getStringValue());
				infoMap.put("omail", entry.getAttribute("mail")==null?"":entry.getAttribute("mail").getStringValue());
				infoMap.put("otel", entry.getAttribute("telephoneNumber")==null?"":entry.getAttribute("telephoneNumber").getStringValue());
				infoMap.put("mobile", entry.getAttribute("mobile")==null?"":entry.getAttribute("mobile").getStringValue());
				
				if(entry.getAttribute("sAMAccountname") != null){
					//查询AD域中对应sAMAccountname的用户在机器猫系统中是否存在
					if(callGetUser(entry.getAttribute("sAMAccountname").getStringValue())){
						log.info(entry.getAttribute("sAMAccountname").getStringValue() + "存在");
						//查询是否为离职员工，是离职员工则修改该用户状态为注销
						if(entry.getAttribute("distinguishedName")!=null && StrUtil.changeNull(entry.getAttribute("distinguishedName").getStringValue()).indexOf("OU=离职员工")!=-1){
							infoMap.put("status", "9");//用户状态：0-挂起；1-正常；2-锁定；9-注销；
							infoMap.put("authmode", "local");//更改为本地密码认证，密码认证方式：本地密码认证、LDAP认证、等
							infoMap.put("leaveDept", "离职员工");
							callUpdateUser(infoMap);
						}
					}else{
						log.info(entry.getAttribute("sAMAccountname").getStringValue() + ": 此userId在数据库中不存在，将添加到机器猫系统");
						//判断该员工在AD域是否是离职状态,如果是离职状态并且本地数据库没有当前用户不添加
						if(entry.getAttribute("distinguishedName")!=null && StrUtil.changeNull(entry.getAttribute("distinguishedName").getStringValue()).indexOf("OU=离职员工")==-1){
							callAddUser(infoMap);
						}
					}
				}
			}
		} catch (LDAPException e) {
			e.printStackTrace();
		} finally {
			rs = null;
			try{
				lc.disconnect();
			} catch (Exception e){
				e.printStackTrace();
			}
		}
		long end = System.currentTimeMillis();
		System.out.println("AD域用户同步结束，耗时："+(end-start)+" 毫秒！");
	}
	
	/**
	 * 对外单独调用使用
	 * 读取离职员工部门中的用户，与机器猫中的用户
	 * 比对，机器猫中存在，则将用户移动到离职部门中
	 * @throws Throwable 
	 */
	@Bizlet("移动注销用户到离职部门")
	public void moveLeaveUser() throws Throwable {
		Map<String, String> infoMap = new HashMap<String, String>();
		try {
			// 创建ldap连接
			connectADServer(getADIP(), getADPORT());
			// 查询出所有结果
			if (rs == null) {
				rs = searchAllLeaveUser();
			}
			while (rs.hasMore()) {
				LDAPEntry entry = rs.next();
				if (entry.getAttribute(ConfigurationUtil.getUserConfigSingleValue("ad_module", "ssoserver", "userDistinguish")) == null) {
					continue;
				}
				System.out.println("离职员工：" + entry.getAttribute("sAMAccountname").getStringValue() + 
							"\t" + callGetUser(entry.getAttribute("sAMAccountname").getStringValue()));
				//判断员工是否在系统中
				if(callGetUser(entry.getAttribute("sAMAccountname").getStringValue())){
					//用户在系统中，将用户状态修改为注销
					if(entry.getAttribute("distinguishedName").getStringValue().indexOf("OU=离职员工") != -1){
						infoMap.put("userId", entry.getAttribute("sAMAccountname").getStringValue());	
						infoMap.put("status", "9");//挂起0，正常1，锁定2，注销9
						infoMap.put("LeaveDept", "离职员工");
						callUpdateUser(infoMap);
						//callUpdateLeaveUser(infoMap);															//注销后将用户移动到离职员工
					}
				}				
			}
		} catch (LDAPException e) {
			e.printStackTrace();
		} finally {
			try{
				lc.disconnect();
			} catch (Exception e){
				e.printStackTrace();
			}
		}
	}	
	
	/**
	 * 查询用户名称
	 * @param userId
	 * @return
	 */
	public static String getUserName(String userId) {
		// 创建ldap连接
		connectADServer(getADIP(), getADPORT());
		String username = null;
		//查询所有用户, 从中过滤出指定用户
		try {
			if (rs == null) {
				rs = searchAllUser();
			}
			if (rs != null) {
				while (rs.hasMore()) {
					LDAPEntry entry = rs.next();
					if (entry.getAttribute("sAMAccountname") == null || !entry.getAttribute("sAMAccountname").getStringValue().equals(userId)) {
						continue;
					}
				}
			}
		} catch (LDAPException e) {
			e.printStackTrace();
		} finally {
			// 关闭ldap连接
			try{
				lc.disconnect();
			} catch (Exception e){
				e.printStackTrace();
			}
		}
		return username;
	}

	/**
	 * 调用逻辑流queryUserInfo(String)
	 * @param userId
	 * @return
	 * @throws Throwable
	 */  
	public static boolean callGetUser(String userId) throws Throwable{
		DataObject obj = DataObjectUtil.createDataObject("org.gocom.components.coframe.rights.dataset.CapUser");
		obj.setString("userId", userId);
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, obj, obj);
		if(obj.getString("operatorId") != null){
			return true;
		}
		log.info(userId + ": 该用户【"+userId+"】在数据库中不存在");
		return false;
	}
	
	/**
	 * 调用逻辑流addUser(String, String)
	 * @param userId
	 * @param userName
	 * @throws Throwable
	 */
	public static void callAddUser(Map<String, String> infoMap) throws Throwable{
		Date date = new Date();
		
		//创建修改值对象
		DataObject capuser = DataObjectUtil.createDataObject("org.gocom.components.coframe.rights.dataset.CapUser");
		capuser.setString("userId", infoMap.get("accountNo"));//用户ID
		capuser.setString("password", "k2xvHUmCHWw=");//密码，默认设置为六个零，即000000
		capuser.setString("tenantId", "default");//所属应用
		capuser.setString("userName", infoMap.get("accountName"));//用户姓名
		capuser.setString("authmode", "ldap");//密码认证方式：本地密码认证、LDAP认证、等
		capuser.setString("status", "2");//用户状态：0-挂起；1-正常；2-锁定；9-注销；
		capuser.setString("menutype", "default");//菜单风格
		capuser.setString("createuser", "sysadmin");//创建人
		capuser.setDate("createtime", date);//创建时间
		capuser.setString("email", infoMap.get("omail"));//邮箱
		capuser.setDate("startdate", date);//有效时间
		capuser.setDate("unlocktime", date);//有效时间
		capuser.setDate("lastlogin", date);//有效时间
		//生成主键
		DatabaseExt.getPrimaryKey(capuser);
		DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, capuser);//保存用户信息
		
		//创建员工对象
		DataObject orgEmployee = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		//创建机构对象，并查询待处理员工机构信息
		DataObject orgOrganization = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgOrganization");
		orgOrganization.setString("orgcode", LDAPSync.CJHX_DCLYG);
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, orgOrganization, orgOrganization);
		
		//给员工对象赋值
		orgEmployee.setString("userid", infoMap.get("accountNo"));
		orgEmployee.setString("operatorid", capuser.getString("operatorId"));
		orgEmployee.setString("empcode", infoMap.get("accountNo"));
		orgEmployee.setString("empname", infoMap.get("accountName"));
		orgEmployee.setString("mobileno", infoMap.get("otel"));
		orgEmployee.setDate("createtime", date);
		orgEmployee.setDate("lastmodytime", date);
		orgEmployee.setString("orgid", orgOrganization.getString("orgid"));
		orgEmployee.setString("tenantid", "default");
		orgEmployee.setString("empstatus", "on");
		//生成主键
		DatabaseExt.getPrimaryKey(orgEmployee);
		DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, orgEmployee);//保存员工信息
		
		//创建机构员工关系表
		DataObject orgEmp = DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.OrgEmporg");
		orgEmp.setInt("empid", orgEmployee.getInt("empid"));
		orgEmp.setInt("orgid", orgOrganization.getInt("orgid"));
		orgEmp.setString("ismain", "y");
		orgEmp.setString("tenantId", JDBCUtil.DATA_SOURCE_DEFAULT);
		DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, orgEmp);//保存机构员工关系
	}
	
	/**
	 * 调用逻辑流queryOrg(deptName)
	 * @param deptName
	 * @throws Throwable
	 * return 如有数据返回DataObject，否则返回null
	 */
	@Bizlet("查询组织部门")
	public DataObject queryOrg(String deptName) throws Throwable{		
		Map<String, String> parameterMap=new HashMap<String, String>();
		parameterMap.put("deptName", deptName);		
		Object[] objs = null;
		try{
			if("".equals(deptName) || deptName==null){
				throw new NullPointerException("deptName is null!");				
			}			
			objs = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.util.processes.queryDeptInfo", parameterMap);
		}catch (Exception e) {
			System.out.println("查询机器猫用户数据出错!请检查SQL是否正确或者数据库连接！");
			e.printStackTrace();
		}
		DataObject obj = (DataObject) objs[0];
		return obj;
	}
	
	/**
	 * 调用逻辑流updateUser(String, String)
	 * 1、更新离职员工状态为注销状态：9
	 * 2、更新离职员工所在部门为：待处理员工部门
	 * @param infoMap
	 * @throws Throwable
	 * @author huangmizhi
	 */
	public static void callUpdateUser(Map<String, String> infoMap) throws Throwable{
		//创建修改值对象
		DataObject updateCapuser = DataObjectUtil.createDataObject("org.gocom.components.coframe.rights.dataset.CapUser");
		//创建修改条件对象
		DataObject templateCapuser = DataObjectUtil.createDataObject("org.gocom.components.coframe.rights.dataset.CapUser");
		
		updateCapuser.setString("status", infoMap.get("status"));//设置用户状态
		updateCapuser.setString("authmode", infoMap.get("authmode"));//密码认证方式：本地密码认证、LDAP认证、等
		templateCapuser.setString("userId", infoMap.get("accountNo"));//设置修改条件
		
		DatabaseUtil.updateEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, updateCapuser, templateCapuser);//修改数据
		
		//创建用户机构关系表对象、员工表对象、机构表对象
		DataObject orgEmp = DataObjectUtil.createDataObject("org.gocom.components.coframe.auth.sysentity.OrgEmporg");
		DataObject employee = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		DataObject orgEmployee = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgEmployee");
		DataObject orgOrganization = DataObjectUtil.createDataObject("org.gocom.components.coframe.org.dataset.OrgOrganization");
		
		//给机构对象赋值查询条件
		orgOrganization.set("orgcode", LDAPSync.CJHX_LZYG);
		//查询机构信息
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, orgOrganization, orgOrganization);
		
		//给员工对象赋值,并修改员工所属机构
		employee.set("orgid", orgOrganization.getString("orgid"));
		employee.set("empstatus", "leave");
		orgEmployee.setString("userid", infoMap.get("accountNo"));
		DatabaseUtil.updateEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, employee, orgEmployee);
		
		//根据userID查询员工信息
		DatabaseUtil.expandEntityByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, orgEmployee, orgEmployee);
		
		//给机构员工对象赋值
		orgEmp.setInt("empid", orgEmployee.getInt("empid"));
		//清空原来员工机构关系
		DatabaseUtil.deleteByTemplate(JDBCUtil.DATA_SOURCE_DEFAULT, orgEmp);
		
		orgEmp.setInt("empid", orgEmployee.getInt("empid"));
		orgEmp.setInt("orgid", orgOrganization.getInt("orgid"));
		orgEmp.setString("ismain", "y");
		orgEmp.setString("tenantId", "default");
		
		//生成主键并保存到数据库中
		DatabaseUtil.insertEntity(JDBCUtil.DATA_SOURCE_DEFAULT, orgEmp);
	}
	
	/**
	 * 调用逻辑流updateLeaveUser(String)
	 * @param userId
	 * @throws Throwable
	 */
	public void callUpdateLeaveUser(Map<String, String> infoMap) throws Throwable{
		//逻辑构件名称
		String componentName = "com.primeton.portal.user.userManager";
		//逻辑流名称
		String operationName = "updateLeaveUser";
		ILogicComponent comp = LogicComponentFactory.create(componentName);
		Object[] params = new Object[]{infoMap};
		comp.invoke(operationName, params);
	}
	
	//读取业务字典中的AD域服务器IP（数据库）
	@Bizlet
	public static String getADIP(){
		//return BusinessDictUtil.getDictName("PORTAL_AD_IP", "PORTAL_AD_IP"); 		
		//return  ConfigurationUtil.getUserConfigSingleValue("ad_module", "ldapserver", "ip");
		return SysParamUtil.getSysParam("ldap", "host");
	}
	
	//读取业务字典中的AD域服务器PORT（数据库）
	@Bizlet
	public static int getADPORT(){
		//return Integer.parseInt(BusinessDictUtil.getDictName("PORTAL_AD_PORT", "PORTAL_AD_PORT")); 				//arg0为字典名，arg2为字典项
		//return  Integer.parseInt(ConfigurationUtil.getUserConfigSingleValue("ad_module", "ldapserver", "port"));
		return Integer.parseInt(SysParamUtil.getSysParam("ldap", "post"));
	}
	
	//连接AD域服务器
	@SuppressWarnings("deprecation")
	@Bizlet
	public static void connectADServer(String IP, int port){
		lc = new LDAPConnection();
		try{
			lc.connect(IP, port);
			//AD域服务器登录账号与密码
			String adminName = SysParamUtil.getSysParam("ldap", "adminName");   
			String adminPassword = SysParamUtil.getSysParam("ldap", "adminPassword");
			//登录AD域服务器
			lc.bind(LDAPConnection.LDAP_V3, adminName, adminPassword);
//			lc.bind(LDAPConnection.LDAP_V3, ConfigurationUtil.getUserConfigSingleValue("ad_module", "ldapserver", "cjhxHost"), 
//					ConfigurationUtil.getUserConfigSingleValue("ad_module", "ldapserver", "cj@2015"));
		} catch(LDAPException e) {
			System.err.print("连接异常！");
			e.printStackTrace();
		}
	}
	
	//用户登录验证
	@SuppressWarnings("deprecation")
	@Bizlet("用户登录验证")
	public boolean checkUser(String userid, String pwd){
		String IP = getADIP();
		int port = getADPORT();
		
		try {
			// 创建ldap连接
			connectADServer(IP, port);
			// 查询出所有结果
			if (rs == null) {
				rs = searchAllUser();
			}
			if (rs == null) {
				System.out.println("查询失败");
				return false;
			}
			while (rs.hasMore()) {
				LDAPEntry entry = rs.next();
				if (entry.getAttribute("displayName") == null) {
					continue;
				}
				
				//查询AD域中userid对应的用户是否存在
				if(entry.getAttribute("sAMAccountname").getStringValue().equals(userid)){
					//用户名存在，验证密码是否正确
					LDAPConnection checklc= new LDAPConnection();
					try{
						checklc.connect(IP, port);
						//登录AD域服务器
						checklc.bind(LDAPConnection.LDAP_V3, entry.getAttribute("distinguishedName").getStringValue(), pwd);
						System.out.println("用户验证成功！");
						return true;
					} catch(LDAPException e) {
						e.printStackTrace();
					} finally {
						checklc.clone();
					}
				}
			}
		} catch (LDAPException e) {
			System.out.println("用户验证失败!");
			e.printStackTrace();
		} finally {
			try{
				lc.disconnect();
			} catch (Exception e){
				e.printStackTrace();
			}
		}
		return false;
	}
	
	//搜索所有用户
	@Bizlet
	public static LDAPSearchResults searchAllUser(){
		//搜索相应目录
		try {
			//获取ad域的目录树结构
			String userDN = SysParamUtil.getSysParam(SysParamUtil.ldap , "userDN");
			//获取值
			rs = lc.search(userDN, LDAPConnection.SCOPE_SUB, "objectClass=organizationalPerson", null, false);
		//	rs = lc.search(ConfigurationUtil.getUserConfigSingleValue("ad_module", "ldapserver", "UserName"), LDAPConnection.SCOPE_SUB, "cn=*", null, false);
		//	System.out.println(ConfigurationUtil.getUserConfigSingleValue("ad_module", "ldapserver", "searchBase"));
//			rs= lc.search(
//					"OU=办公管理,DC=CJHX,DC=TEST",
//					LDAPConnection.SCOPE_SUB, 
//					"objectClass=organizationalPerson",
//					null, 
//					false);			
			
		} catch (LDAPException e) {
			System.err.print("连接异常！");
			e.printStackTrace();
		}
		return rs;
	}
	
	//搜索所有离职员工用户
	private LDAPSearchResults searchAllLeaveUser(){
		//搜索相应目录
		try {
			rs = lc.search(ConfigurationUtil.getUserConfigSingleValue("ad_module", "ssoserver", "searchLeaveDic"), LDAPConnection.SCOPE_SUB, "cn=*", null, false);
		} catch (LDAPException e) {
			System.err.print("连接异常！");
			e.printStackTrace();
		}
		return rs;
	}
	
	
	public static void main(String[] args) {
		LDAPSync ldap = new LDAPSync();
		try {
			ldap.syncUserInfo();
		} catch (Throwable e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
}
