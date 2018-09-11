/**
 * 
 */
package com.cjhxfund.jy.ProductProcess;

import java.util.ArrayList;
import java.util.List;

import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

/**
 * @author 杨敏
 * @date 2017-06-16 10:28:17
 *
 */
@Bizlet("")
public class O32tcjt {
	
	/**
	 * 组装标签
	 * @param orgPartyList
	 * @return
	 */
	@Bizlet("组装顶级标签")
	public static DataObject[] labelTreeNodes(DataObject[] groupTrees,DataObject[] all) {
		
		List<DataObject> results = new ArrayList<DataObject>();
		
		for(DataObject group : groupTrees) {
			//ProdTree node = ProdTree.FACTORY.create();
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsLabelTree");
			node.setString("nodeId",group.getString("lLabelId"));
			node.set("nodeType","topMenu");
			node.set("nodeName",group.getString("vcLabelName"));
			node.set("iconCls","icon-orgalias");
			
			node.set("lLabelId", group.getString("lLabelId"));
			node.set("lParentId", group.getString("lParentId"));
			node.set("vcLabelSeq", group.getString("vcLabelSeq"));
			node.set("vcLabelName", group.getString("vcLabelName"));
			
			boolean isLeaf=true;
			//判断当前节点是否存在子节点
			for(DataObject group1 : all){
				if(group1.getString("lParentId").equals(group.getString("lLabelId"))){
					isLeaf=false;
					break;
				}
			}
			node.set("isLeaf",isLeaf);
			node.set("expanded", false);
			results.add(node);
		}
		
		return results.toArray(new DataObject[results.size()]);
	}
	/**
	 * 
	 * @param groupTrees
	 * @return
	 */
	@Bizlet("组装下级标签")
	public static DataObject[] labelNextTreeNodes(DataObject[] groupTrees,DataObject[] all) {
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject group : groupTrees) {
			
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsLabelTree");
			node.setString("nodeId",group.getString("lLabelId"));
			node.set("nodeType","labelTree");
			node.set("nodeName",group.getString("vcLabelName"));
			node.set("iconCls","icon-orgalias");
			
			node.set("lLabelId", group.getString("lLabelId"));
			node.set("lParentId", group.getString("lParentId"));
			node.set("vcLabelSeq", group.getString("vcLabelSeq"));
			node.set("vcLabelName", group.getString("vcLabelName"));
			
			boolean isLeaf=true;
			//判断当前节点是否存在子节点
			for(DataObject group1 : all){
				if(group1.getString("lParentId").equals(group.getString("lLabelId"))){
					isLeaf=false;
					break;
				}
			}
			node.set("isLeaf",isLeaf);
			node.set("expanded", true);
			results.add(node);
		}
		return results.toArray(new DataObject[results.size()]);
	}
	/**
	 * @param orgPartyList
	 * @return
	 */
	@Bizlet("组装顶级分组")
	public static DataObject[] buildTreeNodes(DataObject[] groupTrees,DataObject[] all) {
		
		List<DataObject> results = new ArrayList<DataObject>();
		
		for(DataObject group : groupTrees) {
			//ProdTree node = ProdTree.FACTORY.create();
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsUserGroup");
			node.setString("nodeId",group.getString("lGroupId"));
			node.set("nodeType","groupTree");
			node.set("nodeName",group.getString("vcGroupName"));
			node.set("iconCls","icon-orgalias");
			
			node.set("lGroupId", group.getString("lGroupId"));
			node.set("lParentId", group.getString("lParentId"));
			node.set("vcGroupSeq", group.getString("vcGroupSeq"));
			node.set("vcGroupName", group.getString("vcGroupName"));
			
			boolean isLeaf=true;
			//判断当前节点是否存在子节点
			for(DataObject group1 : all){
				if(group1.getString("lParentId").equals(group.getString("lGroupId"))){
					isLeaf=false;
					break;
				}
			}
			node.set("isLeaf",isLeaf);
			node.set("expanded", false);
			results.add(node);
		}
		
		
		return results.toArray(new DataObject[results.size()]);
	}
	@Bizlet("组装下级分组")
	public static DataObject[] buildNextTreeNodes(DataObject[] groupTrees,DataObject[] all) {
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject group : groupTrees) {
			
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsUserGroup");
			node.setString("nodeId",group.getString("lGroupId"));
			node.set("nodeType","groupTree");
			node.set("nodeName",group.getString("vcGroupName"));
			node.set("iconCls","icon-orgalias");
			
			node.set("lGroupId", group.getString("lGroupId"));
			node.set("lParentId", group.getString("lParentId"));
			node.set("vcGroupSeq", group.getString("vcGroupSeq"));
			node.set("vcGroupName", group.getString("vcGroupName"));
			
			boolean isLeaf=true;
			//判断当前节点是否存在子节点
			for(DataObject group1 : all){
				if(group1.getString("lParentId").equals(group.getString("lGroupId"))){
					isLeaf=false;
					break;
				}
			}
			node.set("isLeaf",isLeaf);
			node.set("expanded", false);
			results.add(node);
		}
		
		
		return results.toArray(new DataObject[results.size()]);
	}
	@Bizlet("组装用户产品分组数据")
	public static DataObject[] getAssetGroupList(DataObject[] objs,String lGroupId){
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject group : objs) {
			
			DataObject userGroup =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsAssetGroup");
			com.eos.foundation.database.DatabaseExt.getPrimaryKey(userGroup);
			userGroup.setString("lGroupId", lGroupId);
			userGroup.setString("vcProductId", group.getString("lProductId"));
			userGroup.setString("vcAssetId", group.getString("lAssetId"));
			
			results.add(userGroup);
		}
		
		return results.toArray(new DataObject[results.size()]);
	}
	@Bizlet("组装标注数据")
	public static DataObject[] getAssetLabelList(DataObject[] objs,String lLabelId){
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject group : objs) {
			
			DataObject label =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsAssetLabel");
			com.eos.foundation.database.DatabaseExt.getPrimaryKey(label);
			label.setString("lLabelId", lLabelId);
			label.setString("vcProductId", group.getString("lProductId"));
			label.setString("vcAssetId", group.getString("lAssetId"));
			
			results.add(label);
		}
		
		return results.toArray(new DataObject[results.size()]);
	}
	@Bizlet("校验是否为同一个类型")
	public static boolean checkEq(String treeSeq1,String treeSeq2){
		boolean f=false;
		if(treeSeq1.indexOf(".1.")>=0 && treeSeq2.indexOf(".1.")>=0){
			f=true;
		}else if(treeSeq1.indexOf(".2.")>=0 && treeSeq2.indexOf(".2.")>=0){
			f=true;
		}
		return f;
	}
	/**
	 * 组装分组树-下拉列表使用
	 * @param objs
	 * @return
	 */
	@Bizlet("组装分组树")
	public static DataObject[] getUserGroupList(DataObject[] objs,DataObject[] assetAll,String key){
		
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject group : objs) {
			
			//过滤查询条件
			if((!"".equals(key)) && key!=null && group.getString("vcGroupName").indexOf(key)<0){
				continue;
			}
			
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsUserGroup");
			node.setString("id",group.getString("lGroupId"));
			node.set("text",group.getString("vcGroupName"));
			node.set("pid",group.getString("lParentId"));
			boolean isLeaf=true;
			//判断当前节点是否存在子节点
			for(DataObject group1 : objs){
				if(group1.getString("lParentId").equals(group.getString("lGroupId"))){
					isLeaf=false;
					break;
				}
			}
			if(isLeaf==false){
				continue;
			}
			node.set("isLeaf",isLeaf);
			node.set("lGroupId", group.getString("lGroupId"));
			node.set("lParentId", group.getString("lParentId"));
			node.set("vcGroupSeq", group.getString("vcGroupSeq"));
			node.set("vcGroupName", group.getString("vcGroupName"));
			
			String vcProductIdS="";
			String vcAssetIdS="";
			//组装产品和资产单元属性
			for(DataObject group2 : assetAll){
				if(group.getString("lGroupId").equals(group2.getString("lGroupId"))){
					vcProductIdS+=(vcProductIdS==""?"":",")+group2.getString("vcProductId");
					vcAssetIdS+=(vcAssetIdS==""?"":",")+group2.getString("vcAssetId");
				}
			}
			node.set("vcProductIdS",vcProductIdS);
			node.set("vcAssetIdS",vcAssetIdS);
			
			results.add(node);
		}
		/*加入其他选项*/
		DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsUserGroup");
		node.setString("id","-2");
		node.set("text","其他");
		node.set("isLeaf",true);
		node.set("vcGroupSeq", ".-2.");
		results.add(node);
		
		return results.toArray(new DataObject[results.size()]);
	}
	/**
	 * 组装标签树--下拉列表使用
	 * @param objs 查询的数据
	 * @param assetAll 产品数据
	 * @param toplLabelId 顶级节点
	 * @return
	 */
	@Bizlet("组装标签树")
	public static DataObject[] getLabelList(DataObject[] objs,DataObject[] assetAll,String toplLabelId,String key) {
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject group : objs) {
			//过滤非 toplLabelId下的数据
			if((!"".equals(toplLabelId)) && group.getString("vcLabelSeq").indexOf("."+toplLabelId+".")<0){
				continue;
			}
			//过滤查询条件
			if((!"".equals(key)) && key!=null && group.getString("vcLabelName").indexOf(key)<0){
				continue;
			}
			
			
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsLabelTree");
			node.setString("id",group.getString("lLabelId"));
			node.set("text",group.getString("vcLabelName"));
			node.set("pid",group.getString("lParentId"));
			
			node.set("lLabelId", group.getString("lLabelId"));
			node.set("lParentId", group.getString("lParentId"));
			node.set("vcLabelSeq", group.getString("vcLabelSeq"));
			node.set("vcLabelName", group.getString("vcLabelName"));
			
			boolean isLeaf=true;
			//判断当前节点是否存在子节点
			for(DataObject group1 : objs){
				if(group1.getString("lParentId").equals(group.getString("lLabelId"))){
					isLeaf=false;
					break;
				}
			}
			//顶级节点一定是父节点
			if("-1".equals(group.getString("lParentId")) || "".equals(group.getString("lParentId"))){
				isLeaf=false;
			}
			
			if(isLeaf==false){
				continue;
			}
			node.set("isLeaf",isLeaf);
			
			String vcProductIdS="";
			String vcAssetIdS="";
			//组装产品和资产单元属性
			for(DataObject group2 : assetAll){
				if(group.getString("lLabelId").equals(group2.getString("lLabelId"))){
					vcProductIdS+=(vcProductIdS==""?"":",")+group2.getString("vcProductId");
					vcAssetIdS+=(vcAssetIdS==""?"":",")+group2.getString("vcAssetId");
				}
			}
			node.set("vcProductIdS",vcProductIdS);
			node.set("vcAssetIdS",vcAssetIdS);
			results.add(node);
		}
		DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsLabelTree");
		node.setString("id","-2");
		node.set("text","其他");
		node.set("isLeaf",true);
		node.set("vcLabelSeq",".-2.");
		results.add(node);
		return results.toArray(new DataObject[results.size()]);
	}
	
}
