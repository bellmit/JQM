package com.cjhxfund.ats.fm.commonUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.apache.commons.lang.StringUtils;
import com.eos.common.connection.ConnectionHelper;
import com.eos.common.connection.DataSourceHelper;
import com.eos.foundation.common.utils.DateUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

/**
 * JDBC工具类
 * @author 徐福羊
 */
@Bizlet("")
public class JDBCUtil {

    /** 默认[10.201.200.22]数据源Governor的名称： default */
    public static final String DATA_SOURCE_DEFAULT = "default";
    
    /** O32系统[10.201.200.10]数据源Governor的名称：  DS_O32*/
    public static final String DATA_SOURCE_O32 = "DS_O32";
    
    /** 数据中心[10.201.4.43]数据源Governor的名称： DS_SJZX */
    public static final String DATA_SOURCE_SJZX = "DS_SJZX";

    /**
     * 从Governor获取默认数据源
     * 
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static DataSource getDefaultDataSource() {
        return DataSourceHelper.getDataSource();
    }

    /**
     * 根据Governor数据源ID获取对应数据源,若ID为空,则取默认数据源
     * 
     * @param dataSourceId
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static DataSource getDataSourceByDataSourceId(String dataSourceId) {
        if (StringUtils.isNotBlank(dataSourceId)) {
            return DataSourceHelper.getDataSource(dataSourceId.trim());
        } else {
            return DataSourceHelper.getDataSource();
        }
    }

    /**
     * 从Governor获取默认数据源连接
     * 
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static Connection getDefaultConn() {
        return ConnectionHelper.getConnection();
    }

    /**
     * 根据Governor数据源ID获取对应数据源的数据库连接,若ID为空,则取默认数据源的数据库连接
     * 
     * @param dataSourceId
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static Connection getConnByDataSourceId(String dataSourceId) {
        if (StringUtils.isNotBlank(dataSourceId)) {
            return ConnectionHelper.getConnection(dataSourceId);
        } else {
            return ConnectionHelper.getConnection();
        }
    }

    /**
     * 释放资源
     * 
     * @param conn
     * @param stmt
     * @param recd
     * @author 徐福羊
     */
    @Bizlet("")
    public static void releaseResource(Connection conn, Statement stmt,
            ResultSet recd) {
        try {
            if (recd != null) {
                recd.close();
                recd = null;
            }
            if (stmt != null) {
                stmt.close();
                stmt = null;
            }
            if (conn != null) {
                conn.close();
                conn = null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static int insert(String dsName, String sql, List<Object> params) {
        return executeUpdate(dsName, sql, params);
    }

    public static int insert(String dsName, String sql) {
        return insert(dsName, sql, null);
    }

    public static int insert(String sql, List<Object> params) {
        return insert(null, sql, params);
    }

    public static int insert(String sql) {
        return insert(null, sql, null);
    }

    public static int insertBatch(List<String> sqls) {
        return insertBatch(null, sqls);
    }

    public static int insertBatch(String dsName, List<String> sqls) {
        return executeUpdateBatch(dsName, sqls);
    }

    public static int delete(String dsName, String sql, List<Object> params) {
        return executeUpdate(dsName, sql, params);
    }

    public static int delete(String dsName, String sql) {
        return delete(dsName, sql, null);
    }

    public static int delete(String sql, List<Object> params) {
        return delete(null, sql, params);
    }

    public static int delete(String sql) {
        return delete(null, sql, null);
    }

    public static int update(String dsName, String sql, List<Object> params) {
        return executeUpdate(dsName, sql, params);
    }

    public static int update(String dsName, String sql) {
        return update(dsName, sql, null);
    }

    public static int update(String sql, List<Object> params) {
        return update(null, sql, params);
    }

    public static int update(String sql) {
        return update(null, sql, null);
    }

    public static List<Map<String, String>> query(String dsName, String sql,
            List<Object> params) {
        return executeQuery(dsName, sql, params);
    }

    public static List<Map<String, String>> query(String dsName, String sql) {
        return query(dsName, sql, null);
    }

    public static List<Map<String, String>> query(String sql,
            List<Object> params) {
        return query(null, sql, params);
    }

    public static List<Map<String, String>> query(String sql) {
        return query(null, sql, null);
    }

    /**
     * 根据数据源名称、sql语句、参数查询的通用方法
     * 
     * @param dsName
     * @param sql
     * @param params
     * @return
     * @author 徐福羊
     */
    public static List<Map<String, String>> executeQuery(String dsName,
            String sql, List<Object> params) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet recd = null;
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        try {
            conn = getConnByDataSourceId(dsName);
            stmt = conn.prepareStatement(sql);
            setParams(params, stmt);
            recd = stmt.executeQuery();
            list = getResultSetAsList(recd);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseResource(conn, stmt, recd);
        }
        return list;
    }

    /**
     * 根据数据源名称、sql语句、参数更新的通用方法
     * 
     * @param dsName
     * @param sql
     * @param params
     * @return
     * @author 徐福羊
     */
    public static int executeUpdate(String dsName, String sql,
            List<Object> params) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet recd = null;
        try {
            conn = getConnByDataSourceId(dsName);
            stmt = conn.prepareStatement(sql);
            setParams(params, stmt);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseResource(conn, stmt, recd);
        }
        return 0;
    }

    /**
     * 根据数据源名称和sql语句批量更新的通用方法
     * 
     * @param dsName
     * @param sqls
     * @return
     * @author 徐福羊
     */
    public static int executeUpdateBatch(String dsName, List<String> sqls) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet recd = null;
        try {
            conn = getConnByDataSourceId(dsName);
            stmt = conn.createStatement();
            for (String sql : sqls) {
                stmt.addBatch(sql);
            }
            stmt.executeBatch();
            return 1;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseResource(conn, stmt, recd);
        }
        return 0;
    }

    /**
     * 设置查询参数
     * 
     * @param params
     * @param stmt
     * @throws SQLException
     * @author 徐福羊
     */
    public static void setParams(List<Object> params, PreparedStatement stmt)
            throws SQLException {
        if (params != null && params.size() > 0) {
            for (int i = 0; i < params.size(); i++) {
                Object obj = params.get(i);
                int j = (i + 1);
                if (obj instanceof java.lang.String
                        || obj instanceof java.lang.Character) {
                    stmt.setString(j, String.valueOf(obj));
                } else if (obj instanceof java.sql.Date
                        || obj instanceof java.util.Date
                        || obj instanceof java.sql.Timestamp) {
                    stmt.setString(j,
                            DateUtil.format((Date) obj, "yyyy-MM-dd HH:mm:ss"));
                } else if (obj instanceof java.lang.Integer) {
                    stmt.setInt(j, (Integer) obj);
                } else if (obj instanceof java.lang.Double) {
                    stmt.setDouble(j, (Double) obj);
                } else if (obj instanceof java.lang.Float) {
                    stmt.setFloat(j, (Float) obj);
                } else {
                    stmt.setObject(j, obj);
                }
            }
        }
    }

    /**
     * 将查询得到的ResultSet结果转换成List集合
     * 
     * @param rs
     * @return
     * @throws SQLException
     * @author 徐福羊
     */
    public static List<Map<String, String>> getResultSetAsList(ResultSet rs)
            throws SQLException {
        Map<String, String> map = null;
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        while (rs.next()) {
            map = new HashMap<String, String>();
            ResultSetMetaData data = rs.getMetaData();
            for (int i = 0; i < data.getColumnCount(); i++) {
                map.put(data.getColumnName((i + 1)), rs.getString(i + 1));
            }
            list.add(map);
        }
        return list;
    }

    /**
     * 执行数据库更新操作的方法，需要传入Connection
     * 
     * @param conn
     * @param sql
     * @param params
     * @return
     * @author 徐福羊
     */
    public static int executeUpdateWithConn(Connection conn, String sql,
            List<Object> params) {
        PreparedStatement stmt = null;
        ResultSet recd = null;
        try {
            stmt = conn.prepareStatement(sql);
            setParams(params, stmt);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseResource(null, stmt, recd);
        }
        return 0;
    }

    /**
     * 执行数据库批量更新操作的方法，需要传入Connection
     * 
     * @param conn
     * @param sqls
     * @return
     * @author 徐福羊
     */
    public static int executeUpdateBatchWithConn(Connection conn,
            List<String> sqls) {
        Statement stmt = null;
        ResultSet recd = null;
        try {
            stmt = conn.createStatement();
            for (String sql : sqls) {
                stmt.addBatch(sql);
            }
            stmt.executeBatch();
            return 1;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            releaseResource(null, stmt, recd);
        }
        return 0;
    }

    /**
     * 执行数据库查询操作的方法，需要传入Connection
     * 
     * @param conn
     * @param sql
     * @param params
     * @return
     * @author 徐福羊
     */
    public static List<Map<String, String>> executeQueryWithConn(
            Connection conn, String sql, List<Object> params) {
        PreparedStatement stmt = null;
        ResultSet recd = null;
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        try {
            stmt = conn.prepareStatement(sql);
            setParams(params, stmt);
            recd = stmt.executeQuery();
            list = getResultSetAsList(recd);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            sql = null;
            releaseResource(null, stmt, recd);
        }
        return list;
    }
    
    /**
     * 执行数据库查询操作的方法，需要传入Connection
     * 
     * @param conn
     * @param sql
     * @param params
     * @return
     * @author 徐福羊
     */
    public static List<Map<String, String>> executeQueryWithRownum(
            Connection conn, String sql, List<Object> params) {
        PreparedStatement stmt = null;
        ResultSet recd = null;
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        try {
            stmt = conn.prepareStatement(sql);
            setParams(params, stmt);
            stmt.setMaxRows(10000);
            stmt.setFetchSize(1000);
            recd = stmt.executeQuery();
            list = getResultSetAsList(recd);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            sql = null;
            releaseResource(null, stmt, recd);
        }
        return list;
    }

    public static int insertBatchWithConn(Connection conn, List<String> sqls) {
        return executeUpdateBatchWithConn(conn, sqls);
    }

    public static int deleteWithConn(Connection conn, String sql) {
        return executeUpdateWithConn(conn, sql, null);
    }

    public static int updateWithConn(Connection conn, String sql) {
        return executeUpdateWithConn(conn, sql, null);
    }

    public static List<Map<String, String>> queryWithConn(Connection conn,
            String sql, List<Object> params) {
        return executeQueryWithConn(conn, sql, params);
    }

    /**
     * 根据SQL语句查询单一结果值
     * 
     * @param conn
     * @param sql
     * @return
     * @author 徐福羊
     */
    public static String getValueBySql(Connection conn, String sql) {
        String result = "0";
        Statement stmt = null;
        ResultSet recd = null;
        try {
            if (conn == null || conn.isClosed() || StringUtils.isBlank(sql)) {
                return result;
            }
            stmt = conn.createStatement();
            recd = stmt.executeQuery(sql);
            if (recd.next()) {
                result = recd.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                sql = null;
                if (recd != null) {
                    recd.close();
                    recd = null;
                }
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 根据SQL语句查询单一记录字段值(当有多个字段时,字段值以英文逗号分隔)
     * 
     * @param conn
     * @param sql
     * @return
     * @author 徐福羊
     */
    public static String getRecordValueBySql(Connection conn, String sql) {
        String result = "";
        StringBuffer sb = new StringBuffer();
        Statement stmt = null;
        ResultSet recd = null;
        try {
            if (conn == null || conn.isClosed() || StringUtils.isBlank(sql)) {
                return result;
            }
            stmt = conn.createStatement();
            recd = stmt.executeQuery(sql);
            // 获取第一条记录值（若有多条记录，也仅获取第一条记录）
            if (recd.next()) {
                ResultSetMetaData data = recd.getMetaData();
                for (int i = 0; i < data.getColumnCount(); i++) {
                    sb.append(recd.getString(i + 1)).append(",");
                }
            }
            if (sb.length() > 0) {
                result = sb.substring(0, sb.length() - 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (recd != null) {
                    recd.close();
                    recd = null;
                }
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 根据SQL语句查询单一结果值(当有多条记录时,结果值以英文逗号分隔)
     * 
     * @param conn
     * @param sql
     * @return
     * @author 徐福羊
     */
    public static String getListValueBySql(Connection conn, String sql) {
        String result = "";
        StringBuffer sb = new StringBuffer();
        Statement stmt = null;
        ResultSet recd = null;
        try {
            if (conn == null || conn.isClosed() || StringUtils.isBlank(sql)) {
                return result;
            }
            stmt = conn.createStatement();
            recd = stmt.executeQuery(sql);
            while (recd.next()) {
                if (StringUtils.isNotBlank(recd.getString(1))) {
                    sb.append(recd.getString(1)).append(",");
                }
            }
            if (sb.length() > 0) {
                result = sb.substring(0, sb.length() - 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (recd != null) {
                    recd.close();
                    recd = null;
                }
                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
            } catch (Exception ee) {
                ee.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 获取分页查询结果
     * 
     * @param list
     *            全部查询结果集合
     * @param pagecond
     *            分页对象
     * @return 分页后结果集合
     * @author 徐福羊
     */
    @Bizlet("")
    public static DataObject[] myPageCond(DataObject[] list, DataObject pagecond) {
        int count = list.length;
        int length = pagecond.getInt("length");
        int totalPage = (int) Math.ceil((double) count / length);
        int begin = pagecond.getInt("begin");
        int currentPage = 0;
        if (begin == 0) {
            currentPage = 1;
        } else {
            currentPage = begin / length + 1;
        }
        int end = currentPage * length;
        if (end > count)
            end = count;
        DataObject[] resultArr = new DataObject[end - begin];
        for (int i = begin; i < end; i++) {
            resultArr[i - begin] = list[i];
        }
        if (currentPage == 1) {
            pagecond.set("isFirst", true);
            pagecond.set("isLast", false);
        } else if (currentPage == totalPage) {
            pagecond.set("isFirst", false);
            pagecond.set("isLast", true);
        }
        pagecond.set("count", count);
        pagecond.set("totalPage", totalPage);
        pagecond.set("currentPage", currentPage);
        return resultArr;
    }

    /**
     * 计算分页信息值
     * 
     * @param pagecond
     *            分页对象
     * @param countStr
     *            查询结果集记录总数
     * @author 徐福羊
     */
    @Bizlet("")
    public static void calcPageCond(DataObject pagecond, String countStr) {
        int count = pagecond.getInt("count");// 获取查询结果集记录总数
        if (StringUtils.isNotBlank(countStr)) {
            count = Integer.valueOf(countStr.trim());// 若参数传入"查询结果集记录总数"，则直接用该值
        }
        int length = pagecond.getInt("length");
        int totalPage = (int) Math.ceil((double) count / length);
        int begin = pagecond.getInt("begin");
        int currentPage = 0;
        if (begin == 0) {
            currentPage = 1;
        } else {
            currentPage = begin / length + 1;
        }
        int end = currentPage * length;
        if (end > count)
            end = count;
        if (currentPage == 1) {
            pagecond.set("isFirst", true);
            pagecond.set("isLast", false);
        } else if (currentPage == totalPage) {
            pagecond.set("isFirst", false);
            pagecond.set("isLast", true);
        }
        pagecond.set("end", end);// 设置当前页面截至记录数
        pagecond.set("count", count);
        pagecond.set("totalPage", totalPage);
        pagecond.set("currentPage", currentPage);
    }

    /**
     * 获取查询总记录数的SQL语句
     * 
     * @param sql
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static String getCountSql(String sql) {
        if (StringUtils.isBlank(sql)) {
            return "";
        }
        String result = "select count(1) from ( " + sql + " )";
        sql = null;
        return result;
    }

    /**
     * 获取带分页查询的SQL语句
     * 
     * @param sql
     *            查询SQL语句
     * @param begin
     *            记录的起始记录号
     * @param end
     *            记录的截至记录号
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static String getSqlWithPage(String sql, int begin, int end) {
        if (StringUtils.isBlank(sql)) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        sb.append("SELECT * ").append("  FROM (SELECT ROWNUM AS rowno, pt1.* ")
                .append("          FROM ( " + sql + " ) pt1 ")
                .append("         WHERE ROWNUM <= " + end + ") pt2 ")
                .append(" WHERE pt2.rowno > " + begin + " ");
        sql = null;
        return sb.toString();
    }

    /**
     * 根据数据库连接、SQL语句、分页对象获取带分页的结果集
     * 
     * @param conn
     *            数据库连接
     * @param sql
     *            查询SQL语句
     * @param sqlOrder
     *            排序SQL语句
     * @param page
     *            分页对象
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static List<Map<String, String>> queryWithConnPage(Connection conn,
            StringBuffer sql, String sqlOrder, DataObject page) {
        String countStr = getValueBySql(conn, getCountSql(sql.toString()));// 获取查询结果集记录总数
        calcPageCond(page, countStr);// 计算分页信息值
        int begin = page.getInt("begin");// 获取当前页面起始记录数
        int end = page.getInt("end");// 获取当前页面截至记录数
        if (StringUtils.isNotBlank(sqlOrder)) {
            sql.append(sqlOrder);// 新增排序
        }
        return queryWithConn(conn, getSqlWithPage(sql.toString(), begin, end),
                null);
    }

    /**
     * 将字符串拼凑成SQL in 条件的格式
     * 
     * @param str
     *            需转换的字符串，以英文逗号或分号分隔
     * @return
     * @author 徐福羊
     */
    @Bizlet("")
    public static String changeInStr(String str) {
        if (StringUtils.isBlank(str)) {
            return "";
        }
        String result = "";
        StringBuffer sb = new StringBuffer();
        String[] strArr = str.replaceAll("；", ",").replaceAll(";", ",")
                .replaceAll("，", ",").split(",");
        for (int i = 0; i < strArr.length; i++) {
            if (StringUtils.isNotEmpty(strArr[i])) {
                sb.append("'").append(strArr[i]).append("',");
            }
        }
        if (sb.length() > 0) {
            result = sb.substring(0, sb.length() - 1);
        }
        return result;
    }

    /**
     * 将字符串拼凑成SQL in 条件的格式
     * 
     * @param ids
     *            传入的参数字符串
     * @param count
     *            分页条数
     * @param field
     *            查询条件
     * @return 返回 field in (...) or field in (...) 字符串
     * @author 徐福羊
     */
    @Bizlet("")
    public static String getSQLInOrIn(String ids, int count, String field) {
        if (StringUtils.isBlank(ids)) {
            return "";
        }
        count = Math.min(count, 1000);
        String[] idsArr = ids.replaceAll("；", ",").replaceAll(";", ",")
                .replaceAll("，", ",").split(",");
        int len = idsArr.length;
        int size = len % count;
        if (size == 0) {
            size = len / count;
        } else {
            size = (len / count) + 1;
        }
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < size; i++) {
            int fromIndex = i * count; // 设置起始下标
            int toIndex = Math.min(fromIndex + count, len); // 设置结束下标位置
            String tempId = "";
            // 循环数组并赋值
            for (int k = fromIndex; k < toIndex; k++) {
                tempId += ",'" + idsArr[k] + "'";
            }
            // 判断页数是否不等于0，不等于是组装 or
            if (i != 0) {
                builder.append(" or ");
            }
            // 组装in条件
            builder.append(field).append(" in ('")
                    .append(tempId.substring(2, tempId.length() - 1))
                    .append("')");
        }
        return StringUtils.defaultIfEmpty(" and (" + builder.toString() + ") ",
                " and " + field + " in ('')");
    }

    /**
     * 解析字符并组装sql语句
     * 
     * @param ids
     *            传入的参数字符串
     * @return 返回 select '1' from dual union All select '2' form dual 字符串
     * @author 徐福羊
     */
    @Bizlet("")
    public static String getOracleSQLIn(String ids) {
        if (StringUtils.isBlank(ids)) {
            return "";
        }
        StringBuffer sb = new StringBuffer();
        String[] idsArr = ids.replaceAll("；", ",").replaceAll(";", ",")
                .replaceAll("，", ",").split(",");
        int count = idsArr.length;
        for (int i = 0; i < count; i++) {
            sb.append("select '" + idsArr[i] + "' from dual ");
            if (i != count - 1) {
                sb.append("\n").append("union All \n");
            }
        }
        return sb.toString();
    }
    /**
     * 
     * @param sequenceName
     * @return
     */
    @Bizlet("")
    public static long getNextSequence(String sequenceName) {
    	Connection conn  = getDefaultConn();
    	long result =-1 ;
         Statement stmt = null;
         ResultSet recd = null;
         String sql = "select "+sequenceName+".nextval from dual";
         try {
             if (conn == null || conn.isClosed() || StringUtils.isBlank(sql)) {
                 return result;
             }
             stmt = conn.createStatement();
             recd = stmt.executeQuery(sql);
             if (recd.next()) {
                 result = recd.getLong(1);
             }
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
        	 releaseResource(conn, stmt, recd);
         }
         return result;
    	
    }

    /**
     * 测试数据库连接
     */
    @Bizlet("")
    public static void testConn() {
        Connection dbConn = null;
        // String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        // // 加载JDBC驱动
        // String dbURL =
        // "jdbc:sqlserver://172.18.220.174:1433;DatabaseName=caihua"; //
        // 连接服务器和数据库
        String driverName = "oracle.jdbc.driver.OracleDriver"; // 加载JDBC驱动
        String dbURL = "jdbc:oracle:thin:@10.201.200.10:1521:xxbyw"; // 连接服务器和数据库
        String userName = "trade"; // 默认用户名
        String userPwd = "trade"; // 密码
        try {
            Class.forName(driverName);
            dbConn = DriverManager.getConnection(dbURL, userName, userPwd);
            System.out.println("数据库连接：" + dbConn.toString());

            String sql = "select trade.sf_get_bond_yield(20151221,(select t.vc_inter_code from trade.tstockinfo t where t.vc_report_code='011572001'),102.31,0,'2') bond_yield from dual";
            String result = getValueBySql(dbConn, sql);
            System.out.println("result=" + Double.parseDouble(result));

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            releaseResource(dbConn, null, null);
        }
    }

    public static void main(String[] args) throws Exception {
        testConn();
    }
}
