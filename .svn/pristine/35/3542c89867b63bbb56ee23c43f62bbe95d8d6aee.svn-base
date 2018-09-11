package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.UpdateResponse;
import org.apache.solr.common.SolrInputDocument;

import com.eos.system.annotation.Bizlet;

/**
 * 
 * solr针对单个数据进行新增及修改
 * @author chenxing
 *
 */
@Bizlet("solr针对单个数据进行新增及修改,删除")
public class AddOrUpdSolrData {

	private Logger log = Logger.getLogger(QueryProductData.class);
	private static ConnectSolr solr;
	private HttpSolrServer solrServer;

	public void init() {
		if (solr == null) {
			solr = new ConnectSolr();
		}
	}

	/**
	 * 用于往solr环境中增加数据
	 * @param prefix solr配置文件前缀
	 * @param fieldNameList field名称
	 * @param ValueList field名称对应的值
	 */
	@Bizlet("用于往solr环境中增加数据")
	public void addData(String prefix, List<String> fieldNameList,
			List<String> ValueList) {
		try {
			log.info("AddOrUpdSolrData[addData] comming prefix="+prefix+" :fieldNameList="+fieldNameList+": ValueList="+ValueList);
			init();
			solrServer = solr.load(prefix);
			log.info("AddOrUpdSolrData[addData] load end");
			SolrInputDocument doc = new SolrInputDocument();
			for (int i = 0; i < fieldNameList.size(); i++) {
				doc.addField(fieldNameList.get(i), ValueList.get(i));
			}
			solrServer.add(doc);
			solrServer.optimize();
			UpdateResponse rsp = solrServer.commit();
			log.info("AddOrUpdSolrData[delData] add end " + rsp.getStatus()); //0=successful
		} catch (Exception e) {
			e.printStackTrace();
			log.error("AddOrUpdSolrData[addData] error " + e.getMessage());
		} finally {
			solr.closeClient(solrServer);
		}
	}

	/**
	 * 用于往solr环境中增加数据
	 * @param prefix solr配置文件前缀
	 * @param fieldNameList field名称
	 * @param ValueList field名称对应的值
	 * @param idkey 主键field
	 * @param idValue 主键对应的value
	 */
	@Bizlet("用于往solr环境中增加数据")
	public void updData(String prefix, List<String> fieldNameList,
			List<String> ValueList, String idkey, String idValue) {
		try {
			log.info("AddOrUpdSolrData[updData] comming prefix="+prefix+":fieldNameList="+fieldNameList+": ValueList="+ValueList+": id="+idkey+","+idValue);
			init();
			solrServer = solr.load(prefix);
			SolrInputDocument doc = new SolrInputDocument();
			doc.addField(idkey, idValue);
			for (int i = 0; i < fieldNameList.size(); i++) {
				doc.addField(fieldNameList.get(i), ValueList.get(i));
			}
			solrServer.add(doc);
			UpdateResponse rsp = solrServer.commit();
			log.info("AddOrUpdSolrData[updData] update end " + rsp.getStatus()); //0=successful
			//System.out.println("update="+rsp.getStatus()); 
		} catch (Exception e) {
			e.printStackTrace();
			log.error("AddOrUpdSolrData[updData] error " + e.getMessage());
		} finally {
			solr.closeClient(solrServer);
		}
	}

	/**
	 * @param id 主健value值
	 * @param prefix solr配置文件前缀
	 * 用于往solr环境中删除数据
	 */
	@Bizlet("用于往solr环境中删除数据")
	public void delData(String prefix, String id) {
		log.info("AddOrUpdSolrData[delData] comming prefix="+prefix+": id="+id);
		init();
		try {
			solrServer = solr.load(prefix);
			solrServer.deleteById(id);
			solrServer.commit();
			log.info("AddOrUpdSolrData[delData] delete end");
		} catch (Exception e) {
			e.printStackTrace();
			log.error("AddOrUpdSolrData[delData] error " + e.getMessage());
		} finally {
			solr.closeClient(solrServer);
		}
	}
	
	/**
	 * 测试
	 */
	public static void main(String[] args){
		AddOrUpdSolrData solrAu = new AddOrUpdSolrData();
		String prefix="product";
		List<String> fieldList = new ArrayList<String>();
		//String id,String name,String nameEn,String nameHeadEn
		//新增
//		fieldList.add("sysid");
//		fieldList.add("prod_name");
//		fieldList.add("prod_name_en");
//		fieldList.add("prod_name_sim_en");
		//修改
//		fieldList.add("prod_name");
//		fieldList.add("prod_name_en");
//		fieldList.add("prod_name_sim_en");
//		fieldList.add("old_prod_name_cn");
//		fieldList.add("old_prod_name_en");
//		fieldList.add("old_prod_name_sim_en");
		//删除
		
		List<String> valueList = new ArrayList<String>();
//		valueList.add("9998");
//		valueList.add("chx测试");
//		valueList.add("chxceshi");
//		valueList.add("chxcs");
		//修改
//		valueList.add("测试工作120");
//		valueList.add("ceshigongzuo120");
//		valueList.add("csgz120(原chx测试)");
//		valueList.add("chx测试");
//		valueList.add("chxceshi");
//		valueList.add("chxcs");
	    //删除
		//solrAu.addData(prefix, fieldList, valueList);
		//solrAu.updData(prefix, fieldList, valueList, "sysid", "9998");
		solrAu.delData(prefix, "9998");
	}
}
