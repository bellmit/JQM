/**
 * 
 */
package com.cjhxfund.ats.ipo;

import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.codehaus.jettison.json.JSONWriter;
import org.w3c.dom.Node;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.data.serialize.ExtendedXMLSerializer;
import com.primeton.ext.data.serialize.SerializeOption;
import com.primeton.ext.data.serialize.marshal.IMarshallingNode;

import commonj.sdo.DataObject;
import commonj.sdo.Property;

@Bizlet("JDConvertUtil")
public class JDConvertUtil {
	
	@Bizlet("json串转数组")
	public static DataObject[] convertJsonStringToDataObjects(
			String entityName, String jsonString) throws JSONException {
		ArrayList<DataObject> result = new ArrayList<DataObject>();

		JSONArray jsonArr = new JSONArray(jsonString);
		for (int i = 0; i < jsonArr.length(); i++) {
			JSONObject json = jsonArr.getJSONObject(i);

			DataObject dataObject = DataObjectUtil.createDataObject(entityName);
			List list = dataObject.getInstanceProperties();
			for (Object object : list) {
				Property key = (Property) object;
				String keyType = key.getType().getName();//获取字段类型
				if (json.has(key.getName())) {
					Object value = json.get(key.getName());
					if (value == JSONObject.NULL)
						continue;
					dataObject.set(key, value);
					dataObject = converType(keyType, key, dataObject, value);
				}

			}
			result.add(dataObject);
		}

		return result.toArray(new DataObject[result.size()]);
	}

	@Bizlet("json串转实体对象")
	public static DataObject convertJsonStringToDataObject(String entityName,
			String jsonString) throws JSONException {
		JSONObject json = new JSONObject(jsonString);
		DataObject dataObject = DataObjectUtil.createDataObject(entityName);
		List list = dataObject.getInstanceProperties();
		for (Object object : list) {
			Property key = (Property) object;
			String keyType = key.getType().getName();//获取字段类型
			if (json.has(key.getName())) {
				Object value = json.get(key.getName());
				if (value == JSONObject.NULL)
					continue;
				dataObject = converType(keyType, key, dataObject, value);//根据不同类型设置值
			} else {
			}
		}
		return dataObject;
	}

	@Bizlet("实体转json串")
	public static String convertDataObjectToJsonString(DataObject dataObject) {
		DataObject[] dataObjects = new DataObject[] { dataObject };
		String jsonString = convertDataObjectsToJsonString(dataObjects);
		jsonString = jsonString.substring(1, jsonString.length() - 1);
		return jsonString;
	}

	@Bizlet("数组转json串")
	public static String convertDataObjectsToJsonString(DataObject[] dataObjects) {
		Map<String, DataObject[]> root = new HashMap<String, DataObject[]>();
		root.put("data", dataObjects);

		StringWriter stringWriter = new StringWriter();
		JSONWriter jsonWriter = new JSONWriter(stringWriter);
		try {
			ExtendedXMLSerializer serializer = new ExtendedXMLSerializer();
			SerializeOption operation = new SerializeOption();
			operation.setCreateOuterCollectionNode(true);
			serializer.setOption(operation);
			IMarshallingNode node = serializer.marshallToNode(root, "root");
			jsonWriter.object();
			List<IMarshallingNode> children = node.getChildren();
			for (IMarshallingNode child : children) {
				write(child, jsonWriter);
			}
			jsonWriter.endObject();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		String jsonString = stringWriter.toString();
		jsonString = jsonString.substring(8, jsonString.length() - 1);
		return jsonString;
	}

	private static void write(IMarshallingNode node, JSONWriter writer)
			throws JSONException {
		int type = getNodeType(node);
		List<IMarshallingNode> children = null;
		switch (type) {
		case 1:
			Object nodeValue = node.getValue();
			boolean writeValue = false;
			if ((nodeValue == null) || (Boolean.class == nodeValue.getClass())
					|| (Number.class.isAssignableFrom(nodeValue.getClass()))) {
				writeValue = true;
			}
			if (node.isEntry()) {
				writer.value(writeValue == true ? nodeValue : node.getText());
			} else
				writer.key(node.getName()).value(
						writeValue == true ? nodeValue : node.getText());

			break;
		case 2:
			if (!node.isEntry()) {
				writer.key(node.getName());
			}
			writer.array();
			children = node.getChildren();
			for (IMarshallingNode child : children) {
				write(child, writer);
			}
			writer.endArray();
			break;
		case 3:
			if (!node.isEntry()) {
				writer.key(node.getName());
			}
			writer.object();
			children = node.getChildren();
			for (IMarshallingNode child : children) {
				write(child, writer);
			}
			writer.endObject();
			break;
		case 4:
			String xml = com.eos.system.utility.XmlUtil.node2String(
					(Node) node.getValue(), false, false, "UTF-8");

			if (node.isEntry())
				writer.value(xml);
			else {
				writer.key(node.getName()).value(xml);
			}
			break;
		case -1:
		case 0:
			break;
		}
	}

	private static int getNodeType(IMarshallingNode node) {
		if (!node.isSet()) {
			return -1;
		}
		if (node.isXml()) {
			return 4;
		}
		if (node.getChildren().size() <= 0) {
			if (node.getText() != null)
				return 1;
			if ("null".equals(node.getAttribute("__isNullOrEmpty"))) {
				return 1;
			}
			if ("empty".equals(node.getAttribute("__isNullOrEmpty"))) {
				String type = node.getAttribute("__type");
				if (type == null)
					return 3;
				try {
					Class clazz = Class
							.forName(type.substring("java:".length()));

					if ((clazz != null)
							&& ((clazz.isArray()) || (Collection.class
									.isAssignableFrom(clazz)))) {

						return 2;
					}
					return 3;
				} catch (ClassNotFoundException e) {
				}
			}
		} else if (((IMarshallingNode) node.getChildren().get(0)).isEntry()) {
			return 2;
		}
		return 3;
	}

	/**
	 * 将传入的JSON字段根据实体类型转换
	 * @param keyType
	 * @param key
	 * @param dataObject
	 * @param value
	 * @return
	 */
	private static DataObject converType(String keyType, Property key,
			DataObject dataObject, Object value) {
		if (keyType.equals("String")) {
			dataObject.set(key, value.toString());
		} else if (keyType.equals("Int")) {
			dataObject.set(key, Integer.parseInt(value.toString()));
		} else if (keyType.equals("BigInteger")) {
			BigInteger big1 = new BigInteger(value.toString());
			dataObject.set(key, big1);
		} else if (keyType.equals("Float")) {
			dataObject.set(key, Float.parseFloat(value.toString()));
		} else if (keyType.equals("Long")) {
			dataObject.set(key, Long.parseLong(value.toString()));
		} else if (keyType.equals("Double")) {
			dataObject.set(key, Double.parseDouble(value.toString()));
		} else if (keyType.equals("Decimal")) {
			BigDecimal big1 = new BigDecimal(value.toString());
			dataObject.set(key, big1);
		} else if (keyType.equals("Boolean")) {
			dataObject.set(key, Boolean.parseBoolean(value.toString()));
		} else if (keyType.equals("Date")) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			try {
				Date d = format.parse(value.toString());
				dataObject.set(key, d);
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (keyType.equals("Time")) {
			SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
			try {
				Date d = format.parse(value.toString());
				dataObject.set(key, d);
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (keyType.equals("TimeStamp")) {
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				Date d = (Date) f.parseObject(value.toString());
				Timestamp ts = new Timestamp(d.getTime());
				dataObject.set(key, ts);
			} catch (ParseException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (keyType.equals("ClobString")
				|| keyType.equals("BlobByteArray")
				|| keyType.equals("ClobFile") || keyType.equals("BlobFile")
				|| keyType.equals("Byte")) {
			dataObject.set(key, value);
		} else if (keyType.equals("Short")) {
			dataObject.set(key, Short.parseShort(value.toString()));
		} else {//其他类型，主要是子表哦类型
			String sonEntity = key.getType().getURI() + "."
					+ key.getType().getName(); //拼接子表实体名称
			if (key.getType().getURI().isEmpty()
					|| key.getType().getName().isEmpty()) {
				dataObject.set(key, value);
			} else {
				try {
					dataObject.set(
							key,
							convertJsonStringToDataObjects(sonEntity,
									value.toString()));
				} catch (JSONException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			}
		}
		return dataObject;
	}
}
