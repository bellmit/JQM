package com.cjhxfund.jy.DataProcess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cjhxfund.commonUtil.StrUtil;

public class TagExcutor extends Excutor{
	
	private Map<String,String> map;
	
	public TagExcutor(Map<String,String> map){
		this.map = map;
	}
	
	public List<?> query(Connection conn, String sql, List<Object> parameter) {
		// TODO 自动生成的方法存根
		ResultSet set =null;
        PreparedStatement pre =null;
        String realSql = StrUtil.findContentStr(ZHXXCX_FILE_PATH+sql, null);      
        try {
        	
        	String param = (String) parameter.get(0);
        	realSql = realSql.replaceAll("To_Replace_Date", param);
        	pre = conn.prepareStatement(realSql);          	
        	set = pre.executeQuery();          	
        	while(set.next()){
        		String id = set.getString("id");
        		String date = set.getString("l_redeem_liquidate");
        		map.put(id, date);
        	}
        	
        } catch (SQLException e) {  
            e.printStackTrace();  
        } finally{
               try{  
                   if(set!=null){  
                	   set.close();  
                   }if(pre!=null){
                	   pre.clearBatch();
                	   pre.close();  
                   }if(conn!=null){  
                	   conn.close();  
                   }  
               }catch(Exception e2){  
                   e2.printStackTrace();  
               }  
           }	
        return null;
	}
	
	
}
