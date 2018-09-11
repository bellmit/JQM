package com.cjhxfund.ats.fm.baseinfo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

@Bizlet("")
public class SysBondInfoBysjzx {
	 @Bizlet("")
	    public boolean SysBondInfo() {
	        boolean isSuccess = false;
		        System.out.println("[SysBondInfoBysjzx]"+"开始获取Wind和O32历史评级...");
		        LogUtil.logInfo("[SysBondInfoBysjzx]"+"开始获取Wind和O32历史评级...", null, new Object[]{});		  
		        Long beforeTime=(new Date()).getTime();
		        
		        isSuccess = getBondAppraise();
		        if (!isSuccess) {
		            LogUtil.logError("[SysBondInfoBysjzx]"+"SysBondInfoBysjzx.getBondAppraise函数执行失败,掉用getBondAppraise出错!", null, new Object[]{});
		            return isSuccess;
		        }
		        
		        Long afterTime=(new Date()).getTime();
		        String className=Thread.currentThread().getStackTrace()[1].getClassName();
		        String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
		        QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
		        
		        LogUtil.logInfo("[SysBondInfoBysjzx]"+"结束获取Wind和O32历史评级...", null, new Object[]{});
		        System.out.println("[SysBondInfoBysjzx]"+"结束获取Wind和O32历史评级...");
		        return isSuccess;
	    }
	 @Bizlet("")
	 public static boolean getBondAppraise(){
			SynCommonUtil.insertMsg("2", "开始获取历史评级", 0, "获取Wind和O32历史评级", "开始获取历史评级");
	        boolean execute = true;
	        boolean isSuccess = true;
	        boolean flag = true;
	        StringBuffer sql = new StringBuffer();
	        StringBuffer sql_qjy = new StringBuffer();
	        Connection conn_qjy = null;
	        List<Map<String, String>> list_bond = new ArrayList<Map<String, String>>();
	        List<Map<String, String>> list_bond_wind = new ArrayList<Map<String, String>>();
	        List<Map<String, String>> list_bond_O32 = new ArrayList<Map<String, String>>();
	        System.out.println("[getBondAppraise]"+"获取Wind和O32历史评级..");
	        LogUtil.logInfo("[getBondAppraise]"+"获取Wind和O32历史评级..", null, new Object[]{});
	        //1.查询ATS历史评级表中有没有数据和最大的日期时间
	        try {
	        	conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
	        	sql.setLength(0);
	        	sql.append(" select count(1) as cnt,max(L_APPRAISE_DATE) as maxdate from T_ATS_BOND_APPRAISE");
	        	list_bond = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
			} catch (Exception e) {
				isSuccess = false;
				e.printStackTrace();
				SynCommonUtil.insertMsg("1", e.getMessage(), 0, "查询历史评级", "查询Ats历史评级表");
	            LogUtil.logError("[getBondAppraise]"+"函数执行失败,查询Ats历史评级表报错！ ", e, new Object[]{});
			}finally{
				sql.setLength(0);
				sql = null;
				JDBCUtil.releaseResource(conn_qjy, null, null);
			}
	        //2.如果ATS历史评级表中没有数据，查出数据中心数据全量，有数据的话用最大的日期做条件去数据中心查最大日期到当前日期的数据
	        while (execute) {
	            try {
	            	conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
	            	if("0".equals(list_bond.get(0).get("CNT"))){	//查询数据中心wind和O32的历史评级
	            		getBondForOne();
	            		flag = false;
	            	}else{
	                	if(list_bond.get(0).get("MAXDATE") != null && list_bond.get(0).get("MAXDATE") != ""){
	                		sql_qjy.setLength(0);
	                		sql_qjy.append(" select VC_INTER_CODE, L_APPRAISE_DATE, VC_BOND_APPRAISE "
	                				+ ", VC_BOND_APPRAISE_ORGAN from isp.BOND_APPRAISE_HIS_WIND where 1=1 ");
	                		sql_qjy.append(" and L_APPRAISE_DATE >='"+list_bond.get(0).get("MAXDATE")+"'");
	                		list_bond_wind = JDBCUtil.queryWithConn(conn_qjy, sql_qjy.toString(), null);
	                		sql_qjy.setLength(0);
	                		sql_qjy.append(" select VC_INTER_CODE, L_APPRAISE_DATE, VC_BOND_APPRAISE "
	                				+ ", VC_BOND_APPRAISE_ORGAN from isp.BOND_APPRAISE_HIS_O32 where 1=1 ");
	                		sql_qjy.append(" and L_APPRAISE_DATE >='"+list_bond.get(0).get("MAXDATE")+"'");
	                		list_bond_O32 = JDBCUtil.queryWithConn(conn_qjy, sql_qjy.toString(), null);
	                	}
	            	}
	            	SynCommonUtil.insertMsg("2", "获取历史评级", list_bond_wind.size(), "获取Wind历史评级", "开始获取历史评级");
	            	SynCommonUtil.insertMsg("2", "获取历史评级", list_bond_O32.size(), "获取O32历史评级", "开始获取历史评级");
	            	execute = false;
	            } catch (Exception e) {
	            	isSuccess = false;
	                e.printStackTrace();
	                SynCommonUtil.insertMsg("1", e.getMessage(), 0, "查询历史评级", "查询O32和Wind历史评级");
	                LogUtil.logError("[getBondAppraise]"+"函数执行失败,获取Wind和O32历史评级出错!", e, new Object[]{});
	            }
	            finally {
	            	sql_qjy.setLength(0);
	            	sql_qjy = null;
	                JDBCUtil.releaseResource(conn_qjy, null, null);
	            }
	        }
	        //3.将数据插入到ATS的历史评级表中
	        if(flag){
		        try {
		        	List<DataObject> listbonds = new ArrayList<DataObject>();
		        	if(!list_bond_wind.isEmpty() && list_bond_wind.size() > 0){
		        		for (int i = 0; i < list_bond_wind.size(); i++) {
		        			DataObject bondappraise = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsBondAppraise");
		                    Map<String, String> map = list_bond_wind.get(i);
		                    bondappraise.setInt("lAppraiseDate", Integer.parseInt(map.get("L_APPRAISE_DATE")));
		                    bondappraise.setString("vcInterCode", map.get("VC_INTER_CODE"));
		                    bondappraise.setString("vcBondAppraise", map.get("VC_BOND_APPRAISE"));
		                    bondappraise.setString("vcBondAppraiseOrgan", map.get("VC_BOND_APPRAISE_ORGAN"));
		                    bondappraise.setString("cSource", "4");
		                    listbonds.add(bondappraise);
		                    bondappraise = null;
		                    if(listbonds.size() == 10000){
		                    	DataObject dataobjects[] = new DataObject[listbonds.size()];
		                    	listbonds.toArray(dataobjects);
		                    	DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, dataobjects);
		                    	listbonds = null;
		                    	listbonds = new ArrayList<DataObject>();
		                    	dataobjects = null;
		                    }
		        		}
		        	}
		        	if(!list_bond_O32.isEmpty() && list_bond_O32.size() > 0){
		        		for (int i = 0; i < list_bond_O32.size(); i++) {
		        			DataObject bondappraise = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsBondAppraise");
		                    Map<String, String> map = list_bond_O32.get(i);
		                    bondappraise.setInt("lAppraiseDate", Integer.parseInt(map.get("L_APPRAISE_DATE")));
		                    bondappraise.setString("vcInterCode", map.get("VC_INTER_CODE"));
		                    bondappraise.setString("vcBondAppraise", map.get("VC_BOND_APPRAISE"));
		                    bondappraise.setString("vcBondAppraiseOrgan", map.get("VC_BOND_APPRAISE_ORGAN"));
		                    bondappraise.setString("cSource", "3");
		                    listbonds.add(bondappraise);
		                    bondappraise = null;
		                    if(listbonds.size() == 10000){
		                    	DataObject dataobjects[] = new DataObject[listbonds.size()];
		                    	listbonds.toArray(dataobjects);
		                    	DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, dataobjects);
		                    	listbonds = null;
		                    	listbonds = new ArrayList<DataObject>();
		                    	dataobjects = null;
		                    }
		        		}
		        	}
		        	DataObject dataobjects[] = new DataObject[listbonds.size()];
		        	listbonds.toArray(dataobjects);
		            DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, dataobjects);
		            SynCommonUtil.insertMsg("0", "插入历史评级完成", dataobjects.length, "插入历史评级", "将O32和wind的历史评级插入ATS历史评级表");
		            listbonds = null;
		            dataobjects = null;
					
				} catch (Exception e) {
					isSuccess = false;
					e.printStackTrace();
					 SynCommonUtil.insertMsg("1", e.getMessage(), 0, "插入历史评级", "插入O32和Wind历史评级");
		            LogUtil.logError("[getBondAppraise]"+"函数执行失败,插入Wind和O32历史评级出错!", e, new Object[]{});
				}
	        }
	        list_bond = null;
	        list_bond_wind = null;
	        list_bond_O32 = null;
	        SynCommonUtil.insertMsg("2", "结束获取历史评级", 0, "获取Wind和O32历史评级", "结束获取历史评级");
	        LogUtil.logInfo("[getBondAppraise]"+"结束获取Wind和O32历史评级..", null, new Object[]{});
	        System.out.println("[getBondAppraise]"+"结束获取Wind和O32历史评级..");
	        
	        return isSuccess;
	    }
	 public static boolean getBondForOne(){
		 	boolean isSuccess = false;
		 	int lastrow = 0;
			Connection conn_qjy = null;
			StringBuffer sql_qjy = new StringBuffer();
			List<DataObject> listbonds = new ArrayList<DataObject>();
			List<Map<String, String>> list_bond_wind = new ArrayList<Map<String, String>>();
			List<Map<String, String>> list_bond_O32 = new ArrayList<Map<String, String>>();
			conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			System.out.println("开始时间:"+new Date());
			//获取Wind历史评级
	        try {
	        	sql_qjy.setLength(0);
	        	sql_qjy.append(" select count(1) as count from isp.BOND_APPRAISE_HIS_WIND");
	        	list_bond_wind = JDBCUtil.queryWithConn(conn_qjy, sql_qjy.toString(), null);
	        	int datanum = Integer.parseInt(list_bond_wind.get(0).get("COUNT"));
	        	int onerun = 10000;
	        	int runnum = datanum%onerun==0?(datanum/onerun):(datanum/onerun)+1;
	        	for(int r =0;r<runnum;r++){
	        		sql_qjy.setLength(0);
	        		sql_qjy.append(" select VC_INTER_CODE, L_APPRAISE_DATE, VC_BOND_APPRAISE, VC_BOND_APPRAISE_ORGAN from "
	        				+ "(select rownum rm,VC_INTER_CODE, L_APPRAISE_DATE, VC_BOND_APPRAISE,"
	        				+ " VC_BOND_APPRAISE_ORGAN from isp.BOND_APPRAISE_HIS_WIND where l_appraise_date > to_char(add_months(sysdate,-6),'yyyymmdd')  order by rownum  asc) where rm > "+lastrow);
	        		list_bond_wind = JDBCUtil.executeQueryWithRownum(conn_qjy, sql_qjy.toString(), null);
	        		lastrow += onerun;
	        		if(!list_bond_wind.isEmpty() && list_bond_wind.size() > 0){
		        		for (int i = 0; i < list_bond_wind.size(); i++) {
		        			DataObject bondappraise = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsBondAppraise");
		                    Map<String, String> map = list_bond_wind.get(i);
		                    bondappraise.setInt("lAppraiseDate", Integer.parseInt(map.get("L_APPRAISE_DATE")));
		                    bondappraise.setString("vcInterCode", map.get("VC_INTER_CODE"));
		                    bondappraise.setString("vcBondAppraise", map.get("VC_BOND_APPRAISE"));
		                    bondappraise.setString("vcBondAppraiseOrgan", map.get("VC_BOND_APPRAISE_ORGAN"));
		                    bondappraise.setString("cSource", "4");
		                    listbonds.add(bondappraise);
		                    bondappraise = null;
		                    if(listbonds.size() == 10000){
		                    	DataObject dataobjects[] = new DataObject[listbonds.size()];
		                    	listbonds.toArray(dataobjects);
		                    	DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, dataobjects);
		                    	SynCommonUtil.insertMsg("0", "插入历史评级完成", dataobjects.length, "插入历史评级", "将wind的历史评级插入ATS历史评级表");
		                    	listbonds = null;
		                    	listbonds = new ArrayList<DataObject>();
		                    	dataobjects = null;
		                    }
		        		}
		        	}
	        	}
	        	System.out.println("O32时间:"+new Date());
	        	//获取O32历史评级
	        	sql_qjy.setLength(0);
	        	sql_qjy.append(" select count(1) as count from isp.Bond_Appraise_His_O32");
				list_bond_O32 = JDBCUtil.queryWithConn(conn_qjy, sql_qjy.toString(), null);
				lastrow = 0;
				datanum = Integer.parseInt(list_bond_O32.get(0).get("COUNT"));
				runnum = datanum%onerun==0?(datanum/onerun):(datanum/onerun)+1;
				for(int r =0;r<runnum;r++){
	        		sql_qjy.setLength(0);
	        		sql_qjy.append(" select VC_INTER_CODE, L_APPRAISE_DATE, VC_BOND_APPRAISE, VC_BOND_APPRAISE_ORGAN from "
	        				+ "(select rownum rm,VC_INTER_CODE, L_APPRAISE_DATE, VC_BOND_APPRAISE,"
	        				+ " VC_BOND_APPRAISE_ORGAN from isp.Bond_Appraise_His_O32 where l_appraise_date > to_char(add_months(sysdate,-6),'yyyymmdd') order by rownum  asc) where rm > "+lastrow);
	        		list_bond_O32 = JDBCUtil.executeQueryWithRownum(conn_qjy, sql_qjy.toString(), null);
	        		lastrow += onerun;
	        		if(!list_bond_O32.isEmpty() && list_bond_O32.size() > 0){
		        		for (int i = 0; i < list_bond_O32.size(); i++) {
		        			DataObject bondappraise = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsBondAppraise");
		                    Map<String, String> map = list_bond_O32.get(i);
		                    bondappraise.setInt("lAppraiseDate", Integer.parseInt(map.get("L_APPRAISE_DATE")));
		                    bondappraise.setString("vcInterCode", map.get("VC_INTER_CODE"));
		                    bondappraise.setString("vcBondAppraise", map.get("VC_BOND_APPRAISE"));
		                    bondappraise.setString("vcBondAppraiseOrgan", map.get("VC_BOND_APPRAISE_ORGAN"));
		                    bondappraise.setString("cSource", "3");
		                    listbonds.add(bondappraise);
		                    bondappraise = null;
		                    if(listbonds.size() == 10000){
		                    	DataObject dataobjects[] = new DataObject[listbonds.size()];
		                    	listbonds.toArray(dataobjects);
		                    	DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, dataobjects);
		                    	SynCommonUtil.insertMsg("0", "插入历史评级完成", dataobjects.length, "插入历史评级", "将O32的历史评级插入ATS历史评级表");
		                    	listbonds = null;
		                    	listbonds = new ArrayList<DataObject>();
		                    	dataobjects = null;
		                    }
		        		}
		        	}
	        	}
				DataObject dataobjects[] = new DataObject[listbonds.size()];
	        	listbonds.toArray(dataobjects);
	            DatabaseUtil.insertEntityBatch(JDBCUtil.DATA_SOURCE_DEFAULT, dataobjects);
	            SynCommonUtil.insertMsg("0", "插入历史评级完成", dataobjects.length, "插入历史评级", "将O32和wind的历史评级插入ATS历史评级表");
	            listbonds = null;
	            dataobjects = null;
				isSuccess = true;
			} catch (Exception e) {
				isSuccess = false;
				e.printStackTrace();
				 SynCommonUtil.insertMsg("1", e.getMessage(), 0, "插入历史评级", "插入O32和Wind历史评级");
	            LogUtil.logError("[getBondAppraise]"+"函数执行失败,插入Wind和O32历史评级出错!", e, new Object[]{});
			}finally{
				JDBCUtil.releaseResource(conn_qjy, null, null);
			}
	        System.out.println("结束时间:"+new Date());
		 return isSuccess;
	 }

}
