package com.cjhxfund.fpm.bpsExpend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.eos.das.entity.criteria.CriteriaType;
import com.eos.das.entity.criteria.ExprType;
import com.eos.das.entity.criteria.OrderbyType;
import com.eos.das.entity.criteria.impl.CriteriaTypeImpl;
import com.eos.das.entity.criteria.impl.ExprTypeImpl;
import com.eos.das.entity.criteria.impl.OrderbyTypeImpl;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.foundation.database.DatabaseExt;
import com.eos.foundation.database.DatabaseUtil;
import com.eos.system.annotation.Bizlet;
import commonj.sdo.DataObject;

@Bizlet("ProcessStructure")
public class ProcessStructure {
	
	@SuppressWarnings("unchecked")
	@Bizlet("获取流程结构")
	public ProcessTree getProcessStructure(String processDefId,String processInstId) throws DocumentException{
		ProcessTree pt = null;
		Map<String,ProcessTreeNode> actiIds = new HashMap<String,ProcessTreeNode>();
		Map<String,List<String>> actiInfos = new HashMap<String,List<String>>();
		DataObject defDataObj = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.Wfprocessdefine");
		defDataObj.setLong("processdefid", Integer.parseInt(processDefId));
		DatabaseUtil.expandEntity("default", defDataObj);
		String defXml = defDataObj.getString("processdefcontent");
		if(defXml!=null){
			Document document = DocumentHelper.parseText(defXml);
			Element rootElement = document.getRootElement();
			
			Element activities = rootElement.element("activities");
			List<Element> activity = activities.elements("activity");
			for (Element element : activity) {
				List<String> list = new ArrayList<String>();
				String activityId = element.element("activityId").getText();
				String activityName = element.element("activityName").getText();
				String y = element.element("nodeGraphInfo").element("x").getText();
				list.add(activityName);
				list.add(y);
				actiInfos.put(activityId, list);
			}
			
			Element transitions = rootElement.element("transitions");
			List<Element> transition = transitions.elements("transition");
			for (Element element : transition) {
				String from = element.element("from").getText();
				String to = element.element("to").getText();
				ProcessTreeNode prevNode = null;
				ProcessTreeNode nextNode = null;
				if(actiIds.containsKey(from)){
					prevNode = actiIds.get(from);
				}
				else{
					prevNode = new ProcessTreeNode(from);
					prevNode.setActivityInstName(actiInfos.get(from).get(0));
					prevNode.setLocationY(Integer.parseInt(actiInfos.get(from).get(1)));
					actiIds.put(from,prevNode);						
				}
				if(actiIds.containsKey(to)){
					nextNode = actiIds.get(to);
				}
				else{
					nextNode = new ProcessTreeNode(to);
					nextNode.setActivityInstName(actiInfos.get(to).get(0));
					nextNode.setLocationY(Integer.parseInt(actiInfos.get(to).get(1)));
					actiIds.put(to,nextNode);						
				}
				prevNode.getNext().add(nextNode);
				nextNode.getPrev().add(prevNode);														
			}
			
			//添加活动状态
			DataObject actInst = DataObjectUtil.createDataObject("com.eos.workflow.data.WFActivityInst");
			actInst.set("processInstID", processInstId);
			actInst.set("activityType", "manual");
			DataObject[] act = DatabaseUtil.queryEntitiesByTemplate("default", actInst);
			for(DataObject a : act){
				//加入正在执行List
				if("2".equals(a.getString("currentState")))
					actiIds.get(a.getString("activityDefID")).setCurrentState("acting");
				//加入已完成List
				if("7".equals(a.getString("currentState")))
					actiIds.get(a.getString("activityDefID")).setCurrentState("acted");
				//加入已完成List
				if("8".equals(a.getString("currentState")))
					actiIds.get(a.getString("activityDefID")).setCurrentState("acted");
			}
			
			//宽度优先遍历并删除路由节点
			ProcessTreeNode node = actiIds.get("startActivity");
			node.setDepth(0);
			//depthFirstSearch(node,actiIds);
			Set<ProcessTreeNode> set = broadFirstOperate(node,actiIds,processInstId);		
			
			//构建流程树
			pt = buildProcessTree(set);
			
			//broadFristSearchPrint(node);
			
		}
		return pt;
	}
	
	@SuppressWarnings("unchecked")
	@Bizlet("对象转Json")
	public String transferTOJson(ProcessTree pt) throws JsonGenerationException, JsonMappingException, IOException{		
		ObjectMapper mapper = new ObjectMapper();
		String str = mapper.writeValueAsString(pt);
		return str;
	}
	
	@Bizlet("获取退办活动")
	public DataObject[] getBackActivities(ProcessTree pt,String activityDefId){
		
		ProcessTreeNode[] treeNodes = pt.getTree();	
		List<ProcessTreeNode> activities = new ArrayList<ProcessTreeNode>();
		//System.out.println(treeNodes.length);
		//broadFristSearchPrint(treeNodes[0]);
		for(int i=0;i<treeNodes.length;i++){						
			String activityId = treeNodes[i].getActivityInstId();
			int depth = treeNodes[i].getDepth();
			boolean flag = true;
			if(activityId.equals(activityDefId)){
				break;
			}
			if(i>0){
				if(depth==treeNodes[i-1].getDepth()){
					flag = false;
				}
			}
			if(i<treeNodes.length-1){
				if(depth==treeNodes[i+1].getDepth()){
					flag = false;
				}
			}
			if(flag){
				activities.add(treeNodes[i]);
			}
			
		}
		int size = activities.size();
		DataObject[] backActivities = new DataObject[size];
		for(int i=0;i<size;i++){
			DataObject backActivity = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.BackActivity");
			backActivity.set("activitydefid",activities.get(i).getActivityInstId());
			backActivity.set("activityinstname",activities.get(i).getActivityInstName());
			backActivities[i] = backActivity;
		}
		return backActivities;
		
	}
	
	//判断是否为人工活动
	public boolean isManualActivity(String str){
		if(str.length()>14){
			String head = str.substring(0,14);		
			if(head.equals("manualActivity")){
				return true;
			}
		}
		return false;
	}
	
	//流程节点操作
	public void operateNode(ProcessTreeNode prevNode,String from,String to,Map<String,ProcessTreeNode> actiIds,Map<String,String> activityLines,Map<String,String> routeLines){
		if(isManualActivity(to)){
			if(actiIds.containsKey(to)){
				ProcessTreeNode nextNode = actiIds.get(to);
				nextNode.getPrev().add(prevNode);
				prevNode.getNext().add(nextNode);
			}
			else{
				ProcessTreeNode nextNode = new ProcessTreeNode(to);				
				nextNode.getPrev().add(prevNode);
				prevNode.getNext().add(nextNode);
				actiIds.put(to,nextNode);
			}
		}
		else{
			if(routeLines.containsKey(to)){
				if(actiIds.containsKey(routeLines.get(to))){
					ProcessTreeNode nextNode = actiIds.get(routeLines.get(to));
					nextNode.getPrev().add(prevNode);
					prevNode.getNext().add(nextNode);
				}
				else{
					activityLines.put(from,routeLines.get(to));
					routeLines.remove(to);
				}
			}
			else{
				activityLines.put(from,to);
			}			
		}
	}
	
	//深度优先遍历并删除路由节点
	public void depthFirstSearch(ProcessTreeNode node,Map<String,ProcessTreeNode> actiIds){
		print(node);
		while(node.getNext()!=null){
			int i=0;
			while(i<node.getNext().size()){
				ProcessTreeNode next = node.getNext().get(i);
				if(isManualActivity(next.getActivityInstId())){
					if(node.getDepth()+1>next.getDepth()){
						int lastLocationY = 0;
						if(next.getLastDepthActivity() != null)
							lastLocationY = actiIds.get(next.getLastDepthActivity()).getLocationY();
						if(Math.abs(node.getLocationY()-next.getLocationY())
						< Math.abs(next.getLocationY()-lastLocationY)){
							next.setDepth(node.getDepth()+1);
							next.setLastDepthActivity(node.getActivityInstId());
						}
					}
					depthFirstSearch(next,actiIds);
					i++;
				}
				else{
					if(!next.getActivityInstId().equals("finishActivity")){
						while(!isManualActivity(next.getActivityInstId())){
							node.getNext().remove(i);
//							for(int k=0;k<next.getPrev().size();k++){
//								if(next.getPrev().get(k).getActivityInstId().equals(next.getActivityInstId())){
//									next.getPrev().remove(k);
//								}						
//							}					
							for(int j=0;j<next.getNext().size();j++){
								node.getNext().add(next.getNext().get(j));
								}
							for(int k=0;k<node.getNext().size();k++){
								System.out.println(node.getNext().get(k).getActivityInstId());
							}
								next = node.getNext().get(i);
							}
							depthFirstSearch(next,actiIds);
							i++;
						}
						
					}
				}
		}
	}
	
	public void swap(ProcessTreeNode[] treenodes,int a,int b){
		ProcessTreeNode temp = treenodes[b];
		treenodes[b] = treenodes[a];
		treenodes[a] = temp;
	}
	
	public ProcessTree buildProcessTree(Set<ProcessTreeNode> treeSet){
		int size = treeSet.size();
		ProcessTreeNode[] treenodes = new ProcessTreeNode[size];
		List<ProcessTreeNode> startNodes = new ArrayList<ProcessTreeNode>();
		int maxDepth=0;
		int index=0;
		Iterator<ProcessTreeNode> it = treeSet.iterator();
		while(it.hasNext()){
			ProcessTreeNode ptn = it.next();
			if(isManualActivity(ptn.getActivityInstId())){
				treenodes[index++] = ptn;
			}
		}
		//按深度重新排序
		for(int i=0;i<size;i++){
			if(treenodes[i].getDepth()>maxDepth)
				maxDepth = treenodes[i].getDepth();
			if(treenodes[i].getDepth()==1)
				startNodes.add(treenodes[i]);
			for(int j=i+1;j<size;j++){
				if(treenodes[i].getDepth()>treenodes[j].getDepth())
					swap(treenodes,i,j);
			}
		}
		ProcessTree pt = new ProcessTree(treenodes,startNodes,maxDepth);
		
//		ProcessTreeNode[] treeNodes = pt.getTree();	
//		for(int i=0;i<treeNodes.length;i++){						
//			String activityId = treeNodes[i].getActivityInstId();
//			int depth = treeNodes[i].getDepth();
//			System.out.println("activityId:" + activityId + " depth:" + depth);
//		}
		
		return pt;
	}
	
	public Set<ProcessTreeNode> broadFirstOperate(ProcessTreeNode node,Map<String,ProcessTreeNode> actiIds,String processInstId){
		LinkedList<ProcessTreeNode> queue = new LinkedList<ProcessTreeNode>();
		Set<ProcessTreeNode> actiNodes = new HashSet<ProcessTreeNode>();
		Set<ProcessTreeNode> nodes = new HashSet<ProcessTreeNode>();
		queue.add(node);
		while(!queue.isEmpty()){
			ProcessTreeNode ptn = queue.poll();
			//标记尚未执行活动
			if(ptn.getCurrentState().equals("")){
				if(isManualActivity(ptn.getActivityInstId())){
					ptn.setCurrentState("notAct");
				}
			}
			//添加参与人
			if(isManualActivity(ptn.getActivityInstId())){
				String actor = getProcessPartyer(ptn.getActivityInstId(),processInstId);
				ptn.setActors(actor);
			}
			
			//删除子节点中的所有路由节点
			int hasroute = hasRoute(ptn);		
			while(hasroute != 1024){
				changeNext(ptn,hasroute);
				hasroute = hasRoute(ptn);
			}		
			//广度优先遍历添加节点深度属性
			for(int i=0;i<ptn.getNext().size();i++){
				ProcessTreeNode next = ptn.getNext().get(i);
				ptn.getNextActivities().add(next.getActivityInstId());
				//if(!actiNodes.contains(next)){		
					//if(ptn.getDepth()+1>next.getDepth()){
						int lastLocationY = 0;
						if(next.getLastDepthActivity() != null){						
							lastLocationY = actiIds.get(next.getLastDepthActivity()).getLocationY();						
						}
						if(Math.abs(ptn.getLocationY()-next.getLocationY())
							<= Math.abs(next.getLocationY()-lastLocationY)){						
							next.setDepth(ptn.getDepth()+1);
							next.setLastDepthActivity(ptn.getActivityInstId());							
						}	
					//}
					queue.add(next);
					actiNodes.add(ptn);
					nodes.add(next);
				//}
			}
		}
		return nodes;
	}
	
	public void changeNext(ProcessTreeNode node,int index){	
		ProcessTreeNode next = node.getNext().get(index);
		node.getNext().remove(index);
		//List<ProcessTreeNode> nodeNext = node.getNext();
		for(int j=0;j<next.getNext().size();j++){
			//nodeNext.add(next.getNext().get(j));	
			node.getNext().add(next.getNext().get(j));
			for(int k=0;k<next.getNext().get(j).getPrev().size();k++){
				if(next.getNext().get(j).getPrev().equals(next.getNext())){
					next.getNext().get(j).getPrev().remove(k);
				}
			}
			next.getNext().get(j).getPrev().add(next);
		}	
		//node.setNext(nodeNext);
	}
	
	/*
	 * 查看是否有路由节点，如有则返回路由节点的位置，如没有则返回1024（一个节点不会拥有1024个子节点）
	 */
	public int hasRoute(ProcessTreeNode node){
		if(node.getNext()!=null){
			for(int i=0;i<node.getNext().size();i++){
				ProcessTreeNode next = node.getNext().get(i);
				if(!isManualActivity(next.getActivityInstId())){
					return i;
				}
			}
		}
		return 1024;
	}
	
	private static DataObject[] queryWorkItem(String processInstId){
		//获取流程中所有工作项
		CriteriaType criteria = new CriteriaTypeImpl();
		criteria.set_entity("com.eos.workflow.data.WFWorkItem");
		List<ExprType> expr = new ArrayList<ExprType>();
		ExprTypeImpl expr1 = new ExprTypeImpl();
		expr1.set_property("processInstID");
		expr1.set_op("=");
		expr1.set_value(processInstId);
		expr.add(expr1);
		criteria.set_expr(expr);
		List<OrderbyType> order = new ArrayList<OrderbyType>();
		OrderbyType order1 = new OrderbyTypeImpl();
		order1.set_property("currentState");
		order1.set_sort("desc");
		order.add(order1);
		OrderbyType order2 = new OrderbyTypeImpl();
		order2.set_property("endTime");
		order2.set_sort("desc");
		order.add(order2);
		criteria.set_orderby(order);
		return DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteria);
	}
	
	private static DataObject[] queryPrcAprvInfo(String processInstId){
		//查询审批意见表获取最新处理人
		CriteriaType criteriaApr = new CriteriaTypeImpl();
		criteriaApr.set_entity("com.cjhxfund.fpm.bpsExpend.task.TAtsApproveInfo");
		List<ExprType> exprApr = new ArrayList<ExprType>();
		ExprTypeImpl exprApr1 = new ExprTypeImpl();
		exprApr1.set_property("lProcessInstId");
		exprApr1.set_op("=");
		exprApr1.set_value(processInstId);
		exprApr.add(exprApr1);
		criteriaApr.set_expr(exprApr);
		List<OrderbyType> orderApr = new ArrayList<OrderbyType>();
		OrderbyType orderApr1 = new OrderbyTypeImpl();
		orderApr1.set_property("dEndTime");
		orderApr1.set_sort("desc");
		orderApr.add(orderApr1);
		criteriaApr.set_orderby(orderApr);
		return DatabaseUtil.queryEntitiesByCriteriaEntity("default", criteriaApr);
	}
	
	private static ArrayList<String> getActHandler(DataObject[] aprvInfos,String activityDefId){
		ArrayList<String> list = new ArrayList<String>();
		for(DataObject obj:aprvInfos){
			if(obj.getString("activityDefId")==null) continue;
			if(obj.getString("activityDefId").equals(activityDefId)){
				list.add(obj.getString("workItemId"));
			} else {
				if(list.size()>0) return list;
			}
		}
		return list;
	}
	
	private static String queryPartiNameByWorkId(String workItemId) {
		String actActorStrs = "";
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("workItemId", workItemId);
		Object[] strs = DatabaseExt.queryByNamedSql("default", "com.cjhxfund.fpm.bpsExpend.prcworkitem.queryPrcWorkItemId", map);
		for(Object s : strs){
			actActorStrs += s +" - <br/>";
		}
		return actActorStrs;
	}
	
	//获取流程活动中的参与人
		private static String getProcessPartyer(String activityDefID,String processInstID){
			String actor = "";
			//获取流程中所有工作项
			DataObject[] workItem0 = queryWorkItem(processInstID);
			//查询审批意见表获取处理人
			DataObject[] aprvInfos = queryPrcAprvInfo(processInstID);
			
			int actInstId = 0;
			Long startTime = 0L;
			String noFinishAct = "";
			//该活动的处理人
			ArrayList<String> handlerList = getActHandler(aprvInfos,activityDefID);
				
			for(DataObject work:workItem0){//一个活动下的工作项循环
				String currentState = work.getString("currentState");
				//已终止
				if("13".equals(currentState)&&work.get("activityDefID").equals(activityDefID)){
					int aprvNum = 0;//存在审批意见数量
					//查询审批意见表获取处理人
					DataObject aprvInfo = DataObjectUtil.createDataObject("com.cjhxfund.fpm.bpsExpend.task.TAtsApproveInfo");
					for(int j=0;j<aprvInfos.length;j++){
						aprvInfo = aprvInfos[j];
						String aprvActId = aprvInfo.getString("lActivityInstId");
						String aprvWorkId = aprvInfo.getString("lWorkItemId");
						if(aprvActId!=null&&aprvWorkId!=null
								&&aprvActId.equals(work.getString("activityInstID"))
								&&aprvWorkId.equals(work.getString("workItemID"))){
								aprvNum=1;
								break;
						}
					}
					//特殊情况（流程第一环节）不会新建活动实例
					if("manualActivitym1".equals(activityDefID)){
						aprvNum=0;
					}
						
					if(aprvNum!=0){
						String endTime = aprvInfo.getString("dEndTime");
						Long workStartTime = 0L;
						if(aprvInfo.getDate("dStartTime")!=null){
							workStartTime = aprvInfo.getDate("dStartTime").getTime();
						}
						endTime = endTime.replace("T", " ");
						if(endTime.indexOf(".")>-1){ endTime = endTime.substring(0,endTime.indexOf("."));}
						if(actInstId!=work.getInt("activityInstID")&&workStartTime>startTime){
						actor = aprvInfo.getString("vcUserName")+" - "+endTime+"<br/>";
						actInstId = aprvInfo.getInt("lActivityInstId");
						startTime = workStartTime;
						noFinishAct="";
					}else if(actInstId==work.getInt("activityInstID")){
							actor += aprvInfo.getString("vcUserName")+" - "+endTime+"<br/>";
						}
					}
						else{
							String endTime = work.getString("endTime");
							Long workStartTime = work.getDate("createTime").getTime();
							endTime = endTime.replace("T", " ");
							if(endTime.indexOf(".")>-1){ endTime = endTime.substring(0,endTime.indexOf("."));}
							if(actInstId<work.getInt("activityInstID")&&workStartTime>startTime){
								noFinishAct = work.getString("partiName")+" - <br/>";
								actInstId= work.getInt("activityInstID");
								startTime = workStartTime;
							}else if(actInstId==work.getInt("activityInstID")){
								noFinishAct += work.getString("partiName")+" - <br/>";
							}
						}
					}
					//已完成
					if("12".equals(currentState)&&work.get("activityDefID").equals(activityDefID)){
						//处理已完成时间格式
						String endTime = work.getString("endTime");
						Long workStartTime = work.getDate("createTime").getTime();
						endTime = endTime.replace("T", " ");
						if(endTime.indexOf(".")>-1) endTime = endTime.substring(0,endTime.indexOf("."));
						//当第一环节是不判断是否有审批意见信息
						if("manualActivitym1".equals(work.getString("activityDefID"))&&handlerList!=null){
							if(actInstId<work.getInt("activityInstID")&&workStartTime>startTime){
								actor = work.getString("partiName")+" - "+endTime+"<br/>";
								actInstId= work.getInt("activityInstID");
								startTime = workStartTime;
								noFinishAct="";
							}else if(actInstId==work.getInt("activityInstID")){
								actor += work.getString("partiName")+" - "+endTime+"<br/>";
							}
						} else {//根据审批意见表设置处理人
							if(actInstId<work.getInt("activityInstID")&&workStartTime>startTime&&handlerList!=null&&handlerList.contains(work.getString("workItemID"))){
								actor = work.getString("partiName")+" - "+endTime+"<br/>";
								actInstId= work.getInt("activityInstID");
								startTime = workStartTime;
								//noFinishAct="";
							}else if(actInstId==work.getInt("activityInstID")&&handlerList!=null&&handlerList.contains(work.getString("workItemID"))){
								actor += work.getString("partiName")+" - "+endTime+"<br/>";
							} else {
								String temp = "";
								//已完结处理人中是否已存在，已存在则不添加
								temp = actor==null?"":actor.indexOf(work.getString("partiName"))>-1?"":work.getString("partiName")+" - <br/>";
								if("".equals(temp)||temp==null){
									
								} else {
									//若不存在，判断noFinishAct是否有重复
									temp = noFinishAct==null?"":noFinishAct.indexOf(work.getString("partiName"))>-1?"":work.getString("partiName")+" - <br/>";
									noFinishAct += temp ;
								}
							}
						}
					}
					//正在执行必定是优先且串联
					if(("4".equals(currentState)||"10".equals(currentState))&&work.get("activityDefID").equals(activityDefID)){
						Long workStartTime = work.getDate("createTime").getTime();
						String actActorStrs = queryPartiNameByWorkId(work.getString("workItemID"));
						if(!"".equals(actActorStrs)){
							if(actInstId<work.getInt("activityInstID")){
								actInstId= work.getInt("activityInstID");
								actor = actActorStrs;
								startTime = workStartTime;
								noFinishAct="";
							}else if(actInstId==work.getInt("activityInstID")){
								actor += actActorStrs;
							}
							continue;
						}
						if(actInstId<work.getInt("activityInstID")){
							actInstId= work.getInt("activityInstID");
							actor = work.getString("partiName")+" - <br/>";
							startTime = workStartTime;
							noFinishAct="";
						}else if(actInstId==work.getInt("activityInstID")){
							actor += work.getString("partiName")+" - <br/>";
						}
					}
				}
				if(!"".equals(noFinishAct)){
					actor+=noFinishAct;
				}
			
			return actor;
		}
	
	public void broadFristSearchPrint(ProcessTreeNode node){
		LinkedList<ProcessTreeNode> queue = new LinkedList<ProcessTreeNode>();
		Set<String> actiNodes = new HashSet<String>();
		queue.add(node);
		while(!queue.isEmpty()){
			ProcessTreeNode ptn = queue.poll();
			print(ptn);
			for(int i=0;i<ptn.getNext().size();i++){
				if(!actiNodes.contains(ptn.getNext().get(i).getActivityInstId())){
					queue.add(ptn.getNext().get(i));
					actiNodes.add(ptn.getNext().get(i).getActivityInstId());
				}
			}
		}
	}
	
	public void print(ProcessTreeNode node){
		System.out.println("activityInstId:" + node.getActivityInstId() + " activityInstName:" + node.getActivityInstName()
				+ " depth:" + node.getDepth() + " locationY:" + node.getLocationY() 
				+ " currentState:" + node.getCurrentState() + " actors:" + node.getActors());
	}
}
