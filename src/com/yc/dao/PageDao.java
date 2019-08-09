package com.yc.dao;

import java.util.Map;

import com.yc.bean.Board;
import com.yc.bean.Topic;
import com.yc.utils.DBUtil;

public class PageDao {
	private DBUtil db = new DBUtil();
	/**
	 *获得board的总数
	 * @param b
	 * @return
	 */
	public Map<String, Object> getTotalPage(Board b) {
		String sql = "select count(*) as cnt from tbl_topic where boardid = ?";
		return db.get(sql, b.getBoardid());
		
	}
	/**
	 * 获得topic的总数
	 * @param t
	 * @return
	 */
	public Map<String, Object> getTotalPage(Topic t) {
		String sql = "SELECT\n" +
				"	count( * ) AS cnt \n" +
				"FROM\n" +
				"	( SELECT * FROM tbl_topic WHERE topicid = ? UNION ALL SELECT * FROM tbl_reply ) AS a";
		return db.get(sql,t.getTopicid());
		
	}
}
