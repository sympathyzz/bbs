package com.yc.utils;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
 
public class NumberUtil {
 
	public static Set get(int[] args) {
 
		int[] attr = args;
		List<Integer> list = new ArrayList<Integer>();
		for (int i : attr) {
			list.add(i);
		}
		Set<Integer> set = new HashSet<Integer>();
		set.addAll(list);
		return set;
	}
}