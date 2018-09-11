
package com.cjhxfund.jy.ProductProcess;

import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.commonUtil.GenericBaseDaoSupport;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @Description	ProductProcess处理CJAPI业务类
 * @ClassName	ProductProcessApiUtil
 * @Date		2017年2月7日 下午3:15:23
 * @Author		liangjilong
 * @Copyright (c) All Right Reserved CJHXFUND, 2017.
 * @author liangjilong
 * @date 2017-02-07 15:15:23
 */

@Bizlet("ProductProcessApiUtil类")
public class ProductProcessApiUtil {
	
	/**
	 * @Description 回调跟踪机器猫操作按钮流程状态或交易状态
	 * @Author		liangjilong
	 * @Date		2017年2月7日 下午3:28:13
	 * @param opType
	 * @param processId
	 * @param tableName
	 * @throws AppException 		参数
	 * @return 		void 返回类型
	 */
	@Bizlet("回调跟踪机器猫操作按钮流程状态或交易状态")
	public static DataObject  orderOperateCallBack(String opType,Long processId,String tableName,DataObject temp) throws AppException{
		
		String  componentName = "com.cjhxfund.cjapi.CjapiCommonFunction";//构件名称
		String  bizMethodName = "orderOperateCallBack";//订单操作反馈biz方法名名称
		Object  [] paramObjs = new Object[] {opType,processId,tableName};//参数
		//调用逻辑.
		Object[] objects = GenericBaseDaoSupport.invokeBizMethod(componentName, bizMethodName, paramObjs);
		temp.setString("result",(String)objects[0]);
		return temp;
		
	}
	

}
