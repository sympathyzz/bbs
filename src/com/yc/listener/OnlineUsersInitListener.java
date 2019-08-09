package com.yc.listener;

import java.util.ArrayList;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class OnlineUsersInitListener
 *
 */
@WebListener
public class OnlineUsersInitListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public OnlineUsersInitListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  { 
         arg0.getServletContext().setAttribute("onlineUsers", new ArrayList<>());
    }
	
}
