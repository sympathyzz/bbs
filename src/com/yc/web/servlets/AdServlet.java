package com.yc.web.servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yc.dao.AdDao;

/**
 * Servlet implementation class AdServlet
 */
@WebServlet("/ad.s")
public class AdServlet extends BaseServlet {
	
	private static final long serialVersionUID = 1L;
	private AdDao td=new AdDao();
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		countNum(request,response);
	}
	protected void countNum(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aid=request.getParameter("aid");
		List<Map<String, Object>> data=td.getadCount(aid);
		
		int count=(int)data.get(0).get("count");
		
			td.addadCount(count,aid);
			
			count=count+1;
			
		if(count==5){
			response.getWriter().write("yes");	
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	

}
