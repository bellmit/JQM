/**
 * 
 */
package com.cjhxfund.commonUtil;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import com.cjhxfund.commonUtil.MailManager;
import com.eos.runtime.core.ApplicationContext;
import com.eos.system.annotation.Bizlet;
import com.eos.system.log.LogFactory;
import com.eos.system.logging.Logger;
import commonj.sdo.DataObject;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @author 陈迪
 * @date 2016-12-13 11:05:42
 *
 */
@Bizlet("freemarker模版工具")
public class MailTemplateUtil {
	//日志记录对象
	protected static final Logger logger = LogFactory.getLogger(MailManager.class);
    //模板文件路径
    private static String templatePath = MailTemplateUtil.getLocation()+"/com.cjhxfund.commonUtil/META-INF/ftl";
	//模板文件内容编码
    private static final String ENCODING = "UTF-8";
    //模板生成配置
    private static Configuration conf = new Configuration();
    //邮件模板缓存池
    private static Map<String, Template> tempMap = new HashMap<String, Template>();
    static {
        //创建文件对象
    	File file=new File(templatePath);
        try {
        	//设置模板文件路径
			conf.setDirectoryForTemplateLoading(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    /**
     * 获取应用用户相关构件存储库路径
     * @author 陈迪
     * @date:2016-12-12 11:09:05
     * @return path(详情见eos帮助手册)
     */
    @Bizlet("获取应用用户相关构件存储库路径")
    public static String getLocation(){
    	//取得应用的上下文信息
    	ApplicationContext applicationContext = ApplicationContext.getInstance();
    	//获取应用用户相关构件存储库路径(.../ats/WEB-INF/_srv/work/user)
    	return applicationContext.getApplicationUserWorkingPath();
    }
    /**
     * 通过模板文件名称获取指定模板
     * 
     * @author 陈迪
     * @date:2016-12-12 11:09:05
     * @param name 模板文件名称
     * @return Template 模板对象
     * @throws IOException
     * @Description:
     * @return Template
     */
    private static Template getTemplateByName(String name) throws IOException {
        /***如果启用缓存，则每次修改ftl模版都需要重启，所以建议开发测试阶段不启用缓存，注释掉以下代码
         	if (tempMap.containsKey(name)) {
            	// 缓存中有该模板直接返回
            	return tempMap.get(name);
        	}
        	conf.setOutputEncoding(ENCODING);
        	tempMap.put(name, temp);
        ***/
    	if (tempMap.containsKey(name)) {
            // 缓存中有该模板直接返回
            return tempMap.get(name);
        }
        // 缓存中没有该模板时，生成新模板并放入缓存中
        Template temp = conf.getTemplate(name,ENCODING);
        conf.setOutputEncoding(ENCODING);
        tempMap.put(name, temp);
        return temp;
    }
 
    /**
     * 根据指定模板将内容输出到控制台
     * 
     * @author 陈迪
     * @date 2016-12-12 11:09:05
     * @param name 模板文件名称
     * @param map 与模板内容转换对象
     * @Description:
     * @return void
     */
    public static void outputToConsole(String name, Map<String, String> map) {
        try {
            // 通过Template可以将模板文件输出到相应的流
            Template temp = getTemplateByName(name);
            temp.setEncoding(ENCODING);
            temp.process(map, new PrintWriter(System.out));
        } catch (TemplateException e) {
        	logger.error(e.toString(), e);
        } catch (IOException e) {
        	logger.error(e.toString(), e);
        }
    }
 
    /**
     * 根据指定模板将内容直接输出到文件
     * 
     * @author 陈迪
     * @date 2016-12-12 11:09:05
     * @param name 模板文件名称
     * @param map 与模板内容转换对象
     * @param outFile 输出的文件绝对路径
     * @Description:
     * @return void
     */
    public static void outputToFile(String name, Map<String, String> map,
            String outFile) {
        FileWriter out = null;
        try {
            out = new FileWriter(new File(outFile));
            Template temp = getTemplateByName(name);
            temp.setEncoding(ENCODING);
            temp.process(map, out);
        } catch (IOException e) {
        	logger.error(e.toString(), e);
        } catch (TemplateException e) {
        	logger.error(e.toString(), e);
        } finally {
            try {
                if (out != null)
                    out.close();
            } catch (IOException e) {
            	logger.error(e.toString(), e);
            }
        }
    }
    /**
     * 
     * @author 陈迪
     * @date 2016-12-12 11:09:05 
     * @param name 模板文件的名称
     * @param dataObject 与模板内容转换对象
     * @throws IOException
     * @throws TemplateException
     * @Description:
     * @return String
     */
    @Bizlet("将模版内容转化为字符串")
    public static String getStringFromFtl(String name,
    		DataObject dataObject) throws IOException, TemplateException {
        Writer out = new StringWriter(2048);
        //创建模版对象
        Template temp = getTemplateByName(name);
        //设置模版编码
        temp.setEncoding(ENCODING);
        //模板内容转换对象
        temp.process(dataObject, out);
        return out.toString();
    }
}
