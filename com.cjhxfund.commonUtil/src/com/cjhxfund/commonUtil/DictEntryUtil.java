/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * @author 陈鹏
 * @date 2016-04-05 09:22:17
 *
 */
@Bizlet("")
public class DictEntryUtil {

	/**
	 * @param 数据字典名称
	 * @param 过滤值
	 * @return 数据字典集合
	 * @author 陈鹏
	 */
	@Bizlet("")
	public static List<DataObject> getDictEntryList(String entryName,
			String filterValue) {
		// TODO 自动生成的方法存根
		
		DataObject[] objs = BusinessDictUtil.getCurrentDictInfoByType(entryName);
		String[] filterValues = filterValue.split(",");
		List<DataObject> lists = new ArrayList<DataObject>();
		
		for(int i =0;i<objs.length;i++){
			for(int k = 0;k<filterValues.length;k++){
				if(objs[i].getString("dictID").equals(filterValues[k])){
					lists.add(objs[i]);
				}
			}
		}
		
		return  lists;
	}
	
	/**
	 * 将数据转化为json格式
	 * @author 黄燕
	 */
	@Bizlet("")
	public static List<Map<String,String>> getDictToJson(DataObject[] dataObjects) {
		List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
		if(dataObjects.length>0){
			for(int i=0;i<dataObjects.length;i++){
				Map<String, String> maps = new HashMap<String, String>();
				maps.put("id", dataObjects[i].getString("DICTID"));
				maps.put("text", dataObjects[i].getString("DICTNAME"));
    			lists.add(maps);
				//str = str + "{id:'"+dataObjects[i].getString("DICTID")+"',text:'"+dataObjects[i].getString("DICTNAME")+"'},";
			}
			return lists;
		}else{
			return lists;
		}
	}
	/**
	 * 通过sql查询数据转化为json格式
	 * @author 黄燕
	 */
	@Bizlet("")
	public static List<Map<String,String>> getDataToJson(Map<String,String> map) {
		 Connection conn_qjy = null;
	     List<Map<String, String>> list = new ArrayList<Map<String, String>>();
	     List<Map<String, String>> lists = new ArrayList<Map<String, String>>();
	     
	     String sql = "";
        try {
        	conn_qjy = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
        	if(!map.isEmpty()){
        		sql=map.values().toString();
        		sql=sql.substring(1, sql.length()-1);
        	}
        	list = JDBCUtil.queryWithConn(conn_qjy, sql.toString(), null);
        	if(!list.isEmpty()){
        		for(int i=0;i<list.size();i++){
        			Map<String, String> maps = new HashMap<String, String>();
    				maps.put("id", list.get(i).get("ID"));
    				maps.put("text", list.get(i).get("TEXT"));
        			lists.add(maps);
    				//str = str + "{id:'"+list.get(i).get("ID")+"',text:'"+list.get(i).get("TEXT")+"'},";
    			}
        	}
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.releaseResource(conn_qjy, null, null);
        }
		return lists;
        //return "["+str.substring(0, str.length()-1)+"]";
	}


}
