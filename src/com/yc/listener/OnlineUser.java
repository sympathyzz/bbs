package com.yc.listener;

import java.util.List;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.yc.bean.User;



@WebListener
public class OnlineUser implements HttpSessionBindingListener {
	private User user;
	public int isChat = 0;

    public OnlineUser() {

    }

	/**
     * @see HttpSessionBindingListener#valueBound(HttpSessionBindingEvent)
     */
    public void valueBound(HttpSessionBindingEvent arg0)  { 
       List<User> ous= (List<User>) arg0.getSession().getServletContext().getAttribute("onlineUsers");
       ous.add(user);
       System.out.println("用户"+user.getUname()+"上线了。。。");
    }

	/**
     * @see HttpSessionBindingListener#valueUnbound(HttpSessionBindingEvent)
     */
    public void valueUnbound(HttpSessionBindingEvent arg0)  { 
    	 List<User> ous= (List<User>) arg0.getSession().getServletContext().getAttribute("onlineUsers");
         ous.remove(user);
         System.out.println("用户"+user.getUname()+"下线了。。。");
    }
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user=user;
	}
}
