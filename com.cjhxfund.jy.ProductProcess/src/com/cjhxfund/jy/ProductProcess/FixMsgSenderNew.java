/**
 * 
 */
package com.cjhxfund.jy.ProductProcess;

import java.sql.Connection;
import java.util.Date;
import java.util.List;


import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.foundation.fix.FixToMsgUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

/**
 * @author 王锡锋
 * @date 2018-03-14 17:49:10
 *
 */
@Bizlet("")
public class FixMsgSenderNew {
	
	
	/**
	 * 执行老机器猫指令前台成交状态自动更新
	 * @param pIntervalTime 轮询间隔时间，为空或格式错误时取默认3分钟
	 * @param pEndTime 轮询结束时间，为空或格式错误时取默认17:00
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("老机器猫前台成交反馈")
	public static boolean updateJQMRealDealStatus(){
		System.out.println(DateUtil.currentDateTimeString()+"  执行老机器猫指令前台成交状态自动更新开始...");
		//是否调用成功
		boolean isSuccess = false;
		Connection conn = null;
		try {
			System.out.println(DateUtil.currentDateTimeString()+"  updateJQMRealDealStatus begin ...");
				
			try {
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);//获取默认数据库连接
					
				DataObject tempObject = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ExecutionEntity");
				List<DataObject> receiveMsgs = FixToMsgUtil.queryFixReceiveMsg(null, null, DateUtil.currentDateDefaultString()+" 00:00:00");//仅查询当天的成交
				if(receiveMsgs!=null && !receiveMsgs.isEmpty() && receiveMsgs.size()>0){
					for(int i=0; i<receiveMsgs.size(); i++){
						DataObject receiveMsg = receiveMsgs.get(i);
						//3-回馈tag15999=3（成交反馈）
						if("3".equals(receiveMsg.getString("VC_PROCETYPE"))){
							tempObject.set("vcMsgtype", receiveMsg.getString("VC_MSGTYPE"));
							tempObject.set("vcProcetype", receiveMsg.getString("VC_PROCETYPE"));
							tempObject.set("vcOrdstatus", receiveMsg.getString("VC_ORDSTATUS"));
							tempObject.set("vcExectype", receiveMsg.getString("VC_EXECTYPE"));
							DataObject statusObject = FixToMsgUtil.getExecutionReportStatus(tempObject);
							if(statusObject.getBoolean("isSuccess")){
								//A08-部分成交：35=8;15999=3;39=1;150=1;  A09-全部成交：35=8;15999=3;39=2;150=2;
								if("A08".equals(statusObject.getString("resultMsgType"))||"A09".equals(statusObject.getString("resultMsgType"))){
									List<DataObject> zqmms = ProductProcessUtil.getZqmmByClordid(conn, receiveMsg.getString("VC_CLORDID"));
									List<DataObject> zqhgs = ProductProcessUtil.getZnhgByClordid(conn, receiveMsg.getString("VC_CLORDID"));
									if(zqmms!=null && !zqmms.isEmpty() && zqmms.size()>0){
										for(int j=0; j<zqmms.size(); j++){
											DataObject zqmm = zqmms.get(j);
											//买卖业务流程处理状态： 5-前台成交;  6-后台成交 ;
											if(!"5".equals(zqmm.getString("processStatus")) && !"6".equals(zqmm.getString("processStatus"))){
												zqmm.setInt("processStatus", Integer.valueOf("5"));
												zqmm.setString("sendId", "sysadmin");
												zqmm.setString("sendName", "sysadmin");
												zqmm.setDate("sendCd", new Date());
												ProductProcessUtil.updateZqmmByDealStatus(conn, zqmm);
											}
										}
									}
									
									if(zqhgs!=null && !zqhgs.isEmpty() && zqhgs.size()>0){
										for(int j=0; j<zqhgs.size(); j++){
											DataObject zqhg = zqhgs.get(j);
											//买卖业务流程处理状态： 5-前台成交;  6-后台成交 ;
											if(!"5".equals(zqhg.getString("processStatus")) && !"6".equals(zqhg.getString("processStatus"))){
												zqhg.setInt("processStatus", Integer.valueOf("5"));
												zqhg.setString("sendId", "sysadmin");
												zqhg.setString("sendName", "sysadmin");
												zqhg.setDate("sendCd", new Date());
												ProductProcessUtil.updateZnhgByDealStatus(conn, zqhg);
											}
										}
									}
								}
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				JDBCUtil.releaseResource(conn, null, null);
			}
			System.out.println(DateUtil.currentDateTimeString()+"  updateJQMRealDealStatus end !!!");
			//设置为调用成功
			isSuccess = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		System.out.println(DateUtil.currentDateTimeString()+"  执行老机器猫指令前台成交状态自动更新结束!!!");
		return isSuccess;
	}
}
