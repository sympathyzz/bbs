package com.yc.bean;

import java.io.Serializable;

public class Board implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int  boardid;
	private String boardname;
	private int parentid;
	public int getBoardid() {
		return boardid;
	}
	public void setBoardid(int boardid) {
		this.boardid = boardid;
	}
	public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname = boardname;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	
	
}
