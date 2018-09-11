package com.cjhxfund.commonUtil;
import java.util.ArrayList;
import java.util.List;

import com.cjhxfund.cjapi.exception.AppException;
import com.cjhxfund.cjapi.exception.CJAPIConstants;
import com.eos.common.transaction.ITransactionManager;
import com.eos.common.transaction.TransactionManagerFactory;
import com.eos.das.entity.criteria.CriteriaType;
import com.eos.das.entity.criteria.ExprType;
import com.eos.das.entity.criteria.impl.CriteriaTypeImpl;
import com.eos.das.entity.criteria.impl.ExprTypeImpl;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.runtime.core.TraceLoggerFactory;
import com.eos.system.annotation.Bizlet;
import com.eos.system.exception.EOSRuntimeException;
import com.eos.system.logging.Logger;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;


/**
 * @Project		JQM
 * @File		GenericBaseDaoSupport.java
 * @Package		com.cjhxfund.commonUtil
 * @Version		V1.0
 * @Date		2016年12月28日 上午9:41:29
 * @Author		liangjilong
 * @Copyright (c) All Right Reserved CJHXFUND, 2016.
 */


@Bizlet("通用基础DAO支持处理类")
public class GenericBaseDaoSupport {
	
	private static final Logger logger = TraceLoggerFactory.getLogger(GenericBaseDaoSupport.class);

	private static ITransactionManager  transactionManager = null;
	static {
		if(transactionManager == null){
			transactionManager = TransactionManagerFactory.getTransactionManager();//事务
		}
	}
	
	/**
	 * @Description 保存或者更新的动作.
	 * @Author		liangjilong
	 * @Date		2016年12月5日 下午2:55:39
	 * @param 		paramters 参数信息
	 * @param 		executeType执行类型(true/false)
	 * @param 		entityName实体数据模型路径
	 * @param 		dataSource数据源
	 * @return 		void 返回类型
	 */
	public static void saveOrUpdate(DataObject paramters, boolean executeType, String entityName,String dataSource) throws AppException {
		try {
			//创建DataObject,获取值，并设置值到实体属性,转换成EOS底层的DataObject
			DataObject convertDataObject = DataObjectUtil.convertDataObject(paramters, entityName, true);
			if(executeType){
				DatabaseUtil.insertEntity(dataSource, convertDataObject);//保存信息
			}else{
				DatabaseUtil.updateEntity(dataSource, convertDataObject);//更新信息
			}
		} catch (Exception e) {
			if(e instanceof EOSRuntimeException) {
				EOSRuntimeException eosEx=(EOSRuntimeException)e;//普元运行异常
				int code =  StrUtil.toInteger(eosEx.getCode());
				throw new AppException(code,  eosEx.getMessage());
			}else {
				throw new AppException(CJAPIConstants.ERROR_INSERT_OR_UPDATE_DATA,  CJAPIConstants.ERROR_INSERT_OR_UPDATE_DATA_MSG);
			}
		}
	}
	
	
	/**
	 * @Description 查询一个对象数据
	 * @Author		liangjilong
	 * @Date		2016年12月28日 上午10:52:14
	 * @param 		dsName 数据源
	 * @param 		paramDataObj 出入参数对象和返回的新数据对象
	 * @return 		参数
	 * @return 		DataObject 返回类型
	 */
	public static DataObject findOne(String dsName,DataObject paramDataObj){
		int count = DatabaseUtil.expandEntity(dsName, paramDataObj);
		if(count > 0){
			return paramDataObj;
		}
		return null;
	}
	
	
	/**
	 * @Description 动态查询创建CriteriaType对象（propertyNameKeys，propertyNameVals，ops参数值必须是一一对应）
	 * @Author		liangjilong
	 * @Date		2016年12月27日 下午2:37:56
	 * @param 		entityName 动态实体名称
	 * @param 		propertyNameKeys 动态属性name查询条件Key（知道哪些属性要查询的key，不能为空）
	 * @param 		propertyNameVals 动态属性name查询条件Value(值相对比较多类型String,Long,BigDecimal等故改成Object接收)
	 * @param 		ops 动态操作条件(like,or,and,in ,=,>,>=,between,等等SQL关键字)
	 * @return 		CriteriaType 返回类型
	 */
	public static CriteriaType createCriteriaType(String entityName, String [] propertyNameKeys,Object [] propertyNameVals,String [] ops) throws AppException{
		//1、创建CriteriaType和ExprType进行条件查询
		CriteriaType criteriaType = new CriteriaTypeImpl();
		criteriaType.set_entity(entityName);//设置动态的实体
		
		//2、创建 ExprType集合
		List<ExprType> exprTypeList = new ArrayList<ExprType>();
		
		//3、遍历
		if(StrUtil.isNotEmpty(propertyNameKeys) && StrUtil.isNotEmpty(propertyNameVals) && StrUtil.isNotEmpty(ops)){
			//判断propertyNameKeys,propertyNameVals,ops的长度相等才处理.
			if((propertyNameVals.length == propertyNameKeys.length) && (ops.length == propertyNameKeys.length) ){
				for (int i = 0; i < propertyNameKeys.length; i++) {
					String propertyNameKey = propertyNameKeys[i];
					ExprType exprType = new ExprTypeImpl();
					exprType.set_op(ops[i]);//SQL查询条件关键操作符
					if(StrUtil.isNotEmpty(propertyNameKey)){
						exprType.set(propertyNameKey, propertyNameVals[i]);
					}
					//4、设置条件对象
					exprTypeList.add(exprType);
				}
				//5、添加exprTypeList集合
				criteriaType.set_expr(exprTypeList);
			}else{
				String errorParamMissMsg = CJAPIConstants.ERROR_PARAM_MISS_MSG;
				String msg = String.format(errorParamMissMsg, "propertyNameKeys或propertyNameVals或ops");
				throw new AppException(CJAPIConstants.ERROR_PARAM_MISS,msg);
			}
		}else{
			throw new AppException(CJAPIConstants.ERROR_PARAM_NULL,CJAPIConstants.ERROR_PARAM_NULL_MSG);
		}
		return criteriaType;
	}
	
	/**
	 * @Description 代码程序之间调用逻辑方法
	 * @Author		liangjilong
	 * @Date		2016年12月28日 上午10:22:20
	 * @param 		componentName 逻辑构件名称
	 * @param 		bizMethodName 逻辑流名称
	 * @param 		paramObjs参入的参数
	 * @return 		Object[] 返回类型
	 */
	public static Object [] invokeBizMethod(String componentName,String bizMethodName,Object [] paramObjs)  throws AppException{
		Object [] retObjs  =  null;
		ILogicComponent logicComponent = LogicComponentFactory.create(componentName);//创建组建工程
		try {
			retObjs = logicComponent.invoke(bizMethodName, paramObjs);//调用逻辑流
			if(StrUtil.isNotEmpty(retObjs)){
				return retObjs;
			}
		} catch (Throwable e) {
			logger.error("当前类"+getCurrentClassName()+"invokeBizMethod调用逻辑流："+componentName+"."+bizMethodName+"出错,异常信息为："+e.getMessage());
			LogUtil.logError("公共方法[java调用逻辑]错误，调用逻辑流："+componentName+"."+bizMethodName+"出错", e, retObjs);
			throw new AppException(CJAPIConstants.ERROR_INVOKE, CJAPIConstants.ERROR_INVOKE_MSG);
		}
		return retObjs;
	}
	
	/**
	 * @Description 开始事务
	 * @Author		liangjilong
	 * @Date		2016年12月29日 下午3:22:22  
	 * @return 		void 返回类型
	 */
	public static void begin(){
		transactionManager.begin();
	}
	/**
	 * @Description 提交事务
	 * @Author		liangjilong
	 * @Date		2016年12月29日 下午3:22:22 
	 * @return 		void 返回类型
	 */
	public static void commit(){
		transactionManager.commit();
	}
	/**
	 * @Description 回滚事务
	 * @Author		liangjilong
	 * @Date		2016年12月29日 下午3:22:22 
	 * @return 		void 返回类型
	 */
	public static void rollBack(){
		transactionManager.rollback();
	}
	
	/**
	 * @Description 设置回滚事务
	 * @Author		liangjilong
	 * @Date		2016年12月29日 下午3:22:22 
	 * @return 		void 返回类型
	 */
	public static void rollbackOnly(){
		transactionManager.setRollbackOnly();
	}
 
	/**
	 * @Description 获取当前类名称,包含有包名路径。
	 * @Author		liangjilong
	 * @Date		2016年12月28日 上午9:59:29
	 * @return 		参数
	 * @return 		String 返回类型
	 */
	private static String getCurrentClassName(){
		return GenericBaseDaoSupport.class.getName()+".";
	}


}
