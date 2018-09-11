/**
 * 
 */
package com.cjhxfund.jy.momReport;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.gocom.components.coframe.org.dataset.OrgEmployee;
import org.gocom.components.coframe.org.dataset.OrgOrganization;
import org.gocom.components.coframe.org.dataset.OrgPosition;
import org.gocom.components.coframe.org.dataset.OrgTreeNode;
import org.gocom.components.coframe.org.util.IOrgConstants;
import org.gocom.components.coframe.org.util.OrgTreeNodeConvertor;
import org.gocom.components.coframe.tools.IconCls;

import com.eos.system.annotation.Bizlet;
import com.primeton.cap.party.Party;

import commonj.sdo.DataObject;

/**
 * @author 杨敏
 * @date 2017-05-16 11:14:53
 *
 */
@Bizlet("")
public class ProductTreeNodeHelper {
	/**
	 * @param orgPartyList
	 * @return
	 */
	@Bizlet("组装参数")
	public static DataObject[] buildTreeNodes(DataObject[] prodTrees) {
		
		List<DataObject> results = new ArrayList<DataObject>();
		
		for(DataObject prodTree : prodTrees) {
			//ProdTree node = ProdTree.FACTORY.create();
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsProductTree");
			node.setString("nodeId",prodTree.getString("lProductId"));
			node.set("nodeType","ProductTree");
			node.set("nodeName",prodTree.getString("vcProductCode")+" | "+prodTree.getString("vcProductName"));
			node.set("iconCls","icon-orgalias");
			
			node.set("lProductId", prodTree.getString("lProductId"));
			node.set("vcProductName", prodTree.getString("vcProductName"));
			node.set("isLeaf", false);
			node.set("expanded", false);
			results.add(node);
		}
		
		
		return results.toArray(new DataObject[results.size()]);
	}
	@Bizlet("组装下级参数")
	public static DataObject[] buildNextTreeNodes(DataObject[] prodTrees,DataObject[] prodTreesAll) {
		List<DataObject> results = new ArrayList<DataObject>();
		for(DataObject prodTree : prodTrees) {
			
			DataObject node =  com.eos.foundation.data.DataObjectUtil.createDataObject("com.cjhxfund.jy.ProductProcess.singleDataset.TAtsProductTree");
			node.setString("nodeId",prodTree.getString("lProductId"));
			node.set("nodeType","ProductTree");
			node.set("nodeName",prodTree.getString("vcProductCode")+" | "+prodTree.getString("vcProductName"));
			node.set("iconCls","icon-orgalias");
			
			node.set("lProductId", prodTree.getString("lProductId"));
			node.set("vcProductName", prodTree.getString("vcProductName"));
			node.set("lParentId", prodTree.getString("lParentId"));
			node.set("vcProductCode", prodTree.getString("vcProductCode"));
			int cunt = 0;
			for(DataObject nodeAll : prodTreesAll) {
				if(nodeAll.getString("vcProdseq").indexOf("."+prodTree.getString("lProductId")+".")!=-1){
					cunt++;
				}
			}
			if(cunt>1){
				node.set("isLeaf", false);
			}else{
				node.set("isLeaf", true);
			}
			node.set("expanded", false);
			results.add(node);
		}
		
		
		return results.toArray(new DataObject[results.size()]);
	}

}
