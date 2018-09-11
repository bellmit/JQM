package org.gocom.components.coframe.tools.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.gocom.components.coframe.auth.intercepter.UserLoginWebInterceptor;
import org.gocom.components.coframe.auth.menu.DefaultMenuAuthService;
import org.gocom.components.coframe.framework.constants.IAppConstants;
import org.gocom.components.coframe.tools.IAuthConstants;
import org.gocom.components.coframe.tools.IConstants;

import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.data.datacontext.UserObject;
import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.logging.Logger;
import com.eos.system.utility.StringUtil;
import com.primeton.cap.TenantManager;
import com.primeton.cap.management.resource.IManagedResource;
import com.primeton.cap.management.resource.manager.ResourceRuntimeManager;
import com.primeton.cap.party.Party;
import com.primeton.ext.access.http.processor.MultipartResolver;
import com.primeton.ext.common.muo.MUODataContextHelper;

/**
 * 用于控制页面资源权限
 * 
 * @deprecat 页面权限标签
 * @author 谭凯
 * @date 20160804
 * 
 */
public class PrivilegeTag extends TagSupport {

	private static final long serialVersionUID = -532517444654109642L;
	private Logger log = TraceLoggerFactory.getLogger(PrivilegeTag.class);

	private String sourceId; // 对应Attribute,加上set方法。
	private String lableName; // 按钮名（添加）
	private String clazz; // 样式
	private String iconCls; // 图标
	private String onClick; // 点击事件
	private String sid; // 按钮ID属性
	private String sname; // 按钮名称属性

	public String getSourceId() {
		return sourceId;
	}

	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}

	public String getLableName() {
		return lableName;
	}

	public void setLableName(String lableName) {
		this.lableName = lableName;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getOnClick() {
		return onClick;
	}

	public void setOnClick(String onClick) {
		this.onClick = onClick;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	/**
	 * 解析标签，形成原有的a标签
	 */

	public int doStartTag() throws JspException {

		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();
		/**
		 * 判断按钮是否有权限
		 */
		if (hasPermission(getManagedResource(sourceId), request)) {
			StringBuffer sb = new StringBuffer();
			sb.append("<a");
			/**
			 * 按钮触发事件
			 */
			if (onClick != null && !onClick.equals("")) {
				sb.append(" onclick=\"" + onClick + "\"");
			}
			// 样式
			sb.append(" class=\"" + clazz + "\"");
			//sb.append(" plain=true");//按钮扁平化
			if (iconCls != null && !iconCls.equals("")) {
				sb.append(" iconCls=\"" + iconCls + "\"");
			}
			/**
			 * 按钮id属性
			 */
			if (sid != null && !sid.equals("")) {
				sb.append(" id=\"" + sid + "\"");
			}
			/**
			 * 按钮name属性
			 */
			if (sname != null && !sname.equals("")) {
				sb.append(" name=\"" + sname + "\"");
			}
			sb.append(" >" + lableName + "</a>");
			try {
				pageContext.getOut().write(sb.toString());
			} catch (IOException e) {
				log.error("权限标签错误", e);
			}
			return EVAL_PAGE;
		}

		return SKIP_BODY;
	}

	/**
	 * 判断是否拥有访问该角色的权限
	 * 
	 * @param managedResource
	 * @param request
	 * @return
	 */
	public boolean hasPermission(IManagedResource managedResource,
			HttpServletRequest request) {
		if (managedResource == null) {
			return true;
		} else if (managedResource != null
				&& "0".equals(managedResource
						.getAttribute(IAppConstants.FUNCTION_IS_CHECK))) {
			return true;
		}
		UserObject userObject = (UserObject) request.getSession().getAttribute(
				"userObject");
		String roleIds = (String) userObject.get(IConstants.ROLE_LIST);
		List<Party> roles = new ArrayList<Party>();
		if (roleIds != null) {
			String[] roleIdArr = roleIds
					.split(com.primeton.cap.auth.IConstants.SPLIET);
			for (String roleId : roleIdArr) {
				if (!StringUtils.isEmpty(roleId)) {
					roles.add(new Party(IConstants.ROLE_PARTY_TYPE_ID, roleId,
							roleId, roleId));
				}
			}
		}
		String funcCode = managedResource.getResourceID();
		DefaultMenuAuthService menuAuthService = new DefaultMenuAuthService(
				roles);
		if (menuAuthService.canAccessFunction(funcCode)) {
			return true;
		}
		return false;
	}

	/**
	 * 获得功能资源
	 * 
	 * @param request
	 * @return
	 */
	public IManagedResource getManagedResource(String sourceId) {
		List<IManagedResource> resources = ResourceRuntimeManager.getInstance()
				.getRootManagedResourceListByType(
						IAuthConstants.FUNCTION_TO_RESOURCE_TYPE);
		String tenantId = TenantManager.getCurrentTenantID();
		for (IManagedResource resource : resources) {
			String funcTenant = resource.getTenantID();
			String functid = resource.getResourceID();
			if (StringUtil.equal(tenantId, funcTenant)
					&& StringUtil.equal(sourceId, functid)) {
				return resource;
			}
		}
		return null;
	}

}
