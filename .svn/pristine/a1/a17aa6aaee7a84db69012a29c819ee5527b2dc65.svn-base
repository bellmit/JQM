package com.cjhxfund.fpm.bpsExpend;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.codehaus.jackson.annotate.JsonIgnore;

public class ProcessTreeNode {
	
	//活动ID
	public String activityInstId;
	//活动名
	public String activityInstName;
	//前驱节点
	@JsonIgnore
	public List<ProcessTreeNode> prev;
	//后继节点
	@JsonIgnore
	public List<ProcessTreeNode> next;
	//后继节点活动集合
	public Set<String> nextActivities;
	//节点当前状态
	public String currentState;
	//节点深度
	public int depth;
	//节点物理位置
	public int locationY;
	//获取节点深度的上一活动
	public String lastDepthActivity;
	//节点参与人
	public String actors;
	
	public ProcessTreeNode(String activityInstId) {
		super();
		this.activityInstId = activityInstId;
		this.prev = new ArrayList<ProcessTreeNode>();
		this.next = new ArrayList<ProcessTreeNode>();
		this.nextActivities = new HashSet<String>();
		this.locationY = 0;
		this.currentState = "";
	}
	
	public String getActivityInstName() {
		return activityInstName;
	}
	public void setActivityInstName(String activityInstName) {
		this.activityInstName = activityInstName;
	}
	
	public String getActivityInstId() {
		return activityInstId;
	}

	public void setActivityInstId(String activityInstId) {
		this.activityInstId = activityInstId;
	}

	public List<ProcessTreeNode> getPrev() {
		return prev;
	}

	public void setPrev(List<ProcessTreeNode> prev) {
		this.prev = prev;
	}

	public List<ProcessTreeNode> getNext() {
		return next;
	}

	public void setNext(List<ProcessTreeNode> next) {
		this.next = next;
	}

	public String getCurrentState() {
		return currentState;
	}
	public void setCurrentState(String currentState) {
		this.currentState = currentState;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getLocationY() {
		return locationY;
	}

	public void setLocationY(int locationY) {
		this.locationY = locationY;
	}

	public String getLastDepthActivity() {
		return lastDepthActivity;
	}

	public void setLastDepthActivity(String lastDepthActivity) {
		this.lastDepthActivity = lastDepthActivity;
	}

	public String getActors() {
		return actors;
	}

	public void setActors(String actors) {
		this.actors = actors;
	}

	public Set<String> getNextActivities() {
		return nextActivities;
	}

	public void setNextActivities(Set<String> nextActivities) {
		this.nextActivities = nextActivities;
	}

	
	
	
	
	
}
