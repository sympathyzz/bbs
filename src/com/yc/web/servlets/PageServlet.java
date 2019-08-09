package com.yc.web.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yc.bean.Board;
import com.yc.bean.Topic;
import com.yc.biz.impl.PageBiz;
@WebServlet("/page")
public class PageServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * list.jsp页面的上一页
	 * @param req
	 * @param resp
	 */
	public void listNext(HttpServletRequest req, HttpServletResponse resp) {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		int boardid = Integer.parseInt(req.getParameter("boardid"));
		Board b = new Board();
		b.setBoardid(boardid);
		PageBiz pb = new PageBiz();
		if(pageNum >= pb.getTotalPage(b, 3)) {
			req.setAttribute("msg", "已经是最后一页");
			try {
				req.getRequestDispatcher("topic?op=list").forward(req, resp);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		pageNum+=1;
		try {
			req.getRequestDispatcher("topic?op=list&pageNum="+pageNum).forward(req, resp);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * list.jsp页面的下一页
	 * @param req
	 * @param resp
	 */
	public void listLast(HttpServletRequest req, HttpServletResponse resp) {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		if(pageNum == 1) {
			req.setAttribute("msg", "已经是首页");
			try {
				req.getRequestDispatcher("topic?op=list").forward(req, resp);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return;
		}
		pageNum-=1;
		try {
			req.getRequestDispatcher("topic?op=list&pageNum="+pageNum).forward(req, resp);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * dedail.jsp页面的上一页
	 * @param req
	 * @param resp
	 */
	public void detailNext(HttpServletRequest req, HttpServletResponse resp) {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		int topicid = Integer.parseInt(req.getParameter("topicid"));
		Topic topic = new Topic();
		topic.setTopicid(topicid);
		PageBiz pb = new PageBiz();
		if(pageNum >= pb.getTotalPage(topic, 3)) {
			System.out.println(pageNum+"--->"+pb.getTotalPage(topic, 3));
			req.setAttribute("msg", "已经是最后一页");
			try {
				req.getRequestDispatcher("topic?op=detail").forward(req, resp);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			return;
		}
		pageNum+=1;
		try {
			req.getRequestDispatcher("topic?op=detail&pageNum="+pageNum).forward(req, resp);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * detail.jsp页面的下一页
	 * @param req
	 * @param resp
	 */
	public void detailLast(HttpServletRequest req, HttpServletResponse resp) {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		if(pageNum == 1) {
			req.setAttribute("msg", "已经是首页");
			try {
				req.getRequestDispatcher("topic?op=detail").forward(req, resp);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		pageNum-=1;
		try {
			req.getRequestDispatcher("topic?op=detail&pageNum="+pageNum).forward(req, resp);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
		
	}
	
}
