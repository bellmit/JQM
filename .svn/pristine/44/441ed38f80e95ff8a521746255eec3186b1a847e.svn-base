package com.cjhxfund.jy.ProductProcess;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.eoscommon.LogUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 委托人端查询处理公共类
 * @author zhanglu
 * @date 2017-06-16 14:30:00
 */
@Bizlet("")
public class WtrdUtil {
	
	/** 当前classpath的绝对URI路径 */
	public static String CLASS_PATH = "";
	/** 综合信息查询SQL文件存放路径 */
	public static String ZHXXCX_FILE_PATH = "";
	/** 持仓信息查询SQL语句 */
	public static String SQL_CCXX = "";
	/** 资管计划底层资产信息查询SQL语句 */
	public static String SQL_ZGJHDCZCXX = "";
	/** 投资资产及负债信息查询SQL语句 */
	public static String SQL_TZZCJFZXX = "";
	/** 数值型格式*/
	public static DecimalFormat df8 = new DecimalFormat("##0.00000000");
	public static DecimalFormat df7 = new DecimalFormat("##0.0000000");
	public static DecimalFormat df6 = new DecimalFormat("##0.000000");
	public static DecimalFormat df5 = new DecimalFormat("##0.00000");
	public static DecimalFormat df4 = new DecimalFormat("##0.0000");
	public static DecimalFormat df3 = new DecimalFormat("##0.000");
	public static DecimalFormat df2 = new DecimalFormat("##0.00");
	public static DecimalFormat df1 = new DecimalFormat("##0.0");
	

	
	static {
		String os = System.getProperty("os.name");
		if(StringUtils.isNotEmpty(os) && os.toLowerCase().startsWith("win")){
			CLASS_PATH = WtrdUtil.class.getResource("/").getPath().substring(1);
		}else{
			CLASS_PATH = WtrdUtil.class.getResource("/").getPath();
		}
		ZHXXCX_FILE_PATH = CLASS_PATH + "confFile" + File.separator + "sqlFile" + File.separator + "zhxxcx" + File.separator;
	}
	
	
	public static String numberFormat(String val){
		String ret = "";
		if(StringUtils.isBlank(val)){
			return "";
		}
		if(val.indexOf(".") > -1){
			int len = val.length()-val.indexOf(".");
			switch (len-1) {
			case 1:
				ret = df1.format(Double.parseDouble(val));
				break;
			case 2:
				ret = df2.format(Double.parseDouble(val));
				break;
			case 3:
				ret = df3.format(Double.parseDouble(val));
				break;
			case 4:
				ret = df4.format(Double.parseDouble(val));
				break;
			case 5:
				ret = df5.format(Double.parseDouble(val));
				break;
			case 6:
				ret = df6.format(Double.parseDouble(val));
				break;
			case 7:
				ret = df7.format(Double.parseDouble(val));
				break;
			case 8:
				ret = df8.format(Double.parseDouble(val));
				break;
			default:
				ret = df1.format(Double.parseDouble(val));
				break;
			}
		}else{
			return val;
		}
		return ret;
	}
	
	/**
	 * 根据SQL文件名称获取SQL文件内容字符串
	 * @param sqlFile SQL文件名称
	 * @return
	 * @author zhanglu
	 */
	@Bizlet("")
	public static String getFileSql(String sqlFile){
		return StrUtil.findContentStr(ZHXXCX_FILE_PATH+sqlFile, null);
	}
	
	public static String formatDateToString(String date){
		String retDate = "";
		if(date != "" && date != null && date.length() > 10){
			retDate = date.substring(0, 10);
			retDate = retDate.replace("-", "");
			return retDate;
		} else {
			return date;
		}
	}
	
	/**
	 * 委托人端查询-信息收集
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author zhanglu
	 */
	@Bizlet("")
	public static List<DataObject> querySJXX(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取估值系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_SJZX);
			//获取内存中的查询SQL语句
			sb.append(" select product_fullname,jg_name,zqlb,vc_zqdm,vc_kmmc,b_info_issuer,bz,en_cb,en_sz,l_sl,ncdwjz,jjdwjz from dw.A001_PRODUCT_JINNIU where 1=1 ");
				
			String lDate = paramObject.getString("lDate");//数据日期
			String productNo = paramObject.getString("vCFundCode");//产品代码
			lDate = lDate.substring(0, 10);
			//拼接SQL语句
			if(StringUtils.isNotBlank(lDate)){
				sb.append("   and d_ywrq = date'"+lDate+"' ");
			}
			if(StringUtils.isNotBlank(productNo)){
				sb.append("   and L_ZTBH = '" + productNo + "' ");
			}
			//排序SQL语句
			String order = " order by vc_zqdm";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, order,page);
			
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ZhxxcxEntity");
					
					//获取参数值
					String PRODUCT_FULLNAME = map.get("PRODUCT_FULLNAME");   //资管计划名称
					String JG_NAME = map.get("JG_NAME");   //金额
					String ZQLB = map.get("ZQLB");   //到期日
					String VC_ZQDM = map.get("VC_ZQDM");   //资管计划折算人民币未投资头寸(元)
					String VC_KMMC = map.get("VC_KMMC");   //底层资产行内资产负债/编码
					String B_INFO_ISSUER = map.get("B_INFO_ISSUER");   //底层名称
					String BZ = map.get("BZ");   //评级
					String EN_CB = numberFormat(map.get("EN_CB"));  //债券类别
					String EN_SZ = numberFormat(map.get("EN_SZ"));;  //底层资产到期日
					String L_SL = numberFormat(map.get("L_SL"));  //底层资产持仓数量
					String NCDWJZ = df8.format(Double.parseDouble(map.get("NCDWJZ")));   //底层资产折算人民币市值(元)
					String JJDWJZ = df8.format(Double.parseDouble(map.get("JJDWJZ")));  //持仓日期


					//给对象赋值
					obj.setString("PRODUCT_FULLNAME", PRODUCT_FULLNAME);
					obj.setString("JG_NAME", JG_NAME);
					obj.setString("ZQLB", ZQLB);
					obj.setString("VC_ZQDM", VC_ZQDM);
					obj.setString("VC_KMMC", VC_KMMC);
					obj.setString("B_INFO_ISSUER", B_INFO_ISSUER);
					obj.setString("BZ", BZ);
					obj.setString("EN_CB", EN_CB);
					obj.setString("EN_SZ", EN_SZ);
					obj.setString("L_SL", L_SL);
					obj.setString("NCDWJZ", NCDWJZ);
					obj.setString("JJDWJZ", JJDWJZ);
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
	 * 委托人端查询-持仓信息
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author zhanglu
	 * @modify luwenxing
	 */
	@Bizlet("")
	public static List<DataObject> queryCCXX(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取估值系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_SJZX);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_CCXX)){
				SQL_CCXX = getFileSql("wtrd_ccxx.sql");
			}
				
			String lDate = paramObject.getString("lDate");//数据日期
			String productNo = paramObject.getString("vCFundCode");//产品代码	debug by luwenxing
			
			lDate = formatDateToString(lDate);
			//拼接SQL语句
			sb.append(SQL_CCXX);
			if(StringUtils.isNotBlank(lDate)){
				sb.append("   and a.data_date = '"+lDate+"' "); 		// by luwenxing
			}
			if(StringUtils.isNotBlank(productNo)){
				sb.append("   and b.bk_product = '" + productNo + "' ");
			}
			//排序SQL语句
			String order = " order by a.place asc,a.balance_code asc";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, order,page);
			
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ZhxxcxEntity");
					
					//获取参数值
					String INFORMATION_PLAN_NAME = map.get("INFORMATION_PLAN_NAME");   //资管计划名称
					String TOTAL_AMOUNT = map.get("TOTAL_AMOUNT");   //金额
					String EXPIRATION_DATE = map.get("EXPIRATION_DATE");   //到期日
					String NO_INVESTMENT_POSITIONS = map.get("NO_INVESTMENT_POSITIONS");   //资管计划折算人民币未投资头寸(元)
					String BALANCE_CODE = map.get("BALANCE_CODE");   //底层资产行内资产负债/编码
					String BOTTOM_NAME = map.get("BOTTOM_NAME");   //底层名称
					String CREDIT_RATING = map.get("CREDIT_RATING");   //评级
					String BOND_TYPE = map.get("BOND_TYPE");   //债券类别
					String ASSET_TO_DATE = map.get("ASSET_TO_DATE");   //底层资产到期日
					String POAIRION_QUANTITY = map.get("POAIRION_QUANTITY");   //底层资产持仓数量
					String RMB_VALUR = map.get("RMB_VALUR");   //底层资产折算人民币市值(元)
					String CC_DATE = map.get("CC_DATE");   //持仓日期
					String DATA_DATE = map.get("DATA_DATE");   //数据日期
					String PRODUCT_NO = map.get("PRODUCT_NO");   //产品代码

					//给对象赋值
					obj.setString("INFORMATION_PLAN_NAME", INFORMATION_PLAN_NAME);
					obj.setString("TOTAL_AMOUNT", TOTAL_AMOUNT);
					obj.setString("EXPIRATION_DATE", EXPIRATION_DATE);
					obj.setString("NO_INVESTMENT_POSITIONS", NO_INVESTMENT_POSITIONS);
					obj.setString("BALANCE_CODE", BALANCE_CODE);
					obj.setString("BOTTOM_NAME", BOTTOM_NAME);
					obj.setString("CREDIT_RATING", CREDIT_RATING);
					obj.setString("BOND_TYPE", BOND_TYPE);
					obj.setString("ASSET_TO_DATE", ASSET_TO_DATE);
					obj.setString("POAIRION_QUANTITY", POAIRION_QUANTITY);
					obj.setString("RMB_VALUR", RMB_VALUR);
					obj.setString("CC_DATE", CC_DATE);
					obj.setString("DATA_DATE", DATA_DATE);
					obj.setString("PRODUCT_NO", PRODUCT_NO);
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
	 * 委托人端查询-资管计划底层资产信息
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author zhanglu
	 * @modify luwenxing
	 */
	@Bizlet("")
	public static List<DataObject> queryZGJHDCZCXX(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取估值系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_SJZX);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_ZGJHDCZCXX)){
				SQL_ZGJHDCZCXX = getFileSql("wtrd_zgjhdczcxx.sql");
			}
				
			String lDate = paramObject.getString("lDate");//数据日期
			String productNo = paramObject.getString("vCFundCode");//产品代码
			lDate = formatDateToString(lDate);
			//拼接SQL语句
			sb.append(SQL_ZGJHDCZCXX);
			if(StringUtils.isNotBlank(lDate)){
				sb.append("   and a.data_date = '"+lDate+"' ");
			}
			
			if(StringUtils.isNotBlank(productNo)){
				sb.append("   and b.bk_product = '" + productNo + "' ");
			}
			//排序SQL语句
			String order = " order by a.place asc,a.balance_code asc";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, order,page);
			
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ZhxxcxEntity");
					
					//获取参数值
					String FXJG_NAME = map.get("FXJG_NAME");   //发行机构代码
					String DY_BALANCE_CODE = map.get("DY_BALANCE_CODE");   //对应资产管理计划行内资产/负债编码
					String ISSUE_AMOUNT = map.get("ISSUE_AMOUNT");   //资管计划当前总发行数量
					String CURRENT_AMOUNT = map.get("CURRENT_AMOUNT");   //资管计划当前总折算人民币发行金额(元)
					String NO_INVESTMENT_POSITIONS = map.get("NO_INVESTMENT_POSITIONS");   //资管计划折算人民币未投资头寸(元)
					String BALANCE_CODE = map.get("BALANCE_CODE");   //底层资产行内资产负债/编码
					String POAIRION_QUANTITY = map.get("POAIRION_QUANTITY");   //底层资产持仓数量
					String RMB_VALUR = map.get("RMB_VALUR");   //底层资产折算人民币市值(元)
					String CC_DATE = map.get("CC_DATE");   //持仓日期
					String DATA_DATE = map.get("DATA_DATE");   //数据日期
					String PRODUCT_NO = map.get("PRODUCT_NO");   //产品代码

					//给对象赋值
					obj.setString("FXJG_NAME", FXJG_NAME);
					obj.setString("DY_BALANCE_CODE", DY_BALANCE_CODE);
					obj.setString("ISSUE_AMOUNT", ISSUE_AMOUNT);
					obj.setString("CURRENT_AMOUNT", CURRENT_AMOUNT);
					obj.setString("NO_INVESTMENT_POSITIONS", NO_INVESTMENT_POSITIONS);
					obj.setString("BALANCE_CODE", BALANCE_CODE);
					obj.setString("POAIRION_QUANTITY", POAIRION_QUANTITY);
					obj.setString("RMB_VALUR", RMB_VALUR);
					obj.setString("CC_DATE", CC_DATE);
					obj.setString("DATA_DATE", DATA_DATE);
					obj.setString("PRODUCT_NO", PRODUCT_NO);
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
	 * 委托人端查询-投资资产及负债信息
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author zhanglu
	 */
	@Bizlet("")
	public static List<DataObject> queryTZZCJFZXX(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取估值系统数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_SJZX);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_TZZCJFZXX)){
				SQL_TZZCJFZXX = getFileSql("wtrd_tzzcjfzxx.sql");
			}
				
			String lDate = paramObject.getString("lDate");//数据日期
			String productNo = paramObject.getString("vCFundCode");//产品代码
			lDate = formatDateToString(lDate);
			//拼接SQL语句
			sb.append(SQL_TZZCJFZXX);
			
			if(StringUtils.isNotBlank(productNo)){
				sb.append(" and b.bk_product='" + productNo + "' ");
			}
			if(StringUtils.isNotBlank(lDate)){
				sb.append("where a.data_date='"+lDate+"' ");
			}
			String order = " order by a.place,a.col001";
						
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, order,page);
			
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.ZhxxcxEntity");
					
					//获取参数值
					String COL001  = map.get("COL001");   //行内资产/负债编码
					String COL002  = map.get("COL002");   //发行机构代码
					String COL003  = map.get("COL003");   //资产/负债类别
					String COL004  = map.get("COL004");   //交易流通场所
					String COL005  = map.get("COL005");   //币种
					String COL006  = map.get("COL006");   //资金存入银行
					String COL007  = map.get("COL007");   //存款金额
					String COL008  = map.get("COL008");   //起息日
					String COL009  = map.get("COL009");   //到期日
					String COL010  = map.get("COL010");   //年利率%
					String COL011  = map.get("COL011");   //计息基础
					String COL012  = map.get("COL012");   //是否为结构性存款
					String COL013  = map.get("COL013");   //结构性存款挂钩标的类别
					String COL014  = map.get("COL014");   //结构性存款挂钩标的
					String COL015  = map.get("COL015");   //代码
					String COL016  = map.get("COL016");   //名称
					String COL017  = map.get("COL017");   //具体类别
					String COL018  = map.get("COL018");   //发行方式
					String COL019  = map.get("COL019");   //主体评级
					String COL020  = map.get("COL020");   //发行机构类型（按规模划分）
					String COL021  = map.get("COL021");   //发行机构类型（按技术领域划分）
					String COL022  = map.get("COL022");   //发行机构类型（按经济类型划分）
					String COL023  = map.get("COL023");   //发行机构所属行业
					String COL024  = map.get("COL024");   //登记托管机构
					String COL025  = map.get("COL025");   //登记托管机构说明
					String COL026  = map.get("COL026");   //起息日
					String COL027  = map.get("COL027");   //到期日
					String COL028  = map.get("COL028");   //对手方
					String COL029  = map.get("COL029");   //年利率%
					String COL030  = map.get("COL030");   //计息基础
					String COL031  = map.get("COL031");   //回购标的类别
					String COL032  = map.get("COL032");   //回购标的金额
					String COL033  = map.get("COL033");   //收/受益权类型
					String COL034  = map.get("COL034");   //是否属于买入返售
					String COL035  = map.get("COL035");   //名称
					String COL036  = map.get("COL036");   //金额
					String COL037  = map.get("COL037");   //起息日
					String COL038  = map.get("COL038");   //到期日
					String COL039  = map.get("COL039");   //是否有预期收益率
					String COL040  = map.get("COL040");   //项目收益率(利率)%
					String COL041  = map.get("COL041");   //付息频率（个月/次）
					String COL042  = map.get("COL042");   //还本付息情况说明
					String COL043  = map.get("COL043");   //计息基础
					String COL044  = map.get("COL044");   // 基准利率种类
					String COL045  = map.get("COL045");   //浮动因子（%）
					String COL046  = map.get("COL046");   //利差(BP)
					String COL047  = map.get("COL047");   //融资人
					String COL048  = map.get("COL048");   //融资人内部信用评级
					String COL049  = map.get("COL049");   //外部评级机构名称及对融资人评级结果
					String COL050  = map.get("COL050");   //融资人类型（按规模划分）
					String COL051  = map.get("COL051");   //融资人类型（按技术领域划分）
					String COL052  = map.get("COL052");   //融资人类型（按经济类型划分）
					String COL053  = map.get("COL053");   //融资项目
					String COL054  = map.get("COL054");   //融资人所属行业
					String COL055  = map.get("COL055");   //项目是否属于重点监控行业和领域
					String COL056  = map.get("COL056");   //重点监控行业和领域类别
					String COL057  = map.get("COL057");   //重点监控行业和领域类别说明
					String COL058  = map.get("COL058");   //担保方式
					String COL059  = map.get("COL059");   //担保情况说明
					String COL060  = map.get("COL060");   //融资人主体评级
					String COL061  = map.get("COL061");   //资产内部评级
					String COL062  = map.get("COL062");   //资产外部评级
					String COL063  = map.get("COL063");   //选择权
					String COL064  = map.get("COL064");   //行权条件说明
					String COL065  = map.get("COL065");   //融资人所属地区
					String COL066  = map.get("COL066");   //融资人组织机构（社会信用）代码
					String COL067  = map.get("COL067");   //融资总费率%
					String COL068  = map.get("COL068");   //融资项目所属行业
					String COL069  = map.get("COL069");   //是否为收/受益权
					String COL070  = map.get("COL070");   //是否属于买入返售
					String COL071  = map.get("COL071");   //类型
					String COL072  = map.get("COL072");   //数量
					String COL073  = map.get("COL073");   //合计金额
					String COL074  = map.get("COL074");   //加权剩余期限（天）
					String COL075  = map.get("COL075");   //最长剩余期限（天）
					String COL076  = map.get("COL076");   //最短剩余期限（天）
					String COL077  = map.get("COL077");   //起息日
					String COL078  = map.get("COL078");   //到期日
					String COL079  = map.get("COL079");   //行业
					String COL080  = map.get("COL080");   //贴现利率（%）
					String COL081  = map.get("COL081");   //股票代码
					String COL082  = map.get("COL082");   //股票/企业名称
					String COL083  = map.get("COL083");   //股票类型
					String COL084  = map.get("COL084");   //行业
					String COL085  = map.get("COL085");   //投资阶段
					String COL086  = map.get("COL086");   //企业类型（按规模划分）
					String COL087  = map.get("COL087");   //企业类型（按技术领域划分）
					String COL088  = map.get("COL088");   //企业类型（按经济类型划分）
					String COL089  = map.get("COL089");   //是否为质押融资
					String COL090  = map.get("COL090");   //名称
					String COL091  = map.get("COL091");   //名义本金
					String COL092  = map.get("COL092");   //标的类别
					String COL093  = map.get("COL093");   //所属国家或地区
					String COL094  = map.get("COL094");   //债券名称
					String COL095  = map.get("COL095");   //债券代码
					String COL096  = map.get("COL096");   //发行机构
					String COL097  = map.get("COL097");   //发行机构所属行业
					String COL098  = map.get("COL098");   //起息日
					String COL099  = map.get("COL099");   //到期日
					String COL100  = map.get("COL100");   //期限（月）
					String COL101  = map.get("COL101");   //发行机构主体信用评级
					String COL102  = map.get("COL102");   //债券信用评级
					String COL103  = map.get("COL103");   //票面利率%
					String COL104  = map.get("COL104");   //付息频率（个月/次）
					String COL105  = map.get("COL105");   //担保情况说明
					String COL106  = map.get("COL106");   //是否含权等特殊条款情况说明
					String COL107  = map.get("COL107");   //所属国家或地区
					String COL108  = map.get("COL108");   //起息日
					String COL109  = map.get("COL109");   //到期日
					String COL110  = map.get("COL110");   //对手方
					String COL111  = map.get("COL111");   //年利率%
					String COL112  = map.get("COL112");   //计息基础
					String COL113  = map.get("COL113");   //所属国家或地区
					String COL114  = map.get("COL114");   //股票/基金代码
					String COL115  = map.get("COL115");   //股票/基金名称
					String COL116  = map.get("COL116");   //发行机构
					String COL117  = map.get("COL117");   //行业
					String COL118  = map.get("COL118");   //所属国家或地区
					String COL119  = map.get("COL119");   //合约名称
					String COL120  = map.get("COL120");   //起息日
					String COL121  = map.get("COL121");   //到期日
					String COL122  = map.get("COL122");   //票面利率%
					String COL123  = map.get("COL123");   //付息频率（个月/次）
					String COL124  = map.get("COL124");   //固定收益部分所占比例(%)
					String COL125  = map.get("COL125");   //衍生金融工具所占比例(%)
					String COL126  = map.get("COL126");   //衍生金融工具具体投资方式
					String COL127  = map.get("COL127");   //衍生金融工具挂钩的标的资产
					String COL128  = map.get("COL128");   //利息结算方式
					String COL129  = map.get("COL129");   //含权情况说明
					String COL130  = map.get("COL130");   //结构性票据最高收益率%
					String COL131  = map.get("COL131");   //结构性票据最低收益率%
					String COL132  = map.get("COL132");   //挂钩标的资产基准价格
					String COL133  = map.get("COL133");   //挂钩标的资产登记日价格
					String COL134  = map.get("COL134");   //交易费
					String COL135  = map.get("COL135");   // *资管计划名称
					String COL136  = map.get("COL136");   //资管计划发起人机构编码
					String COL137  = map.get("COL137");   //资管计划登记编码
					String COL138  = map.get("COL138");   //管理人
					String COL139  = map.get("COL139");   //托管人
					String COL140  = map.get("COL140");   //金额
					String COL141  = map.get("COL141");   //资金实际投向
					String COL142  = map.get("COL142");   // *资金运用方式
					String COL143  = map.get("COL143");   // *资金运用行业
					String COL144  = map.get("COL144");   //资管计划成立日期
					String COL145  = map.get("COL145");   //资管计划终止日期
					String COL146  = map.get("COL146");   //资管计划属性
					String COL147  = map.get("COL147");   //是否有预期收益率
					String COL148  = map.get("COL148");   //预期最高收益率%
					String COL149  = map.get("COL149");   //预期最低收益率%
					String COL150  = map.get("COL150");   //购买结构
					String COL151  = map.get("COL151");   //管理方式
					String COL152  = map.get("COL152");   //是否掌控计划底层资产详情
					String COL153  = map.get("COL153");   //管理费率%
					String COL154  = map.get("COL154");   //托管费率%
					String COL155  = map.get("COL155");   //交易相关合计费率%
					String COL156  = map.get("COL156");   //中介服务机构合计费率%
					String COL157  = map.get("COL157");   // *其他合计费率%
					String COL158  = map.get("COL158");   //所属国家或地区
					String COL159  = map.get("COL159");   //名称
					String COL160  = map.get("COL160");   //期限（天）
					String COL161  = map.get("COL161");   //资产价值
					String COL162  = map.get("COL162");   // 资产收益率%
					String COL163  = map.get("COL163");   //名称
					String COL164  = map.get("COL164");   //行内资产类别
					String COL165  = map.get("COL165");   //金额
					String COL166  = map.get("COL166");   //起息日
					String COL167  = map.get("COL167");   //到期日
					String COL168  = map.get("COL168");   //所属国家或地区
					String COL169  = map.get("COL169");   //是否有预期收益率
					String COL170  = map.get("COL170");   //项目收益率（利率）%
					String COL171  = map.get("COL171");   //付息频率（个月/次）
					String COL172  = map.get("COL172");   //融资人
					String COL173  = map.get("COL173");   //融资人组织机构（社会信用）代码
					String COL174  = map.get("COL174");   //外部评级机构名称及对融资人评级结果
					String COL175  = map.get("COL175");   //融资人类型（按规模划分）
					String COL176  = map.get("COL176");   //融资人类型（按技术领域划分）
					String COL177  = map.get("COL177");   //融资人类型（按经济类型划分）
					String COL178  = map.get("COL178");   //融资项目
					String COL179  = map.get("COL179");   //融资人所属行业
					String COL180  = map.get("COL180");   //融资项目所属行业
					String COL181  = map.get("COL181");   //项目是否属于重点监控行业和领域
					String COL182  = map.get("COL182");   //重点监控行业和领域类别
					String COL183  = map.get("COL183");   //重点监控行业和领域类别说明
					String COL184  = map.get("COL184");   //对应资产外部评级
					String COL185  = map.get("COL185");   //所属国家或地区
					String COL186  = map.get("COL186");   //名称
					String COL187  = map.get("COL187");   //起息日
					String COL188  = map.get("COL188");   //到期日
					String COL189  = map.get("COL189");   //资产价值
					String COL190  = map.get("COL190");   //资产收益率%
					String COL191  = map.get("COL191");   //基金代码
					String COL192  = map.get("COL192");   //基金名称
					String COL193  = map.get("COL193");   //行业
					String COL194  = map.get("COL194");   //登记备案机构
					String COL195  = map.get("COL195");   //产业投资基金公司名称
					String COL196  = map.get("COL196");   //基金管理机构名称
					String COL197  = map.get("COL197");   //基金托管机构名称
					String COL198  = map.get("COL198");   //投资阶段
					String COL199  = map.get("COL199");   //投资企业类型（按规模划分）
					String COL200  = map.get("COL200");   //投资企业类型（按技术领域划分）
					String COL201  = map.get("COL201");   //投资企业类型（按经济类型划分）
					String COL202  = map.get("COL202");   //基金投资资产
					String COL203  = map.get("COL203");   //所属国家或地区
					String COL204  = map.get("COL204");   //名称
					String COL205  = map.get("COL205");   //期限（天）
					String COL206  = map.get("COL206");   //负债规模
					String COL207  = map.get("COL207");   //利率%
					String COL208  = map.get("COL208");   //备注


					//给对象赋值
					obj.setString("COL001",COL001);
					obj.setString("COL002",COL002);
					obj.setString("COL003",COL003);
					obj.setString("COL004",COL004);
					obj.setString("COL005",COL005);
					obj.setString("COL006",COL006);
					obj.setString("COL007",COL007);
					obj.setString("COL008",COL008);
					obj.setString("COL009",COL009);
					obj.setString("COL010",COL010);
					obj.setString("COL011",COL011);
					obj.setString("COL012",COL012);
					obj.setString("COL013",COL013);
					obj.setString("COL014",COL014);
					obj.setString("COL015",COL015);
					obj.setString("COL016",COL016);
					obj.setString("COL017",COL017);
					obj.setString("COL018",COL018);
					obj.setString("COL019",COL019);
					obj.setString("COL020",COL020);
					obj.setString("COL021",COL021);
					obj.setString("COL022",COL022);
					obj.setString("COL023",COL023);
					obj.setString("COL024",COL024);
					obj.setString("COL025",COL025);
					obj.setString("COL026",COL026);
					obj.setString("COL027",COL027);
					obj.setString("COL028",COL028);
					obj.setString("COL029",COL029);
					obj.setString("COL030",COL030);
					obj.setString("COL031",COL031);
					obj.setString("COL032",COL032);
					obj.setString("COL033",COL033);
					obj.setString("COL034",COL034);
					obj.setString("COL035",COL035);
					obj.setString("COL036",COL036);
					obj.setString("COL037",COL037);
					obj.setString("COL038",COL038);
					obj.setString("COL039",COL039);
					obj.setString("COL040",COL040);
					obj.setString("COL041",COL041);
					obj.setString("COL042",COL042);
					obj.setString("COL043",COL043);
					obj.setString("COL044",COL044);
					obj.setString("COL045",COL045);
					obj.setString("COL046",COL046);
					obj.setString("COL047",COL047);
					obj.setString("COL048",COL048);
					obj.setString("COL049",COL049);
					obj.setString("COL050",COL050);
					obj.setString("COL051",COL051);
					obj.setString("COL052",COL052);
					obj.setString("COL053",COL053);
					obj.setString("COL054",COL054);
					obj.setString("COL055",COL055);
					obj.setString("COL056",COL056);
					obj.setString("COL057",COL057);
					obj.setString("COL058",COL058);
					obj.setString("COL059",COL059);
					obj.setString("COL060",COL060);
					obj.setString("COL061",COL061);
					obj.setString("COL062",COL062);
					obj.setString("COL063",COL063);
					obj.setString("COL064",COL064);
					obj.setString("COL065",COL065);
					obj.setString("COL066",COL066);
					obj.setString("COL067",COL067);
					obj.setString("COL068",COL068);
					obj.setString("COL069",COL069);
					obj.setString("COL070",COL070);
					obj.setString("COL071",COL071);
					obj.setString("COL072",COL072);
					obj.setString("COL073",COL073);
					obj.setString("COL074",COL074);
					obj.setString("COL075",COL075);
					obj.setString("COL076",COL076);
					obj.setString("COL077",COL077);
					obj.setString("COL078",COL078);
					obj.setString("COL079",COL079);
					obj.setString("COL080",COL080);
					obj.setString("COL081",COL081);
					obj.setString("COL082",COL082);
					obj.setString("COL083",COL083);
					obj.setString("COL084",COL084);
					obj.setString("COL085",COL085);
					obj.setString("COL086",COL086);
					obj.setString("COL087",COL087);
					obj.setString("COL088",COL088);
					obj.setString("COL089",COL089);
					obj.setString("COL090",COL090);
					obj.setString("COL091",COL091);
					obj.setString("COL092",COL092);
					obj.setString("COL093",COL093);
					obj.setString("COL094",COL094);
					obj.setString("COL095",COL095);
					obj.setString("COL096",COL096);
					obj.setString("COL097",COL097);
					obj.setString("COL098",COL098);
					obj.setString("COL099",COL099);
					obj.setString("COL100",COL100);
					obj.setString("COL101",COL101);
					obj.setString("COL102",COL102);
					obj.setString("COL103",COL103);
					obj.setString("COL104",COL104);
					obj.setString("COL105",COL105);
					obj.setString("COL106",COL106);
					obj.setString("COL107",COL107);
					obj.setString("COL108",COL108);
					obj.setString("COL109",COL109);
					obj.setString("COL110",COL110);
					obj.setString("COL111",COL111);
					obj.setString("COL112",COL112);
					obj.setString("COL113",COL113);
					obj.setString("COL114",COL114);
					obj.setString("COL115",COL115);
					obj.setString("COL116",COL116);
					obj.setString("COL117",COL117);
					obj.setString("COL118",COL118);
					obj.setString("COL119",COL119);
					obj.setString("COL120",COL120);
					obj.setString("COL121",COL121);
					obj.setString("COL122",COL122);
					obj.setString("COL123",COL123);
					obj.setString("COL124",COL124);
					obj.setString("COL125",COL125);
					obj.setString("COL126",COL126);
					obj.setString("COL127",COL127);
					obj.setString("COL128",COL128);
					obj.setString("COL129",COL129);
					obj.setString("COL130",COL130);
					obj.setString("COL131",COL131);
					obj.setString("COL132",COL132);
					obj.setString("COL133",COL133);
					obj.setString("COL134",COL134);
					obj.setString("COL135",COL135);
					obj.setString("COL136",COL136);
					obj.setString("COL137",COL137);
					obj.setString("COL138",COL138);
					obj.setString("COL139",COL139);
					obj.setString("COL140",COL140);
					obj.setString("COL141",COL141);
					obj.setString("COL142",COL142);
					obj.setString("COL143",COL143);
					obj.setString("COL144",COL144);
					obj.setString("COL145",COL145);
					obj.setString("COL146",COL146);
					obj.setString("COL147",COL147);
					obj.setString("COL148",COL148);
					obj.setString("COL149",COL149);
					obj.setString("COL150",COL150);
					obj.setString("COL151",COL151);
					obj.setString("COL152",COL152);
					obj.setString("COL153",COL153);
					obj.setString("COL154",COL154);
					obj.setString("COL155",COL155);
					obj.setString("COL156",COL156);
					obj.setString("COL157",COL157);
					obj.setString("COL158",COL158);
					obj.setString("COL159",COL159);
					obj.setString("COL160",COL160);
					obj.setString("COL161",COL161);
					obj.setString("COL162",COL162);
					obj.setString("COL163",COL163);
					obj.setString("COL164",COL164);
					obj.setString("COL165",COL165);
					obj.setString("COL166",COL166);
					obj.setString("COL167",COL167);
					obj.setString("COL168",COL168);
					obj.setString("COL169",COL169);
					obj.setString("COL170",COL170);
					obj.setString("COL171",COL171);
					obj.setString("COL172",COL172);
					obj.setString("COL173",COL173);
					obj.setString("COL174",COL174);
					obj.setString("COL175",COL175);
					obj.setString("COL176",COL176);
					obj.setString("COL177",COL177);
					obj.setString("COL178",COL178);
					obj.setString("COL179",COL179);
					obj.setString("COL180",COL180);
					obj.setString("COL181",COL181);
					obj.setString("COL182",COL182);
					obj.setString("COL183",COL183);
					obj.setString("COL184",COL184);
					obj.setString("COL185",COL185);
					obj.setString("COL186",COL186);
					obj.setString("COL187",COL187);
					obj.setString("COL188",COL188);
					obj.setString("COL189",COL189);
					obj.setString("COL190",COL190);
					obj.setString("COL191",COL191);
					obj.setString("COL192",COL192);
					obj.setString("COL193",COL193);
					obj.setString("COL194",COL194);
					obj.setString("COL195",COL195);
					obj.setString("COL196",COL196);
					obj.setString("COL197",COL197);
					obj.setString("COL198",COL198);
					obj.setString("COL199",COL199);
					obj.setString("COL200",COL200);
					obj.setString("COL201",COL201);
					obj.setString("COL202",COL202);
					obj.setString("COL203",COL203);
					obj.setString("COL204",COL204);
					obj.setString("COL205",COL205);
					obj.setString("COL206",COL206);
					obj.setString("COL207",COL207);
					obj.setString("COL208",COL208);
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
				  .append("  t.vc_product_name, ")//产品名称
				  .append("  t1.l_product_id, ")//产品名称
				  .append("  t1.l_parent_id, ")//产品名称
				  .append("  t.vc_product_code|| '-' ||t.vc_product_name productcodename ")//产品代码+产品名称
				  .append("  from t_ats_product_info t,t_ats_product_tree t1 ")
				  .append(" where 1 = 1 ")
				  .append(" and t.vc_product_code = t1.vc_product_code  ");
				
				//新增查询条件
				if(StringUtils.isNotBlank(combProductCodes)){
					sb.append(" and t.vc_product_code in (").append(JDBCUtil.changeInStr(combProductCodes)).append(") ");
				}
				if(StringUtils.isNotBlank(searchKey)){
					sb.append(" and (t.vc_product_code like '%").append(searchKey).append("%' or t.vc_product_name like '%").append(searchKey).append("%') ");
				}
				sb.append("   union all ")
				  .append("   select distinct t.vc_product_code, ")
				  .append("   t.vc_product_name, ")
				  .append("   null,null, ")
				  .append("   t.vc_product_code|| '-' ||t.vc_product_name productcodename ")
				  .append("   from t_ats_product_info t where 1=1 ");
				//新增查询条件
				if(StringUtils.isNotBlank(combProductCodes)){
					sb.append(" and t.vc_product_code in (").append(JDBCUtil.changeInStr(combProductCodes)).append(") ");
				}
				if(StringUtils.isNotBlank(searchKey)){
					sb.append(" and (t.vc_product_code like '%").append(searchKey).append("%' or t.vc_product_name like '%").append(searchKey).append("%') ");
				}
				sb.append(" and t.vc_product_code not in (select vc_product_code from t_ats_product_tree) ");
				
			//排序SQL语句
			String sqlOrder = " order by vc_product_code asc";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConn(conn, sb.toString(),null);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					String vc_fund_code = map.get("VC_PRODUCT_CODE");
					String vc_fund_name = map.get("VC_PRODUCT_NAME");
					String fundCodeName = map.get("PRODUCTCODENAME");
					String L_PRODUCT_ID = map.get("L_PRODUCT_ID");
					String L_PARENT_ID = map.get("L_PARENT_ID");
					
					obj = DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.customEntityDataset.CombProduct");
					obj.setString("fundCode", vc_fund_code);
					obj.setString("fundName", vc_fund_name);
					obj.setString("fundCodeName", fundCodeName);
					obj.setString("L_PRODUCT_ID", L_PRODUCT_ID);
					obj.setString("L_PARENT_ID", L_PARENT_ID);
					
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
	
}
