package com.cjhxfund.ats.fm.baseinfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import com.cjhxfund.ats.fm.commonUtil.JDBCUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;


/**
 * string2map
 * @author shihao
 */
@Bizlet("")
public class DataChangeUtil {
	
	/**
	 * 将string转成map
	 * @param String 参数
	 * @return Map
	 */
	@Bizlet("将string转成map")
	public static Map<String, Object> String2Map(DataObject[] obj) throws Exception {
		String maps = "";
		Map map = new HashMap(); 
		if(obj.length>0){
			if(obj[0].get("vcConfValue") == null || obj[0].get("vcConfValue") ==""){
				return map;
			}
			maps = (String) obj[0].get("vcConfValue");
		}
		 
		StringTokenizer items;
		for(StringTokenizer entrys = new StringTokenizer(maps, ";");entrys.hasMoreTokens();   
		    map.put(items.nextToken(), items.hasMoreTokens() ? ((Object) (items.nextToken())) : null))  items = new StringTokenizer(entrys.nextToken(), "|");
		Map map1 = new HashMap();
		for (Object v : map.values()) {
			   map1.put(v, v);
		}
		  return map1; 
	}
	/**
	 * 将map的查询条件增加引号
	 * @return map
	 */
	@Bizlet("将map的查询条件增加引号")
	public  static Map<String,String> FormatMapQueryCondition(Map<String,String> map){
		if(map.size()>0){
			if(map.get("vcStockType")!=null && map.get("vcStockType")!=""){
				String vcStockType= map.get("vcStockType");//10,2
				vcStockType=vcStockType.replace(",","','");
				vcStockType = "'"+ vcStockType +"'";
				map.put("vcStockType", vcStockType);
			}
			if(map.get("vcIssueProperty")!=null && map.get("vcIssueProperty")!=""){
				String vcIssueProperty= map.get("vcIssueProperty");//10,2
				vcIssueProperty=vcIssueProperty.replace(",","','");
				vcIssueProperty = "'"+ vcIssueProperty +"'";
				map.put("vcIssueProperty", vcIssueProperty);
			}
			if(map.get("cIssueAppraise")!=null && map.get("cIssueAppraise")!=""){
				String cIssueAppraise= map.get("cIssueAppraise");//10,2
				cIssueAppraise=cIssueAppraise.replace(",","','");
				cIssueAppraise = "'"+ cIssueAppraise +"'";
				map.put("cIssueAppraise", cIssueAppraise);
			}
			//添加O32债券类型格式转换
			if(map.get("sStockTypeO32")!=null && map.get("sStockTypeO32")!=""){
				String sStockTypeO32= map.get("sStockTypeO32");//10,2
				sStockTypeO32 = "'"+ sStockTypeO32 +"'";
				map.put("sStockTypeO32", sStockTypeO32);
			}
			if(map.get("flag")=="1" && map.get("lOperatorNo")!=null){
				String lOperatorNo = map.get("lOperatorNo")+",-1";
				map.put("lOperatorNo", lOperatorNo);
			}
		}
		return map;
		
	}
	
	/**
	 * 将map的查询条件增加引号
	 * @return map
	 */
	@Bizlet("将map的查询条件增加引号")
	public  static String FormatMapQueryToSql(String sortField){
		String retuSortField="";
		if(sortField!=null){
			for(int i=0;i<sortField.length();i++){
				char len =sortField.charAt(i);
				if('A'<=len && len<='Z'){
					retuSortField += "_"+sortField.substring(i, i+1);
				}else{
					retuSortField +=sortField.substring(i, i+1);
				}
			}
		}
		return retuSortField;
	}
	/**
	 * 判断字符串是否英文字母
	 * @return Srting
	 */
	@Bizlet("判断字符串是否英文字母")
	public  static Boolean isChar(String sortField){
		Boolean flag = false;
		if(sortField != null){
			char   c   =   sortField.charAt(0);   
	        if(((c>='a'&&c<='z')   ||   (c>='A'&&c<='Z'))){   
	        	flag = true;
	      	}else{   
	      		flag = false;
	        } 
		}
		return flag;
	}
	/**
	 * 自动去重设置参数
	 * @return Srting
	 */
	@Bizlet("新债信息转换发起去重参数")
	public static Map<String,String> mergeParam(Object [] stockinfos){
		List<DataObject> lists = new ArrayList<DataObject>();
		Map parmap = new HashMap();
		DataObject stockinfo = null;
		String selStock = null;
		String lInvestNo = null;
		stockinfo = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.baseinfo.stockissue.TAtsStockIssueInfo");
		long key = 0;
		if (stockinfos.length >1){
			for (int i = 0;i < stockinfos.length;i++){
				stockinfo = (DataObject) stockinfos[i];
				stockinfo.setString("id", stockinfo.getString("lStockIssueId"));
				lists.add(stockinfo);
				if ("4".equals(stockinfo.getString("cSource"))){	//取wind的为准
					selStock = stockinfo.getString("lStockIssueId");
					lInvestNo = stockinfo.getString("lStockInvestNo");
				}
			}
			if(selStock == null || selStock == "" || lInvestNo == null || lInvestNo == ""){  //重复数据都是O32的，取正式代码为准，没有取最后一条记录为准
				for (int i = 0;i < stockinfos.length;i++){
					stockinfo = (DataObject) stockinfos[i];
					if (stockinfo.getString("vcStockCode").matches("[0-9]+")){
						selStock = stockinfo.getString("lStockIssueId");
						lInvestNo = stockinfo.getString("lStockInvestNo");
					}else{
						if(null != selStock && "" != selStock){
							selStock = stockinfo.getString("lStockIssueId");
							lInvestNo = stockinfo.getString("lStockInvestNo");
						}
					}
				}
			}
		}
		key = JDBCUtil.getNextSequence("SEQSTOCKISSUENO");
		DataObject [] nodes = new DataObject[stockinfos.length];
		lists.toArray(nodes);
		parmap.put("nodes", nodes);
		parmap.put("selStock", selStock);
		parmap.put("lInvestNo", lInvestNo);
		parmap.put("key", key);
		return parmap;
	}
	@Bizlet("获取证监会树形数据")
	public static List<Map<String,String>> getVcIssueAppraiseCsrcTree(DataObject[] vcIssueAppraiseCsrcArrays){
		List<Map<String,String>> lst = new ArrayList<Map<String,String>>();
		
		for (int i = 0; i < vcIssueAppraiseCsrcArrays.length; i++) {
			DataObject dataObject = vcIssueAppraiseCsrcArrays[i];
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("id", dataObject.getString("vcIssueAppraiseCsrc"));
			map.put("text", dataObject.getString("vcIssueAppraiseCsrcName"));
			if(dataObject.getString("vcParentIssueAppraiseCsrc")!="" && dataObject.getString("vcParentIssueAppraiseCsrc")!=null){
				map.put("pid", dataObject.getString("vcParentIssueAppraiseCsrc"));
			}
			map.put("isLeaf", dataObject.getString("lIsLeaf"));
			
			lst.add(map);
		}
		return lst;
	}
}
