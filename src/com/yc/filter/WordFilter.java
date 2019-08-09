package com.yc.filter;

import java.io.BufferedReader;
import java.io.File;
import java.net.URL;


			

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.TreeSet;

import com.yc.biz.impl.SenstivewordBiz;
import com.yc.utils.SenstiveNode;

public class WordFilter {
	private static HashMap<String, SenstiveNode> AllSensWord = new HashMap<>();
	private static SenstivewordBiz sw = new SenstivewordBiz();
	static{
		
		TreeSet<String> set = new TreeSet<>();
		set = sw.getSenstive();
		addSensWord(set);
	}
	
	public static void addSensWord(TreeSet<String> set) {
		for(String string : set) {
			HashMap<String, SenstiveNode> strNode = AllSensWord;
			for(int index = 0; index < string.length(); index++) {
				char str = string.charAt(index);
				SenstiveNode node = strNode.get(String.valueOf(str));
				if(node == null) {
					node = new SenstiveNode();
					HashMap<String, SenstiveNode> nextNode = new HashMap<>();
					if(index < string.length()-1) {
						node.setIsEnd(false);
					}
					node.setNextNode(nextNode);
					strNode.put(String.valueOf(str), node);
					strNode = node.getNextNode();
				}else {
					strNode = strNode.get(String.valueOf(str)).getNextNode();
				}
			}
		}
	}
	
	public String WordFilter(String string) {
		HashMap<String, SenstiveNode> strNode = AllSensWord;
		int normarStart = 0;
		int normarEnd = 0;
		int abnormatEnd = 0;
		StringBuffer sb = new StringBuffer();
		for(int index = 0; index < string.length(); index++) {
			char str = string.charAt(index);
			SenstiveNode node = strNode.get(string.valueOf(str));
			if(node != null) {
				abnormatEnd = index;
				if(node.getIsEnd()) {
					if(normarEnd != 0) {
						sb.append(string.substring(normarStart, normarEnd+1));
					}
					normarStart = abnormatEnd+1;
					normarEnd = normarStart;
					abnormatEnd  = normarStart;
					sb.append("**");
					strNode = AllSensWord;
				}else {
					strNode = node.getNextNode();
				}
			}else {					
				normarEnd = index;
			}
		}
		if(abnormatEnd == string.length()-1) {
			sb.append(string.substring(normarEnd,abnormatEnd+1));
		}
		if(normarStart == 0 && normarEnd == string.length()-1) {
			return string;
		}
		return sb.toString();
	}
}
