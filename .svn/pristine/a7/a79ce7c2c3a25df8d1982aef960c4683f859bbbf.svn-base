package com.cjhxfund.commonUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.cjhxfund.commonUtil.model.TCombi;
import com.cjhxfund.commonUtil.model.TProduct;
import com.cjhxfund.commonUtil.model.TProductHandle;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;

/**
 * 机器猫系统产品、组合权限公共功能类
 * 一级债、二级债，包括以后开基、存款等业务，产品、组合等权限的出口都只能本公用类里面的某个方法。
 * 若以下抽象的方法还不能满足自己开发功能的权限需求，请提出，评估合理后再继续在本公共类里面添加。
 * 
 * relateType “权限关系类型” 请根据“CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE”到数据字典表从查找，SQL如下：
 * select * from eos_dict_type t where t.dicttypeid like '%CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE%';
 * select * from eos_dict_entry t where t.dicttypeid like '%CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE%';
 * 
 * 
 * 以下述语中：“录入”与“经办”、“确认”与“复核”语义一致。
 * 
 * 1、创金员工、非创金员工公共权限类型：
 * 00-组合查询权限；
 * 
 * 2、投顾、委托人等非创金员工权限类型：
 * 01-组合与投资录入权限；
 * 07-组合与投资确认权限；
 * A4-需要投顾风控确认；
 * A5-组合与投顾风控确认权限；
 * A2-需要委托人确认；
 * A3-组合与委托人确认权限；
 * A1-投资录入确认可为同一人员；
 * 
 * 3、投资经理、交易员等创金员工权限类型：
 * 02-组合与投资/基金经理权限；
 * 03-组合与询价结果录入权限；
 * 04-组合与交易录单确认权限；
 * 05-组合与交易录单复核权限；
 * 06-组合与资金手工交收权限；
 * 08-组合与资金交收设置权限；
 * 09-组合与中标确认交易员审批权限；
 * 99-交易确认阶段权限；
 * 98-后台成交确认阶段权限；
 * 
 * 
 * @author huangmizhi
 * @date 2016-11-07 16:30:12
 */
@Bizlet("")
public class ProductCombiRightUtil {
	
	/** 投顾确认(复核)、投顾风控确认(复核)、委托人确认(复核)等没权限时返回的常量字符串：NoPermission */
	public final static String NO_PERMISSION = "NoPermission";
	/** 投顾确认(复核)、投顾风控确认(复核)、委托人确认(复核)等未设置人员时返回的常量字符串：NoPerson */
	public final static String NO_PERSON = "NoPerson";
	/** 投顾确认(复核)、投顾风控确认(复核)、委托人确认(复核)等已设置人员但剔除传入的用户ID后无用户权限时返回的常量字符串：HasSetPersonButNoPermission */
	public final static String HAS_SET_PERSON_BUT_NO_PERMISSION = "HasSetPersonButNoPermission";
	
	
	/**
	 * 获取用户产品权限列表
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProduct> getProductRightList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TProduct>();
		}
		return getProductListCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“投顾录入”权限的产品信息列表，根据用户ID+“01-组合与投资录入权限”获取用户产品信息列表(02-投资经理默认包含投顾录入权限)
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProduct> getInvestAdviserInputProductRightList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TProduct>();
		}
		return getProductListCommon("01,02", userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“投顾录入”权限的组合信息列表，根据用户ID+“01-组合与投资录入权限”获取用户组合信息列表(02-投资经理默认包含投顾录入权限)
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TCombi> getInvestAdviserInputCombiRightList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TCombi>();
		}
		return getCombiListCommon("01,02", userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“投顾录入”权限的组合信息列表，根据用户ID+产品代码+“01-组合与投资录入权限”获取用户组合信息列表(02-投资经理默认包含投顾录入权限)
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TCombi> getInvestAdviserInputCombiRightList(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new ArrayList<TCombi>();
		}
		return getCombiListCommon("01,02", userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户组合权限列表
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TCombi> getCombiRightList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TCombi>();
		}
		return getCombiListCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品组合权限列表
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TCombi> getProductCombiRightList(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new ArrayList<TCombi>();
		}
		return getCombiListCommon(null, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据用户ID获取用户产品操作权限列表
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProductHandle> getProductHandleByUserIdList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型获取用户产品操作权限列表
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProductHandle> getProductHandleByRelateTypeList(String relateType){
		if(StringUtils.isBlank(relateType)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(relateType, null, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+产品代码获取用户产品操作权限列表
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProductHandle> getProductHandleByRelateTypeAndProductCodeList(String relateType, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(productCode)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(relateType, null, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+产品代码+组合编号(代码)获取用户产品操作权限列表
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProductHandle> getProductHandleByRelateTypeAndProductCodeAndCombiCodeList(String relateType, String productCode, String combiCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(relateType, null, null, null, productCode, null, null, null, null, null, combiCode, null);
	}
	
	/**
	 * 获取用户单个产品操作权限列表
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProductHandle> getSingleProductHandleList(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(null, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户单个产品操作权限列表
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProductHandle> getSingleProductHandleList(String relateType, String userId, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(relateType, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取产品操作权限列表
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author 童伟
	 */
	@Bizlet("")
	public static List<TProductHandle> getProductHandleList(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null, "com.cjhxfund.commonUtil.productCombiRightUtil.getProducrHandleListCommonSQL");
	}
	
	/**
	 * 根据用户ID获取用户产品操作权限
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static TProductHandle getProductHandleByUserId(String userId){
		if(StringUtils.isBlank(userId)){
			return new TProductHandle();
		}
		List<TProductHandle> list = getProductHandleByUserIdList(userId);
		if(!list.isEmpty() && list.size()>0){
			return list.get(0);
		}
		return new TProductHandle();
	}
	
	/**
	 * 根据权限关系类型获取用户产品操作权限
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static TProductHandle getProductHandleByRelateType(String relateType){
		if(StringUtils.isBlank(relateType)){
			return new TProductHandle();
		}
		List<TProductHandle> list = getProductHandleByRelateTypeList(relateType);
		if(!list.isEmpty() && list.size()>0){
			return list.get(0);
		}
		return new TProductHandle();
	}
	
	/**
	 * 根据权限关系类型+产品代码获取用户产品操作权限
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static TProductHandle getProductHandleByRelateTypeAndProductCode(String relateType, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(productCode)){
			return new TProductHandle();
		}
		List<TProductHandle> list = getProductHandleByRelateTypeAndProductCodeList(relateType, productCode);
		if(!list.isEmpty() && list.size()>0){
			return list.get(0);
		}
		return new TProductHandle();
	}
	
	/**
	 * 获取用户单个产品操作权限
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static TProductHandle getSingleProductHandle(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new TProductHandle();
		}
		List<TProductHandle> list = getSingleProductHandleList(userId, productCode);
		if(!list.isEmpty() && list.size()>0){
			return list.get(0);
		}
		return new TProductHandle();
	}
	
	/**
	 * 获取用户单个产品操作权限
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static TProductHandle getSingleProductHandle(String relateType, String userId, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new TProductHandle();
		}
		List<TProductHandle> list = getSingleProductHandleList(relateType, userId, productCode);
		if(!list.isEmpty() && list.size()>0){
			return list.get(0);
		}
		return new TProductHandle();
	}
	
	/**
	 * 获取用户产品权限ID串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 如：1001,1002,1003,1004...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductRightID(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getProductRightIDCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户组合权限ID串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 如：4,5,6,7...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiRightID(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getCombiRightIDCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品组合权限ID串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 如：4,5,6,7...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductCombiRightID(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getCombiRightIDCommon(null, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品操作权限ID串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：权限ID1，权限ID2；如：1,2,3,4...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductHandleID(String userId){
		return null;
	}
	
	/**
	 * 获取用户单个产品操作权限ID串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：权限ID1，权限ID2；如：1,2,3,4...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getSingleProductHandleID(String userId, String productCode){
		return null;
	}
	
	/**
	 * 获取用户产品权限name串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：创金合信聚利债券（工行）,创金沪港深精选组合（工行）,创金合信货币（招行）,合信阿杏1号...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductRightName(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getProductRightNameCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户组合权限name串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：缺省组合,昭尊1号现货,昭尊2号-A,昭尊2号-B...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiRightName(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getCombiRightNameCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品组合权限name串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：缺省组合,昭尊1号现货,昭尊2号-A,昭尊2号-B...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductCombiRightName(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getCombiRightNameCommon(null, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品操作权限name串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductHandleName(String userId){
		return null;
	}
	
	/**
	 * 获取用户单个产品操作权限name串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getSingleProductHandleName(String userId, String productCode){
		return null;
	}
	
	/**
	 * 获取用户产品权限Code串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：001199,001662,001909,001977...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductRightCode(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getProductRightCodeCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户组合权限Code串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：2001_000,3001_000,3002_000,3003_000,3007_000...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiRightCode(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getCombiRightCodeCommon(null, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品组合权限Code串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：2001_000,3001_000,3002_000,3003_000,3007_000...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductCombiRightCode(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getCombiRightCodeCommon(null, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取用户产品操作权限Code串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductHandleCode(String userId){
		return null;
	}
	
	/**
	 * 获取用户单个产品操作权限关系类型字符串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：00,01,07,A4,A5,A2,A3,A1,02,03,04,05,06,08,09,99,98...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getSingleProductRelateType(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		StringBuffer sb = new StringBuffer();
		List<TProductHandle> list = getSingleProductHandleList(userId, productCode);
		if(!list.isEmpty() && list.size()>0){
			for(int i=0; i<list.size(); i++){
				TProductHandle bean = list.get(i);
				if(StringUtils.isNotBlank(bean.getVcRelateType())){
					sb.append(bean.getVcRelateType().trim()).append(",");
				}
			}
		}
		return sb.length()==0?NO_PERMISSION:sb.substring(0, sb.length()-1);
	}
	
	/**
	 * 根据权限关系类型获取用户ID串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserIdsByRelateType(String relateType){
		if(StringUtils.isBlank(relateType)){
			return NO_PERMISSION;
		}
		return getUserIdCommon(relateType, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型获取用户名称串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @return 返回：张三,李四,王五...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserNamesByRelateType(String relateType){
		if(StringUtils.isBlank(relateType)){
			return NO_PERMISSION;
		}
		return getUserNameCommon(relateType, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据产品代码获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserIdsByProductCode(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon(null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据产品代码获取用户名称串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：张三,李四,王五...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserNamesByProductCode(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserNameCommon(null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+产品代码获取用户ID串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserIdsByRelateTypeAndProductCode(String relateType, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon(relateType, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+产品代码获取用户ID串
	 * @param relateTypes 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找(01,02,04,....)
	 * @param productCodes 产品代码，如：001199,001188,...
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserIdsByRelateTypesAndProductCodesAndCombiCodes(String relateTypes, String productCodes, String combiCodes){
		if(StringUtils.isBlank(relateTypes) || StringUtils.isBlank(productCodes)){
			return NO_PERMISSION;
		}
		return getUserIdCommon(relateTypes, productCodes, null, combiCodes);
	}
	
	/**
	 * 根据权限关系类型+产品代码获取用户名称串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param productCode 产品代码，如：001199
	 * @return 返回：张三,李四,王五...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getUserNamesByRelateTypeAndProductCode(String relateType, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserNameCommon(relateType, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取产品ID串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：1001,1002,1003,1004...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductIDByRelateTypeAndUserId(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getProductRightIDCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取产品Code串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：001199,001662,001909,001977...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductCodeByRelateTypeAndUserId(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getProductRightCodeCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取产品Name串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：创金合信聚利债券（工行）,创金沪港深精选组合（工行）,创金合信货币（招行）,合信阿杏1号...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getProductNameByRelateTypeAndUserId(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getProductRightNameCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取组合ID串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：4,5,6,7...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiIDByRelateTypeAndUserId(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getCombiRightIDCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取组合Code串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：2001_000,3001_000,3002_000,3003_000,3007_000...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiCodeByRelateTypeAndUserId(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getCombiRightCodeCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID获取组合Name串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：缺省组合,昭尊1号现货,昭尊2号-A,昭尊2号-B...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiNameByRelateTypeAndUserId(String relateType, String userId){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getCombiRightNameCommon(relateType, userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID+产品代码获取组合ID串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：4,5,6,7...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiIDByRelateTypeAndUserIdAndProductCode(String relateType, String userId, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getCombiRightIDCommon(relateType, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID+产品代码获取组合Code串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：2001_000,3001_000,3002_000,3003_000,3007_000...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiCodeByRelateTypeAndUserIdAndProductCode(String relateType, String userId, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getCombiRightCodeCommon(relateType, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据权限关系类型+用户ID+产品代码获取组合Name串
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：缺省组合,昭尊1号现货,昭尊2号-A,昭尊2号-B...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getCombiNameByRelateTypeAndUserIdAndProductCode(String relateType, String userId, String productCode){
		if(StringUtils.isBlank(relateType) || StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getCombiRightNameCommon(relateType, userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据用户ID获取权限关系类型字符串
	 * @param userId 用户ID，如：huangmizhi
	 * @return 返回：01,02,03,A1,A2,A3...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getRelateTypeByUserId(String userId){
		if(StringUtils.isBlank(userId)){
			return NO_PERMISSION;
		}
		return getRelateTypeCommon(userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 根据用户ID+产品代码获取权限关系类型字符串
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：01,02,03,A1,A2,A3...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getRelateTypeByUserIdAndProductCode(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getRelateTypeCommon(userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“投顾录入”权限的用户ID串，根据权限关系类型（01-组合与投资录入权限、02-组合与投资经理权限）+产品代码获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestAdviserInputUserIds(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("01", null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“投顾录入”权限的用户ID串，根据权限关系类型（01-组合与投资录入权限）+产品代码+组合编号(代码)获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestAdviserInputUserIds(String productCode, String combiCode){
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("01", null, productCode, null, null, null, null, null, combiCode, null);
	}
	
	/**
	 * 获取拥有“投顾确认(复核)”权限的用户ID串，根据权限关系类型（07-组合与投资确认权限）+产品代码获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品组合设置了“A1-投资录入确认可为同一人员”，则不做剔除处理。
	 * 
	 * 1、没有传入产品代码，返回“NoPermission”字符串；
	 * 2、没设置复核用户，返回“NoPerson”字符串；
	 * 3、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 4、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestAdviserConfirmUserIds(String userId, String productCode){
		//1、没有传入产品代码，返回“NoPermission”字符串；
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		//第2、3、4点判断逻辑在公共方法实现
		return getConfirmRightUserIdsCommon("07", userId, productCode, null, "A1");
	}
	
	/**
	 * 获取拥有“投顾确认(复核)”权限的用户ID串，根据权限关系类型（07-组合与投资确认权限）+产品代码+组合编号(代码)获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品组合设置了“A1-投资录入确认可为同一人员”，则不做剔除处理。
	 * 
	 * 1、没有传入产品代码、组合代码，返回“NoPermission”字符串；
	 * 2、没设置复核用户，返回“NoPerson”字符串；
	 * 3、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 4、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestAdviserConfirmUserIds(String userId, String productCode, String combiCode){
		//1、没有传入产品代码、组合编号(代码)，返回“NoPermission”字符串；
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		//第2、3、4点判断逻辑在公共方法实现
		return getConfirmRightUserIdsCommon("07", userId, productCode, combiCode, "A1");
	}
	
	/**
	 * 获取拥有“投顾风控确认(复核)”权限的用户ID串，根据权限关系类型（A5-组合与投顾风控确认权限）+产品代码获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品组合设置了“A1-投资录入确认可为同一人员”，则不做剔除处理。
	 * 
	 * 1、没有传入产品代码，返回“NoPermission”字符串；
	 * 2、没设置复核用户，返回“NoPerson”字符串；
	 * 3、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 4、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestAdviserRiskCtrlConfirmUserIds(String userId, String productCode){
		//1、没有传入产品代码，返回“NoPermission”字符串；
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		//第2、3、4点判断逻辑在公共方法实现
		return getConfirmRightUserIdsCommon("A5", userId, productCode, null, "A1");
	}
	
	/**
	 * 获取拥有“投顾风控确认(复核)”权限的用户ID串，根据权限关系类型（A5-组合与投顾风控确认权限）+产品代码+组合编号(代码)获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品组合设置了“A1-投资录入确认可为同一人员”，则不做剔除处理。
	 * 
	 * 1、没有传入产品代码、组合代码，返回“NoPermission”字符串；
	 * 2、没设置复核用户，返回“NoPerson”字符串；
	 * 3、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 4、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInvestAdviserRiskCtrlConfirmUserIds(String userId, String productCode, String combiCode){
		//1、没有传入产品代码、组合编号(代码)，返回“NoPermission”字符串；
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		//第2、3、4点判断逻辑在公共方法实现
		return getConfirmRightUserIdsCommon("A5", userId, productCode, combiCode, "A1");
	}
	
	/**
	 * 获取拥有“委托人确认(复核)”权限的用户ID串，根据权限关系类型（A3-组合与委托人确认权限）+产品代码获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品设置了“A1-投资录入确认可为同一人员”，则不做剔除处理。
	 * 
	 * 1、没有传入产品代码，返回“NoPermission”字符串；
	 * 2、没设置复核用户，返回“NoPerson”字符串；
	 * 3、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 4、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getEntrustConfirmUserIds(String userId, String productCode){
		//1、没有传入产品代码，返回“NoPermission”字符串；
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		//第2、3、4点判断逻辑在公共方法实现
		return getConfirmRightUserIdsCommon("A3", userId, productCode, null, "A1");
	}
	
	/**
	 * 获取拥有“委托人确认(复核)”权限的用户ID串，根据权限关系类型（A3-组合与委托人确认权限）+产品代码+组合编号(代码)获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品组合设置了“A1-投资录入确认可为同一人员”，则不做剔除处理。
	 * 
	 * 1、没有传入产品代码、组合代码，返回“NoPermission”字符串；
	 * 2、没设置复核用户，返回“NoPerson”字符串；
	 * 3、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 4、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getEntrustConfirmUserIds(String userId, String productCode, String combiCode){
		//1、没有传入产品代码、组合编号(代码)，返回“NoPermission”字符串；
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		//第2、3、4点判断逻辑在公共方法实现
		return getConfirmRightUserIdsCommon("A3", userId, productCode, combiCode, "A1");
	}
	
	/**
	 * 获取拥有“询价结果录入”权限的用户ID串，根据权限关系类型（03-组合与询价结果录入权限）+产品代码获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInquiryResultInputUserIds(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("03", null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“询价结果录入”权限的用户ID串，根据权限关系类型（03-组合与询价结果录入权限）+产品代码+组合编号(代码)获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getInquiryResultInputUserIds(String productCode, String combiCode){
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("03", null, productCode, null, null, null, null, null, combiCode, null);
	}
	
	/**
	 * 获取拥有“交易录单确认”权限的用户ID串，根据权限关系类型（04-组合与交易录单确认权限）+产品代码获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getTradeInputConfirmUserIds(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("04", null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“交易录单确认”权限的用户ID串，根据权限关系类型（04-组合与交易录单确认权限）+产品代码+组合编号(代码)获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getTradeInputConfirmUserIds(String productCode, String combiCode){
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("04", null, productCode, null, null, null, null, null, combiCode, null);
	}
	
	/**
	 * 获取拥有“交易录单复核”权限的用户ID串，根据权限关系类型（05-组合与交易录单复核权限）+产品代码获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getTradeInputCheckUserIds(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("05", null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“交易录单复核”权限的用户ID串，根据权限关系类型（05-组合与交易录单复核权限）+产品代码+组合编号(代码)获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getTradeInputCheckUserIds(String productCode, String combiCode){
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("05", null, productCode, null, null, null, null, null, combiCode, null);
	}
	
	/**
	 * 获取拥有“资金手工交收”权限的用户ID串，根据权限关系类型（06-组合与资金手工交收权限）+产品代码获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getAssetSettleUserIds(String productCode){
		if(StringUtils.isBlank(productCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("06", null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“资金手工交收”权限的用户ID串，根据权限关系类型（06-组合与资金手工交收权限）+产品代码+组合编号(代码)获取用户ID串
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static String getAssetSettleUserIds(String productCode, String combiCode){
		if(StringUtils.isBlank(productCode) || StringUtils.isBlank(combiCode)){
			return NO_PERMISSION;
		}
		return getUserIdCommon("06", null, productCode, null, null, null, null, null, combiCode, null);
	}
	
	/**
	 * 获取拥有“资金交收设置”权限的产品信息列表，根据用户ID+“08-组合与资金交收设置权限”获取用户产品信息列表
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TProduct> getAssetSettleSetProductRightList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TProduct>();
		}
		return getProductListCommon("08", userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“资金交收设置”权限的组合信息列表，根据用户ID+“08-组合与资金交收设置权限”获取用户组合信息列表
	 * @param userId 用户ID，如：huangmizhi
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TCombi> getAssetSettleSetCombiRightList(String userId){
		if(StringUtils.isBlank(userId)){
			return new ArrayList<TCombi>();
		}
		return getCombiListCommon("08", userId, null, null, null, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“资金交收设置”权限的组合信息列表，根据用户ID+产品代码+“08-组合与资金交收设置权限”获取用户组合信息列表
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	public static List<TCombi> getAssetSettleSetCombiRightList(String userId, String productCode){
		if(StringUtils.isBlank(userId) || StringUtils.isBlank(productCode)){
			return new ArrayList<TCombi>();
		}
		return getCombiListCommon("08", userId, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	/**
	 * 获取拥有“中标确认交易员审批”权限的产品操作权限列表，根据产品代码+“09-组合与中标确认交易员审批权限”获取产品操作权限列表
	 * @param productCode 产品代码，如：001199
	 * @return
	 * @author chenpeng
	 */
	@Bizlet("")
	public static List<TProductHandle> getTraderConfirmExaminApprovalAuthorityList(String productCode){
		if(StringUtils.isBlank(productCode)){
			return new ArrayList<TProductHandle>();
		}
		return getRightListCommon("09", null, null, null, productCode, null, null, null, null, null, null, null);
	}
	
	
	
	
	
	
	
	
	
	
	//*****************【公共调用方法】 begin...*****************//
	
	/**
	 * 【公共调用方法】获取权限关系类型字符串
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：缺省组合,昭尊1号现货,昭尊2号-A,昭尊2号-B...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getRelateTypeCommon(String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getRelateTypeCommonSQL", null, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取用户产品权限ID串
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 如：1001,1002,1003,1004...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getProductRightIDCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getProductRightIDCommonSQL", vcRelateType, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取用户产品权限Code串
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：001199,001662,001909,001977...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getProductRightCodeCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getProductRightCodeCommonSQL", vcRelateType, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取用户产品权限name串
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：创金合信聚利债券（工行）,创金沪港深精选组合（工行）,创金合信货币（招行）,合信阿杏1号...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getProductRightNameCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getProductRightNameCommonSQL", vcRelateType, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取用户组合权限ID串
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 如：4,5,6,7...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getCombiRightIDCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getCombiRightIDCommonSQL", vcRelateType, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取用户组合权限Code串
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：2001_000,3001_000,3002_000,3003_000,3007_000...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getCombiRightCodeCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getCombiRightCodeCommonSQL", vcRelateType, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取用户组合权限name串
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：缺省组合,昭尊1号现货,昭尊2号-A,昭尊2号-B...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getCombiRightNameCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getCombiRightNameCommonSQL", vcRelateType, vcUserId, vcUserName, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】根据权限关系类型、产品、资产单元、组合获取userId串
	 * @param vcRelateType 权限关系类型
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getUserIdCommon(String vcRelateType, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getUserIdCommonSQL", vcRelateType, null, null, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】根据权限关系类型、产品、资产单元、组合获取userId串
	 * @param vcRelateType 权限关系类型,如：'01','02',....
	 * @param vcProductCode 产品代码，如：'001199','001188',...
	 * @param vcAssetNo 资产单元代码（编号），如：'20010001','20010002',...
	 * @param vcCombiNo 组合代码（编号），如：'2001_000','2001_001',...
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getUserIdCommon(String vcRelateType, String vcProductCode, String vcAssetNo, String vcCombiNo){
		return getRightStrCommon("getUserIdInCommonSQL", null, vcRelateType, vcProductCode, vcAssetNo, vcCombiNo);
	}
	
	/**
	 * 【公共调用方法】根据权限关系类型、产品、资产单元、组合获取name串
	 * @param vcRelateType 权限关系类型
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：张三,李四,王五...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getUserNameCommon(String vcRelateType, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		return getRightStrCommon("getUserNameCommonSQL", vcRelateType, null, null, lProductId, vcProductCode, vcProductName, lAssetId, vcAssetNo, vcAssetName, lCombiId, vcCombiNo, vcCombiName);
	}
	
	/**
	 * 【公共调用方法】获取拥有“投顾确认(复核)、投顾风控确认(复核)、委托人确认(复核)”等权限的用户ID串，根据权限关系类型+产品代码+组合编号(代码)获取用户ID串
	 * 默认剔除传入的用户ID（一般传入指令录入人员ID），若产品组合设置了可为同一人员权限，则不做剔除处理。
	 * 
	 * 1、没设置复核用户，返回“NoPerson”字符串；
	 * 2、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
	 * 3、设置复核用户且存在用户，则返回有权限的用户ID字符串；
	 * 
	 * @param relateType 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @param userId 用户ID，如：huangmizhi
	 * @param productCode 产品代码，如：001199
	 * @param combiCode 组合编号(代码)，如：1001_000
	 * @param relateTypeSame 权限关系类型，值域请根据“dicttypeid='CF_JY_COMB_PRODUCT_HANDLE_RELA_TYPE'”到“eos_dict_entry”表中查找
	 * @return 返回：zhangsan,lisi,wangwu...
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getConfirmRightUserIdsCommon(String relateType, String userId, String productCode, String combiCode, String relateTypeSame){
		//1、没设置复核用户，返回“NoPerson”字符串；
		String result = getUserIdCommon(relateType, null, productCode, null, null, null, null, null, combiCode, null);
		if(StringUtils.isBlank(result)){
			return NO_PERSON;
		}
		
		//2、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
		boolean isContain = false;
		relateTypeSame = StringUtils.isBlank(relateTypeSame)?"A1":relateTypeSame;//若可为同一人员权限参数未传入，则取默认值“A1-投资录入确认可为同一人员”权限
		List<TProductHandle> list = getRightListCommon(relateTypeSame, null, null, null, productCode, null, null, null, null, null, combiCode, null);
		//若查询得出记录，则说明该产品组合已设置了可为同一人员权限
		if(list!=null && !list.isEmpty() && list.size()>0){
			isContain = true;//该产品组合已设置了可为同一人员权限，无需剔除传入的用户ID（一般传入指令录入人员ID）
		}
		String[] userIdArr = result.split(",");
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<userIdArr.length; i++){
			String str = userIdArr[i];
			if(StringUtils.isNotBlank(str)){
				//已设置了可为同一人员权限，直接添加
				if(isContain){
					sb.append(str).append(",");
				
				//未设置可为同一人员权限
				}else{
					//若查询出的用户不等于传入的用户ID（一般传入指令录入人员ID），直接添加，否则跳过
					if(!str.equalsIgnoreCase(userId)){
						sb.append(str).append(",");
					}
				}
			}
		}
		//2、设置复核用户但剔除传入的用户ID后无用户，返回“HasSetPersonButNoPermission”字符串；
		if(sb.length()==0){
			return HAS_SET_PERSON_BUT_NO_PERMISSION;
		}
		
		//3、设置复核用户且存在用户，则返回有权限的用户ID字符串；
		return sb.substring(0, sb.length()-1);
	}
	
	/**
	 * 【公共调用方法】获取权限字符串
	 * @param namedSqlId 命名SQL的ID
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：字符串1,字符串2,字符串3......
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getRightStrCommon(String namedSqlId, String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		if(StringUtils.isBlank(namedSqlId)){
			return NO_PERMISSION;
		}
		Map<String,String> paramMap = new HashMap<String,String>();
		if(StringUtils.isNotBlank(vcRelateType)){
			paramMap.put("vcRelateType", StrUtil.disposeString(vcRelateType));
		}
		if(StringUtils.isNotBlank(vcUserId)){
			paramMap.put("vcUserId", vcUserId);
		}		
		if(StringUtils.isNotBlank(vcUserName)){
			paramMap.put("vcUserName", vcUserName);
		}
		if(StringUtils.isNotBlank(lProductId)){
			paramMap.put("lProductId", lProductId);
		}
		if(StringUtils.isNotBlank(vcProductCode)){
			paramMap.put("vcProductCode", vcProductCode);
		}
		if(StringUtils.isNotBlank(vcProductName)){
			paramMap.put("vcProductName", vcProductName);
		}
		if(StringUtils.isNotBlank(lAssetId)){
			paramMap.put("lAssetId", lAssetId);
		}
		if(StringUtils.isNotBlank(vcAssetNo)){
			paramMap.put("vcAssetNo", vcAssetNo);
		}
		if(StringUtils.isNotBlank(vcAssetName)){
			paramMap.put("vcAssetName", vcAssetName);
		}
		if(StringUtils.isNotBlank(lCombiId)){
			paramMap.put("lCombiId", lCombiId);
		}
		if(StringUtils.isNotBlank(vcCombiNo)){
			paramMap.put("vcCombiNo", vcCombiNo);
		}
		if(StringUtils.isNotBlank(vcCombiName)){
			paramMap.put("vcCombiName", vcCombiName);
		}
		
		String result = "";
		Object[] objArr = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.commonUtil.productCombiRightUtil."+namedSqlId, paramMap);
		if(objArr!=null && objArr.length>0 && objArr[0]!=null){
			result = objArr[0].toString();
		}
		paramMap.clear();
		paramMap = null;
		if(StringUtils.isBlank(result)){
			return NO_PERMISSION;
		}
		return result;
	}
	
	/**
	 * 【公共调用方法】获取权限字符串
	 * @param namedSqlId 命名SQL的ID
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return 返回：字符串1,字符串2,字符串3......
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static String getRightStrCommon(String namedSqlId, String vcUserId, String vcRelateType, String vcProductCode, String vcAssetNo, String vcCombiNo){
		if(StringUtils.isBlank(namedSqlId)){
			return NO_PERMISSION;
		}
		Map<String,String> paramMap = new HashMap<String,String>();
		if(StringUtils.isNotBlank(vcRelateType)){
			paramMap.put("vcRelateType", StrUtil.disposeString(vcRelateType));
		}
		if(StringUtils.isNotBlank(vcUserId)){
			paramMap.put("vcUserId", StrUtil.disposeString(vcUserId));
		}
		if(StringUtils.isNotBlank(vcProductCode)){
			paramMap.put("vcProductCode", StrUtil.disposeString(vcProductCode));
		}
		if(StringUtils.isNotBlank(vcAssetNo)){
			paramMap.put("vcAssetNo", StrUtil.disposeString(vcAssetNo));
		}
		if(StringUtils.isNotBlank(vcCombiNo)){
			paramMap.put("vcCombiNo", StrUtil.disposeString(vcCombiNo));
		}
		String result = "";
		Object[] objArr = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.commonUtil.productCombiRightUtil."+namedSqlId, paramMap);
		if(objArr!=null && objArr.length>0 && objArr[0]!=null){
			result = objArr[0].toString();
		}
		paramMap.clear();
		paramMap = null;
		if(StringUtils.isBlank(result)){
			return NO_PERMISSION;
		}
		return result;
	}
	
	/**
	 * 【公共调用方法】获取产品组合与处理人员权限关系列表
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static List<TProductHandle> getRightListCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		Map<String,String> paramMap = new HashMap<String,String>();
		if(StringUtils.isNotBlank(vcRelateType)){
			paramMap.put("vcRelateType", StrUtil.disposeString(vcRelateType));
		}
		if(StringUtils.isNotBlank(vcUserId)){
			paramMap.put("vcUserId", vcUserId);
		}		
		if(StringUtils.isNotBlank(vcUserName)){
			paramMap.put("vcUserName", vcUserName);
		}
		if(StringUtils.isNotBlank(lProductId)){
			paramMap.put("lProductId", lProductId);
		}
		if(StringUtils.isNotBlank(vcProductCode)){
			paramMap.put("vcProductCode", vcProductCode);
		}
		if(StringUtils.isNotBlank(vcProductName)){
			paramMap.put("vcProductName", vcProductName);
		}
		if(StringUtils.isNotBlank(lAssetId)){
			paramMap.put("lAssetId", lAssetId);
		}
		if(StringUtils.isNotBlank(vcAssetNo)){
			paramMap.put("vcAssetNo", vcAssetNo);
		}
		if(StringUtils.isNotBlank(vcAssetName)){
			paramMap.put("vcAssetName", vcAssetName);
		}
		if(StringUtils.isNotBlank(lCombiId)){
			paramMap.put("lCombiId", lCombiId);
		}
		if(StringUtils.isNotBlank(vcCombiNo)){
			paramMap.put("vcCombiNo", vcCombiNo);
		}
		if(StringUtils.isNotBlank(vcCombiName)){
			paramMap.put("vcCombiName", vcCombiName);
		}
		
		List<TProductHandle> result = new ArrayList<TProductHandle>();
		Object[] objArr = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.commonUtil.productCombiRightUtil.getRightListCommonSQL", paramMap);
		if(objArr!=null && objArr.length>0){
			for(int i=0; i<objArr.length; i++){
				result.add((TProductHandle) objArr[i]);
			}
		}
		paramMap.clear();
		paramMap = null;
		return result;
	}
	
	/**
	 * 【公共调用方法】获取产品信息列表
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static List<TProduct> getProductListCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		Map<String,String> paramMap = new HashMap<String,String>();
		if(StringUtils.isNotBlank(vcRelateType)){
			paramMap.put("vcRelateType", StrUtil.disposeString(vcRelateType));
		}
		if(StringUtils.isNotBlank(vcUserId)){
			paramMap.put("vcUserId", vcUserId);
		}		
		if(StringUtils.isNotBlank(vcUserName)){
			paramMap.put("vcUserName", vcUserName);
		}
		if(StringUtils.isNotBlank(lProductId)){
			paramMap.put("lProductId", lProductId);
		}
		if(StringUtils.isNotBlank(vcProductCode)){
			paramMap.put("vcProductCode", vcProductCode);
		}
		if(StringUtils.isNotBlank(vcProductName)){
			paramMap.put("vcProductName", vcProductName);
		}
		if(StringUtils.isNotBlank(lAssetId)){
			paramMap.put("lAssetId", lAssetId);
		}
		if(StringUtils.isNotBlank(vcAssetNo)){
			paramMap.put("vcAssetNo", vcAssetNo);
		}
		if(StringUtils.isNotBlank(vcAssetName)){
			paramMap.put("vcAssetName", vcAssetName);
		}
		if(StringUtils.isNotBlank(lCombiId)){
			paramMap.put("lCombiId", lCombiId);
		}
		if(StringUtils.isNotBlank(vcCombiNo)){
			paramMap.put("vcCombiNo", vcCombiNo);
		}
		if(StringUtils.isNotBlank(vcCombiName)){
			paramMap.put("vcCombiName", vcCombiName);
		}
		
		List<TProduct> result = new ArrayList<TProduct>();
		Object[] objArr = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.commonUtil.productCombiRightUtil.getProductListCommonSQL", paramMap);
		if(objArr!=null && objArr.length>0){
			for(int i=0; i<objArr.length; i++){
				result.add((TProduct) objArr[i]);
			}
		}
		paramMap.clear();
		paramMap = null;
		return result;
	}
	
	/**
	 * 【公共调用方法】获取组合信息列表
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static List<TCombi> getCombiListCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName){
		Map<String,String> paramMap = new HashMap<String,String>();
		if(StringUtils.isNotBlank(vcRelateType)){
			paramMap.put("vcRelateType", StrUtil.disposeString(vcRelateType));
		}
		if(StringUtils.isNotBlank(vcUserId)){
			paramMap.put("vcUserId", vcUserId);
		}		
		if(StringUtils.isNotBlank(vcUserName)){
			paramMap.put("vcUserName", vcUserName);
		}
		if(StringUtils.isNotBlank(lProductId)){
			paramMap.put("lProductId", lProductId);
		}
		if(StringUtils.isNotBlank(vcProductCode)){
			paramMap.put("vcProductCode", vcProductCode);
		}
		if(StringUtils.isNotBlank(vcProductName)){
			paramMap.put("vcProductName", vcProductName);
		}
		if(StringUtils.isNotBlank(lAssetId)){
			paramMap.put("lAssetId", lAssetId);
		}
		if(StringUtils.isNotBlank(vcAssetNo)){
			paramMap.put("vcAssetNo", vcAssetNo);
		}
		if(StringUtils.isNotBlank(vcAssetName)){
			paramMap.put("vcAssetName", vcAssetName);
		}
		if(StringUtils.isNotBlank(lCombiId)){
			paramMap.put("lCombiId", lCombiId);
		}
		if(StringUtils.isNotBlank(vcCombiNo)){
			paramMap.put("vcCombiNo", vcCombiNo);
		}
		if(StringUtils.isNotBlank(vcCombiName)){
			paramMap.put("vcCombiName", vcCombiName);
		}
		
		List<TCombi> result = new ArrayList<TCombi>();
		Object[] objArr = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, "com.cjhxfund.commonUtil.productCombiRightUtil.getCombiListCommonSQL", paramMap);
		if(objArr!=null && objArr.length>0){
			for(int i=0; i<objArr.length; i++){
				result.add((TCombi) objArr[i]);
			}
		}
		paramMap.clear();
		paramMap = null;
		return result;
	}
	
	/**
	 * 【公共调用方法】获取产品组合与处理人员权限关系列表(去重复后记录)
	 * @param vcRelateType 权限关系类型
	 * @param vcUserId 用户ID，如：huangmizhi
	 * @param vcUserName 用户名称，如：黄秘志
	 * @param lProductId 产品序号，如：1001
	 * @param vcProductCode 产品代码，如：001199
	 * @param vcProductName 产品名称，如：创金合信聚利债券（工行）
	 * @param lAssetId 资产单元序号，如：6
	 * @param vcAssetNo 资产单元代码（编号），如：20010001
	 * @param vcAssetName 资产单元名称，如：瑞祥1号单元
	 * @param lCombiId 组合序号，如：4
	 * @param vcCombiNo 组合代码（编号），如：2001_000
	 * @param vcCombiName 组合名称，如：缺省组合
	 * @return
	 * @author huangmizhi
	 */
	@Bizlet("")
	private static List<TProductHandle> getRightListCommon(String vcRelateType, String vcUserId, String vcUserName, String lProductId, String vcProductCode, String vcProductName, String lAssetId, String vcAssetNo, String vcAssetName, String lCombiId, String vcCombiNo, String vcCombiName, String sql){
		Map<String,String> paramMap = new HashMap<String,String>();
		if(StringUtils.isNotBlank(vcRelateType)){
			paramMap.put("vcRelateType", vcRelateType);
		}
		if(StringUtils.isNotBlank(vcUserId)){
			paramMap.put("vcUserId", vcUserId);
		}		
		if(StringUtils.isNotBlank(vcUserName)){
			paramMap.put("vcUserName", vcUserName);
		}
		if(StringUtils.isNotBlank(lProductId)){
			paramMap.put("lProductId", lProductId);
		}
		if(StringUtils.isNotBlank(vcProductCode)){
			paramMap.put("vcProductCode", vcProductCode);
		}
		if(StringUtils.isNotBlank(vcProductName)){
			paramMap.put("vcProductName", vcProductName);
		}
		if(StringUtils.isNotBlank(lAssetId)){
			paramMap.put("lAssetId", lAssetId);
		}
		if(StringUtils.isNotBlank(vcAssetNo)){
			paramMap.put("vcAssetNo", vcAssetNo);
		}
		if(StringUtils.isNotBlank(vcAssetName)){
			paramMap.put("vcAssetName", vcAssetName);
		}
		if(StringUtils.isNotBlank(lCombiId)){
			paramMap.put("lCombiId", lCombiId);
		}
		if(StringUtils.isNotBlank(vcCombiNo)){
			paramMap.put("vcCombiNo", vcCombiNo);
		}
		if(StringUtils.isNotBlank(vcCombiName)){
			paramMap.put("vcCombiName", vcCombiName);
		}
		
		List<TProductHandle> result = new ArrayList<TProductHandle>();
		Object[] objArr = DatabaseExt.queryByNamedSql(JDBCUtil.DATA_SOURCE_DEFAULT, sql, paramMap);
		if(objArr!=null && objArr.length>0){
			for(int i=0; i<objArr.length; i++){
				result.add((TProductHandle) objArr[i]);
			}
		}
		paramMap.clear();
		paramMap = null;
		return result;
	}
	
	/**
	 * 【公共调用方法】判断某用户是否是指定产品的投资经理
	 * @param productId 产品编号
	 * @param userId 用户编号
	 * @return 是否投资经理布尔值
	 * @author chengbichao
	 */
	@Bizlet("判断某用户是否是指定产品的投资经理")
	public static boolean isInvestManager(String productID, String userID){
		List<TProductHandle> list = ProductCombiRightUtil.getProductHandleByRelateTypeAndProductCodeList("02", productID);
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				if(list.get(i).getVcUserId().equals(userID)){
					return true;
				}
			}
		}
		return false;
	}
	
	//*****************【公共调用方法】 end!!!*****************//
	
	public static void main(String[] args) {
	}
}
