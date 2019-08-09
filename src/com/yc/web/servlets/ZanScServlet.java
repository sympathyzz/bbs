package com.yc.web.servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.yc.dao.ZanScDao;


@WebServlet("/ZSc.s")
public class ZanScServlet extends BaseServlet {
	
	private static final long serialVersionUID = 1L;
	
	private ZanScDao td=new ZanScDao();
	

	public void zan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String title=request.getParameter("title");
		String uname=request.getParameter("uname");
		
		if(request.getParameter("count")==null){
			List<Map<String, Object>> list = td.isgreat(title,uname);
			if(list!=null&&list.size()>0){
				response.getWriter().write("yes");
			}else{
				response.getWriter().write("no");	
			}
		}else if(uname.equals("")){
			response.getWriter().write("login");	
			}else{
			int count = 0;
			String c = request.getParameter("count");
			if(c!=null&&c!="") {
				count = Integer.valueOf(c);
			}
			List<Map<String, Object>> list = td.isgreat(title,uname);
			if(list!=null&&list.size()>0){
				td.delzan(title, count,uname);
				response.getWriter().write("no");	
			}else{
				td.addzan(title, count,uname);
				response.getWriter().write("yes");	
			}
			}
	}
	public void collect(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String title = request.getParameter("title");

		String uname = request.getParameter("uname");

		if (request.getParameter("count") == null) {
			List<Map<String, Object>> list = td.iscollect(title, uname);
			if (list != null && list.size() > 0) {
				response.getWriter().write("yes");

			} else {
				response.getWriter().write("no");
			}
		} else if (uname.equals("")) {
			response.getWriter().write("login");
		} else {
			List<Map<String, Object>> list = td.iscollect(title, uname);
			if (list != null && list.size() > 0) {
				td.delsc(title, uname);
				response.getWriter().write("no");
			} else {
				td.addsc(title, uname);
				response.getWriter().write("yes");
			}
		}
	}
	
	public void getMyCollect(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		List<Map<String,Object>> list = td.getMyCollect(uid);
		if(list == null) {
			response.getWriter().append("-1");
		}else {
			String json = JSON.toJSONString(list);
			response.getWriter().append(json);
		}
	}



}
