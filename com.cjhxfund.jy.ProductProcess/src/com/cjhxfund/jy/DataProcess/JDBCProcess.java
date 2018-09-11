package com.cjhxfund.jy.DataProcess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.StrUtil;

public class  JDBCProcess {
		
	public void readPosition() throws SQLException{
		
		Connection conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
		String sql = StrUtil.findContentStr("zhxxcx_pqb.sql", null);
		String countStr = JDBCUtil.getValueBySql(conn, JDBCUtil.getCountSql(sql.toString()));//获取查询结果集记录总数
		int count = Integer.parseInt(countStr);
		int size = 1024;
		int length = count/size;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			
			for(int currentPage=0;currentPage<length;currentPage++){
				
				int begin = currentPage * length + 1;
				int end = begin + length;
				if(end > count)
					end = count;
				sql = JDBCUtil.getSqlWithPage(sql.toString(), begin, end);
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				
				while (rs.next()) {
					
					
				}
				
			}
			
			
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} finally{
			sql = null;
			if(rs != null) {
				rs.close();
				rs = null;
			}
			if(ps != null){
				ps.close();
				ps = null;
			}
			if(conn != null){
				conn.close();
				conn = null;
			}
		}
		
		
	}

}
