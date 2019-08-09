package com.yc.utils;

import java.util.HashMap;

public class SenstiveNode {
	private boolean IsEnd=true;
	private HashMap<String, SenstiveNode> nextNode;
	public boolean getIsEnd() {
		return this.IsEnd;
	}
	public void setIsEnd(boolean isEnd) {
		this.IsEnd = isEnd;
	}
	public HashMap<String, SenstiveNode> getNextNode() {
		return this.nextNode;
	}
	public void setNextNode(HashMap<String, SenstiveNode> nextNode) {
		this.nextNode = nextNode;
	}
	
	
}
