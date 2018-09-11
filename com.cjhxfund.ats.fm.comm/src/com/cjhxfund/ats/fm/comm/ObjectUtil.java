package com.cjhxfund.ats.fm.comm;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.cjhxfund.ats.fm.baseinfo.ApplyInfo;
import com.cjhxfund.ats.fm.baseinfo.PurchaseOderElement;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

@Bizlet("")
public class ObjectUtil {

	/**
	 * 
	 * @param PurchaseOderElement类的对象
	 * @return 包含所有非null对象域值的map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@Bizlet("")
	public static Map<String, String> objToMap(PurchaseOderElement poe) {
		Map<String, String> map = new HashMap<String, String>();
		Class<?> clazz = poe.getClass();

		try {
			Field[] fields = clazz.getDeclaredFields();
			for (Field field : fields) {
				field.setAccessible(true);
				String key = field.getName();
				Object value = field.get(poe);
				if (value != null) {
					if (value instanceof String) {
						map.put(key, (String) value);
					}
					if (value instanceof Map<?,?>) {
						Map<String,List<Object>> mapOflist = (Map<String,List<Object>>)value;
						Iterator<String> it =mapOflist.keySet().iterator();
						while(it.hasNext()){
							String keyOfMap = it.next();
							List<Object> list = mapOflist.get(keyOfMap);
							for (int j = 0; j < list.size(); j++) {
								Object obj = list.get(j);
								Class<?> clazzOfObj = obj.getClass();
								Field[] fieldsOfObj = clazzOfObj.getDeclaredFields();
								for (Field fieldOfObj : fieldsOfObj) {
									fieldOfObj.setAccessible(true);
									String fieldOfObjName = fieldOfObj.getName();
									Object fieldOfObjValue = fieldOfObj.get(obj);
									if(fieldOfObjValue!=null){
										map.put(key+keyOfMap+fieldOfObjName+(j+1), (String)fieldOfObjValue);
									}
								}
							}
						}
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	@Bizlet("")
	public static List<ApplyInfo> applyInfoDobjToList(DataObject[] dobj){
		List<ApplyInfo> result = new ArrayList<ApplyInfo>();
		for(int i=0;i<dobj.length;i++){
			String rate = dobj[i].getString("enOffer");
			String amount = dobj[i].getString("enReport");
			result.add(new ApplyInfo(rate,amount));
		}
		
		return result;
	}
	
	@Bizlet("")
	public static void addObjectToList(List<Object> list,Object obj){
		list.add(obj);
	}
	@Bizlet("")
	public static List<Object> getList(){
		return new ArrayList<Object>();
	}
	@Bizlet("")
	public static Map<String,List<Object>> getMap(){
		return new HashMap<String,List<Object>>();
	}
	@Bizlet("")
	public static void addObjectToMap(Map<String, Object> map,String key ,Object obj){
		map.put(key, obj);
	}
}
