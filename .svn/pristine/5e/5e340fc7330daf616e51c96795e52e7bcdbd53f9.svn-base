
 
	
package com.cjhxfund.ats.mom.report;

import com.cjhxfund.commonUtil.DateUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.spring.support.DatabaseExt;
import commonj.sdo.DataObject;


/**
 * @Description	 产品用管理运算逻辑java代码
 * @ClassName	ProductUserInfoManager
 * @Date		2016年11月14日 下午2:29:54
 * @Author		liangjilong
 * Copyright (c) All Rights Reserved, 2016.
 * @date 2016-11-14 14:29:54
 */

@Bizlet("")
public class ProductUserInfoManager {
	
	private final static String DW_DATABASE_SOURCE="dw";//数据源
	
	
	/**
	 * @Description 保存或更新产品用户信息
	 * @Author		liangjilong
	 * @Date		2016年11月14日 下午2:33:36
	 * @param 		prodUserInfo 页面传过来的对象.
	 * @return 		void 返回类型
	 */
	@Bizlet("保存或更新产品用户信息")
	public void saveOrUpdateProdUserInfo(DataObject prodUserInfo){
		//1、实体对象逻辑

		String entityName="com.cjhxfund.ats.mom.report.report.ProdUserInfo";
		//2、设值
		String userName = (String)prodUserInfo.get("userName");//用户名称
		String userId = (String)prodUserInfo.get("userId");//用户Id
		String prodName =(String) prodUserInfo.get("prodName");//产品名称
		Long prodLayer = prodUserInfo.getLong("prodLayer");//产品类型
		String prodId =(String) prodUserInfo.get("prodId");//产品id
		
		//3、判断是否为空
		if(prodId!=null&&prodId!=""&&prodName!=null&&prodName!=""){
			
			String[] prodIds = prodId.split(",");//处理字符串
			String[] prodNames = prodName.split(",");
			
			DataObject saveOrUpdate = DataObjectUtil.createDataObject(entityName);
			saveOrUpdate.set("userName", userName);
			saveOrUpdate.set("userId", userId);
			saveOrUpdate.set("prodLayer", prodLayer);
			saveOrUpdate.set("insertTime", DateUtil.currentDateTimeString());
			//4、遍历
			for (int i = 0; i < prodIds.length; i++) {
			
				boolean flag = checkIsExistProdUserInfo(userId,prodIds[i],entityName);
				//5、不存在再就插入，避免插入重复有脏数据.
				if(!flag){
					saveOrUpdate.set("prodId", prodIds[i]);
					saveOrUpdate.set("prodName", prodNames[i]);
					saveOrUpdate.set("sysid", getNextSequenceId());
					DatabaseUtil.insertEntity(DW_DATABASE_SOURCE, saveOrUpdate);
				}
			}
		}
	}
	
	/**
	 * 
	 * @Description 检测是否存在产品信息
	 * @Author		liangjilong
	 * @Date		2016年11月14日 下午6:58:08
	 * @userId      用户Id
	 * @prodId      产品Id
	 * @prodName    产品名称
	 * @entityName  实体路径
	 * @return 		boolean 返回类型
	 */
	public static boolean checkIsExistProdUserInfo(String userId,String prodId,String entityName){
		DataObject dataObject = DataObjectUtil.createDataObject(entityName);
		dataObject.set("userId", userId);
		dataObject.set("prodId", prodId);
		
		DataObject[] queryList = DatabaseUtil.queryEntitiesByTemplate(DW_DATABASE_SOURCE, dataObject);
		if(queryList!=null&&queryList.length>0){
			 return true;
		}
		return false;
		
	}
	
	
	/**
	 * @Description  获取下一个序列Id
	 * @Author		liangjilong
	 * @Date		2016年11月14日 下午5:53:48
	 * @param 		参数
	 * @return 		String 返回类型
	 */
	public static synchronized String getNextSequenceId(){
		String result = "";
		try {
			long nextSeq = DatabaseExt.getNextSequence("SEQ_PROD_USER_INFO");
			result = String.valueOf(nextSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
