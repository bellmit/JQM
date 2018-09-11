package com.cjhxfund.commonUtil;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

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
 * 产品处理公共类
 * @author chenpeng
 * @date 2015-10-13 14:27:07
 */
@Bizlet("产品处理公共类")
public class ProductUtil {
	
	/** 匹配不上恒生系统字典ID时返回的特殊字符：★ */
	public static final String DICT_ID_HS_NO_EXIST = "★";
	/** 存放映射恒生系统数据字典信息 */
	public static Map<String,Map<String,String>> dictInfoMap = new HashMap<String,Map<String,String>>();
	/** 存放机构员工所有userId信息 */
	public static Map<String,String> orgEmpUserIdMap = new HashMap<String,String>();
	
	/** 上传文件保存路径-流程文件 */
	public static final String JQM_UPLOAD_FILE_PATH_LIUCHENG = "/home/ats/FileUploadPath/JQM/LiuCheng/";
	/** 上传文件保存路径-流程文件-用印文件 */
	public static final String JQM_UPLOAD_FILE_PATH_LIUCHENG_YONGYIN = "/home/ats/FileUploadPath/JQM/LiuCheng/YongYin/";
	/** 上传文件保存路径-投票业务文件 */
	public static final String JQM_UPLOAD_FILE_PATH_TOUPIAO = "/home/ats/FileUploadPath/JQM/TouPiao/";
	/** 上传文件保存路径-传真文件 */
	public static final String JQM_UPLOAD_FILE_PATH_CHUANZHEN = "/home/ats/FileUploadPath/JQM/ChuanZhen/";
	
	
	/** 上传文件保存路径-流程文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG = "/home/ats/FileUploadPath/fm/LiuCheng";
	/** 上传文件保存路径-流程文件-用印文件 */
	public static final String UPLOAD_FILE_PATH_LIUCHENG_YONGYIN = "/home/ats/FileUploadPath/fm/LiuCheng/YongYin";
	/** 上传文件保存路径-传真文件 */
	public static final String UPLOAD_FILE_PATH_CHUANZHEN = "/home/ats/FileUploadPath/fm/ChuanZhen";
	/** 上传文件保存路径-新债募集说明书 */
	public static final String UPLOAD_FILE_PATH_MJSMS = "/home/ats/FileUploadPath/fm/prospectus";
	/** 上传文件保存路径-新债发行公告 */
	public static final String UPLOAD_FILE_PATH_PUBLICATION = "/home/ats/FileUploadPath/fm/publication";
	/** 上传文件保存路径-新债信用评级报告 */
	public static final String UPLOAD_FILE_PATH_CREDIT = "/home/ats/FileUploadPath/fm/ratingReport";
	/** 上传文件保存路径-新债信用评级报告 */
	public static final String UPLOAD_FILE_PATH_DEBTINFO = "/home/ats/FileDownloadPath/fm/LiuCheng/debtInfo";
	
	
	/**
	 * 获取投资指令/建议编号，所有业务共用，全系统唯一
	 * @param processDate 【该参数已不用，可以不传】业务日期，格式：20100101
	 * @param processType 【该参数已不用，可以不传】业务类别
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static synchronized String getInvestProductNum(String processDate, String processType){
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
	 * 获取投资指令/建议编号，所有业务共用，全系统唯一
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static synchronized String getInvestNo(){
		String result = "";
		try {
			//获取投资指令/建议编号，所有业务共用，全系统唯一
			long investProductNum = DatabaseExt.getNextSequence("CF_JY_P_P_I_PRO_NUM_SEQ");
			result = String.valueOf(investProductNum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 获取询价结果指令表的询价结果指令序号，所有业务共用，全系统唯一
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static synchronized String getATSInquiryResultNo(){
		String result = "";
		try {
			//获取询价结果指令表的询价结果指令序号，所有业务共用，全系统唯一
			long inquiryResultNo = DatabaseExt.getNextSequence("T_ATS_INQUIRY_RESULT_NO_SEQ");
			result = String.valueOf(inquiryResultNo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 获取第三方系统指令编号，全程唯一，已有指令结束归档后该编号可以再使用。
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static synchronized String getClOrdID(){
		return DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSSS_NUMBER);
	}
	
	/**
	 * 综合信息查询-产品信息查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<DataObject> queryProducts(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取O32系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			//获取页面传进来的查询条件值
			String combProductCodes = paramObject.getString("combProductCodes");//可查看的产品代码字符串，当有多条记录时，结果值以英文逗号分隔
			String searchKey = paramObject.getString("searchKey");//搜索关键字
			
			//拼接SQL语句
			sb.append("select distinct t.vc_product_code, ")//产品代码
			  .append("                t.vc_product_name, ")//产品名称
			  .append("                t.vc_product_code || '-' || t.vc_product_name fundCodeName ")//产品代码+产品名称
			  .append("  from t_ats_product_info t ")
			  .append(" where 1 = 1 ");
			
			//新增查询条件
			if(StringUtils.isNotBlank(combProductCodes)){
				sb.append(" and t.vc_product_code in (").append(JDBCUtil.changeInStr(combProductCodes)).append(") ");
			}
			if(StringUtils.isNotBlank(searchKey)){
				sb.append(" and (t.vc_product_code like '%").append(searchKey).append("%' or t.vc_product_name like '%").append(searchKey).append("%') ");
			}
			//排序SQL语句
			String sqlOrder = " order by t.vc_product_code asc";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_fund_code = map.get("VC_PRODUCT_CODE");
					String vc_fund_name = map.get("VC_PRODUCT_NAME");
					String fundCodeName = map.get("FUNDCODENAME");
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.ats.fm.comm.comm.CombProduct");
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
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			
			//拼接SQL语句
			sb.append("select distinct t1.vc_product_code, ")//产品代码
			  .append("                t1.vc_product_name, ")//产品名称
			  .append("                t1.vc_product_code || '-' || t1.vc_product_name fundCodeName, ")//产品代码+产品名称
			  .append("                t2.vc_combi_no, ")//投资组合编号
			  .append("                t2.vc_combi_name, ")//投资组合名称
			  .append("                t2.l_asset_id, ")//资产单元序号
			  .append("                t1.vc_product_code || '|' || t1.vc_product_name || '|' || t2.vc_combi_no || '|' || t2.vc_combi_name || '|' || t2.l_asset_id || '|' || t1.l_product_id || '|' || t2.l_combi_id fundInfo ")//产品投资组合信息
			  .append("  from t_ats_product_info t1, t_ats_combi_info t2 ")
			  .append(" where t1.l_product_id = t2.l_product_id ");
			  
			if(StringUtils.isNotBlank(searchKey)){
				sb.append("   and (t1.vc_product_code like '%").append(searchKey).append("%' or t1.vc_product_name like '%").append(searchKey).append("%' or t2.vc_combi_no like '%").append(searchKey).append("%' or t2.vc_combi_name like '%").append(searchKey).append("%') ");
			}
			if(StringUtils.isNotBlank(productCodes)){
				sb.append("   and t1.vc_product_code in (").append(StrUtil.changeInStr(productCodes)).append(") ");
			}
			if(StringUtils.isNotBlank(combiNos)){
				sb.append("   and t2.vc_combi_no in (").append(StrUtil.changeInStr(combiNos)).append(") ");
			}
			//限制每次只查询20条记录
			sb.append("   and rownum <= 20 ")
			  .append(" order by t1.vc_product_code asc ");
			
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(), null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_fund_code = map.get("VC_PRODUCT_CODE");
					String vc_fund_name = map.get("VC_PRODUCT_NAME");
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
			
			sb.append("select t.vc_product_code from t_ats_product_handle t where 1=1 ");
			if(StringUtils.isNotBlank(relaType)){
				sb.append(" and t.vc_Relate_Type='").append(relaType).append("' ");
			}
			if(StringUtils.isNotBlank(userId)){
				sb.append(" and t.vc_user_id='").append(userId).append("' ");
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
	
	
	
	public static void main(String[] args) {
	}

}
