package com.yc.web.servlets;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yc.bean.PageBean;
import com.yc.bean.Reply;
import com.yc.bean.Topic;
import com.yc.biz.impl.BizException;
import com.yc.biz.impl.TopicBiz;
import com.yc.biz.impl.UserImpl;
import com.yc.dao.ListDao;
import com.yc.filter.WordFilter;

@WebServlet("/topic")
public class TopicServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	private PageBean pg = new PageBean();
	UserImpl ui = new UserImpl();
	WordFilter wf = new WordFilter();

	/**
	 * 查看帖子信息
	 * 
	 * @param req
	 * @param resp
	 */
	public void list(HttpServletRequest req, HttpServletResponse resp) {
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		int pageSize = 3;
		pg.setPageNum(pageNum);
		pg.setPagesize(pageSize);
		String boardid = (String) req.getParameter("boardid");
		String boardname = (String) req.getParameter("boardname");
		HttpSession session = req.getSession();
		session.setAttribute("boardid", boardid);
		session.setAttribute("boardname", boardname);

		List<Map<String, Object>> data = ListDao.getList(boardid, pg);

		req.setAttribute("data", data);

		try {
			req.getRequestDispatcher("list.jsp").forward(req, resp);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 发布帖子
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	public void post(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Topic topic = new Topic();
		TopicBiz tp = new TopicBiz();
		int userid = -1;

		userid = Integer.parseInt(new String(req.getParameter("userid")));

		String title = new String(req.getParameter("title"));
		String content = new String(req.getParameter("content"));

		// 敏感词处理
		title = wf.WordFilter(title);
		content = wf.WordFilter(content);

		// 帖子设置
		int boardid = Integer.parseInt(new String(req.getParameter("boardid")));
		topic.setBoardid(boardid);
		topic.setUserid(userid);
		topic.setTitle(title);
		topic.setContent(content);

		try {
			tp.post(topic);
			
			//发贴成功增加经验值
			ui.growExp(topic.getUserid(),3);
			req.getSession().setAttribute("suc", "1");
			resp.sendRedirect("topic?op=list&pageNum=1&boardid=" + topic.getBoardid());
		} catch (BizException e) {
			req.setAttribute("msg", e.getMessage());
			req.getRequestDispatcher("post.jsp").forward(req, resp);
		}
	}

	/**
	 * 加载detail.jsp页面内容
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 * @throws ServletException
	 */
	public void detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int id = Integer.parseInt(req.getParameter("topicid"));
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		PageBean page = new PageBean();
		page.setPageNum(pageNum);
		page.setPagesize(3);
		TopicBiz topic = new TopicBiz();

		List<Map<String, Object>> list = topic.detail(id, page);

		req.setAttribute("data", list);

		req.getRequestDispatcher("detail.jsp").forward(req, resp);

	}

	/**
	 * 回复
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 * @throws ServletException
	 */
	public void reply(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		String title = new String(req.getParameter("title"));
		String content = new String(req.getParameter("content"));

		// 敏感词处理
		title = wf.WordFilter(title);
		content = wf.WordFilter(content);

		int topicid = Integer.parseInt(req.getParameter("topicid"));
		int userid = -1;
		try {
			userid = Integer.parseInt(req.getParameter("userid"));
		} catch (NumberFormatException e2) {

		}

		Timestamp time = new Timestamp(System.currentTimeMillis());
		Reply reply = new Reply();
		reply.setContent(content);
		reply.setModifytime(time);
		reply.setPublishtime(time);
		reply.setTitle(title);
		reply.setTopicid(topicid);
		reply.setUserid(userid);

		TopicBiz tb = new TopicBiz();
		try {
			tb.reply(reply);
			//回成功增加经验值1
			ui.growExp(reply.getUserid(),1);
			req.getSession().setAttribute("suc", "1");
			resp.sendRedirect("topic?op=detail&topicid=" + topicid + "&pageNum=1");
			
		} catch (BizException e) {

			req.setAttribute("msg", e.getMessage());
			req.getRequestDispatcher("reply.jsp").forward(req, resp);
			
		}
		
	

	}
}
