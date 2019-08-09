package com.yc.web.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.yc.dao.BoardDao;
@WebServlet("/index")
public class IndexServlet extends BaseServlet{
	private BoardDao bd = new BoardDao();
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 获得首页数据
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	public void getIndex(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Map<String, Object>> list = bd.getIndex();
		req.setAttribute("data",list);
		
	 //加入帖子排列和风云人物
	 List<Map<String,Object>> data1=bd.titleOrder();
	 List<Map<String,Object>> data2=bd.nameOrder();
	
	  req.setAttribute("data1",data1);
	  req.setAttribute("data2",data2);
	  
		
	  req.getRequestDispatcher("index.jsp?pageNum=1").forward(req, resp);
		
		
	}
	/**
	 * 获得首页数据将其写入ajax
	 * @param req
	 * @param resp
	 */
	public void index(HttpServletRequest req, HttpServletResponse resp) {
		List<Map<String, Object>> list = bd.getIndex();
		String data = JSON.toJSONString(list);
		try {
			resp.getWriter().append(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

}
