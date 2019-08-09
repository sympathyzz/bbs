package com.yc.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.yc.bean.Tapu;
import com.yc.utils.DBUtil;

public class ManageDao {
	private DBUtil db = new DBUtil();
	public List<Map<String,Object>> getUser(String id){
		String sql = "select * from tbl_user where uid=? or uname=?";
		return db.list(sql, id,id);
	}
	public int Addmanage(String uid) {
		String sql = "UPDATE tbl_user SET type = 1 where uid = ?";
		return db.doUpdate(sql, uid);
	}
	
	public int cancel(String uid) {
		String sql = "UPDATE tbl_user SET type = 0 where uid = ?";
		return db.doUpdate(sql, uid);
	}
	public List<Map<String, Object>> getReport(int pageNum,int pageSize) {
		String sql = "SELECT\n" +
				"	a.*,\n" +
				"	b.uname AS dename, b.head \n" +
				"FROM\n" +
				"	report AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.defenid = b.uid \n" +
				"ORDER BY\n" +
				"	a.reportid DESC \n"+
				"	limit ?,?"
				;
		return db.list(sql,(pageNum - 1)*pageSize,pageSize);
	}
	public int delReport(int reportid) {
		String sql = "delete from report where reportid = ?";
		
		return db.doUpdate(sql, reportid);
	}
	public List<Map<String, Object>> manageTapu(String id) {
		String sql = "SELECT\n" +
				"	a.*,\n" +
				"	b.uname,\n" +
				"	b.head \n" +
				"FROM\n" +
				"	tapu AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.uid = b.uid \n" +
				"WHERE\n" +
				"	b.uname = ? \n" +
				"	OR b.uid = ?";
		return db.list(sql, id,id);
	}
	public int cencelTapu(int uid) {
		String sql = "delete from tapu where uid = ?";
		return db.doUpdate(sql, uid);
	}
	public int addFather(String content) {
		String sql = "select * from tbl_board where boardname=?";
		if(db.list(sql, content) != null) {
			return 0;
		}else {
			sql = "insert into tbl_board value(null,?,0)";
			return db.doUpdate(sql, content);
		}
	}
	public List<Map<String, Object>> getFather() {
		String sql = "select * from tbl_board where parentid = 0";
		return db.list(sql);
	}
	public int addChlid(int index, String content) {
		String sql = "select * from tbl_board where parentid = ? and boardname=?";
		if(db.list(sql, index,content) != null) {
			return 0;
		}else {
			sql = "insert into tbl_board value(null,?,?)";
			return db.doUpdate(sql,content,index);
		}
		
	}
	public int delFather(int index) {
		String sql = "delete from tbl_board where parentid = ? or boardid = ?";
		return db.doUpdate(sql, index,index);
	}
	
	public int delChild(int index) {
		String sql = "delete from tbl_board where boardid = ?";
		return db.doUpdate(sql, index);
	}
	public List<Map<String, Object>> getChild(int index) {
		String sql = "select * from tbl_board where parentid = ?";
		return db.list(sql, index);
	}
	public Map<String, Object> getReportTotal() {
		String sql = "select count(*) as cnt from tbl_board";
		return db.get(sql);
	}
	public List<Map<String, Object>> query(Integer pageNum, Integer pageSize) {
		String sql = "select * from tbl_user limit ?,?";
		return db.list(sql, (pageNum - 1)*pageSize,pageSize);
	}
	public Map<String, Object> getUserTotal() {
		String sql = "select count(*) as cnt from tbl_user";
		return db.get(sql);
	}
	public List<Map<String, Object>> getTapu(Integer pageNum, Integer pageSize) {
		String sql = "SELECT\n" +
				"	a.*,\n" +
				"	b.head,\n" +
				"	b.uname \n" +
				"FROM\n" +
				"	tapu AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.uid = b.uid \n" +
				"	LIMIT ?,?";
		return db.list(sql, (pageNum - 1)*pageSize,pageSize);
	}
	public Map<String, Object> getTapuTotal() {
		String sql = "select count(*) as cnt from tbl_user";
		return db.get(sql);
	}
	public Tapu getTapu(int uid ) {
		String sql = "select * from tapu where uid = ?";
		return db.get(Tapu.class, sql, uid);
	}
	public int tapu(int uid, Timestamp tapuTime, Timestamp conTime) {
		String sql = "insert into tapu value(null,?,?,?)";
		return db.doUpdate(sql,tapuTime,conTime, uid);
	}
}
