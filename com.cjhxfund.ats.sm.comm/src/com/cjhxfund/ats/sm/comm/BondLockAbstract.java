/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.text.SimpleDateFormat;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 童伟
 * @date 2016-12-06 10:14:55
 *	拼装解锁审批信息 任务信息栏
 */
@Bizlet("")
public class BondLockAbstract {

	@Bizlet("BondLockInfo 解锁数据对象")
	public static String assembleAbstract(DataObject BondLockInfo){
		String resultAbstract=null;
		StringBuffer vcAbstract=null;
		vcAbstract=new StringBuffer();
		vcAbstract.append("证券名称："+BondLockInfo.getString("vcStockName")+"，");
		vcAbstract.append("申请解锁人名称："+BondLockInfo.getString("vcOperatorName")+"，");
		vcAbstract.append("申请解锁数量："+BondLockInfo.getString("lUnlockQty")+"，");
		// 日期转换
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String tOperatTime = sdf.format(BondLockInfo.getDate("tOperatTime"));
		vcAbstract.append("申请解锁时间："+tOperatTime);
		resultAbstract=vcAbstract.toString();
		return resultAbstract;
	}
	@Bizlet("addLockQty 增加锁定数量")
	public static long addLockQty(DataObject a,DataObject b){
		return a.getLong("lLockQty") + b.getLong("lLockQty");
		
	}
	@Bizlet("subLockQty 减去锁定数量")
	public static long subLockQty(DataObject a,DataObject b){
		return a.getLong("lLockQty") - b.getLong("lLockQty");
		
	}
	
	/**
	 * 计算可解锁数量，插入锁定记录
	 * 
	 * @param lockInfo 锁定记录信息
	 * @return	lockInfo 添加可解锁数量后的锁定记录信息
	 * @author tongwei
	 * 
	 */
	@Bizlet("计算可解锁数量，插入锁定记录")
	public DataObject[] assembleLockInfo(DataObject[] lockInfo){
		Object[] pedingUnLockQtyObject = null;
		// 申请中带解锁数量
		double pedingUnLockQty = 0.0;
		// 可解锁数量
		double operableUnLockQty = 0.0;
		// 锁定数量
		double lockQty = 0.0;
		// 解锁申请状态
		String approvalStatus = "1";
		// 查询解锁中数量条件
		DataObject data = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
		if(lockInfo.length>0){
			for(int i=0; i<lockInfo.length; i++){
				data.setString("lockId", lockInfo[i].getString("lLockId"));
				data.setString("approvalStatus", approvalStatus);
				lockQty = Double.parseDouble(lockInfo[i].getString("lLockQty"));
				// 查询可解锁数量
				pedingUnLockQtyObject = DatabaseExt.queryByNamedSql("default",
						"com.cjhxfund.ats.sm.comm.bondManage.getUnlockQtyPendingApproveSum",data);
				if(pedingUnLockQtyObject.length>0){
					for(int j=0; j<pedingUnLockQtyObject.length; j++){
						DataObject pedingUnLockQtyObj = (DataObject) pedingUnLockQtyObject[j];
						pedingUnLockQty = Double.parseDouble(pedingUnLockQtyObj.getString("UNLOCKQTYSUM"));
						operableUnLockQty = lockQty - pedingUnLockQty; 
						lockInfo[i].setDouble("operableUnLockQty", operableUnLockQty);
					}
				}
			}
		}
		return lockInfo;
	}
	
	@Bizlet("自动解锁计算可解锁数量")
	public static long atuoOperableUnLockQty(long a,DataObject b){
		return b.getLong("lLockQty") - a;
		
	}
}
