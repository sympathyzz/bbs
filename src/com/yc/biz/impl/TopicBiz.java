package com.yc.biz.impl;


import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yc.bean.PageBean;
import com.yc.bean.Reply;
import com.yc.bean.Topic;
import com.yc.dao.BoardDao;
import com.yc.dao.ListDao;
import com.yc.dao.UserDao;

public class TopicBiz {
	private ListDao li = new ListDao();
	private BoardDao bd = new BoardDao();
	//发送帖子的方法
	public void post(Topic topic) throws BizException {
		
		
		Timestamp date =  new Timestamp(System.currentTimeMillis());
	
		if(topic.getTitle().length() < 2) {
			throw new BizException("标题不能少于2个字符");
		}
		if(topic.getContent().length() <= 10) {
			throw new BizException("内容不能少于10个字符");
			
		}
		UserDao ud = new UserDao();
		Map<String,Object>  map = (Map<String, Object>) ud.getTapu(topic.getUserid());
		if(map != null) {
			Long time1 = date.getTime();
			Long time2 = ((Timestamp)map.get("contime")).getTime();
			if(time1 <= time2) {
				throw new BizException("您目前属于禁言状态，无法发布帖子与回帖");
			}
			
		}

		topic.setModifytime(date);
		topic.setPublishtime(date);
		
		if(li.post(topic) <= 0) {
			throw new BizException("服务器繁忙,请稍后再试");
		}
	}
	
	public List<Map<String,Object>> detail(int id,PageBean page) {
		return li.detail(id,page);
	}
	//回帖的方法
	public void reply(Reply re) throws BizException {
		UserDao ud = new UserDao();
		Map<String,Object>  map = (Map<String, Object>) ud.getTapu(re.getUserid());
		if(map != null) {
			Timestamp date =  new Timestamp(System.currentTimeMillis());
			Long time1 = date.getTime();
			Long time2 = ((Timestamp)map.get("contime")).getTime();
			if(time1 <= time2) {
				throw new BizException("您目前属于禁言状态，无法发布帖子与回帖");
			}
			
		}
		
		
		
		if(re.getContent().length() == 0 || re.getTitle().length() == 0) {
			throw new BizException("回复内容不能为空");
		}else {
			if(bd.reply(re) > 0) {
				return;
			}else {
				throw new BizException("回帖失败");
			}
		}
	}
	//获得板块详情
	public Map<String, Object> getBoard(int boardid ) {
		return li.getBoard(boardid);
	}
	
	
	
}
