package com.cjhxfund.jy.ProductProcess;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.CoframeSupplement;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.eos.system.utility.StringUtil;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * 投顾指令单流程处理公共类
 * @author huangmizhi
 * @date 2015-10-13 14:27:07
 */
@Bizlet("投顾指令单流程处理公共类")
public class ProductProcessUtil {
	
	/** 组合产品与处理人员权限的关系类型 */
	public static final String CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE = "CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE";
	/** 债券类别 */
	public static final String CF_JY_PRODUCT_PROCESS_BOND_CATEGORY = "CF_JY_PRODUCT_PROCESS_BOND_CATEGORY";
	/** 债券评级 */
	public static final String CF_JY_PRODUCT_PROCESS_BOND_RATING = "CF_JY_PRODUCT_PROCESS_BOND_RATING";
	/** 清算速度 */
	public static final String CF_JY_PRODUCT_PROCESS_CLEARING_SPEED = "CF_JY_PRODUCT_PROCESS_CLEARING_SPEED";
	/** 清算类型 */
	public static final String CF_JY_PRODUCT_PROCESS_CLEAR_TYPE = "CF_JY_PRODUCT_PROCESS_CLEAR_TYPE";
	/** 要求到账时间 */
	public static final String CF_JY_PRODUCT_PROCESS_DEMAND_ARRIVAL_TIME = "CF_JY_PRODUCT_PROCESS_DEMAND_ARRIVAL_TIME";
	/** 提前支取条款类型 */
	public static final String CF_JY_PRODUCT_PROCESS_EARLY_WITHDRAWAL_CLAUSE = "CF_JY_PRODUCT_PROCESS_EARLY_WITHDRAWAL_CLAUSE";
	/** 收益率类型 */
	public static final String CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE = "CF_JY_PRODUCT_PROCESS_INTEREST_RATE_TYPE";
	/** 缴款场所 */
	public static final String CF_JY_PRODUCT_PROCESS_PAYMENT_PLACE = "CF_JY_PRODUCT_PROCESS_PAYMENT_PLACE";
	/** 指令/建议流程处理状态 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_STATUS = "CF_JY_PRODUCT_PROCESS_PROCESS_STATUS";
	/** 业务类别_基金申赎 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS = "CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_JJSS";
	/** 业务类别_同业存取 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_TYCQ = "CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_TYCQ";
	/** 业务类别_追加提取 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZJZT = "CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZJZT";
	/** 业务类别_正逆回购 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG = "CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZNHG";
	/** 业务类别_债券买卖 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM = "CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQMM";
	/** 业务类别_申购缴款 */
	public static final String CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ = "CF_JY_PRODUCT_PROCESS_PROCESS_TYPE_ZQSJ";
	/** 评级机构 */
	public static final String CF_JY_PRODUCT_PROCESS_RATING_AGENCIES = "CF_JY_PRODUCT_PROCESS_RATING_AGENCIES";
	/** 主体评级 */
	public static final String CF_JY_PRODUCT_PROCESS_SUBJECT_RATING = "CF_JY_PRODUCT_PROCESS_SUBJECT_RATING";
	/** 交易场所 */
	public static final String CF_JY_PRODUCT_PROCESS_TRADING_PLACE = "CF_JY_PRODUCT_PROCESS_TRADING_PLACE";
	/** 投标场所 */
	public static final String CF_JY_PRODUCT_PROCESS_TRADING_PLACE_3 = "CF_JY_PRODUCT_PROCESS_TRADING_PLACE_3";
	/** 交易状态 */
	public static final String CF_JY_PRODUCT_PROCESS_VALID_STATUS = "CF_JY_PRODUCT_PROCESS_VALID_STATUS";
	/** 买卖方向*/
	public static final String CF_JY_MMFX = "CF_JY_MMFX";
	
	
	
	
	/** 匹配不上恒生系统字典ID时返回的特殊字符：★ */
	public static final String DICT_ID_HS_NO_EXIST = "★";
	/** 存放映射恒生系统数据字典信息 */
	public static Map<String,Map<String,String>> dictInfoMap = new HashMap<String,Map<String,String>>();
	/** 存放机构员工所有userId信息 */
	public static Map<String,String> orgEmpUserIdMap = new HashMap<String,String>();
	
	/** 上传文件保存路径-流程文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG = "/home/ats/FileUploadPath/JQM/LiuCheng/";
	/** 上传文件保存路径-流程文件-用印文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG_YONGYIN = "/home/ats/FileUploadPath/JQM/LiuCheng/YongYin/";
	/** 上传文件保存路径-投票业务文件 */
	public static final String UPLOAD_FILE_PATH_TOUPIAO = "/home/ats/FileUploadPath/JQM/TouPiao/";
	/** 上传文件保存路径-其他指令/建议文件 */
	public static final String UPLOAD_FILE_PATH_QITAZHILING = "/home/ats/FileUploadPath/JQM/QiTaZhiLing/";
	/** 上传文件保存路径-传真文件 */
	public static final String UPLOAD_FILE_PATH_CHUANZHEN = "/home/ats/FileUploadPath/JQM/ChuanZhen/";
	
	
	/**
	 * 根据业务日期、业务类型获取当天投资编号（每天从1开始）
	 * @param processDate 业务日期，格式：20100101
	 * @param processType 业务类别（分六类：1.债券买卖;2.正逆回购;3.申购缴款;4.基金申赎;5.同业存取;6.追加提取;）
	 * 		01-债券买入;02-债券卖出;03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;07-债券申购;08-债券缴款;
	 * 		09-基金申购;10-基金赎回;11-基金转换;12-同存存入;13-同存提取;14-资金追加;15-资金提取;99-其他指令/建议;
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static synchronized String getInvestProductNum(String processDate, String processType){
//		if(StringUtils.isBlank(processDate) || StringUtils.isBlank(processType)){
//			return "0";
//		}
//		Connection conn = null;
//		String result = "0";
//		try {
//			//获取默认连接
//			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
//			
//			//根据业务日期、业务类型获取当天投资编号（每天从1开始）
//			String sql = "select nvl(max(t.invest_product_num),0)+1 invest_product_num from CF_JY_PRODUCT_PROCESS t where to_char(t.process_date, 'yyyyMMdd')='"+processDate.replaceAll("-", "")+"' and t.process_type in ("+StrUtil.changeInStr(processType)+")";
//			result = JDBCUtil.getValueBySql(conn, sql);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			JDBCUtil.releaseResource(conn, null, null);
//		}
//		return result;
		
		String result = "";
		try {
			//获取投资编号，系统唯一性
			long investProductNum = DatabaseExt.getNextSequence("CF_JY_P_P_I_PRO_NUM_SEQ");
			result = String.valueOf(investProductNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 通过关键字、产品代码到O32系统查找产品
	 * @param searchKey 关键字
	 * @param productCodes 产品代码（为空则不过滤该条件）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getProductsByKey(String searchKey, String productCodes){
		searchKey = searchKey==null?"":searchKey;
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct t.vc_fund_code, ")//产品代码
			  .append("                t.vc_fund_name, ")//产品名称
			  .append("                t.vc_fund_code || '-' || t.vc_fund_name fundCodeName ")//产品代码+产品名称
			  .append("  from trade.tfundinfo t ")
			  .append(" where 1 = 1 ")
			  .append("   and (t.vc_fund_code like '%").append(searchKey).append("%' or t.vc_fund_name like '%").append(searchKey).append("%') ");
			  
			if(StringUtils.isNotBlank(productCodes)){
				sb.append(" and t.vc_fund_code in (").append(StrUtil.changeInStr(productCodes)).append(") ");
			}
			//限制每次只查询20条记录
			sb.append("   and rownum<=20 ")
			  .append(" order by t.vc_fund_code asc");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_fund_code = map.get("VC_FUND_CODE");
					String vc_fund_name = map.get("VC_FUND_NAME");
					String fundCodeName = map.get("FUNDCODENAME");
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.CombProduct");
					obj.setString("fundCode", vc_fund_code);
					obj.setString("fundName", vc_fund_name);
					obj.setString("fundCodeName", fundCodeName);
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 通过关键字、产品代码、组合编号到O32系统查找产品、投资组合等信息
	 * @param searchKey 关键字
	 * @param productCodes 产品代码（为空则不过滤该条件）
	 * @param combiNos 投资组合编号（为空则不过滤该条件）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getProductCombisByKey(String searchKey, String productCodes, String combiNos){
		searchKey = searchKey==null?"":searchKey;
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct t1.vc_fund_code, ")//产品代码
			  .append("                t1.vc_fund_name, ")//产品名称
			  .append("                t1.vc_fund_code || '-' || t1.vc_fund_name fundCodeName, ")//产品代码+产品名称
			  .append("                t2.vc_combi_no, ")//投资组合编号
			  .append("                t2.vc_combi_name, ")//投资组合名称
			  .append("                t2.l_asset_id, ")//资产单元序号
			  .append("                t1.vc_fund_code || '|' || t1.vc_fund_name || '|' || t2.vc_combi_no || '|' || t2.vc_combi_name || '|' || t2.l_asset_id fundInfo ")//产品投资组合信息
			  .append("  from trade.tfundinfo t1, trade.tcombi t2 ")
			  .append(" where t1.l_fund_id = t2.l_fund_id ");
			  
			if(StringUtils.isNotBlank(searchKey)){
				sb.append("   and (t1.vc_fund_code like '%").append(searchKey).append("%' or t1.vc_fund_name like '%").append(searchKey).append("%' or t2.vc_combi_no like '%").append(searchKey).append("%' or t2.vc_combi_name like '%").append(searchKey).append("%') ");
			}
			if(StringUtils.isNotBlank(productCodes)){
				sb.append("   and t1.vc_fund_code in (").append(StrUtil.changeInStr(productCodes)).append(") ");
			}
			if(StringUtils.isNotBlank(combiNos)){
				sb.append("   and t2.vc_combi_no in (").append(StrUtil.changeInStr(combiNos)).append(") ");
			}
			//限制每次只查询20条记录
			sb.append("   and rownum <= 20 ")
			  .append(" order by t1.vc_fund_code asc ");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_fund_code = map.get("VC_FUND_CODE");
					String vc_fund_name = map.get("VC_FUND_NAME");
					String fundCodeName = map.get("FUNDCODENAME");
					String vc_combi_no = map.get("VC_COMBI_NO");
					String vc_combi_name = map.get("VC_COMBI_NAME");
					String l_asset_id = map.get("L_ASSET_ID");
					String fundInfo = map.get("FUNDINFO");
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.CombProduct");
					obj.setString("fundCode", vc_fund_code);
					obj.setString("fundName", vc_fund_name);
					obj.setString("fundCodeName", fundCodeName);
					obj.setString("vcCombiNo", vc_combi_no);
					obj.setString("vcCombiName", vc_combi_name);
					obj.setString("lAssetId", l_asset_id);
					obj.setString("fundInfo", fundInfo);
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 通过关键字到O32系统查找投资的债券、股票等产品信息
	 * @param searchKey 关键字
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getInvestProductsByKey(String searchKey){
		searchKey = searchKey==null?"":searchKey;
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct t.vc_report_code, ")//债券、股票代码
			  .append("                t.vc_stock_name, ")//债券、股票名称
			  .append("                t.vc_report_code || '-' || t.vc_stock_name vc_stock, ")//债券、股票代码+债券、股票名称
			  .append("                t.c_market_no, ")//交易市场编号
			  .append("                t.vc_inter_code ")//证券内码
			  .append("  from trade.TSTOCKINFO t ")
			  .append(" where 1 = 1 ")
			  .append("   and (t.vc_report_code like '%").append(searchKey).append("%' or t.vc_stock_name like '%").append(searchKey).append("%') ")
			  .append("   and rownum<=20 ")//限制每次只查询20条记录
			  .append(" order by t.vc_report_code asc ");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_report_code = map.get("VC_REPORT_CODE");//债券代码
					String vc_stock_name = map.get("VC_STOCK_NAME");//债券名称
					String vc_stock = map.get("VC_STOCK");//债券代码名称
					String c_market_no = map.get("C_MARKET_NO");//交易市场编号
					String vc_inter_code = map.get("VC_INTER_CODE");//证券内码
					
					sb.setLength(0);
					sb.append(vc_report_code)//债券代码
					  .append(",").append(vc_stock_name)//债券名称
					  .append(",").append(c_market_no)//交易市场编号
					  .append(",").append(vc_inter_code);//证券内码
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.InvestProduct");
					obj.setString("investProductCode", vc_report_code);//债券代码
					obj.setString("investProductName", vc_stock_name);//债券名称
					obj.setString("investProduct", vc_stock);//债券代码名称
					obj.setString("investProductInfo", sb.toString());//投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 通过债券代码、债券名称到O32系统查找投资的债券信息
	 * @param vcReportCode 债券代码
	 * @param vcStockName 债券名称
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestProductsByReportCodeAndStockName(String vcReportCode, String vcStockName){
		String result = "";
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句，投资产品信息（债券代码,债券名称,交易市场编号,证券内码）
			sb.append("select distinct t.vc_report_code || ',' || t.vc_stock_name || ',' || ")
			  .append("                t.c_market_no || ',' || t.vc_inter_code investProductInfo ")
			  .append("  from trade.TSTOCKINFO t ")
			  .append(" where 1 = 1 ")
			  .append("   and t.vc_report_code = '" + vcReportCode + "' ")
			  .append("   and t.vc_stock_name = '" + vcStockName + "' ")
			  .append("   and rownum = 1 ");
			
			result = JDBCUtil.getValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 通过交易市场编号、证券申报代码到O32系统查找投资的债券、股票等产品信息（包含债券评级等债券属性）
	 * @param marketNo 交易市场编号
	 * @param reportCode 证券申报代码
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestProductInfoByMarketNoAndReportCode(String marketNo, String reportCode){
		if(StringUtils.isBlank(marketNo) || StringUtils.isBlank(reportCode)){
			return "";
		}
		String result = "";
		StringBuffer sb = new StringBuffer();
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct tt.vc_report_code, ")//债券代码
			  .append("                tt.vc_stock_name, ")//债券名称
			  .append("                tt.vc_report_code || '-' || tt.vc_stock_name vc_stock, ")//债券代码名称
			  .append("                tt.c_stock_type, ")//证券类别代码（债券类别代码）
			  .append("                tt.vc_stocktype_name, ")//证券类别（债券类别名称）
			  .append("                tt.c_outer_appraise_zq, ")// 评级代码（债券评级代码）
			  .append("                tt.vc_item_name_zq, ")//债券评级名称
			  .append("                tt.l_issuer_id, ")//发行人代码
			  .append("                tt.vc_issuer_name, ")//发行人名称
			  .append("                tt.c_lemma_item_zt, ")//主体评级代码
			  .append("                tt.vc_item_name_zt, ")//主体评级
			  .append("                tt.c_lemma_item_pjjg, ")//评级机构代码
			  .append("                tt.vc_item_name_pjjg ")//评级机构名称
			  .append("  from (select distinct t1.vc_report_code, ")//债券代码
			  .append("                        t1.vc_stock_name, ")//债券名称                
			  .append("                        t2.c_stock_type, ")//证券类别代码（债券类别代码）
			  .append("                        t2.vc_stocktype_name, ")//证券类别（债券类别名称）
			  .append("                        t3.c_outer_appraise  c_outer_appraise_zq, ")// 评级代码（债券评级代码）
			  .append("                        t3.vc_item_name      vc_item_name_zq, ")//债券评级名称
			  .append("                        t4.l_issuer_id, ")//发行人代码
			  .append("                        t4.vc_issuer_name, ")//发行人名称
			  .append("                        t4.c_lemma_item      c_lemma_item_zt, ")//主体评级代码
			  .append("                        t4.vc_item_name      vc_item_name_zt, ")//主体评级
			  .append("                        t5.c_lemma_item      c_lemma_item_pjjg, ")//评级机构代码
			  .append("                        t5.vc_item_name      vc_item_name_pjjg ")//评级机构名称
			  .append("          from (select t.vc_report_code, ")
			  .append("                       t.vc_stock_name, ")
			  .append("                       t.c_market_no, ")
			  .append("                       t.c_stock_type, ")
			  .append("                       t.vc_inter_code, ")
			  .append("                       t.L_COMPANY_ID ")
			  .append("                  from trade.tstockinfo t ")//获取债券信息表的数据
			  .append("                 where t.vc_report_code = '" + reportCode + "' ")
			  .append("                   and t.c_market_no = '" + marketNo + "' ) t1")
			  .append("          left join trade.tstocktype t2 ")//
			  .append("            on t1.c_market_no = t2.c_market_no ")//
			  .append("           and t1.c_stock_type = t2.c_stock_type ")//
			  .append("          left join (select c.c_market_no, ")//
			  .append("                           c.vc_inter_code, ")//
			  .append("                           c.C_OUTER_APPRAISE, ")//评级代码
			  .append("                           e.vc_item_name ")//债券评级
			  .append("                      from trade.tbondproperty c, ")//
			  .append("                           (select * ")//
			  .append("                              from trade.tdictionary ")//
			  .append("                             where l_dictionary_no = 60649 ")//
			  .append("                               and C_LEMMA_ITEM <> '!') e ")//
			  .append("                     where c.C_OUTER_APPRAISE = e.c_lemma_item) t3 ")//
			  .append("            on t1.c_market_no = t3.c_market_no ")//
			  .append("           and t1.vc_inter_code = t3.vc_inter_code ")//
			  .append("          left join (select f.l_issuer_id, ")// 发行人代码
			  .append("                           f.vc_issuer_name, ")//发行人名称
			  .append("                           g.c_lemma_item, ")//主体评级代码
			  .append("                           g.vc_item_name ")//主体评级
			  .append("                      from trade.TISSUER f, ")//
			  .append("                           (select * ")//
			  .append("                              from trade.tdictionary ")//
			  .append("                             where l_dictionary_no = 110000 ")//
			  .append("                               and C_LEMMA_ITEM <> '!') g ")//
			  .append("                     where f.C_OUTER_APPRAISE = g.c_lemma_item) t4 ")//
			  .append("            on t1.L_COMPANY_ID = t4.l_issuer_id ")//
			  .append("          left join (select a.c_market_no, ")//
			  .append("                           a.vc_inter_code, ")//
			  .append("                           b.c_lemma_item, ")//评级机构代码
			  .append("                           b.vc_item_name ")//评级机构名称
			  .append("                      from trade.tbondproperty a, ")//
			  .append("                           (select c_lemma_item, vc_item_name ")//
			  .append("                              from trade.tdictionary ")//
			  .append("                             where l_dictionary_no = 60200 ")//
			  .append("                               and C_LEMMA_ITEM <> '!') b ")//
			  .append("                     where a.VC_APPRAISE_ORGAN = b.c_lemma_item) t5 ")//
			  .append("            on t1.c_market_no = t5.c_market_no ")//
			  .append("           and t1.vc_inter_code = t5.vc_inter_code) tt ");//
			
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				Map<String, String> map = list.get(0);
				String vc_report_code = map.get("VC_REPORT_CODE");//债券代码
				String vc_stock_name = map.get("VC_STOCK_NAME");//债券名称
				String vc_stock = map.get("VC_STOCK");//债券代码名称
				String c_stock_type = changeToDictId(CF_JY_PRODUCT_PROCESS_BOND_CATEGORY, map.get("C_STOCK_TYPE"));//证券类别代码（债券类别代码）
				//String vc_stocktype_name = map.get("VC_STOCKTYPE_NAME");//证券类别（债券类别名称）
				String c_outer_appraise_zq = changeToDictId(CF_JY_PRODUCT_PROCESS_BOND_RATING, map.get("C_OUTER_APPRAISE_ZQ"));//评级代码（债券评级代码）
				//String vc_item_name_zq = map.get("VC_ITEM_NAME_ZQ");//债券评级名称
				String c_lemma_item_zt = changeToDictId(CF_JY_PRODUCT_PROCESS_SUBJECT_RATING, map.get("C_LEMMA_ITEM_ZT"));//主体评级代码
				//String vc_item_name_zt = map.get("VC_ITEM_NAME_ZT");//主体评级
				String c_lemma_item_pjjg = changeToDictId(CF_JY_PRODUCT_PROCESS_RATING_AGENCIES, map.get("C_LEMMA_ITEM_PJJG"));//评级机构代码
				//String vc_item_name_pjjg = map.get("VC_ITEM_NAME_PJJG");//评级机构名称
				//String l_issuer_id = map.get("L_ISSUER_ID");//发行人代码
				//String vc_issuer_name = map.get("VC_ISSUER_NAME");//发行人名称
				
				sb.setLength(0);
				sb.append(vc_report_code)//债券代码
				  .append(",").append(vc_stock_name)//债券名称
				  .append(",").append(c_stock_type)//债券类别代码
				  .append(",").append(c_outer_appraise_zq)//债券评级代码
				  .append(",").append(c_lemma_item_zt)//主体评级代码
				  .append(",").append(c_lemma_item_pjjg);//评级机构代码
				
				result = sb.toString();//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	
//	/*****************备份*********************************
//	 * 通过关键字到O32系统查找投资的债券、股票等产品信息
//	 * @param searchKey 关键字
//	 * @return
//	 * @author huangmizhi
//	 */
//	@Bizlet("")
//	public static List<DataObject> getInvestProductsByKey(String searchKey){
//		searchKey = searchKey==null?"":searchKey;
//		List<DataObject> result = new ArrayList<DataObject>();
//		StringBuffer sb = new StringBuffer();
//		DataObject obj = null;
//		Connection conn = null;
//		try {
//			//获取O32系统数据库连接
//			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
//			
//			//拼接SQL语句
////			sb.append("select distinct t.vc_report_code, ")//债券、股票代码
////			  .append("                t.vc_stock_name, ")//债券、股票名称
////			  .append("                t.vc_report_code || '-' || t.vc_stock_name vc_stock ")//债券、股票代码+债券、股票名称
////			  .append("  from trade.TSTOCKINFO t ")
////			  .append(" where 1 = 1 ")
////			  .append("   and (t.vc_report_code like '%").append(searchKey).append("%' or t.vc_stock_name like '%").append(searchKey).append("%') ")
////			  .append("   and rownum<=20 ")
////			  .append(" order by t.vc_report_code asc ");//限制每次只查询20条记录
//			
//			//拼接SQL语句
//			sb.append("select distinct tt.vc_report_code, ")//债券代码
//			  .append("                tt.vc_stock_name, ")//债券名称
//			  .append("                tt.vc_report_code || '-' || tt.vc_stock_name vc_stock, ")//债券代码名称
//			  .append("                tt.c_stock_type, ")//证券类别代码（债券类别代码）
//			  .append("                tt.vc_stocktype_name, ")//证券类别（债券类别名称）
//			  .append("                tt.c_outer_appraise_zq, ")// 评级代码（债券评级代码）
//			  .append("                tt.vc_item_name_zq, ")//债券评级名称
//			  .append("                tt.l_issuer_id, ")//发行人代码
//			  .append("                tt.vc_issuer_name, ")//发行人名称
//			  .append("                tt.c_lemma_item_zt, ")//主体评级代码
//			  .append("                tt.vc_item_name_zt, ")//主体评级
//			  .append("                tt.c_lemma_item_pjjg, ")//评级机构代码
//			  .append("                tt.vc_item_name_pjjg ")//评级机构名称
//			  .append("  from (select distinct t1.vc_report_code, ")//债券代码
//			  .append("                        t1.vc_stock_name, ")//债券名称                
//			  .append("                        t2.c_stock_type, ")//证券类别代码（债券类别代码）
//			  .append("                        t2.vc_stocktype_name, ")//证券类别（债券类别名称）
//			  .append("                        t3.c_outer_appraise  c_outer_appraise_zq, ")// 评级代码（债券评级代码）
//			  .append("                        t3.vc_item_name      vc_item_name_zq, ")//债券评级名称
//			  .append("                        t4.l_issuer_id, ")//发行人代码
//			  .append("                        t4.vc_issuer_name, ")//发行人名称
//			  .append("                        t4.c_lemma_item      c_lemma_item_zt, ")//主体评级代码
//			  .append("                        t4.vc_item_name      vc_item_name_zt, ")//主体评级
//			  .append("                        t5.c_lemma_item      c_lemma_item_pjjg, ")//评级机构代码
//			  .append("                        t5.vc_item_name      vc_item_name_pjjg ")//评级机构名称
//			  .append("          from (select t.vc_report_code, ")
//			  .append("                       t.vc_stock_name, ")
//			  .append("                       t.c_market_no, ")
//			  .append("                       t.c_stock_type, ")
//			  .append("                       t.vc_inter_code, ")
//			  .append("                       t.L_COMPANY_ID ")
//			  .append("                  from trade.tstockinfo t ")//获取债券信息表的数据
//			  .append("                 where (t.vc_report_code like '%").append(searchKey).append("%' or t.vc_stock_name like '%").append(searchKey).append("%') ")
////			  .append("                   and l_date = ")
////			  .append("                       (select l_date ")
////			  .append("                          from (select t.l_date from trade.tstockinfo t order by t.l_date desc) ")
////			  .append("                         where rownum = 1) ")
//			  //以下是获取上一交易日（备份）
//			  .append("                   and l_date = ")
//			  .append("                       (select max(f.l_date) ")
//			  .append("                          from trade.tmarkettradeday f ")
//			  .append("                         where f.vc_tradeday_type = '00' ")
//			  .append("                           and f.c_trade_flag = '1' ")
//			  .append("                           and f.l_date < to_char(sysdate, 'yyyymmdd')) ")
//			  .append("                   and rownum <= 20) t1")//限制每次只查询20条记录
//			  .append("          left join trade.tstocktype t2 ")//
//			  .append("            on t1.c_market_no = t2.c_market_no ")//
//			  .append("           and t1.c_stock_type = t2.c_stock_type ")//
//			  .append("          left join (select c.c_market_no, ")//
//			  .append("                           c.vc_inter_code, ")//
//			  .append("                           c.C_OUTER_APPRAISE, ")//评级代码
//			  .append("                           e.vc_item_name ")//债券评级
//			  .append("                      from trade.thisbondproperty c, ")//
//			  .append("                           (select * ")//
//			  .append("                              from trade.tdictionary ")//
//			  .append("                             where l_dictionary_no = 60649 ")//
//			  .append("                               and C_LEMMA_ITEM <> '!') e ")//
//			  .append("                     where c.C_OUTER_APPRAISE = e.c_lemma_item) t3 ")//
//			  .append("            on t1.c_market_no = t3.c_market_no ")//
//			  .append("           and t1.vc_inter_code = t3.vc_inter_code ")//
//			  .append("          left join (select f.l_issuer_id, ")// 发行人代码
//			  .append("                           f.vc_issuer_name, ")//发行人名称
//			  .append("                           g.c_lemma_item, ")//主体评级代码
//			  .append("                           g.vc_item_name ")//主体评级
//			  .append("                      from trade.TISSUER f, ")//
//			  .append("                           (select * ")//
//			  .append("                              from trade.tdictionary ")//
//			  .append("                             where l_dictionary_no = 110000 ")//
//			  .append("                               and C_LEMMA_ITEM <> '!') g ")//
//			  .append("                     where f.C_OUTER_APPRAISE = g.c_lemma_item) t4 ")//
//			  .append("            on t1.L_COMPANY_ID = t4.l_issuer_id ")//
//			  .append("          left join (select a.c_market_no, ")//
//			  .append("                           a.vc_inter_code, ")//
//			  .append("                           b.c_lemma_item, ")//评级机构代码
//			  .append("                           b.vc_item_name ")//评级机构名称
//			  .append("                      from trade.thisbondproperty a, ")//
//			  .append("                           (select c_lemma_item, vc_item_name ")//
//			  .append("                              from trade.tdictionary ")//
//			  .append("                             where l_dictionary_no = 60200 ")//
//			  .append("                               and C_LEMMA_ITEM <> '!') b ")//
//			  .append("                     where a.VC_APPRAISE_ORGAN = b.c_lemma_item) t5 ")//
//			  .append("            on t1.c_market_no = t5.c_market_no ")//
//			  .append("           and t1.vc_inter_code = t5.vc_inter_code) tt ");//
//			
//			
//			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
//			if(!list.isEmpty() && list.size()>0){
//				for(int i=0; i<list.size(); i++){
//					Map<String, String> map = list.get(i);
//					String vc_report_code = map.get("VC_REPORT_CODE");//债券代码
//					String vc_stock_name = map.get("VC_STOCK_NAME");//债券名称
//					String vc_stock = map.get("VC_STOCK");//债券代码名称
//					String c_stock_type = changeToDictId(CF_JY_PRODUCT_PROCESS_BOND_CATEGORY, map.get("C_STOCK_TYPE"));//证券类别代码（债券类别代码）
//					//String vc_stocktype_name = map.get("VC_STOCKTYPE_NAME");//证券类别（债券类别名称）
//					String c_outer_appraise_zq = changeToDictId(CF_JY_PRODUCT_PROCESS_BOND_RATING, map.get("C_OUTER_APPRAISE_ZQ"));//评级代码（债券评级代码）
//					//String vc_item_name_zq = map.get("VC_ITEM_NAME_ZQ");//债券评级名称
//					String c_lemma_item_zt = changeToDictId(CF_JY_PRODUCT_PROCESS_SUBJECT_RATING, map.get("C_LEMMA_ITEM_ZT"));//主体评级代码
//					//String vc_item_name_zt = map.get("VC_ITEM_NAME_ZT");//主体评级
//					String c_lemma_item_pjjg = changeToDictId(CF_JY_PRODUCT_PROCESS_RATING_AGENCIES, map.get("C_LEMMA_ITEM_PJJG"));//评级机构代码
//					//String vc_item_name_pjjg = map.get("VC_ITEM_NAME_PJJG");//评级机构名称
//					//String l_issuer_id = map.get("L_ISSUER_ID");//发行人代码
//					//String vc_issuer_name = map.get("VC_ISSUER_NAME");//发行人名称
//					
//					sb.setLength(0);
//					sb.append(vc_report_code)//债券代码
//					  .append(",").append(vc_stock_name)//债券名称
//					  .append(",").append(c_stock_type)//债券类别代码
//					  .append(",").append(c_outer_appraise_zq)//债券评级代码
//					  .append(",").append(c_lemma_item_zt)//主体评级代码
//					  .append(",").append(c_lemma_item_pjjg);//评级机构代码
//					
//					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.InvestProduct");
//					obj.setString("investProductCode", vc_report_code);//债券代码
//					obj.setString("investProductName", vc_stock_name);//债券名称
//					obj.setString("investProduct", vc_stock);//债券代码名称
//					obj.setString("investProductInfo", sb.toString());//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
//					
//					result.add(obj);
//					obj = null;
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			sb.setLength(0);
//			sb = null;
//			JDBCUtil.releaseResource(conn, null, null);
//		}
//		return result;
//	}
	
	
	/**
	 * 通过关键字到O32系统查找交易对手
	 * @param searchKey 关键字
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getTradeRivalByKey(String searchKey){
		searchKey = searchKey==null?"":searchKey;
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		Connection conn = null;
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			
			//拼接SQL语句
			sb.append("select distinct t.vc_rival_code, t.vc_name ")
			  .append("  from trade.TTRADERIVAL t ")
			  .append(" where rownum <= 20 ")//限制每次只查询20条记录
			  .append("   and t.vc_name like '%").append(searchKey).append("%' ")
			  .append(" order by t.vc_rival_code asc");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_rival_code = map.get("VC_RIVAL_CODE");//交易对手代码
					String vc_name = map.get("VC_NAME");//交易对手名称
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.TradeRival");
					obj.setString("rivalCode", vc_rival_code);
					obj.setString("rivalName", vc_name);
					
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 根据机构员工主键ID获取userId
	 * @param orgEmpId 机构员工主键ID
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserIdByOrgEmpId(String orgEmpId){
		Connection conn = null;
		String userId = "";
		try {
			if(StringUtils.isBlank(orgEmpId)){
				return userId;
			}
			
			//先到内存查找
			userId = orgEmpUserIdMap.get(orgEmpId);
			
			//若内存中不存在，则到数据库查找，并将查找结果更新内存orgEmpUserIdMap值
			if(StringUtils.isEmpty(userId)){
				//清空内存orgEmpUserIdMap值
				orgEmpUserIdMap.clear();
				
				//获取默认连接
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				//将查找结果更新内存orgEmpUserIdMap值
				orgEmpUserIdMap = CoframeSupplement.getOrgEmpUserIds(conn);
				
				//获取userId
				userId = orgEmpUserIdMap.get(orgEmpId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return userId;
	}
	
	/**
	 * 根据权限关系类型、用户ID获取该用户可查看的产品代码（若条件为空，则查找所有记录）
	 * @param relaType 关系类型：01-组合与投顾录入权限；07-组合与投顾确认权限；02-组合与投资经理权限；03-组合与交易员权限；04-组合与复核员权限；05-组合与送单员权限；06-组合与后台成交员权限；98-后台成交确认阶段权限；99-交易确认阶段权限；A1-投顾录入确认可为同一人员；（为空则不过滤该条件）
	 * @param userId 用户ID（为空则不过滤该条件）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductCodesByRelaTypeAndUserId(String relaType, String userId){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select t.comb_product_code from CF_JY_COMB_PRODUCT_HANDLE t where 1=1 ");
			if(StringUtils.isNotBlank(relaType)){
				sb.append(" and t.rela_type='").append(relaType).append("' ");
			}
			if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_id='").append(userId).append("' ");
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 根据权限关系类型、用户ID、产品代码获取该用户可查看的产品投资组合代码（若条件为空，则查找所有记录）
	 * @param relaType 关系类型：01-组合与投顾录入权限；07-组合与投顾确认权限；02-组合与投资经理权限；03-组合与交易员权限；04-组合与复核员权限；05-组合与送单员权限；06-组合与后台成交员权限；98-后台成交确认阶段权限；99-交易确认阶段权限；A1-投顾录入确认可为同一人员；（为空则不过滤该条件）
	 * @param userId 用户ID（为空则不过滤该条件）
	 * @param combProductCodes 产品代码（为空则不过滤该条件）
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiNos(String relaType, String userId, String combProductCodes){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			sb.append("select t.vc_combi_no from CF_JY_COMB_PRODUCT_HANDLE t where 1=1 ");
			if(StringUtils.isNotBlank(relaType)){
				sb.append(" and t.rela_type='").append(relaType).append("' ");
			}
			if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.user_id='").append(userId).append("' ");
			}
			if(StringUtils.isNotBlank(combProductCodes)){
				sb.append(" and t.comb_product_code in (").append(JDBCUtil.changeInStr(combProductCodes)).append(") ");
			}
			
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 根据业务处理日期查询当天所有业务类型待处理指令单与当天该业务指令单总数比值
	 * @param processDate 业务处理日期，若不传入，则默认取当天日期，格式：yyyyMMdd
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getWaitConfirmByProcessDate(String processDate){
		StringBuffer sb = new StringBuffer();
		String result = "";
		Connection conn = null;
		try {
			//若不传入业务处理日期，则默认取当天日期
			if(StringUtils.isBlank(processDate)){
				processDate = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
			}
			processDate = processDate.replaceAll("-", "");
			
			sb//.append("select --nvl(sum(tt.finish_zqmm), 0) finish_zqmm, ")//当日有效的已完成的指令单数量_债券买卖
			  //.append("       --nvl(sum(tt.nofinish_zqmm), 0) nofinish_zqmm, ")//当日有效的未完成的指令单数量_债券买卖
			  //.append("       --nvl(count(1), 0) total_zqmm, ")//当日有效的指令单总数_债券买卖
			  .append("select nvl(sum(tt.nofinish_zqmm), 0) || '/' || nvl(count(1), 0) nofinish_total_zqmm  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_债券买卖
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_zqmm, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_zqmm ")
			  .append("          from ZHFWPT_JY_ZQMM t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type in ('01', '02')) tt  ")//业务类型：01-债券买入;02-债券卖出;
			  .append("union all ")
			  //.append("select --nvl(sum(tt.finish_znhg), 0) finish_znhg, ")//当日有效的已完成的指令单数量_正逆回购
			  //.append("       --nvl(sum(tt.nofinish_znhg), 0) nofinish_znhg, ")//当日有效的未完成的指令单数量_正逆回购
			  //.append("       --nvl(count(1), 0) total_znhg, ")//当日有效的指令单总数_正逆回购
			  .append("select nvl(sum(tt.nofinish_znhg), 0) || '/' || nvl(count(1), 0) nofinish_total_znhg  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_正逆回购
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_znhg, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_znhg ")
			  .append("          from ZHFWPT_JY_ZNHG t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type in ('03', '04', '05', '06')) tt  ")//业务类型：03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购;
			  .append("union all ")
			  //.append("select --nvl(sum(tt.finish_zqsj), 0) finish_zqsj, ")//当日有效的已完成的指令单数量_申购缴款
			  //.append("       --nvl(sum(tt.nofinish_zqsj), 0) nofinish_zqsj, ")//当日有效的未完成的指令单数量_申购缴款
			  //.append("       --nvl(count(1), 0) total_zqsj, ")//当日有效的指令单总数_申购缴款
			  .append("select nvl(sum(tt.nofinish_zqsj), 0) || '/' || nvl(count(1), 0) nofinish_total_zqsj  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_申购缴款
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_zqsj, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_zqsj ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type in ('07', '08')) tt  ")//业务类型：07-债券申购;08-债券缴款;
			  .append("union all ")
			  //.append("select --nvl(sum(tt.finish_jjss), 0) finish_jjss, ")//当日有效的已完成的指令单数量_基金申赎
			  //.append("       --nvl(sum(tt.nofinish_jjss), 0) nofinish_jjss, ")//当日有效的未完成的指令单数量_基金申赎
			  //.append("       --nvl(count(1), 0) total_jjss, ")//当日有效的指令单总数_基金申赎
			  .append("select nvl(sum(tt.nofinish_jjss), 0) || '/' || nvl(count(1), 0) nofinish_total_jjss  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_基金申赎
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_jjss, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_jjss ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type in ('09', '10', '11')) tt  ")//业务类型：09-基金申购;10-基金赎回;11-基金转换;
			  .append("union all ")
			  //.append("select --nvl(sum(tt.finish_tycq), 0) finish_tycq, ")//当日有效的已完成的指令单数量_同业存取
			  //.append("       --nvl(sum(tt.nofinish_tycq), 0) nofinish_tycq, ")//当日有效的未完成的指令单数量_同业存取
			  //.append("       --nvl(count(1), 0) total_tycq, ")//当日有效的指令单总数_同业存取
			  .append("select nvl(sum(tt.nofinish_tycq), 0) || '/' || nvl(count(1), 0) nofinish_total_tycq  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_同业存取
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_tycq, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_tycq ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type in ('12', '13')) tt  ")//业务类型：12-同存存入;13-同存提取;
			  .append("union all ")
			  //.append("select --nvl(sum(tt.finish_zjzt), 0) finish_zjzt, ")//当日有效的已完成的指令单数量_追加提取
			  //.append("       --nvl(sum(tt.nofinish_zjzt), 0) nofinish_zjzt, ")//当日有效的未完成的指令单数量_追加提取
			  //.append("       --nvl(count(1), 0) total_zjzt, ")//当日有效的指令单总数_追加提取
			  .append("select nvl(sum(tt.nofinish_zjzt), 0) || '/' || nvl(count(1), 0) nofinish_total_zjzt  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_追加提取
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_zjzt, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_zjzt ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type in ('14', '15')) tt  ")//业务类型：14-资金追加;15-资金提取;
			  .append("union all ")
			  .append("select nvl(sum(tt.nofinish_dzjy), 0) || '/' || nvl(count(1), 0) nofinish_total_dzjy  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_大宗交易
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_dzjy, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_dzjy ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type = '19') tt  ")//业务类型：19-大宗交易;
			  .append("union all ")
			  .append("select nvl(sum(tt.nofinish_tp), 0) || '/' || nvl(count(1), 0) nofinish_total_tp  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_投票
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_tp, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_tp ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type = '20') tt  ")//业务类型：20-投票;
			  .append("union all ")
			  //.append("select --nvl(sum(tt.finish_qtzl), 0) finish_qtzl, ")//当日有效的已完成的指令单数量_其他指令/建议
			  //.append("       --nvl(sum(tt.nofinish_qtzl), 0) nofinish_qtzl, ")//当日有效的未完成的指令单数量_其他指令/建议
			  //.append("       --nvl(count(1), 0) total_qtzl, ")//当日有效的指令单总数_其他指令/建议
			  .append("select nvl(sum(tt.nofinish_qtzl), 0) || '/' || nvl(count(1), 0) nofinish_total_qtzl  ")//当日有效的未完成的指令单数量比当日有效的指令单总数_其他指令/建议
			  .append("  from (select decode(t.process_status, 6, 1, 0) finish_qtzl, ")
			  .append("               decode(t.process_status, 6, 0, 1) nofinish_qtzl ")
			  .append("          from CF_JY_PRODUCT_PROCESS t ")
			  .append("         where t.process_date = to_date('"+processDate+"', 'yyyyMMdd')  ")//当日日期
			  .append("           and t.valid_status = '0'  ")//交易状态：0-有效；1-无效-修改；2-无效-废弃；3-有效-退回；4-无效-退回；
			  .append("           and t.process_type = '99') tt  ");//业务类型：99-其他指令/建议;
			
			//获取默认连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			result = JDBCUtil.getListValueBySql(conn, sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 根据字典类型获取该类型全部字典信息并封装为map对象
	 * @param map 
	 * @param dictType 字典类型：CF_JY_PRODUCT_PROCESS_BOND_CATEGORY-债券类别;CF_JY_PRODUCT_PROCESS_BOND_RATING-债券评级;
	 * 							CF_JY_PRODUCT_PROCESS_SUBJECT_RATING-主体评级;CF_JY_PRODUCT_PROCESS_RATING_AGENCIES-评级机构;
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static Map<String,String> getDictByDictType(Map<String,String> map, String dictType){
		//若map为空，先创建对象
		if(map==null){
			map = new HashMap<String,String>();
		
		//map不为空，先清空之前字典信息
		}else{
			map.clear();
		}
		
		//获取字典信息
		DataObject[] dicts = null;
		try {
			ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.jy.ProductProcess.CFJYDictConfigBiz");
			Object[] objArr = comp.invoke("queryCFJYDictConfigByDictTypeAndDictId", new String[]{dictType, null});//调用逻辑流的方法
			if(objArr!=null && objArr.length>0){
				dicts =  (DataObject[]) objArr[0];
			}
		} catch (Throwable e) {
			e.printStackTrace();
		}
		//存在字典信息
		if(dicts!=null && dicts.length>0){
			DataObject dict = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.CfJyDictConfig");
			for(int i=0; i<dicts.length; i++){
				dict = dicts[i];
				String dictId = StrUtil.changeNull(dict.getString("dictId"));//字典ID
				//String dictName = StrUtil.changeNull(dict.getString("dictName"));//字典名称
				String dictIdHs = StrUtil.changeNull(dict.getString("dictIdHs"));//恒生字典ID
				//String dictNameHs = StrUtil.changeNull(dict.getString("dictNameHs"));//恒生字典名称
				if(StringUtil.isNotEmpty(dictIdHs)){
					String[] dictIdHsArr = dictIdHs.replaceAll("；", ",").replaceAll(";", ",").replaceAll("，", ",").split(",");
					for(int j=0; j<dictIdHsArr.length; j++){
						String temp = dictIdHsArr[j];
						if(StringUtils.isNotBlank(temp)){
							map.put(temp.trim(), dictId);
						}
					}
				}
			}
		}
		return map;
	}
	
	/**
	 * 将恒生系统字典ID转换为系统字典ID
	 * @param dictType 字典类型：CF_JY_PRODUCT_PROCESS_BOND_CATEGORY-债券类别;CF_JY_PRODUCT_PROCESS_BOND_RATING-债券评级;
	 * 							CF_JY_PRODUCT_PROCESS_SUBJECT_RATING-主体评级;CF_JY_PRODUCT_PROCESS_RATING_AGENCIES-评级机构;
	 * @param dictIdHS 恒生系统字典ID
	 * @return 系统字典ID，若为空，则返回特殊字符“★”
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String changeToDictId(String dictType, String dictIdHS){
		if(StringUtils.isBlank(dictIdHS)){
			return DICT_ID_HS_NO_EXIST;
		}
		String result = null;
		//若map之前尚未存放该字典类型，则新增该字典类型map
		boolean keyExist = dictInfoMap.containsKey(dictType);
		if(!keyExist){
			dictInfoMap.put(dictType, new HashMap<String,String>());//新增该字典类型map
		}
		//从内存中查找该字典类型的字典信息，若查找不到，则再到数据库查找，若还是查找不到，则返回匹配不上的特殊字符：★ 
		Map<String,String> map = dictInfoMap.get(dictType);
		result = map.get(dictIdHS);
		//查找不到，再到数据库查找
		if(StringUtils.isBlank(result)){
			map = getDictByDictType(map, dictType);
			dictInfoMap.put(dictType, map);//将数据库新查出来的字典信息替换内存中旧的信息
			result = map.get(dictIdHS);
		}
		//若还是查找不到，则返回匹配不上的特殊字符：★ 
		if(StringUtils.isBlank(result)){
			result = DICT_ID_HS_NO_EXIST;
		}
		return result;
	}
	
	/**
	 * 清空内存中的数据字典信息
	 * @throws Exception
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void clearDictInfoMap() throws Exception{
		dictInfoMap.clear();
	}
	
	/**
	 * 根据当前日期、清算速度、回购期限（天）计算“首次结算日期”、“到期结算日期”
	 * 算法： 当前日期+清算速度（T+0为0天，T+1为1天，这里是指交易日）+回购天数（这里是指自然日），计算得出的日期，判断该日期如果是非交易日则往后延到第一个交易日，这就是回购到期结算日。
	 * @param currentDate 当前日期，格式：yyyyMMdd
	 * @param clearingSpeed 清算速度
	 * @param actualDays 回购期限（天）
	 * @return “首次结算日期”、“到期结算日期”
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getSettlementDate(String currentDate, String clearingSpeed, String actualDays){
		if(StringUtils.isBlank(currentDate)){
			currentDate = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
		}
		currentDate = currentDate.replaceAll("-", "");
		int actualDaysInt = 0;//回购期限（天）
		String firstSettlementDate = "";//首次结算日
		String expiryDate = "";//到期结算日
		String result = "";
		Connection conn = null;
		try {
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());//获取O32系统数据库连接
			
			//若当天不是交易日，则取当前日期的下一个交易日期
			if(!DateUtil.isTradeDay(conn, currentDate, null)){
				currentDate = DateUtil.getCalculateTradeDay(conn, currentDate, null, 0);
			}
			
			//清算速度（T+0为0天)
			if("0".equals(clearingSpeed)){
				firstSettlementDate = currentDate;
				
			//清算速度（T+1为1天，这里是指交易日)
			}else if("1".equals(clearingSpeed)){
				firstSettlementDate = DateUtil.getCalculateTradeDay(conn, currentDate, null, 1);
			}
			
			try {
				actualDaysInt = Integer.parseInt(StringUtils.isBlank(actualDays)?"0":actualDays.trim());//获取回购期限（天）
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//加回购天数
			expiryDate = DateUtil.format(DateUtil.addDay(DateUtil.parseNumberDate(firstSettlementDate), actualDaysInt), DateUtil.YMD_NUMBER);
			
			//计算得出的日期，判断该日期如果是非交易日则往后延到第一个交易日
			if(!DateUtil.isTradeDay(conn, expiryDate, null)){
				expiryDate = DateUtil.getCalculateTradeDay(conn, expiryDate, null, 0);
			}
			
			result = firstSettlementDate + "," + expiryDate;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	/**
	 * 根据当前日期、清算速度、回购期限（天）计算“首次结算日期”、“到期结算日期”
	 * 算法： 当前日期+回购天数（这里是指自然日）+清算速度（T+0为0天，T+1为1天，这里是指交易日），计算得出的日期，判断该日期如果是非交易日则往后延到第一个交易日，这就是回购到期结算日。
	 * @param currentDate 当前日期，格式：yyyyMMdd
	 * @param clearingSpeed 清算速度
	 * @param actualDays 回购期限（天）
	 * @return “首次结算日期”、“到期结算日期”
	 * @author yangjing
	 */
	@Bizlet("")
	public static String getNewSettlementDate(String currentDate, String clearingSpeed, String actualDays){
		if(StringUtils.isBlank(currentDate)){
			currentDate = DateUtil.currentDateString(DateUtil.YMD_NUMBER);
		}
		currentDate = currentDate.replaceAll("-", "");
		int actualDaysInt = 0;//回购期限（天）
		String firstSettlementDate = currentDate;//首次结算日
		String expiryDate = "";//到期结算日
		String result = "";
		Connection conn = null;
		try {
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());//获取O32系统数据库连接
			//获取首次结算日期,若当天不是交易日，则取当前日期的下一个交易日期
			if(!DateUtil.isTradeDay(conn, firstSettlementDate, null)){
				firstSettlementDate = DateUtil.getCalculateTradeDay(conn, firstSettlementDate, null, 0);
			}
			 if("1".equals(clearingSpeed)){
				firstSettlementDate = DateUtil.getCalculateTradeDay(conn, firstSettlementDate, null, 1);
			}
			try {
				actualDaysInt = Integer.parseInt(StringUtils.isBlank(actualDays)?"0":actualDays.trim());//获取回购期限（天）
			} catch (Exception e) {
				e.printStackTrace();
			}
			//加回购天数
			currentDate = DateUtil.format(DateUtil.addDay(DateUtil.parseNumberDate(currentDate), actualDaysInt), DateUtil.YMD_NUMBER);
			
			//计算得出的日期，判断该日期如果是非交易日则往后延到第一个交易日
			if(!DateUtil.isTradeDay(conn, currentDate, null)){
				currentDate = DateUtil.getCalculateTradeDay(conn, currentDate, null, 0);
			}
			//清算速度（T+0为0天)
			if("0".equals(clearingSpeed)){
				expiryDate = currentDate;
				
			//清算速度（T+1为1天，这里是指交易日)
			}else if("1".equals(clearingSpeed)){
				expiryDate = DateUtil.getCalculateTradeDay(conn, currentDate, null, 1);
			}
			result = firstSettlementDate + "," + expiryDate;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 获取债券净价、全价、收益率（可以必填其一，选填其他，输入一个另外两个数据可以系统自动算出来）
	 * @param processDate 业务日期
	 * @param interCode 证券内码
	 * @param netPrice 净价（元/百元面值）
	 * @param fullPrice 全价（元/百元面值）
	 * @param interestRate 收益率（%）
	 * @param interestRateType 收益率类型：[1-到期;2-行权日]
	 * @param tradingPlace 交易场所：[01-银行间;02-上交所固收平台;03-深交所综合协议平台|上交所大宗;]
	 * @param clearingSpeed 清算速度：T+0、T+1
	 * @return 返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getBondPrice(String processDate, String interCode, String netPrice, String fullPrice, String interestRate, String interestRateType, String tradingPlace, String clearingSpeed){
		//返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
		String result = StrUtil.changeNull(netPrice) + "@" + StrUtil.changeNull(fullPrice) + "@" + StrUtil.changeNull(interestRate) + "@" + StrUtil.changeNull(interestRateType) + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed);
		if(StringUtils.isBlank(processDate) || StringUtils.isBlank(interCode)
				|| (StringUtils.isBlank(netPrice)&&StringUtils.isBlank(fullPrice)&&StringUtils.isBlank(interestRate))){
			return result;
		}
		processDate = processDate.replaceAll("-", "");
		//若不传入“收益率类型”值，则取“1-到期”
		if(!"1".equals(interestRateType) && !"2".equals(interestRateType)){
			interestRateType = "1";
		}
		Connection conn = null;
		try {
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());//获取O32系统数据库连接
			
			//获取“证券内码”、“百元债券利息”、“当日利息”
			String sql_bond_info = "select t1.vc_inter_code,nvl(t1.EN_BOND_INTEREST,0) EN_BOND_INTEREST,nvl(t1.EN_TODAY_INTEREST,0) EN_TODAY_INTEREST from trade.TBONDPROPERTY t1 where t1.vc_inter_code='" + interCode + "'";
			String val_bond_info = JDBCUtil.getRecordValueBySql(conn, sql_bond_info);
			
			//若查找到“证券内码”、“百元债券利息”、“当日利息”，则继续执行，否则直接结束返回
			if(StringUtils.isNotEmpty(val_bond_info)){
				String[] val_bond_info_arr = val_bond_info.split(",");
				String vc_inter_code = val_bond_info_arr[0];//证券内码
				String val_en_bond_interest = val_bond_info_arr[1];//“百元债券利息”
				String en_today_interest = val_bond_info_arr[2];//“当日利息”
				
				String busiDate = processDate;//计算业务日期，默认使用传入的业务日期
				String bond_interest = val_en_bond_interest;//应计利息，默认使用“百元债券利息”
				//若清算速度为T+1，则计算业务日期取T+1日，应计利息取“当日利息”
				if("T+1".equals(clearingSpeed)){
					busiDate = DateUtil.getCalculateTradeDay(conn, processDate, null, 1);
					bond_interest = en_today_interest;
				}else{
					clearingSpeed = "T+0";//默认计算T+0的值
				}
				
				//若传入净价，优先使用净价计算全价、收益率
				if(StringUtils.isNotBlank(netPrice)){
					netPrice = netPrice.replaceAll(",", "").trim();
					
					//根据债券价格[净价]计算债券收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
					//sf_get_bond_yield(l_date_p,vc_inter_code_p,en_price_p,l_design_end_date_p,c_type_p)
					String sql_sf_get_bond_yield = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+netPrice+",0,'"+interestRateType+"'),6) bond_yield from dual";
					String val_yield = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield);
					
					//计算全价，全价=净价+百元债券利息
					fullPrice = String.valueOf(Double.parseDouble(netPrice.trim()) + Double.parseDouble(bond_interest));
					
					//返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
					result = netPrice.trim() + "@" + fullPrice + "@" + val_yield + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed);
					
					
				//若净价为空，存在全价，则使用全价计算净价、收益率
				}else if(StringUtils.isBlank(netPrice) && StringUtils.isNotBlank(fullPrice)){
					fullPrice = fullPrice.replaceAll(",", "").trim();
					
					//计算净价，净价=全价-百元债券利息
					double dNetPrice = Double.parseDouble(fullPrice.trim()) - Double.parseDouble(bond_interest);
					
					//根据债券价格[净价]计算债券收益率（统计日期，债券代码[内码]，单券债券委托价格[净价]，计算到指定日期的收益率[默认0]，计算到到期还是到行权日[1-到期;2-行权日]）
					//sf_get_bond_yield(l_date_p,vc_inter_code_p,en_price_p,l_design_end_date_p,c_type_p)
					String sql_sf_get_bond_yield = "select 100*round(trade.sf_get_bond_yield("+busiDate+",'"+vc_inter_code+"',"+dNetPrice+",0,'"+interestRateType+"'),6) bond_yield from dual";
					String val_yield = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_yield);
					
					//返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
					result = String.valueOf(dNetPrice) + "@" + fullPrice + "@" + val_yield + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed);
					
					
				//若净价、全价为空，存在收益率，则使用收益率计算净价、全价
				}else if(StringUtils.isBlank(netPrice) && StringUtils.isBlank(fullPrice) && StringUtils.isNotBlank(interestRate)){
					interestRate = interestRate.replaceAll(",", "").trim();
					
					//根据债券收益率计算债券价格[全价]（统计日期，基金编号，债券代码[内码]，到期收益率，计算到到期还是到行权日[1-到期;2-行权日]）
					//sf_get_bond_price(l_date_p,l_fund_id_p,vc_inter_code_p,en_yield_rate_P,c_type_p)
					String sql_sf_get_bond_price = "select trade.sf_get_bond_price("+busiDate+",null,'"+vc_inter_code+"',"+Double.parseDouble(interestRate)/100+",'"+interestRateType+"') bond_price from dual";
					String val_sf_get_bond_price = JDBCUtil.getValueBySql(conn, sql_sf_get_bond_price);
					
					//计算净价，净价=全价-百元债券利息
					netPrice = String.valueOf(Double.parseDouble(val_sf_get_bond_price) - Double.parseDouble(bond_interest));
					
					//返回结果：净价，全价，收益率，收益率类型，交易场所，清算速度
					result = netPrice + "@" + val_sf_get_bond_price + "@" + interestRate + "@" + interestRateType + "@" + StrUtil.changeNull(tradingPlace)  + "@" + StrUtil.changeNull(clearingSpeed);
				}
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.releaseResource(conn, null, null);
		}
		return result;
	}
	
	/**
	 * 通过第三方指令Id查询对应债券买卖业务
	 * @param conn 数据库连接，若不传入，则新建数据连接后再关闭
	 * @param clordid 第三方指令Id
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getZqmmByClordid(Connection conn, String clordid){
		//System.out.println("ProductProcessUtil.getZqmmByClordid begin...");
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		boolean isCloseConn = false;
		try {
			//获取默认数据库连接
			if(conn==null || conn.isClosed()){
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				isCloseConn = true;
			}
			
			//拼接SQL语句
			sb.append("select t.process_id, ")//
			  .append("       t.process_status")//
			  .append("  from zhfwpt_jy_zqmm t ")
			  .append(" where 1 = 1 ");
			if(StringUtils.isNotBlank(clordid)){
				sb.append(" and t.clordid =").append("'"+clordid+"'");
			}
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String process_id = map.get("PROCESS_ID");
					String process_status = map.get("PROCESS_STATUS");
					obj =  DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZqmm");
					obj.setString("processId", process_id);
					obj.setString("processStatus", process_status);
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			if(isCloseConn){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
		//System.out.println("ProductProcessUtil.getZqmmByClordid end!!!");
		return result;
	}
	
	/**
	 * 通过第三方指令Id查询对应正逆回购业务
	 * @param conn 数据库连接，若不传入，则新建数据连接后再关闭
	 * @param clordid 第三方指令Id
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> getZnhgByClordid(Connection conn, String clordid){
		//System.out.println("ProductProcessUtil.getZnhgByClordid begin...");
		List<DataObject> result = new ArrayList<DataObject>();
		StringBuffer sb = new StringBuffer();
		DataObject obj = null;
		boolean isCloseConn = false;
		try {
			//获取默认数据库连接
			if(conn==null || conn.isClosed()){
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				isCloseConn = true;
			}
			
			//拼接SQL语句
			sb.append("select t.process_id, ")//
			  .append("       t.process_status")//
			  .append("  from zhfwpt_jy_znhg t ")
			  .append(" where 1 = 1 ");
			if(StringUtils.isNotBlank(clordid)){
				sb.append(" and t.clordid =").append("'"+clordid+"'");
			}
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String process_id = map.get("PROCESS_ID");
					String process_status = map.get("PROCESS_STATUS");
					obj =  DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.ZhfwptJyZnhg");
					obj.setString("processId", process_id);
					obj.setString("processStatus", process_status);
					result.add(obj);
					obj = null;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			if(isCloseConn){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
		//System.out.println("ProductProcessUtil.getZnhgByClordid end!!!");
		return result;
	}
	
	/**
	 * 更新债券买卖前台成交状态
	 * @param conn 数据库连接，若不传入，则新建数据连接后再关闭
	 * @param paramObject 参数条件对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void updateZqmmByDealStatus(Connection conn, DataObject paramObject){
		boolean isCloseConn = false;
		StringBuffer sb = new StringBuffer();
		try {
			//获取默认数据库连接
			if(conn==null || conn.isClosed()){
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				isCloseConn = true;
			}
			
			sb.setLength(0);
			sb.append("update zhfwpt_jy_zqmm t")
				.append(" set t.process_status ="+paramObject.getString("processStatus")+",")
				.append("     t.send_id = '"+paramObject.getString("sendId")+"',")
				.append("     t.send_Name = '"+paramObject.getString("sendName")+"',")
				.append("     t.send_cd = sysdate ")
				.append(" where t.process_id ="+paramObject.getString("processId"));
			
			//执行更新
			JDBCUtil.executeUpdateWithConn(conn, sb.toString(), null);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			if(isCloseConn){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
	}
	
	/**
	 * 更新正逆回购前台成交状态
	 * @param conn 数据库连接，若不传入，则新建数据连接后再关闭
	 * @param paramObject 参数条件对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static void updateZnhgByDealStatus(Connection conn, DataObject paramObject){
		//System.out.println("ProductProcessUtil.updateZnhgByDealStatus begin...");
		boolean isCloseConn = false;
		StringBuffer sb = new StringBuffer();
		List<String> sqls = new ArrayList<String>();
		try {
			//获取默认数据库连接
			if(conn==null || conn.isClosed()){
				conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
				isCloseConn = true;
			}
			
			sb.setLength(0);
			sb.append("update zhfwpt_jy_znhg t")
				.append(" set t.process_status ="+paramObject.getString("processStatus")+",")
				.append("     t.send_id = '"+paramObject.getString("sendId")+"',")
				.append("     t.send_Name = '"+paramObject.getString("sendName")+"',")
				.append("     t.send_cd = sysdate")
				.append(" where t.process_id ="+paramObject.getString("processId"));
			sqls.add(sb.toString());
			JDBCUtil.executeUpdateBatchWithConn(conn, sqls);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sb.setLength(0);
			sb = null;
			if(isCloseConn){
				JDBCUtil.releaseResource(conn, null, null);
			}
		}
		//System.out.println("ProductProcessUtil.updateZnhgByDealStatus end!!!");
	}
	
}
