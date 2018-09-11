package com.cjhxfund.ats.fm.comm;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import com.eos.foundation.common.io.FileUtil;
import com.eos.system.annotation.Bizlet;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Bizlet("")
public class FreemarkerTemplate {

	private static Configuration configuration = null;

	/**
	 * 根据模板生成相应的文件
	 * 
	 * @param map
	 *            保存数据的map
	 * @param template
	 *            模板文件的地址
	 * @param path
	 *            生成的文档输出地址
	 * @param fileName
	 *            word文件名
	 * @return
	 */
	@Bizlet("")
	public synchronized static File process(Map<?, ?> map, String template,
			String path, String fileName) {
		if (null == map) {
			throw new RuntimeException("数据不能为空");
		}
		if (null == template) {
			throw new RuntimeException("模板文件不能为空");
		}
		if (null == path) {
			throw new RuntimeException("输出路径不能为空");
		}
		int templatePathIndex = template.lastIndexOf("/");
		if (templatePathIndex == -1) {
			templatePathIndex = template.lastIndexOf(File.separator);
		}
		String templatePath = template.substring(0, templatePathIndex);
		try {
			FileUtil.mkDir(templatePath);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		String templateName = template.substring(templatePathIndex + 1,
				template.length());
		if (null == configuration) {
			// 这里Configurantion对象不能有两个，否则多线程访问会报错
			configuration = new Configuration();
			configuration.setDefaultEncoding("utf-8");
			configuration.setClassicCompatible(true);
		}
		try {
			configuration
					.setDirectoryForTemplateLoading(new File(templatePath));
		} catch (Exception e) {
			throw new RuntimeException("模板文件加载失败");
		}
		StringBuilder sb = new StringBuilder();
		sb.append(path)
				.append(File.separator)
				.append(DateUtil
						.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER))
				.append("_").append(fileName).append(".doc");

		String filePath = sb.toString();
		try {
			FileUtil.mkDir(path);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		File file = new File(filePath);
		try {
			Template t = null;
			t = configuration.getTemplate(templateName);
			Writer w = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "utf-8"));
			// 这里w是一个输出地址，可以输出到任何位置，如控制台，网页等
			t.process(map, w);
			w.close();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return file;
	}

	/**
	 * 获取文件对象的文件名。如果File对象不为普通对象，函数返回空字符串。
	 * 
	 * @param file
	 * @return
	 */
	@Bizlet("")
	public static String getFileName(File file) {
		if (file.isFile()) {
			return file.getName();
		}
		return "";
	}
	/**
	 * 计算文件包含多少kb的数据，计算结果只保留整数。
	 * @param file
	 * @return
	 */
	@Bizlet("")
	public static String getFileSize(File file) {
		FileInputStream input = null;
		if (file.isFile()) {
			try {
				input = new FileInputStream(file);
				int size = input.available()/1024;
				return String.valueOf(size);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (input != null) {
						input.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
		return "";
	}

	public static void main(String[] args) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("orgName", "测试18");
		System.out.println(getFileSize(process(map, "C:\\Users\\zhoulin\\Desktop\\申购函.xml",
				"C:\\Users\\zhoulin\\Desktop\\docs", "国企活力")));
	}

}
