<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.yc.dao.TopicDao"%>
    <%
	    request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String aid=request.getParameter("aid");
		TopicDao td=new TopicDao();
		List<Map<String, Object>> data=td.getadCount(aid);
		int count=(int)data.get(0).get("count");
			td.addadCount(count,aid);
			count=count+1;
		if(count==5){
			response.getWriter().write("yes");	
		}
	
		
    %>
