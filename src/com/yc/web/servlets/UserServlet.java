package com.yc.web.servlets;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;

import com.alibaba.fastjson.JSON;
import com.sun.mail.imap.OlderTerm;
import com.yc.bean.Report;
import com.yc.bean.User;
import com.yc.biz.impl.BizException;
import com.yc.biz.impl.UserImpl;
import com.yc.dao.BoardDao;
import com.yc.listener.OnlineUser;
import com.yc.utils.Encrypt;
@WebServlet("/user.s")
public class UserServlet extends BaseServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BoardDao bd = new BoardDao();
	private UserImpl ui = new UserImpl();
	
	/**
	 * 用户登录
	 * @param req
	 * @param resp
	 * @throws IllegalAccessException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 * @throws InstantiationException
	 * @throws ServletException
	 * @throws IOException
	 */
	public void login(HttpServletRequest req, HttpServletResponse resp) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, InstantiationException, ServletException, IOException {
		String path = (String) req.getSession().getAttribute("call_backPath");
		Map<String,String[]> map = (Map<String, String[]>) req.getSession().getAttribute("call_backPram");
		
//		String val_code1 = req.getParameter("val_code");
//		String val_code2 = (String)req.getSession().getAttribute("rand");
		
		String uname = req.getParameter("uname");
		String p = req.getParameter("upass");
		System.out.println(uname);
		System.out.println(p);
		String upass = Encrypt.sha(p);
		
		
	
	 	User user = new User();
		user.setUname(uname);
		user.setUpass(upass);
	 	 
		UserImpl ui = new UserImpl();
		User u = new User();
		
		
		try {
				u = ui.login(user);
				if(u==null) {
					resp.getWriter().print("-1");
					return;
				}
				
				
				HttpSession session = req.getSession();
				session.setAttribute("user", u);
			
			if(session.getAttribute(""+u.getUid())==null) {
				
				//把登陆用户注册为监听用户
				OnlineUser ou = new OnlineUser();
				ou.setUser(u);
				session.setAttribute(""+u.getUid(), ou);
			}
			
			
				//单一设备登陆:用户登陆时，在服务器(application)上生成一个与用户对应的UUID map(uid,UUID)，用户每次访问其它页面时，都会判断这个UUID是否改变
				//如果在其它设备登陆，UUID被改写，当原有用户访问其它页面时，会提示用户该账号在其它设备登陆 ，并强制下线
				
				//第一次启动服务器,新建map映射表
				if(req.getServletContext().getAttribute("usermap")==null) {
					
					Map<Integer,UUID> usermap = new HashMap<Integer,UUID>();
					UUID randomUUID = UUID.randomUUID();//不重复的随机数
					usermap.put(u.getUid(), randomUUID);//id ==>uuid 唯一对应关系
					
					req.getServletContext().setAttribute("usermap",usermap);//一份放服务器中
					session.setAttribute("usermap", usermap);//一份放session中
					System.out.println("第一次 "+u.getUid()+" "+randomUUID);
					
				}else {
					Map<Integer,UUID> usermap = (Map<Integer, UUID>) req.getServletContext().getAttribute("usermap");
					Map<Integer,UUID> usermap2 = new HashMap<Integer, UUID>();//防止数据丢失
					usermap2.putAll(usermap);
					
					UUID randomUUID = UUID.randomUUID();//不重复的随机数
					usermap2.put(u.getUid(), randomUUID);//服务器中的usermap被修改，如果是相同用户名，根据map的工作原理，第二次的value会把第一次的覆盖
					//如果是不同名用户，第二次的登陆不会影响之前的用户，这里的usermap保存了所有用户映射关系
					
					req.getServletContext().setAttribute("usermap", usermap2);
					
					System.out.println("第二次 "+u.getUid()+" "+randomUUID+" 服务器"+usermap2.get(u.getUid()));
					
					//为了减轻用户压力，不能把usermap直接放在会话中
					Map<Integer,UUID> m = new HashMap<Integer,UUID>();
					m.put(u.getUid(), randomUUID);
					session.setAttribute("usermap", m);//只保留了当前用户映射map放在session中
				}
				
				
				/*第二个登陆的用户会把第一个用户挤下线*/
				/*原理：用户第一次登陆时，生成一个 uid与UUID的键值对 ，把该键值对分别放session中和服务器缓存中，每次访问页面时，根据用户uid在session拿出UUID
				 * 和缓存中uid对应的UUID比较，相同则继续访问页面。(此时必然相同)
				 *  	第二次登陆时，用户根据uid可以在服务器缓存中有UUID判断出该账号已经登陆，是否继续登陆。
				 *  	如果继续登陆，同样分别保存两份uid_UUID键值对在session和服务器中
				 *  	但是，此时服务器上uid对应的UUID被第二次登陆的用户覆盖了！
				 *  	当第一个用户再次访问页面时，他session中的UUID和服务器中的UUID就不一样了！！
				 * 
				 * */
		
					
					if(path != null && map != null) {
						path += "?";
						for(Map.Entry<String, String[]> en : map.entrySet()) {
							path += en.getKey()+"="+en.getValue()[0]+"&";
						}
						String conPath = req.getContextPath();
						String name = conPath+path;
						session.removeAttribute("call_backPath");
						session.removeAttribute("call_backPram");
						
						resp.getWriter().append(name);
						
						return;
					}else {
						
						//String id = req.getSession().getId();
						resp.getWriter().append("index?op=getIndex");
						return;
					}	
					
			} catch (BizException e) {
				e.printStackTrace();
			}
			
		 
	}
	/**
	 * 用户注册
	 * @param req
	 * @param resp
	 */
	public void reg(HttpServletRequest req, HttpServletResponse resp) {
		String uname = req.getParameter("uName");
		String pwd1  = req.getParameter("uPass");
		String pwd2  = req.getParameter("uPass1");

		Integer gender =Integer.valueOf(req.getParameter("gender"));
		User user = new User();
		String head = req.getParameter("head");

		user.setUname(uname);
		user.setUpass(pwd1);
		user.setGender(gender);
		user.setHead(head);
		Timestamp time = new Timestamp(System.currentTimeMillis());
		user.setRegtime(time);
		try {
			UserImpl.reg(user,pwd2);
		} catch (BizException e1) {
			req.setAttribute("msg", e1.getMessage());
			try {
				req.getRequestDispatcher("reg.jsp").forward(req, resp);
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			resp.sendRedirect("login.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 *  优 化后的注册功能
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	
	public void newReg(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String uname = req.getParameter("uname");
		String psw1  = req.getParameter("password");
		String psw2 =  req.getParameter("password1");
		String phone =  req.getParameter("phone");
		String email =  req.getParameter("mail");
		String person =  req.getParameter("person");
		
		//后台验证
		try {
			ui.reg(uname,psw1,psw2,phone,email,person);
			resp.getWriter().append("0");
		} catch (BizException e) {
			e.printStackTrace();
			req.getSession().setAttribute("msg", e.getMessage());
			resp.getWriter().append("-1");
		}
	}
	
	
	/**
	 * 用户退出登录
	 * @param req
	 * @param resp
	 */
	public void delUser(HttpServletRequest req, HttpServletResponse resp) {
		String url =  req.getHeader("Referer");
		HttpSession session = req.getSession();
		session.removeAttribute("user");
		session.removeAttribute("boardname");
		try {
			resp.sendRedirect(url);
		} catch (IOException e) {
		
		}
	}
	/**
	 * 查询所有用户信息
	 * @param req
	 * @param resp
	 */
	public void query(HttpServletRequest req, HttpServletResponse resp) {
		List<Map<String,Object>> list = bd.query();
		
		String json = JSON.toJSONString(list);
		try {
			resp.getWriter().append(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 获得用户信息
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	public void getUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int uid = Integer.parseInt(req.getParameter("uid"));
		
		List<Map<String,Object>> list =  bd.getUser(uid);
		
		req.setAttribute("data", list);
		User user = (User) req.getSession().getAttribute("user");
		if(user==null) {
			req.getRequestDispatcher("start.jsp").forward(req, resp);
			return;
		}
		
		
		if(user.getUid() == uid){
			try {
				req.getRequestDispatcher("my.jsp").forward(req, resp);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			
			
			try {
				req.getRequestDispatcher("user.jsp").forward(req, resp);
			} catch (ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void report(HttpServletRequest req, HttpServletResponse resp) {
		int uid = Integer.parseInt(req.getParameter("uid"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		User user = (User) req.getSession().getAttribute("user");
		
		Report report = new Report();
		report.setReportid(user.getUid());
		report.setDefenid(uid);
		report.setTitle(title);
		report.setContent(content);
		int i = ui.report(report);
		if(i>0) {
			req.setAttribute("msg", "举报成功，管理员会及时查看信息是否属实");
			try {
				req.getRequestDispatcher("report.jsp").forward(req, resp);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			req.setAttribute("msg", "服务器繁忙，请稍后再试");
			try {
				req.getRequestDispatcher("report.jsp").forward(req, resp);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	
	
	/**
	 * 用户禁言方法
	 * @param req
	 * @param resp
	 */
	public void tapu(HttpServletRequest req, HttpServletResponse resp) {
		System.out.println(req.getParameter("uid"));
		int uid = Integer.parseInt(req.getParameter("uid"));
		int day = Integer.parseInt(req.getParameter("day"));
		UserImpl ui = new UserImpl();
		int i = 0;
		try {
			i = ui.tapu(uid,day);
		} catch (Exception e) {
			req.setAttribute("msg", e.getMessage());
			try {
				req.getRequestDispatcher("tapu.jsp").forward(req, resp);
			} catch (ServletException e1) {
				e1.printStackTrace();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		try {
			if(i > 0) {
				req.setAttribute("msg", "禁言成功");
				req.getRequestDispatcher("tapu.jsp").forward(req, resp);
			}else {
				req.setAttribute("msg", "服务器繁忙，请稍后再试");
				req.getRequestDispatcher("tapu.jsp").forward(req, resp);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 退出登陆 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */

	public void logOut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		User u = (User) req.getSession().getAttribute("user");
		if(u!=null) {
			req.getSession().removeAttribute(""+u.getUid());
			req.getSession().removeAttribute("user");
			resp.sendRedirect("index?op=getIndex");
		}
	}
	
	
	public int follow(HttpServletRequest req, HttpServletResponse resp) {
		User user = (User) req.getSession().getAttribute("user");
		int uid = Integer.parseInt(req.getParameter("uid"));
		
		return ui.follow(user.getUid(),uid);
	}
	
	public int cencel(HttpServletRequest req, HttpServletResponse resp) {
		User user = (User) req.getSession().getAttribute("user");
		int uid = Integer.parseInt(req.getParameter("uid"));
		
		return ui.cencel(user.getUid(),uid);
	}
	
	
	public void isfollow(HttpServletRequest req, HttpServletResponse resp) {
		User user = (User)req.getSession().getAttribute("user");
		String parameter = req.getParameter("uid");
		int uid = Integer.parseInt(parameter);
		
		Map<String, Object> map = ui.isFollow(user.getUid(),uid);
		String json = JSON.toJSONString(map);
		try {
			resp.getWriter().append(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void beFollow(HttpServletRequest req, HttpServletResponse resp){
		int uid = Integer.parseInt(req.getParameter("uid"));
		String json = JSON.toJSONString(ui.beFollow(uid));
		try {
			resp.getWriter().append(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public void getFollow(HttpServletRequest req, HttpServletResponse resp){
		int fansid = Integer.parseInt(req.getParameter("uid"));
		String json = JSON.toJSONString(ui.getFollow(fansid));
		
		
		try {
			resp.getWriter().append(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void changePerson(HttpServletRequest req, HttpServletResponse resp) {
		User user = (User) req.getSession().getAttribute("user");
		String person = "";
		person = new String(req.getParameter("person"));
		int uid = user.getUid();
		int i = ui.changePerson(uid,person);
		if(i > 0) {
			try {
				req.setAttribute("msg", "修改成功");
				req.getRequestDispatcher("changePerson.jsp").forward(req, resp);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	
}
