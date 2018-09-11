package org.cjhxfund.sys;

import  java.io.IOException;
import  java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.gocom.components.coframe.init.UserObjectInit;

import com.eos.access.http.OnlineUserManager;
import com.eos.data.datacontext.UserObject;
import com.eos.foundation.database.DatabaseUtil;
import com.primeton.spring.support.DataObjectUtil;
import com.ups.util.RequestUtil;
import com.ups.util.SsoUtil;
import com.ups.util.UserLoginInfo;
import commonj.sdo.DataObject;

public class Ssologin extends HttpServlet {
	private static final long serialVersionUID = -3959095699602157903L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//生成对应的实体
		Map<String,Object> m = RequestUtil.getQueryParams(req);
		UserLoginInfo userInfoParam = (UserLoginInfo) RequestUtil.toJavaBean(new UserLoginInfo(), m);
		UserLoginInfo userInfo = null;
		/*可根据各自实际情况修改*/
		String settingType = SysParamUtil.getSysParam("sysState", "settingType");//获取当前环境：0-开发；1-开发用测试；2-业务测试；3-预生产；4-生产环境；
		String upsIP = "";
		try {
			if("4".equals(settingType)){//生产环境IP
				upsIP = SsoUtil.UPS_PRD_IP;
			} else {//测试环境IP
				upsIP = SsoUtil.UPS_UAT_IP;
			}
			//签名及参数的合法性验证
			userInfo = SsoUtil.validate(userInfoParam.getTicket(), userInfoParam.getFlag(),
									userInfoParam.getCheckString(), userInfoParam.getCode(),
									userInfoParam.getCipher(), userInfoParam.getSign(), upsIP);
			//成功，初始化用户信息
			if(1==userInfo.getResultcode()){
				/*查询用户表capUser中是否存在该用户*/
				DataObject capUser = DataObjectUtil.createDataObject("org.gocom.components.coframe.rights.dataset.CapUser");
				capUser.set("userId", userInfo.getUserName());
				DatabaseUtil.expandEntityByTemplate("default", capUser, capUser);
				
				if(capUser.getInt("operatorId")>0){//存在
					HttpSession session = req.getSession();
					//初始化用户
					UserObject userObject = UserObjectInit.INSTANCE.init(userInfo.getUserName());
					session.setAttribute("userObject", userObject);
					OnlineUserManager.login(userObject);
					resp.sendRedirect((String)req.getContextPath() + "/coframe/auth/login/redirect.jsp");
				} else {//不存在用户则转发到登录界面
					//login.jsp页面中返回参数：
					//0 密码错误；
					//-1用户不存在;
					//-2用户无权限登录；
					//3 用户已过期；
					//4 用户未到开始使用时间；
					//5 密码已过期；
					//-3查询用户信息失败，请联系系统管理员检查数据库连接；
					//其他数字-未知的异常，请联系系统管理员
					req.setAttribute("result", -1);
					req.getRequestDispatcher("/coframe/auth/login/login.jsp").forward(req, resp);
				}
			}else{
				throw new Exception();
			}
		} catch (Exception e) {
			req.getRequestDispatcher("/coframe/auth/login/login.jsp").forward(req, resp);
		}
	}
}