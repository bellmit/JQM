package com.cjhxfund.ats.ipo;

import java.util.HashMap;
import java.util.Map;

import org.dom4j.DocumentException;

import com.eos.system.annotation.Bizlet;
import com.primeton.workflow.api.WFServiceException;


@Bizlet("流程扩展属性内容解析")
public class FlowExtendUtil {
	
	/**
	 * 
	 * <extendNodes>
	 * 		<extendNode>
	 * 			<key>actType</key>
	 * 			<value>0010</value>
	 * 			<desc></desc>
	 * 		</extendNode>
	 * 		....
	 * </extendNodes>
	 * 			
	 * 
	 * @param extendStr
	 * @return
	 * @throws DocumentException
	 */
	@Bizlet("解析流程扩展中配置扩属性")
	public static Map<String,String> getBackInfo(String extendStr) throws DocumentException{
		Map<String,String> resultMap=new HashMap<String,String>();
		if(extendStr!=null && !"".equals(extendStr)){
			//将扩展的内容去掉回车换行符
			extendStr=extendStr.replaceAll("\r|\n", "");
			extendStr=extendStr.substring(extendStr.indexOf("<extendNodes>")+13);
			//去掉空格字符串
			extendStr.replace("\\s","");
			//System.out.println(extendStr);
			while(extendStr.trim().startsWith("<extendNode>")){
				String extendNode=extendStr.substring(extendStr.indexOf("<extendNode>")+12,extendStr.indexOf("</extendNode>"));
				if(extendNode.trim().startsWith("<key>")){
					String key=extendNode.substring(extendNode.indexOf("<key>")+5, extendNode.indexOf("</key>"));
					if(key!=null && !"".equals(key)){
						String extStr=null;
						//配置回退时，取出回去环节的value
						if("back".equals(key)){
							extStr=extendNode.substring(extendNode.indexOf("<value>")+7, extendNode.indexOf("</value>"));
							//System.out.println(extStr);
							resultMap.put("back", extStr);
						//配置是否自动完成
						}else if("autoFinish".equals(key)){
							extStr=extendNode.substring(extendNode.indexOf("<value>")+7, extendNode.indexOf("</value>"));
							//System.out.println(extStr);
							resultMap.put("autoFinish", extStr);
						//环节标识类型
						}else if("actType".equals(key)){
							extStr=extendNode.substring(extendNode.indexOf("<value>")+7, extendNode.indexOf("</value>"));
							//System.out.println(extStr);
							resultMap.put("actType", extStr);
						}
					}
					extendStr=extendStr.substring(extendStr.indexOf("</extendNode>")+13);
				}
			}
		}
		return resultMap;
	}
	
	public static void main(String[] args) throws WFServiceException, DocumentException {
		String str="<extendNodes><extendNode>"
				+"<key>name</key>"
				+"<value>jim</value>"
				+"<desc></desc>"
				+"</extendNode>"
				+"<extendNode>"
				+"<key>age</key>"
				+"<value>12</value>"
				+"<desc></desc>"
				+"</extendNode>"
				+"<extendNode>"
				+"<key>school</key>"
				+"<value>复旦大学</value>"
				+"<desc>东校区</desc>"
				+"</extendNode>"
				+"</extendNodes>";
		
		getBackInfo(str);
	}
}
