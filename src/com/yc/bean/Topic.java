package com.yc.bean;

import java.io.Serializable;
import java.sql.Timestamp;

public class Topic implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int topicid;
	private String title;
	private String content;
	private Timestamp publishtime;
	private Timestamp modifytime;
	private int userid;
	private int boardid;
	public int getTopicid() {
		return topicid;
	}
	public void setTopicid(int topicid) {
		this.topicid = topicid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getPublishtime() {
		return publishtime;
	}
	public void setPublishtime(Timestamp publishtime) {
		this.publishtime = publishtime;
	}
	public Timestamp getModifytime() {
		return modifytime;
	}
	public void setModifytime(Timestamp modifytime) {
		this.modifytime = modifytime;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getBoardid() {
		return boardid;
	}
	public void setBoardid(int boardid) {
		this.boardid = boardid;
	}
	
	
}
