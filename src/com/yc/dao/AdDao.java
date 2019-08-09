package com.yc.dao;

import java.util.List;


import java.util.Map;

import com.yc.utils.DBUtil;

public class AdDao {
	
	
	public List<Map<String, Object>>  getadCount(String aid){
		String sql= "select count from adcount where aid=?";
		return DBUtil.list(sql,aid);
	}
	public void  addadCount(int count,String aid){
		String sql= "update adcount set count=? where aid=?";
		 DBUtil.doUpdate(sql,count+1,aid);
	}
	
	public Map<String, Object> getAd(){
		String sql="select a.* from adcount a LEFT JOIN adcount b ON a.aid = b.aid where a.count <b.acount";
		List<Map<String, Object>> data= DBUtil.list(sql);
		
		
		if(data!=null){
			return data.get(0);
		}else{
			return null;
		}
		
	}
	public int delAd(String adname) {
		String sql="delete  from adcount where adname=?";
		return DBUtil.doUpdate(sql,adname);
	}
	public int addAd(String adname, String img, String href, int acount) {
		String sql="insert into adcount values(null,?,?,?,0,?)";
		return DBUtil.doUpdate(sql,adname,img,href,acount);
	}
}
