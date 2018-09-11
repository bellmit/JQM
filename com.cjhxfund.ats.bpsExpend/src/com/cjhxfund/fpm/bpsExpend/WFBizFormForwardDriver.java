package com.cjhxfund.fpm.bpsExpend;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.eos.system.utility.XmlUtil;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IBPSServiceClient;
import com.eos.workflow.api.IWFDefinitionQueryManager;
import com.eos.workflow.api.IWFWorkItemManager;
import com.eos.workflow.data.WFWorkItem;
import com.primeton.workflow.api.WFServiceException;
import com.primeton.workflow.commons.utility.XML;
import com.primeton.workflow.commons.utility.XMLException;

public class WFBizFormForwardDriver implements IWFBizFormForwardDriver {
	
	private static final String ISFORWARD_BIZ = "IsForWardBiz";
	private static final String URL = "/bizform/bizformFramework.jsp";
	
	
	public boolean isForwardBizFormClient(long workItemID) throws WFServiceException{

		IBPSServiceClient client;
		client = BPSServiceClientFactory.getDefaultClient();

		IWFWorkItemManager workItemManager = client.getWorkItemManager();
		IWFDefinitionQueryManager definitionQueryManager = client
				.getDefinitionQueryManager();

		WFWorkItem workItem = workItemManager.queryWorkItemDetail(workItemID);
		String xmlProcExt = definitionQueryManager.getExtendAttribute(
				workItem.getProcessDefID(), null);

		boolean isForWard = false;

		Document srcDom;
		try {
			srcDom = XML.parseString(xmlProcExt);
			Element extendNodesEl = srcDom.getDocumentElement();
			NodeList keyNodeList = XmlUtil.findNodes(extendNodesEl,
					"extendNode/key");
			Node keyNode = null;
			for (int i = 0; i < keyNodeList.getLength(); i++) {
				String keyNodeText = XmlUtil.getTextValue(keyNodeList.item(i));
				if (keyNodeText.equals(ISFORWARD_BIZ)) {
					keyNode = keyNodeList.item(i);
				}
			}

			Node valueNode = null;
			String valueNodeText = null;
			if (keyNode != null) {
				Element extendNodeEl = (Element) keyNode.getParentNode();
				valueNode = XmlUtil.findNode(extendNodeEl, "value");
				valueNodeText = XmlUtil.getTextValue(valueNode);
			}
			if (keyNode != null && valueNodeText.equals("true")) {
				isForWard = true;
			}

		} catch (XMLException e) {
			e.printStackTrace();
		}
		return isForWard;
	}
	
	public  String queryURL4BizFormClient(){	
		return URL;
	}

}
