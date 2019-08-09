package com.yc.biz.impl;

import java.util.Map;

import com.yc.bean.Board;
import com.yc.bean.Topic;
import com.yc.dao.PageDao;

public class PageBiz {
	//获得Board的总记录数
	private PageDao pd = new PageDao();
	public int getTotalPage(Board b,int size){
		Map<String,Object> map = pd.getTotalPage(b);
		Number num =  (Number) map.get("cnt"); 
		int cnt = num.intValue();
		if(cnt/size == 0) {
			return cnt/size;
		}else {
			return cnt/size + 1;
		}
	}
	//获得topic的总记录数
	public int getTotalPage(Topic t,int size){
		Map<String,Object> map = pd.getTotalPage(t);
		Number num =  (Number) map.get("cnt"); 
		int cnt = num.intValue();
		if(cnt/size == 0) {
			return cnt/size;
		}else {
			return cnt/size + 1;
		}
	}
}
