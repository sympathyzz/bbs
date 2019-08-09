package com.yc.biz.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.yc.bean.Message;
import com.yc.dao.SocketDao;

public class SocketBiz {
	public void setChat(Message message) {
		Timestamp time = new Timestamp(System.currentTimeMillis());
		message.setMessageDate(time);
		SocketDao sb = new SocketDao();
		sb.setChat(message);
	}
	
	public List<Map<String,Object>> getChat(int uid) {
		SocketDao sb = new SocketDao();
		return sb.getChat(uid);
	}

	public List<Map<String,Object>> getRealMessage(int forname, int toname) {
		SocketDao sb = new SocketDao();
		List<Map<String,Object>> list =  sb.getRealMessage(forname, toname);
		sb.delRealMessage(forname, toname);
		return list;
	}
}
