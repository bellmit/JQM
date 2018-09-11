package com.cjhxfund.ats.ipo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cjhxfund.commonUtil.ProductCombiRightUtil;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.spring.support.DataObjectUtil;

import commonj.sdo.DataObject;

@Bizlet("参与者规则操作类")
public class ParticipantRule {

	@Bizlet("获取投顾参与者规则")
	public static List<WFParticipant> getInvestmentAdviser(DataObject[] rationDatas,String relateType){
		String [] prodCode=null;
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		//查询配售对象对应的产品CODE
		if(rationDatas!=null && rationDatas.length>0){
			prodCode=new String[rationDatas.length];
			for(int i=0;i<rationDatas.length;i++){
				prodCode[i]=rationDatas[i].getString("prodCode");
			}
		}
		
		StringBuffer sb = new StringBuffer();
		if(prodCode!=null && prodCode.length>0){
			for(int i=0;i<prodCode.length;i++){
				if(prodCode[i]!=null && prodCode[i].trim()!=null && !"".equals(prodCode[i].trim())){
					//根据产品CODE查询对应的用户
					String userId=ProductCombiRightUtil.getUserIdsByRelateTypeAndProductCode(relateType, prodCode[i]);
					if(userId!=null && !"".equals(userId) && !"NoPermission".equals(userId)){
						sb = sb.append(userId.trim()).append(",");
					}
				}
			}
			//针对所查询出来的用户ID，在组织机构投顾分组中，查询empid   【人员过滤投顾，2017-12-11 修改】
			DataObject criteriaType=DataObjectUtil.createDataObject("com.primeton.das.criteria.criteriaType");
			if(relateType.equals("01")){//仅在投顾节点有效
				criteriaType.set("_entity", "com.cjhxfund.ats.ipo.ipoDataset.QueryOrgCounsellorEmp");
			}else{
				criteriaType.set("_entity", "com.cjhxfund.commonUtil.dataBase.OrgEmployee");
			}
			
			criteriaType.set("_expr[1]/userid", sb.toString());
			criteriaType.set("_expr[1]/_op", "in");
			DataObject[] capUsers=DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaType);
			if(capUsers!=null && capUsers.length>0){
				for(int j=0;j<capUsers.length;j++){
					//将查询出来的用户信息添加到参与者List中
					WFParticipant part=new WFParticipant();
					part.setId(capUsers[j].getString("empid"));
					part.setName(capUsers[j].getString("empname"));
					part.setTypeCode("emp");
					partList.add(part);
				}
			}
			
		}
		return partList;
	}
	
	
	@Bizlet("获取流程描述中配置的投资类型")
	public static String getActivityInstDesc(String activityDesc){
		String rationType=null;
		String[] rationTypes=null;
		if(activityDesc!=null && !"".equals(activityDesc)){
			rationTypes=activityDesc.split(":");
			if(rationTypes!=null && rationTypes.length>1){
				rationType=rationTypes[1];
			}
		}
		return rationType;
	}
	
	@Bizlet("获取流程描述中配置的投资类型")
	public static Map<String,String> getActInstDesc(String activityDesc){
		Map<String,String> configMap=new HashMap<String,String>();
		String[] coupleBiz=null;
		if(activityDesc!=null && !"".equals(activityDesc)){
			coupleBiz=activityDesc.split("\\|");
			if(coupleBiz!=null && coupleBiz.length>0){
				for(int i=0;i<coupleBiz.length;i++){
					String[] keyValue=coupleBiz[i].split("=");
					if(keyValue!=null && keyValue.length==2){
						configMap.put(keyValue[0], keyValue[1]);
					}
				}
			}
		}
		return configMap;
	}
	
	@Bizlet("设置配置的角色参与者")
	public static List<WFParticipant> getParticipantRole(DataObject capRole){
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		if(capRole!=null){
			WFParticipant pt=new WFParticipant();
			pt.setId(capRole.getString("roleId"));
			pt.setName(capRole.getString("roleName"));
			//注：角色的类型CODE是role是固定不变
			pt.setTypeCode("role");
			partList.add(pt);
		}
		return partList;
	}
	
	
	@Bizlet("设置配置的交易总监参与者")
	public static List<WFParticipant> getParts(DataObject[] partData){
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		if(partData!=null && partData.length>0){
			for(int i=0;i<partData.length;i++){
				WFParticipant pt=new WFParticipant();
				pt.setId(partData[i].getString("empId"));
				pt.setName(partData[i].getString("empName"));
				//注：角色的类型CODE是role是固定不变
				pt.setTypeCode("emp");
				partList.add(pt);
			}
		}
		return partList;
	}
	
	
	
	/**
	 * 用户选择对应的研究员数组
	 * @param users 页面选择的用户信息
	 * @return 参与者List对象供流程使用
	 */
	@Bizlet("研究员设置的参与者")
	public static List<WFParticipant> searcherParticipant(DataObject[] users){
		List<WFParticipant> partList=new ArrayList<WFParticipant>();
		if(users!=null && users.length>0){
			for(int i=0;i<users.length;i++){
				if(users[i].getString("empId")!=null && !"".equals(users[i].getString("empId"))){
					WFParticipant pt=new WFParticipant();
					pt.setId(users[i].getString("empId"));
					pt.setName(users[i].getString("empName"));
					pt.setTypeCode("emp");
					partList.add(pt);
				}
			}
		}
		return partList;
	}
	
	@Bizlet("获取已选择的研究员")
	public static String getSearcher(List<WFParticipant> partList){
		String searcherName=null;
		StringBuffer searcherBuffer=new StringBuffer();
		if(partList!=null && partList.size()>0){
			for(int i=0;i<partList.size();i++){
				if(i==partList.size()-1){
					searcherBuffer.append(partList.get(i).getName());
				}else{
					searcherBuffer.append(partList.get(i).getName()+",");
				}
			}
			searcherName=searcherBuffer.toString();
		}
		return searcherName;
	}
	/**
	 * 组装投顾参与 的产品信息
	 * @param InstructProducts
	 * @return
	 */
	@Bizlet("组装投顾参与 的产品信息")
	public static String getUserJoinProdInfo(DataObject[] InstructProducts){
		String prodStr= "该投顾参与产品：";
		//拼装产品代码和名称
		for (int i = 0; i < InstructProducts.length; i++) {
			prodStr+="[ "+InstructProducts[i].getString("vcRationProductName")+"]";
			if(i<InstructProducts.length-1){
				prodStr+=",";
			}
		}
		if(InstructProducts.length<1){
			prodStr="该投顾没有参与!";
		}
		
		return prodStr;
	}
	
//	public static void main(String[] args) {
//		Integer i1=new Integer(1);
//		Integer i2=new Integer(1);
//		Set testSet=new HashSet();
//		testSet.add(i1);
//		testSet.add(i2);
//		for(Iterator it=testSet.iterator();it.hasNext();){
//			System.out.println(it.next());
//		}
//	}
}
