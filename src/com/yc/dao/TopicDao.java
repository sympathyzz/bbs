package com.yc.dao;

import java.io.UnsupportedEncodingException;

import java.util.List;
import java.util.Map;

import com.yc.bean.Topic;
import com.yc.utils.DBUtil;

public class TopicDao {
	
	public List<Map<String, Object>> query(String boardid) {
		String sql="select * from tbl_topic where boardid=?";
		return	 DBUtil.list(sql, boardid);
	}
	public void insert(Topic topic) {
		String sql="insert into tbl_topic values(null,?,?,?,?,?,?)";
		String sql1="insert into zancount values(?,0)";
		String title = topic.getTitle();
		String content = topic.getContent();
		
		title = new String(title);
		content = new String(content);
	
		
		DBUtil.doUpdate(sql, title
				,content
				,topic.getPublishtime()
				,topic.getModifytime()
				,topic.getUserid()
				,topic.getBoardid());	
		DBUtil.doUpdate(sql1,title);
	}
	public List<Map<String, Object>> selectByDetail(String topicid) {
		String sql="select\n"+
				"a.*,b.uname,\n"+
				"b.regtime,\n"+
				"b.head\n"+
				"from\n"+
				"tbl_topic a\n"+
				"join tbl_user b on a.uid=b.uid\n"+
				"where\n"+
				"topicid=?\n"+
				"union all\n"+
				"select\n"+
				"a.*,b.uname,\n"+
				"b.regtime,\n"+
				"b.head\n"+
				"from\n"+
				"tbl_reply a\n"+
				"join tbl_user b on a.uid=b.uid\n"+
				"where\n"+
				"topicid=?";
		return DBUtil.list(sql, topicid,topicid);
	}
	
	public void addzan(String title,int count,String uname) {
		int acount=count+1;
		String sql="update tbl_reply set count="+acount+" where title=?";
		String sql2="update tbl_topic set count="+acount+" where title=?";
		String sql1="insert into zanuser values(?,?)";
		 if(DBUtil.doUpdate(sql, title)==0){
			 DBUtil.doUpdate(sql2, title);
		 }
		 DBUtil.doUpdate(sql1, uname,title);
	}
	public void delzan(String title,int count,String uname) {
		int acount=count-1;
		String sql="update tbl_reply set count="+acount+" where title=?";
		String sql2="update tbl_topic set count="+acount+" where title=?";
		String sql1="delete from zanuser where title=? and uname=?";
		if(DBUtil.doUpdate(sql, title)==0){
			DBUtil.doUpdate(sql2, title);
		 }
		DBUtil.doUpdate(sql1, title,uname);
	}
	public List<Map<String, Object>> isgreat(String title,String uname) {
		String sql="select * from zanuser where title=? and uname=?";
		List<Map<String, Object>> list = DBUtil.list(sql, title,uname);
		
		
		return list;
	}
	public List<Map<String, Object>> iscollect(String title,String uname) {
		String sql="select * from scuser where title=? and uname=?";
		
		List<Map<String, Object>> list = DBUtil.list(sql, title,uname);
		
		return list;
	}
	public void delsc(String title,String uname) {
		
		String sql1="delete from scuser where title=? and uname=?";
		
		DBUtil.doUpdate(sql1, title,uname);
	}
	public void addsc(String title,String uname) {
		
		String sql1="insert into scuser values(?,?)";
		
		DBUtil.doUpdate(sql1, uname,title);
	}

	public List<Map<String, Object>>  getadCount(String aid){
		String sql= "select count from adcount where aid=?";
		return DBUtil.list(sql,aid);
	}
	public void  addadCount(int count,String aid){
		String sql= "update adcount set count=? where aid=?";
		DBUtil.doUpdate(sql,count+1,aid);
	}
	
	public Map<String, Object> getAd(){
		String sql="select * from adcount where count<acount";
		List<Map<String, Object>> data = DBUtil.list(sql);
		System.out.println(data);
		
		if(data!=null&&data.size()!=0){
			return data.get(0);
		}else{
			return null;
		}
	}
}
