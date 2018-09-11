package com.cjhxfund.fpm.bpsExpend;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;

import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.impl.HttpClientUtil;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.params.ModifiableSolrParams;

public class ConnectSolr {
	private Logger log = Logger.getLogger(ConnectSolr.class);
	//solr4服务器的地址  
	//private final static String SOLR_URL = "http://localhost:8089/solr/coreNew";  
	//private final static String fullImportUrl="http://localhost:8089/solr/coreNew/dataimport?command=full-import&clean=true&commit=true";
	//solr7服务器的地址  
	//private final static String SOLR_URL = "http://localhost:8983/solr/fpms_solr";
	//private final static String fullImportUrl = "http://localhost:8983/solr/fpms_solr/dataimport?command=full-import&clean=true&commit=true";
    private static Properties paramProperties=null;
    private static HttpSolrServer client = null;
    private static String solr_url;
    private static String solr_fullimporturl;
    private static int solr_rownumber;
    private static int solr_connect_timeout;
    private static int solr_read_timeout;
    private static int solr_connectPool_number;
    private static int solr_connect_total;
    private static String solr_product_user;
    private static String solr_product_pwd;
    private static ConnectSolr solrObj = new ConnectSolr();
    
    public static ConnectSolr getInstance(){
    	return solrObj;
    }
    /**
     * 获取显示行数
     * @return
     */
    public int getRowNumber() {
		return solr_rownumber;
	}
    /**
     * 初始化参数
     */
	public void init(String prefix){
		log.debug("ConnectSolr[init]load solr parameter comming:"+prefix+","+paramProperties);
    	  if(paramProperties==null || paramProperties.isEmpty() || solr_product_user==null || "".equals(solr_product_user)){
    		  paramProperties = new Properties();
    		  try {
    			String packpath = "class";
    			String projectPath=ConnectSolr.class.getClassLoader().getResource("").getPath();
    			int leng = projectPath.indexOf(packpath);
    			String path = projectPath.substring(0,leng); //start main close
    			//String path="D:/生命周期(plms)/branch/Ver2.1.0.0-forNewFrame/com.cjhxfund.fpm.bpsExpend/src/META-INF/resources/solr/solr.properties";
    			path=path.replace("\\", "/"); //start main close 
    			path+="_srv/work/user/com.cjhxfund.fpm.bpsExpend/META-INF/resources/solr/solr.properties"; //start main close
    			File file = new File(path);
    			log.info("ConnectSolr[init]load parameter path:"+path);
    			InputStream input = new BufferedInputStream (new FileInputStream(file));
				paramProperties.load(input);
				solr_url = paramProperties.getProperty(prefix+".url");
			    solr_fullimporturl = paramProperties.getProperty(prefix+".fullimporturl");
			    solr_rownumber = Integer.parseInt(paramProperties.getProperty(prefix+".rownumber"));
			    solr_connect_timeout = Integer.parseInt(paramProperties.getProperty(prefix+".connect_timeout"));
			    solr_read_timeout = Integer.parseInt(paramProperties.getProperty(prefix+".read_timeout"));
			    solr_connectPool_number = Integer.parseInt(paramProperties.getProperty(prefix+".connectpool_number"));
			    solr_connect_total = Integer.parseInt(paramProperties.getProperty(prefix+".connect_total"));
			    solr_product_user=paramProperties.getProperty(prefix+".user");
			    solr_product_pwd=paramProperties.getProperty(prefix+".pwd");;
			  } catch (IOException e) {
			    log.error("class ConnectSolr init data eror"+e.getMessage());
			  }
    	  }
		log.debug("ConnectSolr[init]load solr parameter :"+solr_url+","+solr_fullimporturl+","+solr_rownumber+","+solr_connect_timeout+","+solr_read_timeout
				+","+solr_connectPool_number+","+solr_connect_total+","+solr_product_user);
    }
	/**
	 * 创建SolrServer对象
	 * jdk需要使用1.7以上。
	 * @return
	 */
	public void createSolrServer() {
		if(client==null){
			if(solr_product_user!=null && !"".equals(solr_product_user)){
				ModifiableSolrParams params = new ModifiableSolrParams();
				params.set(HttpClientUtil.PROP_BASIC_AUTH_USER, solr_product_user);
				params.set(HttpClientUtil.PROP_BASIC_AUTH_PASS, solr_product_pwd);
				HttpClient httpClient = HttpClientUtil.createClient(params);
				client = new HttpSolrServer(solr_url,httpClient);
				client.setConnectionTimeout(solr_connect_timeout); 
				client.setSoTimeout(solr_read_timeout); 
			}else{
				client = new HttpSolrServer(solr_url);
				client.setConnectionTimeout(solr_connect_timeout); 
				client.setSoTimeout(solr_read_timeout); 
				client.setDefaultMaxConnectionsPerHost(solr_connectPool_number); 
				client.setMaxTotalConnections(solr_connect_total); 
			}
		}
	}

	/** 
	 *删除文档中所有数据
	 */
	public void deleteDocument() throws Exception {
		createSolrServer();
		//删除所有的索引
		client.deleteByQuery("*:*");
		//提交修改  
		client.commit();
		closeClient(client);
	}
	/**
	 * 重新load data
	 * @param completeUrl
	 * @throws Exception
	 */
	public void reloadFullData(String completeUrl) throws Exception {
		try {
			URL url = new URL(completeUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("type", "submit");
			conn.setDoOutput(true);
			// Send HTTP POST                                                                      
			conn.connect();
			log.info(completeUrl
					+ "<ConnectSolr[querySolrValue]> Response message\t\t\t"
					+ conn.getResponseCode() + " : "
					+ conn.getResponseMessage());

			conn.disconnect();
		} catch (Exception e) {
			log.error(completeUrl + "<ConnectSolr[querySolrValue]> Process error "
					+ e.getMessage());
		}
	}
	/**
	 * 加载数据
	 * @param prefix properties中前缀
	 * @return
	 * @throws Exception
	 */
    public HttpSolrServer load(String prefix) throws Exception {
    	log.debug("ConnectSolr[load] comming");
    	//初始化
    	init(prefix);
    	log.debug("ConnectSolr[load] init end");
    	//删除所有数据文档
		//deleteDocument();
		//log.info("ConnectSolr[load] delete document end");
    	//创建服务
    	createSolrServer();
    	log.debug("ConnectSolr[load] create server");
		//重新创建数据文档
		//reloadFullData(solr_fullimporturl);
		//log.info("ConnectSolr[load] create document end");
		return client;
    }
    
    public void closeClient(HttpSolrServer solr){
    	if(solr!=null){
    		solr.shutdown();
    	}
    	if(client!=null){
		   client=null;
    	}
    }
    /**
     * 从表中导入数据
     * @param prefix properties中的前缀
     */
    public void importDataToSolr(String prefix){
      try{
			init(prefix);
			deleteDocument();
			reloadFullData(solr_fullimporturl);
			log.info("ConnectSolr[importDataToSolr] 导入完成 ");
    	}catch(Exception e){
    		e.printStackTrace();
    		log.info("ConnectSolr[importDataToSolr] import data error"+e.getMessage());
    	}
    }
	public static void main(String[] args) throws Exception {
		ConnectSolr obj = new ConnectSolr();
		//HttpSolrClient solr = obj.createSolrServer();
		// solr.addDoc();
        obj.importDataToSolr("product");
		System.out.println("导入完成");
		//obj.querySolrValue("创金合信",0);
	}

}
