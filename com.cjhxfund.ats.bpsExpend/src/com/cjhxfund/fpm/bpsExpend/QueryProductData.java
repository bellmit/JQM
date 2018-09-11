package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrRequest.METHOD;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.ModifiableSolrParams;

import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

public class QueryProductData{
	
	private Logger log = Logger.getLogger(QueryProductData.class);
	/**
	 * @param queryName 
	 * 查询
	 * @throws Exception 
	 */
	@Bizlet("从solr中获取数据")
	public List queryProductName(String queryName,int rowStart) {
		
		HttpSolrServer solrServer = null;
		ConnectSolr solr = ConnectSolr.getInstance();
		//result
		List<DataObject> resultList=null;
		try {
				solrServer = solr.load("product");
				QueryResponse response = null;
				//下面设置solr查询参数
				if(queryName!=null && !"".equals(queryName)){
					// query.setQuery("*:*");
					 ModifiableSolrParams params = new ModifiableSolrParams();  
					// query.addFilterQuery("prod_name:" + "*"+queryName+"* or ");
					 String queryStr = "prod_name:*"+queryName+"* or prod_name_en:*"+queryName+"* or prod_name_sim_en:*"+queryName+"* or old_prod_name_cn:"
							 +"*"+queryName+"* or old_prod_name_en:*"+queryName+"* or old_prod_name_sim_en:*"+queryName+"*";
					 params.add("q", "*:*");
					 params.add("fq",queryStr);
				     params.add("start", rowStart+"");
				     params.add("rows", solr.getRowNumber()+"");
					//query.set("q",queryName); //联想查询
				     response = solrServer.query(params);
				}else{
					SolrQuery query = new SolrQuery();
					query.set("q", "*:*");// 参数q  查询所有   
					//设置分页参数  
					query.setStart(rowStart);
					query.setRows(solr.getRowNumber());//每一页多少值  
					//获取查询结果
					response = solrServer.query(query,METHOD.POST);
				}
				//参数fq, 给query增加过滤查询条件  
				//query.addFilterQuery("id:[0 TO 9]");//id为0-4  
				//参数df,给query设置默认搜索域  
				//query.set("df", "all");
				//参数sort,设置返回结果的排序规则  
				//query.setSort("id",SolrQuery.ORDER.desc);
				//return fields
			    //query.set("fl", "sysid prod_name prod_name_en prod_name_sim_en");
				//参数hl,设置高亮  
				//query.setHighlight(true);
				//查询得到文档的集合  
				SolrDocumentList solrDocumentList = response.getResults();
				log.info("queryProductName[queryProductName] solr data count" + solrDocumentList.getNumFound());
				//遍历列表  
			   if(solrDocumentList.getNumFound()>0){
				   resultList=new ArrayList<DataObject>();
				   for (SolrDocument doc : solrDocumentList) {
						  //System.out.println("id:"+doc.get("sysid")+"   name:"+doc.get("prod_name")+"    description:"+doc.get("prod_code"));
						  log.info("queryProductName[queryProductName] id:"+doc.get("sysid")+"   name:"+doc.get("prod_name"));
						  DataObject data = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.pmProdCommInfo.PmProdCommInfo");
						  data.setString("sysid", (String)doc.get("sysid"));
						  data.setString("prodName", (String)doc.get("prod_name"));
						  resultList.add(data);
					} 
			   }
		} catch (Exception e) {
			e.printStackTrace();
			log.error("QueryProductData[queryProductName] error="+e.getMessage());
		} finally{
		    solr.closeClient(solrServer);
		}
		return resultList;
	}
	
}
