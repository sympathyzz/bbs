package com.yc.dao;

import java.util.List;
import java.util.Map;

import com.yc.utils.DBUtil;

public class Senstiveword {
	private DBUtil db = new DBUtil();
	
	public List<Map<String,Object>> getSenstiveWord() {
		String sql = "select * from senstiveword";
		return db.list(sql);
	}

	public int addSenstive(String word) {
		String sql = "insert into senstiveword value(?)";
		return db.doUpdate(sql,word);
		
	}

	public int delSenstive(String word) {
		String sql = "delete from senstiveword where senstiveword = ?";
		return db.doUpdate(sql, word);
	}
}
