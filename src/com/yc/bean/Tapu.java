package com.yc.bean;

import java.sql.Timestamp;

public class Tapu {
	private int uid;
	private Timestamp tapuTime;
	private Timestamp conTime;
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public Timestamp getTapuTime() {
		return tapuTime;
	}
	public void setTapuTime(Timestamp tapuTime) {
		this.tapuTime = tapuTime;
	}
	public Timestamp getConTime() {
		return conTime;
	}
	public void setConTime(Timestamp conTime) {
		this.conTime = conTime;
	}
}
