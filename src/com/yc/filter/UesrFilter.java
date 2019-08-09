package com.yc.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
@WebFilter(urlPatterns= {"/post.jsp","/reply.jsp"})
public class UesrFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
		HttpServletRequest req = (HttpServletRequest)request;
		if(req.getSession().getAttribute("user") != null) {
			try {
				chain.doFilter(request, response);
			} catch (IOException | ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			String path = req.getServletPath();
			Map<String,String[]> map = new HashMap<>();
			Map<String,String[]> newMap = req.getParameterMap();
			map.putAll(newMap);
			req.getSession().setAttribute("call_backPath", path);
			req.getSession().setAttribute("call_backPram", map);
			req.setAttribute("msg", "请您先登录系统");
			try {
				req.getRequestDispatcher("home.jsp?op=2").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	
}
