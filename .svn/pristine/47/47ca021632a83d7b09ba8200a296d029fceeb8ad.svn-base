package com.cjhxfund.cjapi.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.cjhxfund.cjapi.exception.AppException;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;

import commonj.sdo.DataObject;

/**
 * @author 谭凯
 * @date 2016-11-01 09:07:41
 * 
 */
@Bizlet("")
public class JSONUtil {
	private static Gson gson = new Gson();//gson对象
	
	/**
	 * 将DataObject对象转换成Map
	 * 
	 * @param fields
	 *            字段属性 以","分隔
	 * @param obj
	 *            传入对象
	 * @return
	 */
	@Bizlet("将DataObject对象转换成Map")
	public static Map<String, Object> objToMap(String fields, DataObject obj){
		Map<String, Object> retMap = new HashMap<String, Object>();
		String arrs[] = fields.split(",");
		for (String string : arrs) {
			retMap.put(string.trim(), obj.get(string.trim())==null?"":obj.get(string.trim()));
		}
		return retMap;
	}

	/**
	 * @Description 将DataObject数组集合转换成Map
	 * @Author		liangjilong
	 * @Date		2017年1月7日 上午11:09:04
	 * @param fields
	 * @param objs
	 * @return 		参数
	 * @return 		Map<String,Object> 返回类型
	 */
	@Bizlet("将DataObject数组集合转换成Map")
	public static Map<String, Object> objsToMap(String fields, DataObject[] objs){
		Map<String, Object> retMap = new HashMap<String, Object>();
		String arrs[] = fields.split(",");
		for (int i = 0; i < arrs.length; i++) {
			String string = arrs[i];
			DataObject obj = objs[i];
			retMap.put(string.trim(), obj.get(string.trim())==null?"":obj.get(string.trim()));
		}
	 
		return retMap;
	}
	/**
	 * 将DataObject对象数组转换成Map集合
	 * 
	 * @param fields
	 *            字段属性 以","分隔
	 * @param obj
	 *            传入对象
	 * @return
	 */
	@Bizlet("将DataObject对象数组转换成Map集合")
	public static List<Map<String, Object>> objToListMap(String fields, DataObject[] obj) {
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < obj.length; i++) {

			DataObject dataObject = obj[i];
			Map<String, Object> map = objToMap(fields, dataObject);
			dataList.add(map);

		}
		return dataList;
	}

	/**
	 * @Description 将DataObject对象集合转换成Map集合
	 * @Author		liangjilong
	 * @Date		2017年1月6日 下午2:20:40
	 * @param fields
	 * @param objs
	 * @return 		参数
	 * @return 		List<Map<String,Object>> 返回类型
	 */
	@Bizlet("将DataObject对象集合转换成Map集合")
	public static List<Map<String, Object>> objsToListMap(String fields, List<DataObject> objs) {
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < objs.size(); i++) {
			DataObject dataObject = objs.get(i);
			Map<String, Object> map = objToMap(fields, dataObject);
			dataList.add(map);
		}
		return dataList;
	}
	/**
	 * 将Map转化为Json
	 * 
	 * @param map
	 * @return String
	 */
	@Bizlet("")
	public static <T> String mapToJson(Map<String, T> map) {
		String jsonStr = gson.toJson(map);
		return jsonStr;
	}

	/**
	 * 将List转化为Json
	 * 
	 * @param dataList
	 * @return String
	 */
	@Bizlet("")
	public static <T> String listToJson(List<Map<String, Object>> dataList) {
		String jsonStr = gson.toJson(dataList);
		return jsonStr;
	}

	/**
	 * 将dataObject对象转换成json字符串
	 * 
	 * @param fields
	 * @param obj
	 * @return
	 * @throws AppException 
	 */
	@Bizlet("")
	public static <T> String dataObjectToJson(String fields, DataObject[] obj) throws AppException {
		String jsonStr ="";
		try {
			 jsonStr = listToJson(objToListMap(fields, obj));
			
		} catch (Exception e) {
			throw new AppException(10001,"");
		}
		return jsonStr;
	}

	/**
	 * 获取JsonObject
	 * 
	 * @param json
	 * @return
	 */
	@Bizlet("获取JsonObject")
	public static JsonObject parseJson(String json) {
		JsonParser parser = new JsonParser();
		JsonObject jsonObj = parser.parse(json).getAsJsonObject();
		return jsonObj;
	}

	/**
	 * 根据json字符串返回Map对象
	 * 
	 * @param json
	 * @return
	 */
	@Bizlet("根据json字符串返回Map对象")
	public static Map<String, Object> toMap(String json) {
		return JSONUtil.toMap(JSONUtil.parseJson(json));
	}

	/**
	 * 将JSONObjec对象转换成Map-List集合
	 * 
	 * @param json
	 * @return
	 */
	@Bizlet("JSONObjec对象转换成Map-List集合")
	public static Map<String, Object> toMap(JsonObject json) {
		Map<String, Object> map = new HashMap<String, Object>();
		Set<Entry<String, JsonElement>> entrySet = json.entrySet();
		for (Iterator<Entry<String, JsonElement>> iter = entrySet.iterator(); iter.hasNext();) {
			Entry<String, JsonElement> entry = iter.next();
			String key = entry.getKey();
			Object value = entry.getValue();
			if (value instanceof JsonArray)
				map.put((String) key, toList((JsonArray) value));
			else if (value instanceof JsonObject)
				map.put((String) key, toMap((JsonObject) value));
			else
				map.put((String) key, value);
		}
		return map;
	}

	/**
	 * 将JSONArray对象转换成List集合
	 * 
	 * @param json
	 * @return
	 */
	@Bizlet("将JSONArray对象转换成List集合")
	public static List<Object> toList(JsonArray json) {
		List<Object> list = new ArrayList<Object>();
		for (int i = 0; i < json.size(); i++) {
			Object value = json.get(i);
			if (value instanceof JsonArray) {
				list.add(toList((JsonArray) value));
			} else if (value instanceof JsonObject) {
				list.add(toMap((JsonObject) value));
			} else {
				list.add(value);
			}
		}
		return list;
	}
	
	/**
	 * json转换DataObject
	 * @param obj
	 * @param fields
	 * @param json
	 * @return
	 */
	@Bizlet("json转换DataObject")
	public static DataObject jsonToDataObject(DataObject obj , String fields , String json ){
		Map<String, Object> paramaters = toMap(json);
		String arrs[] = fields.split(",");
		for (String string : arrs) {
			obj.set(string.trim(), paramaters.get(string.trim()));
		}
		return obj;
	}
	
	/**
	 * 将json字符串转化为Map
	 * @author luwenxing
	 * @param jsonString
	 * @return map
	 */
	@Bizlet("将json对象转换成Map集合")
	public static Map<String, Object> jsonToMap(String jsonString) {
		if(jsonString == null || jsonString.isEmpty()) {
			return null;
		}
		JsonParser parser = new JsonParser();  
        JsonObject jsonObj = parser.parse(jsonString).getAsJsonObject();  
        return jsonObjectToMap(jsonObj);
    }  
	

    /** 
     * 将JSONObjec对象转换成Map-List集合 
     * @param json 
     * @return 
     */  
    private static Map<String, Object> jsonObjectToMap(JsonObject json){  
        Map<String, Object> map = new HashMap<String, Object>();  
        Set<Entry<String, JsonElement>> entrySet = json.entrySet();  
        for (Iterator<Entry<String, JsonElement>> iter = entrySet.iterator(); iter.hasNext(); ){  
            Entry<String, JsonElement> entry = iter.next();  
            String key = entry.getKey();  
            JsonElement value = entry.getValue();  
            if(value.isJsonArray())  
                map.put((String) key, jsonObjectToList((JsonArray) value));  
            else if(value.isJsonObject())  
                map.put((String) key, jsonObjectToMap((JsonObject) value));  
            else if(value.isJsonPrimitive())
                map.put((String) key, jsonPrimitiveToObject((JsonPrimitive)value)); 
            else  	// null
            	 map.put((String) key, null); 
        }  
        return map;  
    }
    
    /** 
     * 将JSONArray对象转换成List集合 
     * @param json 
     * @return 
     */  
    private static List<Object> jsonObjectToList(JsonArray json){  
        List<Object> list = new ArrayList<Object>();  
        for (int i=0; i<json.size(); i++){  
            Object value = json.get(i);  
            if(value instanceof JsonArray){
                list.add(jsonObjectToList((JsonArray) value));  
            }  
            else if(value instanceof JsonObject){  
                list.add(jsonObjectToMap((JsonObject) value));  
            }  
            else{  
                list.add(jsonPrimitiveToObject((JsonPrimitive)value));  
            }  
        }  
        return list;  
    }  
    
    private static Object jsonPrimitiveToObject(JsonPrimitive jpObj){
    	if (jpObj == null || jpObj.isJsonNull()) {
    		return null;
    	} else if (jpObj.isBoolean()) {
    		return jpObj.getAsBoolean();
    	} else if (jpObj.isString()) {
    		return jpObj.getAsString();
    	} else if (jpObj.isNumber()) {
    		// 暂时统一定BigDecimal
    		return jpObj.getAsBigDecimal();
    		/**
    		String valStr = jpObj.getAsString();
    		if(valStr.contains(".")) {
    			return jpObj.getAsDouble();
    		} else {
    			Long num =  jpObj.getAsLong();
    			if (Integer.MIN_VALUE <= num && num <= Integer.MAX_VALUE) {
    				return num;
    			} else {
    				return jpObj.getAsInt();
    			}
    		}
    		*/
    	}
    	return null;
    }
    
    /**
	 * @Description 通过JSON字符串和需要的key的格式的json进行转换（单json和key值）
	 * 	             如：{"request":{"country":"中国","province":"广东省","city":"深圳市","street":"福田区","district":"福华一路"}}
	 * @Author		liangjilong
	 * @Date		2016年12月26日 下午4:16:45
	 * @param      jsonString
	 * @param      key  -->>request
	 * @return 		参数
	 * @return 		String 返回类型
     */
    @Bizlet("通过JSON字符串和需要的key的格式的json进行转换 ")
    public static  <T>  String jsonToJSON(String jsonString,String key){
    	String retJson = "";
    	Map<String, Object> jsonMap = jsonToMap(jsonString);
    	
    	if(jsonMap==null||jsonMap.isEmpty()){
    		retJson ="JSON格式有误或不能为空!";
    	}else{
    		Map<Object, Map<String, Object>> retMap = new HashMap <Object, Map<String, Object>>();   
    		retMap.put(key, jsonMap);
    		retJson  = gson.toJson(retMap);
    	}
    	return retJson;
    }
    
    
    
    /**
	 * @Description 多重json转换（jsonStrings和keys）
	 *   {
	 *    "request":
	 *      {
	 *       "Main":{"street":"福田区","province":"广东省","district":"福华一路","city":"深圳市","country":"中国"},
	 *       "Bond":{"street":"福田区","province":"广东省","district":"八卦三路","city":"深圳市","country":"中国"}
	 *     }
	 *   }
	 * @Author		liangjilong
	 * @Date		2016年12月26日 下午5:33:54
	 * @param 		jsonStrings     多个值
	 * @param 		keys       	  	多个key
	 * @param 		retJsonKey      最大的key
	 * @return 		String 返回类型
     */
    @Bizlet("通过JSON字符串和需要的key的格式的json进行转换 ")
    public static  <T>  String jsonToJSONS(String [] jsonStrings,String [] keys,String retJsonKey){
    	String retJson = "";
    	//1、创建返回JSON的多重的大JSON对象map
    	Map<Object, Map<Object, Map<String, Object>>> resultMap = new HashMap <Object,Map<Object, Map<String, Object>>>(); 
    	//2、创建返回JSON的二重的JSON对象map
    	Map<Object, Map<String, Object>> retMap = new HashMap <Object, Map<String, Object>>(); 
    	//3、遍历JSON数据
    	if( (jsonStrings!=null&&jsonStrings.length>0 )  && (keys!=null && keys.length>0) ){
    		for (int i = 0; i < jsonStrings.length; i++) {
				String json = jsonStrings[i];
				Map<String, Object> jsonVal = jsonToMap(json);
				if(keys.length==jsonStrings.length){
					retMap.put(keys[i], jsonVal);
					resultMap.put(retJsonKey, retMap);
		    		retJson = gson.toJson(resultMap);
				}else{
					retJson = json+",\tJSON字符串，缺少key值";
				}
			}
    	}else{
    		retJson ="JSON格式有误或不能为空!";
    	}
    	return retJson;
    }
    
    
    
    public static void main(String[] args) {
    	//String jsonString1="{\"country\":\"中国\",\"province\":\"广东省\",\"city\":\"深圳市\",\"street\":\"福田区\",\"district\":\"福华一路\"}";
    	//String jsonString2="{\"country\":\"中国\",\"province\":\"广东省\",\"city\":\"深圳市\",\"street\":\"福田区\",\"district\":\"八卦三路\"}";
    	//String json1 = jsonToJSON(jsonString1,"request");
    	
    	//System.out.println(json1);
 
    	//String jsonStrs [] = new String []{jsonString1,jsonString2};
    	//String keys [] = new String []{"Main","Bond"};
    	//String retJsonKey  = "request";
    	//String json  = jsonToJSONS(jsonStrs,keys, retJsonKey);
	    //System.out.println(json);
		 
	}
    
    
    
}
