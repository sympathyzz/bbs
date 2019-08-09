package com.yc.dao;

import java.util.List;
import java.util.Map;

import com.yc.bean.Board;
import com.yc.bean.Reply;
import com.yc.bean.User;
import com.yc.utils.DBUtil;
import com.yc.utils.Encrypt;

public class BoardDao {
	private static DBUtil db = new DBUtil();
	/**
	   * 加载index.jsp页面信息
	 * @return
	 */
	public static List<Map<String, Object>> getIndex() {
		String sql = 
				"SELECT\n" +
						"	* \n" +
						"FROM\n" +
						"	(\n" +
						"SELECT\n" +
						"	s.*,\n" +
						"	u.uname \n" +
						"FROM\n" +
						"	(\n" +
						"SELECT\n" +
						"	c.*,\n" +
						"	t.uid \n" +
						"FROM\n" +
						"	(\n" +
						"SELECT\n" +
						"	a.boardname AS pname,\n" +
						"	b.boardname AS cname,\n" +
						"	b.boardid,\n" +
						"	b.parentid,\n" +
						"	g.topicid,\n" +
						"	g.title,\n" +
						"	g.content,\n" +
						"	g.publishtime,\n" +
						"	g.modifytime,\n" +
						"	i.cnt \n" +
						"FROM\n" +
						"	tbl_board AS a\n" +
						"	LEFT JOIN tbl_board AS b ON a.boardid = b.parentid\n" +
						"	LEFT JOIN (\n" +
						"SELECT\n" +
						"	* \n" +
						"FROM\n" +
						"	(\n" +
						"SELECT\n" +
						"	d.* \n" +
						"FROM\n" +
						"	tbl_topic AS d\n" +
						"	JOIN ( SELECT max( topicid ) AS maxid FROM tbl_topic GROUP BY boardid ) AS e ON d.topicid = e.maxid \n" +
						"	) AS f \n" +
						"	) AS g ON g.boardid = b.boardid\n" +
						"	LEFT JOIN ( SELECT count( * ) AS cnt, boardid FROM tbl_topic GROUP BY boardid ) AS i ON i.boardid = b.boardid \n" +
						"WHERE\n" +
						"	a.parentid = 0 \n" +
						"	) AS c\n" +
						"	LEFT JOIN ( SELECT uid, topicid FROM tbl_topic ) AS t ON c.topicid = t.topicid \n" +
						"	) AS s\n" +
						"	LEFT JOIN ( SELECT uname, uid FROM tbl_user ) AS u ON u.uid = s.uid \n" +
						"	) AS x \n" +
						"ORDER BY\n" +
						"	parentid";
		
		
		
		return DBUtil.list(sql);
	}
	
	/**
	 * 
	 *用户登录方法
	 */
	@SuppressWarnings("static-access")
	public User login(User user) {
		String a = db.toString();
		
		return (db.get(User.class,"select * from tbl_user where uname=? and upass=?", user.getUname(),user.getUpass()));
	}
	
	/**
	 * 用户注册方法
	 */
	public String reg(User user) {
		String sql = "select * from tbl_user where uname=?";
		if(DBUtil.get(sql, user.getUname()) != null) {
			return "exist";
		}else {
			sql = "insert into tbl_user values(null,?,?,?,?,?,?,?)";
			if(DBUtil.doUpdate(sql, user.getUname(),Encrypt.sha(user.getUpass()),user.getHead(),user.getRegtime(),user.getGender(),"这个人很懒，什么也没留下",0)>0) {
				return "ok";
			}else {
				return "no";
			}
		}
	}
	/**
	 * 获得用户信息
	 */
	public Map<String,Object> getUser0(int id){
		String sql = "select * from tbl_user where uid=?";
		return db.get(sql, id);
	}
	/**
	 * 回复
	 * @param re
	 * @return
	 */
	public int reply(Reply re) {
		String sql = "insert into tbl_reply (replyid,title,content,publishtime,modifytime,uid,topicid) values (?,?,?,?,?,?,?)";
		return DBUtil.doUpdate(sql,null, re.getTitle(),re.getContent(),re.getPublishtime(),re.getModifytime(),re.getUserid(),re.getTopicid());
	}
	/**
	 * 获得板块名
	 * @param id
	 * @return
	 */
	public static Map<String, Object> getBoardName(int id) {
		String sql = "select boardname from tbl_board where boardid=?";
		return db.get(sql, id);
	}
	
	public static List<Map<String,Object>> query(){
		String sql = "select * from tbl_user";
		return db.list(sql);
	}

	public boolean checkUser(String name) {
		String sql = "select * from tbl_user where uname = ? ";
		return db.get(sql, name)!=null;
	}
	
	/**
	 * 帖子排行
	 * @return
	 */
	public List<Map<String, Object>> titleOrder() {
		String sql=
				"SELECT a.*,b.replyid,count(a.topicid) num from\n"
				+ " tbl_topic a,tbl_reply b\n"
				+ " WHERE a.topicid=b.topicid\n"
				+ " GROUP BY a.topicid\n"
				+ " ORDER BY num DESC\n"
				+ " limit 0,5";
		return db.list(sql);
	}
	
	/**
	 * 人物排行
	 * @return
	 */
	public List<Map<String, Object>> nameOrder() {
		String sql=
				 "SELECT uid,uname,head,COUNT(uid) num\n"
				+ " FROM\n"
				+ " (SELECT uname,head,b.uid uid FROM\n"
				+ " tbl_topic a,tbl_user b\n"
				+ " WHERE a.uid = b.uid) c\n"
				+ " GROUP BY uname\n"
				+ " ORDER BY num DESC"
				+ " LIMIT 0,3";
		return db.list(sql);
	}
	
	/**
	 * 获得用户信息
	 */
	public List<Map<String, Object>> getUser(int id) {
		
		
		String sql = " SELECT  \n" +
				"				 	a.uname, \n" +
				"				a.uid,\n" +
				"			 a.regtime, \n" +
				"			 	a.head, \n" +
				"			 	a.person, \n" +
				"			 a.type, \n" +
				"				 	b.topicid,b.title,b.content,b.publishtime,b.modifytime,b.boardid,b.count, \n" +
				"				 	c.cnt  \n" +
				"				 FROM \n" +
				"				 tbl_topic AS b \n" +
				"				 	right JOIN tbl_user AS a ON a.uid = b.uid \n" +
				"			 	left JOIN ( SELECT count( * ) AS cnt, uid FROM tbl_topic WHERE uid = ? ) AS c ON c.uid = a.uid  \n" +
				"				 WHERE \n" +
				"				 	a.uid = ?  \n" +
				"				 ORDER BY \n" +
				"			 	b.topicid DESC ";
		
		return db.list(sql, id,id);
		
	}

	
}
