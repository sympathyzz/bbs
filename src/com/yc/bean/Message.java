package com.yc.bean;

import java.sql.Timestamp;

public class Message {
	private int messgeid;
	private int forname;
	private int toName;
	private String messgeText;
	private Timestamp messageDate;
	public int getMessgeid() {
		return messgeid;
	}
	public void setMessgeid(int messgeid) {
		this.messgeid = messgeid;
	}
	public int getForname() {
		return forname;
	}
	public void setForname(int forname) {
		this.forname = forname;
	}
	public int getToName() {
		return toName;
	}
	public void setToName(int toName) {
		this.toName = toName;
	}
	public String getMessgeText() {
		return messgeText;
	}
	public void setMessgeText(String messgeText) {
		this.messgeText = messgeText;
	}
	public Timestamp getMessageDate() {
		return messageDate;
	}
	public void setMessageDate(Timestamp messageDate) {
		this.messageDate = messageDate;
	}
}
