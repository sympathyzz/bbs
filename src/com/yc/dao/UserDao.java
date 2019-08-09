package com.yc.dao;

import java.sql.Timestamp;


import java.util.List;
import java.util.Map;

import com.yc.bean.Report;
import com.yc.bean.Tapu;
import com.yc.utils.DBUtil;
import com.yc.utils.Encrypt;

public class UserDao {

	public int tapu(int uid, Timestamp tapuTime, Timestamp conTime) {
		String sql = "insert into tapu value(null,?,?,?)";
		return DBUtil.doUpdate(sql,tapuTime,conTime, uid);
	}
	public Map<String, Object> getTapu(int uid ) {
		String sql = "select * from tapu where uid = ?";
		return DBUtil.get( sql, uid);
	}
	public int remove(int uid) {
		String sql = "delete from tapu where uid = ?";
		return DBUtil.doUpdate(sql, uid);
		
	}
	public int report(Report report) {
		String sql = "insert into report value(null,?,?,?,?)";
		return DBUtil.doUpdate(sql, report.getDefenid(),report.getPlaintid(),report.getTitle(),report.getContent());
	}
	public int follow(int fansid,int uid) {
		String sql = "insert into follow value(null,?,?)";
		return DBUtil.doUpdate(sql, fansid,uid);
		
	}
	public List<Map<String,Object>> getFollow(int uid) {
		String sql = "				\n" +
				"				\n" +
				"SELECT\n" +
				"	b.* \n" +
				"FROM\n" +
				"	follow AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.uid = b.uid \n" +
				"WHERE\n" +
				"	a.fansid =?";
		return DBUtil.list(sql,uid);
		
	}
	public List<Map<String,Object>> beFollow(int uid) {
		String sql = "SELECT\n" +
				"	a.fansid,\n" +
				"	b.* \n" +
				"FROM\n" +
				"	follow AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.fansid = b.uid \n" +
				"WHERE\n" +
				"	a.uid = ?";
		return DBUtil.list(sql,uid);
		
	}
	public int cencel(int fansid, int uid) {
		String sql = "delete from follow where fansid=? and uid =?";
		return DBUtil.doUpdate(sql, fansid,uid);
	}
	public int changePerson(int uid, String person) {
		String sql = "UPDATE tbl_user SET person = ? WHERE uid = ?";
		return DBUtil.doUpdate(sql, person,uid);
	}
	public Map<String, Object> isFollow(int fansid, int uid) {
		String sql = "select count(*) as cnt from follow where fansid=? and uid = ?";
		return DBUtil.get(sql, fansid,uid);
	}
	public Map<String, Object> getHead(int uid){
		String sql = "select head from tbl_user where uid=?";
		return DBUtil.get(sql, uid);
	}
	public int changeHead(String path,int uid) {
		String sql = "UPDATE tbl_user SET head = ? where uid = ?";
		return DBUtil.doUpdate(sql, path,uid);
	}
	public boolean isLog(String name, String psw) {
		String sql = "select * from tbl_user where uname=? and upass = ?";
		psw =   Encrypt.sha(psw);
		List<Map<String, Object>> list = DBUtil.list(sql, name,psw);
		if(list!=null&&list.size()>0)
			return true;
		else
			return false;
	}
	public boolean changePass(String name, String password) {
		password = Encrypt.sha(password);
		String sql = "UPDATE tbl_user SET upass = ? where uname = ?";
		return DBUtil.doUpdate(sql, password,name)>0;
	}

	public int reg(String uname, String psw1, String head, Timestamp time, String gender, String person, int type,
		String email, int exp, String phone) {
		String sql = "insert into tbl_user values(null,?,?,?,?,?,?,?,?,?,?)";
		return DBUtil.doUpdate(sql, uname,Encrypt.sha(psw1),head,time,gender,person,type,email,exp,phone)>0?1:0;
	}
	public int exp(int userid, int i) {
		String sql = "UPDATE tbl_user SET exp = exp+?  where uid = ?";
		return DBUtil.doUpdate(sql,i,userid)>0?1:0;
	}
	
	
	
	public int getExp(int id){
		String sql = "select exp from tbl_user where uid=?";
		List<Map<String, Object>> list = DBUtil.list(sql, id);
		int exp = 0;
		if(list!=null&&list.size()>0) {
			 exp = (int) list.get(0).get("exp");
		}
		return exp;
	}
}
