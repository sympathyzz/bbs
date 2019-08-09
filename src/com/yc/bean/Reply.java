package com.yc.bean;

import java.io.Serializable;
import java.sql.Timestamp;

public class Reply implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer replyid;
	private String title;
	private String content;
	private Timestamp publishtime;
	private Timestamp modifytime;
	private Integer userid;
	private Integer topicid;
	
	public Integer getReplyid() {
		return replyid;
	}
	public void setReplyid(Integer replyid) {
		this.replyid = replyid;
	}
	@Override
	public String toString() {
		return "Reply [replyid=" + replyid + ", title=" + title + ", content=" + content + ", publishtime="
				+ publishtime + ", modifytime=" + modifytime + ", userid=" + userid + ", topicid=" + topicid + "]";
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
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getTopicid() {
		return topicid;
	}
	public void setTopicid(Integer topicid) {
		this.topicid = topicid;
	}
	
	
}
