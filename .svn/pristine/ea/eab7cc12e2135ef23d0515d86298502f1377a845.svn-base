package com.cjhxfund.ats.fm.comm;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.eos.infra.config.Configuration;
import com.eos.runtime.core.ApplicationContext;

public class ConfigFileUtil {
	/**
	 * 获取配置文件对象
	 * 
	 * @param path
	 *            配置文件路径
	 * @return
	 */
	public static Configuration getConfigFile(String path) {
		
		String configPath;
		Configuration ipConfig;
		try {
			configPath = ApplicationContext.getInstance().getWarRealPath()
					+ path;
			ipConfig = Configuration.initConfiguration(configPath);
		} catch (Exception e) {
			e.printStackTrace();
			ipConfig = null;
		}
		return ipConfig;
	}

	public static String txt2String(File file) {
		String result = "";
		try {
			InputStreamReader read = new InputStreamReader(new FileInputStream(file),"UTF-8");       
            BufferedReader br=new BufferedReader(read);   
			String s = null;
			while ((s = br.readLine()) != null) {// 使用readLine方法，一次读一行
				result = result + s;
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/*
	 * 判断传入的文件路径是否存在该文件，若存在，则返回true,否则返回false
	 * String filePath	配置文件的路径（全名，具体到后缀）
	 */
	public boolean createConfigXml(String filePath){
		boolean falg = false;
		try{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document document = builder.newDocument();
			//创建根节点
			Element root = document.createElement("root");
			document.appendChild(root);
			//转成xml文件
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer transformer = tf.newTransformer();
			DOMSource source = new DOMSource(document);
			transformer.setOutputProperty(OutputKeys.ENCODING, "GB2312");
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			PrintWriter pw = new PrintWriter(new FileOutputStream(filePath));
			StreamResult result = new StreamResult(pw);
			transformer.transform(source, result);
			falg = true;
		}catch(Exception e){
			e.printStackTrace();
			falg = false;
		}
		return falg;
	}
	

}
