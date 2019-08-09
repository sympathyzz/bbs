package com.yc.web.servlets;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.yc.bean.User;
import com.yc.biz.impl.SocketBiz;

@WebServlet("/socket")
public class SocketServlet extends BaseServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void getChat(HttpServletRequest req, HttpServletResponse resp) {
		
		
		User user = (User) req.getSession().getAttribute("user");
		SocketBiz sb  = new SocketBiz();
		List<Map<String,Object>> list = null;
		if(user!=null) {
			list = sb.getChat(user.getUid());
		}
		req.getSession().setAttribute("chatData", list);
		try {
			if(list == null) {
				resp.getWriter().append("no");
			}else {
				resp.getWriter().append("yes");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void getRealMessage(HttpServletRequest req, HttpServletResponse resp) {
		int toname = Integer.parseInt(req.getParameter("toname"));
		int forname = Integer.parseInt(req.getParameter("forname"));
		SocketBiz sb  = new SocketBiz();
		List<Map<String,Object>> list = sb.getRealMessage(forname,toname);
		String json = JSON.toJSONString(list);
		try {
			req.setCharacterEncoding("utf-8");
            resp.setContentType("text/html;charset=utf-8");
			resp.getWriter().append(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
