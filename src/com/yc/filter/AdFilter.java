package com.yc.filter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import com.yc.dao.TopicDao;

/**
 * Servlet Filter implementation class AdFilter
 */
@WebFilter("/*")
public class AdFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AdFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		TopicDao td=new TopicDao();
		Map<String, Object> ad=td.getAd();
		HttpServletRequest req=(HttpServletRequest)request;
		if(ad!=null){
			req.setAttribute("ad", ad);
		}
		
		chain.doFilter(req, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
