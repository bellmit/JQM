package org.gocom.components.coframe.auth.ldap;

import java.util.Hashtable;

import javax.naming.AuthenticationException;
import javax.naming.Context;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

import org.cjhxfund.sys.SysParamUtil;
import org.gocom.components.coframe.rights.dataset.CapUser;
import org.gocom.components.coframe.rights.user.CapUserService;

import com.eos.system.annotation.Bizlet;


public class LDAPCheck {
	//初始化LDAP
	@Bizlet("AD域用户验证")
	public int checkUser(String username,String password,CapUser capUser) {
		//System.out.println(username+"|"+password);
        LdapContext ctx=null;
        String host = SysParamUtil.getSysParam("ldap", "host");
        String post = SysParamUtil.getSysParam("ldap", "post");
        String company = SysParamUtil.getSysParam("ldap", "company");
        String email = SysParamUtil.getSysParam("ldap", "Email");
        Hashtable<String,String> HashEnv = new Hashtable<String,String>();
        HashEnv.put(Context.SECURITY_AUTHENTICATION, "simple"); 			// LDAP访问安全级别(none,simple,strong)
        HashEnv.put(Context.SECURITY_PRINCIPAL, username + email); 	
        System.out.println(username + email);
        //AD的用户名
        HashEnv.put(Context.SECURITY_CREDENTIALS, password); 				//AD的密码
        HashEnv.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory"); // LDAP工厂类

        HashEnv.put(Context.PROVIDER_URL, "ldap://" + host + ":" + post);// 默认端口389
        try {
            ctx = new InitialLdapContext(HashEnv,null);// 初始化上下文
            System.out.println("身份验证成功!");
            CapUserService cus = new CapUserService();
            String encodePassword = cus.encodePassword(password);  //获取加密后的密码
            capUser.setPassword(encodePassword);
            cus.updateCapUser(capUser);
            return 1;
        } catch (AuthenticationException e) {
            System.out.println("身份验证失败!");
            e.printStackTrace();
        } catch (javax.naming.CommunicationException e) {
            System.out.println("AD域连接失败!");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("身份验证未知异常!");
            e.printStackTrace();
        } finally{
            if(null!=ctx){
                try {
                    ctx.close();
                    ctx=null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }
}