package com.yc.biz.impl;

import java.util.List;

import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeSet;

import com.yc.dao.Senstiveword;

public class SenstivewordBiz {
	private Senstiveword sw = new Senstiveword();
	
	public TreeSet<String> getSenstive(){
		List<Map<String,Object>> list = sw.getSenstiveWord();
		TreeSet<String> set = new TreeSet<>();
		if(list != null) {
			for(Map<String,Object> map : list) {
				for(Entry<String, Object> en :map.entrySet()) {
					set.add((String) en.getValue());
				}
			}
		}
		return set;
	}
	
	public int addSenstive(String word) {
		return sw.addSenstive(word);
	}
	
	public int delSenstive(String word) {
		return sw.delSenstive(word);
	}
}
