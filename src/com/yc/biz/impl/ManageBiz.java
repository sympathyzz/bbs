package com.yc.biz.impl;

import java.sql.Timestamp;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.yc.bean.User;
import com.yc.dao.AdDao;
import com.yc.dao.ManageDao;



public class ManageBiz {
	private ManageDao md = new ManageDao();
	private AdDao ad = new AdDao();
	public List<Map<String,Object>> getUser(String flag) throws BizException {
		List<Map<String,Object>> list  = md.getUser(flag);
		if(list != null) {
			return list;
		}else {
			throw new  BizException("no");
		}
		
	}
	public int Addmanage(String uid) {
		return md.Addmanage(uid);
	}
	public int Cenclemanage(String uid) {
		return md.cancel(uid);
	}
	public List<Map<String, Object>> getReport(int pageNum,int pageSize) {
		return md.getReport(pageNum,pageSize);
		
	}
	public int delReport(int reportid) {
		return md.delReport(reportid);
	}
	public List<Map<String, Object>> manageTapu(String id) throws BizException {
		List<Map<String, Object>> list = md.manageTapu(id);
		if(list != null) {
			return list;
		}else {
			throw new  BizException("no");
		}
	}
	public int cencelTapu(int uid) {
		return md.cencelTapu(uid);
	}
	public int AddFather(String content) {
		int index =  md.addFather(content);
		if(index == 0) {
			return 0;
		}else if(index > 0) {
			return 1;
		}else {
			return -1;
		}
		
	}
	public List<Map<String, Object>> getFather() {
		
		return md.getFather();
	}
	public int addChild(int index, String content) {
		int flag = md.addChlid(index,content);
		if(flag == 0) {
			return 0;
		}else if(flag > 0) {
			return 1;
		}else {
			return -1;
		}
		
	}
	public int delFather(int index) {
		return md.delFather(index);
		
	}
	
	public int delChild(int index) {
		return md.delChild(index);
		
	}
	public List<Map<String, Object>> getChild(int index) {
		
		return md.getChild(index);
	}
	public int getReportTotal() {
		Map<String,Object> map =  md.getReportTotal();
		if(map != null) {
			return Integer.parseInt( map.get("cnt").toString());
		}else {
			return 0;
		}
		
	}
	public List<Map<String, Object>> query(Integer pageNum, Integer pageSize) {
		return md.query(pageNum,pageSize);
	}
	
	public int getUserTotal() {
		Map<String,Object> map =  md.getUserTotal();
		if(map != null) {
			return Integer.parseInt( map.get("cnt").toString());
		}else {
			return 0;
		}
		
	}
	public List<Map<String, Object>> getTapu(Integer pageNum, Integer pageSize) {
		return md.getTapu(pageNum,pageSize);
	}
	public int getTapuTotal() {
		Map<String,Object> map =  md.getUserTotal();
		if(map != null) {
			return Integer.parseInt( map.get("cnt").toString());
		}else {
			return 0;
		}
		
	}
	public int tapu(int uid, int day) throws BizException {
		if(md.getTapu(uid) != null) {
			throw new BizException("用户目前禁言状态未取消，无需重复禁言");
		}
		Timestamp tapuTime = new Timestamp(System.currentTimeMillis());
		Long time = System.currentTimeMillis()+day*86400000L;
		Timestamp conTime = new Timestamp(time);
		return md.tapu(uid,tapuTime,conTime);
	}
	
	public int delAd(String adname) {
		// TODO Auto-generated method stub
		return ad.delAd(adname);
	}
	public int addAd(String adname, String img, String href, int acount) {
		// TODO Auto-generated method stub
		return ad.addAd(adname,img,href,acount);
	}
}
