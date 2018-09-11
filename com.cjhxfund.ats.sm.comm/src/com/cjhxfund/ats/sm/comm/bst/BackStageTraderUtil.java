package com.cjhxfund.ats.sm.comm.bst;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.CacheUtil;
import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.commonUtil.JDBCUtil;
import com.cjhxfund.commonUtil.StrUtil;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;

/**
 * 综合信息查询处理公共类
 * @author huangmizhi
 * @date 2016-03-03 09:42:20
 */
@Bizlet("")
public class BackStageTraderUtil {
	/** 当前classpath的绝对URI路径 */
	public static String CLASS_PATH = "";
	/** 结算指令下载查询sql语句 */
	public static String SQL_JSZLXZ = "";
	/** 结算合同下载查询sql语句 */
	public static String SQL_JSHTXZ = "";
	/** 分销数据列表查询sql语句 */
	public static String SQL_FXSJLB = "";
	/** 买断式回购列表查询sql语句 */
	public static String SQL_MDSHGLB = "";
	/** 现券交易列表查询sql语句 */
	public static String SQL_XQJYLB = "";
	/** 质押式回购列表查询sql语句 */
	public static String SQL_ZYSHGLB = "";
	/** 全额结算指令列表查询sql语句 */
	public static String SQL_QEJSZL = "";
	/** 上清所指令数据(新)**/
	public static String SQL_SQSZL = "";
	/** 上清所结算数据(新)**/
	public static String SQL_SQSJS = "";
	
	/** 当前classpath的绝对URI路径 */
	/** 综合信息查询SQL文件存放路径 */
	public static String ZHXXCX_FILE_PATH = "";
	
	static {
		String os = System.getProperty("os.name");
		if(StringUtils.isNotEmpty(os) && os.toLowerCase().startsWith("win")){
			CLASS_PATH = BackStageTraderUtil.class.getResource("/").getPath().substring(1);
		}else{
			CLASS_PATH = BackStageTraderUtil.class.getResource("/").getPath();
		}
		ZHXXCX_FILE_PATH = CLASS_PATH + "confFile" + File.separator + "sqlFile" + File.separator + "backStageTrader" + File.separator;
	}
	
	/**
	 * 根据SQL文件名称获取SQL文件内容字符串
	 * @param sqlFile SQL文件名称
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getFileSql(String sqlFile){
		return StrUtil.findContentStr(ZHXXCX_FILE_PATH+sqlFile, null);
	}
	
	/**
	 * 结算指令下载表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryJSZLXZ(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_JSZLXZ)){
				SQL_JSZLXZ = BackStageTraderUtil.getFileSql("bst_jszlxz.sql");
			}
			
			//获取页面传进来的查询条件值
			String vcOrgtrnm = paramObject.getString("vcOrgtrnm");//客户简称（查询条件传入）
			String vcCtrptynm = paramObject.getString("vcCtrptynm");//对手方简称（查询条件传入）
			String vcBiztp = paramObject.getString("vcBiztp");//业务类别描述（查询条件传入）
			String vcFrstdlvrydt = DateUtil.format(paramObject.getDate("vcFrstdlvrydt"), DateUtil.YMD_NUMBER);//首次交割日（查询条件传入）
			String vcScnddlvrydt = DateUtil.format(paramObject.getDate("vcScnddlvrydt"), DateUtil.YMD_NUMBER);//到期交割日/远期交割成交日（查询条件传入）
			String vcInstrsts = paramObject.getString("vcInstrsts");//指令状态描述（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			//拼接SQL语句
			sb.append(SQL_JSZLXZ);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcOrgtrnm)){
				vcOrgtrnm = vcOrgtrnm.trim();
				sb.append("   and a.vc_orgtrnm like '%").append(vcOrgtrnm).append("%'");
			}
			if(StringUtils.isNotBlank(vcCtrptynm)){
				vcCtrptynm = vcCtrptynm.trim();
				sb.append("   and a.vc_ctrptynm like '%").append(vcCtrptynm).append("%'");
			}						
			if(StringUtils.isNotBlank(vcBiztp)){
				vcBiztp = vcBiztp.trim();
				sb.append("   and a.vc_biztp like '%").append(vcBiztp).append("%'");
			}
			if(StringUtils.isNotBlank(vcFrstdlvrydt)){
				sb.append("   and a.vc_frstdlvrydt = ").append("'"+vcFrstdlvrydt+"'");
			}
			if(StringUtils.isNotBlank(vcScnddlvrydt)){
				sb.append("   and a.vc_scnddlvrydt = ").append("'"+vcScnddlvrydt+"'");
			}
			if(StringUtils.isNotBlank(vcInstrsts)){
				vcInstrsts = vcInstrsts.trim();
				sb.append("   and a.vc_instrsts like '%").append(vcInstrsts).append("%'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					//获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_INSTRID = map.get("VC_INSTRID");   //指令编号
					String VC_ORGTRNM	 = map.get("VC_ORGTRNM");   //客户简称
					String VC_ORGTRSUBACCTID = map.get("VC_ORGTRSUBACCTID");   //本方分组合号
					String VC_ORGTRSUBNM	 = map.get("VC_ORGTRSUBNM");  //本方分组合简称
					String VC_ORGTRACCTID = map.get("VC_ORGTRACCTID");  //债券账号
					String VC_ACCTWTHDVPNETGCONFD = map.get("VC_ACCTWTHDVPNETGCONFD");  //预发行净额结算DVP被确认账号
					String VC_ACCTWTHMRGNBLCKGCONFD = map.get("VC_ACCTWTHMRGNBLCKGCONFD"); //保证金冻结确认被确认账号
					String VC_ACCTWHTMRGNUNBLCKGCONFD =  map.get("VC_ACCTWHTMRGNUNBLCKGCONFD"); //保证金解冻确认被确认账号
					String VC_CTRPTYNM =  map.get("VC_CTRPTYNM"); //对手方简称
					String VC_CTRPTYACCT =  map.get("VC_CTRPTYACCT"); //对手方账号
					String VC_BIZTPCD =  map.get("VC_BIZTPCD"); //业务类别编号
					String VC_BIZTP =  map.get("VC_BIZTP"); //业务类别描述
					String VC_TXDRCTN =  map.get("VC_TXDRCTN"); //交易方向描述
					String VC_CSHSTTLEMDRCTN =  map.get("VC_CSHSTTLEMDRCTN"); //现金了结方向描述
					String VC_CONFDCSHDRCTN = map.get("VC_CONFDCSHDRCTN"); //预发行净额结算DVP被确认款方向描述
					String VC_FRSTLEGCD = map.get("VC_FRSTLEGCD"); // 首次结算方式代码
					String VC_FRSTLEG = map.get("VC_FRSTLEG"); // 首次结算方式符号描述
					String VC_FRSTLEGINCHIN = map.get("VC_FRSTLEGINCHIN"); // 首次结算方式中文描述
					String VC_SCNDLEGCD = map.get("VC_SCNDLEGCD"); // 到期结算方式代码
					String VC_SCNDLEG = map.get("VC_SCNDLEG"); // 到期结算方式符号描述
					String VC_SCNDLEGINCHIN = map.get("VC_SCNDLEGINCHIN"); // 到期结算方式中文描述
					String VC_FRSTDLVRYDT = map.get("VC_FRSTDLVRYDT"); // 首次交割日
					String VC_SCNDDLVRYDT = map.get("VC_SCNDDLVRYDT"); // 到期交割日/远期交割成交日
					String VC_FRSTSTTLEMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_FRSTSTTLEMVAL"), StrUtil.df1); // 首期资金清算额/净价金额/融资解押返还资金额(含融资利息)/BEPS调增、调减额度/BEPS置换换入额度
					String VC_CSHSTTLEMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_CSHSTTLEMVAL"), StrUtil.df1); // 现金了结交割金额
					String VC_MRGNBLCKGVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_MRGNBLCKGVAL"), StrUtil.df1); // 	保证金冻结金额
					String VC_MRGNUNBLCKGVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_MRGNUNBLCKGVAL"), StrUtil.df1); // 保证金解冻金额
					String VC_SCNDSTTLEMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_SCNDSTTLEMVAL"), StrUtil.df1); // 到期资金清算额/全价金额/融资解押融资利息/融资质押起点金额/BEPS置换换出额度
					String VC_FRSTLEGPRIC = StrUtil.addThousandth0ToEmpty(map.get("VC_FRSTLEGPRIC"), StrUtil.df1); // 首次结算价格/净价
					String VC_SCNDLEGPRIC = StrUtil.addThousandth0ToEmpty(map.get("VC_SCNDLEGPRIC"), StrUtil.df1); // 到期结算价格/全价
					String VC_TTLFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_TTLFACEAMT"), StrUtil.df1); // 债券面额合计
					String VC_TXID = map.get("VC_TXID"); // 业务标识号
					String VC_REPORATE = map.get("VC_REPORATE"); // 回购年利率
					String VC_OVRDUEDAYS = map.get("VC_OVRDUEDAYS"); // 逾期天数/融资解押资金使用天数
					String VC_SCTIESLNDGTERM = map.get("VC_SCTIESLNDGTERM"); // 质押融券期限
					String VC_ORGTRGRTETPCD = map.get("VC_ORGTRGRTETPCD"); // 发令方保证方式
					String VC_MRGNBLCKGIND = map.get("VC_MRGNBLCKGIND"); // 保证金冻结成功失败标志
					String VC_MRGNUNBLCKGIND = map.get("VC_MRGNUNBLCKGIND"); // 保证金解冻成功失败标志
					String VC_ORGTRGRTETP = map.get("VC_ORGTRGRTETP"); // 发令方保证方式描述
					String VC_CNTRPTYGRTETPCD = map.get("VC_CNTRPTYGRTETPCD"); // 对手方保证方式
					String VC_COLLSBSTITNIND = map.get("VC_COLLSBSTITNIND"); // 是否允许替换质押品
					String VC_CNTRPTYGRTETP = map.get("VC_CNTRPTYGRTETP"); // 对手方保证方式描述
					String VC_ORGTRGRTEBDSEQNB = map.get("VC_ORGTRGRTEBDSEQNB"); // 发令方保证券债券序号
					String VC_ORGTRGRTEBDID = map.get("VC_ORGTRGRTEBDID"); // 发令方保证券债券代码
					String VC_ORGTRGRTEBDSHRTNM = map.get("VC_ORGTRGRTEBDSHRTNM"); // 发令方保证券债券简称
					String VC_ORGTRGRTEBDFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_ORGTRGRTEBDFACEAMT"), StrUtil.df1); // 发令方保证券债券面额
					String VC_OTCBUYGFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCBUYGFACEAMT"), StrUtil.df1); // 柜台专项结算买入面额
					String VC_ORGTRGRTEMRGN = StrUtil.addThousandth0ToEmpty(map.get("VC_ORGTRGRTEMRGN"), StrUtil.df1); // 发令方保证金
					String VC_OTCBUYGVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCBUYGVAL"), StrUtil.df1); // 柜台专项结算买入金额
					String VC_CTRPTYGRTEBDSEQNB = map.get("VC_CTRPTYGRTEBDSEQNB"); // 对手方保证券债券序号
					String VC_CNTRPTYGRTEBDID = map.get("VC_CNTRPTYGRTEBDID"); // 对手方保证券债券代码
					String VC_CNTRPTYGRTEBDSHRTNM = map.get("VC_CNTRPTYGRTEBDSHRTNM"); // 对手方保证券债券简称
					String VC_CNTRPTYGRTEBDFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_CNTRPTYGRTEBDFACEAMT"), StrUtil.df1); // 对手方保证券债券面额
					String VC_OTCSELLGFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCSELLGFACEAMT"), StrUtil.df1); // 柜台专项结算卖出面额
					String VC_CNTRPTYCSHCOLL = StrUtil.addThousandth0ToEmpty(map.get("VC_CNTRPTYCSHCOLL"), StrUtil.df1); // 对手方保证金
					String VC_OTCSELLGVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCSELLGVAL"), StrUtil.df1); // 柜台专项结算卖出金额
					String VC_CROSSTRFAPLT = map.get("VC_CROSSTRFAPLT"); // 转托管申请人
					String VC_ORGNLCTRCTID = map.get("VC_ORGNLCTRCTID"); // 对应合同号
					String VC_ORGNLINSTRID = map.get("VC_ORGNLINSTRID"); // 对应指令号
					String VC_TRANSFEREEID = map.get("VC_TRANSFEREEID"); // 转入方账号
					String VC_TRANSFERORID = map.get("VC_TRANSFERORID"); // 转出方账号
					String VC_OPRTR = map.get("VC_OPRTR"); // 操作员
					String VC_CHCKER = map.get("VC_CHCKER"); // 复核员
					String VC_CNFRMOR = map.get("VC_CNFRMOR"); // 确认员
					String VC_INSTRACCPTTM = map.get("VC_INSTRACCPTTM"); // 指令接收时间
					String VC_INSTRCHCKTM = map.get("VC_INSTRCHCKTM"); // 指令复核时间
					String VC_INSTRCNFRMTM = map.get("VC_INSTRCNFRMTM"); // 指令确认时间
					String VC_INSTRSTSCD = map.get("VC_INSTRSTSCD"); // 指令状态
					String VC_INSTRSTS = map.get("VC_INSTRSTS"); // 指令状态描述
					String VC_LASTUPDTM = map.get("VC_LASTUPDTM"); // 最近更新时间
					String VC_GVRCSHLCTNCD = map.get("VC_GVRCSHLCTNCD"); // 付券方保证金保管地
					String VC_GVRCSHLCTN = map.get("VC_GVRCSHLCTN"); // 付券方保证金保管地描述
					String VC_TAKERCSHLCTNCD = map.get("VC_TAKERCSHLCTNCD"); // 收券方保证金保管地
					String VC_TAKERCSHLCTN = map.get("VC_TAKERCSHLCTN"); // 收券方保证金保管地描述
					String VC_COLLMDLCD = map.get("VC_COLLMDLCD"); // 担保模式代码
					String VC_COLLMDL = map.get("VC_COLLMDL"); // 担保模式描述
					
					//给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_INSTRID", VC_INSTRID);
					obj.setString("VC_ORGTRNM", VC_ORGTRNM);
					obj.setString("VC_ORGTRSUBACCTID", VC_ORGTRSUBACCTID);
					obj.setString("VC_ORGTRSUBNM", VC_ORGTRSUBNM);
					obj.setString("VC_ORGTRACCTID", VC_ORGTRACCTID);
					obj.setString("VC_ACCTWTHDVPNETGCONFD", VC_ACCTWTHDVPNETGCONFD);
					obj.setString("VC_ACCTWTHMRGNBLCKGCONFD", VC_ACCTWTHMRGNBLCKGCONFD);
					obj.setString("VC_ACCTWHTMRGNUNBLCKGCONFD", VC_ACCTWHTMRGNUNBLCKGCONFD);
					obj.setString("VC_CTRPTYNM", VC_CTRPTYNM);
					obj.setString("VC_CTRPTYACCT", VC_CTRPTYACCT);
					obj.setString("VC_BIZTPCD", VC_BIZTPCD);
					obj.setString("VC_BIZTP", VC_BIZTP);
					obj.setString("VC_TXDRCTN", VC_TXDRCTN);
					obj.setString("VC_CSHSTTLEMDRCTN", VC_CSHSTTLEMDRCTN);
					obj.setString("VC_CONFDCSHDRCTN", VC_CONFDCSHDRCTN);
					obj.setString("VC_FRSTLEGCD", VC_FRSTLEGCD);
					obj.setString("VC_FRSTLEG", VC_FRSTLEG);
					obj.setString("VC_FRSTLEGINCHIN", VC_FRSTLEGINCHIN);
					obj.setString("VC_SCNDLEGCD", VC_SCNDLEGCD);
					obj.setString("VC_SCNDLEG", VC_SCNDLEG);
					obj.setString("VC_SCNDLEGINCHIN", VC_SCNDLEGINCHIN);
					obj.setString("VC_FRSTDLVRYDT", VC_FRSTDLVRYDT);
					obj.setString("VC_SCNDDLVRYDT", VC_SCNDDLVRYDT);
					obj.setString("VC_FRSTSTTLEMVAL", VC_FRSTSTTLEMVAL);
					obj.setString("VC_CSHSTTLEMVAL", VC_CSHSTTLEMVAL);
					obj.setString("VC_MRGNBLCKGVAL", VC_MRGNBLCKGVAL);
					obj.setString("VC_MRGNUNBLCKGVAL", VC_MRGNUNBLCKGVAL);
					obj.setString("VC_SCNDSTTLEMVAL", VC_SCNDSTTLEMVAL);
					obj.setString("VC_FRSTLEGPRIC", VC_FRSTLEGPRIC);
					obj.setString("VC_SCNDLEGPRIC", VC_SCNDLEGPRIC);
					obj.setString("VC_TTLFACEAMT", VC_TTLFACEAMT);
					obj.setString("VC_TXID", VC_TXID);
					obj.setString("VC_REPORATE", VC_REPORATE);
					obj.setString("VC_OVRDUEDAYS", VC_OVRDUEDAYS);
					obj.setString("VC_SCTIESLNDGTERM", VC_SCTIESLNDGTERM);
					obj.setString("VC_ORGTRGRTETPCD", VC_ORGTRGRTETPCD);
					obj.setString("VC_MRGNBLCKGIND", VC_MRGNBLCKGIND);
					obj.setString("VC_MRGNUNBLCKGIND", VC_MRGNUNBLCKGIND);
					obj.setString("VC_ORGTRGRTETP", VC_ORGTRGRTETP);
					obj.setString("VC_CNTRPTYGRTETPCD", VC_CNTRPTYGRTETPCD);
					obj.setString("VC_COLLSBSTITNIND", VC_COLLSBSTITNIND);
					obj.setString("VC_CNTRPTYGRTETP", VC_CNTRPTYGRTETP);
					obj.setString("VC_ORGTRGRTEBDSEQNB", VC_ORGTRGRTEBDSEQNB);
					obj.setString("VC_ORGTRGRTEBDID", VC_ORGTRGRTEBDID);
					obj.setString("VC_ORGTRGRTEBDSHRTNM", VC_ORGTRGRTEBDSHRTNM);
					obj.setString("VC_ORGTRGRTEBDFACEAMT", VC_ORGTRGRTEBDFACEAMT);
					obj.setString("VC_OTCBUYGFACEAMT", VC_OTCBUYGFACEAMT);
					obj.setString("VC_ORGTRGRTEMRGN", VC_ORGTRGRTEMRGN);
					obj.setString("VC_OTCBUYGVAL", VC_OTCBUYGVAL);
					obj.setString("VC_CTRPTYGRTEBDSEQNB", VC_CTRPTYGRTEBDSEQNB	);
					obj.setString("VC_CNTRPTYGRTEBDID", VC_CNTRPTYGRTEBDID);
					obj.setString("VC_CNTRPTYGRTEBDSHRTNM", VC_CNTRPTYGRTEBDSHRTNM);
					obj.setString("VC_CNTRPTYGRTEBDFACEAMT", VC_CNTRPTYGRTEBDFACEAMT);
					obj.setString("VC_OTCSELLGFACEAMT", VC_OTCSELLGFACEAMT);
					obj.setString("VC_CNTRPTYCSHCOLL", VC_CNTRPTYCSHCOLL);
					obj.setString("VC_OTCSELLGVAL", VC_OTCSELLGVAL);
					obj.setString("VC_CROSSTRFAPLT", VC_CROSSTRFAPLT);
					obj.setString("VC_ORGNLCTRCTID", VC_ORGNLCTRCTID	);
					obj.setString("VC_ORGNLINSTRID", VC_ORGNLINSTRID);
					obj.setString("VC_TRANSFEREEID", VC_TRANSFEREEID);
					obj.setString("VC_TRANSFERORID", VC_TRANSFERORID);
					obj.setString("VC_OPRTR", VC_OPRTR);
					obj.setString("VC_CHCKER", VC_CHCKER);
					obj.setString("VC_CNFRMOR", VC_CNFRMOR);
					obj.setString("VC_INSTRACCPTTM", VC_INSTRACCPTTM);
					obj.setString("VC_INSTRCHCKTM", VC_INSTRCHCKTM);
					obj.setString("VC_INSTRCNFRMTM", VC_INSTRCNFRMTM);
					obj.setString("VC_INSTRSTSCD", VC_INSTRSTSCD);
					obj.setString("VC_INSTRSTS", VC_INSTRSTS);
					obj.setString("VC_LASTUPDTM", VC_LASTUPDTM);
					obj.setString("VC_GVRCSHLCTNCD", VC_GVRCSHLCTNCD);
					obj.setString("VC_GVRCSHLCTN", VC_GVRCSHLCTN);
					obj.setString("VC_TAKERCSHLCTNCD", VC_TAKERCSHLCTNCD);
					obj.setString("VC_TAKERCSHLCTN", VC_TAKERCSHLCTN);
					obj.setString("VC_COLLMDLCD", VC_COLLMDLCD);
					obj.setString("VC_COLLMDL", VC_COLLMDL);
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
	 * 结算合同下载表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryJSHTXZ(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_JSHTXZ)){
				SQL_JSHTXZ = BackStageTraderUtil.getFileSql("bst_jshtxz.sql");
			}
			
			//获取页面传进来的查询条件值
			String vcBdgvrnm = paramObject.getString("vcBdgvrnm");//付券方简称（查询条件传入）
			String vcBdtakernm = paramObject.getString("vcBdtakernm");//收券方简称（查询条件传入）
			String vcBiztp = paramObject.getString("vcBiztp");//业务类别描述（查询条件传入）
			String vcDlvrydt = DateUtil.format(paramObject.getDate("vcDlvrydt"), DateUtil.YMD_NUMBER);//交割日（查询条件传入）
			String vcCshsts = paramObject.getString("vcCshsts");//资金状态描述（查询条件传入）
			String vcCtrctsts = paramObject.getString("vcCtrctsts");//合同状态描述（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			//拼接SQL语句
			sb.append(SQL_JSHTXZ);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcBdgvrnm)){
				vcBdgvrnm = vcBdgvrnm.trim();
				sb.append("   and a.VC_BDGVRNM like '%").append(vcBdgvrnm).append("%'");
			}
			if(StringUtils.isNotBlank(vcBdtakernm)){
				vcBdtakernm = vcBdtakernm.trim();
				sb.append("   and a.VC_BDTAKERNM like '%").append(vcBdtakernm).append("%'");
			}						
			if(StringUtils.isNotBlank(vcBiztp)){
				vcBiztp = vcBiztp.trim();
				sb.append("   and a.VC_BIZTP like '%").append(vcBiztp).append("%'");
			}
			if(StringUtils.isNotBlank(vcDlvrydt)){
				sb.append("   and a.VC_DLVRYDT = ").append("'"+vcDlvrydt+"'");
			}
			if(StringUtils.isNotBlank(vcCshsts)){
				vcCshsts = vcCshsts.trim();
				sb.append("   and a.VC_CSHSTS like '%").append(vcCshsts).append("%'");
			}
			if(StringUtils.isNotBlank(vcCtrctsts)){
				vcCtrctsts = vcCtrctsts.trim();
				sb.append("   and a.VC_CTRCTSTS like '%").append(vcCtrctsts).append("%'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_CTRCTID = map.get("VC_CTRCTID"); // 合同编号
					String VC_INSTRORGNACCT = map.get("VC_INSTRORGNACCT"); // 指令来源账号
					String VC_BDGVRACCT = map.get("VC_BDGVRACCT"); // 付券方账号
					String VC_ACCTWTHDVPNETGCONFD = map.get("VC_ACCTWTHDVPNETGCONFD"); // 预发行净额结算DVP被确认账号
					String VC_ACCTWTHMRGNBLCKGCONFD = map.get("VC_ACCTWTHMRGNBLCKGCONFD"); // 保证金冻结确认被确认账号
					String VC_ACCTWHTMRGNUNBLCKGCONFD = map.get("VC_ACCTWHTMRGNUNBLCKGCONFD"); // 保证金解冻确认被确认账号
					String VC_BDGVRNM = map.get("VC_BDGVRNM"); // 付券方简称
					String VC_BDGVRSUBACCT = map.get("VC_BDGVRSUBACCT"); // 付券方分组合号
					String VC_BDGVRSUBNM = map.get("VC_BDGVRSUBNM"); // 付券方分组合简称
					String VC_BDTAKERACCT = map.get("VC_BDTAKERACCT"); // 收券方账号
					String VC_BDTAKERNM = map.get("VC_BDTAKERNM"); // 收券方简称
					String VC_BDTAKERSUBACCT = map.get("VC_BDTAKERSUBACCT"); // 收券方分组合号
					String VC_BDTAKESUBRNM = map.get("VC_BDTAKESUBRNM"); // 收券方分组合简称
					String VC_TXID = map.get("VC_TXID"); // 业务标识号
					String VC_BIZTPCD = map.get("VC_BIZTPCD"); // 业务类别编号
					String VC_BIZTP = map.get("VC_BIZTP"); // 业务类别描述
					String VC_STTLMTPCD = map.get("VC_STTLMTPCD"); // 结算方式代码
					String VC_STTLMTP = map.get("VC_STTLMTP"); // 结算方式符号描述
					String VC_STTLMTPINCHIN = map.get("VC_STTLMTPINCHIN"); // 结算方式中文描述
					String VC_BDGVRGRTEBDID = map.get("VC_BDGVRGRTEBDID"); // 付券方保证券债券代码
					String VC_BDGVRGRTEBDSHRTNM = map.get("VC_BDGVRGRTEBDSHRTNM"); // 付券方保证券债券简称
					String VC_BDGVRGRTEBDFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_BDGVRGRTEBDFACEAMT"), StrUtil.df1); // 付券方保证券债券面额
					String VC_OTCBUYGFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCBUYGFACEAMT"), StrUtil.df1); // 柜台专项结算买入面额
					String VC_BDGVRCSHCOLL = StrUtil.addThousandth0ToEmpty(map.get("VC_BDGVRCSHCOLL"), StrUtil.df1); // 付券方保证金/融资质押实际融资金额/BEPS质押增加待分配额度/BEPS置换换入额度
					String VC_OTCBUYGVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCBUYGVAL"), StrUtil.df1); // 柜台专项结算买入金额
					String VC_BDTAKERGRTEBDID = map.get("VC_BDTAKERGRTEBDID"); // 收券方保证券债券代码
					String VC_BDTAKERGRTEBDSHRTNM = map.get("VC_BDTAKERGRTEBDSHRTNM"); // 收券方保证券债券简称
					String VC_BDTAKERGRTEBDFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_BDTAKERGRTEBDFACEAMT"), StrUtil.df1); // 收券方保证券债券面额
					String VC_OTCSELLGVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCSELLGVAL"), StrUtil.df1); // 柜台专项结算卖出金额
					String VC_BDTAKERCSHCOLL = StrUtil.addThousandth0ToEmpty(map.get("VC_BDTAKERCSHCOLL"), StrUtil.df1); // 收券方保证金/融资质押起点金额/BEPS置换换出额度
					String VC_OTCSELLGFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_OTCSELLGFACEAMT"), StrUtil.df1); // 柜台专项结算卖出面额
					String VC_BLCKGPMTVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_BLCKGPMTVAL"), StrUtil.df1); // 冻结缴款金额
					String VC_BDCNT = map.get("VC_BDCNT"); // 债券数目
					String VC_TTLFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_TTLFACEAMT"), StrUtil.df1); // 债券总额
					String VC_CTRCTVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_CTRCTVAL"), StrUtil.df1); // 合同金额/BEPS调增、调减额度
					String VC_SCTIESLNDGFEES = StrUtil.addThousandth0ToEmpty(map.get("VC_SCTIESLNDGFEES"), StrUtil.df1); // 借贷业务融券费用
					String VC_RATE = StrUtil.addThousandth0ToEmpty(map.get("VC_RATE"), StrUtil.df1); // 回购利率
					String VC_DLVRYDT = map.get("VC_DLVRYDT"); // 交割日
					String VC_INSTRIDTOCTRCT = map.get("VC_INSTRIDTOCTRCT"); // 生成合同的指令编号
					String VC_ORGNLCTRCTID = map.get("VC_ORGNLCTRCTID"); // 原合同编号(期调、券置换、撤销合同时使用)
					String VC_ORGNLINSTRID = map.get("VC_ORGNLINSTRID"); // 原指令编号(撤销指令的指令时使用)
					String VC_GVRBDSTSCD = map.get("VC_GVRBDSTSCD"); // 付券方券状态
					String VC_GVRBDSTS = map.get("VC_GVRBDSTS"); // 付券方券状态描述
					String VC_GVRGRTEBDSTSCD = map.get("VC_GVRGRTEBDSTSCD"); // 付券方保证券状态
					String VC_GVRGRTEBDSTS = map.get("VC_GVRGRTEBDSTS"); // 付券方保证券状态描述
					String VC_TAKERBDSTSCD = map.get("VC_TAKERBDSTSCD"); // 收券方券状态
					String VC_TAKERBDSTS = map.get("VC_TAKERBDSTS"); // 收券方券状态描述
					String VC_TAKERGRTEBDSTSCD = map.get("VC_TAKERGRTEBDSTSCD"); // 收券方保证券状态
					String VC_TAKERGRTEBD = map.get("VC_TAKERGRTEBD"); // 收券方保证券状态描述
					String VC_CSHSTSCD = map.get("VC_CSHSTSCD"); // 资金状态
					String VC_CSHSTS = map.get("VC_CSHSTS"); // 资金状态描述
					String VC_BLCKDSTSCD = map.get("VC_BLCKDSTSCD"); // 冻结状态
					String VC_BLCKDSTS = map.get("VC_BLCKDSTS"); // 冻结状态描述
					String VC_EXCTDTM = map.get("VC_EXCTDTM"); // 过户时间/失败时间
					String VC_CTRCTSTSCD = map.get("VC_CTRCTSTSCD"); // 合同状态
					String VC_CTRCTSTS = map.get("VC_CTRCTSTS"); // 合同状态描述
					String VC_CTRCTCRETM = map.get("VC_CTRCTCRETM"); // 合同生成时间
					String VC_LASTUPDTM = map.get("VC_LASTUPDTM"); // 最近更新时间
					String VC_BDGVRCSHCOLLSTSCD = map.get("VC_BDGVRCSHCOLLSTSCD"); // 付券方保证金状态
					String VC_BDGVRCSHCOLLSTS = map.get("VC_BDGVRCSHCOLLSTS"); // 付券方保证金状态描述
					String VC_BDTAKERCSHCOLLSTSCD = map.get("VC_BDTAKERCSHCOLLSTSCD"); // 收券方保证金状态
					String VC_BDTAKERCSHCOLLSTS = map.get("VC_BDTAKERCSHCOLLSTS"); // 收券方保证金状态描述
					String VC_BDGVRCSHLCTNCD = map.get("VC_BDGVRCSHLCTNCD"); // 付券方保证金保管地
					String VC_BDGVRCSHLCTN = map.get("VC_BDGVRCSHLCTN"); // 付券方保证金保管地描述
					String VC_BDTAKERCSHLCTNCD = map.get("VC_BDTAKERCSHLCTNCD"); // 收券方保证金保管地
					String VC_BDTAKERCSHLCTN = map.get("VC_BDTAKERCSHLCTN"); // 收券方保证金保管地描述
					
					//给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_CTRCTID",VC_CTRCTID);
					obj.setString("VC_INSTRORGNACCT",VC_INSTRORGNACCT);
					obj.setString("VC_BDGVRACCT",VC_BDGVRACCT);
					obj.setString("VC_ACCTWTHDVPNETGCONFD",VC_ACCTWTHDVPNETGCONFD);
					obj.setString("VC_ACCTWTHMRGNBLCKGCONFD",VC_ACCTWTHMRGNBLCKGCONFD);
					obj.setString("VC_ACCTWHTMRGNUNBLCKGCONFD",VC_ACCTWHTMRGNUNBLCKGCONFD);
					obj.setString("VC_BDGVRNM",VC_BDGVRNM);
					obj.setString("VC_BDGVRSUBACCT",VC_BDGVRSUBACCT);
					obj.setString("VC_BDGVRSUBNM",VC_BDGVRSUBNM);
					obj.setString("VC_BDTAKERACCT",VC_BDTAKERACCT);
					obj.setString("VC_BDTAKERNM",VC_BDTAKERNM);
					obj.setString("VC_BDTAKERSUBACCT",VC_BDTAKERSUBACCT);
					obj.setString("VC_BDTAKESUBRNM",VC_BDTAKESUBRNM);
					obj.setString("VC_TXID",VC_TXID);
					obj.setString("VC_BIZTPCD",VC_BIZTPCD);
					obj.setString("VC_BIZTP",VC_BIZTP);
					obj.setString("VC_STTLMTPCD",VC_STTLMTPCD);
					obj.setString("VC_STTLMTP",VC_STTLMTP);
					obj.setString("VC_STTLMTPINCHIN",VC_STTLMTPINCHIN);
					obj.setString("VC_BDGVRGRTEBDID",VC_BDGVRGRTEBDID);
					obj.setString("VC_BDGVRGRTEBDSHRTNM",VC_BDGVRGRTEBDSHRTNM);
					obj.setString("VC_BDGVRGRTEBDFACEAMT",VC_BDGVRGRTEBDFACEAMT);
					obj.setString("VC_OTCBUYGFACEAMT",VC_OTCBUYGFACEAMT);
					obj.setString("VC_BDGVRCSHCOLL",VC_BDGVRCSHCOLL);
					obj.setString("VC_OTCBUYGVAL",VC_OTCBUYGVAL);
					obj.setString("VC_BDTAKERGRTEBDID",VC_BDTAKERGRTEBDID);
					obj.setString("VC_BDTAKERGRTEBDSHRTNM",VC_BDTAKERGRTEBDSHRTNM);
					obj.setString("VC_BDTAKERGRTEBDFACEAMT",VC_BDTAKERGRTEBDFACEAMT);
					obj.setString("VC_OTCSELLGVAL",VC_OTCSELLGVAL);
					obj.setString("VC_BDTAKERCSHCOLL",VC_BDTAKERCSHCOLL);
					obj.setString("VC_OTCSELLGFACEAMT",VC_OTCSELLGFACEAMT);
					obj.setString("VC_BLCKGPMTVAL",VC_BLCKGPMTVAL);
					obj.setString("VC_BDCNT",VC_BDCNT);
					obj.setString("VC_TTLFACEAMT",VC_TTLFACEAMT);
					obj.setString("VC_CTRCTVAL",VC_CTRCTVAL);
					obj.setString("VC_SCTIESLNDGFEES",VC_SCTIESLNDGFEES);
					obj.setString("VC_RATE",VC_RATE);
					obj.setString("VC_DLVRYDT",VC_DLVRYDT);
					obj.setString("VC_INSTRIDTOCTRCT",VC_INSTRIDTOCTRCT);
					obj.setString("VC_ORGNLCTRCTID",VC_ORGNLCTRCTID);
					obj.setString("VC_ORGNLINSTRID",VC_ORGNLINSTRID);
					obj.setString("VC_GVRBDSTSCD",VC_GVRBDSTSCD);
					obj.setString("VC_GVRBDSTS",VC_GVRBDSTS);
					obj.setString("VC_GVRGRTEBDSTSCD",VC_GVRGRTEBDSTSCD);
					obj.setString("VC_GVRGRTEBDSTS",VC_GVRGRTEBDSTS);
					obj.setString("VC_TAKERBDSTSCD",VC_TAKERBDSTSCD);
					obj.setString("VC_TAKERBDSTS",VC_TAKERBDSTS);
					obj.setString("VC_TAKERGRTEBDSTSCD",VC_TAKERGRTEBDSTSCD);
					obj.setString("VC_TAKERGRTEBD",VC_TAKERGRTEBD);
					obj.setString("VC_CSHSTSCD",VC_CSHSTSCD);
					obj.setString("VC_CSHSTS",VC_CSHSTS);
					obj.setString("VC_BLCKDSTSCD",VC_BLCKDSTSCD);
					obj.setString("VC_BLCKDSTS",VC_BLCKDSTS);
					obj.setString("VC_EXCTDTM",VC_EXCTDTM);
					obj.setString("VC_CTRCTSTSCD",VC_CTRCTSTSCD);
					obj.setString("VC_CTRCTSTS",VC_CTRCTSTS);
					obj.setString("VC_CTRCTCRETM",VC_CTRCTCRETM);
					obj.setString("VC_LASTUPDTM",VC_LASTUPDTM);
					obj.setString("VC_BDGVRCSHCOLLSTSCD",VC_BDGVRCSHCOLLSTSCD);
					obj.setString("VC_BDGVRCSHCOLLSTS",VC_BDGVRCSHCOLLSTS);
					obj.setString("VC_BDTAKERCSHCOLLSTSCD",VC_BDTAKERCSHCOLLSTSCD);
					obj.setString("VC_BDTAKERCSHCOLLSTS",VC_BDTAKERCSHCOLLSTS);
					obj.setString("VC_BDGVRCSHLCTNCD",VC_BDGVRCSHLCTNCD);
					obj.setString("VC_BDGVRCSHLCTN",VC_BDGVRCSHLCTN);
					obj.setString("VC_BDTAKERCSHLCTNCD",VC_BDTAKERCSHLCTNCD);
					obj.setString("VC_BDTAKERCSHLCTN",VC_BDTAKERCSHLCTN);
					
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
	 * 分销数据列表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryFXSJLB(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_FXSJLB)){
				SQL_FXSJLB = BackStageTraderUtil.getFileSql("bst_fxsjlb.sql");
			}
			
			//获取页面传进来的查询条件值
			String vcStocknm = paramObject.getString("vcStocknm");//证券简称（查询条件传入）
			String vcTradests = paramObject.getString("vcTradests");//交易状态（查询条件传入）
			String vcSellersts = paramObject.getString("vcSellersts");//卖方状态（查询条件传入）
			String vcBuyersts = paramObject.getString("vcBuyersts");//买方状态（查询条件传入）
			String vcSellernm = paramObject.getString("vcSellernm");//卖方持有人简称（查询条件传入）
			String vcBuyernm = paramObject.getString("vcBuyernm");//买方持有人简称（查询条件传入）
			String vcSttlmdt = DateUtil.format(paramObject.getDate("vcSttlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//结算日期（查询条件传入）
			String vcTxdt =  DateUtil.format(paramObject.getDate("vcTxdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//成交日期（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			//拼接SQL语句
			sb.append(SQL_FXSJLB);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcStocknm)){
				vcStocknm = vcStocknm.trim();
				sb.append("   and a.vc_Stocknm like '%").append(vcStocknm).append("%'");
			}
			if(StringUtils.isNotBlank(vcTradests)){
				vcTradests = vcTradests.trim();
				sb.append("   and a.vc_Tradests like '%").append(vcTradests).append("%'");
			}						
			if(StringUtils.isNotBlank(vcSellersts)){
				vcSellersts = vcSellersts.trim();
				sb.append("   and a.vc_Sellersts like '%").append(vcSellersts).append("%'");
			}
			if(StringUtils.isNotBlank(vcBuyersts)){
				vcBuyersts = vcBuyersts.trim();
				sb.append("   and a.vc_Buyersts like '%").append(vcBuyersts).append("%'");
			}
			if(StringUtils.isNotBlank(vcSellernm)){
				vcSellernm = vcSellernm.trim();
				sb.append("   and a.vc_Sellernm like '%").append(vcSellernm).append("%'");
			}
			if(StringUtils.isNotBlank(vcBuyernm)){
				vcBuyernm = vcBuyernm.trim();
				sb.append("   and a.vc_Buyernm like '%").append(vcBuyernm).append("%'");
			}
			if(StringUtils.isNotBlank(vcSttlmdt)){
				sb.append("   and a.vc_Sttlmdt = ").append("'"+vcSttlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcTxdt)){
				sb.append("   and a.vc_Txdt = ").append("'"+vcTxdt+"'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_TXID = map.get("VC_TXID");// 源交易编号
					String VC_TXCD = map.get("VC_TXCD"); // 成交编号
					String VC_TXDT = map.get("VC_TXDT"); // 成交日期
					String VC_TRADESTS = map.get("VC_TRADESTS"); // 交易状态
					String VC_TRADESTSREM = map.get("VC_TRADESTSREM");// 交易状态备注
					String VC_STTLMDT = map.get("VC_STTLMDT"); // 结算日期
					String VC_STOCKCD = map.get("VC_STOCKCD"); // 证券代码
					String VC_STOCKNM = map.get("VC_STOCKNM"); // 证券简称
					String VC_BUYERACCT = map.get("VC_BUYERACCT"); // 买方持有人账号
					String VC_BUYERNM = map.get("VC_BUYERNM"); // 买方持有人简称
					String VC_SELLERACCT = map.get("VC_SELLERACCT"); // 卖方持有人账号
					String VC_SELLERNM = map.get("VC_SELLERNM"); // 卖方持有人简称
					String VC_TXFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_TXFACEAMT"), StrUtil.df1); // 成交面额(万元)
					String VC_STTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_STTLMVAL"), StrUtil.df1); // 结算金额(元)
					String VC_PERCLPRIC = StrUtil.addThousandth0ToEmpty(map.get("VC_PERCLPRIC"), StrUtil.df1);// 百元净价(元)
					String VC_PEROHPRIC = StrUtil.addThousandth0ToEmpty(map.get("VC_PEROHPRIC"), StrUtil.df1); // 百元全价(元)
					String VC_INTEREST = StrUtil.addThousandth0ToEmpty(map.get("VC_INTEREST"), StrUtil.df1); // 应计利息(元)
					String VC_CLTP = map.get("VC_CLTP"); // 清算方式
					String VC_STTLMTP = map.get("VC_STTLMTP"); // 结算方式
					String VC_BUYERSTS = map.get("VC_BUYERSTS"); // 买方状态
					String VC_BUYERSTSREM = map.get("VC_BUYERSTSREM"); // 买方状态备注
					String VC_SELLERSTS = map.get("VC_SELLERSTS"); // 卖方状态
					String VC_SELLERSTSREM = map.get("VC_SELLERSTSREM"); // 卖方状态备注
					String VC_TRADESRC = map.get("VC_TRADESRC"); // 交易来源
					
					//给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_TXID", VC_TXID);
					obj.setString("VC_TXCD", VC_TXCD);
					obj.setString("VC_TXDT", VC_TXDT);
					obj.setString("VC_TRADESTS", VC_TRADESTS);
					obj.setString("VC_TRADESTSREM", VC_TRADESTSREM);
					obj.setString("VC_STTLMDT",VC_STTLMDT);
					obj.setString("VC_STOCKCD",VC_STOCKCD);
					obj.setString("VC_STOCKNM",VC_STOCKNM);
					obj.setString("VC_BUYERACCT",VC_BUYERACCT);
					obj.setString("VC_BUYERNM",VC_BUYERNM);
					obj.setString("VC_SELLERACCT",VC_SELLERACCT);
					obj.setString("VC_SELLERNM",VC_SELLERNM);
					obj.setString("VC_TXFACEAMT",VC_TXFACEAMT);
					obj.setString("VC_STTLMVAL",VC_STTLMVAL);
					obj.setString("VC_PERCLPRIC",VC_PERCLPRIC);
					obj.setString("VC_PEROHPRIC",VC_PEROHPRIC);
					obj.setString("VC_INTEREST",VC_INTEREST);
					obj.setString("VC_CLTP",VC_CLTP);
					obj.setString("VC_STTLMTP",VC_STTLMTP);
					obj.setString("VC_BUYERSTS",VC_BUYERSTS);
					obj.setString("VC_BUYERSTSREM",VC_BUYERSTSREM);
					obj.setString("VC_SELLERSTS",VC_SELLERSTS);
					obj.setString("VC_SELLERSTSREM",VC_SELLERSTSREM);
					obj.setString("VC_TRADESRC",VC_TRADESRC);
					
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
	 * 买断式回购列表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryMDSHGLB(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_MDSHGLB)){
				SQL_MDSHGLB = BackStageTraderUtil.getFileSql("bst_mdshglb.sql");
			}
			//获取页面传进来的查询条件值
			String vcTxdt = DateUtil.format(paramObject.getDate("vcTxdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//成交日期（查询条件传入）
			String vcTradests = paramObject.getString("vcTradests");//交易状态（查询条件传入）
			String vcStocknm = paramObject.getString("vcStocknm");//证券简称（查询条件传入）
			String vcSellreponm = paramObject.getString("vcSellreponm");//正回购方持有人简称（查询条件传入）
			String vcRevreponm = paramObject.getString("vcRevreponm");//逆回购方持有人简称（查询条件传入）
			String vcFrststtlmdt = DateUtil.format(paramObject.getDate("vcFrststtlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//首期结算日期（查询条件传入）
			String vcScndsttlmdt = DateUtil.format(paramObject.getDate("vcScndsttlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//到期结算日期（查询条件传入）
			String vcSellreposts = paramObject.getString("vcSellreposts");//正回购方状态（查询条件传入）
			String vcRevreposts =  paramObject.getString("vcRevreposts");//逆回购方状态（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			//拼接SQL语句
			sb.append(SQL_MDSHGLB);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcTxdt)){
				sb.append("   and a.vc_txdt like '%").append(vcTxdt).append("%'");
			}
			if(StringUtils.isNotBlank(vcTradests)){
				vcTradests = vcTradests.trim();
				sb.append("   and a.vc_tradests like '%").append(vcTradests).append("%'");
			}						
			if(StringUtils.isNotBlank(vcStocknm)){
				vcStocknm = vcStocknm.trim();
				sb.append("   and a.vc_stocknm like '%").append(vcStocknm).append("%'");
			}
			if(StringUtils.isNotBlank(vcSellreponm)){
				vcSellreponm = vcSellreponm.trim();
				sb.append("   and a.vc_sellreponm like '%").append(vcSellreponm).append("%'");
			}
			if(StringUtils.isNotBlank(vcRevreponm)){
				vcRevreponm = vcRevreponm.trim();
				sb.append("   and a.vc_revreponm like '%").append(vcRevreponm).append("%'");
			}
			if(StringUtils.isNotBlank(vcFrststtlmdt)){
				sb.append("   and a.vc_frststtlmdt = ").append("'"+vcFrststtlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcScndsttlmdt)){
				sb.append("   and a.vc_scndsttlmdt = ").append("'"+vcScndsttlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcSellreposts)){
				vcSellreposts = vcSellreposts.trim();
				sb.append("   and a.vc_sellreposts like '%").append(vcSellreposts).append("%'");
			}
			if(StringUtils.isNotBlank(vcRevreposts)){
				vcRevreposts = vcRevreposts.trim();
				sb.append("   and a.vc_revreposts like '%").append(vcRevreposts).append("%'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_TXID = map.get("VC_TXID");// 源交易编号
					String VC_TXCD = map.get("VC_TXCD");// 成交编号
					String VC_TXDT = map.get("VC_TXDT"); // 成交日期
					String VC_TRADESTS = map.get("VC_TRADESTS"); // 交易状态
					String VC_TRADERSTSEM = map.get("VC_TRADERSTSEM"); // 交易状态备注
					String VC_STOCKCD = map.get("VC_STOCKCD"); // 证券代码
					String VC_STOCKNM = map.get("VC_STOCKNM"); // 证券简称
					String VC_SELLREPOACCT = map.get("VC_SELLREPOACCT"); // 正回购方持有人账号
					String VC_SELLREPONM = map.get("VC_SELLREPONM"); // 正回购方持有人简称
					String VC_REVREPOACCT = map.get("VC_REVREPOACCT"); // 逆回购方持有人账号
					String VC_REVREPONM = map.get("VC_REVREPONM"); // 逆回购方持有人简称
					String VC_REPODAYS = map.get("VC_REPODAYS"); // 回购天数
					String VC_CLTP = map.get("VC_CLTP"); // 清算方式
					String VC_STTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_STTLMVAL"), StrUtil.df1); // 成交面额(万元)
					String VC_FRSTSTTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_FRSTSTTLMVAL"), StrUtil.df1); // 首期结算金额(元)
					String VC_FRSTSTTLMTP = map.get("VC_FRSTSTTLMTP"); // 首期结算方式
					String VC_FRSTSTTLMDT = map.get("VC_FRSTSTTLMDT"); // 首期结算日期
					String VC_SCNDSTTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_SCNDSTTLMVAL"), StrUtil.df1); // 到期结算金额(元)
					String VC_SCNDSTTLMTP = map.get("VC_SCNDSTTLMTP"); // 到期结算方式
					String VC_SCNDSTTLMDT = map.get("VC_SCNDSTTLMDT"); // 到期结算日期
					String VC_SELLREPOSTS = map.get("VC_SELLREPOSTS"); // 正回购方状态
					String VC_SELLREPOSTSREM = map.get("VC_SELLREPOSTSREM"); // 正回购方状态备注
					String VC_REVREPOSTS = map.get("VC_REVREPOSTS"); // 逆回购方状态
					String VC_REVREPOSTSREM = map.get("VC_REVREPOSTSREM"); // 逆回购方状态备注
					String VC_TRADESRC = map.get("VC_TRADESRC"); // 交易来源
					//给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_TXID", VC_TXID);
					obj.setString("VC_TXCD", VC_TXCD);
					obj.setString("VC_TXDT", VC_TXDT);
					obj.setString("VC_TRADESTS", VC_TRADESTS);
					obj.setString("VC_TRADERSTSEM", VC_TRADERSTSEM);
					obj.setString("VC_STOCKCD", VC_STOCKCD);
					obj.setString("VC_STOCKNM", VC_STOCKNM);
					obj.setString("VC_SELLREPOACCT", VC_SELLREPOACCT);
					obj.setString("VC_SELLREPONM", VC_SELLREPONM);
					obj.setString("VC_REVREPOACCT", VC_REVREPOACCT);
					obj.setString("VC_REVREPONM", VC_REVREPONM);
					obj.setString("VC_REPODAYS", VC_REPODAYS);
					obj.setString("VC_CLTP", VC_CLTP);
					obj.setString("VC_STTLMVAL", VC_STTLMVAL);
					obj.setString("VC_FRSTSTTLMVAL", VC_FRSTSTTLMVAL);
					obj.setString("VC_FRSTSTTLMTP", VC_FRSTSTTLMTP);
					obj.setString("VC_FRSTSTTLMDT", VC_FRSTSTTLMDT);
					obj.setString("VC_SCNDSTTLMVAL", VC_SCNDSTTLMVAL);
					obj.setString("VC_SCNDSTTLMTP", VC_SCNDSTTLMTP);
					obj.setString("VC_SCNDSTTLMDT", VC_SCNDSTTLMDT);
					obj.setString("VC_SELLREPOSTS", VC_SELLREPOSTS);
					obj.setString("VC_SELLREPOSTSREM", VC_SELLREPOSTSREM);
					obj.setString("VC_REVREPOSTS", VC_REVREPOSTS);
					obj.setString("VC_REVREPOSTSREM", VC_REVREPOSTSREM);
					obj.setString("VC_TRADESRC", VC_TRADESRC);
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
	 * 现券交易列表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryXQJYLB(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_XQJYLB)){
				SQL_XQJYLB = BackStageTraderUtil.getFileSql("bst_xqjylb.sql");
			}
			//获取页面传进来的查询条件值
			String vcTxdt = DateUtil.format(paramObject.getDate("vcTxdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//交易日期（查询条件传入）
			String vcTradests = paramObject.getString("vcTradests");//交易状态（查询条件传入）
			String vcBuyernm = paramObject.getString("vcBuyernm");//买方持有人简称（查询条件传入）
			String vcSellernm = paramObject.getString("vcSellernm");//卖方持有人简称（查询条件传入）
			String vcBuyersts = paramObject.getString("vcBuyersts");//买方状态（查询条件传入）
			String vcSellersts = paramObject.getString("vcSellersts");//卖方状态（查询条件传入）
			String vcSttlmdt = DateUtil.format(paramObject.getDate("vcSttlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//结算日期（查询条件传入）
			String vcStocknm =  paramObject.getString("vcStocknm");//证券简称（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			//拼接SQL语句
			sb.append(SQL_XQJYLB);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcTxdt)){//交易日期
				sb.append("   and a.vc_Txdt = ").append("'"+vcTxdt+"'");
			}
			if(StringUtils.isNotBlank(vcTradests)){//交易状态
				vcTradests = vcTradests.trim();
				sb.append("   and a.vc_Tradests like '%").append(vcTradests).append("%'");
			}						
			if(StringUtils.isNotBlank(vcBuyernm)){//买方持有人简称
				vcBuyernm = vcBuyernm.trim();
				sb.append("   and a.vc_Buyernm like '%").append(vcBuyernm).append("%'");
			}
			if(StringUtils.isNotBlank(vcBuyersts)){//买方状态
				vcBuyersts = vcBuyersts.trim();
				sb.append("   and a.vc_Buyersts like '%").append(vcBuyersts).append("%'");
			}
			if(StringUtils.isNotBlank(vcSellernm)){//卖方持有人简称
				vcSellernm = vcSellernm.trim();
				sb.append("   and a.vc_Sellernm like '%").append(vcSellernm).append("%'");
			}
			if(StringUtils.isNotBlank(vcSellersts)){//卖方状态
				vcSellersts = vcSellersts.trim();
				sb.append("   and a.vc_Sellersts like '%").append(vcSellersts).append("%'");
			}
			if(StringUtils.isNotBlank(vcSttlmdt)){//结算日期
				sb.append("   and a.vc_Sttlmdt = ").append("'"+vcSttlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcStocknm)){//证券简称
				vcStocknm = vcStocknm.trim();
				sb.append("   and a.vc_Stocknm like '%").append(vcStocknm).append("%'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_TXID = map.get("VC_TXID"); // 源交易编号
					String VC_TXCD = map.get("VC_TXCD"); // 成交编号
					String VC_TXDT = map.get("VC_TXDT"); // 交易日期
					String VC_TRADESTS = map.get("VC_TRADESTS"); // 交易状态
					String VC_TRADESTSREM = map.get("VC_TRADESTSREM"); // 交易状态备注
					String VC_STTLMDT = map.get("VC_STTLMDT"); // 结算日期
					String VC_STOCKCD = map.get("VC_STOCKCD"); // 证券代码
					String VC_STOCKNM = map.get("VC_STOCKNM"); // 证券简称
					String VC_BUYERACCT = map.get("VC_BUYERACCT"); // 买方持有人账号
					String VC_BUYERNM = map.get("VC_BUYERNM"); // 买方持有人简称
					String VC_SELLERACCT = map.get("VC_SELLERACCT"); // 卖方持有人账号
					String VC_SELLERNM = map.get("VC_SELLERNM"); // 卖方持有人简称
					String VC_TXFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_TXFACEAMT"), StrUtil.df1); // 成交面额(万元)
					String VC_STTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_STTLMVAL"), StrUtil.df1); // 结算金额(元)
					String VC_PERCLPRIC = StrUtil.addThousandth0ToEmpty(map.get("VC_PERCLPRIC"), StrUtil.df1); // 百元净价(元)
					String VC_PEROHPRIC = StrUtil.addThousandth0ToEmpty(map.get("VC_PEROHPRIC"), StrUtil.df1); // 百元全价(元)
					String VC_INTEREST = StrUtil.addThousandth0ToEmpty(map.get("VC_INTEREST"), StrUtil.df1); // 应计利息(元)
					String VC_CLTP = map.get("VC_CLTP"); // 清算方式
					String VC_STTLMTP = map.get("VC_STTLMTP"); // 结算方式
					String VC_BUYERSTS = map.get("VC_BUYERSTS"); // 买方状态
					String VC_BUYERSTSREM = map.get("VC_BUYERSTSREM"); // 买方状态备注
					String VC_SELLERSTS = map.get("VC_SELLERSTS"); // 卖方状态
					String VC_SELLERSTSREM = map.get("VC_SELLERSTSREM"); // 卖方状态备注
					String VC_TRADESRC = map.get("VC_TRADESRC"); // 交易来源
					// 给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_TXID", VC_TXID);
					obj.setString("VC_TXCD", VC_TXCD);
					obj.setString("VC_TXDT", VC_TXDT);
					obj.setString("VC_TRADESTS", VC_TRADESTS);
					obj.setString("VC_TRADESTSREM", VC_TRADESTSREM);
					obj.setString("VC_STTLMDT", VC_STTLMDT);
					obj.setString("VC_STOCKCD", VC_STOCKCD);
					obj.setString("VC_STOCKNM", VC_STOCKNM);
					obj.setString("VC_BUYERACCT", VC_BUYERACCT);
					obj.setString("VC_BUYERNM", VC_BUYERNM);
					obj.setString("VC_SELLERACCT", VC_SELLERACCT);
					obj.setString("VC_SELLERNM", VC_SELLERNM);
					obj.setString("VC_TXFACEAMT", VC_TXFACEAMT);
					obj.setString("VC_STTLMVAL", VC_STTLMVAL);
					obj.setString("VC_PERCLPRIC", VC_PERCLPRIC);
					obj.setString("VC_PEROHPRIC", VC_PEROHPRIC);
					obj.setString("VC_INTEREST", VC_INTEREST);
					obj.setString("VC_CLTP", VC_CLTP);
					obj.setString("VC_STTLMTP", VC_STTLMTP);
					obj.setString("VC_BUYERSTS", VC_BUYERSTS);
					obj.setString("VC_BUYERSTSREM", VC_BUYERSTSREM);
					obj.setString("VC_SELLERSTS", VC_SELLERSTS);
					obj.setString("VC_SELLERSTSREM", VC_SELLERSTSREM);
					obj.setString("VC_TRADESRC", VC_TRADESRC);
					
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
	 * 质押式回购列表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryZYSHGLB(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_ZYSHGLB)){
				SQL_ZYSHGLB = BackStageTraderUtil.getFileSql("bst_zyshglb.sql");
			}
			//获取页面传进来的查询条件值
			String vcTxdt = DateUtil.format(paramObject.getDate("vcTxdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//成交日期（查询条件传入）
			String vcTradests = paramObject.getString("vcTradests");//交易状态（查询条件传入）
			String vcSellreponm = paramObject.getString("vcSellreponm");//正回购方持有人简称（查询条件传入）
			String vcRevreponm = paramObject.getString("vcRevreponm");//逆回购方持有人简称（查询条件传入）
			String vcFrststtlmdt = DateUtil.format(paramObject.getDate("vcFrststtlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//首期结算日期（查询条件传入）
			String vcScndsttlmdt = DateUtil.format(paramObject.getDate("vcScndsttlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//到期结算日期（查询条件传入）
			String vcSellreposts = paramObject.getString("vcSellreposts");//正回购方状态（查询条件传入）
			String vcRevreposts =  paramObject.getString("vcRevreposts");//逆回购方状态（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			//拼接SQL语句
			sb.append(SQL_ZYSHGLB);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcTxdt)){//成交日期
				sb.append("   and a.vc_txdt like '%").append(vcTxdt).append("%'");
			}
			if(StringUtils.isNotBlank(vcTradests)){//交易状态
				vcTradests = vcTradests.trim();
				sb.append("   and a.vc_tradests like '%").append(vcTradests).append("%'");
			}						
			if(StringUtils.isNotBlank(vcSellreponm)){//正回购方持有人简称
				vcSellreponm = vcSellreponm.trim();
				sb.append("   and a.vc_sellreponm like '%").append(vcSellreponm).append("%'");
			}
			if(StringUtils.isNotBlank(vcRevreponm)){//逆回购方持有人简称
				vcRevreponm = vcRevreponm.trim();
				sb.append("   and a.vc_revreponm like '%").append(vcRevreponm).append("%'");
			}
			if(StringUtils.isNotBlank(vcFrststtlmdt)){//首期结算日期
				sb.append("   and a.vc_frststtlmdt = ").append("'"+vcFrststtlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcScndsttlmdt)){//到期结算日期
				sb.append("   and a.vc_scndsttlmdt = ").append("'"+vcScndsttlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcSellreposts)){//正回购方状态
				vcSellreposts = vcSellreposts.trim();
				sb.append("   and a.vc_sellreposts like '%").append(vcSellreposts).append("%'");
			}
			if(StringUtils.isNotBlank(vcRevreposts)){//逆回购方状态
				vcRevreposts = vcRevreposts.trim();
				sb.append("   and a.vc_revreposts like '%").append(vcRevreposts).append("%'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_TXID = map.get("VC_TXID"); // 源交易编号
					String VC_TXCD = map.get("VC_TXCD"); // 成交编号
					String VC_TXDT = map.get("VC_TXDT"); // 成交日期
					String VC_TRADESTS = map.get("VC_TRADESTS"); // 交易状态
					String VC_TRADEREM = map.get("VC_TRADEREM"); // 交易状态备注
					String VC_SELLREPOACCT = map.get("VC_SELLREPOACCT"); // 正回购方持有人账号
					String VC_SELLREPONM = map.get("VC_SELLREPONM"); // 正回购方持有人简称
					String VC_REVREPOACCT = map.get("VC_REVREPOACCT"); // 逆回购方持有人账号
					String VC_REVREPONM = map.get("VC_REVREPONM"); // 逆回购方持有人简称
					String VC_REPODAYS = map.get("VC_REPODAYS"); // 回购天数
					String VC_CLTP = map.get("VC_CLTP"); // 清算方式
					String VC_FRSTSTTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_FRSTSTTLMVAL"), StrUtil.df1); // 首期结算金额(元)
					String VC_FRSTSTTLMTP = map.get("VC_FRSTSTTLMTP"); // 首期结算方式
					String VC_FRSTSTTLMDT = map.get("VC_FRSTSTTLMDT"); // 首期结算日期
					String VC_SCNDSTTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_SCNDSTTLMVAL"), StrUtil.df1); // 到期结算金额(元)
					String VC_SCNDSTTLMTP = map.get("VC_SCNDSTTLMTP"); // 到期结算方式
					String VC_SCNDSTTLMDT = map.get("VC_SCNDSTTLMDT"); // 到期结算日期
					String VC_SELLREPOSTS = map.get("VC_SELLREPOSTS"); // 正回购方状态
					String VC_SELLREPOSTSREM = map.get("VC_SELLREPOSTSREM"); // 正回购方状态备注
					String VC_REVREPOSTS = map.get("VC_REVREPOSTS"); // 逆回购方状态
					String VC_REVREPOSTSREM = map.get("VC_REVREPOSTSREM"); // 逆回购方状态备注
					String VC_TRADESRC = map.get("VC_TRADESRC"); // 交易来源
					
					// 给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_TXID", VC_TXID);
					obj.setString("VC_TXCD", VC_TXCD);
					obj.setString("VC_TXDT", VC_TXDT);
					obj.setString("VC_TRADESTS", VC_TRADESTS);
					obj.setString("VC_TRADEREM", VC_TRADEREM);
					obj.setString("VC_SELLREPOACCT", VC_SELLREPOACCT);
					obj.setString("VC_SELLREPONM", VC_SELLREPONM);
					obj.setString("VC_REVREPOACCT", VC_REVREPOACCT);
					obj.setString("VC_REVREPONM", VC_REVREPONM);
					obj.setString("VC_REPODAYS", VC_REPODAYS);
					obj.setString("VC_CLTP", VC_CLTP);
					obj.setString("VC_FRSTSTTLMVAL", VC_FRSTSTTLMVAL);
					obj.setString("VC_FRSTSTTLMTP", VC_FRSTSTTLMTP);
					obj.setString("VC_FRSTSTTLMDT", VC_FRSTSTTLMDT);
					obj.setString("VC_SCNDSTTLMVAL", VC_SCNDSTTLMVAL);
					obj.setString("VC_SCNDSTTLMTP", VC_SCNDSTTLMTP);
					obj.setString("VC_SCNDSTTLMDT", VC_SCNDSTTLMDT);
					obj.setString("VC_SELLREPOSTS", VC_SELLREPOSTS);
					obj.setString("VC_SELLREPOSTSREM", VC_SELLREPOSTSREM);
					obj.setString("VC_REVREPOSTS", VC_REVREPOSTS);
					obj.setString("VC_REVREPOSTSREM", VC_REVREPOSTSREM);
					obj.setString("VC_TRADESRC", VC_TRADESRC);
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
	 * 全额结算指令列表查询
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author fengjunpei
	 */
	@Bizlet("")
	public static List<DataObject> queryQEJSZL(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据中心数据库连接
			conn = JDBCUtil.getConnByDataSourceId(JDBCUtil.DATA_SOURCE_DEFAULT);
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_QEJSZL)){
				SQL_QEJSZL = BackStageTraderUtil.getFileSql("bst_qejszl.sql");
			}
			//获取页面传进来的查询条件值
			String vcBiztp = paramObject.getString("vcBiztp");//业务品种（查询条件传入）
			String vcSttlmordersts = paramObject.getString("vcSttlmordersts");//结算指令状态（查询条件传入）
			String vcProdsttlmsts = paramObject.getString("vcProdsttlmsts");//产品结算状态（查询条件传入）
			String vcFundsttlmsts = paramObject.getString("vcFundsttlmsts");//资金结算状态（查询条件传入）
			String vcBuyershortnm = paramObject.getString("vcBuyershortnm");//买/融入/逆回购方简称（查询条件传入）
			String vcSellershortnm = paramObject.getString("vcSellershortnm");//卖/融出/正回购方简称（查询条件传入）
			String vcStocknm = paramObject.getString("vcStocknm");//证券简称（查询条件传入）
			String lUpdatedt = paramObject.getString("lUpdatedt");//业务日期（查询条件传入)
			String vcSttlmdt =  DateUtil.format(paramObject.getDate("vcSttlmdt"), DateUtil.YEAR_MONTH_DAY_SLASH);//结算日（查询条件传入）
			String vcOdrgnrtdate = DateUtil.format(paramObject.getDate("vcOdrgnrtdate"), DateUtil.YEAR_MONTH_DAY_SLASH);//指令生成日（查询条件传入）
			//拼接SQL语句
			sb.append(SQL_QEJSZL);
			if(StringUtils.isNotBlank(lUpdatedt)){//业务日期
				lUpdatedt = lUpdatedt.substring(0, 10).replaceAll("-", "");
				sb.append("   and a.l_updatedt =").append("'"+lUpdatedt+"'");
			}
			if(StringUtils.isNotBlank(vcBiztp)){//业务品种
				vcBiztp = vcBiztp.trim();
				sb.append("   and a.vc_biztp like '%").append(vcBiztp).append("%'");
			}
			if(StringUtils.isNotBlank(vcSttlmordersts)){//结算指令状态
				vcSttlmordersts = vcSttlmordersts.trim();
				sb.append("   and a.vc_sttlmordersts like '%").append(vcSttlmordersts).append("%'");
			}						
			if(StringUtils.isNotBlank(vcProdsttlmsts)){//产品结算状态
				vcProdsttlmsts = vcProdsttlmsts.trim();
				sb.append("   and a.vc_prodsttlmsts like '%").append(vcProdsttlmsts).append("%'");
			}
			if(StringUtils.isNotBlank(vcFundsttlmsts)){//资金结算状态
				vcFundsttlmsts = vcFundsttlmsts.trim();
				sb.append("   and a.vc_fundsttlmsts like '%").append(vcFundsttlmsts).append("%'");
			}
			if(StringUtils.isNotBlank(vcBuyershortnm)){//买/融入/逆回购方简称
				vcBuyershortnm = vcBuyershortnm.trim();
				sb.append("   and a.vc_buyershortnm like '%").append(vcBuyershortnm).append("%'");
			}
			if(StringUtils.isNotBlank(vcSellershortnm)){//卖/融出/正回购方简称
				vcSellershortnm = vcSellershortnm.trim();
				sb.append("   and a.vc_sellershortnm like '%").append(vcSellershortnm).append("%'");
			}
			if(StringUtils.isNotBlank(vcStocknm)){//证券简称
				vcStocknm = vcStocknm.trim();
				sb.append("   and a.vc_stocknm like '%").append(vcStocknm).append("%'");
			}
			if(StringUtils.isNotBlank(vcSttlmdt)){//结算日
				sb.append("   and a.vc_sttlmdt =").append("'"+vcSttlmdt+"'");
			}
			if(StringUtils.isNotBlank(vcOdrgnrtdate)){//指令生成日
				sb.append("   and a.vc_odrgnrtdate = ").append("'"+vcOdrgnrtdate+"'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_UPDATEDT = map.get("L_UPDATEDT");//业务日期
					String VC_TXID = map.get("VC_TXID");// 源交易编号
					String VC_STTLMORDERCD = map.get("VC_STTLMORDERCD");// 结算指令编号
					String VC_TXDT = map.get("VC_TXDT");// 成交编号
					String VC_FRSTORSCND = map.get("VC_FRSTORSCND");// 首期/到期
					String VC_BIZTP = map.get("VC_BIZTP");// 业务品种
					String VC_STTLMTP = map.get("VC_STTLMTP");// 结算方式
					String VC_STTLMORDERSTS = map.get("VC_STTLMORDERSTS");// 结算指令状态
					String VC_PRODSTTLMSTS = map.get("VC_PRODSTTLMSTS");// 产品结算状态
					String VC_FUNDSTTLMSTS = map.get("VC_FUNDSTTLMSTS");// 资金结算状态
					String VC_BUYERACCT = map.get("VC_BUYERACCT");// 买/融入/逆回购方账号
					String VC_BUYERSHORTNM = map.get("VC_BUYERSHORTNM");// 买/融入/逆回购方简称
					String VC_BUYERAGNTACCT = map.get("VC_BUYERAGNTACCT");// 买/融入/逆回购方代理账号
					String VC_BUYERAGNTSHORTNM = map.get("VC_BUYERAGNTSHORTNM");// 买/融入/逆回购方代理简称
					String VC_SELLERACCT = map.get("VC_SELLERACCT");// 卖/融出/正回购方账号
					String VC_SELLERSHORTNM = map.get("VC_SELLERSHORTNM");// 卖/融出/正回购方简称
					String VC_SELLERAGNTACCT = map.get("VC_SELLERAGNTACCT");// 卖/融出/正回购方代理账号
					String VC_SELLERAGNTSHORTNM = map.get("VC_SELLERAGNTSHORTNM");// 卖/融出/正回购方代理简称
					String VC_STOCKCD = map.get("VC_STOCKCD");// 证券代码
					String VC_STOCKNM = map.get("VC_STOCKNM");// 证券简称
					String VC_STOCKFACEAMT = StrUtil.addThousandth0ToEmpty(map.get("VC_STOCKFACEAMT"), StrUtil.df1);// 证券面额(万元)
					String VC_FUNDSTTLMVAL = StrUtil.addThousandth0ToEmpty(map.get("VC_FUNDSTTLMVAL"), StrUtil.df1);// 资金结算金额(元)
					String VC_STTLMDT = map.get("VC_STTLMDT");// 结算日
					String VC_ODRGNRTDATE = map.get("VC_ODRGNRTDATE");// 指令生成日
					String VC_ODRFRSTGNRTTM = map.get("VC_ODRFRSTGNRTTM");// 指令首次创建时间
					String VC_ODRUPDATETM = map.get("VC_ODRUPDATETM");// 指令更新时间
					String VC_PRODSTTLMGRACE = map.get("VC_PRODSTTLMGRACE");// 产品结算宽限期
					String VC_FUNDSTTLMGRACE = map.get("VC_FUNDSTTLMGRACE");// 资金结算宽限期
					String VC_RCVPMTCFMER = map.get("VC_RCVPMTCFMER");// 收付款确认人
					String VC_RCVPMTCFMCHECKER = map.get("VC_RCVPMTCFMCHECKER");// 收付款确认复核人
					String VC_ODRREVOCATIONSIDE = map.get("VC_ODRREVOCATIONSIDE");// 指令撤销方
					String VC_REVOCATIONTM = map.get("VC_REVOCATIONTM");// 撤销时间
					String VC_REVOCATIONCFMER = map.get("VC_REVOCATIONCFMER");// 撤销确认方
					String VC_REVOCATIONCFMTM = map.get("VC_REVOCATIONCFMTM");// 撤销确认时间
					String VC_REVOCATIONRSLT = map.get("VC_REVOCATIONRSLT");// 撤销处理结果

					// 给对象赋值
					obj.setString("L_UPDATEDT", L_UPDATEDT);
					obj.setString("VC_TXID", VC_TXID);
					obj.setString("VC_STTLMORDERCD", VC_STTLMORDERCD);
					obj.setString("VC_TXDT", VC_TXDT);
					obj.setString("VC_FRSTORSCND", VC_FRSTORSCND);
					obj.setString("VC_BIZTP", VC_BIZTP);
					obj.setString("VC_STTLMTP", VC_STTLMTP);
					obj.setString("VC_STTLMORDERSTS", VC_STTLMORDERSTS);
					obj.setString("VC_PRODSTTLMSTS", VC_PRODSTTLMSTS);
					obj.setString("VC_FUNDSTTLMSTS", VC_FUNDSTTLMSTS);
					obj.setString("VC_BUYERACCT", VC_BUYERACCT);
					obj.setString("VC_BUYERSHORTNM", VC_BUYERSHORTNM);
					obj.setString("VC_BUYERAGNTACCT", VC_BUYERAGNTACCT);
					obj.setString("VC_BUYERAGNTSHORTNM", VC_BUYERAGNTSHORTNM);
					obj.setString("VC_SELLERACCT", VC_SELLERACCT);
					obj.setString("VC_SELLERSHORTNM", VC_SELLERSHORTNM);
					obj.setString("VC_SELLERAGNTACCT", VC_SELLERAGNTACCT);
					obj.setString("VC_SELLERAGNTSHORTNM", VC_SELLERAGNTSHORTNM);
					obj.setString("VC_STOCKCD", VC_STOCKCD);
					obj.setString("VC_STOCKNM", VC_STOCKNM);
					obj.setString("VC_STOCKFACEAMT", VC_STOCKFACEAMT);
					obj.setString("VC_FUNDSTTLMVAL", VC_FUNDSTTLMVAL);
					obj.setString("VC_STTLMDT", VC_STTLMDT);
					obj.setString("VC_ODRGNRTDATE", VC_ODRGNRTDATE);
					obj.setString("VC_ODRFRSTGNRTTM", VC_ODRFRSTGNRTTM);
					obj.setString("VC_ODRUPDATETM", VC_ODRUPDATETM);
					obj.setString("VC_PRODSTTLMGRACE", VC_PRODSTTLMGRACE);
					obj.setString("VC_FUNDSTTLMGRACE", VC_FUNDSTTLMGRACE);
					obj.setString("VC_RCVPMTCFMER", VC_RCVPMTCFMER);
					obj.setString("VC_RCVPMTCFMCHECKER", VC_RCVPMTCFMCHECKER);
					obj.setString("VC_ODRREVOCATIONSIDE", VC_ODRREVOCATIONSIDE);
					obj.setString("VC_REVOCATIONTM", VC_REVOCATIONTM);
					obj.setString("VC_REVOCATIONCFMER", VC_REVOCATIONCFMER);
					obj.setString("VC_REVOCATIONCFMTM", VC_REVOCATIONCFMTM);
					obj.setString("VC_REVOCATIONRSLT", VC_REVOCATIONRSLT);
					
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
	 * 上清所指令数据(新)
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author chendi
	 */
	@Bizlet("")
	public static List<DataObject> querySQSZL(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据中心数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_SQSZL)){
				SQL_SQSZL = BackStageTraderUtil.getFileSql("bst_sqzlxzlb.sql");
			}
			//获取页面传进来的查询条件值
			String vcProductName = paramObject.getString("vcProductName");//证券简称（查询条件传入）
			String cBuyerstatus = paramObject.getString("cBuyerstatus");//买方状态（查询条件传入）
			String cSellerstatus = paramObject.getString("cSellerstatus");//卖方状态（查询条件传入）
			String vcBholdershortname = paramObject.getString("vcBholdershortname");//买/融入/逆回购方简称（查询条件传入）
			String vcSholdershortname = paramObject.getString("vcSholdershortname");//卖/融出/正回购方简称（查询条件传入）
			String vcTradeid = paramObject.getString("vcTradeid");//成交编号（查询条件传入）
			String lTradedate =  DateUtil.format(paramObject.getDate("lTradedate"), DateUtil.YMD_NUMBER);//交易日期（查询条件传入）
			String lSettlementdate =  DateUtil.format(paramObject.getDate("lSettlementdate"), DateUtil.YMD_NUMBER);//结算日（查询条件传入）
			String lDate =  DateUtil.format(paramObject.getDate("lDate"), DateUtil.YMD_NUMBER);//业务日期（查询条件传入）
			
			//拼接SQL语句
			sb.append(SQL_SQSZL);
			if(StringUtils.isNotBlank(vcProductName)){//产品简称
				vcProductName = vcProductName.trim();
				sb.append("   and t1.vc_productname like '%").append(vcProductName).append("%'");
			}
			if(StringUtils.isNotBlank(cBuyerstatus)){//买方状态
				cBuyerstatus = cBuyerstatus.trim();
				sb.append("   and t1.c_buyerstatus like '%").append(cBuyerstatus).append("%'");
			}						
			if(StringUtils.isNotBlank(cSellerstatus)){//卖方状态
				cSellerstatus = cSellerstatus.trim();
				sb.append("   and t1.c_sellerstatus like '%").append(cSellerstatus).append("%'");
			}
			if(StringUtils.isNotBlank(vcBholdershortname)){//买/融入/逆回购方简称
				vcBholdershortname = vcBholdershortname.trim();
				sb.append("   and t1.vc_bholdershortname like '%").append(vcBholdershortname).append("%'");
			}
			if(StringUtils.isNotBlank(vcSholdershortname)){//卖/融出/正回购方简称
				vcSholdershortname = vcSholdershortname.trim();
				sb.append("   and t1.vc_sholdershortname like '%").append(vcSholdershortname).append("%'");
			}
			if(StringUtils.isNotBlank(vcTradeid)){//成交编号
				vcTradeid = vcTradeid.trim();
				sb.append("   and t1.vc_tradeid like '%").append(vcTradeid).append("%'");
			}
			if(StringUtils.isNotBlank(lTradedate)){//交易日期
				sb.append("   and t1.l_tradedate =").append("'"+lTradedate+"'");
			}
			if(StringUtils.isNotBlank(lSettlementdate)){//结算日期
				sb.append("   and t1.l_settlementdate = ").append("'"+lSettlementdate+"'");
			}
			if(StringUtils.isNotBlank(lDate)){//结算日期
				sb.append("   and t1.l_date = ").append("'"+lDate+"'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_DATE = map.get("L_DATE");//业务日期
					String L_TRADEORDERNO = map.get("L_TRADEORDERNO");// 源交易编号
					String VC_SRCTRADEID = map.get("VC_SRCTRADEID");// 结算指令编号
					String C_SOURCEFROM = map.get("C_SOURCEFROM");// 成交编号
					String VC_TABLESOURCE = map.get("VC_TABLESOURCE");// 首期/到期
					String C_AUDITSTATUS = map.get("C_AUDITSTATUS");// C_AUDITSTATUS
					String C_ORDERSTATUS = map.get("C_ORDERSTATUS");// C_ORDERSTATUS
					String VC_TRADEID = map.get("VC_TRADEID");// VC_TRADEID
					String L_OPORDERTYPE = map.get("L_OPORDERTYPE");// L_OPORDERTYPE
					String C_TRADETYPE = map.get("C_TRADETYPE");// C_TRADETYPE
					String C_CLEARTYPE = map.get("C_CLEARTYPE");// C_CLEARTYPE
					String VC_PRODUCTCODE = map.get("VC_PRODUCTCODE");// VC_PRODUCTCODE
					String VC_PRODUCTNAME = map.get("VC_PRODUCTNAME");// VC_PRODUCTNAME
					String EN_FACEVALUE = StrUtil.addThousandth0ToEmpty(map.get("EN_FACEVALUE"), StrUtil.df1);// EN_FACEVALUE
					String VC_BUYERHOLDERACCOUNT = map.get("VC_BUYERHOLDERACCOUNT");// VC_BUYERHOLDERACCOUNT
					String VC_BHOLDERSHORTNAME = map.get("VC_BHOLDERSHORTNAME");// VC_BHOLDERSHORTNAME
					String VC_BOPERHOLDERACCOUNT = map.get("VC_BOPERHOLDERACCOUNT");// VC_BOPERHOLDERACCOUNT
					String VC_SELLERHOLDERACCOUNT = map.get("VC_SELLERHOLDERACCOUNT");// VC_SELLERHOLDERACCOUNT
					String VC_SHOLDERSHORTNAME = map.get("VC_SHOLDERSHORTNAME");// VC_SHOLDERSHORTNAME
					String VC_SOPERHOLDERACCOUNT = map.get("VC_SOPERHOLDERACCOUNT");// VC_SOPERHOLDERACCOUNT
					String EN_SETTLEMENTAMOUNT = StrUtil.addThousandth0ToEmpty(map.get("EN_SETTLEMENTAMOUNT"), StrUtil.df1);// EN_SETTLEMENTAMOUNT
					String L_TRADEDATE = map.get("L_TRADEDATE");// L_TRADEDATE
					String L_SETTLEMENTDATE = map.get("L_SETTLEMENTDATE");// L_SETTLEMENTDATE
					String C_BUYERSTATUS = map.get("C_BUYERSTATUS");// C_BUYERSTATUS
					
					String C_SELLERSTATUS = map.get("C_SELLERSTATUS");// C_SELLERSTATUS
					String VC_BOPERORDERSTATUS = map.get("VC_BOPERORDERSTATUS");// VC_BOPERORDERSTATUS
					String VC_SOPERORDERSTATUS = map.get("VC_SOPERORDERSTATUS");// VC_SOPERORDERSTATUS
					String VC_OPERNAME = map.get("VC_OPERNAME");// VC_OPERNAME
					String VC_AUDITOPERNAME = map.get("VC_AUDITOPERNAME");// VC_AUDITOPERNAME
					String L_SETTLEMENTTYPE = map.get("L_SETTLEMENTTYPE");// L_SETTLEMENTTYPE
					String L_DUESETTLEDATE = map.get("L_DUESETTLEDATE");// L_DUESETTLEDATE
					String EN_DUESETTLEAMOUNT = StrUtil.addThousandth0ToEmpty(map.get("EN_DUESETTLEAMOUNT"), StrUtil.df1);// EN_DUESETTLEAMOUNT
					
					String L_DUESETTLEMETHOD = map.get("L_DUESETTLEMETHOD");// L_DUESETTLEMETHOD
					String C_SEND_STATUS = map.get("C_SEND_STATUS");// C_SEND_STATUS
					String C_MATCH_FLAG = map.get("C_MATCH_FLAG");// C_MATCH_FLAG
					String VC_MATCH_ERRMSG = map.get("VC_MATCH_ERRMSG");// VC_MATCH_ERRMSG
					String VC_CONF_OPERATOR_NAME = map.get("VC_CONF_OPERATOR_NAME");// VC_CONF_OPERATOR_NAME
					String EN_CLEANPRICE = StrUtil.addThousandth0ToEmpty(map.get("EN_CLEANPRICE"), StrUtil.df1);// EN_CLEANPRICE
					String EN_FULLPRICE = StrUtil.addThousandth0ToEmpty(map.get("EN_FULLPRICE"), StrUtil.df1);// EN_FULLPRICE
					String EN_ACCRUEDINTEREST = StrUtil.addThousandth0ToEmpty(map.get("EN_ACCRUEDINTEREST"), StrUtil.df1);// EN_ACCRUEDINTEREST
					String EN_REPODAYS = StrUtil.addThousandth0ToEmpty(map.get("EN_REPODAYS"), StrUtil.df1);// EN_REPODAYS
					String C_DISTRIBUTIONFLAG = map.get("C_DISTRIBUTIONFLAG");// C_DISTRIBUTIONFLAG
					String VC_REASON = map.get("VC_REASON");// VC_REASON
					
					// 给对象赋值
					obj.setString("L_DATE", L_DATE);
					obj.setString("L_TRADEORDERNO", L_TRADEORDERNO);
					obj.setString("VC_SRCTRADEID", VC_SRCTRADEID);
					obj.setString("C_SOURCEFROM", C_SOURCEFROM);
					obj.setString("VC_TABLESOURCE", VC_TABLESOURCE);
					obj.setString("C_AUDITSTATUS", C_AUDITSTATUS);
					obj.setString("C_ORDERSTATUS", C_ORDERSTATUS);
					obj.setString("VC_TRADEID", VC_TRADEID);
					obj.setString("L_OPORDERTYPE", L_OPORDERTYPE);
					obj.setString("C_TRADETYPE", C_TRADETYPE);
					obj.setString("C_CLEARTYPE", C_CLEARTYPE);
					obj.setString("VC_PRODUCTCODE", VC_PRODUCTCODE);
					obj.setString("VC_PRODUCTNAME", VC_PRODUCTNAME);
					obj.setString("EN_FACEVALUE", EN_FACEVALUE);
					obj.setString("VC_BUYERHOLDERACCOUNT", VC_BUYERHOLDERACCOUNT);
					obj.setString("VC_BHOLDERSHORTNAME", VC_BHOLDERSHORTNAME);
					obj.setString("VC_BOPERHOLDERACCOUNT", VC_BOPERHOLDERACCOUNT);
					obj.setString("VC_SELLERHOLDERACCOUNT", VC_SELLERHOLDERACCOUNT);
					obj.setString("VC_SHOLDERSHORTNAME", VC_SHOLDERSHORTNAME);
					obj.setString("VC_SOPERHOLDERACCOUNT", VC_SOPERHOLDERACCOUNT);
					obj.setString("EN_SETTLEMENTAMOUNT", EN_SETTLEMENTAMOUNT);
					obj.setString("L_TRADEDATE", L_TRADEDATE);
					obj.setString("L_SETTLEMENTDATE", L_SETTLEMENTDATE);
					obj.setString("C_BUYERSTATUS", C_BUYERSTATUS);
					
					obj.setString("C_SELLERSTATUS", C_SELLERSTATUS);
					obj.setString("VC_BOPERORDERSTATUS", VC_BOPERORDERSTATUS);
					obj.setString("VC_SOPERORDERSTATUS", VC_SOPERORDERSTATUS);
					obj.setString("VC_OPERNAME", VC_OPERNAME);
					obj.setString("VC_AUDITOPERNAME", VC_AUDITOPERNAME);
					obj.setString("L_SETTLEMENTTYPE", L_SETTLEMENTTYPE);
					obj.setString("L_DUESETTLEDATE", L_DUESETTLEDATE);
					obj.setString("EN_DUESETTLEAMOUNT", EN_DUESETTLEAMOUNT);
					obj.setString("L_DUESETTLEMETHOD", L_DUESETTLEMETHOD);
					
					obj.setString("C_SEND_STATUS", C_SEND_STATUS);
					obj.setString("C_MATCH_FLAG", C_MATCH_FLAG);
					obj.setString("VC_MATCH_ERRMSG", VC_MATCH_ERRMSG);
					obj.setString("VC_CONF_OPERATOR_NAME", VC_CONF_OPERATOR_NAME);
					obj.setString("EN_CLEANPRICE", EN_CLEANPRICE);
					obj.setString("EN_FULLPRICE", EN_FULLPRICE);
					obj.setString("EN_ACCRUEDINTEREST", EN_ACCRUEDINTEREST);
					obj.setString("EN_REPODAYS", EN_REPODAYS);
					obj.setString("C_DISTRIBUTIONFLAG", C_DISTRIBUTIONFLAG);
					obj.setString("VC_REASON", VC_REASON);
					
					
					
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
	 * 上清所结算数据(新)
	 * @param paramObject 查询条件对象
	 * @param page 分页对象
	 * @return
	 * @author chendi
	 */
	@Bizlet("")
	public static List<DataObject> querySQSJS(DataObject paramObject, DataObject page){
		DataObject obj = null;
		Connection conn = null;
		StringBuffer sb = new StringBuffer();
		List<DataObject> result = new ArrayList<DataObject>();
		try {
			//获取数据中心数据库连接
			conn = JDBCUtil.getConnByDataSourceId(CacheUtil.getO32CacheDataSourceName());
			//获取内存中的查询SQL语句
			if(StringUtils.isEmpty(SQL_SQSJS)){
				SQL_SQSJS = BackStageTraderUtil.getFileSql("bst_sqjsxzlb.sql");
			}
			//获取页面传进来的查询条件值
			String vcProductName = paramObject.getString("vcProductName");//业务品种（查询条件传入）
			String cFundsettstatus = paramObject.getString("cFundsettstatus");//结算指令状态（查询条件传入）
			String cProductstatus = paramObject.getString("cProductstatus");//产品结算状态（查询条件传入）
			String vcBholdershortname = paramObject.getString("vcBholdershortname");//资金结算状态（查询条件传入）
			String vcSholdershortname = paramObject.getString("vcSholdershortname");//买/融入/逆回购方简称（查询条件传入）
			String vcTradeid = paramObject.getString("vcTradeid");//卖/融出/正回购方简称（查询条件传入）
			String lCreatedate =  DateUtil.format(paramObject.getDate("lCreatedate"), DateUtil.YMD_NUMBER);//业务日期（查询条件传入）
			String lSettlementdate =  DateUtil.format(paramObject.getDate("lSettlementdate"), DateUtil.YMD_NUMBER);//业务日期（查询条件传入）
			String lDate =  DateUtil.format(paramObject.getDate("lDate"), DateUtil.YMD_NUMBER);//业务日期（查询条件传入）
			//拼接SQL语句
			sb.append(SQL_SQSJS);
			if(StringUtils.isNotBlank(vcProductName)){//产品简称
				vcProductName = vcProductName.trim();
				sb.append("   and t1.vc_productname like '%").append(vcProductName).append("%'");
			}
			if(StringUtils.isNotBlank(cFundsettstatus)){//买方状态
				cFundsettstatus = cFundsettstatus.trim();
				sb.append("   and t1.c_fundsettstatus like '%").append(cFundsettstatus).append("%'");
			}						
			if(StringUtils.isNotBlank(cProductstatus)){//卖方状态
				cProductstatus = cProductstatus.trim();
				sb.append("   and t1.c_productstatus like '%").append(cProductstatus).append("%'");
			}
			if(StringUtils.isNotBlank(vcBholdershortname)){//买/融入/逆回购方简称
				vcBholdershortname = vcBholdershortname.trim();
				sb.append("   and t1.vc_bholdershortname like '%").append(vcBholdershortname).append("%'");
			}
			if(StringUtils.isNotBlank(vcSholdershortname)){//卖/融出/正回购方简称
				vcSholdershortname = vcSholdershortname.trim();
				sb.append("   and t1.vc_sholdershortname like '%").append(vcSholdershortname).append("%'");
			}
			if(StringUtils.isNotBlank(vcTradeid)){//成交编号
				vcTradeid = vcTradeid.trim();
				sb.append("   and t1.vc_tradeid like '%").append(vcTradeid).append("%'");
			}
			if(StringUtils.isNotBlank(lCreatedate)){//交易日期
				sb.append("   and t1.l_createdate =").append("'"+lCreatedate+"'");
			}
			if(StringUtils.isNotBlank(lSettlementdate)){//结算日期
				sb.append("   and t1.l_settlementdate = ").append("'"+lSettlementdate+"'");
			}
			if(StringUtils.isNotBlank(lDate)){//结算日期
				sb.append("   and t1.l_date = ").append("'"+lDate+"'");
			}
			//排序SQL语句
			String sqlOrder = "";
			
			//查询结果集
			List<Map<String, String>> list = JDBCUtil.queryWithConnPage(conn, sb, sqlOrder, page);
			if(!list.isEmpty() && list.size()>0){
				for(int i=0; i<list.size(); i++){
					Map<String, String> map = list.get(i);
					//创建实体对象
					obj = DataObjectUtil.createDataObject("commonj.sdo.DataObject");
					
					// 获取参数值
					String L_DATE = map.get("L_DATE");//业务日期
					String VC_SETTLEMENTORDERID = map.get("VC_SETTLEMENTORDERID");// 结算指令编号
					String VC_TRADEID = map.get("VC_TRADEID");// 成交编号
					String VC_BUYERHOLDERACCOUNT = map.get("VC_BUYERHOLDERACCOUNT");// 买方持有人账号
					String VC_BHOLDERSHORTNAME = map.get("VC_BHOLDERSHORTNAME");// 买方持有人账户简称
					String VC_BAGENCYHOLDERACCOUNT = map.get("VC_BAGENCYHOLDERACCOUNT");// 买方代理持有人账号
					String VC_BAGENCYHOLDERSHORTNAME = map.get("VC_BAGENCYHOLDERSHORTNAME");// 买方代理持有人账户简称
					String VC_BOPERHOLDERACCOUNT = map.get("VC_BOPERHOLDERACCOUNT");// 买方操作持有人账号
					String VC_SELLERHOLDERACCOUNT = map.get("VC_SELLERHOLDERACCOUNT");// 卖方持有人账号
					String VC_SHOLDERSHORTNAME = map.get("VC_SHOLDERSHORTNAME");// 卖方持有人账户简称
					String VC_SAGENCYHOLDERACCOUNT = map.get("VC_SAGENCYHOLDERACCOUNT");// 卖方代理持有人账号
					String VC_SAGENCYHOLDERSHORTNAME = map.get("VC_SAGENCYHOLDERSHORTNAME");// 卖方代理持有人账户简称
					String VC_SOPERHOLDERACCOUNT = map.get("VC_SOPERHOLDERACCOUNT");// 卖方操作持有人账号
					String VC_PRODUCTCODE = map.get("VC_PRODUCTCODE");// 产品代码
					String VC_PRODUCTNAME = map.get("VC_PRODUCTNAME");// 产品简称
					
					String VC_TRADETYPE = map.get("VC_TRADETYPE");// 交易方式
					String VC_CURRENCY = map.get("VC_CURRENCY");// 币种
					String L_SETTLEMENTTYPE = map.get("L_SETTLEMENTTYPE");// 结算方式
					String C_FULLORDERTYPE = map.get("C_FULLORDERTYPE");// 全额结算指令类型
					String C_PARTICIPATETYPE = map.get("C_PARTICIPATETYPE");// 参与方式
					String EN_SETTLEMENTAMOUNT = StrUtil.addThousandth0ToEmpty(map.get("EN_SETTLEMENTAMOUNT"), StrUtil.df1);// 结算金额
					String EN_FACEVALUE = StrUtil.addThousandth0ToEmpty(map.get("EN_FACEVALUE"), StrUtil.df1);// 产品面值
					String C_GROSSORDERSTATUS = map.get("C_GROSSORDERSTATUS");// 指令状态
					String C_FUNDSETTSTATUS = map.get("C_FUNDSETTSTATUS");// 资金结算状态
					String C_PRODUCTSTATUS = map.get("C_PRODUCTSTATUS");// 产品结算状态
					String L_FINANCEGRACEPERIOD = map.get("L_FINANCEGRACEPERIOD");// 资金宽限期
					String L_PRODUCTGRACEPERIOD = map.get("L_PRODUCTGRACEPERIOD");// 产品宽限期
					String L_SETTLEMENTDATE = map.get("L_SETTLEMENTDATE");// 结算日期
					String VC_BOPERORDERSTATUS = map.get("VC_BOPERORDERSTATUS");// 买方指令可操作状态
					String VC_SOPERORDERSTATUS = map.get("VC_SOPERORDERSTATUS");// 卖方指令可操作状态
					
					String C_STOCKSETTLE_FLAG = map.get("C_STOCKSETTLE_FLAG");// 证券交收状态
					String C_CASHSETTLE_FLAG = map.get("C_CASHSETTLE_FLAG");// 资金交收状态
					String VC_SETTLE_ERRMSG = map.get("VC_SETTLE_ERRMSG");// 交收错误信息
					String L_CREATEDATE = map.get("L_CREATEDATE");// 生成日期
					String L_CREATETIME = map.get("L_CREATETIME");// 生成时间
					String L_ORDERSTATUSUPDATETIME = map.get("L_ORDERSTATUSUPDATETIME");// 指令状态更新时间
					
					

					// 给对象赋值
					obj.setString("L_DATE", L_DATE);
					obj.setString("VC_SETTLEMENTORDERID", VC_SETTLEMENTORDERID);
					obj.setString("VC_TRADEID", VC_TRADEID);
					obj.setString("VC_BUYERHOLDERACCOUNT", VC_BUYERHOLDERACCOUNT);
					obj.setString("VC_BHOLDERSHORTNAME", VC_BHOLDERSHORTNAME);
					obj.setString("VC_BAGENCYHOLDERACCOUNT", VC_BAGENCYHOLDERACCOUNT);
					obj.setString("VC_BAGENCYHOLDERSHORTNAME", VC_BAGENCYHOLDERSHORTNAME);
					obj.setString("VC_BOPERHOLDERACCOUNT", VC_BOPERHOLDERACCOUNT);
					obj.setString("VC_SELLERHOLDERACCOUNT", VC_SELLERHOLDERACCOUNT);
					obj.setString("VC_SHOLDERSHORTNAME", VC_SHOLDERSHORTNAME);
					obj.setString("VC_SAGENCYHOLDERACCOUNT", VC_SAGENCYHOLDERACCOUNT);
					obj.setString("VC_SAGENCYHOLDERSHORTNAME", VC_SAGENCYHOLDERSHORTNAME);
					obj.setString("VC_SOPERHOLDERACCOUNT", VC_SOPERHOLDERACCOUNT);
					obj.setString("VC_PRODUCTCODE", VC_PRODUCTCODE);
					obj.setString("VC_PRODUCTNAME", VC_PRODUCTNAME);
					obj.setString("VC_TRADETYPE", VC_TRADETYPE);
					obj.setString("VC_CURRENCY", VC_CURRENCY);
					obj.setString("L_SETTLEMENTTYPE", L_SETTLEMENTTYPE);
					obj.setString("C_FULLORDERTYPE", C_FULLORDERTYPE);
					obj.setString("C_PARTICIPATETYPE", C_PARTICIPATETYPE);
					obj.setString("EN_SETTLEMENTAMOUNT", EN_SETTLEMENTAMOUNT);
					obj.setString("EN_FACEVALUE", EN_FACEVALUE);
					obj.setString("C_GROSSORDERSTATUS", C_GROSSORDERSTATUS);
					obj.setString("C_FUNDSETTSTATUS", C_FUNDSETTSTATUS);
					obj.setString("C_PRODUCTSTATUS", C_PRODUCTSTATUS);
					obj.setString("L_FINANCEGRACEPERIOD", L_FINANCEGRACEPERIOD);
					obj.setString("L_PRODUCTGRACEPERIOD", L_PRODUCTGRACEPERIOD);
					obj.setString("L_SETTLEMENTDATE", L_SETTLEMENTDATE);
					obj.setString("VC_BOPERORDERSTATUS", VC_BOPERORDERSTATUS);
					obj.setString("VC_SOPERORDERSTATUS", VC_SOPERORDERSTATUS);
					obj.setString("C_STOCKSETTLE_FLAG", C_STOCKSETTLE_FLAG);
					obj.setString("C_CASHSETTLE_FLAG", C_CASHSETTLE_FLAG);
					obj.setString("VC_SETTLE_ERRMSG", VC_SETTLE_ERRMSG);
					obj.setString("L_CREATEDATE", L_CREATEDATE);
					obj.setString("L_CREATETIME", L_CREATETIME);
					obj.setString("L_ORDERSTATUSUPDATETIME", L_ORDERSTATUSUPDATETIME);
					
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
