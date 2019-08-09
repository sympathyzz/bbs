package com.yc.dao;

import java.util.List;
import java.util.Map;

import com.yc.bean.Message;
import com.yc.utils.DBUtil;

public class SocketDao {
	private DBUtil db = new DBUtil();
	public void setChat(Message message) {
		String sql  = "insert into socket value(null,?,?,?,?)";
		db.doUpdate(sql, message.getForname(),message.getToName(),message.getMessgeText(),message.getMessageDate());
	}
	public List<Map<String,Object>> getChat(int uid) {
		String sql = "SELECT\n" +
				"	a.*,\n" +
				"	b.head \n" +
				"FROM\n" +
				"	socket AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.toname = b.uid \n" +
				"WHERE\n" +
				"	toname =?";
		return db.list(sql, uid);
		
	}
	public List<Map<String,Object>> getRealMessage(int forname, int toname) {
		String sql = "SELECT\n" +
				"	a.*,\n" +
				"	b.head \n" +
				"FROM\n" +
				"	socket AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.forname = b.uid \n" +
				"WHERE\n" +
				"	a.forname = ? \n" +
				"	AND a.toname = ?";
		return db.list(sql, forname,toname);
		
	}
	
	public void delRealMessage(int forname, int toname) {
		String sql="DELETE \n" +
				"FROM\n" +
				"socket \n" +
				"WHERE\n" +
				"	forname = ? \n" +
				"	AND toname =?";
		
		db.doUpdate(sql, forname,toname);
	}
}
