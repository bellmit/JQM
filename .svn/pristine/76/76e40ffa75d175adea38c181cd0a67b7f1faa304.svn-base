/**
 * 
 */
package com.cjhxfund.ats.fm.comm;

import java.lang.reflect.Field;
import java.util.HashMap;
import com.eos.system.annotation.Bizlet;

/**
 * 业务状态码类
 * @author 杨敏
 * @date 2016-09-22 15:36:54
 *
 */
@Bizlet("业务状态码类")
public class StatusCode {

	private static final String FILEISNULL="文件找不到";
	
	//定义常量名称和code的关系
	private static final HashMap<String, String> CODEMSG = new HashMap<String, String>() {
		/**
		 * 定义常量名称和code的关系，存放在map集合中
		 */
		private static final long serialVersionUID = 1L;
		{ 
			put("1001", "FILEISNULL" ); 
		}
	}; 

	/**
	 * 获取状态码消息
	 * @param code
	 * @return
	 */
	@Bizlet("获取状态码消息")
	public static String getStatusMsg(String code){

		String name=StatusCode.CODEMSG.get(code);
		Object f=new StatusCode();
		// 获取f对象对应类中的所有属性域
		Field[] fields = f.getClass().getDeclaredFields();
		for(int i = 0 , len = fields.length; i < len; i++) {
			// 对于每个属性，获取属性名
			String varName = fields[i].getName();
			//查找指定的变量名。
			if(!varName.equals(name)){
				continue;
			}
			try {
				// 获取原来的访问控制权限
				boolean accessFlag = fields[i].isAccessible();
				// 修改访问控制权限
				fields[i].setAccessible(true);
				// 获取在对象f中属性fields[i]对应的对象中的变量
				Object o = fields[i].get(f);
				// 恢复访问控制权限
				fields[i].setAccessible(accessFlag);
				return o.toString();
			} catch (IllegalArgumentException ex) {
				ex.printStackTrace();
			} catch (IllegalAccessException ex) {
				ex.printStackTrace();
			}
		}
		return "未知错误，请联系管理员";
	}
	public static void main(String[] args) {
		String name=StatusCode.getStatusMsg("1001");
		System.out.println(name);
	}


}
