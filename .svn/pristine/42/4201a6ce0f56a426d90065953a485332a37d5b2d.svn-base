package com.cjhxfund.ats.fm.baseinfo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.LogUtil;
import com.primeton.ext.engine.component.LogicComponentFactory;


/**
 * @author 徐福羊
 * @date 2016-08-27 10:40:10
 * 
 */
@Bizlet("")
public class synStockIssueData {
	
	private static List<String> err_stockTypes = Arrays.asList("S","SE","SF","41F","41E");  //定义特殊处理的债券类型：格式:债券类型+杂项分类
    @Bizlet("")
    public boolean synStockIssueInfo() {
        boolean isSuccess = false;
        System.out.println("[synStockIssueInfo]"+"开始基础数据日初同步...");
        isSuccess = SynCommonUtil.synControl();
        if(isSuccess){
	        System.out.println("[synStockIssueInfo]"+"开始定时器日初同步任务...");
	        LogUtil.logInfo("[synStockIssueInfo]"+"开始定时器日初同步任务...", null, new Object[]{});
	        SynCommonUtil.insertMsg("2", "开始基础数据日初同步", 0, "日初同步", "同步O32和Wind基础数据");
	        try {
	        	Long beforeTime=(new Date()).getTime();
	        	
		    	String componentName = "com.cjhxfund.ats.fm.baseinfo.synBondInfoData";/*逻辑构建名称*/
		        String operationName = "synAutomatic";/*逻辑流名称*/
		        ILogicComponent comp = LogicComponentFactory.create(componentName);
		        Object[] params = new Object[]{};
				Object[] result = (Object[])comp.invoke(operationName, params);
				if("true".equals(result[0].toString())){
					SynCommonUtil.insertMsg("0", "基础数据日初同步成功", 0, "日初同步", "同步O32和Wind基础数据");
				}else{
					SynCommonUtil.insertMsg("1", "基础数据日初同步失败，步骤为："+result[1], 0, "日初同步", "同步O32和Wind基础数据");
				}
				
				Long afterTime=(new Date()).getTime();
				String className=Thread.currentThread().getStackTrace()[1].getClassName();
				String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
				QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
				
			} catch (Throwable e) {
				e.printStackTrace();
				SynCommonUtil.insertMsg("1", e.getMessage(), 0, "日初同步", "同步O32和Wind基础数据");
			}
	        SynCommonUtil.insertMsg("2", "结束基础数据日初同步", 0, "日初同步", "同步O32和Wind基础数据");
	        LogUtil.logInfo("[synStockIssueInfo]"+"结束定时器日初同步任务...", null, new Object[]{});
	        System.out.println("[synStockIssueInfo]"+"结束定时器日初同步任务...");
	        mergestock();	//发起自动去重任务
        }else{
        	System.out.println("[synStockIssueInfo]"+"当前配置为手工操作，定时器不做任何操作...");
        	SynCommonUtil.insertMsg("2", "当前配置为手工操作，定时器不做任何操作", 0, "日初同步", "同步O32和Wind基础数据");
        	LogUtil.logInfo("[synStockIssueInfo]"+"当前配置为手工操作，定时器不做任何操作。。。。", null, new Object[]{});
        }
        System.out.println("[synStockIssueInfo]"+"结束基础数据日初同步...");
        return isSuccess;
    }
    /**
     * @author 章璐
     * @date 2017-01-19 15:00:10
     * 日初归集后自动发起去重
     */
    @Bizlet("")
    public boolean mergestock() {
        boolean isSuccess = false;
	        System.out.println("[synStockIssueInfo]"+"日初始化归集后自动去重任务...");
	        LogUtil.logInfo("[synStockIssueInfo]"+"日初始化归集后自动去重任务...", null, new Object[]{});
	        SynCommonUtil.insertMsg("2", "日初自动去重", 0, "日初自动去重", "日初归集后自动发起去重任务开始...");
	        try {
		    	String componentName = "com.cjhxfund.ats.fm.baseinfo.synBondInfoData";/*逻辑构建名称*/
		        String operationName = "mergeAutomatic";/*逻辑流名称*/
		        ILogicComponent comp = LogicComponentFactory.create(componentName);
		        Object[] params = new Object[]{};
				Object[] result = (Object[])comp.invoke(operationName, params);
				if("true".equals(result[0].toString())){
					isSuccess = true;
					SynCommonUtil.insertMsg("0", "日初自动去重", 0, "日初自动去重", "日初归集后自动发起去重任务成功。。。");
				}else{
					SynCommonUtil.insertMsg("1", "日初自动去重", 0, "日初自动去重", "日初归集后自动发起去重任务失败。。。");
				}
			} catch (Throwable e) {
				e.printStackTrace();
				SynCommonUtil.insertMsg("1", e.getMessage(), 0, "日初自动去重", "日初归集后自动发起去重任务失败。。。");
			}
	        System.out.println("[synStockIssueInfo]"+"日初始化归集后自动去重任务...");
	        LogUtil.logInfo("[synStockIssueInfo]"+"日初始化归集后自动去重任务...", null, new Object[]{});
	        SynCommonUtil.insertMsg("2", "日初自动去重", 0, "日初自动去重", "日初归集后自动发起去重任务结束...");
        return isSuccess;
    }
    @Bizlet("")
    public static boolean callO32DataPrc() {
    	SynCommonUtil.insertMsg("2", "开始归集O32数据", 0, "归集O32数据", "开始归集O32数据");
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[callO32DataPrc]"+"开始执行存储过程callO32DataPrc..");
        LogUtil.logInfo("[callO32DataPrc]"+"开始执行存储过程callO32DataPrc..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call sp_sync_O32_stock_data(?,?)}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.registerOutParameter(1, Types.INTEGER);
                cStmt_qjy.registerOutParameter(2, Types.INTEGER);
                cStmt_qjy.executeUpdate();
                int l_success = -1;
                isSuccess = true;
                l_success = cStmt_qjy.getInt(1);
                if (l_success != 0){
                    isSuccess = false;
                    execute = false;
                    LogUtil.logError("[callO32DataPrc]"+"函数执行失败,将O32接口表数据同步到正式表出错!", null, new Object[]{});
                }
                LogUtil.logError("[callO32DataPrc]"+"函数执行成功,将O32接口表数据同步到正式表成功!", null, new Object[]{});
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[callO32DataPrc]"+"函数执行成功,将O32接口表数据同步到正式表出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        LogUtil.logInfo("[callO32DataPrc]"+"结束执行存储过程callO32DataPrc..", null, new Object[]{});
        System.out.println("[callO32DataPrc]"+"结束执行存储过程callO32DataPrc..");
        SynCommonUtil.insertMsg("2", "结束归集O32数据", 0, "归集O32数据", "结束归集O32数据");
        return isSuccess;
    }
    
    @Bizlet("")
    public static boolean callWindDataPrc() {
    	SynCommonUtil.insertMsg("2", "开始归集Wind数据", 0, "归集Wind数据", "开始归集Wind数据");
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[callWindDataPrc]"+"开始执行存储过程callWindDataPrc..");
        LogUtil.logInfo("[callWindDataPrc]"+"开始执行存储过程callWindDataPrc..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call sp_sync_Wind_stock_data(?,?)}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.registerOutParameter(1, Types.INTEGER);
                cStmt_qjy.registerOutParameter(2, Types.INTEGER);
                cStmt_qjy.executeUpdate();
                int l_success = -1;
                isSuccess = true;
                l_success = cStmt_qjy.getInt(1);
                if (l_success != 0){
                    isSuccess = false;
                    execute = false;
                    LogUtil.logError("[callWindDataPrc]"+"函数执行失败,将Wind正式表O32格式数据同步到正式表出错!", null, new Object[]{});
                }
                LogUtil.logError("[callO32DataPrc]"+"函数执行成功,将Wind正式表O32格式数据同步到正式表成功!", null, new Object[]{});
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[callWindDataPrc]"+"函数执行失败,将Wind正式表O32格式数据同步到正式表出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        LogUtil.logInfo("[callWindDataPrc]"+"结束执行存储过程callWindDataPrc..", null, new Object[]{});
        System.out.println("[callWindDataPrc]"+"结束执行存储过程callWindDataPrc..");
        SynCommonUtil.insertMsg("2", "开始归集Wind数据", 0, "归集Wind数据", "开始归集Wind数据");
        return isSuccess;
    }
    
    @Bizlet("")
    public static boolean callWindDataCheckPrc() {
    	SynCommonUtil.insertMsg("2", "开始校验Wind数据", 0, "校验Wind数据", "开始校验Wind数据");
        boolean execute = true;
        boolean isSuccess = false;
        Connection conn_qjy = null;
        CallableStatement cStmt_qjy = null;
        System.out.println("[sp_sync_stock_wind_O32]"+"开始执行存储过程sp_sync_stock_wind_O32..");
        LogUtil.logInfo("[sp_sync_stock_wind_O32]"+"开始执行存储过程sp_sync_stock_wind_O32..", null, new Object[]{});
        while (execute) {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            try {
                String procedure = "{call sp_sync_stock_wind_O32()}";
                cStmt_qjy = conn_qjy.prepareCall(procedure);
                cStmt_qjy.executeUpdate();
                isSuccess = true;
                LogUtil.logError("[sp_sync_stock_wind_O32]"+"函数执行成功,校验Wind数据成功!", null, new Object[]{});
            } catch (Exception e) {
                e.printStackTrace();
                LogUtil.logError("[sp_sync_stock_wind_O32]"+"函数执行失败,校验Wind数据出错!", e, new Object[]{});
            }
            finally {
                JDBCUtil.releaseResource(conn_qjy, cStmt_qjy, null);
            }
            execute = false;
        }
        LogUtil.logInfo("[sp_sync_stock_wind_O32]"+"结束执行存储过程sp_sync_stock_wind_O32..", null, new Object[]{});
        System.out.println("[sp_sync_stock_wind_O32]"+"结束执行存储过程sp_sync_stock_wind_O32..");
        SynCommonUtil.insertMsg("2", "开始校验Wind数据", 0, "校验Wind数据", "开始校验Wind数据");
        return isSuccess;
    }
    
    public static String getMapType(Connection c_qjy,String StockType,String mixedtype,String stockname) {
    	String stocktype_ats = "";
    	StringBuffer s_qjy = new StringBuffer();
    	List<Map<String, String>> list_stocktype_ats = new ArrayList<Map<String, String>>();
    	try {
    		if(stockname != null && stockname != ""){
    			if(stockname.contains("ABN")){
    				return "M3";
    			}
    		}
        	if(StockType != null && StockType != ""){ //O32新债类型转ats
        		if(mixedtype != null && mixedtype != ""){
	        		if(err_stockTypes.contains(StockType+mixedtype)){	//特殊处理的债券类型,直接返回0
	            		return "0";
	            	}
        		}else{
        			if(err_stockTypes.contains(StockType)){	//特殊处理的债券类型,直接返回0
	            		return "0";
	            	}
        		}
        		s_qjy.append("select t.vc_stock_type from t_ats_stock_type_map t where 1=1 and t.c_status = '0'")
        		.append(" and t.vc_stock_type_id = '"+StockType+"'");
        		list_stocktype_ats = JDBCUtil.queryWithConn(c_qjy, s_qjy.toString(), null);
        		if(list_stocktype_ats.size()==1){
        			stocktype_ats = list_stocktype_ats.get(0).get("VC_STOCK_TYPE");	//当用vc_stock_type只查道一个映射关系直接返回
        			return stocktype_ats;
        		}else if(mixedtype != null && mixedtype != ""){ 			//否则加上杂项分类去查
	        			for(int i=0;i<mixedtype.length();i++){
	        				s_qjy.append(" and instr(t.vc_stock_type_dtl,'"+mixedtype.charAt(i)+"') >0 and length(t.vc_stock_type_dtl) = '"+mixedtype.length()+"'"); //杂项分类匹配，与顺序无关	
	        			}
                }
                list_stocktype_ats = JDBCUtil.queryWithConn(c_qjy, s_qjy.toString(), null);
                if(list_stocktype_ats.size() != 0){										//加上杂项分类查到了
                	stocktype_ats = list_stocktype_ats.get(0).get("VC_STOCK_TYPE");
                }else{																		//杂项分类少的话看能不能匹配到多的项
                	s_qjy.setLength(0);
                	s_qjy.append("select t.vc_stock_type from t_ats_stock_type_map t where 1=1 and t.c_status = '0'")
            		.append(" and t.vc_stock_type_id = '"+StockType+"'");
                	for(int i=0;i<mixedtype.length();i++){
        				s_qjy.append(" and instr(t.vc_stock_type_dtl,'"+mixedtype.charAt(i)+"') >0 "); //杂项分类匹配，与顺序无关	
        			}
                	list_stocktype_ats = JDBCUtil.queryWithConn(c_qjy, s_qjy.toString(), null);
                	if(list_stocktype_ats.size() != 0){
                		stocktype_ats = list_stocktype_ats.get(0).get("VC_STOCK_TYPE");
                	}else{
                		stocktype_ats = "0";
                	}
                }
        	}else{
        		stocktype_ats = "0";//其他类型
        	}
        	s_qjy.setLength(0);
		} catch (Exception e) {
            e.printStackTrace();
            LogUtil.logError("O32类型转ats失败!", e, new Object[]{});
		}
    	return stocktype_ats;
    }
    
    @Bizlet("")
	public static boolean stockTypeMap(){
    	SynCommonUtil.insertMsg("2", "开始O32债券类型转换", 0, "转换O32债券类型格式", "开始O32债券类型转换");
        boolean isSuccess = true;
        StringBuffer sql = new StringBuffer();
        Connection conn_qjy = null;
        System.out.println("[stockTypeMap]"+"开始执行函数stockTypeMap..");
        LogUtil.logInfo("[stockTypeMap]"+"开始执行函数stockTypeMap..", null, new Object[]{});
        List<Map<String, String>> list_O32 = new ArrayList<Map<String, String>>();
        //1.查询O32新增接口表数据
        try {
        	conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
        	sql.setLength(0);
        	sql.append(" select vc_inter_code,vc_mixed_type,vc_stock_type_o32,vc_stock_name from t_ats_intf_stock_issue_info");
        	list_O32 = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
        	for (int i = 0; i < list_O32.size(); i++) {
        		String stocktype_ats = getMapType(conn_qjy,list_O32.get(i).get("VC_STOCK_TYPE_O32"),list_O32.get(i).get("VC_MIXED_TYPE"),list_O32.get(i).get("VC_STOCK_NAME"));
        		sql.setLength(0);
            	sql.append(" update t_ats_intf_stock_issue_info t set t.vc_stock_type = '"+stocktype_ats+"' where t.vc_inter_code = '"+list_O32.get(i).get("VC_INTER_CODE")+"'");
        		JDBCUtil.update(sql.toString());
        	}
		} catch (Exception e) {
			isSuccess = false;
			e.printStackTrace();
			SynCommonUtil.insertMsg("1", e.getMessage(), 0, "转换O32债券类型格式", "转换O32债券类型格式");
            LogUtil.logError("[stockTypeMap]"+"函数执行失败,转换O32债券类型格式报错！ ", e, new Object[]{});
		}finally{
			sql.setLength(0);
			sql = null;
			JDBCUtil.releaseResource(conn_qjy, null, null);
		}
	        SynCommonUtil.insertMsg("2", "结束O32债券类型转换", 0, "转换O32债券类型格式", "结束O32债券类型转换");
	        LogUtil.logInfo("[stockTypeMap]"+"结束执行函数stockTypeMap..", null, new Object[]{});
	        System.out.println("[stockTypeMap]"+"结束执行函数stockTypeMap..");
	        return isSuccess;
	} 
    
   
}
