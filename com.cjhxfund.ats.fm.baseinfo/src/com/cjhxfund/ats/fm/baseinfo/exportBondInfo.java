package com.cjhxfund.ats.fm.baseinfo;

import java.io.File;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;

import com.cjhxfund.ats.fm.commonUtil.Constan;
import com.cjhxfund.ats.fm.commonUtil.DateUtil;
import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.QrtzUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.common.io.FileUtil;
import com.eos.foundation.eoscommon.CacheUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 徐福羊
 * @date 2016-09-05 17:15:23
 * 
 */
@Bizlet("")
public class exportBondInfo {
    
    private static boolean isRun = true;
    
    /*关闭导出任务时需要保证指定路径下的文件已被删除,否则会影响O32系统(转换机一直在刷新共享内存)*/
    private static boolean isExportFileExistRun = true;
    
    /**
     * 启动定时任务
     * 
     * @param
     *
     * @return
     */
    @Bizlet("")
    public void startExportServer() {
        isRun = true;
        exportMain();
    }
    /**
     * 在O32数据源中查询指定转换机任务的上一执行完成时间
     * 
     * @param
     *
     * @return 是否关闭成功
     */
    @Bizlet("")
    public boolean closeExportServer() {
        isRun = false;
        isExportFileExistRun = true;
        return true;
    }
    @Bizlet("")
    public static void exportMain() {
        boolean flag = false;
        String sLastExecTime = "0";
        boolean isFileExist = false;
        String key = "";
        StringBuffer filePath = new StringBuffer("");
        StringBuffer fileName = new StringBuffer("");
        StringBuffer sCreateTime = new StringBuffer("0");
        
        System.out.println("[exportMain]开始导出新债数据到O32...");
        if (exportBondInfo.isRun || exportBondInfo.isExportFileExistRun) {
            flag = checkRunTime();
            if (flag == false) return;
            try {
                /* 01.判断O32转换机路径中是否存在指定的文件名 */
                LogUtil.logInfo("[exportMain]开始判断O32转换机路径下是否存在文件...", null, new Object[]{});
                key = "ATS_CJ_ZQFXXX_URL";
                getFilePathName(key, filePath, fileName);
                isFileExist = isFileExist(filePath.toString(), fileName.toString(), sCreateTime);
                LogUtil.logInfo("[exportMain]结束判断O32转换机路径下是否存在文件...isFileExist["+isFileExist+"],sCreateTime["+sCreateTime+"]",null,new Object[]{});

                /* 02.判断O32转换机路径中是否存在指定的文件名 */
                if (isFileExist) {
                    /* 02.01.存在指定的文件,查询O32转换机任务的最后执行时间 */
                    LogUtil.logInfo("[exportMain]开始获取O32指定转换机任务的最后执行时间...", null, new Object[]{});
                    sLastExecTime = getLastExecTimeFromHs();
                    if (sLastExecTime == null || sLastExecTime == "0") {
                        flag = false;
                        return;
                    }
                    LogUtil.logInfo("[exportMain]结束获取O32指定转换机任务的最后执行时间...sLastExecTime["+sLastExecTime+"]", null, new Object[]{});
                    /* 文件创建时间<O32最后执行时间,说明O32转换机已对该文件进行处理,则删除指定目录下的文件*/
                    if (Integer.parseInt(sCreateTime.toString()) < Integer.parseInt(sLastExecTime)) {
                        LogUtil.logInfo("[exportMain]开始删除O32转换机路径下的文件...", null, new Object[]{});
                        flag = deleteFileList(filePath.toString());
                        if (flag == false) return;
                        /*关闭导出任务时,若指定路径下的文件存在且已被删除,则不进行后续的导出文件操作,程序直接退出*/
                        if (exportBondInfo.isRun==false) {
                            exportBondInfo.isExportFileExistRun = false;
                            LogUtil.logInfo("[exportMain]文件存在且已被删除,允许程序退出...", null, new Object[]{});
                            return;
                        }
                        LogUtil.logInfo("[exportMain]结束删除O32转换机路径下的文件...", null, new Object[]{});
                        LogUtil.logInfo("[exportMain]开始导出ATS新债数据到O32转换机指定路径...", null, new Object[]{});
                        doAtsExportData();
                        LogUtil.logInfo("[exportMain]结束导出ATS新债数据到O32转换机指定路径...", null, new Object[]{});
                        if (flag == false) return;
                    }
                    else {
                        flag = true;
                        if (exportBondInfo.isRun==false) {
                            exportBondInfo.isExportFileExistRun = true;
                            LogUtil.logInfo("[exportMain]文件存在且未被删除,不允许程序退出...", null, new Object[]{});
                        }
                    }
                } else {
                    /* 02.02.不存在指定的文件,则先判断是否存在需要导出的新债数据,然后将数据写入到Excel文件,最后将Temp表的新债数据删除 */
                    if (exportBondInfo.isRun==false) {
                        exportBondInfo.isExportFileExistRun = false;
                        LogUtil.logInfo("[exportMain]文件不存在,允许程序退出...", null, new Object[]{});
                        return;
                    }
                    /*关闭导出任务时,若指定路径下的文件存在且已被删除或文件不存在,则不进行后续的导出文件操作,程序直接退出*/
                    LogUtil.logInfo("[exportMain]开始导出ATS新债数据到O32转换机指定路径...", null, new Object[]{});
                    doAtsExportData();
                    LogUtil.logInfo("[exportMain]结束导出ATS新债数据到O32转换机指定路径...", null, new Object[]{});
                    if (flag == false) return;
                }
            } catch (Exception e) {
                flag = false;
                e.printStackTrace();
                return;
            }
        }
        System.out.println("[exportMain]结束导出新债数据到O32...");
    }
    /**
     * 在O32数据源中查询指定转换机任务的上一执行完成时间
     * 
     * @param
     *
     * @return 指定转换机任务的上一执行完成时间
     */
    public static String getLastExecTimeFromHs() {
        boolean execute = true;
        String sLastExecTime = "0";
        String sLastExecDate = "0";
        Connection conn_O32 = null;
        StringBuffer sql_O32 = new StringBuffer();
        System.out.println("[getLastExecTimeFromHs]开始获取指定转换机任务的最后执行时间...");
        while (execute) {
            try {
                conn_O32 = JDBCUtil.getConnByDataSourceId(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName());
                sql_O32.setLength(0);
                sql_O32.append("select to_char(nvl(a.l_lastexec_date,0)) sLastExecDate from trade.tconvertset a where a.vc_remarks = 'CJ证券发行信息导入'");
                sLastExecDate = JDBCUtil.getValueBySql(conn_O32, sql_O32.toString());
                String nowDate = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
                if (sLastExecDate == null || sLastExecDate == "0" || Integer.parseInt(nowDate)>Integer.parseInt(sLastExecDate)) {
                    sLastExecTime = "0";
                }
                else {
                    sql_O32.setLength(0);
                    sql_O32.append("select to_char(nvl(a.l_lastexec_time,0)) sLastExecTime from trade.tconvertset a where a.vc_remarks = 'CJ证券发行信息导入'");
                    sLastExecTime = JDBCUtil.getValueBySql(conn_O32, sql_O32.toString());
                    if (sLastExecTime == null || sLastExecTime == "0") {
                        sLastExecTime = "0";
                    }
                }
                execute = false;
            } catch (Exception e) {
                sLastExecTime = "0";
                execute = false;
                e.printStackTrace();
            } finally {
                sql_O32.setLength(0);
                sql_O32 = null;
                execute = false;
                JDBCUtil.releaseResource(conn_O32, null, null);
            }
        }
        System.out.println("[getLastExecTimeFromHs]结束获取指定转换机任务的最后执行时间...sLastExecTime["+sLastExecTime+"]");
        return sLastExecTime;
    }
    /**
     * 将需要导出的新债数据写入到Excel文件中,并删除已导出的数据
     * 
     * @param
     *
     * @return 是否成功导出新债数据
     */
    @Bizlet("")
    public static int doAtsExportData() {
        int iCount = 0;
        int errType = 0;
        boolean flag = false;
        Connection conn_qjy = null;
        StringBuffer sql_qjy = new StringBuffer();
        String[] illegalRunTimes={"112500-130500","165500-180500"};
    	flag = checkRunTime(illegalRunTimes);
    	if(flag == false){
    		errType = 5;
    		return errType;
    	}
        /*01.查询是否存在需要导出的新债数据*/
        System.out.println("[doAtsExportData]开始查询是否存在需要导出的新债数据...");
        try {
        	conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            sql_qjy.setLength(0);
            sql_qjy.append("select count(1) l_count from t_ats_stock_issue_info_temp tmp,t_ats_stock_issue_info ts  where tmp.c_status = '2' and tmp.l_stock_issue_id = ts.l_stock_issue_id");
            iCount = Integer.parseInt(JDBCUtil.getValueBySql(conn_qjy, sql_qjy.toString()));
            if(iCount>0){
            	//将债权信息导出状态由2改为4
            	sql_qjy.setLength(0);
            	sql_qjy.append("update t_ats_stock_issue_info_temp set c_status = '4' where c_status = '2'");
                flag = doExecSqlByAts(sql_qjy);
                //并删除共享文件夹下的Excel文件
                String key = "ATS_CJ_ZQFXXX_URL";
                StringBuffer filePath = new StringBuffer("");
                StringBuffer fileName = new StringBuffer("");
                StringBuffer sCreateTime = new StringBuffer("0");
                getFilePathName(key, filePath, fileName);
                boolean isFileExist = isFileExist(filePath.toString(), fileName.toString(), sCreateTime);
                if(isFileExist){
	                flag = deleteFileList(filePath.toString());
	                if(flag){
	                	System.out.println("共享目录文件删除成功。。。。。");
	                }else{
	                	System.out.println("共享目录文件删除失败。。。。。");
	                }
                }
            }
            iCount = 0;
            sql_qjy.setLength(0);
            sql_qjy.append("select count(1) l_count from t_ats_stock_issue_info_temp where c_status = '4'");
            iCount = Integer.parseInt(JDBCUtil.getValueBySql(conn_qjy, sql_qjy.toString()));
            flag = true;
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            LogUtil.logError("[doAtsExportData]" + "函数执行失败,清空表数据出错!", e, new Object[] {});
        } finally {
            sql_qjy.setLength(0);
            JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        System.out.println("[doAtsExportData]结束查询是否存在需要导出的新债数据...iCount["+iCount+"]");
        
        /*02.将待导出的的新债数据写入到指定的网络共享盘(10.8.1.19)*/
        try {
            /* A.存在需要导出的新债数据 */
            if (iCount > 0) {
                System.out.println("[doAtsExportData]开始将待导出的数据状态置为正在导出...");
                /*sql_qjy.setLength(0);
                sql_qjy.append("update t_ats_stock_issue_info_temp set c_status = '4' where c_status = '1'");
                flag = doExecSqlByAts(sql_qjy);*/
                //将发行主体临时表的数据状态置为正在导出。。。。
                sql_qjy.setLength(0);
                sql_qjy.append("update t_ats_issuer_info_temp set c_status = '2' where c_status = '1'");
                flag = doExecSqlByAts(sql_qjy);
                
                System.out.println("[doAtsExportData]结束将待导出的数据状态置为正在导出...flag["+flag+"]");
                if (flag == false) {
                	errType = 3;
                	return errType;
                }
                System.out.println("[doAtsExportData]开始导出新债数据...");
                try {
                    String componentName = "com.cjhxfund.ats.fm.baseinfo.DebtIssueManager";/*逻辑构建名称*/
                    String operationName = "exportO32Excel";/*逻辑流名称*/
                    ILogicComponent comp = LogicComponentFactory.create(componentName);
                    String ids = null;
                    Object[] params = new Object[]{ids};
                    Object[] result = (Object[])comp.invoke(operationName,params);
                    System.out.print(result);
                    flag = (Boolean)result[0];
                    SynCommonUtil.insertMsg("0", "无", iCount, "导出新债信息", "将新债信息导出到转换机目录");
                } catch (Exception e) {
                    flag = false;
                    System.out.print(e);
                    e.printStackTrace();
                    SynCommonUtil.insertMsg("1", e.getMessage(), 0, "导出新债信息", "将新债信息导出到转换机目录");
                    LogUtil.logError("[doAtsExportData]"+"文件导出失败!", null, new Object[]{});
                } catch(Throwable e) {
                    flag = false;
                    e.printStackTrace();
                    LogUtil.logError("[doAtsExportData]"+"文件导出失败!", null, new Object[]{});
                }
                System.out.println("[doAtsExportData]结束导出新债数据...flag["+flag+"]");
                if (flag == false) {
                	errType = 3;
                	return errType;
                }
            }
            /* B.不存在需要导出的新债数据 */
            else {
                System.out.println("[doAtsExportData]无需要导出新债数据,程序直接返回...");
                flag = true;
                errType = 4;
            	return errType;
            }
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
        }
        /*03.存在需要导出的新债数据,导出成功删除temp，导出失败还原状态*/
       /* System.out.println("[doAtsExportData]开始删除Temp表的数据...");
        sql_qjy.setLength(0);
        sql_qjy.append("delete from t_ats_stock_issue_info_temp where c_status = '2'");
        flag = doExecSqlByAts(sql_qjy);*/
        //checkIsHaveBond();
        sql_qjy.setLength(0);
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sql_qjy.append("update t_ats_stock_issue_info_temp set c_status = '2',d_export_time = to_date('"+sim.format(new Date())+"','yyyy-mm-dd hh24:mi:ss')  where c_status = '4'");
        flag = doExecSqlByAts(sql_qjy);
        //将发行主体临时表正在导出的数据删除
        
        sql_qjy.setLength(0);
        sql_qjy.append("delete from t_ats_issuer_info_temp where c_status = '2'");
        flag = doExecSqlByAts(sql_qjy);
        
        System.out.println("[doAtsExportData]成功导出Temp表的数据...flag["+flag+"]");
        errType = 0;
    	return errType;
    }
    /**
     * 在default数据源中执行指定的Sql语句
     * 
     * @param sql
     *          待执行的Sql语句
     * @return Sql语句是否执行成功
     */
    public static boolean doExecSqlByAts(StringBuffer sql) {
        boolean flag = false;
        Connection conn_qjy = null;
        List<String> sqls = new ArrayList<String>();
        System.out.println("[doExecSqlByAts]开始执行sql语句...");
        try {
            conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
            sqls.add(sql.toString());
            JDBCUtil.executeUpdateBatchWithConn(conn_qjy, sqls);
            flag = true;
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
            LogUtil.logError("[doExecSqlByAts]" + "函数执行失败!", e, new Object[] {});
        } finally {
            sqls.clear();
            sql.setLength(0);
            JDBCUtil.releaseResource(conn_qjy, null, null);
        }
        System.out.println("[doExecSqlByAts]结束执行sql语句...flag["+flag+"]");
        return flag;
    }
    /**
     * 判断指定路径上的文件名是否存在
     * 
     * @param filePath
     *          文件在服务器中存储的路径
     * @param fileName
     *          要判断是否存在的文件名称
     * @param sCreateTime
     *          返回该文件的最后修改时间
     * @return 是否存在该文件,该文件的最后修改时间
     */
    public static boolean isFileExist(String filePath, String fileName, StringBuffer sCreateTime) {
        boolean result = false;
        sCreateTime.delete(0, sCreateTime.length());
        System.out.println("[isFileExist]开始判断路径["+filePath+fileName+"]是否存在...");
        if (filePath == null || filePath.length() == 0 || fileName == null || fileName.length() == 0) {
            result = false;
            sCreateTime.append("0");
            return result;
        }
        File file_path = new File(filePath.replace("\\", "/"));
        if (file_path.exists()==false || file_path.isDirectory()==false) {
            result = false;
            sCreateTime.append("0");
            return result;
        }
        File file_name = new File(filePath.replace("\\", "/") + File.separator + fileName);
        if (file_name.exists()==false || file_name.isFile()==false) {
            result = false;
            sCreateTime.append("0");
            return result;
        }
        Calendar cal = Calendar.getInstance();
        long time = file_name.lastModified();
        cal.setTimeInMillis(time);
        SimpleDateFormat df = new SimpleDateFormat("HHmmss");
        sCreateTime.append(Integer.toString(Integer.parseInt(df.format(cal.getTime()))));
        System.out.println("[isFileExist]结束判断路径["+filePath+fileName+"]是否存在...[存在]");
        result = true;
        return result;
    }
    /**
     * 删除指定目录下的所有文件(不含子目录)
     * 
     * @param filePath
     *         文件在服务器中存储的路径
     * @return 指定路径下的所有文件是否删除成功
     */
    public static boolean deleteFileList(String filePath) {
        boolean result = false;
        System.out.println("[deleteFileList]开始删除路径["+filePath+"]下的所有文件...");
        if (filePath == null || filePath.length() == 0) {
            result = false;
            return result;
        }
        File file_list = new File(filePath.replace("\\", "/"));
        if (file_list.exists()==false || file_list.isDirectory()==false) {
            result = false;
            return result;
        }
        File[] file_lists = file_list.listFiles();
        for (int i=0; i<file_lists.length; i++) {
            if (file_lists[i].isFile()) {
                result = deleteFile(filePath, file_lists[i].getName());
                if (result==false) return result;
            }
        }
        System.out.println("[deleteFileList]结束删除路径["+filePath+"]下的所有文件...");
        return result;
    }
    /**
     * 删除指定目录下指定的文件,并备份该文件
     * 
     * @param filePath
     *          文件在服务器中存储的路径
     * @param fileName
     *          要被删除的文件名称
     * @return 该文件删除成功
     */
    public static boolean deleteFile(String filePath, String fileName) {
        boolean result = false;
        String filePathBak = "";
        String fileNameBak = "";
        File file_path_bak = null;
        File file_name_bak = null;
        System.out.println("[deleteFile]开始删除文件["+filePath+fileName+"]...");
        if (filePath == null || filePath.length() == 0 || fileName == null || fileName.length() == 0) {
            result = false;
            return result;
        }
        File file_path = new File(filePath.replace("\\", "/"));
        if (file_path.exists()==false || file_path.isDirectory()==false) {
            result = false;
            return result;
        }
        File file_name = new File(filePath.replace("\\", "/") + File.separator + fileName);
        if (file_name.exists()==false || file_name.isFile()==false) {
            result = false;
            return result;
        }
        System.out.println("[deleteFile]开始备份路径["+filePath+fileName+"]...");
        try {
            filePathBak = filePath + "bak" + File.separator;
            if (filePathBak.length() == 0) {
                result = false;
                return result;
            }
            file_path_bak = new File(filePathBak.replace("\\", "/"));
            if (file_path_bak.exists()==false) {
                FileUtil.mkDir(file_path_bak.getPath());
            }
            String[] token = fileName.split("\\.");
            String replaceFileName = DateUtil.currentDateString("HHmmss");
            fileNameBak = filePathBak + token[0] + "_" + replaceFileName + "." + token[1];
            file_name_bak = new File(fileNameBak.replace("\\", "/"));
            if (file_name_bak.exists()) {
                if (file_name_bak.isFile()==false) {
                    result = false;
                    return result;
                }
            }
            FileUtils.copyFile(file_name, file_name_bak);
        } catch (Exception e) {
            result = false;
            e.printStackTrace();
            return result;
        }
        System.out.println("[deleteFile]结束备份文件["+filePath+fileName+"]到["+fileNameBak+"]");
        result = file_name.delete();
        System.out.println("[deleteFile]结束删除文件["+filePath+fileName+"]...");
        return result;
    }
    /**
     * 根据系统参数名称(导出文件路径)获取导出文件的路径和文件名称
     * 
     * @param   key        系统参数名称
     * @return  filePath   导出文件的路径
     * @return  fileName   导出文件的名称
     */
    public static void getFilePathName(String key, StringBuffer filePath, StringBuffer fileName) {
        String replaceFileName = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
        DataObject config = (DataObject)CacheUtil.getValue(Constan.CACHE_NAME, key);
        String filedir = config.getString("paramValue");
        filedir = filedir.replaceAll(Constan.PATH_FORMAT, replaceFileName);
        
        File file=new File(filedir);
        String file_path = file.getParentFile().toString();
        if (file_path.endsWith("/")==false) {
            file_path += "/";
        }
        filePath.setLength(0);
        filePath.append(file_path);
        
        String file_name = file.getName();
        fileName.setLength(0);
        fileName.append(file_name);
    }
    /**
     * 校验当前运行时间是否合法
     * 
     * @param
     * @return  运行时间是否合法
     */
    public static boolean checkRunTime() {
        boolean flag = false;
        int beginTime = 93000;
        int endTime = 173000;
        DataObject config = (DataObject)CacheUtil.getValue(Constan.CACHE_NAME, "ATS_CJ_RUN_TIME");
        String run_time = config.getString("paramValue");
        String[] token_rime = run_time.split("-");
        beginTime = Integer.parseInt(token_rime[0]);
        endTime = Integer.parseInt(token_rime[1]);
        int nowTime = Integer.parseInt(DateUtil.currentDateString("HHmmss"));
        if (nowTime>=beginTime && nowTime<=endTime) {
            flag = true;
            LogUtil.logInfo("[checkRunTime]运行时间,nowTime["+nowTime+"],beginTime["+beginTime+"],endTime["+endTime+"]", null, new Object[]{});
        }
        else {
            LogUtil.logError("[checkRunTime]运行时间不合法,nowTime["+nowTime+"],beginTime["+beginTime+"],endTime["+endTime+"]", null, new Object[]{});
        }
        return flag;
    }
    /**
     * 校验当前运行时间是否合法
     * @param illegalRunTimes  非法执行任务时间段数组,数组内的字符串格式为"'beginTime'-'endTime'"。例如："093000-103000"
     * @return false 执行时间不合法   true 执行时间
     */
    public static boolean checkRunTime(String[] illegalRunTimes){
    	int nowTime = Integer.parseInt(DateUtil.currentDateString("HHmmss"));
    	int beginTime = 0;
    	int endTime = 0;
    	boolean flag = true;
    	for (String illegalRunTimeStr : illegalRunTimes) {
			String[] timePoints = illegalRunTimeStr.split("-");
			if(timePoints.length!=2){
				throw new IllegalArgumentException("非法执行时间段字符串格式不正确");
			}
			beginTime = Integer.parseInt(timePoints[0]);
			endTime = Integer.parseInt(timePoints[1]);
			if (nowTime>=beginTime&&nowTime<=endTime) {
	            flag = false;
	            break;
			}
		}
    	return flag;
    }
    /**
     * 查询导出的记录是否成功导到O32
     * 1.存在就删除temp记录，
     * 2.不存在就还原状态为1（未导出）
     * @return  判断O32是否存在该记录，
     * 
     */
    public static boolean checkIsHaveBond(){
    	boolean flag = false;
        Connection conn_qjy = null;
        Connection conn_O32 = null;
        SimpleDateFormat sim = null;
        StringBuffer sql_qjy = new StringBuffer();
        StringBuffer sql_O32 = new StringBuffer();
        List<Map<String, String>> list_bond_qjy = new ArrayList<Map<String, String>>();
        List<Map<String, String>> list_bond_O32 = new ArrayList<Map<String, String>>();
    	try {
	        conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
	        conn_O32 = JDBCUtil.getConnByDataSourceId(com.cjhxfund.commonUtil.CacheUtil.getO32CacheDataSourceName());
            sql_qjy.setLength(0);
            sql_qjy.append("select t.l_stock_issue_id,t.c_market_no,t.vc_stock_code from t_ats_stock_issue_info t ,t_ats_stock_issue_info_temp p where t.l_stock_issue_id = p.l_stock_issue_id and p.c_status = '2'");
            //2.查询temp表中导出excl的记录
            list_bond_qjy = JDBCUtil.queryWithConn(conn_qjy, sql_qjy.toString(), null);
            sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            if (!list_bond_qjy.isEmpty() && list_bond_qjy.size() > 0) {
            	for (int i = 0; i < list_bond_qjy.size(); i++) {
                    Map<String, String> map = list_bond_qjy.get(i);
                    String lStockIssueId = map.get("L_STOCK_ISSUE_ID");
                    String vcStockCode = map.get("VC_STOCK_CODE");
        			String cMarketNo = map.get("C_MARKET_NO");
        			//3.判断O32是否已经存在该记录
        			sql_O32.setLength(0);
        			sql_O32.append(" select count(*) as count from trade.tstockinfo a where a.c_market_no = '"+cMarketNo+"' and a.vc_report_code = '"+vcStockCode+"'");
        	    	list_bond_O32 = JDBCUtil.queryWithConn(conn_O32, sql_O32.toString(), null);
        	    	if(list_bond_O32.get(0).get("COUNT")!=null || list_bond_O32.get(0).get("COUNT")!=""){
        	    		String sCnt = list_bond_O32.get(0).get("COUNT");
        	    		//4.存在更新状态为3（已导出），不存在则更新状态为5（导出失败）
        	    		if(!("0".equals(sCnt))){
        	    	        sql_qjy.setLength(0);
        	    	        sql_qjy.append(" delete from t_ats_stock_issue_info_temp where l_stock_issue_id = '"+lStockIssueId+"'");
        	    	        doExecSqlByAts(sql_qjy);
        	    	        //SynCommonUtil.insertMsg("0", "新债信息导出到O32", 1, "导入成功", "将债券代码为:'"+vcStockCode+"' 成功导入O32");
        	    		}else{
        	    			sql_qjy.setLength(0);
        	    	        sql_qjy.append(" update t_ats_stock_issue_info_temp set c_status = '5',d_export_time = to_date('"+sim.format(new Date())+"','yyyy-mm-dd hh24:mi:ss') where l_stock_issue_id = '"+lStockIssueId+"'");
        	    	        doExecSqlByAts(sql_qjy);
        	    	        //SynCommonUtil.insertMsg("0", "新债信息导出到O32", 1, "导入失败，并还原", "将债券代码为:'"+vcStockCode+"' 还原到待导出表");
        	    		}
        	    	}
            	}
            	return true;
            }else{
            	return flag;
            }
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sim = null;
			sql_qjy = null;
			sql_O32 = null;
			list_bond_qjy = null;
			list_bond_O32 = null;
			JDBCUtil.releaseResource(conn_qjy, null, null);
			JDBCUtil.releaseResource(conn_O32, null, null);
		}
    	return flag;
    }
    
    /**
     * 校验转换机是否成功导出excl
     * @param
     * @return  转换机的执行时间是否大于excl创建时间
     */
    @Bizlet("")
    public static boolean checkExport(){
    	System.out.println(DateUtil.currentDateTimeString()+"---checkExport begin...");
    	Long beforeTime=(new Date()).getTime();
    	
    	boolean flag = false;
    	flag = checkRunTime();
        String sLastExecTime = "0";
        boolean isFileExist = false;
        String key = "";
        StringBuffer filePath = new StringBuffer("");
        StringBuffer fileName = new StringBuffer("");
        StringBuffer sCreateTime = new StringBuffer("0");
        if(flag){
        key = "ATS_CJ_ZQFXXX_URL";
        getFilePathName(key, filePath, fileName);
        isFileExist = isFileExist(filePath.toString(), fileName.toString(), sCreateTime);
        	/* 02.判断O32转换机路径中是否存在指定的文件名 */
	        if (isFileExist) {
	            /* 02.01.存在指定的文件,查询O32转换机任务的最后执行时间 */
	            sLastExecTime = getLastExecTimeFromHs();
	            if (sLastExecTime == null || sLastExecTime == "0") {
	                return false;
	            }
	            /* 文件创建时间<O32最后执行时间,说明O32转换机已对该文件进行处理,则删除指定目录下的文件*/
	            System.out.println("文件创建时间:"+Integer.parseInt(sCreateTime.toString())+"------转换机执行时间:"+Integer.parseInt(sLastExecTime));
	            if (Integer.parseInt(sCreateTime.toString()) < Integer.parseInt(sLastExecTime)) {
	            	System.out.println("转换机执行时间大于文件创建时间，将删除目录文件，并反馈状态。。。。。");
	                flag = deleteFileList(filePath.toString());
	                if(flag){
	                	System.out.println("共享目录文件删除成功。。。。。");
	                	//更新temp状态
	                	checkIsHaveBond();
	                }else{
	                	System.out.println("共享目录文件删除失败。。。。。");
	                }
	            }
	        }
        }
        
        Long afterTime=(new Date()).getTime();
        String className=Thread.currentThread().getStackTrace()[1].getClassName();
        String methodName=Thread.currentThread().getStackTrace()[1].getMethodName();
        QrtzUtil.logTriggerInfo(className+"."+methodName, beforeTime, afterTime);
        
        System.out.println(DateUtil.currentDateTimeString()+"---checkExport end...");
    	return true;
    }
}
