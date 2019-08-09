package com.yc.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

//使用适配器
//抽象类，即不能直接使用，将来写一个Servlet继承自BaseServlet. 
public abstract class BaseServlet extends HttpServlet {

	private static final long serialVersionUID = 3929147019319436036L;
	
	protected String op;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//统一字符编码
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		
		
		//op记录需要调用的方法
		String op = req.getParameter("op");
		//根据op的值调用对应的方法(反射技术)
		Class<?>[] clazz = new Class<?> [] {
			HttpServletRequest.class,HttpServletResponse.class
		};
		//获取对应的method方法
		try {
			Method m = this.getClass().getMethod(op, clazz);
			//通过反射调用方法
			m.invoke(this, req,resp);
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// 
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doGet(req, resp);
	}

	
}
