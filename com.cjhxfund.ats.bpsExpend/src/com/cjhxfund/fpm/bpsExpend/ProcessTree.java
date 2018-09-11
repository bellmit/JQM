package com.cjhxfund.fpm.bpsExpend;

import java.util.List;

public class ProcessTree {
	
	public ProcessTreeNode[] tree;
	public List<ProcessTreeNode> startNodes;
	int depth;
		
	public ProcessTree(){}
	
	public ProcessTree(ProcessTreeNode[] tree,
			List<ProcessTreeNode> startNodes, int depth) {
		super();
		this.tree = tree;
		this.startNodes = startNodes;
		this.depth = depth;
	}

	public ProcessTreeNode[] getTree() {
		return tree;
	}

	public void setTree(ProcessTreeNode[] tree) {
		this.tree = tree;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public List<ProcessTreeNode> getStartNodes() {
		return startNodes;
	}

	public void setStartNodes(List<ProcessTreeNode> startNodes) {
		this.startNodes = startNodes;
	}
	
	
}
