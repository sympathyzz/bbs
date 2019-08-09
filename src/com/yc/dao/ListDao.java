package com.yc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yc.bean.PageBean;
import com.yc.bean.Topic;
import com.yc.utils.DBUtil;

public class ListDao {
	/**
	 * 获得list.jsp页面信息
	 * @param boardid
	 * @param page
	 * @return
	 */
	public static  List<Map<String, Object>> getList(String boardid,PageBean page){
		String sql = "    \n" +
				"SELECT   \n" +
				"				 	*  \n" +
				"				 FROM \n" +
				"				 	(  \n" +
				"				 	SELECT \n" +
				"				 		a.uname, \n" +
				"				 		b.*,\n" +
				"						x.replycnt\n" +
				"				\n" +
				"				 	FROM \n" +
				"				 		( SELECT uname, uid FROM tbl_user WHERE uid = ANY ( SELECT uid FROM tbl_topic WHERE boardid = ? ) ) AS a \n" +
				"				 		 LEFT JOIN tbl_topic AS b ON a.uid = b.uid\n" +
				"				  	  LEFT JOIN (SELECT count(*)+1 replycnt,topicid FROM tbl_reply GROUP BY(topicid)) as x ON x.topicid = b.topicid	\n" +
				"				 	WHERE \n" +
				"				 		b.boardid = ?  \n" +
				"				  	) AS c\n" +
				"				 ORDER BY \n" +
				"				 topicid DESC LIMIT ?,? ";
		Integer id = Integer.parseInt(boardid); 
		List<Map<String, Object>> result = DBUtil.list(sql,id,id,(page.getPageNum()-1)*page.getPagesize(),page.getPagesize());
		return result;
	}
	/**
	 * 回复的方法
	 * @param topic
	 * @return
	 */
	public int post(Topic topic) {
		
		String sql ="insert into tbl_topic (topicid,title,content,publishtime,modifytime,uid,boardid) values (null,?,?,?,?,?,?)";
		
		return DBUtil.doUpdate(sql, topic.getTitle(),topic.getContent(),topic.getPublishtime(),topic.getPublishtime(),topic.getUserid(),topic.getBoardid());
	}
	/**
	 * 获得帖子详情和回复的方法
	 */
	public List<Map<String,Object>> detail(int topicid,PageBean page) {
		
		
		
		
		
		String sql = "select * from (\n" +
				"	select a.uname,a.head,a.regtime,a.person,b.* from tbl_user as a\n" +
				"				join tbl_topic as b \n" +
				"				on a.uid = b.uid\n" +
				"				where topicid = ? \n" +
				"				union all\n" +
				"				select a.uname,a.head,a.regtime,a.person,b.* from tbl_user as a\n" +
				"				join tbl_reply as b\n" +
				"				on a.uid = b.uid \n" +
				"				where topicid = ?\n" +
				") as a limit ?,?";
		
		
		
		
		return DBUtil.list(sql, topicid, topicid,(page.getPageNum()-1)*page.getPagesize(),page.getPagesize());
	}
	/**
	 *获得回复详情的方法
	 */
	public static List<Map<String, Object>> getReply(int id) {
		String sql = "select a.uname,b.* from (select uname,uid from tbl_user where uid =  any(select uid from tbl_reply where topicid = ?)) as a left join tbl_reply as b on a.uid = b.uid";
		return DBUtil.list(sql, id);
	}
	/**
	 * 获得板块详情
	 * @param boardid
	 * @return
	 */
	public static Map<String,Object> getBoard(int boardid){
		String sql = "select a.topicid,a.title,a.publishtime,a.uid,b.uname from tbl_topic as a  \n" +
				"join\n" +
				"tbl_user as b\n" +
				"on a.uid = b.uid\n" +
				"where boardid = ? limit 1";
		Map<String,Object> map = new HashMap<>();
		if(DBUtil.get(sql, boardid) == null) {
			map.put("uname", "0");
			map.put("uid", "null");
			map.put("title","null");
			map.put("publishtime","null");
			map.put("topicid","null");
		}else {
			map=DBUtil.get(sql, boardid);
		}
		return map;
	}
}
