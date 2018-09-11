package com.cjhxfund.ats.sm.comm;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.cjhxfund.commonUtil.ProductCombiRightUtil;
import com.cjhxfund.commonUtil.model.TProductHandle;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;

import commonj.sdo.DataObject;

/**
 * 
 * @author houzhiyong
 * 参与者规则方法，主要用于流程环节参与者的自动生成
 *
 */
public class ParticipantRule {
	
	/**
	 * adviser 是否有投顾复核人
	 * risk 是否有投顾风控复核人
	 * entrust 是否有委托人复核
	 * 
	 * 投顾复核阶段的参与者（包括投顾复核人，投顾委托人，风控复核人）
	 * @param productID 产品code
	 * @param type 类型
	 * @return
	 * @throws Exception
	 */
	public List<WFParticipant> investAdviserParticipant(String createUserID,String productID, String vcCombiCode,String type)throws Exception{
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		boolean flag=false;
		String userID=null;
		String creator=null;
		if(createUserID!=null && !"".equals(createUserID)){
			DataObject criteriaType=DataObjectUtil.createDataObject("com.primeton.das.criteria.criteriaType");
			criteriaType.set("_entity", "com.cjhxfund.commonUtil.dataBase.OrgEmployee");
			criteriaType.set("_expr[1]/empid", createUserID);
			criteriaType.set("_expr[1]/_op", "=");
			DataObject[] capUsers=DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaType);
			creator=capUsers[0].getString("userid");
		}else{
			throw new Exception("流程创建者，入参为空");
		}
		if("adviser".equals(type)){
			userID=ProductCombiRightUtil.getInvestAdviserConfirmUserIds(creator,productID,vcCombiCode);
		}
		if("risk".equals(type)){
			userID=ProductCombiRightUtil.getInvestAdviserRiskCtrlConfirmUserIds(null,productID,vcCombiCode);
		}
		if("entrust".equals(type)){
			userID=ProductCombiRightUtil.getEntrustConfirmUserIds(null,productID,vcCombiCode);
		}
		if(userID==null ||"".equals(userID)){
			flag=false;
		}else if(ProductCombiRightUtil.NO_PERSON.equals(userID)){
			flag=false;
		}else if(ProductCombiRightUtil.NO_PERMISSION.equals(userID)){
			flag=false;
		}else if(ProductCombiRightUtil.HAS_SET_PERSON_BUT_NO_PERMISSION.equals(userID)){
			flag=false;
		}else{
			flag=true;
		}
		if(flag){
			DataObject criteriaType=DataObjectUtil.createDataObject("com.primeton.das.criteria.criteriaType");
			criteriaType.set("_entity", "com.cjhxfund.commonUtil.dataBase.OrgEmployee");
			criteriaType.set("_expr[1]/userid", userID);
			criteriaType.set("_expr[1]/_op", "in");
			DataObject[] capUsers=DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaType);
			if(capUsers!=null && capUsers.length>0){
				for(int i=0;i<capUsers.length;i++){
					WFParticipant part=new WFParticipant();
					part.setId(capUsers[i].getString("empid"));
					part.setName(capUsers[i].getString("empname"));
					part.setTypeCode("emp");
					partList.add(part);
				}
			}
		}
		return  partList;
	}
	
	/**
	 * 设置审批人
	 * 1.如果锁定记录来自1（买断式回购），当前申请解锁用户为交易员审批人为投顾，当前审批人为投顾审批人为交易员，如果当前用户是投顾和交易员都有权限则取交易员权限；
	 * 2.如果锁定记录来自3（预置指令），当前申请解锁用户为交易员时，审批人为投资经理（权限02）；申请解锁是投顾时，审批人为交易员；
	 * @param productID	产品编号
	 * @param applyUserID	申请解锁用户
	 * @param lockSource	锁定来源
	 * @return
	 * @author tongwei
	 */
	public List<WFParticipant> getTraderParticipant(String productID,String applyUserID,String lockSource){
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		String relateType=null;
		String userID=null;
		DataObject criteriaType=DataObjectUtil.createDataObject("com.primeton.das.criteria.criteriaType");
		criteriaType.set("_entity", "com.cjhxfund.commonUtil.dataBase.OrgEmployee");
		//获取当前申请人用户的产品权限对象
		List<TProductHandle> productHandle=ProductCombiRightUtil.getProductHandleByUserIdList(applyUserID);
		if(productHandle!=null && productHandle.size()>0){
			for(int i=0;i<productHandle.size();i++){
				relateType=productHandle.get(i).getVcRelateType();
				// 根据锁定来源设置审批人（1.买断式回购，3.预置指令）
				if("1".equals(lockSource)){
					//01表示当前提前解锁申请人是投顾
					if("01".equals(relateType)){
						userID=ProductCombiRightUtil.getUserIdsByRelateTypeAndProductCode("04",productID);
					}
					//04表示当前提前解锁申请人是交易员
					if("04".equals(relateType)){
						userID=ProductCombiRightUtil.getUserIdsByRelateTypeAndProductCode("01",productID);
						break;
					}
				}
				if("3".equals(lockSource)){
					// 如果申请解锁用户是投顾01，审批人为交易员04
					if("01".equals(relateType)){
						userID=ProductCombiRightUtil.getUserIdsByRelateTypeAndProductCode("04",productID);
					}
					// 如果申请解锁用户是交易员04，审批人为投资经理02
					if("04".equals(relateType)){
						userID=ProductCombiRightUtil.getUserIdsByRelateTypeAndProductCode("02",productID);
						break;
					}
				}
				
			}
		}
		//查询出来的人员不为空时，组装流程参与者对象设置到流程环节上
		if(userID!=null && !"NoPermission".equals(userID)){
			criteriaType.set("_expr[1]/userid", userID);
			criteriaType.set("_expr[1]/_op", "in");
			//由于通过产品权限接口查询出来的是userID字符串，需要再通过字符串查询用户对应的OperatorID(是数字类型)
			DataObject[] capUsers=DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaType);
			if(capUsers!=null && capUsers.length>0){
				for(int j=0;j<capUsers.length;j++){
					WFParticipant part=new WFParticipant();
					part.setId(capUsers[j].getString("empid"));
					part.setName(capUsers[j].getString("empname"));
					part.setTypeCode("emp");
					partList.add(part);
				}
			}
		}
		
		return  partList;
	}

	
	/**
	 * 获取产品投资经理确认人
	 * @param productID 产品code
	 * @return
	 */
	@Bizlet("获取投资经理参与者")
	public static List<WFParticipant> investManagerParticipant(String productID){
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		String userID = "";
		List<TProductHandle> list = ProductCombiRightUtil.getProductHandleByRelateTypeAndProductCodeList("02", productID);
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				if(i==0){
					userID += list.get(i).getVcUserId();
				}else{
					userID += ","+list.get(i).getVcUserId();
				}
			}
		}
		if(userID!=null && !"".equals(userID)){
			DataObject criteriaType=DataObjectUtil.createDataObject("com.primeton.das.criteria.criteriaType");
			criteriaType.set("_entity", "com.cjhxfund.commonUtil.dataBase.OrgEmployee");
			criteriaType.set("_expr[1]/userid", userID);
			criteriaType.set("_expr[1]/_op", "in");
			DataObject[] capUsers=DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaType);
			if(capUsers!=null && capUsers.length>0){
				for(int i=0;i<capUsers.length;i++){
					WFParticipant part=new WFParticipant();
					part.setId(capUsers[i].getString("empid"));
					part.setAttribute("vcUserId", capUsers[i].getString("empcode"));
					part.setName(capUsers[i].getString("empname"));
					part.setTypeCode("emp");
					partList.add(part);
				}
			}
		}
		return  partList;
	}
	
	/**
	 * 获取询价录入人
	 * @param productID
	 * @return
	 */
	@Bizlet("获取询价录入人")
	public static List<WFParticipant> inquiryInputParticipant(String productID){
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		String userID = "";
		List<TProductHandle> list = ProductCombiRightUtil.getProductHandleByRelateTypeAndProductCodeList("03", productID);
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				if(i==0){
					userID += list.get(i).getVcUserId();
				}else{
					userID += ","+list.get(i).getVcUserId();
				}
			}
		}
		if(userID!=null && !"".equals(userID)){
			DataObject criteriaType=DataObjectUtil.createDataObject("com.primeton.das.criteria.criteriaType");
			criteriaType.set("_entity", "com.cjhxfund.commonUtil.dataBase.OrgEmployee");
			criteriaType.set("_expr[1]/userid", userID);
			criteriaType.set("_expr[1]/_op", "in");
			DataObject[] capUsers=DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaType);
			if(capUsers!=null && capUsers.length>0){
				for(int i=0;i<capUsers.length;i++){
					WFParticipant part=new WFParticipant();
					part.setId(capUsers[i].getString("empid"));
					part.setAttribute("vcUserId", capUsers[i].getString("empcode"));
					part.setName(capUsers[i].getString("empname"));
					part.setTypeCode("emp");
					partList.add(part);
				}
			}
		}
		return  partList;
	}
	
	public static void main(String[] args) throws ParseException {
		System.out.println(investManagerParticipant("CJ0017"));
	}
}
