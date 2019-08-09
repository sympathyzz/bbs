package com.yc.websocket;

 
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.yc.bean.User;
import com.yc.dao.BoardDao;
import com.yc.web.servlets.BaseServlet;
 
@WebServlet(name="BitCoinDataCenter",urlPatterns = "/BitCoinDataCenter",loadOnStartup=1) //标记为Servlet不是为了其被访问，而是为了便于伴随Tomcat一起启动
public class BitCoinDataCenter extends BaseServlet implements Runnable{
 
	protected String op;

	
	//给所有与websocket的客户端发送消息的方法
	public void send(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		BoardDao bd = new BoardDao();
		String msg = req.getParameter("msg");
		String uid = req.getParameter("uid");
		Map<String, Object> user = bd.getUser0(Integer.valueOf(uid));
	
		Map<String,Object> map = new HashMap<>();
		map.put("msg", msg);
		map.put("op", "send");
		map.put("user", user);
		String jsonString = JSON.toJSONString(map);
		ServerManager.broadCast(jsonString);
	}
	
	
	//更改所有客户端在线人数、用户登陆情况
	public void login(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
		
		BoardDao bd = new BoardDao();
		Map<String,Object> map = new HashMap<>();
		String uid = req.getParameter("uid");
		Map<String, Object> user = bd.getUser0(Integer.valueOf(uid));
		
		
		 List<User> ous= (List<User>) req.getSession().getServletContext().getAttribute("onlineUsers");
		 Integer cnt = 1;
		 
		 //聊天室在线人数+1
		 if(req.getServletContext().getAttribute("cnt")==null) {
			 req.getServletContext().setAttribute("cnt",1);
		 }else {
			  cnt = (Integer) req.getServletContext().getAttribute("cnt")+1;
			  req.getServletContext().setAttribute("cnt",cnt);
		 }
		 
		 
		 
		 
		 
		//把这个在线用户标记为加入了聊天室
		 if(ous.size()>0) {
			 for(int i = 0;i<ous.size();i++) {
				 if(String.valueOf(ous.get(i).getUid()).equals(uid)) {
					ous.get(i).isChat = 1;//加入了聊天室
				 }
			 }
		 }
		
		
		map.put("user",user);
		map.put("op", "login");
		map.put("cnt", cnt);
		
		String jsonString = JSON.toJSONString(map);
		
		ServerManager.broadCast(jsonString);
	}
	
	
	//加载其它用户信息
	public void login1(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		BoardDao bd = new BoardDao();
		Map<String,Object> map = new HashMap<>();
		Integer uid = Integer.valueOf(req.getParameter("uid"));
		Map<String, Object> user = bd.getUser0(uid);
		
		 List<User> ous0= (List<User>) req.getSession().getServletContext().getAttribute("onlineUsers");
		 List<User> ous = new ArrayList<>();
		 ous.addAll(ous0);
		 
		 String cnt = String.valueOf(ous.size());
		 
		 
		 //把自己去掉，防止重复加载
//		 for(int i = 0;i<ous.size();i++) {
//			 if(uid.equals(ous.get(i).getUid())) {
//				 ous.remove(i);
//			 }
//		 }
		 
		 Iterator<User> it = ous.iterator();
		 while(it.hasNext()) {
			if(uid.equals(it.next().getUid())) {
				it.remove();
			}
		 }
		 
		 
		 
		  
		 //把没有加入聊天室的去掉  删除元素不推荐用这个方法
//		 for(int i = 0;i<ous.size();i++) {
//			 if(ous.get(i).isChat == 0) {
//				 ous.remove(i);
//				 i--;//循环删除的大坑！！！！
//			 }
//		 }
		 
		 Iterator<User> iterator = ous.iterator();
		 while(iterator.hasNext()) {
			 if(iterator.next().isChat==0) {
				 iterator.remove();
			 }
		 }
		 
		 
		map.put("ous",ous);
		map.put("op", "login1");
		
		String jsonString = JSON.toJSONString(map);
		resp.getWriter().print(jsonString.trim());
	}
	
	
	
	//用户下线
	public void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		
		BoardDao bd = new BoardDao();
		Map<String,Object> map = new HashMap<>();
		Integer uid = Integer.valueOf(req.getParameter("uid"));
		Map<String, Object> user = bd.getUser0(uid);
		
		 List<User> ous= (List<User>) req.getSession().getServletContext().getAttribute("onlineUsers");
			
		 Integer cnt = (Integer) req.getServletContext().getAttribute("cnt");
		//把这个在线用户标记为退出了聊天室
		 if(ous.size()>0) {
			 for(int i = 0;i<ous.size();i++) {
				 if(uid.equals(ous.get(i).getUid())) {
					 ous.get(i).isChat = 0;//退出聊天室
					  cnt--;
					  req.getServletContext().setAttribute("cnt", cnt);
				 }
			 }
		 }
		map.put("user",user);
		map.put("op", "logout");
		map.put("cnt", cnt);
		
		String jsonString = JSON.toJSONString(map);
		
		ServerManager.broadCast(jsonString);
	}
	
	
	
	
	@Override
	public void run() {
		
	}
}