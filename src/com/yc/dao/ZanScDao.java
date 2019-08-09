package com.yc.dao;

import java.util.List;
import java.util.Map;

import com.yc.utils.DBUtil;

public class ZanScDao {
	
	
public void addzan(String title,int count,String uname) {
		
		String sql="update tbl_reply set count=? where title=?";
		String sql2="update tbl_topic set count=? where title=?";
		String sql1="insert into zanuser values(?,?)";
		 if( DBUtil.doUpdate(sql,count+1, title)==0){
			 DBUtil.doUpdate(sql2,count+1, title);
		 }
		 DBUtil.doUpdate(sql1, uname,title);
	}
	public void delzan(String title,int count,String uname) {
	
		String sql="update tbl_reply set count=? where title=?";
		String sql2="update tbl_topic set count=? where title=?";
		String sql1="delete from zanuser where title=? and uname=?";
		if( DBUtil.doUpdate(sql,count-1, title)==0){
			 DBUtil.doUpdate(sql2,count-1, title);
		 }
		 DBUtil.doUpdate(sql1, title,uname);
	}
	public List<Map<String, Object>> isgreat(String title,String uname) {
		String sql="select * from zanuser where title=? and uname=?";
		return DBUtil.list(sql, title,uname);
	}


	public List<Map<String, Object>> iscollect(String title, String uname) {
		String sql = "select * from scuser where title=? and uname=?";
		return  DBUtil.list(sql, title, uname);
	}

	public void delsc(String title, String uname) {

		String sql1 = "delete from scuser where title=? and uname=?";

		 DBUtil.doUpdate(sql1, title, uname);
	}

	public void addsc(String title, String uname) {

		String sql1 = "insert into scuser values(?,?)";

		 DBUtil.doUpdate(sql1, uname, title);
	}
	public List<Map<String,Object>> getMyCollect(int uid) {
		String sql = "SELECT\n" +
				"	d.* \n" +
				"FROM\n" +
				"	tbl_topic AS d\n" +
				"	RIGHT JOIN (\n" +
				"SELECT\n" +
				"	a.title \n" +
				"FROM\n" +
				"	scuser AS a\n" +
				"	LEFT JOIN tbl_user AS b ON a.uname = b.uname \n" +
				"WHERE\n" +
				"	b.uid = ? \n" +
				"	) AS c ON c.title = d.title";
		return DBUtil.list(sql, uid);
	}

}
