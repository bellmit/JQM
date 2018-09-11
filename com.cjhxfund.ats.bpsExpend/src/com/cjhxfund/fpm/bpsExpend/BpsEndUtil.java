package com.cjhxfund.fpm.bpsExpend;
import java.util.HashMap;

import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

public class BpsEndUtil {

	/**
	 * 
	 * @param url 逻辑流的url
	 * @param param  需要invoke的逻辑流参数
	 * @return
	 * @throws Throwable
	 */
	@SuppressWarnings("all")
    @Bizlet
    public static  Object[] invoke(String url,Object param) throws Throwable{
    	
    	int index=url.lastIndexOf('.');
    	//逻辑构建名称
    	System.out.println();
    	
		String componentName=url.substring(0,index);
		//逻辑流名称
		String operationName=url.substring(index+1, url.length());		
		ILogicComponent comp = LogicComponentFactory.create(componentName);	
		int i=0;
		Object []object =new Object[1];
		object [0]=param;
        Object[] result=comp.invoke(operationName, object);
        return result;
    }

	/**
	 * 
	 * @param map  逻辑流结果集合
	 * @param logicalFlowName  逻辑流名称
	 * @param result  调用逻辑流返回的结果
	 * @return  逻辑流结果集合
	 * @throws Throwable
	 */
    @Bizlet
    public static  HashMap<String,Object> appendFesult(HashMap<String,Object> map,String logicalFlowName,Object []result) throws Throwable{
    	map.put(logicalFlowName,result);
    	return map;
    }
}
