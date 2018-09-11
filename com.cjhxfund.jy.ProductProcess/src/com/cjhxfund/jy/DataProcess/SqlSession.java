package com.cjhxfund.jy.DataProcess;

import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.cjhxfund.commonUtil.JDBCUtil;

public class SqlSession {
	
	private Connection conn;	
	private Excutor excutor;
	private String dataSource;
	private boolean isClose;
	private static ThreadLocal<Connection> connPool = new ThreadLocal<Connection>();
	private static Logger logger = Logger.getLogger(SqlSession.class);
	
	public SqlSession(String dataSource){
		this.dataSource = dataSource;
		this.conn = JDBCUtil.getConnByDataSourceId(dataSource);
	}
	
	public SqlSession(String dataSource,Excutor excutor){
		this.dataSource = dataSource;
		this.conn = JDBCUtil.getConnByDataSourceId(dataSource);
		this.excutor = excutor;
	}
	
	public SqlSession(String dataSource,Excutor excutor,boolean isClose){
		this.dataSource = dataSource;
		this.conn = JDBCUtil.getConnByDataSourceId(dataSource);
		this.excutor = excutor;
		this.isClose = isClose;
	}
	
	public Connection getConnect(){
		return this.conn;
	}
	
	public void closeConnect(){
		if(conn!=null){  
     	   try {
			conn.close();
			logger.info("Connection closed");
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}  
        }
	}
	
	public List<?> select(String statement,List<Object> parameter){  
        return excutor.query(conn,statement, parameter);  
    }
	
	public void insertOrUpdate(String statement,List<Object> parameter){
		excutor.insertOrUpdate(conn,statement, parameter);
	}
	
	@SuppressWarnings("unchecked")
	public <T> T getMapper(Class<T> clazz){
		//动态代理
		return (T)Proxy.newProxyInstance(clazz.getClassLoader(), new Class[]{clazz}, new MapperProxy(this));
		
	}
	
}
